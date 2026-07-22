// The isolation guarantee: while a password-reset recovery is in progress, the
// REAL app router must pin the user to the change-password screen and keep them
// OFF the shell — that's what stops the shell's auto-sync from pushing the
// wrong account's local data to the recovered account's cloud. This drives the
// production `routerProvider` (not a stand-in) so a regression — dropping the
// flag from the redirect or the refreshListenable — fails here.
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rung/app/providers.dart';
import 'package:rung/app/router.dart';
import 'package:rung/data/remote/auth_repository.dart';
import 'package:rung/domain/repositories/settings_repository.dart';
import 'package:rung/features/auth/change_password_screen.dart';
import 'package:rung/l10n/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Signed in, onboarding done — the state a recovery session lands in.
class _FakeSettings implements SettingsRepository {
  @override
  bool get hasCompletedOnboarding => true;
  @override
  Stream<void> get changes => const Stream<void>.empty();
  @override
  dynamic noSuchMethod(Invocation i) => throw UnimplementedError();
}

class _FakeAuth implements AuthRepository {
  @override
  bool get isSignedIn => true;
  @override
  Stream<AuthState> authChanges() => const Stream<AuthState>.empty();
  @override
  dynamic noSuchMethod(Invocation i) => throw UnimplementedError();
}

Widget _app() => ProviderScope(
      overrides: [
        settingsRepositoryProvider.overrideWithValue(_FakeSettings()),
        authRepositoryProvider.overrideWithValue(_FakeAuth()),
        cloudEnabledProvider.overrideWithValue(true),
      ],
      child: Consumer(
        builder: (context, ref, _) => MaterialApp.router(
          localizationsDelegates: const [
            ...AppLocalizations.localizationsDelegates,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          routerConfig: ref.watch(routerProvider),
        ),
      ),
    );

void main() {
  setUp(() => passwordRecoveryActive.value = false);
  tearDown(() => passwordRecoveryActive.value = false);

  testWidgets(
      'a signed-in recovery is pinned to change-password, never the shell',
      (tester) async {
    // Recovery active BEFORE the first frame — mirrors a cold start from the
    // reset link, where the initial location (/dashboard) must be overridden.
    passwordRecoveryActive.value = true;
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    // If the redirect ignored the flag, a signed-in user would land on the
    // dashboard (the shell) — reaching it here would also throw, since the
    // shell's providers aren't overridden. Finding the change-password screen
    // proves the pin held.
    expect(find.byType(ChangePasswordScreen), findsOneWidget);
  });
}
