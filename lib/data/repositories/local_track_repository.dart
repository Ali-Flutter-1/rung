import 'package:uuid/uuid.dart';

import '../../domain/entities/rung.dart';
import '../../domain/entities/track.dart';
import '../../domain/repositories/track_repository.dart';
import '../local/app_database.dart';
import '../local/mappers.dart';

class LocalTrackRepository implements TrackRepository {
  LocalTrackRepository(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();

  List<Track> _allTracks() => _db
      .select('SELECT * FROM tracks ORDER BY sort_order;')
      .map(trackFromRow)
      .toList();

  /// Custom rungs are always shown; seeded rungs are capped to the first
  /// [maxBase] by sort_order (the tier's depth limit). `null` = no cap.
  List<Rung> _ladder(String trackId, {int? maxBase}) {
    if (maxBase == null) {
      return _db
          .select(
            'SELECT * FROM rungs WHERE track_id = ? AND deleted_at IS NULL '
            'ORDER BY sort_order;',
            [trackId],
          )
          .map(rungFromRow)
          .toList();
    }
    return _db
        .select(
          'SELECT * FROM rungs WHERE track_id = ? AND deleted_at IS NULL '
          'AND (is_custom = 1 OR id IN ('
          '  SELECT id FROM rungs WHERE track_id = ? AND deleted_at IS NULL '
          '  AND is_custom = 0 ORDER BY sort_order LIMIT ?'
          ')) ORDER BY sort_order;',
          [trackId, trackId, maxBase],
        )
        .map(rungFromRow)
        .toList();
  }

  @override
  Future<List<Track>> getTracks() async => _allTracks();

  @override
  Stream<List<Track>> watchTracks() => _db.watch(_allTracks);

  @override
  Future<Track?> getTrack(String trackId) async {
    final rows = _db.select('SELECT * FROM tracks WHERE id = ?;', [trackId]);
    return rows.isEmpty ? null : trackFromRow(rows.first);
  }

  @override
  Future<List<Rung>> getLadder(String trackId, {int? maxBaseRungs}) async =>
      _ladder(trackId, maxBase: maxBaseRungs);

  @override
  Stream<List<Rung>> watchLadder(String trackId, {int? maxBaseRungs}) =>
      _db.watch(() => _ladder(trackId, maxBase: maxBaseRungs));

  @override
  Future<Rung?> getRung(String rungId) async {
    final rows = _db.select('SELECT * FROM rungs WHERE id = ?;', [rungId]);
    return rows.isEmpty ? null : rungFromRow(rows.first);
  }

  @override
  Future<int> customRungCount() async => _db
      .select(
        'SELECT COUNT(*) AS n FROM rungs '
        'WHERE is_custom = 1 AND deleted_at IS NULL;',
      )
      .first['n'] as int;

  @override
  Future<int> customRungCountSince(int sinceMs) async => _db
      .select(
        'SELECT COUNT(*) AS n FROM rungs '
        'WHERE is_custom = 1 AND deleted_at IS NULL AND updated_at >= ?;',
        [sinceMs],
      )
      .first['n'] as int;

  @override
  Future<Rung> addCustomRung({
    required String trackId,
    required String title,
    required String whatToDo,
    required String whyItHelps,
    required int difficulty,
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now().millisecondsSinceEpoch;
    final nextOrder = _db
        .select(
          'SELECT COALESCE(MAX(sort_order), 0) + 1 AS n FROM rungs '
          'WHERE track_id = ?;',
          [trackId],
        )
        .first['n'] as int;
    _db.transaction(() {
      _db.run(
        'INSERT INTO rungs (id, track_id, title, what_to_do, why_it_helps, '
        'difficulty, sort_order, is_custom, owner_id, est_minutes, updated_at) '
        'VALUES (?, ?, ?, ?, ?, ?, ?, 1, ?, 2, ?);',
        [id, trackId, title, whatToDo, whyItHelps, difficulty, nextOrder,
            'local', now],
      );
    });
    return (await getRung(id))!;
  }

  @override
  Future<Rung?> recommendNextRung(String trackId) async {
    final rows = _db.select(
      "SELECT * FROM rungs WHERE track_id = ? AND deleted_at IS NULL "
      "AND id NOT IN (SELECT rung_id FROM attempts "
      "  WHERE outcome IN ('done','partial') AND deleted_at IS NULL) "
      "ORDER BY sort_order LIMIT 1;",
      [trackId],
    );
    return rows.isEmpty ? null : rungFromRow(rows.first);
  }
}
