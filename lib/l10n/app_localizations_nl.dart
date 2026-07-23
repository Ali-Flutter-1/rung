// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get navHome => 'Start';

  @override
  String get navGroups => 'Groepen';

  @override
  String get navPremium => 'Premium';

  @override
  String get navProfile => 'Profiel';

  @override
  String get greetingMorning => 'Goedemorgen';

  @override
  String get greetingAfternoon => 'Goedemiddag';

  @override
  String get greetingEvening => 'Goedenavond';

  @override
  String get todayStepIntro => 'Hier is één kleine stap voor vandaag.';

  @override
  String get commonContinue => 'Doorgaan';

  @override
  String get commonCancel => 'Annuleren';

  @override
  String get commonSave => 'Opslaan';

  @override
  String get commonDone => 'Klaar';

  @override
  String get commonNotNow => 'Niet nu';

  @override
  String get profileTitle => 'Profiel';

  @override
  String get language => 'Taal';

  @override
  String get languageSystemDefault => 'Systeemtaal';

  @override
  String get yourTone => 'Je toon';

  @override
  String get appearance => 'Weergave';

  @override
  String get themeSystem => 'Systeem';

  @override
  String get themeLight => 'Licht';

  @override
  String get themeDark => 'Donker';

  @override
  String get onbSkip => 'Overslaan';

  @override
  String get onbWelcomeTitle =>
      'Ga de momenten aan die je vroeger vreesde — één kleine stap tegelijk.';

  @override
  String get onbWelcomeBody =>
      'Rung helpt je sociaal zelfvertrouwen op te bouwen met zachte, private oefening. Voorspel, doe het, reflecteer — en zie je ergste angsten uiteenvallen in je eigen cijfers.';

  @override
  String get onbGetStarted => 'Aan de slag';

  @override
  String get onbSafetyTitle => 'Oefening, geen therapie.';

  @override
  String get onbUnderstand => 'Ik begrijp het';

  @override
  String get onbSafetyBody1 =>
      'Rung is een hulpmiddel voor zelfvertrouwen en oefening — geen therapie, geen medische behandeling en geen diagnose.';

  @override
  String get onbSafetyBody2 =>
      'Het doel is je prettiger voelen in momenten die je vroeger vreesde — niet iemand worden die je niet bent. Overslaan mag altijd.';

  @override
  String get onbSafetyCrisis =>
      'Als angst je leven ernstig beïnvloedt, of als je ooit gedachten hebt om jezelf pijn te doen, neem dan contact op met een professional of een lokale crisislijn.';

  @override
  String get onbFearTitle => 'Waar wil je beginnen?';

  @override
  String get onbFearBody =>
      'Gewoon als suggestie voor een eerste stap — je kunt elk van deze op elk moment beklimmen. Niets legt je hier vast.';

  @override
  String get onbExploreOwn => 'Ik verken liever zelf';

  @override
  String get onbToneTitle => 'Wat past het best bij jou?';

  @override
  String get onbToneIntrovertTitle => 'Ik ben eerder een introvert';

  @override
  String get onbToneIntrovertBody =>
      'Ik wil me op mijn gemak voelen, geen ander mens worden.';

  @override
  String get onbToneSituationalTitle => 'Ik word in bepaalde situaties angstig';

  @override
  String get onbToneSituationalBody =>
      'Soms ben ik uitbundig, maar bepaalde momenten brengen me van slag.';

  @override
  String get onbToneFootnote =>
      'Je kunt dit op elk moment wijzigen in Profiel.';

  @override
  String get onbHowTitle => 'Zo werkt het.';

  @override
  String get onbStartClimbing => 'Begin met klimmen';

  @override
  String get onbStep1 => 'Voorspel hoe erg het zal voelen (0–10).';

  @override
  String get onbStep2 => 'Doe het in het echt — de app mag dicht.';

  @override
  String get onbStep3 => 'Kom terug en noteer hoe het echt ging.';

  @override
  String get onbGentleFirstStep => 'EEN ZACHTE EERSTE STAP';

  @override
  String get onbGoodPlaceToStart => 'EEN GOEDE PLEK OM TE BEGINNEN';

  @override
  String get onbAllAreas =>
      'Alle zes gebieden staan op je startscherm — begin waar je wilt.';

  @override
  String get predictAppBar => 'Voordat je gaat';

  @override
  String get predictSaved =>
      'Opgeslagen. Ga het doen — kom daarna terug om te noteren hoe het ging.';

  @override
  String get predictQuestion => 'Hoe erg denk je dat dit wordt?';

  @override
  String get predictNoteLabel => 'Wat verwacht je dat er gebeurt? (optioneel)';

  @override
  String get predictNoteHint => 'bijv. Ze zullen me onhandig vinden';

  @override
  String get predictCompare =>
      'We vergelijken dit met hoe het echt gaat. Die kloof is waar het om draait.';

  @override
  String get predictDoIt => 'Ik ga het doen';

  @override
  String get reflectAppBar => 'Hoe ging het?';

  @override
  String get reflectDidYouDoIt => 'Heb je het gedaan?';

  @override
  String get reflectHowAnxious =>
      'Hoe angstig voelde alleen al de gedachte eraan?';

  @override
  String get reflectHowBad => 'Hoe erg was het echt?';

  @override
  String get reflectNoteLabel => 'Iets wat je wilt onthouden? (optioneel)';

  @override
  String get reflectOutcomeDone => 'Gedaan';

  @override
  String get reflectOutcomePartial => 'Deels';

  @override
  String get reflectOutcomeNotToday => 'Niet vandaag';

  @override
  String get resultQuietDelight => 'Stille vreugde in elke stap.';

  @override
  String get resultBackToLadder => 'Terug naar ladder';

  @override
  String resultGapHeadline(int predicted, int actual) {
    return 'Je hield rekening met $predicted. Het werd $actual.';
  }

  @override
  String resultGapSub(int predicted, int actual) {
    return 'Je hart bereidde zich voor op een zware $predicted, maar de wereld ontving je met een zachtere $actual. Het onthouden waard.';
  }

  @override
  String get resultRightHeadline => 'Precies zoals je gokte.';

  @override
  String get resultRightSub =>
      'Je had het goed — en je kwam toch opdagen. Dat is de winst.';

  @override
  String get resultTougherHeadline => 'Zwaarder dan je dacht — en je deed het.';

  @override
  String get resultTougherSub =>
      'Sommige momenten vragen meer van ons. Toch opdagen is waar het om draait.';

  @override
  String get resultPredicted => 'Voorspeld';

  @override
  String get resultActual => 'Werkelijk';

  @override
  String resultLighter(int reduction) {
    return 'Dit moment was $reduction% lichter dan je vreesde';
  }

  @override
  String get resultSkippedHeadline => 'Genoteerd — geen druk.';

  @override
  String get resultSkippedSub =>
      '«Niet vandaag» is een prima antwoord. Deze sport staat hier nog wanneer je zover bent.';

  @override
  String get resultWinCopied =>
      'Overwinning gekopieerd — plak het waar je wilt.';

  @override
  String get resultCopyWin => 'Kopieer mijn overwinning';

  @override
  String resultShareText(String rung) {
    return 'Ik deed net iets wat ik altijd vermeed: $rung. Eén kleine sport beklommen. 🪜 #Rung';
  }

  @override
  String get tracksTitle => 'Jouw trajecten';

  @override
  String get tracksSubtitle => 'Kleine stappen naar groot zelfvertrouwen.';

  @override
  String get menuInsights => 'Inzichten';

  @override
  String get menuIsThisRight => 'Is dit iets voor mij?';

  @override
  String tracksRungsCount(int done, int total) {
    return '$done van $total sporten';
  }

  @override
  String tracksClimbedCount(int done, int total) {
    return '$done van $total beklommen';
  }

  @override
  String get tracksContinueLabel => 'GA VERDER WAAR JE GEBLEVEN WAS';

  @override
  String get tracksNextStepLabel => 'JOUW VOLGENDE STAP';

  @override
  String get tracksLoadError => 'Kon trajecten niet laden.';

  @override
  String get todayResume => 'Ga verder waar je gebleven was';

  @override
  String get todayNext => 'Jouw volgende stap';

  @override
  String get todayVariety => 'Iets anders';

  @override
  String get todayFresh => 'Jouw startpunt';

  @override
  String get todayResumeCta => 'Noteren afmaken';

  @override
  String get todayStartCta => 'Beginnen';

  @override
  String todayMinutes(int min) {
    return '~$min min';
  }

  @override
  String get dashShareTooltip => 'Deel mijn voortgang';

  @override
  String get dashWeeklyGoal => 'Weekdoel';

  @override
  String dashStepsPerWeek(int count) {
    return '$count stappen/week';
  }

  @override
  String dashGoalPerWeek(int count) {
    return '$count/week';
  }

  @override
  String dashWeeklyProgress(int done, int goal) {
    return '$done van $goal stappen deze week voltooid';
  }

  @override
  String get dashYourGrowth => 'Jouw groei';

  @override
  String get dashTodayError =>
      'Kon de stap van vandaag niet laden. Trek om opnieuw te proberen.';

  @override
  String get dashTodayAllClear =>
      'Je hebt alles beschikbare afgerond — voeg een eigen sport toe of bekijk er een opnieuw om je reeks door te zetten.';

  @override
  String get dashTakeABreak => 'Neem een pauze';

  @override
  String get dashTakeABreakSub =>
      'Een paar rustige spellen — tegen de telefoon of met een vriend.';

  @override
  String get ladderTitleFallback => 'Ladder';

  @override
  String get ladderLoadError => 'Kon ladder niet laden.';

  @override
  String get ladderAddOwn => 'Voeg je eigen sport toe';

  @override
  String ladderOfClimbed(int total) {
    return 'van $total beklommen';
  }

  @override
  String get detailLoadError => 'Kon niet laden.';

  @override
  String get detailNotExist => 'Deze sport bestaat niet meer.';

  @override
  String get detailWhatToDo => 'Wat te doen';

  @override
  String get detailWhyHelps => 'Waarom dit helpt';

  @override
  String get detailPastAttempts => 'Je eerdere pogingen';

  @override
  String get detailDoThis => 'Ik ga dit doen';

  @override
  String get detailReattempt =>
      'Opnieuw proberen wordt aangemoedigd — het bouwt je gegevens op.';

  @override
  String detailHistoryStat(int predicted, int actual) {
    return 'voorspeld $predicted · werkelijk $actual';
  }

  @override
  String customLimitPremium(int cap) {
    return 'Je hebt de limiet van deze maand van $cap eigen sporten bereikt — die wordt volgende maand gereset.';
  }

  @override
  String get customLimitFree =>
      'Het gratis plan bevat 5 eigen sporten — upgrade voor meer per maand.';

  @override
  String get customDefaultWhat => 'Een uitdaging die je jezelf oplegt.';

  @override
  String get customDefaultWhy =>
      'Jij hebt dit benoemd — dat maakt het belangrijk.';

  @override
  String get customSubtitle =>
      'Jouw situatie is specifiek — deze sport is alleen voor jou.';

  @override
  String get customWhatLabel => 'Wat ga je doen?';

  @override
  String get customWhatHint => 'bijv. Mijn manager om feedback vragen';

  @override
  String get customNoteLabel => 'Een notitie voor jezelf (optioneel)';

  @override
  String customDifficulty(int value) {
    return 'Hoe moeilijk voelt het? $value/10';
  }

  @override
  String get customAddToLadder => 'Aan ladder toevoegen';

  @override
  String get paywallSwitchToFree => 'Overschakelen naar Gratis';

  @override
  String get paywallHeroTitle => 'Je hoeft het niet alleen aan te gaan.';

  @override
  String get paywallHeroBody =>
      'De dagelijkse oefening is altijd gratis. Premium voegt een private coach aan jouw kant toe — en een grotere gemeenschap naast je — voor als je klaar bent om verder te gaan.';

  @override
  String get paywallWhatsIncluded => 'Wat is inbegrepen';

  @override
  String get paywallPlusHeader => 'Bovendien krijgt elke abonnee';

  @override
  String get paywallBenefitCoach =>
      'Een private coach, wanneer je wilt — oefen iets wat eraan komt of praat na over hoe het ging';

  @override
  String get paywallBenefitPods =>
      'Je doet dit niet alleen — sluit je aan bij meer steun-pods (3 bij maandelijks, onbeperkt bij jaarlijks)';

  @override
  String get paywallBenefitCustom =>
      'Bouw onbeperkt eigen ladders — geen limiet op eigen sporten';

  @override
  String get paywallBenefitDepth =>
      'Ga dieper wanneer je klaar bent — tot 40 stappen per traject (gratis is een volledige boog van 10 stappen)';

  @override
  String get paywallPlusStreak =>
      'Reeksbescherming — een gemiste dag breekt je reeks niet';

  @override
  String get paywallPlusInsights =>
      'Diepere inzichten — je maand in één oogopslag';

  @override
  String get paywallPlusShare => 'Persoonlijke stijlen voor deelkaarten';

  @override
  String get paywallPlusPrivacy => 'Altijd privé, altijd reclamevrij';

  @override
  String get paywallYearly => 'Jaarlijks';

  @override
  String get paywallPerYear => 'per jaar · beste waarde';

  @override
  String get paywallSave => 'Bespaar 33%';

  @override
  String get paywallMonthly => 'Maandelijks';

  @override
  String get paywallPerMonth => 'per maand';

  @override
  String get paywallSwitchYearly => 'Overschakelen naar jaarlijks';

  @override
  String get paywallSwitchMonthly => 'Overschakelen naar maandelijks';

  @override
  String paywallStartYearly(String price) {
    return 'Start jaarlijks — $price';
  }

  @override
  String paywallStartMonthly(String price) {
    return 'Start maandelijks — $price';
  }

  @override
  String get paywallRestore => 'Aankopen herstellen';

  @override
  String paywallCurrentPlan(String plan) {
    return 'Huidig plan: $plan. Altijd opzegbaar.';
  }

  @override
  String get paywallCancelAnytime =>
      'Altijd opzegbaar. De kernervaring blijft voor altijd gratis.';

  @override
  String get paywallSimulated =>
      'Premium actief (gesimuleerd — voeg RevenueCat-sleutels toe voor echte aankopen).';

  @override
  String get paywallPlanUnavailable =>
      'Dat plan is nu niet beschikbaar. Probeer het zo weer.';

  @override
  String get paywallThankYou => 'Premium actief — bedankt. 🌱';

  @override
  String get paywallPurchaseFailed =>
      'De aankoop is niet voltooid. Er is niets in rekening gebracht.';

  @override
  String get paywallRestored => 'Aankopen hersteld.';

  @override
  String get paywallNoRestore =>
      'Geen eerdere aankopen gevonden op dit account.';

  @override
  String get paywallRestoreFailed =>
      'Kon nu niet herstellen. Probeer het zo weer.';

  @override
  String get profileAddName => 'Voeg je naam toe';

  @override
  String get profileLockTitle => 'Mijn profiel vergrendelen';

  @override
  String get profileLockedSub =>
      'Verborgen — pod-leden kunnen je details niet openen.';

  @override
  String get profileUnlockedSub =>
      'Pod-leden kunnen op je avatar tikken om je details te zien.';

  @override
  String get profilePlanTitle => 'Jouw plan';

  @override
  String get profilePremium => 'Premium';

  @override
  String get profileUpgrade => 'Upgraden';

  @override
  String get profileToneDesc =>
      'Rung spreekt standaard zacht. Als jouw angst meer situationeel is, past een iets stelliger toon misschien beter bij je.';

  @override
  String get profileToneIntrovert => 'Introvert';

  @override
  String get profileToneSituational => 'Situationeel';

  @override
  String get profileSafetySub => 'Hoe Rung past — en wanneer meer te zoeken';

  @override
  String get profileBlockedTitle => 'Geblokkeerde leden';

  @override
  String get profileBlockedSub =>
      'Bekijk en deblokkeer mensen die je hebt geblokkeerd';

  @override
  String get profileRestoreTitle => 'Mijn voortgang herstellen';

  @override
  String get profileRestoreSub => 'Haal je reeks en uitdagingen uit de cloud';

  @override
  String get profileRestoring => 'Herstellen…';

  @override
  String get profileRestoreOk => 'Voortgang hersteld uit de cloud.';

  @override
  String profileRestoreFail(String error) {
    return 'Herstellen mislukt: $error';
  }

  @override
  String get profileLogout => 'Uitloggen';

  @override
  String get profileChangePwTitle => 'Wachtwoord wijzigen';

  @override
  String get profileChangePwSub =>
      'Stel een nieuw wachtwoord in voor je account';

  @override
  String get profileChangePwSaved => 'Wachtwoord bijgewerkt';

  @override
  String get profileSignedIn => 'Ingelogd';

  @override
  String get profileLogoutConfirmTitle => 'Uitloggen?';

  @override
  String get profileLogoutConfirmBody =>
      'Je voortgang is opgeslagen in de cloud en komt terug wanneer je opnieuw inlogt.';

  @override
  String get profileLoggingOut => 'Uitloggen…';

  @override
  String get profileRateTitle => 'Beoordeel Rung';

  @override
  String get profileRateSub => 'Vertel ons hoe het gaat — het helpt echt';

  @override
  String get profilePrivacyTitle => 'Privacybeleid';

  @override
  String get profilePrivacySub =>
      'Wat we opslaan — en wat op je apparaat blijft';

  @override
  String get profileTermsTitle => 'Servicevoorwaarden';

  @override
  String get profileTermsSub => 'De overeenkomst voor het gebruik van Rung';

  @override
  String get profileDeleteTitle => 'Account verwijderen';

  @override
  String get profileDeleteSub => 'Wis je account en gegevens permanent';

  @override
  String get profileFooter =>
      'Rung · oefening, geen therapie. Jouw gegevens zijn van jou.';

  @override
  String get profileDeleteConfirmTitle => 'Account verwijderen?';

  @override
  String get profileDeleteConfirmBody =>
      'Dit verwijdert permanent je account, je pod-berichten en je opgeslagen voortgang. Dit kan niet ongedaan worden gemaakt.';

  @override
  String get profileDelete => 'Verwijderen';

  @override
  String get profileDeleting => 'Je account verwijderen…';

  @override
  String get profileDeleteFail =>
      'Kon je account niet verwijderen. Probeer opnieuw.';

  @override
  String get profileBioPlaceholder => 'Een stille klimmer.';

  @override
  String get profileHaptics => 'Trillingen';

  @override
  String get profileHapticsSub => 'Zachte trilling bij tikken en overwinningen';

  @override
  String get profileAnalytics => 'Anonieme gebruiksgegevens delen';

  @override
  String get profileAnalyticsSub =>
      'Helpt Rung te verbeteren. Nooit persoonlijke gegevens.';

  @override
  String get profileNotifications => 'Meldingen';

  @override
  String get profileNotificationsSub => 'Meldingen van Rung op dit apparaat';

  @override
  String get profilePodAlerts => 'Pod-berichtmeldingen';

  @override
  String get profilePodAlertsSub =>
      'Laat het me weten als iemand in mijn pods post';

  @override
  String get profileEnableNotifs =>
      'Schakel meldingen in bij Instellingen om herinneringen te krijgen.';

  @override
  String get profileReminderHelp => 'Wanneer zullen we je een zetje geven?';

  @override
  String get profileReminderTitle => 'Zachte dagelijkse herinnering';

  @override
  String profileReminderOn(String time) {
    return 'Elke dag om $time · tik op de schakelaar om uit te zetten';
  }

  @override
  String get profileReminderOff =>
      'Een kalm, schuldvrij zetje om één kleine stap te zetten';

  @override
  String get profileAvatarTitle => 'Kies je avatar';

  @override
  String get profileAvatarSub =>
      'Alleen jij kunt het wijzigen — je pod-maten zien het ook.';

  @override
  String get commonClose => 'Sluiten';

  @override
  String get checkInMoodCalm => 'Kalm';

  @override
  String get checkInMoodOkay => 'Oké';

  @override
  String get checkInMoodAnxious => 'Angstig';

  @override
  String get checkInMoodLow => 'Somber';

  @override
  String get checkInMoodTense => 'Gespannen';

  @override
  String get checkInTitle => 'Hoe kom je vandaag aan?';

  @override
  String get checkInDismiss => 'Sluiten';

  @override
  String get checkInCalmCta => 'Probeer een kalm moment';

  @override
  String get checkInStepCta => 'Bekijk de stap van vandaag';

  @override
  String get supportTitle => 'Dit klinkt als veel om te dragen.';

  @override
  String get supportBody =>
      'Rung is een oefenhulpmiddel, geen crisisdienst. Als je iets zwaars doormaakt, neem dan contact op met iemand die je nu kan helpen — een vertrouwd persoon of een lokale crisislijn. Je verdient echte steun.';

  @override
  String get supportResources => 'Bekijk steunbronnen';

  @override
  String get progressChallenges => 'Uitdagingen';

  @override
  String get progressCurrentStreak => 'Huidige reeks';

  @override
  String get progressBestStreak => 'Beste reeks';

  @override
  String get progressThisWeek => 'Deze week';

  @override
  String get progressCategoryBreakdown => 'Uitsplitsing per categorie';

  @override
  String get insightsHistory => 'Geschiedenis';

  @override
  String checkInAckTitle(String mood) {
    return 'Ingecheckt — je voelt je $mood';
  }

  @override
  String get checkInAckGentle =>
      'Bedankt voor je eerlijkheid. Laten we vandaag zacht houden — één kleine, vriendelijke daad is genoeg.';

  @override
  String get checkInAckStep =>
      'Mooi. Wanneer je klaar bent, houdt één kleine stap het momentum vast.';

  @override
  String get sharePremiumPerk =>
      '✨ Meer kaartstijlen zijn een Premium-voordeel.';

  @override
  String get shareSeePremium => 'Bekijk Premium';

  @override
  String get shareText =>
      'Kleine dappere stappen, één sport tegelijk. 🌱 #Rung';

  @override
  String get shareError => 'Kon delen niet openen. Probeer opnieuw.';

  @override
  String get shareTitle => 'Deel je voortgang';

  @override
  String get shareSubtitle => 'Alleen je cijfers — niets privé.';

  @override
  String get shareCta => 'Delen';

  @override
  String get shareCardHeadline => 'Mijn dappere stappen';

  @override
  String get shareCardFearsFaced => 'angsten aangegaan';

  @override
  String get shareCardCurrentStreak => 'Huidige reeks';

  @override
  String get shareCardBestStreak => 'Beste reeks';

  @override
  String get shareCardTagline =>
      'Sociale angsten aangaan, één kleine sport tegelijk.';

  @override
  String get helpNow => 'Hulp nu';

  @override
  String get helpCalmMoment => 'Een kalm moment';

  @override
  String get helpTabBreathe => 'Adem';

  @override
  String get helpTabGround => 'Aarden';

  @override
  String get helpTabSay => 'Zeg dit';

  @override
  String get helpBreatheIn => 'Adem in…';

  @override
  String get helpBreatheOut => 'Adem uit…';

  @override
  String get helpBreatheHint => 'Volg de cirkel. Er is geen haast.';

  @override
  String get helpGround5 => 'dingen die je kunt zien';

  @override
  String get helpGround4 => 'dingen die je kunt aanraken';

  @override
  String get helpGround3 => 'dingen die je kunt horen';

  @override
  String get helpGround2 => 'dingen die je kunt ruiken';

  @override
  String get helpGround1 => 'ding dat je kunt proeven';

  @override
  String get helpGroundTitle => 'Benoem, stilletjes voor jezelf…';

  @override
  String get helpGroundHint =>
      'Dit brengt je terug naar het nu — waar je veilig bent.';

  @override
  String get helpOpener1 => 'Hoe ken jij de mensen hier?';

  @override
  String get helpOpener2 =>
      'Ik vind deze plek geweldig — ben je hier al eens geweest?';

  @override
  String get helpOpener3 =>
      'Ik ben hopeloos met namen — kun je me de jouwe nog eens zeggen?';

  @override
  String get helpOpener4 => 'Wat heb je deze week gedaan?';

  @override
  String get helpExit1 =>
      'Ik ga iets te drinken halen — het was fijn om met je te praten.';

  @override
  String get helpExit2 =>
      'Ik moet even iemand gedag zeggen, sorry, één momentje.';

  @override
  String get helpExit3 => 'Ik laat je verder mingelen — tot straks.';

  @override
  String get helpOpenersTitle => 'Makkelijke openingszinnen';

  @override
  String get helpExitsTitle => 'Sierlijke afscheiden';

  @override
  String get authEnterEmail => 'Voer je e-mail in';

  @override
  String get authBadEmail => 'Deze e-mail lijkt niet te kloppen';

  @override
  String get authEnterPassword => 'Voer een wachtwoord in';

  @override
  String get authMin6 => 'Minstens 6 tekens';

  @override
  String get authPwMismatch => 'Wachtwoorden komen niet overeen';

  @override
  String get authConfirmEmail =>
      'Controleer je e-mail om te bevestigen en log dan in. (Of schakel e-mailbevestiging uit in de Supabase Auth-instellingen om snel te testen.)';

  @override
  String get authGenericError => 'Er ging iets mis. Probeer opnieuw.';

  @override
  String get authCreateTitle => 'Maak je account aan';

  @override
  String get authWelcomeBack => 'Welkom terug';

  @override
  String get authSignUpSub =>
      'Sluit je aan bij de pods en houd je voortgang veilig op al je apparaten.';

  @override
  String get authSignInSub =>
      'Log in bij je pods en gesynchroniseerde voortgang.';

  @override
  String get authDisplayName => 'Weergavenaam (optioneel)';

  @override
  String get authEmail => 'E-mail';

  @override
  String get authPassword => 'Wachtwoord';

  @override
  String get authShowPassword => 'Wachtwoord tonen';

  @override
  String get authHidePassword => 'Wachtwoord verbergen';

  @override
  String get authConfirmPassword => 'Wachtwoord bevestigen';

  @override
  String get authForgotPassword => 'Wachtwoord vergeten?';

  @override
  String get authResetTitle => 'Wachtwoord opnieuw instellen';

  @override
  String get authResetBody =>
      'Voer het e-mailadres van je account in en we sturen je een link om een nieuw wachtwoord in te stellen.';

  @override
  String get authResetSend => 'Link versturen';

  @override
  String get authResetSent =>
      'Als er een account bij dat e-mailadres hoort, is de link al onderweg.';

  @override
  String get authNewPassword => 'Nieuw wachtwoord';

  @override
  String get authConfirmNewPassword => 'Nieuw wachtwoord bevestigen';

  @override
  String get authUpdatePasswordCta => 'Wachtwoord bijwerken';

  @override
  String get authCreateCta => 'Account aanmaken';

  @override
  String get authSignInCta => 'Inloggen';

  @override
  String get authHaveAccount => 'Ik heb al een account';

  @override
  String get authNewAccount => 'Ik ben nieuw — maak een account aan';

  @override
  String get authLegalPrefixSignUp =>
      'Door een account aan te maken ga je akkoord met onze ';

  @override
  String get authLegalPrefixSignIn =>
      'Door verder te gaan ga je akkoord met onze ';

  @override
  String get authTerms => 'Voorwaarden';

  @override
  String get authAnd => ' en ';

  @override
  String get gamesIntro =>
      'Rustige spellen voor focus en een kalme geest — het soort hersentraining dat mensen aardend vinden. Speel tegen de telefoon of geef hem aan een vriend.';

  @override
  String gamesBestMs(int ms) {
    return 'Beste $ms ms';
  }

  @override
  String gamesBestLevel(int level) {
    return 'Beste niveau $level';
  }

  @override
  String gamesBest(String score) {
    return 'Beste $score';
  }

  @override
  String gamesBestMoves(int moves) {
    return 'Beste $moves zetten';
  }

  @override
  String gamesWinsVsPhone(int count) {
    return '$count keer gewonnen van de telefoon';
  }

  @override
  String get gameTitleReaction => 'Reactiesnelheid';

  @override
  String get gameTitleSequence => 'Reeksgeheugen';

  @override
  String get gameTitleQuickMath => 'Snel rekenen';

  @override
  String get gameTitleMemory => 'Memory';

  @override
  String get gameSubReaction => 'focus · tik als het groen wordt';

  @override
  String get gameSubSequence => 'geheugen · kijk en herhaal';

  @override
  String get gameSub2048 => 'strategie · veeg om samen te voegen';

  @override
  String get gameSubQuickMath => 'hoofdrekenen · sprint van 30 seconden';

  @override
  String get gameSubTicTacToe => 'tegen de telefoon · of 2 spelers';

  @override
  String get gameSubConnect4 => 'tegen de telefoon · of 2 spelers';

  @override
  String get gameSubMemory => 'solo · vind de paren';

  @override
  String get gameHelpTooltip => 'Hoe te spelen';

  @override
  String gameHelpTitle(String game) {
    return 'Hoe te spelen · $game';
  }

  @override
  String get gameGotIt => 'Begrepen';

  @override
  String get tierFree => 'Gratis';

  @override
  String get tierMonthly => 'Premium · Maandelijks';

  @override
  String get tierYearly => 'Premium · Jaarlijks';

  @override
  String get podsUnlimited => 'onbeperkte pods';

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
  String get groupsSignedOutTitle =>
      'Sluit je aan bij een kleine, vriendelijke pod';

  @override
  String get groupsSignedOutBody =>
      'Groepen vereisen een snel account zodat pods veilig en van jou zijn. Je oefening blijft privé en accountvrij.';

  @override
  String get groupsSignInCta => 'Log in om door te gaan';

  @override
  String get groupsLoadError =>
      'Kon pods niet laden. Trek om opnieuw te proberen.';

  @override
  String groupsJoined(String pod) {
    return 'Aangesloten bij $pod. Zeg gedag wanneer je klaar bent.';
  }

  @override
  String get groupsJoinedNew =>
      'Aangesloten bij een nieuwe pod. Zeg gedag wanneer je klaar bent.';

  @override
  String get groupsNoPodFound => 'Kon nu geen pod vinden. Probeer opnieuw.';

  @override
  String groupsLeaveTitle(String pod) {
    return '$pod verlaten?';
  }

  @override
  String get groupsLeave => 'Verlaten';

  @override
  String groupsLeft(String pod) {
    return 'Je hebt $pod verlaten.';
  }

  @override
  String get groupsLeaveError => 'Kon de pod niet verlaten. Probeer opnieuw.';

  @override
  String get groupsHeader => 'Kleine pods, vriendelijke mensen';

  @override
  String get groupsYourPods => 'JOUW PODS';

  @override
  String get groupsDiscoverPods => 'ONTDEK PODS';

  @override
  String get groupsJoinAnother => 'Sluit je aan bij een andere pod';

  @override
  String get groupsNoOthers => 'Geen andere pods om je nu bij aan te sluiten.';

  @override
  String groupsJoinedShort(String pod) {
    return 'Aangesloten bij $pod.';
  }

  @override
  String get groupsJoin => 'Aansluiten';

  @override
  String get groupsPodOptions => 'Pod-opties';

  @override
  String get groupsLeavePod => 'Pod verlaten';

  @override
  String groupsMembers(int count, int capacity) {
    return '$count/$capacity leden';
  }

  @override
  String groupsTierPods(String tier, String pods) {
    return 'Met $tier kun je in $pods zitten.';
  }

  @override
  String groupsCapacityTierPods(int capacity, String tier, String pods) {
    return 'Tot $capacity per pod. Met $tier kun je in $pods zitten.';
  }

  @override
  String groupsInYourPods(String pods) {
    return 'Je zit in je $pods';
  }

  @override
  String get groupsUpgradeBody =>
      'Ga Premium om je bij meer aan te sluiten — maandelijks ontgrendelt 3 pods, jaarlijks zoveel als je wilt.';

  @override
  String get groupsSafetyLive =>
      'Wees vriendelijk. Je kunt iedereen vanuit hun profiel melden of blokkeren. Vergrendelde profielen blijven privé.';

  @override
  String get groupsSafetyPreview =>
      'Voorbeeld. Pods worden live, gemodereerde chats zodra inloggen is ingesteld.';

  @override
  String get groupsLeaveBody =>
      'Je ziet de berichten van deze pod niet meer. Je kunt je later opnieuw aansluiten.';

  @override
  String get podRulesTitle => 'Pod-regels';

  @override
  String get podRulesIntro =>
      'Pods werken alleen als iedereen zich veilig voelt. Door je aan te sluiten ga je akkoord:';

  @override
  String get podRule1 =>
      'Wees vriendelijk. Iedereen hier oefent iets moeilijks.';

  @override
  String get podRule2 => 'Geen intimidatie, haat of schadelijke inhoud. Nooit.';

  @override
  String get podRule3 =>
      'Meld of blokkeer iedereen die je een ongemakkelijk gevoel geeft.';

  @override
  String get podRule4 =>
      'Respecteer privacy — wat hier gedeeld wordt, blijft hier.';

  @override
  String get podRule5 =>
      'Pods zijn steun onder gelijken, geen crisisdienst. Neem bij nood contact op met een professional of een lokale crisislijn.';

  @override
  String get podRulesAgree => 'Ik ga akkoord — laat me binnen';

  @override
  String chatIntrosBeKind(int count, int capacity) {
    return '$count/$capacity introverten · wees vriendelijk';
  }

  @override
  String get chatHint => 'Zeg iets vriendelijks…';

  @override
  String get chatPreviewBanner =>
      'Voorbeeld · berichten blijven voorlopig op je apparaat. Echte, gemodereerde pods komen met accounts.';

  @override
  String get chatYou => 'Jij';

  @override
  String get reportHarassment => 'Intimidatie of pesten';

  @override
  String get reportHate => 'Haat of schadelijke taal';

  @override
  String get reportSpam => 'Spam of oplichting';

  @override
  String get reportUnsafe => 'Geeft me een onveilig gevoel';

  @override
  String get reportOther => 'Iets anders';

  @override
  String get memberPrivateTitle => 'Privéprofiel';

  @override
  String get memberPrivateBody =>
      'Dit lid houdt zijn profiel privé. Je kunt nog steeds met hem chatten — en melden of blokkeren indien nodig.';

  @override
  String memberStreak(int days) {
    return 'Reeks van $days dagen';
  }

  @override
  String memberChallenges(int count) {
    return '$count uitdagingen';
  }

  @override
  String memberClimbing(String track) {
    return 'Aan het klimmen: $track';
  }

  @override
  String get memberReport => 'Melden';

  @override
  String get memberBlock => 'Blokkeren';

  @override
  String get memberReportThanks => 'Bedankt — we bekijken dit.';

  @override
  String get memberBlockToo => 'Ook blokkeren';

  @override
  String get memberBlocked => 'Geblokkeerd. Je ziet hun berichten niet meer.';

  @override
  String get memberBlockError => 'Kon niet blokkeren. Probeer opnieuw.';

  @override
  String get memberReportError =>
      'Kon melding niet verzenden. Probeer opnieuw.';

  @override
  String get memberBlockConfirmTitle => 'Dit lid blokkeren?';

  @override
  String get memberBlockConfirmBody =>
      'Jullie zien elkaars berichten niet meer. Je kunt dit later ongedaan maken.';

  @override
  String get memberSoonReporting =>
      'Melden gaat live in gemodereerde pods (log in om het te gebruiken).';

  @override
  String get memberSoonBlocking =>
      'Blokkeren gaat live in gemodereerde pods (log in om het te gebruiken).';

  @override
  String get memberWhatsWrong => 'Wat is er mis?';

  @override
  String get memberFallback => 'Lid';

  @override
  String get blockedUnblockError => 'Kon niet deblokkeren. Probeer opnieuw.';

  @override
  String blockedUnblocked(String name) {
    return '$name gedeblokkeerd. Je ziet hun berichten weer.';
  }

  @override
  String get blockedIntro =>
      'Blokkeren verbergt de berichten van een lid voor jou — en die van jou voor hen, in beide richtingen. Deblokkeer hieronder iemand om het ongedaan te maken.';

  @override
  String get blockedLabel => 'Geblokkeerd';

  @override
  String get blockedUnblock => 'Deblokkeren';

  @override
  String get blockedEmptyTitle => 'Niemand geblokkeerd';

  @override
  String get blockedEmptyBody =>
      'Je hebt niemand geblokkeerd. Blokkeren verbergt de berichten van een lid voor jou, in beide richtingen — en je kunt het hier altijd ongedaan maken.';

  @override
  String get chatCheckInPosted => 'Goed gedaan. Pod-check-in geplaatst.';

  @override
  String get chatCheckInError => 'Kon nu niet inchecken. Probeer opnieuw.';

  @override
  String get chatDeleteMsgTitle => 'Bericht verwijderen?';

  @override
  String get chatDeleteMsgBody => 'Dit verwijdert het voor iedereen in de pod.';

  @override
  String get chatReply => 'Antwoorden';

  @override
  String get chatEdit => 'Bewerken';

  @override
  String get chatDailyPrompt => 'Dagelijkse pod-prompt';

  @override
  String get chatCheckedInToday => 'Vandaag ingecheckt';

  @override
  String get chatDidMyStep => 'Ik deed mijn stap';

  @override
  String chatCheckedInCount(int count) {
    return '$count ingecheckt';
  }

  @override
  String get chatNoMessages =>
      'Nog geen berichten. Een simpel «hoi» is een dappere eerste sport.';

  @override
  String get chatEditingMessage => 'Je bericht bewerken';

  @override
  String chatReplyingTo(String name) {
    return 'Antwoorden aan $name';
  }

  @override
  String get chatYourself => 'jezelf';

  @override
  String get chatMsgDeleted => 'Dit bericht is verwijderd';

  @override
  String get chatPrivateMember => 'Privélid';

  @override
  String chatBeKind(int count, int capacity) {
    return '$count/$capacity · wees vriendelijk';
  }

  @override
  String get chatDeletedMessageShort => 'verwijderd bericht';

  @override
  String get gameYouWin => 'Je wint! 🎉';

  @override
  String get gamePhoneWins => 'De telefoon wint';

  @override
  String get gamePhoneThinking => 'De telefoon denkt na…';

  @override
  String get gamePlayPhone => 'Speel tegen de telefoon';

  @override
  String get game2Players => '2 spelers';

  @override
  String get gameNewGame => 'Nieuw spel';

  @override
  String get gameYou => 'Jij';

  @override
  String get gamePhone => 'Telefoon';

  @override
  String get gameDraws => 'Gelijkspel';

  @override
  String get tttP1Wins => 'Speler 1 (X) wint! 🎉';

  @override
  String get tttP2Wins => 'Speler 2 (O) wint! 🎉';

  @override
  String get tttYourTurn => 'Jouw beurt';

  @override
  String get tttP1Turn => 'Speler 1 · X';

  @override
  String get tttP2Turn => 'Speler 2 · O';

  @override
  String get tttP1Label => 'S1 (X)';

  @override
  String get tttP2Label => 'S2 (O)';

  @override
  String get tttRule1 => 'Plaats om de beurt je teken op het 3×3-raster.';

  @override
  String get tttRule2 =>
      'Krijg drie van je tekens op een rij — horizontaal, verticaal of diagonaal — om te winnen.';

  @override
  String get tttRule3 =>
      '«Speel tegen de telefoon» is jij tegen een simpele AI. «2 spelers» geeft de telefoon elke beurt door.';

  @override
  String get c4P1Wins => 'Speler 1 wint! 🎉';

  @override
  String get c4P2Wins => 'Speler 2 wint! 🎉';

  @override
  String get c4Turn => 'Jouw beurt — tik op een kolom';

  @override
  String get c4P1Turn => 'Speler 1 · rood';

  @override
  String get c4P2Turn => 'Speler 2 · geel';

  @override
  String get c4P1Label => 'S1';

  @override
  String get c4P2Label => 'S2';

  @override
  String get c4Rule1 =>
      'Tik op een kolom om je schijf te laten vallen — hij valt naar de laagste vrije plek.';

  @override
  String get c4Rule2 =>
      'Krijg vier van je kleur op een rij — horizontaal, verticaal of diagonaal — om te winnen.';

  @override
  String get c4Rule3 =>
      '«Speel tegen de telefoon» is jij tegen een simpele AI. «2 spelers» geeft de telefoon door.';

  @override
  String get gameDraw => 'Het is gelijkspel 🤝';

  @override
  String get gamePlayAgain => 'Opnieuw spelen';

  @override
  String get gameStart => 'Beginnen';

  @override
  String get g2048Rule1 =>
      'Veeg omhoog, omlaag, links of rechts om alle tegels te schuiven.';

  @override
  String get g2048Rule2 =>
      'Twee tegels met hetzelfde getal versmelten tot één die verdubbelt.';

  @override
  String get g2048Rule3 =>
      'Blijf samenvoegen om een 2048-tegel te bouwen. Het bord vult zich — denk vooruit!';

  @override
  String get g2048Score => 'Score';

  @override
  String get g2048Best => 'Beste';

  @override
  String get g2048GameOver => 'Game over';

  @override
  String get g2048Won => 'Je hebt 2048 gemaakt! 🎉';

  @override
  String get g2048SwipeToMerge => 'Veeg om samen te voegen';

  @override
  String get qmRule1 => 'Je hebt 30 seconden — los er zoveel op als je kunt.';

  @override
  String get qmRule2 => 'Tik op het juiste antwoord uit de vier keuzes.';

  @override
  String get qmRule3 =>
      'Een verkeerde tik kost 2 seconden, dus lees zorgvuldig.';

  @override
  String qmTimeScored(Object score) {
    return 'Tijd! Je scoorde $score';
  }

  @override
  String qmBestSub(Object best) {
    return 'Beste $best · 30 seconden, beantwoord er zoveel als je kunt.';
  }

  @override
  String get qmStartSub => '30 seconden. Een verkeerde tik kost 2 seconden.';

  @override
  String get qmCorrect => 'goed';

  @override
  String get mmRule1 =>
      'Tik op een kaart om hem om te draaien, draai dan een tweede om.';

  @override
  String get mmRule2 =>
      'Als de twee emoji\'s overeenkomen, blijven ze open; zo niet, dan draaien ze terug.';

  @override
  String get mmRule3 => 'Vind alle paren — in zo weinig mogelijk zetten.';

  @override
  String mmAllMatched(Object moves) {
    return 'Alles gematcht in $moves zetten! 🎉';
  }

  @override
  String mmFindPairs(Object moves) {
    return 'Vind de paren · $moves zetten';
  }

  @override
  String mmBest(Object best) {
    return 'Beste: $best zetten';
  }

  @override
  String get mmShuffle => 'Schudden';

  @override
  String get rxTapStart => 'Tik om te beginnen';

  @override
  String get rxWaitGreen => 'Wacht op groen, tik dan snel';

  @override
  String get rxWait => 'Wacht…';

  @override
  String get rxTapMoment => 'Tik op het moment dat het groen wordt';

  @override
  String rxBestRetry(Object ms) {
    return 'Beste $ms ms · tik om opnieuw te proberen';
  }

  @override
  String get rxTapRetry => 'Tik om opnieuw te proberen';

  @override
  String get rxTooSoon => 'Te vroeg!';

  @override
  String get rxWaitRetry => 'Wacht op groen · tik om opnieuw te proberen';

  @override
  String get rxTap => 'TIK!';

  @override
  String get rxRule1 =>
      'Tik op het scherm om te beginnen, wacht dan — het wordt oranje.';

  @override
  String get rxRule2 =>
      'Op het moment dat het groen wordt, tik zo snel als je kunt.';

  @override
  String get rxRule3 =>
      'Te vroeg tikken zet het terug. Een lagere tijd (ms) is beter.';

  @override
  String get smWatchRepeat => 'Kijk naar het patroon en herhaal het.';

  @override
  String get smWatch => 'Kijk…';

  @override
  String smYourTurn(Object current, Object total) {
    return 'Jouw beurt · $current van $total';
  }

  @override
  String smReachedBest(Object best, Object reached) {
    return 'Je bereikte $reached · beste $best';
  }

  @override
  String smReached(Object reached) {
    return 'Je bereikte $reached';
  }

  @override
  String get smRule1 => 'Kijk hoe de tegels een voor een oplichten.';

  @override
  String get smRule2 =>
      'Herhaal precies dezelfde volgorde door op de tegels te tikken.';

  @override
  String get smRule3 => 'Elke ronde voegt één stap toe — kijk hoe ver je komt.';

  @override
  String smRound(Object round) {
    return 'Ronde $round';
  }

  @override
  String get safetyScreenTitle => 'Is dit iets voor mij?';

  @override
  String get safetyPracticeTitle => 'Rung is oefening, geen therapie.';

  @override
  String get safetyIntro =>
      'Rung is een hulpmiddel voor zelfvertrouwen en oefening. Het helpt je alledaagse sociale situaties geleidelijk aan te gaan, op je eigen tempo. Het is geen therapie, geen medische behandeling en geen diagnose.';

  @override
  String get safetyPoint1 =>
      'Het doel is beheersbare spanning — je prettiger voelen in de momenten die je vroeger vermeed. Niet een ander mens worden.';

  @override
  String get safetyPoint2 =>
      'Overslaan mag altijd en telt nooit tegen je. Er zijn hier geen schaamtemechanismen.';

  @override
  String get safetyPoint3 =>
      'Je gegevens zijn van jou. Alles werkt offline, zonder account.';

  @override
  String get safetyMoreTitle => 'Als dit meer is dan zenuwen';

  @override
  String get safetyMoreBody =>
      'Als angst je dagelijks leven ernstig beïnvloedt, of als je ooit gedachten hebt om jezelf pijn te doen, neem dan contact op met een gekwalificeerde professional of een lokale crisislijn. Dat is een sterke, gezonde stap — en Rung is daar geen vervanging voor.';

  @override
  String get legalLastUpdated => 'Laatst bijgewerkt: juni 2026';

  @override
  String legalQuestions(String email) {
    return 'Vragen? Neem contact met ons op via $email.';
  }

  @override
  String get privacyTitle => 'Privacybeleid';

  @override
  String get privacyIntro =>
      'Rung is een privé oefenhulpmiddel om sociaal zelfvertrouwen op te bouwen. We verzamelen zo min mogelijk, en de meest persoonlijke dingen die je schrijft verlaten je telefoon nooit. Dit beleid legt uit wat we opslaan en waarom.';

  @override
  String get ppWhatStaysHead => 'Wat alleen op je apparaat blijft';

  @override
  String get ppWhatStaysBody =>
      'Je reflectienotities en voorspellingsnotities — de private dingen die je schrijft over hoe een moment voelde — worden alleen in de app op je apparaat opgeslagen. Ze worden nooit naar onze servers geüpload.';

  @override
  String get ppCloudHead => 'Wat we in de cloud opslaan';

  @override
  String get ppCloudBody =>
      'Wanneer je een account aanmaakt, slaan we op: je e-mailadres (om in te loggen; je wachtwoord is versleuteld en we zien het nooit), een optionele weergavenaam en bio, en je privacyvergrendeling-instelling. Om de gemeenschap («pods») te laten werken, slaan we de berichten die je plaatst op, evenals blokkeringen of meldingen die je maakt. Om je voortgang veilig te houden op al je apparaten maken we alleen een back-up van cijfers — je reeks, voltooide uitdagingen en angstbeoordelingen (voorspeld vs werkelijk) — plus eventuele eigen stappen die je aanmaakt. Notitietekst wordt nooit opgenomen.';

  @override
  String get ppAnalyticsHead => 'Analyse';

  @override
  String get ppAnalyticsBody =>
      'We gebruiken privacyvriendelijke productanalyse (PostHog) om te begrijpen welke functies helpen — anonieme gebruiksgebeurtenissen zoals ‘scherm geopend’ of ‘stap voltooid’, nooit de inhoud van je notities of berichten. Het staat standaard uit en werkt alleen als je het inschakelt bij Instellingen; je kunt het altijd weer uitschakelen.';

  @override
  String get ppUseHead => 'Hoe we je gegevens gebruiken';

  @override
  String get ppUseBody =>
      'Alleen om de app te leveren: je inloggen, de pods laten werken, je voortgang herstellen en Rung verbeteren met geaggregeerde, anonieme trends. We verkopen je gegevens niet en gebruiken ze niet voor advertenties.';

  @override
  String get ppProcessHead => 'Wie je gegevens verwerkt';

  @override
  String get ppProcessBody =>
      'We gebruiken Supabase (authenticatie, database en hosting) en PostHog (analyse) als gegevensverwerkers. Zij verwerken gegevens namens ons onder hun eigen beveiligings- en privacyverplichtingen.';

  @override
  String get ppRightsHead => 'Je rechten en keuzes';

  @override
  String get ppRightsBody =>
      'Je kunt je profiel bewerken, het vergrendelen zodat andere leden het niet kunnen zien, en je account en alle bijbehorende cloudgegevens op elk moment permanent verwijderen via Profiel → Account verwijderen. Je kunt ons ook mailen om toegang tot of verwijdering van je gegevens te vragen.';

  @override
  String get ppSecurityHead => 'Beveiliging en bewaring';

  @override
  String get ppSecurityBody =>
      'Gegevens worden versleuteld tijdens verzending, en elke tabel is beschermd met beveiliging op rijniveau zodat je alleen bij je eigen gegevens kunt (en pod-berichten waarvan je lid bent). We bewaren je gegevens tot je je account verwijdert of ons vraagt ze te verwijderen.';

  @override
  String get ppChildrenHead => 'Kinderen';

  @override
  String get ppChildrenBody =>
      'Rung is niet bedoeld voor personen onder de 16. Als je denkt dat een kind een account heeft aangemaakt, neem dan contact met ons op en we verwijderen het.';

  @override
  String get ppMedicalHead => 'Geen medische zorg';

  @override
  String get ppMedicalBody =>
      'Rung ondersteunt geleidelijke oefening maar is geen therapie, diagnose of medisch advies. Als je in crisis bent, neem dan contact op met je lokale hulpdiensten of een crisislijn.';

  @override
  String get ppChangesHead => 'Wijzigingen';

  @override
  String get ppChangesBody =>
      'Als we dit beleid bijwerken, wijzigen we de datum hierboven en, voor wezenlijke wijzigingen, laten we het je weten in de app.';

  @override
  String get termsTitle => 'Servicevoorwaarden';

  @override
  String get termsIntro =>
      'Deze voorwaarden vormen de overeenkomst tussen jou en Rung wanneer je de app gebruikt. Door een account aan te maken of Rung te gebruiken, ga je ermee akkoord.';

  @override
  String get tosMedicalHead => 'Geen medische dienst';

  @override
  String get tosMedicalBody =>
      'Rung is een zelfhulp- en oefenhulpmiddel, geen therapie of medische zorg, en vervangt geen professionele hulp. Het kan geen bepaald resultaat garanderen. Als je in crisis bent of jezelf of anderen kunt schaden, neem dan onmiddellijk contact op met je lokale hulpdiensten.';

  @override
  String get tosEligibilityHead => 'Geschiktheid';

  @override
  String get tosEligibilityBody =>
      'Je moet minstens 16 jaar oud zijn om Rung te gebruiken en het recht hebben om met deze voorwaarden akkoord te gaan.';

  @override
  String get tosAccountHead => 'Je account';

  @override
  String get tosAccountBody =>
      'Houd je inloggegevens veilig — je bent verantwoordelijk voor activiteit op je account. Laat het ons meteen weten als je onbevoegd gebruik vermoedt.';

  @override
  String get tosCommunityHead => 'Gemeenschapsregels (pods)';

  @override
  String get tosCommunityBody =>
      'Pods zijn voor vriendelijkheid en steun. Je gaat ermee akkoord niet te intimideren, bedreigen, kleineren, spammen of haatdragende of illegale inhoud te plaatsen, en geen privé-informatie van anderen te delen. We kunnen inhoud verwijderen of accounts schorsen die deze regels overtreden. Je kunt andere leden op elk moment blokkeren en melden.';

  @override
  String get tosContentHead => 'Inhoud die je plaatst';

  @override
  String get tosContentBody =>
      'Je behoudt het eigendom van wat je schrijft. Door in een pod te plaatsen geef je ons toestemming om het op te slaan en te tonen aan de leden van die pod zodat de gemeenschap werkt. Plaats niets waarvan je niet het recht hebt om het te delen.';

  @override
  String get tosSubsHead => 'Abonnementen';

  @override
  String get tosSubsBody =>
      'Sommige functies en extra oefeninhoud zijn beschikbaar met een betaald abonnement. Wanneer facturering actief is, worden aankopen en verlengingen afgehandeld door de appstore, en je kunt ze beheren of opzeggen via je appstore-account. Prijzen en inhoud kunnen met kennisgeving wijzigen.';

  @override
  String get tosDisclaimerHead => 'Disclaimers en aansprakelijkheid';

  @override
  String get tosDisclaimerBody =>
      'Rung wordt geleverd «zoals het is», zonder enige garantie. Voor zover wettelijk toegestaan zijn we niet aansprakelijk voor indirecte of gevolgschade die voortvloeit uit je gebruik van de app.';

  @override
  String get tosEndingHead => 'Je gebruik beëindigen';

  @override
  String get tosEndingBody =>
      'Je kunt je account op elk moment verwijderen via Profiel → Account verwijderen. We kunnen de toegang schorsen of beëindigen als deze voorwaarden ernstig of herhaaldelijk worden overtreden.';

  @override
  String get tosChangesHead => 'Wijzigingen';

  @override
  String get tosChangesBody =>
      'We kunnen deze voorwaarden bijwerken; we werken de datum hierboven bij en, voor belangrijke wijzigingen, stellen we je op de hoogte in de app. Doorgaan met Rung betekent dat je de bijgewerkte voorwaarden accepteert.';

  @override
  String get breatheCta => 'Voel je de spanning? Adem eerst';

  @override
  String get breatheIntro => 'Zestig seconden. Volg gewoon de cirkel.';

  @override
  String get breatheIn => 'Adem in';

  @override
  String get breatheHold => 'Vasthouden';

  @override
  String get breatheOut => 'Adem uit';

  @override
  String get breatheSkip => 'Overslaan';

  @override
  String get breatheDoneTitle => 'Zo.';

  @override
  String get breatheDoneSub =>
      'Voel je je iets stabieler? Doe je sport wanneer je klaar bent.';

  @override
  String get breatheDoneBtn => 'Klaar';

  @override
  String get insightsDeeperTitle => 'Diepere inzichten';

  @override
  String get insightsLockedBody =>
      'Zie je maand in één oogopslag — hoeveel heter je angst liep dan de werkelijkheid, en hoe vaak je hem overschatte. Een Premium-voordeel.';

  @override
  String get insightsUnlockCta => 'Ontgrendel met Premium';

  @override
  String get insightsNoSteps =>
      'Deze maand nog geen stappen genoteerd. Ga er een paar aan en je overzicht verschijnt hier.';

  @override
  String get insightsFearsFacedMonth => 'angsten aangegaan deze maand';

  @override
  String insightsGapHotter(String points) {
    return 'Je angst liep gemiddeld $points punten heter dan de werkelijkheid.';
  }

  @override
  String get insightsGapTougher =>
      'De werkelijkheid was deze maand iets zwaarder dan je voorspelde — ook dat zijn dappere gegevens.';

  @override
  String get insightsGapSpotOn =>
      'Je voorspellingen zaten deze maand aardig raak.';

  @override
  String insightsOverPredicted(int rate) {
    return 'Je overschatte de angst in $rate% van de gevallen.';
  }

  @override
  String get insightsTrendSame => 'Hetzelfde als vorige maand';

  @override
  String insightsTrendMore(int count) {
    return '$count meer dan vorige maand';
  }

  @override
  String insightsTrendFewer(int count) {
    return '$count minder dan vorige maand';
  }

  @override
  String get rateTitle => 'Bevalt Rung je?';

  @override
  String get ratePromptNone => 'Hoe voelt Rung voor je?';

  @override
  String get ratePromptLow => 'Jammer dat het niet aanslaat. Wat ontbreekt er?';

  @override
  String get ratePromptMid => 'Bedankt — wat zou er een 5 van maken?';

  @override
  String get ratePromptHigh => 'Dat betekent veel. Wat vind je goed?';

  @override
  String get rateHintLove => 'Iets wat je goed vindt? (optioneel)';

  @override
  String get rateHintMore => 'Vertel ons meer (optioneel)';

  @override
  String get rateSend => 'Versturen';

  @override
  String get rateThanksHigh => 'Bedankt — het helpt echt. 🌱';

  @override
  String get rateThanksLow =>
      'Bedankt voor je eerlijkheid — we gebruiken het om te verbeteren.';

  @override
  String get editProfileTitle => 'Profiel bewerken';

  @override
  String get editDisplayName => 'Weergavenaam';

  @override
  String get editDisplayNameHint => 'Hoe moeten de pods je noemen?';

  @override
  String get editBio => 'Korte bio (optioneel)';

  @override
  String get editBioHint =>
      'Een regel over jou — blijft privé als je je profiel vergrendelt.';

  @override
  String get errorOffline =>
      'Je bent offline. Maak verbinding met internet en probeer opnieuw.';

  @override
  String get errorGeneric => 'Er ging iets mis. Probeer opnieuw.';

  @override
  String get errorSaveFailed =>
      'Opslaan mislukt — je apparaat heeft mogelijk weinig opslag. Maak ruimte vrij en probeer opnieuw.';
}
