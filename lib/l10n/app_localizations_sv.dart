// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get navHome => 'Hem';

  @override
  String get navGroups => 'Grupper';

  @override
  String get navPremium => 'Premium';

  @override
  String get navProfile => 'Profil';

  @override
  String get greetingMorning => 'God morgon';

  @override
  String get greetingAfternoon => 'God eftermiddag';

  @override
  String get greetingEvening => 'God kväll';

  @override
  String get todayStepIntro => 'Här är ett litet steg för idag.';

  @override
  String get commonContinue => 'Fortsätt';

  @override
  String get commonCancel => 'Avbryt';

  @override
  String get commonSave => 'Spara';

  @override
  String get commonDone => 'Klar';

  @override
  String get commonNotNow => 'Inte nu';

  @override
  String get profileTitle => 'Profil';

  @override
  String get language => 'Språk';

  @override
  String get languageSystemDefault => 'Systemspråk';

  @override
  String get yourTone => 'Din ton';

  @override
  String get appearance => 'Utseende';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Ljust';

  @override
  String get themeDark => 'Mörkt';

  @override
  String get onbSkip => 'Hoppa över';

  @override
  String get onbWelcomeTitle =>
      'Möt stunderna du brukade bäva för — ett litet steg i taget.';

  @override
  String get onbWelcomeBody =>
      'Rung hjälper dig bygga socialt självförtroende genom mjuk, privat övning. Förutsäg, gör det, reflektera — och se dina värsta farhågor falla isär i dina egna siffror.';

  @override
  String get onbGetStarted => 'Kom igång';

  @override
  String get onbSafetyTitle => 'Övning, inte terapi.';

  @override
  String get onbUnderstand => 'Jag förstår';

  @override
  String get onbSafetyBody1 =>
      'Rung är ett verktyg för självförtroende och övning — inte terapi, inte medicinsk behandling och inte en diagnos.';

  @override
  String get onbSafetyBody2 =>
      'Målet är att känna dig mer bekväm i stunder du brukade bäva för — inte att bli någon du inte är. Att hoppa över är alltid okej.';

  @override
  String get onbSafetyCrisis =>
      'Om ångest allvarligt påverkar ditt liv, eller om du någon gång har tankar på att skada dig själv, kontakta en professionell eller en lokal krislinje.';

  @override
  String get onbFearTitle => 'Var vill du börja?';

  @override
  String get onbFearBody =>
      'Bara som förslag på ett första steg — du kan klättra vilken som helst av dessa när som helst. Inget här binder dig.';

  @override
  String get onbExploreOwn => 'Jag utforskar hellre på egen hand';

  @override
  String get onbToneTitle => 'Vad låter mest som du?';

  @override
  String get onbToneIntrovertTitle => 'Jag är mer av en introvert';

  @override
  String get onbToneIntrovertBody =>
      'Jag vill känna mig bekväm, inte bli en annan person.';

  @override
  String get onbToneSituationalTitle => 'Jag blir nervös i vissa situationer';

  @override
  String get onbToneSituationalBody =>
      'Ibland är jag utåtriktad, men vissa stunder får mig ur balans.';

  @override
  String get onbToneFootnote => 'Du kan ändra detta när som helst i Profil.';

  @override
  String get onbHowTitle => 'Så här fungerar det.';

  @override
  String get onbStartClimbing => 'Börja klättra';

  @override
  String get onbStep1 => 'Förutsäg hur jobbigt det kommer kännas (0–10).';

  @override
  String get onbStep2 => 'Gör det i verkligheten — appen får vara stängd.';

  @override
  String get onbStep3 => 'Kom tillbaka och notera hur det faktiskt gick.';

  @override
  String get onbGentleFirstStep => 'ETT MJUKT FÖRSTA STEG';

  @override
  String get onbGoodPlaceToStart => 'ETT BRA STÄLLE ATT BÖRJA';

  @override
  String get onbAllAreas =>
      'Alla sex områden finns på din startskärm — börja var du vill.';

  @override
  String get predictAppBar => 'Innan du går';

  @override
  String get predictSaved =>
      'Sparat. Gå och gör det — kom sedan tillbaka och notera hur det gick.';

  @override
  String get predictQuestion => 'Hur jobbigt tror du att det blir?';

  @override
  String get predictNoteLabel => 'Vad tror du händer? (valfritt)';

  @override
  String get predictNoteHint => 't.ex. De kommer tycka att jag är fumlig';

  @override
  String get predictCompare =>
      'Vi jämför detta med hur det faktiskt går. Den skillnaden är hela poängen.';

  @override
  String get predictDoIt => 'Jag gör det';

  @override
  String get reflectAppBar => 'Hur gick det?';

  @override
  String get reflectDidYouDoIt => 'Gjorde du det?';

  @override
  String get reflectHowAnxious => 'Hur ångestfylld kändes bara tanken på det?';

  @override
  String get reflectHowBad => 'Hur jobbigt var det, egentligen?';

  @override
  String get reflectNoteLabel => 'Något du vill minnas? (valfritt)';

  @override
  String get reflectOutcomeDone => 'Gjort';

  @override
  String get reflectOutcomePartial => 'Delvis';

  @override
  String get reflectOutcomeNotToday => 'Inte idag';

  @override
  String get resultQuietDelight => 'Stilla glädje i varje steg.';

  @override
  String get resultBackToLadder => 'Tillbaka till stegen';

  @override
  String resultGapHeadline(int predicted, int actual) {
    return 'Du förberedde dig för $predicted. Det blev $actual.';
  }

  @override
  String resultGapSub(int predicted, int actual) {
    return 'Ditt hjärta förberedde sig för en tung $predicted, men världen mötte dig med en mildare $actual. Värt att minnas.';
  }

  @override
  String get resultRightHeadline => 'Precis som du gissade.';

  @override
  String get resultRightSub =>
      'Du hade rätt — och du dök ändå upp. Det är vinsten.';

  @override
  String get resultTougherHeadline =>
      'Tuffare än du gissade — och du gjorde det.';

  @override
  String get resultTougherSub =>
      'Vissa stunder kräver mer av oss. Att dyka upp ändå är hela poängen.';

  @override
  String get resultPredicted => 'Förutsagt';

  @override
  String get resultActual => 'Faktiskt';

  @override
  String resultLighter(int reduction) {
    return 'Den här stunden var $reduction% lättare än du fruktade';
  }

  @override
  String get resultSkippedHeadline => 'Noterat — ingen press.';

  @override
  String get resultSkippedSub =>
      '«Inte idag» är ett fullt godtagbart svar. Det här steget finns kvar när du är redo.';

  @override
  String get resultWinCopied =>
      'Vinsten kopierad — klistra in den var du vill.';

  @override
  String get resultCopyWin => 'Kopiera min vinst';

  @override
  String resultShareText(String rung) {
    return 'Jag gjorde precis något jag brukade undvika: $rung. Ett litet steg klättrat. 🪜 #Rung';
  }

  @override
  String get tracksTitle => 'Dina spår';

  @override
  String get tracksSubtitle => 'Små steg mot stort självförtroende.';

  @override
  String get menuInsights => 'Insikter';

  @override
  String get menuIsThisRight => 'Är det här rätt för mig?';

  @override
  String tracksRungsCount(int done, int total) {
    return '$done av $total steg';
  }

  @override
  String tracksClimbedCount(int done, int total) {
    return '$done av $total klättrade';
  }

  @override
  String get tracksContinueLabel => 'FORTSÄTT DÄR DU SLUTADE';

  @override
  String get tracksNextStepLabel => 'DITT NÄSTA STEG';

  @override
  String get tracksLoadError => 'Kunde inte ladda spåren.';

  @override
  String get todayResume => 'Fortsätt där du slutade';

  @override
  String get todayNext => 'Ditt nästa steg';

  @override
  String get todayVariety => 'Något lite annorlunda';

  @override
  String get todayFresh => 'Din startpunkt';

  @override
  String get todayResumeCta => 'Slutför noteringen';

  @override
  String get todayStartCta => 'Börja';

  @override
  String todayMinutes(int min) {
    return '~$min min';
  }

  @override
  String get dashShareTooltip => 'Dela mina framsteg';

  @override
  String get dashWeeklyGoal => 'Veckomål';

  @override
  String dashStepsPerWeek(int count) {
    return '$count steg/vecka';
  }

  @override
  String dashGoalPerWeek(int count) {
    return '$count/vecka';
  }

  @override
  String dashWeeklyProgress(int done, int goal) {
    return '$done av $goal steg klara den här veckan';
  }

  @override
  String get dashYourGrowth => 'Din utveckling';

  @override
  String get dashTodayError =>
      'Kunde inte ladda dagens steg. Dra för att försöka igen.';

  @override
  String get dashTodayAllClear =>
      'Du har klarat allt tillgängligt — lägg till ett eget steg eller gör om ett för att hålla svitem igång.';

  @override
  String get dashTakeABreak => 'Ta en paus';

  @override
  String get dashTakeABreakSub =>
      'Några lugna spel — mot telefonen eller med en vän.';

  @override
  String get ladderTitleFallback => 'Stege';

  @override
  String get ladderLoadError => 'Kunde inte ladda stegen.';

  @override
  String get ladderAddOwn => 'Lägg till ditt eget steg';

  @override
  String ladderOfClimbed(int total) {
    return 'av $total klättrade';
  }

  @override
  String get detailLoadError => 'Kunde inte ladda.';

  @override
  String get detailNotExist => 'Det här steget finns inte längre.';

  @override
  String get detailWhatToDo => 'Vad du ska göra';

  @override
  String get detailWhyHelps => 'Varför det hjälper';

  @override
  String get detailPastAttempts => 'Dina tidigare försök';

  @override
  String get detailDoThis => 'Jag gör det här';

  @override
  String get detailReattempt =>
      'Att försöka igen uppmuntras — det bygger dina data.';

  @override
  String detailHistoryStat(int predicted, int actual) {
    return 'förutsagt $predicted · faktiskt $actual';
  }

  @override
  String customLimitPremium(int cap) {
    return 'Du har nått den här månadens gräns på $cap egna steg — den återställs nästa månad.';
  }

  @override
  String get customLimitFree =>
      'Gratisplanen innehåller 5 egna steg — uppgradera för fler varje månad.';

  @override
  String get customDefaultWhat => 'En utmaning du sätter för dig själv.';

  @override
  String get customDefaultWhy =>
      'Du satte ord på den — det är det som gör att den räknas.';

  @override
  String get customSubtitle =>
      'Din situation är specifik — det här steget är bara för dig.';

  @override
  String get customWhatLabel => 'Vad ska du göra?';

  @override
  String get customWhatHint => 't.ex. Be min chef om feedback';

  @override
  String get customNoteLabel => 'En notering till dig själv (valfritt)';

  @override
  String customDifficulty(int value) {
    return 'Hur svårt känns det? $value/10';
  }

  @override
  String get customAddToLadder => 'Lägg till i stegen';

  @override
  String get paywallSwitchToFree => 'Byt till Gratis';

  @override
  String get paywallHeroTitle => 'Du behöver inte möta det ensam.';

  @override
  String get paywallHeroBody =>
      'Den dagliga övningen är alltid gratis. Premium lägger till en privat coach i ditt hörn — och en större gemenskap vid din sida — för när du är redo att gå längre.';

  @override
  String get paywallWhatsIncluded => 'Vad som ingår';

  @override
  String get paywallPlusHeader => 'Dessutom får varje prenumerant';

  @override
  String get paywallBenefitCoach =>
      'En privat coach, när som helst — öva på något som väntar eller prata igenom hur det gick';

  @override
  String get paywallBenefitPods =>
      'Du gör inte detta ensam — gå med i fler stödgrupper (3 på månadsvis, obegränsat på årsvis)';

  @override
  String get paywallBenefitCustom =>
      'Bygg obegränsat med egna stegar — ingen gräns för egna steg';

  @override
  String get paywallBenefitDepth =>
      'Gå djupare när du är redo — upp till 40 steg per spår (gratis är en hel båge på 10 steg)';

  @override
  String get paywallPlusStreak =>
      'Svitskydd — en missad dag bryter inte din svit';

  @override
  String get paywallPlusInsights =>
      'Djupare insikter — din månad i ett ögonkast';

  @override
  String get paywallPlusShare => 'Personliga stilar för delningskort';

  @override
  String get paywallPlusPrivacy => 'Alltid privat, alltid reklamfritt';

  @override
  String get paywallYearly => 'Årsvis';

  @override
  String get paywallPerYear => 'per år · bästa värde';

  @override
  String get paywallSave => 'Spara 33%';

  @override
  String get paywallMonthly => 'Månadsvis';

  @override
  String get paywallPerMonth => 'per månad';

  @override
  String get paywallSwitchYearly => 'Byt till årsvis';

  @override
  String get paywallSwitchMonthly => 'Byt till månadsvis';

  @override
  String paywallStartYearly(String price) {
    return 'Starta årsvis — $price';
  }

  @override
  String paywallStartMonthly(String price) {
    return 'Starta månadsvis — $price';
  }

  @override
  String get paywallRestore => 'Återställ köp';

  @override
  String paywallCurrentPlan(String plan) {
    return 'Nuvarande plan: $plan. Avsluta när du vill.';
  }

  @override
  String get paywallCancelAnytime =>
      'Avsluta när du vill. Kärnan förblir gratis för alltid.';

  @override
  String get paywallSimulated =>
      'Premium aktivt (simulerat — lägg till RevenueCat-nycklar för riktiga köp).';

  @override
  String get paywallPlanUnavailable =>
      'Den planen är inte tillgänglig just nu. Försök igen strax.';

  @override
  String get paywallThankYou => 'Premium aktivt — tack. 🌱';

  @override
  String get paywallPurchaseFailed =>
      'Köpet slutfördes inte. Du har inte debiterats.';

  @override
  String get paywallRestored => 'Köp återställda.';

  @override
  String get paywallNoRestore =>
      'Inga tidigare köp hittades på det här kontot.';

  @override
  String get paywallRestoreFailed =>
      'Kunde inte återställa just nu. Försök igen strax.';

  @override
  String get profileAddName => 'Lägg till ditt namn';

  @override
  String get profileLockTitle => 'Lås min profil';

  @override
  String get profileLockedSub =>
      'Dold — gruppmedlemmar kan inte öppna dina uppgifter.';

  @override
  String get profileUnlockedSub =>
      'Gruppmedlemmar kan trycka på din avatar för att se dina uppgifter.';

  @override
  String get profilePlanTitle => 'Din plan';

  @override
  String get profilePremium => 'Premium';

  @override
  String get profileUpgrade => 'Uppgradera';

  @override
  String get profileToneDesc =>
      'Rung talar mjukt som standard. Om din ångest är mer situationsbunden kan en något djärvare ton passa dig bättre.';

  @override
  String get profileToneIntrovert => 'Introvert';

  @override
  String get profileToneSituational => 'Situationsbunden';

  @override
  String get profileSafetySub => 'Hur Rung passar in — och när du bör söka mer';

  @override
  String get profileBlockedTitle => 'Blockerade medlemmar';

  @override
  String get profileBlockedSub => 'Se och avblockera personer du har blockerat';

  @override
  String get profileRestoreTitle => 'Återställ mina framsteg';

  @override
  String get profileRestoreSub =>
      'Hämta din svit och dina utmaningar från molnet';

  @override
  String get profileRestoring => 'Återställer…';

  @override
  String get profileRestoreOk => 'Framsteg återställda från molnet.';

  @override
  String profileRestoreFail(String error) {
    return 'Återställning misslyckades: $error';
  }

  @override
  String get profileLogout => 'Logga ut';

  @override
  String get profileChangePwTitle => 'Byt lösenord';

  @override
  String get profileChangePwSub => 'Ange ett nytt lösenord för ditt konto';

  @override
  String get profileChangePwSaved => 'Lösenordet uppdaterat';

  @override
  String get profileSignedIn => 'Inloggad';

  @override
  String get profileLogoutConfirmTitle => 'Logga ut?';

  @override
  String get profileLogoutConfirmBody =>
      'Dina framsteg är sparade i molnet och kommer tillbaka när du loggar in igen.';

  @override
  String get profileLoggingOut => 'Loggar ut…';

  @override
  String get profileRateTitle => 'Betygsätt Rung';

  @override
  String get profileRateSub => 'Berätta hur det går — det hjälper verkligen';

  @override
  String get profilePrivacyTitle => 'Integritetspolicy';

  @override
  String get profilePrivacySub =>
      'Vad vi lagrar — och vad som stannar på din enhet';

  @override
  String get profileTermsTitle => 'Användarvillkor';

  @override
  String get profileTermsSub => 'Avtalet för att använda Rung';

  @override
  String get profileDeleteTitle => 'Radera konto';

  @override
  String get profileDeleteSub => 'Radera permanent ditt konto och dina data';

  @override
  String get profileFooter => 'Rung · övning, inte terapi. Dina data är dina.';

  @override
  String get profileDeleteConfirmTitle => 'Radera konto?';

  @override
  String get profileDeleteConfirmBody =>
      'Detta raderar permanent ditt konto, dina gruppmeddelanden och dina sparade framsteg. Det kan inte ångras.';

  @override
  String get profileDelete => 'Radera';

  @override
  String get profileDeleting => 'Raderar ditt konto…';

  @override
  String get profileDeleteFail => 'Kunde inte radera ditt konto. Försök igen.';

  @override
  String get profileBioPlaceholder => 'En tyst klättrare.';

  @override
  String get profileHaptics => 'Vibration';

  @override
  String get profileHapticsSub => 'Mjuk vibration vid tryck och vinster';

  @override
  String get profileAnalytics => 'Dela anonym användningsdata';

  @override
  String get profileAnalyticsSub =>
      'Hjälper till att förbättra Rung. Aldrig personuppgifter.';

  @override
  String get profileNotifications => 'Aviseringar';

  @override
  String get profileNotificationsSub =>
      'Aviseringar från Rung på den här enheten';

  @override
  String get profilePodAlerts => 'Aviseringar om gruppmeddelanden';

  @override
  String get profilePodAlertsSub => 'Säg till när någon skriver i mina grupper';

  @override
  String get profileEnableNotifs =>
      'Aktivera aviseringar i Inställningar för att få påminnelser.';

  @override
  String get profileReminderHelp => 'När ska vi puffa på dig?';

  @override
  String get profileReminderTitle => 'Mjuk daglig påminnelse';

  @override
  String profileReminderOn(String time) {
    return 'Varje dag kl. $time · tryck på reglaget för att stänga av';
  }

  @override
  String get profileReminderOff =>
      'En lugn, skuldfri knuff att ta ett litet steg';

  @override
  String get profileAvatarTitle => 'Välj din avatar';

  @override
  String get profileAvatarSub =>
      'Bara du kan ändra den — dina gruppkamrater ser den också.';

  @override
  String get commonClose => 'Stäng';

  @override
  String get checkInMoodCalm => 'Lugn';

  @override
  String get checkInMoodOkay => 'Okej';

  @override
  String get checkInMoodAnxious => 'Ängslig';

  @override
  String get checkInMoodLow => 'Nedstämd';

  @override
  String get checkInMoodTense => 'Spänd';

  @override
  String get checkInTitle => 'Hur anländer du idag?';

  @override
  String get checkInDismiss => 'Avfärda';

  @override
  String get checkInCalmCta => 'Prova en lugn stund';

  @override
  String get checkInStepCta => 'Se dagens steg';

  @override
  String get supportTitle => 'Det låter som mycket att bära.';

  @override
  String get supportBody =>
      'Rung är ett övningsverktyg, inte en krisjour. Om du går igenom något tungt, vänd dig till någon som kan hjälpa dig nu — en person du litar på, eller en lokal krislinje. Du förtjänar riktigt stöd.';

  @override
  String get supportResources => 'Se stödresurser';

  @override
  String get progressChallenges => 'Utmaningar';

  @override
  String get progressCurrentStreak => 'Nuvarande svit';

  @override
  String get progressBestStreak => 'Bästa svit';

  @override
  String get progressThisWeek => 'Den här veckan';

  @override
  String get progressCategoryBreakdown => 'Fördelning per kategori';

  @override
  String get insightsHistory => 'Historik';

  @override
  String checkInAckTitle(String mood) {
    return 'Incheckad — du känner dig $mood';
  }

  @override
  String get checkInAckGentle =>
      'Tack för din ärlighet. Låt oss hålla idag mjuk — en liten, snäll sak räcker.';

  @override
  String get checkInAckStep =>
      'Härligt. När du är redo håller ett litet steg farten uppe.';

  @override
  String get sharePremiumPerk => '✨ Fler kortstilar är en Premium-förmån.';

  @override
  String get shareSeePremium => 'Se Premium';

  @override
  String get shareText => 'Små modiga steg, ett steg i taget. 🌱 #Rung';

  @override
  String get shareError => 'Kunde inte öppna delning. Försök igen.';

  @override
  String get shareTitle => 'Dela dina framsteg';

  @override
  String get shareSubtitle => 'Bara dina siffror — inget privat.';

  @override
  String get shareCta => 'Dela';

  @override
  String get shareCardHeadline => 'Mina modiga steg';

  @override
  String get shareCardFearsFaced => 'rädslor mötta';

  @override
  String get shareCardCurrentStreak => 'Nuvarande svit';

  @override
  String get shareCardBestStreak => 'Bästa svit';

  @override
  String get shareCardTagline => 'Möta social rädsla, ett litet steg i taget.';

  @override
  String get helpNow => 'Hjälp nu';

  @override
  String get helpCalmMoment => 'En lugn stund';

  @override
  String get helpTabBreathe => 'Andas';

  @override
  String get helpTabGround => 'Jorda';

  @override
  String get helpTabSay => 'Säg det här';

  @override
  String get helpBreatheIn => 'Andas in…';

  @override
  String get helpBreatheOut => 'Andas ut…';

  @override
  String get helpBreatheHint => 'Följ cirkeln. Det är ingen brådska.';

  @override
  String get helpGround5 => 'saker du kan se';

  @override
  String get helpGround4 => 'saker du kan röra vid';

  @override
  String get helpGround3 => 'saker du kan höra';

  @override
  String get helpGround2 => 'saker du kan känna doften av';

  @override
  String get helpGround1 => 'sak du kan smaka';

  @override
  String get helpGroundTitle => 'Nämn, tyst för dig själv…';

  @override
  String get helpGroundHint =>
      'Detta för dig tillbaka till nuet — där du är trygg.';

  @override
  String get helpOpener1 => 'Hur känner du folk här?';

  @override
  String get helpOpener2 =>
      'Jag älskar det här stället — har du varit här förut?';

  @override
  String get helpOpener3 => 'Jag är hopplös på namn — kan du påminna mig?';

  @override
  String get helpOpener4 => 'Vad har du gjort den här veckan?';

  @override
  String get helpExit1 =>
      'Jag ska hämta något att dricka — det var trevligt att prata med dig.';

  @override
  String get helpExit2 =>
      'Jag måste säga hej till någon snabbt, ursäkta mig ett ögonblick.';

  @override
  String get helpExit3 => 'Jag låter dig mingla vidare — vi ses sen.';

  @override
  String get helpOpenersTitle => 'Enkla inledningar';

  @override
  String get helpExitsTitle => 'Graciösa avsked';

  @override
  String get authEnterEmail => 'Ange din e-post';

  @override
  String get authBadEmail => 'Den e-posten ser inte rätt ut';

  @override
  String get authEnterPassword => 'Ange ett lösenord';

  @override
  String get authMin6 => 'Minst 6 tecken';

  @override
  String get authPwMismatch => 'Lösenorden matchar inte';

  @override
  String get authConfirmEmail =>
      'Kolla din e-post för att bekräfta, logga sedan in. (Eller stäng av e-postbekräftelse i Supabase Auth-inställningarna för snabb testning.)';

  @override
  String get authGenericError => 'Något gick fel. Försök igen.';

  @override
  String get authCreateTitle => 'Skapa ditt konto';

  @override
  String get authWelcomeBack => 'Välkommen tillbaka';

  @override
  String get authSignUpSub =>
      'Gå med i grupperna och håll dina framsteg trygga över alla enheter.';

  @override
  String get authSignInSub =>
      'Logga in till dina grupper och synkade framsteg.';

  @override
  String get authDisplayName => 'Visningsnamn (valfritt)';

  @override
  String get authEmail => 'E-post';

  @override
  String get authPassword => 'Lösenord';

  @override
  String get authShowPassword => 'Visa lösenord';

  @override
  String get authHidePassword => 'Dölj lösenord';

  @override
  String get authConfirmPassword => 'Bekräfta lösenord';

  @override
  String get authForgotPassword => 'Glömt lösenordet?';

  @override
  String get authResetTitle => 'Återställ lösenord';

  @override
  String get authResetBody =>
      'Ange e-postadressen för ditt konto så skickar vi en länk för att skapa ett nytt lösenord.';

  @override
  String get authResetSend => 'Skicka länk';

  @override
  String get authResetSent =>
      'Om den e-postadressen har ett konto är länken redan på väg.';

  @override
  String get authNewPassword => 'Nytt lösenord';

  @override
  String get authConfirmNewPassword => 'Bekräfta nytt lösenord';

  @override
  String get authUpdatePasswordCta => 'Uppdatera lösenord';

  @override
  String get authCreateCta => 'Skapa konto';

  @override
  String get authSignInCta => 'Logga in';

  @override
  String get authHaveAccount => 'Jag har redan ett konto';

  @override
  String get authNewAccount => 'Jag är ny — skapa ett konto';

  @override
  String get authLegalPrefixSignUp =>
      'Genom att skapa ett konto godkänner du våra ';

  @override
  String get authLegalPrefixSignIn => 'Genom att fortsätta godkänner du våra ';

  @override
  String get authTerms => 'Villkor';

  @override
  String get authAnd => ' och ';

  @override
  String get gamesIntro =>
      'Lugna spel för fokus och ett stilla sinne — den sortens hjärnträning som känns jordande. Spela mot telefonen, eller skicka den till en vän.';

  @override
  String gamesBestMs(int ms) {
    return 'Bäst $ms ms';
  }

  @override
  String gamesBestLevel(int level) {
    return 'Bästa nivå $level';
  }

  @override
  String gamesBest(String score) {
    return 'Bäst $score';
  }

  @override
  String gamesBestMoves(int moves) {
    return 'Bäst $moves drag';
  }

  @override
  String gamesWinsVsPhone(int count) {
    return '$count vinster mot telefonen';
  }

  @override
  String get gameTitleReaction => 'Reaktionshastighet';

  @override
  String get gameTitleSequence => 'Sekvensminne';

  @override
  String get gameTitleQuickMath => 'Snabbmatte';

  @override
  String get gameTitleMemory => 'Memory';

  @override
  String get gameSubReaction => 'fokus · tryck när det blir grönt';

  @override
  String get gameSubSequence => 'minne · titta och upprepa';

  @override
  String get gameSub2048 => 'strategi · svep för att slå ihop';

  @override
  String get gameSubQuickMath => 'huvudräkning · 30-sekunderssprint';

  @override
  String get gameSubTicTacToe => 'mot telefonen · eller 2 spelare';

  @override
  String get gameSubConnect4 => 'mot telefonen · eller 2 spelare';

  @override
  String get gameSubMemory => 'solo · hitta paren';

  @override
  String get gameHelpTooltip => 'Så spelar du';

  @override
  String gameHelpTitle(String game) {
    return 'Så spelar du · $game';
  }

  @override
  String get gameGotIt => 'Uppfattat';

  @override
  String get tierFree => 'Gratis';

  @override
  String get tierMonthly => 'Premium · Månadsvis';

  @override
  String get tierYearly => 'Premium · Årsvis';

  @override
  String get podsUnlimited => 'obegränsat med grupper';

  @override
  String podsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count grupper',
      one: '1 grupp',
    );
    return '$_temp0';
  }

  @override
  String get groupsSignedOutTitle => 'Gå med i en liten, snäll grupp';

  @override
  String get groupsSignedOutBody =>
      'Grupper kräver ett snabbt konto så att de är trygga och dina. Din övning förblir privat och kontofri.';

  @override
  String get groupsSignInCta => 'Logga in för att fortsätta';

  @override
  String get groupsLoadError =>
      'Kunde inte ladda grupperna. Dra för att försöka igen.';

  @override
  String groupsJoined(String pod) {
    return 'Gick med i $pod. Säg hej när du är redo.';
  }

  @override
  String get groupsJoinedNew =>
      'Gick med i en ny grupp. Säg hej när du är redo.';

  @override
  String get groupsNoPodFound =>
      'Kunde inte hitta en grupp just nu. Försök igen.';

  @override
  String groupsLeaveTitle(String pod) {
    return 'Lämna $pod?';
  }

  @override
  String get groupsLeave => 'Lämna';

  @override
  String groupsLeft(String pod) {
    return 'Du lämnade $pod.';
  }

  @override
  String get groupsLeaveError => 'Kunde inte lämna gruppen. Försök igen.';

  @override
  String get groupsHeader => 'Små grupper, snälla människor';

  @override
  String get groupsYourPods => 'DINA GRUPPER';

  @override
  String get groupsDiscoverPods => 'UPPTÄCK GRUPPER';

  @override
  String get groupsJoinAnother => 'Gå med i en annan grupp';

  @override
  String get groupsNoOthers => 'Inga andra grupper att gå med i just nu.';

  @override
  String groupsJoinedShort(String pod) {
    return 'Gick med i $pod.';
  }

  @override
  String get groupsJoin => 'Gå med';

  @override
  String get groupsPodOptions => 'Gruppalternativ';

  @override
  String get groupsLeavePod => 'Lämna gruppen';

  @override
  String groupsMembers(int count, int capacity) {
    return '$count/$capacity medlemmar';
  }

  @override
  String groupsTierPods(String tier, String pods) {
    return 'Med $tier kan du vara med i $pods.';
  }

  @override
  String groupsCapacityTierPods(int capacity, String tier, String pods) {
    return 'Upp till $capacity per grupp. Med $tier kan du vara med i $pods.';
  }

  @override
  String groupsInYourPods(String pods) {
    return 'Du är med i dina $pods';
  }

  @override
  String get groupsUpgradeBody =>
      'Skaffa Premium för att gå med i fler — månadsvis låser upp 3 grupper, årsvis så många du vill.';

  @override
  String get groupsSafetyLive =>
      'Var snäll. Du kan anmäla eller blockera vem som helst från deras profil. Låsta profiler förblir privata.';

  @override
  String get groupsSafetyPreview =>
      'Förhandsvisning. Grupperna blir live, modererade chattar när inloggning är konfigurerad.';

  @override
  String get groupsLeaveBody =>
      'Du slutar se den här gruppens meddelanden. Du kan gå med igen senare.';

  @override
  String get podRulesTitle => 'Gruppregler';

  @override
  String get podRulesIntro =>
      'Grupper fungerar bara om alla känner sig trygga. Genom att gå med godkänner du:';

  @override
  String get podRule1 => 'Var snäll. Alla här övar på något svårt.';

  @override
  String get podRule2 =>
      'Ingen trakasserier, hat eller skadligt innehåll. Aldrig.';

  @override
  String get podRule3 =>
      'Anmäl eller blockera vem som helst som får dig att känna dig obekväm.';

  @override
  String get podRule4 =>
      'Respektera integritet — det som delas här stannar här.';

  @override
  String get podRule5 =>
      'Grupper är stöd mellan likar, inte en krisjour. Vid en nödsituation, kontakta en professionell eller en lokal krislinje.';

  @override
  String get podRulesAgree => 'Jag godkänner — släpp in mig';

  @override
  String chatIntrosBeKind(int count, int capacity) {
    return '$count/$capacity introverta · var snäll';
  }

  @override
  String get chatHint => 'Säg något snällt…';

  @override
  String get chatPreviewBanner =>
      'Förhandsvisning · meddelanden stannar på din enhet tills vidare. Riktiga, modererade grupper kommer med konton.';

  @override
  String get chatYou => 'Du';

  @override
  String get reportHarassment => 'Trakasserier eller mobbning';

  @override
  String get reportHate => 'Hat eller skadligt språk';

  @override
  String get reportSpam => 'Spam eller bedrägeri';

  @override
  String get reportUnsafe => 'Får mig att känna mig otrygg';

  @override
  String get reportOther => 'Något annat';

  @override
  String get memberPrivateTitle => 'Privat profil';

  @override
  String get memberPrivateBody =>
      'Den här medlemmen håller sin profil privat. Du kan fortfarande chatta med dem — och anmäla eller blockera vid behov.';

  @override
  String memberStreak(int days) {
    return '$days dagars svit';
  }

  @override
  String memberChallenges(int count) {
    return '$count utmaningar';
  }

  @override
  String memberClimbing(String track) {
    return 'Klättrar: $track';
  }

  @override
  String get memberReport => 'Anmäl';

  @override
  String get memberBlock => 'Blockera';

  @override
  String get memberReportThanks => 'Tack — vi granskar detta.';

  @override
  String get memberBlockToo => 'Blockera också';

  @override
  String get memberBlocked => 'Blockerad. Du ser inte deras meddelanden.';

  @override
  String get memberBlockError => 'Kunde inte blockera. Försök igen.';

  @override
  String get memberReportError => 'Kunde inte skicka anmälan. Försök igen.';

  @override
  String get memberBlockConfirmTitle => 'Blockera den här medlemmen?';

  @override
  String get memberBlockConfirmBody =>
      'Ni ser inte varandras meddelanden. Du kan ångra detta senare.';

  @override
  String get memberSoonReporting =>
      'Anmälan aktiveras i modererade grupper (logga in för att använda den).';

  @override
  String get memberSoonBlocking =>
      'Blockering aktiveras i modererade grupper (logga in för att använda den).';

  @override
  String get memberWhatsWrong => 'Vad är fel?';

  @override
  String get memberFallback => 'Medlem';

  @override
  String get blockedUnblockError => 'Kunde inte avblockera. Försök igen.';

  @override
  String blockedUnblocked(String name) {
    return 'Avblockerade $name. Du ser deras meddelanden igen.';
  }

  @override
  String get blockedIntro =>
      'Blockering döljer en medlems meddelanden för dig — och dina för dem, åt båda hållen. Avblockera någon nedan för att ångra det.';

  @override
  String get blockedLabel => 'Blockerad';

  @override
  String get blockedUnblock => 'Avblockera';

  @override
  String get blockedEmptyTitle => 'Ingen blockerad';

  @override
  String get blockedEmptyBody =>
      'Du har inte blockerat någon. Blockering döljer en medlems meddelanden för dig, åt båda hållen — och du kan alltid ångra det här.';

  @override
  String get chatCheckInPosted => 'Bra jobbat. Gruppincheckning publicerad.';

  @override
  String get chatCheckInError => 'Kunde inte checka in just nu. Försök igen.';

  @override
  String get chatDeleteMsgTitle => 'Radera meddelande?';

  @override
  String get chatDeleteMsgBody => 'Detta tar bort det för alla i gruppen.';

  @override
  String get chatReply => 'Svara';

  @override
  String get chatEdit => 'Redigera';

  @override
  String get chatDailyPrompt => 'Daglig gruppfråga';

  @override
  String get chatCheckedInToday => 'Incheckad idag';

  @override
  String get chatDidMyStep => 'Jag gjorde mitt steg';

  @override
  String chatCheckedInCount(int count) {
    return '$count har checkat in';
  }

  @override
  String get chatNoMessages =>
      'Inga meddelanden än. Ett enkelt «hej» är ett modigt första steg.';

  @override
  String get chatEditingMessage => 'Redigerar ditt meddelande';

  @override
  String chatReplyingTo(String name) {
    return 'Svarar $name';
  }

  @override
  String get chatYourself => 'dig själv';

  @override
  String get chatMsgDeleted => 'Det här meddelandet har raderats';

  @override
  String get chatPrivateMember => 'Privat medlem';

  @override
  String chatBeKind(int count, int capacity) {
    return '$count/$capacity · var snäll';
  }

  @override
  String get chatDeletedMessageShort => 'raderat meddelande';

  @override
  String get gameYouWin => 'Du vinner! 🎉';

  @override
  String get gamePhoneWins => 'Telefonen vinner';

  @override
  String get gamePhoneThinking => 'Telefonen tänker…';

  @override
  String get gamePlayPhone => 'Spela mot telefonen';

  @override
  String get game2Players => '2 spelare';

  @override
  String get gameNewGame => 'Nytt spel';

  @override
  String get gameYou => 'Du';

  @override
  String get gamePhone => 'Telefon';

  @override
  String get gameDraws => 'Oavgjorda';

  @override
  String get tttP1Wins => 'Spelare 1 (X) vinner! 🎉';

  @override
  String get tttP2Wins => 'Spelare 2 (O) vinner! 🎉';

  @override
  String get tttYourTurn => 'Din tur';

  @override
  String get tttP1Turn => 'Spelare 1 · X';

  @override
  String get tttP2Turn => 'Spelare 2 · O';

  @override
  String get tttP1Label => 'S1 (X)';

  @override
  String get tttP2Label => 'S2 (O)';

  @override
  String get tttRule1 => 'Turas om att placera ditt märke på 3×3-rutnätet.';

  @override
  String get tttRule2 =>
      'Få tre av dina märken i rad — vågrätt, lodrätt eller diagonalt — för att vinna.';

  @override
  String get tttRule3 =>
      '«Spela mot telefonen» är du mot en enkel AI. «2 spelare» skickar telefonen varje tur.';

  @override
  String get c4P1Wins => 'Spelare 1 vinner! 🎉';

  @override
  String get c4P2Wins => 'Spelare 2 vinner! 🎉';

  @override
  String get c4Turn => 'Din tur — tryck på en kolumn';

  @override
  String get c4P1Turn => 'Spelare 1 · röd';

  @override
  String get c4P2Turn => 'Spelare 2 · gul';

  @override
  String get c4P1Label => 'S1';

  @override
  String get c4P2Label => 'S2';

  @override
  String get c4Rule1 =>
      'Tryck på en kolumn för att släppa din bricka — den faller till den lägsta lediga platsen.';

  @override
  String get c4Rule2 =>
      'Få fyra i rad av din färg — vågrätt, lodrätt eller diagonalt — för att vinna.';

  @override
  String get c4Rule3 =>
      '«Spela mot telefonen» är du mot en enkel AI. «2 spelare» skickar telefonen.';

  @override
  String get gameDraw => 'Det är oavgjort 🤝';

  @override
  String get gamePlayAgain => 'Spela igen';

  @override
  String get gameStart => 'Börja';

  @override
  String get g2048Rule1 =>
      'Svep upp, ner, vänster eller höger för att skjuta alla brickor.';

  @override
  String get g2048Rule2 =>
      'Två brickor med samma tal slås ihop till en som dubblas.';

  @override
  String get g2048Rule3 =>
      'Fortsätt slå ihop för att bygga en 2048-bricka. Brädet fylls — planera framåt!';

  @override
  String get g2048Score => 'Poäng';

  @override
  String get g2048Best => 'Bästa';

  @override
  String get g2048GameOver => 'Spelet är slut';

  @override
  String get g2048Won => 'Du gjorde 2048! 🎉';

  @override
  String get g2048SwipeToMerge => 'Svep för att slå ihop';

  @override
  String get qmRule1 => 'Du har 30 sekunder — lös så många du kan.';

  @override
  String get qmRule2 => 'Tryck på rätt svar bland de fyra valen.';

  @override
  String get qmRule3 => 'Ett felaktigt tryck kostar 2 sekunder, så läs noga.';

  @override
  String qmTimeScored(Object score) {
    return 'Tiden är ute! Du fick $score';
  }

  @override
  String qmBestSub(Object best) {
    return 'Bäst $best · 30 sekunder, svara på så många du kan.';
  }

  @override
  String get qmStartSub =>
      '30 sekunder. Ett felaktigt tryck kostar 2 sekunder.';

  @override
  String get qmCorrect => 'rätt';

  @override
  String get mmRule1 =>
      'Tryck på ett kort för att vända det, vänd sedan ett till.';

  @override
  String get mmRule2 =>
      'Om de två emojierna matchar ligger de kvar uppåt; annars vänds de tillbaka.';

  @override
  String get mmRule3 => 'Hitta alla par — på så få drag som möjligt.';

  @override
  String mmAllMatched(Object moves) {
    return 'Alla matchade på $moves drag! 🎉';
  }

  @override
  String mmFindPairs(Object moves) {
    return 'Hitta paren · $moves drag';
  }

  @override
  String mmBest(Object best) {
    return 'Bäst: $best drag';
  }

  @override
  String get mmShuffle => 'Blanda';

  @override
  String get rxTapStart => 'Tryck för att börja';

  @override
  String get rxWaitGreen => 'Vänta på grönt, tryck sedan snabbt';

  @override
  String get rxWait => 'Vänta…';

  @override
  String get rxTapMoment => 'Tryck i samma ögonblick som det blir grönt';

  @override
  String rxBestRetry(Object ms) {
    return 'Bäst $ms ms · tryck för att försöka igen';
  }

  @override
  String get rxTapRetry => 'Tryck för att försöka igen';

  @override
  String get rxTooSoon => 'För tidigt!';

  @override
  String get rxWaitRetry => 'Vänta på grönt · tryck för att försöka igen';

  @override
  String get rxTap => 'TRYCK!';

  @override
  String get rxRule1 =>
      'Tryck på skärmen för att börja, vänta sedan — den blir bärnstensfärgad.';

  @override
  String get rxRule2 =>
      'I samma ögonblick som den blir grön, tryck så snabbt du kan.';

  @override
  String get rxRule3 =>
      'Att trycka för tidigt nollställer. Lägre tid (ms) är bättre.';

  @override
  String get smWatchRepeat => 'Titta på mönstret och upprepa det sedan.';

  @override
  String get smWatch => 'Titta…';

  @override
  String smYourTurn(Object current, Object total) {
    return 'Din tur · $current av $total';
  }

  @override
  String smReachedBest(Object best, Object reached) {
    return 'Du nådde $reached · bäst $best';
  }

  @override
  String smReached(Object reached) {
    return 'Du nådde $reached';
  }

  @override
  String get smRule1 => 'Se hur brickorna lyser upp en efter en.';

  @override
  String get smRule2 =>
      'Upprepa exakt samma ordning genom att trycka på brickorna.';

  @override
  String get smRule3 =>
      'Varje runda lägger till ett steg — se hur långt du kommer.';

  @override
  String smRound(Object round) {
    return 'Runda $round';
  }

  @override
  String get safetyScreenTitle => 'Är det här rätt för mig?';

  @override
  String get safetyPracticeTitle => 'Rung är övning, inte terapi.';

  @override
  String get safetyIntro =>
      'Rung är ett verktyg för självförtroende och övning. Det hjälper dig att gradvis möta vardagliga sociala situationer, i din egen takt. Det är inte terapi, inte medicinsk behandling och inte en diagnos.';

  @override
  String get safetyPoint1 =>
      'Målet är hanterbar bävan — att känna dig mer bekväm i de stunder du brukade undvika. Inte att bli en annan person.';

  @override
  String get safetyPoint2 =>
      'Att hoppa över är alltid okej och räknas aldrig emot dig. Här finns inga skammekanismer.';

  @override
  String get safetyPoint3 =>
      'Dina data är dina. Allt fungerar offline, utan konto.';

  @override
  String get safetyMoreTitle => 'Om det här är mer än nervositet';

  @override
  String get safetyMoreBody =>
      'Om ångest allvarligt påverkar din vardag, eller om du någon gång har tankar på att skada dig själv, kontakta en kvalificerad professionell eller en lokal krislinje. Det är ett starkt, sunt steg — och Rung ersätter det inte.';

  @override
  String get legalLastUpdated => 'Senast uppdaterad: juni 2026';

  @override
  String legalQuestions(String email) {
    return 'Frågor? Kontakta oss på $email.';
  }

  @override
  String get privacyTitle => 'Integritetspolicy';

  @override
  String get privacyIntro =>
      'Rung är ett privat övningsverktyg för att bygga socialt självförtroende. Vi samlar in så lite som möjligt, och det mest personliga du skriver lämnar aldrig din telefon. Den här policyn förklarar vad vi lagrar och varför.';

  @override
  String get ppWhatStaysHead => 'Vad som stannar enbart på din enhet';

  @override
  String get ppWhatStaysBody =>
      'Dina reflektionsanteckningar och förutsägelseanteckningar — det privata du skriver om hur en stund kändes — lagras enbart i appen på din enhet. De laddas aldrig upp till våra servrar.';

  @override
  String get ppCloudHead => 'Vad vi lagrar i molnet';

  @override
  String get ppCloudBody =>
      'När du skapar ett konto lagrar vi: din e-postadress (för inloggning; ditt lösenord är krypterat och vi ser det aldrig), ett valfritt visningsnamn och en bio, samt din integritetslåsinställning. För att driva gemenskapen («grupper») lagrar vi de meddelanden du publicerar och eventuella blockeringar eller anmälningar du gör. För att hålla dina framsteg trygga över enheter säkerhetskopierar vi endast siffror — din svit, avklarade utmaningar och ångestskattningar (förutsagt vs faktiskt) — plus egna steg du skapar. Anteckningstext inkluderas aldrig.';

  @override
  String get ppAnalyticsHead => 'Analys';

  @override
  String get ppAnalyticsBody =>
      'Vi använder integritetsrespekterande produktanalys (PostHog) för att förstå vilka funktioner som hjälper, med anonyma användningshändelser som «öppnade en skärm» eller «slutförde ett steg». Vi skickar aldrig innehållet i dina anteckningar eller meddelanden till analysen.';

  @override
  String get ppUseHead => 'Hur vi använder dina uppgifter';

  @override
  String get ppUseBody =>
      'Endast för att tillhandahålla appen: logga in dig, driva grupperna, återställa dina framsteg och förbättra Rung med aggregerade, anonyma trender. Vi säljer inte dina data och använder dem inte för annonsering.';

  @override
  String get ppProcessHead => 'Vem som behandlar dina data';

  @override
  String get ppProcessBody =>
      'Vi använder Supabase (autentisering, databas och drift) och PostHog (analys) som personuppgiftsbiträden. De hanterar data för vår räkning under sina egna säkerhets- och integritetsåtaganden.';

  @override
  String get ppRightsHead => 'Dina rättigheter och val';

  @override
  String get ppRightsBody =>
      'Du kan redigera din profil, låsa den så att andra medlemmar inte kan se den, och permanent radera ditt konto och all tillhörande molndata när som helst via Profil → Radera konto. Du kan också mejla oss för att begära tillgång till eller radering av dina data.';

  @override
  String get ppSecurityHead => 'Säkerhet och lagring';

  @override
  String get ppSecurityBody =>
      'Data krypteras under överföring, och varje tabell skyddas av säkerhet på radnivå så att du bara kan komma åt dina egna data (och gruppmeddelanden där du är medlem). Vi behåller dina data tills du raderar ditt konto eller ber oss ta bort dem.';

  @override
  String get ppChildrenHead => 'Barn';

  @override
  String get ppChildrenBody =>
      'Rung är inte avsett för någon under 16 år. Om du tror att ett barn har skapat ett konto, kontakta oss så tar vi bort det.';

  @override
  String get ppMedicalHead => 'Inte medicinsk vård';

  @override
  String get ppMedicalBody =>
      'Rung stödjer gradvis övning men är inte terapi, diagnos eller medicinsk rådgivning. Om du är i kris, kontakta din lokala räddningstjänst eller en krislinje.';

  @override
  String get ppChangesHead => 'Ändringar';

  @override
  String get ppChangesBody =>
      'Om vi uppdaterar den här policyn ändrar vi datumet ovan och, vid väsentliga ändringar, meddelar vi dig i appen.';

  @override
  String get termsTitle => 'Användarvillkor';

  @override
  String get termsIntro =>
      'Dessa villkor är avtalet mellan dig och Rung när du använder appen. Genom att skapa ett konto eller använda Rung godkänner du dem.';

  @override
  String get tosMedicalHead => 'Inte en medicinsk tjänst';

  @override
  String get tosMedicalBody =>
      'Rung är ett självhjälps- och övningsverktyg, inte terapi eller medicinsk vård, och ersätter inte professionell hjälp. Det kan inte garantera något visst resultat. Om du är i kris eller kan skada dig själv eller andra, kontakta din lokala räddningstjänst omedelbart.';

  @override
  String get tosEligibilityHead => 'Behörighet';

  @override
  String get tosEligibilityBody =>
      'Du måste vara minst 16 år för att använda Rung och ha rätt att godkänna dessa villkor.';

  @override
  String get tosAccountHead => 'Ditt konto';

  @override
  String get tosAccountBody =>
      'Håll dina inloggningsuppgifter säkra — du ansvarar för aktivitet på ditt konto. Meddela oss omgående om du misstänker obehörig användning.';

  @override
  String get tosCommunityHead => 'Gemenskapsregler (grupper)';

  @override
  String get tosCommunityBody =>
      'Grupper är till för vänlighet och stöd. Du godkänner att inte trakassera, hota, förnedra, spamma eller publicera hatiskt eller olagligt innehåll, och att inte dela andras privata information. Vi kan ta bort innehåll eller stänga av konton som bryter mot dessa regler. Du kan blockera och anmäla andra medlemmar när som helst.';

  @override
  String get tosContentHead => 'Innehåll du publicerar';

  @override
  String get tosContentBody =>
      'Du behåller äganderätten till det du skriver. Genom att publicera i en grupp ger du oss tillåtelse att lagra det och visa det för medlemmarna i gruppen så att gemenskapen fungerar. Publicera inget du inte har rätt att dela.';

  @override
  String get tosSubsHead => 'Prenumerationer';

  @override
  String get tosSubsBody =>
      'Vissa funktioner och extra övningsinnehåll är tillgängliga med en betald prenumeration. När fakturering är aktiv hanteras köp och förnyelser av appbutiken, och du kan hantera eller avsluta via ditt appbutikskonto. Priser och innehåll kan ändras med förvarning.';

  @override
  String get tosDisclaimerHead => 'Friskrivningar och ansvar';

  @override
  String get tosDisclaimerBody =>
      'Rung tillhandahålls «i befintligt skick», utan garantier av något slag. I den utsträckning lagen tillåter ansvarar vi inte för indirekta skador eller följdskador som uppstår vid din användning av appen.';

  @override
  String get tosEndingHead => 'Avsluta din användning';

  @override
  String get tosEndingBody =>
      'Du kan radera ditt konto när som helst via Profil → Radera konto. Vi kan stänga av eller avsluta åtkomst om dessa villkor bryts allvarligt eller upprepat.';

  @override
  String get tosChangesHead => 'Ändringar';

  @override
  String get tosChangesBody =>
      'Vi kan uppdatera dessa villkor; vi uppdaterar datumet ovan och, vid betydande ändringar, meddelar dig i appen. Fortsatt användning av Rung innebär att du godkänner de uppdaterade villkoren.';

  @override
  String get breatheCta => 'Känner du bävan? Andas först';

  @override
  String get breatheIntro => 'Sextio sekunder. Följ bara cirkeln.';

  @override
  String get breatheIn => 'Andas in';

  @override
  String get breatheHold => 'Håll';

  @override
  String get breatheOut => 'Andas ut';

  @override
  String get breatheSkip => 'Hoppa över';

  @override
  String get breatheDoneTitle => 'Så var det.';

  @override
  String get breatheDoneSub =>
      'Känns det lite stadigare? Gör ditt steg när du är redo.';

  @override
  String get breatheDoneBtn => 'Klar';

  @override
  String get insightsDeeperTitle => 'Djupare insikter';

  @override
  String get insightsLockedBody =>
      'Se din månad i ett ögonkast — hur mycket hetare din rädsla gick än verkligheten, och hur ofta du överskattade den. En Premium-förmån.';

  @override
  String get insightsUnlockCta => 'Lås upp med Premium';

  @override
  String get insightsNoSteps =>
      'Inga steg noterade den här månaden än. Möt ett par, så dyker din sammanfattning upp här.';

  @override
  String get insightsFearsFacedMonth => 'rädslor mötta den här månaden';

  @override
  String insightsGapHotter(String points) {
    return 'Din rädsla gick i snitt $points punkter hetare än verkligheten.';
  }

  @override
  String get insightsGapTougher =>
      'Verkligheten var lite tuffare än du förutsåg den här månaden — det är också modiga data.';

  @override
  String get insightsGapSpotOn =>
      'Dina förutsägelser var ganska precisa den här månaden.';

  @override
  String insightsOverPredicted(int rate) {
    return 'Du överskattade rädslan $rate% av gångerna.';
  }

  @override
  String get insightsTrendSame => 'Samma som förra månaden';

  @override
  String insightsTrendMore(int count) {
    return '$count fler än förra månaden';
  }

  @override
  String insightsTrendFewer(int count) {
    return '$count färre än förra månaden';
  }

  @override
  String get rateTitle => 'Gillar du Rung?';

  @override
  String get ratePromptNone => 'Hur känns Rung för dig?';

  @override
  String get ratePromptLow => 'Tråkigt att det inte funkar. Vad saknas?';

  @override
  String get ratePromptMid => 'Tack — vad skulle göra det till en 5:a?';

  @override
  String get ratePromptHigh => 'Det betyder mycket. Vad gillar du?';

  @override
  String get rateHintLove => 'Något du gillar? (valfritt)';

  @override
  String get rateHintMore => 'Berätta mer (valfritt)';

  @override
  String get rateSend => 'Skicka';

  @override
  String get rateThanksHigh => 'Tack — det hjälper verkligen. 🌱';

  @override
  String get rateThanksLow =>
      'Tack för ärligheten — vi använder den för att bli bättre.';

  @override
  String get editProfileTitle => 'Redigera profil';

  @override
  String get editDisplayName => 'Visningsnamn';

  @override
  String get editDisplayNameHint => 'Vad ska grupperna kalla dig?';

  @override
  String get editBio => 'Kort bio (valfritt)';

  @override
  String get editBioHint =>
      'En rad om dig — hålls privat om du låser din profil.';

  @override
  String get errorOffline =>
      'Du är offline. Anslut till internet och försök igen.';

  @override
  String get errorGeneric => 'Något gick fel. Försök igen.';

  @override
  String get errorSaveFailed =>
      'Kunde inte spara — din enhet kan ha lite lagring. Frigör utrymme och försök igen.';
}
