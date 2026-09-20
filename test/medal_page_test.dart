import 'package:flutter_test/flutter_test.dart';
import 'package:kebabbo_flutter/pages/misc/medal_page.dart';

void main() {
  group('Medal System Tests', () {
    test('allMedalsList contains 9 correctly configured medals', () {
      expect(allMedalsList.length, 9);

      final reviewMedals =
          allMedalsList.where((m) => m.category == 'reviews').toList();
      final postMedals =
          allMedalsList.where((m) => m.category == 'posts').toList();

      expect(reviewMedals.length, 5);
      expect(postMedals.length, 4);

      // Verify IDs are unique and 0..8
      final ids = allMedalsList.map((m) => m.id).toSet();
      expect(ids.length, 9);
      for (int i = 0; i < 9; i++) {
        expect(ids.contains(i), isTrue);
      }

      // Verify review thresholds
      expect(reviewMedals[0].requiredCount, 1);
      expect(reviewMedals[1].requiredCount, 5);
      expect(reviewMedals[2].requiredCount, 10);
      expect(reviewMedals[3].requiredCount, 20);
      expect(reviewMedals[4].requiredCount, 30);

      // Verify post thresholds
      expect(postMedals[0].requiredCount, 1);
      expect(postMedals[1].requiredCount, 5);
      expect(postMedals[2].requiredCount, 10);
      expect(postMedals[3].requiredCount, 50);

      // Verify non-empty assets and descriptions
      for (final medal in allMedalsList) {
        expect(medal.title.isNotEmpty, isTrue);
        expect(medal.subtitle.isNotEmpty, isTrue);
        expect(medal.description.isNotEmpty, isTrue);
        expect(medal.assetPath.endsWith('.png'), isTrue);
      }
    });
  });
}
