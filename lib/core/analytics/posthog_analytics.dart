import 'package:posthog_flutter/posthog_flutter.dart';

import 'analytics.dart';

/// PostHog-backed analytics. Every call is guarded so an uninitialized or
/// offline SDK can never crash the app.
class PostHogAnalytics implements Analytics {
  const PostHogAnalytics();

  @override
  void capture(String event, [Map<String, Object?> props = const {}]) {
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
