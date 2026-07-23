import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_da.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_ms.dart';
import 'app_localizations_nb.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_sv.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('da'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('ms'),
    Locale('nb'),
    Locale('nl'),
    Locale('pl'),
    Locale('pt'),
    Locale('pt', 'PT'),
    Locale('sv'),
  ];

  /// Bottom nav tab: dashboard/home
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navGroups.
  ///
  /// In en, this message translates to:
  /// **'Groups'**
  String get navGroups;

  /// No description provided for @navPremium.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get navPremium;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @greetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get greetingMorning;

  /// No description provided for @greetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get greetingEvening;

  /// No description provided for @todayStepIntro.
  ///
  /// In en, this message translates to:
  /// **'Here\'s one small step for today.'**
  String get todayStepIntro;

  /// No description provided for @commonContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get commonContinue;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get commonDone;

  /// No description provided for @commonNotNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get commonNotNow;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageSystemDefault.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get languageSystemDefault;

  /// No description provided for @yourTone.
  ///
  /// In en, this message translates to:
  /// **'Your tone'**
  String get yourTone;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @onbSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onbSkip;

  /// No description provided for @onbWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Face the moments you used to dread — one small step at a time.'**
  String get onbWelcomeTitle;

  /// No description provided for @onbWelcomeBody.
  ///
  /// In en, this message translates to:
  /// **'Rung helps you build social confidence through gentle, private practice. Predict, do it, reflect — and watch your worst-case fears come apart in your own numbers.'**
  String get onbWelcomeBody;

  /// No description provided for @onbGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get onbGetStarted;

  /// No description provided for @onbSafetyTitle.
  ///
  /// In en, this message translates to:
  /// **'Practice, not therapy.'**
  String get onbSafetyTitle;

  /// No description provided for @onbUnderstand.
  ///
  /// In en, this message translates to:
  /// **'I understand'**
  String get onbUnderstand;

  /// No description provided for @onbSafetyBody1.
  ///
  /// In en, this message translates to:
  /// **'Rung is a confidence and practice tool — not therapy, not medical treatment, and not a diagnosis.'**
  String get onbSafetyBody1;

  /// No description provided for @onbSafetyBody2.
  ///
  /// In en, this message translates to:
  /// **'The goal is to feel more comfortable in moments you used to dread — not to become someone you\'re not. Skipping is always okay.'**
  String get onbSafetyBody2;

  /// No description provided for @onbSafetyCrisis.
  ///
  /// In en, this message translates to:
  /// **'If anxiety is severely affecting your life, or you ever have thoughts of harming yourself, please reach out to a professional or a local crisis line.'**
  String get onbSafetyCrisis;

  /// No description provided for @onbFearTitle.
  ///
  /// In en, this message translates to:
  /// **'Where would you like to start?'**
  String get onbFearTitle;

  /// No description provided for @onbFearBody.
  ///
  /// In en, this message translates to:
  /// **'Just to suggest a first step — you can climb any of these any time. Nothing here locks you in.'**
  String get onbFearBody;

  /// No description provided for @onbExploreOwn.
  ///
  /// In en, this message translates to:
  /// **'I\'ll explore on my own'**
  String get onbExploreOwn;

  /// No description provided for @onbToneTitle.
  ///
  /// In en, this message translates to:
  /// **'Which sounds more like you?'**
  String get onbToneTitle;

  /// No description provided for @onbToneIntrovertTitle.
  ///
  /// In en, this message translates to:
  /// **'I\'m more of an introvert'**
  String get onbToneIntrovertTitle;

  /// No description provided for @onbToneIntrovertBody.
  ///
  /// In en, this message translates to:
  /// **'I want to feel comfortable, not become a different person.'**
  String get onbToneIntrovertBody;

  /// No description provided for @onbToneSituationalTitle.
  ///
  /// In en, this message translates to:
  /// **'I get situationally anxious'**
  String get onbToneSituationalTitle;

  /// No description provided for @onbToneSituationalBody.
  ///
  /// In en, this message translates to:
  /// **'I\'m outgoing sometimes, but certain moments trip me up.'**
  String get onbToneSituationalBody;

  /// No description provided for @onbToneFootnote.
  ///
  /// In en, this message translates to:
  /// **'You can change this any time in Profile.'**
  String get onbToneFootnote;

  /// No description provided for @onbHowTitle.
  ///
  /// In en, this message translates to:
  /// **'Here\'s how it works.'**
  String get onbHowTitle;

  /// No description provided for @onbStartClimbing.
  ///
  /// In en, this message translates to:
  /// **'Start climbing'**
  String get onbStartClimbing;

  /// No description provided for @onbStep1.
  ///
  /// In en, this message translates to:
  /// **'Predict how bad it\'ll feel (0–10).'**
  String get onbStep1;

  /// No description provided for @onbStep2.
  ///
  /// In en, this message translates to:
  /// **'Go do it in real life — the app can be closed.'**
  String get onbStep2;

  /// No description provided for @onbStep3.
  ///
  /// In en, this message translates to:
  /// **'Come back and log how it actually went.'**
  String get onbStep3;

  /// No description provided for @onbGentleFirstStep.
  ///
  /// In en, this message translates to:
  /// **'A GENTLE FIRST STEP'**
  String get onbGentleFirstStep;

  /// No description provided for @onbGoodPlaceToStart.
  ///
  /// In en, this message translates to:
  /// **'A GOOD PLACE TO START'**
  String get onbGoodPlaceToStart;

  /// No description provided for @onbAllAreas.
  ///
  /// In en, this message translates to:
  /// **'All six areas are on your home screen — start anywhere.'**
  String get onbAllAreas;

  /// No description provided for @predictAppBar.
  ///
  /// In en, this message translates to:
  /// **'Before you go'**
  String get predictAppBar;

  /// No description provided for @predictSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved. Go do it — then come back to log how it went.'**
  String get predictSaved;

  /// No description provided for @predictQuestion.
  ///
  /// In en, this message translates to:
  /// **'How bad do you think this\'ll be?'**
  String get predictQuestion;

  /// No description provided for @predictNoteLabel.
  ///
  /// In en, this message translates to:
  /// **'What do you predict happens? (optional)'**
  String get predictNoteLabel;

  /// No description provided for @predictNoteHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. They\'ll think I\'m awkward'**
  String get predictNoteHint;

  /// No description provided for @predictCompare.
  ///
  /// In en, this message translates to:
  /// **'We\'ll compare this to how it actually goes. That gap is the whole point.'**
  String get predictCompare;

  /// No description provided for @predictDoIt.
  ///
  /// In en, this message translates to:
  /// **'I\'ll do it'**
  String get predictDoIt;

  /// No description provided for @reflectAppBar.
  ///
  /// In en, this message translates to:
  /// **'How did it go?'**
  String get reflectAppBar;

  /// No description provided for @reflectDidYouDoIt.
  ///
  /// In en, this message translates to:
  /// **'Did you do it?'**
  String get reflectDidYouDoIt;

  /// No description provided for @reflectHowAnxious.
  ///
  /// In en, this message translates to:
  /// **'How anxious did the thought of it feel?'**
  String get reflectHowAnxious;

  /// No description provided for @reflectHowBad.
  ///
  /// In en, this message translates to:
  /// **'How bad was it, actually?'**
  String get reflectHowBad;

  /// No description provided for @reflectNoteLabel.
  ///
  /// In en, this message translates to:
  /// **'Anything you want to remember? (optional)'**
  String get reflectNoteLabel;

  /// No description provided for @reflectOutcomeDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get reflectOutcomeDone;

  /// No description provided for @reflectOutcomePartial.
  ///
  /// In en, this message translates to:
  /// **'Partial'**
  String get reflectOutcomePartial;

  /// No description provided for @reflectOutcomeNotToday.
  ///
  /// In en, this message translates to:
  /// **'Not today'**
  String get reflectOutcomeNotToday;

  /// No description provided for @resultQuietDelight.
  ///
  /// In en, this message translates to:
  /// **'Quiet delight in every step.'**
  String get resultQuietDelight;

  /// No description provided for @resultBackToLadder.
  ///
  /// In en, this message translates to:
  /// **'Back to ladder'**
  String get resultBackToLadder;

  /// No description provided for @resultGapHeadline.
  ///
  /// In en, this message translates to:
  /// **'You braced for {predicted}. It came in at {actual}.'**
  String resultGapHeadline(int predicted, int actual);

  /// No description provided for @resultGapSub.
  ///
  /// In en, this message translates to:
  /// **'Your heart prepared for a heavy {predicted}, but the world met you with a gentler {actual}. Worth remembering.'**
  String resultGapSub(int predicted, int actual);

  /// No description provided for @resultRightHeadline.
  ///
  /// In en, this message translates to:
  /// **'Right where you guessed.'**
  String get resultRightHeadline;

  /// No description provided for @resultRightSub.
  ///
  /// In en, this message translates to:
  /// **'You called it — and you still showed up. That\'s the win.'**
  String get resultRightSub;

  /// No description provided for @resultTougherHeadline.
  ///
  /// In en, this message translates to:
  /// **'Tougher than you guessed — and you did it.'**
  String get resultTougherHeadline;

  /// No description provided for @resultTougherSub.
  ///
  /// In en, this message translates to:
  /// **'Some moments ask more of us. Showing up anyway is the whole point.'**
  String get resultTougherSub;

  /// No description provided for @resultPredicted.
  ///
  /// In en, this message translates to:
  /// **'Predicted'**
  String get resultPredicted;

  /// No description provided for @resultActual.
  ///
  /// In en, this message translates to:
  /// **'Actual'**
  String get resultActual;

  /// No description provided for @resultLighter.
  ///
  /// In en, this message translates to:
  /// **'This moment was {reduction}% lighter than you feared'**
  String resultLighter(int reduction);

  /// No description provided for @resultSkippedHeadline.
  ///
  /// In en, this message translates to:
  /// **'Logged — no pressure.'**
  String get resultSkippedHeadline;

  /// No description provided for @resultSkippedSub.
  ///
  /// In en, this message translates to:
  /// **'Not today is a perfectly good answer. This rung is still here whenever you\'re ready.'**
  String get resultSkippedSub;

  /// No description provided for @resultWinCopied.
  ///
  /// In en, this message translates to:
  /// **'Win copied — paste it wherever you like.'**
  String get resultWinCopied;

  /// No description provided for @resultCopyWin.
  ///
  /// In en, this message translates to:
  /// **'Copy my win'**
  String get resultCopyWin;

  /// No description provided for @resultShareText.
  ///
  /// In en, this message translates to:
  /// **'I just did something I used to avoid: {rung}. One small rung climbed. 🪜 #Rung'**
  String resultShareText(String rung);

  /// No description provided for @tracksTitle.
  ///
  /// In en, this message translates to:
  /// **'Your tracks'**
  String get tracksTitle;

  /// No description provided for @tracksSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Small steps toward big confidence.'**
  String get tracksSubtitle;

  /// No description provided for @menuInsights.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get menuInsights;

  /// No description provided for @menuIsThisRight.
  ///
  /// In en, this message translates to:
  /// **'Is this right for me?'**
  String get menuIsThisRight;

  /// No description provided for @tracksRungsCount.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} rungs'**
  String tracksRungsCount(int done, int total);

  /// No description provided for @tracksClimbedCount.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} climbed'**
  String tracksClimbedCount(int done, int total);

  /// No description provided for @tracksContinueLabel.
  ///
  /// In en, this message translates to:
  /// **'CONTINUE WHERE YOU LEFT OFF'**
  String get tracksContinueLabel;

  /// No description provided for @tracksNextStepLabel.
  ///
  /// In en, this message translates to:
  /// **'YOUR NEXT STEP'**
  String get tracksNextStepLabel;

  /// No description provided for @tracksLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load tracks.'**
  String get tracksLoadError;

  /// No description provided for @todayResume.
  ///
  /// In en, this message translates to:
  /// **'Pick up where you left off'**
  String get todayResume;

  /// No description provided for @todayNext.
  ///
  /// In en, this message translates to:
  /// **'Your next step'**
  String get todayNext;

  /// No description provided for @todayVariety.
  ///
  /// In en, this message translates to:
  /// **'Something a little different'**
  String get todayVariety;

  /// No description provided for @todayFresh.
  ///
  /// In en, this message translates to:
  /// **'Your starting point'**
  String get todayFresh;

  /// No description provided for @todayResumeCta.
  ///
  /// In en, this message translates to:
  /// **'Finish logging'**
  String get todayResumeCta;

  /// No description provided for @todayStartCta.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get todayStartCta;

  /// No description provided for @todayMinutes.
  ///
  /// In en, this message translates to:
  /// **'~{min} min'**
  String todayMinutes(int min);

  /// No description provided for @dashShareTooltip.
  ///
  /// In en, this message translates to:
  /// **'Share my progress'**
  String get dashShareTooltip;

  /// No description provided for @dashWeeklyGoal.
  ///
  /// In en, this message translates to:
  /// **'Weekly goal'**
  String get dashWeeklyGoal;

  /// No description provided for @dashStepsPerWeek.
  ///
  /// In en, this message translates to:
  /// **'{count} steps/week'**
  String dashStepsPerWeek(int count);

  /// No description provided for @dashGoalPerWeek.
  ///
  /// In en, this message translates to:
  /// **'{count}/week'**
  String dashGoalPerWeek(int count);

  /// No description provided for @dashWeeklyProgress.
  ///
  /// In en, this message translates to:
  /// **'{done} of {goal} steps completed this week'**
  String dashWeeklyProgress(int done, int goal);

  /// No description provided for @dashYourGrowth.
  ///
  /// In en, this message translates to:
  /// **'Your growth'**
  String get dashYourGrowth;

  /// No description provided for @dashTodayError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load today\'s step. Pull to retry.'**
  String get dashTodayError;

  /// No description provided for @dashTodayAllClear.
  ///
  /// In en, this message translates to:
  /// **'You\'ve cleared everything available — add a custom rung or revisit one to keep the streak going.'**
  String get dashTodayAllClear;

  /// No description provided for @dashTakeABreak.
  ///
  /// In en, this message translates to:
  /// **'Take a break'**
  String get dashTakeABreak;

  /// No description provided for @dashTakeABreakSub.
  ///
  /// In en, this message translates to:
  /// **'A few quiet games — vs the phone or a friend.'**
  String get dashTakeABreakSub;

  /// No description provided for @ladderTitleFallback.
  ///
  /// In en, this message translates to:
  /// **'Ladder'**
  String get ladderTitleFallback;

  /// No description provided for @ladderLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load ladder.'**
  String get ladderLoadError;

  /// No description provided for @ladderAddOwn.
  ///
  /// In en, this message translates to:
  /// **'Add your own rung'**
  String get ladderAddOwn;

  /// No description provided for @ladderOfClimbed.
  ///
  /// In en, this message translates to:
  /// **'of {total} climbed'**
  String ladderOfClimbed(int total);

  /// No description provided for @detailLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load.'**
  String get detailLoadError;

  /// No description provided for @detailNotExist.
  ///
  /// In en, this message translates to:
  /// **'This rung no longer exists.'**
  String get detailNotExist;

  /// No description provided for @detailWhatToDo.
  ///
  /// In en, this message translates to:
  /// **'What to do'**
  String get detailWhatToDo;

  /// No description provided for @detailWhyHelps.
  ///
  /// In en, this message translates to:
  /// **'Why this helps'**
  String get detailWhyHelps;

  /// No description provided for @detailPastAttempts.
  ///
  /// In en, this message translates to:
  /// **'Your past attempts'**
  String get detailPastAttempts;

  /// No description provided for @detailDoThis.
  ///
  /// In en, this message translates to:
  /// **'I\'ll do this'**
  String get detailDoThis;

  /// No description provided for @detailReattempt.
  ///
  /// In en, this message translates to:
  /// **'Re-attempting is encouraged — it builds your data.'**
  String get detailReattempt;

  /// No description provided for @detailHistoryStat.
  ///
  /// In en, this message translates to:
  /// **'predicted {predicted} · actual {actual}'**
  String detailHistoryStat(int predicted, int actual);

  /// No description provided for @customLimitPremium.
  ///
  /// In en, this message translates to:
  /// **'You\'ve reached this month\'s limit of {cap} custom rungs — it resets next month.'**
  String customLimitPremium(int cap);

  /// No description provided for @customLimitFree.
  ///
  /// In en, this message translates to:
  /// **'Free plan includes 5 custom rungs — upgrade for more each month.'**
  String get customLimitFree;

  /// No description provided for @customDefaultWhat.
  ///
  /// In en, this message translates to:
  /// **'A challenge you set for yourself.'**
  String get customDefaultWhat;

  /// No description provided for @customDefaultWhy.
  ///
  /// In en, this message translates to:
  /// **'You named this one — that makes it count.'**
  String get customDefaultWhy;

  /// No description provided for @customSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your situation is specific — this rung is just for you.'**
  String get customSubtitle;

  /// No description provided for @customWhatLabel.
  ///
  /// In en, this message translates to:
  /// **'What will you do?'**
  String get customWhatLabel;

  /// No description provided for @customWhatHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Ask my manager for feedback'**
  String get customWhatHint;

  /// No description provided for @customNoteLabel.
  ///
  /// In en, this message translates to:
  /// **'A note to yourself (optional)'**
  String get customNoteLabel;

  /// No description provided for @customDifficulty.
  ///
  /// In en, this message translates to:
  /// **'How hard does it feel? {value}/10'**
  String customDifficulty(int value);

  /// No description provided for @customAddToLadder.
  ///
  /// In en, this message translates to:
  /// **'Add to ladder'**
  String get customAddToLadder;

  /// No description provided for @paywallSwitchToFree.
  ///
  /// In en, this message translates to:
  /// **'Switch to Free'**
  String get paywallSwitchToFree;

  /// No description provided for @paywallHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have to face it alone.'**
  String get paywallHeroTitle;

  /// No description provided for @paywallHeroBody.
  ///
  /// In en, this message translates to:
  /// **'The daily practice is always free. Premium adds a private coach in your corner — and a bigger community beside you — for when you\'re ready to go further.'**
  String get paywallHeroBody;

  /// No description provided for @paywallWhatsIncluded.
  ///
  /// In en, this message translates to:
  /// **'What\'s included'**
  String get paywallWhatsIncluded;

  /// No description provided for @paywallPlusHeader.
  ///
  /// In en, this message translates to:
  /// **'Plus, every subscriber gets'**
  String get paywallPlusHeader;

  /// No description provided for @paywallBenefitCoach.
  ///
  /// In en, this message translates to:
  /// **'A private coach, any time — rehearse something coming up or talk through how it went'**
  String get paywallBenefitCoach;

  /// No description provided for @paywallBenefitPods.
  ///
  /// In en, this message translates to:
  /// **'You\'re not doing this alone — join more support pods (3 on monthly, unlimited on yearly)'**
  String get paywallBenefitPods;

  /// No description provided for @paywallBenefitCustom.
  ///
  /// In en, this message translates to:
  /// **'Build unlimited ladders of your own — no cap on custom steps'**
  String get paywallBenefitCustom;

  /// No description provided for @paywallBenefitDepth.
  ///
  /// In en, this message translates to:
  /// **'Go deeper when you\'re ready — up to 40 steps a track (free is a full 10-step arc)'**
  String get paywallBenefitDepth;

  /// No description provided for @paywallPlusStreak.
  ///
  /// In en, this message translates to:
  /// **'Streak protection — a missed day won\'t break your streak'**
  String get paywallPlusStreak;

  /// No description provided for @paywallPlusInsights.
  ///
  /// In en, this message translates to:
  /// **'Deeper insights — your month at a glance'**
  String get paywallPlusInsights;

  /// No description provided for @paywallPlusShare.
  ///
  /// In en, this message translates to:
  /// **'Personal share-card styles'**
  String get paywallPlusShare;

  /// No description provided for @paywallPlusPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Always private, always ad-free'**
  String get paywallPlusPrivacy;

  /// No description provided for @paywallYearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get paywallYearly;

  /// No description provided for @paywallPerYear.
  ///
  /// In en, this message translates to:
  /// **'per year · best value'**
  String get paywallPerYear;

  /// No description provided for @paywallSave.
  ///
  /// In en, this message translates to:
  /// **'Save 33%'**
  String get paywallSave;

  /// No description provided for @paywallMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get paywallMonthly;

  /// No description provided for @paywallPerMonth.
  ///
  /// In en, this message translates to:
  /// **'per month'**
  String get paywallPerMonth;

  /// No description provided for @paywallSwitchYearly.
  ///
  /// In en, this message translates to:
  /// **'Switch to yearly'**
  String get paywallSwitchYearly;

  /// No description provided for @paywallSwitchMonthly.
  ///
  /// In en, this message translates to:
  /// **'Switch to monthly'**
  String get paywallSwitchMonthly;

  /// No description provided for @paywallStartYearly.
  ///
  /// In en, this message translates to:
  /// **'Start yearly — {price}'**
  String paywallStartYearly(String price);

  /// No description provided for @paywallStartMonthly.
  ///
  /// In en, this message translates to:
  /// **'Start monthly — {price}'**
  String paywallStartMonthly(String price);

  /// No description provided for @paywallRestore.
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get paywallRestore;

  /// No description provided for @paywallCurrentPlan.
  ///
  /// In en, this message translates to:
  /// **'Current plan: {plan}. Cancel anytime.'**
  String paywallCurrentPlan(String plan);

  /// No description provided for @paywallCancelAnytime.
  ///
  /// In en, this message translates to:
  /// **'Cancel anytime. The core loop stays free forever.'**
  String get paywallCancelAnytime;

  /// No description provided for @paywallSimulated.
  ///
  /// In en, this message translates to:
  /// **'Premium active (simulated — add RevenueCat keys for real purchases).'**
  String get paywallSimulated;

  /// No description provided for @paywallPlanUnavailable.
  ///
  /// In en, this message translates to:
  /// **'That plan isn\'t available right now. Try again shortly.'**
  String get paywallPlanUnavailable;

  /// No description provided for @paywallThankYou.
  ///
  /// In en, this message translates to:
  /// **'Premium active — thank you. 🌱'**
  String get paywallThankYou;

  /// No description provided for @paywallPurchaseFailed.
  ///
  /// In en, this message translates to:
  /// **'The purchase didn\'t complete. You haven\'t been charged.'**
  String get paywallPurchaseFailed;

  /// No description provided for @paywallRestored.
  ///
  /// In en, this message translates to:
  /// **'Purchases restored.'**
  String get paywallRestored;

  /// No description provided for @paywallNoRestore.
  ///
  /// In en, this message translates to:
  /// **'No previous purchases found on this account.'**
  String get paywallNoRestore;

  /// No description provided for @paywallRestoreFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t restore right now. Try again shortly.'**
  String get paywallRestoreFailed;

  /// No description provided for @profileAddName.
  ///
  /// In en, this message translates to:
  /// **'Add your name'**
  String get profileAddName;

  /// No description provided for @profileLockTitle.
  ///
  /// In en, this message translates to:
  /// **'Lock my profile'**
  String get profileLockTitle;

  /// No description provided for @profileLockedSub.
  ///
  /// In en, this message translates to:
  /// **'Hidden — pod members can\'t open your details.'**
  String get profileLockedSub;

  /// No description provided for @profileUnlockedSub.
  ///
  /// In en, this message translates to:
  /// **'Pod members can tap your avatar to see your details.'**
  String get profileUnlockedSub;

  /// No description provided for @profilePlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Your plan'**
  String get profilePlanTitle;

  /// No description provided for @profilePremium.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get profilePremium;

  /// No description provided for @profileUpgrade.
  ///
  /// In en, this message translates to:
  /// **'Upgrade'**
  String get profileUpgrade;

  /// No description provided for @profileToneDesc.
  ///
  /// In en, this message translates to:
  /// **'Rung speaks gently by default. If your anxiety is more situational, a slightly bolder tone may suit you better.'**
  String get profileToneDesc;

  /// No description provided for @profileToneIntrovert.
  ///
  /// In en, this message translates to:
  /// **'Introvert'**
  String get profileToneIntrovert;

  /// No description provided for @profileToneSituational.
  ///
  /// In en, this message translates to:
  /// **'Situational'**
  String get profileToneSituational;

  /// No description provided for @profileSafetySub.
  ///
  /// In en, this message translates to:
  /// **'How Rung fits — and when to seek more'**
  String get profileSafetySub;

  /// No description provided for @profileBlockedTitle.
  ///
  /// In en, this message translates to:
  /// **'Blocked members'**
  String get profileBlockedTitle;

  /// No description provided for @profileBlockedSub.
  ///
  /// In en, this message translates to:
  /// **'See and unblock people you\'ve blocked'**
  String get profileBlockedSub;

  /// No description provided for @profileRestoreTitle.
  ///
  /// In en, this message translates to:
  /// **'Restore my progress'**
  String get profileRestoreTitle;

  /// No description provided for @profileRestoreSub.
  ///
  /// In en, this message translates to:
  /// **'Pull your streak & challenges from the cloud'**
  String get profileRestoreSub;

  /// No description provided for @profileRestoring.
  ///
  /// In en, this message translates to:
  /// **'Restoring…'**
  String get profileRestoring;

  /// No description provided for @profileRestoreOk.
  ///
  /// In en, this message translates to:
  /// **'Progress restored from the cloud.'**
  String get profileRestoreOk;

  /// No description provided for @profileRestoreFail.
  ///
  /// In en, this message translates to:
  /// **'Restore failed: {error}'**
  String profileRestoreFail(String error);

  /// No description provided for @profileLogout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get profileLogout;

  /// No description provided for @profileChangePwTitle.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get profileChangePwTitle;

  /// No description provided for @profileChangePwSub.
  ///
  /// In en, this message translates to:
  /// **'Set a new password for your account'**
  String get profileChangePwSub;

  /// No description provided for @profileChangePwSaved.
  ///
  /// In en, this message translates to:
  /// **'Password updated'**
  String get profileChangePwSaved;

  /// No description provided for @profileSignedIn.
  ///
  /// In en, this message translates to:
  /// **'Signed in'**
  String get profileSignedIn;

  /// No description provided for @profileLogoutConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Log out?'**
  String get profileLogoutConfirmTitle;

  /// No description provided for @profileLogoutConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Your progress is saved to the cloud and comes back when you sign in again.'**
  String get profileLogoutConfirmBody;

  /// No description provided for @profileLoggingOut.
  ///
  /// In en, this message translates to:
  /// **'Logging out…'**
  String get profileLoggingOut;

  /// No description provided for @profileRateTitle.
  ///
  /// In en, this message translates to:
  /// **'Rate Rung'**
  String get profileRateTitle;

  /// No description provided for @profileRateSub.
  ///
  /// In en, this message translates to:
  /// **'Tell us how it\'s going — it really helps'**
  String get profileRateSub;

  /// No description provided for @profilePrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get profilePrivacyTitle;

  /// No description provided for @profilePrivacySub.
  ///
  /// In en, this message translates to:
  /// **'What we store — and what stays on your device'**
  String get profilePrivacySub;

  /// No description provided for @profileTermsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get profileTermsTitle;

  /// No description provided for @profileTermsSub.
  ///
  /// In en, this message translates to:
  /// **'The agreement for using Rung'**
  String get profileTermsSub;

  /// No description provided for @profileDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get profileDeleteTitle;

  /// No description provided for @profileDeleteSub.
  ///
  /// In en, this message translates to:
  /// **'Permanently erase your account and data'**
  String get profileDeleteSub;

  /// No description provided for @profileFooter.
  ///
  /// In en, this message translates to:
  /// **'Rung · practice, not therapy. Your data is yours.'**
  String get profileFooter;

  /// No description provided for @profileDeleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete account?'**
  String get profileDeleteConfirmTitle;

  /// No description provided for @profileDeleteConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'This permanently deletes your account, your pod messages, and your saved progress. This cannot be undone.'**
  String get profileDeleteConfirmBody;

  /// No description provided for @profileDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get profileDelete;

  /// No description provided for @profileDeleting.
  ///
  /// In en, this message translates to:
  /// **'Deleting your account…'**
  String get profileDeleting;

  /// No description provided for @profileDeleteFail.
  ///
  /// In en, this message translates to:
  /// **'Could not delete your account. Try again.'**
  String get profileDeleteFail;

  /// No description provided for @profileBioPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'A quiet climber.'**
  String get profileBioPlaceholder;

  /// No description provided for @profileHaptics.
  ///
  /// In en, this message translates to:
  /// **'Haptics'**
  String get profileHaptics;

  /// No description provided for @profileHapticsSub.
  ///
  /// In en, this message translates to:
  /// **'Gentle vibration on taps and wins'**
  String get profileHapticsSub;

  /// No description provided for @profileAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Share anonymous usage data'**
  String get profileAnalytics;

  /// No description provided for @profileAnalyticsSub.
  ///
  /// In en, this message translates to:
  /// **'Helps improve Rung. No personal data, ever.'**
  String get profileAnalyticsSub;

  /// No description provided for @profileNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get profileNotifications;

  /// No description provided for @profileNotificationsSub.
  ///
  /// In en, this message translates to:
  /// **'Alerts from Rung on this device'**
  String get profileNotificationsSub;

  /// No description provided for @profilePodAlerts.
  ///
  /// In en, this message translates to:
  /// **'Pod message alerts'**
  String get profilePodAlerts;

  /// No description provided for @profilePodAlertsSub.
  ///
  /// In en, this message translates to:
  /// **'Tell me when someone posts in my pods'**
  String get profilePodAlertsSub;

  /// No description provided for @profileEnableNotifs.
  ///
  /// In en, this message translates to:
  /// **'Enable notifications in Settings to get reminders.'**
  String get profileEnableNotifs;

  /// No description provided for @profileReminderHelp.
  ///
  /// In en, this message translates to:
  /// **'When should we nudge you?'**
  String get profileReminderHelp;

  /// No description provided for @profileReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Gentle daily reminder'**
  String get profileReminderTitle;

  /// No description provided for @profileReminderOn.
  ///
  /// In en, this message translates to:
  /// **'Every day at {time} · tap the switch to turn off'**
  String profileReminderOn(String time);

  /// No description provided for @profileReminderOff.
  ///
  /// In en, this message translates to:
  /// **'A calm, no-guilt nudge to take one small step'**
  String get profileReminderOff;

  /// No description provided for @profileAvatarTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your avatar'**
  String get profileAvatarTitle;

  /// No description provided for @profileAvatarSub.
  ///
  /// In en, this message translates to:
  /// **'Only you can change it — pod-mates see it too.'**
  String get profileAvatarSub;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// No description provided for @checkInMoodCalm.
  ///
  /// In en, this message translates to:
  /// **'Calm'**
  String get checkInMoodCalm;

  /// No description provided for @checkInMoodOkay.
  ///
  /// In en, this message translates to:
  /// **'Okay'**
  String get checkInMoodOkay;

  /// No description provided for @checkInMoodAnxious.
  ///
  /// In en, this message translates to:
  /// **'Anxious'**
  String get checkInMoodAnxious;

  /// No description provided for @checkInMoodLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get checkInMoodLow;

  /// No description provided for @checkInMoodTense.
  ///
  /// In en, this message translates to:
  /// **'Tense'**
  String get checkInMoodTense;

  /// No description provided for @checkInTitle.
  ///
  /// In en, this message translates to:
  /// **'How are you arriving today?'**
  String get checkInTitle;

  /// No description provided for @checkInDismiss.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get checkInDismiss;

  /// No description provided for @checkInCalmCta.
  ///
  /// In en, this message translates to:
  /// **'Try a calm moment'**
  String get checkInCalmCta;

  /// No description provided for @checkInStepCta.
  ///
  /// In en, this message translates to:
  /// **'See today\'s step'**
  String get checkInStepCta;

  /// No description provided for @supportTitle.
  ///
  /// In en, this message translates to:
  /// **'This sounds like a lot to carry.'**
  String get supportTitle;

  /// No description provided for @supportBody.
  ///
  /// In en, this message translates to:
  /// **'Rung is a practice tool, not a crisis service. If you\'re going through something heavy, please reach out to someone who can help right now — a trusted person, or a local crisis line. You deserve real support.'**
  String get supportBody;

  /// No description provided for @supportResources.
  ///
  /// In en, this message translates to:
  /// **'See support resources'**
  String get supportResources;

  /// No description provided for @progressChallenges.
  ///
  /// In en, this message translates to:
  /// **'Challenges'**
  String get progressChallenges;

  /// No description provided for @progressCurrentStreak.
  ///
  /// In en, this message translates to:
  /// **'Current Streak'**
  String get progressCurrentStreak;

  /// No description provided for @progressBestStreak.
  ///
  /// In en, this message translates to:
  /// **'Best Streak'**
  String get progressBestStreak;

  /// No description provided for @progressThisWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get progressThisWeek;

  /// No description provided for @progressCategoryBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Category Breakdown'**
  String get progressCategoryBreakdown;

  /// No description provided for @insightsHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get insightsHistory;

  /// No description provided for @checkInAckTitle.
  ///
  /// In en, this message translates to:
  /// **'Checked in — feeling {mood}'**
  String checkInAckTitle(String mood);

  /// No description provided for @checkInAckGentle.
  ///
  /// In en, this message translates to:
  /// **'Thanks for being honest. Let\'s keep today gentle — one small, kind thing is enough.'**
  String get checkInAckGentle;

  /// No description provided for @checkInAckStep.
  ///
  /// In en, this message translates to:
  /// **'Love that. When you\'re ready, one small step keeps the momentum going.'**
  String get checkInAckStep;

  /// No description provided for @sharePremiumPerk.
  ///
  /// In en, this message translates to:
  /// **'✨ More card styles are a Premium perk.'**
  String get sharePremiumPerk;

  /// No description provided for @shareSeePremium.
  ///
  /// In en, this message translates to:
  /// **'See Premium'**
  String get shareSeePremium;

  /// No description provided for @shareText.
  ///
  /// In en, this message translates to:
  /// **'Small brave steps, one rung at a time. 🌱 #Rung'**
  String get shareText;

  /// No description provided for @shareError.
  ///
  /// In en, this message translates to:
  /// **'Could not open share. Try again.'**
  String get shareError;

  /// No description provided for @shareTitle.
  ///
  /// In en, this message translates to:
  /// **'Share your progress'**
  String get shareTitle;

  /// No description provided for @shareSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Just your numbers — nothing private.'**
  String get shareSubtitle;

  /// No description provided for @shareCta.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareCta;

  /// No description provided for @shareCardHeadline.
  ///
  /// In en, this message translates to:
  /// **'My brave steps'**
  String get shareCardHeadline;

  /// No description provided for @shareCardFearsFaced.
  ///
  /// In en, this message translates to:
  /// **'fears faced'**
  String get shareCardFearsFaced;

  /// No description provided for @shareCardCurrentStreak.
  ///
  /// In en, this message translates to:
  /// **'Current streak'**
  String get shareCardCurrentStreak;

  /// No description provided for @shareCardBestStreak.
  ///
  /// In en, this message translates to:
  /// **'Best streak'**
  String get shareCardBestStreak;

  /// No description provided for @shareCardTagline.
  ///
  /// In en, this message translates to:
  /// **'Facing social fears, one small rung at a time.'**
  String get shareCardTagline;

  /// No description provided for @helpNow.
  ///
  /// In en, this message translates to:
  /// **'Help now'**
  String get helpNow;

  /// No description provided for @helpCalmMoment.
  ///
  /// In en, this message translates to:
  /// **'A calm moment'**
  String get helpCalmMoment;

  /// No description provided for @helpTabBreathe.
  ///
  /// In en, this message translates to:
  /// **'Breathe'**
  String get helpTabBreathe;

  /// No description provided for @helpTabGround.
  ///
  /// In en, this message translates to:
  /// **'Ground'**
  String get helpTabGround;

  /// No description provided for @helpTabSay.
  ///
  /// In en, this message translates to:
  /// **'Say this'**
  String get helpTabSay;

  /// No description provided for @helpBreatheIn.
  ///
  /// In en, this message translates to:
  /// **'Breathe in…'**
  String get helpBreatheIn;

  /// No description provided for @helpBreatheOut.
  ///
  /// In en, this message translates to:
  /// **'Breathe out…'**
  String get helpBreatheOut;

  /// No description provided for @helpBreatheHint.
  ///
  /// In en, this message translates to:
  /// **'Follow the circle. There is no rush.'**
  String get helpBreatheHint;

  /// No description provided for @helpGround5.
  ///
  /// In en, this message translates to:
  /// **'things you can see'**
  String get helpGround5;

  /// No description provided for @helpGround4.
  ///
  /// In en, this message translates to:
  /// **'things you can touch'**
  String get helpGround4;

  /// No description provided for @helpGround3.
  ///
  /// In en, this message translates to:
  /// **'things you can hear'**
  String get helpGround3;

  /// No description provided for @helpGround2.
  ///
  /// In en, this message translates to:
  /// **'things you can smell'**
  String get helpGround2;

  /// No description provided for @helpGround1.
  ///
  /// In en, this message translates to:
  /// **'thing you can taste'**
  String get helpGround1;

  /// No description provided for @helpGroundTitle.
  ///
  /// In en, this message translates to:
  /// **'Name, quietly to yourself…'**
  String get helpGroundTitle;

  /// No description provided for @helpGroundHint.
  ///
  /// In en, this message translates to:
  /// **'This brings you back to right now — where you are safe.'**
  String get helpGroundHint;

  /// No description provided for @helpOpener1.
  ///
  /// In en, this message translates to:
  /// **'How do you know the people here?'**
  String get helpOpener1;

  /// No description provided for @helpOpener2.
  ///
  /// In en, this message translates to:
  /// **'I love this spot — have you been before?'**
  String get helpOpener2;

  /// No description provided for @helpOpener3.
  ///
  /// In en, this message translates to:
  /// **'I\'m hopeless with names — could you remind me?'**
  String get helpOpener3;

  /// No description provided for @helpOpener4.
  ///
  /// In en, this message translates to:
  /// **'What have you been up to this week?'**
  String get helpOpener4;

  /// No description provided for @helpExit1.
  ///
  /// In en, this message translates to:
  /// **'I\'m going to grab a drink — it was good talking to you.'**
  String get helpExit1;

  /// No description provided for @helpExit2.
  ///
  /// In en, this message translates to:
  /// **'I need to say a quick hello to someone, excuse me a sec.'**
  String get helpExit2;

  /// No description provided for @helpExit3.
  ///
  /// In en, this message translates to:
  /// **'I\'ll let you mingle — catch you later.'**
  String get helpExit3;

  /// No description provided for @helpOpenersTitle.
  ///
  /// In en, this message translates to:
  /// **'Easy openers'**
  String get helpOpenersTitle;

  /// No description provided for @helpExitsTitle.
  ///
  /// In en, this message translates to:
  /// **'Graceful exits'**
  String get helpExitsTitle;

  /// No description provided for @authEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get authEnterEmail;

  /// No description provided for @authBadEmail.
  ///
  /// In en, this message translates to:
  /// **'That email doesn\'t look right'**
  String get authBadEmail;

  /// No description provided for @authEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter a password'**
  String get authEnterPassword;

  /// No description provided for @authMin6.
  ///
  /// In en, this message translates to:
  /// **'At least 6 characters'**
  String get authMin6;

  /// No description provided for @authPwMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match'**
  String get authPwMismatch;

  /// No description provided for @authConfirmEmail.
  ///
  /// In en, this message translates to:
  /// **'Check your email to confirm, then sign in. (Or disable email confirmation in Supabase Auth settings for quick testing.)'**
  String get authConfirmEmail;

  /// No description provided for @authGenericError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Try again.'**
  String get authGenericError;

  /// No description provided for @authCreateTitle.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get authCreateTitle;

  /// No description provided for @authWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get authWelcomeBack;

  /// No description provided for @authSignUpSub.
  ///
  /// In en, this message translates to:
  /// **'Join the pods and keep your progress safe across devices.'**
  String get authSignUpSub;

  /// No description provided for @authSignInSub.
  ///
  /// In en, this message translates to:
  /// **'Sign in to your pods and synced progress.'**
  String get authSignInSub;

  /// No description provided for @authDisplayName.
  ///
  /// In en, this message translates to:
  /// **'Display name (optional)'**
  String get authDisplayName;

  /// No description provided for @authEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authEmail;

  /// No description provided for @authPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authPassword;

  /// No description provided for @authShowPassword.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get authShowPassword;

  /// No description provided for @authHidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get authHidePassword;

  /// No description provided for @authConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get authConfirmPassword;

  /// No description provided for @authForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get authForgotPassword;

  /// No description provided for @authResetTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get authResetTitle;

  /// No description provided for @authResetBody.
  ///
  /// In en, this message translates to:
  /// **'Enter your account email and we\'ll send you a link to set a new password.'**
  String get authResetBody;

  /// No description provided for @authResetSend.
  ///
  /// In en, this message translates to:
  /// **'Send reset link'**
  String get authResetSend;

  /// No description provided for @authResetSent.
  ///
  /// In en, this message translates to:
  /// **'If that email has an account, a reset link is on its way.'**
  String get authResetSent;

  /// No description provided for @authNewPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get authNewPassword;

  /// No description provided for @authConfirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm new password'**
  String get authConfirmNewPassword;

  /// No description provided for @authUpdatePasswordCta.
  ///
  /// In en, this message translates to:
  /// **'Update password'**
  String get authUpdatePasswordCta;

  /// No description provided for @authCreateCta.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get authCreateCta;

  /// No description provided for @authSignInCta.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get authSignInCta;

  /// No description provided for @authHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'I already have an account'**
  String get authHaveAccount;

  /// No description provided for @authNewAccount.
  ///
  /// In en, this message translates to:
  /// **'I\'m new — create an account'**
  String get authNewAccount;

  /// No description provided for @authLegalPrefixSignUp.
  ///
  /// In en, this message translates to:
  /// **'By creating an account you agree to our '**
  String get authLegalPrefixSignUp;

  /// No description provided for @authLegalPrefixSignIn.
  ///
  /// In en, this message translates to:
  /// **'By continuing you agree to our '**
  String get authLegalPrefixSignIn;

  /// No description provided for @authTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get authTerms;

  /// No description provided for @authAnd.
  ///
  /// In en, this message translates to:
  /// **' and '**
  String get authAnd;

  /// No description provided for @gamesIntro.
  ///
  /// In en, this message translates to:
  /// **'Quiet games for focus and a calm mind — the kind of brain-training people find grounding. Play the phone, or pass it to a friend.'**
  String get gamesIntro;

  /// No description provided for @gamesBestMs.
  ///
  /// In en, this message translates to:
  /// **'Best {ms} ms'**
  String gamesBestMs(int ms);

  /// No description provided for @gamesBestLevel.
  ///
  /// In en, this message translates to:
  /// **'Best level {level}'**
  String gamesBestLevel(int level);

  /// No description provided for @gamesBest.
  ///
  /// In en, this message translates to:
  /// **'Best {score}'**
  String gamesBest(String score);

  /// No description provided for @gamesBestMoves.
  ///
  /// In en, this message translates to:
  /// **'Best {moves} moves'**
  String gamesBestMoves(int moves);

  /// No description provided for @gamesWinsVsPhone.
  ///
  /// In en, this message translates to:
  /// **'{count} wins vs phone'**
  String gamesWinsVsPhone(int count);

  /// No description provided for @gameTitleReaction.
  ///
  /// In en, this message translates to:
  /// **'Reaction speed'**
  String get gameTitleReaction;

  /// No description provided for @gameTitleSequence.
  ///
  /// In en, this message translates to:
  /// **'Sequence memory'**
  String get gameTitleSequence;

  /// No description provided for @gameTitleQuickMath.
  ///
  /// In en, this message translates to:
  /// **'Quick Math'**
  String get gameTitleQuickMath;

  /// No description provided for @gameTitleMemory.
  ///
  /// In en, this message translates to:
  /// **'Memory match'**
  String get gameTitleMemory;

  /// No description provided for @gameSubReaction.
  ///
  /// In en, this message translates to:
  /// **'focus · tap when it turns green'**
  String get gameSubReaction;

  /// No description provided for @gameSubSequence.
  ///
  /// In en, this message translates to:
  /// **'memory · watch and repeat'**
  String get gameSubSequence;

  /// No description provided for @gameSub2048.
  ///
  /// In en, this message translates to:
  /// **'strategy · swipe to merge'**
  String get gameSub2048;

  /// No description provided for @gameSubQuickMath.
  ///
  /// In en, this message translates to:
  /// **'mental speed · 30-second sprint'**
  String get gameSubQuickMath;

  /// No description provided for @gameSubTicTacToe.
  ///
  /// In en, this message translates to:
  /// **'vs the phone · or 2 players'**
  String get gameSubTicTacToe;

  /// No description provided for @gameSubConnect4.
  ///
  /// In en, this message translates to:
  /// **'vs the phone · or 2 players'**
  String get gameSubConnect4;

  /// No description provided for @gameSubMemory.
  ///
  /// In en, this message translates to:
  /// **'solo · find the pairs'**
  String get gameSubMemory;

  /// No description provided for @gameHelpTooltip.
  ///
  /// In en, this message translates to:
  /// **'How to play'**
  String get gameHelpTooltip;

  /// No description provided for @gameHelpTitle.
  ///
  /// In en, this message translates to:
  /// **'How to play · {game}'**
  String gameHelpTitle(String game);

  /// No description provided for @gameGotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get gameGotIt;

  /// No description provided for @tierFree.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get tierFree;

  /// No description provided for @tierMonthly.
  ///
  /// In en, this message translates to:
  /// **'Premium · Monthly'**
  String get tierMonthly;

  /// No description provided for @tierYearly.
  ///
  /// In en, this message translates to:
  /// **'Premium · Yearly'**
  String get tierYearly;

  /// No description provided for @podsUnlimited.
  ///
  /// In en, this message translates to:
  /// **'unlimited pods'**
  String get podsUnlimited;

  /// No description provided for @podsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 pod} other{{count} pods}}'**
  String podsCount(int count);

  /// No description provided for @groupsSignedOutTitle.
  ///
  /// In en, this message translates to:
  /// **'Join a small, kind pod'**
  String get groupsSignedOutTitle;

  /// No description provided for @groupsSignedOutBody.
  ///
  /// In en, this message translates to:
  /// **'Groups need a quick account so pods are safe and yours. Your practice stays private and account-free.'**
  String get groupsSignedOutBody;

  /// No description provided for @groupsSignInCta.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get groupsSignInCta;

  /// No description provided for @groupsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load pods. Pull to retry.'**
  String get groupsLoadError;

  /// No description provided for @groupsJoined.
  ///
  /// In en, this message translates to:
  /// **'Joined {pod}. Say hi when you\'re ready.'**
  String groupsJoined(String pod);

  /// No description provided for @groupsJoinedNew.
  ///
  /// In en, this message translates to:
  /// **'Joined a new pod. Say hi when you\'re ready.'**
  String get groupsJoinedNew;

  /// No description provided for @groupsNoPodFound.
  ///
  /// In en, this message translates to:
  /// **'Could not find a pod right now. Try again.'**
  String get groupsNoPodFound;

  /// No description provided for @groupsLeaveTitle.
  ///
  /// In en, this message translates to:
  /// **'Leave {pod}?'**
  String groupsLeaveTitle(String pod);

  /// No description provided for @groupsLeave.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get groupsLeave;

  /// No description provided for @groupsLeft.
  ///
  /// In en, this message translates to:
  /// **'You left {pod}.'**
  String groupsLeft(String pod);

  /// No description provided for @groupsLeaveError.
  ///
  /// In en, this message translates to:
  /// **'Could not leave the pod. Try again.'**
  String get groupsLeaveError;

  /// No description provided for @groupsHeader.
  ///
  /// In en, this message translates to:
  /// **'Small pods, kind people'**
  String get groupsHeader;

  /// No description provided for @groupsYourPods.
  ///
  /// In en, this message translates to:
  /// **'YOUR PODS'**
  String get groupsYourPods;

  /// No description provided for @groupsDiscoverPods.
  ///
  /// In en, this message translates to:
  /// **'DISCOVER PODS'**
  String get groupsDiscoverPods;

  /// No description provided for @groupsJoinAnother.
  ///
  /// In en, this message translates to:
  /// **'Join another pod'**
  String get groupsJoinAnother;

  /// No description provided for @groupsNoOthers.
  ///
  /// In en, this message translates to:
  /// **'No other pods to join right now.'**
  String get groupsNoOthers;

  /// No description provided for @groupsJoinedShort.
  ///
  /// In en, this message translates to:
  /// **'Joined {pod}.'**
  String groupsJoinedShort(String pod);

  /// No description provided for @groupsJoin.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get groupsJoin;

  /// No description provided for @groupsPodOptions.
  ///
  /// In en, this message translates to:
  /// **'Pod options'**
  String get groupsPodOptions;

  /// No description provided for @groupsLeavePod.
  ///
  /// In en, this message translates to:
  /// **'Leave pod'**
  String get groupsLeavePod;

  /// No description provided for @groupsMembers.
  ///
  /// In en, this message translates to:
  /// **'{count}/{capacity} members'**
  String groupsMembers(int count, int capacity);

  /// No description provided for @groupsTierPods.
  ///
  /// In en, this message translates to:
  /// **'On {tier} you can be in {pods}.'**
  String groupsTierPods(String tier, String pods);

  /// No description provided for @groupsCapacityTierPods.
  ///
  /// In en, this message translates to:
  /// **'Up to {capacity} per pod. On {tier} you can be in {pods}.'**
  String groupsCapacityTierPods(int capacity, String tier, String pods);

  /// No description provided for @groupsInYourPods.
  ///
  /// In en, this message translates to:
  /// **'You\'re in your {pods}'**
  String groupsInYourPods(String pods);

  /// No description provided for @groupsUpgradeBody.
  ///
  /// In en, this message translates to:
  /// **'Go Premium to join more — monthly unlocks 3 pods, yearly unlocks as many as you like.'**
  String get groupsUpgradeBody;

  /// No description provided for @groupsSafetyLive.
  ///
  /// In en, this message translates to:
  /// **'Be kind. You can report or block anyone from their profile. Locked profiles stay private.'**
  String get groupsSafetyLive;

  /// No description provided for @groupsSafetyPreview.
  ///
  /// In en, this message translates to:
  /// **'Preview. Pods become live, moderated chats once sign-in is configured.'**
  String get groupsSafetyPreview;

  /// No description provided for @groupsLeaveBody.
  ///
  /// In en, this message translates to:
  /// **'You\'ll stop seeing this pod\'s messages. You can join again later.'**
  String get groupsLeaveBody;

  /// No description provided for @podRulesTitle.
  ///
  /// In en, this message translates to:
  /// **'Pod rules'**
  String get podRulesTitle;

  /// No description provided for @podRulesIntro.
  ///
  /// In en, this message translates to:
  /// **'Pods only work if everyone feels safe. By joining you agree:'**
  String get podRulesIntro;

  /// No description provided for @podRule1.
  ///
  /// In en, this message translates to:
  /// **'Be kind. Everyone here is practicing something hard.'**
  String get podRule1;

  /// No description provided for @podRule2.
  ///
  /// In en, this message translates to:
  /// **'No harassment, hate, or harmful content. Ever.'**
  String get podRule2;

  /// No description provided for @podRule3.
  ///
  /// In en, this message translates to:
  /// **'Report or block anyone who makes you uncomfortable.'**
  String get podRule3;

  /// No description provided for @podRule4.
  ///
  /// In en, this message translates to:
  /// **'Respect privacy — what\'s shared here stays here.'**
  String get podRule4;

  /// No description provided for @podRule5.
  ///
  /// In en, this message translates to:
  /// **'Pods are peer support, not a crisis service. In an emergency, contact a professional or local crisis line.'**
  String get podRule5;

  /// No description provided for @podRulesAgree.
  ///
  /// In en, this message translates to:
  /// **'I agree — take me in'**
  String get podRulesAgree;

  /// No description provided for @chatIntrosBeKind.
  ///
  /// In en, this message translates to:
  /// **'{count}/{capacity} introverts · be kind'**
  String chatIntrosBeKind(int count, int capacity);

  /// No description provided for @chatHint.
  ///
  /// In en, this message translates to:
  /// **'Say something kind…'**
  String get chatHint;

  /// No description provided for @chatPreviewBanner.
  ///
  /// In en, this message translates to:
  /// **'Preview · messages stay on your device for now. Real, moderated pods arrive with accounts.'**
  String get chatPreviewBanner;

  /// No description provided for @chatYou.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get chatYou;

  /// No description provided for @reportHarassment.
  ///
  /// In en, this message translates to:
  /// **'Harassment or bullying'**
  String get reportHarassment;

  /// No description provided for @reportHate.
  ///
  /// In en, this message translates to:
  /// **'Hate or harmful language'**
  String get reportHate;

  /// No description provided for @reportSpam.
  ///
  /// In en, this message translates to:
  /// **'Spam or scam'**
  String get reportSpam;

  /// No description provided for @reportUnsafe.
  ///
  /// In en, this message translates to:
  /// **'Makes me feel unsafe'**
  String get reportUnsafe;

  /// No description provided for @reportOther.
  ///
  /// In en, this message translates to:
  /// **'Something else'**
  String get reportOther;

  /// No description provided for @memberPrivateTitle.
  ///
  /// In en, this message translates to:
  /// **'Private profile'**
  String get memberPrivateTitle;

  /// No description provided for @memberPrivateBody.
  ///
  /// In en, this message translates to:
  /// **'This member keeps their profile private. You can still chat with them — and report or block if needed.'**
  String get memberPrivateBody;

  /// No description provided for @memberStreak.
  ///
  /// In en, this message translates to:
  /// **'{days}-day streak'**
  String memberStreak(int days);

  /// No description provided for @memberChallenges.
  ///
  /// In en, this message translates to:
  /// **'{count} challenges'**
  String memberChallenges(int count);

  /// No description provided for @memberClimbing.
  ///
  /// In en, this message translates to:
  /// **'Climbing: {track}'**
  String memberClimbing(String track);

  /// No description provided for @memberReport.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get memberReport;

  /// No description provided for @memberBlock.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get memberBlock;

  /// No description provided for @memberReportThanks.
  ///
  /// In en, this message translates to:
  /// **'Thanks — we\'ll review this.'**
  String get memberReportThanks;

  /// No description provided for @memberBlockToo.
  ///
  /// In en, this message translates to:
  /// **'Block too'**
  String get memberBlockToo;

  /// No description provided for @memberBlocked.
  ///
  /// In en, this message translates to:
  /// **'Blocked. You won\'t see their messages.'**
  String get memberBlocked;

  /// No description provided for @memberBlockError.
  ///
  /// In en, this message translates to:
  /// **'Could not block. Try again.'**
  String get memberBlockError;

  /// No description provided for @memberReportError.
  ///
  /// In en, this message translates to:
  /// **'Could not send report. Try again.'**
  String get memberReportError;

  /// No description provided for @memberBlockConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Block this member?'**
  String get memberBlockConfirmTitle;

  /// No description provided for @memberBlockConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'You won\'t see each other\'s messages. You can undo this later.'**
  String get memberBlockConfirmBody;

  /// No description provided for @memberSoonReporting.
  ///
  /// In en, this message translates to:
  /// **'Reporting goes live in moderated pods (sign in to use it).'**
  String get memberSoonReporting;

  /// No description provided for @memberSoonBlocking.
  ///
  /// In en, this message translates to:
  /// **'Blocking goes live in moderated pods (sign in to use it).'**
  String get memberSoonBlocking;

  /// No description provided for @memberWhatsWrong.
  ///
  /// In en, this message translates to:
  /// **'What\'s wrong?'**
  String get memberWhatsWrong;

  /// No description provided for @memberFallback.
  ///
  /// In en, this message translates to:
  /// **'Member'**
  String get memberFallback;

  /// No description provided for @blockedUnblockError.
  ///
  /// In en, this message translates to:
  /// **'Could not unblock. Try again.'**
  String get blockedUnblockError;

  /// No description provided for @blockedUnblocked.
  ///
  /// In en, this message translates to:
  /// **'Unblocked {name}. You\'ll see their messages again.'**
  String blockedUnblocked(String name);

  /// No description provided for @blockedIntro.
  ///
  /// In en, this message translates to:
  /// **'Blocking hides a member\'s messages from you — and yours from them, both ways. Unblock anyone below to undo it.'**
  String get blockedIntro;

  /// No description provided for @blockedLabel.
  ///
  /// In en, this message translates to:
  /// **'Blocked'**
  String get blockedLabel;

  /// No description provided for @blockedUnblock.
  ///
  /// In en, this message translates to:
  /// **'Unblock'**
  String get blockedUnblock;

  /// No description provided for @blockedEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No one blocked'**
  String get blockedEmptyTitle;

  /// No description provided for @blockedEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t blocked anyone. Blocking hides a member\'s messages from you, both ways — and you can always undo it here.'**
  String get blockedEmptyBody;

  /// No description provided for @chatCheckInPosted.
  ///
  /// In en, this message translates to:
  /// **'Nice work. Pod check-in posted.'**
  String get chatCheckInPosted;

  /// No description provided for @chatCheckInError.
  ///
  /// In en, this message translates to:
  /// **'Could not check in right now. Try again.'**
  String get chatCheckInError;

  /// No description provided for @chatDeleteMsgTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete message?'**
  String get chatDeleteMsgTitle;

  /// No description provided for @chatDeleteMsgBody.
  ///
  /// In en, this message translates to:
  /// **'This removes it for everyone in the pod.'**
  String get chatDeleteMsgBody;

  /// No description provided for @chatReply.
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get chatReply;

  /// No description provided for @chatEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get chatEdit;

  /// No description provided for @chatDailyPrompt.
  ///
  /// In en, this message translates to:
  /// **'Daily pod prompt'**
  String get chatDailyPrompt;

  /// No description provided for @chatCheckedInToday.
  ///
  /// In en, this message translates to:
  /// **'Checked in today'**
  String get chatCheckedInToday;

  /// No description provided for @chatDidMyStep.
  ///
  /// In en, this message translates to:
  /// **'I did my step'**
  String get chatDidMyStep;

  /// No description provided for @chatCheckedInCount.
  ///
  /// In en, this message translates to:
  /// **'{count} checked in'**
  String chatCheckedInCount(int count);

  /// No description provided for @chatNoMessages.
  ///
  /// In en, this message translates to:
  /// **'No messages yet. A simple \"hi\" is a brave first rung.'**
  String get chatNoMessages;

  /// No description provided for @chatEditingMessage.
  ///
  /// In en, this message translates to:
  /// **'Editing your message'**
  String get chatEditingMessage;

  /// No description provided for @chatReplyingTo.
  ///
  /// In en, this message translates to:
  /// **'Replying to {name}'**
  String chatReplyingTo(String name);

  /// No description provided for @chatYourself.
  ///
  /// In en, this message translates to:
  /// **'yourself'**
  String get chatYourself;

  /// No description provided for @chatMsgDeleted.
  ///
  /// In en, this message translates to:
  /// **'This message was deleted'**
  String get chatMsgDeleted;

  /// No description provided for @chatPrivateMember.
  ///
  /// In en, this message translates to:
  /// **'Private member'**
  String get chatPrivateMember;

  /// No description provided for @chatBeKind.
  ///
  /// In en, this message translates to:
  /// **'{count}/{capacity} · be kind'**
  String chatBeKind(int count, int capacity);

  /// No description provided for @chatDeletedMessageShort.
  ///
  /// In en, this message translates to:
  /// **'deleted message'**
  String get chatDeletedMessageShort;

  /// No description provided for @gameYouWin.
  ///
  /// In en, this message translates to:
  /// **'You win! 🎉'**
  String get gameYouWin;

  /// No description provided for @gamePhoneWins.
  ///
  /// In en, this message translates to:
  /// **'The phone wins'**
  String get gamePhoneWins;

  /// No description provided for @gamePhoneThinking.
  ///
  /// In en, this message translates to:
  /// **'The phone is thinking…'**
  String get gamePhoneThinking;

  /// No description provided for @gamePlayPhone.
  ///
  /// In en, this message translates to:
  /// **'Play the phone'**
  String get gamePlayPhone;

  /// No description provided for @game2Players.
  ///
  /// In en, this message translates to:
  /// **'2 players'**
  String get game2Players;

  /// No description provided for @gameNewGame.
  ///
  /// In en, this message translates to:
  /// **'New game'**
  String get gameNewGame;

  /// No description provided for @gameYou.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get gameYou;

  /// No description provided for @gamePhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get gamePhone;

  /// No description provided for @gameDraws.
  ///
  /// In en, this message translates to:
  /// **'Draws'**
  String get gameDraws;

  /// No description provided for @tttP1Wins.
  ///
  /// In en, this message translates to:
  /// **'Player 1 (X) wins! 🎉'**
  String get tttP1Wins;

  /// No description provided for @tttP2Wins.
  ///
  /// In en, this message translates to:
  /// **'Player 2 (O) wins! 🎉'**
  String get tttP2Wins;

  /// No description provided for @tttYourTurn.
  ///
  /// In en, this message translates to:
  /// **'Your turn'**
  String get tttYourTurn;

  /// No description provided for @tttP1Turn.
  ///
  /// In en, this message translates to:
  /// **'Player 1 · X'**
  String get tttP1Turn;

  /// No description provided for @tttP2Turn.
  ///
  /// In en, this message translates to:
  /// **'Player 2 · O'**
  String get tttP2Turn;

  /// No description provided for @tttP1Label.
  ///
  /// In en, this message translates to:
  /// **'P1 (X)'**
  String get tttP1Label;

  /// No description provided for @tttP2Label.
  ///
  /// In en, this message translates to:
  /// **'P2 (O)'**
  String get tttP2Label;

  /// No description provided for @tttRule1.
  ///
  /// In en, this message translates to:
  /// **'Take turns placing your mark on the 3×3 grid.'**
  String get tttRule1;

  /// No description provided for @tttRule2.
  ///
  /// In en, this message translates to:
  /// **'Get three of your marks in a row — across, down, or diagonally — to win.'**
  String get tttRule2;

  /// No description provided for @tttRule3.
  ///
  /// In en, this message translates to:
  /// **'\"Play the phone\" is you vs a simple AI. \"2 players\" passes the phone each turn.'**
  String get tttRule3;

  /// No description provided for @c4P1Wins.
  ///
  /// In en, this message translates to:
  /// **'Player 1 wins! 🎉'**
  String get c4P1Wins;

  /// No description provided for @c4P2Wins.
  ///
  /// In en, this message translates to:
  /// **'Player 2 wins! 🎉'**
  String get c4P2Wins;

  /// No description provided for @c4Turn.
  ///
  /// In en, this message translates to:
  /// **'Your turn — tap a column'**
  String get c4Turn;

  /// No description provided for @c4P1Turn.
  ///
  /// In en, this message translates to:
  /// **'Player 1 · red'**
  String get c4P1Turn;

  /// No description provided for @c4P2Turn.
  ///
  /// In en, this message translates to:
  /// **'Player 2 · yellow'**
  String get c4P2Turn;

  /// No description provided for @c4P1Label.
  ///
  /// In en, this message translates to:
  /// **'P1'**
  String get c4P1Label;

  /// No description provided for @c4P2Label.
  ///
  /// In en, this message translates to:
  /// **'P2'**
  String get c4P2Label;

  /// No description provided for @c4Rule1.
  ///
  /// In en, this message translates to:
  /// **'Tap a column to drop your token — it falls to the lowest free slot.'**
  String get c4Rule1;

  /// No description provided for @c4Rule2.
  ///
  /// In en, this message translates to:
  /// **'Line up four of your colour — across, down, or diagonally — to win.'**
  String get c4Rule2;

  /// No description provided for @c4Rule3.
  ///
  /// In en, this message translates to:
  /// **'\"Play the phone\" is you vs a simple AI. \"2 players\" passes the phone.'**
  String get c4Rule3;

  /// No description provided for @gameDraw.
  ///
  /// In en, this message translates to:
  /// **'It\'s a draw 🤝'**
  String get gameDraw;

  /// No description provided for @gamePlayAgain.
  ///
  /// In en, this message translates to:
  /// **'Play again'**
  String get gamePlayAgain;

  /// No description provided for @gameStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get gameStart;

  /// No description provided for @g2048Rule1.
  ///
  /// In en, this message translates to:
  /// **'Swipe up, down, left or right to slide all tiles.'**
  String get g2048Rule1;

  /// No description provided for @g2048Rule2.
  ///
  /// In en, this message translates to:
  /// **'Two tiles with the same number merge into one that doubles.'**
  String get g2048Rule2;

  /// No description provided for @g2048Rule3.
  ///
  /// In en, this message translates to:
  /// **'Keep merging to build a 2048 tile. The board fills — plan ahead!'**
  String get g2048Rule3;

  /// No description provided for @g2048Score.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get g2048Score;

  /// No description provided for @g2048Best.
  ///
  /// In en, this message translates to:
  /// **'Best'**
  String get g2048Best;

  /// No description provided for @g2048GameOver.
  ///
  /// In en, this message translates to:
  /// **'Game over'**
  String get g2048GameOver;

  /// No description provided for @g2048Won.
  ///
  /// In en, this message translates to:
  /// **'You made 2048! 🎉'**
  String get g2048Won;

  /// No description provided for @g2048SwipeToMerge.
  ///
  /// In en, this message translates to:
  /// **'Swipe to merge'**
  String get g2048SwipeToMerge;

  /// No description provided for @qmRule1.
  ///
  /// In en, this message translates to:
  /// **'You have 30 seconds — solve as many as you can.'**
  String get qmRule1;

  /// No description provided for @qmRule2.
  ///
  /// In en, this message translates to:
  /// **'Tap the correct answer from the four choices.'**
  String get qmRule2;

  /// No description provided for @qmRule3.
  ///
  /// In en, this message translates to:
  /// **'A wrong tap costs 2 seconds, so read carefully.'**
  String get qmRule3;

  /// No description provided for @qmTimeScored.
  ///
  /// In en, this message translates to:
  /// **'Time! You scored {score}'**
  String qmTimeScored(Object score);

  /// No description provided for @qmBestSub.
  ///
  /// In en, this message translates to:
  /// **'Best {best} · 30 seconds, answer as many as you can.'**
  String qmBestSub(Object best);

  /// No description provided for @qmStartSub.
  ///
  /// In en, this message translates to:
  /// **'30 seconds. A wrong tap costs 2 seconds.'**
  String get qmStartSub;

  /// No description provided for @qmCorrect.
  ///
  /// In en, this message translates to:
  /// **'correct'**
  String get qmCorrect;

  /// No description provided for @mmRule1.
  ///
  /// In en, this message translates to:
  /// **'Tap a card to flip it, then flip a second one.'**
  String get mmRule1;

  /// No description provided for @mmRule2.
  ///
  /// In en, this message translates to:
  /// **'If the two emojis match, they stay face-up; if not, they flip back.'**
  String get mmRule2;

  /// No description provided for @mmRule3.
  ///
  /// In en, this message translates to:
  /// **'Find all the pairs — in as few moves as you can.'**
  String get mmRule3;

  /// No description provided for @mmAllMatched.
  ///
  /// In en, this message translates to:
  /// **'All matched in {moves} moves! 🎉'**
  String mmAllMatched(Object moves);

  /// No description provided for @mmFindPairs.
  ///
  /// In en, this message translates to:
  /// **'Find the pairs · {moves} moves'**
  String mmFindPairs(Object moves);

  /// No description provided for @mmBest.
  ///
  /// In en, this message translates to:
  /// **'Best: {best} moves'**
  String mmBest(Object best);

  /// No description provided for @mmShuffle.
  ///
  /// In en, this message translates to:
  /// **'Shuffle'**
  String get mmShuffle;

  /// No description provided for @rxTapStart.
  ///
  /// In en, this message translates to:
  /// **'Tap to start'**
  String get rxTapStart;

  /// No description provided for @rxWaitGreen.
  ///
  /// In en, this message translates to:
  /// **'Wait for green, then tap fast'**
  String get rxWaitGreen;

  /// No description provided for @rxWait.
  ///
  /// In en, this message translates to:
  /// **'Wait…'**
  String get rxWait;

  /// No description provided for @rxTapMoment.
  ///
  /// In en, this message translates to:
  /// **'Tap the moment it turns green'**
  String get rxTapMoment;

  /// No description provided for @rxBestRetry.
  ///
  /// In en, this message translates to:
  /// **'Best {ms} ms · tap to retry'**
  String rxBestRetry(Object ms);

  /// No description provided for @rxTapRetry.
  ///
  /// In en, this message translates to:
  /// **'Tap to retry'**
  String get rxTapRetry;

  /// No description provided for @rxTooSoon.
  ///
  /// In en, this message translates to:
  /// **'Too soon!'**
  String get rxTooSoon;

  /// No description provided for @rxWaitRetry.
  ///
  /// In en, this message translates to:
  /// **'Wait for green · tap to retry'**
  String get rxWaitRetry;

  /// No description provided for @rxTap.
  ///
  /// In en, this message translates to:
  /// **'TAP!'**
  String get rxTap;

  /// No description provided for @rxRule1.
  ///
  /// In en, this message translates to:
  /// **'Tap the screen to start, then wait — it will turn amber.'**
  String get rxRule1;

  /// No description provided for @rxRule2.
  ///
  /// In en, this message translates to:
  /// **'The instant it turns green, tap as fast as you can.'**
  String get rxRule2;

  /// No description provided for @rxRule3.
  ///
  /// In en, this message translates to:
  /// **'Tapping too early resets it. A lower time (ms) is better.'**
  String get rxRule3;

  /// No description provided for @smWatchRepeat.
  ///
  /// In en, this message translates to:
  /// **'Watch the pattern, then repeat it.'**
  String get smWatchRepeat;

  /// No description provided for @smWatch.
  ///
  /// In en, this message translates to:
  /// **'Watch…'**
  String get smWatch;

  /// No description provided for @smYourTurn.
  ///
  /// In en, this message translates to:
  /// **'Your turn · {current} of {total}'**
  String smYourTurn(Object current, Object total);

  /// No description provided for @smReachedBest.
  ///
  /// In en, this message translates to:
  /// **'You reached {reached} · best {best}'**
  String smReachedBest(Object best, Object reached);

  /// No description provided for @smReached.
  ///
  /// In en, this message translates to:
  /// **'You reached {reached}'**
  String smReached(Object reached);

  /// No description provided for @smRule1.
  ///
  /// In en, this message translates to:
  /// **'Watch the tiles light up one by one.'**
  String get smRule1;

  /// No description provided for @smRule2.
  ///
  /// In en, this message translates to:
  /// **'Repeat the exact same order by tapping the tiles.'**
  String get smRule2;

  /// No description provided for @smRule3.
  ///
  /// In en, this message translates to:
  /// **'Each round adds one more step — see how far you can go.'**
  String get smRule3;

  /// No description provided for @smRound.
  ///
  /// In en, this message translates to:
  /// **'Round {round}'**
  String smRound(Object round);

  /// No description provided for @safetyScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Is this right for me?'**
  String get safetyScreenTitle;

  /// No description provided for @safetyPracticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Rung is practice, not therapy.'**
  String get safetyPracticeTitle;

  /// No description provided for @safetyIntro.
  ///
  /// In en, this message translates to:
  /// **'Rung is a confidence and practice tool. It helps you face everyday social situations gradually, at your own pace. It is not therapy, not a medical treatment, and not a diagnosis.'**
  String get safetyIntro;

  /// No description provided for @safetyPoint1.
  ///
  /// In en, this message translates to:
  /// **'The goal is manageable dread — feeling more comfortable in the moments you used to avoid. Not becoming a different person.'**
  String get safetyPoint1;

  /// No description provided for @safetyPoint2.
  ///
  /// In en, this message translates to:
  /// **'Skipping is always okay and never counts against you. There are no shame mechanics here.'**
  String get safetyPoint2;

  /// No description provided for @safetyPoint3.
  ///
  /// In en, this message translates to:
  /// **'Your data is yours. Everything works offline, with no account required.'**
  String get safetyPoint3;

  /// No description provided for @safetyMoreTitle.
  ///
  /// In en, this message translates to:
  /// **'If this is more than nerves'**
  String get safetyMoreTitle;

  /// No description provided for @safetyMoreBody.
  ///
  /// In en, this message translates to:
  /// **'If anxiety is severely affecting your daily life, or you ever have thoughts of harming yourself, please reach out to a qualified professional or a local crisis line. That is a strong, healthy step — and Rung is not a substitute for it.'**
  String get safetyMoreBody;

  /// No description provided for @legalLastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last updated: June 2026'**
  String get legalLastUpdated;

  /// No description provided for @legalQuestions.
  ///
  /// In en, this message translates to:
  /// **'Questions? Contact us at {email}.'**
  String legalQuestions(String email);

  /// No description provided for @privacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyTitle;

  /// No description provided for @privacyIntro.
  ///
  /// In en, this message translates to:
  /// **'Rung is a private practice tool for building social confidence. We collect as little as possible, and the most personal things you write never leave your phone. This policy explains what we store and why.'**
  String get privacyIntro;

  /// No description provided for @ppWhatStaysHead.
  ///
  /// In en, this message translates to:
  /// **'What stays only on your device'**
  String get ppWhatStaysHead;

  /// No description provided for @ppWhatStaysBody.
  ///
  /// In en, this message translates to:
  /// **'Your reflection notes and prediction notes — the private things you write about how a moment felt — are stored only in the app on your device. They are never uploaded to our servers.'**
  String get ppWhatStaysBody;

  /// No description provided for @ppCloudHead.
  ///
  /// In en, this message translates to:
  /// **'What we store in the cloud'**
  String get ppCloudHead;

  /// No description provided for @ppCloudBody.
  ///
  /// In en, this message translates to:
  /// **'When you create an account we store: your email address (for sign-in; your password is encrypted and we never see it), an optional display name and bio, and your privacy-lock setting. To run the community (“pods”) we store the messages you post and any blocks or reports you make. To keep your progress safe across devices we back up numbers only — your streak, challenges completed, and anxiety ratings (predicted vs actual) — plus any custom steps you create. Note text is never included.'**
  String get ppCloudBody;

  /// No description provided for @ppAnalyticsHead.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get ppAnalyticsHead;

  /// No description provided for @ppAnalyticsBody.
  ///
  /// In en, this message translates to:
  /// **'We use privacy-respecting product analytics (PostHog) to understand which features help — anonymous usage events like “opened a screen” or “completed a step”, never the content of your notes or messages. It is off by default and only runs if you turn it on in Settings; you can turn it off again at any time.'**
  String get ppAnalyticsBody;

  /// No description provided for @ppUseHead.
  ///
  /// In en, this message translates to:
  /// **'How we use your information'**
  String get ppUseHead;

  /// No description provided for @ppUseBody.
  ///
  /// In en, this message translates to:
  /// **'Only to provide the app: to sign you in, run the pods, restore your progress, and improve Rung using aggregate, anonymous trends. We do not sell your data or use it for advertising.'**
  String get ppUseBody;

  /// No description provided for @ppProcessHead.
  ///
  /// In en, this message translates to:
  /// **'Who processes your data'**
  String get ppProcessHead;

  /// No description provided for @ppProcessBody.
  ///
  /// In en, this message translates to:
  /// **'We use Supabase (authentication, database, and hosting) and PostHog (analytics) as data processors. They handle data on our behalf under their own security and privacy commitments.'**
  String get ppProcessBody;

  /// No description provided for @ppRightsHead.
  ///
  /// In en, this message translates to:
  /// **'Your rights & choices'**
  String get ppRightsHead;

  /// No description provided for @ppRightsBody.
  ///
  /// In en, this message translates to:
  /// **'You can edit your profile, lock it so other members can’t see it, and permanently delete your account and all associated cloud data at any time from Profile → Delete account. You can also email us to request access to or deletion of your data.'**
  String get ppRightsBody;

  /// No description provided for @ppSecurityHead.
  ///
  /// In en, this message translates to:
  /// **'Security & retention'**
  String get ppSecurityHead;

  /// No description provided for @ppSecurityBody.
  ///
  /// In en, this message translates to:
  /// **'Data is encrypted in transit, and every table is protected by row-level security so you can only ever access your own data (and pod messages you’re a member of). We keep your data until you delete your account or ask us to remove it.'**
  String get ppSecurityBody;

  /// No description provided for @ppChildrenHead.
  ///
  /// In en, this message translates to:
  /// **'Children'**
  String get ppChildrenHead;

  /// No description provided for @ppChildrenBody.
  ///
  /// In en, this message translates to:
  /// **'Rung is not intended for anyone under 16. If you believe a child has created an account, contact us and we will remove it.'**
  String get ppChildrenBody;

  /// No description provided for @ppMedicalHead.
  ///
  /// In en, this message translates to:
  /// **'Not medical care'**
  String get ppMedicalHead;

  /// No description provided for @ppMedicalBody.
  ///
  /// In en, this message translates to:
  /// **'Rung supports gradual practice but is not therapy, diagnosis, or medical advice. If you are in crisis, contact your local emergency services or a crisis line.'**
  String get ppMedicalBody;

  /// No description provided for @ppChangesHead.
  ///
  /// In en, this message translates to:
  /// **'Changes'**
  String get ppChangesHead;

  /// No description provided for @ppChangesBody.
  ///
  /// In en, this message translates to:
  /// **'If we update this policy we’ll change the date above and, for material changes, let you know in the app.'**
  String get ppChangesBody;

  /// No description provided for @termsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsTitle;

  /// No description provided for @termsIntro.
  ///
  /// In en, this message translates to:
  /// **'These terms are the agreement between you and Rung when you use the app. By creating an account or using Rung, you agree to them.'**
  String get termsIntro;

  /// No description provided for @tosMedicalHead.
  ///
  /// In en, this message translates to:
  /// **'Not a medical service'**
  String get tosMedicalHead;

  /// No description provided for @tosMedicalBody.
  ///
  /// In en, this message translates to:
  /// **'Rung is a self-help practice tool, not therapy or medical care, and does not replace professional help. It cannot guarantee any particular outcome. If you are in crisis or may harm yourself or others, contact your local emergency services immediately.'**
  String get tosMedicalBody;

  /// No description provided for @tosEligibilityHead.
  ///
  /// In en, this message translates to:
  /// **'Eligibility'**
  String get tosEligibilityHead;

  /// No description provided for @tosEligibilityBody.
  ///
  /// In en, this message translates to:
  /// **'You must be at least 16 years old to use Rung and have the right to agree to these terms.'**
  String get tosEligibilityBody;

  /// No description provided for @tosAccountHead.
  ///
  /// In en, this message translates to:
  /// **'Your account'**
  String get tosAccountHead;

  /// No description provided for @tosAccountBody.
  ///
  /// In en, this message translates to:
  /// **'Keep your login details safe — you’re responsible for activity on your account. Tell us promptly if you suspect unauthorised use.'**
  String get tosAccountBody;

  /// No description provided for @tosCommunityHead.
  ///
  /// In en, this message translates to:
  /// **'Community rules (pods)'**
  String get tosCommunityHead;

  /// No description provided for @tosCommunityBody.
  ///
  /// In en, this message translates to:
  /// **'Pods are for kindness and support. You agree not to harass, threaten, demean, spam, or post hateful or illegal content, and not to share other people’s private information. We may remove content or suspend accounts that break these rules. You can block and report other members at any time.'**
  String get tosCommunityBody;

  /// No description provided for @tosContentHead.
  ///
  /// In en, this message translates to:
  /// **'Content you post'**
  String get tosContentHead;

  /// No description provided for @tosContentBody.
  ///
  /// In en, this message translates to:
  /// **'You keep ownership of what you write. By posting in a pod you grant us permission to store and show it to the members of that pod so the community works. Don’t post anything you don’t have the right to share.'**
  String get tosContentBody;

  /// No description provided for @tosSubsHead.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions'**
  String get tosSubsHead;

  /// No description provided for @tosSubsBody.
  ///
  /// In en, this message translates to:
  /// **'Some features and extra practice content are available with a paid subscription. When billing is live, purchases and renewals are handled by the app store, and you can manage or cancel through your app-store account. Prices and inclusions may change with notice.'**
  String get tosSubsBody;

  /// No description provided for @tosDisclaimerHead.
  ///
  /// In en, this message translates to:
  /// **'Disclaimers & liability'**
  String get tosDisclaimerHead;

  /// No description provided for @tosDisclaimerBody.
  ///
  /// In en, this message translates to:
  /// **'Rung is provided “as is”, without warranties of any kind. To the fullest extent permitted by law, we are not liable for indirect or consequential losses arising from your use of the app.'**
  String get tosDisclaimerBody;

  /// No description provided for @tosEndingHead.
  ///
  /// In en, this message translates to:
  /// **'Ending your use'**
  String get tosEndingHead;

  /// No description provided for @tosEndingBody.
  ///
  /// In en, this message translates to:
  /// **'You can delete your account at any time from Profile → Delete account. We may suspend or end access if these terms are seriously or repeatedly broken.'**
  String get tosEndingBody;

  /// No description provided for @tosChangesHead.
  ///
  /// In en, this message translates to:
  /// **'Changes'**
  String get tosChangesHead;

  /// No description provided for @tosChangesBody.
  ///
  /// In en, this message translates to:
  /// **'We may update these terms; we’ll update the date above and, for significant changes, notify you in the app. Continuing to use Rung means you accept the updated terms.'**
  String get tosChangesBody;

  /// No description provided for @breatheCta.
  ///
  /// In en, this message translates to:
  /// **'Feeling the dread? Breathe first'**
  String get breatheCta;

  /// No description provided for @breatheIntro.
  ///
  /// In en, this message translates to:
  /// **'Sixty seconds. Just follow the circle.'**
  String get breatheIntro;

  /// No description provided for @breatheIn.
  ///
  /// In en, this message translates to:
  /// **'Breathe in'**
  String get breatheIn;

  /// No description provided for @breatheHold.
  ///
  /// In en, this message translates to:
  /// **'Hold'**
  String get breatheHold;

  /// No description provided for @breatheOut.
  ///
  /// In en, this message translates to:
  /// **'Breathe out'**
  String get breatheOut;

  /// No description provided for @breatheSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get breatheSkip;

  /// No description provided for @breatheDoneTitle.
  ///
  /// In en, this message translates to:
  /// **'That’s it.'**
  String get breatheDoneTitle;

  /// No description provided for @breatheDoneSub.
  ///
  /// In en, this message translates to:
  /// **'Feel a little steadier? Go do your rung whenever you’re ready.'**
  String get breatheDoneSub;

  /// No description provided for @breatheDoneBtn.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get breatheDoneBtn;

  /// No description provided for @insightsDeeperTitle.
  ///
  /// In en, this message translates to:
  /// **'Deeper insights'**
  String get insightsDeeperTitle;

  /// No description provided for @insightsLockedBody.
  ///
  /// In en, this message translates to:
  /// **'See your month at a glance — how much your fear ran hotter than reality, and how often you over-predicted it. A Premium perk.'**
  String get insightsLockedBody;

  /// No description provided for @insightsUnlockCta.
  ///
  /// In en, this message translates to:
  /// **'Unlock with Premium'**
  String get insightsUnlockCta;

  /// No description provided for @insightsNoSteps.
  ///
  /// In en, this message translates to:
  /// **'No steps logged yet this month. Face a couple and your summary appears here.'**
  String get insightsNoSteps;

  /// No description provided for @insightsFearsFacedMonth.
  ///
  /// In en, this message translates to:
  /// **'fears faced this month'**
  String get insightsFearsFacedMonth;

  /// No description provided for @insightsGapHotter.
  ///
  /// In en, this message translates to:
  /// **'Your fear ran {points} points hotter than reality, on average.'**
  String insightsGapHotter(String points);

  /// No description provided for @insightsGapTougher.
  ///
  /// In en, this message translates to:
  /// **'Reality was a bit tougher than you predicted this month — that\'s brave data too.'**
  String get insightsGapTougher;

  /// No description provided for @insightsGapSpotOn.
  ///
  /// In en, this message translates to:
  /// **'Your predictions were about spot-on this month.'**
  String get insightsGapSpotOn;

  /// No description provided for @insightsOverPredicted.
  ///
  /// In en, this message translates to:
  /// **'You over-predicted the fear {rate}% of the time.'**
  String insightsOverPredicted(int rate);

  /// No description provided for @insightsTrendSame.
  ///
  /// In en, this message translates to:
  /// **'Same as last month'**
  String get insightsTrendSame;

  /// No description provided for @insightsTrendMore.
  ///
  /// In en, this message translates to:
  /// **'{count} more than last month'**
  String insightsTrendMore(int count);

  /// No description provided for @insightsTrendFewer.
  ///
  /// In en, this message translates to:
  /// **'{count} fewer than last month'**
  String insightsTrendFewer(int count);

  /// No description provided for @rateTitle.
  ///
  /// In en, this message translates to:
  /// **'Enjoying Rung?'**
  String get rateTitle;

  /// No description provided for @ratePromptNone.
  ///
  /// In en, this message translates to:
  /// **'How is Rung feeling for you?'**
  String get ratePromptNone;

  /// No description provided for @ratePromptLow.
  ///
  /// In en, this message translates to:
  /// **'We\'re sorry it\'s not landing. What\'s missing?'**
  String get ratePromptLow;

  /// No description provided for @ratePromptMid.
  ///
  /// In en, this message translates to:
  /// **'Thanks — what would make it a 5?'**
  String get ratePromptMid;

  /// No description provided for @ratePromptHigh.
  ///
  /// In en, this message translates to:
  /// **'That means a lot. What do you love?'**
  String get ratePromptHigh;

  /// No description provided for @rateHintLove.
  ///
  /// In en, this message translates to:
  /// **'Anything you love? (optional)'**
  String get rateHintLove;

  /// No description provided for @rateHintMore.
  ///
  /// In en, this message translates to:
  /// **'Tell us more (optional)'**
  String get rateHintMore;

  /// No description provided for @rateSend.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get rateSend;

  /// No description provided for @rateThanksHigh.
  ///
  /// In en, this message translates to:
  /// **'Thank you — it truly helps. 🌱'**
  String get rateThanksHigh;

  /// No description provided for @rateThanksLow.
  ///
  /// In en, this message translates to:
  /// **'Thank you for the honesty — we\'ll use it to improve.'**
  String get rateThanksLow;

  /// No description provided for @editProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editProfileTitle;

  /// No description provided for @editDisplayName.
  ///
  /// In en, this message translates to:
  /// **'Display name'**
  String get editDisplayName;

  /// No description provided for @editDisplayNameHint.
  ///
  /// In en, this message translates to:
  /// **'What should pods call you?'**
  String get editDisplayNameHint;

  /// No description provided for @editBio.
  ///
  /// In en, this message translates to:
  /// **'Short bio (optional)'**
  String get editBio;

  /// No description provided for @editBioHint.
  ///
  /// In en, this message translates to:
  /// **'A line about you — kept private if you lock your profile.'**
  String get editBioHint;

  /// No description provided for @errorOffline.
  ///
  /// In en, this message translates to:
  /// **'You\'re offline. Connect to the internet and try again.'**
  String get errorOffline;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorGeneric;

  /// No description provided for @errorSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t save — your device may be low on storage. Free up space and try again.'**
  String get errorSaveFailed;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'da',
    'de',
    'en',
    'es',
    'fr',
    'id',
    'it',
    'ja',
    'ko',
    'ms',
    'nb',
    'nl',
    'pl',
    'pt',
    'sv',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'PT':
            return AppLocalizationsPtPt();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'da':
      return AppLocalizationsDa();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'id':
      return AppLocalizationsId();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'ms':
      return AppLocalizationsMs();
    case 'nb':
      return AppLocalizationsNb();
    case 'nl':
      return AppLocalizationsNl();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'sv':
      return AppLocalizationsSv();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
