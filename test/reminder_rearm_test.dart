// The daily reminder must be re-armed on every launch.
//
// Android cancels a package's alarms when it is REPLACED, but the stored
// reminder time lives in SharedPreferences and survives the update. Scheduling
// used to happen only in the Profile time picker, so after any app update the
// toggle still read "on" while no OS alarm existed — the user silently stopped
// being reminded, with nothing in the UI to show for it. (Reboots were already
// covered by flutter_local_notifications' BOOT_COMPLETED receiver; updates
// were the gap.)
//
// This asserts on the source of main.dart rather than running the app, because
// the bug is precisely an absent call — there is no runtime behaviour to probe
// when it regresses, and the notification plugin needs a real platform.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  late String main_;

  setUpAll(() => main_ = File('lib/main.dart').readAsStringSync());

  test('startup reads the stored reminder time', () {
    expect(
      main_,
      contains('settings.reminderTime'),
      reason: 'main() must read the persisted reminder time to re-arm it',
    );
  });

  test('startup re-arms the alarm by calling scheduleDaily', () {
    expect(
      main_,
      contains('scheduleDaily'),
      reason:
          'without this call the alarm is gone after every app update while '
          'the Profile toggle still reads "on"',
    );
  });

  test('the re-arm happens after settings are loaded', () {
    // Ordering matters: the reminder time comes from the settings repository,
    // so calling scheduleDaily before it exists would always read null and
    // quietly re-arm nothing.
    final settingsAt = main_.indexOf('PrefsSettingsRepository.create()');
    final rearmAt = main_.indexOf('scheduleDaily');
    expect(settingsAt, greaterThan(-1));
    expect(rearmAt, greaterThan(settingsAt));
  });

  test('the re-arm happens after the notification service is initialised', () {
    // scheduleDaily returns an error string and schedules nothing while the
    // service is not ready, so init() must come first.
    final initAt = main_.indexOf('NotificationService.instance.init()');
    final rearmAt = main_.indexOf('scheduleDaily');
    expect(initAt, greaterThan(-1));
    expect(rearmAt, greaterThan(initAt));
  });

  test('scheduling stays idempotent — scheduleDaily cancels first', () {
    // Re-running on every launch is only safe because scheduleDaily clears the
    // previous alarm before setting a new one. If that cancel is ever removed,
    // launching repeatedly would stack duplicate reminders.
    final service = File(
      'lib/data/notifications/notification_service.dart',
    ).readAsStringSync();
    final body = service.substring(service.indexOf('scheduleDaily(TimeOfDay'));
    final cancelAt = body.indexOf('cancel(id: _reminderId)');
    final scheduleAt = body.indexOf('zonedSchedule');
    expect(
      cancelAt,
      greaterThan(-1),
      reason: 'scheduleDaily must cancel first',
    );
    expect(cancelAt, lessThan(scheduleAt));
  });
}
