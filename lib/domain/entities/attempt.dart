/// How an attempt resolved. Skips are neutral, never a "failure" (§1.9).
enum Outcome { done, partial, skipped }

extension OutcomeX on Outcome {
  String get id => name;
  static Outcome fromId(String v) =>
      Outcome.values.firstWhere((o) => o.name == v, orElse: () => Outcome.done);

  /// Done or partial count toward streaks/clears; skipped does not (§8.2).
  bool get counts => this == Outcome.done || this == Outcome.partial;
}

/// One predict → do → reflect cycle (§2.4). The heart of the data model.
class Attempt {
  const Attempt({
    required this.id,
    required this.rungId,
    required this.predictedSuds,
    this.predictedNote,
    this.actualSuds,
    this.outcome,
    this.reflectionNote,
    required this.startedAt,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String rungId;

  /// Anticipated Subjective Units of Distress, 0–10.
  final int predictedSuds;
  final String? predictedNote;

  /// Actual SUDS once reflected, 0–10. Null while in-progress.
  final int? actualSuds;
  final Outcome? outcome;
  final String? reflectionNote;
  final DateTime startedAt;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get isInProgress => completedAt == null;

  /// Positive gap = brain over-predicted the distress (the "aha", §1.5).
  int? get predictionGap =>
      actualSuds == null ? null : predictedSuds - actualSuds!;
}
