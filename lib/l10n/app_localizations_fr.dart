// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get navHome => 'Accueil';

  @override
  String get navGroups => 'Groupes';

  @override
  String get navPremium => 'Premium';

  @override
  String get navProfile => 'Profil';

  @override
  String get greetingMorning => 'Bonjour';

  @override
  String get greetingAfternoon => 'Bon après-midi';

  @override
  String get greetingEvening => 'Bonsoir';

  @override
  String get todayStepIntro => 'Voici un petit pas pour aujourd\'hui.';

  @override
  String get commonContinue => 'Continuer';

  @override
  String get commonCancel => 'Annuler';

  @override
  String get commonSave => 'Enregistrer';

  @override
  String get commonDone => 'Terminé';

  @override
  String get commonNotNow => 'Pas maintenant';

  @override
  String get profileTitle => 'Profil';

  @override
  String get language => 'Langue';

  @override
  String get languageSystemDefault => 'Paramètre du système';

  @override
  String get yourTone => 'Votre ton';

  @override
  String get appearance => 'Apparence';

  @override
  String get themeSystem => 'Système';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get onbSkip => 'Passer';

  @override
  String get onbWelcomeTitle =>
      'Affronte les moments que tu redoutais — un petit pas à la fois.';

  @override
  String get onbWelcomeBody =>
      'Rung t’aide à gagner en confiance sociale grâce à une pratique douce et privée. Prédis, fais-le, réfléchis — et regarde tes pires craintes se défaire dans tes propres chiffres.';

  @override
  String get onbGetStarted => 'Commencer';

  @override
  String get onbSafetyTitle => 'De la pratique, pas une thérapie.';

  @override
  String get onbUnderstand => 'Je comprends';

  @override
  String get onbSafetyBody1 =>
      'Rung est un outil de confiance et de pratique — pas une thérapie, pas un traitement médical, et pas un diagnostic.';

  @override
  String get onbSafetyBody2 =>
      'Le but est de te sentir plus à l’aise dans des moments que tu redoutais — pas de devenir quelqu’un d’autre. Passer est toujours permis.';

  @override
  String get onbSafetyCrisis =>
      'Si l’anxiété affecte gravement ta vie, ou si tu as des pensées de te faire du mal, contacte un professionnel ou une ligne d’écoute locale.';

  @override
  String get onbFearTitle => 'Par où aimerais-tu commencer ?';

  @override
  String get onbFearBody =>
      'Juste pour suggérer un premier pas — tu peux gravir n’importe lequel à tout moment. Rien ici ne t’engage.';

  @override
  String get onbExploreOwn => 'Je préfère explorer par moi-même';

  @override
  String get onbToneTitle => 'Qu’est-ce qui te ressemble le plus ?';

  @override
  String get onbToneIntrovertTitle => 'Je suis plutôt introverti';

  @override
  String get onbToneIntrovertBody =>
      'Je veux me sentir à l’aise, pas devenir quelqu’un de différent.';

  @override
  String get onbToneSituationalTitle =>
      'Je deviens anxieux selon les situations';

  @override
  String get onbToneSituationalBody =>
      'Je suis parfois sociable, mais certains moments me déstabilisent.';

  @override
  String get onbToneFootnote =>
      'Tu peux changer cela à tout moment dans Profil.';

  @override
  String get onbHowTitle => 'Voici comment ça marche.';

  @override
  String get onbStartClimbing => 'Commencer à grimper';

  @override
  String get onbStep1 => 'Prédis à quel point ce sera difficile (0–10).';

  @override
  String get onbStep2 =>
      'Va le faire dans la vraie vie — l’appli peut être fermée.';

  @override
  String get onbStep3 => 'Reviens et note comment ça s’est vraiment passé.';

  @override
  String get onbGentleFirstStep => 'UN PREMIER PAS EN DOUCEUR';

  @override
  String get onbGoodPlaceToStart => 'UN BON POINT DE DÉPART';

  @override
  String get onbAllAreas =>
      'Les six domaines sont sur ton écran d’accueil — commence où tu veux.';

  @override
  String get predictAppBar => 'Avant de partir';

  @override
  String get predictSaved =>
      'Enregistré. Vas-y, fais-le — puis reviens noter comment ça s\'est passé.';

  @override
  String get predictQuestion =>
      'À quel point penses-tu que ce sera difficile ?';

  @override
  String get predictNoteLabel =>
      'Que penses-tu qu\'il va se passer ? (facultatif)';

  @override
  String get predictNoteHint => 'ex. : Ils vont me trouver bizarre';

  @override
  String get predictCompare =>
      'On comparera avec ce qui se passe vraiment. Cet écart, c\'est tout l\'intérêt.';

  @override
  String get predictDoIt => 'Je le fais';

  @override
  String get reflectAppBar => 'Comment ça s\'est passé ?';

  @override
  String get reflectDidYouDoIt => 'Tu l\'as fait ?';

  @override
  String get reflectHowAnxious =>
      'À quel point l\'idée t\'a-t-elle rendu anxieux ?';

  @override
  String get reflectHowBad => 'C\'était si difficile que ça, en vrai ?';

  @override
  String get reflectNoteLabel => 'Quelque chose à retenir ? (facultatif)';

  @override
  String get reflectOutcomeDone => 'Fait';

  @override
  String get reflectOutcomePartial => 'En partie';

  @override
  String get reflectOutcomeNotToday => 'Pas aujourd\'hui';

  @override
  String get resultQuietDelight => 'Une joie tranquille à chaque pas.';

  @override
  String get resultBackToLadder => 'Retour à l\'échelle';

  @override
  String resultGapHeadline(int predicted, int actual) {
    return 'Tu t\'attendais à $predicted. C\'était $actual.';
  }

  @override
  String resultGapSub(int predicted, int actual) {
    return 'Ton cœur se préparait à un lourd $predicted, mais le monde t\'a accueilli avec un $actual plus doux. À retenir.';
  }

  @override
  String get resultRightHeadline => 'Exactement comme prévu.';

  @override
  String get resultRightSub =>
      'Tu l\'avais deviné – et tu y es allé quand même. C\'est ça, la victoire.';

  @override
  String get resultTougherHeadline => 'Plus dur que prévu – et tu l\'as fait.';

  @override
  String get resultTougherSub =>
      'Certains moments nous demandent plus. Se présenter malgré tout, c\'est tout l\'intérêt.';

  @override
  String get resultPredicted => 'Prévu';

  @override
  String get resultActual => 'Réel';

  @override
  String resultLighter(int reduction) {
    return 'Ce moment était $reduction% plus léger que tu ne le craignais';
  }

  @override
  String get resultSkippedHeadline => 'Noté – sans pression.';

  @override
  String get resultSkippedSub =>
      'Pas aujourd\'hui est une réponse tout à fait valable. Cet échelon reste là quand tu seras prêt.';

  @override
  String get resultWinCopied => 'Victoire copiée – colle-la où tu veux.';

  @override
  String get resultCopyWin => 'Copier ma victoire';

  @override
  String resultShareText(String rung) {
    return 'Je viens de faire quelque chose que j\'évitais : $rung. Un petit échelon gravi. 🪜 #Rung';
  }

  @override
  String get tracksTitle => 'Tes parcours';

  @override
  String get tracksSubtitle => 'De petits pas vers une grande confiance.';

  @override
  String get menuInsights => 'Analyses';

  @override
  String get menuIsThisRight => 'Est-ce fait pour moi ?';

  @override
  String tracksRungsCount(int done, int total) {
    return '$done sur $total échelons';
  }

  @override
  String tracksClimbedCount(int done, int total) {
    return '$done sur $total gravis';
  }

  @override
  String get tracksContinueLabel => 'REPRENDS LÀ OÙ TU T\'ES ARRÊTÉ';

  @override
  String get tracksNextStepLabel => 'TON PROCHAIN PAS';

  @override
  String get tracksLoadError => 'Impossible de charger les parcours.';

  @override
  String get todayResume => 'Reprends là où tu t\'es arrêté';

  @override
  String get todayNext => 'Ton prochain pas';

  @override
  String get todayVariety => 'Quelque chose d\'un peu différent';

  @override
  String get todayFresh => 'Ton point de départ';

  @override
  String get todayResumeCta => 'Terminer la saisie';

  @override
  String get todayStartCta => 'Commencer';

  @override
  String todayMinutes(int min) {
    return '~$min min';
  }

  @override
  String get dashShareTooltip => 'Partager ma progression';

  @override
  String get dashWeeklyGoal => 'Objectif hebdomadaire';

  @override
  String dashStepsPerWeek(int count) {
    return '$count pas/semaine';
  }

  @override
  String dashGoalPerWeek(int count) {
    return '$count/semaine';
  }

  @override
  String dashWeeklyProgress(int done, int goal) {
    return '$done sur $goal pas réalisés cette semaine';
  }

  @override
  String get dashYourGrowth => 'Ta progression';

  @override
  String get dashTodayError =>
      'Impossible de charger l\'étape du jour. Tire pour réessayer.';

  @override
  String get dashTodayAllClear =>
      'Tu as terminé tout ce qui est disponible — ajoute un échelon personnalisé ou refais-en un pour garder ta série.';

  @override
  String get dashTakeABreak => 'Fais une pause';

  @override
  String get dashTakeABreakSub =>
      'Quelques jeux tranquilles, contre le téléphone ou un ami.';

  @override
  String get ladderTitleFallback => 'Échelle';

  @override
  String get ladderLoadError => 'Impossible de charger l\'échelle.';

  @override
  String get ladderAddOwn => 'Ajoute ton propre échelon';

  @override
  String ladderOfClimbed(int total) {
    return 'sur $total gravis';
  }

  @override
  String get detailLoadError => 'Impossible de charger.';

  @override
  String get detailNotExist => 'Cet échelon n\'existe plus.';

  @override
  String get detailWhatToDo => 'Quoi faire';

  @override
  String get detailWhyHelps => 'Pourquoi c\'est utile';

  @override
  String get detailPastAttempts => 'Tes tentatives passées';

  @override
  String get detailDoThis => 'Je le fais';

  @override
  String get detailReattempt =>
      'Recommencer est encouragé : cela enrichit tes données.';

  @override
  String detailHistoryStat(int predicted, int actual) {
    return 'prévu $predicted · réel $actual';
  }

  @override
  String customLimitPremium(int cap) {
    return 'Tu as atteint la limite de $cap échelons personnalisés ce mois-ci — elle se réinitialise le mois prochain.';
  }

  @override
  String get customLimitFree =>
      'Le forfait gratuit inclut 5 échelons personnalisés — passe à la version supérieure pour en avoir plus chaque mois.';

  @override
  String get customDefaultWhat => 'Un défi que tu te fixes.';

  @override
  String get customDefaultWhy =>
      'Tu as nommé celui-ci – c\'est ce qui le rend important.';

  @override
  String get customSubtitle =>
      'Ta situation est unique – cet échelon est juste pour toi.';

  @override
  String get customWhatLabel => 'Que vas-tu faire ?';

  @override
  String get customWhatHint => 'ex. : Demander un retour à mon responsable';

  @override
  String get customNoteLabel => 'Une note pour toi (facultatif)';

  @override
  String customDifficulty(int value) {
    return 'À quel point cela semble difficile ? $value/10';
  }

  @override
  String get customAddToLadder => 'Ajouter à l\'échelle';

  @override
  String get paywallSwitchToFree => 'Passer à Gratuit';

  @override
  String get paywallHeroTitle => 'Tu n\'as pas à affronter ça seul.';

  @override
  String get paywallHeroBody =>
      'La pratique quotidienne est toujours gratuite. Premium ajoute un coach privé à tes côtés — et une communauté plus grande — pour quand tu es prêt à aller plus loin.';

  @override
  String get paywallWhatsIncluded => 'Ce qui est inclus';

  @override
  String get paywallPlusHeader => 'En plus, chaque abonné reçoit';

  @override
  String get paywallBenefitCoach =>
      'Un coach privé, à tout moment — répète quelque chose à venir ou raconte comment ça s\'est passé';

  @override
  String get paywallBenefitPods =>
      'Tu n\'es pas seul — rejoins plus de groupes de soutien (3 en mensuel, illimités en annuel)';

  @override
  String get paywallBenefitCustom =>
      'Crée tes propres échelles sans limite — aucun plafond d\'échelons personnalisés';

  @override
  String get paywallBenefitDepth =>
      'Va plus loin quand tu es prêt — jusqu\'à 40 étapes par parcours (le gratuit est un parcours complet de 10 étapes)';

  @override
  String get paywallPlusStreak =>
      'Protection de série — un jour manqué ne brise pas ta série';

  @override
  String get paywallPlusInsights =>
      'Analyses approfondies — ton mois en un coup d\'œil';

  @override
  String get paywallPlusShare => 'Styles de partage personnalisés';

  @override
  String get paywallPlusPrivacy => 'Toujours privé, toujours sans publicité';

  @override
  String get paywallYearly => 'Annuel';

  @override
  String get paywallPerYear => 'par an · meilleure offre';

  @override
  String get paywallSave => 'Économise 33%';

  @override
  String get paywallMonthly => 'Mensuel';

  @override
  String get paywallPerMonth => 'par mois';

  @override
  String get paywallSwitchYearly => 'Passer à l\'annuel';

  @override
  String get paywallSwitchMonthly => 'Passer au mensuel';

  @override
  String paywallStartYearly(String price) {
    return 'Commencer l\'annuel — $price';
  }

  @override
  String paywallStartMonthly(String price) {
    return 'Commencer le mensuel — $price';
  }

  @override
  String get paywallRestore => 'Restaurer les achats';

  @override
  String paywallCurrentPlan(String plan) {
    return 'Forfait actuel : $plan. Annulable à tout moment.';
  }

  @override
  String get paywallCancelAnytime =>
      'Annulable à tout moment. Le cœur reste gratuit pour toujours.';

  @override
  String get paywallSimulated =>
      'Premium actif (simulé — ajoute des clés RevenueCat pour de vrais achats).';

  @override
  String get paywallPlanUnavailable =>
      'Ce forfait n\'est pas disponible pour le moment. Réessaie bientôt.';

  @override
  String get paywallThankYou => 'Premium actif — merci. 🌱';

  @override
  String get paywallPurchaseFailed =>
      'L\'achat n\'a pas abouti. Tu n\'as pas été débité.';

  @override
  String get paywallRestored => 'Achats restaurés.';

  @override
  String get paywallNoRestore => 'Aucun achat précédent trouvé sur ce compte.';

  @override
  String get paywallRestoreFailed =>
      'Impossible de restaurer pour le moment. Réessaie bientôt.';

  @override
  String get profileAddName => 'Ajoute ton nom';

  @override
  String get profileLockTitle => 'Verrouiller mon profil';

  @override
  String get profileLockedSub =>
      'Masqué – les membres du groupe ne peuvent pas voir tes détails.';

  @override
  String get profileUnlockedSub =>
      'Les membres du groupe peuvent toucher ton avatar pour voir tes détails.';

  @override
  String get profilePlanTitle => 'Ton forfait';

  @override
  String get profilePremium => 'Premium';

  @override
  String get profileUpgrade => 'Passer à Premium';

  @override
  String get profileToneDesc =>
      'Rung parle avec douceur par défaut. Si ton anxiété est plutôt situationnelle, un ton un peu plus direct te conviendra peut-être mieux.';

  @override
  String get profileToneIntrovert => 'Introverti';

  @override
  String get profileToneSituational => 'Situationnel';

  @override
  String get profileSafetySub =>
      'Comment Rung s\'intègre – et quand chercher plus d\'aide';

  @override
  String get profileBlockedTitle => 'Membres bloqués';

  @override
  String get profileBlockedSub =>
      'Vois et débloque les personnes que tu as bloquées';

  @override
  String get profileRestoreTitle => 'Restaurer ma progression';

  @override
  String get profileRestoreSub =>
      'Récupère ta série et tes défis depuis le cloud';

  @override
  String get profileRestoring => 'Restauration…';

  @override
  String get profileRestoreOk => 'Progression restaurée depuis le cloud.';

  @override
  String profileRestoreFail(String error) {
    return 'Échec de la restauration : $error';
  }

  @override
  String get profileLogout => 'Se déconnecter';

  @override
  String get profileSignedIn => 'Connecté';

  @override
  String get profileLogoutConfirmTitle => 'Se déconnecter ?';

  @override
  String get profileLogoutConfirmBody =>
      'Ta progression est enregistrée dans le cloud et revient quand tu te reconnectes.';

  @override
  String get profileLoggingOut => 'Déconnexion…';

  @override
  String get profileRateTitle => 'Noter Rung';

  @override
  String get profileRateSub =>
      'Dis-nous comment ça se passe — ça aide vraiment';

  @override
  String get profilePrivacyTitle => 'Politique de confidentialité';

  @override
  String get profilePrivacySub =>
      'Ce que nous stockons – et ce qui reste sur ton appareil';

  @override
  String get profileTermsTitle => 'Conditions d\'utilisation';

  @override
  String get profileTermsSub => 'L\'accord pour utiliser Rung';

  @override
  String get profileDeleteTitle => 'Supprimer le compte';

  @override
  String get profileDeleteSub =>
      'Efface ton compte et tes données de façon permanente';

  @override
  String get profileFooter =>
      'Rung · entraînement, pas thérapie. Tes données t\'appartiennent.';

  @override
  String get profileDeleteConfirmTitle => 'Supprimer le compte ?';

  @override
  String get profileDeleteConfirmBody =>
      'Cela supprime définitivement ton compte, tes messages de groupe et ta progression enregistrée. C\'est irréversible.';

  @override
  String get profileDelete => 'Supprimer';

  @override
  String get profileDeleting => 'Suppression de ton compte…';

  @override
  String get profileDeleteFail =>
      'Impossible de supprimer ton compte. Réessaie.';

  @override
  String get profileBioPlaceholder => 'Un grimpeur tranquille.';

  @override
  String get profileHaptics => 'Retour haptique';

  @override
  String get profileHapticsSub =>
      'Légère vibration aux touchers et aux réussites';

  @override
  String get profileNotifications => 'Notifications';

  @override
  String get profileNotificationsSub => 'Alertes de Rung sur cet appareil';

  @override
  String get profilePodAlerts => 'Alertes de messages de groupe';

  @override
  String get profilePodAlertsSub =>
      'Préviens-moi quand quelqu\'un publie dans mes groupes';

  @override
  String get profileEnableNotifs =>
      'Active les notifications dans les Réglages pour recevoir des rappels.';

  @override
  String get profileReminderHelp => 'Quand devons-nous t\'encourager ?';

  @override
  String get profileReminderTitle => 'Rappel quotidien tout en douceur';

  @override
  String profileReminderOn(String time) {
    return 'Chaque jour à $time · touche l\'interrupteur pour désactiver';
  }

  @override
  String get profileReminderOff =>
      'Un petit encouragement calme et sans culpabilité pour faire un petit pas';

  @override
  String get profileAvatarTitle => 'Choisis ton avatar';

  @override
  String get profileAvatarSub =>
      'Toi seul peux le changer — tes coéquipiers le voient aussi.';

  @override
  String get commonClose => 'Fermer';

  @override
  String get checkInMoodCalm => 'Calme';

  @override
  String get checkInMoodOkay => 'Ça va';

  @override
  String get checkInMoodAnxious => 'Anxieux';

  @override
  String get checkInMoodLow => 'Au plus bas';

  @override
  String get checkInMoodTense => 'Tendu';

  @override
  String get checkInTitle => 'Comment arrives-tu aujourd\'hui ?';

  @override
  String get checkInDismiss => 'Ignorer';

  @override
  String get checkInCalmCta => 'Essayer un moment de calme';

  @override
  String get checkInStepCta => 'Voir l\'étape du jour';

  @override
  String get supportTitle => 'Ça a l\'air lourd à porter.';

  @override
  String get supportBody =>
      'Rung est un outil d\'entraînement, pas un service de crise. Si tu traverses quelque chose de difficile, adresse-toi à quelqu\'un qui peut t\'aider tout de suite — une personne de confiance ou une ligne d\'écoute locale. Tu mérites un vrai soutien.';

  @override
  String get supportResources => 'Voir les ressources d\'aide';

  @override
  String get progressChallenges => 'Défis';

  @override
  String get progressCurrentStreak => 'Série actuelle';

  @override
  String get progressBestStreak => 'Meilleure série';

  @override
  String get progressThisWeek => 'Cette semaine';

  @override
  String get progressCategoryBreakdown => 'Répartition par catégorie';

  @override
  String get insightsHistory => 'Historique';

  @override
  String checkInAckTitle(String mood) {
    return 'Enregistré — tu te sens $mood';
  }

  @override
  String get checkInAckGentle =>
      'Merci pour ta franchise. Restons doux aujourd\'hui — une petite chose bienveillante suffit.';

  @override
  String get checkInAckStep =>
      'J\'adore. Quand tu es prêt, un petit pas entretient l\'élan.';

  @override
  String get sharePremiumPerk =>
      '✨ D\'autres styles de carte sont un avantage Premium.';

  @override
  String get shareSeePremium => 'Voir Premium';

  @override
  String get shareText =>
      'De petits pas courageux, un échelon à la fois. 🌱 #Rung';

  @override
  String get shareError => 'Impossible d\'ouvrir le partage. Réessaie.';

  @override
  String get shareTitle => 'Partage ta progression';

  @override
  String get shareSubtitle => 'Juste tes chiffres — rien de privé.';

  @override
  String get shareCta => 'Partager';

  @override
  String get shareCardHeadline => 'Mes pas courageux';

  @override
  String get shareCardFearsFaced => 'peurs affrontées';

  @override
  String get shareCardCurrentStreak => 'Série actuelle';

  @override
  String get shareCardBestStreak => 'Meilleure série';

  @override
  String get shareCardTagline =>
      'Affronter ses peurs sociales, un petit échelon à la fois.';

  @override
  String get helpNow => 'Aide maintenant';

  @override
  String get helpCalmMoment => 'Un moment de calme';

  @override
  String get helpTabBreathe => 'Respire';

  @override
  String get helpTabGround => 'Ancre-toi';

  @override
  String get helpTabSay => 'Dis ceci';

  @override
  String get helpBreatheIn => 'Inspire…';

  @override
  String get helpBreatheOut => 'Expire…';

  @override
  String get helpBreatheHint => 'Suis le cercle. Rien ne presse.';

  @override
  String get helpGround5 => 'choses que tu peux voir';

  @override
  String get helpGround4 => 'choses que tu peux toucher';

  @override
  String get helpGround3 => 'choses que tu peux entendre';

  @override
  String get helpGround2 => 'choses que tu peux sentir';

  @override
  String get helpGround1 => 'chose que tu peux goûter';

  @override
  String get helpGroundTitle => 'Nomme-les, doucement pour toi…';

  @override
  String get helpGroundHint =>
      'Cela te ramène à l\'instant présent — là où tu es en sécurité.';

  @override
  String get helpOpener1 => 'Comment connais-tu les gens ici ?';

  @override
  String get helpOpener2 => 'J\'adore cet endroit — tu es déjà venu ?';

  @override
  String get helpOpener3 =>
      'Je suis nul avec les prénoms — tu me rappelles le tien ?';

  @override
  String get helpOpener4 => 'Qu\'est-ce que tu as fait cette semaine ?';

  @override
  String get helpExit1 =>
      'Je vais me chercher à boire — c\'était sympa de parler avec toi.';

  @override
  String get helpExit2 =>
      'Je dois dire bonjour à quelqu\'un, excuse-moi une seconde.';

  @override
  String get helpExit3 => 'Je te laisse circuler — à plus tard.';

  @override
  String get helpOpenersTitle => 'Phrases pour engager';

  @override
  String get helpExitsTitle => 'Sorties en douceur';

  @override
  String get authEnterEmail => 'Saisis ton e-mail';

  @override
  String get authBadEmail => 'Cet e-mail ne semble pas valide';

  @override
  String get authEnterPassword => 'Saisis un mot de passe';

  @override
  String get authMin6 => 'Au moins 6 caractères';

  @override
  String get authPwMismatch => 'Les mots de passe ne correspondent pas';

  @override
  String get authConfirmEmail =>
      'Vérifie ton e-mail pour confirmer, puis connecte-toi. (Ou désactive la confirmation par e-mail dans les réglages Auth de Supabase pour des tests rapides.)';

  @override
  String get authGenericError => 'Une erreur s\'est produite. Réessaie.';

  @override
  String get authCreateTitle => 'Crée ton compte';

  @override
  String get authWelcomeBack => 'Content de te revoir';

  @override
  String get authSignUpSub =>
      'Rejoins les groupes et garde ta progression en sécurité sur tous tes appareils.';

  @override
  String get authSignInSub =>
      'Connecte-toi à tes groupes et à ta progression synchronisée.';

  @override
  String get authDisplayName => 'Nom affiché (facultatif)';

  @override
  String get authEmail => 'E-mail';

  @override
  String get authPassword => 'Mot de passe';

  @override
  String get authShowPassword => 'Afficher le mot de passe';

  @override
  String get authHidePassword => 'Masquer le mot de passe';

  @override
  String get authConfirmPassword => 'Confirmer le mot de passe';

  @override
  String get authCreateCta => 'Créer un compte';

  @override
  String get authSignInCta => 'Se connecter';

  @override
  String get authHaveAccount => 'J\'ai déjà un compte';

  @override
  String get authNewAccount => 'Je suis nouveau — créer un compte';

  @override
  String get authLegalPrefixSignUp => 'En créant un compte, tu acceptes nos ';

  @override
  String get authLegalPrefixSignIn => 'En continuant, tu acceptes nos ';

  @override
  String get authTerms => 'Conditions';

  @override
  String get authAnd => ' et ';

  @override
  String get gamesIntro =>
      'Des jeux paisibles pour la concentration et l\'esprit tranquille — le genre d\'entraînement cérébral qui apaise. Joue contre le téléphone ou passe-le à un ami.';

  @override
  String gamesBestMs(int ms) {
    return 'Meilleur : $ms ms';
  }

  @override
  String gamesBestLevel(int level) {
    return 'Meilleur niveau : $level';
  }

  @override
  String gamesBest(String score) {
    return 'Meilleur : $score';
  }

  @override
  String gamesBestMoves(int moves) {
    return 'Meilleur : $moves coups';
  }

  @override
  String gamesWinsVsPhone(int count) {
    return '$count victoires contre le téléphone';
  }

  @override
  String get gameTitleReaction => 'Vitesse de réaction';

  @override
  String get gameTitleSequence => 'Mémoire de séquence';

  @override
  String get gameTitleQuickMath => 'Calcul rapide';

  @override
  String get gameTitleMemory => 'Jeu de mémoire';

  @override
  String get gameSubReaction => 'concentration · touche quand ça devient vert';

  @override
  String get gameSubSequence => 'mémoire · observe et répète';

  @override
  String get gameSub2048 => 'stratégie · glisse pour fusionner';

  @override
  String get gameSubQuickMath => 'rapidité mentale · sprint de 30 secondes';

  @override
  String get gameSubTicTacToe => 'contre le téléphone · ou 2 joueurs';

  @override
  String get gameSubConnect4 => 'contre le téléphone · ou 2 joueurs';

  @override
  String get gameSubMemory => 'en solo · trouve les paires';

  @override
  String get gameHelpTooltip => 'Comment jouer';

  @override
  String gameHelpTitle(String game) {
    return 'Comment jouer · $game';
  }

  @override
  String get gameGotIt => 'Compris';

  @override
  String get tierFree => 'Gratuit';

  @override
  String get tierMonthly => 'Premium · Mensuel';

  @override
  String get tierYearly => 'Premium · Annuel';

  @override
  String get podsUnlimited => 'un nombre illimité de groupes';

  @override
  String podsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count groupes',
      one: '1 groupe',
    );
    return '$_temp0';
  }

  @override
  String get groupsSignedOutTitle => 'Rejoins un petit groupe bienveillant';

  @override
  String get groupsSignedOutBody =>
      'Les groupes nécessitent un compte rapide pour rester sûrs et à toi. Ta pratique reste privée et sans compte.';

  @override
  String get groupsSignInCta => 'Connecte-toi pour continuer';

  @override
  String get groupsLoadError =>
      'Impossible de charger les groupes. Tire pour réessayer.';

  @override
  String groupsJoined(String pod) {
    return 'Tu as rejoint $pod. Dis bonjour quand tu es prêt.';
  }

  @override
  String get groupsJoinedNew =>
      'Tu as rejoint un nouveau groupe. Dis bonjour quand tu es prêt.';

  @override
  String get groupsNoPodFound =>
      'Aucun groupe trouvé pour le moment. Réessaie.';

  @override
  String groupsLeaveTitle(String pod) {
    return 'Quitter $pod ?';
  }

  @override
  String get groupsLeave => 'Quitter';

  @override
  String groupsLeft(String pod) {
    return 'Tu as quitté $pod.';
  }

  @override
  String get groupsLeaveError => 'Impossible de quitter le groupe. Réessaie.';

  @override
  String get groupsHeader => 'Petits groupes, gens bienveillants';

  @override
  String get groupsYourPods => 'TES GROUPES';

  @override
  String get groupsDiscoverPods => 'DÉCOUVRIR DES GROUPES';

  @override
  String get groupsJoinAnother => 'Rejoindre un autre groupe';

  @override
  String get groupsNoOthers => 'Aucun autre groupe à rejoindre pour le moment.';

  @override
  String groupsJoinedShort(String pod) {
    return 'Tu as rejoint $pod.';
  }

  @override
  String get groupsJoin => 'Rejoindre';

  @override
  String get groupsPodOptions => 'Options du groupe';

  @override
  String get groupsLeavePod => 'Quitter le groupe';

  @override
  String groupsMembers(int count, int capacity) {
    return '$count/$capacity membres';
  }

  @override
  String groupsTierPods(String tier, String pods) {
    return 'Avec $tier, tu peux être dans $pods.';
  }

  @override
  String groupsCapacityTierPods(int capacity, String tier, String pods) {
    return 'Jusqu\'à $capacity par groupe. Avec $tier, tu peux être dans $pods.';
  }

  @override
  String groupsInYourPods(String pods) {
    return 'Tu es dans tes $pods';
  }

  @override
  String get groupsUpgradeBody =>
      'Passe à Premium pour en rejoindre plus — le mensuel débloque 3 groupes, l\'annuel autant que tu veux.';

  @override
  String get groupsSafetyLive =>
      'Sois bienveillant. Tu peux signaler ou bloquer quelqu\'un depuis son profil. Les profils verrouillés restent privés.';

  @override
  String get groupsSafetyPreview =>
      'Aperçu. Les groupes deviennent des discussions en direct et modérées une fois la connexion configurée.';

  @override
  String get groupsLeaveBody =>
      'Tu ne verras plus les messages de ce groupe. Tu pourras le rejoindre plus tard.';

  @override
  String get podRulesTitle => 'Règles du groupe';

  @override
  String get podRulesIntro =>
      'Les groupes ne fonctionnent que si chacun se sent en sécurité. En rejoignant, tu acceptes :';

  @override
  String get podRule1 =>
      'Sois bienveillant. Ici, chacun s\'exerce à quelque chose de difficile.';

  @override
  String get podRule2 =>
      'Pas de harcèlement, de haine ni de contenu nuisible. Jamais.';

  @override
  String get podRule3 =>
      'Signale ou bloque toute personne qui te met mal à l\'aise.';

  @override
  String get podRule4 =>
      'Respecte la vie privée — ce qui se partage ici reste ici.';

  @override
  String get podRule5 =>
      'Les groupes sont un soutien entre pairs, pas un service de crise. En cas d\'urgence, contacte un professionnel ou une ligne d\'écoute locale.';

  @override
  String get podRulesAgree => 'J\'accepte — j\'entre';

  @override
  String chatIntrosBeKind(int count, int capacity) {
    return '$count/$capacity introvertis · sois bienveillant';
  }

  @override
  String get chatHint => 'Dis quelque chose de gentil…';

  @override
  String get chatPreviewBanner =>
      'Aperçu · pour l\'instant, les messages restent sur ton appareil. Les vrais groupes modérés arrivent avec les comptes.';

  @override
  String get chatYou => 'Toi';

  @override
  String get reportHarassment => 'Harcèlement ou intimidation';

  @override
  String get reportHate => 'Haine ou langage nuisible';

  @override
  String get reportSpam => 'Spam ou arnaque';

  @override
  String get reportUnsafe => 'Me met mal à l\'aise';

  @override
  String get reportOther => 'Autre chose';

  @override
  String get memberPrivateTitle => 'Profil privé';

  @override
  String get memberPrivateBody =>
      'Ce membre garde son profil privé. Tu peux quand même discuter avec lui — et le signaler ou le bloquer si besoin.';

  @override
  String memberStreak(int days) {
    return 'série de $days jours';
  }

  @override
  String memberChallenges(int count) {
    return '$count défis';
  }

  @override
  String memberClimbing(String track) {
    return 'En cours : $track';
  }

  @override
  String get memberReport => 'Signaler';

  @override
  String get memberBlock => 'Bloquer';

  @override
  String get memberReportThanks => 'Merci — nous allons vérifier.';

  @override
  String get memberBlockToo => 'Bloquer aussi';

  @override
  String get memberBlocked => 'Bloqué. Tu ne verras plus ses messages.';

  @override
  String get memberBlockError => 'Impossible de bloquer. Réessaie.';

  @override
  String get memberReportError =>
      'Impossible d\'envoyer le signalement. Réessaie.';

  @override
  String get memberBlockConfirmTitle => 'Bloquer ce membre ?';

  @override
  String get memberBlockConfirmBody =>
      'Vous ne verrez plus les messages l\'un de l\'autre. Tu pourras annuler plus tard.';

  @override
  String get memberSoonReporting =>
      'Le signalement arrive dans les groupes modérés (connecte-toi pour l\'utiliser).';

  @override
  String get memberSoonBlocking =>
      'Le blocage arrive dans les groupes modérés (connecte-toi pour l\'utiliser).';

  @override
  String get memberWhatsWrong => 'Qu\'est-ce qui ne va pas ?';

  @override
  String get memberFallback => 'Membre';

  @override
  String get blockedUnblockError => 'Impossible de débloquer. Réessaie.';

  @override
  String blockedUnblocked(String name) {
    return '$name débloqué. Tu reverras ses messages.';
  }

  @override
  String get blockedIntro =>
      'Bloquer masque les messages d\'un membre pour toi — et les tiens pour lui, dans les deux sens. Débloque quelqu\'un ci-dessous pour annuler.';

  @override
  String get blockedLabel => 'Bloqué';

  @override
  String get blockedUnblock => 'Débloquer';

  @override
  String get blockedEmptyTitle => 'Personne de bloqué';

  @override
  String get blockedEmptyBody =>
      'Tu n\'as bloqué personne. Bloquer masque les messages d\'un membre pour toi, dans les deux sens — et tu peux toujours annuler ici.';

  @override
  String get chatCheckInPosted => 'Bien joué. Check-in publié dans le groupe.';

  @override
  String get chatCheckInError =>
      'Impossible de faire le check-in maintenant. Réessaie.';

  @override
  String get chatDeleteMsgTitle => 'Supprimer le message ?';

  @override
  String get chatDeleteMsgBody =>
      'Il est retiré pour tout le monde dans le groupe.';

  @override
  String get chatReply => 'Répondre';

  @override
  String get chatEdit => 'Modifier';

  @override
  String get chatDailyPrompt => 'Suggestion quotidienne du groupe';

  @override
  String get chatCheckedInToday => 'Check-in fait aujourd\'hui';

  @override
  String get chatDidMyStep => 'J\'ai fait mon pas';

  @override
  String chatCheckedInCount(int count) {
    return '$count ont fait leur check-in';
  }

  @override
  String get chatNoMessages =>
      'Pas encore de messages. Un simple « salut » est un premier échelon courageux.';

  @override
  String get chatEditingMessage => 'Modification de ton message';

  @override
  String chatReplyingTo(String name) {
    return 'Réponse à $name';
  }

  @override
  String get chatYourself => 'toi-même';

  @override
  String get chatMsgDeleted => 'Ce message a été supprimé';

  @override
  String get chatPrivateMember => 'Membre privé';

  @override
  String chatBeKind(int count, int capacity) {
    return '$count/$capacity · sois bienveillant';
  }

  @override
  String get chatDeletedMessageShort => 'message supprimé';

  @override
  String get gameYouWin => 'Tu gagnes ! 🎉';

  @override
  String get gamePhoneWins => 'Le téléphone gagne';

  @override
  String get gamePhoneThinking => 'Le téléphone réfléchit…';

  @override
  String get gamePlayPhone => 'Jouer contre le téléphone';

  @override
  String get game2Players => '2 joueurs';

  @override
  String get gameNewGame => 'Nouvelle partie';

  @override
  String get gameYou => 'Toi';

  @override
  String get gamePhone => 'Téléphone';

  @override
  String get gameDraws => 'Nuls';

  @override
  String get tttP1Wins => 'Le Joueur 1 (X) gagne ! 🎉';

  @override
  String get tttP2Wins => 'Le Joueur 2 (O) gagne ! 🎉';

  @override
  String get tttYourTurn => 'À ton tour';

  @override
  String get tttP1Turn => 'Joueur 1 · X';

  @override
  String get tttP2Turn => 'Joueur 2 · O';

  @override
  String get tttP1Label => 'J1 (X)';

  @override
  String get tttP2Label => 'J2 (O)';

  @override
  String get tttRule1 =>
      'À tour de rôle, placez votre marque sur la grille 3×3.';

  @override
  String get tttRule2 =>
      'Aligne trois de tes marques — horizontalement, verticalement ou en diagonale — pour gagner.';

  @override
  String get tttRule3 =>
      '« Jouer contre le téléphone », c\'est contre une IA simple. « 2 joueurs » passe le téléphone à chaque tour.';

  @override
  String get c4P1Wins => 'Le Joueur 1 gagne ! 🎉';

  @override
  String get c4P2Wins => 'Le Joueur 2 gagne ! 🎉';

  @override
  String get c4Turn => 'À ton tour — touche une colonne';

  @override
  String get c4P1Turn => 'Joueur 1 · rouge';

  @override
  String get c4P2Turn => 'Joueur 2 · jaune';

  @override
  String get c4P1Label => 'J1';

  @override
  String get c4P2Label => 'J2';

  @override
  String get c4Rule1 =>
      'Touche une colonne pour lâcher ton jeton — il tombe dans l\'emplacement libre le plus bas.';

  @override
  String get c4Rule2 =>
      'Aligne quatre de ta couleur — horizontalement, verticalement ou en diagonale — pour gagner.';

  @override
  String get c4Rule3 =>
      '« Jouer contre le téléphone », c\'est contre une IA simple. « 2 joueurs » passe le téléphone.';

  @override
  String get gameDraw => 'Match nul 🤝';

  @override
  String get gamePlayAgain => 'Rejouer';

  @override
  String get gameStart => 'Commencer';

  @override
  String get g2048Rule1 =>
      'Balaie vers le haut, le bas, la gauche ou la droite pour faire glisser toutes les tuiles.';

  @override
  String get g2048Rule2 =>
      'Deux tuiles portant le même nombre fusionnent en une qui double.';

  @override
  String get g2048Rule3 =>
      'Continue de fusionner pour créer une tuile 2048. Le plateau se remplit — anticipe !';

  @override
  String get g2048Score => 'Score';

  @override
  String get g2048Best => 'Meilleur';

  @override
  String get g2048GameOver => 'Partie terminée';

  @override
  String get g2048Won => 'Tu as fait 2048 ! 🎉';

  @override
  String get g2048SwipeToMerge => 'Glisse pour fusionner';

  @override
  String get qmRule1 => 'Tu as 30 secondes — résous-en le plus possible.';

  @override
  String get qmRule2 => 'Touche la bonne réponse parmi les quatre choix.';

  @override
  String get qmRule3 =>
      'Une mauvaise réponse coûte 2 secondes, alors lis bien.';

  @override
  String qmTimeScored(Object score) {
    return 'Temps écoulé ! Tu as marqué $score';
  }

  @override
  String qmBestSub(Object best) {
    return 'Meilleur $best · 30 secondes, réponds au maximum.';
  }

  @override
  String get qmStartSub =>
      '30 secondes. Une mauvaise réponse coûte 2 secondes.';

  @override
  String get qmCorrect => 'bonnes';

  @override
  String get mmRule1 =>
      'Touche une carte pour la retourner, puis une deuxième.';

  @override
  String get mmRule2 =>
      'Si les deux emojis correspondent, ils restent face visible ; sinon, ils se retournent.';

  @override
  String get mmRule3 =>
      'Trouve toutes les paires — en le moins de coups possible.';

  @override
  String mmAllMatched(Object moves) {
    return 'Toutes trouvées en $moves coups ! 🎉';
  }

  @override
  String mmFindPairs(Object moves) {
    return 'Trouve les paires · $moves coups';
  }

  @override
  String mmBest(Object best) {
    return 'Meilleur : $best coups';
  }

  @override
  String get mmShuffle => 'Mélanger';

  @override
  String get rxTapStart => 'Touche pour commencer';

  @override
  String get rxWaitGreen => 'Attends le vert, puis touche vite';

  @override
  String get rxWait => 'Attends…';

  @override
  String get rxTapMoment => 'Touche dès que ça devient vert';

  @override
  String rxBestRetry(Object ms) {
    return 'Meilleur $ms ms · touche pour réessayer';
  }

  @override
  String get rxTapRetry => 'Touche pour réessayer';

  @override
  String get rxTooSoon => 'Trop tôt !';

  @override
  String get rxWaitRetry => 'Attends le vert · touche pour réessayer';

  @override
  String get rxTap => 'TOUCHE !';

  @override
  String get rxRule1 =>
      'Touche l\'écran pour commencer, puis attends — il deviendra ambre.';

  @override
  String get rxRule2 =>
      'Dès qu\'il devient vert, touche le plus vite possible.';

  @override
  String get rxRule3 =>
      'Toucher trop tôt réinitialise. Un temps plus court (ms) est meilleur.';

  @override
  String get smWatchRepeat => 'Observe le motif, puis répète-le.';

  @override
  String get smWatch => 'Regarde…';

  @override
  String smYourTurn(Object current, Object total) {
    return 'À ton tour · $current sur $total';
  }

  @override
  String smReachedBest(Object best, Object reached) {
    return 'Tu as atteint $reached · meilleur $best';
  }

  @override
  String smReached(Object reached) {
    return 'Tu as atteint $reached';
  }

  @override
  String get smRule1 => 'Regarde les tuiles s\'allumer une par une.';

  @override
  String get smRule2 =>
      'Répète exactement le même ordre en touchant les tuiles.';

  @override
  String get smRule3 =>
      'Chaque manche ajoute une étape — vois jusqu\'où tu peux aller.';

  @override
  String smRound(Object round) {
    return 'Manche $round';
  }

  @override
  String get safetyScreenTitle => 'Est-ce fait pour moi ?';

  @override
  String get safetyPracticeTitle => 'Rung est une pratique, pas une thérapie.';

  @override
  String get safetyIntro =>
      'Rung est un outil de confiance et de pratique. Il t’aide à affronter des situations sociales du quotidien progressivement, à ton propre rythme. Ce n’est pas une thérapie, ni un traitement médical, ni un diagnostic.';

  @override
  String get safetyPoint1 =>
      'Le but est une appréhension gérable — te sentir plus à l’aise dans les moments que tu évitais. Pas devenir quelqu’un d’autre.';

  @override
  String get safetyPoint2 =>
      'Passer est toujours permis et ne te pénalise jamais. Il n’y a aucune mécanique de honte ici.';

  @override
  String get safetyPoint3 =>
      'Tes données t’appartiennent. Tout fonctionne hors ligne, sans compte requis.';

  @override
  String get safetyMoreTitle => 'Si c’est plus que du trac';

  @override
  String get safetyMoreBody =>
      'Si l’anxiété affecte gravement ta vie quotidienne, ou si tu as des pensées de te faire du mal, contacte un professionnel qualifié ou une ligne d’écoute locale. C’est un pas fort et sain — et Rung ne le remplace pas.';

  @override
  String get legalLastUpdated => 'Dernière mise à jour : juin 2026';

  @override
  String legalQuestions(String email) {
    return 'Des questions ? Contacte-nous à $email.';
  }

  @override
  String get privacyTitle => 'Politique de confidentialité';

  @override
  String get privacyIntro =>
      'Rung est un outil de pratique privé pour développer la confiance sociale. Nous collectons le moins possible, et les choses les plus personnelles que tu écris ne quittent jamais ton téléphone. Cette politique explique ce que nous stockons et pourquoi.';

  @override
  String get ppWhatStaysHead => 'Ce qui reste uniquement sur ton appareil';

  @override
  String get ppWhatStaysBody =>
      'Tes notes de réflexion et de prédiction — les choses privées que tu écris sur ce qu’un moment t’a fait ressentir — sont stockées uniquement dans l’appli, sur ton appareil. Elles ne sont jamais envoyées à nos serveurs.';

  @override
  String get ppCloudHead => 'Ce que nous stockons dans le cloud';

  @override
  String get ppCloudBody =>
      'Quand tu crées un compte, nous stockons : ton adresse e-mail (pour la connexion ; ton mot de passe est chiffré et nous ne le voyons jamais), un nom affiché et une bio facultatifs, et ton réglage de verrouillage de confidentialité. Pour faire vivre la communauté (« pods ») nous stockons les messages que tu publies ainsi que les blocages ou signalements que tu fais. Pour sécuriser ta progression entre appareils, nous sauvegardons uniquement des chiffres — ta série, les défis terminés et les évaluations d’anxiété (prévue vs réelle) — ainsi que les étapes personnalisées que tu crées. Le texte des notes n’est jamais inclus.';

  @override
  String get ppAnalyticsHead => 'Analytique';

  @override
  String get ppAnalyticsBody =>
      'Nous utilisons une analytique produit respectueuse de la vie privée (PostHog) pour comprendre quelles fonctions aident, à l’aide d’événements d’usage anonymes comme « écran ouvert » ou « étape terminée ». Nous n’envoyons jamais le contenu de tes notes ou messages à l’analytique.';

  @override
  String get ppUseHead => 'Comment nous utilisons tes informations';

  @override
  String get ppUseBody =>
      'Uniquement pour fournir l’appli : te connecter, faire fonctionner les pods, restaurer ta progression et améliorer Rung à partir de tendances agrégées et anonymes. Nous ne vendons pas tes données et ne les utilisons pas à des fins publicitaires.';

  @override
  String get ppProcessHead => 'Qui traite tes données';

  @override
  String get ppProcessBody =>
      'Nous utilisons Supabase (authentification, base de données et hébergement) et PostHog (analytique) comme sous-traitants. Ils traitent les données pour notre compte selon leurs propres engagements de sécurité et de confidentialité.';

  @override
  String get ppRightsHead => 'Tes droits et choix';

  @override
  String get ppRightsBody =>
      'Tu peux modifier ton profil, le verrouiller pour que les autres membres ne le voient pas, et supprimer définitivement ton compte et toutes les données associées dans le cloud à tout moment via Profil → Supprimer le compte. Tu peux aussi nous écrire pour demander l’accès à tes données ou leur suppression.';

  @override
  String get ppSecurityHead => 'Sécurité et conservation';

  @override
  String get ppSecurityBody =>
      'Les données sont chiffrées en transit, et chaque table est protégée par une sécurité au niveau des lignes, de sorte que tu ne puisses accéder qu’à tes propres données (et aux messages des pods dont tu es membre). Nous conservons tes données jusqu’à ce que tu supprimes ton compte ou nous demandes de les retirer.';

  @override
  String get ppChildrenHead => 'Enfants';

  @override
  String get ppChildrenBody =>
      'Rung n’est pas destiné aux personnes de moins de 16 ans. Si tu penses qu’un enfant a créé un compte, contacte-nous et nous le supprimerons.';

  @override
  String get ppMedicalHead => 'Pas des soins médicaux';

  @override
  String get ppMedicalBody =>
      'Rung soutient une pratique progressive mais n’est pas une thérapie, un diagnostic ou un avis médical. Si tu es en crise, contacte les services d’urgence locaux ou une ligne d’écoute.';

  @override
  String get ppChangesHead => 'Modifications';

  @override
  String get ppChangesBody =>
      'Si nous mettons à jour cette politique, nous changerons la date ci-dessus et, pour les changements importants, nous t’informerons dans l’appli.';

  @override
  String get termsTitle => 'Conditions d’utilisation';

  @override
  String get termsIntro =>
      'Ces conditions constituent l’accord entre toi et Rung lorsque tu utilises l’appli. En créant un compte ou en utilisant Rung, tu les acceptes.';

  @override
  String get tosMedicalHead => 'Pas un service médical';

  @override
  String get tosMedicalBody =>
      'Rung est un outil de pratique et d’auto-assistance, pas une thérapie ni des soins médicaux, et ne remplace pas une aide professionnelle. Il ne peut garantir aucun résultat particulier. Si tu es en crise ou que tu risques de te faire du mal ou d’en faire à autrui, contacte immédiatement les services d’urgence locaux.';

  @override
  String get tosEligibilityHead => 'Admissibilité';

  @override
  String get tosEligibilityBody =>
      'Tu dois avoir au moins 16 ans pour utiliser Rung et avoir le droit d’accepter ces conditions.';

  @override
  String get tosAccountHead => 'Ton compte';

  @override
  String get tosAccountBody =>
      'Garde tes identifiants en sécurité — tu es responsable de l’activité sur ton compte. Préviens-nous rapidement si tu soupçonnes une utilisation non autorisée.';

  @override
  String get tosCommunityHead => 'Règles de la communauté (pods)';

  @override
  String get tosCommunityBody =>
      'Les pods sont pour la bienveillance et le soutien. Tu acceptes de ne pas harceler, menacer, rabaisser, spammer, ni publier de contenu haineux ou illégal, et de ne pas partager les informations privées d’autrui. Nous pouvons retirer du contenu ou suspendre les comptes qui enfreignent ces règles. Tu peux bloquer et signaler d’autres membres à tout moment.';

  @override
  String get tosContentHead => 'Le contenu que tu publies';

  @override
  String get tosContentBody =>
      'Tu conserves la propriété de ce que tu écris. En publiant dans un pod, tu nous donnes la permission de le stocker et de le montrer aux membres de ce pod pour que la communauté fonctionne. Ne publie rien que tu n’as pas le droit de partager.';

  @override
  String get tosSubsHead => 'Abonnements';

  @override
  String get tosSubsBody =>
      'Certaines fonctions et du contenu de pratique supplémentaire sont disponibles avec un abonnement payant. Quand la facturation sera active, les achats et renouvellements seront gérés par la boutique d’applications, et tu pourras les gérer ou les annuler depuis ton compte de boutique. Les prix et le contenu inclus peuvent changer avec préavis.';

  @override
  String get tosDisclaimerHead => 'Avertissements et responsabilité';

  @override
  String get tosDisclaimerBody =>
      'Rung est fourni « tel quel », sans garantie d’aucune sorte. Dans toute la mesure permise par la loi, nous ne sommes pas responsables des pertes indirectes ou consécutives découlant de ton utilisation de l’appli.';

  @override
  String get tosEndingHead => 'Fin de ton utilisation';

  @override
  String get tosEndingBody =>
      'Tu peux supprimer ton compte à tout moment via Profil → Supprimer le compte. Nous pouvons suspendre ou mettre fin à l’accès si ces conditions sont gravement ou répétitivement enfreintes.';

  @override
  String get tosChangesHead => 'Modifications';

  @override
  String get tosChangesBody =>
      'Nous pouvons mettre à jour ces conditions ; nous mettrons à jour la date ci-dessus et, pour les changements importants, nous t’avertirons dans l’appli. Continuer à utiliser Rung signifie que tu acceptes les conditions mises à jour.';

  @override
  String get breatheCta => 'Tu sens l’appréhension ? Respire d’abord';

  @override
  String get breatheIntro => 'Soixante secondes. Suis simplement le cercle.';

  @override
  String get breatheIn => 'Inspire';

  @override
  String get breatheHold => 'Retiens';

  @override
  String get breatheOut => 'Expire';

  @override
  String get breatheSkip => 'Passer';

  @override
  String get breatheDoneTitle => 'Voilà.';

  @override
  String get breatheDoneSub =>
      'Tu te sens un peu plus posé ? Fais ton étape quand tu es prêt.';

  @override
  String get breatheDoneBtn => 'Terminé';

  @override
  String get insightsDeeperTitle => 'Analyses approfondies';

  @override
  String get insightsLockedBody =>
      'Vois ton mois d\'un coup d\'œil — à quel point ta peur a dépassé la réalité, et combien de fois tu l\'as surestimée. Un avantage Premium.';

  @override
  String get insightsUnlockCta => 'Débloquer avec Premium';

  @override
  String get insightsNoSteps =>
      'Aucun pas enregistré ce mois-ci. Affronte-en quelques-uns et ton résumé apparaîtra ici.';

  @override
  String get insightsFearsFacedMonth => 'peurs affrontées ce mois-ci';

  @override
  String insightsGapHotter(String points) {
    return 'Ta peur a été $points points plus vive que la réalité, en moyenne.';
  }

  @override
  String get insightsGapTougher =>
      'La réalité a été un peu plus dure que prévu ce mois-ci — ce sont aussi des données courageuses.';

  @override
  String get insightsGapSpotOn =>
      'Tes prédictions étaient plutôt justes ce mois-ci.';

  @override
  String insightsOverPredicted(int rate) {
    return 'Tu as surestimé la peur $rate% du temps.';
  }

  @override
  String get insightsTrendSame => 'Comme le mois dernier';

  @override
  String insightsTrendMore(int count) {
    return '$count de plus que le mois dernier';
  }

  @override
  String insightsTrendFewer(int count) {
    return '$count de moins que le mois dernier';
  }

  @override
  String get rateTitle => 'Rung te plaît ?';

  @override
  String get ratePromptNone => 'Comment se passe Rung pour toi ?';

  @override
  String get ratePromptLow =>
      'Désolés que ça ne fonctionne pas. Qu\'est-ce qui manque ?';

  @override
  String get ratePromptMid => 'Merci — qu\'est-ce qui en ferait un 5 ?';

  @override
  String get ratePromptHigh => 'Ça compte beaucoup. Qu\'est-ce que tu aimes ?';

  @override
  String get rateHintLove => 'Quelque chose que tu aimes ? (facultatif)';

  @override
  String get rateHintMore => 'Dis-nous en plus (facultatif)';

  @override
  String get rateSend => 'Envoyer';

  @override
  String get rateThanksHigh => 'Merci — ça aide vraiment. 🌱';

  @override
  String get rateThanksLow =>
      'Merci pour ta franchise — nous nous en servirons pour progresser.';

  @override
  String get editProfileTitle => 'Modifier le profil';

  @override
  String get editDisplayName => 'Nom affiché';

  @override
  String get editDisplayNameHint => 'Comment les pods doivent-ils t\'appeler ?';

  @override
  String get editBio => 'Courte bio (facultatif)';

  @override
  String get editBioHint =>
      'Une ligne sur toi — gardée privée si tu verrouilles ton profil.';

  @override
  String get errorOffline =>
      'Tu es hors ligne. Connecte-toi à Internet et réessaie.';

  @override
  String get errorGeneric => 'Une erreur s\'est produite. Réessaie.';

  @override
  String get errorSaveFailed =>
      'Échec de l\'enregistrement — ton appareil manque peut-être d\'espace. Libère de l\'espace et réessaie.';
}
