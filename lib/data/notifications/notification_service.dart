import 'package:flutter/foundation.dart';
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
    // Timezone lookup is the fragile step (it can throw on an OEM ROM with an
    // unrecognised zone id). It must NOT take the whole service down with it:
    // failing here used to leave _ready false, which silently no-ops every
    // reminder for the life of the session. Fall back to UTC and carry on —
    // a reminder an hour off beats no reminder at all.
    try {
      tzdata.initializeTimeZones();
      final info = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(info.identifier));
    } catch (_) {
      try {
        tz.setLocalLocation(tz.getLocation('UTC'));
      } catch (_) {
        /* timezone db unavailable — scheduling will fail loudly below */
      }
    }
    try {
      const settings = InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      );
      await _plugin.initialize(settings: settings);
      await _createAndroidChannels();
      _ready = true;
    } catch (_) {
      _ready = false;
    }
  }

  /// Creates the notification channels up front. Android caches a channel's
  /// importance at creation, so these must exist before the first notification
  /// — including `rung_push`, which FCM names in the manifest for
  /// background/terminated messages.
  Future<void> _createAndroidChannels() async {
    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (android == null) return;
    await android.createNotificationChannel(
      const AndroidNotificationChannel(
        'daily_reminder',
        'Daily reminder',
        description: 'A gentle nudge to take one small step.',
      ),
    );
    await android.createNotificationChannel(
      const AndroidNotificationChannel(
        'rung_push',
        'Messages and updates',
        description: 'Pod messages and account notifications.',
        importance: Importance.high,
      ),
    );
  }

  /// Asks the OS for permission. Returns whether granted (best-effort true).
  ///
  /// Checks the CURRENT state before asking. The OS only runs the request
  /// callback when it actually shows a dialog, so re-requesting an
  /// already-granted permission — which is the normal case here, since push
  /// setup (FirebaseMessaging.requestPermission) usually prompts first — can
  /// resolve false and wrongly tell the user to go enable notifications in
  /// Settings. Asking "are they on?" first avoids that entirely.
  Future<bool> requestPermission() async {
    if (!_ready) return false;
    try {
      final ios = _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >();
      if (ios != null) {
        final current = await ios.checkPermissions();
        if (current?.isEnabled ?? false) return true;
        final ok = await ios.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
        return ok ?? false;
      }
      final android = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      if (android != null) {
        if (await android.areNotificationsEnabled() ?? false) return true;
        final ok = await android.requestNotificationsPermission();
        if (ok ?? false) return true;
        // The request can resolve false/null even when the permission is in
        // fact granted (no dialog shown → no callback). Re-read the real state
        // rather than trusting that result.
        return await android.areNotificationsEnabled() ?? false;
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
  ///
  /// Returns null on success, or a human-readable reason on failure. It used to
  /// swallow every error, which made an Android device that silently refused to
  /// schedule indistinguishable from one that worked — the toggle flipped on and
  /// nothing ever arrived. Callers surface what comes back.
  Future<String?> scheduleDaily(TimeOfDay time) async {
    if (!_ready) return 'Notifications are unavailable on this device.';
    try {
      await _plugin.cancel(id: _reminderId);
      await _plugin.zonedSchedule(
        id: _reminderId,
        title: 'Your next small step is waiting',
        body: 'A couple of calm minutes is all it takes. 🪜',
        scheduledDate: _nextInstanceOf(time),
        notificationDetails: _details,
        androidScheduleMode: await _scheduleMode(),
        matchDateTimeComponents: DateTimeComponents.time, // repeat daily
      );
      return null;
    } catch (e) {
      if (kDebugMode) debugPrint('[notif] scheduleDaily failed: $e');
      return '$e';
    }
  }

  /// Exact alarms survive Doze and OEM battery managers far better, but the OS
  /// only grants them when the user has allowed it. Ask, then fall back — an
  /// inexact reminder that arrives late beats one that never arrives.
  Future<AndroidScheduleMode> _scheduleMode() async {
    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (android == null) return AndroidScheduleMode.exactAllowWhileIdle;
    try {
      if (await android.canScheduleExactNotifications() ?? false) {
        return AndroidScheduleMode.exactAllowWhileIdle;
      }
    } catch (_) {
      /* fall through to inexact */
    }
    return AndroidScheduleMode.inexactAllowWhileIdle;
  }

  /// Posts a notification right now. Used to confirm the reminder was set — and
  /// doubles as proof that delivery works at all on this device.
  Future<void> showNow({required String title, required String body}) async {
    if (!_ready) return;
    try {
      await _plugin.show(
        id: _reminderId + 900,
        title: title,
        body: body,
        notificationDetails: _details,
      );
    } catch (e) {
      if (kDebugMode) debugPrint('[notif] showNow failed: $e');
    }
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
    final daysInactive = lastCompletedAt == null
        ? null
        : now.difference(lastCompletedAt).inDays;
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
    } catch (_) {
      /* never block the UI */
    }
  }

  tz.TZDateTime _nextInstanceOf(TimeOfDay time) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    if (!scheduled.isAfter(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
