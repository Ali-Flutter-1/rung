import '../../domain/entities/subscription.dart';
import 'cloud_models.dart';
import 'supabase_bootstrap.dart';

/// Community data layer over Supabase (pods, members, chat, profile sync).
/// Capacity + per-tier join limits are enforced server-side by the RPCs
/// (`join_group`, `ensure_system_pod`); this client just calls them.
class CloudRepository {
  const CloudRepository();

  String? get _uid => supabase.auth.currentUser?.id;
  bool get isSignedIn => _uid != null;

  // ── Profile sync ────────────────────────────────────────────────────────
  /// Upserts the signed-in user's profile. Stat columns are written ONLY when
  /// non-null — an identity-only write (name/bio/lock) must never clobber an
  /// account's published streak/challenges with zeros, which is exactly what
  /// happened right after an account switch wiped local progress.
  Future<void> upsertProfile({
    String? displayName,
    String? bio,
    required bool isLocked,
    required SubscriptionTier tier,
    int? currentStreak,
    int? bestStreak,
    int? totalChallenges,
  }) async {
    final uid = _uid;
    if (uid == null) return;
    final row = buildProfileRow(
      id: uid,
      displayName: displayName,
      bio: bio,
      isLocked: isLocked,
      tier: tier,
      updatedAt: DateTime.now().toUtc().toIso8601String(),
      currentStreak: currentStreak,
      bestStreak: bestStreak,
      totalChallenges: totalChallenges,
    );
    await supabase.from('profiles').upsert(row);
  }

  /// Builds the `profiles` upsert payload. Pure + static so the
  /// "identity write never clobbers stats" invariant is unit-testable:
  /// stat columns are present ONLY when their value is non-null.
  static Map<String, dynamic> buildProfileRow({
    required String id,
    String? displayName,
    String? bio,
    required bool isLocked,
    required SubscriptionTier tier,
    required String updatedAt,
    int? currentStreak,
    int? bestStreak,
    int? totalChallenges,
  }) {
    final row = <String, dynamic>{
      'id': id,
      'display_name': displayName,
      'bio': bio,
      'is_locked': isLocked,
      'subscription_tier': tier.id,
      'updated_at': updatedAt,
    };
    if (currentStreak != null) row['current_streak'] = currentStreak;
    if (bestStreak != null) row['best_streak'] = bestStreak;
    if (totalChallenges != null) row['total_challenges'] = totalChallenges;
    return row;
  }

  Future<CloudProfile?> getProfile(String userId) async {
    final rows = await supabase.from('profiles').select().eq('id', userId);
    if (rows.isEmpty) return null;
    return CloudProfile.fromRow(rows.first);
  }

  // ── Pods ──────────────────────────────────────────────────────────────────
  /// Ensures the user has a system-assigned starter pod. Returns its id.
  Future<String> ensureSystemPod() async {
    final id = await supabase.rpc('ensure_system_pod');
    return id as String;
  }

  Future<List<CloudPod>> myPods() async {
    final rows = await supabase.rpc('my_pods') as List;
    return rows
        .map((r) => CloudPod.fromRow(Map<String, dynamic>.from(r as Map)))
        .toList();
  }

  Future<List<CloudPod>> discoverPods() async {
    final rows = await supabase.rpc('discover_pods') as List;
    return rows
        .map((r) => CloudPod.fromRow(Map<String, dynamic>.from(r as Map)))
        .toList();
  }

  /// Joins a pod via the server-side RPC (enforces capacity + tier limit).
  /// Throws a [CloudJoinException] with a friendly message on rejection.
  Future<void> joinPod(String groupId) async {
    try {
      await supabase.rpc('join_group', params: {'gid': groupId});
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('pod is full')) {
        throw const CloudJoinException('That pod just filled up.');
      }
      if (msg.contains('pod limit reached')) {
        throw const CloudJoinException(
            'You\'ve hit your pod limit — upgrade to join more.');
      }
      throw const CloudJoinException('Could not join that pod. Try again.');
    }
  }

  /// Removes the signed-in user from a pod (their own membership only).
  Future<void> leavePod(String groupId) =>
      supabase.rpc('leave_group', params: {'gid': groupId});

  /// Server-side matchmaking for "Join another pod": returns the id of a
  /// joinable discoverable pod (creating a fresh, uniquely-named one if all are
  /// full). The caller still joins via [joinPod] so tier/capacity are enforced.
  Future<String> matchDiscoverPod() async =>
      await supabase.rpc('match_discover_pod') as String;

  /// Permanently deletes the signed-in user's account and ALL their cloud data
  /// (cascades from auth.users). Irreversible.
  Future<void> deleteAccount() => supabase.rpc('delete_my_account');

  // ── Push tokens ──────────────────────────────────────────────────────────
  /// Registers this device's FCM token for the signed-in user (upsert by token,
  /// so switching accounts on one device reassigns it).
  Future<void> upsertDeviceToken(String token, String platform) async {
    final uid = _uid;
    if (uid == null) return;
    await supabase.from('device_tokens').upsert({
      'token': token,
      'user_id': uid,
      'platform': platform,
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    }, onConflict: 'token');
  }

  Future<void> deleteDeviceToken(String token) =>
      supabase.from('device_tokens').delete().eq('token', token);

  /// User ids in a pod. (Locked members still appear here; their profile is
  /// just hidden by RLS when fetched.)
  Future<List<String>> podMemberIds(String groupId) async {
    final rows =
        await supabase.from('group_members').select('user_id').eq('group_id', groupId);
    return rows.map((r) => r['user_id'] as String).toList();
  }

  /// Visible profiles for a pod (locked members are omitted by RLS).
  Future<Map<String, CloudProfile>> visibleProfiles(List<String> userIds) async {
    if (userIds.isEmpty) return {};
    final rows = await supabase.from('profiles').select().inFilter('id', userIds);
    final map = <String, CloudProfile>{};
    for (final r in rows) {
      final p = CloudProfile.fromRow(r);
      map[p.id] = p;
    }
    return map;
  }

  // ── Chat ────────────────────────────────────────────────────────────────
  /// Newest-first stream of the latest [limit] messages (paginated). The chat
  /// renders this in a `reverse: true` list → newest pinned to the bottom,
  /// scroll up for older. Raise [limit] to load older messages.
  Stream<List<CloudMessage>> watchMessages(String groupId, {int limit = 20}) {
    return supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('group_id', groupId)
        .order('created_at', ascending: false) // newest first
        .limit(limit)
        .map((rows) => rows.map(CloudMessage.fromRow).toList());
  }

  Future<void> sendMessage(String groupId, String body) async {
    final uid = _uid;
    if (uid == null) return;
    try {
      await supabase.from('messages').insert({
        'group_id': groupId,
        'user_id': uid,
        'body': body,
      });
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('rate_limited')) {
        throw const CloudActionException(
            'Take a breath — that\'s a lot of messages very fast.');
      }
      // RLS: not a member of this pod (e.g. membership lapsed / not joined).
      if (msg.contains('row-level security') || msg.contains('42501')) {
        throw const CloudActionException(
            "You're not in this pod — reopen Groups to rejoin.");
      }
      throw const CloudActionException('Could not send. Try again.');
    }
  }

  // ── Moderation (Phase 2 safety) ─────────────────────────────────────────
  Future<void> blockUser(String userId) =>
      supabase.rpc('block_user', params: {'target': userId});

  Future<void> unblockUser(String userId) =>
      supabase.rpc('unblock_user', params: {'target': userId});

  Future<void> reportMessage(String messageId, String reason) =>
      supabase.rpc('report_message', params: {'mid': messageId, 'why': reason});

  Future<void> reportUser(String userId, String groupId, String reason) =>
      supabase.rpc('report_user',
          params: {'target': userId, 'gid': groupId, 'why': reason});

  // ── Progress backup (numbers only — never note text) ────────────────────
  Future<void> pushBackupAttempts(List<Map<String, dynamic>> rows) async {
    final uid = _uid;
    if (uid == null || rows.isEmpty) return;
    final withUser = [
      for (final r in rows) {...r, 'user_id': uid},
    ];
    await supabase.from('backup_attempts').upsert(withUser, onConflict: 'id');
  }

  Future<void> pushBackupProgress(List<Map<String, dynamic>> rows) async {
    final uid = _uid;
    if (uid == null || rows.isEmpty) return;
    final withUser = [
      for (final r in rows) {...r, 'user_id': uid},
    ];
    await supabase
        .from('backup_progress')
        .upsert(withUser, onConflict: 'user_id,track_id');
  }

  Future<List<Map<String, dynamic>>> fetchBackupAttempts(int sinceMs) async {
    final uid = _uid;
    if (uid == null) return [];
    final rows = await supabase
        .from('backup_attempts')
        .select()
        .eq('user_id', uid)
        .gt('updated_at', sinceMs);
    return rows.cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> fetchBackupProgress(int sinceMs) async {
    final uid = _uid;
    if (uid == null) return [];
    final rows = await supabase
        .from('backup_progress')
        .select()
        .eq('user_id', uid)
        .gt('updated_at', sinceMs);
    return rows.cast<Map<String, dynamic>>();
  }

  // ── Global content (tracks + rungs) ─────────────────────────────────────
  /// Fetches the canonical tracks. Read-only; cached into local SQLite.
  Future<List<Map<String, dynamic>>> fetchContentTracks() async {
    final rows = await supabase.from('content_tracks').select();
    return rows.cast<Map<String, dynamic>>();
  }

  /// Fetches the canonical rungs (all tiers' depth). Read-only; cached locally
  /// and then gated per subscription tier on-device.
  Future<List<Map<String, dynamic>>> fetchContentRungs() async {
    final rows = await supabase.from('content_rungs').select();
    return rows.cast<Map<String, dynamic>>();
  }

  // ── Custom rungs (per-user content) ─────────────────────────────────────
  /// Pushes the user's custom rungs. A server trigger enforces the free-tier
  /// cap (5); a [CloudActionException] surfaces if it's exceeded.
  Future<void> pushCustomRungs(List<Map<String, dynamic>> rows) async {
    final uid = _uid;
    if (uid == null || rows.isEmpty) return;
    final withUser = [
      for (final r in rows) {...r, 'user_id': uid},
    ];
    try {
      await supabase
          .from('custom_rungs')
          .upsert(withUser, onConflict: 'id');
    } catch (e) {
      if (e.toString().contains('custom_rung_limit')) {
        throw const CloudActionException(
            'Free plan keeps 5 custom rungs — upgrade for unlimited.');
      }
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> fetchCustomRungs(int sinceMs) async {
    final uid = _uid;
    if (uid == null) return [];
    final rows = await supabase
        .from('custom_rungs')
        .select()
        .eq('user_id', uid)
        .gt('updated_at', sinceMs);
    return rows.cast<Map<String, dynamic>>();
  }

  /// Whether this account has any backed-up progress (→ restore is possible).
  Future<bool> hasBackup() async {
    final uid = _uid;
    if (uid == null) return false;
    final a = await supabase
        .from('backup_attempts')
        .select('id')
        .eq('user_id', uid)
        .limit(1);
    if (a.isNotEmpty) return true;
    final p = await supabase
        .from('backup_progress')
        .select('track_id')
        .eq('user_id', uid)
        .limit(1);
    return p.isNotEmpty;
  }
}

class CloudActionException implements Exception {
  const CloudActionException(this.message);
  final String message;
  @override
  String toString() => message;
}

class CloudJoinException implements Exception {
  const CloudJoinException(this.message);
  final String message;
  @override
  String toString() => message;
}
