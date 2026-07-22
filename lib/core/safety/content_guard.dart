/// Lightweight, on-device content checks for pod chat. This is a first line,
/// not a replacement for human moderation (reports go to a queue server-side).
class ContentGuard {
  ContentGuard._();

  // A deliberately small list — soft-blocks the most clearly abusive terms.
  // Real moderation needs a maintained service; this just stops obvious abuse.
  static final RegExp _profanity = RegExp(
    r'\b(f[u\*]ck|sh[i\*]t|b[i\*]tch|asshole|cunt|retard|faggot|n[i\*]gg)',
    caseSensitive: false,
  );

  // Distress / self-harm signals — surface help, never punish (spec §1.9).
  // Because a match only offers a support resource (it never blocks a message),
  // we err toward catching more. Deliberately EXCLUDED: "don't want to be here"
  // and similar — in a social-anxiety app that usually means dread of an event,
  // not self-harm, so it would misfire constantly. "kms" is matched only when
  // it isn't a number's unit ("5 kms" = kilometres) via the digit lookbehind.
  static final RegExp _distress = RegExp(
    r'(kill myself|killing myself|end my life|end it all|'
    r'tak(e|ing) my (own )?life|want to die|wanna die|'
    r'suicid|self[\s-]?harm|hurt myself|cut myself|hang(ing)? myself|overdose|'
    r'no reason to live|no point (in )?living|better off dead|'
    r'(?<!\d\s)\bkms\b|'
    r"can'?t go on|don'?t want to live)",
    caseSensitive: false,
  );

  // Phone keyboards autocorrect the straight ' into a curly ’ (U+2019), so the
  // text we actually receive is "can’t", not "can't". Matching only the straight
  // form silently missed real distress signals — normalize first so every
  // pattern above works regardless of which apostrophe the keyboard produced.
  static final RegExp _apostrophes = RegExp(r'[‘’ʼ´`]');

  static String _normalize(String text) => text.replaceAll(_apostrophes, "'");

  static bool isAbusive(String text) => _profanity.hasMatch(_normalize(text));

  static bool isDistress(String text) => _distress.hasMatch(_normalize(text));
}
