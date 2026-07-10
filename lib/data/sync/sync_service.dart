import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../domain/repositories/settings_repository.dart';
import '../local/app_database.dart';
import '../local/content_locale.dart';
import '../remote/cloud_repository.dart';
import '../remote/supabase_bootstrap.dart';

/// Opt-in progress backup (numbers only). Pushes/pulls `attempts` +
/// `user_track_progress` between the local SQLite store (source of truth) and
/// Supabase, last-write-wins on `updated_at`. Reflection/prediction NOTE TEXT
/// is never included — it stays on-device (§1.9).
class SyncService {
  SyncService(this._db, this._cloud, this._settings);

  final AppDatabase _db;
  final CloudRepository _cloud;
  final SettingsRepository _settings;

  bool _running = false;
  Timer? _debounce;

  /// Human-readable reason the last backup/restore did not succeed (e.g. a
  /// missing table). `null` after a successful sync. Surfaced in Profile so a
  /// silent failure (like migration 0004 not applied) becomes visible.
  String? lastError;

  /// Debounced backup — call after each data change (e.g. logging a rung).
  /// Many quick changes coalesce into a single sync (battery/network friendly).
  void scheduleBackup({Duration delay = const Duration(seconds: 4)}) {
    if (!_settings.backupEnabled) return;
    _debounce?.cancel();
    _debounce = Timer(delay, backupNow);
  }

  /// Content rarely changes, so re-pull it at most once per this window rather
  /// than on every app open — keeps cloud egress negligible.
  static const _contentTtl = Duration(hours: 24);

  /// Pulls the global content (tracks + rungs) from the cloud and caches it
  /// into local SQLite, so paid-tier depth is available offline afterwards.
  /// Throttled to once per [_contentTtl] per device. Best-effort: on failure
  /// the bundled seed (and any prior cache) remains in place.
  /// [locale] is the app's active locale code (e.g. `pt_PT`); only that locale
  /// and its base language are pulled, never all of them. Passing a locale we
  /// have not cached before bypasses the TTL — otherwise switching language
  /// would show English rung copy for up to 24h.
  /// Returns true if the content the UI would render may have changed, so the
  /// caller can invalidate cached content providers.
  Future<bool> syncContent({bool force = false, String? locale}) async {
    final chain = locale == null ? const <String>[] : contentLocaleChain(locale);
    // Apply the chain locally FIRST: it is free, works offline and signed out,
    // and makes already-cached translations take effect the instant the user
    // switches language — no network round-trip.
    var changed = _db.setContentLocaleChain(chain);

    if (!supabaseReady || !_cloud.isSignedIn) return changed;
    final nowMs = DateTime.now().millisecondsSinceEpoch;
    final localeChanged = _settings.lastContentLocale != (locale ?? 'en');
    if (!force &&
        !localeChanged &&
        nowMs - _settings.lastContentSyncAt < _contentTtl.inMilliseconds) {
      return changed; // fetched recently for this locale — cache is fresh
    }
    try {
      final tracks = await _cloud.fetchContentTracks();
      final rungs = await _cloud.fetchContentRungs();
      final trackI18n = await _cloud.fetchContentTrackI18n(chain);
      final rungI18n = await _cloud.fetchContentRungI18n(chain);
      _db.upsertContent(
        tracks: tracks,
        rungs: rungs,
        trackI18n: trackI18n,
        rungI18n: rungI18n,
      );
      await _settings.setLastContentSyncAt(nowMs);
      await _settings.setLastContentLocale(locale ?? 'en');
      changed = true;
    } catch (e) {
      if (kDebugMode) debugPrint('[sync] content pull failed: $e');
      // keep the bundled seed / prior cache
    }
    return changed;
  }

  /// True if the signed-in account has cloud backup data to restore.
  Future<bool> hasCloudBackup() async {
    if (!supabaseReady || !_cloud.isSignedIn) return false;
    try {
      return await _cloud.hasBackup();
    } catch (_) {
      return false;
    }
  }

  /// Whether the local store has any real attempt history (vs a fresh install).
  bool get localHasHistory {
    final n = _db
        .select('SELECT COUNT(*) AS n FROM attempts WHERE deleted_at IS NULL;')
        .first['n'] as int;
    return n > 0;
  }

  /// Turns backup on and pulls everything down (used by account-driven restore).
  Future<bool> restoreFromCloud() async {
    await _settings.setBackupEnabled(true);
    await _settings.setLastBackupAt(0); // pull the full history
    return backupNow();
  }

  /// Runs a full backup cycle if eligible. Safe to call often; self-guards.
  Future<bool> backupNow() async {
    if (_running) return false;
    if (!supabaseReady) {
      lastError = 'Cloud is not configured.';
      return false;
    }
    if (!_cloud.isSignedIn) {
      lastError = 'Not signed in.';
      return false;
    }
    if (!_settings.backupEnabled) {
      lastError = 'Backup is off.';
      return false;
    }
    _running = true;
    try {
      final since = _settings.lastBackupAt;
      final nowMs = DateTime.now().millisecondsSinceEpoch;
      await _push(since);
      await _pull(since);
      await _settings.setLastBackupAt(nowMs);
      lastError = null; // success
      _db.notifyChanged(); // refresh UI streams after a pull
      return true;
    } catch (e) {
      // Best-effort; never disrupt the core loop. But surface WHY (debug log +
      // lastError shown in Profile) so a missing migration (e.g. backup_attempts
      // table) isn't an invisible "dashboard shows 0" symptom.
      lastError = e.toString();
      if (kDebugMode) debugPrint('[sync] backup/restore failed: $e');
      return false;
    } finally {
      _running = false;
    }
  }

  // ── push local deltas → cloud (numbers only) ────────────────────────────
  Future<void> _push(int since) async {
    // Custom rungs are per-user content (not notes) — back them up so they
    // survive reinstall / a new device.
    final customRungs = _db
        .select(
          'SELECT id, track_id, title, what_to_do, why_it_helps, difficulty, '
          'sort_order, est_minutes, updated_at, deleted_at FROM rungs '
          'WHERE is_custom = 1 AND updated_at > ?;',
          [since],
        )
        .map((r) => {
              'id': r['id'],
              'track_id': r['track_id'],
              'title': r['title'],
              'what_to_do': r['what_to_do'],
              'why_it_helps': r['why_it_helps'],
              'difficulty': r['difficulty'],
              'sort_order': r['sort_order'],
              'est_minutes': r['est_minutes'],
              'updated_at': r['updated_at'],
              'deleted_at': r['deleted_at'],
            })
        .toList();
    await _cloud.pushCustomRungs(customRungs);

    final attempts = _db
        .select(
          'SELECT id, rung_id, predicted_suds, actual_suds, outcome, '
          'started_at, completed_at, created_at, updated_at, deleted_at '
          'FROM attempts WHERE updated_at > ?;',
          [since],
        )
        .map((r) => {
              'id': r['id'],
              'rung_id': r['rung_id'],
              'predicted_suds': r['predicted_suds'],
              'actual_suds': r['actual_suds'],
              'outcome': r['outcome'],
              'started_at': r['started_at'],
              'completed_at': r['completed_at'],
              'created_at': r['created_at'],
              'updated_at': r['updated_at'],
              'deleted_at': r['deleted_at'],
            })
        .toList();
    await _cloud.pushBackupAttempts(attempts);

    final progress = _db
        .select(
          'SELECT track_id, current_rung_id, rungs_cleared, streak, '
          'streak_freezes_remaining, last_activity_day, updated_at '
          'FROM user_track_progress WHERE updated_at > ?;',
          [since],
        )
        .map((r) => {
              'track_id': r['track_id'],
              'current_rung_id': r['current_rung_id'],
              'rungs_cleared': r['rungs_cleared'],
              'streak': r['streak'],
              'streak_freezes_remaining': r['streak_freezes_remaining'],
              'last_activity_day': r['last_activity_day'],
              'updated_at': r['updated_at'],
            })
        .toList();
    await _cloud.pushBackupProgress(progress);
  }

  // ── pull cloud deltas → local (merge, preserve local notes) ─────────────
  Future<void> _pull(int since) async {
    final customRungs = await _cloud.fetchCustomRungs(since);
    final attempts = await _cloud.fetchBackupAttempts(since);
    final progress = await _cloud.fetchBackupProgress(since);

    _db.transaction(() {
      // Custom rungs FIRST — attempts reference rung ids via FK.
      for (final r in customRungs) {
        _db.run(
          'INSERT INTO rungs (id, track_id, title, what_to_do, why_it_helps, '
          'difficulty, sort_order, is_custom, owner_id, est_minutes, '
          'updated_at, deleted_at) '
          'VALUES (?, ?, ?, ?, ?, ?, ?, 1, ?, ?, ?, ?) '
          'ON CONFLICT(id) DO UPDATE SET '
          '  title = excluded.title, what_to_do = excluded.what_to_do, '
          '  why_it_helps = excluded.why_it_helps, '
          '  difficulty = excluded.difficulty, sort_order = excluded.sort_order, '
          '  est_minutes = excluded.est_minutes, updated_at = excluded.updated_at, '
          '  deleted_at = excluded.deleted_at '
          'WHERE excluded.updated_at > rungs.updated_at;',
          [
            r['id'], r['track_id'], r['title'], r['what_to_do'],
            r['why_it_helps'], r['difficulty'], r['sort_order'], 'cloud',
            r['est_minutes'] ?? 2, r['updated_at'], r['deleted_at'],
          ],
        );
      }
      for (final r in attempts) {
        // INSERT new rows; only overwrite an existing row if the cloud copy is
        // newer. Note columns are left untouched (never synced).
        _db.run(
          'INSERT INTO attempts (id, rung_id, predicted_suds, actual_suds, '
          'outcome, started_at, completed_at, created_at, updated_at, deleted_at) '
          'VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?) '
          'ON CONFLICT(id) DO UPDATE SET '
          '  predicted_suds = excluded.predicted_suds, '
          '  actual_suds = excluded.actual_suds, '
          '  outcome = excluded.outcome, '
          '  completed_at = excluded.completed_at, '
          '  updated_at = excluded.updated_at, '
          '  deleted_at = excluded.deleted_at '
          'WHERE excluded.updated_at > attempts.updated_at;',
          [
            r['id'], r['rung_id'], r['predicted_suds'], r['actual_suds'],
            r['outcome'], r['started_at'], r['completed_at'], r['created_at'],
            r['updated_at'], r['deleted_at'],
          ],
        );
      }
      for (final r in progress) {
        _db.run(
          'INSERT INTO user_track_progress (track_id, current_rung_id, '
          'rungs_cleared, streak, streak_freezes_remaining, last_activity_day, '
          'updated_at) VALUES (?, ?, ?, ?, ?, ?, ?) '
          'ON CONFLICT(track_id) DO UPDATE SET '
          '  current_rung_id = excluded.current_rung_id, '
          '  rungs_cleared = excluded.rungs_cleared, '
          '  streak = excluded.streak, '
          '  streak_freezes_remaining = excluded.streak_freezes_remaining, '
          '  last_activity_day = excluded.last_activity_day, '
          '  updated_at = excluded.updated_at '
          'WHERE excluded.updated_at > user_track_progress.updated_at;',
          [
            r['track_id'], r['current_rung_id'], r['rungs_cleared'],
            r['streak'], r['streak_freezes_remaining'], r['last_activity_day'],
            r['updated_at'],
          ],
        );
      }
    });
  }
}
