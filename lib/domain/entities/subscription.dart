/// Premium tier. Until real in-app purchases exist this is a local flag the
/// Premium screen can set, so the group rules are testable end-to-end.
enum SubscriptionTier { free, monthly, yearly }

extension SubscriptionTierX on SubscriptionTier {
  String get id => name;
  static SubscriptionTier fromId(String? v) => SubscriptionTier.values
      .firstWhere((t) => t.name == v, orElse: () => SubscriptionTier.free);

  bool get isPremium => this != SubscriptionTier.free;

  String get label => switch (this) {
        SubscriptionTier.free => 'Free',
        SubscriptionTier.monthly => 'Premium · Monthly',
        SubscriptionTier.yearly => 'Premium · Yearly',
      };
}

/// Content access keyed off the user's subscription tier.
///
/// Rung depth per track: free 10 / monthly 40 / yearly 60. These cap how many
/// of a track's *seeded* rungs are visible — the list is always
/// `min(limit, rungs that exist)`, so tiers "unlock" depth as more content is
/// authored. Custom rungs the user creates are separate: free is capped at 5,
/// paid is unlimited.
class ContentRules {
  const ContentRules._();

  /// Visible seeded rungs per track for this tier.
  static int maxRungsPerTrack(SubscriptionTier tier) => switch (tier) {
        SubscriptionTier.free => 5,
        SubscriptionTier.monthly => 30,
        SubscriptionTier.yearly => 40,
      };

  /// Custom rungs a user may create. For free this is an all-time total; for
  /// paid tiers it's an allowance PER CALENDAR MONTH (yearly = 40/mo ≈ 480/yr).
  static int maxCustomRungs(SubscriptionTier tier) => switch (tier) {
        SubscriptionTier.free => 5,
        SubscriptionTier.monthly => 30,
        SubscriptionTier.yearly => 40,
      };

  /// Whether the custom-rung cap is counted per calendar month (paid) instead
  /// of as an all-time total (free).
  static bool customRungCapIsMonthly(SubscriptionTier tier) => tier.isPremium;

  /// Whether the tier can add one more custom rung given how many already count
  /// against the cap in the relevant window (all-time for free, this month for
  /// paid).
  static bool canAddCustomRung(SubscriptionTier tier, int countInWindow) =>
      countInWindow < maxCustomRungs(tier);
}

/// Business rules for pods (groups) keyed off the user's subscription tier.
class GroupRules {
  const GroupRules._();

  /// Max pods a user may belong to. `null` = unlimited (yearly).
  static int? maxGroups(SubscriptionTier tier) => switch (tier) {
        SubscriptionTier.free => 1,
        SubscriptionTier.monthly => 3,
        SubscriptionTier.yearly => null, // unlimited
      };

  /// Pod member capacity available to a user of this tier.
  /// Free users sit in smaller pods (≤25); subscribers get larger pods (≤50).
  static int podCapacity(SubscriptionTier tier) =>
      tier.isPremium ? 50 : 25;

  /// Whether the user can join one more pod given how many they're in now.
  static bool canJoinAnother(SubscriptionTier tier, int currentCount) {
    final max = maxGroups(tier);
    return max == null || currentCount < max;
  }

  static String maxGroupsLabel(SubscriptionTier tier) {
    final max = maxGroups(tier);
    return max == null ? 'unlimited pods' : '$max ${max == 1 ? 'pod' : 'pods'}';
  }
}
