/// Backend configuration. The app is local-first and runs fully without these;
/// once a URL + anon key are present, cloud features (accounts, pods, chat)
/// switch on.
///
/// Provide keys either by:
///   1) pasting them into [_inlineUrl] / [_inlineAnonKey] below, or
///   2) passing --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...
/// The anon key is safe to ship in a client (RLS protects the data).
class AppConfig {
  AppConfig._();

  static const _envUrl = String.fromEnvironment('SUPABASE_URL');
  static const _envAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  // ── Paste your Supabase project values here (or use --dart-define) ────────
  static const _inlineUrl = 'https://qrouiinilylxahdyrxsg.supabase.co';
  static const _inlineAnonKey = 'sb_publishable_sQNEil2AjzZQg-yM9fKgEg_8bmj1Wvm';

  static String get supabaseUrl =>
      _envUrl.isNotEmpty ? _envUrl : _inlineUrl;
  static String get supabaseAnonKey =>
      _envAnonKey.isNotEmpty ? _envAnonKey : _inlineAnonKey;

  /// True when both URL and key are present — gates cloud initialization.
  static bool get hasSupabase =>
      supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;

  // ── Analytics (PostHog) — optional; events no-op until a key is present ────
  static const _envPosthogKey = String.fromEnvironment('POSTHOG_KEY');
  static const _inlinePosthogKey = 'phc_xFbsFwfgtpUpq88Ev96BnX2jQkYUYAkYWNjr2WFH7uNF'; // paste your PostHog project API key
  static const _inlinePosthogHost = 'https://us.i.posthog.com';

  static String get posthogKey =>
      _envPosthogKey.isNotEmpty ? _envPosthogKey : _inlinePosthogKey;
  static String get posthogHost => _inlinePosthogHost;
  static bool get hasPosthog => posthogKey.isNotEmpty;

  // ── Payments (RevenueCat) — optional; the simulated tier is used until a key
  // is present. These PUBLIC SDK keys are safe to ship (the store + the server
  // webhook verify entitlements; a client can't fake a purchase).
  static const _envRcIos = String.fromEnvironment('REVENUECAT_IOS_KEY');
  static const _envRcAndroid = String.fromEnvironment('REVENUECAT_ANDROID_KEY');
  static const _inlineRcIos = ''; // appl_…  (RevenueCat → Project → API keys)
  static const _inlineRcAndroid = ''; // goog_…
  /// The RevenueCat entitlement that unlocks Premium.
  static const revenueCatEntitlement = 'premium';

  static String get revenueCatIosKey =>
      _envRcIos.isNotEmpty ? _envRcIos : _inlineRcIos;
  static String get revenueCatAndroidKey =>
      _envRcAndroid.isNotEmpty ? _envRcAndroid : _inlineRcAndroid;
  static bool get hasRevenueCat =>
      revenueCatIosKey.isNotEmpty || revenueCatAndroidKey.isNotEmpty;
}

