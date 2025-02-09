import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image/image.dart' as img;
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
    Position? userPosition,
    bool showOnlyOpen,
    bool showOnlyKebab) {
  if (showOnlyOpen) {
    kebabs.removeWhere((kebab) => !isKebabOpen(kebab['orari_apertura']));
  }

  if (orderByField == 'stelle') {
    orderByField = 'rating';
  } else if (orderByField == 'prezzo') {
    orderByField = 'price';
  } else if (orderByField == 'qualità') {
    orderByField = 'quality';
  } else if (orderByField == 'dimensione') {
    orderByField = 'dimension';
  } else if (orderByField == 'nome') {
    orderByField = 'name';
  } else if (orderByField == 'distanza') {
    orderByField = 'distance';
  }

  // Filtra per "Solo kebab"
  if (showOnlyKebab) {
    kebabs.removeWhere((kebab) => kebab['tag'] != 'kebab');
  } else {
    kebabs.removeWhere((kebab) => kebab['tag'] == 'kebab');
  }
  if (orderByField == 'distance') {
    orderDirection = !orderDirection;
    for (var kebab in kebabs) {
      if (userPosition != null) {
        double distanceInMeters = Geolocator.distanceBetween(
          userPosition.latitude,
          userPosition.longitude,
          kebab['lat'],
          kebab['lng'],
        );
        kebab[orderByField] = distanceInMeters / 1000;
      }
    }
  }
  if (orderByField == 'name') {
    orderDirection = !orderDirection;
  }

  // Sort kebabs based on orderByField and orderDirection
  kebabs.sort((a, b) {
    return orderDirection
        ? b[orderByField].compareTo(a[orderByField])
        : a[orderByField].compareTo(b[orderByField]);
  });

  return kebabs;
}

String generateHash(String kebabberName) {
  final bytes = utf8.encode(kebabberName);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

bool isKebabOpen(Map<String, dynamic>? orariApertura) {
  if (orariApertura == null) {
    return false;
  }
  // Ottieni l'ora e il giorno corrente
  DateTime now = DateTime.now();
  String dayOfWeekEnglish =
      DateFormat('EEEE', 'en_US').format(now).toLowerCase();
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

Future<Map<String, int>> calculateAvailableKebabsPerDistance(
  Map<String, int> ingredientAmounts,
  Position? userPosition,
) async {
  try {
    // Fetch all kebabs from Supabase with required ingredient values
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

    Map<String, int> kebabsInRange = {
      '200m': 0,
      '500m': 0,
      '1km': 0,
      '10km': 0,
      'unlimited': kebabs.length, // All kebabs for unlimited range
    };

    // If user location is available, calculate the distance
    if (userPosition != null) {
      for (var kebab in kebabs) {
        double distanceInMeters = Geolocator.distanceBetween(
          userPosition.latitude,
          userPosition.longitude,
          kebab['lat'],
          kebab['lng'],
        );
        double distanceInKm = distanceInMeters / 1000;

        if (distanceInKm <= 0.2) {
          kebabsInRange['200m'] = kebabsInRange['200m']! + 1;
        }
        if (distanceInKm <= 0.5) {
          kebabsInRange['500m'] = kebabsInRange['500m']! + 1;
        }
        if (distanceInKm <= 1) {
          kebabsInRange['1km'] = kebabsInRange['1km']! + 1;
        }
        if (distanceInKm <= 10) {
          kebabsInRange['10km'] = kebabsInRange['10km']! + 1;
        }
      }
    }

    return kebabsInRange; // Return available kebab counts for each range
  } catch (error) {
    print('Error calculating kebab distance: $error');
    return {'200m': 0, '500m': 0, '1km': 0, '10km': 0, 'unlimited': 0};
  }
}

Future<Uint8List?> compressImage(Uint8List imageData) async {
  // Decodifica l'immagine dal byte array
  img.Image? image = img.decodeImage(imageData);
  if (image == null) return null;

  // Ridimensiona l'immagine mantenendo il rapporto di aspetto
  img.Image resizedImage = img.copyResize(image, width: 400);

  // Codifica nuovamente l'immagine in JPEG con qualità ridotta
  return Uint8List.fromList(img.encodeJpg(resizedImage, quality: 60));
}

