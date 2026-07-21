// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get navHome => 'Home';

  @override
  String get navGroups => 'Gruppi';

  @override
  String get navPremium => 'Premium';

  @override
  String get navProfile => 'Profilo';

  @override
  String get greetingMorning => 'Buongiorno';

  @override
  String get greetingAfternoon => 'Buon pomeriggio';

  @override
  String get greetingEvening => 'Buonasera';

  @override
  String get todayStepIntro => 'Ecco un piccolo passo per oggi.';

  @override
  String get commonContinue => 'Continua';

  @override
  String get commonCancel => 'Annulla';

  @override
  String get commonSave => 'Salva';

  @override
  String get commonDone => 'Fatto';

  @override
  String get commonNotNow => 'Non ora';

  @override
  String get profileTitle => 'Profilo';

  @override
  String get language => 'Lingua';

  @override
  String get languageSystemDefault => 'Lingua del sistema';

  @override
  String get yourTone => 'Il tuo tono';

  @override
  String get appearance => 'Aspetto';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Chiaro';

  @override
  String get themeDark => 'Scuro';

  @override
  String get onbSkip => 'Salta';

  @override
  String get onbWelcomeTitle =>
      'Affronta i momenti che temevi — un piccolo passo alla volta.';

  @override
  String get onbWelcomeBody =>
      'Rung ti aiuta a costruire sicurezza sociale con una pratica delicata e privata. Prevedi, fallo, rifletti — e guarda le tue paure peggiori sciogliersi nei tuoi stessi numeri.';

  @override
  String get onbGetStarted => 'Inizia';

  @override
  String get onbSafetyTitle => 'Pratica, non terapia.';

  @override
  String get onbUnderstand => 'Ho capito';

  @override
  String get onbSafetyBody1 =>
      'Rung è uno strumento di sicurezza e pratica — non è terapia, né trattamento medico, né una diagnosi.';

  @override
  String get onbSafetyBody2 =>
      'L\'obiettivo è sentirti più a tuo agio nei momenti che temevi — non diventare qualcuno che non sei. Saltare va sempre bene.';

  @override
  String get onbSafetyCrisis =>
      'Se l\'ansia sta compromettendo gravemente la tua vita, o se hai mai pensieri di farti del male, rivolgiti a un professionista o a una linea di crisi locale.';

  @override
  String get onbFearTitle => 'Da dove ti piacerebbe iniziare?';

  @override
  String get onbFearBody =>
      'Solo per suggerirti un primo passo — puoi affrontare uno qualsiasi di questi in qualsiasi momento. Niente qui ti vincola.';

  @override
  String get onbExploreOwn => 'Preferisco esplorare da solo';

  @override
  String get onbToneTitle => 'Cosa ti somiglia di più?';

  @override
  String get onbToneIntrovertTitle => 'Sono piuttosto introverso';

  @override
  String get onbToneIntrovertBody =>
      'Voglio sentirmi a mio agio, non diventare una persona diversa.';

  @override
  String get onbToneSituationalTitle => 'Divento ansioso in certe situazioni';

  @override
  String get onbToneSituationalBody =>
      'A volte sono estroverso, ma certi momenti mi mettono in difficoltà.';

  @override
  String get onbToneFootnote =>
      'Puoi cambiarlo in qualsiasi momento nel Profilo.';

  @override
  String get onbHowTitle => 'Ecco come funziona.';

  @override
  String get onbStartClimbing => 'Inizia a salire';

  @override
  String get onbStep1 => 'Prevedi quanto sarà difficile (0–10).';

  @override
  String get onbStep2 => 'Fallo nella vita reale — l\'app può restare chiusa.';

  @override
  String get onbStep3 => 'Torna e annota com\'è andata davvero.';

  @override
  String get onbGentleFirstStep => 'UN PRIMO PASSO DELICATO';

  @override
  String get onbGoodPlaceToStart => 'UN BUON PUNTO DI PARTENZA';

  @override
  String get onbAllAreas =>
      'Tutte e sei le aree sono nella tua schermata iniziale — inizia da dove vuoi.';

  @override
  String get predictAppBar => 'Prima di andare';

  @override
  String get predictSaved =>
      'Salvato. Vai a farlo — poi torna per annotare com\'è andata.';

  @override
  String get predictQuestion => 'Quanto pensi che sarà difficile?';

  @override
  String get predictNoteLabel => 'Cosa prevedi che succeda? (facoltativo)';

  @override
  String get predictNoteHint => 'es. Penseranno che sono impacciato';

  @override
  String get predictCompare =>
      'Lo confronteremo con come va davvero. Quel divario è tutto il punto.';

  @override
  String get predictDoIt => 'Lo farò';

  @override
  String get reflectAppBar => 'Com\'è andata?';

  @override
  String get reflectDidYouDoIt => 'L\'hai fatto?';

  @override
  String get reflectHowAnxious => 'Quanto ti faceva ansia il solo pensiero?';

  @override
  String get reflectHowBad => 'Quanto è stato difficile, in realtà?';

  @override
  String get reflectNoteLabel => 'Qualcosa che vuoi ricordare? (facoltativo)';

  @override
  String get reflectOutcomeDone => 'Fatto';

  @override
  String get reflectOutcomePartial => 'In parte';

  @override
  String get reflectOutcomeNotToday => 'Non oggi';

  @override
  String get resultQuietDelight => 'Una gioia silenziosa in ogni passo.';

  @override
  String get resultBackToLadder => 'Torna alla scala';

  @override
  String resultGapHeadline(int predicted, int actual) {
    return 'Ti eri preparato per $predicted. È stato $actual.';
  }

  @override
  String resultGapSub(int predicted, int actual) {
    return 'Il tuo cuore si era preparato a un pesante $predicted, ma il mondo ti ha accolto con un più gentile $actual. Vale la pena ricordarlo.';
  }

  @override
  String get resultRightHeadline => 'Esattamente come avevi previsto.';

  @override
  String get resultRightSub =>
      'L\'avevi previsto — e ti sei comunque presentato. Questa è la vittoria.';

  @override
  String get resultTougherHeadline =>
      'Più difficile del previsto — e l\'hai fatto.';

  @override
  String get resultTougherSub =>
      'Certi momenti ci chiedono di più. Presentarsi comunque è tutto il punto.';

  @override
  String get resultPredicted => 'Previsto';

  @override
  String get resultActual => 'Reale';

  @override
  String resultLighter(int reduction) {
    return 'Questo momento è stato più leggero del $reduction% rispetto a quanto temevi';
  }

  @override
  String get resultSkippedHeadline => 'Annotato — nessuna pressione.';

  @override
  String get resultSkippedSub =>
      '«Non oggi» è una risposta perfettamente valida. Questo gradino è ancora qui quando sarai pronto.';

  @override
  String get resultWinCopied => 'Vittoria copiata — incollala dove vuoi.';

  @override
  String get resultCopyWin => 'Copia la mia vittoria';

  @override
  String resultShareText(String rung) {
    return 'Ho appena fatto una cosa che evitavo: $rung. Un piccolo gradino salito. 🪜 #Rung';
  }

  @override
  String get tracksTitle => 'I tuoi percorsi';

  @override
  String get tracksSubtitle => 'Piccoli passi verso una grande sicurezza.';

  @override
  String get menuInsights => 'Analisi';

  @override
  String get menuIsThisRight => 'È adatto a me?';

  @override
  String tracksRungsCount(int done, int total) {
    return '$done di $total gradini';
  }

  @override
  String tracksClimbedCount(int done, int total) {
    return '$done di $total saliti';
  }

  @override
  String get tracksContinueLabel => 'RIPRENDI DA DOVE AVEVI LASCIATO';

  @override
  String get tracksNextStepLabel => 'IL TUO PROSSIMO PASSO';

  @override
  String get tracksLoadError => 'Impossibile caricare i percorsi.';

  @override
  String get todayResume => 'Riprendi da dove avevi lasciato';

  @override
  String get todayNext => 'Il tuo prossimo passo';

  @override
  String get todayVariety => 'Qualcosa di un po\' diverso';

  @override
  String get todayFresh => 'Il tuo punto di partenza';

  @override
  String get todayResumeCta => 'Finisci di annotare';

  @override
  String get todayStartCta => 'Inizia';

  @override
  String todayMinutes(int min) {
    return '~$min min';
  }

  @override
  String get dashShareTooltip => 'Condividi i miei progressi';

  @override
  String get dashWeeklyGoal => 'Obiettivo settimanale';

  @override
  String dashStepsPerWeek(int count) {
    return '$count passi/settimana';
  }

  @override
  String dashGoalPerWeek(int count) {
    return '$count/settimana';
  }

  @override
  String dashWeeklyProgress(int done, int goal) {
    return '$done di $goal passi completati questa settimana';
  }

  @override
  String get dashYourGrowth => 'La tua crescita';

  @override
  String get dashTodayError =>
      'Impossibile caricare il passo di oggi. Trascina per riprovare.';

  @override
  String get dashTodayAllClear =>
      'Hai completato tutto ciò che era disponibile — aggiungi un gradino personalizzato o rivedine uno per mantenere la serie.';

  @override
  String get dashTakeABreak => 'Prenditi una pausa';

  @override
  String get dashTakeABreakSub =>
      'Qualche gioco tranquillo — contro il telefono o con un amico.';

  @override
  String get ladderTitleFallback => 'Scala';

  @override
  String get ladderLoadError => 'Impossibile caricare la scala.';

  @override
  String get ladderAddOwn => 'Aggiungi il tuo gradino';

  @override
  String ladderOfClimbed(int total) {
    return 'di $total saliti';
  }

  @override
  String get detailLoadError => 'Impossibile caricare.';

  @override
  String get detailNotExist => 'Questo gradino non esiste più.';

  @override
  String get detailWhatToDo => 'Cosa fare';

  @override
  String get detailWhyHelps => 'Perché aiuta';

  @override
  String get detailPastAttempts => 'I tuoi tentativi passati';

  @override
  String get detailDoThis => 'Lo farò';

  @override
  String get detailReattempt =>
      'Riprovare è incoraggiato — arricchisce i tuoi dati.';

  @override
  String detailHistoryStat(int predicted, int actual) {
    return 'previsto $predicted · reale $actual';
  }

  @override
  String customLimitPremium(int cap) {
    return 'Hai raggiunto il limite di questo mese di $cap gradini personalizzati — si azzera il mese prossimo.';
  }

  @override
  String get customLimitFree =>
      'Il piano gratuito include 5 gradini personalizzati — passa a Premium per averne di più ogni mese.';

  @override
  String get customDefaultWhat => 'Una sfida che ti sei posto.';

  @override
  String get customDefaultWhy =>
      'L\'hai definita tu — è questo che la rende importante.';

  @override
  String get customSubtitle =>
      'La tua situazione è specifica — questo gradino è solo per te.';

  @override
  String get customWhatLabel => 'Cosa farai?';

  @override
  String get customWhatHint => 'es. Chiedere un riscontro al mio responsabile';

  @override
  String get customNoteLabel => 'Una nota per te (facoltativo)';

  @override
  String customDifficulty(int value) {
    return 'Quanto ti sembra difficile? $value/10';
  }

  @override
  String get customAddToLadder => 'Aggiungi alla scala';

  @override
  String get paywallSwitchToFree => 'Passa a Gratuito';

  @override
  String get paywallHeroTitle => 'Non devi affrontarlo da solo.';

  @override
  String get paywallHeroBody =>
      'La pratica quotidiana è sempre gratuita. Premium aggiunge un coach privato dalla tua parte — e una comunità più grande accanto a te — per quando sei pronto ad andare oltre.';

  @override
  String get paywallWhatsIncluded => 'Cosa è incluso';

  @override
  String get paywallPlusHeader => 'Inoltre, ogni abbonato riceve';

  @override
  String get paywallBenefitCoach =>
      'Un coach privato, in qualsiasi momento — prova qualcosa in arrivo o parla di com\'è andata';

  @override
  String get paywallBenefitPods =>
      'Non lo stai facendo da solo — unisciti a più pod di supporto (3 con il mensile, illimitati con l\'annuale)';

  @override
  String get paywallBenefitCustom =>
      'Crea scale illimitate tutte tue — nessun limite ai gradini personalizzati';

  @override
  String get paywallBenefitDepth =>
      'Vai più a fondo quando sei pronto — fino a 40 passi per percorso (il gratuito è un arco completo di 10 passi)';

  @override
  String get paywallPlusStreak =>
      'Protezione della serie — un giorno saltato non interrompe la tua serie';

  @override
  String get paywallPlusInsights =>
      'Analisi più approfondite — il tuo mese in un colpo d\'occhio';

  @override
  String get paywallPlusShare => 'Stili personali per le card da condividere';

  @override
  String get paywallPlusPrivacy => 'Sempre privato, sempre senza pubblicità';

  @override
  String get paywallYearly => 'Annuale';

  @override
  String get paywallPerYear => 'all\'anno · miglior valore';

  @override
  String get paywallSave => 'Risparmia il 33%';

  @override
  String get paywallMonthly => 'Mensile';

  @override
  String get paywallPerMonth => 'al mese';

  @override
  String get paywallSwitchYearly => 'Passa all\'annuale';

  @override
  String get paywallSwitchMonthly => 'Passa al mensile';

  @override
  String paywallStartYearly(String price) {
    return 'Inizia l\'annuale — $price';
  }

  @override
  String paywallStartMonthly(String price) {
    return 'Inizia il mensile — $price';
  }

  @override
  String get paywallRestore => 'Ripristina acquisti';

  @override
  String paywallCurrentPlan(String plan) {
    return 'Piano attuale: $plan. Annulla quando vuoi.';
  }

  @override
  String get paywallCancelAnytime =>
      'Annulla quando vuoi. Il percorso di base resta gratuito per sempre.';

  @override
  String get paywallSimulated =>
      'Premium attivo (simulato — aggiungi le chiavi RevenueCat per acquisti reali).';

  @override
  String get paywallPlanUnavailable =>
      'Quel piano non è disponibile al momento. Riprova tra poco.';

  @override
  String get paywallThankYou => 'Premium attivo — grazie. 🌱';

  @override
  String get paywallPurchaseFailed =>
      'L\'acquisto non è andato a buon fine. Non ti è stato addebitato nulla.';

  @override
  String get paywallRestored => 'Acquisti ripristinati.';

  @override
  String get paywallNoRestore =>
      'Nessun acquisto precedente trovato su questo account.';

  @override
  String get paywallRestoreFailed =>
      'Impossibile ripristinare ora. Riprova tra poco.';

  @override
  String get profileAddName => 'Aggiungi il tuo nome';

  @override
  String get profileLockTitle => 'Blocca il mio profilo';

  @override
  String get profileLockedSub =>
      'Nascosto — i membri del pod non possono aprire i tuoi dettagli.';

  @override
  String get profileUnlockedSub =>
      'I membri del pod possono toccare il tuo avatar per vedere i tuoi dettagli.';

  @override
  String get profilePlanTitle => 'Il tuo piano';

  @override
  String get profilePremium => 'Premium';

  @override
  String get profileUpgrade => 'Passa a Premium';

  @override
  String get profileToneDesc =>
      'Rung parla con delicatezza per impostazione predefinita. Se la tua ansia è più situazionale, un tono un po\' più deciso potrebbe adattarsi meglio a te.';

  @override
  String get profileToneIntrovert => 'Introverso';

  @override
  String get profileToneSituational => 'Situazionale';

  @override
  String get profileSafetySub =>
      'Come si inserisce Rung — e quando cercare di più';

  @override
  String get profileBlockedTitle => 'Membri bloccati';

  @override
  String get profileBlockedSub => 'Vedi e sblocca le persone che hai bloccato';

  @override
  String get profileRestoreTitle => 'Ripristina i miei progressi';

  @override
  String get profileRestoreSub => 'Recupera la tua serie e le sfide dal cloud';

  @override
  String get profileRestoring => 'Ripristino in corso…';

  @override
  String get profileRestoreOk => 'Progressi ripristinati dal cloud.';

  @override
  String profileRestoreFail(String error) {
    return 'Ripristino non riuscito: $error';
  }

  @override
  String get profileLogout => 'Esci';

  @override
  String get profileChangePwTitle => 'Cambia password';

  @override
  String get profileChangePwSub =>
      'Imposta una nuova password per il tuo account';

  @override
  String get profileChangePwSaved => 'Password aggiornata';

  @override
  String get profileSignedIn => 'Accesso effettuato';

  @override
  String get profileLogoutConfirmTitle => 'Uscire?';

  @override
  String get profileLogoutConfirmBody =>
      'I tuoi progressi sono salvati nel cloud e tornano quando accedi di nuovo.';

  @override
  String get profileLoggingOut => 'Uscita in corso…';

  @override
  String get profileRateTitle => 'Valuta Rung';

  @override
  String get profileRateSub => 'Dicci come sta andando — aiuta davvero';

  @override
  String get profilePrivacyTitle => 'Informativa sulla privacy';

  @override
  String get profilePrivacySub =>
      'Cosa memorizziamo — e cosa resta sul tuo dispositivo';

  @override
  String get profileTermsTitle => 'Termini di servizio';

  @override
  String get profileTermsSub => 'L\'accordo per usare Rung';

  @override
  String get profileDeleteTitle => 'Elimina account';

  @override
  String get profileDeleteSub =>
      'Cancella definitivamente il tuo account e i tuoi dati';

  @override
  String get profileFooter =>
      'Rung · pratica, non terapia. I tuoi dati sono tuoi.';

  @override
  String get profileDeleteConfirmTitle => 'Eliminare l\'account?';

  @override
  String get profileDeleteConfirmBody =>
      'Questo elimina definitivamente il tuo account, i tuoi messaggi nei pod e i progressi salvati. Non è reversibile.';

  @override
  String get profileDelete => 'Elimina';

  @override
  String get profileDeleting => 'Eliminazione dell\'account…';

  @override
  String get profileDeleteFail => 'Impossibile eliminare l\'account. Riprova.';

  @override
  String get profileBioPlaceholder => 'Uno scalatore tranquillo.';

  @override
  String get profileHaptics => 'Vibrazione';

  @override
  String get profileHapticsSub => 'Vibrazione delicata a tocchi e vittorie';

  @override
  String get profileNotifications => 'Notifiche';

  @override
  String get profileNotificationsSub => 'Avvisi da Rung su questo dispositivo';

  @override
  String get profilePodAlerts => 'Avvisi messaggi dei pod';

  @override
  String get profilePodAlertsSub =>
      'Avvisami quando qualcuno scrive nei miei pod';

  @override
  String get profileEnableNotifs =>
      'Abilita le notifiche nelle Impostazioni per ricevere i promemoria.';

  @override
  String get profileReminderHelp => 'Quando dovremmo darti una spinta?';

  @override
  String get profileReminderTitle => 'Promemoria quotidiano delicato';

  @override
  String profileReminderOn(String time) {
    return 'Ogni giorno alle $time · tocca l\'interruttore per disattivare';
  }

  @override
  String get profileReminderOff =>
      'Una spinta calma e senza sensi di colpa per fare un piccolo passo';

  @override
  String get profileAvatarTitle => 'Scegli il tuo avatar';

  @override
  String get profileAvatarSub =>
      'Solo tu puoi cambiarlo — lo vedono anche i tuoi compagni di pod.';

  @override
  String get commonClose => 'Chiudi';

  @override
  String get checkInMoodCalm => 'Calmo';

  @override
  String get checkInMoodOkay => 'Così così';

  @override
  String get checkInMoodAnxious => 'Ansioso';

  @override
  String get checkInMoodLow => 'Giù';

  @override
  String get checkInMoodTense => 'Teso';

  @override
  String get checkInTitle => 'Come arrivi oggi?';

  @override
  String get checkInDismiss => 'Ignora';

  @override
  String get checkInCalmCta => 'Prova un momento di calma';

  @override
  String get checkInStepCta => 'Vedi il passo di oggi';

  @override
  String get supportTitle => 'Sembra un bel peso da portare.';

  @override
  String get supportBody =>
      'Rung è uno strumento di pratica, non un servizio di crisi. Se stai attraversando qualcosa di pesante, rivolgiti a qualcuno che può aiutarti subito — una persona di fiducia o una linea di crisi locale. Meriti un supporto vero.';

  @override
  String get supportResources => 'Vedi risorse di supporto';

  @override
  String get progressChallenges => 'Sfide';

  @override
  String get progressCurrentStreak => 'Serie attuale';

  @override
  String get progressBestStreak => 'Serie migliore';

  @override
  String get progressThisWeek => 'Questa settimana';

  @override
  String get progressCategoryBreakdown => 'Suddivisione per categoria';

  @override
  String get insightsHistory => 'Cronologia';

  @override
  String checkInAckTitle(String mood) {
    return 'Registrato — ti senti $mood';
  }

  @override
  String get checkInAckGentle =>
      'Grazie per la sincerità. Manteniamo oggi delicato — una piccola cosa gentile è sufficiente.';

  @override
  String get checkInAckStep =>
      'Bellissimo. Quando sei pronto, un piccolo passo mantiene lo slancio.';

  @override
  String get sharePremiumPerk =>
      '✨ Altri stili di card sono un vantaggio Premium.';

  @override
  String get shareSeePremium => 'Vedi Premium';

  @override
  String get shareText =>
      'Piccoli passi coraggiosi, un gradino alla volta. 🌱 #Rung';

  @override
  String get shareError => 'Impossibile aprire la condivisione. Riprova.';

  @override
  String get shareTitle => 'Condividi i tuoi progressi';

  @override
  String get shareSubtitle => 'Solo i tuoi numeri — niente di privato.';

  @override
  String get shareCta => 'Condividi';

  @override
  String get shareCardHeadline => 'I miei passi coraggiosi';

  @override
  String get shareCardFearsFaced => 'paure affrontate';

  @override
  String get shareCardCurrentStreak => 'Serie attuale';

  @override
  String get shareCardBestStreak => 'Serie migliore';

  @override
  String get shareCardTagline =>
      'Affrontare le paure sociali, un piccolo gradino alla volta.';

  @override
  String get helpNow => 'Aiuto adesso';

  @override
  String get helpCalmMoment => 'Un momento di calma';

  @override
  String get helpTabBreathe => 'Respira';

  @override
  String get helpTabGround => 'Radicati';

  @override
  String get helpTabSay => 'Di\' questo';

  @override
  String get helpBreatheIn => 'Inspira…';

  @override
  String get helpBreatheOut => 'Espira…';

  @override
  String get helpBreatheHint => 'Segui il cerchio. Non c\'è fretta.';

  @override
  String get helpGround5 => 'cose che puoi vedere';

  @override
  String get helpGround4 => 'cose che puoi toccare';

  @override
  String get helpGround3 => 'cose che puoi sentire';

  @override
  String get helpGround2 => 'cose che puoi odorare';

  @override
  String get helpGround1 => 'cosa che puoi gustare';

  @override
  String get helpGroundTitle => 'Nomina, in silenzio dentro di te…';

  @override
  String get helpGroundHint =>
      'Questo ti riporta all\'adesso — dove sei al sicuro.';

  @override
  String get helpOpener1 => 'Come conosci le persone qui?';

  @override
  String get helpOpener2 => 'Adoro questo posto — c\'eri già stato?';

  @override
  String get helpOpener3 => 'Sono un disastro con i nomi — me lo ricordi?';

  @override
  String get helpOpener4 => 'Cosa hai fatto questa settimana?';

  @override
  String get helpExit1 =>
      'Vado a prendere qualcosa da bere — è stato bello parlare con te.';

  @override
  String get helpExit2 =>
      'Devo salutare al volo una persona, scusami un attimo.';

  @override
  String get helpExit3 => 'Ti lascio socializzare — ci vediamo dopo.';

  @override
  String get helpOpenersTitle => 'Frasi per rompere il ghiaccio';

  @override
  String get helpExitsTitle => 'Congedi eleganti';

  @override
  String get authEnterEmail => 'Inserisci la tua email';

  @override
  String get authBadEmail => 'Questa email non sembra corretta';

  @override
  String get authEnterPassword => 'Inserisci una password';

  @override
  String get authMin6 => 'Almeno 6 caratteri';

  @override
  String get authPwMismatch => 'Le password non coincidono';

  @override
  String get authConfirmEmail =>
      'Controlla la tua email per confermare, poi accedi. (Oppure disabilita la conferma via email nelle impostazioni di Supabase Auth per test rapidi.)';

  @override
  String get authGenericError => 'Qualcosa è andato storto. Riprova.';

  @override
  String get authCreateTitle => 'Crea il tuo account';

  @override
  String get authWelcomeBack => 'Bentornato';

  @override
  String get authSignUpSub =>
      'Unisciti ai pod e mantieni i tuoi progressi al sicuro su tutti i dispositivi.';

  @override
  String get authSignInSub =>
      'Accedi ai tuoi pod e ai progressi sincronizzati.';

  @override
  String get authDisplayName => 'Nome visualizzato (facoltativo)';

  @override
  String get authEmail => 'Email';

  @override
  String get authPassword => 'Password';

  @override
  String get authShowPassword => 'Mostra password';

  @override
  String get authHidePassword => 'Nascondi password';

  @override
  String get authConfirmPassword => 'Conferma password';

  @override
  String get authForgotPassword => 'Password dimenticata?';

  @override
  String get authResetTitle => 'Reimposta la password';

  @override
  String get authResetBody =>
      'Inserisci l\'email del tuo account e ti invieremo un link per impostare una nuova password.';

  @override
  String get authResetSend => 'Invia il link';

  @override
  String get authResetSent =>
      'Se quell\'email ha un account, il link è già in arrivo.';

  @override
  String get authNewPassword => 'Nuova password';

  @override
  String get authConfirmNewPassword => 'Conferma la nuova password';

  @override
  String get authUpdatePasswordCta => 'Aggiorna la password';

  @override
  String get authCreateCta => 'Crea account';

  @override
  String get authSignInCta => 'Accedi';

  @override
  String get authHaveAccount => 'Ho già un account';

  @override
  String get authNewAccount => 'Sono nuovo — crea un account';

  @override
  String get authLegalPrefixSignUp => 'Creando un account accetti i nostri ';

  @override
  String get authLegalPrefixSignIn => 'Continuando accetti i nostri ';

  @override
  String get authTerms => 'Termini';

  @override
  String get authAnd => ' e ';

  @override
  String get gamesIntro =>
      'Giochi tranquilli per concentrazione e mente serena — il tipo di allenamento mentale che le persone trovano rassicurante. Gioca contro il telefono o passalo a un amico.';

  @override
  String gamesBestMs(int ms) {
    return 'Migliore $ms ms';
  }

  @override
  String gamesBestLevel(int level) {
    return 'Livello migliore $level';
  }

  @override
  String gamesBest(String score) {
    return 'Migliore $score';
  }

  @override
  String gamesBestMoves(int moves) {
    return 'Migliore $moves mosse';
  }

  @override
  String gamesWinsVsPhone(int count) {
    return '$count vittorie contro il telefono';
  }

  @override
  String get gameTitleReaction => 'Velocità di reazione';

  @override
  String get gameTitleSequence => 'Memoria delle sequenze';

  @override
  String get gameTitleQuickMath => 'Calcolo veloce';

  @override
  String get gameTitleMemory => 'Memory';

  @override
  String get gameSubReaction => 'concentrazione · tocca quando diventa verde';

  @override
  String get gameSubSequence => 'memoria · guarda e ripeti';

  @override
  String get gameSub2048 => 'strategia · scorri per unire';

  @override
  String get gameSubQuickMath => 'velocità mentale · sprint di 30 secondi';

  @override
  String get gameSubTicTacToe => 'contro il telefono · o 2 giocatori';

  @override
  String get gameSubConnect4 => 'contro il telefono · o 2 giocatori';

  @override
  String get gameSubMemory => 'da solo · trova le coppie';

  @override
  String get gameHelpTooltip => 'Come si gioca';

  @override
  String gameHelpTitle(String game) {
    return 'Come si gioca · $game';
  }

  @override
  String get gameGotIt => 'Ho capito';

  @override
  String get tierFree => 'Gratuito';

  @override
  String get tierMonthly => 'Premium · Mensile';

  @override
  String get tierYearly => 'Premium · Annuale';

  @override
  String get podsUnlimited => 'pod illimitati';

  @override
  String podsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pod',
      one: '1 pod',
    );
    return '$_temp0';
  }

  @override
  String get groupsSignedOutTitle => 'Unisciti a un pod piccolo e gentile';

  @override
  String get groupsSignedOutBody =>
      'I gruppi richiedono un rapido account così i pod sono sicuri e tuoi. La tua pratica resta privata e senza account.';

  @override
  String get groupsSignInCta => 'Accedi per continuare';

  @override
  String get groupsLoadError =>
      'Impossibile caricare i pod. Trascina per riprovare.';

  @override
  String groupsJoined(String pod) {
    return 'Ti sei unito a $pod. Saluta quando sei pronto.';
  }

  @override
  String get groupsJoinedNew =>
      'Ti sei unito a un nuovo pod. Saluta quando sei pronto.';

  @override
  String get groupsNoPodFound => 'Impossibile trovare un pod ora. Riprova.';

  @override
  String groupsLeaveTitle(String pod) {
    return 'Lasciare $pod?';
  }

  @override
  String get groupsLeave => 'Lascia';

  @override
  String groupsLeft(String pod) {
    return 'Hai lasciato $pod.';
  }

  @override
  String get groupsLeaveError => 'Impossibile lasciare il pod. Riprova.';

  @override
  String get groupsHeader => 'Piccoli pod, persone gentili';

  @override
  String get groupsYourPods => 'I TUOI POD';

  @override
  String get groupsDiscoverPods => 'SCOPRI I POD';

  @override
  String get groupsJoinAnother => 'Unisciti a un altro pod';

  @override
  String get groupsNoOthers => 'Nessun altro pod a cui unirti al momento.';

  @override
  String groupsJoinedShort(String pod) {
    return 'Ti sei unito a $pod.';
  }

  @override
  String get groupsJoin => 'Unisciti';

  @override
  String get groupsPodOptions => 'Opzioni del pod';

  @override
  String get groupsLeavePod => 'Lascia il pod';

  @override
  String groupsMembers(int count, int capacity) {
    return '$count/$capacity membri';
  }

  @override
  String groupsTierPods(String tier, String pods) {
    return 'Con $tier puoi far parte di $pods.';
  }

  @override
  String groupsCapacityTierPods(int capacity, String tier, String pods) {
    return 'Fino a $capacity per pod. Con $tier puoi far parte di $pods.';
  }

  @override
  String groupsInYourPods(String pods) {
    return 'Sei nei tuoi $pods';
  }

  @override
  String get groupsUpgradeBody =>
      'Passa a Premium per unirti a di più — il mensile sblocca 3 pod, l\'annuale quanti ne vuoi.';

  @override
  String get groupsSafetyLive =>
      'Sii gentile. Puoi segnalare o bloccare chiunque dal suo profilo. I profili bloccati restano privati.';

  @override
  String get groupsSafetyPreview =>
      'Anteprima. I pod diventano chat live e moderate una volta configurato l\'accesso.';

  @override
  String get groupsLeaveBody =>
      'Smetterai di vedere i messaggi di questo pod. Puoi unirti di nuovo più tardi.';

  @override
  String get podRulesTitle => 'Regole del pod';

  @override
  String get podRulesIntro =>
      'I pod funzionano solo se tutti si sentono al sicuro. Unendoti accetti:';

  @override
  String get podRule1 =>
      'Sii gentile. Qui tutti stanno affrontando qualcosa di difficile.';

  @override
  String get podRule2 => 'Niente molestie, odio o contenuti dannosi. Mai.';

  @override
  String get podRule3 => 'Segnala o blocca chiunque ti metta a disagio.';

  @override
  String get podRule4 =>
      'Rispetta la privacy — ciò che si condivide qui resta qui.';

  @override
  String get podRule5 =>
      'I pod sono supporto tra pari, non un servizio di crisi. In un\'emergenza, contatta un professionista o una linea di crisi locale.';

  @override
  String get podRulesAgree => 'Accetto — fammi entrare';

  @override
  String chatIntrosBeKind(int count, int capacity) {
    return '$count/$capacity introversi · sii gentile';
  }

  @override
  String get chatHint => 'Di\' qualcosa di gentile…';

  @override
  String get chatPreviewBanner =>
      'Anteprima · per ora i messaggi restano sul tuo dispositivo. Pod reali e moderati arrivano con gli account.';

  @override
  String get chatYou => 'Tu';

  @override
  String get reportHarassment => 'Molestie o bullismo';

  @override
  String get reportHate => 'Odio o linguaggio dannoso';

  @override
  String get reportSpam => 'Spam o truffa';

  @override
  String get reportUnsafe => 'Mi fa sentire in pericolo';

  @override
  String get reportOther => 'Qualcos\'altro';

  @override
  String get memberPrivateTitle => 'Profilo privato';

  @override
  String get memberPrivateBody =>
      'Questo membro mantiene privato il proprio profilo. Puoi comunque chattare con lui — e segnalare o bloccare se necessario.';

  @override
  String memberStreak(int days) {
    return 'Serie di $days giorni';
  }

  @override
  String memberChallenges(int count) {
    return '$count sfide';
  }

  @override
  String memberClimbing(String track) {
    return 'In salita: $track';
  }

  @override
  String get memberReport => 'Segnala';

  @override
  String get memberBlock => 'Blocca';

  @override
  String get memberReportThanks => 'Grazie — lo esamineremo.';

  @override
  String get memberBlockToo => 'Blocca anche';

  @override
  String get memberBlocked => 'Bloccato. Non vedrai i suoi messaggi.';

  @override
  String get memberBlockError => 'Impossibile bloccare. Riprova.';

  @override
  String get memberReportError =>
      'Impossibile inviare la segnalazione. Riprova.';

  @override
  String get memberBlockConfirmTitle => 'Bloccare questo membro?';

  @override
  String get memberBlockConfirmBody =>
      'Non vedrete più i messaggi l\'uno dell\'altro. Puoi annullarlo più tardi.';

  @override
  String get memberSoonReporting =>
      'Le segnalazioni saranno attive nei pod moderati (accedi per usarle).';

  @override
  String get memberSoonBlocking =>
      'Il blocco sarà attivo nei pod moderati (accedi per usarlo).';

  @override
  String get memberWhatsWrong => 'Cosa c\'è che non va?';

  @override
  String get memberFallback => 'Membro';

  @override
  String get blockedUnblockError => 'Impossibile sbloccare. Riprova.';

  @override
  String blockedUnblocked(String name) {
    return 'Sbloccato $name. Vedrai di nuovo i suoi messaggi.';
  }

  @override
  String get blockedIntro =>
      'Bloccare nasconde i messaggi di un membro a te — e i tuoi a lui, in entrambi i sensi. Sblocca chiunque qui sotto per annullare.';

  @override
  String get blockedLabel => 'Bloccato';

  @override
  String get blockedUnblock => 'Sblocca';

  @override
  String get blockedEmptyTitle => 'Nessuno bloccato';

  @override
  String get blockedEmptyBody =>
      'Non hai bloccato nessuno. Bloccare nasconde i messaggi di un membro a te, in entrambi i sensi — e puoi sempre annullarlo qui.';

  @override
  String get chatCheckInPosted => 'Ottimo lavoro. Check-in del pod pubblicato.';

  @override
  String get chatCheckInError => 'Impossibile fare il check-in ora. Riprova.';

  @override
  String get chatDeleteMsgTitle => 'Eliminare il messaggio?';

  @override
  String get chatDeleteMsgBody => 'Questo lo rimuove per tutti nel pod.';

  @override
  String get chatReply => 'Rispondi';

  @override
  String get chatEdit => 'Modifica';

  @override
  String get chatDailyPrompt => 'Spunto quotidiano del pod';

  @override
  String get chatCheckedInToday => 'Check-in fatto oggi';

  @override
  String get chatDidMyStep => 'Ho fatto il mio passo';

  @override
  String chatCheckedInCount(int count) {
    return '$count hanno fatto il check-in';
  }

  @override
  String get chatNoMessages =>
      'Ancora nessun messaggio. Un semplice «ciao» è un coraggioso primo gradino.';

  @override
  String get chatEditingMessage => 'Modifica del tuo messaggio';

  @override
  String chatReplyingTo(String name) {
    return 'In risposta a $name';
  }

  @override
  String get chatYourself => 'te stesso';

  @override
  String get chatMsgDeleted => 'Questo messaggio è stato eliminato';

  @override
  String get chatPrivateMember => 'Membro privato';

  @override
  String chatBeKind(int count, int capacity) {
    return '$count/$capacity · sii gentile';
  }

  @override
  String get chatDeletedMessageShort => 'messaggio eliminato';

  @override
  String get gameYouWin => 'Hai vinto! 🎉';

  @override
  String get gamePhoneWins => 'Vince il telefono';

  @override
  String get gamePhoneThinking => 'Il telefono sta pensando…';

  @override
  String get gamePlayPhone => 'Gioca contro il telefono';

  @override
  String get game2Players => '2 giocatori';

  @override
  String get gameNewGame => 'Nuova partita';

  @override
  String get gameYou => 'Tu';

  @override
  String get gamePhone => 'Telefono';

  @override
  String get gameDraws => 'Pareggi';

  @override
  String get tttP1Wins => 'Vince il Giocatore 1 (X)! 🎉';

  @override
  String get tttP2Wins => 'Vince il Giocatore 2 (O)! 🎉';

  @override
  String get tttYourTurn => 'Tocca a te';

  @override
  String get tttP1Turn => 'Giocatore 1 · X';

  @override
  String get tttP2Turn => 'Giocatore 2 · O';

  @override
  String get tttP1Label => 'G1 (X)';

  @override
  String get tttP2Label => 'G2 (O)';

  @override
  String get tttRule1 => 'A turno, posiziona il tuo segno sulla griglia 3×3.';

  @override
  String get tttRule2 =>
      'Allinea tre dei tuoi segni — in orizzontale, verticale o diagonale — per vincere.';

  @override
  String get tttRule3 =>
      '«Gioca contro il telefono» è tu contro una semplice IA. «2 giocatori» passa il telefono a ogni turno.';

  @override
  String get c4P1Wins => 'Vince il Giocatore 1! 🎉';

  @override
  String get c4P2Wins => 'Vince il Giocatore 2! 🎉';

  @override
  String get c4Turn => 'Tocca a te — tocca una colonna';

  @override
  String get c4P1Turn => 'Giocatore 1 · rosso';

  @override
  String get c4P2Turn => 'Giocatore 2 · giallo';

  @override
  String get c4P1Label => 'G1';

  @override
  String get c4P2Label => 'G2';

  @override
  String get c4Rule1 =>
      'Tocca una colonna per far cadere il tuo gettone — scende nella casella libera più in basso.';

  @override
  String get c4Rule2 =>
      'Allinea quattro gettoni del tuo colore — in orizzontale, verticale o diagonale — per vincere.';

  @override
  String get c4Rule3 =>
      '«Gioca contro il telefono» è tu contro una semplice IA. «2 giocatori» passa il telefono.';

  @override
  String get gameDraw => 'È un pareggio 🤝';

  @override
  String get gamePlayAgain => 'Gioca di nuovo';

  @override
  String get gameStart => 'Inizia';

  @override
  String get g2048Rule1 =>
      'Scorri su, giù, a sinistra o a destra per far scivolare tutte le tessere.';

  @override
  String get g2048Rule2 =>
      'Due tessere con lo stesso numero si uniscono in una che raddoppia.';

  @override
  String get g2048Rule3 =>
      'Continua a unire per costruire una tessera 2048. Il tabellone si riempie — pianifica in anticipo!';

  @override
  String get g2048Score => 'Punteggio';

  @override
  String get g2048Best => 'Record';

  @override
  String get g2048GameOver => 'Partita finita';

  @override
  String get g2048Won => 'Hai fatto 2048! 🎉';

  @override
  String get g2048SwipeToMerge => 'Scorri per unire';

  @override
  String get qmRule1 => 'Hai 30 secondi — risolvine quanti più puoi.';

  @override
  String get qmRule2 => 'Tocca la risposta corretta tra le quattro scelte.';

  @override
  String get qmRule3 =>
      'Un tocco sbagliato costa 2 secondi, quindi leggi con attenzione.';

  @override
  String qmTimeScored(Object score) {
    return 'Tempo scaduto! Hai totalizzato $score';
  }

  @override
  String qmBestSub(Object best) {
    return 'Record $best · 30 secondi, rispondi a quante più puoi.';
  }

  @override
  String get qmStartSub => '30 secondi. Un tocco sbagliato costa 2 secondi.';

  @override
  String get qmCorrect => 'corrette';

  @override
  String get mmRule1 => 'Tocca una carta per girarla, poi girane una seconda.';

  @override
  String get mmRule2 =>
      'Se le due emoji coincidono, restano scoperte; altrimenti si rigirano.';

  @override
  String get mmRule3 => 'Trova tutte le coppie — con meno mosse possibili.';

  @override
  String mmAllMatched(Object moves) {
    return 'Tutte abbinate in $moves mosse! 🎉';
  }

  @override
  String mmFindPairs(Object moves) {
    return 'Trova le coppie · $moves mosse';
  }

  @override
  String mmBest(Object best) {
    return 'Record: $best mosse';
  }

  @override
  String get mmShuffle => 'Mescola';

  @override
  String get rxTapStart => 'Tocca per iniziare';

  @override
  String get rxWaitGreen => 'Aspetta il verde, poi tocca velocemente';

  @override
  String get rxWait => 'Aspetta…';

  @override
  String get rxTapMoment => 'Tocca nell\'istante in cui diventa verde';

  @override
  String rxBestRetry(Object ms) {
    return 'Record $ms ms · tocca per riprovare';
  }

  @override
  String get rxTapRetry => 'Tocca per riprovare';

  @override
  String get rxTooSoon => 'Troppo presto!';

  @override
  String get rxWaitRetry => 'Aspetta il verde · tocca per riprovare';

  @override
  String get rxTap => 'TOCCA!';

  @override
  String get rxRule1 =>
      'Tocca lo schermo per iniziare, poi aspetta — diventerà ambra.';

  @override
  String get rxRule2 =>
      'Nell\'istante in cui diventa verde, tocca il più velocemente possibile.';

  @override
  String get rxRule3 =>
      'Toccare troppo presto azzera. Un tempo più basso (ms) è migliore.';

  @override
  String get smWatchRepeat => 'Guarda lo schema, poi ripetilo.';

  @override
  String get smWatch => 'Guarda…';

  @override
  String smYourTurn(Object current, Object total) {
    return 'Tocca a te · $current di $total';
  }

  @override
  String smReachedBest(Object best, Object reached) {
    return 'Sei arrivato a $reached · record $best';
  }

  @override
  String smReached(Object reached) {
    return 'Sei arrivato a $reached';
  }

  @override
  String get smRule1 => 'Guarda le tessere illuminarsi una a una.';

  @override
  String get smRule2 => 'Ripeti lo stesso ordine esatto toccando le tessere.';

  @override
  String get smRule3 =>
      'Ogni round aggiunge un altro passo — vedi fin dove riesci ad arrivare.';

  @override
  String smRound(Object round) {
    return 'Round $round';
  }

  @override
  String get safetyScreenTitle => 'È adatto a me?';

  @override
  String get safetyPracticeTitle => 'Rung è pratica, non terapia.';

  @override
  String get safetyIntro =>
      'Rung è uno strumento di sicurezza e pratica. Ti aiuta ad affrontare gradualmente le situazioni sociali di ogni giorno, al tuo ritmo. Non è terapia, né trattamento medico, né una diagnosi.';

  @override
  String get safetyPoint1 =>
      'L\'obiettivo è un timore gestibile — sentirti più a tuo agio nei momenti che evitavi. Non diventare una persona diversa.';

  @override
  String get safetyPoint2 =>
      'Saltare va sempre bene e non conta mai contro di te. Qui non ci sono meccanismi di vergogna.';

  @override
  String get safetyPoint3 =>
      'I tuoi dati sono tuoi. Tutto funziona offline, senza bisogno di un account.';

  @override
  String get safetyMoreTitle => 'Se è più di semplice nervosismo';

  @override
  String get safetyMoreBody =>
      'Se l\'ansia sta compromettendo gravemente la tua vita quotidiana, o se hai mai pensieri di farti del male, rivolgiti a un professionista qualificato o a una linea di crisi locale. È un passo forte e sano — e Rung non lo sostituisce.';

  @override
  String get legalLastUpdated => 'Ultimo aggiornamento: giugno 2026';

  @override
  String legalQuestions(String email) {
    return 'Domande? Contattaci a $email.';
  }

  @override
  String get privacyTitle => 'Informativa sulla privacy';

  @override
  String get privacyIntro =>
      'Rung è uno strumento di pratica privato per costruire sicurezza sociale. Raccogliamo il meno possibile, e le cose più personali che scrivi non lasciano mai il tuo telefono. Questa informativa spiega cosa memorizziamo e perché.';

  @override
  String get ppWhatStaysHead => 'Cosa resta solo sul tuo dispositivo';

  @override
  String get ppWhatStaysBody =>
      'Le tue note di riflessione e di previsione — le cose private che scrivi su come ti è sembrato un momento — sono memorizzate solo nell\'app sul tuo dispositivo. Non vengono mai caricate sui nostri server.';

  @override
  String get ppCloudHead => 'Cosa memorizziamo nel cloud';

  @override
  String get ppCloudBody =>
      'Quando crei un account memorizziamo: il tuo indirizzo email (per l\'accesso; la tua password è crittografata e non la vediamo mai), un nome visualizzato e una bio facoltativi, e la tua impostazione di blocco della privacy. Per gestire la comunità («pod») memorizziamo i messaggi che pubblichi e qualsiasi blocco o segnalazione che effettui. Per mantenere i tuoi progressi al sicuro tra i dispositivi eseguiamo il backup solo di numeri — la tua serie, le sfide completate e le valutazioni d\'ansia (prevista vs reale) — oltre a eventuali passi personalizzati che crei. Il testo delle note non è mai incluso.';

  @override
  String get ppAnalyticsHead => 'Analisi';

  @override
  String get ppAnalyticsBody =>
      'Usiamo analisi di prodotto rispettose della privacy (PostHog) per capire quali funzioni aiutano, tramite eventi d\'uso anonimi come «ha aperto una schermata» o «ha completato un passo». Non inviamo mai il contenuto delle tue note o dei tuoi messaggi alle analisi.';

  @override
  String get ppUseHead => 'Come usiamo le tue informazioni';

  @override
  String get ppUseBody =>
      'Solo per fornire l\'app: farti accedere, gestire i pod, ripristinare i tuoi progressi e migliorare Rung usando tendenze aggregate e anonime. Non vendiamo i tuoi dati né li usiamo per la pubblicità.';

  @override
  String get ppProcessHead => 'Chi tratta i tuoi dati';

  @override
  String get ppProcessBody =>
      'Usiamo Supabase (autenticazione, database e hosting) e PostHog (analisi) come responsabili del trattamento. Trattano i dati per nostro conto secondo i loro impegni di sicurezza e privacy.';

  @override
  String get ppRightsHead => 'I tuoi diritti e le tue scelte';

  @override
  String get ppRightsBody =>
      'Puoi modificare il tuo profilo, bloccarlo così che gli altri membri non possano vederlo, ed eliminare definitivamente il tuo account e tutti i dati cloud associati in qualsiasi momento da Profilo → Elimina account. Puoi anche scriverci per richiedere l\'accesso o l\'eliminazione dei tuoi dati.';

  @override
  String get ppSecurityHead => 'Sicurezza e conservazione';

  @override
  String get ppSecurityBody =>
      'I dati sono crittografati in transito, e ogni tabella è protetta da sicurezza a livello di riga così che tu possa accedere solo ai tuoi dati (e ai messaggi dei pod di cui sei membro). Conserviamo i tuoi dati finché non elimini il tuo account o ci chiedi di rimuoverli.';

  @override
  String get ppChildrenHead => 'Minori';

  @override
  String get ppChildrenBody =>
      'Rung non è destinato a chi ha meno di 16 anni. Se ritieni che un minore abbia creato un account, contattaci e lo rimuoveremo.';

  @override
  String get ppMedicalHead => 'Non è assistenza medica';

  @override
  String get ppMedicalBody =>
      'Rung sostiene la pratica graduale ma non è terapia, diagnosi o consulenza medica. Se sei in crisi, contatta i servizi di emergenza locali o una linea di crisi.';

  @override
  String get ppChangesHead => 'Modifiche';

  @override
  String get ppChangesBody =>
      'Se aggiorniamo questa informativa cambieremo la data qui sopra e, per modifiche sostanziali, te lo comunicheremo nell\'app.';

  @override
  String get termsTitle => 'Termini di servizio';

  @override
  String get termsIntro =>
      'Questi termini sono l\'accordo tra te e Rung quando usi l\'app. Creando un account o usando Rung, li accetti.';

  @override
  String get tosMedicalHead => 'Non è un servizio medico';

  @override
  String get tosMedicalBody =>
      'Rung è uno strumento di auto-aiuto e pratica, non terapia o assistenza medica, e non sostituisce l\'aiuto professionale. Non può garantire alcun risultato specifico. Se sei in crisi o rischi di fare del male a te stesso o ad altri, contatta immediatamente i servizi di emergenza locali.';

  @override
  String get tosEligibilityHead => 'Requisiti';

  @override
  String get tosEligibilityBody =>
      'Devi avere almeno 16 anni per usare Rung e avere il diritto di accettare questi termini.';

  @override
  String get tosAccountHead => 'Il tuo account';

  @override
  String get tosAccountBody =>
      'Mantieni al sicuro i tuoi dati di accesso — sei responsabile dell\'attività sul tuo account. Avvisaci tempestivamente se sospetti un uso non autorizzato.';

  @override
  String get tosCommunityHead => 'Regole della comunità (pod)';

  @override
  String get tosCommunityBody =>
      'I pod sono per la gentilezza e il supporto. Accetti di non molestare, minacciare, umiliare, fare spam o pubblicare contenuti d\'odio o illegali, e di non condividere informazioni private altrui. Possiamo rimuovere contenuti o sospendere account che infrangono queste regole. Puoi bloccare e segnalare altri membri in qualsiasi momento.';

  @override
  String get tosContentHead => 'I contenuti che pubblichi';

  @override
  String get tosContentBody =>
      'Mantieni la proprietà di ciò che scrivi. Pubblicando in un pod ci concedi il permesso di memorizzarlo e mostrarlo ai membri di quel pod affinché la comunità funzioni. Non pubblicare nulla che non hai il diritto di condividere.';

  @override
  String get tosSubsHead => 'Abbonamenti';

  @override
  String get tosSubsBody =>
      'Alcune funzioni e contenuti di pratica extra sono disponibili con un abbonamento a pagamento. Quando la fatturazione è attiva, acquisti e rinnovi sono gestiti dallo store, e puoi gestirli o annullarli dal tuo account dello store. Prezzi e contenuti possono cambiare con preavviso.';

  @override
  String get tosDisclaimerHead => 'Esclusioni e responsabilità';

  @override
  String get tosDisclaimerBody =>
      'Rung è fornito «così com\'è», senza garanzie di alcun tipo. Nella misura massima consentita dalla legge, non siamo responsabili per perdite indirette o consequenziali derivanti dal tuo uso dell\'app.';

  @override
  String get tosEndingHead => 'Termine del tuo utilizzo';

  @override
  String get tosEndingBody =>
      'Puoi eliminare il tuo account in qualsiasi momento da Profilo → Elimina account. Possiamo sospendere o terminare l\'accesso se questi termini vengono infranti in modo grave o ripetuto.';

  @override
  String get tosChangesHead => 'Modifiche';

  @override
  String get tosChangesBody =>
      'Possiamo aggiornare questi termini; aggiorneremo la data qui sopra e, per modifiche significative, ti avviseremo nell\'app. Continuare a usare Rung significa che accetti i termini aggiornati.';

  @override
  String get breatheCta => 'Senti il timore? Prima respira';

  @override
  String get breatheIntro => 'Sessanta secondi. Segui solo il cerchio.';

  @override
  String get breatheIn => 'Inspira';

  @override
  String get breatheHold => 'Trattieni';

  @override
  String get breatheOut => 'Espira';

  @override
  String get breatheSkip => 'Salta';

  @override
  String get breatheDoneTitle => 'Ecco fatto.';

  @override
  String get breatheDoneSub =>
      'Ti senti un po\' più stabile? Fai il tuo gradino quando sei pronto.';

  @override
  String get breatheDoneBtn => 'Fatto';

  @override
  String get insightsDeeperTitle => 'Analisi più approfondite';

  @override
  String get insightsLockedBody =>
      'Guarda il tuo mese in un colpo d\'occhio — quanto la tua paura è stata più intensa della realtà e quante volte l\'hai sopravvalutata. Un vantaggio Premium.';

  @override
  String get insightsUnlockCta => 'Sblocca con Premium';

  @override
  String get insightsNoSteps =>
      'Nessun passo registrato questo mese. Affrontane un paio e il tuo riepilogo apparirà qui.';

  @override
  String get insightsFearsFacedMonth => 'paure affrontate questo mese';

  @override
  String insightsGapHotter(String points) {
    return 'La tua paura è stata in media $points punti più intensa della realtà.';
  }

  @override
  String get insightsGapTougher =>
      'La realtà è stata un po\' più dura di quanto avevi previsto questo mese — anche questi sono dati coraggiosi.';

  @override
  String get insightsGapSpotOn =>
      'Le tue previsioni sono state piuttosto azzeccate questo mese.';

  @override
  String insightsOverPredicted(int rate) {
    return 'Hai sopravvalutato la paura nel $rate% dei casi.';
  }

  @override
  String get insightsTrendSame => 'Come il mese scorso';

  @override
  String insightsTrendMore(int count) {
    return '$count in più rispetto al mese scorso';
  }

  @override
  String insightsTrendFewer(int count) {
    return '$count in meno rispetto al mese scorso';
  }

  @override
  String get rateTitle => 'Ti piace Rung?';

  @override
  String get ratePromptNone => 'Come ti sta andando con Rung?';

  @override
  String get ratePromptLow => 'Ci dispiace che non funzioni. Cosa manca?';

  @override
  String get ratePromptMid => 'Grazie — cosa lo renderebbe un 5?';

  @override
  String get ratePromptHigh => 'Significa molto. Cosa ti piace?';

  @override
  String get rateHintLove => 'Qualcosa che ami? (facoltativo)';

  @override
  String get rateHintMore => 'Raccontaci di più (facoltativo)';

  @override
  String get rateSend => 'Invia';

  @override
  String get rateThanksHigh => 'Grazie — aiuta davvero. 🌱';

  @override
  String get rateThanksLow =>
      'Grazie per la sincerità — la useremo per migliorare.';

  @override
  String get editProfileTitle => 'Modifica profilo';

  @override
  String get editDisplayName => 'Nome visualizzato';

  @override
  String get editDisplayNameHint => 'Come dovrebbero chiamarti nei pod?';

  @override
  String get editBio => 'Breve bio (facoltativo)';

  @override
  String get editBioHint =>
      'Una riga su di te — resta privata se blocchi il profilo.';

  @override
  String get errorOffline => 'Sei offline. Connettiti a internet e riprova.';

  @override
  String get errorGeneric => 'Qualcosa è andato storto. Riprova.';

  @override
  String get errorSaveFailed =>
      'Impossibile salvare — il dispositivo potrebbe avere poco spazio. Libera spazio e riprova.';
}
