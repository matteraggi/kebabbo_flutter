import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';



Future<Map<String, dynamic>?> buildKebab(
    Map<String, int> ingredientAmounts,
    int rerollCounter,
    double maxDistance,
    Position? userPosition) async {
  try {
    // Fetch kebabs with non-null ingredient values from Supabase
    final PostgrestList response = await supabase
        .from('kebab')
        .select('*')
        .not('meat', 'is', null)
        .not('onion', 'is', null)
        .not('spicy', 'is', null)
        .not('yogurt', 'is', null)
        .not('vegetables', 'is', null);

    List<Map<String, dynamic>> kebabs =
        List<Map<String, dynamic>>.from(response as List);

    // Filter kebabs by maximum distance
    if (userPosition != null) {
      kebabs = kebabs.where((kebab) {
        double distanceInMeters = Geolocator.distanceBetween(
          userPosition.latitude,
          userPosition.longitude,
          kebab['lat'],
          kebab['lng'],
        );
        double distanceInKm = distanceInMeters / 1000;
        return distanceInKm <= maxDistance;
      }).toList();
    }

    // Sort kebabs by how closely they match the user ingredients
    List<Map<String, dynamic>> sortedKebabs = kebabs
        .map((kebab) {
          double totalDistance = 0;
          int includedIngredients = 0;

          for (String ingredient in ingredientAmounts.keys) {
            var kebabValue = kebab[ingredient];
            double distance = calculateIngredientDistance(
              ingredient,
              ingredientAmounts[ingredient]!,
              kebabValue as int?,
            );
            if (distance >= 0) {
              totalDistance += distance;
              includedIngredients++;
            }
          }

          double averageDistance = includedIngredients > 0
              ? totalDistance / includedIngredients
              : double.infinity;

          return {'kebab': kebab, 'averageDistance': averageDistance};
        })
        .toList();

    sortedKebabs
        .sort((a, b) => a['averageDistance'].compareTo(b['averageDistance']));

    if (sortedKebabs.isNotEmpty) {
      int kebabIndex = rerollCounter % sortedKebabs.length;
      return {
        'kebab': sortedKebabs[kebabIndex]['kebab'],
        'availableKebabs': sortedKebabs.length
      };
    }

    return null;
  } catch (error) {
    print('Error building kebab: $error');
    return null;
  }
}


double calculateIngredientDistance(String ingredient, int userInput, int? kebabValue) {
  // If kebabValue is null, treat it as a large distance, or assign a default value
  if ((ingredient == 'spicy' || ingredient == 'onion') && userInput == 0) {
    return -1; // Exclude from calculation if the user does not want this ingredient
  } else if (kebabValue == null) {
    return double.infinity; // Treat null as a very far distance
  } else {
    return (userInput - kebabValue).abs().toDouble(); // Calculate the absolute difference
  }
}
