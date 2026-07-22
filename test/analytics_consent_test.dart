// GDPR: analytics must not run without an explicit opt-in. The gate is the
// module-level `analyticsConsentGranted` flag — PostHog is never set up and no
// event is captured unless it's true. (The PostHog SDK's own method-channel
// calls no-op under flutter_test; these tests exercise the consent gate itself.)
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rung/core/analytics/analytics_bootstrap.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // The PostHog SDK talks over this channel; there's no plugin under
  // flutter_test, so stub it to no-op. We're testing the consent gate, not the
  // SDK.
  setUpAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
            const MethodChannel('posthog_flutter'), (_) async => null);
  });

  tearDown(() async => setAnalyticsConsent(false)); // leave opted out

  test('opted out by default — nothing runs until the user chooses', () {
    expect(analyticsConsentGranted, isFalse);
  });

  test('boot with a stored opt-out keeps analytics off', () async {
    await initAnalytics(consent: false);
    expect(analyticsConsentGranted, isFalse);
  });

  test('boot with a stored opt-in turns analytics on', () async {
    await initAnalytics(consent: true);
    expect(analyticsConsentGranted, isTrue);
  });

  test('the runtime toggle flips the gate both ways', () async {
    await setAnalyticsConsent(true);
    expect(analyticsConsentGranted, isTrue);
    await setAnalyticsConsent(false);
    expect(analyticsConsentGranted, isFalse,
        reason: 'revoking consent stops capture immediately');
  });
}
