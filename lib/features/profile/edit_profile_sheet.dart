import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';
import 'profile_sync.dart';

/// Edit display name + short bio. Stored locally now; will upsert into the
/// Supabase `profiles` row once signed in.
Future<void> showEditProfileSheet(BuildContext context, WidgetRef ref) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
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
  bool _busy = false;

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
    if (_busy) return; // a double-tap must not save twice and pop twice
    setState(() => _busy = true);
    final settings = ref.read(settingsRepositoryProvider);
    try {
      await settings.setDisplayName(_name.text);
      await settings.setBio(_bio.text);
      await pushIdentityToCloud(ref); // publish new name/bio to pod members
    } catch (_) {
      // A local prefs-write failure must never throw out of the button's async
      // callback (that would reach the global handler). Best-effort; close.
    }
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final l = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(Insets.lg, 0, Insets.lg, Insets.lg),
      // Scroll when the keyboard + fields exceed a short screen (avoids overflow).
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.editProfileTitle, style: t.titleLarge),
            const SizedBox(height: Insets.lg),
            TextField(
              controller: _name,
              onTapOutside: (_) {},
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: l.editDisplayName,
                hintText: l.editDisplayNameHint,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: Insets.md),
            TextField(
              controller: _bio,
              onTapOutside: (_) {},
              textCapitalization: TextCapitalization.sentences,
              maxLines: 3,
              maxLength: 140,
              decoration: InputDecoration(
                labelText: l.editBio,
                hintText: l.editBioHint,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: Insets.sm),
            TextFieldTapRegion(
              child: FilledButton(
                onPressed: _busy ? null : _save,
                child: Text(l.commonSave),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
