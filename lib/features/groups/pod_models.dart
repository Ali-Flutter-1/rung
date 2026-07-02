import 'package:flutter/material.dart';

/// A pod member (sample data for the UI shell). Mirrors the eventual Supabase
/// `profiles` join — `locked` maps to `profiles.is_locked`.
class Member {
  const Member({
    required this.name,
    this.bio = '',
    this.locked = false,
    this.you = false,
    this.climbing = '',
    this.avatarId,
    this.streak = 0,
    this.challenges = 0,
  });

  final String name;
  final String bio;
  final bool locked;
  final bool you;
  final String? avatarId;

  /// What track they're climbing (shown in the detail sheet).
  final String climbing;

  /// Public stats shown on the member sheet (when not locked).
  final int streak;
  final int challenges;

  String get initial => name.isEmpty ? '?' : name.characters.first.toUpperCase();
}

/// A pod (group). `capacity` is set by the owning user's tier (25 free / 50
/// premium). Sample data until Supabase realtime is live.
class Pod {
  const Pod({
    required this.name,
    required this.blurb,
    required this.members,
    required this.capacity,
    this.system = false,
  });

  final String name;
  final String blurb;
  final List<Member> members;
  final int capacity;

  /// The first pod is system-assigned (random members) and can't be left.
  final bool system;

  int get memberCount => members.length;
}

/// Sample roster used across the Groups shell.
const sampleMembers = <Member>[
  Member(name: 'Mara', bio: 'Coffee-shop conversations are my Everest.', climbing: 'Approaching people'),
  Member(name: 'Sam', bio: 'Here for the prediction-gap dopamine.', climbing: 'Speaking up'),
  Member(name: 'Quiet one', locked: true), // keeps their profile private
  Member(name: 'Priya', bio: 'Learning to take up space in meetings.', climbing: 'Under pressure'),
  Member(name: 'Leo', bio: 'Phone calls? In this economy?', climbing: 'Speaking up'),
];

Pod systemPod(int capacity) => Pod(
      name: 'Quiet Risers',
      blurb: 'Your starter pod — assigned, gentle, no pressure',
      members: sampleMembers,
      capacity: capacity,
      system: true,
    );

List<Pod> discoverablePods(int capacity) => [
      Pod(
          name: 'Evening Owls',
          blurb: 'After-work practice & wins',
          members: sampleMembers.take(4).toList(),
          capacity: capacity),
      Pod(
          name: 'First Rungs',
          blurb: 'Brand-new climbers, extra gentle',
          members: sampleMembers.take(3).toList(),
          capacity: capacity),
      Pod(
          name: 'Phone-Call Club',
          blurb: 'We dread the same things',
          members: sampleMembers.take(5).toList(),
          capacity: capacity),
    ];
