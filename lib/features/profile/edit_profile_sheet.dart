import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/theme/app_theme.dart';
import 'profile_sync.dart';

/// Edit display name + short bio. Stored locally now; will upsert into the
/// Supabase `profiles` row once signed in.
Future<void> showEditProfileSheet(BuildContext context, WidgetRef ref) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: const _EditProfileForm(),
    ),
  );
}

class _EditProfileForm extends ConsumerStatefulWidget {
  const _EditProfileForm();
  @override
  ConsumerState<_EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends ConsumerState<_EditProfileForm> {
  late final TextEditingController _name;
  late final TextEditingController _bio;

  @override
  void initState() {
    super.initState();
    final settings = ref.read(settingsRepositoryProvider);
    _name = TextEditingController(text: settings.displayName ?? '');
    _bio = TextEditingController(text: settings.bio ?? '');
  }

  @override
  void dispose() {
    _name.dispose();
    _bio.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final settings = ref.read(settingsRepositoryProvider);
    await settings.setDisplayName(_name.text);
    await settings.setBio(_bio.text);
    await pushIdentityToCloud(ref); // publish new name/bio to pod members
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(Insets.lg, 0, Insets.lg, Insets.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Edit profile', style: t.titleLarge),
          const SizedBox(height: Insets.lg),
          TextField(
            controller: _name,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Display name',
              hintText: 'What should pods call you?',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: Insets.md),
          TextField(
            controller: _bio,
            textCapitalization: TextCapitalization.sentences,
            maxLines: 3,
            maxLength: 140,
            decoration: const InputDecoration(
              labelText: 'Short bio (optional)',
              hintText: 'A line about you — kept private if you lock your profile.',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: Insets.sm),
          FilledButton(onPressed: _save, child: const Text('Save')),
        ],
      ),
    );
  }
}
