// Lightweight DTOs for the Supabase community layer.

class CloudPod {
  const CloudPod({
    required this.id,
    required this.name,
    required this.capacity,
    required this.isSystem,
    required this.memberCount,
  });

  final String id;
  final String name;
  final int capacity;
  final bool isSystem;
  final int memberCount;

  factory CloudPod.fromRow(Map<String, dynamic> r) => CloudPod(
        id: r['id'] as String,
        name: (r['name'] ?? 'Pod') as String,
        capacity: (r['capacity'] ?? 25) as int,
        isSystem: (r['is_system'] ?? false) as bool,
        memberCount: (r['member_count'] ?? 0) as int,
      );
}

class CloudProfile {
  const CloudProfile({
    required this.id,
    this.displayName,
    this.bio,
    this.isLocked = false,
    this.climbing = '',
    this.avatarId,
    this.currentStreak = 0,
    this.bestStreak = 0,
    this.totalChallenges = 0,
  });

  final String id;
  final String? displayName;
  final String? bio;
  final bool isLocked;
  final String climbing;
  final String? avatarId;
  final int currentStreak;
  final int bestStreak;
  final int totalChallenges;

  factory CloudProfile.fromRow(Map<String, dynamic> r) => CloudProfile(
        id: r['id'] as String,
        displayName: r['display_name'] as String?,
        bio: r['bio'] as String?,
        isLocked: (r['is_locked'] ?? false) as bool,
        avatarId: r['avatar'] as String?,
        currentStreak: (r['current_streak'] ?? 0) as int,
        bestStreak: (r['best_streak'] ?? 0) as int,
        totalChallenges: (r['total_challenges'] ?? 0) as int,
      );
}

class CloudMessage {
  const CloudMessage({
    required this.id,
    required this.groupId,
    required this.userId,
    required this.body,
    required this.createdAt,
    this.replyTo,
    this.editedAt,
    this.deletedAt,
  });

  final String id;
  final String groupId;
  final String userId;
  final String body;
  final DateTime createdAt;
  final String? replyTo; // id of the message this replies to
  final DateTime? editedAt;
  final DateTime? deletedAt;

  bool get isDeleted => deletedAt != null;
  bool get isEdited => editedAt != null;

  factory CloudMessage.fromRow(Map<String, dynamic> r) => CloudMessage(
        id: r['id'] as String,
        groupId: r['group_id'] as String,
        userId: r['user_id'] as String,
        body: (r['body'] ?? '') as String,
        createdAt:
            DateTime.tryParse('${r['created_at']}')?.toLocal() ?? DateTime(2000),
        replyTo: r['reply_to'] as String?,
        editedAt: r['edited_at'] == null
            ? null
            : DateTime.tryParse('${r['edited_at']}')?.toLocal(),
        deletedAt: r['deleted_at'] == null
            ? null
            : DateTime.tryParse('${r['deleted_at']}')?.toLocal(),
      );
}

/// A single reaction row (one message + one user + one emoji).
class CloudReaction {
  const CloudReaction({
    required this.messageId,
    required this.userId,
    required this.emoji,
  });

  final String messageId;
  final String userId;
  final String emoji;

  factory CloudReaction.fromRow(Map<String, dynamic> r) => CloudReaction(
        messageId: r['message_id'] as String,
        userId: r['user_id'] as String,
        emoji: (r['emoji'] ?? '') as String,
      );
}
