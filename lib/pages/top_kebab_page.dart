import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/components/order_bar.dart';
import 'package:kebabbo_flutter/components/kebab_item.dart';

class TopKebabPage extends StatefulWidget {
  @override
  _TopKebabPageState createState() => _TopKebabPageState();
}

class _TopKebabPageState extends State<TopKebabPage> {
  List<Map<String, dynamic>> dashList = [];
  bool isLoading = true;
  String? errorMessage;
  String orderByField = 'rating';
  bool orderDirection = false;

  @override
  void initState() {
    super.initState();
    fetchKebab();
  }

  Future<void> fetchKebab() async {
    try {
      final response = await supabase
          .from('kebab')
          .select('*')
          .order(orderByField, ascending: orderDirection);

      if (mounted) {
        setState(() {
          dashList = List<Map<String, dynamic>>.from(response as List);
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

  // solo distanza non è fattibile in automatico da supabase
  void changeOrderByField(String field) {
    setState(() {
      orderByField = field;
      if (field == 'name') {
        orderDirection = true;
      } else {
        orderDirection = false;
      }
      fetchKebab();
    });
  }

  void changeOrderDirection(bool direction) {
    setState(() {
      orderDirection = direction;
      fetchKebab();
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text('Errore: $errorMessage'))
              : dashList.isEmpty
                  ? Center(child: Text('Nessun Kebabbaro presente :('))
                  : SafeArea(
                      minimum: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 32,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          OrderBar(
                            orderByField: orderByField,
                            orderDirection: orderDirection,
                            onChangeOrderByField: changeOrderByField,
                            onChangeOrderDirection: changeOrderDirection,
                          ),
                          SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: TextField(
                              controller: searchController,
                              onChanged: (value) {
                                // Handle search text changes
                                print('Search text: $value');
                              },
                              decoration: InputDecoration(
                                hintText: "Cerca un kebabbaro...",
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 0.0,
                                  horizontal: 20.0,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(Icons.search),
                              ),
                            ),
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
                                  quality: (kebab['quality'] ?? 0.0).toDouble(),
                                  price: (kebab['price'] ?? 0.0).toDouble(),
                                  dimension:
                                      (kebab['dimension'] ?? 0.0).toDouble(),
                                  menu: (kebab['menu'] ?? 0.0).toDouble(),
                                  map: kebab['map'] ?? '',
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 16)
                        ],
                      ),
                    ),
    );
  }
}
