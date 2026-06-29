import 'package:uuid/uuid.dart';

import '../../domain/entities/attempt.dart';
import '../../domain/entities/prediction_gap.dart';
import '../../domain/repositories/attempt_repository.dart';
import '../local/app_database.dart';
import '../local/mappers.dart';

class LocalAttemptRepository implements AttemptRepository {
  LocalAttemptRepository(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();

  @override
  Future<Attempt> startChallenge({
    required String rungId,
    required int predictedSuds,
    String? predictedNote,
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now().millisecondsSinceEpoch;
    _db.transaction(() {
      _db.run(
        'INSERT INTO attempts (id, rung_id, predicted_suds, predicted_note, '
        'started_at, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?);',
        [id, rungId, predictedSuds, predictedNote, now, now, now],
      );
    });
    return (await getAttempt(id))!;
  }

  @override
  Future<Attempt> completeChallenge({
    required String attemptId,
    required int actualSuds,
    required Outcome outcome,
    String? reflectionNote,
  }) async {
    final now = DateTime.now();
    final nowMs = now.millisecondsSinceEpoch;
    _db.transaction(() {
      _db.run(
        'UPDATE attempts SET actual_suds = ?, outcome = ?, reflection_note = ?, '
        'completed_at = ?, updated_at = ? WHERE id = ?;',
        [actualSuds, outcome.id, reflectionNote, nowMs, nowMs, attemptId],
      );
      if (outcome.counts) {
        _recalcProgressForAttempt(attemptId, now);
      }
    });
    return (await getAttempt(attemptId))!;
  }

  /// Recomputes cached progress for the attempt's track after a counting log.
  void _recalcProgressForAttempt(String attemptId, DateTime now) {
    final trackRows = _db.select(
      'SELECT r.track_id AS track_id FROM attempts a '
      'JOIN rungs r ON r.id = a.rung_id WHERE a.id = ?;',
      [attemptId],
    );
    if (trackRows.isEmpty) return;
    final trackId = trackRows.first['track_id'] as String;

    final cleared = _db.select(
      "SELECT COUNT(DISTINCT a.rung_id) AS n FROM attempts a "
      "JOIN rungs r ON r.id = a.rung_id "
      "WHERE r.track_id = ? AND a.outcome IN ('done','partial') "
      "AND a.deleted_at IS NULL;",
      [trackId],
    ).first['n'] as int;

    final nextRows = _db.select(
      "SELECT id FROM rungs WHERE track_id = ? AND deleted_at IS NULL "
      "AND id NOT IN (SELECT rung_id FROM attempts "
      "  WHERE outcome IN ('done','partial') AND deleted_at IS NULL) "
      "ORDER BY sort_order LIMIT 1;",
      [trackId],
    );
    final nextRungId = nextRows.isEmpty ? null : nextRows.first['id'] as String;

    _db.run(
      'UPDATE user_track_progress SET rungs_cleared = ?, current_rung_id = ?, '
      'last_activity_day = ?, updated_at = ? WHERE track_id = ?;',
      [cleared, nextRungId, dayKey(now), now.millisecondsSinceEpoch, trackId],
    );
  }

  @override
  Future<Attempt?> getAttempt(String attemptId) async {
    final rows = _db.select(
      'SELECT * FROM attempts WHERE id = ? AND deleted_at IS NULL;',
      [attemptId],
    );
    return rows.isEmpty ? null : attemptFromRow(rows.first);
  }

  Attempt? _inProgress() {
    final rows = _db.select(
      'SELECT * FROM attempts WHERE completed_at IS NULL AND deleted_at IS NULL '
      'ORDER BY started_at DESC LIMIT 1;',
    );
    return rows.isEmpty ? null : attemptFromRow(rows.first);
  }

  @override
  Future<Attempt?> getInProgress() async => _inProgress();

  @override
  Stream<Attempt?> watchInProgress() => _db.watch(_inProgress);

  @override
  Future<List<Attempt>> getAttemptsForRung(String rungId) async => _db
      .select(
        'SELECT * FROM attempts WHERE rung_id = ? AND deleted_at IS NULL '
        'ORDER BY created_at DESC;',
        [rungId],
      )
      .map(attemptFromRow)
      .toList();

  List<Attempt> _recent(int limit) => _db
      .select(
        'SELECT * FROM attempts WHERE deleted_at IS NULL '
        'ORDER BY created_at DESC LIMIT ?;',
        [limit],
      )
      .map(attemptFromRow)
      .toList();

  @override
  Future<List<Attempt>> getRecentAttempts({int limit = 50}) async =>
      _recent(limit);

  @override
  Stream<List<Attempt>> watchRecentAttempts({int limit = 50}) =>
      _db.watch(() => _recent(limit));

  @override
  Future<GapSeries> getPredictionGap(GapRange range) async {
    final cutoff = switch (range) {
      GapRange.last7 =>
        DateTime.now().subtract(const Duration(days: 7)).millisecondsSinceEpoch,
      GapRange.last30 =>
        DateTime.now().subtract(const Duration(days: 30)).millisecondsSinceEpoch,
      GapRange.all => 0,
    };
    final rows = _db.select(
      'SELECT completed_at, predicted_suds, actual_suds FROM attempts '
      'WHERE actual_suds IS NOT NULL AND completed_at IS NOT NULL '
      'AND deleted_at IS NULL AND completed_at >= ? '
      'ORDER BY completed_at ASC;',
      [cutoff],
    );
    if (rows.isEmpty) return GapSeries.empty;
    final points = rows
        .map((r) => GapPoint(
              date: DateTime.fromMillisecondsSinceEpoch(r['completed_at'] as int),
              predicted: r['predicted_suds'] as int,
              actual: r['actual_suds'] as int,
            ))
        .toList();
    final avgP = points.map((p) => p.predicted).reduce((a, b) => a + b) /
        points.length;
    final avgA =
        points.map((p) => p.actual).reduce((a, b) => a + b) / points.length;
    return GapSeries(points: points, avgPredicted: avgP, avgActual: avgA);
  }

  Set<String> _clearedRungIds() => _db
      .select(
        "SELECT DISTINCT rung_id FROM attempts "
        "WHERE outcome IN ('done','partial') AND deleted_at IS NULL;",
      )
      .map((r) => r['rung_id'] as String)
      .toSet();

  @override
  Future<Set<String>> getClearedRungIds() async => _clearedRungIds();

  @override
  Stream<Set<String>> watchClearedRungIds() => _db.watch(_clearedRungIds);
}
