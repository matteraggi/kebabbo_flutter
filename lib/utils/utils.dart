import 'package:fuzzy/fuzzy.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

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
