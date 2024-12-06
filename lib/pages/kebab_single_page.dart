import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/kebab_item_favorite.dart';
import 'package:kebabbo_flutter/main.dart';

class KebabSinglePage extends StatefulWidget {
  final String kebabId;

  const KebabSinglePage({super.key, required this.kebabId});

  @override
  KebabSinglePageState createState() => KebabSinglePageState();
}

class KebabSinglePageState extends State<KebabSinglePage> {
  Map<String, dynamic>? kebabData;

  @override
  void initState() {
    super.initState();
    _fetchKebabData();
  }

  Future<void> _fetchKebabData() async {
    try {
      final response = await supabase
          .from('kebab')
          .select('*')
          .eq('id', widget.kebabId)
          .single();

      setState(() {
        kebabData = response;
      });
    } catch (error) {
      print('errore_nel_caricamento_dei_dati_del_kebabbaro:$error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: kebabData == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KebabListItemFavorite(
                    id: kebabData!['id'].toString(),
                    name: kebabData?["name"] ?? "",
                    description: kebabData?["description"] ?? "",
                    rating: (kebabData?["rating"] ?? 0.0).toDouble(),
                    quality: (kebabData?["quality"] ?? 0.0).toDouble(),
                    price: (kebabData?["price"] ?? 0.0).toDouble(),
                    dimension: (kebabData?["dimension"] ?? 0.0).toDouble(),
                    menu: (kebabData?["menu"] ?? 0.0).toDouble(),
                    fun: (kebabData?["fun"] ?? 0.0).toDouble(),
                    map: kebabData?["map"] ?? "",
                    lat: (kebabData?["lat"] ?? 0.0).toDouble(),
                    lng: (kebabData?["lng"] ?? 0.0).toDouble(),
                    vegetables: (kebabData?["vegetables"] ?? 0.0).toDouble(),
                    yogurt: (kebabData?["yogurt"] ?? 0.0).toDouble(),
                    spicy: (kebabData?["spicy"] ?? 0.0).toDouble(),
                    onion: (kebabData?["onion"] ?? 0.0).toDouble(),
                    tag: kebabData?["tag"] ?? "",
                    isOpen: kebabData?["isOpen"] ?? false,
                    glutenFree: kebabData?["gluten_free"] ?? false,
                    expanded: true,
                  ),
                ],
              ),
            ),
    );
  }
}
