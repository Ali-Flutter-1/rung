import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';

/// Pushes ONLY identity (name, bio, lock, tier) to the Supabase `profiles` row.
/// Never touches the stat columns, so it is safe to call right after an account
/// switch wiped local progress — it cannot zero an account's published
/// streak/challenges. Use for sign-in, lock toggle, and profile edits.
Future<void> pushIdentityToCloud(WidgetRef ref) async {
  if (!ref.read(cloudEnabledProvider)) return;
  final s = ref.read(settingsRepositoryProvider);
  final cloud = ref.read(cloudRepositoryProvider);
  try {
    await cloud.upsertProfile(
      displayName: s.displayName,
      bio: s.bio,
      isLocked: s.profileLocked,
      tier: s.subscriptionTier,
      avatarId: s.avatarId,
    );
  } catch (e) {
    if (kDebugMode) debugPrint('[profile] identity push failed: $e');
  }
}

/// Pushes identity AND aggregate stats (streak, challenges). Call this ONLY
/// where the local progress is genuinely this account's own truth — i.e. after
/// completing a rung. Calling it right after a reset would publish zeros.
Future<void> pushProfileToCloud(WidgetRef ref) async {
  if (!ref.read(cloudEnabledProvider)) return;
  final s = ref.read(settingsRepositoryProvider);
  final prog = ref.read(progressRepositoryProvider);
  final cloud = ref.read(cloudRepositoryProvider);
  try {
    final streak = await prog.currentStreak();
    final best = await prog.bestStreak();
    final challenges = await prog.totalRungsCleared();
    await cloud.upsertProfile(
      displayName: s.displayName,
      bio: s.bio,
      isLocked: s.profileLocked,
      tier: s.subscriptionTier,
      avatarId: s.avatarId,
      currentStreak: streak,
      bestStreak: best,
      totalChallenges: challenges,
    );
  } catch (e) {
    if (kDebugMode) debugPrint('[profile] stats push failed: $e');
  }
}
