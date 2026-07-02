import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../domain/entities/subscription.dart';
import '../config/app_config.dart';

/// True once RevenueCat configured this session — gates all purchase work so
/// the app runs fine (with the simulated tier) when no key is present.
bool purchasesReady = false;

/// Self-guarding RevenueCat init — called from main(). Never throws.
Future<void> initPurchases() async {
  final key = defaultTargetPlatform == TargetPlatform.iOS
      ? AppConfig.revenueCatIosKey
      : AppConfig.revenueCatAndroidKey;
  if (key.isEmpty) {
    purchasesReady = false;
    return;
  }
  try {
    if (kDebugMode) await Purchases.setLogLevel(LogLevel.debug);
    await Purchases.configure(PurchasesConfiguration(key));
    purchasesReady = true;
  } catch (e) {
    if (kDebugMode) debugPrint('[iap] configure failed: $e');
    purchasesReady = false;
  }
}

/// Raised when the user backs out of the store sheet — not an error to surface.
class PurchaseCancelled implements Exception {
  const PurchaseCancelled();
}

/// Thin wrapper over the RevenueCat SDK. Maps entitlements to [SubscriptionTier]
/// and exposes offerings / purchase / restore. All methods no-op safely when
/// [purchasesReady] is false.
class PurchaseService {
  const PurchaseService();

  /// Maps the active RevenueCat entitlement to our tier (monthly vs yearly is
  /// read from the product identifier, so name your products with month/year).
  static SubscriptionTier tierFrom(CustomerInfo info) {
    final ent = info.entitlements.active[AppConfig.revenueCatEntitlement];
    if (ent == null) return SubscriptionTier.free;
    final pid = ent.productIdentifier.toLowerCase();
    if (pid.contains('year') || pid.contains('annual')) {
      return SubscriptionTier.yearly;
    }
    if (pid.contains('month')) return SubscriptionTier.monthly;
    return SubscriptionTier.monthly; // active but unrecognised → assume monthly
  }

  /// Ties purchases to the signed-in user so the webhook knows who bought.
  /// Returns their current entitlement tier.
  Future<SubscriptionTier> syncUser(String uid) async {
    if (!purchasesReady) return SubscriptionTier.free;
    try {
      final res = await Purchases.logIn(uid);
      return tierFrom(res.customerInfo);
    } catch (e) {
      if (kDebugMode) debugPrint('[iap] logIn failed: $e');
      return SubscriptionTier.free;
    }
  }

  Future<SubscriptionTier> currentTier() async {
    if (!purchasesReady) return SubscriptionTier.free;
    try {
      return tierFrom(await Purchases.getCustomerInfo());
    } catch (_) {
      return SubscriptionTier.free;
    }
  }

  /// The current offering's packages (with live, localized prices).
  Future<Offering?> currentOffering() async {
    if (!purchasesReady) return null;
    try {
      return (await Purchases.getOfferings()).current;
    } catch (e) {
      if (kDebugMode) debugPrint('[iap] offerings failed: $e');
      return null;
    }
  }

  /// Buys a package. Returns the resulting tier, or throws [PurchaseCancelled].
  Future<SubscriptionTier> buy(Package package) async {
    try {
      final result = await Purchases.purchase(PurchaseParams.package(package));
      return tierFrom(result.customerInfo);
    } on PlatformException catch (e) {
      final code = PurchasesErrorHelper.getErrorCode(e);
      if (code == PurchasesErrorCode.purchaseCancelledError) {
        throw const PurchaseCancelled();
      }
      rethrow;
    }
  }

  /// Restores prior purchases (App Store requires a restore path).
  Future<SubscriptionTier> restore() async {
    if (!purchasesReady) return SubscriptionTier.free;
    return tierFrom(await Purchases.restorePurchases());
  }

  /// Detaches the user on sign-out.
  Future<void> logOut() async {
    if (!purchasesReady) return;
    try {
      await Purchases.logOut();
    } catch (_) {}
  }

  /// Fires whenever entitlements change (renewal, expiry, restore, another
  /// device). Returns the subscription so it can be cancelled.
  void addTierListener(void Function(SubscriptionTier) onTier) {
    if (!purchasesReady) return;
    Purchases.addCustomerInfoUpdateListener((info) => onTier(tierFrom(info)));
  }
}
