// Core-loop integration test (§11.3): predict → reflect → clear → progress.
// Runs against the real local SQLite store (in-memory), exercising the
// repositories end-to-end without any UI.
import 'package:flutter_test/flutter_test.dart';
import 'package:rung/data/local/app_database.dart';
import 'package:rung/data/repositories/local_attempt_repository.dart';
import 'package:rung/data/repositories/local_progress_repository.dart';
import 'package:rung/data/repositories/local_track_repository.dart';
import 'package:rung/domain/entities/attempt.dart';

void main() {
  late AppDatabase db;
  late LocalTrackRepository tracks;
  late LocalAttemptRepository attempts;
  late LocalProgressRepository progress;

  setUp(() {
    db = AppDatabase.openInMemory();
    tracks = LocalTrackRepository(db);
    attempts = LocalAttemptRepository(db);
    progress = LocalProgressRepository(db);
  });

  tearDown(() => db.close());

  test('seeds 6 tracks with 10 rungs each', () async {
    final list = await tracks.getTracks();
    expect(list.length, 6);
    for (final t in list) {
      final ladder = await tracks.getLadder(t.id);
      expect(ladder.length, 10, reason: '${t.slug} should have 10 rungs');
    }
  });

  test('predict → reflect clears a rung and updates progress', () async {
    final ladder = await tracks.getLadder('trk_speaking');
    final first = ladder.first;

    final started = await attempts.startChallenge(
      rungId: first.id,
      predictedSuds: 8,
    );
    expect(started.isInProgress, isTrue);
    expect(await attempts.getInProgress(), isNotNull);

    final done = await attempts.completeChallenge(
      attemptId: started.id,
      actualSuds: 3,
      outcome: Outcome.done,
    );
    expect(done.isInProgress, isFalse);
    expect(done.predictionGap, 5); // 8 - 3

    final cleared = await attempts.getClearedRungIds();
    expect(cleared.contains(first.id), isTrue);

    final p = await progress.getProgress('trk_speaking');
    expect(p.rungsCleared, 1);
    expect(await progress.totalRungsCleared(), 1);
    expect(await progress.currentStreak(), 1);
  });

  test('skipped attempts are neutral — no clear, no streak', () async {
    final ladder = await tracks.getLadder('trk_assertiveness');
    final first = ladder.first;
    final started =
        await attempts.startChallenge(rungId: first.id, predictedSuds: 5);
    await attempts.completeChallenge(
      attemptId: started.id,
      actualSuds: 5,
      outcome: Outcome.skipped,
    );

    expect((await attempts.getClearedRungIds()).contains(first.id), isFalse);
    expect(await progress.totalRungsCleared(), 0);
    expect(await progress.currentStreak(), 0);
  });

  test("Today's Rung resumes an in-progress attempt first", () async {
    final ladder = await tracks.getLadder('trk_speaking');
    final started = await attempts.startChallenge(
        rungId: ladder.first.id, predictedSuds: 6);

    final suggestion = await progress.getTodaysRung();
    expect(suggestion, isNotNull);
    expect(suggestion!.inProgressAttempt?.id, started.id);
  });

  test('custom rung is added to the ladder', () async {
    final before = await tracks.getLadder('trk_visibility');
    await tracks.addCustomRung(
      trackId: 'trk_visibility',
      title: 'My own challenge',
      whatToDo: 'Do the thing',
      whyItHelps: 'Because I chose it',
      difficulty: 4,
    );
    final after = await tracks.getLadder('trk_visibility');
    expect(after.length, before.length + 1);
    expect(after.any((r) => r.isCustom && r.title == 'My own challenge'),
        isTrue);
  });
}
