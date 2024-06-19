import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/main.dart';

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
      appBar: AppBar(
        title: Text('Top Kebab'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text('Errore: $errorMessage'))
              : dashList.isEmpty
                  ? Center(child: Text('Nessun Kebabbaro presente :('))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: dashList.length,
                            itemBuilder: (context, index) {
                              return KebabListItem(
                                name: dashList[index]['name'] ?? '',
                                description:
                                    dashList[index]['description'] ?? '',
                              );
                            },
                          ),
                        ),
                      ],
                    ),
    );
  }
}

class KebabListItem extends StatelessWidget {
  final String name;
  final String description;

  KebabListItem({
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        name,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        description,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
