import 'package:flutter/material.dart';

import '../entities/subscription.dart';

/// Tone mode shifts copy + density (§4.2). Default is introvert-first (§4.1).
enum ToneMode { introvert, situational }

/// Local-only profile/settings (§2.4 Profile). No account required.
abstract interface class SettingsRepository {
  bool get hasCompletedOnboarding;
  Future<void> setCompletedOnboarding(bool value);

  bool get hasAcceptedDisclaimer;
  Future<void> setAcceptedDisclaimer(bool value);

  ToneMode get toneMode;
  Future<void> setToneMode(ToneMode mode);

  ThemeMode get themeMode;
  Future<void> setThemeMode(ThemeMode mode);

  /// Chosen UI language as a locale code (e.g. 'en', 'es', 'ar'); null = follow
  /// the device language.
  String? get localeCode;
  Future<void> setLocaleCode(String? code);

  /// Track slug chosen by the onboarding quiz as the user's starting point.
  String? get startingTrackSlug;
  Future<void> setStartingTrackSlug(String? slug);

  // ── Profile (synced to Supabase `profiles` once signed in) ──────────────
  String? get displayName;
  Future<void> setDisplayName(String? value);

  String? get bio;
  Future<void> setBio(String? value);

  /// When true, other pod members can't open your profile details (§ privacy).
  bool get profileLocked;
  Future<void> setProfileLocked(bool value);

  /// Local premium tier flag until real in-app purchases exist.
  SubscriptionTier get subscriptionTier;
  Future<void> setSubscriptionTier(SubscriptionTier tier);

  /// Whether the user accepted the community/pod rules (gate before joining).
  bool get hasAcceptedPodRules;
  Future<void> setAcceptedPodRules(bool value);

  /// Opt-in cloud backup of progress (streaks/attempts; notes stay on-device).
  bool get backupEnabled;
  Future<void> setBackupEnabled(bool value);

  /// Epoch millis of the last successful backup sync (delta cursor).
  int get lastBackupAt;
  Future<void> setLastBackupAt(int ms);

  /// Epoch millis of the last global-content pull (throttles re-fetching the
  /// rarely-changing tracks/rungs so they aren't re-downloaded every app open).
  int get lastContentSyncAt;
  Future<void> setLastContentSyncAt(int ms);

  /// The locale the cached content was last pulled for. When the user switches
  /// language this no longer matches, so the content sync bypasses its TTL and
  /// translated rung copy arrives immediately rather than up to 24h later.
  String get lastContentLocale;
  Future<void> setLastContentLocale(String code);

  /// Master push switch — when off, the device's push token is removed so no
  /// cloud notifications arrive at all.
  bool get pushEnabled;
  Future<void> setPushEnabled(bool value);

  /// Whether new pod-message notifications are wanted (mirrors the cloud
  /// `profiles.pod_alerts` flag the notify function checks).
  bool get podAlertsEnabled;
  Future<void> setPodAlertsEnabled(bool value);

  /// The account (auth user id) whose data is currently on this device. Used to
  /// detect an account switch on sign-in and reset local data accordingly.
  String? get lastUserId;
  Future<void> setLastUserId(String? id);

  /// Opt-in daily reminder time; null = reminders off.
  TimeOfDay? get reminderTime;
  Future<void> setReminderTime(TimeOfDay? value);

  /// Weekly completion target shown on Home ("3 steps this week", etc).
  int get weeklyGoalSteps;
  Future<void> setWeeklyGoalSteps(int value);

  /// `yyyy-MM-dd` of the last daily check-in — gates the once-a-day prompt.
  String? get lastCheckInDate;
  Future<void> setLastCheckInDate(String ymd);

  /// Whether haptic feedback (vibration on taps/wins) is on. Default on.
  bool get hapticsEnabled;
  Future<void> setHapticsEnabled(bool value);

  /// Chosen avatar id (see [Avatars]); null = use the name's initial. Synced to
  /// the cloud profile so pod-mates see it.
  String? get avatarId;
  Future<void> setAvatarId(String? id);

  /// Whether the user has already left a rating — used to avoid re-nagging with
  /// the "how's it going?" prompt (the manual Rate tile is always available).
  bool get hasRatedApp;
  Future<void> setHasRatedApp(bool value);

  /// Notifies listeners (the app shell) when settings change.
  Stream<void> get changes;
}
