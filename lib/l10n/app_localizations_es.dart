// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get navHome => 'Inicio';

  @override
  String get navGroups => 'Grupos';

  @override
  String get navPremium => 'Premium';

  @override
  String get navProfile => 'Perfil';

  @override
  String get greetingMorning => 'Buenos días';

  @override
  String get greetingAfternoon => 'Buenas tardes';

  @override
  String get greetingEvening => 'Buenas noches';

  @override
  String get todayStepIntro => 'Aquí tienes un pequeño paso para hoy.';

  @override
  String get commonContinue => 'Continuar';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonDone => 'Listo';

  @override
  String get commonNotNow => 'Ahora no';

  @override
  String get profileTitle => 'Perfil';

  @override
  String get language => 'Idioma';

  @override
  String get languageSystemDefault => 'Predeterminado del sistema';

  @override
  String get yourTone => 'Tu tono';

  @override
  String get appearance => 'Apariencia';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get onbSkip => 'Omitir';

  @override
  String get onbWelcomeTitle =>
      'Afronta los momentos que solías temer — un pequeño paso a la vez.';

  @override
  String get onbWelcomeBody =>
      'Rung te ayuda a ganar confianza social con práctica suave y privada. Predice, hazlo, reflexiona — y observa cómo tus peores miedos se deshacen en tus propios números.';

  @override
  String get onbGetStarted => 'Empezar';

  @override
  String get onbSafetyTitle => 'Práctica, no terapia.';

  @override
  String get onbUnderstand => 'Entiendo';

  @override
  String get onbSafetyBody1 =>
      'Rung es una herramienta de confianza y práctica — no es terapia, ni tratamiento médico, ni un diagnóstico.';

  @override
  String get onbSafetyBody2 =>
      'El objetivo es sentirte más cómodo en momentos que solías temer — no convertirte en alguien que no eres. Saltarte pasos siempre está bien.';

  @override
  String get onbSafetyCrisis =>
      'Si la ansiedad está afectando gravemente tu vida, o alguna vez tienes pensamientos de hacerte daño, por favor contacta con un profesional o una línea de crisis local.';

  @override
  String get onbFearTitle => '¿Por dónde te gustaría empezar?';

  @override
  String get onbFearBody =>
      'Solo para sugerir un primer paso — puedes subir por cualquiera de estos en cualquier momento. Nada aquí te compromete.';

  @override
  String get onbExploreOwn => 'Prefiero explorar por mi cuenta';

  @override
  String get onbToneTitle => '¿Con cuál te identificas más?';

  @override
  String get onbToneIntrovertTitle => 'Soy más bien introvertido';

  @override
  String get onbToneIntrovertBody =>
      'Quiero sentirme cómodo, no convertirme en una persona diferente.';

  @override
  String get onbToneSituationalTitle =>
      'Me pongo nervioso en ciertas situaciones';

  @override
  String get onbToneSituationalBody =>
      'A veces soy extrovertido, pero ciertos momentos me hacen tropezar.';

  @override
  String get onbToneFootnote => 'Puedes cambiar esto cuando quieras en Perfil.';

  @override
  String get onbHowTitle => 'Así funciona.';

  @override
  String get onbStartClimbing => 'Empezar a subir';

  @override
  String get onbStep1 => 'Predice qué tan mal se sentirá (0–10).';

  @override
  String get onbStep2 => 'Ve y hazlo en la vida real — puedes cerrar la app.';

  @override
  String get onbStep3 => 'Vuelve y anota cómo fue realmente.';

  @override
  String get onbGentleFirstStep => 'UN PRIMER PASO SUAVE';

  @override
  String get onbGoodPlaceToStart => 'UN BUEN LUGAR PARA EMPEZAR';

  @override
  String get onbAllAreas =>
      'Las seis áreas están en tu pantalla de inicio — empieza donde quieras.';

  @override
  String get predictAppBar => 'Antes de ir';

  @override
  String get predictSaved =>
      'Guardado. Ve y hazlo, luego vuelve para registrar cómo fue.';

  @override
  String get predictQuestion => '¿Qué tan mal crees que será?';

  @override
  String get predictNoteLabel => '¿Qué crees que pasará? (opcional)';

  @override
  String get predictNoteHint => 'p. ej. Pensarán que soy raro';

  @override
  String get predictCompare =>
      'Lo compararemos con cómo va en realidad. Esa diferencia es lo que importa.';

  @override
  String get predictDoIt => 'Lo haré';

  @override
  String get reflectAppBar => '¿Cómo fue?';

  @override
  String get reflectDidYouDoIt => '¿Lo hiciste?';

  @override
  String get reflectHowAnxious => '¿Qué tan ansioso te hizo sentir pensarlo?';

  @override
  String get reflectHowBad => '¿Qué tan mal fue, en realidad?';

  @override
  String get reflectNoteLabel => '¿Algo que quieras recordar? (opcional)';

  @override
  String get reflectOutcomeDone => 'Hecho';

  @override
  String get reflectOutcomePartial => 'Parcial';

  @override
  String get reflectOutcomeNotToday => 'Hoy no';

  @override
  String get resultQuietDelight => 'Una alegría tranquila en cada paso.';

  @override
  String get resultBackToLadder => 'Volver a la escalera';

  @override
  String resultGapHeadline(int predicted, int actual) {
    return 'Te preparaste para $predicted. Resultó ser $actual.';
  }

  @override
  String resultGapSub(int predicted, int actual) {
    return 'Tu corazón se preparó para un duro $predicted, pero el mundo te recibió con un más suave $actual. Vale la pena recordarlo.';
  }

  @override
  String get resultRightHeadline => 'Justo como lo imaginaste.';

  @override
  String get resultRightSub =>
      'Lo predijiste, y aun así diste el paso. Ese es el logro.';

  @override
  String get resultTougherHeadline =>
      'Más difícil de lo que pensabas, y lo hiciste.';

  @override
  String get resultTougherSub =>
      'Algunos momentos nos exigen más. Presentarte de todos modos es lo que importa.';

  @override
  String get resultPredicted => 'Previsto';

  @override
  String get resultActual => 'Real';

  @override
  String resultLighter(int reduction) {
    return 'Este momento fue un $reduction% más leve de lo que temías';
  }

  @override
  String get resultSkippedHeadline => 'Registrado, sin presión.';

  @override
  String get resultSkippedSub =>
      'Hoy no es una respuesta perfectamente válida. Este peldaño seguirá aquí cuando estés listo.';

  @override
  String get resultWinCopied => 'Logro copiado: pégalo donde quieras.';

  @override
  String get resultCopyWin => 'Copiar mi logro';

  @override
  String resultShareText(String rung) {
    return 'Acabo de hacer algo que solía evitar: $rung. Un pequeño peldaño superado. 🪜 #Rung';
  }

  @override
  String get tracksTitle => 'Tus caminos';

  @override
  String get tracksSubtitle => 'Pequeños pasos hacia una gran confianza.';

  @override
  String get menuInsights => 'Análisis';

  @override
  String get menuIsThisRight => '¿Es esto para mí?';

  @override
  String tracksRungsCount(int done, int total) {
    return '$done de $total peldaños';
  }

  @override
  String tracksClimbedCount(int done, int total) {
    return '$done de $total superados';
  }

  @override
  String get tracksContinueLabel => 'CONTINÚA DONDE LO DEJASTE';

  @override
  String get tracksNextStepLabel => 'TU PRÓXIMO PASO';

  @override
  String get tracksLoadError => 'No se pudieron cargar los caminos.';

  @override
  String get todayResume => 'Retoma donde lo dejaste';

  @override
  String get todayNext => 'Tu próximo paso';

  @override
  String get todayVariety => 'Algo un poco diferente';

  @override
  String get todayFresh => 'Tu punto de partida';

  @override
  String get todayResumeCta => 'Terminar de registrar';

  @override
  String get todayStartCta => 'Empezar';

  @override
  String todayMinutes(int min) {
    return '~$min min';
  }

  @override
  String get dashShareTooltip => 'Compartir mi progreso';

  @override
  String get dashWeeklyGoal => 'Meta semanal';

  @override
  String dashStepsPerWeek(int count) {
    return '$count pasos/semana';
  }

  @override
  String dashGoalPerWeek(int count) {
    return '$count/semana';
  }

  @override
  String dashWeeklyProgress(int done, int goal) {
    return '$done de $goal pasos completados esta semana';
  }

  @override
  String get dashYourGrowth => 'Tu crecimiento';

  @override
  String get dashTodayError =>
      'No se pudo cargar el paso de hoy. Desliza para reintentar.';

  @override
  String get dashTodayAllClear =>
      'Has completado todo lo disponible: añade un peldaño personalizado o repite uno para mantener tu racha.';

  @override
  String get dashTakeABreak => 'Tómate un descanso';

  @override
  String get dashTakeABreakSub =>
      'Unos juegos tranquilos, contra el teléfono o un amigo.';

  @override
  String get ladderTitleFallback => 'Escalera';

  @override
  String get ladderLoadError => 'No se pudo cargar la escalera.';

  @override
  String get ladderAddOwn => 'Añade tu propio peldaño';

  @override
  String ladderOfClimbed(int total) {
    return 'de $total superados';
  }

  @override
  String get detailLoadError => 'No se pudo cargar.';

  @override
  String get detailNotExist => 'Este peldaño ya no existe.';

  @override
  String get detailWhatToDo => 'Qué hacer';

  @override
  String get detailWhyHelps => 'Por qué ayuda';

  @override
  String get detailPastAttempts => 'Tus intentos anteriores';

  @override
  String get detailDoThis => 'Lo haré';

  @override
  String get detailReattempt => 'Repetir es bienvenido: fortalece tus datos.';

  @override
  String detailHistoryStat(int predicted, int actual) {
    return 'previsto $predicted · real $actual';
  }

  @override
  String customLimitPremium(int cap) {
    return 'Has alcanzado el límite de este mes de $cap peldaños personalizados; se restablece el próximo mes.';
  }

  @override
  String get customLimitFree =>
      'El plan gratuito incluye 5 peldaños personalizados; mejora para tener más cada mes.';

  @override
  String get customDefaultWhat => 'Un reto que te pones a ti mismo.';

  @override
  String get customDefaultWhy =>
      'Tú le pusiste nombre a este, y eso lo hace contar.';

  @override
  String get customSubtitle =>
      'Tu situación es específica: este peldaño es solo para ti.';

  @override
  String get customWhatLabel => '¿Qué harás?';

  @override
  String get customWhatHint => 'p. ej. Pedir feedback a mi jefe';

  @override
  String get customNoteLabel => 'Una nota para ti (opcional)';

  @override
  String customDifficulty(int value) {
    return '¿Qué tan difícil se siente? $value/10';
  }

  @override
  String get customAddToLadder => 'Añadir a la escalera';

  @override
  String get paywallSwitchToFree => 'Cambiar a Gratis';

  @override
  String get paywallHeroTitle => 'No tienes que enfrentarlo solo.';

  @override
  String get paywallHeroBody =>
      'La práctica diaria siempre es gratis. Premium añade un entrenador privado de tu lado — y una comunidad más grande — para cuando estés listo para ir más lejos.';

  @override
  String get paywallWhatsIncluded => 'Qué incluye';

  @override
  String get paywallPlusHeader => 'Además, cada suscriptor recibe';

  @override
  String get paywallBenefitCoach =>
      'Un entrenador privado, cuando quieras: ensaya algo que se acerca o habla sobre cómo fue';

  @override
  String get paywallBenefitPods =>
      'No estás solo en esto: únete a más grupos de apoyo (3 en mensual, ilimitados en anual)';

  @override
  String get paywallBenefitCustom =>
      'Crea tus propias escaleras sin límite: sin tope de peldaños personalizados';

  @override
  String get paywallBenefitDepth =>
      'Profundiza cuando estés listo: hasta 40 pasos por camino (gratis es un recorrido completo de 10 pasos)';

  @override
  String get paywallPlusStreak =>
      'Protección de racha: un día perdido no romperá tu racha';

  @override
  String get paywallPlusInsights =>
      'Análisis más profundos: tu mes de un vistazo';

  @override
  String get paywallPlusShare => 'Estilos personales para compartir logros';

  @override
  String get paywallPlusPrivacy => 'Siempre privado, siempre sin anuncios';

  @override
  String get paywallYearly => 'Anual';

  @override
  String get paywallPerYear => 'al año · mejor valor';

  @override
  String get paywallSave => 'Ahorra 33%';

  @override
  String get paywallMonthly => 'Mensual';

  @override
  String get paywallPerMonth => 'al mes';

  @override
  String get paywallSwitchYearly => 'Cambiar a anual';

  @override
  String get paywallSwitchMonthly => 'Cambiar a mensual';

  @override
  String paywallStartYearly(String price) {
    return 'Empezar anual — $price';
  }

  @override
  String paywallStartMonthly(String price) {
    return 'Empezar mensual — $price';
  }

  @override
  String get paywallRestore => 'Restaurar compras';

  @override
  String paywallCurrentPlan(String plan) {
    return 'Plan actual: $plan. Cancela cuando quieras.';
  }

  @override
  String get paywallCancelAnytime =>
      'Cancela cuando quieras. El núcleo sigue siendo gratis para siempre.';

  @override
  String get paywallSimulated =>
      'Premium activo (simulado: añade claves de RevenueCat para compras reales).';

  @override
  String get paywallPlanUnavailable =>
      'Ese plan no está disponible ahora. Inténtalo de nuevo en breve.';

  @override
  String get paywallThankYou => 'Premium activo — gracias. 🌱';

  @override
  String get paywallPurchaseFailed =>
      'La compra no se completó. No se te ha cobrado.';

  @override
  String get paywallRestored => 'Compras restauradas.';

  @override
  String get paywallNoRestore =>
      'No se encontraron compras anteriores en esta cuenta.';

  @override
  String get paywallRestoreFailed =>
      'No se pudo restaurar ahora. Inténtalo de nuevo en breve.';

  @override
  String get profileAddName => 'Añade tu nombre';

  @override
  String get profileLockTitle => 'Bloquear mi perfil';

  @override
  String get profileLockedSub =>
      'Oculto: los miembros del grupo no pueden ver tus detalles.';

  @override
  String get profileUnlockedSub =>
      'Los miembros del grupo pueden tocar tu avatar para ver tus detalles.';

  @override
  String get profilePlanTitle => 'Tu plan';

  @override
  String get profilePremium => 'Premium';

  @override
  String get profileUpgrade => 'Mejorar';

  @override
  String get profileToneDesc =>
      'Rung habla con suavidad por defecto. Si tu ansiedad es más situacional, un tono un poco más directo puede irte mejor.';

  @override
  String get profileToneIntrovert => 'Introvertido';

  @override
  String get profileToneSituational => 'Situacional';

  @override
  String get profileSafetySub => 'Cómo encaja Rung, y cuándo buscar más ayuda';

  @override
  String get profileBlockedTitle => 'Miembros bloqueados';

  @override
  String get profileBlockedSub =>
      'Ve y desbloquea a las personas que has bloqueado';

  @override
  String get profileRestoreTitle => 'Restaurar mi progreso';

  @override
  String get profileRestoreSub => 'Recupera tu racha y desafíos desde la nube';

  @override
  String get profileRestoring => 'Restaurando…';

  @override
  String get profileRestoreOk => 'Progreso restaurado desde la nube.';

  @override
  String profileRestoreFail(String error) {
    return 'Error al restaurar: $error';
  }

  @override
  String get profileLogout => 'Cerrar sesión';

  @override
  String get profileSignedIn => 'Sesión iniciada';

  @override
  String get profileLogoutConfirmTitle => '¿Cerrar sesión?';

  @override
  String get profileLogoutConfirmBody =>
      'Tu progreso se guarda en la nube y vuelve cuando inicias sesión de nuevo.';

  @override
  String get profileLoggingOut => 'Cerrando sesión…';

  @override
  String get profileRateTitle => 'Valorar Rung';

  @override
  String get profileRateSub => 'Cuéntanos cómo te va: ayuda mucho';

  @override
  String get profilePrivacyTitle => 'Política de privacidad';

  @override
  String get profilePrivacySub =>
      'Qué guardamos y qué se queda en tu dispositivo';

  @override
  String get profileTermsTitle => 'Términos de servicio';

  @override
  String get profileTermsSub => 'El acuerdo para usar Rung';

  @override
  String get profileDeleteTitle => 'Eliminar cuenta';

  @override
  String get profileDeleteSub =>
      'Borra tu cuenta y tus datos de forma permanente';

  @override
  String get profileFooter =>
      'Rung · práctica, no terapia. Tus datos son tuyos.';

  @override
  String get profileDeleteConfirmTitle => '¿Eliminar cuenta?';

  @override
  String get profileDeleteConfirmBody =>
      'Esto elimina de forma permanente tu cuenta, tus mensajes de grupo y tu progreso guardado. No se puede deshacer.';

  @override
  String get profileDelete => 'Eliminar';

  @override
  String get profileDeleting => 'Eliminando tu cuenta…';

  @override
  String get profileDeleteFail =>
      'No se pudo eliminar tu cuenta. Inténtalo de nuevo.';

  @override
  String get profileBioPlaceholder => 'Un escalador tranquilo.';

  @override
  String get profileHaptics => 'Vibración';

  @override
  String get profileHapticsSub => 'Vibración suave al tocar y al ganar';

  @override
  String get profileNotifications => 'Notificaciones';

  @override
  String get profileNotificationsSub => 'Avisos de Rung en este dispositivo';

  @override
  String get profilePodAlerts => 'Avisos de mensajes de grupo';

  @override
  String get profilePodAlertsSub =>
      'Avísame cuando alguien publique en mis grupos';

  @override
  String get profileEnableNotifs =>
      'Activa las notificaciones en Ajustes para recibir recordatorios.';

  @override
  String get profileReminderHelp =>
      '¿Cuándo quieres que te demos un empujoncito?';

  @override
  String get profileReminderTitle => 'Recordatorio diario suave';

  @override
  String profileReminderOn(String time) {
    return 'Cada día a las $time · toca el interruptor para desactivar';
  }

  @override
  String get profileReminderOff =>
      'Un empujoncito tranquilo y sin culpa para dar un pequeño paso';

  @override
  String get profileAvatarTitle => 'Elige tu avatar';

  @override
  String get profileAvatarSub =>
      'Solo tú puedes cambiarlo; tus compañeros de grupo también lo ven.';

  @override
  String get commonClose => 'Cerrar';

  @override
  String get checkInMoodCalm => 'En calma';

  @override
  String get checkInMoodOkay => 'Bien';

  @override
  String get checkInMoodAnxious => 'Ansioso';

  @override
  String get checkInMoodLow => 'Decaído';

  @override
  String get checkInMoodTense => 'Tenso';

  @override
  String get checkInTitle => '¿Cómo llegas hoy?';

  @override
  String get checkInDismiss => 'Descartar';

  @override
  String get checkInCalmCta => 'Prueba un momento de calma';

  @override
  String get checkInStepCta => 'Ver el paso de hoy';

  @override
  String get supportTitle => 'Parece que estás cargando con mucho.';

  @override
  String get supportBody =>
      'Rung es una herramienta de práctica, no un servicio de crisis. Si estás pasando por algo difícil, por favor busca a alguien que pueda ayudarte ahora mismo: una persona de confianza o una línea de crisis local. Mereces apoyo de verdad.';

  @override
  String get supportResources => 'Ver recursos de apoyo';

  @override
  String get progressChallenges => 'Desafíos';

  @override
  String get progressCurrentStreak => 'Racha actual';

  @override
  String get progressBestStreak => 'Mejor racha';

  @override
  String get progressThisWeek => 'Esta semana';

  @override
  String get progressCategoryBreakdown => 'Desglose por categoría';

  @override
  String get insightsHistory => 'Historial';

  @override
  String checkInAckTitle(String mood) {
    return 'Registrado — te sientes $mood';
  }

  @override
  String get checkInAckGentle =>
      'Gracias por tu sinceridad. Hagamos que hoy sea suave: una cosa pequeña y amable es suficiente.';

  @override
  String get checkInAckStep =>
      'Me encanta. Cuando estés listo, un pequeño paso mantiene el impulso.';

  @override
  String get sharePremiumPerk =>
      '✨ Más estilos de tarjeta son una ventaja Premium.';

  @override
  String get shareSeePremium => 'Ver Premium';

  @override
  String get shareText =>
      'Pequeños pasos valientes, un peldaño a la vez. 🌱 #Rung';

  @override
  String get shareError =>
      'No se pudo abrir para compartir. Inténtalo de nuevo.';

  @override
  String get shareTitle => 'Comparte tu progreso';

  @override
  String get shareSubtitle => 'Solo tus números, nada privado.';

  @override
  String get shareCta => 'Compartir';

  @override
  String get shareCardHeadline => 'Mis pasos valientes';

  @override
  String get shareCardFearsFaced => 'miedos enfrentados';

  @override
  String get shareCardCurrentStreak => 'Racha actual';

  @override
  String get shareCardBestStreak => 'Mejor racha';

  @override
  String get shareCardTagline =>
      'Enfrentando miedos sociales, un pequeño peldaño a la vez.';

  @override
  String get helpNow => 'Ayuda ahora';

  @override
  String get helpCalmMoment => 'Un momento de calma';

  @override
  String get helpTabBreathe => 'Respira';

  @override
  String get helpTabGround => 'Ánclate';

  @override
  String get helpTabSay => 'Di esto';

  @override
  String get helpBreatheIn => 'Inhala…';

  @override
  String get helpBreatheOut => 'Exhala…';

  @override
  String get helpBreatheHint => 'Sigue el círculo. No hay prisa.';

  @override
  String get helpGround5 => 'cosas que puedes ver';

  @override
  String get helpGround4 => 'cosas que puedes tocar';

  @override
  String get helpGround3 => 'cosas que puedes oír';

  @override
  String get helpGround2 => 'cosas que puedes oler';

  @override
  String get helpGround1 => 'cosa que puedes saborear';

  @override
  String get helpGroundTitle => 'Nombra, en silencio para ti…';

  @override
  String get helpGroundHint =>
      'Esto te trae de vuelta al ahora, donde estás a salvo.';

  @override
  String get helpOpener1 => '¿De qué conoces a la gente de aquí?';

  @override
  String get helpOpener2 => 'Me encanta este lugar, ¿habías venido antes?';

  @override
  String get helpOpener3 => 'Soy fatal con los nombres, ¿me lo recuerdas?';

  @override
  String get helpOpener4 => '¿Qué has hecho esta semana?';

  @override
  String get helpExit1 => 'Voy a por una bebida, me alegró hablar contigo.';

  @override
  String get helpExit2 =>
      'Tengo que saludar a alguien rápido, discúlpame un momento.';

  @override
  String get helpExit3 => 'Te dejo que socialices, nos vemos luego.';

  @override
  String get helpOpenersTitle => 'Frases para empezar';

  @override
  String get helpExitsTitle => 'Salidas con elegancia';

  @override
  String get authEnterEmail => 'Ingresa tu correo';

  @override
  String get authBadEmail => 'Ese correo no parece válido';

  @override
  String get authEnterPassword => 'Ingresa una contraseña';

  @override
  String get authMin6 => 'Al menos 6 caracteres';

  @override
  String get authPwMismatch => 'Las contraseñas no coinciden';

  @override
  String get authConfirmEmail =>
      'Revisa tu correo para confirmar y luego inicia sesión. (O desactiva la confirmación por correo en los ajustes de Auth de Supabase para pruebas rápidas.)';

  @override
  String get authGenericError => 'Algo salió mal. Inténtalo de nuevo.';

  @override
  String get authCreateTitle => 'Crea tu cuenta';

  @override
  String get authWelcomeBack => 'Bienvenido de nuevo';

  @override
  String get authSignUpSub =>
      'Únete a los grupos y mantén tu progreso a salvo en todos tus dispositivos.';

  @override
  String get authSignInSub =>
      'Inicia sesión en tus grupos y tu progreso sincronizado.';

  @override
  String get authDisplayName => 'Nombre para mostrar (opcional)';

  @override
  String get authEmail => 'Correo';

  @override
  String get authPassword => 'Contraseña';

  @override
  String get authShowPassword => 'Mostrar contraseña';

  @override
  String get authHidePassword => 'Ocultar contraseña';

  @override
  String get authConfirmPassword => 'Confirmar contraseña';

  @override
  String get authCreateCta => 'Crear cuenta';

  @override
  String get authSignInCta => 'Iniciar sesión';

  @override
  String get authHaveAccount => 'Ya tengo una cuenta';

  @override
  String get authNewAccount => 'Soy nuevo — crear una cuenta';

  @override
  String get authLegalPrefixSignUp => 'Al crear una cuenta aceptas nuestros ';

  @override
  String get authLegalPrefixSignIn => 'Al continuar aceptas nuestros ';

  @override
  String get authTerms => 'Términos';

  @override
  String get authAnd => ' y ';

  @override
  String get gamesIntro =>
      'Juegos tranquilos para la concentración y una mente calmada, el tipo de entrenamiento mental que a la gente le resulta reconfortante. Juega contra el teléfono o pásaselo a un amigo.';

  @override
  String gamesBestMs(int ms) {
    return 'Mejor: $ms ms';
  }

  @override
  String gamesBestLevel(int level) {
    return 'Mejor nivel: $level';
  }

  @override
  String gamesBest(String score) {
    return 'Mejor: $score';
  }

  @override
  String gamesBestMoves(int moves) {
    return 'Mejor: $moves movimientos';
  }

  @override
  String gamesWinsVsPhone(int count) {
    return '$count victorias vs. teléfono';
  }

  @override
  String get gameTitleReaction => 'Velocidad de reacción';

  @override
  String get gameTitleSequence => 'Memoria de secuencia';

  @override
  String get gameTitleQuickMath => 'Cálculo rápido';

  @override
  String get gameTitleMemory => 'Encuentra las parejas';

  @override
  String get gameSubReaction => 'concentración · toca cuando se ponga verde';

  @override
  String get gameSubSequence => 'memoria · observa y repite';

  @override
  String get gameSub2048 => 'estrategia · desliza para combinar';

  @override
  String get gameSubQuickMath => 'velocidad mental · sprint de 30 segundos';

  @override
  String get gameSubTicTacToe => 'vs. el teléfono · o 2 jugadores';

  @override
  String get gameSubConnect4 => 'vs. el teléfono · o 2 jugadores';

  @override
  String get gameSubMemory => 'en solitario · encuentra las parejas';

  @override
  String get gameHelpTooltip => 'Cómo jugar';

  @override
  String gameHelpTitle(String game) {
    return 'Cómo jugar · $game';
  }

  @override
  String get gameGotIt => 'Entendido';

  @override
  String get tierFree => 'Gratis';

  @override
  String get tierMonthly => 'Premium · Mensual';

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
  String get groupsSignedOutTitle => 'Únete a un grupo pequeño y amable';

  @override
  String get groupsSignedOutBody =>
      'Los grupos necesitan una cuenta rápida para que sean seguros y tuyos. Tu práctica sigue siendo privada y sin cuenta.';

  @override
  String get groupsSignInCta => 'Inicia sesión para continuar';

  @override
  String get groupsLoadError =>
      'No se pudieron cargar los grupos. Desliza para reintentar.';

  @override
  String groupsJoined(String pod) {
    return 'Te uniste a $pod. Saluda cuando estés listo.';
  }

  @override
  String get groupsJoinedNew =>
      'Te uniste a un grupo nuevo. Saluda cuando estés listo.';

  @override
  String get groupsNoPodFound =>
      'No se encontró un grupo ahora. Inténtalo de nuevo.';

  @override
  String groupsLeaveTitle(String pod) {
    return '¿Salir de $pod?';
  }

  @override
  String get groupsLeave => 'Salir';

  @override
  String groupsLeft(String pod) {
    return 'Saliste de $pod.';
  }

  @override
  String get groupsLeaveError =>
      'No se pudo salir del grupo. Inténtalo de nuevo.';

  @override
  String get groupsHeader => 'Grupos pequeños, gente amable';

  @override
  String get groupsYourPods => 'TUS GRUPOS';

  @override
  String get groupsDiscoverPods => 'DESCUBRIR GRUPOS';

  @override
  String get groupsJoinAnother => 'Unirse a otro grupo';

  @override
  String get groupsNoOthers => 'No hay otros grupos para unirte ahora.';

  @override
  String groupsJoinedShort(String pod) {
    return 'Te uniste a $pod.';
  }

  @override
  String get groupsJoin => 'Unirse';

  @override
  String get groupsPodOptions => 'Opciones del grupo';

  @override
  String get groupsLeavePod => 'Salir del grupo';

  @override
  String groupsMembers(int count, int capacity) {
    return '$count/$capacity miembros';
  }

  @override
  String groupsTierPods(String tier, String pods) {
    return 'En $tier puedes estar en $pods.';
  }

  @override
  String groupsCapacityTierPods(int capacity, String tier, String pods) {
    return 'Hasta $capacity por grupo. En $tier puedes estar en $pods.';
  }

  @override
  String groupsInYourPods(String pods) {
    return 'Estás en tus $pods';
  }

  @override
  String get groupsUpgradeBody =>
      'Hazte Premium para unirte a más: el plan mensual desbloquea 3 grupos y el anual, todos los que quieras.';

  @override
  String get groupsSafetyLive =>
      'Sé amable. Puedes reportar o bloquear a cualquiera desde su perfil. Los perfiles bloqueados siguen siendo privados.';

  @override
  String get groupsSafetyPreview =>
      'Vista previa. Los grupos se convierten en chats en vivo y moderados cuando se configura el inicio de sesión.';

  @override
  String get groupsLeaveBody =>
      'Dejarás de ver los mensajes de este grupo. Puedes volver a unirte más tarde.';

  @override
  String get podRulesTitle => 'Reglas del grupo';

  @override
  String get podRulesIntro =>
      'Los grupos solo funcionan si todos se sienten seguros. Al unirte, aceptas:';

  @override
  String get podRule1 =>
      'Sé amable. Aquí todos están practicando algo difícil.';

  @override
  String get podRule2 => 'Sin acoso, odio ni contenido dañino. Nunca.';

  @override
  String get podRule3 => 'Reporta o bloquea a cualquiera que te incomode.';

  @override
  String get podRule4 =>
      'Respeta la privacidad: lo que se comparte aquí se queda aquí.';

  @override
  String get podRule5 =>
      'Los grupos son apoyo entre pares, no un servicio de crisis. En una emergencia, contacta a un profesional o a una línea de crisis local.';

  @override
  String get podRulesAgree => 'Acepto — entrar';

  @override
  String chatIntrosBeKind(int count, int capacity) {
    return '$count/$capacity introvertidos · sé amable';
  }

  @override
  String get chatHint => 'Di algo amable…';

  @override
  String get chatPreviewBanner =>
      'Vista previa · por ahora los mensajes se quedan en tu dispositivo. Los grupos reales y moderados llegan con las cuentas.';

  @override
  String get chatYou => 'Tú';

  @override
  String get reportHarassment => 'Acoso o intimidación';

  @override
  String get reportHate => 'Odio o lenguaje dañino';

  @override
  String get reportSpam => 'Spam o estafa';

  @override
  String get reportUnsafe => 'Me hace sentir inseguro';

  @override
  String get reportOther => 'Otra cosa';

  @override
  String get memberPrivateTitle => 'Perfil privado';

  @override
  String get memberPrivateBody =>
      'Este miembro mantiene su perfil privado. Aun así puedes chatear con él, y reportar o bloquear si es necesario.';

  @override
  String memberStreak(int days) {
    return 'racha de $days días';
  }

  @override
  String memberChallenges(int count) {
    return '$count desafíos';
  }

  @override
  String memberClimbing(String track) {
    return 'Subiendo: $track';
  }

  @override
  String get memberReport => 'Reportar';

  @override
  String get memberBlock => 'Bloquear';

  @override
  String get memberReportThanks => 'Gracias, lo revisaremos.';

  @override
  String get memberBlockToo => 'Bloquear también';

  @override
  String get memberBlocked => 'Bloqueado. No verás sus mensajes.';

  @override
  String get memberBlockError => 'No se pudo bloquear. Inténtalo de nuevo.';

  @override
  String get memberReportError =>
      'No se pudo enviar el reporte. Inténtalo de nuevo.';

  @override
  String get memberBlockConfirmTitle => '¿Bloquear a este miembro?';

  @override
  String get memberBlockConfirmBody =>
      'No verán los mensajes del otro. Puedes deshacerlo más tarde.';

  @override
  String get memberSoonReporting =>
      'Reportar estará disponible en grupos moderados (inicia sesión para usarlo).';

  @override
  String get memberSoonBlocking =>
      'Bloquear estará disponible en grupos moderados (inicia sesión para usarlo).';

  @override
  String get memberWhatsWrong => '¿Qué ocurre?';

  @override
  String get memberFallback => 'Miembro';

  @override
  String get blockedUnblockError =>
      'No se pudo desbloquear. Inténtalo de nuevo.';

  @override
  String blockedUnblocked(String name) {
    return 'Desbloqueaste a $name. Volverás a ver sus mensajes.';
  }

  @override
  String get blockedIntro =>
      'Bloquear oculta los mensajes de un miembro para ti, y los tuyos para él, en ambos sentidos. Desbloquea a cualquiera abajo para deshacerlo.';

  @override
  String get blockedLabel => 'Bloqueado';

  @override
  String get blockedUnblock => 'Desbloquear';

  @override
  String get blockedEmptyTitle => 'Nadie bloqueado';

  @override
  String get blockedEmptyBody =>
      'No has bloqueado a nadie. Bloquear oculta los mensajes de un miembro para ti, en ambos sentidos, y siempre puedes deshacerlo aquí.';

  @override
  String get chatCheckInPosted =>
      'Buen trabajo. Registro publicado en el grupo.';

  @override
  String get chatCheckInError =>
      'No se pudo registrar ahora. Inténtalo de nuevo.';

  @override
  String get chatDeleteMsgTitle => '¿Eliminar mensaje?';

  @override
  String get chatDeleteMsgBody => 'Se elimina para todos en el grupo.';

  @override
  String get chatReply => 'Responder';

  @override
  String get chatEdit => 'Editar';

  @override
  String get chatDailyPrompt => 'Sugerencia diaria del grupo';

  @override
  String get chatCheckedInToday => 'Registrado hoy';

  @override
  String get chatDidMyStep => 'Hice mi paso';

  @override
  String chatCheckedInCount(int count) {
    return '$count registrados';
  }

  @override
  String get chatNoMessages =>
      'Aún no hay mensajes. Un simple «hola» es un primer peldaño valiente.';

  @override
  String get chatEditingMessage => 'Editando tu mensaje';

  @override
  String chatReplyingTo(String name) {
    return 'Respondiendo a $name';
  }

  @override
  String get chatYourself => 'ti mismo';

  @override
  String get chatMsgDeleted => 'Este mensaje fue eliminado';

  @override
  String get chatPrivateMember => 'Miembro privado';

  @override
  String chatBeKind(int count, int capacity) {
    return '$count/$capacity · sé amable';
  }

  @override
  String get chatDeletedMessageShort => 'mensaje eliminado';

  @override
  String get gameYouWin => '¡Ganaste! 🎉';

  @override
  String get gamePhoneWins => 'Gana el teléfono';

  @override
  String get gamePhoneThinking => 'El teléfono está pensando…';

  @override
  String get gamePlayPhone => 'Jugar contra el teléfono';

  @override
  String get game2Players => '2 jugadores';

  @override
  String get gameNewGame => 'Nueva partida';

  @override
  String get gameYou => 'Tú';

  @override
  String get gamePhone => 'Teléfono';

  @override
  String get gameDraws => 'Empates';

  @override
  String get tttP1Wins => '¡Gana el Jugador 1 (X)! 🎉';

  @override
  String get tttP2Wins => '¡Gana el Jugador 2 (O)! 🎉';

  @override
  String get tttYourTurn => 'Tu turno';

  @override
  String get tttP1Turn => 'Jugador 1 · X';

  @override
  String get tttP2Turn => 'Jugador 2 · O';

  @override
  String get tttP1Label => 'J1 (X)';

  @override
  String get tttP2Label => 'J2 (O)';

  @override
  String get tttRule1 => 'Por turnos, coloca tu marca en la cuadrícula de 3×3.';

  @override
  String get tttRule2 =>
      'Consigue tres marcas en línea — horizontal, vertical o diagonal — para ganar.';

  @override
  String get tttRule3 =>
      '«Jugar contra el teléfono» es contra una IA sencilla. «2 jugadores» pasa el teléfono en cada turno.';

  @override
  String get c4P1Wins => '¡Gana el Jugador 1! 🎉';

  @override
  String get c4P2Wins => '¡Gana el Jugador 2! 🎉';

  @override
  String get c4Turn => 'Tu turno — toca una columna';

  @override
  String get c4P1Turn => 'Jugador 1 · rojo';

  @override
  String get c4P2Turn => 'Jugador 2 · amarillo';

  @override
  String get c4P1Label => 'J1';

  @override
  String get c4P2Label => 'J2';

  @override
  String get c4Rule1 =>
      'Toca una columna para soltar tu ficha; cae a la ranura libre más baja.';

  @override
  String get c4Rule2 =>
      'Alinea cuatro de tu color — horizontal, vertical o diagonal — para ganar.';

  @override
  String get c4Rule3 =>
      '«Jugar contra el teléfono» es contra una IA sencilla. «2 jugadores» pasa el teléfono.';

  @override
  String get gameDraw => 'Es un empate 🤝';

  @override
  String get gamePlayAgain => 'Jugar de nuevo';

  @override
  String get gameStart => 'Empezar';

  @override
  String get g2048Rule1 =>
      'Desliza arriba, abajo, izquierda o derecha para mover todas las fichas.';

  @override
  String get g2048Rule2 =>
      'Dos fichas con el mismo número se fusionan en una que se duplica.';

  @override
  String get g2048Rule3 =>
      'Sigue fusionando para crear una ficha 2048. El tablero se llena, ¡planea con antelación!';

  @override
  String get g2048Score => 'Puntuación';

  @override
  String get g2048Best => 'Mejor';

  @override
  String get g2048GameOver => 'Fin del juego';

  @override
  String get g2048Won => '¡Hiciste 2048! 🎉';

  @override
  String get g2048SwipeToMerge => 'Desliza para combinar';

  @override
  String get qmRule1 => 'Tienes 30 segundos: resuelve tantas como puedas.';

  @override
  String get qmRule2 => 'Toca la respuesta correcta entre las cuatro opciones.';

  @override
  String get qmRule3 =>
      'Un toque incorrecto cuesta 2 segundos, así que lee con atención.';

  @override
  String qmTimeScored(Object score) {
    return '¡Se acabó! Puntuaste $score';
  }

  @override
  String qmBestSub(Object best) {
    return 'Mejor $best · 30 segundos, responde tantas como puedas.';
  }

  @override
  String get qmStartSub =>
      '30 segundos. Un toque incorrecto cuesta 2 segundos.';

  @override
  String get qmCorrect => 'correctas';

  @override
  String get mmRule1 =>
      'Toca una carta para voltearla, luego voltea una segunda.';

  @override
  String get mmRule2 =>
      'Si los dos emojis coinciden, quedan boca arriba; si no, se voltean de nuevo.';

  @override
  String get mmRule3 =>
      'Encuentra todas las parejas — en los menos movimientos posibles.';

  @override
  String mmAllMatched(Object moves) {
    return '¡Todas emparejadas en $moves movimientos! 🎉';
  }

  @override
  String mmFindPairs(Object moves) {
    return 'Encuentra las parejas · $moves movimientos';
  }

  @override
  String mmBest(Object best) {
    return 'Mejor: $best movimientos';
  }

  @override
  String get mmShuffle => 'Barajar';

  @override
  String get rxTapStart => 'Toca para empezar';

  @override
  String get rxWaitGreen => 'Espera el verde y toca rápido';

  @override
  String get rxWait => 'Espera…';

  @override
  String get rxTapMoment => 'Toca en cuanto se ponga verde';

  @override
  String rxBestRetry(Object ms) {
    return 'Mejor $ms ms · toca para reintentar';
  }

  @override
  String get rxTapRetry => 'Toca para reintentar';

  @override
  String get rxTooSoon => '¡Demasiado pronto!';

  @override
  String get rxWaitRetry => 'Espera el verde · toca para reintentar';

  @override
  String get rxTap => '¡TOCA!';

  @override
  String get rxRule1 =>
      'Toca la pantalla para empezar, luego espera: se pondrá ámbar.';

  @override
  String get rxRule2 =>
      'En cuanto se ponga verde, toca lo más rápido que puedas.';

  @override
  String get rxRule3 =>
      'Tocar demasiado pronto lo reinicia. Un tiempo menor (ms) es mejor.';

  @override
  String get smWatchRepeat => 'Observa el patrón y luego repítelo.';

  @override
  String get smWatch => 'Observa…';

  @override
  String smYourTurn(Object current, Object total) {
    return 'Tu turno · $current de $total';
  }

  @override
  String smReachedBest(Object best, Object reached) {
    return 'Llegaste a $reached · mejor $best';
  }

  @override
  String smReached(Object reached) {
    return 'Llegaste a $reached';
  }

  @override
  String get smRule1 => 'Observa cómo se iluminan las fichas una por una.';

  @override
  String get smRule2 => 'Repite el mismo orden exacto tocando las fichas.';

  @override
  String get smRule3 =>
      'Cada ronda añade un paso más — mira hasta dónde llegas.';

  @override
  String smRound(Object round) {
    return 'Ronda $round';
  }

  @override
  String get safetyScreenTitle => '¿Es esto adecuado para mí?';

  @override
  String get safetyPracticeTitle => 'Rung es práctica, no terapia.';

  @override
  String get safetyIntro =>
      'Rung es una herramienta de confianza y práctica. Te ayuda a afrontar situaciones sociales cotidianas de forma gradual, a tu propio ritmo. No es terapia, ni tratamiento médico, ni un diagnóstico.';

  @override
  String get safetyPoint1 =>
      'El objetivo es un temor manejable — sentirte más cómodo en los momentos que solías evitar. No convertirte en otra persona.';

  @override
  String get safetyPoint2 =>
      'Saltarte pasos siempre está bien y nunca cuenta en tu contra. Aquí no hay mecánicas de vergüenza.';

  @override
  String get safetyPoint3 =>
      'Tus datos son tuyos. Todo funciona sin conexión, sin necesidad de una cuenta.';

  @override
  String get safetyMoreTitle => 'Si esto es más que nervios';

  @override
  String get safetyMoreBody =>
      'Si la ansiedad está afectando gravemente tu vida diaria, o alguna vez tienes pensamientos de hacerte daño, por favor contacta con un profesional cualificado o una línea de crisis local. Es un paso fuerte y saludable — y Rung no lo sustituye.';

  @override
  String get legalLastUpdated => 'Última actualización: junio de 2026';

  @override
  String legalQuestions(String email) {
    return '¿Preguntas? Escríbenos a $email.';
  }

  @override
  String get privacyTitle => 'Política de Privacidad';

  @override
  String get privacyIntro =>
      'Rung es una herramienta privada de práctica para ganar confianza social. Recopilamos lo mínimo posible, y las cosas más personales que escribes nunca salen de tu teléfono. Esta política explica qué guardamos y por qué.';

  @override
  String get ppWhatStaysHead => 'Lo que permanece solo en tu dispositivo';

  @override
  String get ppWhatStaysBody =>
      'Tus notas de reflexión y de predicción — las cosas privadas que escribes sobre cómo se sintió un momento — se guardan solo en la app, en tu dispositivo. Nunca se suben a nuestros servidores.';

  @override
  String get ppCloudHead => 'Lo que guardamos en la nube';

  @override
  String get ppCloudBody =>
      'Cuando creas una cuenta guardamos: tu dirección de correo (para iniciar sesión; tu contraseña está cifrada y nunca la vemos), un nombre para mostrar y una biografía opcionales, y tu ajuste de bloqueo de privacidad. Para gestionar la comunidad («pods») guardamos los mensajes que publicas y cualquier bloqueo o reporte que hagas. Para mantener tu progreso a salvo entre dispositivos respaldamos solo números — tu racha, retos completados y valoraciones de ansiedad (prevista vs real) — además de los pasos personalizados que crees. El texto de las notas nunca se incluye.';

  @override
  String get ppAnalyticsHead => 'Analítica';

  @override
  String get ppAnalyticsBody =>
      'Usamos analítica de producto respetuosa con la privacidad (PostHog) para entender qué funciones ayudan, mediante eventos de uso anónimos como «abrió una pantalla» o «completó un paso». Nunca enviamos el contenido de tus notas o mensajes a la analítica.';

  @override
  String get ppUseHead => 'Cómo usamos tu información';

  @override
  String get ppUseBody =>
      'Solo para ofrecer la app: iniciar tu sesión, gestionar los pods, restaurar tu progreso y mejorar Rung con tendencias agregadas y anónimas. No vendemos tus datos ni los usamos para publicidad.';

  @override
  String get ppProcessHead => 'Quién procesa tus datos';

  @override
  String get ppProcessBody =>
      'Usamos Supabase (autenticación, base de datos y alojamiento) y PostHog (analítica) como encargados del tratamiento. Gestionan los datos en nuestro nombre bajo sus propios compromisos de seguridad y privacidad.';

  @override
  String get ppRightsHead => 'Tus derechos y opciones';

  @override
  String get ppRightsBody =>
      'Puedes editar tu perfil, bloquearlo para que otros miembros no lo vean, y eliminar de forma permanente tu cuenta y todos los datos asociados en la nube en cualquier momento desde Perfil → Eliminar cuenta. También puedes escribirnos para solicitar acceso o la eliminación de tus datos.';

  @override
  String get ppSecurityHead => 'Seguridad y conservación';

  @override
  String get ppSecurityBody =>
      'Los datos se cifran en tránsito, y cada tabla está protegida con seguridad a nivel de fila, de modo que solo puedas acceder a tus propios datos (y a los mensajes de los pods de los que eres miembro). Conservamos tus datos hasta que elimines tu cuenta o nos pidas retirarlos.';

  @override
  String get ppChildrenHead => 'Menores';

  @override
  String get ppChildrenBody =>
      'Rung no está destinado a menores de 16 años. Si crees que un menor ha creado una cuenta, contáctanos y la eliminaremos.';

  @override
  String get ppMedicalHead => 'No es atención médica';

  @override
  String get ppMedicalBody =>
      'Rung apoya la práctica gradual, pero no es terapia, diagnóstico ni consejo médico. Si estás en crisis, contacta con los servicios de emergencia locales o una línea de crisis.';

  @override
  String get ppChangesHead => 'Cambios';

  @override
  String get ppChangesBody =>
      'Si actualizamos esta política, cambiaremos la fecha de arriba y, para cambios importantes, te avisaremos en la app.';

  @override
  String get termsTitle => 'Términos del Servicio';

  @override
  String get termsIntro =>
      'Estos términos son el acuerdo entre tú y Rung cuando usas la app. Al crear una cuenta o usar Rung, los aceptas.';

  @override
  String get tosMedicalHead => 'No es un servicio médico';

  @override
  String get tosMedicalBody =>
      'Rung es una herramienta de autoayuda y práctica, no terapia ni atención médica, y no reemplaza la ayuda profesional. No puede garantizar ningún resultado concreto. Si estás en crisis o puedes hacerte daño a ti mismo o a otros, contacta de inmediato con los servicios de emergencia locales.';

  @override
  String get tosEligibilityHead => 'Requisitos';

  @override
  String get tosEligibilityBody =>
      'Debes tener al menos 16 años para usar Rung y tener derecho a aceptar estos términos.';

  @override
  String get tosAccountHead => 'Tu cuenta';

  @override
  String get tosAccountBody =>
      'Mantén tus datos de acceso a salvo — eres responsable de la actividad de tu cuenta. Avísanos de inmediato si sospechas de un uso no autorizado.';

  @override
  String get tosCommunityHead => 'Reglas de la comunidad (pods)';

  @override
  String get tosCommunityBody =>
      'Los pods son para la amabilidad y el apoyo. Aceptas no acosar, amenazar, humillar, hacer spam ni publicar contenido de odio o ilegal, y no compartir información privada de otras personas. Podemos eliminar contenido o suspender cuentas que infrinjan estas reglas. Puedes bloquear y reportar a otros miembros en cualquier momento.';

  @override
  String get tosContentHead => 'El contenido que publicas';

  @override
  String get tosContentBody =>
      'Conservas la propiedad de lo que escribes. Al publicar en un pod nos das permiso para almacenarlo y mostrarlo a los miembros de ese pod para que la comunidad funcione. No publiques nada que no tengas derecho a compartir.';

  @override
  String get tosSubsHead => 'Suscripciones';

  @override
  String get tosSubsBody =>
      'Algunas funciones y contenido de práctica adicional están disponibles con una suscripción de pago. Cuando la facturación esté activa, las compras y renovaciones las gestiona la tienda de aplicaciones, y puedes administrarlas o cancelarlas desde tu cuenta de la tienda. Los precios y lo incluido pueden cambiar con previo aviso.';

  @override
  String get tosDisclaimerHead => 'Exenciones y responsabilidad';

  @override
  String get tosDisclaimerBody =>
      'Rung se ofrece «tal cual», sin garantías de ningún tipo. En la máxima medida permitida por la ley, no somos responsables de pérdidas indirectas o consecuentes derivadas de tu uso de la app.';

  @override
  String get tosEndingHead => 'Fin de tu uso';

  @override
  String get tosEndingBody =>
      'Puedes eliminar tu cuenta en cualquier momento desde Perfil → Eliminar cuenta. Podemos suspender o cancelar el acceso si estos términos se infringen de forma grave o reiterada.';

  @override
  String get tosChangesHead => 'Cambios';

  @override
  String get tosChangesBody =>
      'Podemos actualizar estos términos; actualizaremos la fecha de arriba y, para cambios importantes, te avisaremos en la app. Seguir usando Rung significa que aceptas los términos actualizados.';

  @override
  String get breatheCta => '¿Sientes el temor? Respira primero';

  @override
  String get breatheIntro => 'Sesenta segundos. Solo sigue el círculo.';

  @override
  String get breatheIn => 'Inhala';

  @override
  String get breatheHold => 'Sostén';

  @override
  String get breatheOut => 'Exhala';

  @override
  String get breatheSkip => 'Omitir';

  @override
  String get breatheDoneTitle => 'Eso es todo.';

  @override
  String get breatheDoneSub =>
      '¿Te sientes un poco más firme? Haz tu paso cuando estés listo.';

  @override
  String get breatheDoneBtn => 'Listo';

  @override
  String get insightsDeeperTitle => 'Análisis más profundos';

  @override
  String get insightsLockedBody =>
      'Ve tu mes de un vistazo — cuánto tu miedo superó a la realidad, y con qué frecuencia lo sobrestimaste. Una ventaja Premium.';

  @override
  String get insightsUnlockCta => 'Desbloquear con Premium';

  @override
  String get insightsNoSteps =>
      'Aún no has registrado pasos este mes. Afronta un par y tu resumen aparecerá aquí.';

  @override
  String get insightsFearsFacedMonth => 'miedos afrontados este mes';

  @override
  String insightsGapHotter(String points) {
    return 'Tu miedo fue $points puntos más intenso que la realidad, de media.';
  }

  @override
  String get insightsGapTougher =>
      'La realidad fue algo más dura de lo que predijiste este mes — eso también son datos valientes.';

  @override
  String get insightsGapSpotOn =>
      'Tus predicciones fueron bastante acertadas este mes.';

  @override
  String insightsOverPredicted(int rate) {
    return 'Sobrestimaste el miedo el $rate% de las veces.';
  }

  @override
  String get insightsTrendSame => 'Igual que el mes pasado';

  @override
  String insightsTrendMore(int count) {
    return '$count más que el mes pasado';
  }

  @override
  String insightsTrendFewer(int count) {
    return '$count menos que el mes pasado';
  }

  @override
  String get rateTitle => '¿Te gusta Rung?';

  @override
  String get ratePromptNone => '¿Cómo te está sentando Rung?';

  @override
  String get ratePromptLow =>
      'Sentimos que no te esté funcionando. ¿Qué falta?';

  @override
  String get ratePromptMid => 'Gracias — ¿qué lo convertiría en un 5?';

  @override
  String get ratePromptHigh => 'Significa mucho. ¿Qué es lo que más te gusta?';

  @override
  String get rateHintLove => '¿Algo que te encante? (opcional)';

  @override
  String get rateHintMore => 'Cuéntanos más (opcional)';

  @override
  String get rateSend => 'Enviar';

  @override
  String get rateThanksHigh => 'Gracias — ayuda de verdad. 🌱';

  @override
  String get rateThanksLow =>
      'Gracias por tu sinceridad — la usaremos para mejorar.';

  @override
  String get editProfileTitle => 'Editar perfil';

  @override
  String get editDisplayName => 'Nombre para mostrar';

  @override
  String get editDisplayNameHint => '¿Cómo deberían llamarte en los pods?';

  @override
  String get editBio => 'Biografía breve (opcional)';

  @override
  String get editBioHint =>
      'Una línea sobre ti — se mantiene privada si bloqueas tu perfil.';
}
