// Build 1 ships without the AI coach — it lands in build 2.
//
// The coach feature is deliberately *commented out* rather than deleted, so a
// normal `grep` can't tell "hidden" from "still wired up". These tests strip
// comments from the source on disk first, then assert nothing live reaches the
// coach. They also assert the dormant code is still there, so a well-meaning
// cleanup that deletes it fails here instead of at build-2 time.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Source with `//` line comments and `/* … */` blocks removed, so only code
/// that actually compiles is left. String literals are preserved.
String _stripComments(String src) {
  final out = StringBuffer();
  var i = 0;
  String? quote; // the delimiter of the string literal we're inside, if any
  while (i < src.length) {
    final c = src[i];
    final next = i + 1 < src.length ? src[i + 1] : '';
    if (quote != null) {
      if (c == r'\') {
        out.write(src.substring(i, (i + 2).clamp(0, src.length)));
        i += 2;
        continue;
      }
      if (c == quote) quote = null;
      out.write(c);
      i++;
    } else if (c == '/' && next == '/') {
      while (i < src.length && src[i] != '\n') {
        i++;
      }
    } else if (c == '/' && next == '*') {
      i += 2;
      while (i < src.length && !(src[i] == '*' && i + 1 < src.length && src[i + 1] == '/')) {
        i++;
      }
      i += 2;
    } else {
      if (c == "'" || c == '"') quote = c;
      out.write(c);
      i++;
    }
  }
  return out.toString();
}

/// Every `.dart` file under `lib/`, excluding the dormant coach feature itself
/// and the translation files (unused `coach*` strings are harmless).
List<File> _liveSources() => Directory('lib')
    .listSync(recursive: true)
    .whereType<File>()
    .where((f) => f.path.endsWith('.dart'))
    .where((f) => !f.path.startsWith('lib/features/coach/'))
    .where((f) => !f.path.startsWith('lib/l10n/'))
    .toList();

void main() {
  test('no live code reaches the coach screen', () {
    final offenders = <String>[];
    for (final f in _liveSources()) {
      final code = _stripComments(f.readAsStringSync());
      if (code.contains('features/coach/') ||
          code.contains('coach_screen.dart') ||
          code.contains('openCoach') ||
          code.contains('CoachScreen')) {
        offenders.add(f.path);
      }
    }
    expect(
      offenders,
      isEmpty,
      reason: 'the coach is hidden until build 2, but these files still '
          'reference it in live code: $offenders',
    );
  });

  test('the dashboard shows no coach card', () {
    final code = _stripComments(
      File('lib/features/dashboard/dashboard_screen.dart').readAsStringSync(),
    );
    expect(code.contains('_CoachCard'), isFalse);
    expect(code.contains('dashCoachTitle'), isFalse);
    expect(code.contains('dashCoachSub'), isFalse);
  });

  test('the paywall never promises a coach', () {
    final code = _stripComments(
      File('lib/features/subscription/subscription_screen.dart')
          .readAsStringSync(),
    );
    // Advertising a coach the build does not ship is an App Store risk, so both
    // the benefit row and the hero paragraph that mentions it stay hidden.
    expect(code.contains('paywallBenefitCoach'), isFalse);
    expect(code.contains('paywallHeroBody'), isFalse);
    // The rest of the paywall must still be intact.
    expect(code.contains('paywallHeroTitle'), isTrue);
    expect(code.contains('paywallBenefitPods'), isTrue);
    expect(code.contains('paywallBenefitCustom'), isTrue);
    expect(code.contains('paywallBenefitDepth'), isTrue);
  });

  test('the coach feature is only dormant, not deleted', () {
    // Build 2 restores it by uncommenting; these are what it restores to.
    expect(File('lib/features/coach/coach_screen.dart').existsSync(), isTrue);
    final dash =
        File('lib/features/dashboard/dashboard_screen.dart').readAsStringSync();
    expect(
      dash.contains('COACH: hidden for build 1'),
      isTrue,
      reason: 'the commented-out _CoachCard and its marker should remain',
    );
    expect(dash.contains('_CoachCard'), isTrue);
    expect(
      File('lib/l10n/app_en.arb').readAsStringSync().contains('"coachTitle"'),
      isTrue,
      reason: 'coach translations stay so build 2 needs no re-translation',
    );
  });
}
