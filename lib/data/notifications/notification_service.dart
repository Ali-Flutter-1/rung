import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

/// Opt-in daily practice reminder (spec §7.4) — gentle, never guilt.
/// Self-guarding: any platform failure is swallowed so it never blocks startup.
class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _ready = false;
  static const _reminderId = 1001;
  static const _missedReflectionId = 1101;
  static const _streakRiskId = 1102;
  static const _comebackId = 1103;

  Future<void> init() async {
    try {
      tzdata.initializeTimeZones();
      final info = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(info.identifier));
      const settings = InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      );
      await _plugin.initialize(settings: settings);
      _ready = true;
    } catch (_) {
      _ready = false;
    }
  }

  /// Asks the OS for permission. Returns whether granted (best-effort true).
  Future<bool> requestPermission() async {
    if (!_ready) return false;
    try {
      final ios = _plugin.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>();
      if (ios != null) {
        final ok = await ios.requestPermissions(alert: true, badge: true, sound: true);
        return ok ?? false;
      }
      final android = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      if (android != null) {
        final ok = await android.requestNotificationsPermission();
        return ok ?? true;
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  static const _details = NotificationDetails(
    android: AndroidNotificationDetails(
      'daily_reminder',
      'Daily reminder',
      channelDescription: 'A gentle nudge to take one small step.',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    ),
    iOS: DarwinNotificationDetails(),
  );

  /// Schedules (or reschedules) a daily reminder at [time], local.
  Future<void> scheduleDaily(TimeOfDay time) async {
    if (!_ready) return;
    try {
      await _plugin.cancel(id: _reminderId);
      await _plugin.zonedSchedule(
        id: _reminderId,
        title: 'Your next small step is waiting',
        body: 'A couple of calm minutes is all it takes. 🪜',
        scheduledDate: _nextInstanceOf(time),
        notificationDetails: _details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time, // repeat daily
      );
    } catch (_) {/* never block the UI */}
  }

  Future<void> cancelDaily() async {
    if (!_ready) return;
    try {
      await _plugin.cancel(id: _reminderId);
    } catch (_) {}
  }

  /// Plans contextual reminders in addition to the base daily reminder.
  ///
  /// - Missed reflection: a challenge was started but not reflected for 4h.
  /// - Streak risk: no counting completion today, but an active streak exists.
  /// - Comeback: inactivity reached day 2 / 5 / 10.
  Future<void> syncSmartReminders({
    required bool enabled,
    required DateTime? inProgressStartedAt,
    required bool hasCompletedToday,
    required int currentStreak,
    required DateTime? lastCompletedAt,
  }) async {
    if (!_ready) return;
    if (!enabled) {
      await _cancelSmartReminders();
      return;
    }
    final now = DateTime.now();

    // Missed reflection (single nudge after 4h, max once per in-progress cycle).
    if (inProgressStartedAt == null) {
      await _plugin.cancel(id: _missedReflectionId);
    } else {
      final due = inProgressStartedAt.add(const Duration(hours: 4));
      final at = due.isAfter(now) ? due : now.add(const Duration(minutes: 10));
      await _scheduleOneOff(
        id: _missedReflectionId,
        at: at,
        title: 'How did it go?',
        body: 'A quick reflection locks in the win. Takes under a minute.',
      );
    }

    // Streak risk (only if streak exists and today has no counted completion).
    if (currentStreak > 0 && !hasCompletedToday) {
      var at = DateTime(now.year, now.month, now.day, 20, 0);
      if (!at.isAfter(now)) at = now.add(const Duration(minutes: 15));
      await _scheduleOneOff(
        id: _streakRiskId,
        at: at,
        title: 'Keep your streak alive',
        body: 'One small step today keeps your momentum going.',
      );
    } else {
      await _plugin.cancel(id: _streakRiskId);
    }

    // Comeback (2/5/10 day milestones, one reminder for the nearest milestone).
    final daysInactive =
        lastCompletedAt == null ? null : now.difference(lastCompletedAt).inDays;
    if (daysInactive == null || !{2, 5, 10}.contains(daysInactive)) {
      await _plugin.cancel(id: _comebackId);
    } else {
      var at = DateTime(now.year, now.month, now.day, 10, 0);
      if (!at.isAfter(now)) at = now.add(const Duration(minutes: 10));
      final msg = switch (daysInactive) {
        2 => 'A tiny restart today is enough.',
        5 => 'You can come back gently, one rung at a time.',
        _ => 'No pressure — your next step is still here when you are.',
      };
      await _scheduleOneOff(
        id: _comebackId,
        at: at,
        title: 'Ready for a small comeback?',
        body: msg,
      );
    }
  }

  Future<void> _cancelSmartReminders() async {
    await _plugin.cancel(id: _missedReflectionId);
    await _plugin.cancel(id: _streakRiskId);
    await _plugin.cancel(id: _comebackId);
  }

  Future<void> _scheduleOneOff({
    required int id,
    required DateTime at,
    required String title,
    required String body,
  }) async {
    try {
      await _plugin.cancel(id: id);
      await _plugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: tz.TZDateTime.from(at, tz.local),
        notificationDetails: _details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );
    } catch (_) {/* never block the UI */}
  }

  tz.TZDateTime _nextInstanceOf(TimeOfDay time) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute);
    if (!scheduled.isAfter(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
