import '../entities/attempt.dart';
import '../entities/prediction_gap.dart';

/// Time window for insight aggregation.
enum GapRange { last7, last30, all }

/// The core-loop data seam: predict → reflect → result (§12.3).
abstract interface class AttemptRepository {
  /// Creates an in-progress Attempt holding the prediction (§2.5 StartChallenge).
  Future<Attempt> startChallenge({
    required String rungId,
    required int predictedSuds,
    String? predictedNote,
  });

  /// Finalizes an Attempt and updates progress (§2.5 CompleteChallenge).
  Future<Attempt> completeChallenge({
    required String attemptId,
    required int actualSuds,
    required Outcome outcome,
    String? reflectionNote,
  });

  /// The single open (un-reflected) attempt, if any — drives resume banner.
  Future<Attempt?> getInProgress();
  Stream<Attempt?> watchInProgress();

  Future<Attempt?> getAttempt(String attemptId);

  /// All attempts for a rung, newest first (builds the data series).
  Future<List<Attempt>> getAttemptsForRung(String rungId);

  /// Recent attempts across all rungs, newest first.
  Future<List<Attempt>> getRecentAttempts({int limit = 50});

  Stream<List<Attempt>> watchRecentAttempts({int limit = 50});

  /// Predicted-vs-actual aggregate for the chart (§2.5 GetPredictionGap).
  Future<GapSeries> getPredictionGap(GapRange range);

  /// IDs of rungs that have at least one counting (done/partial) attempt.
  Future<Set<String>> getClearedRungIds();
  Stream<Set<String>> watchClearedRungIds();
}
