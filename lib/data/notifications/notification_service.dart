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
