import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../app/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/subscription.dart';
import '../../shared/rung_logo.dart';
import '../legal/legal_screens.dart';
import '../profile/profile_sync.dart';

/// Sign in / sign up — the account gate for Groups + cloud backup. The core
/// loop itself works on-device; an account adds the community + sync.
class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  final _name = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmFocus = FocusNode();

  bool _signUp = true;
  bool _busy = false;
  bool _obscure = true;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    _name.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmFocus.dispose();
    super.dispose();
  }

  static final _emailRe = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  String? _validateEmail(String? v) {
    final s = (v ?? '').trim();
    if (s.isEmpty) return 'Enter your email';
    if (!_emailRe.hasMatch(s)) return 'That email doesn\'t look right';
    return null;
  }

  String? _validatePassword(String? v) {
    final s = v ?? '';
    if (s.isEmpty) return 'Enter a password';
    if (s.length < 6) return 'At least 6 characters';
    return null;
  }

  String? _validateConfirm(String? v) {
    if (!_signUp) return null;
    if ((v ?? '') != _password.text) return 'Passwords don\'t match';
    return null;
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    HapticFeedback.lightImpact();
    setState(() {
      _busy = true;
      _error = null;
    });
    final auth = ref.read(authRepositoryProvider);
    try {
      if (_signUp) {
        await auth.signUp(
          email: _email.text.trim(),
          password: _password.text,
          displayName: _name.text.trim().isEmpty ? null : _name.text.trim(),
        );
      } else {
        await auth.signIn(email: _email.text.trim(), password: _password.text);
      }
      if (!mounted) return;
      // If email confirmation is required, there may be no session yet.
      if (auth.isSignedIn) {
        TextInput.finishAutofillContext(); // let the OS offer to save the login
        final uid = auth.currentUser?.id;
        if (uid != null) ref.read(analyticsProvider).identify(uid);
        await _handleAccountSession();
        if (!mounted) return;
        // As the auth gate there's nothing to pop — the router redirect moves
        // us into the app. When pushed (e.g. re-auth), pop back.
        if (Navigator.of(context).canPop()) Navigator.of(context).pop();
      } else if (mounted) {
        setState(() => _error =
            'Check your email to confirm, then sign in. (Or disable email '
            'confirmation in Supabase Auth settings for quick testing.)');
      }
    } on AuthException catch (e) {
      if (mounted) setState(() => _error = e.message);
    } catch (_) {
      if (mounted) setState(() => _error = 'Something went wrong. Try again.');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  /// On sign-in: if a *different* account signed in on this device, wipe the
  /// previous account's local data so account B never sees account A's data.
  /// Then load this account's identity (name/bio/lock) from its cloud profile
  /// and restore its progress from the cloud.
  Future<void> _handleAccountSession() async {
    final settings = ref.read(settingsRepositoryProvider);
    final cloud = ref.read(cloudRepositoryProvider);
    final newUid = ref.read(authRepositoryProvider).currentUser?.id;
    if (newUid == null) return;

    final switched =
        settings.lastUserId != null && settings.lastUserId != newUid;
    if (switched) {
      ref.read(databaseProvider).resetUserData();
      await settings.setDisplayName(null);
      await settings.setBio(null);
      await settings.setProfileLocked(false);
      await settings.setSubscriptionTier(SubscriptionTier.free);
    }
    await settings.setLastUserId(newUid);

    try {
      final p = await cloud.getProfile(newUid);
      if (p != null) {
        await settings.setDisplayName(p.displayName);
        await settings.setBio(p.bio);
        await settings.setProfileLocked(p.isLocked);
      }
    } catch (_) {/* identity load is best-effort */}

    // Pull this account's backed-up progress, streak and custom rungs into
    // local storage. After an account switch local was wiped, so this restores
    // the signed-in account's real data (instead of showing zeros). Notes stay
    // on-device — they're never backed up.
    try {
      await ref.read(syncServiceProvider).restoreFromCloud();
    } catch (_) {/* restore is best-effort; never block sign-in */}

    // Local now reflects this account's real numbers, so a full profile push
    // (incl. stats) is safe and keeps the pod profile == the dashboard.
    await pushProfileToCloud(ref);
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: AutofillGroup(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                  Insets.lg, Insets.lg, Insets.lg, Insets.xl),
              children: [
                const Center(child: RungLogo(size: 72)),
                const SizedBox(height: Insets.lg),
                Text(_signUp ? 'Create your account' : 'Welcome back',
                    textAlign: TextAlign.center, style: t.headlineMedium),
                const SizedBox(height: Insets.xs),
                Text(
                  _signUp
                      ? 'Join the pods and keep your progress safe across devices.'
                      : 'Sign in to your pods and synced progress.',
                  textAlign: TextAlign.center,
                  style: t.bodyMedium?.copyWith(color: AppColors.inkMuted),
                ),
                const SizedBox(height: Insets.xl),
                if (_signUp) ...[
                  TextFormField(
                    controller: _name,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.name],
                    onEditingComplete: () => _emailFocus.requestFocus(),
                    decoration: const InputDecoration(
                      labelText: 'Display name (optional)',
                      prefixIcon: Icon(Icons.badge_outlined),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: Insets.md),
                ],
                TextFormField(
                  controller: _email,
                  focusNode: _emailFocus,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autocorrect: false,
                  enableSuggestions: false,
                  autofillHints: const [AutofillHints.email],
                  validator: _validateEmail,
                  onEditingComplete: () => _passwordFocus.requestFocus(),
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.mail_outline_rounded),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: Insets.md),
                TextFormField(
                  controller: _password,
                  focusNode: _passwordFocus,
                  obscureText: _obscure,
                  textInputAction:
                      _signUp ? TextInputAction.next : TextInputAction.done,
                  autofillHints: [
                    _signUp ? AutofillHints.newPassword : AutofillHints.password
                  ],
                  validator: _validatePassword,
                  onEditingComplete: () => _signUp
                      ? _confirmFocus.requestFocus()
                      : _submit(),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    helperText: _signUp ? 'At least 6 characters' : null,
                    suffixIcon: IconButton(
                      icon: Icon(_obscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                      tooltip: _obscure ? 'Show password' : 'Hide password',
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                if (_signUp) ...[
                  const SizedBox(height: Insets.md),
                  TextFormField(
                    controller: _confirm,
                    focusNode: _confirmFocus,
                    obscureText: _obscure,
                    textInputAction: TextInputAction.done,
                    autofillHints: const [AutofillHints.newPassword],
                    validator: _validateConfirm,
                    onEditingComplete: _submit,
                    decoration: const InputDecoration(
                      labelText: 'Confirm password',
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
                if (_error != null) ...[
                  const SizedBox(height: Insets.md),
                  _ErrorBanner(message: _error!),
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
                      : Text(_signUp ? 'Create account' : 'Sign in'),
                ),
                const SizedBox(height: Insets.sm),
                TextButton(
                  onPressed: _busy
                      ? null
                      : () => setState(() {
                            _signUp = !_signUp;
                            _error = null;
                            _formKey.currentState?.reset();
                          }),
                  child: Text(_signUp
                      ? 'I already have an account'
                      : "I'm new — create an account"),
                ),
                const SizedBox(height: Insets.sm),
                _LegalFooter(signUp: _signUp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// "By continuing you agree to …" with tappable Terms + Privacy links.
class _LegalFooter extends StatelessWidget {
  const _LegalFooter({required this.signUp});
  final bool signUp;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final muted = t.bodySmall?.copyWith(color: AppColors.inkMuted);
    final link = t.bodySmall?.copyWith(
        color: AppColors.primaryDeep, fontWeight: FontWeight.w600);
    void open(Widget page) => Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => page));
    return Text.rich(
      TextSpan(
        style: muted,
        children: [
          TextSpan(
              text: signUp
                  ? 'By creating an account you agree to our '
                  : 'By continuing you agree to our '),
          TextSpan(
            text: 'Terms',
            style: link,
            recognizer: TapGestureRecognizer()
              ..onTap = () => open(const TermsScreen()),
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy',
            style: link,
            recognizer: TapGestureRecognizer()
              ..onTap = () => open(const PrivacyPolicyScreen()),
          ),
          const TextSpan(text: '.'),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(Insets.md),
      decoration: BoxDecoration(
        color: AppColors.accentSoft,
        borderRadius: Radii.card,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline_rounded,
              size: 20, color: AppColors.accentDeep),
          const SizedBox(width: Insets.sm),
          Expanded(
            child: Text(message,
                style: t.bodyMedium?.copyWith(color: AppColors.accentDeep)),
          ),
        ],
      ),
    );
  }
}
