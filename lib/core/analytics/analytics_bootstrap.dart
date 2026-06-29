import 'package:posthog_flutter/posthog_flutter.dart';

import '../config/app_config.dart';

/// Initializes PostHog iff a key is configured. Safe no-op otherwise.
Future<bool> initAnalytics() async {
  if (!AppConfig.hasPosthog) return false;
  try {
    final config = PostHogConfig(AppConfig.posthogKey)
      ..host = AppConfig.posthogHost;
    await Posthog().setup(config);
    return true;
  } catch (_) {
    return false;
  }
}
