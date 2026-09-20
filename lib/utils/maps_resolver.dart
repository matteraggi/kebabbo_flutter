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

      // Se è un link breve (maps.app.goo.gl o goo.gl), seguiamo i redirect
      if (trimmed.contains('goo.gl') || !trimmed.contains('@')) {
        final client = http.Client();
        try {
          final request = http.Request('GET', Uri.parse(trimmed))
            ..followRedirects = true
            ..maxRedirects = 5;
          final response = await client.send(request);
          resolvedUrl = response.request?.url.toString() ?? trimmed;
        } finally {
          client.close();
        }
      }

      // Estrai coordinate tramite regex su vari formati Google Maps
      LatLng? coords = extractCoordsFromUrl(resolvedUrl);

      // Se non trovate nel link finale, proviamo anche sul link originale
      coords ??= extractCoordsFromUrl(trimmed);

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

  /// Estrae il nome del locale dall'URL Google Maps (se presente)
  static String? extractPlaceNameFromUrl(String url) {
    try {
      // 1. Formato standard /place/Nome+Del+Locale/@lat,lng
      final placeRegex = RegExp(r'/place/([^/@?]+)');
      final placeMatch = placeRegex.firstMatch(url);
      if (placeMatch != null) {
        final raw = Uri.decodeComponent(placeMatch.group(1)!).replaceAll('+', ' ').trim();
        if (raw.isNotEmpty && !RegExp(r'^-?\d+\.\d+,-?\d+\.\d+$').hasMatch(raw)) {
          return raw;
        }
      }

      // 2. Formato query q=Nome+Locale o query=Nome+Locale
      final qRegex = RegExp(r'[?&](?:query|q)=([^&]+)');
      final qMatch = qRegex.firstMatch(url);
      if (qMatch != null) {
        final raw = Uri.decodeComponent(qMatch.group(1)!).replaceAll('+', ' ').trim();
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
    // 1. Formato standard @lat,lng,zoom (es. /place/.../@44.495536,11.3486402,17z)
    final atRegex = RegExp(r'@(-?\d+\.\d+),(-?\d+\.\d+)');
    final atMatch = atRegex.firstMatch(url);
    if (atMatch != null) {
      final lat = double.tryParse(atMatch.group(1)!);
      final lng = double.tryParse(atMatch.group(2)!);
      if (lat != null && lng != null) return LatLng(lat, lng);
    }

    // 2. Formato query q=lat,lng o query=lat,lng o destination=lat,lng
    final qRegex = RegExp(r'(?:q|query|destination|ll)=(-?\d+\.\d+),(-?\d+\.\d+)');
    final qMatch = qRegex.firstMatch(url);
    if (qMatch != null) {
      final lat = double.tryParse(qMatch.group(1)!);
      final lng = double.tryParse(qMatch.group(2)!);
      if (lat != null && lng != null) return LatLng(lat, lng);
    }

    // 3. Formato Protobuf Embed Google (!2d<lng>!3d<lat> oppure !3d<lat>!4d<lng>)
    final proto2d3dRegex = RegExp(r'!2d(-?\d+\.\d+)!3d(-?\d+\.\d+)');
    final proto2d3dMatch = proto2d3dRegex.firstMatch(url);
    if (proto2d3dMatch != null) {
      final lng = double.tryParse(proto2d3dMatch.group(1)!);
      final lat = double.tryParse(proto2d3dMatch.group(2)!);
      if (lat != null && lng != null) return LatLng(lat, lng);
    }

    final protoRegex = RegExp(r'!3d(-?\d+\.\d+)!4d(-?\d+\.\d+)');
    final protoMatch = protoRegex.firstMatch(url);
    if (protoMatch != null) {
      final lat = double.tryParse(protoMatch.group(1)!);
      final lng = double.tryParse(protoMatch.group(2)!);
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
          '$_nominatimBaseUrl/search?q=$encoded&format=json&addressdetails=1&limit=5&countrycodes=it');
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
