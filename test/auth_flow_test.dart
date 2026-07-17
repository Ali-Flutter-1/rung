// Sign-up / sign-in screen: validation and error mapping.
//
// Scope note: these cover everything that happens BEFORE a session exists —
// which is all of it that can run without a live Supabase. The success path
// (_handleAccountSession) reaches the real backend, and logout/delete-account
// call Supabase RPCs through a global singleton, so those are integration
// concerns, not unit-testable here.
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rung/app/providers.dart';
import 'package:rung/data/remote/auth_repository.dart';
import 'package:rung/features/auth/sign_in_screen.dart';
import 'package:rung/l10n/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Never signed in, so the success path (which needs a real backend) is never
/// reached. [onAuth] decides how signIn/signUp behave.
class _FakeAuth implements AuthRepository {
  _FakeAuth({this.onAuth});
  final Future<void> Function()? onAuth;

  @override
  User? get currentUser => null;

  @override
  bool get isSignedIn => false;

  @override
  Future<void> signIn({required String email, required String password}) async {
    if (onAuth != null) await onAuth!();
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    if (onAuth != null) await onAuth!();
  }

  @override
  dynamic noSuchMethod(Invocation i) => throw UnimplementedError();
}

Widget _app(AuthRepository auth) => ProviderScope(
      overrides: [authRepositoryProvider.overrideWithValue(auth)],
      child: const MaterialApp(
        localizationsDelegates: [
          ...AppLocalizations.localizationsDelegates,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale('en'),
        home: SignInScreen(),
      ),
    );

/// The screen opens in sign-up mode; this flips it to sign-in.
Future<void> switchToSignIn(WidgetTester tester) async {
  await tester.tap(find.text('I already have an account'));
  await tester.pumpAndSettle();
}

/// The form lives in a ListView, which lazily builds only what is visible. The
/// default 800x600 test surface cuts off the submit button, so give it room.
Future<void> pumpAuth(WidgetTester tester, AuthRepository auth) async {
  await tester.binding.setSurfaceSize(const Size(500, 1600));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(_app(auth));
  await tester.pumpAndSettle();
}

Future<void> submit(WidgetTester tester) async {
  await tester.tap(find.byType(FilledButton));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
}

void main() {
  group('mode toggle', () {
    testWidgets('opens on sign-up and can switch to sign-in', (tester) async {
      await pumpAuth(tester, _FakeAuth());

      expect(find.text('Create your account'), findsOneWidget);
      expect(find.text('Confirm password'), findsOneWidget);

      await switchToSignIn(tester);

      expect(find.text('Welcome back'), findsOneWidget);
      expect(find.text('Confirm password'), findsNothing,
          reason: 'sign-in has no confirm field');
    });
  });

  group('validation runs before any network call', () {
    testWidgets('empty email is rejected', (tester) async {
      await pumpAuth(tester, _FakeAuth());
      await submit(tester);
      expect(find.text('Enter your email'), findsOneWidget);
    });

    testWidgets('a malformed email is rejected', (tester) async {
      await pumpAuth(tester, _FakeAuth());

      await tester.enterText(find.byType(TextFormField).at(1), 'not-an-email');
      await submit(tester);
      expect(find.text('That email doesn\'t look right'), findsOneWidget);
    });

    testWidgets('a short password is rejected', (tester) async {
      await pumpAuth(tester, _FakeAuth());

      await tester.enterText(find.byType(TextFormField).at(1), 'a@b.com');
      await tester.enterText(find.byType(TextFormField).at(2), '123');
      await submit(tester);
      expect(find.text('At least 6 characters'), findsWidgets);
    });

    testWidgets('sign-up rejects mismatched passwords', (tester) async {
      await pumpAuth(tester, _FakeAuth());

      await tester.enterText(find.byType(TextFormField).at(1), 'a@b.com');
      await tester.enterText(find.byType(TextFormField).at(2), 'secret123');
      await tester.enterText(find.byType(TextFormField).at(3), 'different');
      await submit(tester);
      expect(find.text('Passwords don\'t match'), findsOneWidget);
    });

    testWidgets('a bad form never calls the backend', (tester) async {
      var called = false;
      await pumpAuth(tester, _FakeAuth(onAuth: () async {
        called = true;
      }));

      await submit(tester); // empty form
      expect(called, isFalse);
    });
  });

  group('error mapping', () {
    Future<void> pumpWithError(WidgetTester tester, Object error) async {
      await pumpAuth(tester, _FakeAuth(onAuth: () async => throw error));
      await switchToSignIn(tester);
      await tester.enterText(find.byType(TextFormField).at(0), 'a@b.com');
      await tester.enterText(find.byType(TextFormField).at(1), 'secret123');
      await submit(tester);
    }

    testWidgets('offline shows the friendly offline line, not a raw error',
        (tester) async {
      // AuthRetryableFetchException IS an AuthException, so it used to fall into
      // the `on AuthException` branch and print its raw "Failed host lookup"
      // message — leaking the Supabase URL onto the login screen.
      await pumpWithError(
        tester,
        AuthRetryableFetchException(
          message: "ClientException with SocketException: Failed host lookup: "
              "'proj.supabase.co'",
        ),
      );

      expect(find.textContaining("You're offline"), findsOneWidget);
      expect(find.textContaining('Failed host lookup'), findsNothing,
          reason: 'the raw exception must never reach the user');
      expect(find.textContaining('supabase.co'), findsNothing,
          reason: 'the project URL must not leak');
    });

    testWidgets('a real auth error shows the server message', (tester) async {
      await pumpWithError(tester, const AuthException('Invalid login credentials'));
      expect(find.text('Invalid login credentials'), findsOneWidget,
          reason: 'genuine auth failures must stay specific and actionable');
    });

    testWidgets('an unknown error shows the generic message', (tester) async {
      await pumpWithError(tester, StateError('something odd'));
      expect(find.textContaining('Something went wrong'), findsOneWidget);
      expect(find.textContaining('something odd'), findsNothing);
    });

    testWidgets('the button re-enables after a failure so the user can retry',
        (tester) async {
      await pumpWithError(tester, const AuthException('Invalid login credentials'));
      final button = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(button.onPressed, isNotNull);
    });
  });

  group('email confirmation', () {
    testWidgets('sign-up with no session tells the user to confirm their email',
        (tester) async {
      // Supabase with "Confirm email" ON: signUp succeeds but creates NO
      // session — the exact state that made Groups say "sign in" earlier.
      await pumpAuth(tester, _FakeAuth()); // succeeds, isSignedIn = false

      await tester.enterText(find.byType(TextFormField).at(1), 'a@b.com');
      await tester.enterText(find.byType(TextFormField).at(2), 'secret123');
      await tester.enterText(find.byType(TextFormField).at(3), 'secret123');
      await submit(tester);

      expect(find.textContaining('Check your email'), findsOneWidget);
    });
  });
}
