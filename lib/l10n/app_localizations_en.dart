// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get navHome => 'Home';

  @override
  String get navGroups => 'Groups';

  @override
  String get navPremium => 'Premium';

  @override
  String get navProfile => 'Profile';

  @override
  String get greetingMorning => 'Good morning';

  @override
  String get greetingAfternoon => 'Good afternoon';

  @override
  String get greetingEvening => 'Good evening';

  @override
  String get todayStepIntro => 'Here\'s one small step for today.';

  @override
  String get commonContinue => 'Continue';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonSave => 'Save';

  @override
  String get commonDone => 'Done';

  @override
  String get commonNotNow => 'Not now';

  @override
  String get profileTitle => 'Profile';

  @override
  String get language => 'Language';

  @override
  String get languageSystemDefault => 'System default';

  @override
  String get yourTone => 'Your tone';

  @override
  String get appearance => 'Appearance';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get onbSkip => 'Skip';

  @override
  String get onbWelcomeTitle =>
      'Face the moments you used to dread — one small step at a time.';

  @override
  String get onbWelcomeBody =>
      'Rung helps you build social confidence through gentle, private practice. Predict, do it, reflect — and watch your worst-case fears come apart in your own numbers.';

  @override
  String get onbGetStarted => 'Get started';

  @override
  String get onbSafetyTitle => 'Practice, not therapy.';

  @override
  String get onbUnderstand => 'I understand';

  @override
  String get onbSafetyBody1 =>
      'Rung is a confidence and practice tool — not therapy, not medical treatment, and not a diagnosis.';

  @override
  String get onbSafetyBody2 =>
      'The goal is to feel more comfortable in moments you used to dread — not to become someone you\'re not. Skipping is always okay.';

  @override
  String get onbSafetyCrisis =>
      'If anxiety is severely affecting your life, or you ever have thoughts of harming yourself, please reach out to a professional or a local crisis line.';

  @override
  String get onbFearTitle => 'Where would you like to start?';

  @override
  String get onbFearBody =>
      'Just to suggest a first step — you can climb any of these any time. Nothing here locks you in.';

  @override
  String get onbExploreOwn => 'I\'ll explore on my own';

  @override
  String get onbToneTitle => 'Which sounds more like you?';

  @override
  String get onbToneIntrovertTitle => 'I\'m more of an introvert';

  @override
  String get onbToneIntrovertBody =>
      'I want to feel comfortable, not become a different person.';

  @override
  String get onbToneSituationalTitle => 'I get situationally anxious';

  @override
  String get onbToneSituationalBody =>
      'I\'m outgoing sometimes, but certain moments trip me up.';

  @override
  String get onbToneFootnote => 'You can change this any time in Profile.';

  @override
  String get onbHowTitle => 'Here\'s how it works.';

  @override
  String get onbStartClimbing => 'Start climbing';

  @override
  String get onbStep1 => 'Predict how bad it\'ll feel (0–10).';

  @override
  String get onbStep2 => 'Go do it in real life — the app can be closed.';

  @override
  String get onbStep3 => 'Come back and log how it actually went.';

  @override
  String get onbGentleFirstStep => 'A GENTLE FIRST STEP';

  @override
  String get onbGoodPlaceToStart => 'A GOOD PLACE TO START';

  @override
  String get onbAllAreas =>
      'All six areas are on your home screen — start anywhere.';

  @override
  String get predictAppBar => 'Before you go';

  @override
  String get predictSaved =>
      'Saved. Go do it — then come back to log how it went.';

  @override
  String get predictQuestion => 'How bad do you think this\'ll be?';

  @override
  String get predictNoteLabel => 'What do you predict happens? (optional)';

  @override
  String get predictNoteHint => 'e.g. They\'ll think I\'m awkward';

  @override
  String get predictCompare =>
      'We\'ll compare this to how it actually goes. That gap is the whole point.';

  @override
  String get predictDoIt => 'I\'ll do it';

  @override
  String get reflectAppBar => 'How did it go?';

  @override
  String get reflectDidYouDoIt => 'Did you do it?';

  @override
  String get reflectHowAnxious => 'How anxious did the thought of it feel?';

  @override
  String get reflectHowBad => 'How bad was it, actually?';

  @override
  String get reflectNoteLabel => 'Anything you want to remember? (optional)';

  @override
  String get reflectOutcomeDone => 'Done';

  @override
  String get reflectOutcomePartial => 'Partial';

  @override
  String get reflectOutcomeNotToday => 'Not today';

  @override
  String get resultQuietDelight => 'Quiet delight in every step.';

  @override
  String get resultBackToLadder => 'Back to ladder';

  @override
  String resultGapHeadline(int predicted, int actual) {
    return 'You braced for $predicted. It came in at $actual.';
  }

  @override
  String resultGapSub(int predicted, int actual) {
    return 'Your heart prepared for a heavy $predicted, but the world met you with a gentler $actual. Worth remembering.';
  }

  @override
  String get resultRightHeadline => 'Right where you guessed.';

  @override
  String get resultRightSub =>
      'You called it — and you still showed up. That\'s the win.';

  @override
  String get resultTougherHeadline =>
      'Tougher than you guessed — and you did it.';

  @override
  String get resultTougherSub =>
      'Some moments ask more of us. Showing up anyway is the whole point.';

  @override
  String get resultPredicted => 'Predicted';

  @override
  String get resultActual => 'Actual';

  @override
  String resultLighter(int reduction) {
    return 'This moment was $reduction% lighter than you feared';
  }

  @override
  String get resultSkippedHeadline => 'Logged — no pressure.';

  @override
  String get resultSkippedSub =>
      'Not today is a perfectly good answer. This rung is still here whenever you\'re ready.';

  @override
  String get resultWinCopied => 'Win copied — paste it wherever you like.';

  @override
  String get resultCopyWin => 'Copy my win';

  @override
  String resultShareText(String rung) {
    return 'I just did something I used to avoid: $rung. One small rung climbed. 🪜 #Rung';
  }

  @override
  String get tracksTitle => 'Your tracks';

  @override
  String get tracksSubtitle => 'Small steps toward big confidence.';

  @override
  String get menuInsights => 'Insights';

  @override
  String get menuIsThisRight => 'Is this right for me?';

  @override
  String tracksRungsCount(int done, int total) {
    return '$done of $total rungs';
  }

  @override
  String tracksClimbedCount(int done, int total) {
    return '$done of $total climbed';
  }

  @override
  String get tracksContinueLabel => 'CONTINUE WHERE YOU LEFT OFF';

  @override
  String get tracksNextStepLabel => 'YOUR NEXT STEP';

  @override
  String get tracksLoadError => 'Could not load tracks.';

  @override
  String get todayResume => 'Pick up where you left off';

  @override
  String get todayNext => 'Your next step';

  @override
  String get todayVariety => 'Something a little different';

  @override
  String get todayFresh => 'Your starting point';

  @override
  String get todayResumeCta => 'Finish logging';

  @override
  String get todayStartCta => 'Start';

  @override
  String todayMinutes(int min) {
    return '~$min min';
  }

  @override
  String get dashShareTooltip => 'Share my progress';

  @override
  String get dashWeeklyGoal => 'Weekly goal';

  @override
  String dashStepsPerWeek(int count) {
    return '$count steps/week';
  }

  @override
  String dashGoalPerWeek(int count) {
    return '$count/week';
  }

  @override
  String dashWeeklyProgress(int done, int goal) {
    return '$done of $goal steps completed this week';
  }

  @override
  String get dashYourGrowth => 'Your growth';

  @override
  String get dashTodayError => 'Couldn\'t load today\'s step. Pull to retry.';

  @override
  String get dashTodayAllClear =>
      'You\'ve cleared everything available — add a custom rung or revisit one to keep the streak going.';

  @override
  String get dashTakeABreak => 'Take a break';

  @override
  String get dashTakeABreakSub =>
      'A few quiet games — vs the phone or a friend.';

  @override
  String get ladderTitleFallback => 'Ladder';

  @override
  String get ladderLoadError => 'Could not load ladder.';

  @override
  String get ladderAddOwn => 'Add your own rung';

  @override
  String ladderOfClimbed(int total) {
    return 'of $total climbed';
  }

  @override
  String get detailLoadError => 'Could not load.';

  @override
  String get detailNotExist => 'This rung no longer exists.';

  @override
  String get detailWhatToDo => 'What to do';

  @override
  String get detailWhyHelps => 'Why this helps';

  @override
  String get detailPastAttempts => 'Your past attempts';

  @override
  String get detailDoThis => 'I\'ll do this';

  @override
  String get detailReattempt =>
      'Re-attempting is encouraged — it builds your data.';

  @override
  String detailHistoryStat(int predicted, int actual) {
    return 'predicted $predicted · actual $actual';
  }

  @override
  String customLimitPremium(int cap) {
    return 'You\'ve reached this month\'s limit of $cap custom rungs — it resets next month.';
  }

  @override
  String get customLimitFree =>
      'Free plan includes 5 custom rungs — upgrade for more each month.';

  @override
  String get customDefaultWhat => 'A challenge you set for yourself.';

  @override
  String get customDefaultWhy => 'You named this one — that makes it count.';

  @override
  String get customSubtitle =>
      'Your situation is specific — this rung is just for you.';

  @override
  String get customWhatLabel => 'What will you do?';

  @override
  String get customWhatHint => 'e.g. Ask my manager for feedback';

  @override
  String get customNoteLabel => 'A note to yourself (optional)';

  @override
  String customDifficulty(int value) {
    return 'How hard does it feel? $value/10';
  }

  @override
  String get customAddToLadder => 'Add to ladder';

  @override
  String get paywallSwitchToFree => 'Switch to Free';

  @override
  String get paywallHeroTitle => 'You don\'t have to face it alone.';

  @override
  String get paywallHeroBody =>
      'The daily practice is always free. Premium adds a private coach in your corner — and a bigger community beside you — for when you\'re ready to go further.';

  @override
  String get paywallWhatsIncluded => 'What\'s included';

  @override
  String get paywallPlusHeader => 'Plus, every subscriber gets';

  @override
  String get paywallBenefitCoach =>
      'A private coach, any time — rehearse something coming up or talk through how it went';

  @override
  String get paywallBenefitPods =>
      'You\'re not doing this alone — join more support pods (3 on monthly, unlimited on yearly)';

  @override
  String get paywallBenefitCustom =>
      'Build unlimited ladders of your own — no cap on custom steps';

  @override
  String get paywallBenefitDepth =>
      'Go deeper when you\'re ready — up to 40 steps a track (free is a full 10-step arc)';

  @override
  String get paywallPlusStreak =>
      'Streak protection — a missed day won\'t break your streak';

  @override
  String get paywallPlusInsights => 'Deeper insights — your month at a glance';

  @override
  String get paywallPlusShare => 'Personal share-card styles';

  @override
  String get paywallPlusPrivacy => 'Always private, always ad-free';

  @override
  String get paywallYearly => 'Yearly';

  @override
  String get paywallPerYear => 'per year · best value';

  @override
  String get paywallSave => 'Save 33%';

  @override
  String get paywallMonthly => 'Monthly';

  @override
  String get paywallPerMonth => 'per month';

  @override
  String get paywallSwitchYearly => 'Switch to yearly';

  @override
  String get paywallSwitchMonthly => 'Switch to monthly';

  @override
  String paywallStartYearly(String price) {
    return 'Start yearly — $price';
  }

  @override
  String paywallStartMonthly(String price) {
    return 'Start monthly — $price';
  }

  @override
  String get paywallRestore => 'Restore purchases';

  @override
  String paywallCurrentPlan(String plan) {
    return 'Current plan: $plan. Cancel anytime.';
  }

  @override
  String get paywallCancelAnytime =>
      'Cancel anytime. The core loop stays free forever.';

  @override
  String get paywallSimulated =>
      'Premium active (simulated — add RevenueCat keys for real purchases).';

  @override
  String get paywallPlanUnavailable =>
      'That plan isn\'t available right now. Try again shortly.';

  @override
  String get paywallThankYou => 'Premium active — thank you. 🌱';

  @override
  String get paywallPurchaseFailed =>
      'The purchase didn\'t complete. You haven\'t been charged.';

  @override
  String get paywallRestored => 'Purchases restored.';

  @override
  String get paywallNoRestore => 'No previous purchases found on this account.';

  @override
  String get paywallRestoreFailed =>
      'Couldn\'t restore right now. Try again shortly.';

  @override
  String get profileAddName => 'Add your name';

  @override
  String get profileLockTitle => 'Lock my profile';

  @override
  String get profileLockedSub =>
      'Hidden — pod members can\'t open your details.';

  @override
  String get profileUnlockedSub =>
      'Pod members can tap your avatar to see your details.';

  @override
  String get profilePlanTitle => 'Your plan';

  @override
  String get profilePremium => 'Premium';

  @override
  String get profileUpgrade => 'Upgrade';

  @override
  String get profileToneDesc =>
      'Rung speaks gently by default. If your anxiety is more situational, a slightly bolder tone may suit you better.';

  @override
  String get profileToneIntrovert => 'Introvert';

  @override
  String get profileToneSituational => 'Situational';

  @override
  String get profileSafetySub => 'How Rung fits — and when to seek more';

  @override
  String get profileBlockedTitle => 'Blocked members';

  @override
  String get profileBlockedSub => 'See and unblock people you\'ve blocked';

  @override
  String get profileRestoreTitle => 'Restore my progress';

  @override
  String get profileRestoreSub =>
      'Pull your streak & challenges from the cloud';

  @override
  String get profileRestoring => 'Restoring…';

  @override
  String get profileRestoreOk => 'Progress restored from the cloud.';

  @override
  String profileRestoreFail(String error) {
    return 'Restore failed: $error';
  }

  @override
  String get profileLogout => 'Log out';

  @override
  String get profileChangePwTitle => 'Change password';

  @override
  String get profileChangePwSub => 'Set a new password for your account';

  @override
  String get profileChangePwSaved => 'Password updated';

  @override
  String get profileSignedIn => 'Signed in';

  @override
  String get profileLogoutConfirmTitle => 'Log out?';

  @override
  String get profileLogoutConfirmBody =>
      'Your progress is saved to the cloud and comes back when you sign in again.';

  @override
  String get profileLoggingOut => 'Logging out…';

  @override
  String get profileRateTitle => 'Rate Rung';

  @override
  String get profileRateSub => 'Tell us how it\'s going — it really helps';

  @override
  String get profilePrivacyTitle => 'Privacy Policy';

  @override
  String get profilePrivacySub =>
      'What we store — and what stays on your device';

  @override
  String get profileTermsTitle => 'Terms of Service';

  @override
  String get profileTermsSub => 'The agreement for using Rung';

  @override
  String get profileDeleteTitle => 'Delete account';

  @override
  String get profileDeleteSub => 'Permanently erase your account and data';

  @override
  String get profileFooter =>
      'Rung · practice, not therapy. Your data is yours.';

  @override
  String get profileDeleteConfirmTitle => 'Delete account?';

  @override
  String get profileDeleteConfirmBody =>
      'This permanently deletes your account, your pod messages, and your saved progress. This cannot be undone.';

  @override
  String get profileDelete => 'Delete';

  @override
  String get profileDeleting => 'Deleting your account…';

  @override
  String get profileDeleteFail => 'Could not delete your account. Try again.';

  @override
  String get profileBioPlaceholder => 'A quiet climber.';

  @override
  String get profileHaptics => 'Haptics';

  @override
  String get profileHapticsSub => 'Gentle vibration on taps and wins';

  @override
  String get profileAnalytics => 'Share anonymous usage data';

  @override
  String get profileAnalyticsSub =>
      'Helps improve Rung. No personal data, ever.';

  @override
  String get profileNotifications => 'Notifications';

  @override
  String get profileNotificationsSub => 'Alerts from Rung on this device';

  @override
  String get profilePodAlerts => 'Pod message alerts';

  @override
  String get profilePodAlertsSub => 'Tell me when someone posts in my pods';

  @override
  String get profileEnableNotifs =>
      'Enable notifications in Settings to get reminders.';

  @override
  String get profileReminderHelp => 'When should we nudge you?';

  @override
  String get profileReminderTitle => 'Gentle daily reminder';

  @override
  String profileReminderOn(String time) {
    return 'Every day at $time · tap the switch to turn off';
  }

  @override
  String get profileReminderOff =>
      'A calm, no-guilt nudge to take one small step';

  @override
  String get profileAvatarTitle => 'Choose your avatar';

  @override
  String get profileAvatarSub =>
      'Only you can change it — pod-mates see it too.';

  @override
  String get commonClose => 'Close';

  @override
  String get checkInMoodCalm => 'Calm';

  @override
  String get checkInMoodOkay => 'Okay';

  @override
  String get checkInMoodAnxious => 'Anxious';

  @override
  String get checkInMoodLow => 'Low';

  @override
  String get checkInMoodTense => 'Tense';

  @override
  String get checkInTitle => 'How are you arriving today?';

  @override
  String get checkInDismiss => 'Dismiss';

  @override
  String get checkInCalmCta => 'Try a calm moment';

  @override
  String get checkInStepCta => 'See today\'s step';

  @override
  String get supportTitle => 'This sounds like a lot to carry.';

  @override
  String get supportBody =>
      'Rung is a practice tool, not a crisis service. If you\'re going through something heavy, please reach out to someone who can help right now — a trusted person, or a local crisis line. You deserve real support.';

  @override
  String get supportResources => 'See support resources';

  @override
  String get progressChallenges => 'Challenges';

  @override
  String get progressCurrentStreak => 'Current Streak';

  @override
  String get progressBestStreak => 'Best Streak';

  @override
  String get progressThisWeek => 'This Week';

  @override
  String get progressCategoryBreakdown => 'Category Breakdown';

  @override
  String get insightsHistory => 'History';

  @override
  String checkInAckTitle(String mood) {
    return 'Checked in — feeling $mood';
  }

  @override
  String get checkInAckGentle =>
      'Thanks for being honest. Let\'s keep today gentle — one small, kind thing is enough.';

  @override
  String get checkInAckStep =>
      'Love that. When you\'re ready, one small step keeps the momentum going.';

  @override
  String get sharePremiumPerk => '✨ More card styles are a Premium perk.';

  @override
  String get shareSeePremium => 'See Premium';

  @override
  String get shareText => 'Small brave steps, one rung at a time. 🌱 #Rung';

  @override
  String get shareError => 'Could not open share. Try again.';

  @override
  String get shareTitle => 'Share your progress';

  @override
  String get shareSubtitle => 'Just your numbers — nothing private.';

  @override
  String get shareCta => 'Share';

  @override
  String get shareCardHeadline => 'My brave steps';

  @override
  String get shareCardFearsFaced => 'fears faced';

  @override
  String get shareCardCurrentStreak => 'Current streak';

  @override
  String get shareCardBestStreak => 'Best streak';

  @override
  String get shareCardTagline =>
      'Facing social fears, one small rung at a time.';

  @override
  String get helpNow => 'Help now';

  @override
  String get helpCalmMoment => 'A calm moment';

  @override
  String get helpTabBreathe => 'Breathe';

  @override
  String get helpTabGround => 'Ground';

  @override
  String get helpTabSay => 'Say this';

  @override
  String get helpBreatheIn => 'Breathe in…';

  @override
  String get helpBreatheOut => 'Breathe out…';

  @override
  String get helpBreatheHint => 'Follow the circle. There is no rush.';

  @override
  String get helpGround5 => 'things you can see';

  @override
  String get helpGround4 => 'things you can touch';

  @override
  String get helpGround3 => 'things you can hear';

  @override
  String get helpGround2 => 'things you can smell';

  @override
  String get helpGround1 => 'thing you can taste';

  @override
  String get helpGroundTitle => 'Name, quietly to yourself…';

  @override
  String get helpGroundHint =>
      'This brings you back to right now — where you are safe.';

  @override
  String get helpOpener1 => 'How do you know the people here?';

  @override
  String get helpOpener2 => 'I love this spot — have you been before?';

  @override
  String get helpOpener3 => 'I\'m hopeless with names — could you remind me?';

  @override
  String get helpOpener4 => 'What have you been up to this week?';

  @override
  String get helpExit1 =>
      'I\'m going to grab a drink — it was good talking to you.';

  @override
  String get helpExit2 =>
      'I need to say a quick hello to someone, excuse me a sec.';

  @override
  String get helpExit3 => 'I\'ll let you mingle — catch you later.';

  @override
  String get helpOpenersTitle => 'Easy openers';

  @override
  String get helpExitsTitle => 'Graceful exits';

  @override
  String get authEnterEmail => 'Enter your email';

  @override
  String get authBadEmail => 'That email doesn\'t look right';

  @override
  String get authEnterPassword => 'Enter a password';

  @override
  String get authMin6 => 'At least 6 characters';

  @override
  String get authPwMismatch => 'Passwords don\'t match';

  @override
  String get authConfirmEmail =>
      'Check your email to confirm, then sign in. (Or disable email confirmation in Supabase Auth settings for quick testing.)';

  @override
  String get authGenericError => 'Something went wrong. Try again.';

  @override
  String get authCreateTitle => 'Create your account';

  @override
  String get authWelcomeBack => 'Welcome back';

  @override
  String get authSignUpSub =>
      'Join the pods and keep your progress safe across devices.';

  @override
  String get authSignInSub => 'Sign in to your pods and synced progress.';

  @override
  String get authDisplayName => 'Display name (optional)';

  @override
  String get authEmail => 'Email';

  @override
  String get authPassword => 'Password';

  @override
  String get authShowPassword => 'Show password';

  @override
  String get authHidePassword => 'Hide password';

  @override
  String get authConfirmPassword => 'Confirm password';

  @override
  String get authForgotPassword => 'Forgot password?';

  @override
  String get authResetTitle => 'Reset password';

  @override
  String get authResetBody =>
      'Enter your account email and we\'ll send you a link to set a new password.';

  @override
  String get authResetSend => 'Send reset link';

  @override
  String get authResetSent =>
      'If that email has an account, a reset link is on its way.';

  @override
  String get authNewPassword => 'New password';

  @override
  String get authConfirmNewPassword => 'Confirm new password';

  @override
  String get authUpdatePasswordCta => 'Update password';

  @override
  String get authCreateCta => 'Create account';

  @override
  String get authSignInCta => 'Sign in';

  @override
  String get authHaveAccount => 'I already have an account';

  @override
  String get authNewAccount => 'I\'m new — create an account';

  @override
  String get authLegalPrefixSignUp =>
      'By creating an account you agree to our ';

  @override
  String get authLegalPrefixSignIn => 'By continuing you agree to our ';

  @override
  String get authTerms => 'Terms';

  @override
  String get authAnd => ' and ';

  @override
  String get gamesIntro =>
      'Quiet games for focus and a calm mind — the kind of brain-training people find grounding. Play the phone, or pass it to a friend.';

  @override
  String gamesBestMs(int ms) {
    return 'Best $ms ms';
  }

  @override
  String gamesBestLevel(int level) {
    return 'Best level $level';
  }

  @override
  String gamesBest(String score) {
    return 'Best $score';
  }

  @override
  String gamesBestMoves(int moves) {
    return 'Best $moves moves';
  }

  @override
  String gamesWinsVsPhone(int count) {
    return '$count wins vs phone';
  }

  @override
  String get gameTitleReaction => 'Reaction speed';

  @override
  String get gameTitleSequence => 'Sequence memory';

  @override
  String get gameTitleQuickMath => 'Quick Math';

  @override
  String get gameTitleMemory => 'Memory match';

  @override
  String get gameSubReaction => 'focus · tap when it turns green';

  @override
  String get gameSubSequence => 'memory · watch and repeat';

  @override
  String get gameSub2048 => 'strategy · swipe to merge';

  @override
  String get gameSubQuickMath => 'mental speed · 30-second sprint';

  @override
  String get gameSubTicTacToe => 'vs the phone · or 2 players';

  @override
  String get gameSubConnect4 => 'vs the phone · or 2 players';

  @override
  String get gameSubMemory => 'solo · find the pairs';

  @override
  String get gameHelpTooltip => 'How to play';

  @override
  String gameHelpTitle(String game) {
    return 'How to play · $game';
  }

  @override
  String get gameGotIt => 'Got it';

  @override
  String get tierFree => 'Free';

  @override
  String get tierMonthly => 'Premium · Monthly';

  @override
  String get tierYearly => 'Premium · Yearly';

  @override
  String get podsUnlimited => 'unlimited pods';

  @override
  String podsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pods',
      one: '1 pod',
    );
    return '$_temp0';
  }

  @override
  String get groupsSignedOutTitle => 'Join a small, kind pod';

  @override
  String get groupsSignedOutBody =>
      'Groups need a quick account so pods are safe and yours. Your practice stays private and account-free.';

  @override
  String get groupsSignInCta => 'Sign in to continue';

  @override
  String get groupsLoadError => 'Could not load pods. Pull to retry.';

  @override
  String groupsJoined(String pod) {
    return 'Joined $pod. Say hi when you\'re ready.';
  }

  @override
  String get groupsJoinedNew => 'Joined a new pod. Say hi when you\'re ready.';

  @override
  String get groupsNoPodFound => 'Could not find a pod right now. Try again.';

  @override
  String groupsLeaveTitle(String pod) {
    return 'Leave $pod?';
  }

  @override
  String get groupsLeave => 'Leave';

  @override
  String groupsLeft(String pod) {
    return 'You left $pod.';
  }

  @override
  String get groupsLeaveError => 'Could not leave the pod. Try again.';

  @override
  String get groupsHeader => 'Small pods, kind people';

  @override
  String get groupsYourPods => 'YOUR PODS';

  @override
  String get groupsDiscoverPods => 'DISCOVER PODS';

  @override
  String get groupsJoinAnother => 'Join another pod';

  @override
  String get groupsNoOthers => 'No other pods to join right now.';

  @override
  String groupsJoinedShort(String pod) {
    return 'Joined $pod.';
  }

  @override
  String get groupsJoin => 'Join';

  @override
  String get groupsPodOptions => 'Pod options';

  @override
  String get groupsLeavePod => 'Leave pod';

  @override
  String groupsMembers(int count, int capacity) {
    return '$count/$capacity members';
  }

  @override
  String groupsTierPods(String tier, String pods) {
    return 'On $tier you can be in $pods.';
  }

  @override
  String groupsCapacityTierPods(int capacity, String tier, String pods) {
    return 'Up to $capacity per pod. On $tier you can be in $pods.';
  }

  @override
  String groupsInYourPods(String pods) {
    return 'You\'re in your $pods';
  }

  @override
  String get groupsUpgradeBody =>
      'Go Premium to join more — monthly unlocks 3 pods, yearly unlocks as many as you like.';

  @override
  String get groupsSafetyLive =>
      'Be kind. You can report or block anyone from their profile. Locked profiles stay private.';

  @override
  String get groupsSafetyPreview =>
      'Preview. Pods become live, moderated chats once sign-in is configured.';

  @override
  String get groupsLeaveBody =>
      'You\'ll stop seeing this pod\'s messages. You can join again later.';

  @override
  String get podRulesTitle => 'Pod rules';

  @override
  String get podRulesIntro =>
      'Pods only work if everyone feels safe. By joining you agree:';

  @override
  String get podRule1 => 'Be kind. Everyone here is practicing something hard.';

  @override
  String get podRule2 => 'No harassment, hate, or harmful content. Ever.';

  @override
  String get podRule3 => 'Report or block anyone who makes you uncomfortable.';

  @override
  String get podRule4 => 'Respect privacy — what\'s shared here stays here.';

  @override
  String get podRule5 =>
      'Pods are peer support, not a crisis service. In an emergency, contact a professional or local crisis line.';

  @override
  String get podRulesAgree => 'I agree — take me in';

  @override
  String chatIntrosBeKind(int count, int capacity) {
    return '$count/$capacity introverts · be kind';
  }

  @override
  String get chatHint => 'Say something kind…';

  @override
  String get chatPreviewBanner =>
      'Preview · messages stay on your device for now. Real, moderated pods arrive with accounts.';

  @override
  String get chatYou => 'You';

  @override
  String get reportHarassment => 'Harassment or bullying';

  @override
  String get reportHate => 'Hate or harmful language';

  @override
  String get reportSpam => 'Spam or scam';

  @override
  String get reportUnsafe => 'Makes me feel unsafe';

  @override
  String get reportOther => 'Something else';

  @override
  String get memberPrivateTitle => 'Private profile';

  @override
  String get memberPrivateBody =>
      'This member keeps their profile private. You can still chat with them — and report or block if needed.';

  @override
  String memberStreak(int days) {
    return '$days-day streak';
  }

  @override
  String memberChallenges(int count) {
    return '$count challenges';
  }

  @override
  String memberClimbing(String track) {
    return 'Climbing: $track';
  }

  @override
  String get memberReport => 'Report';

  @override
  String get memberBlock => 'Block';

  @override
  String get memberReportThanks => 'Thanks — we\'ll review this.';

  @override
  String get memberBlockToo => 'Block too';

  @override
  String get memberBlocked => 'Blocked. You won\'t see their messages.';

  @override
  String get memberBlockError => 'Could not block. Try again.';

  @override
  String get memberReportError => 'Could not send report. Try again.';

  @override
  String get memberBlockConfirmTitle => 'Block this member?';

  @override
  String get memberBlockConfirmBody =>
      'You won\'t see each other\'s messages. You can undo this later.';

  @override
  String get memberSoonReporting =>
      'Reporting goes live in moderated pods (sign in to use it).';

  @override
  String get memberSoonBlocking =>
      'Blocking goes live in moderated pods (sign in to use it).';

  @override
  String get memberWhatsWrong => 'What\'s wrong?';

  @override
  String get memberFallback => 'Member';

  @override
  String get blockedUnblockError => 'Could not unblock. Try again.';

  @override
  String blockedUnblocked(String name) {
    return 'Unblocked $name. You\'ll see their messages again.';
  }

  @override
  String get blockedIntro =>
      'Blocking hides a member\'s messages from you — and yours from them, both ways. Unblock anyone below to undo it.';

  @override
  String get blockedLabel => 'Blocked';

  @override
  String get blockedUnblock => 'Unblock';

  @override
  String get blockedEmptyTitle => 'No one blocked';

  @override
  String get blockedEmptyBody =>
      'You haven\'t blocked anyone. Blocking hides a member\'s messages from you, both ways — and you can always undo it here.';

  @override
  String get chatCheckInPosted => 'Nice work. Pod check-in posted.';

  @override
  String get chatCheckInError => 'Could not check in right now. Try again.';

  @override
  String get chatDeleteMsgTitle => 'Delete message?';

  @override
  String get chatDeleteMsgBody => 'This removes it for everyone in the pod.';

  @override
  String get chatReply => 'Reply';

  @override
  String get chatEdit => 'Edit';

  @override
  String get chatDailyPrompt => 'Daily pod prompt';

  @override
  String get chatCheckedInToday => 'Checked in today';

  @override
  String get chatDidMyStep => 'I did my step';

  @override
  String chatCheckedInCount(int count) {
    return '$count checked in';
  }

  @override
  String get chatNoMessages =>
      'No messages yet. A simple \"hi\" is a brave first rung.';

  @override
  String get chatEditingMessage => 'Editing your message';

  @override
  String chatReplyingTo(String name) {
    return 'Replying to $name';
  }

  @override
  String get chatYourself => 'yourself';

  @override
  String get chatMsgDeleted => 'This message was deleted';

  @override
  String get chatPrivateMember => 'Private member';

  @override
  String chatBeKind(int count, int capacity) {
    return '$count/$capacity · be kind';
  }

  @override
  String get chatDeletedMessageShort => 'deleted message';

  @override
  String get gameYouWin => 'You win! 🎉';

  @override
  String get gamePhoneWins => 'The phone wins';

  @override
  String get gamePhoneThinking => 'The phone is thinking…';

  @override
  String get gamePlayPhone => 'Play the phone';

  @override
  String get game2Players => '2 players';

  @override
  String get gameNewGame => 'New game';

  @override
  String get gameYou => 'You';

  @override
  String get gamePhone => 'Phone';

  @override
  String get gameDraws => 'Draws';

  @override
  String get tttP1Wins => 'Player 1 (X) wins! 🎉';

  @override
  String get tttP2Wins => 'Player 2 (O) wins! 🎉';

  @override
  String get tttYourTurn => 'Your turn';

  @override
  String get tttP1Turn => 'Player 1 · X';

  @override
  String get tttP2Turn => 'Player 2 · O';

  @override
  String get tttP1Label => 'P1 (X)';

  @override
  String get tttP2Label => 'P2 (O)';

  @override
  String get tttRule1 => 'Take turns placing your mark on the 3×3 grid.';

  @override
  String get tttRule2 =>
      'Get three of your marks in a row — across, down, or diagonally — to win.';

  @override
  String get tttRule3 =>
      '\"Play the phone\" is you vs a simple AI. \"2 players\" passes the phone each turn.';

  @override
  String get c4P1Wins => 'Player 1 wins! 🎉';

  @override
  String get c4P2Wins => 'Player 2 wins! 🎉';

  @override
  String get c4Turn => 'Your turn — tap a column';

  @override
  String get c4P1Turn => 'Player 1 · red';

  @override
  String get c4P2Turn => 'Player 2 · yellow';

  @override
  String get c4P1Label => 'P1';

  @override
  String get c4P2Label => 'P2';

  @override
  String get c4Rule1 =>
      'Tap a column to drop your token — it falls to the lowest free slot.';

  @override
  String get c4Rule2 =>
      'Line up four of your colour — across, down, or diagonally — to win.';

  @override
  String get c4Rule3 =>
      '\"Play the phone\" is you vs a simple AI. \"2 players\" passes the phone.';

  @override
  String get gameDraw => 'It\'s a draw 🤝';

  @override
  String get gamePlayAgain => 'Play again';

  @override
  String get gameStart => 'Start';

  @override
  String get g2048Rule1 => 'Swipe up, down, left or right to slide all tiles.';

  @override
  String get g2048Rule2 =>
      'Two tiles with the same number merge into one that doubles.';

  @override
  String get g2048Rule3 =>
      'Keep merging to build a 2048 tile. The board fills — plan ahead!';

  @override
  String get g2048Score => 'Score';

  @override
  String get g2048Best => 'Best';

  @override
  String get g2048GameOver => 'Game over';

  @override
  String get g2048Won => 'You made 2048! 🎉';

  @override
  String get g2048SwipeToMerge => 'Swipe to merge';

  @override
  String get qmRule1 => 'You have 30 seconds — solve as many as you can.';

  @override
  String get qmRule2 => 'Tap the correct answer from the four choices.';

  @override
  String get qmRule3 => 'A wrong tap costs 2 seconds, so read carefully.';

  @override
  String qmTimeScored(Object score) {
    return 'Time! You scored $score';
  }

  @override
  String qmBestSub(Object best) {
    return 'Best $best · 30 seconds, answer as many as you can.';
  }

  @override
  String get qmStartSub => '30 seconds. A wrong tap costs 2 seconds.';

  @override
  String get qmCorrect => 'correct';

  @override
  String get mmRule1 => 'Tap a card to flip it, then flip a second one.';

  @override
  String get mmRule2 =>
      'If the two emojis match, they stay face-up; if not, they flip back.';

  @override
  String get mmRule3 => 'Find all the pairs — in as few moves as you can.';

  @override
  String mmAllMatched(Object moves) {
    return 'All matched in $moves moves! 🎉';
  }

  @override
  String mmFindPairs(Object moves) {
    return 'Find the pairs · $moves moves';
  }

  @override
  String mmBest(Object best) {
    return 'Best: $best moves';
  }

  @override
  String get mmShuffle => 'Shuffle';

  @override
  String get rxTapStart => 'Tap to start';

  @override
  String get rxWaitGreen => 'Wait for green, then tap fast';

  @override
  String get rxWait => 'Wait…';

  @override
  String get rxTapMoment => 'Tap the moment it turns green';

  @override
  String rxBestRetry(Object ms) {
    return 'Best $ms ms · tap to retry';
  }

  @override
  String get rxTapRetry => 'Tap to retry';

  @override
  String get rxTooSoon => 'Too soon!';

  @override
  String get rxWaitRetry => 'Wait for green · tap to retry';

  @override
  String get rxTap => 'TAP!';

  @override
  String get rxRule1 =>
      'Tap the screen to start, then wait — it will turn amber.';

  @override
  String get rxRule2 => 'The instant it turns green, tap as fast as you can.';

  @override
  String get rxRule3 =>
      'Tapping too early resets it. A lower time (ms) is better.';

  @override
  String get smWatchRepeat => 'Watch the pattern, then repeat it.';

  @override
  String get smWatch => 'Watch…';

  @override
  String smYourTurn(Object current, Object total) {
    return 'Your turn · $current of $total';
  }

  @override
  String smReachedBest(Object best, Object reached) {
    return 'You reached $reached · best $best';
  }

  @override
  String smReached(Object reached) {
    return 'You reached $reached';
  }

  @override
  String get smRule1 => 'Watch the tiles light up one by one.';

  @override
  String get smRule2 => 'Repeat the exact same order by tapping the tiles.';

  @override
  String get smRule3 =>
      'Each round adds one more step — see how far you can go.';

  @override
  String smRound(Object round) {
    return 'Round $round';
  }

  @override
  String get safetyScreenTitle => 'Is this right for me?';

  @override
  String get safetyPracticeTitle => 'Rung is practice, not therapy.';

  @override
  String get safetyIntro =>
      'Rung is a confidence and practice tool. It helps you face everyday social situations gradually, at your own pace. It is not therapy, not a medical treatment, and not a diagnosis.';

  @override
  String get safetyPoint1 =>
      'The goal is manageable dread — feeling more comfortable in the moments you used to avoid. Not becoming a different person.';

  @override
  String get safetyPoint2 =>
      'Skipping is always okay and never counts against you. There are no shame mechanics here.';

  @override
  String get safetyPoint3 =>
      'Your data is yours. Everything works offline, with no account required.';

  @override
  String get safetyMoreTitle => 'If this is more than nerves';

  @override
  String get safetyMoreBody =>
      'If anxiety is severely affecting your daily life, or you ever have thoughts of harming yourself, please reach out to a qualified professional or a local crisis line. That is a strong, healthy step — and Rung is not a substitute for it.';

  @override
  String get legalLastUpdated => 'Last updated: June 2026';

  @override
  String legalQuestions(String email) {
    return 'Questions? Contact us at $email.';
  }

  @override
  String get privacyTitle => 'Privacy Policy';

  @override
  String get privacyIntro =>
      'Rung is a private practice tool for building social confidence. We collect as little as possible, and the most personal things you write never leave your phone. This policy explains what we store and why.';

  @override
  String get ppWhatStaysHead => 'What stays only on your device';

  @override
  String get ppWhatStaysBody =>
      'Your reflection notes and prediction notes — the private things you write about how a moment felt — are stored only in the app on your device. They are never uploaded to our servers.';

  @override
  String get ppCloudHead => 'What we store in the cloud';

  @override
  String get ppCloudBody =>
      'When you create an account we store: your email address (for sign-in; your password is encrypted and we never see it), an optional display name and bio, and your privacy-lock setting. To run the community (“pods”) we store the messages you post and any blocks or reports you make. To keep your progress safe across devices we back up numbers only — your streak, challenges completed, and anxiety ratings (predicted vs actual) — plus any custom steps you create. Note text is never included.';

  @override
  String get ppAnalyticsHead => 'Analytics';

  @override
  String get ppAnalyticsBody =>
      'We use privacy-respecting product analytics (PostHog) to understand which features help — anonymous usage events like “opened a screen” or “completed a step”, never the content of your notes or messages. It is off by default and only runs if you turn it on in Settings; you can turn it off again at any time.';

  @override
  String get ppUseHead => 'How we use your information';

  @override
  String get ppUseBody =>
      'Only to provide the app: to sign you in, run the pods, restore your progress, and improve Rung using aggregate, anonymous trends. We do not sell your data or use it for advertising.';

  @override
  String get ppProcessHead => 'Who processes your data';

  @override
  String get ppProcessBody =>
      'We use Supabase (authentication, database, and hosting) and PostHog (analytics) as data processors. They handle data on our behalf under their own security and privacy commitments.';

  @override
  String get ppRightsHead => 'Your rights & choices';

  @override
  String get ppRightsBody =>
      'You can edit your profile, lock it so other members can’t see it, and permanently delete your account and all associated cloud data at any time from Profile → Delete account. You can also email us to request access to or deletion of your data.';

  @override
  String get ppSecurityHead => 'Security & retention';

  @override
  String get ppSecurityBody =>
      'Data is encrypted in transit, and every table is protected by row-level security so you can only ever access your own data (and pod messages you’re a member of). We keep your data until you delete your account or ask us to remove it.';

  @override
  String get ppChildrenHead => 'Children';

  @override
  String get ppChildrenBody =>
      'Rung is not intended for anyone under 16. If you believe a child has created an account, contact us and we will remove it.';

  @override
  String get ppMedicalHead => 'Not medical care';

  @override
  String get ppMedicalBody =>
      'Rung supports gradual practice but is not therapy, diagnosis, or medical advice. If you are in crisis, contact your local emergency services or a crisis line.';

  @override
  String get ppChangesHead => 'Changes';

  @override
  String get ppChangesBody =>
      'If we update this policy we’ll change the date above and, for material changes, let you know in the app.';

  @override
  String get termsTitle => 'Terms of Service';

  @override
  String get termsIntro =>
      'These terms are the agreement between you and Rung when you use the app. By creating an account or using Rung, you agree to them.';

  @override
  String get tosMedicalHead => 'Not a medical service';

  @override
  String get tosMedicalBody =>
      'Rung is a self-help practice tool, not therapy or medical care, and does not replace professional help. It cannot guarantee any particular outcome. If you are in crisis or may harm yourself or others, contact your local emergency services immediately.';

  @override
  String get tosEligibilityHead => 'Eligibility';

  @override
  String get tosEligibilityBody =>
      'You must be at least 16 years old to use Rung and have the right to agree to these terms.';

  @override
  String get tosAccountHead => 'Your account';

  @override
  String get tosAccountBody =>
      'Keep your login details safe — you’re responsible for activity on your account. Tell us promptly if you suspect unauthorised use.';

  @override
  String get tosCommunityHead => 'Community rules (pods)';

  @override
  String get tosCommunityBody =>
      'Pods are for kindness and support. You agree not to harass, threaten, demean, spam, or post hateful or illegal content, and not to share other people’s private information. We may remove content or suspend accounts that break these rules. You can block and report other members at any time.';

  @override
  String get tosContentHead => 'Content you post';

  @override
  String get tosContentBody =>
      'You keep ownership of what you write. By posting in a pod you grant us permission to store and show it to the members of that pod so the community works. Don’t post anything you don’t have the right to share.';

  @override
  String get tosSubsHead => 'Subscriptions';

  @override
  String get tosSubsBody =>
      'Some features and extra practice content are available with a paid subscription. When billing is live, purchases and renewals are handled by the app store, and you can manage or cancel through your app-store account. Prices and inclusions may change with notice.';

  @override
  String get tosDisclaimerHead => 'Disclaimers & liability';

  @override
  String get tosDisclaimerBody =>
      'Rung is provided “as is”, without warranties of any kind. To the fullest extent permitted by law, we are not liable for indirect or consequential losses arising from your use of the app.';

  @override
  String get tosEndingHead => 'Ending your use';

  @override
  String get tosEndingBody =>
      'You can delete your account at any time from Profile → Delete account. We may suspend or end access if these terms are seriously or repeatedly broken.';

  @override
  String get tosChangesHead => 'Changes';

  @override
  String get tosChangesBody =>
      'We may update these terms; we’ll update the date above and, for significant changes, notify you in the app. Continuing to use Rung means you accept the updated terms.';

  @override
  String get breatheCta => 'Feeling the dread? Breathe first';

  @override
  String get breatheIntro => 'Sixty seconds. Just follow the circle.';

  @override
  String get breatheIn => 'Breathe in';

  @override
  String get breatheHold => 'Hold';

  @override
  String get breatheOut => 'Breathe out';

  @override
  String get breatheSkip => 'Skip';

  @override
  String get breatheDoneTitle => 'That’s it.';

  @override
  String get breatheDoneSub =>
      'Feel a little steadier? Go do your rung whenever you’re ready.';

  @override
  String get breatheDoneBtn => 'Done';

  @override
  String get insightsDeeperTitle => 'Deeper insights';

  @override
  String get insightsLockedBody =>
      'See your month at a glance — how much your fear ran hotter than reality, and how often you over-predicted it. A Premium perk.';

  @override
  String get insightsUnlockCta => 'Unlock with Premium';

  @override
  String get insightsNoSteps =>
      'No steps logged yet this month. Face a couple and your summary appears here.';

  @override
  String get insightsFearsFacedMonth => 'fears faced this month';

  @override
  String insightsGapHotter(String points) {
    return 'Your fear ran $points points hotter than reality, on average.';
  }

  @override
  String get insightsGapTougher =>
      'Reality was a bit tougher than you predicted this month — that\'s brave data too.';

  @override
  String get insightsGapSpotOn =>
      'Your predictions were about spot-on this month.';

  @override
  String insightsOverPredicted(int rate) {
    return 'You over-predicted the fear $rate% of the time.';
  }

  @override
  String get insightsTrendSame => 'Same as last month';

  @override
  String insightsTrendMore(int count) {
    return '$count more than last month';
  }

  @override
  String insightsTrendFewer(int count) {
    return '$count fewer than last month';
  }

  @override
  String get rateTitle => 'Enjoying Rung?';

  @override
  String get ratePromptNone => 'How is Rung feeling for you?';

  @override
  String get ratePromptLow =>
      'We\'re sorry it\'s not landing. What\'s missing?';

  @override
  String get ratePromptMid => 'Thanks — what would make it a 5?';

  @override
  String get ratePromptHigh => 'That means a lot. What do you love?';

  @override
  String get rateHintLove => 'Anything you love? (optional)';

  @override
  String get rateHintMore => 'Tell us more (optional)';

  @override
  String get rateSend => 'Send';

  @override
  String get rateThanksHigh => 'Thank you — it truly helps. 🌱';

  @override
  String get rateThanksLow =>
      'Thank you for the honesty — we\'ll use it to improve.';

  @override
  String get editProfileTitle => 'Edit profile';

  @override
  String get editDisplayName => 'Display name';

  @override
  String get editDisplayNameHint => 'What should pods call you?';

  @override
  String get editBio => 'Short bio (optional)';

  @override
  String get editBioHint =>
      'A line about you — kept private if you lock your profile.';

  @override
  String get errorOffline =>
      'You\'re offline. Connect to the internet and try again.';

  @override
  String get errorGeneric => 'Something went wrong. Please try again.';

  @override
  String get errorSaveFailed =>
      'Couldn\'t save — your device may be low on storage. Free up space and try again.';
}
