import '../entities/rung.dart';
import '../entities/track.dart';

/// Read access to tracks and their ladders (§12.3).
abstract interface class TrackRepository {
  Future<List<Track>> getTracks();
  Future<Track?> getTrack(String trackId);
  Stream<List<Track>> watchTracks();

  /// Ordered rungs for a track (easy → hard). [maxBaseRungs] caps how many
  /// *seeded* rungs are returned (per the subscription tier); the user's own
  /// custom rungs are always included. `null` = no cap.
  Future<List<Rung>> getLadder(String trackId, {int? maxBaseRungs});
  Stream<List<Rung>> watchLadder(String trackId, {int? maxBaseRungs});

  Future<Rung?> getRung(String rungId);

  /// How many custom rungs the user currently keeps (for the free all-time cap).
  Future<int> customRungCount();

  /// How many custom rungs were created since [sinceMs] (for paid per-month
  /// allowances).
  Future<int> customRungCountSince(int sinceMs);

  /// Adds a user's own rung to a track (§2.5 AddCustomRung).
  Future<Rung> addCustomRung({
    required String trackId,
    required String title,
    required String whatToDo,
    required String whyItHelps,
    required int difficulty,
  });

  /// Easiest not-yet-cleared rung, else next by difficulty (§2.5).
  Future<Rung?> recommendNextRung(String trackId);
}
