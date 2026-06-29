import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import 'member_sheet.dart';
import 'pod_models.dart';

/// A sample group-chat surface (UI shell). Messages are local-only and not
/// persisted or sent anywhere — real, moderated cross-device chat arrives with
/// the backend (accounts + realtime + reporting/blocking).
class GroupChatScreen extends StatefulWidget {
  const GroupChatScreen({
    super.key,
    required this.podName,
    required this.memberCount,
    required this.capacity,
  });

  final String podName;
  final int memberCount;
  final int capacity;

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _Message {
  const _Message(this.member, this.text, {this.mine = false});
  final Member member;
  final String text;
  final bool mine;
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  final _input = TextEditingController();
  final _scroll = ScrollController();

  static const _you = Member(name: 'You', you: true);

  late final List<_Message> _messages = [
    _Message(sampleMembers[0],
        'Did anyone do their rung today? I asked a barista a question 😅'),
    _Message(sampleMembers[1],
        'Nice!! I predicted an 8, it was like a 3. Wild how that works.'),
    _Message(sampleMembers[2],
        'Still building up to mine. Reading your wins helps though.'),
    _Message(sampleMembers[0],
        'No rush at all. We are all just one small step at a time here.'),
  ];

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _send() {
    final text = _input.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_Message(_you, text, mine: true));
      _input.clear();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(_scroll.position.maxScrollExtent,
            duration: Motion.base, curve: Motion.ease);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.podName, style: t.titleMedium),
            Text('${widget.memberCount}/${widget.capacity} introverts · be kind',
                style: t.bodyMedium),
          ],
        ),
      ),
      body: Column(
        children: [
          const _PreviewBanner(),
          Expanded(
            child: ListView.builder(
              controller: _scroll,
              padding: const EdgeInsets.all(Insets.lg),
              itemCount: _messages.length,
              itemBuilder: (_, i) => _Bubble(message: _messages[i]),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  Insets.md, Insets.sm, Insets.md, Insets.md),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _input,
                      textCapitalization: TextCapitalization.sentences,
                      onSubmitted: (_) => _send(),
                      decoration: InputDecoration(
                        hintText: 'Say something kind…',
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surface,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: Insets.md, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: Radii.pill,
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: Radii.pill,
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: Insets.sm),
                  IconButton.filled(
                    style: IconButton.styleFrom(
                        backgroundColor: AppColors.primary),
                    onPressed: _send,
                    icon: const Icon(Icons.arrow_upward_rounded),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewBanner extends StatelessWidget {
  const _PreviewBanner();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.accentSoft,
      padding: const EdgeInsets.symmetric(
          horizontal: Insets.lg, vertical: Insets.sm),
      child: Text(
        'Preview · messages stay on your device for now. Real, moderated pods '
        'arrive with accounts.',
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: AppColors.accentDeep),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.message});
  final _Message message;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final mine = message.mine;
    final m = message.member;

    final bubble = Container(
      padding: const EdgeInsets.all(Insets.md),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.68),
      decoration: BoxDecoration(
        color: mine ? AppColors.primary : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radii.md,
          topRight: Radii.md,
          bottomLeft: Radius.circular(mine ? 16 : 4),
          bottomRight: Radius.circular(mine ? 4 : 16),
        ),
        border: mine ? null : Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!mine)
            Text(m.locked ? 'Private member' : m.name,
                style: t.bodyMedium?.copyWith(
                    color: AppColors.primaryDeep,
                    fontWeight: FontWeight.w700)),
          if (!mine) const SizedBox(height: 2),
          Text(message.text,
              style: t.bodyLarge
                  ?.copyWith(color: mine ? Colors.white : Theme.of(context).colorScheme.onSurface)),
        ],
      ),
    );

    if (mine) {
      return Align(
        alignment: Alignment.centerRight,
        child: Padding(
            padding: const EdgeInsets.only(bottom: Insets.md), child: bubble),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: Insets.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tap the avatar → member detail sheet (honours profile lock).
          GestureDetector(
            onTap: () => showMemberSheet(context, m),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primary.withValues(alpha: 0.15),
              child: m.locked
                  ? const Icon(Icons.lock_outline_rounded,
                      size: 16, color: AppColors.primaryDeep)
                  : Text(m.initial,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryDeep)),
            ),
          ),
          const SizedBox(width: Insets.sm),
          Flexible(child: bubble),
        ],
      ),
    );
  }
}
