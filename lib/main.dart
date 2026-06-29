import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'app/providers.dart';
import 'core/analytics/analytics_bootstrap.dart';
import 'data/local/app_database.dart';
import 'data/notifications/notification_service.dart';
import 'data/remote/supabase_bootstrap.dart';
import 'data/repositories/prefs_settings_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Cloud + analytics + notifications are optional and self-guarding (§2.2).
  await initSupabase();
  await initAnalytics();
  await NotificationService.instance.init();

  // Open the local-first store + settings before the app reads them (§2.2).
  final db = await AppDatabase.open();
  final settings = await PrefsSettingsRepository.create();

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
