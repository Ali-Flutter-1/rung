// Tier content limits: rung depth per track (free 10 / monthly 40 / yearly 60)
// and the custom-rung cap (free 5, paid unlimited), plus the ladder cap query.
import 'package:flutter_test/flutter_test.dart';
import 'package:rung/data/local/app_database.dart';
import 'package:rung/data/repositories/local_track_repository.dart';
import 'package:rung/domain/entities/subscription.dart';

void main() {
  group('ContentRules', () {
    test('rung depth per tier', () {
      expect(ContentRules.maxRungsPerTrack(SubscriptionTier.free), 5);
      expect(ContentRules.maxRungsPerTrack(SubscriptionTier.monthly), 30);
      expect(ContentRules.maxRungsPerTrack(SubscriptionTier.yearly), 40);
    });

    test('custom-rung cap: free 5 all-time, monthly 30/mo, yearly 40/mo', () {
      expect(ContentRules.maxCustomRungs(SubscriptionTier.free), 5);
      expect(ContentRules.maxCustomRungs(SubscriptionTier.monthly), 30);
      expect(ContentRules.maxCustomRungs(SubscriptionTier.yearly), 40);

      // Free is an all-time total; paid is windowed per month.
      expect(ContentRules.customRungCapIsMonthly(SubscriptionTier.free), false);
      expect(ContentRules.customRungCapIsMonthly(SubscriptionTier.monthly), true);
      expect(ContentRules.customRungCapIsMonthly(SubscriptionTier.yearly), true);

      // Each tier blocks once the window count reaches its cap.
      expect(ContentRules.canAddCustomRung(SubscriptionTier.free, 4), isTrue);
      expect(ContentRules.canAddCustomRung(SubscriptionTier.free, 5), isFalse);
      expect(ContentRules.canAddCustomRung(SubscriptionTier.monthly, 29), isTrue);
      expect(ContentRules.canAddCustomRung(SubscriptionTier.monthly, 30), isFalse);
      expect(ContentRules.canAddCustomRung(SubscriptionTier.yearly, 39), isTrue);
      expect(ContentRules.canAddCustomRung(SubscriptionTier.yearly, 40), isFalse);
    });
  });

  group('ladder cap', () {
    late AppDatabase db;
    late LocalTrackRepository tracks;

    setUp(() {
      db = AppDatabase.openInMemory();
      tracks = LocalTrackRepository(db);
    });
    tearDown(() => db.close());

    test('caps seeded rungs but always shows custom rungs', () async {
      // Track has 10 seeded rungs; free tier limit is 10 → all shown.
      expect((await tracks.getLadder('trk_speaking', maxBaseRungs: 10)).length,
          10);

      // A tighter cap (5) shows only the first 5 seeded rungs...
      final capped = await tracks.getLadder('trk_speaking', maxBaseRungs: 5);
      expect(capped.length, 5);

      // ...but a custom rung the user added is always included on top.
      await tracks.addCustomRung(
        trackId: 'trk_speaking',
        title: 'Mine',
        whatToDo: 'x',
        whyItHelps: 'y',
        difficulty: 3,
      );
      final withCustom =
          await tracks.getLadder('trk_speaking', maxBaseRungs: 5);
      expect(withCustom.length, 6);
      expect(withCustom.where((r) => r.isCustom).length, 1);
      expect(await tracks.customRungCount(), 1);
    });
  });
}
