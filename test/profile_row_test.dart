import 'package:flutter_test/flutter_test.dart';
import 'package:rung/data/remote/cloud_repository.dart';
import 'package:rung/domain/entities/subscription.dart';

/// Regression guard for the account-switch stat-wipe bug: an identity-only
/// profile write (sign-in, lock toggle, edit profile, Groups open) must NEVER
/// include stat columns, so it can't overwrite an account's published
/// streak/challenges with zeros after a local reset.
void main() {
  group('buildProfileRow', () {
    test('identity-only write omits all stat columns', () {
      final row = CloudRepository.buildProfileRow(
        id: 'u1',
        displayName: 'Mara',
        bio: 'hi',
        isLocked: true,
        tier: SubscriptionTier.free,
        updatedAt: '2026-06-28T00:00:00Z',
        // no stats supplied
      );

      expect(row['display_name'], 'Mara');
      expect(row['is_locked'], true);
      expect(row.containsKey('current_streak'), isFalse);
      expect(row.containsKey('best_streak'), isFalse);
      expect(row.containsKey('total_challenges'), isFalse);
    });

    test('full write includes stats when provided (even zero)', () {
      final row = CloudRepository.buildProfileRow(
        id: 'u1',
        isLocked: false,
        tier: SubscriptionTier.free,
        updatedAt: '2026-06-28T00:00:00Z',
        currentStreak: 0,
        bestStreak: 3,
        totalChallenges: 2,
      );

      expect(row['current_streak'], 0);
      expect(row['best_streak'], 3);
      expect(row['total_challenges'], 2);
    });
  });
}
