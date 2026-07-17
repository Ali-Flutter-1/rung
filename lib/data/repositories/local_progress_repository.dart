import '../../domain/entities/attempt.dart';
import '../../domain/entities/today_suggestion.dart';
import '../../domain/entities/user_progress.dart';
import '../../domain/repositories/progress_repository.dart';
import '../local/app_database.dart';
import '../local/mappers.dart';

class LocalProgressRepository implements ProgressRepository {
  LocalProgressRepository(this._db);

  final AppDatabase _db;

  // ── Progress 
  @override
  Future<UserProgress> getProgress(String trackId) async {
    final rows = _db.select(
      'SELECT * FROM user_track_progress WHERE track_id = ?;',
      [trackId],
    );
    return rows.isEmpty
        ? UserProgress(trackId: trackId)
        : progressFromRow(rows.first);
  }

  List<UserProgress> _allProgress() => _db
      .select('SELECT * FROM user_track_progress;')
      .map(progressFromRow)
      .toList();

  @override
  Future<List<UserProgress>> getAllProgress() async => _allProgress();

  @override
  Stream<List<UserProgress>> watchAllProgress() => _db.watch(_allProgress);

  int _totalCleared() => _db
      .select('SELECT COALESCE(SUM(rungs_cleared), 0) AS n '
          'FROM user_track_progress;')
      .first['n'] as int;

  @override
  Future<int> totalRungsCleared() async => _totalCleared();

  @override
  Stream<int> watchTotalRungsCleared() => _db.watch(_totalCleared);

  @override
  Stream<int> watchCurrentStreak() =>
      _db.watch(() => _streakFrom(_activeDayKeys(), DateTime.now()));

  @override
  Future<int> bestStreak() async => _bestStreakFrom(_activeDayKeys());

  @override
  Stream<int> watchBestStreak() =>
      _db.watch(() => _bestStreakFrom(_activeDayKeys()));

  @override
  Stream<Set<String>> watchActiveDays() => _db.watch(_activeDayKeys);

  /// Longest run of consecutive calendar days present in [dayKeys].
  int _bestStreakFrom(Set<String> dayKeys) {
    if (dayKeys.isEmpty) return 0;
    // Parse as UTC — a bare 'yyyy-MM-dd' parses to LOCAL midnight, and the gap
    // between two consecutive local midnights across a spring-forward is 23h,
    // which `.inDays` truncates to 0. The day then counts as neither
    // consecutive nor a break, silently shortening the best streak.
    final dates = dayKeys
        .map((k) => DateTime.tryParse('${k}T00:00:00Z'))
        .whereType<DateTime>()
        .toList()
      ..sort();
    var best = 1, run = 1;
    for (var i = 1; i < dates.length; i++) {
      final diff = dates[i].difference(dates[i - 1]).inDays;
      if (diff == 1) {
        run++;
        if (run > best) best = run;
      } else if (diff > 1) {
        run = 1;
      }
    }
    return best;
  }

  // ── Streak (global headline, §8.2) ────────────────────────────────────
  Set<String> _activeDayKeys() {
    final days = _db
        .select(
          "SELECT completed_at FROM attempts "
          "WHERE outcome IN ('done','partial') AND completed_at IS NOT NULL "
          "AND deleted_at IS NULL;",
        )
        .map((r) =>
            dayKey(DateTime.fromMillisecondsSinceEpoch(r['completed_at'] as int)))
        .toSet();
    days.addAll(_frozenDays());
    return days;
  }

  int _streakFrom(Set<String> days, DateTime now) {
    // Date-only stepping happens in UTC. The components come from the user's
    // LOCAL date (which is what _activeDayKeys records), but the arithmetic must
    // not run in a zone that observes daylight saving: there a day is 23 or 25
    // hours, so `subtract(days: 1)` shifts the wall clock and dayKey() lands on
    // the wrong calendar day — silently skipping one and under-counting the
    // streak. UTC has no DST, so every step is exactly one calendar day.
    final today = DateTime.utc(now.year, now.month, now.day);
    bool has(DateTime d) => days.contains(dayKey(d));
    DateTime cursor;
    if (has(today)) {
      cursor = today;
    } else if (has(today.subtract(const Duration(days: 1)))) {
      cursor = today.subtract(const Duration(days: 1));
    } else {
      return 0;
    }
    var streak = 0;
    while (has(cursor)) {
      streak++;
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return streak;
  }

  @override
  Future<int> currentStreak() async =>
      _streakFrom(_activeDayKeys(), DateTime.now());

  // ── Today's Rung (§8.1) ───────────────────────────────────────────────
  @override
  Future<TodaySuggestion?> getTodaysRung() async => _todaysRung();

  @override
  Stream<TodaySuggestion?> watchTodaysRung() => _db.watch(_todaysRung);

  TodaySuggestion? _todaysRung() {
    // Priority 1: resume any in-progress attempt.
    final inProg = _db.select(
      'SELECT * FROM attempts WHERE completed_at IS NULL AND deleted_at IS NULL '
      'ORDER BY started_at DESC LIMIT 1;',
    );
    if (inProg.isNotEmpty) {
      final attempt = attemptFromRow(inProg.first);
      final s = _suggestion(attempt.rungId, TodayReason.resumeInProgress,
          attempt: attempt);
      if (s != null) return s;
    }

    final hasAnyAttempt = (_db
            .select('SELECT COUNT(*) AS n FROM attempts '
                'WHERE deleted_at IS NULL;')
            .first['n'] as int) >
        0;

    // Build an ordered candidate list of (rungId, reason).
    final candidates = <MapEntry<String, TodayReason>>[];

    // Priority 2: next uncleared rung in the most active track.
    final activeTrack = _mostActiveTrackId();
    if (activeTrack != null) {
      final next = _nextUnclearedRung(activeTrack);
      if (next != null) {
        candidates.add(MapEntry(next, TodayReason.nextInActiveTrack));
      }
    }

    // Priority 3: a rung from an untouched track (variety).
    final untouched = _untouchedTrackId();
    if (untouched != null) {
      final next = _nextUnclearedRung(untouched);
      if (next != null) {
        candidates.add(MapEntry(next, TodayReason.varietyFromOtherTrack));
      }
    }

    // Fallback: the easiest uncleared rung anywhere (fresh start).
    final anyNext = _easiestUnclearedRungAnywhere();
    if (anyNext != null) {
      candidates.add(MapEntry(
        anyNext,
        hasAnyAttempt
            ? TodayReason.nextInActiveTrack
            : TodayReason.freshStart,
      ));
    }

    if (candidates.isEmpty) return null;

    // Never show the same rung two days running, if an alternative exists.
    final lastId = _db.meta('today_rung_id');
    final lastDay = _db.meta('today_rung_day');
    final today = dayKey(DateTime.now());
    MapEntry<String, TodayReason> chosen = candidates.first;
    if (lastId != null && lastDay != today && chosen.key == lastId) {
      final alt = candidates.firstWhere(
        (c) => c.key != lastId,
        orElse: () => candidates.first,
      );
      chosen = alt;
    }

    _db
      ..setMeta('today_rung_id', chosen.key)
      ..setMeta('today_rung_day', today);
    return _suggestion(chosen.key, chosen.value);
  }

  String? _mostActiveTrackId() {
    final rows = _db.select(
      'SELECT r.track_id AS track_id, COUNT(*) AS c FROM attempts a '
      'JOIN rungs r ON r.id = a.rung_id WHERE a.deleted_at IS NULL '
      'GROUP BY r.track_id ORDER BY c DESC, MAX(a.created_at) DESC LIMIT 1;',
    );
    return rows.isEmpty ? null : rows.first['track_id'] as String;
  }

  String? _untouchedTrackId() {
    final rows = _db.select(
      'SELECT id FROM tracks WHERE id NOT IN '
      '(SELECT DISTINCT r.track_id FROM attempts a '
      ' JOIN rungs r ON r.id = a.rung_id WHERE a.deleted_at IS NULL) '
      'ORDER BY sort_order LIMIT 1;',
    );
    return rows.isEmpty ? null : rows.first['id'] as String;
  }

  String? _nextUnclearedRung(String trackId) {
    final rows = _db.select(
      "SELECT id FROM rungs WHERE track_id = ? AND deleted_at IS NULL "
      "AND id NOT IN (SELECT rung_id FROM attempts "
      "  WHERE outcome IN ('done','partial') AND deleted_at IS NULL) "
      "ORDER BY sort_order LIMIT 1;",
      [trackId],
    );
    return rows.isEmpty ? null : rows.first['id'] as String;
  }

  String? _easiestUnclearedRungAnywhere() {
    final rows = _db.select(
      "SELECT id FROM rungs WHERE deleted_at IS NULL "
      "AND id NOT IN (SELECT rung_id FROM attempts "
      "  WHERE outcome IN ('done','partial') AND deleted_at IS NULL) "
      "ORDER BY difficulty, sort_order LIMIT 1;",
    );
    return rows.isEmpty ? null : rows.first['id'] as String;
  }

  TodaySuggestion? _suggestion(String rungId, TodayReason reason,
      {Attempt? attempt}) {
    final rungRows =
        _db.select('SELECT * FROM rungs WHERE id = ?;', [rungId]);
    if (rungRows.isEmpty) return null;
    final rung = rungFromRow(rungRows.first);
    final trackRows =
        _db.select('SELECT * FROM tracks WHERE id = ?;', [rung.trackId]);
    if (trackRows.isEmpty) return null;
    return TodaySuggestion(
      rung: rung,
      track: trackFromRow(trackRows.first),
      reason: reason,
      inProgressAttempt: attempt,
    );
  }

  // ── Streak freeze (§8.2) ──────────────────────────────────────────────
  static const _isoWeekKey = 'freeze_week';
  static const _remainingKey = 'freezes_remaining';
  static const _frozenDaysKey = 'frozen_days';

  Set<String> _frozenDays() {
    final raw = _db.meta(_frozenDaysKey);
    if (raw == null || raw.isEmpty) return {};
    return raw.split(',').where((s) => s.isNotEmpty).toSet();
  }

  int _freezesRemaining(DateTime now, [int allowance = 1]) {
    final week = _weekKey(now);
    if (_db.meta(_isoWeekKey) != week) {
      _db
        ..setMeta(_isoWeekKey, week)
        ..setMeta(_remainingKey, '$allowance'); // per-tier weekly saves (§8.2)
      return allowance;
    }
    return int.tryParse(_db.meta(_remainingKey) ?? '$allowance') ?? allowance;
  }

  @override
  Future<bool> applyStreakFreeze(String trackId) async {
    final now = DateTime.now();
    if (_freezesRemaining(now) <= 0) return false;
    // Freeze yesterday — the day that would otherwise break the streak.
    // Calendar arithmetic in UTC (see _streakFrom): DateTime normalises a day
    // of 0 or less into the previous month, and no DST can shift it.
    final missed = dayKey(DateTime.utc(now.year, now.month, now.day - 1));
    final frozen = _frozenDays()..add(missed);
    _db.transaction(() {
      _db
        ..setMeta(_frozenDaysKey, frozen.join(','))
        ..setMeta(_remainingKey, '${_freezesRemaining(now) - 1}');
    });
    return true;
  }

  /// Auto-protects a running streak from a single missed day, up to
  /// [weeklyAllowance] times per week (tier-based). Runs on app open: if
  /// yesterday was missed but the day before was active (so the streak is about
  /// to break) and a freeze remains, it freezes yesterday so the streak holds.
  @override
  Future<void> autoProtectStreak({required int weeklyAllowance}) async {
    final now = DateTime.now();
    // Calendar arithmetic in UTC (see _streakFrom) so a DST day can't shift
    // which calendar day we treat as "yesterday".
    final yKey = dayKey(DateTime.utc(now.year, now.month, now.day - 1));
    final beforeKey = dayKey(DateTime.utc(now.year, now.month, now.day - 2));
    final days = _activeDayKeys(); // already includes frozen days
    if (days.contains(yKey)) return; // yesterday already counts — nothing to do
    if (!days.contains(beforeKey)) return; // no live streak to protect
    final remaining = _freezesRemaining(now, weeklyAllowance);
    if (remaining <= 0) return;
    final frozen = _frozenDays()..add(yKey);
    _db.transaction(() {
      _db
        ..setMeta(_frozenDaysKey, frozen.join(','))
        ..setMeta(_remainingKey, '${remaining - 1}');
    });
  }

  String _weekKey(DateTime d) {
    // Simple ISO-ish week bucket: year + ordinal week. Good enough for resets.
    final firstDay = DateTime(d.year, 1, 1);
    final week = ((d.difference(firstDay).inDays + firstDay.weekday) / 7).ceil();
    return '${d.year}-W$week';
  }
}
