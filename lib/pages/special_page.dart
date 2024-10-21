import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/components/kebab_item.dart';

const Color red = Color.fromRGBO(187, 0, 0, 1.0);

class SpecialPage extends StatefulWidget {
  Position? currentPosition;

  SpecialPage({super.key, required this.currentPosition});

  @override
  _SpecialPageState createState() => _SpecialPageState();
}

class _SpecialPageState extends State<SpecialPage> {
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
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.public,
                        size: 24,
                      ),
                      SizedBox(width: 8),
                      Text('World'),
                    ],
                  ),
                ),
              ),
              Tab(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.brightness_high_sharp,
                        size: 24,
                      ),
                      SizedBox(width: 8),
                      Text('Legends'),
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
                ? Center(child: Text('Errore: $errorMessage'))
                : dashList.isEmpty
                    ? const Center(child: Text('Nessun Kebabbaro presente :('))
                    : SafeArea(
                        minimum: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 32,
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
                                        (kebab['distance'] ?? 0.0).toDouble(),
                                    meat: (kebab['meat'] ?? 0.0).toDouble(),
                                    yogurt: (kebab['yogurt'] ?? 0.0).toDouble(),
                                    spicy: (kebab['spicy'] ?? 0.0).toDouble(),
                                    onion: (kebab['onion'] ?? 0.0).toDouble(),
                                    tag: (kebab['tag'] ?? ''),
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
