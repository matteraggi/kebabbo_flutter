import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class LocationDetails {
  final double lat;
  final double lng;
  final String? address;
  final String? placeName;
  final String? city;
  final String googleMapsUrl;

  LocationDetails({
    required this.lat,
    required this.lng,
    this.address,
    this.placeName,
    this.city,
    required this.googleMapsUrl,
  });
}

class MapsResolver {
  static const String _nominatimBaseUrl = 'https://nominatim.openstreetmap.org';
  static const Map<String, String> _headers = {
    'User-Agent': 'KebabboFlutter/1.0 (info@kebabbo.top)',
  };

  /// Genera l'URL universale di ricerca Google Maps
  static String buildGoogleMapsUrl(double lat, double lng) {
    return 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
  }

  /// Risolve un URL di Google Maps (anche accorciato maps.app.goo.gl) ed estrae le coordinate
  static Future<LocationDetails?> resolveGoogleMapsUrl(String inputUrl) async {
    final trimmed = inputUrl.trim();
    if (trimmed.isEmpty) return null;

    try {
      String resolvedUrl = trimmed;

      // 1. Controlla prima se il link contiene già le coordinate (come i link estesi di Google Maps)
      LatLng? coords = extractCoordsFromUrl(trimmed);

      // 2. Se non ha coordinate ed è un link breve (maps.app.goo.gl o goo.gl), srotoliamo l'URL
      if (coords == null && (trimmed.contains('goo.gl') || !trimmed.contains('@'))) {
        if (kIsWeb) {
          // Su Web i browser bloccano le chiamate dirette a maps.app.goo.gl per via della CORS policy.
          // Utilizziamo un endpoint unshortener pubblico con CORS abilitato (Access-Control-Allow-Origin: *).
          final unshortened = await _unshortenWebUrl(trimmed);
          if (unshortened != null && unshortened.isNotEmpty) {
            resolvedUrl = unshortened;
          }
        } else {
          final client = http.Client();
          try {
            String currentUrl = trimmed;
            for (int i = 0; i < 5; i++) {
              final request = http.Request('GET', Uri.parse(currentUrl))
                ..followRedirects = false;
              final response = await client.send(request);
              final location = response.headers['location'];
              if (location != null && location.isNotEmpty) {
                currentUrl = Uri.parse(currentUrl).resolve(location).toString();
              } else {
                break;
              }
            }
            resolvedUrl = currentUrl;
          } catch (_) {
            // Fallback
          } finally {
            client.close();
          }
        }
      }

      // Estrai coordinate tramite regex su vari formati Google Maps
      coords = extractCoordsFromUrl(resolvedUrl) ?? coords ?? extractCoordsFromUrl(trimmed);

      // Estrai nome del luogo dall'URL se presente (es. /place/Nome+Locale/@... o ?q=Nome+Locale)
      final extractedName = extractPlaceNameFromUrl(resolvedUrl) ?? extractPlaceNameFromUrl(trimmed);

      if (coords != null) {
        // Reverse geocode per ottenere l'indirizzo
        final details = await reverseGeocode(coords.latitude, coords.longitude);
        final finalName = (extractedName != null && extractedName.isNotEmpty)
            ? extractedName
            : details?['name'];

        return LocationDetails(
          lat: coords.latitude,
          lng: coords.longitude,
          address: details?['address'],
          placeName: finalName,
          city: details?['city'],
          googleMapsUrl: trimmed.startsWith('http')
              ? trimmed
              : buildGoogleMapsUrl(coords.latitude, coords.longitude),
        );
      }
    } catch (e) {
      debugPrint('Errore durante la risoluzione del link Maps: $e');
    }

    return null;
  }

  /// Su Web usiamo unshorten.me con CORS abilitato per espandere i link brevi maps.app.goo.gl
  static Future<String?> _unshortenWebUrl(String url) async {
    try {
      final unshortenUri = Uri.parse('https://unshorten.me/json/${Uri.encodeComponent(url)}');
      final res = await http.get(unshortenUri, headers: _headers);
      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        if (data is Map && data['success'] == true && data['resolved_url'] != null) {
          String resolved = data['resolved_url'].toString();
          if (resolved.contains('continue=')) {
            final uri = Uri.tryParse(resolved);
            final continueParam = uri?.queryParameters['continue'];
            if (continueParam != null && continueParam.isNotEmpty) {
              resolved = continueParam;
            }
          }
          return Uri.decodeFull(resolved);
        }
      }
    } catch (e) {
      debugPrint('Errore unshorten web proxy: $e');
    }
    return null;
  }

  static String _safeDecode(String encoded) {
    try {
      return Uri.decodeComponent(encoded).replaceAll('+', ' ').trim();
    } catch (_) {
      try {
        return Uri.decodeQueryComponent(encoded).trim();
      } catch (_) {
        return encoded.replaceAll('+', ' ').trim();
      }
    }
  }

  /// Estrae il nome del locale dall'URL Google Maps (se presente)
  static String? extractPlaceNameFromUrl(String url) {
    try {
      // 1. Formato standard /place/Nome+Del+Locale/@lat,lng
      final placeRegex = RegExp(r'/place/([^/@?]+)');
      final placeMatch = placeRegex.firstMatch(url);
      if (placeMatch != null) {
        final raw = _safeDecode(placeMatch.group(1)!);
        if (raw.isNotEmpty && !RegExp(r'^-?\d+\.\d+,-?\d+\.\d+$').hasMatch(raw)) {
          return raw;
        }
      }

      // 2. Formato query q=Nome+Locale o query=Nome+Locale
      final qRegex = RegExp(r'[?&](?:query|q)=([^&]+)');
      final qMatch = qRegex.firstMatch(url);
      if (qMatch != null) {
        final raw = _safeDecode(qMatch.group(1)!);
        if (raw.isNotEmpty && !RegExp(r'^-?\d+\.\d+,-?\d+\.\d+$').hasMatch(raw)) {
          return raw;
        }
      }
    } catch (e) {
      debugPrint('Errore estrazione nome da URL: $e');
    }
    return null;
  }

  /// Estrae LatLng da un URL o stringa
  static LatLng? extractCoordsFromUrl(String url) {
    // 1. Formato Protobuf Pin Google Place (!3d<lat>!4d<lng>)
    // PRIORITARIO: rappresenta il pin esatto del locale, mentre @lat,lng è spesso solo la viewport della mappa
    final protoRegex = RegExp(r'!3d(-?\d+\.\d+)!4d(-?\d+\.\d+)');
    final protoMatch = protoRegex.firstMatch(url);
    if (protoMatch != null) {
      final lat = double.tryParse(protoMatch.group(1)!);
      final lng = double.tryParse(protoMatch.group(2)!);
      if (lat != null && lng != null) return LatLng(lat, lng);
    }

    // 2. Formato Protobuf Embed Google (!2d<lng>!3d<lat>)
    final proto2d3dRegex = RegExp(r'!2d(-?\d+\.\d+)!3d(-?\d+\.\d+)');
    final proto2d3dMatch = proto2d3dRegex.firstMatch(url);
    if (proto2d3dMatch != null) {
      final lng = double.tryParse(proto2d3dMatch.group(1)!);
      final lat = double.tryParse(proto2d3dMatch.group(2)!);
      if (lat != null && lng != null) return LatLng(lat, lng);
    }

    // 3. Formato query esplicita q=lat,lng o query=lat,lng o destination=lat,lng o ll=lat,lng
    final qRegex = RegExp(r'(?:q|query|destination|ll)=(-?\d+\.\d+),(-?\d+\.\d+)');
    final qMatch = qRegex.firstMatch(url);
    if (qMatch != null) {
      final lat = double.tryParse(qMatch.group(1)!);
      final lng = double.tryParse(qMatch.group(2)!);
      if (lat != null && lng != null) return LatLng(lat, lng);
    }

    // 4. Formato standard camera/viewport @lat,lng,zoom (es. /place/.../@44.495536,11.3486402,17z)
    final atRegex = RegExp(r'@(-?\d+\.\d+),(-?\d+\.\d+)');
    final atMatch = atRegex.firstMatch(url);
    if (atMatch != null) {
      final lat = double.tryParse(atMatch.group(1)!);
      final lng = double.tryParse(atMatch.group(2)!);
      if (lat != null && lng != null) return LatLng(lat, lng);
    }

    return null;
  }

  /// Reverse geocoding gratuito tramite Nominatim (OpenStreetMap)
  static Future<Map<String, String>?> reverseGeocode(
      double lat, double lng) async {
    try {
      final uri = Uri.parse(
          '$_nominatimBaseUrl/reverse?lat=$lat&lon=$lng&format=json&addressdetails=1');
      final res = await http.get(uri, headers: _headers);
      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        final address = data['address'] as Map<String, dynamic>?;
        if (address != null) {
          final road = address['road'] ?? address['pedestrian'] ?? address['suburb'] ?? '';
          final houseNumber = address['house_number'] ?? '';
          final city = address['city'] ?? address['town'] ?? address['village'] ?? address['county'] ?? '';
          final formattedAddress = [
            if (road.isNotEmpty) road + (houseNumber.isNotEmpty ? ' $houseNumber' : ''),
            if (city.isNotEmpty) city,
          ].join(', ');

          final rawName = data['name']?.toString() ?? '';
          final amenity = address['amenity'] ??
              address['shop'] ??
              address['restaurant'] ??
              address['fast_food'] ??
              '';
          final placeName = rawName.isNotEmpty
              ? rawName
              : (amenity is String && amenity.isNotEmpty ? amenity : '');

          return {
            'address': formattedAddress.isNotEmpty
                ? formattedAddress
                : (data['display_name'] ?? ''),
            'name': placeName,
            'city': city,
          };
        }
      }
    } catch (e) {
      debugPrint('Errore nel reverse geocoding: $e');
    }
    return null;
  }

  /// Ricerca indirizzi/luoghi tramite Nominatim
  static Future<List<Map<String, dynamic>>> searchPlaces(String query) async {
    if (query.trim().length < 3) return [];
    try {
      final encoded = Uri.encodeComponent(query.trim());
      final uri = Uri.parse(
          '$_nominatimBaseUrl/search?q=$encoded&format=json&addressdetails=1&limit=8');
      final res = await http.get(uri, headers: _headers);
      if (res.statusCode == 200) {
        final List list = json.decode(res.body);
        return list.map((item) {
          final lat = double.tryParse(item['lat'].toString()) ?? 0.0;
          final lon = double.tryParse(item['lon'].toString()) ?? 0.0;
          final displayName = item['display_name']?.toString() ?? '';
          final address = item['address'] as Map<String, dynamic>?;
          final city = address?['city'] ?? address?['town'] ?? address?['village'] ?? '';

          final rawName = item['name']?.toString() ?? '';
          final placeName = rawName.isNotEmpty
              ? rawName
              : (displayName.contains(',') ? displayName.split(',').first.trim() : displayName);

          return {
            'lat': lat,
            'lng': lon,
            'displayName': displayName,
            'name': placeName,
            'city': city,
          };
        }).toList();
      }
    } catch (e) {
      debugPrint('Errore nella ricerca luoghi: $e');
    }
    return [];
  }
}
