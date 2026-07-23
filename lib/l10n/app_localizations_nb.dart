// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Bokmål (`nb`).
class AppLocalizationsNb extends AppLocalizations {
  AppLocalizationsNb([String locale = 'nb']) : super(locale);

  @override
  String get navHome => 'Hjem';

  @override
  String get navGroups => 'Grupper';

  @override
  String get navPremium => 'Premium';

  @override
  String get navProfile => 'Profil';

  @override
  String get greetingMorning => 'God morgen';

  @override
  String get greetingAfternoon => 'God ettermiddag';

  @override
  String get greetingEvening => 'God kveld';

  @override
  String get todayStepIntro => 'Her er ett lite steg for i dag.';

  @override
  String get commonContinue => 'Fortsett';

  @override
  String get commonCancel => 'Avbryt';

  @override
  String get commonSave => 'Lagre';

  @override
  String get commonDone => 'Ferdig';

  @override
  String get commonNotNow => 'Ikke nå';

  @override
  String get profileTitle => 'Profil';

  @override
  String get language => 'Språk';

  @override
  String get languageSystemDefault => 'Systemspråk';

  @override
  String get yourTone => 'Din tone';

  @override
  String get appearance => 'Utseende';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Lyst';

  @override
  String get themeDark => 'Mørkt';

  @override
  String get onbSkip => 'Hopp over';

  @override
  String get onbWelcomeTitle =>
      'Møt øyeblikkene du pleide å grue deg til — ett lite steg om gangen.';

  @override
  String get onbWelcomeBody =>
      'Rung hjelper deg å bygge sosial selvtillit gjennom mild, privat øving. Forutsi, gjør det, reflekter — og se din verste frykt falle fra hverandre i dine egne tall.';

  @override
  String get onbGetStarted => 'Kom i gang';

  @override
  String get onbSafetyTitle => 'Øving, ikke terapi.';

  @override
  String get onbUnderstand => 'Jeg forstår';

  @override
  String get onbSafetyBody1 =>
      'Rung er et verktøy for selvtillit og øving — ikke terapi, ikke medisinsk behandling og ikke en diagnose.';

  @override
  String get onbSafetyBody2 =>
      'Målet er å føle deg mer komfortabel i øyeblikk du pleide å grue deg til — ikke å bli noen du ikke er. Å hoppe over er alltid greit.';

  @override
  String get onbSafetyCrisis =>
      'Hvis angst påvirker livet ditt alvorlig, eller du noen gang har tanker om å skade deg selv, ta kontakt med en fagperson eller en lokal krisetelefon.';

  @override
  String get onbFearTitle => 'Hvor vil du begynne?';

  @override
  String get onbFearBody =>
      'Bare som forslag til et første steg — du kan klatre hvilken som helst av disse når som helst. Ingenting her binder deg.';

  @override
  String get onbExploreOwn => 'Jeg utforsker heller på egen hånd';

  @override
  String get onbToneTitle => 'Hva ligner mest på deg?';

  @override
  String get onbToneIntrovertTitle => 'Jeg er mer en introvert';

  @override
  String get onbToneIntrovertBody =>
      'Jeg vil føle meg komfortabel, ikke bli en annen person.';

  @override
  String get onbToneSituationalTitle =>
      'Jeg blir engstelig i visse situasjoner';

  @override
  String get onbToneSituationalBody =>
      'Noen ganger er jeg utadvendt, men visse øyeblikk får meg ut av balanse.';

  @override
  String get onbToneFootnote => 'Du kan endre dette når som helst i Profil.';

  @override
  String get onbHowTitle => 'Slik fungerer det.';

  @override
  String get onbStartClimbing => 'Begynn å klatre';

  @override
  String get onbStep1 => 'Forutsi hvor ille det vil føles (0–10).';

  @override
  String get onbStep2 => 'Gjør det i virkeligheten — appen kan være lukket.';

  @override
  String get onbStep3 => 'Kom tilbake og noter hvordan det faktisk gikk.';

  @override
  String get onbGentleFirstStep => 'ET MILDT FØRSTE STEG';

  @override
  String get onbGoodPlaceToStart => 'ET GODT STED Å BEGYNNE';

  @override
  String get onbAllAreas =>
      'Alle seks områdene er på startskjermen din — begynn hvor du vil.';

  @override
  String get predictAppBar => 'Før du går';

  @override
  String get predictSaved =>
      'Lagret. Gå og gjør det — kom så tilbake og noter hvordan det gikk.';

  @override
  String get predictQuestion => 'Hvor ille tror du dette blir?';

  @override
  String get predictNoteLabel => 'Hva tror du skjer? (valgfritt)';

  @override
  String get predictNoteHint => 'f.eks. De vil synes jeg er klønete';

  @override
  String get predictCompare =>
      'Vi sammenligner dette med hvordan det faktisk går. Det gapet er hele poenget.';

  @override
  String get predictDoIt => 'Jeg gjør det';

  @override
  String get reflectAppBar => 'Hvordan gikk det?';

  @override
  String get reflectDidYouDoIt => 'Gjorde du det?';

  @override
  String get reflectHowAnxious => 'Hvor engstelig føltes bare tanken på det?';

  @override
  String get reflectHowBad => 'Hvor ille var det, egentlig?';

  @override
  String get reflectNoteLabel => 'Noe du vil huske? (valgfritt)';

  @override
  String get reflectOutcomeDone => 'Gjort';

  @override
  String get reflectOutcomePartial => 'Delvis';

  @override
  String get reflectOutcomeNotToday => 'Ikke i dag';

  @override
  String get resultQuietDelight => 'Stille glede i hvert steg.';

  @override
  String get resultBackToLadder => 'Tilbake til stigen';

  @override
  String resultGapHeadline(int predicted, int actual) {
    return 'Du forberedte deg på $predicted. Det ble $actual.';
  }

  @override
  String resultGapSub(int predicted, int actual) {
    return 'Hjertet ditt forberedte seg på en tung $predicted, men verden møtte deg med en mildere $actual. Verdt å huske.';
  }

  @override
  String get resultRightHeadline => 'Akkurat som du gjettet.';

  @override
  String get resultRightSub =>
      'Du hadde rett — og du møtte likevel opp. Det er seieren.';

  @override
  String get resultTougherHeadline =>
      'Tøffere enn du gjettet — og du gjorde det.';

  @override
  String get resultTougherSub =>
      'Noen øyeblikk krever mer av oss. Å møte opp likevel er hele poenget.';

  @override
  String get resultPredicted => 'Forutsagt';

  @override
  String get resultActual => 'Faktisk';

  @override
  String resultLighter(int reduction) {
    return 'Dette øyeblikket var $reduction% lettere enn du fryktet';
  }

  @override
  String get resultSkippedHeadline => 'Notert — ingen press.';

  @override
  String get resultSkippedSub =>
      '«Ikke i dag» er et helt greit svar. Dette trinnet står her når du er klar.';

  @override
  String get resultWinCopied => 'Seieren kopiert — lim den inn hvor du vil.';

  @override
  String get resultCopyWin => 'Kopier seieren min';

  @override
  String resultShareText(String rung) {
    return 'Jeg gjorde nettopp noe jeg pleide å unngå: $rung. Ett lite trinn klatret. 🪜 #Rung';
  }

  @override
  String get tracksTitle => 'Dine spor';

  @override
  String get tracksSubtitle => 'Små steg mot stor selvtillit.';

  @override
  String get menuInsights => 'Innsikt';

  @override
  String get menuIsThisRight => 'Er dette riktig for meg?';

  @override
  String tracksRungsCount(int done, int total) {
    return '$done av $total trinn';
  }

  @override
  String tracksClimbedCount(int done, int total) {
    return '$done av $total klatret';
  }

  @override
  String get tracksContinueLabel => 'FORTSETT DER DU SLAPP';

  @override
  String get tracksNextStepLabel => 'DITT NESTE STEG';

  @override
  String get tracksLoadError => 'Kunne ikke laste sporene.';

  @override
  String get todayResume => 'Fortsett der du slapp';

  @override
  String get todayNext => 'Ditt neste steg';

  @override
  String get todayVariety => 'Noe litt annerledes';

  @override
  String get todayFresh => 'Ditt startpunkt';

  @override
  String get todayResumeCta => 'Fullfør noteringen';

  @override
  String get todayStartCta => 'Start';

  @override
  String todayMinutes(int min) {
    return '~$min min';
  }

  @override
  String get dashShareTooltip => 'Del fremgangen min';

  @override
  String get dashWeeklyGoal => 'Ukesmål';

  @override
  String dashStepsPerWeek(int count) {
    return '$count steg/uke';
  }

  @override
  String dashGoalPerWeek(int count) {
    return '$count/uke';
  }

  @override
  String dashWeeklyProgress(int done, int goal) {
    return '$done av $goal steg fullført denne uken';
  }

  @override
  String get dashYourGrowth => 'Din vekst';

  @override
  String get dashTodayError =>
      'Kunne ikke laste dagens steg. Dra for å prøve igjen.';

  @override
  String get dashTodayAllClear =>
      'Du har fullført alt tilgjengelig — legg til et eget trinn eller gjør ett om igjen for å holde rekken i gang.';

  @override
  String get dashTakeABreak => 'Ta en pause';

  @override
  String get dashTakeABreakSub =>
      'Noen rolige spill — mot telefonen eller med en venn.';

  @override
  String get ladderTitleFallback => 'Stige';

  @override
  String get ladderLoadError => 'Kunne ikke laste stigen.';

  @override
  String get ladderAddOwn => 'Legg til ditt eget trinn';

  @override
  String ladderOfClimbed(int total) {
    return 'av $total klatret';
  }

  @override
  String get detailLoadError => 'Kunne ikke laste.';

  @override
  String get detailNotExist => 'Dette trinnet finnes ikke lenger.';

  @override
  String get detailWhatToDo => 'Hva du skal gjøre';

  @override
  String get detailWhyHelps => 'Hvorfor dette hjelper';

  @override
  String get detailPastAttempts => 'Dine tidligere forsøk';

  @override
  String get detailDoThis => 'Jeg gjør dette';

  @override
  String get detailReattempt =>
      'Å prøve igjen oppfordres — det bygger dataene dine.';

  @override
  String detailHistoryStat(int predicted, int actual) {
    return 'forutsagt $predicted · faktisk $actual';
  }

  @override
  String customLimitPremium(int cap) {
    return 'Du har nådd denne månedens grense på $cap egne trinn — den nullstilles neste måned.';
  }

  @override
  String get customLimitFree =>
      'Gratisplanen inkluderer 5 egne trinn — oppgrader for flere hver måned.';

  @override
  String get customDefaultWhat => 'En utfordring du setter for deg selv.';

  @override
  String get customDefaultWhy =>
      'Du satte ord på den — det er det som gjør at den teller.';

  @override
  String get customSubtitle =>
      'Din situasjon er spesiell — dette trinnet er bare for deg.';

  @override
  String get customWhatLabel => 'Hva skal du gjøre?';

  @override
  String get customWhatHint => 'f.eks. Be lederen min om tilbakemelding';

  @override
  String get customNoteLabel => 'En notat til deg selv (valgfritt)';

  @override
  String customDifficulty(int value) {
    return 'Hvor vanskelig føles det? $value/10';
  }

  @override
  String get customAddToLadder => 'Legg til i stigen';

  @override
  String get paywallSwitchToFree => 'Bytt til Gratis';

  @override
  String get paywallHeroTitle => 'Du trenger ikke møte det alene.';

  @override
  String get paywallHeroBody =>
      'Den daglige øvingen er alltid gratis. Premium legger til en privat coach på ditt lag — og et større fellesskap ved din side — for når du er klar til å gå videre.';

  @override
  String get paywallWhatsIncluded => 'Hva som er inkludert';

  @override
  String get paywallPlusHeader => 'I tillegg får hver abonnent';

  @override
  String get paywallBenefitCoach =>
      'En privat coach, når som helst — øv på noe som kommer eller snakk gjennom hvordan det gikk';

  @override
  String get paywallBenefitPods =>
      'Du gjør ikke dette alene — bli med i flere støttegrupper (3 på månedlig, ubegrenset på årlig)';

  @override
  String get paywallBenefitCustom =>
      'Bygg ubegrenset med egne stiger — ingen grense for egne trinn';

  @override
  String get paywallBenefitDepth =>
      'Gå dypere når du er klar — opptil 40 steg per spor (gratis er en full bue på 10 steg)';

  @override
  String get paywallPlusStreak =>
      'Rekkebeskyttelse — en tapt dag bryter ikke rekken din';

  @override
  String get paywallPlusInsights => 'Dypere innsikt — måneden din på et blikk';

  @override
  String get paywallPlusShare => 'Personlige stiler for delekort';

  @override
  String get paywallPlusPrivacy => 'Alltid privat, alltid reklamefritt';

  @override
  String get paywallYearly => 'Årlig';

  @override
  String get paywallPerYear => 'per år · best verdi';

  @override
  String get paywallSave => 'Spar 33%';

  @override
  String get paywallMonthly => 'Månedlig';

  @override
  String get paywallPerMonth => 'per måned';

  @override
  String get paywallSwitchYearly => 'Bytt til årlig';

  @override
  String get paywallSwitchMonthly => 'Bytt til månedlig';

  @override
  String paywallStartYearly(String price) {
    return 'Start årlig — $price';
  }

  @override
  String paywallStartMonthly(String price) {
    return 'Start månedlig — $price';
  }

  @override
  String get paywallRestore => 'Gjenopprett kjøp';

  @override
  String paywallCurrentPlan(String plan) {
    return 'Nåværende plan: $plan. Avslutt når som helst.';
  }

  @override
  String get paywallCancelAnytime =>
      'Avslutt når som helst. Kjernen forblir gratis for alltid.';

  @override
  String get paywallSimulated =>
      'Premium aktivt (simulert — legg til RevenueCat-nøkler for ekte kjøp).';

  @override
  String get paywallPlanUnavailable =>
      'Den planen er ikke tilgjengelig nå. Prøv igjen snart.';

  @override
  String get paywallThankYou => 'Premium aktivt — takk. 🌱';

  @override
  String get paywallPurchaseFailed =>
      'Kjøpet ble ikke fullført. Du er ikke belastet.';

  @override
  String get paywallRestored => 'Kjøp gjenopprettet.';

  @override
  String get paywallNoRestore =>
      'Ingen tidligere kjøp funnet på denne kontoen.';

  @override
  String get paywallRestoreFailed =>
      'Kunne ikke gjenopprette nå. Prøv igjen snart.';

  @override
  String get profileAddName => 'Legg til navnet ditt';

  @override
  String get profileLockTitle => 'Lås profilen min';

  @override
  String get profileLockedSub =>
      'Skjult — gruppemedlemmer kan ikke åpne detaljene dine.';

  @override
  String get profileUnlockedSub =>
      'Gruppemedlemmer kan trykke på avataren din for å se detaljene dine.';

  @override
  String get profilePlanTitle => 'Din plan';

  @override
  String get profilePremium => 'Premium';

  @override
  String get profileUpgrade => 'Oppgrader';

  @override
  String get profileToneDesc =>
      'Rung snakker mildt som standard. Hvis angsten din er mer situasjonsbetinget, kan en litt dristigere tone passe deg bedre.';

  @override
  String get profileToneIntrovert => 'Introvert';

  @override
  String get profileToneSituational => 'Situasjonsbetinget';

  @override
  String get profileSafetySub =>
      'Hvordan Rung passer inn — og når du bør søke mer';

  @override
  String get profileBlockedTitle => 'Blokkerte medlemmer';

  @override
  String get profileBlockedSub =>
      'Se og opphev blokkering av personer du har blokkert';

  @override
  String get profileRestoreTitle => 'Gjenopprett fremgangen min';

  @override
  String get profileRestoreSub => 'Hent rekken og utfordringene dine fra skyen';

  @override
  String get profileRestoring => 'Gjenoppretter…';

  @override
  String get profileRestoreOk => 'Fremgang gjenopprettet fra skyen.';

  @override
  String profileRestoreFail(String error) {
    return 'Gjenoppretting mislyktes: $error';
  }

  @override
  String get profileLogout => 'Logg ut';

  @override
  String get profileChangePwTitle => 'Bytt passord';

  @override
  String get profileChangePwSub => 'Lag et nytt passord for kontoen din';

  @override
  String get profileChangePwSaved => 'Passordet er oppdatert';

  @override
  String get profileSignedIn => 'Innlogget';

  @override
  String get profileLogoutConfirmTitle => 'Logge ut?';

  @override
  String get profileLogoutConfirmBody =>
      'Fremgangen din er lagret i skyen og kommer tilbake når du logger inn igjen.';

  @override
  String get profileLoggingOut => 'Logger ut…';

  @override
  String get profileRateTitle => 'Vurder Rung';

  @override
  String get profileRateSub =>
      'Fortell oss hvordan det går — det hjelper virkelig';

  @override
  String get profilePrivacyTitle => 'Personvernerklæring';

  @override
  String get profilePrivacySub =>
      'Hva vi lagrer — og hva som blir på enheten din';

  @override
  String get profileTermsTitle => 'Vilkår for bruk';

  @override
  String get profileTermsSub => 'Avtalen for å bruke Rung';

  @override
  String get profileDeleteTitle => 'Slett konto';

  @override
  String get profileDeleteSub => 'Slett kontoen og dataene dine permanent';

  @override
  String get profileFooter =>
      'Rung · øving, ikke terapi. Dataene dine er dine.';

  @override
  String get profileDeleteConfirmTitle => 'Slette konto?';

  @override
  String get profileDeleteConfirmBody =>
      'Dette sletter permanent kontoen din, gruppemeldingene dine og lagret fremgang. Dette kan ikke angres.';

  @override
  String get profileDelete => 'Slett';

  @override
  String get profileDeleting => 'Sletter kontoen din…';

  @override
  String get profileDeleteFail => 'Kunne ikke slette kontoen din. Prøv igjen.';

  @override
  String get profileBioPlaceholder => 'En stille klatrer.';

  @override
  String get profileHaptics => 'Vibrasjon';

  @override
  String get profileHapticsSub => 'Mild vibrasjon ved trykk og seiere';

  @override
  String get profileAnalytics => 'Del anonyme bruksdata';

  @override
  String get profileAnalyticsSub =>
      'Hjelper med å forbedre Rung. Aldri personopplysninger.';

  @override
  String get profileNotifications => 'Varsler';

  @override
  String get profileNotificationsSub => 'Varsler fra Rung på denne enheten';

  @override
  String get profilePodAlerts => 'Varsler om gruppemeldinger';

  @override
  String get profilePodAlertsSub => 'Si fra når noen skriver i gruppene mine';

  @override
  String get profileEnableNotifs =>
      'Slå på varsler i Innstillinger for å få påminnelser.';

  @override
  String get profileReminderHelp => 'Når skal vi dytte deg litt?';

  @override
  String get profileReminderTitle => 'Mild daglig påminnelse';

  @override
  String profileReminderOn(String time) {
    return 'Hver dag kl. $time · trykk på bryteren for å slå av';
  }

  @override
  String get profileReminderOff =>
      'Et rolig, skyldfritt dytt til å ta ett lite steg';

  @override
  String get profileAvatarTitle => 'Velg avataren din';

  @override
  String get profileAvatarSub =>
      'Bare du kan endre den — gruppekameratene dine ser den også.';

  @override
  String get commonClose => 'Lukk';

  @override
  String get checkInMoodCalm => 'Rolig';

  @override
  String get checkInMoodOkay => 'Greit';

  @override
  String get checkInMoodAnxious => 'Engstelig';

  @override
  String get checkInMoodLow => 'Nedfor';

  @override
  String get checkInMoodTense => 'Anspent';

  @override
  String get checkInTitle => 'Hvordan ankommer du i dag?';

  @override
  String get checkInDismiss => 'Avvis';

  @override
  String get checkInCalmCta => 'Prøv et rolig øyeblikk';

  @override
  String get checkInStepCta => 'Se dagens steg';

  @override
  String get supportTitle => 'Det høres ut som mye å bære.';

  @override
  String get supportBody =>
      'Rung er et øvingsverktøy, ikke en krisetjeneste. Hvis du går gjennom noe tungt, ta kontakt med noen som kan hjelpe deg nå — en du stoler på, eller en lokal krisetelefon. Du fortjener ekte støtte.';

  @override
  String get supportResources => 'Se støtteressurser';

  @override
  String get progressChallenges => 'Utfordringer';

  @override
  String get progressCurrentStreak => 'Nåværende rekke';

  @override
  String get progressBestStreak => 'Beste rekke';

  @override
  String get progressThisWeek => 'Denne uken';

  @override
  String get progressCategoryBreakdown => 'Fordeling per kategori';

  @override
  String get insightsHistory => 'Historikk';

  @override
  String checkInAckTitle(String mood) {
    return 'Sjekket inn — du føler deg $mood';
  }

  @override
  String get checkInAckGentle =>
      'Takk for ærligheten. La oss holde i dag mildt — én liten, vennlig ting er nok.';

  @override
  String get checkInAckStep =>
      'Herlig. Når du er klar, holder ett lite steg farten oppe.';

  @override
  String get sharePremiumPerk => '✨ Flere kortstiler er en Premium-fordel.';

  @override
  String get shareSeePremium => 'Se Premium';

  @override
  String get shareText => 'Små modige steg, ett trinn om gangen. 🌱 #Rung';

  @override
  String get shareError => 'Kunne ikke åpne deling. Prøv igjen.';

  @override
  String get shareTitle => 'Del fremgangen din';

  @override
  String get shareSubtitle => 'Bare tallene dine — ingenting privat.';

  @override
  String get shareCta => 'Del';

  @override
  String get shareCardHeadline => 'Mine modige steg';

  @override
  String get shareCardFearsFaced => 'møter med frykten';

  @override
  String get shareCardCurrentStreak => 'Nåværende rekke';

  @override
  String get shareCardBestStreak => 'Beste rekke';

  @override
  String get shareCardTagline => 'Møte sosial frykt, ett lite trinn om gangen.';

  @override
  String get helpNow => 'Hjelp nå';

  @override
  String get helpCalmMoment => 'Et rolig øyeblikk';

  @override
  String get helpTabBreathe => 'Pust';

  @override
  String get helpTabGround => 'Jording';

  @override
  String get helpTabSay => 'Si dette';

  @override
  String get helpBreatheIn => 'Pust inn…';

  @override
  String get helpBreatheOut => 'Pust ut…';

  @override
  String get helpBreatheHint => 'Følg sirkelen. Det haster ikke.';

  @override
  String get helpGround5 => 'ting du kan se';

  @override
  String get helpGround4 => 'ting du kan ta på';

  @override
  String get helpGround3 => 'ting du kan høre';

  @override
  String get helpGround2 => 'ting du kan lukte';

  @override
  String get helpGround1 => 'ting du kan smake';

  @override
  String get helpGroundTitle => 'Nevn, stille for deg selv…';

  @override
  String get helpGroundHint =>
      'Dette bringer deg tilbake til nå — der du er trygg.';

  @override
  String get helpOpener1 => 'Hvordan kjenner du folkene her?';

  @override
  String get helpOpener2 => 'Jeg elsker dette stedet — har du vært her før?';

  @override
  String get helpOpener3 =>
      'Jeg er håpløs med navn — kan du minne meg på ditt?';

  @override
  String get helpOpener4 => 'Hva har du drevet med denne uken?';

  @override
  String get helpExit1 =>
      'Jeg skal hente noe å drikke — det var hyggelig å snakke med deg.';

  @override
  String get helpExit2 =>
      'Jeg må hilse raskt på noen, unnskyld meg et øyeblikk.';

  @override
  String get helpExit3 => 'Jeg lar deg mingle videre — vi ses senere.';

  @override
  String get helpOpenersTitle => 'Enkle åpningsreplikker';

  @override
  String get helpExitsTitle => 'Elegante avskjeder';

  @override
  String get authEnterEmail => 'Skriv inn e-posten din';

  @override
  String get authBadEmail => 'Den e-posten ser ikke riktig ut';

  @override
  String get authEnterPassword => 'Skriv inn et passord';

  @override
  String get authMin6 => 'Minst 6 tegn';

  @override
  String get authPwMismatch => 'Passordene stemmer ikke overens';

  @override
  String get authConfirmEmail =>
      'Sjekk e-posten din for å bekrefte, og logg deretter inn. (Eller slå av e-postbekreftelse i Supabase Auth-innstillingene for rask testing.)';

  @override
  String get authGenericError => 'Noe gikk galt. Prøv igjen.';

  @override
  String get authCreateTitle => 'Opprett kontoen din';

  @override
  String get authWelcomeBack => 'Velkommen tilbake';

  @override
  String get authSignUpSub =>
      'Bli med i gruppene og hold fremgangen din trygg på tvers av enheter.';

  @override
  String get authSignInSub =>
      'Logg inn på gruppene dine og synkronisert fremgang.';

  @override
  String get authDisplayName => 'Visningsnavn (valgfritt)';

  @override
  String get authEmail => 'E-post';

  @override
  String get authPassword => 'Passord';

  @override
  String get authShowPassword => 'Vis passord';

  @override
  String get authHidePassword => 'Skjul passord';

  @override
  String get authConfirmPassword => 'Bekreft passord';

  @override
  String get authForgotPassword => 'Glemt passord?';

  @override
  String get authResetTitle => 'Tilbakestill passord';

  @override
  String get authResetBody =>
      'Skriv inn e-posten til kontoen din, så sender vi deg en lenke for å lage et nytt passord.';

  @override
  String get authResetSend => 'Send lenke';

  @override
  String get authResetSent =>
      'Hvis den e-posten har en konto, er lenken allerede på vei.';

  @override
  String get authNewPassword => 'Nytt passord';

  @override
  String get authConfirmNewPassword => 'Bekreft nytt passord';

  @override
  String get authUpdatePasswordCta => 'Oppdater passord';

  @override
  String get authCreateCta => 'Opprett konto';

  @override
  String get authSignInCta => 'Logg inn';

  @override
  String get authHaveAccount => 'Jeg har allerede en konto';

  @override
  String get authNewAccount => 'Jeg er ny — opprett en konto';

  @override
  String get authLegalPrefixSignUp => 'Ved å opprette en konto godtar du våre ';

  @override
  String get authLegalPrefixSignIn => 'Ved å fortsette godtar du våre ';

  @override
  String get authTerms => 'Vilkår';

  @override
  String get authAnd => ' og ';

  @override
  String get gamesIntro =>
      'Rolige spill for fokus og et stille sinn — den typen hjernetrening folk opplever som jordnær. Spill mot telefonen, eller gi den til en venn.';

  @override
  String gamesBestMs(int ms) {
    return 'Best $ms ms';
  }

  @override
  String gamesBestLevel(int level) {
    return 'Beste nivå $level';
  }

  @override
  String gamesBest(String score) {
    return 'Best $score';
  }

  @override
  String gamesBestMoves(int moves) {
    return 'Best $moves trekk';
  }

  @override
  String gamesWinsVsPhone(int count) {
    return '$count seiere mot telefonen';
  }

  @override
  String get gameTitleReaction => 'Reaksjonshastighet';

  @override
  String get gameTitleSequence => 'Sekvenshukommelse';

  @override
  String get gameTitleQuickMath => 'Hurtigmatte';

  @override
  String get gameTitleMemory => 'Memory';

  @override
  String get gameSubReaction => 'fokus · trykk når det blir grønt';

  @override
  String get gameSubSequence => 'hukommelse · se og gjenta';

  @override
  String get gameSub2048 => 'strategi · sveip for å slå sammen';

  @override
  String get gameSubQuickMath => 'hoderegning · 30-sekunders spurt';

  @override
  String get gameSubTicTacToe => 'mot telefonen · eller 2 spillere';

  @override
  String get gameSubConnect4 => 'mot telefonen · eller 2 spillere';

  @override
  String get gameSubMemory => 'solo · finn parene';

  @override
  String get gameHelpTooltip => 'Slik spiller du';

  @override
  String gameHelpTitle(String game) {
    return 'Slik spiller du · $game';
  }

  @override
  String get gameGotIt => 'Skjønner';

  @override
  String get tierFree => 'Gratis';

  @override
  String get tierMonthly => 'Premium · Månedlig';

  @override
  String get tierYearly => 'Premium · Årlig';

  @override
  String get podsUnlimited => 'ubegrenset med grupper';

  @override
  String podsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count grupper',
      one: '1 gruppe',
    );
    return '$_temp0';
  }

  @override
  String get groupsSignedOutTitle => 'Bli med i en liten, vennlig gruppe';

  @override
  String get groupsSignedOutBody =>
      'Grupper krever en rask konto slik at de er trygge og dine. Øvingen din forblir privat og kontofri.';

  @override
  String get groupsSignInCta => 'Logg inn for å fortsette';

  @override
  String get groupsLoadError =>
      'Kunne ikke laste gruppene. Dra for å prøve igjen.';

  @override
  String groupsJoined(String pod) {
    return 'Ble med i $pod. Si hei når du er klar.';
  }

  @override
  String get groupsJoinedNew =>
      'Ble med i en ny gruppe. Si hei når du er klar.';

  @override
  String get groupsNoPodFound => 'Kunne ikke finne en gruppe nå. Prøv igjen.';

  @override
  String groupsLeaveTitle(String pod) {
    return 'Forlate $pod?';
  }

  @override
  String get groupsLeave => 'Forlat';

  @override
  String groupsLeft(String pod) {
    return 'Du forlot $pod.';
  }

  @override
  String get groupsLeaveError => 'Kunne ikke forlate gruppen. Prøv igjen.';

  @override
  String get groupsHeader => 'Små grupper, vennlige folk';

  @override
  String get groupsYourPods => 'DINE GRUPPER';

  @override
  String get groupsDiscoverPods => 'OPPDAG GRUPPER';

  @override
  String get groupsJoinAnother => 'Bli med i en annen gruppe';

  @override
  String get groupsNoOthers => 'Ingen andre grupper å bli med i nå.';

  @override
  String groupsJoinedShort(String pod) {
    return 'Ble med i $pod.';
  }

  @override
  String get groupsJoin => 'Bli med';

  @override
  String get groupsPodOptions => 'Gruppevalg';

  @override
  String get groupsLeavePod => 'Forlat gruppen';

  @override
  String groupsMembers(int count, int capacity) {
    return '$count/$capacity medlemmer';
  }

  @override
  String groupsTierPods(String tier, String pods) {
    return 'Med $tier kan du være med i $pods.';
  }

  @override
  String groupsCapacityTierPods(int capacity, String tier, String pods) {
    return 'Opptil $capacity per gruppe. Med $tier kan du være med i $pods.';
  }

  @override
  String groupsInYourPods(String pods) {
    return 'Du er med i dine $pods';
  }

  @override
  String get groupsUpgradeBody =>
      'Skaff Premium for å bli med i flere — månedlig låser opp 3 grupper, årlig så mange du vil.';

  @override
  String get groupsSafetyLive =>
      'Vær vennlig. Du kan rapportere eller blokkere hvem som helst fra profilen deres. Låste profiler forblir private.';

  @override
  String get groupsSafetyPreview =>
      'Forhåndsvisning. Gruppene blir live, modererte chatter når innlogging er satt opp.';

  @override
  String get groupsLeaveBody =>
      'Du slutter å se meldingene til denne gruppen. Du kan bli med igjen senere.';

  @override
  String get podRulesTitle => 'Grupperegler';

  @override
  String get podRulesIntro =>
      'Grupper fungerer bare hvis alle føler seg trygge. Ved å bli med godtar du:';

  @override
  String get podRule1 => 'Vær vennlig. Alle her øver på noe vanskelig.';

  @override
  String get podRule2 =>
      'Ingen trakassering, hat eller skadelig innhold. Aldri.';

  @override
  String get podRule3 =>
      'Rapporter eller blokker hvem som helst som gjør deg utilpass.';

  @override
  String get podRule4 => 'Respekter personvern — det som deles her, blir her.';

  @override
  String get podRule5 =>
      'Grupper er støtte mellom likemenn, ikke en krisetjeneste. I en nødsituasjon, kontakt en fagperson eller en lokal krisetelefon.';

  @override
  String get podRulesAgree => 'Jeg godtar — slipp meg inn';

  @override
  String chatIntrosBeKind(int count, int capacity) {
    return '$count/$capacity introverte · vær vennlig';
  }

  @override
  String get chatHint => 'Si noe vennlig…';

  @override
  String get chatPreviewBanner =>
      'Forhåndsvisning · meldinger blir på enheten din foreløpig. Ekte, modererte grupper kommer med kontoer.';

  @override
  String get chatYou => 'Du';

  @override
  String get reportHarassment => 'Trakassering eller mobbing';

  @override
  String get reportHate => 'Hat eller skadelig språk';

  @override
  String get reportSpam => 'Spam eller svindel';

  @override
  String get reportUnsafe => 'Får meg til å føle meg utrygg';

  @override
  String get reportOther => 'Noe annet';

  @override
  String get memberPrivateTitle => 'Privat profil';

  @override
  String get memberPrivateBody =>
      'Dette medlemmet holder profilen sin privat. Du kan fortsatt chatte med dem — og rapportere eller blokkere ved behov.';

  @override
  String memberStreak(int days) {
    return '$days dagers rekke';
  }

  @override
  String memberChallenges(int count) {
    return '$count utfordringer';
  }

  @override
  String memberClimbing(String track) {
    return 'Klatrer: $track';
  }

  @override
  String get memberReport => 'Rapporter';

  @override
  String get memberBlock => 'Blokker';

  @override
  String get memberReportThanks => 'Takk — vi ser på dette.';

  @override
  String get memberBlockToo => 'Blokker også';

  @override
  String get memberBlocked => 'Blokkert. Du vil ikke se meldingene deres.';

  @override
  String get memberBlockError => 'Kunne ikke blokkere. Prøv igjen.';

  @override
  String get memberReportError => 'Kunne ikke sende rapport. Prøv igjen.';

  @override
  String get memberBlockConfirmTitle => 'Blokkere dette medlemmet?';

  @override
  String get memberBlockConfirmBody =>
      'Dere vil ikke se hverandres meldinger. Du kan angre dette senere.';

  @override
  String get memberSoonReporting =>
      'Rapportering aktiveres i modererte grupper (logg inn for å bruke den).';

  @override
  String get memberSoonBlocking =>
      'Blokkering aktiveres i modererte grupper (logg inn for å bruke den).';

  @override
  String get memberWhatsWrong => 'Hva er galt?';

  @override
  String get memberFallback => 'Medlem';

  @override
  String get blockedUnblockError =>
      'Kunne ikke oppheve blokkering. Prøv igjen.';

  @override
  String blockedUnblocked(String name) {
    return 'Opphevet blokkering av $name. Du vil se meldingene deres igjen.';
  }

  @override
  String get blockedIntro =>
      'Blokkering skjuler et medlems meldinger for deg — og dine for dem, begge veier. Opphev blokkering av hvem som helst nedenfor for å angre.';

  @override
  String get blockedLabel => 'Blokkert';

  @override
  String get blockedUnblock => 'Opphev blokkering';

  @override
  String get blockedEmptyTitle => 'Ingen blokkert';

  @override
  String get blockedEmptyBody =>
      'Du har ikke blokkert noen. Blokkering skjuler et medlems meldinger for deg, begge veier — og du kan alltid angre det her.';

  @override
  String get chatCheckInPosted => 'Godt jobbet. Gruppeinnsjekk publisert.';

  @override
  String get chatCheckInError => 'Kunne ikke sjekke inn nå. Prøv igjen.';

  @override
  String get chatDeleteMsgTitle => 'Slette melding?';

  @override
  String get chatDeleteMsgBody => 'Dette fjerner den for alle i gruppen.';

  @override
  String get chatReply => 'Svar';

  @override
  String get chatEdit => 'Rediger';

  @override
  String get chatDailyPrompt => 'Daglig gruppespørsmål';

  @override
  String get chatCheckedInToday => 'Sjekket inn i dag';

  @override
  String get chatDidMyStep => 'Jeg gjorde steget mitt';

  @override
  String chatCheckedInCount(int count) {
    return '$count har sjekket inn';
  }

  @override
  String get chatNoMessages =>
      'Ingen meldinger ennå. Et enkelt «hei» er et modig første trinn.';

  @override
  String get chatEditingMessage => 'Redigerer meldingen din';

  @override
  String chatReplyingTo(String name) {
    return 'Svarer $name';
  }

  @override
  String get chatYourself => 'deg selv';

  @override
  String get chatMsgDeleted => 'Denne meldingen ble slettet';

  @override
  String get chatPrivateMember => 'Privat medlem';

  @override
  String chatBeKind(int count, int capacity) {
    return '$count/$capacity · vær vennlig';
  }

  @override
  String get chatDeletedMessageShort => 'slettet melding';

  @override
  String get gameYouWin => 'Du vinner! 🎉';

  @override
  String get gamePhoneWins => 'Telefonen vinner';

  @override
  String get gamePhoneThinking => 'Telefonen tenker…';

  @override
  String get gamePlayPhone => 'Spill mot telefonen';

  @override
  String get game2Players => '2 spillere';

  @override
  String get gameNewGame => 'Nytt spill';

  @override
  String get gameYou => 'Du';

  @override
  String get gamePhone => 'Telefon';

  @override
  String get gameDraws => 'Uavgjort';

  @override
  String get tttP1Wins => 'Spiller 1 (X) vinner! 🎉';

  @override
  String get tttP2Wins => 'Spiller 2 (O) vinner! 🎉';

  @override
  String get tttYourTurn => 'Din tur';

  @override
  String get tttP1Turn => 'Spiller 1 · X';

  @override
  String get tttP2Turn => 'Spiller 2 · O';

  @override
  String get tttP1Label => 'S1 (X)';

  @override
  String get tttP2Label => 'S2 (O)';

  @override
  String get tttRule1 => 'Bytt på å plassere merket ditt på 3×3-rutenettet.';

  @override
  String get tttRule2 =>
      'Få tre av merkene dine på rad — vannrett, loddrett eller diagonalt — for å vinne.';

  @override
  String get tttRule3 =>
      '«Spill mot telefonen» er deg mot en enkel KI. «2 spillere» sender telefonen hver tur.';

  @override
  String get c4P1Wins => 'Spiller 1 vinner! 🎉';

  @override
  String get c4P2Wins => 'Spiller 2 vinner! 🎉';

  @override
  String get c4Turn => 'Din tur — trykk på en kolonne';

  @override
  String get c4P1Turn => 'Spiller 1 · rød';

  @override
  String get c4P2Turn => 'Spiller 2 · gul';

  @override
  String get c4P1Label => 'S1';

  @override
  String get c4P2Label => 'S2';

  @override
  String get c4Rule1 =>
      'Trykk på en kolonne for å slippe brikken din — den faller til laveste ledige plass.';

  @override
  String get c4Rule2 =>
      'Få fire på rad i din farge — vannrett, loddrett eller diagonalt — for å vinne.';

  @override
  String get c4Rule3 =>
      '«Spill mot telefonen» er deg mot en enkel KI. «2 spillere» sender telefonen.';

  @override
  String get gameDraw => 'Det er uavgjort 🤝';

  @override
  String get gamePlayAgain => 'Spill igjen';

  @override
  String get gameStart => 'Start';

  @override
  String get g2048Rule1 =>
      'Sveip opp, ned, venstre eller høyre for å skyve alle brikkene.';

  @override
  String get g2048Rule2 =>
      'To brikker med samme tall slås sammen til én som dobles.';

  @override
  String get g2048Rule3 =>
      'Fortsett å slå sammen for å bygge en 2048-brikke. Brettet fylles — planlegg fremover!';

  @override
  String get g2048Score => 'Poeng';

  @override
  String get g2048Best => 'Best';

  @override
  String get g2048GameOver => 'Spillet er over';

  @override
  String get g2048Won => 'Du lagde 2048! 🎉';

  @override
  String get g2048SwipeToMerge => 'Sveip for å slå sammen';

  @override
  String get qmRule1 => 'Du har 30 sekunder — løs så mange du kan.';

  @override
  String get qmRule2 => 'Trykk på riktig svar blant de fire valgene.';

  @override
  String get qmRule3 => 'Et feil trykk koster 2 sekunder, så les nøye.';

  @override
  String qmTimeScored(Object score) {
    return 'Tiden er ute! Du fikk $score';
  }

  @override
  String qmBestSub(Object best) {
    return 'Best $best · 30 sekunder, svar på så mange du kan.';
  }

  @override
  String get qmStartSub => '30 sekunder. Et feil trykk koster 2 sekunder.';

  @override
  String get qmCorrect => 'riktige';

  @override
  String get mmRule1 => 'Trykk på et kort for å snu det, snu så et til.';

  @override
  String get mmRule2 =>
      'Hvis de to emojiene matcher, blir de liggende åpne; hvis ikke, snus de tilbake.';

  @override
  String get mmRule3 => 'Finn alle parene — på så få trekk som mulig.';

  @override
  String mmAllMatched(Object moves) {
    return 'Alle matchet på $moves trekk! 🎉';
  }

  @override
  String mmFindPairs(Object moves) {
    return 'Finn parene · $moves trekk';
  }

  @override
  String mmBest(Object best) {
    return 'Best: $best trekk';
  }

  @override
  String get mmShuffle => 'Stokk';

  @override
  String get rxTapStart => 'Trykk for å starte';

  @override
  String get rxWaitGreen => 'Vent på grønt, trykk så raskt';

  @override
  String get rxWait => 'Vent…';

  @override
  String get rxTapMoment => 'Trykk i det øyeblikket det blir grønt';

  @override
  String rxBestRetry(Object ms) {
    return 'Best $ms ms · trykk for å prøve igjen';
  }

  @override
  String get rxTapRetry => 'Trykk for å prøve igjen';

  @override
  String get rxTooSoon => 'For tidlig!';

  @override
  String get rxWaitRetry => 'Vent på grønt · trykk for å prøve igjen';

  @override
  String get rxTap => 'TRYKK!';

  @override
  String get rxRule1 =>
      'Trykk på skjermen for å starte, vent så — den blir ravgul.';

  @override
  String get rxRule2 =>
      'I det øyeblikket den blir grønn, trykk så raskt du kan.';

  @override
  String get rxRule3 =>
      'Å trykke for tidlig nullstiller. Lavere tid (ms) er bedre.';

  @override
  String get smWatchRepeat => 'Se på mønsteret, og gjenta det.';

  @override
  String get smWatch => 'Se…';

  @override
  String smYourTurn(Object current, Object total) {
    return 'Din tur · $current av $total';
  }

  @override
  String smReachedBest(Object best, Object reached) {
    return 'Du nådde $reached · best $best';
  }

  @override
  String smReached(Object reached) {
    return 'Du nådde $reached';
  }

  @override
  String get smRule1 => 'Se brikkene lyse opp én etter én.';

  @override
  String get smRule2 =>
      'Gjenta nøyaktig samme rekkefølge ved å trykke på brikkene.';

  @override
  String get smRule3 =>
      'Hver runde legger til ett steg — se hvor langt du kommer.';

  @override
  String smRound(Object round) {
    return 'Runde $round';
  }

  @override
  String get safetyScreenTitle => 'Er dette riktig for meg?';

  @override
  String get safetyPracticeTitle => 'Rung er øving, ikke terapi.';

  @override
  String get safetyIntro =>
      'Rung er et verktøy for selvtillit og øving. Det hjelper deg å møte hverdagslige sosiale situasjoner gradvis, i ditt eget tempo. Det er ikke terapi, ikke medisinsk behandling og ikke en diagnose.';

  @override
  String get safetyPoint1 =>
      'Målet er håndterbar gruing — å føle deg mer komfortabel i øyeblikkene du pleide å unngå. Ikke å bli en annen person.';

  @override
  String get safetyPoint2 =>
      'Å hoppe over er alltid greit og teller aldri mot deg. Her finnes ingen skammekanismer.';

  @override
  String get safetyPoint3 =>
      'Dataene dine er dine. Alt fungerer offline, uten konto.';

  @override
  String get safetyMoreTitle => 'Hvis dette er mer enn nerver';

  @override
  String get safetyMoreBody =>
      'Hvis angst påvirker hverdagen din alvorlig, eller du noen gang har tanker om å skade deg selv, ta kontakt med en kvalifisert fagperson eller en lokal krisetelefon. Det er et sterkt, sunt steg — og Rung erstatter det ikke.';

  @override
  String get legalLastUpdated => 'Sist oppdatert: juni 2026';

  @override
  String legalQuestions(String email) {
    return 'Spørsmål? Kontakt oss på $email.';
  }

  @override
  String get privacyTitle => 'Personvernerklæring';

  @override
  String get privacyIntro =>
      'Rung er et privat øvingsverktøy for å bygge sosial selvtillit. Vi samler inn så lite som mulig, og det mest personlige du skriver forlater aldri telefonen din. Denne erklæringen forklarer hva vi lagrer og hvorfor.';

  @override
  String get ppWhatStaysHead => 'Hva som bare blir på enheten din';

  @override
  String get ppWhatStaysBody =>
      'Refleksjonsnotatene og forutsigelsesnotatene dine — de private tingene du skriver om hvordan et øyeblikk føltes — lagres bare i appen på enheten din. De lastes aldri opp til serverne våre.';

  @override
  String get ppCloudHead => 'Hva vi lagrer i skyen';

  @override
  String get ppCloudBody =>
      'Når du oppretter en konto lagrer vi: e-postadressen din (for innlogging; passordet ditt er kryptert og vi ser det aldri), et valgfritt visningsnavn og en bio, og personverninnstillingen din. For å drive fellesskapet («grupper») lagrer vi meldingene du publiserer og eventuelle blokkeringer eller rapporter du gjør. For å holde fremgangen din trygg på tvers av enheter sikkerhetskopierer vi bare tall — rekken din, fullførte utfordringer og angstvurderinger (forutsagt vs faktisk) — pluss egne trinn du oppretter. Notattekst er aldri inkludert.';

  @override
  String get ppAnalyticsHead => 'Analyse';

  @override
  String get ppAnalyticsBody =>
      'Vi bruker personvernvennlig produktanalyse (PostHog) for å forstå hvilke funksjoner som hjelper – anonyme brukshendelser som «åpnet en skjerm» eller «fullførte et steg», aldri innholdet i notatene eller meldingene dine. Den er av som standard og kjører bare hvis du slår den på i Innstillinger; du kan slå den av igjen når som helst.';

  @override
  String get ppUseHead => 'Hvordan vi bruker opplysningene dine';

  @override
  String get ppUseBody =>
      'Bare for å levere appen: logge deg inn, drive gruppene, gjenopprette fremgangen din og forbedre Rung med aggregerte, anonyme trender. Vi selger ikke dataene dine og bruker dem ikke til annonsering.';

  @override
  String get ppProcessHead => 'Hvem som behandler dataene dine';

  @override
  String get ppProcessBody =>
      'Vi bruker Supabase (autentisering, database og drift) og PostHog (analyse) som databehandlere. De behandler data på våre vegne under sine egne sikkerhets- og personvernforpliktelser.';

  @override
  String get ppRightsHead => 'Dine rettigheter og valg';

  @override
  String get ppRightsBody =>
      'Du kan redigere profilen din, låse den slik at andre medlemmer ikke kan se den, og slette kontoen din og alle tilhørende skydata permanent når som helst fra Profil → Slett konto. Du kan også sende oss e-post for å be om tilgang til eller sletting av dataene dine.';

  @override
  String get ppSecurityHead => 'Sikkerhet og lagring';

  @override
  String get ppSecurityBody =>
      'Data krypteres under overføring, og hver tabell er beskyttet av sikkerhet på radnivå slik at du bare får tilgang til dine egne data (og gruppemeldinger der du er medlem). Vi beholder dataene dine til du sletter kontoen din eller ber oss fjerne dem.';

  @override
  String get ppChildrenHead => 'Barn';

  @override
  String get ppChildrenBody =>
      'Rung er ikke ment for noen under 16 år. Hvis du tror et barn har opprettet en konto, kontakt oss så fjerner vi den.';

  @override
  String get ppMedicalHead => 'Ikke medisinsk behandling';

  @override
  String get ppMedicalBody =>
      'Rung støtter gradvis øving, men er ikke terapi, diagnose eller medisinsk råd. Hvis du er i krise, kontakt lokale nødetater eller en krisetelefon.';

  @override
  String get ppChangesHead => 'Endringer';

  @override
  String get ppChangesBody =>
      'Hvis vi oppdaterer denne erklæringen, endrer vi datoen ovenfor og, ved vesentlige endringer, gir vi deg beskjed i appen.';

  @override
  String get termsTitle => 'Vilkår for bruk';

  @override
  String get termsIntro =>
      'Disse vilkårene er avtalen mellom deg og Rung når du bruker appen. Ved å opprette en konto eller bruke Rung, godtar du dem.';

  @override
  String get tosMedicalHead => 'Ikke en medisinsk tjeneste';

  @override
  String get tosMedicalBody =>
      'Rung er et selvhjelps- og øvingsverktøy, ikke terapi eller medisinsk behandling, og erstatter ikke profesjonell hjelp. Det kan ikke garantere noe bestemt resultat. Hvis du er i krise eller kan skade deg selv eller andre, kontakt lokale nødetater umiddelbart.';

  @override
  String get tosEligibilityHead => 'Kvalifikasjon';

  @override
  String get tosEligibilityBody =>
      'Du må være minst 16 år for å bruke Rung og ha rett til å godta disse vilkårene.';

  @override
  String get tosAccountHead => 'Kontoen din';

  @override
  String get tosAccountBody =>
      'Hold påloggingsopplysningene dine trygge — du er ansvarlig for aktivitet på kontoen din. Si fra til oss umiddelbart hvis du mistenker uautorisert bruk.';

  @override
  String get tosCommunityHead => 'Fellesskapsregler (grupper)';

  @override
  String get tosCommunityBody =>
      'Grupper er til for vennlighet og støtte. Du samtykker i å ikke trakassere, true, nedverdige, spamme eller publisere hatefullt eller ulovlig innhold, og ikke dele andres private opplysninger. Vi kan fjerne innhold eller suspendere kontoer som bryter disse reglene. Du kan blokkere og rapportere andre medlemmer når som helst.';

  @override
  String get tosContentHead => 'Innhold du publiserer';

  @override
  String get tosContentBody =>
      'Du beholder eierskapet til det du skriver. Ved å publisere i en gruppe gir du oss tillatelse til å lagre det og vise det til medlemmene i gruppen slik at fellesskapet fungerer. Ikke publiser noe du ikke har rett til å dele.';

  @override
  String get tosSubsHead => 'Abonnementer';

  @override
  String get tosSubsBody =>
      'Noen funksjoner og ekstra øvingsinnhold er tilgjengelig med et betalt abonnement. Når fakturering er aktiv, håndteres kjøp og fornyelser av appbutikken, og du kan administrere eller avslutte via appbutikkontoen din. Priser og innhold kan endres med varsel.';

  @override
  String get tosDisclaimerHead => 'Ansvarsfraskrivelser og ansvar';

  @override
  String get tosDisclaimerBody =>
      'Rung leveres «som det er», uten garantier av noe slag. I den grad loven tillater det, er vi ikke ansvarlige for indirekte tap eller følgetap som oppstår ved din bruk av appen.';

  @override
  String get tosEndingHead => 'Avslutte bruken din';

  @override
  String get tosEndingBody =>
      'Du kan slette kontoen din når som helst fra Profil → Slett konto. Vi kan suspendere eller avslutte tilgang hvis disse vilkårene brytes alvorlig eller gjentatte ganger.';

  @override
  String get tosChangesHead => 'Endringer';

  @override
  String get tosChangesBody =>
      'Vi kan oppdatere disse vilkårene; vi oppdaterer datoen ovenfor og, ved betydelige endringer, varsler deg i appen. Fortsatt bruk av Rung betyr at du godtar de oppdaterte vilkårene.';

  @override
  String get breatheCta => 'Kjenner du gruingen? Pust først';

  @override
  String get breatheIntro => 'Seksti sekunder. Bare følg sirkelen.';

  @override
  String get breatheIn => 'Pust inn';

  @override
  String get breatheHold => 'Hold';

  @override
  String get breatheOut => 'Pust ut';

  @override
  String get breatheSkip => 'Hopp over';

  @override
  String get breatheDoneTitle => 'Sånn, ja.';

  @override
  String get breatheDoneSub =>
      'Føles det litt stødigere? Ta trinnet ditt når du er klar.';

  @override
  String get breatheDoneBtn => 'Ferdig';

  @override
  String get insightsDeeperTitle => 'Dypere innsikt';

  @override
  String get insightsLockedBody =>
      'Se måneden din på et blikk — hvor mye hetere frykten din gikk enn virkeligheten, og hvor ofte du overvurderte den. En Premium-fordel.';

  @override
  String get insightsUnlockCta => 'Lås opp med Premium';

  @override
  String get insightsNoSteps =>
      'Ingen steg notert denne måneden ennå. Møt et par, så dukker sammendraget ditt opp her.';

  @override
  String get insightsFearsFacedMonth => 'møter med frykten denne måneden';

  @override
  String insightsGapHotter(String points) {
    return 'Frykten din gikk i snitt $points poeng hetere enn virkeligheten.';
  }

  @override
  String get insightsGapTougher =>
      'Virkeligheten var litt tøffere enn du forutså denne måneden — det er modige data det også.';

  @override
  String get insightsGapSpotOn =>
      'Forutsigelsene dine var ganske treffsikre denne måneden.';

  @override
  String insightsOverPredicted(int rate) {
    return 'Du overvurderte frykten $rate% av gangene.';
  }

  @override
  String get insightsTrendSame => 'Det samme som forrige måned';

  @override
  String insightsTrendMore(int count) {
    return '$count flere enn forrige måned';
  }

  @override
  String insightsTrendFewer(int count) {
    return '$count færre enn forrige måned';
  }

  @override
  String get rateTitle => 'Liker du Rung?';

  @override
  String get ratePromptNone => 'Hvordan føles Rung for deg?';

  @override
  String get ratePromptLow => 'Trist at det ikke treffer. Hva mangler?';

  @override
  String get ratePromptMid => 'Takk — hva skulle til for en 5-er?';

  @override
  String get ratePromptHigh => 'Det betyr mye. Hva liker du?';

  @override
  String get rateHintLove => 'Noe du liker? (valgfritt)';

  @override
  String get rateHintMore => 'Fortell oss mer (valgfritt)';

  @override
  String get rateSend => 'Send';

  @override
  String get rateThanksHigh => 'Takk — det hjelper virkelig. 🌱';

  @override
  String get rateThanksLow =>
      'Takk for ærligheten — vi bruker den til å bli bedre.';

  @override
  String get editProfileTitle => 'Rediger profil';

  @override
  String get editDisplayName => 'Visningsnavn';

  @override
  String get editDisplayNameHint => 'Hva skal gruppene kalle deg?';

  @override
  String get editBio => 'Kort bio (valgfritt)';

  @override
  String get editBioHint =>
      'En linje om deg — holdes privat hvis du låser profilen din.';

  @override
  String get errorOffline =>
      'Du er frakoblet. Koble til internett og prøv igjen.';

  @override
  String get errorGeneric => 'Noe gikk galt. Prøv igjen.';

  @override
  String get errorSaveFailed =>
      'Kunne ikke lagre — enheten din har kanskje lite lagringsplass. Frigjør plass og prøv igjen.';
}
