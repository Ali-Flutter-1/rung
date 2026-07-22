// Change-password screen. Covers every outcome the user can hit — success,
// validation, backend failure (offline + auth error), the never-stuck
// guarantee, and the two entry modes (profile change vs reset-recovery).
//
// The screen is driven through a real GoRouter with a refreshListenable, so the
// tests reproduce production navigation: updatePassword fires a userUpdated auth
// event, which trips the router refresh. A screen that pops with Navigator (not
// go_router) reappears when that refresh rebuilds the stack — the bug these
// tests guard against.
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:rung/app/providers.dart';
import 'package:rung/data/remote/auth_repository.dart';
import 'package:rung/features/auth/change_password_screen.dart';
import 'package:rung/l10n/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class _Refresh extends ChangeNotifier {
  void bump() => notifyListeners();
}

class _FakeAuth implements AuthRepository {
  _FakeAuth({this.onUpdate, this.onUpdated});
  final Future<void> Function(String)? onUpdate;

  /// Fired (async) after a successful update — mimics the `userUpdated` auth
  /// event that trips the router's refreshListenable in production.
  final VoidCallback? onUpdated;

  /// The password the screen asked the backend to set (null until it succeeds).
  String? updatedTo;
  bool signedOut = false;

  @override
  Future<void> updatePassword(String newPassword) async {
    // onUpdate first: if it throws, updatedTo stays null (the change failed).
    if (onUpdate != null) await onUpdate!(newPassword);
    updatedTo = newPassword;
    if (onUpdated != null) scheduleMicrotask(onUpdated!);
  }

  @override
  Future<void> signOut() async => signedOut = true;

  @override
  dynamic noSuchMethod(Invocation i) => throw UnimplementedError();
}

/// A GoRouter with a launcher route that pushes the screen — matching how the
/// real app reaches it (context.push through go_router).
Widget _app(AuthRepository auth, {Listenable? refresh}) {
  final router = GoRouter(
    refreshListenable: refresh,
    routes: [
      GoRoute(
        path: '/',
        builder: (ctx, _) => Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () => ctx.push('/change'),
              child: const Text('open'),
            ),
          ),
        ),
      ),
      GoRoute(
          path: '/change', builder: (_, _) => const ChangePasswordScreen()),
      // The screen navigates here (Routes.dashboard) on a profile-mode success.
      GoRoute(
          path: '/dashboard',
          builder: (_, _) =>
              const Scaffold(body: Center(child: Text('home')))),
    ],
  );
  return ProviderScope(
    overrides: [authRepositoryProvider.overrideWithValue(auth)],
    child: MaterialApp.router(
      localizationsDelegates: const [
        ...AppLocalizations.localizationsDelegates,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      routerConfig: router,
    ),
  );
}

Future<void> open(WidgetTester tester, AuthRepository auth,
    {Listenable? refresh}) async {
  await tester.binding.setSurfaceSize(const Size(500, 1200));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(_app(auth, refresh: refresh));
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
}

Future<void> fillAndSubmit(WidgetTester tester, String pw) async {
  await tester.enterText(find.byType(TextFormField).at(0), pw);
  await tester.enterText(find.byType(TextFormField).at(1), pw);
  await tester.tap(find.byType(FilledButton));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
}

void main() {
  // The recovery flag is a global — keep it false unless a test opts in, and
  // always reset it so one test can't leak into the next.
  setUp(() => passwordRecoveryActive.value = false);
  tearDown(() => passwordRecoveryActive.value = false);

  testWidgets('mismatched passwords are rejected before any backend call',
      (tester) async {
    final auth = _FakeAuth();
    await open(tester, auth);

    await tester.enterText(find.byType(TextFormField).at(0), 'secret123');
    await tester.enterText(find.byType(TextFormField).at(1), 'different1');
    await tester.tap(find.byType(FilledButton));
    await tester.pump();

    expect(find.text("Passwords don't match"), findsOneWidget);
    expect(auth.updatedTo, isNull);
  });

  testWidgets('a short password is rejected', (tester) async {
    final auth = _FakeAuth();
    await open(tester, auth);

    await tester.enterText(find.byType(TextFormField).at(0), '123');
    await tester.enterText(find.byType(TextFormField).at(1), '123');
    await tester.tap(find.byType(FilledButton));
    await tester.pump();

    expect(find.text('At least 6 characters'), findsWidgets);
    expect(auth.updatedTo, isNull);
  });

  testWidgets(
      'a profile-mode change updates the password and lands on Home — even '
      'after the auth-event router refresh', (tester) async {
    final refresh = _Refresh();
    final auth = _FakeAuth(onUpdated: refresh.bump);
    await open(tester, auth, refresh: refresh);

    await fillAndSubmit(tester, 'newsecret');
    await tester.pumpAndSettle(); // let the refresh fire and rebuild

    expect(auth.updatedTo, 'newsecret');
    expect(auth.signedOut, isFalse, reason: 'a deliberate change keeps the session');
    expect(find.text('Password updated'), findsOneWidget);
    expect(find.byType(ChangePasswordScreen), findsNothing,
        reason: 'the screen must not reappear when the router refreshes');
    expect(find.text('home'), findsOneWidget,
        reason: 'landed on the dashboard, not stuck on change-password');
  });

  testWidgets('reset-recovery mode signs out to force a fresh login',
      (tester) async {
    passwordRecoveryActive.value = true; // simulate arriving via the reset link
    final auth = _FakeAuth();
    await open(tester, auth);

    await fillAndSubmit(tester, 'newsecret');
    await tester.pumpAndSettle();

    expect(auth.updatedTo, 'newsecret', reason: 'the password was changed');
    expect(auth.signedOut, isTrue,
        reason: 'recovery re-authenticates so account isolation runs on login');
    expect(passwordRecoveryActive.value, isFalse, reason: 'the flag is consumed');
    expect(find.text('Password updated'), findsOneWidget);
    expect(find.text('home'), findsNothing,
        reason: 'recovery does NOT drop the user onto the dashboard');
  });

  testWidgets('an offline failure shows the friendly line and never sticks',
      (tester) async {
    final auth = _FakeAuth(
      onUpdate: (_) async => throw AuthRetryableFetchException(
          message: 'ClientException with SocketException: Failed host lookup'),
    );
    await open(tester, auth);

    await fillAndSubmit(tester, 'newsecret');

    expect(find.textContaining("You're offline"), findsOneWidget);
    expect(auth.updatedTo, isNull, reason: 'the change did not go through');
    expect(find.byType(ChangePasswordScreen), findsOneWidget,
        reason: 'still on the screen so the user can retry');
    final button = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(button.onPressed, isNotNull, reason: 'the button re-enabled — not stuck');
  });

  testWidgets('a server auth error is shown verbatim and the button re-enables',
      (tester) async {
    final auth = _FakeAuth(
      onUpdate: (_) async =>
          throw const AuthException('New password should be different'),
    );
    await open(tester, auth);

    await fillAndSubmit(tester, 'newsecret');

    expect(find.text('New password should be different'), findsOneWidget);
    final button = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(button.onPressed, isNotNull);
  });

  testWidgets('the button shows a spinner while the update is in flight',
      (tester) async {
    final gate = Completer<void>();
    final auth = _FakeAuth(onUpdate: (_) => gate.future);
    await open(tester, auth);

    await tester.enterText(find.byType(TextFormField).at(0), 'newsecret');
    await tester.enterText(find.byType(TextFormField).at(1), 'newsecret');
    await tester.tap(find.byType(FilledButton));
    await tester.pump(); // one frame — the update hasn't resolved

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    gate.complete();
    await tester.pumpAndSettle();
  });
}
