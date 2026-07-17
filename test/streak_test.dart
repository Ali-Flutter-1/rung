// Streak + freeze logic. The streak is the app's headline number, so an
// off-by-one here is very visible to the user.
//
// Attempts are inserted directly with controlled completed_at timestamps so we
// can place activity on exact calendar days. Timestamps are taken at NOON of
// the target day (via calendar arithmetic, not 24h subtraction) so the test
// itself can't drift across a daylight-saving boundary.
import 'package:flutter_test/flutter_test.dart';
import 'package:rung/data/local/app_database.dart';
import 'package:rung/data/repositories/local_progress_repository.dart';
import 'package:rung/data/repositories/local_track_repository.dart';

void main() {
  late AppDatabase db;
  late LocalTrackRepository tracks;
  late LocalProgressRepository progress;
  late String rungId;

  setUp(() async {
    db = AppDatabase.openInMemory();
    tracks = LocalTrackRepository(db);
    progress = LocalProgressRepository(db);
    rungId = (await tracks.getLadder('trk_speaking')).first.id;
  });

  tearDown(() => db.close());

  /// Noon, [daysAgo] calendar days back. DateTime normalises a negative day.
  int noonDaysAgo(int daysAgo) {
    final n = DateTime.now();
    return DateTime(n.year, n.month, n.day - daysAgo, 12).millisecondsSinceEpoch;
  }

  var seq = 0;
  void logAttemptAtMs(int ms, {String outcome = 'done'}) {
    db.run(
      'INSERT INTO attempts (id, rung_id, predicted_suds, actual_suds, outcome, '
      'started_at, completed_at, created_at, updated_at) '
      'VALUES (?, ?, 7, 3, ?, ?, ?, ?, ?);',
      ['a${seq++}', rungId, outcome, ms, ms, ms, ms],
    );
  }

  void logAttempt({required int daysAgo, String outcome = 'done'}) =>
      logAttemptAtMs(noonDaysAgo(daysAgo), outcome: outcome);

  group('currentStreak', () {
    test('no activity → 0', () async {
      expect(await progress.currentStreak(), 0);
    });

    test('done today → 1', () async {
      logAttempt(daysAgo: 0);
      expect(await progress.currentStreak(), 1);
    });

    test('today + yesterday → 2', () async {
      logAttempt(daysAgo: 0);
      logAttempt(daysAgo: 1);
      expect(await progress.currentStreak(), 2);
    });

    test('five consecutive days → 5', () async {
      for (var i = 0; i < 5; i++) {
        logAttempt(daysAgo: i);
      }
      expect(await progress.currentStreak(), 5);
    });

    test('yesterday but not today → 1 (the streak is still alive)', () async {
      logAttempt(daysAgo: 1);
      expect(await progress.currentStreak(), 1,
          reason: 'you have not missed today until today is over');
    });

    test('nothing today or yesterday → 0 (broken)', () async {
      logAttempt(daysAgo: 2);
      logAttempt(daysAgo: 3);
      expect(await progress.currentStreak(), 0);
    });

    test('a gap stops the count', () async {
      logAttempt(daysAgo: 0);
      logAttempt(daysAgo: 1);
      // no day 2
      logAttempt(daysAgo: 3);
      logAttempt(daysAgo: 4);
      expect(await progress.currentStreak(), 2, reason: 'stops at the gap');
    });

    test('several attempts on one day still count as one day', () async {
      logAttempt(daysAgo: 0);
      logAttempt(daysAgo: 0);
      logAttempt(daysAgo: 0);
      expect(await progress.currentStreak(), 1);
    });
  });

  group('what counts', () {
    test('partial counts toward the streak', () async {
      logAttempt(daysAgo: 0, outcome: 'partial');
      expect(await progress.currentStreak(), 1);
    });

    test('skipped is neutral — it does not build a streak', () async {
      logAttempt(daysAgo: 0, outcome: 'skipped');
      expect(await progress.currentStreak(), 0,
          reason: 'skipping must never be punished, but it is not progress');
    });

    test('a skipped day does not bridge a gap', () async {
      logAttempt(daysAgo: 0);
      logAttempt(daysAgo: 1, outcome: 'skipped');
      logAttempt(daysAgo: 2);
      expect(await progress.currentStreak(), 1,
          reason: 'the skipped day is not active, so the run stops');
    });
  });

  group('bestStreak', () {
    test('remembers the longest past run, not the current one', () async {
      // A 4-day run a while back...
      for (var i = 10; i < 14; i++) {
        logAttempt(daysAgo: i);
      }
      // ...and a shorter current one.
      logAttempt(daysAgo: 0);

      expect(await progress.currentStreak(), 1);
      expect(await progress.bestStreak(), 4);
    });

    test('no activity → 0', () async {
      expect(await progress.bestStreak(), 0);
    });

    test('best is never less than current', () async {
      for (var i = 0; i < 3; i++) {
        logAttempt(daysAgo: i);
      }
      expect(await progress.bestStreak(),
          greaterThanOrEqualTo(await progress.currentStreak()));
    });
  });

  // Date-only maths must not run in the local zone, where a daylight-saving day
  // is 23 or 25 hours. These pin real transition dates, so they exercise the
  // boundary that the `now`-relative tests above can never reach.
  //
  // Run with `TZ=Europe/Berlin flutter test` to see them bite: with local-time
  // maths the 23-hour spring-forward gap truncates to 0 days, so the middle day
  // counts as neither consecutive nor a break and the run is silently short.
  group('daylight saving', () {
    /// Noon on a given calendar day — safely inside the day in any zone.
    void logOn(int year, int month, int day) =>
        logAttemptAtMs(DateTime(year, month, day, 12).millisecondsSinceEpoch);

    test('a run spanning the EU spring-forward counts every day', () async {
      // Clocks jump 02:00 → 03:00 on Sun 29 Mar 2026.
      logOn(2026, 3, 28);
      logOn(2026, 3, 29);
      logOn(2026, 3, 30);
      expect(await progress.bestStreak(), 3,
          reason: 'losing an hour must not lose a day');
    });

    test('a run spanning the EU autumn fall-back counts every day', () async {
      // Clocks go back 03:00 → 02:00 on Sun 25 Oct 2026.
      logOn(2026, 10, 24);
      logOn(2026, 10, 25);
      logOn(2026, 10, 26);
      expect(await progress.bestStreak(), 3,
          reason: 'gaining an hour must not double-count or drop a day');
    });

    test('a run spanning the US spring-forward counts every day', () async {
      // US clocks jump forward on Sun 8 Mar 2026.
      logOn(2026, 3, 7);
      logOn(2026, 3, 8);
      logOn(2026, 3, 9);
      expect(await progress.bestStreak(), 3);
    });

    test('a longer run across a transition is fully counted', () async {
      for (var d = 26; d <= 31; d++) {
        logOn(2026, 3, d); // 26th–31st, spanning the 29th
      }
      expect(await progress.bestStreak(), 6);
    });

    test('a real gap next to a transition is still a gap', () async {
      logOn(2026, 3, 28);
      logOn(2026, 3, 29);
      // 30th missing — this break must survive the fix, not be papered over.
      logOn(2026, 3, 31);
      expect(await progress.bestStreak(), 2);
    });
  });

  group('streak freeze', () {
    test('freezing yesterday keeps a streak alive across a missed day',
        () async {
      logAttempt(daysAgo: 0); // today
      // nothing yesterday
      logAttempt(daysAgo: 2);
      logAttempt(daysAgo: 3);
      expect(await progress.currentStreak(), 1, reason: 'gap at yesterday');

      final ok = await progress.applyStreakFreeze('trk_speaking');
      expect(ok, isTrue);

      expect(await progress.currentStreak(), 4,
          reason: 'the frozen day bridges today back to the earlier run');
    });

    test('a freeze is spent — the allowance runs out', () async {
      logAttempt(daysAgo: 0);
      logAttempt(daysAgo: 2);

      expect(await progress.applyStreakFreeze('trk_speaking'), isTrue);
      // Free tier allows 1/week, so a second freeze in the same week fails.
      expect(await progress.applyStreakFreeze('trk_speaking'), isFalse,
          reason: 'the weekly allowance is spent');
    });

    test('autoProtectStreak rescues a streak about to break', () async {
      logAttempt(daysAgo: 2); // the run
      logAttempt(daysAgo: 3);
      // nothing yesterday, nothing today → streak already reads 0
      expect(await progress.currentStreak(), 0);

      await progress.autoProtectStreak(weeklyAllowance: 1);

      // Yesterday is frozen, so the streak is alive again anchored on yesterday.
      expect(await progress.currentStreak(), 3);
    });

    test('autoProtectStreak does nothing when yesterday was active', () async {
      logAttempt(daysAgo: 0);
      logAttempt(daysAgo: 1);
      await progress.autoProtectStreak(weeklyAllowance: 1);

      // Still 2 — and no freeze was wasted.
      expect(await progress.currentStreak(), 2);
      expect(await progress.applyStreakFreeze('trk_speaking'), isTrue,
          reason: 'the allowance should be untouched');
    });

    test('autoProtectStreak does nothing when there is no streak to save',
        () async {
      // Nothing anywhere — no live run, so no freeze should be spent.
      await progress.autoProtectStreak(weeklyAllowance: 1);
      expect(await progress.currentStreak(), 0);
      expect(await progress.applyStreakFreeze('trk_speaking'), isTrue,
          reason: 'the allowance should be untouched');
    });
  });
}
