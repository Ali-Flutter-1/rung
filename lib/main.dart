import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'app/providers.dart';
import 'core/analytics/analytics_bootstrap.dart';
import 'core/errors.dart';
import 'core/haptics.dart';
import 'core/purchases/purchase_service.dart';
import 'core/push/push_bootstrap.dart';
import 'data/local/app_database.dart';
import 'data/notifications/notification_service.dart';
import 'data/remote/supabase_bootstrap.dart';
import 'data/repositories/prefs_settings_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Known Flutter 3.38 semantics-engine regression: flushSemantics can throw a
  // debug-only '!semantics.parentDataDirty' assertion when a route/sheet is
  // presented over a tab shell. It never fires in release and doesn't affect
  // behaviour, but in debug the per-frame throw blanks the screen. Swallow ONLY
  // that assertion; everything else goes to the normal handler.
  final defaultOnError = FlutterError.onError;
  FlutterError.onError = (details) {
    if (details.exceptionAsString().contains('parentDataDirty')) return;
    defaultOnError?.call(details);
  };

  // Supabase auto-refreshes the auth session on a background timer. Offline,
  // that refresh throws AuthRetryableFetchException from an internal retry loop
  // we never await — so it surfaces as an UNHANDLED async error that would
  // crash the app. The same goes for any other cloud call whose rejection
  // escapes. These are expected and self-heal when the network returns, so
  // swallow offline errors here (the last-resort net); anything else propagates
  // to the platform's default handler so real bugs still surface.
  WidgetsBinding.instance.platformDispatcher.onError = (error, stack) {
    if (isOfflineError(error)) return true; // handled — do not crash
    return false; // unknown error → default handling
  };

  // Portrait-only — block landscape on every screen (native config in
  // Info.plist + AndroidManifest enforces it too; this is the belt-and-braces).
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Cloud + analytics + notifications are optional and self-guarding (§2.2).
  await initSupabase();
  await initFirebase();
  await initPurchases();
  await initAnalytics();
  await NotificationService.instance.init();

  // Open the local-first store + settings before the app reads them (§2.2).
  final db = await AppDatabase.open();
  final settings = await PrefsSettingsRepository.create();
  Haptics.enabled = settings.hapticsEnabled; // gate all haptics from here on

  // Record the already-signed-in account so the FIRST account switch is
  // detected (otherwise a session that persisted from before has no baseline).
  if (supabaseReady) {
    final uid = supabase.auth.currentUser?.id;
    if (uid != null && settings.lastUserId == null) {
      await settings.setLastUserId(uid);
    }
  }

  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(db),
        settingsRepositoryProvider.overrideWithValue(settings),
      ],
      child: const RungApp(),
    ),
  );
}
