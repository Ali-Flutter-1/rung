// One-off: prints the bundled seed (tracks + rungs) as JSON so the canonical
// content can be loaded into Supabase. Run: dart run tool/dump_seed.dart
// ignore_for_file: avoid_print
import 'dart:convert';

import 'package:rung/data/seed/seed_data.dart';

void main() {
  final out = {
    'tracks': [
      for (final t in SeedData.tracks)
        {
          'id': t.id,
          'slug': t.slug,
          'title': t.title,
          'description': t.description,
          'icon': t.icon,
          'sortOrder': t.sortOrder,
          'colorSeed': t.colorSeed,
        }
    ],
    'rungs': [
      for (final r in SeedData.rungs)
        {
          'id': r.id,
          'trackId': r.trackId,
          'difficulty': r.difficulty,
          'sortOrder': r.sortOrder,
          'estMinutes': r.estMinutes,
          'title': r.title,
          'whatToDo': r.whatToDo,
          'whyItHelps': r.whyItHelps,
        }
    ],
  };
  print(jsonEncode(out));
}
