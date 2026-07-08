/// Stable analytics event taxonomy. Rename with care — historical funnels
/// break if event names change (spec §11.7). Add new names; don't repurpose.
class Ev {
  Ev._();
  static const onboardingComplete = 'onboarding_complete';
  static const predictStarted = 'predict_started';
  static const reflectCompleted = 'reflect_completed';
  static const rungCleared = 'rung_cleared';
  static const insightViewed = 'insight_viewed';
  static const podOpened = 'pod_opened';
  static const messageSent = 'message_sent';
  static const paywallViewed = 'paywall_viewed';
  static const subscribeTapped = 'subscribe_tapped';
  static const reminderEnabled = 'reminder_enabled';
  static const checkInCompleted = 'check_in_completed';
  static const rateOpened = 'rate_opened';
  static const ratingSubmitted = 'rating_submitted';
}

/// The analytics seam — privacy-respecting. NEVER pass note/reflection text or
/// other PII as properties (spec §2.6): only counts, ids, enums, durations.
abstract interface class Analytics {
  void capture(String event, [Map<String, Object?> props]);
  void identify(String userId);
  void reset();
}

/// Default implementation when analytics is not configured — does nothing.
class NoopAnalytics implements Analytics {
  const NoopAnalytics();
  @override
  void capture(String event, [Map<String, Object?> props = const {}]) {}
  @override
  void identify(String userId) {}
  @override
  void reset() {}
}
