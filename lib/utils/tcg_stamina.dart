import 'dart:math' as math;

/// Utility class for calculating and managing TCG pack recharge stamina.
///
/// Rules:
/// - 1 pack recharges every 12 hours (43,200 seconds).
/// - Maximum stored capacity is 2 packs (24 hours = 86,400 seconds).
/// - Stamina accumulates continuously: opening 1 pack deducts 12 hours of recharge time,
///   preserving any surplus progress towards the next pack.
class PackStamina {
  static const int packCooldownSeconds = 12 * 3600; // 43,200 seconds (12 hours)
  static const int maxPacks = 2;
  static const int maxCapacitySeconds = maxPacks * packCooldownSeconds; // 86,400 seconds (24 hours)

  /// Calculates the current pack stamina state based on the user's [lastPack] timestamp.
  ///
  /// Returns:
  /// - [availablePacks]: Number of packs ready to open (0, 1, or 2).
  /// - [timeToNextPack]: Duration remaining until the next pack is ready (Duration.zero if 2/2).
  /// - [progressToNextPack]: A 0.0 to 1.0 progress value towards the next pack.
  static ({int availablePacks, Duration timeToNextPack, double progressToNextPack})
      calculate(DateTime? lastPack) {
    if (lastPack == null) {
      // First-time player or no record: full stamina (2 packs ready)
      return (
        availablePacks: maxPacks,
        timeToNextPack: Duration.zero,
        progressToNextPack: 1.0,
      );
    }

    final now = DateTime.now().toUtc();
    final diffSeconds = now.difference(lastPack.toUtc()).inSeconds;

    if (diffSeconds <= 0) {
      return (
        availablePacks: 0,
        timeToNextPack: const Duration(seconds: packCooldownSeconds),
        progressToNextPack: 0.0,
      );
    }

    final clampedSeconds = diffSeconds.clamp(0, maxCapacitySeconds);
    final availablePacks = clampedSeconds ~/ packCooldownSeconds; // 0, 1, or 2

    if (availablePacks >= maxPacks) {
      return (
        availablePacks: maxPacks,
        timeToNextPack: Duration.zero,
        progressToNextPack: 1.0,
      );
    }

    final secondsIntoCurrentPack = clampedSeconds % packCooldownSeconds;
    final secondsRemaining = packCooldownSeconds - secondsIntoCurrentPack;
    final progress = secondsIntoCurrentPack / packCooldownSeconds;

    return (
      availablePacks: availablePacks,
      timeToNextPack: Duration(seconds: secondsRemaining),
      progressToNextPack: progress,
    );
  }

  /// Calculates the new [last_pack] timestamp to store in Supabase when 1 pack is consumed.
  ///
  /// Deducts 12 hours of accumulated stamina, keeping surplus progress towards the next pack.
  static DateTime consumePack(DateTime? lastPack) {
    final now = DateTime.now().toUtc();
    if (lastPack == null) {
      // User had full stamina (2 packs). After consuming 1, they have 1 pack left.
      // 1 pack left means 12 hours of stamina currently accumulated.
      return now.subtract(const Duration(seconds: packCooldownSeconds));
    }

    final diffSeconds = now.difference(lastPack.toUtc()).inSeconds;
    final clampedSeconds = diffSeconds.clamp(0, maxCapacitySeconds);

    // Deduct 1 pack (12 hours)
    final remainingStaminaSeconds =
        math.max(0, clampedSeconds - packCooldownSeconds);

    return now.subtract(Duration(seconds: remainingStaminaSeconds));
  }

  /// Formats a [Duration] into HH:MM:SS or MM:SS string.
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    final hoursStr = hours.toString().padLeft(2, '0');
    return '$hoursStr:$minutes:$seconds';
  }
}

/// Helper class for managing valid TCG cards in Kebabbo.
///
/// Exactly 22 kebabs have card graphic assets in `assets/kebab-card/`.
/// In Supabase, ID 10 (Bella Istanbul 3) has an asset but has_card is false in DB,
/// while ID 16 (Murgulet Kebab) has has_card true in DB but no asset exists.
class TcgCardsHelper {
  static const Set<int> validCardIds = {
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 17, 18, 19, 20, 21, 22, 23
  };

  static bool isValidCard(int id, [bool? hasCard]) {
    if (id == 10) return true; // Bella Istanbul 3 (asset exists)
    if (id == 16) return false; // Murgulet Kebab (no asset)
    return hasCard == true || validCardIds.contains(id);
  }

  static int get totalCardsCount => validCardIds.length; // 22

  static int countCollected(List<dynamic> userTcgList) {
    return userTcgList
        .map((id) => int.tryParse(id.toString()))
        .where((id) => id != null && validCardIds.contains(id))
        .toSet()
        .length;
  }
}

