import 'package:supabase_flutter/supabase_flutter.dart';

import 'supabase_bootstrap.dart';

/// Thin wrapper over Supabase Auth. Identity is only needed for Groups — the
/// core loop stays account-free (§1.4).
class AuthRepository {
  const AuthRepository();

  GoTrueClient get _auth => supabase.auth;

  User? get currentUser => supabaseReady ? _auth.currentUser : null;
  bool get isSignedIn => currentUser != null;

  /// Emits on sign-in / sign-out so the UI can react.
  Stream<AuthState> authChanges() => _auth.onAuthStateChange;

  Future<void> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    await _auth.signUp(
      email: email,
      password: password,
      data: displayName == null ? null : {'display_name': displayName},
    );
  }

  Future<void> signIn({required String email, required String password}) async {
    await _auth.signInWithPassword(email: email, password: password);
  }

  /// Signs out. The Supabase SDK clears the local session first, then tries to
  /// revoke it server-side — that revoke throws when offline. We swallow it:
  /// the local session is already gone, so the user IS signed out, and the
  /// stale server token expires on its own. Without this, logging out with no
  /// connection crashes the app.
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (_) {
      // Offline / server unreachable — local session already cleared.
    }
  }
}
