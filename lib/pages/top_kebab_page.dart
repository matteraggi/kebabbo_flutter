import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/components/order_bar.dart';
import 'package:kebabbo_flutter/components/kebab_item.dart';
import 'package:postgrest/src/types.dart';

class TopKebabPage extends StatefulWidget {
  final Position currentPosition;

  TopKebabPage({required this.currentPosition});

  @override
  _TopKebabPageState createState() => _TopKebabPageState();
}

class _TopKebabPageState extends State<TopKebabPage> {
  List<Map<String, dynamic>> dashList = [];
  List<Map<String, dynamic>> searchResultList = [];
  bool isLoading = true;
  String? errorMessage;
  String orderByField = 'rating';
  bool orderDirection = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchKebab(widget.currentPosition);
  }

  Future<void> fetchKebab(Position userPosition) async {
    try {
      final PostgrestList response;
      if (orderByField != 'distance') {
        response = await supabase
            .from('kebab')
            .select('*')
            .order(orderByField, ascending: orderDirection);
      } else {
        response = await supabase.from('kebab').select('*');
      }

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

        if (orderByField == 'distance') {
          kebabs.sort((a, b) {
            return orderDirection
                ? b['distance'].compareTo(a['distance'])
                : a['distance'].compareTo(b['distance']);
          });
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

  void searchKebab(String query) {
    final filteredList = dashList.where((kebab) {
      final kebabName = kebab['name'].toString().toLowerCase();
      final searchText = query.toLowerCase();
      return kebabName.contains(searchText);
    }).toList();

    filteredList.sort((a, b) {
      final aName = a['name'].toString().toLowerCase();
      final bName = b['name'].toString().toLowerCase();
      final aIndex = aName.indexOf(query.toLowerCase());
      final bIndex = bName.indexOf(query.toLowerCase());
      return aIndex.compareTo(bIndex);
    });

    setState(() {
      searchResultList = filteredList;
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
                      child: Column(
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
                                  rating: (kebab['rating'] ?? 0.0).toDouble(),
                                  quality: (kebab['quality'] ?? 0.0).toDouble(),
                                  price: (kebab['price'] ?? 0.0).toDouble(),
                                  dimension:
                                      (kebab['dimension'] ?? 0.0).toDouble(),
                                  menu: (kebab['menu'] ?? 0.0).toDouble(),
                                  map: kebab['map'] ?? '',
                                  lat: (kebab['lat'] ?? 0.0).toDouble(),
                                  lng: (kebab['lng'] ?? 0.0).toDouble(),
                                  distance:
                                      (kebab['distance'] ?? 0.0).toDouble(),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 16)
                        ],
                      ),
                    ),
    );
  }
}
