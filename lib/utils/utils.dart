import 'package:fuzzy/fuzzy.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

List<Map<String, dynamic>> fuzzySearchAndSort(List<Map<String, dynamic>> items,
    String query, String searchKey, bool showOnlyOpen, bool showOnlyKebab) {
  List<Map<String, dynamic>> tempList = items;
  if (query.isEmpty) {
    if (showOnlyOpen) {
      tempList.removeWhere((kebab) => !isKebabOpen(kebab['orari_apertura']));
    }
    if (showOnlyKebab) {
      tempList.removeWhere((kebab) => kebab['tag'] != 'kebab');
    }
    return tempList; // Return original list if query is empty
  }

  final fuse = Fuzzy<Map<String, dynamic>>(items,
      options: FuzzyOptions(
        keys: [
          WeightedKey(
            name: searchKey,
            getter: (item) => item[searchKey] ?? '',
            weight: 1.0,
          )
        ],
        threshold: 1, // You can adjust this threshold
      ));

  final results = fuse.search(query);

  results.sort((a, b) {
    return (a.score).compareTo(b.score);
  });
  tempList = results.map((result) => result.item).toList();
  if (showOnlyOpen) {
    tempList.removeWhere((kebab) => !isKebabOpen(kebab['orari_apertura']));
  }
  if (showOnlyKebab) {
    tempList.removeWhere((kebab) => kebab['tag'] != 'kebab');
  }
  return tempList;
}

List<Map<String, dynamic>> sortKebabs(
    List<Map<String, dynamic>> kebabs,
    String orderByField,
    bool orderDirection,
    Position userPosition,
    bool showOnlyOpen,
    bool showOnlyKebab) {
  if (showOnlyOpen) {
    kebabs.removeWhere((kebab) => !isKebabOpen(kebab['orari_apertura']));
  }

  // Filtra per "Solo kebab"
  if (showOnlyKebab) {
    kebabs.removeWhere((kebab) => kebab['tag'] != 'kebab');
  } // Calculate distance for each kebab if orderByField is 'distance'
  if (orderByField == 'distance') {
    for (var kebab in kebabs) {
      double distanceInMeters = Geolocator.distanceBetween(
        userPosition.latitude,
        userPosition.longitude,
        kebab['lat'],
        kebab['lng'],
      );
      kebab['distance'] = distanceInMeters / 1000;
    }
  }

  // Sort kebabs based on orderByField and orderDirection
  kebabs.sort((a, b) {
    if (orderByField == 'distance') {
      // Special handling for distance sorting
      return orderDirection
          ? b['distance'].compareTo(a['distance'])
          : a['distance'].compareTo(b['distance']);
    } else {
      // Generic sorting for other fields
      return orderDirection
          ? b[orderByField].compareTo(a[orderByField])
          : a[orderByField].compareTo(b[orderByField]);
    }
  });

  return kebabs;
}

bool isKebabOpen(Map<String, dynamic>? orariApertura) {
  if (orariApertura == null) {
    return false;
  }
  // Ottieni l'ora e il giorno corrente
  DateTime now = DateTime.now();
  String dayOfWeekEnglish =
      DateFormat('EEEE').format(now).toLowerCase(); // giorno in minuscolo

  const Map<String, String> daysOfWeek = {
    'monday': 'lunedì',
    'tuesday': 'martedì',
    'wednesday': 'mercoledì',
    'thursday': 'giovedì',
    'friday': 'venerdì',
    'saturday': 'sabato',
    'sunday': 'domenica',
  };

  String dayOfWeek = daysOfWeek[dayOfWeekEnglish]!;
  // Controlla se il giorno corrente è presente negli orari di apertura
  if (orariApertura.containsKey(dayOfWeek)) {
    // Ottieni gli orari di apertura per il giorno corrente
    String orari = orariApertura[dayOfWeek];
    if (orari == "chiuso") {
      return false;
    }

    // Dividi gli orari di apertura per virgola (se ci sono più fasce orarie)
    List<String> orariList = orari.split(',');
    for (String orario in orariList) {
      // Dividi l'orario per trattino per ottenere l'ora di inizio e fine
      List<String> startEnd = orario.split('-');
      DateTime startTime = DateFormat('HH:mm').parse(startEnd[0]);
      DateTime endTime = DateFormat('HH:mm').parse(startEnd[1]);

      // Gestisci il caso in cui l'orario di chiusura sia dopo mezzanotte
      if (endTime.isBefore(startTime)) {
        endTime = endTime.add(const Duration(days: 1));
      }

      // Crea un DateTime per l'ora corrente con la stessa data di startTime
      DateTime nowWithStartTime = DateTime(
        startTime.year,
        startTime.month,
        startTime.day,
        now.hour,
        now.minute,
      );
      // Controlla se l'ora corrente è compresa tra l'ora di inizio e fine
      if (nowWithStartTime.isAfter(startTime) &&
          nowWithStartTime.isBefore(endTime)) {
        return true; // Il kebabbaro è aperto!
      }
    }
  }
  return false; // Il kebabbaro è chiuso
}


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
