import 'package:posthog_flutter/posthog_flutter.dart';

import '../config/app_config.dart';

/// Whether the user has opted in to analytics. Captures are dropped unless this
/// is true — even after the SDK is set up — so revoking consent takes effect
/// immediately. Defaults to false: no analytics until an explicit opt-in, which
/// is what GDPR requires for a non-essential tracker like PostHog.
bool analyticsConsentGranted = false;

bool _setupDone = false;

/// Initialize the PostHog SDK once, and only when we actually have consent — so
/// with the default (opted out) the tracker is never even started.
Future<void> _ensureSetup() async {
  if (_setupDone || !AppConfig.hasPosthog) return;
  try {
    final config = PostHogConfig(AppConfig.posthogKey)
      ..host = AppConfig.posthogHost;
    await Posthog().setup(config);
    _setupDone = true;
  } catch (_) {/* analytics must never break boot */}
}

/// Boot-time: honour the stored opt-in. With consent off (the default) the SDK
/// is not initialized at all.
Future<void> initAnalytics({required bool consent}) async {
  analyticsConsentGranted = consent && AppConfig.hasPosthog;
  if (analyticsConsentGranted) await _ensureSetup();
}

/// Runtime opt-in/out from the privacy setting. Turning it on sets the SDK up
/// (first time) and starts capturing; turning it off stops capturing and clears
/// the local anonymous id so nothing further is associated.
Future<void> setAnalyticsConsent(bool on) async {
  analyticsConsentGranted = on && AppConfig.hasPosthog;
  if (analyticsConsentGranted) {
    await _ensureSetup();
  } else {
    try {
      Posthog().reset();
    } catch (_) {}
  }
}
