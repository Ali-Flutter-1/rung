import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

import '../seed/seed_data.dart';

/// Local-first SQLite store — the source of truth at runtime (§2.2).
///
/// Codegen-free wrapper over `package:sqlite3`. It owns schema creation,
/// additive migrations (§11.4), content seeding, and a change-notification
/// stream that lets repositories expose reactive `watch*` queries without an
/// ORM. Everything here sits behind the repository interfaces (§11.2), so a
/// future swap to Drift touches only this layer.
class AppDatabase {
  AppDatabase._(this._db);

  final Database _db;
  final StreamController<void> _changes = StreamController<void>.broadcast();

  /// Current schema version. Bump + add a migration step for additive changes.
  static const int schemaVersion = 2;

  static Future<AppDatabase> open({String? path}) async {
    final dbPath = path ??
        '${(await getApplicationDocumentsDirectory()).path}/rung.db';
    final db = sqlite3.open(dbPath);
    final instance = AppDatabase._(db);
    instance._configure();
    instance._migrate();
    instance._seed();
    return instance;
  }

  /// In-memory database for tests.
  static AppDatabase openInMemory() {
    final instance = AppDatabase._(sqlite3.openInMemory());
    instance._configure();
    instance._migrate();
    instance._seed();
    return instance;
  }

  void _configure() {
    _db
      ..execute('PRAGMA foreign_keys = ON;')
      ..execute('PRAGMA journal_mode = WAL;');
  }

  void _migrate() {
    final version = _db.select('PRAGMA user_version;').first.values.first as int;
    var v = version;
    // Forward-only, additive migrations (§11.4).
    if (v < 1) {
      _createV1();
      v = 1;
    }
    if (v < 2) {
      _createV2();
      v = 2;
    }
    if (v != version) {
      _db.execute('PRAGMA user_version = $v;');
    }
  }

  /// v2 — content translations.
  ///
  /// `tracks` / `rungs` remain the canonical base and hold the ENGLISH copy.
  /// Translations live alongside, keyed by (id, locale); structural fields are
  /// never duplicated per locale. Reads go through the `*_localized` views,
  /// which resolve the best available locale and fall back to English.
  ///
  /// `source_updated_at` is the base row's `updated_at` that a translation was
  /// made from. If English copy is later rewritten, `updated_at` bumps and the
  /// translation becomes stale — it now describes a *different* exercise. The
  /// view refuses stale rows, so the user sees English rather than instructions
  /// for a step that no longer exists.
  void _createV2() {
    _db.execute('''
      CREATE TABLE track_i18n (
        track_id          TEXT NOT NULL REFERENCES tracks(id) ON DELETE CASCADE,
        locale            TEXT NOT NULL,
        title             TEXT NOT NULL,
        description       TEXT NOT NULL,
        source_updated_at INTEGER NOT NULL DEFAULT 0,
        PRIMARY KEY (track_id, locale)
      );
    ''');
    _db.execute('''
      CREATE TABLE rung_i18n (
        rung_id           TEXT NOT NULL REFERENCES rungs(id) ON DELETE CASCADE,
        locale            TEXT NOT NULL,
        title             TEXT NOT NULL,
        what_to_do        TEXT NOT NULL,
        why_it_helps      TEXT NOT NULL,
        source_updated_at INTEGER NOT NULL DEFAULT 0,
        PRIMARY KEY (rung_id, locale)
      );
    ''');
    // The active locale fallback chain, lowest rank wins (pt_PT=0, pt=1, en=2).
    // Empty table ⇒ every lookup misses ⇒ everything falls back to English.
    _db.execute('''
      CREATE TABLE content_locale_pref (
        locale TEXT PRIMARY KEY,
        rank   INTEGER NOT NULL
      );
    ''');

    // Custom rungs (is_custom = 1) never have i18n rows, so COALESCE returns
    // the user's own text untouched — user content is never translated.
    _db.execute('''
      CREATE VIEW rungs_localized AS
      SELECT
        r.id, r.track_id,
        COALESCE(i.title, r.title)               AS title,
        COALESCE(i.what_to_do, r.what_to_do)     AS what_to_do,
        COALESCE(i.why_it_helps, r.why_it_helps) AS why_it_helps,
        r.difficulty, r.sort_order, r.is_custom, r.owner_id,
        r.est_minutes, r.updated_at, r.deleted_at
      FROM rungs r
      LEFT JOIN rung_i18n i
        ON i.rung_id = r.id
       AND i.locale = (
             SELECT x.locale
             FROM rung_i18n x
             JOIN content_locale_pref p ON p.locale = x.locale
             WHERE x.rung_id = r.id
               AND x.source_updated_at >= r.updated_at
             ORDER BY p.rank
             LIMIT 1
           );
    ''');
    _db.execute('''
      CREATE VIEW tracks_localized AS
      SELECT
        t.id, t.slug,
        COALESCE(i.title, t.title)             AS title,
        COALESCE(i.description, t.description) AS description,
        t.icon, t.sort_order, t.color_seed
      FROM tracks t
      LEFT JOIN track_i18n i
        ON i.track_id = t.id
       AND i.locale = (
             SELECT x.locale
             FROM track_i18n x
             JOIN content_locale_pref p ON p.locale = x.locale
             WHERE x.track_id = t.id
             ORDER BY p.rank
             LIMIT 1
           );
    ''');
  }

  /// Sets the content-locale fallback chain, best first (e.g. `['pt_PT','pt']`).
  /// English is the implicit last resort via COALESCE, so it need not be listed.
  ///
  /// Returns true if the chain actually changed — the caller uses that to
  /// invalidate cached content providers, since the localized views read this
  /// table and SQLite has no way to tell Riverpod it moved.
  bool setContentLocaleChain(List<String> chain) {
    final current = _db
        .select('SELECT locale FROM content_locale_pref ORDER BY rank;')
        .map((r) => r['locale'] as String)
        .toList();
    if (current.length == chain.length) {
      var same = true;
      for (var i = 0; i < chain.length; i++) {
        if (current[i] != chain[i]) same = false;
      }
      if (same) return false;
    }
    transaction(() {
      _db.execute('DELETE FROM content_locale_pref;');
      for (var i = 0; i < chain.length; i++) {
        _db.execute(
          'INSERT INTO content_locale_pref (locale, rank) VALUES (?, ?);',
          [chain[i], i],
        );
      }
    });
    return true;
  }

  void _createV1() {
    _db.execute('''
      CREATE TABLE tracks (
        id           TEXT PRIMARY KEY,
        slug         TEXT NOT NULL UNIQUE,
        title        TEXT NOT NULL,
        description  TEXT NOT NULL,
        icon         TEXT NOT NULL,
        sort_order   INTEGER NOT NULL,
        color_seed   TEXT NOT NULL
      );
    ''');
    _db.execute('''
      CREATE TABLE rungs (
        id           TEXT PRIMARY KEY,
        track_id     TEXT NOT NULL REFERENCES tracks(id),
        title        TEXT NOT NULL,
        what_to_do   TEXT NOT NULL,
        why_it_helps TEXT NOT NULL,
        difficulty   INTEGER NOT NULL,
        sort_order   INTEGER NOT NULL,
        is_custom    INTEGER NOT NULL DEFAULT 0,
        owner_id     TEXT,
        est_minutes  INTEGER NOT NULL DEFAULT 2,
        updated_at   INTEGER NOT NULL DEFAULT 0,
        deleted_at   INTEGER
      );
    ''');
    _db.execute(
      'CREATE INDEX idx_rungs_track ON rungs(track_id, sort_order);',
    );
    _db.execute('''
      CREATE TABLE attempts (
        id              TEXT PRIMARY KEY,
        rung_id         TEXT NOT NULL REFERENCES rungs(id),
        predicted_suds  INTEGER NOT NULL,
        predicted_note  TEXT,
        actual_suds     INTEGER,
        outcome         TEXT,
        reflection_note TEXT,
        started_at      INTEGER NOT NULL,
        completed_at    INTEGER,
        created_at      INTEGER NOT NULL,
        updated_at      INTEGER NOT NULL,
        deleted_at      INTEGER
      );
    ''');
    _db.execute(
      'CREATE INDEX idx_attempts_rung ON attempts(rung_id, created_at);',
    );
    _db.execute('''
      CREATE TABLE user_track_progress (
        track_id                 TEXT PRIMARY KEY REFERENCES tracks(id),
        current_rung_id          TEXT,
        rungs_cleared            INTEGER NOT NULL DEFAULT 0,
        streak                   INTEGER NOT NULL DEFAULT 0,
        streak_freezes_remaining INTEGER NOT NULL DEFAULT 1,
        last_activity_day        TEXT,
        updated_at               INTEGER NOT NULL DEFAULT 0
      );
    ''');
    // Global key/value scratch for app-wide counters (e.g. streak freezes).
    _db.execute(
      'CREATE TABLE app_meta (key TEXT PRIMARY KEY, value TEXT);',
    );
  }

  /// Upserts seed content so app updates can add/adjust global tracks & rungs
  /// without a destructive migration. UPSERT (not REPLACE) preserves rows so
  /// attempt foreign keys are never orphaned.
  void _seed() {
    final trackStmt = _db.prepare('''
      INSERT INTO tracks (id, slug, title, description, icon, sort_order, color_seed)
      VALUES (?, ?, ?, ?, ?, ?, ?)
      ON CONFLICT(id) DO UPDATE SET
        slug=excluded.slug, title=excluded.title, description=excluded.description,
        icon=excluded.icon, sort_order=excluded.sort_order, color_seed=excluded.color_seed;
    ''');
    final rungStmt = _db.prepare('''
      INSERT INTO rungs (id, track_id, title, what_to_do, why_it_helps, difficulty, sort_order, is_custom, owner_id, est_minutes, updated_at)
      VALUES (?, ?, ?, ?, ?, ?, ?, 0, NULL, ?, 0)
      ON CONFLICT(id) DO UPDATE SET
        title=excluded.title, what_to_do=excluded.what_to_do,
        why_it_helps=excluded.why_it_helps, difficulty=excluded.difficulty,
        sort_order=excluded.sort_order, est_minutes=excluded.est_minutes;
    ''');
    _db.execute('BEGIN;');
    try {
      for (final t in SeedData.tracks) {
        trackStmt.execute([
          t.id, t.slug, t.title, t.description, t.icon, t.sortOrder, t.colorSeed,
        ]);
      }
      for (final r in SeedData.rungs) {
        rungStmt.execute([
          r.id, r.trackId, r.title, r.whatToDo, r.whyItHelps,
          r.difficulty, r.sortOrder, r.estMinutes,
        ]);
      }
      // Ensure a progress row exists per track.
      for (final t in SeedData.tracks) {
        _db.execute(
          'INSERT OR IGNORE INTO user_track_progress (track_id) VALUES (?);',
          [t.id],
        );
      }
      _db.execute('COMMIT;');
    } catch (e) {
      _db.execute('ROLLBACK;');
      rethrow;
    } finally {
      trackStmt.dispose();
      rungStmt.dispose();
    }
  }

  /// Caches global content fetched from the cloud into the local store. The
  /// cloud is authoritative for seeded tracks/rungs, so rows are overwritten on
  /// conflict. Custom rungs (`is_custom = 1`) are never touched. Track/rung
  /// rows ensure a progress row exists per (possibly new) track.
  void upsertContent({
    required List<Map<String, dynamic>> tracks,
    required List<Map<String, dynamic>> rungs,
    List<Map<String, dynamic>> trackI18n = const [],
    List<Map<String, dynamic>> rungI18n = const [],
  }) {
    if (tracks.isEmpty &&
        rungs.isEmpty &&
        trackI18n.isEmpty &&
        rungI18n.isEmpty) {
      return;
    }
    transaction(() {
      for (final t in tracks) {
        _db.execute(
          'INSERT INTO tracks (id, slug, title, description, icon, sort_order, '
          'color_seed) VALUES (?, ?, ?, ?, ?, ?, ?) '
          'ON CONFLICT(id) DO UPDATE SET slug=excluded.slug, '
          'title=excluded.title, description=excluded.description, '
          'icon=excluded.icon, sort_order=excluded.sort_order, '
          'color_seed=excluded.color_seed;',
          [
            t['id'], t['slug'], t['title'], t['description'], t['icon'],
            t['sort_order'], t['color_seed'],
          ],
        );
        _db.execute(
          'INSERT OR IGNORE INTO user_track_progress (track_id) VALUES (?);',
          [t['id']],
        );
      }
      for (final r in rungs) {
        _db.execute(
          'INSERT INTO rungs (id, track_id, title, what_to_do, why_it_helps, '
          'difficulty, sort_order, is_custom, owner_id, est_minutes, '
          'updated_at, deleted_at) VALUES (?, ?, ?, ?, ?, ?, ?, 0, NULL, ?, ?, ?) '
          'ON CONFLICT(id) DO UPDATE SET title=excluded.title, '
          'what_to_do=excluded.what_to_do, why_it_helps=excluded.why_it_helps, '
          'difficulty=excluded.difficulty, sort_order=excluded.sort_order, '
          'est_minutes=excluded.est_minutes, updated_at=excluded.updated_at, '
          'deleted_at=excluded.deleted_at;',
          [
            r['id'], r['track_id'], r['title'], r['what_to_do'],
            r['why_it_helps'], r['difficulty'], r['sort_order'],
            r['est_minutes'] ?? 2, r['updated_at'] ?? 0, r['deleted_at'],
          ],
        );
      }
      for (final t in trackI18n) {
        _db.execute(
          'INSERT INTO track_i18n (track_id, locale, title, description, '
          'source_updated_at) VALUES (?, ?, ?, ?, ?) '
          'ON CONFLICT(track_id, locale) DO UPDATE SET title=excluded.title, '
          'description=excluded.description, '
          'source_updated_at=excluded.source_updated_at;',
          [
            t['track_id'], t['locale'], t['title'], t['description'],
            t['source_updated_at'] ?? 0,
          ],
        );
      }
      for (final r in rungI18n) {
        _db.execute(
          'INSERT INTO rung_i18n (rung_id, locale, title, what_to_do, '
          'why_it_helps, source_updated_at) VALUES (?, ?, ?, ?, ?, ?) '
          'ON CONFLICT(rung_id, locale) DO UPDATE SET title=excluded.title, '
          'what_to_do=excluded.what_to_do, why_it_helps=excluded.why_it_helps, '
          'source_updated_at=excluded.source_updated_at;',
          [
            r['rung_id'], r['locale'], r['title'], r['what_to_do'],
            r['why_it_helps'], r['source_updated_at'] ?? 0,
          ],
        );
      }
    });
  }

  // ── Query surface used by repositories ────────────────────────────────
  ResultSet select(String sql, [List<Object?> params = const []]) =>
      _db.select(sql, params);

  void run(String sql, [List<Object?> params = const []]) =>
      _db.execute(sql, params);

  String? meta(String key) {
    final rows = _db.select('SELECT value FROM app_meta WHERE key = ?;', [key]);
    return rows.isEmpty ? null : rows.first['value'] as String?;
  }

  void setMeta(String key, String value) => _db.execute(
        'INSERT INTO app_meta (key, value) VALUES (?, ?) '
        'ON CONFLICT(key) DO UPDATE SET value = excluded.value;',
        [key, value],
      );

  /// Runs [body] in a transaction and notifies watchers once on success.
  T transaction<T>(T Function() body) {
    _db.execute('BEGIN;');
    try {
      final result = body();
      _db.execute('COMMIT;');
      notifyChanged();
      return result;
    } catch (_) {
      _db.execute('ROLLBACK;');
      rethrow;
    }
  }

  /// Wipes the device's user data (attempts, progress, meta) but keeps the
  /// seeded content (tracks/rungs). Used when a different account signs in.
  void resetUserData() {
    transaction(() {
      _db.execute('DELETE FROM attempts;');
      _db.execute('DELETE FROM app_meta;');
      // Custom rungs are per-user content — drop them so the next account never
      // inherits them. They are restored from the cloud for that account.
      _db.execute('DELETE FROM rungs WHERE is_custom = 1;');
      _db.execute(
        'UPDATE user_track_progress SET rungs_cleared = 0, '
        'current_rung_id = NULL, streak = 0, streak_freezes_remaining = 1, '
        'last_activity_day = NULL, updated_at = 0;',
      );
    });
  }

  /// Signals every reactive query to re-read.
  void notifyChanged() {
    if (!_changes.isClosed) _changes.add(null);
  }

  /// Emits the result of [reader] now and after every change.
  Stream<T> watch<T>(T Function() reader) async* {
    yield reader();
    yield* _changes.stream.map((_) => reader());
  }

  Future<void> close() async {
    await _changes.close();
    _db.dispose();
  }
}
