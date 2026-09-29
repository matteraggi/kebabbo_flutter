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

      const complexUrl =
          'https://www.google.com/maps/place/Galata+Tantuni+%26+k%C3%BCnefe/@42.5791576,12.8364487,6z/data=!4m6!3m5!1s0x14cab9ba43533c3f:0xffcfb91435c4dccf!8m2!3d41.0278679!4d28.9738275!16s';
      final name4 = MapsResolver.extractPlaceNameFromUrl(complexUrl);
      expect(name4, 'Galata Tantuni & künefe');
    });

    test('extractCoordsFromUrl prioritizes exact place pin (!3d!4d) over viewport camera (@)', () {
      // Nel link reale condiviso dall'utente, @42.579,12.836 è la camera sull'Italia,
      // mentre !3d41.0278679!4d28.9738275 è la posizione reale del locale a Istanbul
      const urlWithBoth =
          'https://www.google.com/maps/place/Galata+Tantuni+%26+k%C3%BCnefe/@42.5791576,12.8364487,6z/data=!4m6!3m5!1s0x14cab9ba43533c3f:0xffcfb91435c4dccf!8m2!3d41.0278679!4d28.9738275!16s%2Fg%2F11qpkckrg1';
      final coords = MapsResolver.extractCoordsFromUrl(urlWithBoth);
      expect(coords, isNotNull);
      // Deve restituire le coordinate di Istanbul, NON quelle dell'Italia
      expect(coords!.latitude, closeTo(41.0278679, 0.0001));
      expect(coords.longitude, closeTo(28.9738275, 0.0001));
    });

    test('resolveGoogleMapsUrl resolves short link Ydk7NbzKFhyvbVXk8 with correct Istanbul coords and name', () async {
      final details = await MapsResolver.resolveGoogleMapsUrl('https://maps.app.goo.gl/Ydk7NbzKFhyvbVXk8');
      expect(details, isNotNull);
      expect(details!.placeName, 'Galata Tantuni & künefe');
      expect(details.lat, closeTo(41.0278, 0.001));
      expect(details.lng, closeTo(28.9738, 0.001));
    });

    test('resolveGoogleMapsUrl resolves full Google Maps browser URL instantly', () async {
      const fullUrl =
          'https://www.google.com/maps/place/Galata+Tantuni+%26+k%C3%BCnefe/@41.0271473,28.9702217,15.79z/data=!4m6!3m5!1s0x14cab9ba43533c3f:0xffcfb91435c4dccf!8m2!3d41.0278679!4d28.9738275!16s%2Fg%2F11qpkckrg1';
      final details = await MapsResolver.resolveGoogleMapsUrl(fullUrl);
      expect(details, isNotNull);
      expect(details!.placeName, 'Galata Tantuni & künefe');
      expect(details.lat, closeTo(41.0278, 0.001));
      expect(details.lng, closeTo(28.9738, 0.001));
    });
  });
}
