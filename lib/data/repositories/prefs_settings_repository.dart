import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/subscription.dart';
import '../../domain/repositories/settings_repository.dart';

/// Local-only settings backed by shared_preferences (§2.4 Profile). No account.
class PrefsSettingsRepository implements SettingsRepository {
  PrefsSettingsRepository(this._prefs);

  final SharedPreferences _prefs;
  final StreamController<void> _changes = StreamController<void>.broadcast();

  static const _kOnboarded = 'onboarded';
  static const _kDisclaimer = 'accepted_disclaimer';
  static const _kTone = 'tone_mode';
  static const _kTheme = 'theme_mode';
  static const _kStartTrack = 'starting_track_slug';
  static const _kDisplayName = 'display_name';
  static const _kBio = 'bio';
  static const _kProfileLocked = 'profile_locked';
  static const _kTier = 'subscription_tier';
  static const _kPodRules = 'accepted_pod_rules';
  static const _kBackup = 'backup_enabled';
  static const _kLastBackup = 'last_backup_at';
  static const _kLastContentSync = 'last_content_sync_at';
  static const _kPush = 'push_enabled';
  static const _kPodAlerts = 'pod_alerts_enabled';
  static const _kLastUser = 'last_user_id';
  static const _kReminder = 'reminder_time';
  static const _kCheckIn = 'last_check_in_date';
  static const _kAvatar = 'avatar_id';

  static Future<PrefsSettingsRepository> create() async =>
      PrefsSettingsRepository(await SharedPreferences.getInstance());

  void _bump() {
    if (!_changes.isClosed) _changes.add(null);
  }

  @override
  Stream<void> get changes => _changes.stream;

  @override
  bool get hasCompletedOnboarding => _prefs.getBool(_kOnboarded) ?? false;

  @override
  Future<void> setCompletedOnboarding(bool value) async {
    await _prefs.setBool(_kOnboarded, value);
    _bump();
  }

  @override
  bool get hasAcceptedDisclaimer => _prefs.getBool(_kDisclaimer) ?? false;

  @override
  Future<void> setAcceptedDisclaimer(bool value) async {
    await _prefs.setBool(_kDisclaimer, value);
    _bump();
  }

  @override
  ToneMode get toneMode =>
      (_prefs.getString(_kTone) == ToneMode.situational.name)
          ? ToneMode.situational
          : ToneMode.introvert;

  @override
  Future<void> setToneMode(ToneMode mode) async {
    await _prefs.setString(_kTone, mode.name);
    _bump();
  }

  @override
  ThemeMode get themeMode => switch (_prefs.getString(_kTheme)) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      };

  @override
  Future<void> setThemeMode(ThemeMode mode) async {
    await _prefs.setString(_kTheme, mode.name);
    _bump();
  }

  @override
  String? get startingTrackSlug => _prefs.getString(_kStartTrack);

  @override
  Future<void> setStartingTrackSlug(String? slug) async {
    if (slug == null) {
      await _prefs.remove(_kStartTrack);
    } else {
      await _prefs.setString(_kStartTrack, slug);
    }
    _bump();
  }

  String? _str(String key) {
    final v = _prefs.getString(key);
    return (v == null || v.isEmpty) ? null : v;
  }

  Future<void> _setStr(String key, String? value) async {
    if (value == null || value.trim().isEmpty) {
      await _prefs.remove(key);
    } else {
      await _prefs.setString(key, value.trim());
    }
    _bump();
  }

  @override
  String? get displayName => _str(_kDisplayName);

  @override
  Future<void> setDisplayName(String? value) => _setStr(_kDisplayName, value);

  @override
  String? get bio => _str(_kBio);

  @override
  Future<void> setBio(String? value) => _setStr(_kBio, value);

  @override
  bool get profileLocked => _prefs.getBool(_kProfileLocked) ?? false;

  @override
  Future<void> setProfileLocked(bool value) async {
    await _prefs.setBool(_kProfileLocked, value);
    _bump();
  }

  @override
  SubscriptionTier get subscriptionTier =>
      SubscriptionTierX.fromId(_prefs.getString(_kTier));

  @override
  Future<void> setSubscriptionTier(SubscriptionTier tier) async {
    await _prefs.setString(_kTier, tier.id);
    _bump();
  }

  @override
  TimeOfDay? get reminderTime {
    final raw = _prefs.getString(_kReminder);
    if (raw == null) return null;
    final parts = raw.split(':');
    if (parts.length != 2) return null;
    final h = int.tryParse(parts[0]);
    final m = int.tryParse(parts[1]);
    if (h == null || m == null) return null;
    return TimeOfDay(hour: h, minute: m);
  }

  @override
  Future<void> setReminderTime(TimeOfDay? value) async {
    if (value == null) {
      await _prefs.remove(_kReminder);
    } else {
      await _prefs.setString(_kReminder, '${value.hour}:${value.minute}');
    }
    _bump();
  }

  @override
  bool get hasAcceptedPodRules => _prefs.getBool(_kPodRules) ?? false;

  @override
  Future<void> setAcceptedPodRules(bool value) async {
    await _prefs.setBool(_kPodRules, value);
    _bump();
  }

  @override
  bool get backupEnabled => _prefs.getBool(_kBackup) ?? false;

  @override
  Future<void> setBackupEnabled(bool value) async {
    await _prefs.setBool(_kBackup, value);
    _bump();
  }

  @override
  int get lastBackupAt => _prefs.getInt(_kLastBackup) ?? 0;

  @override
  Future<void> setLastBackupAt(int ms) async {
    await _prefs.setInt(_kLastBackup, ms);
  }

  @override
  int get lastContentSyncAt => _prefs.getInt(_kLastContentSync) ?? 0;

  @override
  Future<void> setLastContentSyncAt(int ms) async {
    await _prefs.setInt(_kLastContentSync, ms);
  }

  @override
  bool get pushEnabled => _prefs.getBool(_kPush) ?? true;

  @override
  Future<void> setPushEnabled(bool value) async {
    await _prefs.setBool(_kPush, value);
    _bump();
  }

  @override
  bool get podAlertsEnabled => _prefs.getBool(_kPodAlerts) ?? true;

  @override
  Future<void> setPodAlertsEnabled(bool value) async {
    await _prefs.setBool(_kPodAlerts, value);
    _bump();
  }

  @override
  String? get lastCheckInDate => _str(_kCheckIn);

  @override
  Future<void> setLastCheckInDate(String ymd) => _setStr(_kCheckIn, ymd);

  @override
  String? get avatarId => _str(_kAvatar);

  @override
  Future<void> setAvatarId(String? id) => _setStr(_kAvatar, id);

  @override
  String? get lastUserId => _str(_kLastUser);

  @override
  Future<void> setLastUserId(String? id) async {
    if (id == null) {
      await _prefs.remove(_kLastUser);
    } else {
      await _prefs.setString(_kLastUser, id);
    }
  }
}
