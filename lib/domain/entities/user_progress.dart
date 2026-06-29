/// Cached progress per track (§2.4). Derived from attempts but stored for speed.
class UserProgress {
  const UserProgress({
    required this.trackId,
    this.currentRungId,
    this.rungsCleared = 0,
    this.streak = 0,
    this.streakFreezesRemaining = 1,
    this.lastActivityDay,
  });

  final String trackId;
  final String? currentRungId;
  final int rungsCleared;
  final int streak;
  final int streakFreezesRemaining;

  /// Local day (yyyy-mm-dd) of the last counting attempt, for streak math.
  final String? lastActivityDay;

  UserProgress copyWith({
    String? currentRungId,
    int? rungsCleared,
    int? streak,
    int? streakFreezesRemaining,
    String? lastActivityDay,
  }) =>
      UserProgress(
        trackId: trackId,
        currentRungId: currentRungId ?? this.currentRungId,
        rungsCleared: rungsCleared ?? this.rungsCleared,
        streak: streak ?? this.streak,
        streakFreezesRemaining:
            streakFreezesRemaining ?? this.streakFreezesRemaining,
        lastActivityDay: lastActivityDay ?? this.lastActivityDay,
      );
}
