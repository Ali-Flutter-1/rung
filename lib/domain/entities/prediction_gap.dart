/// One point in the predicted-vs-actual series (§2.5 GetPredictionGap).
class GapPoint {
  const GapPoint({
    required this.date,
    required this.predicted,
    required this.actual,
  });

  final DateTime date;
  final int predicted;
  final int actual;

  int get gap => predicted - actual;
}

/// Aggregate prediction-gap evidence shown on Insights (§1.5, the "aha").
class GapSeries {
  const GapSeries({
    required this.points,
    required this.avgPredicted,
    required this.avgActual,
  });

  final List<GapPoint> points;
  final double avgPredicted;
  final double avgActual;

  bool get hasEnoughData => points.length >= 2;

  /// Positive = fears reliably overestimate reality.
  double get avgGap => avgPredicted - avgActual;

  static const empty = GapSeries(points: [], avgPredicted: 0, avgActual: 0);
}
