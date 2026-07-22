// Safety-critical: isDistress gates the crisis support sheet. A MISS means
// someone in real trouble types it and the app says nothing. A false positive
// is merely annoying. So this leans hard on catching real phrasings.
import 'package:flutter_test/flutter_test.dart';
import 'package:rung/core/safety/content_guard.dart';

void main() {
  group('isDistress catches real signals', () {
    for (final text in const [
      'I want to kill myself',
      'been thinking about killing myself',
      'I want to end my life',
      'i want to die',
      'i wanna die',
      'feeling suicidal lately',
      'suicide',
      'self harm',
      'self-harm',
      'selfharm',
      'I might hurt myself',
      'I cut myself last night',
      'theres no reason to live',
      'I cant go on',
      "I can't go on",
      'everyone would be better off dead',
      // Added phrasings.
      'I just want to end it all',
      'thinking about taking my own life',
      'I might take my life',
      'I want to hang myself',
      'been thinking about hanging myself',
      'thinking about an overdose',
      "there's no point in living",
      "I don't want to live anymore",
      'i want to kms',
      'honestly kms',
    ]) {
      test('"$text"', () => expect(ContentGuard.isDistress(text), isTrue));
    }
  });

  group('"kms" only fires as self-harm slang, not the distance unit', () {
    // "kms" = kilometres when a number precedes it — must NOT surface a crisis
    // sheet for "I ran 5 kms".
    for (final text in const [
      'I ran 5 kms today',
      'did 10 kms this morning',
      'the trail is 3 kms long',
    ]) {
      test('"$text" → not distress', () =>
          expect(ContentGuard.isDistress(text), isFalse));
    }
  });

  group('isDistress is case-insensitive', () {
    for (final text in const [
      'I WANT TO DIE',
      'Suicidal',
      'Kill Myself',
    ]) {
      test('"$text"', () => expect(ContentGuard.isDistress(text), isTrue));
    }
  });

  group('smart quotes — what phones actually produce', () {
    // iOS/Android keyboards autocorrect the straight ' into a curly ’ (U+2019).
    // A user in crisis types "I can't go on" and the OS stores "can’t".
    test('"I can’t go on" (curly apostrophe)', () {
      expect(ContentGuard.isDistress('I can’t go on'), isTrue,
          reason: 'phones type ’ not \' — this must still reach the support sheet');
    });
  });

  group('isDistress does not fire on ordinary anxious talk', () {
    // False positives would shove a crisis sheet at someone just venting.
    for (final text in const [
      'That party killed me, so awkward',
      "I'm dying to meet them",
      'I felt like dying of embarrassment',
      'This is killing my confidence',
      'I was so nervous I wanted to disappear',
      'I survived the meeting!',
      // Deliberately NOT distress: in a social-anxiety app this is dread of an
      // event, not self-harm — matching it would misfire constantly.
      "I don't want to be here",
      'I really do not want to be here right now',
    ]) {
      test('"$text"', () => expect(ContentGuard.isDistress(text), isFalse));
    }
  });

  group('isAbusive', () {
    test('catches clear profanity', () {
      expect(ContentGuard.isAbusive('you are a bitch'), isTrue);
      expect(ContentGuard.isAbusive('asshole'), isTrue);
    });

    test('catches masked profanity', () {
      expect(ContentGuard.isAbusive('f*ck you'), isTrue);
      expect(ContentGuard.isAbusive('sh*t'), isTrue);
    });

    test('is case-insensitive', () {
      expect(ContentGuard.isAbusive('BITCH'), isTrue);
    });

    test('does not fire on kind, ordinary pod talk', () {
      for (final text in const [
        'Well done, that took real courage',
        'I class this as a win',
        'Scunthorpe is where I grew up', // the classic substring false-positive
        'I passed the assessment',
      ]) {
        expect(ContentGuard.isAbusive(text), isFalse, reason: text);
      }
    });
  });
}
