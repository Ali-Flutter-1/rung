// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get navHome => 'Hjem';

  @override
  String get navGroups => 'Grupper';

  @override
  String get navPremium => 'Premium';

  @override
  String get navProfile => 'Profil';

  @override
  String get greetingMorning => 'Godmorgen';

  @override
  String get greetingAfternoon => 'God eftermiddag';

  @override
  String get greetingEvening => 'Godaften';

  @override
  String get todayStepIntro => 'Her er ét lille skridt til i dag.';

  @override
  String get commonContinue => 'Fortsæt';

  @override
  String get commonCancel => 'Annuller';

  @override
  String get commonSave => 'Gem';

  @override
  String get commonDone => 'Færdig';

  @override
  String get commonNotNow => 'Ikke nu';

  @override
  String get profileTitle => 'Profil';

  @override
  String get language => 'Sprog';

  @override
  String get languageSystemDefault => 'Systemsprog';

  @override
  String get yourTone => 'Din tone';

  @override
  String get appearance => 'Udseende';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Lyst';

  @override
  String get themeDark => 'Mørkt';

  @override
  String get onbSkip => 'Spring over';

  @override
  String get onbWelcomeTitle =>
      'Mød de øjeblikke, du plejede at frygte — ét lille skridt ad gangen.';

  @override
  String get onbWelcomeBody =>
      'Rung hjælper dig med at opbygge social selvtillid gennem blid, privat øvelse. Forudsig, gør det, reflekter — og se din værste frygt falde fra hinanden i dine egne tal.';

  @override
  String get onbGetStarted => 'Kom i gang';

  @override
  String get onbSafetyTitle => 'Øvelse, ikke terapi.';

  @override
  String get onbUnderstand => 'Jeg forstår';

  @override
  String get onbSafetyBody1 =>
      'Rung er et værktøj til selvtillid og øvelse — ikke terapi, ikke medicinsk behandling og ikke en diagnose.';

  @override
  String get onbSafetyBody2 =>
      'Målet er at føle dig mere tilpas i øjeblikke, du plejede at frygte — ikke at blive en, du ikke er. At springe over er altid i orden.';

  @override
  String get onbSafetyCrisis =>
      'Hvis angst påvirker dit liv alvorligt, eller du nogensinde har tanker om at skade dig selv, så kontakt en fagperson eller en lokal krisetelefon.';

  @override
  String get onbFearTitle => 'Hvor vil du gerne begynde?';

  @override
  String get onbFearBody =>
      'Bare som forslag til et første skridt — du kan klatre hvilken som helst af disse når som helst. Intet her binder dig.';

  @override
  String get onbExploreOwn => 'Jeg udforsker hellere selv';

  @override
  String get onbToneTitle => 'Hvad lyder mest som dig?';

  @override
  String get onbToneIntrovertTitle => 'Jeg er mere introvert';

  @override
  String get onbToneIntrovertBody =>
      'Jeg vil føle mig tilpas, ikke blive en anden person.';

  @override
  String get onbToneSituationalTitle =>
      'Jeg bliver nervøs i bestemte situationer';

  @override
  String get onbToneSituationalBody =>
      'Nogle gange er jeg udadvendt, men visse øjeblikke bringer mig ud af balance.';

  @override
  String get onbToneFootnote => 'Du kan ændre dette når som helst i Profil.';

  @override
  String get onbHowTitle => 'Sådan fungerer det.';

  @override
  String get onbStartClimbing => 'Begynd at klatre';

  @override
  String get onbStep1 => 'Forudsig, hvor slemt det vil føles (0–10).';

  @override
  String get onbStep2 =>
      'Gør det i virkeligheden — appen må gerne være lukket.';

  @override
  String get onbStep3 => 'Kom tilbage og notér, hvordan det faktisk gik.';

  @override
  String get onbGentleFirstStep => 'ET BLIDT FØRSTE SKRIDT';

  @override
  String get onbGoodPlaceToStart => 'ET GODT STED AT BEGYNDE';

  @override
  String get onbAllAreas =>
      'Alle seks områder er på din startskærm — begynd hvor du vil.';

  @override
  String get predictAppBar => 'Før du går';

  @override
  String get predictSaved =>
      'Gemt. Gå ud og gør det — kom så tilbage og notér, hvordan det gik.';

  @override
  String get predictQuestion => 'Hvor slemt tror du, det bliver?';

  @override
  String get predictNoteLabel => 'Hvad tror du, der sker? (valgfrit)';

  @override
  String get predictNoteHint => 'f.eks. De vil synes, jeg er akavet';

  @override
  String get predictCompare =>
      'Vi sammenligner dette med, hvordan det faktisk går. Det spring er hele pointen.';

  @override
  String get predictDoIt => 'Jeg gør det';

  @override
  String get reflectAppBar => 'Hvordan gik det?';

  @override
  String get reflectDidYouDoIt => 'Gjorde du det?';

  @override
  String get reflectHowAnxious => 'Hvor angst føltes bare tanken om det?';

  @override
  String get reflectHowBad => 'Hvor slemt var det egentlig?';

  @override
  String get reflectNoteLabel => 'Noget du vil huske? (valgfrit)';

  @override
  String get reflectOutcomeDone => 'Gjort';

  @override
  String get reflectOutcomePartial => 'Delvist';

  @override
  String get reflectOutcomeNotToday => 'Ikke i dag';

  @override
  String get resultQuietDelight => 'Stille glæde i hvert skridt.';

  @override
  String get resultBackToLadder => 'Tilbage til stigen';

  @override
  String resultGapHeadline(int predicted, int actual) {
    return 'Du forberedte dig på $predicted. Det blev $actual.';
  }

  @override
  String resultGapSub(int predicted, int actual) {
    return 'Dit hjerte forberedte sig på et tungt $predicted, men verden mødte dig med et mildere $actual. Værd at huske.';
  }

  @override
  String get resultRightHeadline => 'Præcis som du gættede.';

  @override
  String get resultRightSub =>
      'Du ramte plet — og du mødte alligevel op. Det er sejren.';

  @override
  String get resultTougherHeadline =>
      'Hårdere end du gættede — og du gjorde det.';

  @override
  String get resultTougherSub =>
      'Nogle øjeblikke kræver mere af os. At møde op alligevel er hele pointen.';

  @override
  String get resultPredicted => 'Forudsagt';

  @override
  String get resultActual => 'Faktisk';

  @override
  String resultLighter(int reduction) {
    return 'Dette øjeblik var $reduction% lettere, end du frygtede';
  }

  @override
  String get resultSkippedHeadline => 'Noteret — intet pres.';

  @override
  String get resultSkippedSub =>
      '«Ikke i dag» er et helt fint svar. Dette trin står her, når du er klar.';

  @override
  String get resultWinCopied => 'Sejren kopieret — indsæt den hvor du vil.';

  @override
  String get resultCopyWin => 'Kopiér min sejr';

  @override
  String resultShareText(String rung) {
    return 'Jeg gjorde lige noget, jeg plejede at undgå: $rung. Ét lille trin klatret. 🪜 #Rung';
  }

  @override
  String get tracksTitle => 'Dine spor';

  @override
  String get tracksSubtitle => 'Små skridt mod stor selvtillid.';

  @override
  String get menuInsights => 'Indsigt';

  @override
  String get menuIsThisRight => 'Er dette rigtigt for mig?';

  @override
  String tracksRungsCount(int done, int total) {
    return '$done af $total trin';
  }

  @override
  String tracksClimbedCount(int done, int total) {
    return '$done af $total klatret';
  }

  @override
  String get tracksContinueLabel => 'FORTSÆT HVOR DU SLAP';

  @override
  String get tracksNextStepLabel => 'DIT NÆSTE SKRIDT';

  @override
  String get tracksLoadError => 'Kunne ikke indlæse sporene.';

  @override
  String get todayResume => 'Fortsæt hvor du slap';

  @override
  String get todayNext => 'Dit næste skridt';

  @override
  String get todayVariety => 'Noget lidt anderledes';

  @override
  String get todayFresh => 'Dit udgangspunkt';

  @override
  String get todayResumeCta => 'Færdiggør noteringen';

  @override
  String get todayStartCta => 'Start';

  @override
  String todayMinutes(int min) {
    return '~$min min';
  }

  @override
  String get dashShareTooltip => 'Del mine fremskridt';

  @override
  String get dashWeeklyGoal => 'Ugemål';

  @override
  String dashStepsPerWeek(int count) {
    return '$count skridt/uge';
  }

  @override
  String dashGoalPerWeek(int count) {
    return '$count/uge';
  }

  @override
  String dashWeeklyProgress(int done, int goal) {
    return '$done af $goal skridt gennemført i denne uge';
  }

  @override
  String get dashYourGrowth => 'Din vækst';

  @override
  String get dashTodayError =>
      'Kunne ikke indlæse dagens skridt. Træk for at prøve igen.';

  @override
  String get dashTodayAllClear =>
      'Du har gennemført alt tilgængeligt — tilføj et eget trin eller tag et om igen for at holde stimen i gang.';

  @override
  String get dashTakeABreak => 'Hold en pause';

  @override
  String get dashTakeABreakSub =>
      'Et par rolige spil — mod telefonen eller med en ven.';

  @override
  String get ladderTitleFallback => 'Stige';

  @override
  String get ladderLoadError => 'Kunne ikke indlæse stigen.';

  @override
  String get ladderAddOwn => 'Tilføj dit eget trin';

  @override
  String ladderOfClimbed(int total) {
    return 'af $total klatret';
  }

  @override
  String get detailLoadError => 'Kunne ikke indlæse.';

  @override
  String get detailNotExist => 'Dette trin findes ikke længere.';

  @override
  String get detailWhatToDo => 'Hvad du skal gøre';

  @override
  String get detailWhyHelps => 'Hvorfor det hjælper';

  @override
  String get detailPastAttempts => 'Dine tidligere forsøg';

  @override
  String get detailDoThis => 'Jeg gør dette';

  @override
  String get detailReattempt =>
      'At prøve igen opfordres — det opbygger dine data.';

  @override
  String detailHistoryStat(int predicted, int actual) {
    return 'forudsagt $predicted · faktisk $actual';
  }

  @override
  String customLimitPremium(int cap) {
    return 'Du har nået denne måneds grænse på $cap egne trin — den nulstilles næste måned.';
  }

  @override
  String get customLimitFree =>
      'Gratisplanen indeholder 5 egne trin — opgrader for flere hver måned.';

  @override
  String get customDefaultWhat => 'En udfordring, du sætter for dig selv.';

  @override
  String get customDefaultWhy =>
      'Du satte ord på den — det er derfor, den tæller.';

  @override
  String get customSubtitle =>
      'Din situation er speciel — dette trin er kun for dig.';

  @override
  String get customWhatLabel => 'Hvad vil du gøre?';

  @override
  String get customWhatHint => 'f.eks. Bede min chef om feedback';

  @override
  String get customNoteLabel => 'En note til dig selv (valgfrit)';

  @override
  String customDifficulty(int value) {
    return 'Hvor svært føles det? $value/10';
  }

  @override
  String get customAddToLadder => 'Tilføj til stigen';

  @override
  String get paywallSwitchToFree => 'Skift til Gratis';

  @override
  String get paywallHeroTitle => 'Du behøver ikke møde det alene.';

  @override
  String get paywallHeroBody =>
      'Den daglige øvelse er altid gratis. Premium tilføjer en privat coach i dit hjørne — og et større fællesskab ved din side — til når du er klar til at gå videre.';

  @override
  String get paywallWhatsIncluded => 'Hvad der er inkluderet';

  @override
  String get paywallPlusHeader => 'Derudover får hver abonnent';

  @override
  String get paywallBenefitCoach =>
      'En privat coach, når som helst — øv noget der venter, eller tal om hvordan det gik';

  @override
  String get paywallBenefitPods =>
      'Du gør ikke dette alene — bliv medlem af flere støttegrupper (3 på månedlig, ubegrænset på årlig)';

  @override
  String get paywallBenefitCustom =>
      'Byg ubegrænset med dine egne stiger — ingen grænse for egne trin';

  @override
  String get paywallBenefitDepth =>
      'Gå dybere når du er klar — op til 40 skridt pr. spor (gratis er en fuld bue på 10 skridt)';

  @override
  String get paywallPlusStreak =>
      'Stimebeskyttelse — en overspringet dag bryder ikke din stime';

  @override
  String get paywallPlusInsights => 'Dybere indsigt — din måned på et øjeblik';

  @override
  String get paywallPlusShare => 'Personlige stilarter til delekort';

  @override
  String get paywallPlusPrivacy => 'Altid privat, altid reklamefrit';

  @override
  String get paywallYearly => 'Årligt';

  @override
  String get paywallPerYear => 'pr. år · bedste værdi';

  @override
  String get paywallSave => 'Spar 33%';

  @override
  String get paywallMonthly => 'Månedligt';

  @override
  String get paywallPerMonth => 'pr. måned';

  @override
  String get paywallSwitchYearly => 'Skift til årligt';

  @override
  String get paywallSwitchMonthly => 'Skift til månedligt';

  @override
  String paywallStartYearly(String price) {
    return 'Start årligt — $price';
  }

  @override
  String paywallStartMonthly(String price) {
    return 'Start månedligt — $price';
  }

  @override
  String get paywallRestore => 'Gendan køb';

  @override
  String paywallCurrentPlan(String plan) {
    return 'Nuværende plan: $plan. Opsig når som helst.';
  }

  @override
  String get paywallCancelAnytime =>
      'Opsig når som helst. Kernen forbliver gratis for altid.';

  @override
  String get paywallSimulated =>
      'Premium aktiv (simuleret — tilføj RevenueCat-nøgler for rigtige køb).';

  @override
  String get paywallPlanUnavailable =>
      'Den plan er ikke tilgængelig lige nu. Prøv igen om lidt.';

  @override
  String get paywallThankYou => 'Premium aktiv — tak. 🌱';

  @override
  String get paywallPurchaseFailed =>
      'Købet blev ikke gennemført. Du er ikke blevet opkrævet.';

  @override
  String get paywallRestored => 'Køb gendannet.';

  @override
  String get paywallNoRestore => 'Ingen tidligere køb fundet på denne konto.';

  @override
  String get paywallRestoreFailed =>
      'Kunne ikke gendanne lige nu. Prøv igen om lidt.';

  @override
  String get profileAddName => 'Tilføj dit navn';

  @override
  String get profileLockTitle => 'Lås min profil';

  @override
  String get profileLockedSub =>
      'Skjult — gruppemedlemmer kan ikke åbne dine detaljer.';

  @override
  String get profileUnlockedSub =>
      'Gruppemedlemmer kan trykke på din avatar for at se dine detaljer.';

  @override
  String get profilePlanTitle => 'Din plan';

  @override
  String get profilePremium => 'Premium';

  @override
  String get profileUpgrade => 'Opgrader';

  @override
  String get profileToneDesc =>
      'Rung taler blidt som standard. Hvis din angst er mere situationsbestemt, passer en lidt dristigere tone måske bedre til dig.';

  @override
  String get profileToneIntrovert => 'Introvert';

  @override
  String get profileToneSituational => 'Situationsbestemt';

  @override
  String get profileSafetySub =>
      'Hvordan Rung passer ind — og hvornår du bør søge mere';

  @override
  String get profileBlockedTitle => 'Blokerede medlemmer';

  @override
  String get profileBlockedSub =>
      'Se og ophæv blokering af personer, du har blokeret';

  @override
  String get profileRestoreTitle => 'Gendan mine fremskridt';

  @override
  String get profileRestoreSub =>
      'Hent din stime og dine udfordringer fra skyen';

  @override
  String get profileRestoring => 'Gendanner…';

  @override
  String get profileRestoreOk => 'Fremskridt gendannet fra skyen.';

  @override
  String profileRestoreFail(String error) {
    return 'Gendannelse mislykkedes: $error';
  }

  @override
  String get profileLogout => 'Log ud';

  @override
  String get profileSignedIn => 'Logget ind';

  @override
  String get profileLogoutConfirmTitle => 'Log ud?';

  @override
  String get profileLogoutConfirmBody =>
      'Dine fremskridt er gemt i skyen og kommer tilbage, når du logger ind igen.';

  @override
  String get profileLoggingOut => 'Logger ud…';

  @override
  String get profileRateTitle => 'Bedøm Rung';

  @override
  String get profileRateSub =>
      'Fortæl os hvordan det går — det hjælper virkelig';

  @override
  String get profilePrivacyTitle => 'Privatlivspolitik';

  @override
  String get profilePrivacySub =>
      'Hvad vi gemmer — og hvad der bliver på din enhed';

  @override
  String get profileTermsTitle => 'Servicevilkår';

  @override
  String get profileTermsSub => 'Aftalen for at bruge Rung';

  @override
  String get profileDeleteTitle => 'Slet konto';

  @override
  String get profileDeleteSub => 'Slet din konto og dine data permanent';

  @override
  String get profileFooter => 'Rung · øvelse, ikke terapi. Dine data er dine.';

  @override
  String get profileDeleteConfirmTitle => 'Slet konto?';

  @override
  String get profileDeleteConfirmBody =>
      'Dette sletter permanent din konto, dine gruppebeskeder og dine gemte fremskridt. Det kan ikke fortrydes.';

  @override
  String get profileDelete => 'Slet';

  @override
  String get profileDeleting => 'Sletter din konto…';

  @override
  String get profileDeleteFail => 'Kunne ikke slette din konto. Prøv igen.';

  @override
  String get profileBioPlaceholder => 'En stille klatrer.';

  @override
  String get profileHaptics => 'Vibration';

  @override
  String get profileHapticsSub => 'Blid vibration ved tryk og sejre';

  @override
  String get profileNotifications => 'Notifikationer';

  @override
  String get profileNotificationsSub =>
      'Notifikationer fra Rung på denne enhed';

  @override
  String get profilePodAlerts => 'Notifikationer om gruppebeskeder';

  @override
  String get profilePodAlertsSub => 'Sig til, når nogen skriver i mine grupper';

  @override
  String get profileEnableNotifs =>
      'Slå notifikationer til i Indstillinger for at få påmindelser.';

  @override
  String get profileReminderHelp => 'Hvornår skal vi give dig et lille skub?';

  @override
  String get profileReminderTitle => 'Blid daglig påmindelse';

  @override
  String profileReminderOn(String time) {
    return 'Hver dag kl. $time · tryk på kontakten for at slå fra';
  }

  @override
  String get profileReminderOff =>
      'Et roligt, skyldfrit skub til at tage ét lille skridt';

  @override
  String get profileAvatarTitle => 'Vælg din avatar';

  @override
  String get profileAvatarSub =>
      'Kun du kan ændre den — dine gruppekammerater ser den også.';

  @override
  String get commonClose => 'Luk';

  @override
  String get checkInMoodCalm => 'Rolig';

  @override
  String get checkInMoodOkay => 'Okay';

  @override
  String get checkInMoodAnxious => 'Ængstelig';

  @override
  String get checkInMoodLow => 'Nedtrykt';

  @override
  String get checkInMoodTense => 'Anspændt';

  @override
  String get checkInTitle => 'Hvordan ankommer du i dag?';

  @override
  String get checkInDismiss => 'Afvis';

  @override
  String get checkInCalmCta => 'Prøv et roligt øjeblik';

  @override
  String get checkInStepCta => 'Se dagens skridt';

  @override
  String get supportTitle => 'Det lyder som meget at bære på.';

  @override
  String get supportBody =>
      'Rung er et øvelsesværktøj, ikke en krisetjeneste. Hvis du gennemgår noget tungt, så kontakt en, der kan hjælpe dig nu — en du stoler på, eller en lokal krisetelefon. Du fortjener rigtig støtte.';

  @override
  String get supportResources => 'Se støtteressourcer';

  @override
  String get progressChallenges => 'Udfordringer';

  @override
  String get progressCurrentStreak => 'Nuværende stime';

  @override
  String get progressBestStreak => 'Bedste stime';

  @override
  String get progressThisWeek => 'Denne uge';

  @override
  String get progressCategoryBreakdown => 'Fordeling pr. kategori';

  @override
  String get insightsHistory => 'Historik';

  @override
  String checkInAckTitle(String mood) {
    return 'Tjekket ind — du føler dig $mood';
  }

  @override
  String get checkInAckGentle =>
      'Tak for ærligheden. Lad os holde i dag blidt — én lille, venlig ting er nok.';

  @override
  String get checkInAckStep =>
      'Skønt. Når du er klar, holder ét lille skridt farten oppe.';

  @override
  String get sharePremiumPerk => '✨ Flere kortstilarter er en Premium-fordel.';

  @override
  String get shareSeePremium => 'Se Premium';

  @override
  String get shareText => 'Små modige skridt, ét trin ad gangen. 🌱 #Rung';

  @override
  String get shareError => 'Kunne ikke åbne deling. Prøv igen.';

  @override
  String get shareTitle => 'Del dine fremskridt';

  @override
  String get shareSubtitle => 'Kun dine tal — intet privat.';

  @override
  String get shareCta => 'Del';

  @override
  String get shareCardHeadline => 'Mine modige skridt';

  @override
  String get shareCardFearsFaced => 'møder med frygten';

  @override
  String get shareCardCurrentStreak => 'Nuværende stime';

  @override
  String get shareCardBestStreak => 'Bedste stime';

  @override
  String get shareCardTagline =>
      'At møde social frygt, ét lille trin ad gangen.';

  @override
  String get helpNow => 'Hjælp nu';

  @override
  String get helpCalmMoment => 'Et roligt øjeblik';

  @override
  String get helpTabBreathe => 'Ånd';

  @override
  String get helpTabGround => 'Jording';

  @override
  String get helpTabSay => 'Sig dette';

  @override
  String get helpBreatheIn => 'Ånd ind…';

  @override
  String get helpBreatheOut => 'Ånd ud…';

  @override
  String get helpBreatheHint => 'Følg cirklen. Der er ingen hast.';

  @override
  String get helpGround5 => 'ting du kan se';

  @override
  String get helpGround4 => 'ting du kan røre ved';

  @override
  String get helpGround3 => 'ting du kan høre';

  @override
  String get helpGround2 => 'ting du kan lugte';

  @override
  String get helpGround1 => 'ting du kan smage';

  @override
  String get helpGroundTitle => 'Nævn, stille for dig selv…';

  @override
  String get helpGroundHint =>
      'Dette bringer dig tilbage til nu — hvor du er tryg.';

  @override
  String get helpOpener1 => 'Hvordan kender du folk her?';

  @override
  String get helpOpener2 => 'Jeg elsker det her sted — har du været her før?';

  @override
  String get helpOpener3 =>
      'Jeg er håbløs med navne — kan du minde mig om dit?';

  @override
  String get helpOpener4 => 'Hvad har du lavet i denne uge?';

  @override
  String get helpExit1 =>
      'Jeg henter lige noget at drikke — det var rart at tale med dig.';

  @override
  String get helpExit2 =>
      'Jeg skal lige sige hej til nogen, undskyld mig et øjeblik.';

  @override
  String get helpExit3 => 'Jeg lader dig mingle videre — vi ses senere.';

  @override
  String get helpOpenersTitle => 'Nemme åbningsreplikker';

  @override
  String get helpExitsTitle => 'Elegante afskeder';

  @override
  String get authEnterEmail => 'Indtast din e-mail';

  @override
  String get authBadEmail => 'Den e-mail ser ikke rigtig ud';

  @override
  String get authEnterPassword => 'Indtast en adgangskode';

  @override
  String get authMin6 => 'Mindst 6 tegn';

  @override
  String get authPwMismatch => 'Adgangskoderne matcher ikke';

  @override
  String get authConfirmEmail =>
      'Tjek din e-mail for at bekræfte, og log derefter ind. (Eller slå e-mailbekræftelse fra i Supabase Auth-indstillingerne til hurtig test.)';

  @override
  String get authGenericError => 'Noget gik galt. Prøv igen.';

  @override
  String get authCreateTitle => 'Opret din konto';

  @override
  String get authWelcomeBack => 'Velkommen tilbage';

  @override
  String get authSignUpSub =>
      'Bliv medlem af grupperne og hold dine fremskridt sikre på tværs af enheder.';

  @override
  String get authSignInSub =>
      'Log ind på dine grupper og synkroniserede fremskridt.';

  @override
  String get authDisplayName => 'Vist navn (valgfrit)';

  @override
  String get authEmail => 'E-mail';

  @override
  String get authPassword => 'Adgangskode';

  @override
  String get authShowPassword => 'Vis adgangskode';

  @override
  String get authHidePassword => 'Skjul adgangskode';

  @override
  String get authConfirmPassword => 'Bekræft adgangskode';

  @override
  String get authCreateCta => 'Opret konto';

  @override
  String get authSignInCta => 'Log ind';

  @override
  String get authHaveAccount => 'Jeg har allerede en konto';

  @override
  String get authNewAccount => 'Jeg er ny — opret en konto';

  @override
  String get authLegalPrefixSignUp =>
      'Ved at oprette en konto accepterer du vores ';

  @override
  String get authLegalPrefixSignIn => 'Ved at fortsætte accepterer du vores ';

  @override
  String get authTerms => 'Vilkår';

  @override
  String get authAnd => ' og ';

  @override
  String get gamesIntro =>
      'Rolige spil til fokus og et stille sind — den slags hjernetræning, folk oplever som jordnær. Spil mod telefonen, eller giv den til en ven.';

  @override
  String gamesBestMs(int ms) {
    return 'Bedst $ms ms';
  }

  @override
  String gamesBestLevel(int level) {
    return 'Bedste niveau $level';
  }

  @override
  String gamesBest(String score) {
    return 'Bedst $score';
  }

  @override
  String gamesBestMoves(int moves) {
    return 'Bedst $moves træk';
  }

  @override
  String gamesWinsVsPhone(int count) {
    return '$count sejre mod telefonen';
  }

  @override
  String get gameTitleReaction => 'Reaktionshastighed';

  @override
  String get gameTitleSequence => 'Sekvenshukommelse';

  @override
  String get gameTitleQuickMath => 'Hurtig matematik';

  @override
  String get gameTitleMemory => 'Vendespil';

  @override
  String get gameSubReaction => 'fokus · tryk når det bliver grønt';

  @override
  String get gameSubSequence => 'hukommelse · se og gentag';

  @override
  String get gameSub2048 => 'strategi · stryg for at slå sammen';

  @override
  String get gameSubQuickMath => 'hovedregning · 30-sekunders spurt';

  @override
  String get gameSubTicTacToe => 'mod telefonen · eller 2 spillere';

  @override
  String get gameSubConnect4 => 'mod telefonen · eller 2 spillere';

  @override
  String get gameSubMemory => 'solo · find parrene';

  @override
  String get gameHelpTooltip => 'Sådan spiller du';

  @override
  String gameHelpTitle(String game) {
    return 'Sådan spiller du · $game';
  }

  @override
  String get gameGotIt => 'Forstået';

  @override
  String get tierFree => 'Gratis';

  @override
  String get tierMonthly => 'Premium · Månedlig';

  @override
  String get tierYearly => 'Premium · Årlig';

  @override
  String get podsUnlimited => 'ubegrænset antal grupper';

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
  String get groupsSignedOutTitle => 'Bliv medlem af en lille, venlig gruppe';

  @override
  String get groupsSignedOutBody =>
      'Grupper kræver en hurtig konto, så de er trygge og dine. Din øvelse forbliver privat og kontofri.';

  @override
  String get groupsSignInCta => 'Log ind for at fortsætte';

  @override
  String get groupsLoadError =>
      'Kunne ikke indlæse grupperne. Træk for at prøve igen.';

  @override
  String groupsJoined(String pod) {
    return 'Blev medlem af $pod. Sig hej, når du er klar.';
  }

  @override
  String get groupsJoinedNew =>
      'Blev medlem af en ny gruppe. Sig hej, når du er klar.';

  @override
  String get groupsNoPodFound =>
      'Kunne ikke finde en gruppe lige nu. Prøv igen.';

  @override
  String groupsLeaveTitle(String pod) {
    return 'Forlade $pod?';
  }

  @override
  String get groupsLeave => 'Forlad';

  @override
  String groupsLeft(String pod) {
    return 'Du forlod $pod.';
  }

  @override
  String get groupsLeaveError => 'Kunne ikke forlade gruppen. Prøv igen.';

  @override
  String get groupsHeader => 'Små grupper, venlige mennesker';

  @override
  String get groupsYourPods => 'DINE GRUPPER';

  @override
  String get groupsDiscoverPods => 'OPDAG GRUPPER';

  @override
  String get groupsJoinAnother => 'Bliv medlem af en anden gruppe';

  @override
  String get groupsNoOthers =>
      'Ingen andre grupper at blive medlem af lige nu.';

  @override
  String groupsJoinedShort(String pod) {
    return 'Blev medlem af $pod.';
  }

  @override
  String get groupsJoin => 'Bliv medlem';

  @override
  String get groupsPodOptions => 'Gruppeindstillinger';

  @override
  String get groupsLeavePod => 'Forlad gruppen';

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
    return 'Op til $capacity pr. gruppe. Med $tier kan du være med i $pods.';
  }

  @override
  String groupsInYourPods(String pods) {
    return 'Du er med i dine $pods';
  }

  @override
  String get groupsUpgradeBody =>
      'Få Premium for at blive medlem af flere — månedlig låser 3 grupper op, årlig så mange du vil.';

  @override
  String get groupsSafetyLive =>
      'Vær venlig. Du kan anmelde eller blokere hvem som helst fra deres profil. Låste profiler forbliver private.';

  @override
  String get groupsSafetyPreview =>
      'Forhåndsvisning. Grupperne bliver live, modererede chats, når login er sat op.';

  @override
  String get groupsLeaveBody =>
      'Du holder op med at se denne gruppes beskeder. Du kan blive medlem igen senere.';

  @override
  String get podRulesTitle => 'Grupperegler';

  @override
  String get podRulesIntro =>
      'Grupper virker kun, hvis alle føler sig trygge. Ved at blive medlem accepterer du:';

  @override
  String get podRule1 => 'Vær venlig. Alle her øver sig på noget svært.';

  @override
  String get podRule2 => 'Ingen chikane, had eller skadeligt indhold. Aldrig.';

  @override
  String get podRule3 => 'Anmeld eller bloker enhver, der gør dig utilpas.';

  @override
  String get podRule4 =>
      'Respekter privatliv — det, der deles her, bliver her.';

  @override
  String get podRule5 =>
      'Grupper er støtte mellem ligesindede, ikke en krisetjeneste. I en nødsituation, kontakt en fagperson eller en lokal krisetelefon.';

  @override
  String get podRulesAgree => 'Jeg accepterer — luk mig ind';

  @override
  String chatIntrosBeKind(int count, int capacity) {
    return '$count/$capacity introverte · vær venlig';
  }

  @override
  String get chatHint => 'Sig noget venligt…';

  @override
  String get chatPreviewBanner =>
      'Forhåndsvisning · beskeder bliver på din enhed indtil videre. Rigtige, modererede grupper kommer med konti.';

  @override
  String get chatYou => 'Dig';

  @override
  String get reportHarassment => 'Chikane eller mobning';

  @override
  String get reportHate => 'Had eller skadeligt sprog';

  @override
  String get reportSpam => 'Spam eller svindel';

  @override
  String get reportUnsafe => 'Får mig til at føle mig utryg';

  @override
  String get reportOther => 'Noget andet';

  @override
  String get memberPrivateTitle => 'Privat profil';

  @override
  String get memberPrivateBody =>
      'Dette medlem holder sin profil privat. Du kan stadig chatte med dem — og anmelde eller blokere om nødvendigt.';

  @override
  String memberStreak(int days) {
    return '$days dages stime';
  }

  @override
  String memberChallenges(int count) {
    return '$count udfordringer';
  }

  @override
  String memberClimbing(String track) {
    return 'Klatrer: $track';
  }

  @override
  String get memberReport => 'Anmeld';

  @override
  String get memberBlock => 'Bloker';

  @override
  String get memberReportThanks => 'Tak — vi kigger på det.';

  @override
  String get memberBlockToo => 'Bloker også';

  @override
  String get memberBlocked => 'Blokeret. Du vil ikke se deres beskeder.';

  @override
  String get memberBlockError => 'Kunne ikke blokere. Prøv igen.';

  @override
  String get memberReportError => 'Kunne ikke sende anmeldelse. Prøv igen.';

  @override
  String get memberBlockConfirmTitle => 'Bloker dette medlem?';

  @override
  String get memberBlockConfirmBody =>
      'I vil ikke se hinandens beskeder. Du kan fortryde dette senere.';

  @override
  String get memberSoonReporting =>
      'Anmeldelse aktiveres i modererede grupper (log ind for at bruge den).';

  @override
  String get memberSoonBlocking =>
      'Blokering aktiveres i modererede grupper (log ind for at bruge den).';

  @override
  String get memberWhatsWrong => 'Hvad er der galt?';

  @override
  String get memberFallback => 'Medlem';

  @override
  String get blockedUnblockError => 'Kunne ikke ophæve blokering. Prøv igen.';

  @override
  String blockedUnblocked(String name) {
    return 'Ophævede blokering af $name. Du vil se deres beskeder igen.';
  }

  @override
  String get blockedIntro =>
      'Blokering skjuler et medlems beskeder for dig — og dine for dem, begge veje. Ophæv blokering af enhver nedenfor for at fortryde.';

  @override
  String get blockedLabel => 'Blokeret';

  @override
  String get blockedUnblock => 'Ophæv blokering';

  @override
  String get blockedEmptyTitle => 'Ingen blokeret';

  @override
  String get blockedEmptyBody =>
      'Du har ikke blokeret nogen. Blokering skjuler et medlems beskeder for dig, begge veje — og du kan altid fortryde det her.';

  @override
  String get chatCheckInPosted =>
      'Godt gået. Gruppe-indtjekning offentliggjort.';

  @override
  String get chatCheckInError => 'Kunne ikke tjekke ind lige nu. Prøv igen.';

  @override
  String get chatDeleteMsgTitle => 'Slet besked?';

  @override
  String get chatDeleteMsgBody => 'Dette fjerner den for alle i gruppen.';

  @override
  String get chatReply => 'Svar';

  @override
  String get chatEdit => 'Rediger';

  @override
  String get chatDailyPrompt => 'Dagligt gruppespørgsmål';

  @override
  String get chatCheckedInToday => 'Tjekket ind i dag';

  @override
  String get chatDidMyStep => 'Jeg tog mit skridt';

  @override
  String chatCheckedInCount(int count) {
    return '$count har tjekket ind';
  }

  @override
  String get chatNoMessages =>
      'Ingen beskeder endnu. Et simpelt «hej» er et modigt første trin.';

  @override
  String get chatEditingMessage => 'Redigerer din besked';

  @override
  String chatReplyingTo(String name) {
    return 'Svarer $name';
  }

  @override
  String get chatYourself => 'dig selv';

  @override
  String get chatMsgDeleted => 'Denne besked blev slettet';

  @override
  String get chatPrivateMember => 'Privat medlem';

  @override
  String chatBeKind(int count, int capacity) {
    return '$count/$capacity · vær venlig';
  }

  @override
  String get chatDeletedMessageShort => 'slettet besked';

  @override
  String get gameYouWin => 'Du vinder! 🎉';

  @override
  String get gamePhoneWins => 'Telefonen vinder';

  @override
  String get gamePhoneThinking => 'Telefonen tænker…';

  @override
  String get gamePlayPhone => 'Spil mod telefonen';

  @override
  String get game2Players => '2 spillere';

  @override
  String get gameNewGame => 'Nyt spil';

  @override
  String get gameYou => 'Dig';

  @override
  String get gamePhone => 'Telefon';

  @override
  String get gameDraws => 'Uafgjorte';

  @override
  String get tttP1Wins => 'Spiller 1 (X) vinder! 🎉';

  @override
  String get tttP2Wins => 'Spiller 2 (O) vinder! 🎉';

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
  String get tttRule1 => 'Skiftes til at placere dit mærke på 3×3-gitteret.';

  @override
  String get tttRule2 =>
      'Få tre af dine mærker på række — vandret, lodret eller diagonalt — for at vinde.';

  @override
  String get tttRule3 =>
      '«Spil mod telefonen» er dig mod en simpel AI. «2 spillere» sender telefonen videre hver tur.';

  @override
  String get c4P1Wins => 'Spiller 1 vinder! 🎉';

  @override
  String get c4P2Wins => 'Spiller 2 vinder! 🎉';

  @override
  String get c4Turn => 'Din tur — tryk på en kolonne';

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
      'Tryk på en kolonne for at slippe din brik — den falder til den laveste ledige plads.';

  @override
  String get c4Rule2 =>
      'Få fire på række i din farve — vandret, lodret eller diagonalt — for at vinde.';

  @override
  String get c4Rule3 =>
      '«Spil mod telefonen» er dig mod en simpel AI. «2 spillere» sender telefonen videre.';

  @override
  String get gameDraw => 'Det er uafgjort 🤝';

  @override
  String get gamePlayAgain => 'Spil igen';

  @override
  String get gameStart => 'Start';

  @override
  String get g2048Rule1 =>
      'Stryg op, ned, til venstre eller højre for at skubbe alle brikkerne.';

  @override
  String get g2048Rule2 =>
      'To brikker med samme tal smelter sammen til én, der fordobles.';

  @override
  String get g2048Rule3 =>
      'Bliv ved med at slå sammen for at bygge en 2048-brik. Brættet fyldes — planlæg forud!';

  @override
  String get g2048Score => 'Point';

  @override
  String get g2048Best => 'Bedste';

  @override
  String get g2048GameOver => 'Spillet er slut';

  @override
  String get g2048Won => 'Du lavede 2048! 🎉';

  @override
  String get g2048SwipeToMerge => 'Stryg for at slå sammen';

  @override
  String get qmRule1 => 'Du har 30 sekunder — løs så mange du kan.';

  @override
  String get qmRule2 => 'Tryk på det rigtige svar blandt de fire valg.';

  @override
  String get qmRule3 =>
      'Et forkert tryk koster 2 sekunder, så læs omhyggeligt.';

  @override
  String qmTimeScored(Object score) {
    return 'Tiden er gået! Du fik $score';
  }

  @override
  String qmBestSub(Object best) {
    return 'Bedst $best · 30 sekunder, svar på så mange du kan.';
  }

  @override
  String get qmStartSub => '30 sekunder. Et forkert tryk koster 2 sekunder.';

  @override
  String get qmCorrect => 'rigtige';

  @override
  String get mmRule1 =>
      'Tryk på et kort for at vende det, vend derefter et mere.';

  @override
  String get mmRule2 =>
      'Hvis de to emojis matcher, bliver de liggende med forsiden op; hvis ikke, vendes de tilbage.';

  @override
  String get mmRule3 => 'Find alle parrene — på så få træk som muligt.';

  @override
  String mmAllMatched(Object moves) {
    return 'Alle matchet på $moves træk! 🎉';
  }

  @override
  String mmFindPairs(Object moves) {
    return 'Find parrene · $moves træk';
  }

  @override
  String mmBest(Object best) {
    return 'Bedst: $best træk';
  }

  @override
  String get mmShuffle => 'Bland';

  @override
  String get rxTapStart => 'Tryk for at starte';

  @override
  String get rxWaitGreen => 'Vent på grønt, tryk så hurtigt';

  @override
  String get rxWait => 'Vent…';

  @override
  String get rxTapMoment => 'Tryk i det øjeblik det bliver grønt';

  @override
  String rxBestRetry(Object ms) {
    return 'Bedst $ms ms · tryk for at prøve igen';
  }

  @override
  String get rxTapRetry => 'Tryk for at prøve igen';

  @override
  String get rxTooSoon => 'For tidligt!';

  @override
  String get rxWaitRetry => 'Vent på grønt · tryk for at prøve igen';

  @override
  String get rxTap => 'TRYK!';

  @override
  String get rxRule1 =>
      'Tryk på skærmen for at starte, vent så — den bliver ravgul.';

  @override
  String get rxRule2 =>
      'I det øjeblik den bliver grøn, tryk så hurtigt du kan.';

  @override
  String get rxRule3 =>
      'At trykke for tidligt nulstiller. Lavere tid (ms) er bedre.';

  @override
  String get smWatchRepeat => 'Se mønsteret, og gentag det.';

  @override
  String get smWatch => 'Se…';

  @override
  String smYourTurn(Object current, Object total) {
    return 'Din tur · $current af $total';
  }

  @override
  String smReachedBest(Object best, Object reached) {
    return 'Du nåede $reached · bedst $best';
  }

  @override
  String smReached(Object reached) {
    return 'Du nåede $reached';
  }

  @override
  String get smRule1 => 'Se brikkerne lyse op én efter én.';

  @override
  String get smRule2 =>
      'Gentag præcis samme rækkefølge ved at trykke på brikkerne.';

  @override
  String get smRule3 =>
      'Hver runde tilføjer ét skridt mere — se hvor langt du kan nå.';

  @override
  String smRound(Object round) {
    return 'Runde $round';
  }

  @override
  String get safetyScreenTitle => 'Er dette rigtigt for mig?';

  @override
  String get safetyPracticeTitle => 'Rung er øvelse, ikke terapi.';

  @override
  String get safetyIntro =>
      'Rung er et værktøj til selvtillid og øvelse. Det hjælper dig med gradvist at møde hverdagens sociale situationer i dit eget tempo. Det er ikke terapi, ikke medicinsk behandling og ikke en diagnose.';

  @override
  String get safetyPoint1 =>
      'Målet er en håndterbar frygt — at føle dig mere tilpas i de øjeblikke, du plejede at undgå. Ikke at blive en anden person.';

  @override
  String get safetyPoint2 =>
      'At springe over er altid i orden og tæller aldrig imod dig. Der er ingen skammekanismer her.';

  @override
  String get safetyPoint3 =>
      'Dine data er dine. Alt fungerer offline, uden en konto.';

  @override
  String get safetyMoreTitle => 'Hvis dette er mere end nervøsitet';

  @override
  String get safetyMoreBody =>
      'Hvis angst påvirker din hverdag alvorligt, eller du nogensinde har tanker om at skade dig selv, så kontakt en kvalificeret fagperson eller en lokal krisetelefon. Det er et stærkt, sundt skridt — og Rung erstatter det ikke.';

  @override
  String get legalLastUpdated => 'Sidst opdateret: juni 2026';

  @override
  String legalQuestions(String email) {
    return 'Spørgsmål? Kontakt os på $email.';
  }

  @override
  String get privacyTitle => 'Privatlivspolitik';

  @override
  String get privacyIntro =>
      'Rung er et privat øvelsesværktøj til at opbygge social selvtillid. Vi indsamler så lidt som muligt, og det mest personlige, du skriver, forlader aldrig din telefon. Denne politik forklarer, hvad vi gemmer og hvorfor.';

  @override
  String get ppWhatStaysHead => 'Hvad der kun bliver på din enhed';

  @override
  String get ppWhatStaysBody =>
      'Dine refleksionsnoter og forudsigelsesnoter — de private ting, du skriver om, hvordan et øjeblik føltes — gemmes kun i appen på din enhed. De uploades aldrig til vores servere.';

  @override
  String get ppCloudHead => 'Hvad vi gemmer i skyen';

  @override
  String get ppCloudBody =>
      'Når du opretter en konto, gemmer vi: din e-mailadresse (til login; din adgangskode er krypteret, og vi ser den aldrig), et valgfrit vist navn og en bio, samt din privatlivslåsindstilling. For at drive fællesskabet («grupper») gemmer vi de beskeder, du sender, og eventuelle blokeringer eller anmeldelser, du foretager. For at holde dine fremskridt sikre på tværs af enheder sikkerhedskopierer vi kun tal — din stime, gennemførte udfordringer og angstvurderinger (forudsagt vs faktisk) — plus egne trin, du opretter. Notetekst er aldrig inkluderet.';

  @override
  String get ppAnalyticsHead => 'Analyse';

  @override
  String get ppAnalyticsBody =>
      'Vi bruger privatlivsrespekterende produktanalyse (PostHog) til at forstå, hvilke funktioner der hjælper, med anonyme brugshændelser som «åbnede en skærm» eller «gennemførte et skridt». Vi sender aldrig indholdet af dine noter eller beskeder til analysen.';

  @override
  String get ppUseHead => 'Hvordan vi bruger dine oplysninger';

  @override
  String get ppUseBody =>
      'Kun for at levere appen: logge dig ind, drive grupperne, gendanne dine fremskridt og forbedre Rung ved hjælp af aggregerede, anonyme tendenser. Vi sælger ikke dine data og bruger dem ikke til reklame.';

  @override
  String get ppProcessHead => 'Hvem der behandler dine data';

  @override
  String get ppProcessBody =>
      'Vi bruger Supabase (autentificering, database og hosting) og PostHog (analyse) som databehandlere. De behandler data på vores vegne under deres egne sikkerheds- og privatlivsforpligtelser.';

  @override
  String get ppRightsHead => 'Dine rettigheder og valg';

  @override
  String get ppRightsBody =>
      'Du kan redigere din profil, låse den så andre medlemmer ikke kan se den, og permanent slette din konto og alle tilknyttede skydata når som helst fra Profil → Slet konto. Du kan også skrive til os for at anmode om adgang til eller sletning af dine data.';

  @override
  String get ppSecurityHead => 'Sikkerhed og opbevaring';

  @override
  String get ppSecurityBody =>
      'Data krypteres under overførsel, og hver tabel er beskyttet af sikkerhed på rækkeniveau, så du kun kan tilgå dine egne data (og gruppebeskeder, hvor du er medlem). Vi opbevarer dine data, indtil du sletter din konto eller beder os fjerne dem.';

  @override
  String get ppChildrenHead => 'Børn';

  @override
  String get ppChildrenBody =>
      'Rung er ikke beregnet til nogen under 16 år. Hvis du tror, at et barn har oprettet en konto, så kontakt os, og vi fjerner den.';

  @override
  String get ppMedicalHead => 'Ikke medicinsk behandling';

  @override
  String get ppMedicalBody =>
      'Rung understøtter gradvis øvelse, men er ikke terapi, diagnose eller lægelig rådgivning. Hvis du er i krise, så kontakt de lokale nødtjenester eller en krisetelefon.';

  @override
  String get ppChangesHead => 'Ændringer';

  @override
  String get ppChangesBody =>
      'Hvis vi opdaterer denne politik, ændrer vi datoen ovenfor og giver dig ved væsentlige ændringer besked i appen.';

  @override
  String get termsTitle => 'Servicevilkår';

  @override
  String get termsIntro =>
      'Disse vilkår er aftalen mellem dig og Rung, når du bruger appen. Ved at oprette en konto eller bruge Rung accepterer du dem.';

  @override
  String get tosMedicalHead => 'Ikke en medicinsk tjeneste';

  @override
  String get tosMedicalBody =>
      'Rung er et selvhjælps- og øvelsesværktøj, ikke terapi eller lægebehandling, og erstatter ikke professionel hjælp. Det kan ikke garantere noget bestemt resultat. Hvis du er i krise eller kan skade dig selv eller andre, så kontakt straks de lokale nødtjenester.';

  @override
  String get tosEligibilityHead => 'Berettigelse';

  @override
  String get tosEligibilityBody =>
      'Du skal være mindst 16 år for at bruge Rung og have ret til at acceptere disse vilkår.';

  @override
  String get tosAccountHead => 'Din konto';

  @override
  String get tosAccountBody =>
      'Hold dine loginoplysninger sikre — du er ansvarlig for aktivitet på din konto. Sig til med det samme, hvis du har mistanke om uautoriseret brug.';

  @override
  String get tosCommunityHead => 'Fællesskabsregler (grupper)';

  @override
  String get tosCommunityBody =>
      'Grupper er til venlighed og støtte. Du accepterer ikke at chikanere, true, nedgøre, spamme eller poste hadefuldt eller ulovligt indhold, og ikke at dele andres private oplysninger. Vi kan fjerne indhold eller suspendere konti, der bryder disse regler. Du kan blokere og anmelde andre medlemmer når som helst.';

  @override
  String get tosContentHead => 'Indhold du poster';

  @override
  String get tosContentBody =>
      'Du beholder ejerskabet af det, du skriver. Ved at poste i en gruppe giver du os tilladelse til at gemme det og vise det til medlemmerne af den gruppe, så fællesskabet fungerer. Post ikke noget, du ikke har ret til at dele.';

  @override
  String get tosSubsHead => 'Abonnementer';

  @override
  String get tosSubsBody =>
      'Nogle funktioner og ekstra øvelsesindhold er tilgængeligt med et betalt abonnement. Når fakturering er aktiv, håndteres køb og fornyelser af app-butikken, og du kan administrere eller opsige via din app-butikskonto. Priser og indhold kan ændres med varsel.';

  @override
  String get tosDisclaimerHead => 'Ansvarsfraskrivelser og ansvar';

  @override
  String get tosDisclaimerBody =>
      'Rung leveres «som det er», uden garantier af nogen art. I det omfang loven tillader det, er vi ikke ansvarlige for indirekte tab eller følgetab, der opstår ved din brug af appen.';

  @override
  String get tosEndingHead => 'Afslutning af din brug';

  @override
  String get tosEndingBody =>
      'Du kan slette din konto når som helst fra Profil → Slet konto. Vi kan suspendere eller afslutte adgangen, hvis disse vilkår brydes alvorligt eller gentagne gange.';

  @override
  String get tosChangesHead => 'Ændringer';

  @override
  String get tosChangesBody =>
      'Vi kan opdatere disse vilkår; vi opdaterer datoen ovenfor og giver dig ved væsentlige ændringer besked i appen. Fortsat brug af Rung betyder, at du accepterer de opdaterede vilkår.';

  @override
  String get breatheCta => 'Mærker du frygten? Træk vejret først';

  @override
  String get breatheIntro => 'Tres sekunder. Følg bare cirklen.';

  @override
  String get breatheIn => 'Ånd ind';

  @override
  String get breatheHold => 'Hold';

  @override
  String get breatheOut => 'Ånd ud';

  @override
  String get breatheSkip => 'Spring over';

  @override
  String get breatheDoneTitle => 'Sådan.';

  @override
  String get breatheDoneSub =>
      'Føles det lidt mere stabilt? Tag dit trin, når du er klar.';

  @override
  String get breatheDoneBtn => 'Færdig';

  @override
  String get insightsDeeperTitle => 'Dybere indsigt';

  @override
  String get insightsLockedBody =>
      'Se din måned på et øjeblik — hvor meget varmere din frygt løb end virkeligheden, og hvor ofte du overvurderede den. En Premium-fordel.';

  @override
  String get insightsUnlockCta => 'Lås op med Premium';

  @override
  String get insightsNoSteps =>
      'Ingen skridt noteret denne måned endnu. Mød et par stykker, så dukker dit overblik op her.';

  @override
  String get insightsFearsFacedMonth => 'møder med frygten denne måned';

  @override
  String insightsGapHotter(String points) {
    return 'Din frygt løb i gennemsnit $points point varmere end virkeligheden.';
  }

  @override
  String get insightsGapTougher =>
      'Virkeligheden var lidt hårdere, end du forudsagde denne måned — det er også modige data.';

  @override
  String get insightsGapSpotOn =>
      'Dine forudsigelser ramte ret præcist denne måned.';

  @override
  String insightsOverPredicted(int rate) {
    return 'Du overvurderede frygten $rate% af gangene.';
  }

  @override
  String get insightsTrendSame => 'Samme som sidste måned';

  @override
  String insightsTrendMore(int count) {
    return '$count flere end sidste måned';
  }

  @override
  String insightsTrendFewer(int count) {
    return '$count færre end sidste måned';
  }

  @override
  String get rateTitle => 'Kan du lide Rung?';

  @override
  String get ratePromptNone => 'Hvordan føles Rung for dig?';

  @override
  String get ratePromptLow =>
      'Ærgerligt, at det ikke rammer. Hvad mangler der?';

  @override
  String get ratePromptMid => 'Tak — hvad skulle der til for en 5\'er?';

  @override
  String get ratePromptHigh => 'Det betyder meget. Hvad kan du lide?';

  @override
  String get rateHintLove => 'Noget du kan lide? (valgfrit)';

  @override
  String get rateHintMore => 'Fortæl os mere (valgfrit)';

  @override
  String get rateSend => 'Send';

  @override
  String get rateThanksHigh => 'Tak — det hjælper virkelig. 🌱';

  @override
  String get rateThanksLow =>
      'Tak for ærligheden — vi bruger den til at blive bedre.';

  @override
  String get editProfileTitle => 'Rediger profil';

  @override
  String get editDisplayName => 'Vist navn';

  @override
  String get editDisplayNameHint => 'Hvad skal grupperne kalde dig?';

  @override
  String get editBio => 'Kort bio (valgfrit)';

  @override
  String get editBioHint =>
      'En linje om dig — holdes privat, hvis du låser din profil.';

  @override
  String get errorOffline =>
      'Du er offline. Opret forbindelse til internettet, og prøv igen.';

  @override
  String get errorGeneric => 'Noget gik galt. Prøv igen.';

  @override
  String get errorSaveFailed =>
      'Kunne ikke gemme — din enhed har måske lidt lagerplads. Frigør plads, og prøv igen.';
}
