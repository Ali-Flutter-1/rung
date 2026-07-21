import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import 'providers.dart';
import 'router.dart';

class RungApp extends ConsumerStatefulWidget {
  const RungApp({super.key});

  @override
  ConsumerState<RungApp> createState() => _RungAppState();
}

class _RungAppState extends ConsumerState<RungApp> {
  StreamSubscription<AuthState>? _recoverySub;

  @override
  void initState() {
    super.initState();
    // When the user taps the link in a password-reset email, supabase_flutter
    // handles the deep link, establishes a short-lived recovery session, and
    // emits a passwordRecovery event. Route them straight to the screen that
    // sets a new password. Only wire this up when cloud is configured —
    // authChanges() reaches into the Supabase client, which doesn't exist in a
    // local-only build.
    if (ref.read(cloudEnabledProvider)) {
      _recoverySub = ref.read(authRepositoryProvider).authChanges().listen((s) {
        if (s.event == AuthChangeEvent.passwordRecovery && mounted) {
          // Use go (not push): the recovery session also trips the router's
          // gate refresh, and go_router restores imperatively-pushed routes on
          // refresh. Replacing the location avoids that fight entirely.
          ref.read(routerProvider).go(Routes.changePassword);
        }
      });
    }
  }

  @override
  void dispose() {
    _recoverySub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    final settings = ref.watch(settingsRepositoryProvider);
    ref.watch(settingsChangesProvider); // rebuild on theme/tone/language changes
    final code = settings.localeCode;
    return MaterialApp.router(
      title: 'Rung',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: settings.themeMode,
      // Localization: chosen language, or null → follow the device. Flutter
      // applies RTL automatically for RTL locales (e.g. Arabic).
      locale: code == null ? null : _localeFromCode(code),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }
}

/// Parse a stored locale code into a [Locale]. Handles language-only codes
/// ("de") and language+country codes ("pt_PT" → Locale('pt', 'PT')).
Locale _localeFromCode(String code) {
  final parts = code.split('_');
  return parts.length == 2 ? Locale(parts[0], parts[1]) : Locale(parts[0]);
}
