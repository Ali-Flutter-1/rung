import 'attempt.dart';
import 'rung.dart';
import 'track.dart';

/// Why a rung was chosen for Today (drives the card's framing) (§8.1).
enum TodayReason {
  resumeInProgress,
  nextInActiveTrack,
  varietyFromOtherTrack,
  freshStart,
}

/// The single curated rung for the Today surface, plus its context.
class TodaySuggestion {
  const TodaySuggestion({
    required this.rung,
    required this.track,
    required this.reason,
    this.inProgressAttempt,
  });

  final Rung rung;
  final Track track;
  final TodayReason reason;

  /// Set when [reason] is [TodayReason.resumeInProgress].
  final Attempt? inProgressAttempt;
}

/// A rung paired with its parent track (used by Today + history surfaces).
class RungWithTrack {
  const RungWithTrack({required this.rung, required this.track});
  final Rung rung;
  final Track track;
}
