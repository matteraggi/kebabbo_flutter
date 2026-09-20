import 'package:flutter_test/flutter_test.dart';
import 'package:kebabbo_flutter/utils/tcg_stamina.dart';

void main() {
  group('PackStamina tests', () {
    test('New user (null lastPack) has 2/2 packs ready', () {
      final stamina = PackStamina.calculate(null);
      expect(stamina.availablePacks, 2);
      expect(stamina.timeToNextPack, Duration.zero);
      expect(stamina.progressToNextPack, 1.0);
    });

    test('User opened pack 3 hours ago: 0 packs available, 9 hours to next', () {
      final threeHoursAgo = DateTime.now().toUtc().subtract(const Duration(hours: 3));
      final stamina = PackStamina.calculate(threeHoursAgo);
      expect(stamina.availablePacks, 0);
      expect(stamina.timeToNextPack.inMinutes, closeTo(9 * 60, 2));
      expect(stamina.progressToNextPack, closeTo(3 / 12, 0.05));
    });

    test('User opened pack 14 hours ago: 1 pack available, 10 hours to 2nd pack', () {
      final fourteenHoursAgo = DateTime.now().toUtc().subtract(const Duration(hours: 14));
      final stamina = PackStamina.calculate(fourteenHoursAgo);
      expect(stamina.availablePacks, 1);
      expect(stamina.timeToNextPack.inMinutes, closeTo(10 * 60, 2));
      expect(stamina.progressToNextPack, closeTo(2 / 12, 0.05));
    });

    test('User opened pack 30 hours ago: capped at 2/2 packs ready', () {
      final thirtyHoursAgo = DateTime.now().toUtc().subtract(const Duration(hours: 30));
      final stamina = PackStamina.calculate(thirtyHoursAgo);
      expect(stamina.availablePacks, 2);
      expect(stamina.timeToNextPack, Duration.zero);
      expect(stamina.progressToNextPack, 1.0);
    });

    test('Consuming 1 pack when at 2/2 leaves 1 pack available with 12h to next', () {
      final thirtyHoursAgo = DateTime.now().toUtc().subtract(const Duration(hours: 30));
      final newLastPack = PackStamina.consumePack(thirtyHoursAgo);
      final stamina = PackStamina.calculate(newLastPack);
      expect(stamina.availablePacks, 1);
      expect(stamina.timeToNextPack.inMinutes, closeTo(12 * 60, 2));
    });

    test('Consuming 1 pack when at 14h preserves surplus 2h progress towards next pack', () {
      final fourteenHoursAgo = DateTime.now().toUtc().subtract(const Duration(hours: 14));
      final newLastPack = PackStamina.consumePack(fourteenHoursAgo);
      final stamina = PackStamina.calculate(newLastPack);
      expect(stamina.availablePacks, 0);
      expect(stamina.timeToNextPack.inMinutes, closeTo(10 * 60, 2));
    });

    test('Format duration handles hours, minutes, seconds', () {
      expect(PackStamina.formatDuration(const Duration(hours: 11, minutes: 42, seconds: 9)), '11:42:09');
      expect(PackStamina.formatDuration(const Duration(minutes: 5, seconds: 20)), '00:05:20');
    });
  });

  group('TcgCardsHelper tests', () {
    test('Total cards count is exactly 22', () {
      expect(TcgCardsHelper.totalCardsCount, 22);
      expect(TcgCardsHelper.validCardIds.length, 22);
    });

    test('Bella Istanbul 3 (ID 10) is valid even though DB has has_card: false', () {
      expect(TcgCardsHelper.isValidCard(10, false), isTrue);
    });

    test('Murgulet Kebab (ID 16) is invalid because it has no image asset', () {
      expect(TcgCardsHelper.isValidCard(16, true), isFalse);
    });

    test('countCollected ignores invalid IDs and duplicates', () {
      // 1, 2, 3 are valid, 10 is valid, 16 is invalid, 999 is invalid, duplicates of 1 and 2
      final rawTcg = [1, 1, 2, 3, 10, 16, 999, 2];
      expect(TcgCardsHelper.countCollected(rawTcg), 4);
    });
  });
}
