import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kebabbo_flutter/components/animations/kebab_cooking_overlay.dart';
import 'package:kebabbo_flutter/components/list_items/kebab_item.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/utils/utils.dart';
import 'package:kebabbo_flutter/utils/ingredients_logic.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';

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
  KebabRecommendationPageState createState() => KebabRecommendationPageState();
}

class KebabRecommendationPageState extends State<KebabRecommendationPage> {
  late Map<String, dynamic>
      _currentKebab; // State variable for the current kebab
  double? _distanceInKm;
  int rerollCounter = 0;
  bool _isRerolling = false;

  @override
  void initState() {
    super.initState();
    _currentKebab = widget.kebab; // Initialize with the initial kebab
    _currentKebab['isFavorite'] = false;

    _calculateDistance();
  }

  @override
  void dispose() {
    super.dispose();
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
      _isRerolling = true;
    });

    // Concurrently fetch new kebab with cooking overlay delay
    final results = await Future.wait([
      buildKebab(widget.ingredients, rerollCounter, widget.maxDistance,
          widget.currentPosition),
      Future.delayed(const Duration(milliseconds: 1600)),
    ]);

    final result = results[0] as Map<String, dynamic>?;

    if (result == null) {
      if (mounted) {
        setState(() {
          _isRerolling = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Non ci sono altri kebab disponibili da consigliare."),
            duration: Duration(seconds: 2),
          ),
        );
      }
      return;
    }

    if (mounted) {
      setState(() {
        _currentKebab = result['kebab'];
        _currentKebab['isFavorite'] = false;
        _calculateDistance();
        _isRerolling = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).kebab_consigliato),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          S.of(context).il_kebab_che_ti_raccomandiamo_e,
                          style: TextStyle(
                            fontSize: 32,
                            color: red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        KebabListItem(
                          id: _currentKebab['id'].toString(),
                          name: _currentKebab['name'] ??
                              S.of(context).kebab_sconosciuto,
                          description: _currentKebab['description'] ??
                              S.of(context).descrizione_non_disponibile,
                          rating: (_currentKebab['rating'] ?? 0.0).toDouble(),
                          quality: (_currentKebab['quality'] ?? 0.0).toDouble(),
                          price: (_currentKebab['price'] ?? 0.0).toDouble(),
                          dimension:
                              (_currentKebab['dimension'] ?? 0.0).toDouble(),
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
                          onFavoriteToggle: () =>
                              toggleFavorite(_currentKebab['id'].toString()),
                          special: false,
                          initiallyExpanded: true,
                          glutenFree: _currentKebab['gluten_free'] ?? false,
                          hasUserReview:
                              _currentKebab['user_reviewed'] ?? false,
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
                      onPressed: (rerollCounter < widget.availableKebabs - 1 &&
                              !_isRerolling)
                          ? _rerollRecommendation
                          : null, // Disable if rerollCounter exceeds available kebabs or while rerolling
                      child: const Text("Reroll"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Go back to previous page
                      },
                      child: Text(S.of(context).back_to_build),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Sizzling cooking overlay during reroll
          KebabCookingOverlay(
            isVisible: _isRerolling,
            isReroll: true,
            ingredients: widget.ingredients,
          ),
        ],
      ),
    );
  }

  Future<void> toggleFavorite(String kebabId) async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).preferiti_solo_per_utenti_registrati),
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

    if (isCurrentlyFavorite) {
      updatedFavorites.remove(kebabId);
    } else {
      updatedFavorites.add(kebabId);
    }

    await supabase
        .from('profiles')
        .update({'favorites': updatedFavorites}).eq('id', user.id);

    setState(() {
      _currentKebab['isFavorite'] = !isCurrentlyFavorite;
    });
  }
}
