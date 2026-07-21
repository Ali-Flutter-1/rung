import 'package:supabase_flutter/supabase_flutter.dart';

import 'supabase_bootstrap.dart';

/// Deep link the password-reset email points back at. Must match BOTH the
/// native URL scheme (iOS `CFBundleURLSchemes`, Android intent-filter) AND the
/// "Redirect URLs" allow-list in the Supabase dashboard, or the link won't open
/// the app. Tapping it hands the app a short-lived recovery session and fires
/// an `AuthChangeEvent.passwordRecovery` (see RungApp), which routes the user to
/// the "set a new password" screen.
const passwordResetRedirect = 'com.rung.app://reset-password';

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

  /// Emails a password-reset link to [email]. Best-effort by design: Supabase
  /// never reveals whether an address has an account, so the UI shows the same
  /// confirmation either way (no account-enumeration leak).
  Future<void> resetPassword(String email) async {
    await _auth.resetPasswordForEmail(email, redirectTo: passwordResetRedirect);
  }

  /// Changes the *currently signed-in* user's password. Requires a live
  /// session — this is the in-app "change password", not the forgotten-password
  /// recovery flow above.
  Future<void> updatePassword(String newPassword) async {
    await _auth.updateUser(UserAttributes(password: newPassword));
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
