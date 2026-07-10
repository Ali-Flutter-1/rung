import '../domain/entities/rung.dart';
import '../l10n/app_localizations.dart';

/// Display-time copy for a rung.
///
/// Seeded rungs always carry text (localized via `rungs_localized`). Custom
/// rungs may leave `whatToDo` empty — the user wrote a title only — and always
/// leave `whyItHelps` empty, because that line is the app's own words, never
/// the user's. Those blanks are filled from the ACTIVE locale here rather than
/// being frozen into the database row at creation time.
extension RungCopy on Rung {
  String whatToDoText(AppLocalizations l) =>
      whatToDo.trim().isEmpty ? l.customDefaultWhat : whatToDo;

  String whyItHelpsText(AppLocalizations l) =>
      whyItHelps.trim().isEmpty ? l.customDefaultWhy : whyItHelps;
}
