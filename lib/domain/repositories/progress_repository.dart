import '../entities/today_suggestion.dart';
import '../entities/user_progress.dart';

/// Per-track progress + the Today surface selection (§8.1).
abstract interface class ProgressRepository {
  Future<UserProgress> getProgress(String trackId);
  Future<List<UserProgress>> getAllProgress();
  Stream<List<UserProgress>> watchAllProgress();

  /// Total rungs cleared across every track.
  Future<int> totalRungsCleared();

  /// Best current streak across tracks (the app shows one headline streak).
  Future<int> currentStreak();
  Stream<int> watchCurrentStreak();
  Stream<int> watchTotalRungsCleared();

  /// All-time longest streak (consecutive active days), derived from history.
  Future<int> bestStreak();
  Stream<int> watchBestStreak();

  /// Day-keys (yyyy-mm-dd) with a counting attempt — drives the week strip.
  Stream<Set<String>> watchActiveDays();

  /// Selects the single best rung for the Today card (§2.5 GetTodaysRung).
  Future<TodaySuggestion?> getTodaysRung();
  Stream<TodaySuggestion?> watchTodaysRung();

  /// Consumes a weekly streak-save allowance (§2.5 ApplyStreakFreeze).
  Future<bool> applyStreakFreeze(String trackId);

  /// Auto-protects a running streak from one missed day, up to [weeklyAllowance]
  /// times per week (tier-based). No-op when nothing needs protecting.
  Future<void> autoProtectStreak({required int weeklyAllowance});
}
