// Local SQLite schema invariants.
//
// v2/v3 briefly added a per-locale content cache (rung_i18n, track_i18n,
// content_locale_pref and the *_localized views). That was reverted — rung and
// track copy is English-only. v4 drops those objects if a dev build created
// them. These tests pin the resulting shape so the dead schema cannot creep
// back in unnoticed.
import 'package:flutter_test/flutter_test.dart';
import 'package:rung/data/local/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase.openInMemory());
  tearDown(() => db.close());

  int userVersion() =>
      db.select('PRAGMA user_version;').first.values.first as int;

  bool exists(String type, String name) => db.select(
        'SELECT 1 FROM sqlite_master WHERE type = ? AND name = ?;',
        [type, name],
      ).isNotEmpty;

  test('a freshly opened database is fully migrated', () {
    expect(AppDatabase.schemaVersion, 4);
    expect(userVersion(), AppDatabase.schemaVersion);
  });

  test('the core content tables exist', () {
    expect(exists('table', 'tracks'), isTrue);
    expect(exists('table', 'rungs'), isTrue);
    expect(exists('table', 'attempts'), isTrue);
    expect(exists('table', 'user_track_progress'), isTrue);
  });

  group('the reverted per-locale content cache is gone', () {
    test('no translation tables', () {
      expect(exists('table', 'rung_i18n'), isFalse);
      expect(exists('table', 'track_i18n'), isFalse);
      expect(exists('table', 'content_locale_pref'), isFalse);
    });

    test('no localized views', () {
      expect(exists('view', 'rungs_localized'), isFalse);
      expect(exists('view', 'tracks_localized'), isFalse);
    });
  });

  group('seeded content', () {
    test('6 tracks and 60 bundled rungs, all with English copy', () {
      final tracks =
          db.select('SELECT COUNT(*) AS n FROM tracks;').first['n'] as int;
      final rungs = db
          .select('SELECT COUNT(*) AS n FROM rungs WHERE is_custom = 0;')
          .first['n'] as int;
      expect(tracks, 6);
      expect(rungs, 60);
    });

    test('no seeded rung has empty copy — only custom rungs may be blank', () {
      final blanks = db.select(
        "SELECT id FROM rungs WHERE is_custom = 0 "
        "AND (trim(what_to_do) = '' OR trim(why_it_helps) = '');",
      );
      expect(blanks, isEmpty);
    });

    test('rungs reference a real track', () {
      final orphans = db.select(
        'SELECT r.id FROM rungs r '
        'LEFT JOIN tracks t ON t.id = r.track_id WHERE t.id IS NULL;',
      );
      expect(orphans, isEmpty);
    });
  });

  test('the custom-rung blanking migration is idempotent', () {
    // Re-opening an already-migrated database must not throw or re-blank.
    final again = AppDatabase.openInMemory();
    expect(again.select('PRAGMA user_version;').first.values.first, 4);
    again.close();
  });

  test('a custom rung may legitimately store empty copy', () {
    db.run(
      "INSERT INTO rungs (id, track_id, title, what_to_do, why_it_helps, "
      "difficulty, sort_order, is_custom, est_minutes, updated_at) "
      "VALUES ('rng_c', 'trk_speaking', 'Mine', '', '', 3, 99, 1, 5, 0);",
    );
    final r = db.select("SELECT * FROM rungs WHERE id = 'rng_c';").first;
    expect(r['what_to_do'], '');
    expect(r['why_it_helps'], '');
    expect(r['is_custom'], 1);
  });
}
