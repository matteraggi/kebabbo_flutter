import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/components/kebab_item.dart';

class TopKebabPage extends StatefulWidget {
  @override
  _TopKebabPageState createState() => _TopKebabPageState();
}

class _TopKebabPageState extends State<TopKebabPage> {
  List<Map<String, dynamic>> dashList = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchKebab();
  }

  Future<void> fetchKebab() async {
    try {
      final response = await supabase.from('kebab').select('*');

      setState(() {
        dashList = List<Map<String, dynamic>>.from(response as List);
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = error.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text('Errore: $errorMessage'))
              : dashList.isEmpty
                  ? Center(child: Text('Nessun Kebabbaro presente :('))
                  : SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, left: 16.0, right: 16.0),
                            child: Text(
                              'Top Kebab',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
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
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
    );
  }
}
