import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/components/order_bar.dart';
import 'package:kebabbo_flutter/components/kebab_item.dart';
import 'package:kebabbo_flutter/pages/special_page.dart';
import 'package:postgrest/src/types.dart';
import 'package:kebabbo_flutter/utils/utils.dart';

const Color red = Color.fromRGBO(187, 0, 0, 1.0);

class TopKebabPage extends StatefulWidget {
  final Position currentPosition;

  const TopKebabPage({super.key, required this.currentPosition});

  @override
  _TopKebabPageState createState() => _TopKebabPageState();
}

class _TopKebabPageState extends State<TopKebabPage> {
  List<Map<String, dynamic>> dashList = [];
  List<Map<String, dynamic>> searchResultList = [];
  bool isLoading = true;
  String? errorMessage;
  String orderByField = 'rating';
  bool orderDirection = true;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchKebab(widget.currentPosition);
  }

  Future<void> fetchKebab(Position userPosition) async {
    try {
      final PostgrestList response = await supabase
          .from('kebab')
          .select('*');

      if (mounted) {
        List<Map<String, dynamic>> kebabs =
            List<Map<String, dynamic>>.from(response as List);

        for (var kebab in kebabs) {
          double distanceInMeters = Geolocator.distanceBetween(
            userPosition.latitude,
            userPosition.longitude,
            kebab['lat'],
            kebab['lng'],
          );
          kebab['distance'] = distanceInMeters / 1000;
        }

        // Sort the kebabs using the utility function
        kebabs = sortKebabs(kebabs, orderByField, orderDirection, userPosition);

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

  void searchKebab(String query) {
    setState(() {
      searchResultList = fuzzySearchAndSort(dashList, query, 'name');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              ),
                              const SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: TextField(
                                  controller: searchController,
                                  onChanged: searchKebab,
                                  decoration: InputDecoration(
                                    hintText: "Cerca un kebabbaro...",
                                    hintStyle: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0.0,
                                      horizontal: 20.0,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    prefixIcon: const Icon(Icons.search),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: searchResultList.length,
                                  itemBuilder: (context, index) {
                                    final kebab = searchResultList[index];
                                    return KebabListItem(
                                      name: kebab['name'] ?? '',
                                      description: kebab['description'] ?? '',
                                      rating:
                                          (kebab['rating'] ?? 0.0).toDouble(),
                                      quality:
                                          (kebab['quality'] ?? 0.0).toDouble(),
                                      price: (kebab['price'] ?? 0.0).toDouble(),
                                      dimension: (kebab['dimension'] ?? 0.0)
                                          .toDouble(),
                                      menu: (kebab['menu'] ?? 0.0).toDouble(),
                                      fun: (kebab['fun'] ?? 0.0).toDouble(),
                                      map: kebab['map'] ?? '',
                                      lat: (kebab['lat'] ?? 0.0).toDouble(),
                                      lng: (kebab['lng'] ?? 0.0).toDouble(),
                                      distance:
                                          (kebab['distance'] ?? 0.0).toDouble(),
                                      meat: (kebab['meat'] ?? 0.0).toDouble(),
                                      yogurt:
                                          (kebab['yogurt'] ?? 0.0).toDouble(),
                                      spicy: (kebab['spicy'] ?? 0.0).toDouble(),
                                      onion: (kebab['onion'] ?? 0.0).toDouble(),
                                      tag: (kebab['tag'] ?? ''),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 16),
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
                              child:
                                  const Icon(Icons.public, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
    );
  }
}
