// Privacy-critical: signing in as a different account on the same device must
// leave NO trace of the previous account — not their attempts, not their
// private reflection notes, not their custom rungs, not their streak.
//
// The shared, non-personal content (tracks + seeded rungs) must survive, or the
// next account opens an empty app.
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

  /// Account A uses the app: clears a rung (with a private note) and writes a
  /// custom rung of their own.
  Future<String> seedAccountA() async {
    final ladder = await tracks.getLadder('trk_speaking');
    final started = await attempts.startChallenge(
      rungId: ladder.first.id,
      predictedSuds: 8,
      predictedNote: 'they will judge me',
    );
    await attempts.completeChallenge(
      attemptId: started.id,
      actualSuds: 3,
      outcome: Outcome.done,
      reflectionNote: 'it was fine, nobody noticed',
    );
    final custom = await tracks.addCustomRung(
      trackId: 'trk_speaking',
      title: 'Ask my manager for a raise',
      whatToDo: '',
      whyItHelps: '',
      difficulty: 7,
    );
    return custom.id;
  }

  test('account A really did leave data behind (guards the test itself)',
      () async {
    await seedAccountA();
    expect(await attempts.getRecentAttempts(), isNotEmpty);
    expect(await progress.totalRungsCleared(), greaterThan(0));
  });

  test('a switch wipes the previous account attempts and notes', () async {
    await seedAccountA();
    db.resetUserData();

    expect(await attempts.getRecentAttempts(), isEmpty,
        reason: 'account B must not see account A history');

    // The private note text lived on the attempt row — it must be gone with it.
    final rows = db.select("SELECT COUNT(*) AS n FROM attempts;");
    expect(rows.first['n'], 0);
  });

  test('a switch removes the previous account custom rungs', () async {
    final customId = await seedAccountA();
    db.resetUserData();

    final ladder = await tracks.getLadder('trk_speaking');
    expect(ladder.any((r) => r.id == customId), isFalse,
        reason: 'account B must not inherit account A private rung');
  });

  test('a switch resets streak and progress to zero', () async {
    await seedAccountA();
    expect(await progress.totalRungsCleared(), greaterThan(0));

    db.resetUserData();

    expect(await progress.currentStreak(), 0);
    expect(await progress.totalRungsCleared(), 0);

    final p = db.select(
      "SELECT rungs_cleared, streak, current_rung_id, last_activity_day "
      "FROM user_track_progress WHERE track_id = 'trk_speaking';",
    ).first;
    expect(p['rungs_cleared'], 0);
    expect(p['streak'], 0);
    expect(p['current_rung_id'], isNull);
    expect(p['last_activity_day'], isNull);
  });

  test('a switch keeps the shared content — B does not open an empty app',
      () async {
    await seedAccountA();
    db.resetUserData();

    expect((await tracks.getTracks()).length, 6);
    expect((await tracks.getLadder('trk_speaking')).length, 10,
        reason: 'seeded rungs are shared content, not account A data');
  });

  test('account B can start fresh and its data is its own', () async {
    await seedAccountA();
    db.resetUserData();

    final ladder = await tracks.getLadder('trk_speaking');
    final started = await attempts.startChallenge(
      rungId: ladder.first.id,
      predictedSuds: 4,
    );
    await attempts.completeChallenge(
      attemptId: started.id,
      actualSuds: 2,
      outcome: Outcome.done,
    );

    final all = await attempts.getRecentAttempts();
    expect(all.length, 1, reason: 'only account B attempt exists');
    expect(all.first.predictedSuds, 4);
  });

  test('resetUserData is idempotent', () async {
    await seedAccountA();
    db.resetUserData();
    db.resetUserData(); // must not throw or corrupt anything
    expect(await attempts.getRecentAttempts(), isEmpty);
    expect((await tracks.getTracks()).length, 6);
  });
}
