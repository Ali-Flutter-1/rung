import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import 'providers.dart';
import 'router.dart';

class RungApp extends ConsumerWidget {
  const RungApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
