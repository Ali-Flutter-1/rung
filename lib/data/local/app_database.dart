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
  static const int schemaVersion = 1;

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
    if (v != version) {
      _db.execute('PRAGMA user_version = $v;');
    }
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
  }) {
    if (tracks.isEmpty && rungs.isEmpty) return;
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
