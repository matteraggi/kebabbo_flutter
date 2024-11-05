import 'package:flutter/material.dart';
import 'package:kebabbo_flutter/components/kebab_item_favorite.dart';
import 'package:kebabbo_flutter/main.dart';


class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Map<String, dynamic>> _favoriteKebabs = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadFavoriteKebabs();
  }

Future<void> _loadFavoriteKebabs() async {
  if (mounted) {
    setState(() {
      _loading = true;
    });
  }

  try {
    final userId = supabase.auth.currentSession!.user.id;

    final userData = await supabase
        .from('profiles')
        .select('favorites')
        .eq('id', userId)
        .single();

    final favoriteIds = List<String>.from(userData['favorites'] ?? []);

    if (favoriteIds.isNotEmpty) {
      // Recupera i kebab utilizzando gli ID preferiti
      final kebabsResponse =
          await supabase.from('kebab').select().inFilter('id', favoriteIds);

      _favoriteKebabs = List<Map<String, dynamic>>.from(kebabsResponse);
    }
  } catch (error) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load favorites')),
      );
    }
  } finally {
    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: yellow,
        title: const Text('Kebab Preferiti'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          child: _loading
              ? const Center(child: CircularProgressIndicator())
              : _favoriteKebabs.isEmpty
                  ? const Center(child: Text("Nessun kebab tra i preferiti"))
                  : ListView.builder(
                      itemCount: _favoriteKebabs.length,
                      itemBuilder: (context, index) {
                        final kebab = _favoriteKebabs[index];
                        return KebabListItemFavorite(
                          id: kebab['id'].toString(),
                          name: kebab['name'] ?? '',
                          description: kebab['description'] ?? '',
                          rating: (kebab['rating'] ?? 0.0).toDouble(),
                          quality: (kebab['quality'] ?? 0.0).toDouble(),
                          price: (kebab['price'] ?? 0.0).toDouble(),
                          dimension: (kebab['dimension'] ?? 0.0).toDouble(),
                          menu: (kebab['menu'] ?? 0.0).toDouble(),
                          fun: (kebab['fun'] ?? 0.0).toDouble(),
                          map: kebab['map'] ?? '',
                          lat: (kebab['lat'] ?? 0.0).toDouble(),
                          lng: (kebab['lng'] ?? 0.0).toDouble(),
                          vegetables: (kebab['vegetables'] ?? 0.0).toDouble(),
                          yogurt: (kebab['yogurt'] ?? 0.0).toDouble(),
                          spicy: (kebab['spicy'] ?? 0.0).toDouble(),
                          onion: (kebab['onion'] ?? 0.0).toDouble(),
                          tag: (kebab['tag'] ?? ''),
                          isOpen: kebab['isOpen'] ?? false,
                          glutenFree: kebab['gluten_free'] ?? false,
                          expanded: false,
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
