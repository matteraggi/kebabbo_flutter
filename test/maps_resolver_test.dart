import 'package:flutter_test/flutter_test.dart';
import 'package:kebabbo_flutter/utils/maps_resolver.dart';

void main() {
  group('MapsResolver Tests', () {
    test('buildGoogleMapsUrl formats lat/lng correctly', () {
      final url = MapsResolver.buildGoogleMapsUrl(44.4955, 11.3512);
      expect(url, 'https://www.google.com/maps/search/?api=1&query=44.4955,11.3512');
    });

    test('extractCoordsFromUrl parses standard @lat,lng Google Maps URL', () {
      const url =
          'https://www.google.com/maps/place/Agra+Take+Away+Indiano/@44.495536,11.3486402,17z/data=!3m1!4b1';
      final coords = MapsResolver.extractCoordsFromUrl(url);
      expect(coords, isNotNull);
      expect(coords!.latitude, closeTo(44.495536, 0.0001));
      expect(coords.longitude, closeTo(11.3486402, 0.0001));
    });

    test('extractCoordsFromUrl parses query q=lat,lng format', () {
      const url = 'https://www.google.com/maps?q=44.4949,11.3426';
      final coords = MapsResolver.extractCoordsFromUrl(url);
      expect(coords, isNotNull);
      expect(coords!.latitude, closeTo(44.4949, 0.0001));
      expect(coords.longitude, closeTo(11.3426, 0.0001));
    });

    test('extractCoordsFromUrl parses Google Embed protobuf coords (!3d / !4d or !2d / !3d)', () {
      const embedUrl =
          'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2845.957!2d11.34864!3d44.495536!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x477fd4bbc276b1f5%3A0xfd478b1bffacb193!2sAgra!5e0!3m2!1sit!2sit';
      final coords = MapsResolver.extractCoordsFromUrl(embedUrl);
      expect(coords, isNotNull);
      expect(coords!.latitude, closeTo(44.495536, 0.0001));
      expect(coords.longitude, closeTo(11.34864, 0.0001));
    });

    test('extractCoordsFromUrl returns null for invalid url', () {
      const invalidUrl = 'https://google.com/search?q=kebab';
      final coords = MapsResolver.extractCoordsFromUrl(invalidUrl);
      expect(coords, isNull);
    });

    test('extractPlaceNameFromUrl extracts name from place URL and query URL', () {
      const placeUrl =
          'https://www.google.com/maps/place/Agra+Take+Away+Indiano/@44.495536,11.3486402,17z';
      final name1 = MapsResolver.extractPlaceNameFromUrl(placeUrl);
      expect(name1, 'Agra Take Away Indiano');

      const queryUrl = 'https://maps.google.com/?q=Bella+Istanbul+3';
      final name2 = MapsResolver.extractPlaceNameFromUrl(queryUrl);
      expect(name2, 'Bella Istanbul 3');

      const coordsOnlyUrl = 'https://maps.google.com/?q=44.4955,11.3512';
      final name3 = MapsResolver.extractPlaceNameFromUrl(coordsOnlyUrl);
      expect(name3, isNull);
    });
  });
}
