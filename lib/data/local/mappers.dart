import 'package:sqlite3/sqlite3.dart';

import '../../domain/entities/attempt.dart';
import '../../domain/entities/rung.dart';
import '../../domain/entities/track.dart';
import '../../domain/entities/user_progress.dart';

/// Row → entity mappers shared by the local repositories.
Track trackFromRow(Row r) => Track(
      id: r['id'] as String,
      slug: r['slug'] as String,
      title: r['title'] as String,
      description: r['description'] as String,
      icon: r['icon'] as String,
      sortOrder: r['sort_order'] as int,
      colorSeed: r['color_seed'] as String,
    );

Rung rungFromRow(Row r) => Rung(
      id: r['id'] as String,
      trackId: r['track_id'] as String,
      title: r['title'] as String,
      whatToDo: r['what_to_do'] as String,
      whyItHelps: r['why_it_helps'] as String,
      difficulty: r['difficulty'] as int,
      sortOrder: r['sort_order'] as int,
      isCustom: (r['is_custom'] as int) == 1,
      ownerId: r['owner_id'] as String?,
      estMinutes: r['est_minutes'] as int,
    );

Attempt attemptFromRow(Row r) => Attempt(
      id: r['id'] as String,
      rungId: r['rung_id'] as String,
      predictedSuds: r['predicted_suds'] as int,
      predictedNote: r['predicted_note'] as String?,
      actualSuds: r['actual_suds'] as int?,
      outcome: r['outcome'] == null
          ? null
          : OutcomeX.fromId(r['outcome'] as String),
      reflectionNote: r['reflection_note'] as String?,
      startedAt: _ms(r['started_at']),
      completedAt: _msOrNull(r['completed_at']),
      createdAt: _ms(r['created_at']),
      updatedAt: _ms(r['updated_at']),
    );

UserProgress progressFromRow(Row r) => UserProgress(
      trackId: r['track_id'] as String,
      currentRungId: r['current_rung_id'] as String?,
      rungsCleared: r['rungs_cleared'] as int,
      streak: r['streak'] as int,
      streakFreezesRemaining: r['streak_freezes_remaining'] as int,
      lastActivityDay: r['last_activity_day'] as String?,
    );

DateTime _ms(Object? v) =>
    DateTime.fromMillisecondsSinceEpoch(v as int);
DateTime? _msOrNull(Object? v) =>
    v == null ? null : DateTime.fromMillisecondsSinceEpoch(v as int);

/// Local day key (yyyy-mm-dd) for streak math.
String dayKey(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-'
    '${d.month.toString().padLeft(2, '0')}-'
    '${d.day.toString().padLeft(2, '0')}';
