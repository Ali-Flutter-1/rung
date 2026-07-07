import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
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
  Map<String, String> _bests = {};

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
      _bests = {
        'reaction': r == null ? '' : 'Best $r ms',
        'sequence': s == null ? '' : 'Best level $s',
        '2048': g == null ? '' : 'Best ${_short(g)}',
        'quickmath': q == null ? '' : 'Best $q',
        'memory': m == null ? '' : 'Best $m moves',
        'tictactoe': (ttt ?? 0) == 0 ? '' : '$ttt wins vs phone',
        'connect4': (c4 ?? 0) == 0 ? '' : '$c4 wins vs phone',
      };
    });
  }

  String _short(int v) => v >= 1000 ? '${(v / 1000).toStringAsFixed(1)}k' : '$v';

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Take a break')),
      body: ListView(
        padding:
            const EdgeInsets.fromLTRB(Insets.lg, Insets.md, Insets.lg, Insets.xl),
        children: [
          Text(
            'Quiet games for focus and a calm mind — the kind of brain-training '
            'people find grounding. Play the phone, or pass it to a friend.',
            style: t.bodyMedium?.copyWith(color: AppColors.inkMuted),
          ),
          const SizedBox(height: Insets.lg),
          for (final (i, g) in _games.indexed) ...[
            _GameCard(
              id: g.id,
              emoji: g.emoji,
              title: g.title,
              subtitle: g.subtitle,
              best: _bests[g.id],
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

/// The catalogue. Add a game by appending one entry.
final _games = <_GameSpec>[
  _GameSpec('reaction', '⚡', 'Reaction speed', 'focus · tap when it turns green',
      const [Color(0xFF3FA46A), Color(0xFF2C6B48)], (_) => const ReactionScreen()),
  _GameSpec('sequence', '🔵', 'Sequence memory', 'memory · watch and repeat',
      const [Color(0xFF6B8FC9), Color(0xFF33507E)],
      (_) => const SequenceMemoryScreen()),
  _GameSpec('2048', '🔢', '2048', 'strategy · swipe to merge',
      const [Color(0xFFE0574F), Color(0xFF9E3B36)], (_) => const Game2048Screen()),
  _GameSpec('quickmath', '🧮', 'Quick Math', 'mental speed · 30-second sprint',
      const [Color(0xFF4C9A6B), Color(0xFF2C6B48)], (_) => const QuickMathScreen()),
  _GameSpec('tictactoe', '⭕', 'Tic-Tac-Toe', 'vs the phone · or 2 players',
      const [Color(0xFF3AA8A0), Color(0xFF23736D)],
      (_) => const TicTacToeScreen()),
  _GameSpec('connect4', '🔴', 'Connect 4', 'vs the phone · or 2 players',
      const [Color(0xFFF2A65A), Color(0xFFC97B3D)],
      (_) => const ConnectFourScreen()),
  _GameSpec('memory', '🧠', 'Memory match', 'solo · find the pairs',
      const [Color(0xFFB187C9), Color(0xFF7C5296)],
      (_) => const MemoryMatchScreen()),
];

class _GameSpec {
  const _GameSpec(
      this.id, this.emoji, this.title, this.subtitle, this.colors, this.builder);
  final String id;
  final String emoji;
  final String title;
  final String subtitle;
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
