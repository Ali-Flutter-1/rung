// Lightweight DTOs for the Supabase community layer.

class CloudPod {
  const CloudPod({
    required this.id,
    required this.name,
    required this.capacity,
    required this.isSystem,
    required this.memberCount,
    this.unreadCount = 0,
  });

  final String id;
  final String name;
  final int capacity;
  final bool isSystem;
  final int memberCount;
  final int unreadCount;

  /// For the local "last seen pods" cache (instant Groups render on open).
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'capacity': capacity,
        'is_system': isSystem,
        'member_count': memberCount,
        'unread_count': unreadCount,
      };

  factory CloudPod.fromRow(Map<String, dynamic> r) => CloudPod(
        id: r['id'] as String,
        name: (r['name'] ?? 'Pod') as String,
        capacity: ((r['capacity'] ?? 25) as num).toInt(),
        isSystem: (r['is_system'] ?? false) as bool,
        memberCount: ((r['member_count'] ?? 0) as num).toInt(),
        unreadCount: ((r['unread_count'] ?? 0) as num).toInt(),
      );
}

class CloudPodPrompt {
  const CloudPodPrompt({
    required this.id,
    required this.groupId,
    required this.dayKey,
    required this.prompt,
  });

  final String id;
  final String groupId;
  final String dayKey;
  final String prompt;

  factory CloudPodPrompt.fromRow(Map<String, dynamic> r) => CloudPodPrompt(
        id: r['id'] as String,
        groupId: r['group_id'] as String,
        dayKey: (r['day_key'] ?? '') as String,
        prompt: (r['prompt'] ?? '') as String,
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
    this.isPremium = false,
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
  final bool isPremium; // subscription_tier != 'free' (for the pod badge)
  final int currentStreak;
  final int bestStreak;
  final int totalChallenges;

  factory CloudProfile.fromRow(Map<String, dynamic> r) => CloudProfile(
        id: r['id'] as String,
        displayName: r['display_name'] as String?,
        bio: r['bio'] as String?,
        isLocked: (r['is_locked'] ?? false) as bool,
        avatarId: r['avatar'] as String?,
        isPremium: ((r['subscription_tier'] ?? 'free') as String) != 'free',
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
