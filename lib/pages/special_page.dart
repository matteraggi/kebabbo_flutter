import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/components/kebab_item.dart';

class SpecialPage extends StatefulWidget {
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
    fetchKebab('kebab_world');
  }

  Future<void> fetchKebab(String tableName) async {
    try {
      final response = await supabase.from(tableName).select('*');
      if (!mounted) return;
      setState(() {
        dashList = List<Map<String, dynamic>>.from(response as List);
        isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        errorMessage = error.toString();
        isLoading = false;
      });
    }
  }

  void onTabChange(String tableName) {
    setState(() {
      isLoading = true;
      errorMessage = null;
      dashList = [];
    });
    fetchKebab(tableName);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Kebab'),
          bottom: TabBar(
            onTap: (index) {
              if (index == 0) {
                onTabChange('kebab_world');
              } else {
                onTabChange('kebab_legend');
              }
            },
            tabs: [
              Tab(text: 'World'),
              Tab(text: 'Special'),
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
                                    quality:
                                        (kebab['quality'] ?? 0.0).toDouble(),
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
      ),
    );
  }
}
