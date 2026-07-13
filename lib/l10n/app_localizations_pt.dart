// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get navHome => 'Início';

  @override
  String get navGroups => 'Grupos';

  @override
  String get navPremium => 'Premium';

  @override
  String get navProfile => 'Perfil';

  @override
  String get greetingMorning => 'Bom dia';

  @override
  String get greetingAfternoon => 'Boa tarde';

  @override
  String get greetingEvening => 'Boa noite';

  @override
  String get todayStepIntro => 'Aqui está um pequeno passo para hoje.';

  @override
  String get commonContinue => 'Continuar';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonSave => 'Salvar';

  @override
  String get commonDone => 'Concluído';

  @override
  String get commonNotNow => 'Agora não';

  @override
  String get profileTitle => 'Perfil';

  @override
  String get language => 'Idioma';

  @override
  String get languageSystemDefault => 'Padrão do sistema';

  @override
  String get yourTone => 'Seu tom';

  @override
  String get appearance => 'Aparência';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';

  @override
  String get onbSkip => 'Pular';

  @override
  String get onbWelcomeTitle =>
      'Encare os momentos que você costumava temer — um pequeno passo de cada vez.';

  @override
  String get onbWelcomeBody =>
      'O Rung ajuda você a ganhar confiança social com prática suave e privada. Preveja, faça, reflita — e veja seus piores medos se desfazerem nos seus próprios números.';

  @override
  String get onbGetStarted => 'Começar';

  @override
  String get onbSafetyTitle => 'Prática, não terapia.';

  @override
  String get onbUnderstand => 'Entendi';

  @override
  String get onbSafetyBody1 =>
      'O Rung é uma ferramenta de confiança e prática — não é terapia, nem tratamento médico, nem um diagnóstico.';

  @override
  String get onbSafetyBody2 =>
      'O objetivo é se sentir mais à vontade em momentos que você costumava temer — não virar alguém que você não é. Pular sempre está tudo bem.';

  @override
  String get onbSafetyCrisis =>
      'Se a ansiedade estiver afetando seriamente sua vida, ou se você tiver pensamentos de se machucar, procure um profissional ou uma linha de apoio em crise local.';

  @override
  String get onbFearTitle => 'Por onde você gostaria de começar?';

  @override
  String get onbFearBody =>
      'Só para sugerir um primeiro passo — você pode subir por qualquer um destes a qualquer momento. Nada aqui prende você.';

  @override
  String get onbExploreOwn => 'Prefiro explorar por conta própria';

  @override
  String get onbToneTitle => 'Com qual você se identifica mais?';

  @override
  String get onbToneIntrovertTitle => 'Sou mais introvertido';

  @override
  String get onbToneIntrovertBody =>
      'Quero me sentir confortável, não virar uma pessoa diferente.';

  @override
  String get onbToneSituationalTitle => 'Fico ansioso em certas situações';

  @override
  String get onbToneSituationalBody =>
      'Às vezes sou extrovertido, mas certos momentos me atrapalham.';

  @override
  String get onbToneFootnote => 'Você pode mudar isso quando quiser no Perfil.';

  @override
  String get onbHowTitle => 'Veja como funciona.';

  @override
  String get onbStartClimbing => 'Começar a subir';

  @override
  String get onbStep1 => 'Preveja o quão ruim vai parecer (0–10).';

  @override
  String get onbStep2 => 'Vá fazer na vida real — o app pode ficar fechado.';

  @override
  String get onbStep3 => 'Volte e registre como realmente foi.';

  @override
  String get onbGentleFirstStep => 'UM PRIMEIRO PASSO SUAVE';

  @override
  String get onbGoodPlaceToStart => 'UM BOM LUGAR PARA COMEÇAR';

  @override
  String get onbAllAreas =>
      'Todas as seis áreas estão na sua tela inicial — comece por onde quiser.';

  @override
  String get predictAppBar => 'Antes de ir';

  @override
  String get predictSaved =>
      'Salvo. Vá em frente e faça — depois volte para registrar como foi.';

  @override
  String get predictQuestion => 'Quão ruim você acha que vai ser?';

  @override
  String get predictNoteLabel =>
      'O que você acha que vai acontecer? (opcional)';

  @override
  String get predictNoteHint => 'ex.: Vão achar que sou esquisito';

  @override
  String get predictCompare =>
      'Vamos comparar isso com o que acontece de verdade. Essa diferença é o que importa.';

  @override
  String get predictDoIt => 'Vou fazer';

  @override
  String get reflectAppBar => 'Como foi?';

  @override
  String get reflectDidYouDoIt => 'Você fez?';

  @override
  String get reflectHowAnxious =>
      'Quão ansioso o pensamento fez você se sentir?';

  @override
  String get reflectHowBad => 'Quão ruim foi, na verdade?';

  @override
  String get reflectNoteLabel => 'Algo que queira lembrar? (opcional)';

  @override
  String get reflectOutcomeDone => 'Feito';

  @override
  String get reflectOutcomePartial => 'Parcial';

  @override
  String get reflectOutcomeNotToday => 'Hoje não';

  @override
  String get resultQuietDelight => 'Uma alegria tranquila em cada passo.';

  @override
  String get resultBackToLadder => 'Voltar à escada';

  @override
  String resultGapHeadline(int predicted, int actual) {
    return 'Você se preparou para $predicted. Ficou em $actual.';
  }

  @override
  String resultGapSub(int predicted, int actual) {
    return 'Seu coração se preparou para um pesado $predicted, mas o mundo te recebeu com um $actual mais suave. Vale a pena lembrar.';
  }

  @override
  String get resultRightHeadline => 'Exatamente como você imaginou.';

  @override
  String get resultRightSub =>
      'Você acertou, e ainda assim compareceu. Essa é a vitória.';

  @override
  String get resultTougherHeadline =>
      'Mais difícil do que você imaginava, e você fez.';

  @override
  String get resultTougherSub =>
      'Alguns momentos exigem mais de nós. Comparecer mesmo assim é o que importa.';

  @override
  String get resultPredicted => 'Previsto';

  @override
  String get resultActual => 'Real';

  @override
  String resultLighter(int reduction) {
    return 'Este momento foi $reduction% mais leve do que você temia';
  }

  @override
  String get resultSkippedHeadline => 'Registrado, sem pressão.';

  @override
  String get resultSkippedSub =>
      'Hoje não é uma resposta perfeitamente válida. Este degrau continuará aqui quando você estiver pronto.';

  @override
  String get resultWinCopied => 'Vitória copiada, cole onde quiser.';

  @override
  String get resultCopyWin => 'Copiar minha vitória';

  @override
  String resultShareText(String rung) {
    return 'Acabei de fazer algo que eu costumava evitar: $rung. Um pequeno degrau superado. 🪜 #Rung';
  }

  @override
  String get tracksTitle => 'Seus caminhos';

  @override
  String get tracksSubtitle => 'Pequenos passos rumo a uma grande confiança.';

  @override
  String get menuInsights => 'Análises';

  @override
  String get menuIsThisRight => 'Isto é para mim?';

  @override
  String tracksRungsCount(int done, int total) {
    return '$done de $total degraus';
  }

  @override
  String tracksClimbedCount(int done, int total) {
    return '$done de $total superados';
  }

  @override
  String get tracksContinueLabel => 'CONTINUE DE ONDE PAROU';

  @override
  String get tracksNextStepLabel => 'SEU PRÓXIMO PASSO';

  @override
  String get tracksLoadError => 'Não foi possível carregar os caminhos.';

  @override
  String get todayResume => 'Retome de onde parou';

  @override
  String get todayNext => 'Seu próximo passo';

  @override
  String get todayVariety => 'Algo um pouco diferente';

  @override
  String get todayFresh => 'Seu ponto de partida';

  @override
  String get todayResumeCta => 'Terminar de registrar';

  @override
  String get todayStartCta => 'Começar';

  @override
  String todayMinutes(int min) {
    return '~$min min';
  }

  @override
  String get dashShareTooltip => 'Compartilhar meu progresso';

  @override
  String get dashWeeklyGoal => 'Meta semanal';

  @override
  String dashStepsPerWeek(int count) {
    return '$count passos/semana';
  }

  @override
  String dashGoalPerWeek(int count) {
    return '$count/semana';
  }

  @override
  String dashWeeklyProgress(int done, int goal) {
    return '$done de $goal passos concluídos esta semana';
  }

  @override
  String get dashYourGrowth => 'Seu crescimento';

  @override
  String get dashTodayError =>
      'Não foi possível carregar o passo de hoje. Puxe para tentar novamente.';

  @override
  String get dashTodayAllClear =>
      'Você concluiu tudo o que estava disponível — adicione um degrau personalizado ou repita um para manter sua sequência.';

  @override
  String get dashTakeABreak => 'Faça uma pausa';

  @override
  String get dashTakeABreakSub =>
      'Alguns jogos tranquilos, contra o telefone ou um amigo.';

  @override
  String get ladderTitleFallback => 'Escada';

  @override
  String get ladderLoadError => 'Não foi possível carregar a escada.';

  @override
  String get ladderAddOwn => 'Adicione seu próprio degrau';

  @override
  String ladderOfClimbed(int total) {
    return 'de $total superados';
  }

  @override
  String get detailLoadError => 'Não foi possível carregar.';

  @override
  String get detailNotExist => 'Este degrau não existe mais.';

  @override
  String get detailWhatToDo => 'O que fazer';

  @override
  String get detailWhyHelps => 'Por que isto ajuda';

  @override
  String get detailPastAttempts => 'Suas tentativas anteriores';

  @override
  String get detailDoThis => 'Vou fazer';

  @override
  String get detailReattempt => 'Repetir é incentivado: fortalece seus dados.';

  @override
  String detailHistoryStat(int predicted, int actual) {
    return 'previsto $predicted · real $actual';
  }

  @override
  String customLimitPremium(int cap) {
    return 'Você atingiu o limite deste mês de $cap degraus personalizados — ele é redefinido no próximo mês.';
  }

  @override
  String get customLimitFree =>
      'O plano gratuito inclui 5 degraus personalizados — faça upgrade para ter mais a cada mês.';

  @override
  String get customDefaultWhat => 'Um desafio que você define para si mesmo.';

  @override
  String get customDefaultWhy => 'Você deu nome a este — e isso faz valer.';

  @override
  String get customSubtitle =>
      'Sua situação é específica — este degrau é só para você.';

  @override
  String get customWhatLabel => 'O que você vai fazer?';

  @override
  String get customWhatHint => 'ex.: Pedir feedback ao meu gerente';

  @override
  String get customNoteLabel => 'Uma nota para você (opcional)';

  @override
  String customDifficulty(int value) {
    return 'Quão difícil parece? $value/10';
  }

  @override
  String get customAddToLadder => 'Adicionar à escada';

  @override
  String get paywallSwitchToFree => 'Mudar para Gratuito';

  @override
  String get paywallHeroTitle => 'Você não precisa enfrentar isso sozinho.';

  @override
  String get paywallHeroBody =>
      'A prática diária é sempre gratuita. O Premium adiciona um treinador particular ao seu lado — e uma comunidade maior — para quando você estiver pronto para ir além.';

  @override
  String get paywallWhatsIncluded => 'O que está incluído';

  @override
  String get paywallPlusHeader => 'Além disso, todo assinante recebe';

  @override
  String get paywallBenefitCoach =>
      'Um treinador particular, a qualquer hora — ensaie algo que vem por aí ou converse sobre como foi';

  @override
  String get paywallBenefitPods =>
      'Você não está sozinho nisso — participe de mais grupos de apoio (3 no mensal, ilimitados no anual)';

  @override
  String get paywallBenefitCustom =>
      'Crie suas próprias escadas sem limite — sem teto de degraus personalizados';

  @override
  String get paywallBenefitDepth =>
      'Vá mais fundo quando estiver pronto — até 40 passos por caminho (o gratuito é uma jornada completa de 10 passos)';

  @override
  String get paywallPlusStreak =>
      'Proteção de sequência — um dia perdido não quebra sua sequência';

  @override
  String get paywallPlusInsights =>
      'Análises mais profundas — seu mês de relance';

  @override
  String get paywallPlusShare => 'Estilos pessoais para compartilhar';

  @override
  String get paywallPlusPrivacy => 'Sempre privado, sempre sem anúncios';

  @override
  String get paywallYearly => 'Anual';

  @override
  String get paywallPerYear => 'por ano · melhor valor';

  @override
  String get paywallSave => 'Economize 33%';

  @override
  String get paywallMonthly => 'Mensal';

  @override
  String get paywallPerMonth => 'por mês';

  @override
  String get paywallSwitchYearly => 'Mudar para anual';

  @override
  String get paywallSwitchMonthly => 'Mudar para mensal';

  @override
  String paywallStartYearly(String price) {
    return 'Começar anual — $price';
  }

  @override
  String paywallStartMonthly(String price) {
    return 'Começar mensal — $price';
  }

  @override
  String get paywallRestore => 'Restaurar compras';

  @override
  String paywallCurrentPlan(String plan) {
    return 'Plano atual: $plan. Cancele quando quiser.';
  }

  @override
  String get paywallCancelAnytime =>
      'Cancele quando quiser. O núcleo continua gratuito para sempre.';

  @override
  String get paywallSimulated =>
      'Premium ativo (simulado — adicione chaves do RevenueCat para compras reais).';

  @override
  String get paywallPlanUnavailable =>
      'Esse plano não está disponível agora. Tente novamente em breve.';

  @override
  String get paywallThankYou => 'Premium ativo — obrigado. 🌱';

  @override
  String get paywallPurchaseFailed =>
      'A compra não foi concluída. Você não foi cobrado.';

  @override
  String get paywallRestored => 'Compras restauradas.';

  @override
  String get paywallNoRestore =>
      'Nenhuma compra anterior encontrada nesta conta.';

  @override
  String get paywallRestoreFailed =>
      'Não foi possível restaurar agora. Tente novamente em breve.';

  @override
  String get profileAddName => 'Adicione seu nome';

  @override
  String get profileLockTitle => 'Bloquear meu perfil';

  @override
  String get profileLockedSub =>
      'Oculto: os membros do grupo não podem ver seus detalhes.';

  @override
  String get profileUnlockedSub =>
      'Os membros do grupo podem tocar no seu avatar para ver seus detalhes.';

  @override
  String get profilePlanTitle => 'Seu plano';

  @override
  String get profilePremium => 'Premium';

  @override
  String get profileUpgrade => 'Fazer upgrade';

  @override
  String get profileToneDesc =>
      'O Rung fala com suavidade por padrão. Se sua ansiedade é mais situacional, um tom um pouco mais direto pode combinar melhor.';

  @override
  String get profileToneIntrovert => 'Introvertido';

  @override
  String get profileToneSituational => 'Situacional';

  @override
  String get profileSafetySub =>
      'Como o Rung se encaixa — e quando buscar mais ajuda';

  @override
  String get profileBlockedTitle => 'Membros bloqueados';

  @override
  String get profileBlockedSub =>
      'Veja e desbloqueie pessoas que você bloqueou';

  @override
  String get profileRestoreTitle => 'Restaurar meu progresso';

  @override
  String get profileRestoreSub => 'Recupere sua sequência e desafios da nuvem';

  @override
  String get profileRestoring => 'Restaurando…';

  @override
  String get profileRestoreOk => 'Progresso restaurado da nuvem.';

  @override
  String profileRestoreFail(String error) {
    return 'Falha ao restaurar: $error';
  }

  @override
  String get profileLogout => 'Sair';

  @override
  String get profileSignedIn => 'Conectado';

  @override
  String get profileLogoutConfirmTitle => 'Sair?';

  @override
  String get profileLogoutConfirmBody =>
      'Seu progresso está salvo na nuvem e volta quando você entrar novamente.';

  @override
  String get profileLoggingOut => 'Saindo…';

  @override
  String get profileRateTitle => 'Avaliar o Rung';

  @override
  String get profileRateSub => 'Conte como está indo — ajuda muito';

  @override
  String get profilePrivacyTitle => 'Política de Privacidade';

  @override
  String get profilePrivacySub =>
      'O que guardamos — e o que fica no seu dispositivo';

  @override
  String get profileTermsTitle => 'Termos de Serviço';

  @override
  String get profileTermsSub => 'O acordo para usar o Rung';

  @override
  String get profileDeleteTitle => 'Excluir conta';

  @override
  String get profileDeleteSub =>
      'Apague sua conta e seus dados permanentemente';

  @override
  String get profileFooter =>
      'Rung · prática, não terapia. Seus dados são seus.';

  @override
  String get profileDeleteConfirmTitle => 'Excluir conta?';

  @override
  String get profileDeleteConfirmBody =>
      'Isto exclui permanentemente sua conta, suas mensagens de grupo e seu progresso salvo. Não pode ser desfeito.';

  @override
  String get profileDelete => 'Excluir';

  @override
  String get profileDeleting => 'Excluindo sua conta…';

  @override
  String get profileDeleteFail =>
      'Não foi possível excluir sua conta. Tente novamente.';

  @override
  String get profileBioPlaceholder => 'Um escalador tranquilo.';

  @override
  String get profileHaptics => 'Vibração';

  @override
  String get profileHapticsSub => 'Vibração suave ao tocar e ao vencer';

  @override
  String get profileNotifications => 'Notificações';

  @override
  String get profileNotificationsSub => 'Avisos do Rung neste dispositivo';

  @override
  String get profilePodAlerts => 'Avisos de mensagens de grupo';

  @override
  String get profilePodAlertsSub =>
      'Avise-me quando alguém publicar nos meus grupos';

  @override
  String get profileEnableNotifs =>
      'Ative as notificações nos Ajustes para receber lembretes.';

  @override
  String get profileReminderHelp => 'Quando devemos te lembrar?';

  @override
  String get profileReminderTitle => 'Lembrete diário suave';

  @override
  String profileReminderOn(String time) {
    return 'Todo dia às $time · toque no botão para desativar';
  }

  @override
  String get profileReminderOff =>
      'Um empurrãozinho calmo e sem culpa para dar um pequeno passo';

  @override
  String get profileAvatarTitle => 'Escolha seu avatar';

  @override
  String get profileAvatarSub =>
      'Só você pode mudá-lo — seus colegas de grupo também o veem.';

  @override
  String get commonClose => 'Fechar';

  @override
  String get checkInMoodCalm => 'Calmo';

  @override
  String get checkInMoodOkay => 'Bem';

  @override
  String get checkInMoodAnxious => 'Ansioso';

  @override
  String get checkInMoodLow => 'Para baixo';

  @override
  String get checkInMoodTense => 'Tenso';

  @override
  String get checkInTitle => 'Como você está chegando hoje?';

  @override
  String get checkInDismiss => 'Dispensar';

  @override
  String get checkInCalmCta => 'Experimente um momento de calma';

  @override
  String get checkInStepCta => 'Ver o passo de hoje';

  @override
  String get supportTitle => 'Parece que você está carregando bastante coisa.';

  @override
  String get supportBody =>
      'O Rung é uma ferramenta de prática, não um serviço de crise. Se você está passando por algo pesado, por favor procure alguém que possa ajudar agora — uma pessoa de confiança ou uma linha de crise local. Você merece apoio de verdade.';

  @override
  String get supportResources => 'Ver recursos de apoio';

  @override
  String get progressChallenges => 'Desafios';

  @override
  String get progressCurrentStreak => 'Sequência atual';

  @override
  String get progressBestStreak => 'Melhor sequência';

  @override
  String get progressThisWeek => 'Esta semana';

  @override
  String get progressCategoryBreakdown => 'Detalhamento por categoria';

  @override
  String get insightsHistory => 'Histórico';

  @override
  String checkInAckTitle(String mood) {
    return 'Registrado — você está se sentindo $mood';
  }

  @override
  String get checkInAckGentle =>
      'Obrigado pela sinceridade. Vamos manter o dia leve — uma pequena coisa gentil já basta.';

  @override
  String get checkInAckStep =>
      'Adorei. Quando estiver pronto, um pequeno passo mantém o ritmo.';

  @override
  String get sharePremiumPerk =>
      '✨ Mais estilos de cartão são um benefício Premium.';

  @override
  String get shareSeePremium => 'Ver Premium';

  @override
  String get shareText =>
      'Pequenos passos corajosos, um degrau de cada vez. 🌱 #Rung';

  @override
  String get shareError =>
      'Não foi possível abrir o compartilhamento. Tente novamente.';

  @override
  String get shareTitle => 'Compartilhe seu progresso';

  @override
  String get shareSubtitle => 'Só os seus números — nada privado.';

  @override
  String get shareCta => 'Compartilhar';

  @override
  String get shareCardHeadline => 'Meus passos corajosos';

  @override
  String get shareCardFearsFaced => 'medos enfrentados';

  @override
  String get shareCardCurrentStreak => 'Sequência atual';

  @override
  String get shareCardBestStreak => 'Melhor sequência';

  @override
  String get shareCardTagline =>
      'Enfrentando medos sociais, um pequeno degrau de cada vez.';

  @override
  String get helpNow => 'Ajuda agora';

  @override
  String get helpCalmMoment => 'Um momento de calma';

  @override
  String get helpTabBreathe => 'Respire';

  @override
  String get helpTabGround => 'Ancore-se';

  @override
  String get helpTabSay => 'Diga isto';

  @override
  String get helpBreatheIn => 'Inspire…';

  @override
  String get helpBreatheOut => 'Expire…';

  @override
  String get helpBreatheHint => 'Siga o círculo. Não há pressa.';

  @override
  String get helpGround5 => 'coisas que você pode ver';

  @override
  String get helpGround4 => 'coisas que você pode tocar';

  @override
  String get helpGround3 => 'coisas que você pode ouvir';

  @override
  String get helpGround2 => 'coisas que você pode cheirar';

  @override
  String get helpGround1 => 'coisa que você pode saborear';

  @override
  String get helpGroundTitle => 'Nomeie, em silêncio para você…';

  @override
  String get helpGroundHint =>
      'Isto te traz de volta ao agora — onde você está seguro.';

  @override
  String get helpOpener1 => 'De onde você conhece as pessoas aqui?';

  @override
  String get helpOpener2 => 'Adoro este lugar — você já veio antes?';

  @override
  String get helpOpener3 => 'Sou péssimo com nomes — pode me lembrar?';

  @override
  String get helpOpener4 => 'O que você tem feito esta semana?';

  @override
  String get helpExit1 => 'Vou pegar uma bebida — foi bom conversar com você.';

  @override
  String get helpExit2 =>
      'Preciso dar um oi rápido a alguém, com licença um instante.';

  @override
  String get helpExit3 => 'Vou te deixar circular — até mais.';

  @override
  String get helpOpenersTitle => 'Frases para começar';

  @override
  String get helpExitsTitle => 'Saídas graciosas';

  @override
  String get authEnterEmail => 'Digite seu e-mail';

  @override
  String get authBadEmail => 'Esse e-mail não parece válido';

  @override
  String get authEnterPassword => 'Digite uma senha';

  @override
  String get authMin6 => 'Pelo menos 6 caracteres';

  @override
  String get authPwMismatch => 'As senhas não coincidem';

  @override
  String get authConfirmEmail =>
      'Verifique seu e-mail para confirmar e depois entre. (Ou desative a confirmação por e-mail nas configurações de Auth do Supabase para testes rápidos.)';

  @override
  String get authGenericError => 'Algo deu errado. Tente novamente.';

  @override
  String get authCreateTitle => 'Crie sua conta';

  @override
  String get authWelcomeBack => 'Bem-vindo de volta';

  @override
  String get authSignUpSub =>
      'Entre nos grupos e mantenha seu progresso seguro em todos os dispositivos.';

  @override
  String get authSignInSub =>
      'Entre nos seus grupos e no seu progresso sincronizado.';

  @override
  String get authDisplayName => 'Nome de exibição (opcional)';

  @override
  String get authEmail => 'E-mail';

  @override
  String get authPassword => 'Senha';

  @override
  String get authShowPassword => 'Mostrar senha';

  @override
  String get authHidePassword => 'Ocultar senha';

  @override
  String get authConfirmPassword => 'Confirmar senha';

  @override
  String get authCreateCta => 'Criar conta';

  @override
  String get authSignInCta => 'Entrar';

  @override
  String get authHaveAccount => 'Já tenho uma conta';

  @override
  String get authNewAccount => 'Sou novo — criar uma conta';

  @override
  String get authLegalPrefixSignUp =>
      'Ao criar uma conta, você concorda com nossos ';

  @override
  String get authLegalPrefixSignIn => 'Ao continuar, você concorda com nossos ';

  @override
  String get authTerms => 'Termos';

  @override
  String get authAnd => ' e ';

  @override
  String get gamesIntro =>
      'Jogos tranquilos para foco e uma mente calma — o tipo de treino mental que as pessoas acham reconfortante. Jogue contra o telefone ou passe para um amigo.';

  @override
  String gamesBestMs(int ms) {
    return 'Melhor: $ms ms';
  }

  @override
  String gamesBestLevel(int level) {
    return 'Melhor nível: $level';
  }

  @override
  String gamesBest(String score) {
    return 'Melhor: $score';
  }

  @override
  String gamesBestMoves(int moves) {
    return 'Melhor: $moves jogadas';
  }

  @override
  String gamesWinsVsPhone(int count) {
    return '$count vitórias vs. telefone';
  }

  @override
  String get gameTitleReaction => 'Velocidade de reação';

  @override
  String get gameTitleSequence => 'Memória de sequência';

  @override
  String get gameTitleQuickMath => 'Cálculo rápido';

  @override
  String get gameTitleMemory => 'Jogo da memória';

  @override
  String get gameSubReaction => 'foco · toque quando ficar verde';

  @override
  String get gameSubSequence => 'memória · observe e repita';

  @override
  String get gameSub2048 => 'estratégia · deslize para juntar';

  @override
  String get gameSubQuickMath => 'rapidez mental · corrida de 30 segundos';

  @override
  String get gameSubTicTacToe => 'vs. o telefone · ou 2 jogadores';

  @override
  String get gameSubConnect4 => 'vs. o telefone · ou 2 jogadores';

  @override
  String get gameSubMemory => 'sozinho · encontre os pares';

  @override
  String get gameHelpTooltip => 'Como jogar';

  @override
  String gameHelpTitle(String game) {
    return 'Como jogar · $game';
  }

  @override
  String get gameGotIt => 'Entendi';

  @override
  String get tierFree => 'Gratuito';

  @override
  String get tierMonthly => 'Premium · Mensal';

  @override
  String get tierYearly => 'Premium · Anual';

  @override
  String get podsUnlimited => 'grupos ilimitados';

  @override
  String podsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count grupos',
      one: '1 grupo',
    );
    return '$_temp0';
  }

  @override
  String get groupsSignedOutTitle => 'Entre em um grupo pequeno e acolhedor';

  @override
  String get groupsSignedOutBody =>
      'Os grupos precisam de uma conta rápida para serem seguros e seus. Sua prática continua privada e sem conta.';

  @override
  String get groupsSignInCta => 'Entre para continuar';

  @override
  String get groupsLoadError =>
      'Não foi possível carregar os grupos. Puxe para tentar novamente.';

  @override
  String groupsJoined(String pod) {
    return 'Você entrou em $pod. Diga oi quando estiver pronto.';
  }

  @override
  String get groupsJoinedNew =>
      'Você entrou em um grupo novo. Diga oi quando estiver pronto.';

  @override
  String get groupsNoPodFound =>
      'Nenhum grupo encontrado agora. Tente novamente.';

  @override
  String groupsLeaveTitle(String pod) {
    return 'Sair de $pod?';
  }

  @override
  String get groupsLeave => 'Sair';

  @override
  String groupsLeft(String pod) {
    return 'Você saiu de $pod.';
  }

  @override
  String get groupsLeaveError =>
      'Não foi possível sair do grupo. Tente novamente.';

  @override
  String get groupsHeader => 'Grupos pequenos, gente gentil';

  @override
  String get groupsYourPods => 'SEUS GRUPOS';

  @override
  String get groupsDiscoverPods => 'DESCOBRIR GRUPOS';

  @override
  String get groupsJoinAnother => 'Entrar em outro grupo';

  @override
  String get groupsNoOthers => 'Nenhum outro grupo para entrar agora.';

  @override
  String groupsJoinedShort(String pod) {
    return 'Você entrou em $pod.';
  }

  @override
  String get groupsJoin => 'Entrar';

  @override
  String get groupsPodOptions => 'Opções do grupo';

  @override
  String get groupsLeavePod => 'Sair do grupo';

  @override
  String groupsMembers(int count, int capacity) {
    return '$count/$capacity membros';
  }

  @override
  String groupsTierPods(String tier, String pods) {
    return 'No $tier você pode estar em $pods.';
  }

  @override
  String groupsCapacityTierPods(int capacity, String tier, String pods) {
    return 'Até $capacity por grupo. No $tier você pode estar em $pods.';
  }

  @override
  String groupsInYourPods(String pods) {
    return 'Você está nos seus $pods';
  }

  @override
  String get groupsUpgradeBody =>
      'Assine o Premium para entrar em mais — o mensal libera 3 grupos e o anual, quantos você quiser.';

  @override
  String get groupsSafetyLive =>
      'Seja gentil. Você pode denunciar ou bloquear qualquer pessoa pelo perfil dela. Perfis bloqueados continuam privados.';

  @override
  String get groupsSafetyPreview =>
      'Prévia. Os grupos se tornam chats ao vivo e moderados assim que o login for configurado.';

  @override
  String get groupsLeaveBody =>
      'Você deixará de ver as mensagens deste grupo. Você pode entrar novamente mais tarde.';

  @override
  String get podRulesTitle => 'Regras do grupo';

  @override
  String get podRulesIntro =>
      'Os grupos só funcionam se todos se sentirem seguros. Ao entrar, você concorda:';

  @override
  String get podRule1 =>
      'Seja gentil. Todos aqui estão praticando algo difícil.';

  @override
  String get podRule2 => 'Sem assédio, ódio ou conteúdo prejudicial. Nunca.';

  @override
  String get podRule3 =>
      'Denuncie ou bloqueie qualquer pessoa que te deixe desconfortável.';

  @override
  String get podRule4 =>
      'Respeite a privacidade — o que é compartilhado aqui fica aqui.';

  @override
  String get podRule5 =>
      'Os grupos são apoio entre pares, não um serviço de crise. Em uma emergência, procure um profissional ou uma linha de crise local.';

  @override
  String get podRulesAgree => 'Concordo — entrar';

  @override
  String chatIntrosBeKind(int count, int capacity) {
    return '$count/$capacity introvertidos · seja gentil';
  }

  @override
  String get chatHint => 'Diga algo gentil…';

  @override
  String get chatPreviewBanner =>
      'Prévia · por enquanto as mensagens ficam no seu dispositivo. Grupos reais e moderados chegam com as contas.';

  @override
  String get chatYou => 'Você';

  @override
  String get reportHarassment => 'Assédio ou bullying';

  @override
  String get reportHate => 'Ódio ou linguagem prejudicial';

  @override
  String get reportSpam => 'Spam ou golpe';

  @override
  String get reportUnsafe => 'Me faz sentir inseguro';

  @override
  String get reportOther => 'Outra coisa';

  @override
  String get memberPrivateTitle => 'Perfil privado';

  @override
  String get memberPrivateBody =>
      'Este membro mantém o perfil privado. Você ainda pode conversar com ele — e denunciar ou bloquear se precisar.';

  @override
  String memberStreak(int days) {
    return 'sequência de $days dias';
  }

  @override
  String memberChallenges(int count) {
    return '$count desafios';
  }

  @override
  String memberClimbing(String track) {
    return 'Subindo: $track';
  }

  @override
  String get memberReport => 'Denunciar';

  @override
  String get memberBlock => 'Bloquear';

  @override
  String get memberReportThanks => 'Obrigado — vamos analisar.';

  @override
  String get memberBlockToo => 'Bloquear também';

  @override
  String get memberBlocked => 'Bloqueado. Você não verá as mensagens dele.';

  @override
  String get memberBlockError => 'Não foi possível bloquear. Tente novamente.';

  @override
  String get memberReportError =>
      'Não foi possível enviar a denúncia. Tente novamente.';

  @override
  String get memberBlockConfirmTitle => 'Bloquear este membro?';

  @override
  String get memberBlockConfirmBody =>
      'Vocês não verão as mensagens um do outro. Você pode desfazer isso mais tarde.';

  @override
  String get memberSoonReporting =>
      'Denunciar fica disponível em grupos moderados (entre para usar).';

  @override
  String get memberSoonBlocking =>
      'Bloquear fica disponível em grupos moderados (entre para usar).';

  @override
  String get memberWhatsWrong => 'O que houve?';

  @override
  String get memberFallback => 'Membro';

  @override
  String get blockedUnblockError =>
      'Não foi possível desbloquear. Tente novamente.';

  @override
  String blockedUnblocked(String name) {
    return 'Você desbloqueou $name. Voltará a ver as mensagens dele.';
  }

  @override
  String get blockedIntro =>
      'Bloquear oculta as mensagens de um membro para você — e as suas para ele, nos dois sentidos. Desbloqueie qualquer pessoa abaixo para desfazer.';

  @override
  String get blockedLabel => 'Bloqueado';

  @override
  String get blockedUnblock => 'Desbloquear';

  @override
  String get blockedEmptyTitle => 'Ninguém bloqueado';

  @override
  String get blockedEmptyBody =>
      'Você não bloqueou ninguém. Bloquear oculta as mensagens de um membro para você, nos dois sentidos — e você sempre pode desfazer aqui.';

  @override
  String get chatCheckInPosted => 'Bom trabalho. Check-in publicado no grupo.';

  @override
  String get chatCheckInError =>
      'Não foi possível fazer check-in agora. Tente novamente.';

  @override
  String get chatDeleteMsgTitle => 'Excluir mensagem?';

  @override
  String get chatDeleteMsgBody => 'Ela é removida para todos no grupo.';

  @override
  String get chatReply => 'Responder';

  @override
  String get chatEdit => 'Editar';

  @override
  String get chatDailyPrompt => 'Sugestão diária do grupo';

  @override
  String get chatCheckedInToday => 'Check-in feito hoje';

  @override
  String get chatDidMyStep => 'Fiz meu passo';

  @override
  String chatCheckedInCount(int count) {
    return '$count fizeram check-in';
  }

  @override
  String get chatNoMessages =>
      'Ainda não há mensagens. Um simples \"oi\" é um primeiro degrau corajoso.';

  @override
  String get chatEditingMessage => 'Editando sua mensagem';

  @override
  String chatReplyingTo(String name) {
    return 'Respondendo a $name';
  }

  @override
  String get chatYourself => 'você mesmo';

  @override
  String get chatMsgDeleted => 'Esta mensagem foi excluída';

  @override
  String get chatPrivateMember => 'Membro privado';

  @override
  String chatBeKind(int count, int capacity) {
    return '$count/$capacity · seja gentil';
  }

  @override
  String get chatDeletedMessageShort => 'mensagem excluída';

  @override
  String get gameYouWin => 'Você venceu! 🎉';

  @override
  String get gamePhoneWins => 'O telefone venceu';

  @override
  String get gamePhoneThinking => 'O telefone está pensando…';

  @override
  String get gamePlayPhone => 'Jogar contra o telefone';

  @override
  String get game2Players => '2 jogadores';

  @override
  String get gameNewGame => 'Novo jogo';

  @override
  String get gameYou => 'Você';

  @override
  String get gamePhone => 'Telefone';

  @override
  String get gameDraws => 'Empates';

  @override
  String get tttP1Wins => 'Jogador 1 (X) venceu! 🎉';

  @override
  String get tttP2Wins => 'Jogador 2 (O) venceu! 🎉';

  @override
  String get tttYourTurn => 'Sua vez';

  @override
  String get tttP1Turn => 'Jogador 1 · X';

  @override
  String get tttP2Turn => 'Jogador 2 · O';

  @override
  String get tttP1Label => 'J1 (X)';

  @override
  String get tttP2Label => 'J2 (O)';

  @override
  String get tttRule1 => 'Revezem-se colocando sua marca na grade 3×3.';

  @override
  String get tttRule2 =>
      'Consiga três marcas em linha — horizontal, vertical ou diagonal — para vencer.';

  @override
  String get tttRule3 =>
      '\"Jogar contra o telefone\" é contra uma IA simples. \"2 jogadores\" passa o telefone a cada vez.';

  @override
  String get c4P1Wins => 'Jogador 1 venceu! 🎉';

  @override
  String get c4P2Wins => 'Jogador 2 venceu! 🎉';

  @override
  String get c4Turn => 'Sua vez — toque em uma coluna';

  @override
  String get c4P1Turn => 'Jogador 1 · vermelho';

  @override
  String get c4P2Turn => 'Jogador 2 · amarelo';

  @override
  String get c4P1Label => 'J1';

  @override
  String get c4P2Label => 'J2';

  @override
  String get c4Rule1 =>
      'Toque em uma coluna para soltar sua ficha — ela cai na posição livre mais baixa.';

  @override
  String get c4Rule2 =>
      'Alinhe quatro da sua cor — horizontal, vertical ou diagonal — para vencer.';

  @override
  String get c4Rule3 =>
      '\"Jogar contra o telefone\" é contra uma IA simples. \"2 jogadores\" passa o telefone.';

  @override
  String get gameDraw => 'Deu empate 🤝';

  @override
  String get gamePlayAgain => 'Jogar de novo';

  @override
  String get gameStart => 'Começar';

  @override
  String get g2048Rule1 =>
      'Deslize para cima, baixo, esquerda ou direita para mover todas as peças.';

  @override
  String get g2048Rule2 =>
      'Duas peças com o mesmo número se fundem em uma que dobra.';

  @override
  String get g2048Rule3 =>
      'Continue fundindo para criar uma peça 2048. O tabuleiro enche — planeje!';

  @override
  String get g2048Score => 'Pontuação';

  @override
  String get g2048Best => 'Melhor';

  @override
  String get g2048GameOver => 'Fim de jogo';

  @override
  String get g2048Won => 'Você fez 2048! 🎉';

  @override
  String get g2048SwipeToMerge => 'Deslize para juntar';

  @override
  String get qmRule1 => 'Você tem 30 segundos — resolva o máximo que puder.';

  @override
  String get qmRule2 => 'Toque na resposta correta entre as quatro opções.';

  @override
  String get qmRule3 =>
      'Um toque errado custa 2 segundos, então leia com atenção.';

  @override
  String qmTimeScored(Object score) {
    return 'Tempo! Você fez $score';
  }

  @override
  String qmBestSub(Object best) {
    return 'Melhor $best · 30 segundos, responda o máximo que puder.';
  }

  @override
  String get qmStartSub => '30 segundos. Um toque errado custa 2 segundos.';

  @override
  String get qmCorrect => 'corretas';

  @override
  String get mmRule1 =>
      'Toque em uma carta para virá-la, depois vire uma segunda.';

  @override
  String get mmRule2 =>
      'Se os dois emojis combinarem, ficam virados para cima; se não, viram de volta.';

  @override
  String get mmRule3 =>
      'Encontre todos os pares — no menor número de jogadas possível.';

  @override
  String mmAllMatched(Object moves) {
    return 'Tudo combinado em $moves jogadas! 🎉';
  }

  @override
  String mmFindPairs(Object moves) {
    return 'Encontre os pares · $moves jogadas';
  }

  @override
  String mmBest(Object best) {
    return 'Melhor: $best jogadas';
  }

  @override
  String get mmShuffle => 'Embaralhar';

  @override
  String get rxTapStart => 'Toque para começar';

  @override
  String get rxWaitGreen => 'Espere o verde e toque rápido';

  @override
  String get rxWait => 'Espere…';

  @override
  String get rxTapMoment => 'Toque assim que ficar verde';

  @override
  String rxBestRetry(Object ms) {
    return 'Melhor $ms ms · toque para tentar de novo';
  }

  @override
  String get rxTapRetry => 'Toque para tentar de novo';

  @override
  String get rxTooSoon => 'Cedo demais!';

  @override
  String get rxWaitRetry => 'Espere o verde · toque para tentar de novo';

  @override
  String get rxTap => 'TOQUE!';

  @override
  String get rxRule1 =>
      'Toque na tela para começar, depois espere — ela ficará âmbar.';

  @override
  String get rxRule2 =>
      'No instante em que ficar verde, toque o mais rápido possível.';

  @override
  String get rxRule3 =>
      'Tocar cedo demais reinicia. Um tempo menor (ms) é melhor.';

  @override
  String get smWatchRepeat => 'Observe o padrão e depois repita.';

  @override
  String get smWatch => 'Observe…';

  @override
  String smYourTurn(Object current, Object total) {
    return 'Sua vez · $current de $total';
  }

  @override
  String smReachedBest(Object best, Object reached) {
    return 'Você chegou a $reached · melhor $best';
  }

  @override
  String smReached(Object reached) {
    return 'Você chegou a $reached';
  }

  @override
  String get smRule1 => 'Observe os quadros acenderem um por um.';

  @override
  String get smRule2 => 'Repita exatamente a mesma ordem tocando nos quadros.';

  @override
  String get smRule3 =>
      'Cada rodada adiciona mais um passo — veja até onde você chega.';

  @override
  String smRound(Object round) {
    return 'Rodada $round';
  }

  @override
  String get safetyScreenTitle => 'Isto é certo para mim?';

  @override
  String get safetyPracticeTitle => 'O Rung é prática, não terapia.';

  @override
  String get safetyIntro =>
      'O Rung é uma ferramenta de confiança e prática. Ele ajuda você a encarar situações sociais do dia a dia gradualmente, no seu próprio ritmo. Não é terapia, nem tratamento médico, nem um diagnóstico.';

  @override
  String get safetyPoint1 =>
      'O objetivo é um receio administrável — sentir-se mais à vontade nos momentos que você costumava evitar. Não virar uma pessoa diferente.';

  @override
  String get safetyPoint2 =>
      'Pular sempre está tudo bem e nunca conta contra você. Aqui não há mecânicas de vergonha.';

  @override
  String get safetyPoint3 =>
      'Seus dados são seus. Tudo funciona offline, sem precisar de conta.';

  @override
  String get safetyMoreTitle => 'Se isto for mais do que nervosismo';

  @override
  String get safetyMoreBody =>
      'Se a ansiedade estiver afetando seriamente seu dia a dia, ou se você tiver pensamentos de se machucar, procure um profissional qualificado ou uma linha de apoio em crise local. Esse é um passo forte e saudável — e o Rung não substitui isso.';

  @override
  String get legalLastUpdated => 'Última atualização: junho de 2026';

  @override
  String legalQuestions(String email) {
    return 'Dúvidas? Fale conosco em $email.';
  }

  @override
  String get privacyTitle => 'Política de Privacidade';

  @override
  String get privacyIntro =>
      'O Rung é uma ferramenta privada de prática para ganhar confiança social. Coletamos o mínimo possível, e as coisas mais pessoais que você escreve nunca saem do seu telefone. Esta política explica o que guardamos e por quê.';

  @override
  String get ppWhatStaysHead => 'O que fica só no seu dispositivo';

  @override
  String get ppWhatStaysBody =>
      'Suas notas de reflexão e de previsão — as coisas privadas que você escreve sobre como um momento foi sentido — ficam guardadas apenas no app, no seu dispositivo. Elas nunca são enviadas aos nossos servidores.';

  @override
  String get ppCloudHead => 'O que guardamos na nuvem';

  @override
  String get ppCloudBody =>
      'Quando você cria uma conta, guardamos: seu endereço de e-mail (para login; sua senha é criptografada e nunca a vemos), um nome de exibição e uma bio opcionais, e sua configuração de bloqueio de privacidade. Para operar a comunidade («pods») guardamos as mensagens que você publica e quaisquer bloqueios ou denúncias que você faça. Para manter seu progresso seguro entre dispositivos, fazemos backup apenas de números — sua sequência, desafios concluídos e avaliações de ansiedade (prevista vs real) — além de quaisquer passos personalizados que você criar. O texto das notas nunca é incluído.';

  @override
  String get ppAnalyticsHead => 'Análise';

  @override
  String get ppAnalyticsBody =>
      'Usamos análise de produto que respeita a privacidade (PostHog) para entender quais recursos ajudam, usando eventos de uso anônimos como «abriu uma tela» ou «concluiu um passo». Nunca enviamos o conteúdo das suas notas ou mensagens para a análise.';

  @override
  String get ppUseHead => 'Como usamos suas informações';

  @override
  String get ppUseBody =>
      'Apenas para oferecer o app: fazer seu login, operar os pods, restaurar seu progresso e melhorar o Rung usando tendências agregadas e anônimas. Não vendemos seus dados nem os usamos para publicidade.';

  @override
  String get ppProcessHead => 'Quem processa seus dados';

  @override
  String get ppProcessBody =>
      'Usamos o Supabase (autenticação, banco de dados e hospedagem) e o PostHog (análise) como operadores de dados. Eles tratam os dados em nosso nome sob seus próprios compromissos de segurança e privacidade.';

  @override
  String get ppRightsHead => 'Seus direitos e escolhas';

  @override
  String get ppRightsBody =>
      'Você pode editar seu perfil, bloqueá-lo para que outros membros não o vejam, e excluir permanentemente sua conta e todos os dados associados na nuvem a qualquer momento em Perfil → Excluir conta. Você também pode nos enviar um e-mail para solicitar acesso ou a exclusão dos seus dados.';

  @override
  String get ppSecurityHead => 'Segurança e retenção';

  @override
  String get ppSecurityBody =>
      'Os dados são criptografados em trânsito, e cada tabela é protegida por segurança em nível de linha, de modo que você só possa acessar seus próprios dados (e mensagens de pods dos quais é membro). Guardamos seus dados até você excluir sua conta ou nos pedir para removê-los.';

  @override
  String get ppChildrenHead => 'Crianças';

  @override
  String get ppChildrenBody =>
      'O Rung não é destinado a menores de 16 anos. Se você acredita que uma criança criou uma conta, entre em contato conosco e a removeremos.';

  @override
  String get ppMedicalHead => 'Não é atendimento médico';

  @override
  String get ppMedicalBody =>
      'O Rung apoia a prática gradual, mas não é terapia, diagnóstico ou aconselhamento médico. Se você estiver em crise, contate os serviços de emergência locais ou uma linha de apoio em crise.';

  @override
  String get ppChangesHead => 'Alterações';

  @override
  String get ppChangesBody =>
      'Se atualizarmos esta política, mudaremos a data acima e, para alterações relevantes, avisaremos você no app.';

  @override
  String get termsTitle => 'Termos de Serviço';

  @override
  String get termsIntro =>
      'Estes termos são o acordo entre você e o Rung quando você usa o app. Ao criar uma conta ou usar o Rung, você os aceita.';

  @override
  String get tosMedicalHead => 'Não é um serviço médico';

  @override
  String get tosMedicalBody =>
      'O Rung é uma ferramenta de autoajuda e prática, não terapia ou atendimento médico, e não substitui ajuda profissional. Não pode garantir nenhum resultado específico. Se você estiver em crise ou puder ferir a si mesmo ou a outros, contate imediatamente os serviços de emergência locais.';

  @override
  String get tosEligibilityHead => 'Elegibilidade';

  @override
  String get tosEligibilityBody =>
      'Você deve ter pelo menos 16 anos para usar o Rung e ter o direito de aceitar estes termos.';

  @override
  String get tosAccountHead => 'Sua conta';

  @override
  String get tosAccountBody =>
      'Mantenha seus dados de login seguros — você é responsável pela atividade na sua conta. Avise-nos prontamente se suspeitar de uso não autorizado.';

  @override
  String get tosCommunityHead => 'Regras da comunidade (pods)';

  @override
  String get tosCommunityBody =>
      'Os pods são para gentileza e apoio. Você concorda em não assediar, ameaçar, humilhar, enviar spam ou publicar conteúdo de ódio ou ilegal, e em não compartilhar informações privadas de outras pessoas. Podemos remover conteúdo ou suspender contas que quebrem estas regras. Você pode bloquear e denunciar outros membros a qualquer momento.';

  @override
  String get tosContentHead => 'Conteúdo que você publica';

  @override
  String get tosContentBody =>
      'Você mantém a propriedade do que escreve. Ao publicar em um pod, você nos concede permissão para armazená-lo e mostrá-lo aos membros daquele pod para que a comunidade funcione. Não publique nada que você não tenha o direito de compartilhar.';

  @override
  String get tosSubsHead => 'Assinaturas';

  @override
  String get tosSubsBody =>
      'Alguns recursos e conteúdo extra de prática estão disponíveis com uma assinatura paga. Quando a cobrança estiver ativa, as compras e renovações são gerenciadas pela loja de aplicativos, e você pode gerenciar ou cancelar pela sua conta da loja. Os preços e o que está incluído podem mudar mediante aviso.';

  @override
  String get tosDisclaimerHead => 'Isenções e responsabilidade';

  @override
  String get tosDisclaimerBody =>
      'O Rung é fornecido «como está», sem garantias de qualquer tipo. Na extensão máxima permitida por lei, não somos responsáveis por perdas indiretas ou consequentes decorrentes do seu uso do app.';

  @override
  String get tosEndingHead => 'Encerrando seu uso';

  @override
  String get tosEndingBody =>
      'Você pode excluir sua conta a qualquer momento em Perfil → Excluir conta. Podemos suspender ou encerrar o acesso se estes termos forem grave ou repetidamente violados.';

  @override
  String get tosChangesHead => 'Alterações';

  @override
  String get tosChangesBody =>
      'Podemos atualizar estes termos; atualizaremos a data acima e, para alterações significativas, avisaremos você no app. Continuar usando o Rung significa que você aceita os termos atualizados.';

  @override
  String get breatheCta => 'Sentindo o receio? Respire primeiro';

  @override
  String get breatheIntro => 'Sessenta segundos. Apenas siga o círculo.';

  @override
  String get breatheIn => 'Inspire';

  @override
  String get breatheHold => 'Segure';

  @override
  String get breatheOut => 'Expire';

  @override
  String get breatheSkip => 'Pular';

  @override
  String get breatheDoneTitle => 'É isso.';

  @override
  String get breatheDoneSub =>
      'Sente-se um pouco mais firme? Faça seu passo quando estiver pronto.';

  @override
  String get breatheDoneBtn => 'Pronto';

  @override
  String get insightsDeeperTitle => 'Análises mais profundas';

  @override
  String get insightsLockedBody =>
      'Veja seu mês num relance — o quanto seu medo foi mais intenso que a realidade, e com que frequência você o superestimou. Uma vantagem Premium.';

  @override
  String get insightsUnlockCta => 'Desbloquear com Premium';

  @override
  String get insightsNoSteps =>
      'Nenhum passo registrado ainda neste mês. Encare alguns e seu resumo aparecerá aqui.';

  @override
  String get insightsFearsFacedMonth => 'medos encarados neste mês';

  @override
  String insightsGapHotter(String points) {
    return 'Seu medo foi $points pontos mais intenso que a realidade, em média.';
  }

  @override
  String get insightsGapTougher =>
      'A realidade foi um pouco mais dura do que você previu neste mês — isso também é um dado corajoso.';

  @override
  String get insightsGapSpotOn =>
      'Suas previsões estiveram bem certeiras neste mês.';

  @override
  String insightsOverPredicted(int rate) {
    return 'Você superestimou o medo em $rate% das vezes.';
  }

  @override
  String get insightsTrendSame => 'Igual ao mês passado';

  @override
  String insightsTrendMore(int count) {
    return '$count a mais que no mês passado';
  }

  @override
  String insightsTrendFewer(int count) {
    return '$count a menos que no mês passado';
  }

  @override
  String get rateTitle => 'Curtindo o Rung?';

  @override
  String get ratePromptNone => 'Como o Rung está sendo para você?';

  @override
  String get ratePromptLow =>
      'Sentimos que não esteja funcionando. O que está faltando?';

  @override
  String get ratePromptMid => 'Obrigado — o que faria virar um 5?';

  @override
  String get ratePromptHigh => 'Isso significa muito. O que você mais gosta?';

  @override
  String get rateHintLove => 'Algo que você adora? (opcional)';

  @override
  String get rateHintMore => 'Conte mais (opcional)';

  @override
  String get rateSend => 'Enviar';

  @override
  String get rateThanksHigh => 'Obrigado — ajuda de verdade. 🌱';

  @override
  String get rateThanksLow =>
      'Obrigado pela sinceridade — vamos usá-la para melhorar.';

  @override
  String get editProfileTitle => 'Editar perfil';

  @override
  String get editDisplayName => 'Nome de exibição';

  @override
  String get editDisplayNameHint => 'Como os pods devem te chamar?';

  @override
  String get editBio => 'Bio curta (opcional)';

  @override
  String get editBioHint =>
      'Uma linha sobre você — fica privada se você bloquear seu perfil.';

  @override
  String get errorOffline =>
      'Você está offline. Conecte-se à internet e tente novamente.';

  @override
  String get errorGeneric => 'Algo deu errado. Tente novamente.';

  @override
  String get errorSaveFailed =>
      'Não foi possível salvar — seu dispositivo pode estar com pouco espaço. Libere espaço e tente novamente.';
}

/// The translations for Portuguese, as used in Portugal (`pt_PT`).
class AppLocalizationsPtPt extends AppLocalizationsPt {
  AppLocalizationsPtPt() : super('pt_PT');

  @override
  String get navHome => 'Início';

  @override
  String get navGroups => 'Grupos';

  @override
  String get navPremium => 'Premium';

  @override
  String get navProfile => 'Perfil';

  @override
  String get greetingMorning => 'Bom dia';

  @override
  String get greetingAfternoon => 'Boa tarde';

  @override
  String get greetingEvening => 'Boa noite';

  @override
  String get todayStepIntro => 'Aqui está um pequeno passo para hoje.';

  @override
  String get commonContinue => 'Continuar';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonDone => 'Concluído';

  @override
  String get commonNotNow => 'Agora não';

  @override
  String get profileTitle => 'Perfil';

  @override
  String get language => 'Idioma';

  @override
  String get languageSystemDefault => 'Idioma do sistema';

  @override
  String get yourTone => 'O teu tom';

  @override
  String get appearance => 'Aspeto';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';

  @override
  String get onbSkip => 'Saltar';

  @override
  String get onbWelcomeTitle =>
      'Enfrenta os momentos que costumavas temer — um pequeno passo de cada vez.';

  @override
  String get onbWelcomeBody =>
      'O Rung ajuda-te a ganhar confiança social com prática suave e privada. Prevê, fá-lo, reflete — e vê os teus piores receios desfazerem-se nos teus próprios números.';

  @override
  String get onbGetStarted => 'Começar';

  @override
  String get onbSafetyTitle => 'Prática, não terapia.';

  @override
  String get onbUnderstand => 'Compreendo';

  @override
  String get onbSafetyBody1 =>
      'O Rung é uma ferramenta de confiança e prática — não é terapia, nem tratamento médico, nem um diagnóstico.';

  @override
  String get onbSafetyBody2 =>
      'O objetivo é sentires-te mais à vontade em momentos que costumavas temer — não tornares-te alguém que não és. Saltar é sempre válido.';

  @override
  String get onbSafetyCrisis =>
      'Se a ansiedade estiver a afetar gravemente a tua vida, ou se alguma vez tiveres pensamentos de te magoares, contacta um profissional ou uma linha de apoio em crise local.';

  @override
  String get onbFearTitle => 'Por onde gostarias de começar?';

  @override
  String get onbFearBody =>
      'É apenas uma sugestão de primeiro passo — podes subir qualquer um destes a qualquer momento. Nada aqui te compromete.';

  @override
  String get onbExploreOwn => 'Prefiro explorar por mim';

  @override
  String get onbToneTitle => 'Com qual te identificas mais?';

  @override
  String get onbToneIntrovertTitle => 'Sou mais introvertido';

  @override
  String get onbToneIntrovertBody =>
      'Quero sentir-me à vontade, não tornar-me uma pessoa diferente.';

  @override
  String get onbToneSituationalTitle => 'Fico ansioso em certas situações';

  @override
  String get onbToneSituationalBody =>
      'Às vezes sou extrovertido, mas certos momentos deixam-me atrapalhado.';

  @override
  String get onbToneFootnote => 'Podes alterar isto quando quiseres no Perfil.';

  @override
  String get onbHowTitle => 'Eis como funciona.';

  @override
  String get onbStartClimbing => 'Começar a subir';

  @override
  String get onbStep1 => 'Prevê quão difícil vai parecer (0–10).';

  @override
  String get onbStep2 =>
      'Vai fazê-lo na vida real — a aplicação pode ficar fechada.';

  @override
  String get onbStep3 => 'Volta e regista como correu realmente.';

  @override
  String get onbGentleFirstStep => 'UM PRIMEIRO PASSO SUAVE';

  @override
  String get onbGoodPlaceToStart => 'UM BOM SÍTIO PARA COMEÇAR';

  @override
  String get onbAllAreas =>
      'As seis áreas estão no teu ecrã inicial — começa onde quiseres.';

  @override
  String get predictAppBar => 'Antes de ires';

  @override
  String get predictSaved =>
      'Guardado. Vai fazê-lo — depois volta para registares como correu.';

  @override
  String get predictQuestion => 'Quão difícil achas que vai ser?';

  @override
  String get predictNoteLabel => 'O que prevês que aconteça? (opcional)';

  @override
  String get predictNoteHint => 'p. ex. Vão achar que sou desajeitado';

  @override
  String get predictCompare =>
      'Vamos comparar isto com o que acontece realmente. Essa diferença é o essencial.';

  @override
  String get predictDoIt => 'Vou fazê-lo';

  @override
  String get reflectAppBar => 'Como correu?';

  @override
  String get reflectDidYouDoIt => 'Fizeste-o?';

  @override
  String get reflectHowAnxious => 'Quão ansioso te deixava só o pensamento?';

  @override
  String get reflectHowBad => 'Quão difícil foi, na realidade?';

  @override
  String get reflectNoteLabel => 'Algo que queiras recordar? (opcional)';

  @override
  String get reflectOutcomeDone => 'Feito';

  @override
  String get reflectOutcomePartial => 'Parcial';

  @override
  String get reflectOutcomeNotToday => 'Hoje não';

  @override
  String get resultQuietDelight => 'Uma alegria serena em cada passo.';

  @override
  String get resultBackToLadder => 'Voltar à escada';

  @override
  String resultGapHeadline(int predicted, int actual) {
    return 'Preparaste-te para $predicted. Ficou em $actual.';
  }

  @override
  String resultGapSub(int predicted, int actual) {
    return 'O teu coração preparou-se para um pesado $predicted, mas o mundo recebeu-te com um mais suave $actual. Vale a pena recordar.';
  }

  @override
  String get resultRightHeadline => 'Exatamente como previste.';

  @override
  String get resultRightSub =>
      'Acertaste — e ainda assim apareceste. É essa a vitória.';

  @override
  String get resultTougherHeadline =>
      'Mais difícil do que previas — e fizeste-o.';

  @override
  String get resultTougherSub =>
      'Alguns momentos exigem mais de nós. Aparecer mesmo assim é o essencial.';

  @override
  String get resultPredicted => 'Previsto';

  @override
  String get resultActual => 'Real';

  @override
  String resultLighter(int reduction) {
    return 'Este momento foi $reduction% mais leve do que temias';
  }

  @override
  String get resultSkippedHeadline => 'Registado — sem pressão.';

  @override
  String get resultSkippedSub =>
      '«Hoje não» é uma resposta perfeitamente válida. Este degrau continua aqui quando estiveres pronto.';

  @override
  String get resultWinCopied => 'Vitória copiada — cola-a onde quiseres.';

  @override
  String get resultCopyWin => 'Copiar a minha vitória';

  @override
  String resultShareText(String rung) {
    return 'Acabei de fazer algo que costumava evitar: $rung. Um pequeno degrau subido. 🪜 #Rung';
  }

  @override
  String get tracksTitle => 'Os teus percursos';

  @override
  String get tracksSubtitle => 'Pequenos passos rumo a uma grande confiança.';

  @override
  String get menuInsights => 'Análises';

  @override
  String get menuIsThisRight => 'Isto é adequado para mim?';

  @override
  String tracksRungsCount(int done, int total) {
    return '$done de $total degraus';
  }

  @override
  String tracksClimbedCount(int done, int total) {
    return '$done de $total subidos';
  }

  @override
  String get tracksContinueLabel => 'CONTINUA DE ONDE FICASTE';

  @override
  String get tracksNextStepLabel => 'O TEU PRÓXIMO PASSO';

  @override
  String get tracksLoadError => 'Não foi possível carregar os percursos.';

  @override
  String get todayResume => 'Continua de onde ficaste';

  @override
  String get todayNext => 'O teu próximo passo';

  @override
  String get todayVariety => 'Algo um pouco diferente';

  @override
  String get todayFresh => 'O teu ponto de partida';

  @override
  String get todayResumeCta => 'Terminar o registo';

  @override
  String get todayStartCta => 'Começar';

  @override
  String todayMinutes(int min) {
    return '~$min min';
  }

  @override
  String get dashShareTooltip => 'Partilhar o meu progresso';

  @override
  String get dashWeeklyGoal => 'Objetivo semanal';

  @override
  String dashStepsPerWeek(int count) {
    return '$count passos/semana';
  }

  @override
  String dashGoalPerWeek(int count) {
    return '$count/semana';
  }

  @override
  String dashWeeklyProgress(int done, int goal) {
    return '$done de $goal passos concluídos esta semana';
  }

  @override
  String get dashYourGrowth => 'O teu crescimento';

  @override
  String get dashTodayError =>
      'Não foi possível carregar o passo de hoje. Puxa para tentar de novo.';

  @override
  String get dashTodayAllClear =>
      'Concluíste tudo o que estava disponível — adiciona um degrau personalizado ou repete um para manteres a sequência.';

  @override
  String get dashTakeABreak => 'Faz uma pausa';

  @override
  String get dashTakeABreakSub =>
      'Uns jogos calmos — contra o telemóvel ou com um amigo.';

  @override
  String get ladderTitleFallback => 'Escada';

  @override
  String get ladderLoadError => 'Não foi possível carregar a escada.';

  @override
  String get ladderAddOwn => 'Adiciona o teu próprio degrau';

  @override
  String ladderOfClimbed(int total) {
    return 'de $total subidos';
  }

  @override
  String get detailLoadError => 'Não foi possível carregar.';

  @override
  String get detailNotExist => 'Este degrau já não existe.';

  @override
  String get detailWhatToDo => 'O que fazer';

  @override
  String get detailWhyHelps => 'Porque ajuda';

  @override
  String get detailPastAttempts => 'As tuas tentativas anteriores';

  @override
  String get detailDoThis => 'Vou fazer isto';

  @override
  String get detailReattempt =>
      'Voltar a tentar é encorajado — enriquece os teus dados.';

  @override
  String detailHistoryStat(int predicted, int actual) {
    return 'previsto $predicted · real $actual';
  }

  @override
  String customLimitPremium(int cap) {
    return 'Atingiste o limite deste mês de $cap degraus personalizados — é reposto no próximo mês.';
  }

  @override
  String get customLimitFree =>
      'O plano gratuito inclui 5 degraus personalizados — faz upgrade para teres mais todos os meses.';

  @override
  String get customDefaultWhat => 'Um desafio que colocas a ti mesmo.';

  @override
  String get customDefaultWhy =>
      'Foste tu que lhe deste nome — é isso que o torna importante.';

  @override
  String get customSubtitle =>
      'A tua situação é específica — este degrau é só para ti.';

  @override
  String get customWhatLabel => 'O que vais fazer?';

  @override
  String get customWhatHint => 'p. ex. Pedir feedback à minha chefia';

  @override
  String get customNoteLabel => 'Uma nota para ti (opcional)';

  @override
  String customDifficulty(int value) {
    return 'Quão difícil te parece? $value/10';
  }

  @override
  String get customAddToLadder => 'Adicionar à escada';

  @override
  String get paywallSwitchToFree => 'Mudar para Gratuito';

  @override
  String get paywallHeroTitle => 'Não tens de enfrentar isto sozinho.';

  @override
  String get paywallHeroBody =>
      'A prática diária é sempre gratuita. O Premium acrescenta um treinador privado do teu lado — e uma comunidade maior a acompanhar-te — para quando estiveres pronto para ir mais longe.';

  @override
  String get paywallWhatsIncluded => 'O que está incluído';

  @override
  String get paywallPlusHeader => 'Além disso, cada subscritor recebe';

  @override
  String get paywallBenefitCoach =>
      'Um treinador privado, a qualquer hora — ensaia algo que aí vem ou conversa sobre como correu';

  @override
  String get paywallBenefitPods =>
      'Não estás a fazer isto sozinho — junta-te a mais grupos de apoio (3 no mensal, ilimitados no anual)';

  @override
  String get paywallBenefitCustom =>
      'Constrói escadas ilimitadas só tuas — sem limite de degraus personalizados';

  @override
  String get paywallBenefitDepth =>
      'Vai mais fundo quando estiveres pronto — até 40 passos por percurso (o gratuito é um arco completo de 10 passos)';

  @override
  String get paywallPlusStreak =>
      'Proteção da sequência — um dia falhado não quebra a tua sequência';

  @override
  String get paywallPlusInsights =>
      'Análises mais profundas — o teu mês num relance';

  @override
  String get paywallPlusShare => 'Estilos pessoais para os cartões de partilha';

  @override
  String get paywallPlusPrivacy => 'Sempre privado, sempre sem publicidade';

  @override
  String get paywallYearly => 'Anual';

  @override
  String get paywallPerYear => 'por ano · melhor valor';

  @override
  String get paywallSave => 'Poupa 33%';

  @override
  String get paywallMonthly => 'Mensal';

  @override
  String get paywallPerMonth => 'por mês';

  @override
  String get paywallSwitchYearly => 'Mudar para anual';

  @override
  String get paywallSwitchMonthly => 'Mudar para mensal';

  @override
  String paywallStartYearly(String price) {
    return 'Começar anual — $price';
  }

  @override
  String paywallStartMonthly(String price) {
    return 'Começar mensal — $price';
  }

  @override
  String get paywallRestore => 'Restaurar compras';

  @override
  String paywallCurrentPlan(String plan) {
    return 'Plano atual: $plan. Cancela quando quiseres.';
  }

  @override
  String get paywallCancelAnytime =>
      'Cancela quando quiseres. O essencial mantém-se gratuito para sempre.';

  @override
  String get paywallSimulated =>
      'Premium ativo (simulado — adiciona as chaves RevenueCat para compras reais).';

  @override
  String get paywallPlanUnavailable =>
      'Esse plano não está disponível de momento. Tenta novamente daqui a pouco.';

  @override
  String get paywallThankYou => 'Premium ativo — obrigado. 🌱';

  @override
  String get paywallPurchaseFailed =>
      'A compra não foi concluída. Não te foi cobrado nada.';

  @override
  String get paywallRestored => 'Compras restauradas.';

  @override
  String get paywallNoRestore =>
      'Não foram encontradas compras anteriores nesta conta.';

  @override
  String get paywallRestoreFailed =>
      'Não foi possível restaurar agora. Tenta novamente daqui a pouco.';

  @override
  String get profileAddName => 'Adiciona o teu nome';

  @override
  String get profileLockTitle => 'Bloquear o meu perfil';

  @override
  String get profileLockedSub =>
      'Oculto — os membros do grupo não podem abrir os teus detalhes.';

  @override
  String get profileUnlockedSub =>
      'Os membros do grupo podem tocar no teu avatar para ver os teus detalhes.';

  @override
  String get profilePlanTitle => 'O teu plano';

  @override
  String get profilePremium => 'Premium';

  @override
  String get profileUpgrade => 'Fazer upgrade';

  @override
  String get profileToneDesc =>
      'O Rung fala com suavidade por predefinição. Se a tua ansiedade for mais situacional, um tom ligeiramente mais firme pode assentar-te melhor.';

  @override
  String get profileToneIntrovert => 'Introvertido';

  @override
  String get profileToneSituational => 'Situacional';

  @override
  String get profileSafetySub =>
      'Como o Rung se enquadra — e quando procurar mais';

  @override
  String get profileBlockedTitle => 'Membros bloqueados';

  @override
  String get profileBlockedSub => 'Vê e desbloqueia as pessoas que bloqueaste';

  @override
  String get profileRestoreTitle => 'Restaurar o meu progresso';

  @override
  String get profileRestoreSub => 'Traz a tua sequência e desafios da nuvem';

  @override
  String get profileRestoring => 'A restaurar…';

  @override
  String get profileRestoreOk => 'Progresso restaurado a partir da nuvem.';

  @override
  String profileRestoreFail(String error) {
    return 'Falha ao restaurar: $error';
  }

  @override
  String get profileLogout => 'Terminar sessão';

  @override
  String get profileSignedIn => 'Sessão iniciada';

  @override
  String get profileLogoutConfirmTitle => 'Terminar sessão?';

  @override
  String get profileLogoutConfirmBody =>
      'O teu progresso está guardado na nuvem e regressa quando iniciares sessão novamente.';

  @override
  String get profileLoggingOut => 'A terminar sessão…';

  @override
  String get profileRateTitle => 'Avaliar o Rung';

  @override
  String get profileRateSub => 'Diz-nos como está a correr — ajuda mesmo';

  @override
  String get profilePrivacyTitle => 'Política de Privacidade';

  @override
  String get profilePrivacySub =>
      'O que guardamos — e o que fica no teu dispositivo';

  @override
  String get profileTermsTitle => 'Termos de Serviço';

  @override
  String get profileTermsSub => 'O acordo para usares o Rung';

  @override
  String get profileDeleteTitle => 'Eliminar conta';

  @override
  String get profileDeleteSub =>
      'Apaga permanentemente a tua conta e os teus dados';

  @override
  String get profileFooter =>
      'Rung · prática, não terapia. Os teus dados são teus.';

  @override
  String get profileDeleteConfirmTitle => 'Eliminar conta?';

  @override
  String get profileDeleteConfirmBody =>
      'Isto elimina permanentemente a tua conta, as tuas mensagens nos grupos e o progresso guardado. Não pode ser anulado.';

  @override
  String get profileDelete => 'Eliminar';

  @override
  String get profileDeleting => 'A eliminar a tua conta…';

  @override
  String get profileDeleteFail =>
      'Não foi possível eliminar a tua conta. Tenta de novo.';

  @override
  String get profileBioPlaceholder => 'Um escalador silencioso.';

  @override
  String get profileHaptics => 'Vibração';

  @override
  String get profileHapticsSub => 'Vibração suave em toques e vitórias';

  @override
  String get profileNotifications => 'Notificações';

  @override
  String get profileNotificationsSub => 'Alertas do Rung neste dispositivo';

  @override
  String get profilePodAlerts => 'Alertas de mensagens dos grupos';

  @override
  String get profilePodAlertsSub =>
      'Avisa-me quando alguém publicar nos meus grupos';

  @override
  String get profileEnableNotifs =>
      'Ativa as notificações nas Definições para receberes lembretes.';

  @override
  String get profileReminderHelp => 'Quando devemos dar-te um empurrãozinho?';

  @override
  String get profileReminderTitle => 'Lembrete diário suave';

  @override
  String profileReminderOn(String time) {
    return 'Todos os dias às $time · toca no interruptor para desativar';
  }

  @override
  String get profileReminderOff =>
      'Um empurrãozinho calmo, sem culpa, para dares um pequeno passo';

  @override
  String get profileAvatarTitle => 'Escolhe o teu avatar';

  @override
  String get profileAvatarSub =>
      'Só tu o podes mudar — os teus colegas de grupo também o veem.';

  @override
  String get commonClose => 'Fechar';

  @override
  String get checkInMoodCalm => 'Calmo';

  @override
  String get checkInMoodOkay => 'Razoável';

  @override
  String get checkInMoodAnxious => 'Ansioso';

  @override
  String get checkInMoodLow => 'Em baixo';

  @override
  String get checkInMoodTense => 'Tenso';

  @override
  String get checkInTitle => 'Como chegas hoje?';

  @override
  String get checkInDismiss => 'Dispensar';

  @override
  String get checkInCalmCta => 'Experimenta um momento de calma';

  @override
  String get checkInStepCta => 'Ver o passo de hoje';

  @override
  String get supportTitle => 'Parece um grande peso para carregar.';

  @override
  String get supportBody =>
      'O Rung é uma ferramenta de prática, não um serviço de crise. Se estás a passar por algo pesado, procura alguém que te possa ajudar agora — uma pessoa de confiança ou uma linha de apoio em crise local. Mereces apoio a sério.';

  @override
  String get supportResources => 'Ver recursos de apoio';

  @override
  String get progressChallenges => 'Desafios';

  @override
  String get progressCurrentStreak => 'Sequência atual';

  @override
  String get progressBestStreak => 'Melhor sequência';

  @override
  String get progressThisWeek => 'Esta semana';

  @override
  String get progressCategoryBreakdown => 'Repartição por categoria';

  @override
  String get insightsHistory => 'Histórico';

  @override
  String checkInAckTitle(String mood) {
    return 'Registado — sentes-te $mood';
  }

  @override
  String get checkInAckGentle =>
      'Obrigado pela sinceridade. Vamos manter o dia suave — uma pequena coisa gentil é suficiente.';

  @override
  String get checkInAckStep =>
      'Muito bem. Quando estiveres pronto, um pequeno passo mantém o ritmo.';

  @override
  String get sharePremiumPerk =>
      '✨ Mais estilos de cartão são uma vantagem Premium.';

  @override
  String get shareSeePremium => 'Ver Premium';

  @override
  String get shareText =>
      'Pequenos passos corajosos, um degrau de cada vez. 🌱 #Rung';

  @override
  String get shareError => 'Não foi possível abrir a partilha. Tenta de novo.';

  @override
  String get shareTitle => 'Partilha o teu progresso';

  @override
  String get shareSubtitle => 'Apenas os teus números — nada privado.';

  @override
  String get shareCta => 'Partilhar';

  @override
  String get shareCardHeadline => 'Os meus passos corajosos';

  @override
  String get shareCardFearsFaced => 'receios enfrentados';

  @override
  String get shareCardCurrentStreak => 'Sequência atual';

  @override
  String get shareCardBestStreak => 'Melhor sequência';

  @override
  String get shareCardTagline =>
      'Enfrentar receios sociais, um pequeno degrau de cada vez.';

  @override
  String get helpNow => 'Ajuda agora';

  @override
  String get helpCalmMoment => 'Um momento de calma';

  @override
  String get helpTabBreathe => 'Respira';

  @override
  String get helpTabGround => 'Ancora-te';

  @override
  String get helpTabSay => 'Diz isto';

  @override
  String get helpBreatheIn => 'Inspira…';

  @override
  String get helpBreatheOut => 'Expira…';

  @override
  String get helpBreatheHint => 'Segue o círculo. Não há pressa.';

  @override
  String get helpGround5 => 'coisas que consegues ver';

  @override
  String get helpGround4 => 'coisas em que consegues tocar';

  @override
  String get helpGround3 => 'coisas que consegues ouvir';

  @override
  String get helpGround2 => 'coisas que consegues cheirar';

  @override
  String get helpGround1 => 'coisa que consegues saborear';

  @override
  String get helpGroundTitle => 'Nomeia, em silêncio para ti…';

  @override
  String get helpGroundHint =>
      'Isto traz-te de volta ao agora — onde estás em segurança.';

  @override
  String get helpOpener1 => 'Como conheces as pessoas aqui?';

  @override
  String get helpOpener2 => 'Adoro este sítio — já cá tinhas vindo?';

  @override
  String get helpOpener3 => 'Sou péssimo com nomes — podes relembrar-me o teu?';

  @override
  String get helpOpener4 => 'O que tens feito esta semana?';

  @override
  String get helpExit1 => 'Vou buscar uma bebida — foi bom falar contigo.';

  @override
  String get helpExit2 =>
      'Preciso de cumprimentar rapidamente uma pessoa, dás-me licença?';

  @override
  String get helpExit3 => 'Vou deixar-te conviver — até já.';

  @override
  String get helpOpenersTitle => 'Frases fáceis para iniciar';

  @override
  String get helpExitsTitle => 'Despedidas elegantes';

  @override
  String get authEnterEmail => 'Introduz o teu e-mail';

  @override
  String get authBadEmail => 'Esse e-mail não parece correto';

  @override
  String get authEnterPassword => 'Introduz uma palavra-passe';

  @override
  String get authMin6 => 'Pelo menos 6 caracteres';

  @override
  String get authPwMismatch => 'As palavras-passe não coincidem';

  @override
  String get authConfirmEmail =>
      'Verifica o teu e-mail para confirmar e depois inicia sessão. (Ou desativa a confirmação por e-mail nas definições do Supabase Auth para testes rápidos.)';

  @override
  String get authGenericError => 'Algo correu mal. Tenta de novo.';

  @override
  String get authCreateTitle => 'Cria a tua conta';

  @override
  String get authWelcomeBack => 'Bem-vindo de volta';

  @override
  String get authSignUpSub =>
      'Junta-te aos grupos e mantém o teu progresso seguro em todos os dispositivos.';

  @override
  String get authSignInSub =>
      'Inicia sessão nos teus grupos e no progresso sincronizado.';

  @override
  String get authDisplayName => 'Nome a apresentar (opcional)';

  @override
  String get authEmail => 'E-mail';

  @override
  String get authPassword => 'Palavra-passe';

  @override
  String get authShowPassword => 'Mostrar palavra-passe';

  @override
  String get authHidePassword => 'Ocultar palavra-passe';

  @override
  String get authConfirmPassword => 'Confirmar palavra-passe';

  @override
  String get authCreateCta => 'Criar conta';

  @override
  String get authSignInCta => 'Iniciar sessão';

  @override
  String get authHaveAccount => 'Já tenho uma conta';

  @override
  String get authNewAccount => 'Sou novo — criar uma conta';

  @override
  String get authLegalPrefixSignUp =>
      'Ao criares uma conta concordas com os nossos ';

  @override
  String get authLegalPrefixSignIn => 'Ao continuares concordas com os nossos ';

  @override
  String get authTerms => 'Termos';

  @override
  String get authAnd => ' e ';

  @override
  String get gamesIntro =>
      'Jogos calmos para foco e uma mente serena — o tipo de treino mental que as pessoas acham reconfortante. Joga contra o telemóvel ou passa-o a um amigo.';

  @override
  String gamesBestMs(int ms) {
    return 'Melhor $ms ms';
  }

  @override
  String gamesBestLevel(int level) {
    return 'Melhor nível $level';
  }

  @override
  String gamesBest(String score) {
    return 'Melhor $score';
  }

  @override
  String gamesBestMoves(int moves) {
    return 'Melhor $moves jogadas';
  }

  @override
  String gamesWinsVsPhone(int count) {
    return '$count vitórias contra o telemóvel';
  }

  @override
  String get gameTitleReaction => 'Velocidade de reação';

  @override
  String get gameTitleSequence => 'Memória de sequências';

  @override
  String get gameTitleQuickMath => 'Cálculo rápido';

  @override
  String get gameTitleMemory => 'Jogo da memória';

  @override
  String get gameSubReaction => 'foco · toca quando ficar verde';

  @override
  String get gameSubSequence => 'memória · observa e repete';

  @override
  String get gameSub2048 => 'estratégia · desliza para juntar';

  @override
  String get gameSubQuickMath => 'cálculo mental · sprint de 30 segundos';

  @override
  String get gameSubTicTacToe => 'contra o telemóvel · ou 2 jogadores';

  @override
  String get gameSubConnect4 => 'contra o telemóvel · ou 2 jogadores';

  @override
  String get gameSubMemory => 'a solo · encontra os pares';

  @override
  String get gameHelpTooltip => 'Como jogar';

  @override
  String gameHelpTitle(String game) {
    return 'Como jogar · $game';
  }

  @override
  String get gameGotIt => 'Percebi';

  @override
  String get tierFree => 'Gratuito';

  @override
  String get tierMonthly => 'Premium · Mensal';

  @override
  String get tierYearly => 'Premium · Anual';

  @override
  String get podsUnlimited => 'grupos ilimitados';

  @override
  String podsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count grupos',
      one: '1 grupo',
    );
    return '$_temp0';
  }

  @override
  String get groupsSignedOutTitle => 'Junta-te a um grupo pequeno e gentil';

  @override
  String get groupsSignedOutBody =>
      'Os grupos precisam de uma conta rápida para serem seguros e teus. A tua prática mantém-se privada e sem conta.';

  @override
  String get groupsSignInCta => 'Inicia sessão para continuar';

  @override
  String get groupsLoadError =>
      'Não foi possível carregar os grupos. Puxa para tentar de novo.';

  @override
  String groupsJoined(String pod) {
    return 'Entraste em $pod. Diz olá quando estiveres pronto.';
  }

  @override
  String get groupsJoinedNew =>
      'Entraste num novo grupo. Diz olá quando estiveres pronto.';

  @override
  String get groupsNoPodFound =>
      'Não foi possível encontrar um grupo agora. Tenta de novo.';

  @override
  String groupsLeaveTitle(String pod) {
    return 'Sair de $pod?';
  }

  @override
  String get groupsLeave => 'Sair';

  @override
  String groupsLeft(String pod) {
    return 'Saíste de $pod.';
  }

  @override
  String get groupsLeaveError =>
      'Não foi possível sair do grupo. Tenta de novo.';

  @override
  String get groupsHeader => 'Grupos pequenos, pessoas gentis';

  @override
  String get groupsYourPods => 'OS TEUS GRUPOS';

  @override
  String get groupsDiscoverPods => 'DESCOBRIR GRUPOS';

  @override
  String get groupsJoinAnother => 'Junta-te a outro grupo';

  @override
  String get groupsNoOthers =>
      'Não há outros grupos para entrares neste momento.';

  @override
  String groupsJoinedShort(String pod) {
    return 'Entraste em $pod.';
  }

  @override
  String get groupsJoin => 'Entrar';

  @override
  String get groupsPodOptions => 'Opções do grupo';

  @override
  String get groupsLeavePod => 'Sair do grupo';

  @override
  String groupsMembers(int count, int capacity) {
    return '$count/$capacity membros';
  }

  @override
  String groupsTierPods(String tier, String pods) {
    return 'Com $tier podes pertencer a $pods.';
  }

  @override
  String groupsCapacityTierPods(int capacity, String tier, String pods) {
    return 'Até $capacity por grupo. Com $tier podes pertencer a $pods.';
  }

  @override
  String groupsInYourPods(String pods) {
    return 'Estás nos teus $pods';
  }

  @override
  String get groupsUpgradeBody =>
      'Passa a Premium para entrares em mais — o mensal desbloqueia 3 grupos, o anual tantos quantos quiseres.';

  @override
  String get groupsSafetyLive =>
      'Sê gentil. Podes denunciar ou bloquear qualquer pessoa a partir do perfil dela. Os perfis bloqueados mantêm-se privados.';

  @override
  String get groupsSafetyPreview =>
      'Pré-visualização. Os grupos tornam-se conversas reais e moderadas assim que o início de sessão estiver configurado.';

  @override
  String get groupsLeaveBody =>
      'Deixarás de ver as mensagens deste grupo. Podes voltar a entrar mais tarde.';

  @override
  String get podRulesTitle => 'Regras do grupo';

  @override
  String get podRulesIntro =>
      'Os grupos só funcionam se todos se sentirem seguros. Ao entrares, concordas:';

  @override
  String get podRule1 =>
      'Sê gentil. Toda a gente aqui está a praticar algo difícil.';

  @override
  String get podRule2 => 'Sem assédio, ódio ou conteúdo nocivo. Nunca.';

  @override
  String get podRule3 => 'Denuncia ou bloqueia quem te deixe desconfortável.';

  @override
  String get podRule4 =>
      'Respeita a privacidade — o que se partilha aqui fica aqui.';

  @override
  String get podRule5 =>
      'Os grupos são apoio entre pares, não um serviço de crise. Numa emergência, contacta um profissional ou uma linha de apoio em crise local.';

  @override
  String get podRulesAgree => 'Concordo — deixa-me entrar';

  @override
  String chatIntrosBeKind(int count, int capacity) {
    return '$count/$capacity introvertidos · sê gentil';
  }

  @override
  String get chatHint => 'Diz algo gentil…';

  @override
  String get chatPreviewBanner =>
      'Pré-visualização · por agora as mensagens ficam no teu dispositivo. Os grupos reais e moderados chegam com as contas.';

  @override
  String get chatYou => 'Tu';

  @override
  String get reportHarassment => 'Assédio ou bullying';

  @override
  String get reportHate => 'Ódio ou linguagem nociva';

  @override
  String get reportSpam => 'Spam ou burla';

  @override
  String get reportUnsafe => 'Faz-me sentir inseguro';

  @override
  String get reportOther => 'Outra coisa';

  @override
  String get memberPrivateTitle => 'Perfil privado';

  @override
  String get memberPrivateBody =>
      'Este membro mantém o perfil privado. Ainda podes conversar com ele — e denunciar ou bloquear, se for preciso.';

  @override
  String memberStreak(int days) {
    return 'Sequência de $days dias';
  }

  @override
  String memberChallenges(int count) {
    return '$count desafios';
  }

  @override
  String memberClimbing(String track) {
    return 'A subir: $track';
  }

  @override
  String get memberReport => 'Denunciar';

  @override
  String get memberBlock => 'Bloquear';

  @override
  String get memberReportThanks => 'Obrigado — vamos analisar isto.';

  @override
  String get memberBlockToo => 'Bloquear também';

  @override
  String get memberBlocked => 'Bloqueado. Não verás as mensagens dele.';

  @override
  String get memberBlockError => 'Não foi possível bloquear. Tenta de novo.';

  @override
  String get memberReportError =>
      'Não foi possível enviar a denúncia. Tenta de novo.';

  @override
  String get memberBlockConfirmTitle => 'Bloquear este membro?';

  @override
  String get memberBlockConfirmBody =>
      'Não verão as mensagens um do outro. Podes anular isto mais tarde.';

  @override
  String get memberSoonReporting =>
      'As denúncias ficam ativas nos grupos moderados (inicia sessão para as usares).';

  @override
  String get memberSoonBlocking =>
      'O bloqueio fica ativo nos grupos moderados (inicia sessão para o usares).';

  @override
  String get memberWhatsWrong => 'O que se passa?';

  @override
  String get memberFallback => 'Membro';

  @override
  String get blockedUnblockError =>
      'Não foi possível desbloquear. Tenta de novo.';

  @override
  String blockedUnblocked(String name) {
    return 'Desbloqueaste $name. Voltarás a ver as mensagens dele.';
  }

  @override
  String get blockedIntro =>
      'Bloquear esconde as mensagens de um membro de ti — e as tuas dele, nos dois sentidos. Desbloqueia alguém abaixo para anular.';

  @override
  String get blockedLabel => 'Bloqueado';

  @override
  String get blockedUnblock => 'Desbloquear';

  @override
  String get blockedEmptyTitle => 'Ninguém bloqueado';

  @override
  String get blockedEmptyBody =>
      'Não bloqueaste ninguém. Bloquear esconde as mensagens de um membro de ti, nos dois sentidos — e podes sempre anular aqui.';

  @override
  String get chatCheckInPosted => 'Bom trabalho. Registo no grupo publicado.';

  @override
  String get chatCheckInError =>
      'Não foi possível registar agora. Tenta de novo.';

  @override
  String get chatDeleteMsgTitle => 'Eliminar mensagem?';

  @override
  String get chatDeleteMsgBody => 'Isto remove-a para todos no grupo.';

  @override
  String get chatReply => 'Responder';

  @override
  String get chatEdit => 'Editar';

  @override
  String get chatDailyPrompt => 'Sugestão diária do grupo';

  @override
  String get chatCheckedInToday => 'Registado hoje';

  @override
  String get chatDidMyStep => 'Dei o meu passo';

  @override
  String chatCheckedInCount(int count) {
    return '$count registaram-se';
  }

  @override
  String get chatNoMessages =>
      'Ainda não há mensagens. Um simples «olá» é um corajoso primeiro degrau.';

  @override
  String get chatEditingMessage => 'A editar a tua mensagem';

  @override
  String chatReplyingTo(String name) {
    return 'A responder a $name';
  }

  @override
  String get chatYourself => 'ti próprio';

  @override
  String get chatMsgDeleted => 'Esta mensagem foi eliminada';

  @override
  String get chatPrivateMember => 'Membro privado';

  @override
  String chatBeKind(int count, int capacity) {
    return '$count/$capacity · sê gentil';
  }

  @override
  String get chatDeletedMessageShort => 'mensagem eliminada';

  @override
  String get gameYouWin => 'Ganhaste! 🎉';

  @override
  String get gamePhoneWins => 'O telemóvel ganha';

  @override
  String get gamePhoneThinking => 'O telemóvel está a pensar…';

  @override
  String get gamePlayPhone => 'Jogar contra o telemóvel';

  @override
  String get game2Players => '2 jogadores';

  @override
  String get gameNewGame => 'Novo jogo';

  @override
  String get gameYou => 'Tu';

  @override
  String get gamePhone => 'Telemóvel';

  @override
  String get gameDraws => 'Empates';

  @override
  String get tttP1Wins => 'O Jogador 1 (X) ganha! 🎉';

  @override
  String get tttP2Wins => 'O Jogador 2 (O) ganha! 🎉';

  @override
  String get tttYourTurn => 'É a tua vez';

  @override
  String get tttP1Turn => 'Jogador 1 · X';

  @override
  String get tttP2Turn => 'Jogador 2 · O';

  @override
  String get tttP1Label => 'J1 (X)';

  @override
  String get tttP2Label => 'J2 (O)';

  @override
  String get tttRule1 => 'Alternem a colocar a vossa marca na grelha 3×3.';

  @override
  String get tttRule2 =>
      'Alinha três marcas tuas — na horizontal, vertical ou diagonal — para ganhares.';

  @override
  String get tttRule3 =>
      '«Jogar contra o telemóvel» é tu contra uma IA simples. «2 jogadores» passa o telemóvel a cada vez.';

  @override
  String get c4P1Wins => 'O Jogador 1 ganha! 🎉';

  @override
  String get c4P2Wins => 'O Jogador 2 ganha! 🎉';

  @override
  String get c4Turn => 'É a tua vez — toca numa coluna';

  @override
  String get c4P1Turn => 'Jogador 1 · vermelho';

  @override
  String get c4P2Turn => 'Jogador 2 · amarelo';

  @override
  String get c4P1Label => 'J1';

  @override
  String get c4P2Label => 'J2';

  @override
  String get c4Rule1 =>
      'Toca numa coluna para largares a tua peça — cai para o espaço livre mais baixo.';

  @override
  String get c4Rule2 =>
      'Alinha quatro peças da tua cor — na horizontal, vertical ou diagonal — para ganhares.';

  @override
  String get c4Rule3 =>
      '«Jogar contra o telemóvel» é tu contra uma IA simples. «2 jogadores» passa o telemóvel.';

  @override
  String get gameDraw => 'É um empate 🤝';

  @override
  String get gamePlayAgain => 'Jogar de novo';

  @override
  String get gameStart => 'Começar';

  @override
  String get g2048Rule1 =>
      'Desliza para cima, baixo, esquerda ou direita para moveres todas as peças.';

  @override
  String get g2048Rule2 =>
      'Duas peças com o mesmo número juntam-se numa que duplica.';

  @override
  String get g2048Rule3 =>
      'Continua a juntar para construíres uma peça 2048. O tabuleiro enche-se — planeia com antecedência!';

  @override
  String get g2048Score => 'Pontuação';

  @override
  String get g2048Best => 'Melhor';

  @override
  String get g2048GameOver => 'Fim do jogo';

  @override
  String get g2048Won => 'Chegaste a 2048! 🎉';

  @override
  String get g2048SwipeToMerge => 'Desliza para juntar';

  @override
  String get qmRule1 => 'Tens 30 segundos — resolve quantos conseguires.';

  @override
  String get qmRule2 => 'Toca na resposta certa entre as quatro opções.';

  @override
  String get qmRule3 =>
      'Um toque errado custa 2 segundos, por isso lê com atenção.';

  @override
  String qmTimeScored(Object score) {
    return 'Tempo! Fizeste $score';
  }

  @override
  String qmBestSub(Object best) {
    return 'Melhor $best · 30 segundos, responde a quantos conseguires.';
  }

  @override
  String get qmStartSub => '30 segundos. Um toque errado custa 2 segundos.';

  @override
  String get qmCorrect => 'certas';

  @override
  String get mmRule1 =>
      'Toca numa carta para a virares e depois vira uma segunda.';

  @override
  String get mmRule2 =>
      'Se os dois emojis coincidirem, ficam virados para cima; se não, voltam a virar-se.';

  @override
  String get mmRule3 =>
      'Encontra todos os pares — no menor número de jogadas possível.';

  @override
  String mmAllMatched(Object moves) {
    return 'Todos os pares em $moves jogadas! 🎉';
  }

  @override
  String mmFindPairs(Object moves) {
    return 'Encontra os pares · $moves jogadas';
  }

  @override
  String mmBest(Object best) {
    return 'Melhor: $best jogadas';
  }

  @override
  String get mmShuffle => 'Baralhar';

  @override
  String get rxTapStart => 'Toca para começar';

  @override
  String get rxWaitGreen => 'Espera pelo verde e depois toca depressa';

  @override
  String get rxWait => 'Espera…';

  @override
  String get rxTapMoment => 'Toca no momento em que ficar verde';

  @override
  String rxBestRetry(Object ms) {
    return 'Melhor $ms ms · toca para repetir';
  }

  @override
  String get rxTapRetry => 'Toca para repetir';

  @override
  String get rxTooSoon => 'Cedo demais!';

  @override
  String get rxWaitRetry => 'Espera pelo verde · toca para repetir';

  @override
  String get rxTap => 'TOCA!';

  @override
  String get rxRule1 =>
      'Toca no ecrã para começar e depois espera — vai ficar âmbar.';

  @override
  String get rxRule2 =>
      'No instante em que ficar verde, toca o mais depressa que conseguires.';

  @override
  String get rxRule3 =>
      'Tocar cedo demais reinicia. Um tempo mais baixo (ms) é melhor.';

  @override
  String get smWatchRepeat => 'Observa o padrão e depois repete-o.';

  @override
  String get smWatch => 'Observa…';

  @override
  String smYourTurn(Object current, Object total) {
    return 'É a tua vez · $current de $total';
  }

  @override
  String smReachedBest(Object best, Object reached) {
    return 'Chegaste a $reached · melhor $best';
  }

  @override
  String smReached(Object reached) {
    return 'Chegaste a $reached';
  }

  @override
  String get smRule1 => 'Observa as peças a acenderem-se uma a uma.';

  @override
  String get smRule2 => 'Repete exatamente a mesma ordem tocando nas peças.';

  @override
  String get smRule3 =>
      'Cada ronda acrescenta mais um passo — vê até onde consegues ir.';

  @override
  String smRound(Object round) {
    return 'Ronda $round';
  }

  @override
  String get safetyScreenTitle => 'Isto é adequado para mim?';

  @override
  String get safetyPracticeTitle => 'O Rung é prática, não terapia.';

  @override
  String get safetyIntro =>
      'O Rung é uma ferramenta de confiança e prática. Ajuda-te a enfrentar gradualmente situações sociais do dia a dia, ao teu ritmo. Não é terapia, nem tratamento médico, nem um diagnóstico.';

  @override
  String get safetyPoint1 =>
      'O objetivo é um receio gerível — sentires-te mais à vontade nos momentos que costumavas evitar. Não tornares-te uma pessoa diferente.';

  @override
  String get safetyPoint2 =>
      'Saltar é sempre válido e nunca conta contra ti. Aqui não há mecanismos de vergonha.';

  @override
  String get safetyPoint3 =>
      'Os teus dados são teus. Tudo funciona offline, sem ser necessária uma conta.';

  @override
  String get safetyMoreTitle => 'Se isto for mais do que nervosismo';

  @override
  String get safetyMoreBody =>
      'Se a ansiedade estiver a afetar gravemente o teu dia a dia, ou se alguma vez tiveres pensamentos de te magoares, contacta um profissional qualificado ou uma linha de apoio em crise local. É um passo forte e saudável — e o Rung não o substitui.';

  @override
  String get legalLastUpdated => 'Última atualização: junho de 2026';

  @override
  String legalQuestions(String email) {
    return 'Dúvidas? Contacta-nos em $email.';
  }

  @override
  String get privacyTitle => 'Política de Privacidade';

  @override
  String get privacyIntro =>
      'O Rung é uma ferramenta de prática privada para ganhares confiança social. Recolhemos o mínimo possível, e as coisas mais pessoais que escreves nunca saem do teu telemóvel. Esta política explica o que guardamos e porquê.';

  @override
  String get ppWhatStaysHead => 'O que fica apenas no teu dispositivo';

  @override
  String get ppWhatStaysBody =>
      'As tuas notas de reflexão e de previsão — as coisas privadas que escreves sobre como sentiste um momento — são guardadas apenas na aplicação, no teu dispositivo. Nunca são enviadas para os nossos servidores.';

  @override
  String get ppCloudHead => 'O que guardamos na nuvem';

  @override
  String get ppCloudBody =>
      'Quando crias uma conta guardamos: o teu endereço de e-mail (para iniciares sessão; a tua palavra-passe é encriptada e nunca a vemos), um nome a apresentar e uma biografia opcionais, e a tua definição de bloqueio de privacidade. Para gerir a comunidade («grupos») guardamos as mensagens que publicas e quaisquer bloqueios ou denúncias que faças. Para manter o teu progresso seguro entre dispositivos, fazemos cópia apenas de números — a tua sequência, os desafios concluídos e as avaliações de ansiedade (prevista vs real) — além de quaisquer degraus personalizados que cries. O texto das notas nunca é incluído.';

  @override
  String get ppAnalyticsHead => 'Análise';

  @override
  String get ppAnalyticsBody =>
      'Usamos análise de produto que respeita a privacidade (PostHog) para percebermos que funcionalidades ajudam, através de eventos de utilização anónimos como «abriu um ecrã» ou «concluiu um passo». Nunca enviamos o conteúdo das tuas notas ou mensagens para a análise.';

  @override
  String get ppUseHead => 'Como usamos as tuas informações';

  @override
  String get ppUseBody =>
      'Apenas para disponibilizar a aplicação: iniciar a tua sessão, gerir os grupos, restaurar o teu progresso e melhorar o Rung com tendências agregadas e anónimas. Não vendemos os teus dados nem os usamos para publicidade.';

  @override
  String get ppProcessHead => 'Quem trata os teus dados';

  @override
  String get ppProcessBody =>
      'Usamos o Supabase (autenticação, base de dados e alojamento) e o PostHog (análise) como subcontratantes. Tratam os dados em nosso nome ao abrigo dos seus próprios compromissos de segurança e privacidade.';

  @override
  String get ppRightsHead => 'Os teus direitos e escolhas';

  @override
  String get ppRightsBody =>
      'Podes editar o teu perfil, bloqueá-lo para que outros membros não o vejam, e eliminar permanentemente a tua conta e todos os dados associados na nuvem a qualquer momento em Perfil → Eliminar conta. Também nos podes escrever para pedir acesso aos teus dados ou a sua eliminação.';

  @override
  String get ppSecurityHead => 'Segurança e conservação';

  @override
  String get ppSecurityBody =>
      'Os dados são encriptados em trânsito, e cada tabela está protegida por segurança ao nível da linha, para que só possas aceder aos teus próprios dados (e às mensagens dos grupos de que és membro). Guardamos os teus dados até eliminares a tua conta ou nos pedires para os removermos.';

  @override
  String get ppChildrenHead => 'Crianças';

  @override
  String get ppChildrenBody =>
      'O Rung não se destina a menores de 16 anos. Se achares que uma criança criou uma conta, contacta-nos e removê-la-emos.';

  @override
  String get ppMedicalHead => 'Não é cuidado médico';

  @override
  String get ppMedicalBody =>
      'O Rung apoia a prática gradual mas não é terapia, diagnóstico nem aconselhamento médico. Se estiveres em crise, contacta os serviços de emergência locais ou uma linha de apoio em crise.';

  @override
  String get ppChangesHead => 'Alterações';

  @override
  String get ppChangesBody =>
      'Se atualizarmos esta política, alteraremos a data acima e, para alterações relevantes, avisamos-te na aplicação.';

  @override
  String get termsTitle => 'Termos de Serviço';

  @override
  String get termsIntro =>
      'Estes termos são o acordo entre ti e o Rung quando usas a aplicação. Ao criares uma conta ou ao usares o Rung, concordas com eles.';

  @override
  String get tosMedicalHead => 'Não é um serviço médico';

  @override
  String get tosMedicalBody =>
      'O Rung é uma ferramenta de autoajuda e prática, não é terapia nem cuidado médico, e não substitui ajuda profissional. Não pode garantir qualquer resultado específico. Se estiveres em crise ou puderes magoar-te a ti ou a outros, contacta imediatamente os serviços de emergência locais.';

  @override
  String get tosEligibilityHead => 'Elegibilidade';

  @override
  String get tosEligibilityBody =>
      'Tens de ter pelo menos 16 anos para usares o Rung e ter o direito de concordar com estes termos.';

  @override
  String get tosAccountHead => 'A tua conta';

  @override
  String get tosAccountBody =>
      'Mantém os teus dados de acesso seguros — és responsável pela atividade na tua conta. Avisa-nos prontamente se suspeitares de uso não autorizado.';

  @override
  String get tosCommunityHead => 'Regras da comunidade (grupos)';

  @override
  String get tosCommunityBody =>
      'Os grupos existem para a gentileza e o apoio. Concordas em não assediar, ameaçar, humilhar, enviar spam ou publicar conteúdo de ódio ou ilegal, e em não partilhar informação privada de outras pessoas. Podemos remover conteúdo ou suspender contas que infrinjam estas regras. Podes bloquear e denunciar outros membros a qualquer momento.';

  @override
  String get tosContentHead => 'Conteúdo que publicas';

  @override
  String get tosContentBody =>
      'Mantens a propriedade daquilo que escreves. Ao publicares num grupo, dás-nos permissão para o armazenarmos e mostrarmos aos membros desse grupo, para que a comunidade funcione. Não publiques nada que não tenhas o direito de partilhar.';

  @override
  String get tosSubsHead => 'Subscrições';

  @override
  String get tosSubsBody =>
      'Algumas funcionalidades e conteúdo de prática adicional estão disponíveis com uma subscrição paga. Quando a faturação estiver ativa, as compras e renovações são tratadas pela loja de aplicações, e podes geri-las ou cancelá-las através da tua conta da loja. Os preços e o conteúdo incluído podem mudar mediante aviso.';

  @override
  String get tosDisclaimerHead => 'Exclusões e responsabilidade';

  @override
  String get tosDisclaimerBody =>
      'O Rung é fornecido «tal como está», sem garantias de qualquer tipo. Na máxima medida permitida por lei, não somos responsáveis por perdas indiretas ou consequentes decorrentes da tua utilização da aplicação.';

  @override
  String get tosEndingHead => 'Terminar a tua utilização';

  @override
  String get tosEndingBody =>
      'Podes eliminar a tua conta a qualquer momento em Perfil → Eliminar conta. Podemos suspender ou terminar o acesso se estes termos forem grave ou repetidamente infringidos.';

  @override
  String get tosChangesHead => 'Alterações';

  @override
  String get tosChangesBody =>
      'Podemos atualizar estes termos; atualizaremos a data acima e, para alterações significativas, avisamos-te na aplicação. Continuares a usar o Rung significa que aceitas os termos atualizados.';

  @override
  String get breatheCta => 'Sentes o receio? Respira primeiro';

  @override
  String get breatheIntro => 'Sessenta segundos. Segue apenas o círculo.';

  @override
  String get breatheIn => 'Inspira';

  @override
  String get breatheHold => 'Suster';

  @override
  String get breatheOut => 'Expira';

  @override
  String get breatheSkip => 'Saltar';

  @override
  String get breatheDoneTitle => 'É isso.';

  @override
  String get breatheDoneSub =>
      'Sentes-te um pouco mais firme? Dá o teu degrau quando estiveres pronto.';

  @override
  String get breatheDoneBtn => 'Concluído';

  @override
  String get insightsDeeperTitle => 'Análises mais profundas';

  @override
  String get insightsLockedBody =>
      'Vê o teu mês num relance — quanto o teu receio foi mais intenso do que a realidade, e com que frequência o sobrestimaste. Uma vantagem Premium.';

  @override
  String get insightsUnlockCta => 'Desbloquear com Premium';

  @override
  String get insightsNoSteps =>
      'Ainda não registaste passos este mês. Enfrenta alguns e o teu resumo aparece aqui.';

  @override
  String get insightsFearsFacedMonth => 'receios enfrentados este mês';

  @override
  String insightsGapHotter(String points) {
    return 'O teu receio foi $points pontos mais intenso do que a realidade, em média.';
  }

  @override
  String get insightsGapTougher =>
      'A realidade foi um pouco mais dura do que previste este mês — isso também são dados corajosos.';

  @override
  String get insightsGapSpotOn =>
      'As tuas previsões estiveram bastante certeiras este mês.';

  @override
  String insightsOverPredicted(int rate) {
    return 'Sobrestimaste o receio em $rate% das vezes.';
  }

  @override
  String get insightsTrendSame => 'Igual ao mês passado';

  @override
  String insightsTrendMore(int count) {
    return '$count a mais do que no mês passado';
  }

  @override
  String insightsTrendFewer(int count) {
    return '$count a menos do que no mês passado';
  }

  @override
  String get rateTitle => 'Estás a gostar do Rung?';

  @override
  String get ratePromptNone => 'Como está a correr o Rung para ti?';

  @override
  String get ratePromptLow =>
      'Lamentamos que não esteja a resultar. O que falta?';

  @override
  String get ratePromptMid => 'Obrigado — o que o tornaria um 5?';

  @override
  String get ratePromptHigh => 'Isso significa muito. Do que gostas mais?';

  @override
  String get rateHintLove => 'Algo de que gostes muito? (opcional)';

  @override
  String get rateHintMore => 'Conta-nos mais (opcional)';

  @override
  String get rateSend => 'Enviar';

  @override
  String get rateThanksHigh => 'Obrigado — ajuda mesmo. 🌱';

  @override
  String get rateThanksLow =>
      'Obrigado pela sinceridade — vamos usá-la para melhorar.';

  @override
  String get editProfileTitle => 'Editar perfil';

  @override
  String get editDisplayName => 'Nome a apresentar';

  @override
  String get editDisplayNameHint => 'Como te devem chamar nos grupos?';

  @override
  String get editBio => 'Biografia curta (opcional)';

  @override
  String get editBioHint =>
      'Uma linha sobre ti — fica privada se bloqueares o teu perfil.';

  @override
  String get errorOffline =>
      'Estás offline. Liga-te à internet e tenta novamente.';

  @override
  String get errorGeneric => 'Algo correu mal. Tenta novamente.';

  @override
  String get errorSaveFailed =>
      'Não foi possível guardar — o teu dispositivo pode ter pouco espaço. Liberta espaço e tenta novamente.';
}
