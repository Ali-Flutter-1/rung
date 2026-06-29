/// A single challenge on a track's ladder (§2.4).
class Rung {
  const Rung({
    required this.id,
    required this.trackId,
    required this.title,
    required this.whatToDo,
    required this.whyItHelps,
    required this.difficulty,
    required this.sortOrder,
    this.isCustom = false,
    this.ownerId,
    this.estMinutes = 2,
  });

  final String id;
  final String trackId;
  final String title;

  /// Short "what to do" micro-guidance (§13).
  final String whatToDo;

  /// One-line "why this helps" micro-education (§13).
  final String whyItHelps;

  /// 1–10.
  final int difficulty;
  final int sortOrder;
  final bool isCustom;
  final String? ownerId;
  final int estMinutes;
}
