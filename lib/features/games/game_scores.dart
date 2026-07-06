import 'package:shared_preferences/shared_preferences.dart';

/// Tiny local store for per-game best scores (SharedPreferences). Some games
/// score higher-is-better (2048, Quick Math, sequence level), others
/// lower-is-better (reaction ms, memory moves), and the vs-phone games keep a
/// running win count. Kept separate from the app's settings repo — it's just
/// game state.
class GameScores {
  GameScores._();

  static SharedPreferences? _p;
  static Future<SharedPreferences> get _prefs async =>
      _p ??= await SharedPreferences.getInstance();

  static String _k(String id) => 'game_best_$id';

  static Future<int?> best(String id) async => (await _prefs).getInt(_k(id));

  /// Saves [value] as the new best if it beats the stored one. Returns the
  /// current best afterwards.
  static Future<int> record(
    String id,
    int value, {
    bool lowerIsBetter = false,
  }) async {
    final p = await _prefs;
    final cur = p.getInt(_k(id));
    final better = cur == null || (lowerIsBetter ? value < cur : value > cur);
    if (better) {
      await p.setInt(_k(id), value);
      return value;
    }
    return cur;
  }

  /// Increments a running counter (used for vs-phone wins). Returns the total.
  static Future<int> increment(String id) async {
    final p = await _prefs;
    final n = (p.getInt(_k(id)) ?? 0) + 1;
    await p.setInt(_k(id), n);
    return n;
  }
}
