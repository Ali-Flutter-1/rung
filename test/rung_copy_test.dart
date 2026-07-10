import 'package:flutter_test/flutter_test.dart';
import 'package:rung/domain/entities/rung.dart';
import 'package:rung/l10n/app_localizations_en.dart';
import 'package:rung/l10n/app_localizations_fr.dart';
import 'package:rung/shared/rung_copy.dart';

Rung rung({String whatToDo = '', String whyItHelps = ''}) => Rung(
      id: 'r1',
      trackId: 't1',
      title: 'Ask my manager for feedback',
      whatToDo: whatToDo,
      whyItHelps: whyItHelps,
      difficulty: 4,
      sortOrder: 1,
      isCustom: true,
    );

void main() {
  final en = AppLocalizationsEn();
  final fr = AppLocalizationsFr();

  group('custom-rung copy follows the active locale', () {
    test('empty whyItHelps renders the app default, not stored text', () {
      expect(rung().whyItHelpsText(en), 'You named this one — that makes it count.');
      expect(rung().whyItHelpsText(fr),
          "Tu as nommé celui-ci – c'est ce qui le rend important.");
    });

    test('empty whatToDo renders the app default', () {
      expect(rung().whatToDoText(en), 'A challenge you set for yourself.');
      expect(rung().whatToDoText(fr), 'Un défi que tu te fixes.');
    });

    test('the same rung reads differently after a language switch', () {
      final r = rung();
      expect(r.whyItHelpsText(en), isNot(r.whyItHelpsText(fr)));
    });
  });

  group("the user's own words are never replaced", () {
    test('non-empty whatToDo is returned verbatim in every locale', () {
      final r = rung(whatToDo: 'Pedir feedback ao chefe');
      expect(r.whatToDoText(en), 'Pedir feedback ao chefe');
      expect(r.whatToDoText(fr), 'Pedir feedback ao chefe');
    });

    test('a seeded rung keeps its (already localized) copy', () {
      final r = rung(whatToDo: 'Ask one question.', whyItHelps: 'It helps.');
      expect(r.whatToDoText(fr), 'Ask one question.');
      expect(r.whyItHelpsText(fr), 'It helps.');
    });

    test('whitespace-only counts as empty, not as user text', () {
      expect(rung(whatToDo: '   ').whatToDoText(en),
          'A challenge you set for yourself.');
    });
  });
}
