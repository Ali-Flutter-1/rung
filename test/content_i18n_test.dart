import 'package:flutter_test/flutter_test.dart';
import 'package:rung/data/local/app_database.dart';
import 'package:rung/data/local/content_locale.dart';

void main() {
  group('contentLocaleChain', () {
    test('English needs no chain — the base rows already are English', () {
      expect(contentLocaleChain('en'), isEmpty);
      expect(contentLocaleChain('en_US'), isEmpty);
    });

    test('a region variant falls back to its base language first', () {
      expect(contentLocaleChain('pt_PT'), ['pt_PT', 'pt']);
      expect(contentLocaleChain('pt-PT'), ['pt_PT', 'pt']);
    });

    test('a plain language is its own chain', () {
      expect(contentLocaleChain('de'), ['de']);
      expect(contentLocaleChain('ja'), ['ja']);
    });
  });

  group('localized content views', () {
    late AppDatabase db;

    String rungTitle(String id) => db
        .select('SELECT title FROM rungs_localized WHERE id = ?;', [id])
        .first['title'] as String;

    setUp(() {
      db = AppDatabase.openInMemory();
      // A seeded English rung at revision 100.
      db.upsertContent(tracks: const [], rungs: [
        {
          'id': 'rng_x',
          'track_id': 'trk_speaking',
          'title': 'Ask a question',
          'what_to_do': 'Ask one question.',
          'why_it_helps': 'It helps.',
          'difficulty': 1,
          'sort_order': 1,
          'est_minutes': 2,
          'updated_at': 100,
          'deleted_at': null,
        },
      ]);
    });

    tearDown(() => db.close());

    test('falls back to English when no translation exists', () {
      db.setContentLocaleChain(['fr']);
      expect(rungTitle('rng_x'), 'Ask a question');
    });

    test('uses the translation when one exists for the active locale', () {
      db.upsertContent(tracks: const [], rungs: const [], rungI18n: [
        {
          'rung_id': 'rng_x',
          'locale': 'fr',
          'title': 'Pose une question',
          'what_to_do': 'Pose une question.',
          'why_it_helps': 'Ça aide.',
          'source_updated_at': 100,
        },
      ]);
      db.setContentLocaleChain(['fr']);
      expect(rungTitle('rng_x'), 'Pose une question');
    });

    test('pt_PT prefers pt_PT, then pt, then English', () {
      db.upsertContent(tracks: const [], rungs: const [], rungI18n: [
        {
          'rung_id': 'rng_x',
          'locale': 'pt',
          'title': 'Faça uma pergunta',
          'what_to_do': 'x',
          'why_it_helps': 'y',
          'source_updated_at': 100,
        },
      ]);
      // Only Brazilian exists → the pt_PT user gets pt, not English.
      db.setContentLocaleChain(['pt_PT', 'pt']);
      expect(rungTitle('rng_x'), 'Faça uma pergunta');

      // Now European Portuguese arrives and wins on rank.
      db.upsertContent(tracks: const [], rungs: const [], rungI18n: [
        {
          'rung_id': 'rng_x',
          'locale': 'pt_PT',
          'title': 'Faz uma pergunta',
          'what_to_do': 'x',
          'why_it_helps': 'y',
          'source_updated_at': 100,
        },
      ]);
      expect(rungTitle('rng_x'), 'Faz uma pergunta');
    });

    test(
        'a translation made from older English copy is refused — it describes a '
        'different exercise', () {
      db.upsertContent(tracks: const [], rungs: const [], rungI18n: [
        {
          'rung_id': 'rng_x',
          'locale': 'fr',
          'title': 'Ancienne traduction',
          'what_to_do': 'x',
          'why_it_helps': 'y',
          'source_updated_at': 100, // translated from revision 100
        },
      ]);
      db.setContentLocaleChain(['fr']);
      expect(rungTitle('rng_x'), 'Ancienne traduction');

      // English copy is rewritten (à la migration 0012) → revision 200.
      db.upsertContent(tracks: const [], rungs: [
        {
          'id': 'rng_x',
          'track_id': 'trk_speaking',
          'title': 'Ask a DIFFERENT question',
          'what_to_do': 'Ask something else.',
          'why_it_helps': 'It helps.',
          'difficulty': 1,
          'sort_order': 1,
          'est_minutes': 2,
          'updated_at': 200,
          'deleted_at': null,
        },
      ]);
      // The stale French must NOT be shown — English wins until re-translated.
      expect(rungTitle('rng_x'), 'Ask a DIFFERENT question');
    });

    test('an empty chain resolves to English', () {
      db.upsertContent(tracks: const [], rungs: const [], rungI18n: [
        {
          'rung_id': 'rng_x',
          'locale': 'fr',
          'title': 'Pose une question',
          'what_to_do': 'x',
          'why_it_helps': 'y',
          'source_updated_at': 100,
        },
      ]);
      db.setContentLocaleChain(const []);
      expect(rungTitle('rng_x'), 'Ask a question');
    });

    test('custom rungs are never translated', () {
      db.run(
        "INSERT INTO rungs (id, track_id, title, what_to_do, why_it_helps, "
        "difficulty, sort_order, is_custom, est_minutes, updated_at) "
        "VALUES ('rng_mine', 'trk_speaking', 'My own step', 'do it', "
        "'because', 3, 99, 1, 5, 0);",
      );
      db.setContentLocaleChain(['fr']);
      expect(rungTitle('rng_mine'), 'My own step');
    });

    test('setContentLocaleChain reports whether it actually changed', () {
      expect(db.setContentLocaleChain(['fr']), isTrue);
      expect(db.setContentLocaleChain(['fr']), isFalse);
      expect(db.setContentLocaleChain(['pt_PT', 'pt']), isTrue);
      expect(db.setContentLocaleChain(['pt', 'pt_PT']), isTrue); // order matters
    });
  });
}
