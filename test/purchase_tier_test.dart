// Entitlement → tier mapping, and the rule that decides when a fetched tier is
// allowed to overwrite the stored one.
//
// These guard two bugs that shipped in this file's history:
//   1. A failed entitlement lookup (offline, RevenueCat unreachable) resolved to
//      `free` and was written to settings — silently downgrading a PAYING user
//      whenever the network hiccupped at launch. "Unknown" is now null, and null
//      must never overwrite what is stored.
//   2. A purchase whose product wasn't attached to the `premium` entitlement
//      returned `free` while the UI said "Thank you" — money taken, nothing
//      granted. The mapping below is what that check depends on.
import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:rung/core/purchases/purchase_service.dart';
import 'package:rung/domain/entities/subscription.dart';

/// A CustomerInfo whose `premium` entitlement is active for [productId].
/// Pass null for an account with no active entitlement at all.
CustomerInfo _info(String? productId, {String entitlement = 'premium'}) {
  final active = <String, EntitlementInfo>{};
  if (productId != null) {
    active[entitlement] = EntitlementInfo(
      entitlement,
      true, // isActive
      true, // willRenew
      '2026-09-29T00:00:00Z',
      '2026-09-29T00:00:00Z',
      productId,
      true, // isSandbox
    );
  }
  return CustomerInfo(
    EntitlementInfos(active, active),
    const {},
    const [],
    const [],
    const [],
    '2026-09-29T00:00:00Z',
    'user-1',
    const {},
    '2026-09-29T00:00:00Z',
  );
}

void main() {
  group('entitlement → tier', () {
    test('a monthly product grants monthly', () {
      expect(
        PurchaseService.tierFrom(_info('rung_premium_monthly')),
        SubscriptionTier.monthly,
      );
    });

    test('a yearly product grants yearly', () {
      expect(
        PurchaseService.tierFrom(_info('rung_premium_yearly')),
        SubscriptionTier.yearly,
      );
    });

    test('"annual" is treated as yearly', () {
      expect(
        PurchaseService.tierFrom(_info('rung_premium_annual')),
        SubscriptionTier.yearly,
      );
    });

    test('the bare Test Store ids map correctly too', () {
      // RevenueCat's Test Store ships products literally named monthly/yearly;
      // both stores must resolve through the same `premium` entitlement.
      expect(PurchaseService.tierFrom(_info('monthly')), SubscriptionTier.monthly);
      expect(PurchaseService.tierFrom(_info('yearly')), SubscriptionTier.yearly);
    });

    test('a Play base-plan suffix does not break the mapping', () {
      expect(
        PurchaseService.tierFrom(_info('rung_premium_yearly:p1y-autorenew')),
        SubscriptionTier.yearly,
      );
    });

    test('no active entitlement means free', () {
      expect(PurchaseService.tierFrom(_info(null)), SubscriptionTier.free);
    });

    test('an entitlement under another name grants nothing', () {
      // The exact bug hit in testing: products attached to a second entitlement
      // ("test monthly") instead of `premium`. Purchases succeed and grant
      // nothing, so the paywall must not claim success.
      expect(
        PurchaseService.tierFrom(_info('monthly', entitlement: 'test monthly')),
        SubscriptionTier.free,
      );
    });

    test('an active but unrecognised product never over-grants yearly', () {
      // Better to under-grant and hear about it than to hand out the more
      // expensive tier for free.
      expect(
        PurchaseService.tierFrom(_info('lifetime')),
        SubscriptionTier.monthly,
      );
    });
  });

  group('unknown entitlement state must not downgrade', () {
    // Mirrors the guard in purchaseSyncProvider: write only when the fetched
    // value is known.
    SubscriptionTier resolve(SubscriptionTier stored, SubscriptionTier? fetched) =>
        fetched ?? stored;

    test('null keeps a paying subscriber paying', () {
      expect(resolve(SubscriptionTier.yearly, null), SubscriptionTier.yearly);
      expect(resolve(SubscriptionTier.monthly, null), SubscriptionTier.monthly);
    });

    test('a known free result does downgrade — that is a real signal', () {
      expect(
        resolve(SubscriptionTier.yearly, SubscriptionTier.free),
        SubscriptionTier.free,
      );
    });

    test('a known upgrade is applied', () {
      expect(
        resolve(SubscriptionTier.free, SubscriptionTier.yearly),
        SubscriptionTier.yearly,
      );
    });
  });
}
