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
      }
      fetchKebab();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Top Kebab',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            DropdownButton<String>(
              value: orderByField,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  changeOrderByField(newValue);
                }
              },
              items: <String>[
                'rating',
                'quality',
                'price',
                'dimension',
                'menu',
                'name',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value.toUpperCase()),
                );
              }).toList(),
            ),
          ],
        ),
      ),
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
