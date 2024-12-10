import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/components/buttons&selectors/order_bar.dart';
import 'package:kebabbo_flutter/components/list_items/kebab_item.dart';
import 'package:kebabbo_flutter/pages/kebab/special_page.dart';
import 'package:kebabbo_flutter/utils/utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class TopKebabPage extends StatefulWidget {
  final Position? currentPosition;

  const TopKebabPage({super.key, required this.currentPosition});

  @override
  TopKebabPageState createState() => TopKebabPageState();
}

class TopKebabPageState extends State<TopKebabPage> {
  List<Map<String, dynamic>> dashList = [];
  List<Map<String, dynamic>> searchResultList = [];
  bool isLoading = true;
  String? errorMessage;
  String orderByField = 'stelle';
  bool orderDirection = true;
  bool showOnlyOpen = false;
  bool showOnlyKebab = true;
  TextEditingController searchController = TextEditingController();
  final String privacyPolicyUrl = "https://kebabbo-privacy-policy.vercel.app/";

  @override
  void initState() {
    super.initState();
    fetchKebab(widget.currentPosition);
  }

  @override
  void didUpdateWidget(TopKebabPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentPosition != oldWidget.currentPosition &&
        oldWidget.currentPosition == null) {
      fetchKebab(widget.currentPosition);
    }
  }

  Future<void> fetchKebab(Position? userPosition) async {
    try {
      final PostgrestList response = await supabase.from('kebab').select('*');

      if (mounted) {
        List<Map<String, dynamic>> kebabs =
            List<Map<String, dynamic>>.from(response as List);

        for (var kebab in kebabs) {
          if (userPosition != null) {
            double distanceInMeters = Geolocator.distanceBetween(
              userPosition.latitude,
              userPosition.longitude,
              kebab['lat'],
              kebab['lng'],
            );
            kebab['distance'] = distanceInMeters / 1000;
          }
          kebab['isOpen'] = isKebabOpen(kebab['orari_apertura']);
        }

        // Sort the kebabs using the utility function
        kebabs = sortKebabs(kebabs, orderByField, orderDirection, userPosition,
            showOnlyOpen, showOnlyKebab);

        // Aggiungi lo stato di "preferito" per ciascun kebab
        final user = supabase.auth.currentUser;
        if (user != null) {
          final userResponse = await supabase
              .from('profiles')
              .select('favorites')
              .eq('id', user.id)
              .single();

          final List<String> favoriteIds =
              List<String>.from(userResponse['favorites'] ?? []);
          for (var kebab in kebabs) {
            kebab['isFavorite'] = favoriteIds.contains(kebab['id'].toString());
          }
        }

        setState(() {
          dashList = kebabs;
          searchResultList = kebabs;
          isLoading = false;
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          errorMessage = error.toString();
          isLoading = false;
        });
      }
    }
  }

  Future<void> toggleFavorite(String kebabId) async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).preferiti_solo_per_utenti_registrati),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final kebabIndex = dashList
        .indexWhere((kebab) => kebab['id'].toString() == kebabId.toString());
    if (kebabIndex != -1) {
      final isCurrentlyFavorite = dashList[kebabIndex]['isFavorite'];
      final updatedFavorites = List<String>.from(
        dashList
            .where((kebab) => kebab['isFavorite'])
            .map((k) => k['id'].toString()),
      );

      if (isCurrentlyFavorite) {
        updatedFavorites.remove(kebabId);
      } else {
        updatedFavorites.add(kebabId);
      }

      // Effettua aggiornamento su Supabase
      await supabase
          .from('profiles')
          .update({'favorites': updatedFavorites}).eq('id', user.id);

      // Aggiorna lo stato in dashList
      setState(() {
        dashList[kebabIndex]['isFavorite'] = !isCurrentlyFavorite;
      });

      // Log del nuovo stato
    } else {
      print("Kebab con id $kebabId non trovato in dashList.");
    }
  }

  void searchKebab(String query) {
    setState(() {
      searchResultList = fuzzySearchAndSort(
          dashList, query, 'name', showOnlyOpen, showOnlyKebab);
    });
  }

  void changeOrderByField(String field) {
    setState(() {
      orderByField = field;
      fetchKebab(widget.currentPosition);
    });
  }

  void changeOrderDirection(bool direction) {
    setState(() {
      orderDirection = direction;
      fetchKebab(widget.currentPosition);
    });
  }

  void toggleShowOnlyKebab() {
    setState(() {
      showOnlyKebab = !showOnlyKebab;
      fetchKebab(widget.currentPosition);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(
                  child: Text(S.of(context).errore + errorMessage.toString()))
              : SafeArea(
                  minimum: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 12,
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          OrderBar(
                              orderByField: orderByField,
                              orderDirection: orderDirection,
                              onChangeOrderByField: changeOrderByField,
                              onChangeOrderDirection: changeOrderDirection,
                              showOnlyKebab: showOnlyKebab,
                              changeShowOnlyKebab: toggleShowOnlyKebab),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Row(
                              children: [
                                // Make the TextField take up the maximum available space
                                Expanded(
                                  child: TextField(
                                    controller: searchController,
                                    onChanged: searchKebab,
                                    decoration: InputDecoration(
                                      hintText:
                                          S.of(context).cerca_un_kebabbaro,
                                      hintStyle: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 0.0,
                                        horizontal: 20.0,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      prefixIcon: const Icon(Icons.search),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                    width:
                                        8), // Spacing between TextField and button

                                // Set the button to a constrained width and height for consistent sizing
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 150, // Set a max width
                                    minWidth:
                                        80, // Optional: set a minimum width
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showOnlyOpen = !showOnlyOpen;
                                        fetchKebab(widget.currentPosition);
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15,
                                          horizontal: 16), // Inner padding
                                      decoration: BoxDecoration(
                                        color:
                                            showOnlyOpen ? red : Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            showOnlyOpen
                                                ? Icons.check
                                                : Icons.close,
                                            color: showOnlyOpen
                                                ? Colors.white
                                                : Colors.black,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            S.of(context).aperti_ora,
                                            style: TextStyle(
                                              color: showOnlyOpen
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          dashList.isEmpty
                              ? Center(
                                  child: Text(
                                      S.of(context).nessun_kebabbaro_presente))
                              : Expanded(
                                  child: ListView.builder(
                                    itemCount: searchResultList.length,
                                    itemBuilder: (context, index) {
                                      final kebab = searchResultList[index];
                                      return KebabListItem(
                                        id: kebab['id'].toString(),
                                        name: kebab['name'] ?? '',
                                        description: kebab['description'] ?? '',
                                        rating:
                                            (kebab['rating'] ?? 0.0).toDouble(),
                                        quality: (kebab['quality'] ?? 0.0)
                                            .toDouble(),
                                        price:
                                            (kebab['price'] ?? 0.0).toDouble(),
                                        dimension: (kebab['dimension'] ?? 0.0)
                                            .toDouble(),
                                        menu: (kebab['menu'] ?? 0.0).toDouble(),
                                        fun: (kebab['fun'] ?? 0.0).toDouble(),
                                        map: kebab['map'] ?? '',
                                        lat: (kebab['lat'] ?? 0.0).toDouble(),
                                        lng: (kebab['lng'] ?? 0.0).toDouble(),
                                        distance: kebab['distance']?.toDouble(),
                                        vegetables: (kebab['vegetables'] ?? 0.0)
                                            .toDouble(),
                                        yogurt:
                                            (kebab['yogurt'] ?? 0.0).toDouble(),
                                        spicy:
                                            (kebab['spicy'] ?? 0.0).toDouble(),
                                        onion:
                                            (kebab['onion'] ?? 0.0).toDouble(),
                                        tag: (kebab['tag'] ?? ''),
                                        isOpen: kebab['isOpen'] ?? false,
                                        isFavorite:
                                            kebab['isFavorite'] ?? false,
                                        onFavoriteToggle: () => toggleFavorite(
                                            kebab['id'].toString()),
                                        special: false,
                                        glutenFree:
                                            kebab['gluten_free'] ?? false,
                                      );
                                    },
                                  ),
                                ),
                          GestureDetector(
                            onTap: () async {
                              final url = Uri.parse(privacyPolicyUrl);
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url,
                                    mode: LaunchMode.externalApplication);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Impossibile aprire il link.'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Center(
                                child: Text(
                                  "Privacy Policy",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontStyle: FontStyle.italic,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Icona circolare "kebab special" in basso a sinistra
                      Positioned(
                        bottom: 20.0,
                        right: 8.0,
                        child: FloatingActionButton(
                          backgroundColor: red,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SpecialPage(
                                  currentPosition: widget.currentPosition,
                                ),
                              ),
                            );
                          },
                          child: const Icon(Icons.public, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
