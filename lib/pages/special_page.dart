import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/components/kebab_item.dart';
import 'package:kebabbo_flutter/utils/utils.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';


class SpecialPage extends StatefulWidget {
  final Position? currentPosition;

  const SpecialPage({super.key, required this.currentPosition});

  @override
  SpecialPageState createState() => SpecialPageState();
}

class SpecialPageState extends State<SpecialPage> {
  List<Map<String, dynamic>> dashList = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchKebab('kebab_world', widget.currentPosition!);
  }

  Future<void> fetchKebab(String tableName, Position userPosition) async {
    try {
      final response = await supabase
          .from(tableName)
          .select('*')
          .order("rating", ascending: false);

      if (mounted) {
        List<Map<String, dynamic>> kebabs =
            List<Map<String, dynamic>>.from(response as List);

        // Calcola la distanza per ogni kebab
        for (var kebab in kebabs) {
          double distanceInMeters = Geolocator.distanceBetween(
            userPosition.latitude,
            userPosition.longitude,
            kebab['lat'],
            kebab['lng'],
          );
          kebab['distance'] = distanceInMeters / 1000;
          kebab['isOpen'] = isKebabOpen(kebab['orari_apertura']);
        }


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
    if (user == null) return;

    final kebabIndex = dashList.indexWhere((kebab) => kebab['id'] == kebabId);
    if (kebabIndex != -1) {
      final isCurrentlyFavorite = dashList[kebabIndex]['isFavorite'];
      final updatedFavorites = List<String>.from(
          dashList.where((kebab) => kebab['isFavorite']).map((k) => k['id'].toString()));

      if (isCurrentlyFavorite) {
        updatedFavorites.remove(kebabId);
      } else {
        updatedFavorites.add(kebabId);
      }

      await supabase
          .from('profiles')
          .update({'favorites': updatedFavorites})
          .eq('id', user.id);

      setState(() {
        dashList[kebabIndex]['isFavorite'] = !isCurrentlyFavorite;
      });
    }
  }


  void onTabChange(String tableName) {
    setState(() {
      isLoading = true;
      errorMessage = null;
      dashList = [];
    });
    fetchKebab(tableName, widget.currentPosition!);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      animationDuration: const Duration(milliseconds: 600),
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            dividerColor: Colors.transparent,
            onTap: (index) {
              if (index == 0) {
                onTabChange('kebab_world');
              } else {
                onTabChange('kebab_legend');
              }
            },
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: red,
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            labelStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 16,
            ),
            tabs: [
              Tab(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal:
                          16), // Aggiungi padding intorno al contenuto della scheda
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.public,
                        size: 24,
                      ),
                      SizedBox(width: 8),
                      Text(S.of(context).world),
                    ],
                  ),
                ),
              ),
              Tab(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child:  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.brightness_high_sharp,
                        size: 24,
                      ),
                      SizedBox(width: 8),
                      Text(S.of(context).legends),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage != null
                ? Center(child: Text(S.of(context).errore +errorMessage.toString()))
                : dashList.isEmpty
                    ?  Center(child: Text(S.of(context).nessun_kebabbaro_presente))
                    : SafeArea(
                        minimum: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 12,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 16.0),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: dashList.length,
                                itemBuilder: (context, index) {
                                  final kebab = dashList[index];
                                  return KebabListItem(
                                    id: kebab['id'].toString(),
                                    name: kebab['name'] ?? '',
                                    description: kebab['description'] ?? '',
                                    rating: (kebab['rating'] ?? 0.0).toDouble(),
                                    quality:
                                        (kebab['quality'] ?? 0.0).toDouble(),
                                    price: (kebab['price'] ?? 0.0).toDouble(),
                                    dimension:
                                        (kebab['dimension'] ?? 0.0).toDouble(),
                                    menu: (kebab['menu'] ?? 0.0).toDouble(),
                                    fun: (kebab['fun'] ?? 0.0).toDouble(),
                                    map: kebab['map'] ?? '',
                                    lat: (kebab['lat'] ?? 0.0).toDouble(),
                                    lng: (kebab['lng'] ?? 0.0).toDouble(),
                                    distance:
                                        kebab['distance']?.toDouble(),
                                    vegetables: (kebab['vegetables'] ?? 0.0).toDouble(),
                                    yogurt: (kebab['yogurt'] ?? 0.0).toDouble(),
                                    spicy: (kebab['spicy'] ?? 0.0).toDouble(),
                                    onion: (kebab['onion'] ?? 0.0).toDouble(),
                                    tag: (kebab['tag'] ?? ''),
                                    isOpen: kebab['isOpen'] ?? false,
                                    isFavorite: kebab['isFavorite'] ?? false,
                                    onFavoriteToggle: () => toggleFavorite(kebab['id'].toString()),
                                    special: true,
                                    glutenFree: kebab['gluten_free'] ?? false,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
      ),
    );
  }
}
