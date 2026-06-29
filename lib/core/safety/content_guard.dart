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
  static final RegExp _distress = RegExp(
    r'(kill myself|killing myself|end my life|want to die|wanna die|'
    r'suicid|self[\s-]?harm|hurt myself|cut myself|no reason to live|'
    r"can'?t go on|better off dead)",
    caseSensitive: false,
  );

  static bool isAbusive(String text) => _profanity.hasMatch(text);

  static bool isDistress(String text) => _distress.hasMatch(text);
}
