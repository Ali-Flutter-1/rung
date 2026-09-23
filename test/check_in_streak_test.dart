// The streak counts SHOWING UP, not completing an exposure step.
//
// Requiring a completed step made the daily habit conditional on the hardest
// thing the app asks for — impossible to sustain daily, and least possible on a
// bad day, which is exactly when an anxious user most needs the app to feel
// welcoming. A check-in takes five seconds and anyone can do it, so it is the
// streak's unit. Steps remain the separate depth metric.
import 'package:flutter_test/flutter_test.dart';
import 'package:rung/data/local/app_database.dart';
import 'package:rung/data/repositories/local_attempt_repository.dart';
import 'package:rung/data/repositories/local_progress_repository.dart';
import 'package:rung/data/repositories/local_track_repository.dart';
import 'package:rung/domain/entities/attempt.dart';

void main() {
  late AppDatabase db;
  late LocalProgressRepository progress;
  late LocalAttemptRepository attempts;
  late LocalTrackRepository tracks;

  setUp(() {
    db = AppDatabase.openInMemory();
    progress = LocalProgressRepository(db);
    attempts = LocalAttemptRepository(db);
    tracks = LocalTrackRepository(db);
  });

  tearDown(() => db.close());

  test('no activity at all means no streak', () async {
    expect(await progress.currentStreak(), 0);
    expect(await progress.hasCheckedInToday(), isFalse);
  });

  test('a check-in alone starts the streak — no step required', () async {
    await progress.recordCheckIn('Anxious');
    expect(await progress.currentStreak(), 1);
    expect(await progress.hasCheckedInToday(), isTrue);
  });

  test('checking in twice in a day counts once', () async {
    await progress.recordCheckIn('Low');
    await progress.recordCheckIn('Okay');
    expect(await progress.currentStreak(), 1);
    // The day is banked once; the first mood of the day is the one kept.
    final rows = db.select('SELECT day, mood FROM check_ins;');
    expect(rows.length, 1);
    expect(rows.first['mood'], 'Low');
  });

  test('a check-in day and a step day both count, and merge', () async {
    final ladder = await tracks.getLadder('trk_speaking');
    final started = await attempts.startChallenge(
      rungId: ladder.first.id,
      predictedSuds: 7,
    );
    await attempts.completeChallenge(
      attemptId: started.id,
      actualSuds: 3,
      outcome: Outcome.done,
    );
    // Same calendar day → still one active day, not two.
    await progress.recordCheckIn('Calm');
    expect(await progress.currentStreak(), 1);
    expect(await progress.totalRungsCleared(), 1);
  });

  test('the check-in day appears in the week strip', () async {
    await progress.recordCheckIn('Tense');
    final days = await progress.watchActiveDays().first;
    expect(days.length, 1);
  });

  test('steps still drive depth, which a check-in never inflates', () async {
    await progress.recordCheckIn('Okay');
    // Showing up keeps the streak alive but clears no rungs — the two metrics
    // must not be conflated, or "14 steps cleared" stops meaning anything.
    expect(await progress.currentStreak(), 1);
    expect(await progress.totalRungsCleared(), 0);
  });
}
