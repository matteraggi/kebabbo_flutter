import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image/image.dart' as img;
import 'package:kebabbo_flutter/main.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

List<Map<String, dynamic>> fuzzySearchAndSort(List<Map<String, dynamic>> items,
    String query, String searchKey, bool showOnlyOpen, bool showOnlyKebab) {
  // Copia: removeWhere non deve modificare la lista del chiamante.
  List<Map<String, dynamic>> tempList = List.of(items);
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
        final lat = kebab['lat'];
        final lng = kebab['lng'];
        if (lat != null && lng != null) {
          double distanceInMeters = Geolocator.distanceBetween(
            userPosition.latitude,
            userPosition.longitude,
            lat,
            lng,
          );
          kebab[orderByField] = distanceInMeters / 1000;
        } else {
          kebab[orderByField] = double.infinity;
        }
      }
    }
  }
  if (orderByField == 'name') {
    orderDirection = !orderDirection;
  }

  // Sort kebabs based on orderByField and orderDirection
  kebabs.sort((a, b) {
    var valA = a[orderByField];
    var valB = b[orderByField];
    if (valA == null && valB == null) return 0;
    if (valA == null) return 1;
    if (valB == null) return -1;
    return orderDirection
        ? valB.compareTo(valA)
        : valA.compareTo(valB);
  });

  return kebabs;
}

String generateHash(String kebabberName) {
  final bytes = utf8.encode(kebabberName);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

/// Chiavi (in italiano) usate nel JSON `orari_apertura`, da lunedì a domenica.
const List<String> orariDayKeys = [
  'lunedì',
  'martedì',
  'mercoledì',
  'giovedì',
  'venerdì',
  'sabato',
  'domenica',
];

/// Normalizza `orari_apertura`: accetta sia una Map sia una stringa JSON
/// (righe salvate in passato come stringa jsonb).
Map<String, dynamic>? parseOrari(dynamic orariApertura) {
  if (orariApertura is Map) return Map<String, dynamic>.from(orariApertura);
  if (orariApertura is String && orariApertura.trim().isNotEmpty) {
    try {
      final decoded = jsonDecode(orariApertura);
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    } catch (_) {}
  }
  return null;
}

/// Verifica se sono presenti orari di apertura validi (non null, non mappa vuota, non tutti i valori vuoti o null).
bool hasOpeningHours(dynamic orariApertura) {
  final orari = parseOrari(orariApertura);
  if (orari == null || orari.isEmpty) return false;
  return orari.values.any((v) {
    if (v == null) return false;
    final s = v.toString().trim().toLowerCase();
    return s.isNotEmpty && s != 'null';
  });
}

/// Nome del giorno localizzato per un indice 0 (lunedì) .. 6 (domenica).
String localizedWeekdayName(BuildContext context, int index) {
  final locale = Localizations.localeOf(context).languageCode;
  // 1 gennaio 2024 era un lunedì.
  final name = DateFormat.EEEE(locale).format(DateTime(2024, 1, 1 + index));
  return name.isEmpty ? name : name[0].toUpperCase() + name.substring(1);
}

/// "3 giorni fa" / "3 days ago" nella lingua corrente dell'app.
String formatTimeAgo(BuildContext context, DateTime date) {
  final locale = Localizations.localeOf(context).languageCode;
  return timeago.format(date, locale: locale);
}

/// Indirizzo leggibile di un kebab, es. "I Panini di Mirò" -> "i-panini-di-miro".
/// Deve dare lo stesso risultato di `slugify` in seo/lib.mjs (pagine web).
String kebabSlug(String name) {
  const special = {'ı': 'i', 'ß': 'ss', 'ø': 'o', 'ł': 'l', 'æ': 'ae', 'œ': 'oe', 'đ': 'd'};
  const accents = {
    'a': 'àáâãäåāăą', 'c': 'çćĉċč', 'd': 'ď', 'e': 'èéêëēĕėęě', 'g': 'ĝğġģ',
    'h': 'ĥ', 'i': 'ìíîïĩīĭįİ', 'j': 'ĵ', 'k': 'ķ', 'l': 'ĺļľ', 'n': 'ñńņňŉ',
    'o': 'òóôõöōŏő', 'r': 'ŕŗř', 's': 'śŝşšș', 't': 'ţťț', 'u': 'ùúûüũūŭůűų',
    'w': 'ŵ', 'y': 'ýÿŷ', 'z': 'źżž',
  };
  final buf = StringBuffer();
  for (final ch in name.toLowerCase().runes.map(String.fromCharCode)) {
    if (ch == "'" || ch == '’') continue;
    final mapped = special[ch] ??
        accents.entries
            .firstWhere((e) => e.value.contains(ch),
                orElse: () => const MapEntry('', ''))
            .key;
    buf.write(mapped.isNotEmpty ? mapped : (ch == '&' ? ' e ' : ch));
  }
  return buf
      .toString()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
      .replaceAll(RegExp(r'^-+|-+$'), '');
}

/// Registra i messaggi timeago per tutte le lingue supportate (en è già incluso).
void registerTimeagoLocales() {
  timeago.setLocaleMessages('it', timeago.ItMessages());
  timeago.setLocaleMessages('es', timeago.EsMessages());
  timeago.setLocaleMessages('fr', timeago.FrMessages());
  timeago.setLocaleMessages('de', timeago.DeMessages());
  timeago.setLocaleMessages('pt', timeago.PtBrMessages());
}

bool isKebabOpen(dynamic orariApertura) {
  final orari = parseOrari(orariApertura);
  if (orari == null) {
    return false;
  }

  final now = DateTime.now();
  final int nowMinutes = now.hour * 60 + now.minute;

  const daysItalian = orariDayKeys;

  final int todayIndex = now.weekday - 1; // 0 for lunedì, 6 for domenica
  final String todayName = daysItalian[todayIndex];
  final int yesterdayIndex = (todayIndex - 1 + 7) % 7;
  final String yesterdayName = daysItalian[yesterdayIndex];

  int? parseTimeToMinutes(String s) {
    final clean = s.trim().replaceAll(' ', '');
    final parts = clean.split(':');
    if (parts.isEmpty) return null;
    final h = int.tryParse(parts[0]);
    if (h == null) return null;
    final m = parts.length > 1 ? (int.tryParse(parts[1]) ?? 0) : 0;
    if (h == 24) return 24 * 60;
    return h * 60 + m;
  }

  bool checkDaySlots(String? daySchedule, {required bool isYesterday}) {
    if (daySchedule == null) return false;
    final lower = daySchedule.trim().toLowerCase();
    if (lower == 'chiuso' || lower.isEmpty) return false;
    if (lower.contains('24h') ||
        lower.contains('aperto 24') ||
        lower == '00:00-24:00' ||
        lower == '00:00-00:00') {
      return true;
    }

    final intervals = lower.split(',');
    for (final interval in intervals) {
      final parts = interval.split('-');
      if (parts.length != 2) continue;

      final startMin = parseTimeToMinutes(parts[0]);
      final endMin = parseTimeToMinutes(parts[1]);
      if (startMin == null || endMin == null) continue;

      if (endMin <= startMin) {
        // Fascia oraria che si estende oltre la mezzanotte
        if (endMin == 0 && parts[1].trim() == '00:00' && startMin > 0) {
          // Chiusura esattamente alla mezzanotte
          if (!isYesterday && nowMinutes >= startMin && nowMinutes < 1440) {
            return true;
          }
        } else {
          // Turno notturno oltre la mezzanotte
          if (!isYesterday) {
            if (nowMinutes >= startMin) return true;
          } else {
            if (nowMinutes < endMin) return true;
          }
        }
      } else {
        // Fascia normale diurna
        if (!isYesterday) {
          if (nowMinutes >= startMin && nowMinutes < endMin) {
            return true;
          }
        }
      }
    }
    return false;
  }

  // 1. Controlla il giorno corrente
  final todaySchedule = orari[todayName]?.toString();
  if (checkDaySlots(todaySchedule, isYesterday: false)) {
    return true;
  }

  // 2. Controlla eventuale turno notturno iniziato ieri
  final yesterdaySchedule = orari[yesterdayName]?.toString();
  if (checkDaySlots(yesterdaySchedule, isYesterday: true)) {
    return true;
  }

  return false;
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
        .eq('is_staff', true)
        .not('lat', 'is', null)
        .not('lng', 'is', null)
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
        if (kebab['lat'] == null || kebab['lng'] == null) continue;
        double distanceInMeters = Geolocator.distanceBetween(
          userPosition.latitude,
          userPosition.longitude,
          (kebab['lat'] as num).toDouble(),
          (kebab['lng'] as num).toDouble(),
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
    debugPrint('Error calculating kebab distance: $error');
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
