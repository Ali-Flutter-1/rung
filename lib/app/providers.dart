import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/analytics/analytics.dart';
import '../core/analytics/posthog_analytics.dart';
import '../core/config/app_config.dart';
import '../core/purchases/purchase_service.dart';
import '../core/push/push_service.dart';
import '../data/local/app_database.dart';
import '../data/remote/auth_repository.dart';
import '../data/remote/cloud_repository.dart';
import '../data/remote/supabase_bootstrap.dart';
import '../data/sync/sync_service.dart';
import '../data/repositories/local_attempt_repository.dart';
import '../data/repositories/local_progress_repository.dart';
import '../data/repositories/local_track_repository.dart';
import '../domain/entities/attempt.dart';
import '../domain/entities/subscription.dart';
import '../domain/entities/rung.dart';
import '../domain/entities/today_suggestion.dart';
import '../domain/entities/track.dart';
import '../domain/entities/user_progress.dart';
import '../domain/repositories/attempt_repository.dart';
import '../domain/repositories/progress_repository.dart';
import '../domain/repositories/settings_repository.dart';
import '../domain/repositories/track_repository.dart';

/// Infrastructure singletons — overridden in `main()` after async bootstrap.
final databaseProvider = Provider<AppDatabase>(
  (ref) => throw UnimplementedError('databaseProvider must be overridden'),
);

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => throw UnimplementedError('settingsRepositoryProvider override'),
);

/// Emits whenever a setting changes, so theme/tone-dependent widgets rebuild.
/// Emits a monotonically increasing tick — a plain `void`/null stream would
/// produce equal `AsyncData(null)` values, which Riverpod dedupes, so only the
/// first change would rebuild watchers (toggles would "stick" after one use).
final settingsChangesProvider = StreamProvider<int>((ref) {
  final settings = ref.watch(settingsRepositoryProvider);
  var tick = 0;
  return settings.changes.map((_) => ++tick);
});

/// Analytics seam — PostHog when configured, no-op otherwise.
final analyticsProvider = Provider<Analytics>(
  (_) => AppConfig.hasPosthog ? const PostHogAnalytics() : const NoopAnalytics(),
);

// ── Cloud (Supabase) — only active when configured ───────────────────────
/// True when Supabase initialized successfully this session.
final cloudEnabledProvider = Provider<bool>((_) => supabaseReady);

final authRepositoryProvider = Provider<AuthRepository>(
  (_) => const AuthRepository(),
);

final cloudRepositoryProvider = Provider<CloudRepository>(
  (_) => const CloudRepository(),
);

/// Opt-in progress backup (numbers only) behind the repository seam.
final syncServiceProvider = Provider<SyncService>(
  (ref) => SyncService(
    ref.watch(databaseProvider),
    ref.watch(cloudRepositoryProvider),
    ref.watch(settingsRepositoryProvider),
  ),
);

/// RevenueCat purchases. No-ops until a RevenueCat key is configured.
final purchaseServiceProvider =
    Provider<PurchaseService>((_) => const PurchaseService());

/// On sign-in: tie purchases to the user and sync their entitlement tier into
/// local settings + the cloud profile (so server-side pod/content limits match).
/// Renewals/expiries are also caught by the RevenueCat webhook server-side and
/// re-synced here on the next app open.
final purchaseSyncProvider = FutureProvider<void>((ref) async {
  if (!purchasesReady) return;
  final user = ref.watch(authUserProvider).asData?.value;
  if (user == null) return;
  final settings = ref.read(settingsRepositoryProvider);
  final tier = await ref.read(purchaseServiceProvider).syncUser(user.id);
  if (settings.subscriptionTier != tier) {
    await settings.setSubscriptionTier(tier);
    try {
      await ref.read(cloudRepositoryProvider).upsertProfile(
            displayName: settings.displayName,
            bio: settings.bio,
            isLocked: settings.profileLocked,
            tier: tier,
            avatarId: settings.avatarId,
          );
    } catch (_) {/* best-effort */}
  }
});

/// Push-notification token lifecycle (FCM). No-ops until Firebase is ready.
final pushServiceProvider = Provider<PushService>((ref) => PushService(
      onRegister: (token, platform) =>
          ref.read(cloudRepositoryProvider).upsertDeviceToken(token, platform),
      onDelete: (token) =>
          ref.read(cloudRepositoryProvider).deleteDeviceToken(token),
    ));

/// Registers this device's push token whenever someone is signed in (and on
/// account switch). Watched in the shell; result ignored.
final pushRegistrationProvider = FutureProvider<void>((ref) async {
  if (!ref.watch(cloudEnabledProvider)) return;
  ref.watch(settingsChangesProvider); // re-run when the master toggle changes
  final signedIn = ref.watch(authUserProvider).asData?.value != null;
  if (!signedIn) return;
  // Respect the master push switch — off means no token, so no cloud pushes.
  if (!ref.read(settingsRepositoryProvider).pushEnabled) return;
  await ref.read(pushServiceProvider).registerForUser();
});

/// Pulls global content (tracks + rungs) from Supabase into the local cache
/// whenever the signed-in user changes (sign-in / switch / startup). Watch it
/// somewhere always-mounted (the shell) to keep content fresh; result ignored.
final contentSyncProvider = FutureProvider<void>((ref) async {
  if (!ref.watch(cloudEnabledProvider)) return;
  final signedIn = ref.watch(authUserProvider).asData?.value != null;
  if (!signedIn) return;
  await ref.read(syncServiceProvider).syncContent();
});

/// Auto-syncs the signed-in user's PROGRESS (attempts + streak, numbers only)
/// with the cloud on app start and whenever the signed-in user changes — so a
/// reopened app or a freshly-switched account pulls its real data back without
/// a manual button. Local SQLite stays the fast, offline source of truth; this
/// just reconciles it with the cloud (push local changes, pull cloud history).
/// Watched in the shell; result ignored.
final progressSyncProvider = FutureProvider<void>((ref) async {
  if (!ref.watch(cloudEnabledProvider)) return;
  final signedIn = ref.watch(authUserProvider).asData?.value != null;
  if (!signedIn) return;
  final sync = ref.read(syncServiceProvider);
  // Empty local (reinstall / just-switched account) → pull the full history.
  // Otherwise just reconcile recent changes (cheap, avoids re-pulling everything).
  if (sync.localHasHistory) {
    await sync.backupNow();
  } else {
    await sync.restoreFromCloud();
  }
});

/// Current signed-in user (null when cloud off or signed out).
final authUserProvider = StreamProvider<User?>((ref) async* {
  if (!supabaseReady) {
    yield null;
    return;
  }
  final auth = ref.watch(authRepositoryProvider);
  yield auth.currentUser;
  await for (final _ in auth.authChanges()) {
    yield auth.currentUser;
  }
});

// ── Repository seam (§12.3) — local impls today, swappable later ──────────
final trackRepositoryProvider = Provider<TrackRepository>(
  (ref) => LocalTrackRepository(ref.watch(databaseProvider)),
);

final attemptRepositoryProvider = Provider<AttemptRepository>(
  (ref) => LocalAttemptRepository(ref.watch(databaseProvider)),
);

final progressRepositoryProvider = Provider<ProgressRepository>(
  (ref) => LocalProgressRepository(ref.watch(databaseProvider)),
);

// ── Reactive read models for the UI ──────────────────────────────────────
final tracksProvider = StreamProvider<List<Track>>(
  (ref) => ref.watch(trackRepositoryProvider).watchTracks(),
);

/// Tier-capped ladder: free sees 10 rungs/track, monthly 40, yearly 60 (capped
/// at the rungs that actually exist). Custom rungs are always shown. Rebuilds
/// when the subscription tier changes.
final ladderProvider = StreamProvider.family<List<Rung>, String>(
  (ref, trackId) {
    ref.watch(settingsChangesProvider);
    final tier = ref.watch(settingsRepositoryProvider).subscriptionTier;
    return ref.watch(trackRepositoryProvider).watchLadder(
          trackId,
          maxBaseRungs: ContentRules.maxRungsPerTrack(tier),
        );
  },
);

final todaysRungProvider = StreamProvider<TodaySuggestion?>(
  (ref) => ref.watch(progressRepositoryProvider).watchTodaysRung(),
);

final inProgressAttemptProvider = StreamProvider<Attempt?>(
  (ref) => ref.watch(attemptRepositoryProvider).watchInProgress(),
);

final clearedRungIdsProvider = StreamProvider<Set<String>>(
  (ref) => ref.watch(attemptRepositoryProvider).watchClearedRungIds(),
);

final allProgressProvider = StreamProvider<List<UserProgress>>(
  (ref) => ref.watch(progressRepositoryProvider).watchAllProgress(),
);

final streakProvider = StreamProvider<int>(
  (ref) => ref.watch(progressRepositoryProvider).watchCurrentStreak(),
);

final totalClearedProvider = StreamProvider<int>(
  (ref) => ref.watch(progressRepositoryProvider).watchTotalRungsCleared(),
);

final bestStreakProvider = StreamProvider<int>(
  (ref) => ref.watch(progressRepositoryProvider).watchBestStreak(),
);

final activeDaysProvider = StreamProvider<Set<String>>(
  (ref) => ref.watch(progressRepositoryProvider).watchActiveDays(),
);

final recentAttemptsProvider = StreamProvider<List<Attempt>>(
  (ref) => ref.watch(attemptRepositoryProvider).watchRecentAttempts(),
);

/// All rungs keyed by id — handy for history/result screens.
final rungByIdProvider = FutureProvider.family<Rung?, String>(
  (ref, rungId) => ref.watch(trackRepositoryProvider).getRung(rungId),
);

final trackByIdProvider = FutureProvider.family<Track?, String>(
  (ref, trackId) => ref.watch(trackRepositoryProvider).getTrack(trackId),
);
