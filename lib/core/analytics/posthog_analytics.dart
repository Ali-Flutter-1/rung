import 'package:posthog_flutter/posthog_flutter.dart';

import 'analytics.dart';
import 'analytics_bootstrap.dart';

/// PostHog-backed analytics. Every call is guarded so an uninitialized or
/// offline SDK can never crash the app. Capture and identify additionally
/// no-op unless the user has opted in ([analyticsConsentGranted]) — the GDPR
/// gate: nothing is sent until explicit consent, and it stops the moment
/// consent is revoked.
class PostHogAnalytics implements Analytics {
  const PostHogAnalytics();

  @override
  void capture(String event, [Map<String, Object?> props = const {}]) {
    if (!analyticsConsentGranted) return;
    try {
      final clean = <String, Object>{
        for (final e in props.entries)
          if (e.value != null) e.key: e.value!,
      };
      Posthog().capture(eventName: event, properties: clean);
    } catch (_) {/* analytics must never break the app */}
  }

  @override
  void identify(String userId) {
    if (!analyticsConsentGranted) return;
    try {
      Posthog().identify(userId: userId);
    } catch (_) {}
  }

  @override
  void reset() {
    try {
      Posthog().reset();
    } catch (_) {}
  }
}
