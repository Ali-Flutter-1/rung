import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/sign_in_screen.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/groups/groups_screen.dart';
import '../features/ladder/ladder_screen.dart';
import '../features/ladder/rung_detail_screen.dart';
import '../features/challenge/predict_screen.dart';
import '../features/challenge/reflect_screen.dart';
import '../features/challenge/result_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/subscription/subscription_screen.dart';
import '../features/tracks/tracks_screen.dart';
import 'app_shell.dart';
import 'providers.dart';

/// Route paths (single source of truth; referenced via `context.go`).
class Routes {
  Routes._();
  static const onboarding = '/onboarding';
  static const auth = '/auth';
  static const dashboard = '/dashboard';
  static const groups = '/groups';
  static const tracks = '/tracks'; // the "Rung" tab
  static const subscription = '/subscription';
  static const profile = '/profile';
  static String ladder(String trackId) => '/tracks/$trackId';
  static String rung(String rungId) => '/rung/$rungId';
  static String predict(String rungId) => '/predict/$rungId';
  static String reflect(String attemptId) => '/reflect/$attemptId';
  static String result(String attemptId) => '/result/$attemptId';
}

final _rootKey = GlobalKey<NavigatorState>();

/// A calm fade-through transition (gentle fade + slight upward slide) for the
/// predict → reflect → result flow, so steps feel connected rather than snapping.
CustomTransitionPage<void> _fade(Widget child) {
  return CustomTransitionPage<void>(
    child: child,
    transitionDuration: const Duration(milliseconds: 280),
    reverseTransitionDuration: const Duration(milliseconds: 220),
    transitionsBuilder: (context, animation, _, child) {
      final curved =
          CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
                  begin: const Offset(0, 0.02), end: Offset.zero)
              .animate(curved),
          child: child,
        ),
      );
    },
  );
}

final routerProvider = Provider<GoRouter>((ref) {
  final settings = ref.watch(settingsRepositoryProvider);
  final auth = ref.watch(authRepositoryProvider);
  final cloudOn = ref.watch(cloudEnabledProvider);
  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: Routes.dashboard,
    refreshListenable: _GateRefresh(
      settings.changes,
      cloudOn ? auth.authChanges() : null,
    ),
    redirect: (context, state) {
      final onboarded = settings.hasCompletedOnboarding;
      // Mandatory account once cloud is configured. (If no Supabase keys, we
      // can't gate, so treat as signed-in and stay local-only.)
      final signedIn = !cloudOn || auth.isSignedIn;
      final loc = state.matchedLocation;
      if (!onboarded) {
        return loc == Routes.onboarding ? null : Routes.onboarding;
      }
      if (!signedIn) {
        return loc == Routes.auth ? null : Routes.auth;
      }
      if (loc == Routes.onboarding || loc == Routes.auth) {
        return Routes.dashboard;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: Routes.onboarding,
        builder: (_, _) => const OnboardingScreen(),
      ),
      GoRoute(
        path: Routes.auth,
        builder: (_, _) => const SignInScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (_, _, shell) => AppShell(shell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: Routes.dashboard,
              builder: (_, _) => const DashboardScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: Routes.tracks,
              builder: (_, _) => const TracksScreen(),
              routes: [
                GoRoute(
                  path: ':trackId',
                  builder: (_, s) =>
                      LadderScreen(trackId: s.pathParameters['trackId']!),
                ),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: Routes.groups,
              builder: (_, _) => const GroupsScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: Routes.subscription,
              builder: (_, _) => const SubscriptionScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: Routes.profile,
              builder: (_, _) => const ProfileScreen(),
            ),
          ]),
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: '/rung/:rungId',
        pageBuilder: (_, s) =>
            _fade(RungDetailScreen(rungId: s.pathParameters['rungId']!)),
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: '/predict/:rungId',
        pageBuilder: (_, s) =>
            _fade(PredictScreen(rungId: s.pathParameters['rungId']!)),
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: '/reflect/:attemptId',
        pageBuilder: (_, s) =>
            _fade(ReflectScreen(attemptId: s.pathParameters['attemptId']!)),
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: '/result/:attemptId',
        pageBuilder: (_, s) =>
            _fade(ResultScreen(attemptId: s.pathParameters['attemptId']!)),
      ),
    ],
  );
});

/// Re-evaluates redirects when settings OR auth state change (sign-in/out).
class _GateRefresh extends ChangeNotifier {
  _GateRefresh(Stream<void> settings, Stream<dynamic>? auth) {
    notifyListeners();
    _subs.add(settings.asBroadcastStream().listen((_) => notifyListeners()));
    if (auth != null) {
      _subs.add(auth.asBroadcastStream().listen((_) => notifyListeners()));
    }
  }
  final _subs = <StreamSubscription<dynamic>>[];

  @override
  void dispose() {
    for (final s in _subs) {
      s.cancel();
    }
    super.dispose();
  }
}
