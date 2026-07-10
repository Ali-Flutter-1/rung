// Custom rungs end-to-end against the real (in-memory) SQLite store.
//
// The invariant: app-supplied default copy is NEVER written into the row (it
// would be stranded in the language it was created in), while the user's own
// words are stored verbatim and never translated.
import 'package:flutter_test/flutter_test.dart';
import 'package:rung/data/local/app_database.dart';
import 'package:rung/data/repositories/local_track_repository.dart';
import 'package:rung/l10n/app_localizations_en.dart';
import 'package:rung/l10n/app_localizations_ja.dart';
import 'package:rung/shared/rung_copy.dart';

void main() {
  late AppDatabase db;
  late LocalTrackRepository tracks;

  final en = AppLocalizationsEn();
  final ja = AppLocalizationsJa();

  setUp(() {
    db = AppDatabase.openInMemory();
    tracks = LocalTrackRepository(db);
  });

  tearDown(() => db.close());

  Map<String, Object?> row(String id) =>
      db.select('SELECT * FROM rungs WHERE id = ?;', [id]).first;

  group('the app never freezes its own copy into the row', () {
    test('a blank "what will you do" is stored empty, not as default text', () async {
      final r = await tracks.addCustomRung(
        trackId: 'trk_speaking',
        title: 'Speak at standup',
        whatToDo: '',
        whyItHelps: '',
        difficulty: 4,
      );
      expect(row(r.id)['what_to_do'], '');
      expect(row(r.id)['why_it_helps'], '');
    });

    test('the default is rendered from the ACTIVE locale at display time', () async {
      final r = await tracks.addCustomRung(
        trackId: 'trk_speaking',
        title: 'Speak at standup',
        whatToDo: '',
        whyItHelps: '',
        difficulty: 4,
      );
      expect(r.whyItHelpsText(en), en.customDefaultWhy);
      expect(r.whyItHelpsText(ja), ja.customDefaultWhy);
      expect(r.whyItHelpsText(en), isNot(r.whyItHelpsText(ja)),
          reason: 'the same row must read differently after a language switch');
    });
  });

  group("the user's own words are untouched", () {
    test('typed text is stored verbatim', () async {
      const typed = 'Pedir feedback ao chefe';
      final r = await tracks.addCustomRung(
        trackId: 'trk_speaking',
        title: 'Feedback',
        whatToDo: typed,
        whyItHelps: '',
        difficulty: 3,
      );
      expect(row(r.id)['what_to_do'], typed);
    });

    test('typed text is returned unchanged in every locale', () async {
      const typed = 'Pedir feedback ao chefe';
      final r = await tracks.addCustomRung(
        trackId: 'trk_speaking',
        title: 'Feedback',
        whatToDo: typed,
        whyItHelps: '',
        difficulty: 3,
      );
      expect(r.whatToDoText(en), typed);
      expect(r.whatToDoText(ja), typed);
    });
  });

  group('seeded rungs are unaffected', () {
    test('they carry their own copy and never fall back to the default', () async {
      final ladder = await tracks.getLadder('trk_speaking');
      final seeded = ladder.first;
      expect(seeded.isCustom, isFalse);
      expect(seeded.whatToDo.trim(), isNotEmpty);
      expect(seeded.whyItHelps.trim(), isNotEmpty);
      expect(seeded.whyItHelpsText(ja), seeded.whyItHelps,
          reason: 'seeded copy must not be replaced by the custom default');
    });
  });

  test('a custom rung is marked custom and lands on the ladder', () async {
    final before = (await tracks.getLadder('trk_speaking')).length;
    final r = await tracks.addCustomRung(
      trackId: 'trk_speaking',
      title: 'My own step',
      whatToDo: '',
      whyItHelps: '',
      difficulty: 5,
    );
    expect(r.isCustom, isTrue);
    final after = await tracks.getLadder('trk_speaking');
    expect(after.length, before + 1);
    expect(after.map((x) => x.id), contains(r.id));
  });
}
