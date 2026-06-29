import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/config/app_config.dart';

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
