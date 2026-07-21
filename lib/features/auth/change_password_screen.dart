import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rung/core/haptics.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../app/providers.dart';
import '../../app/router.dart';
import '../../core/errors.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';

/// In-app "change password" for a signed-in user. Distinct from the
/// forgotten-password recovery flow on the sign-in screen — this needs a live
/// session and just swaps the password on the current account.
class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _busy = false;
  bool _obscure = true;
  String? _error;

  @override
  void dispose() {
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  String? _validatePassword(String? v) {
    final l = AppLocalizations.of(context);
    final s = v ?? '';
    if (s.isEmpty) return l.authEnterPassword;
    if (s.length < 6) return l.authMin6;
    return null;
  }

  String? _validateConfirm(String? v) {
    if ((v ?? '') != _password.text) {
      return AppLocalizations.of(context).authPwMismatch;
    }
    return null;
  }

  Future<void> _submit() async {
    final l = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    // Engage the busy state first so the button reacts on the tap; clear it in
    // the same synchronous pass if the form is invalid (no spinner flash).
    setState(() {
      _busy = true;
      _error = null;
    });
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) {
      setState(() => _busy = false);
      return;
    }
    Haptics.light();
    try {
      await ref.read(authRepositoryProvider).updatePassword(_password.text);
      if (!mounted) return;
      Haptics.medium();
      messenger.showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(l.profileChangePwSaved),
      ));
      // updatePassword fires a `userUpdated` auth event, which trips the
      // router's refreshListenable. go_router restores an imperatively-pushed
      // route on refresh, so a plain pop (Navigator OR go_router) is undone and
      // this screen reappears. Navigate to a definite location instead — that
      // clears the imperative stack and survives the refresh. Both entry points
      // (profile + reset-link recovery) are signed in, so Home is safe.
      context.go(Routes.dashboard);
    } on AuthException catch (e) {
      if (mounted) {
        setState(() => _error = isOfflineError(e) ? l.errorOffline : e.message);
      }
    } catch (e) {
      if (mounted) {
        setState(() =>
            _error = isOfflineError(e) ? l.errorOffline : l.authGenericError);
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.profileChangePwTitle)),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
                Insets.lg, Insets.lg, Insets.lg, Insets.xl),
            children: [
              Text(l.profileChangePwSub,
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: Insets.lg),
              TextFormField(
                controller: _password,
                obscureText: _obscure,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: _validatePassword,
                decoration: InputDecoration(
                  labelText: l.authNewPassword,
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  helperText: l.authMin6,
                  suffixIcon: IconButton(
                    icon: Icon(_obscure
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined),
                    tooltip: _obscure ? l.authShowPassword : l.authHidePassword,
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: Insets.md),
              TextFormField(
                controller: _confirm,
                obscureText: _obscure,
                textInputAction: TextInputAction.done,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: _validateConfirm,
                onFieldSubmitted: (_) => _busy ? null : _submit(),
                decoration: InputDecoration(
                  labelText: l.authConfirmNewPassword,
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  border: const OutlineInputBorder(),
                ),
              ),
              if (_error != null) ...[
                const SizedBox(height: Insets.md),
                Text(_error!,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.error)),
              ],
              const SizedBox(height: Insets.lg),
              FilledButton(
                onPressed: _busy ? null : _submit,
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                ),
                child: _busy
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white))
                    : Text(l.authUpdatePasswordCta),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
