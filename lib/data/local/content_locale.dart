/// Resolves the fallback chain used to pick translated rung/track copy.
///
/// English is the implicit last resort (it lives in the base rows), so it is
/// never part of the chain. A region variant falls back to its base language
/// first: a `pt_PT` user with an untranslated rung should see Brazilian
/// Portuguese before dropping all the way to English.
///
///   'pt_PT' → ['pt_PT', 'pt']
///   'de'    → ['de']
///   'en'    → []            (base rows already are English)
///   null    → resolved from the device locale by the caller
List<String> contentLocaleChain(String code) {
  if (code.isEmpty) return const [];
  final normalized = code.replaceAll('-', '_');
  final language = normalized.split('_').first;
  if (language == 'en') return const [];
  if (normalized == language) return [language];
  return [normalized, language];
}
