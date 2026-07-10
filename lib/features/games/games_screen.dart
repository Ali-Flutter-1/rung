import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';
import 'connect_four_screen.dart';
import 'game_2048_screen.dart';
import 'game_scores.dart';
import 'memory_match_screen.dart';
import 'quick_math_screen.dart';
import 'reaction_screen.dart';
import 'sequence_memory_screen.dart';
import 'tic_tac_toe_screen.dart';

/// A small hub of calm, offline games — a stress break, not a headline. Shows
/// your best per game (persisted locally). Add new games by dropping another
/// [_GameCard] here.
class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  Map<String, int?> _bestVals = {};

  @override
  void initState() {
    super.initState();
    _loadBests();
  }

  Future<void> _loadBests() async {
    final r = await GameScores.best('reaction');
    final s = await GameScores.best('sequence');
    final g = await GameScores.best('2048');
    final q = await GameScores.best('quickmath');
    final m = await GameScores.best('memory');
    final ttt = await GameScores.best('tictactoe');
    final c4 = await GameScores.best('connect4');
    if (!mounted) return;
    setState(() {
      _bestVals = {
        'reaction': r,
        'sequence': s,
        '2048': g,
        'quickmath': q,
        'memory': m,
        'tictactoe': ttt,
        'connect4': c4,
      };
    });
  }

  String _short(int v) => v >= 1000 ? '${(v / 1000).toStringAsFixed(1)}k' : '$v';

  /// Localized "best" label for a game, or null when there's no score yet.
  String? _bestLabel(AppLocalizations l, String id, int? v) {
    if (v == null) return null;
    switch (id) {
      case 'reaction':
        return l.gamesBestMs(v);
      case 'sequence':
        return l.gamesBestLevel(v);
      case '2048':
        return l.gamesBest(_short(v));
      case 'quickmath':
        return l.gamesBest('$v');
      case 'memory':
        return l.gamesBestMoves(v);
      case 'tictactoe':
      case 'connect4':
        return v == 0 ? null : l.gamesWinsVsPhone(v);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.dashTakeABreak)),
      body: ListView(
        padding:
            const EdgeInsets.fromLTRB(Insets.lg, Insets.md, Insets.lg, Insets.xl),
        children: [
          Text(
            l.gamesIntro,
            style: t.bodyMedium?.copyWith(color: AppColors.inkMuted),
          ),
          const SizedBox(height: Insets.lg),
          for (final (i, g) in _games.indexed) ...[
            _GameCard(
              id: g.id,
              emoji: g.emoji,
              title: _gameTitle(l, g.id),
              subtitle: _gameSub(l, g.id),
              best: _bestLabel(l, g.id, _bestVals[g.id]),
              colors: g.colors,
              builder: g.builder,
              onPlayed: _loadBests,
            )
                .animate(delay: (i * 55).ms)
                .fadeIn(duration: 300.ms)
                .slideY(begin: 0.10, end: 0, curve: Curves.easeOut),
            if (i < _games.length - 1) const SizedBox(height: Insets.md),
          ],
        ],
      ),
    );
  }
}

/// The catalogue. Add a game by appending one entry. Titles/subtitles are
/// resolved per-locale in [_gameTitle] / [_gameSub] keyed by [id].
final _games = <_GameSpec>[
  _GameSpec('reaction', '⚡',
      const [Color(0xFF3FA46A), Color(0xFF2C6B48)], (_) => const ReactionScreen()),
  _GameSpec('sequence', '🔵',
      const [Color(0xFF6B8FC9), Color(0xFF33507E)],
      (_) => const SequenceMemoryScreen()),
  _GameSpec('2048', '🔢',
      const [Color(0xFFE0574F), Color(0xFF9E3B36)], (_) => const Game2048Screen()),
  _GameSpec('quickmath', '🧮',
      const [Color(0xFF4C9A6B), Color(0xFF2C6B48)], (_) => const QuickMathScreen()),
  _GameSpec('tictactoe', '⭕',
      const [Color(0xFF3AA8A0), Color(0xFF23736D)],
      (_) => const TicTacToeScreen()),
  _GameSpec('connect4', '🔴',
      const [Color(0xFFF2A65A), Color(0xFFC97B3D)],
      (_) => const ConnectFourScreen()),
  _GameSpec('memory', '🧠',
      const [Color(0xFFB187C9), Color(0xFF7C5296)],
      (_) => const MemoryMatchScreen()),
];

// 2048 / Tic-Tac-Toe / Connect 4 are universal game names — kept untranslated.
String _gameTitle(AppLocalizations l, String id) => switch (id) {
      'reaction' => l.gameTitleReaction,
      'sequence' => l.gameTitleSequence,
      '2048' => '2048',
      'quickmath' => l.gameTitleQuickMath,
      'tictactoe' => 'Tic-Tac-Toe',
      'connect4' => 'Connect 4',
      'memory' => l.gameTitleMemory,
      _ => id,
    };

String _gameSub(AppLocalizations l, String id) => switch (id) {
      'reaction' => l.gameSubReaction,
      'sequence' => l.gameSubSequence,
      '2048' => l.gameSub2048,
      'quickmath' => l.gameSubQuickMath,
      'tictactoe' => l.gameSubTicTacToe,
      'connect4' => l.gameSubConnect4,
      'memory' => l.gameSubMemory,
      _ => '',
    };

class _GameSpec {
  const _GameSpec(this.id, this.emoji, this.colors, this.builder);
  final String id;
  final String emoji;
  final List<Color> colors;
  final WidgetBuilder builder;
}

class _GameCard extends StatelessWidget {
  const _GameCard({
    required this.id,
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.colors,
    required this.builder,
    this.best,
    this.onPlayed,
  });
  final String id;
  final String emoji;
  final String title;
  final String subtitle;
  final List<Color> colors;
  final WidgetBuilder builder;
  final String? best;
  final VoidCallback? onPlayed;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final hasBest = best != null && best!.isNotEmpty;
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(MaterialPageRoute(builder: builder));
        onPlayed?.call();
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(Insets.lg),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: Radii.lgAll,
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: colors,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: colors.last.withValues(alpha: 0.30),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(emoji, style: const TextStyle(fontSize: 24)),
            ),
            const SizedBox(width: Insets.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: t.titleMedium),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: t.bodyMedium?.copyWith(color: AppColors.inkMuted)),
                  if (hasBest) ...[
                    const SizedBox(height: 6),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.emoji_events_rounded,
                            size: 13, color: AppColors.accentDeep),
                        const SizedBox(width: 4),
                        Text(best!,
                            style: t.bodySmall?.copyWith(
                                color: AppColors.accentDeep,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.inkFaint),
          ],
        ),
      ),
    );
  }
}
