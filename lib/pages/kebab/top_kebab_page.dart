import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kebabbo_flutter/components/buttons&selectors/filter_search.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/components/buttons&selectors/order_bar.dart';
import 'package:kebabbo_flutter/components/list_items/kebab_item.dart';
import 'package:kebabbo_flutter/utils/utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';

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
  final ScrollController _scrollController = ScrollController();
  bool _hasAutoScrolled = false;
  String? _expandedKebabId;
  bool showStaffRatings = true;
  double maxDistance = double.infinity; // nessun limite all'inizio
  bool useDistanceFilter = false; // lo switch nella bottom sheet

  @override
  void initState() {
    super.initState();
    fetchKebab(widget.currentPosition, useStaffRatings: showStaffRatings);
  }

  @override
  void didUpdateWidget(TopKebabPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentPosition != oldWidget.currentPosition &&
        oldWidget.currentPosition == null) {
      fetchKebab(widget.currentPosition, useStaffRatings: showStaffRatings);
    }
  }

  Future<void> fetchKebab(Position? userPosition,
      {required bool useStaffRatings}) async {
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
              kebab['lat'] ?? 0.0,
              kebab['lng'] ?? 0.0,
            );
            kebab['distance'] = distanceInMeters / 1000;
          }
          kebab['isOpen'] = isKebabOpen(kebab['orari_apertura']);
          // 1. Controlla se lat e lng sono validi
          final double lat = kebab['lat'] ?? 0.0;
          final double lng = kebab['lng'] ?? 0.0;

          if (userPosition != null && (lat != 0.0 || lng != 0.0)) {
            // 2. Calcola la distanza SOLO se le coordinate sono valide
            double distanceInMeters = Geolocator.distanceBetween(
              userPosition.latitude,
              userPosition.longitude,
              lat,
              lng,
            );
            kebab['distance'] = distanceInMeters / 1000;
          } else {
            // 3. Altrimenti, imposta la distanza a null
            kebab['distance'] = null;
          }
        }

        if (userPosition != null &&
            useDistanceFilter &&
            !maxDistance.isInfinite) {
          kebabs = kebabs
              .where((kebab) =>
                  (kebab['distance'] ?? double.infinity) <= maxDistance)
              .toList();
        }
        // Filtro staff / utenti
        if (useStaffRatings) {
          kebabs = kebabs.where((kebab) => kebab['is_staff'] == true).toList();
        } else {
          kebabs = kebabs
              .where((kebab) =>
                  kebab['user_reviewed'] == true && kebab['approved'] != false)
              .toList();
        }

        // Sort the kebabs using the utility function
        kebabs = sortKebabs(kebabs, orderByField, orderDirection, userPosition,
            showOnlyOpen, showOnlyKebab);

        Map<String, dynamic>? closestKebab;
        if (userPosition != null && kebabs.isNotEmpty) {
          final tempClosest = kebabs.reduce((curr, next) =>
              (curr['distance'] ?? double.infinity) <
                      (next['distance'] ?? double.infinity)
                  ? curr
                  : next);
          if ((tempClosest['distance'] ?? double.infinity) < 0.2) {
            closestKebab = tempClosest;
          }
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
        if (mounted) {
          setState(() {
            dashList = kebabs;
            searchResultList = fuzzySearchAndSort(
                dashList,
                searchController.text, // Usa il testo già presente nella barra
                'name',
                showOnlyOpen,
                showOnlyKebab);
            isLoading = false;

            setState(() {
              dashList = dashList; // Salva la master list
              searchResultList =
                  searchResultList; // Salva la display list filtrata
              isLoading = false;

              // Se troviamo un kebab vicino, salviamo il suo ID
              if (closestKebab != null && !_hasAutoScrolled) {
                _expandedKebabId = closestKebab['id'].toString();
              }
            });
          });

          // Lo scroll viene attivato qui, dopo che lo stato è stato aggiornato
          if (closestKebab != null && !_hasAutoScrolled) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollToKebab(closestKebab!);
            });
          }
        }
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

  // Sostituisci la vecchia funzione _scrollToAndOpenKebab con questa
  void _scrollToKebab(Map<String, dynamic> kebab) {
    final kebabId = kebab['id'].toString();
    final index =
        searchResultList.indexWhere((k) => k['id'].toString() == kebabId);

    if (index != -1) {
      const double itemHeight = 180.0; // L'altezza dell'elemento CHIUSO
      final topOfItemOffset = index * itemHeight;

      // Aggiungiamo un "margine di sicurezza" in alto per dare spazio all'espansione.
      // Puoi modificare questo valore per trovare quello perfetto per il tuo layout.
      const double topPadding = 430.0;

      // Calcoliamo il nuovo offset e ci assicuriamo che non sia mai minore di zero.
      final targetOffset = (topOfItemOffset - topPadding).clamp(
        0.0,
        _scrollController.position.maxScrollExtent,
      );
      // Anima lo scroll fino al nuovo offset calcolato
      _scrollController.animateTo(
        targetOffset,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );

      setState(() {
        _hasAutoScrolled = true;
      });
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
      debugPrint("Kebab con id $kebabId non trovato in dashList.");
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
      fetchKebab(widget.currentPosition, useStaffRatings: showStaffRatings);
    });
  }

  void changeOrderDirection(bool direction) {
    setState(() {
      orderDirection = direction;
      fetchKebab(widget.currentPosition, useStaffRatings: showStaffRatings);
    });
  }

  void toggleShowOnlyKebab() {
    setState(() {
      showOnlyKebab = !showOnlyKebab;
      fetchKebab(widget.currentPosition, useStaffRatings: showStaffRatings);
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
                            showStaffRatings: showStaffRatings,
                            onToggleShowStaffRatings: () async {
                              // 1. Define the new state
                              final bool newStaffRatingsValue =
                                  !showStaffRatings;

                              // 2. Await the fetch *with the new value*.
                              //    fetchKebab will call its own setState internally to update the list.
                              await fetchKebab(widget.currentPosition,
                                  useStaffRatings: newStaffRatingsValue);

                              // 3. AFTER the await, update the class variable to change the color.
                              setState(() {
                                showStaffRatings = newStaffRatingsValue;
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Row(
                              children: [
                                // La barra di ricerca ora prende molto più spazio
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

                                const SizedBox(width: 12),

                                // Nuovo bottone filtro (sostituisce il toggle "Aperti ora")
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.filter_list,
                                        color: Colors.black, size: 28),
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20)),
                                        ),
                                        builder: (context) => FilterSearch(
                                          showOnlyOpen: showOnlyOpen,
                                          onToggleShowOnlyOpen: (value) {
                                            setState(() {
                                              showOnlyOpen = value;
                                              fetchKebab(widget.currentPosition,
                                                  useStaffRatings:
                                                      showStaffRatings);
                                            });
                                          },
                                          showOnlyKebab: showOnlyKebab,
                                          onToggleShowOnlyKebab: () {
                                            setState(() {
                                              showOnlyKebab = !showOnlyKebab;
                                              fetchKebab(widget.currentPosition,
                                                  useStaffRatings:
                                                      showStaffRatings);
                                            });
                                          },
                                          orderByField: orderByField,
                                          orderDirection: orderDirection,
                                          onChangeOrderByField: (value) {
                                            setState(() {
                                              orderByField = value;
                                              fetchKebab(widget.currentPosition,
                                                  useStaffRatings:
                                                      showStaffRatings);
                                            });
                                          },
                                          onChangeOrderByDirection: (value) {
                                            setState(() {
                                              orderDirection = value;
                                              fetchKebab(widget.currentPosition,
                                                  useStaffRatings:
                                                      showStaffRatings);
                                            });
                                          },
                                          useDistanceFilter: useDistanceFilter,
                                          maxDistanceKm: maxDistance.isInfinite
                                              ? 50
                                              : maxDistance,
                                          onToggleUseDistanceFilter: (enabled) {
                                            setState(() {
                                              useDistanceFilter = enabled;
                                              // se lo spegne => infinito
                                              maxDistance = enabled
                                                  ? maxDistance
                                                  : double.infinity;
                                              fetchKebab(widget.currentPosition,
                                                  useStaffRatings:
                                                      showStaffRatings);
                                            });
                                          },
                                          onChangeMaxDistanceKm: (km) {
                                            setState(() {
                                              maxDistance = km;
                                              useDistanceFilter = true;
                                              fetchKebab(widget.currentPosition,
                                                  useStaffRatings:
                                                      showStaffRatings);
                                            });
                                          },
                                        ),
                                      );
                                    },
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
                                    controller:
                                        _scrollController, // Il controller rimane
                                    itemCount: searchResultList.length,
                                    itemBuilder: (context, index) {
                                      final kebab = searchResultList[index];
                                      final kebabId = kebab['id']
                                          .toString(); // Ottieni l'ID
                                      return KebabListItem(
                                        key: ValueKey(
                                            "${kebab['id']}_${showStaffRatings.toString()}"),
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
                                        initiallyExpanded:
                                            kebabId == _expandedKebabId,
                                        hasUserReview:
                                            kebab['user_reviewed'] ?? false,
                                        flipped: !showStaffRatings,
                                        approved: kebab['approved'],
                                      );
                                    },
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
    );
  }
}
