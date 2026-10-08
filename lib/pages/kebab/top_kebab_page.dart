import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kebabbo_flutter/components/buttons&selectors/filter_search.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/components/buttons&selectors/order_bar.dart';
import 'package:kebabbo_flutter/components/list_items/kebab_item.dart';
import 'package:kebabbo_flutter/utils/utils.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';

class TopKebabPage extends StatefulWidget {
  final Position? currentPosition;

  const TopKebabPage({super.key, required this.currentPosition});

  @override
  TopKebabPageState createState() => TopKebabPageState();
}

class TopKebabPageState extends State<TopKebabPage> {
  List<Map<String, dynamic>> _allKebabs = [];
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
  // Di default mostriamo solo i kebabbari entro 50 km (dalla posizione
  // dell'utente, o da Bologna se non disponibile): altrimenti un locale
  // all'estero può finire primo in classifica.
  static const double defaultMaxDistanceKm = 50;
  static const double _bolognaLat = 44.4949;
  static const double _bolognaLng = 11.3426;
  double maxDistance = defaultMaxDistanceKm;
  bool useDistanceFilter = true; // lo switch nella bottom sheet

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
      final user = supabase.auth.currentUser;
      final Future<dynamic> kebabsFuture = supabase.from('kebab').select('*');
      final Future<dynamic> reviewsFuture = supabase.from('reviews').select(
          'kebabber_id, quality, quantity, menu, price, fun, vegetables, yogurt, spicy, onion');
      // I preferiti non devono mai bloccare la lista (es. sessione scaduta).
      final Future<dynamic> favoritesFuture = user != null
          ? supabase
              .from('profiles')
              .select('favorites')
              .eq('id', user.id)
              .maybeSingle()
              .then<dynamic>((v) => v, onError: (e) {
              debugPrint('Preferiti non disponibili: $e');
              return null;
            })
          : Future<dynamic>.value(null);

      final results = await Future.wait<dynamic>([
        kebabsFuture,
        reviewsFuture,
        favoritesFuture,
      ]);
      final response = results[0] as List;
      final reviewsList = results[1] as List;
      final userProfile = results[2] as Map<String, dynamic>?;

      if (!mounted) return;

      List<Map<String, dynamic>> kebabs =
          List<Map<String, dynamic>>.from(response);

      final List<String> favoriteIds = userProfile != null
          ? List<String>.from(userProfile['favorites'] ?? [])
          : [];

      // Raggruppa le recensioni utenti per kebabber_id
      final Map<String, List<Map<String, dynamic>>> reviewsByKebabId = {};
      for (var r in reviewsList) {
        final kid = r['kebabber_id']?.toString();
        if (kid != null) {
          reviewsByKebabId
              .putIfAbsent(kid, () => [])
              .add(Map<String, dynamic>.from(r));
        }
      }

      for (var kebab in kebabs) {
        // Distanza usata solo per il filtro: dall'utente o, in mancanza, da Bologna.
        final num? kLat = kebab['lat'] as num?;
        final num? kLng = kebab['lng'] as num?;
        if (kLat != null && kLng != null && (kLat != 0 || kLng != 0)) {
          kebab['filter_distance'] = Geolocator.distanceBetween(
                userPosition?.latitude ?? _bolognaLat,
                userPosition?.longitude ?? _bolognaLng,
                kLat.toDouble(),
                kLng.toDouble(),
              ) /
              1000;
        } else {
          kebab['filter_distance'] =
              null; // posizione ignota: non lo escludiamo
        }

        if (userPosition != null) {
          final double lat =
              (kebab['lat'] is num) ? (kebab['lat'] as num).toDouble() : 0.0;
          final double lng =
              (kebab['lng'] is num) ? (kebab['lng'] as num).toDouble() : 0.0;

          if (lat != 0.0 || lng != 0.0) {
            double distanceInMeters = Geolocator.distanceBetween(
              userPosition.latitude,
              userPosition.longitude,
              lat,
              lng,
            );
            kebab['distance'] = distanceInMeters / 1000;
          } else {
            kebab['distance'] = null;
          }
        } else {
          kebab['distance'] = null;
        }

        // Controllo Orari
        kebab['isOpen'] = isKebabOpen(kebab['orari_apertura']);

        kebab['staff_rating'] = (kebab['rating'] as num?)?.toDouble() ?? 0.0;
        kebab['staff_quality'] = (kebab['quality'] as num?)?.toDouble() ?? 0.0;
        kebab['staff_price'] = (kebab['price'] as num?)?.toDouble() ?? 0.0;
        kebab['staff_dimension'] =
            (kebab['dimension'] as num?)?.toDouble() ?? 0.0;
        kebab['staff_menu'] = (kebab['menu'] as num?)?.toDouble() ?? 0.0;
        kebab['staff_fun'] = (kebab['fun'] as num?)?.toDouble() ?? 0.0;
        kebab['staff_vegetables'] =
            (kebab['vegetables'] as num?)?.toDouble() ?? 0.0;
        kebab['staff_onion'] = (kebab['onion'] as num?)?.toDouble() ?? 0.0;
        kebab['staff_spicy'] = (kebab['spicy'] as num?)?.toDouble() ?? 0.0;
        kebab['staff_meat'] = (kebab['meat'] as num?)?.toDouble() ?? 0.0;
        kebab['name'] = kebab['name'] ?? '';

        if (kebab['distance'] == null) {
          kebab['distance_sortable'] = double.maxFinite;
        } else {
          kebab['distance_sortable'] = kebab['distance'];
        }

        // Calcola medie delle recensioni utenti
        final kid = kebab['id'].toString();
        final userReviews = reviewsByKebabId[kid];

        if (userReviews != null && userReviews.isNotEmpty) {
          double totalQuality = 0;
          double totalQuantity = 0;
          double totalMenu = 0;
          double totalPrice = 0;
          double totalFun = 0;
          double totalVegetables = 0;
          double totalYogurt = 0;
          double totalSpicy = 0;
          double totalOnion = 0;

          for (var review in userReviews) {
            totalQuality += (review['quality'] as num?)?.toDouble() ?? 0.0;
            totalQuantity += (review['quantity'] as num?)?.toDouble() ?? 0.0;
            totalMenu += (review['menu'] as num?)?.toDouble() ?? 0.0;
            totalPrice += (review['price'] as num?)?.toDouble() ?? 0.0;
            totalFun += (review['fun'] as num?)?.toDouble() ?? 0.0;
            totalVegetables +=
                (review['vegetables'] as num?)?.toDouble() ?? 0.0;
            totalYogurt += (review['yogurt'] as num?)?.toDouble() ?? 0.0;
            totalSpicy += (review['spicy'] as num?)?.toDouble() ?? 0.0;
            totalOnion += (review['onion'] as num?)?.toDouble() ?? 0.0;
          }

          int count = userReviews.length;
          double avgQuality = totalQuality / count;
          double avgQuantity = totalQuantity / count;
          double avgMenu = totalMenu / count;
          double avgPrice = totalPrice / count;
          double avgFun = totalFun / count;
          double overallAvg =
              (avgQuality + avgQuantity + avgMenu + avgPrice) / 4;

          kebab['user_rating'] = overallAvg;
          kebab['user_quality'] = avgQuality;
          kebab['user_dimension'] = avgQuantity;
          kebab['user_menu'] = avgMenu;
          kebab['user_price'] = avgPrice;
          kebab['user_fun'] = avgFun;
          kebab['user_vegetables'] = totalVegetables / count;
          kebab['user_yogurt'] = totalYogurt / count;
          kebab['user_spicy'] = totalSpicy / count;
          kebab['user_onion'] = totalOnion / count;
          kebab['user_reviews_count'] = count;
        } else {
          kebab['user_rating'] = kebab['staff_rating'] ?? 0.0;
          kebab['user_quality'] = kebab['staff_quality'] ?? 0.0;
          kebab['user_dimension'] = kebab['staff_dimension'] ?? 0.0;
          kebab['user_menu'] = kebab['staff_menu'] ?? 0.0;
          kebab['user_price'] = kebab['staff_price'] ?? 0.0;
          kebab['user_fun'] = kebab['staff_fun'] ?? 0.0;
          kebab['user_vegetables'] = kebab['staff_vegetables'] ?? 0.0;
          kebab['user_yogurt'] = (kebab['yogurt'] as num?)?.toDouble() ?? 0.0;
          kebab['user_spicy'] = kebab['staff_spicy'] ?? 0.0;
          kebab['user_onion'] = kebab['staff_onion'] ?? 0.0;
          kebab['user_reviews_count'] = 0;
        }

        kebab['isFavorite'] = favoriteIds.contains(kebab['id'].toString());
      }

      _allKebabs = kebabs;
      _applyFilterAndSort(useStaffRatings: useStaffRatings);
    } catch (error) {
      if (mounted) {
        setState(() {
          errorMessage = error.toString();
          isLoading = false;
        });
      }
    }
  }

  void _applyFilterAndSort({required bool useStaffRatings}) {
    List<Map<String, dynamic>> kebabs =
        _allKebabs.map((k) => Map<String, dynamic>.from(k)).toList();

    for (var kebab in kebabs) {
      if (useStaffRatings) {
        kebab['rating'] = kebab['staff_rating'] ?? 0.0;
        kebab['quality'] = kebab['staff_quality'] ?? 0.0;
        kebab['dimension'] = kebab['staff_dimension'] ?? 0.0;
        kebab['menu'] = kebab['staff_menu'] ?? 0.0;
        kebab['price'] = kebab['staff_price'] ?? 0.0;
        kebab['fun'] = kebab['staff_fun'] ?? 0.0;
      } else {
        kebab['rating'] = kebab['user_rating'] ?? 0.0;
        kebab['quality'] = kebab['user_quality'] ?? 0.0;
        kebab['dimension'] = kebab['user_dimension'] ?? 0.0;
        kebab['menu'] = kebab['user_menu'] ?? 0.0;
        kebab['price'] = kebab['user_price'] ?? 0.0;
        kebab['fun'] = kebab['user_fun'] ?? 0.0;
      }
    }

    if (useDistanceFilter && !maxDistance.isInfinite) {
      kebabs = kebabs.where((kebab) {
        final d = kebab['filter_distance'] as double?;
        return d == null || d <= maxDistance;
      }).toList();
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

    kebabs = sortKebabs(kebabs, orderByField, orderDirection,
        widget.currentPosition, showOnlyOpen, showOnlyKebab);

    Map<String, dynamic>? closestKebab;
    if (widget.currentPosition != null && kebabs.isNotEmpty) {
      final tempClosest = kebabs.reduce((curr, next) =>
          (curr['distance'] ?? double.infinity) <
                  (next['distance'] ?? double.infinity)
              ? curr
              : next);
      if ((tempClosest['distance'] ?? double.infinity) < 0.2) {
        closestKebab = tempClosest;
      }
    }

    if (mounted) {
      setState(() {
        dashList = kebabs;
        searchResultList = fuzzySearchAndSort(dashList, searchController.text,
            'name', showOnlyOpen, showOnlyKebab);
        isLoading = false;

        // Se troviamo un kebab vicino, salviamo il suo ID
        if (closestKebab != null && !_hasAutoScrolled) {
          _expandedKebabId = closestKebab['id'].toString();
        }
      });

      // Lo scroll viene attivato qui, dopo che lo stato è stato aggiornato
      if (closestKebab != null && !_hasAutoScrolled) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToKebab(closestKebab!);
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
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    final kebabIndex = dashList
        .indexWhere((kebab) => kebab['id'].toString() == kebabId.toString());
    if (kebabIndex != -1) {
      final isCurrentlyFavorite = dashList[kebabIndex]['isFavorite'] == true;
      try {
        final userResponse = await supabase
            .from('profiles')
            .select('favorites')
            .eq('id', user.id)
            .single();

        final updatedFavorites =
            List<String>.from(userResponse['favorites'] ?? []);

        if (isCurrentlyFavorite) {
          updatedFavorites.remove(kebabId);
        } else {
          if (!updatedFavorites.contains(kebabId)) {
            updatedFavorites.add(kebabId);
          }
        }

        // Effettua aggiornamento su Supabase
        await supabase
            .from('profiles')
            .update({'favorites': updatedFavorites}).eq('id', user.id);
      } catch (e) {
        debugPrint('Errore aggiornamento preferiti: $e');
        return;
      }
      if (!mounted) return;

      // Aggiorna lo stato in dashList e in _allKebabs
      setState(() {
        dashList[kebabIndex]['isFavorite'] = !isCurrentlyFavorite;
        final allIndex = _allKebabs
            .indexWhere((k) => k['id'].toString() == kebabId.toString());
        if (allIndex != -1) {
          _allKebabs[allIndex]['isFavorite'] = !isCurrentlyFavorite;
        }
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
      _applyFilterAndSort(useStaffRatings: showStaffRatings);
    });
  }

  void changeOrderDirection(bool direction) {
    setState(() {
      orderDirection = direction;
      _applyFilterAndSort(useStaffRatings: showStaffRatings);
    });
  }

  void toggleShowOnlyKebab() {
    setState(() {
      showOnlyKebab = !showOnlyKebab;
      _applyFilterAndSort(useStaffRatings: showStaffRatings);
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
                            onToggleShowStaffRatings: () {
                              final bool newStaffRatingsValue =
                                  !showStaffRatings;
                              setState(() {
                                showStaffRatings = newStaffRatingsValue;
                                _applyFilterAndSort(
                                    useStaffRatings: newStaffRatingsValue);
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
                                  decoration: const BoxDecoration(
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
                                              _applyFilterAndSort(
                                                  useStaffRatings:
                                                      showStaffRatings);
                                            });
                                          },
                                          showOnlyKebab: showOnlyKebab,
                                          onToggleShowOnlyKebab: () {
                                            setState(() {
                                              showOnlyKebab = !showOnlyKebab;
                                              _applyFilterAndSort(
                                                  useStaffRatings:
                                                      showStaffRatings);
                                            });
                                          },
                                          orderByField: orderByField,
                                          orderDirection: orderDirection,
                                          onChangeOrderByField: (value) {
                                            setState(() {
                                              orderByField = value;
                                              _applyFilterAndSort(
                                                  useStaffRatings:
                                                      showStaffRatings);
                                            });
                                          },
                                          onChangeOrderByDirection: (value) {
                                            setState(() {
                                              orderDirection = value;
                                              _applyFilterAndSort(
                                                  useStaffRatings:
                                                      showStaffRatings);
                                            });
                                          },
                                          useDistanceFilter: useDistanceFilter,
                                          maxDistanceKm: maxDistance.isInfinite
                                              ? defaultMaxDistanceKm
                                              : maxDistance,
                                          onToggleUseDistanceFilter: (enabled) {
                                            setState(() {
                                              useDistanceFilter = enabled;
                                              _applyFilterAndSort(
                                                  useStaffRatings:
                                                      showStaffRatings);
                                            });
                                          },
                                          onChangeMaxDistanceKm: (km) {
                                            setState(() {
                                              maxDistance = km;
                                              useDistanceFilter = true;
                                              _applyFilterAndSort(
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
                                  child:
                                      useDistanceFilter && _allKebabs.isNotEmpty
                                          ? Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(S
                                                    .of(context)
                                                    .no_kebab_within_distance(
                                                        maxDistance
                                                            .round()
                                                            .toString())),
                                                TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      useDistanceFilter = false;
                                                      _applyFilterAndSort(
                                                          useStaffRatings:
                                                              showStaffRatings);
                                                    });
                                                  },
                                                  child: Text(S
                                                      .of(context)
                                                      .show_all_distances),
                                                ),
                                              ],
                                            )
                                          : Text(S
                                              .of(context)
                                              .nessun_kebabbaro_presente))
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
                                        userRating:
                                            (kebab['user_rating'] as num?)
                                                ?.toDouble(),
                                        userQuality:
                                            (kebab['user_quality'] as num?)
                                                ?.toDouble(),
                                        userQuantity:
                                            (kebab['user_dimension'] as num?)
                                                ?.toDouble(),
                                        userMenu: (kebab['user_menu'] as num?)
                                            ?.toDouble(),
                                        userPrice: (kebab['user_price'] as num?)
                                            ?.toDouble(),
                                        userFun: (kebab['user_fun'] as num?)
                                            ?.toDouble(),
                                        userVegetables:
                                            (kebab['user_vegetables'] as num?)
                                                ?.toDouble(),
                                        userYogurt:
                                            (kebab['user_yogurt'] as num?)
                                                ?.toDouble(),
                                        userSpicy: (kebab['user_spicy'] as num?)
                                            ?.toDouble(),
                                        userOnion: (kebab['user_onion'] as num?)
                                            ?.toDouble(),
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
