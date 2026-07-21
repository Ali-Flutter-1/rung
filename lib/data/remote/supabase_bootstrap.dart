import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/config/app_config.dart';
import '../../core/net/timeout_client.dart';

bool _ready = false;

/// Initializes Supabase iff configured. Returns whether cloud is enabled.
/// The app keeps working offline-first when this returns false (§2.2).
Future<bool> initSupabase() async {
  if (!AppConfig.hasSupabase) return false;
  try {
    await Supabase.initialize(
      url: AppConfig.supabaseUrl,
      // Accepts classic anon (eyJ...) or new publishable (sb_publishable_...) keys.
      // ignore: deprecated_member_use
      anonKey: AppConfig.supabaseAnonKey,
      // Implicit flow for the password-reset deep link. PKCE stores a code
      // verifier on the *requesting* device, so the reset link only completes on
      // that same device/install — it fails otherwise (lands the user back on
      // the sign-in screen). Implicit carries the recovery session in the link
      // itself, so it works regardless of where the link is opened and reliably
      // fires passwordRecovery. Normal email/password sign-in doesn't use a
      // redirect, so it's unaffected either way.
      authOptions:
          const FlutterAuthClientOptions(authFlowType: AuthFlowType.implicit),
      // Bound every REST call (auth/db/functions) so a slow network fails fast
      // instead of hanging the UI. Realtime WebSockets are unaffected.
      httpClient: TimeoutHttpClient(http.Client()),
    );
    _ready = true;
  } catch (_) {
    // Never let a bad key / offline first-run brick the app — stay local (§2.2).
    _ready = false;
  }
  return _ready;
}

/// Whether cloud was successfully initialized this session.
bool get supabaseReady => _ready;

/// Convenience accessor — only valid after a successful [initSupabase].
SupabaseClient get supabase => Supabase.instance.client;
