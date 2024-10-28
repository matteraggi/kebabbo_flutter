import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kebabbo_flutter/components/kebab_item.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/utils/utils.dart';

class KebabRecommendationPage extends StatefulWidget {
  final Position? currentPosition;

  final Map<String, dynamic> kebab;
  final int availableKebabs;
  final Map<String, int> ingredients;
  final double maxDistance;


  const KebabRecommendationPage({
    super.key,
    required this.kebab,
    required this.availableKebabs,
    required this.ingredients,
    required this.maxDistance,
    required this.currentPosition,
  });

  @override
  _KebabRecommendationPageState createState() =>
      _KebabRecommendationPageState();
}

class _KebabRecommendationPageState extends State<KebabRecommendationPage> {
  late Map<String, dynamic> _currentKebab; // State variable for the current kebab
  double? _distanceInKm;
  int rerollCounter = 0;

  @override
  void initState() {
    super.initState();
    _currentKebab = widget.kebab; // Initialize with the initial kebab
    _currentKebab['isFavorite'] = false;

    _calculateDistance();
  }

  

  void _calculateDistance() {
    if (widget.currentPosition != null &&
        _currentKebab['lat'] != null &&
        _currentKebab['lng'] != null) {
      double distanceInMeters = Geolocator.distanceBetween(
        widget.currentPosition!.latitude,
        widget.currentPosition!.longitude,
        _currentKebab['lat'],
        _currentKebab['lng'],
      );
      setState(() {
        _distanceInKm = distanceInMeters / 1000;
      });
    } else {
      setState(() {
        _distanceInKm = null;
      });
    }
  }

  Future<void> _rerollRecommendation() async {
    setState(() {
      rerollCounter++;
    });
    Map<String, dynamic>? result = await buildKebab(widget.ingredients, rerollCounter, widget.maxDistance,widget.currentPosition );
    if (result != null) {
      setState(() {
  _currentKebab = result['kebab'];
  _currentKebab['isFavorite'] = false;
    // Recalculate the distance for the new kebab
    _calculateDistance();
      });
            setState(() {}); 

}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kebab Consigliato'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Il kebab che ti raccomandiamo è:',
                      style: TextStyle(fontSize: 32, color: red, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    KebabListItem(
                      id: _currentKebab['id'].toString(),
                      name: _currentKebab['name'] ?? 'Kebab Sconosciuto',
                      description: _currentKebab['description'] ??
                          'Descrizione non disponibile',
                      rating: (_currentKebab['rating'] ?? 0.0).toDouble(),
                      quality: (_currentKebab['quality'] ?? 0.0).toDouble(),
                      price: (_currentKebab['price'] ?? 0.0).toDouble(),
                      dimension: (_currentKebab['dimension'] ?? 0.0).toDouble(),
                      menu: (_currentKebab['menu'] ?? 0.0).toDouble(),
                      fun: (_currentKebab['fun'] ?? 0.0).toDouble(),
                      map: _currentKebab['map'] ?? 'N/A',
                      lat: (_currentKebab['lat'] ?? 0.0).toDouble(),
                      lng: (_currentKebab['lng'] ?? 0.0).toDouble(),
                      distance: _distanceInKm,
                      vegetables:
                          (_currentKebab['vegetables'] ?? 0.0).toDouble(),
                      yogurt: (_currentKebab['yogurt'] ?? 0.0).toDouble(),
                      spicy: (_currentKebab['spicy'] ?? 0.0).toDouble(),
                      onion: (_currentKebab['onion'] ?? 0.0).toDouble(),
                      tag: _currentKebab['tag'] ?? 'Generale',
                      isOpen: isKebabOpen(_currentKebab['orari_apertura']),
                      isFavorite: _currentKebab['isFavorite'] ?? false,
                      onFavoriteToggle: () => toggleFavorite(
                                          _currentKebab['id'].toString()),
                      special: false,
                      initiallyExpanded: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed:
                      rerollCounter < widget.availableKebabs - 1
                          ? _rerollRecommendation
                          : null, // Disable if rerollCounter exceeds available kebabs
                  child: const Text("Reroll"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Go back to previous page
                  },
                  child: const Text("Back to Build"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Future<void> toggleFavorite(String kebabId) async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Preferiti solo per utenti registrati"),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
      final isCurrentlyFavorite = _currentKebab['isFavorite'];
      final userResponse = await supabase
              .from('profiles')
              .select('favorites')
              .eq('id', user.id)
              .single();

          final List<String> updatedFavorites =
              List<String>.from(userResponse['favorites'] ?? []);

      // Log stato attuale
      print("Stato preferito attuale per $kebabId: $isCurrentlyFavorite");

      if (isCurrentlyFavorite) {
        updatedFavorites.remove(kebabId);
        print("Rimosso $kebabId dai preferiti.");
      } else {
        updatedFavorites.add(kebabId);
        print("Aggiunto $kebabId ai preferiti.");
      }

      // Effettua aggiornamento su Supabase
      await supabase
          .from('profiles')
          .update({'favorites': updatedFavorites}).eq('id', user.id);

      // Aggiorna lo stato in dashList
      setState(() {
        _currentKebab['isFavorite'] = !isCurrentlyFavorite;
      });

      // Log del nuovo stato
      print("Nuovo stato preferito per $kebabId: ${!isCurrentlyFavorite}");
}
}