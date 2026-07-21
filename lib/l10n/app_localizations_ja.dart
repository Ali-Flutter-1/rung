// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get navHome => 'ホーム';

  @override
  String get navGroups => 'グループ';

  @override
  String get navPremium => 'プレミアム';

  @override
  String get navProfile => 'プロフィール';

  @override
  String get greetingMorning => 'おはようございます';

  @override
  String get greetingAfternoon => 'こんにちは';

  @override
  String get greetingEvening => 'こんばんは';

  @override
  String get todayStepIntro => '今日の小さな一歩です。';

  @override
  String get commonContinue => '続ける';

  @override
  String get commonCancel => 'キャンセル';

  @override
  String get commonSave => '保存';

  @override
  String get commonDone => '完了';

  @override
  String get commonNotNow => '今はしない';

  @override
  String get profileTitle => 'プロフィール';

  @override
  String get language => '言語';

  @override
  String get languageSystemDefault => 'システムの言語';

  @override
  String get yourTone => 'あなたのトーン';

  @override
  String get appearance => '外観';

  @override
  String get themeSystem => 'システム';

  @override
  String get themeLight => 'ライト';

  @override
  String get themeDark => 'ダーク';

  @override
  String get onbSkip => 'スキップ';

  @override
  String get onbWelcomeTitle => 'かつて怖かった瞬間に向き合う — 小さな一歩ずつ。';

  @override
  String get onbWelcomeBody =>
      'Rung は、やさしく人目につかない練習を通して、人づきあいの自信を育てます。予測し、実行し、振り返る — そして最悪の不安が、自分の数字の中でほどけていくのを見てください。';

  @override
  String get onbGetStarted => 'はじめる';

  @override
  String get onbSafetyTitle => '練習であって、治療ではありません。';

  @override
  String get onbUnderstand => '理解しました';

  @override
  String get onbSafetyBody1 =>
      'Rung は自信と練習のためのツールです — 心理療法でも、医療行為でも、診断でもありません。';

  @override
  String get onbSafetyBody2 =>
      '目標は、かつて怖かった瞬間で少し楽になることです — 別人になることではありません。スキップはいつでも大丈夫です。';

  @override
  String get onbSafetyCrisis =>
      '不安が生活に深刻な影響を与えている場合、または自分を傷つけたいと思うことがある場合は、専門家またはお住まいの地域の相談窓口にご連絡ください。';

  @override
  String get onbFearTitle => 'どこから始めたいですか？';

  @override
  String get onbFearBody =>
      '最初の一歩の提案にすぎません — どれにでもいつでも挑戦できます。ここで何かに縛られることはありません。';

  @override
  String get onbExploreOwn => '自分で探してみます';

  @override
  String get onbToneTitle => 'どちらがあなたに近いですか？';

  @override
  String get onbToneIntrovertTitle => 'どちらかというと内向的です';

  @override
  String get onbToneIntrovertBody => '心地よくいたいだけで、別の人間になりたいわけではありません。';

  @override
  String get onbToneSituationalTitle => '場面によって不安になります';

  @override
  String get onbToneSituationalBody => '社交的なときもありますが、特定の場面でつまずきます。';

  @override
  String get onbToneFootnote => 'プロフィールからいつでも変更できます。';

  @override
  String get onbHowTitle => 'こんなふうに進みます。';

  @override
  String get onbStartClimbing => '登りはじめる';

  @override
  String get onbStep1 => 'どれくらいつらく感じるか予測します（0〜10）。';

  @override
  String get onbStep2 => '実際にやってみます — アプリは閉じていて大丈夫です。';

  @override
  String get onbStep3 => '戻ってきて、実際どうだったかを記録します。';

  @override
  String get onbGentleFirstStep => 'やさしい最初の一歩';

  @override
  String get onbGoodPlaceToStart => '始めるのに良い場所';

  @override
  String get onbAllAreas => '6つの領域すべてがホーム画面にあります — どこからでも始められます。';

  @override
  String get predictAppBar => '行く前に';

  @override
  String get predictSaved => '保存しました。やってみて — 戻ってきて結果を記録してください。';

  @override
  String get predictQuestion => 'どれくらいつらくなると思いますか？';

  @override
  String get predictNoteLabel => '何が起きると予想しますか？（任意）';

  @override
  String get predictNoteHint => '例：ぎこちないと思われる';

  @override
  String get predictCompare => 'これを実際の結果と比べます。その差こそが、すべての要点です。';

  @override
  String get predictDoIt => 'やってみます';

  @override
  String get reflectAppBar => 'どうでしたか？';

  @override
  String get reflectDidYouDoIt => '実行できましたか？';

  @override
  String get reflectHowAnxious => '考えるだけで、どれくらい不安でしたか？';

  @override
  String get reflectHowBad => '実際には、どれくらいつらかったですか？';

  @override
  String get reflectNoteLabel => '覚えておきたいことはありますか？（任意）';

  @override
  String get reflectOutcomeDone => 'できた';

  @override
  String get reflectOutcomePartial => '一部できた';

  @override
  String get reflectOutcomeNotToday => '今日はしない';

  @override
  String get resultQuietDelight => '一歩ごとの静かな喜び。';

  @override
  String get resultBackToLadder => 'はしごに戻る';

  @override
  String resultGapHeadline(int predicted, int actual) {
    return '$predicted を覚悟していました。実際は $actual でした。';
  }

  @override
  String resultGapSub(int predicted, int actual) {
    return '心は重い $predicted に備えていましたが、世界はもっとやさしい $actual で迎えてくれました。覚えておく価値があります。';
  }

  @override
  String get resultRightHeadline => '予想どおりでした。';

  @override
  String get resultRightSub => '言い当てた — それでも、あなたは踏み出しました。それが勝利です。';

  @override
  String get resultTougherHeadline => '予想より大変でした — それでもやり遂げました。';

  @override
  String get resultTougherSub => '求められるものが大きい瞬間もあります。それでも踏み出すことが、すべての要点です。';

  @override
  String get resultPredicted => '予測';

  @override
  String get resultActual => '実際';

  @override
  String resultLighter(int reduction) {
    return 'この瞬間は、恐れていたより $reduction% 軽くすみました';
  }

  @override
  String get resultSkippedHeadline => '記録しました — 焦らなくて大丈夫です。';

  @override
  String get resultSkippedSub => '「今日はしない」も立派な答えです。この段は、あなたの準備ができるまでここにあります。';

  @override
  String get resultWinCopied => '成果をコピーしました — 好きな場所に貼り付けてください。';

  @override
  String get resultCopyWin => '成果をコピー';

  @override
  String resultShareText(String rung) {
    return '避けていたことをやってみました：$rung。小さな一段を登りました。🪜 #Rung';
  }

  @override
  String get tracksTitle => 'あなたのコース';

  @override
  String get tracksSubtitle => '大きな自信へ、小さな一歩ずつ。';

  @override
  String get menuInsights => 'インサイト';

  @override
  String get menuIsThisRight => 'これは自分に合っていますか？';

  @override
  String tracksRungsCount(int done, int total) {
    return '$total 段中 $done 段';
  }

  @override
  String tracksClimbedCount(int done, int total) {
    return '$total 段中 $done 段を達成';
  }

  @override
  String get tracksContinueLabel => '続きから再開';

  @override
  String get tracksNextStepLabel => '次の一歩';

  @override
  String get tracksLoadError => 'コースを読み込めませんでした。';

  @override
  String get todayResume => '続きから再開';

  @override
  String get todayNext => '次の一歩';

  @override
  String get todayVariety => '少し違うこと';

  @override
  String get todayFresh => 'あなたの出発点';

  @override
  String get todayResumeCta => '記録を仕上げる';

  @override
  String get todayStartCta => 'はじめる';

  @override
  String todayMinutes(int min) {
    return '約 $min 分';
  }

  @override
  String get dashShareTooltip => '進捗を共有';

  @override
  String get dashWeeklyGoal => '週間目標';

  @override
  String dashStepsPerWeek(int count) {
    return '週 $count 歩';
  }

  @override
  String dashGoalPerWeek(int count) {
    return '$count/週';
  }

  @override
  String dashWeeklyProgress(int done, int goal) {
    return '今週は $goal 歩中 $done 歩を達成';
  }

  @override
  String get dashYourGrowth => 'あなたの成長';

  @override
  String get dashTodayError => '今日の一歩を読み込めませんでした。引っ張って再試行してください。';

  @override
  String get dashTodayAllClear =>
      '利用できるものはすべて達成しました — 自分の段を追加するか、もう一度挑戦して連続記録を続けましょう。';

  @override
  String get dashTakeABreak => 'ひと休みする';

  @override
  String get dashTakeABreakSub => '静かなゲームをいくつか — 端末と、または友だちと。';

  @override
  String get ladderTitleFallback => 'はしご';

  @override
  String get ladderLoadError => 'はしごを読み込めませんでした。';

  @override
  String get ladderAddOwn => '自分の段を追加';

  @override
  String ladderOfClimbed(int total) {
    return '$total 段中';
  }

  @override
  String get detailLoadError => '読み込めませんでした。';

  @override
  String get detailNotExist => 'この段はもう存在しません。';

  @override
  String get detailWhatToDo => 'やること';

  @override
  String get detailWhyHelps => 'なぜ効果があるのか';

  @override
  String get detailPastAttempts => 'これまでの挑戦';

  @override
  String get detailDoThis => 'これをやります';

  @override
  String get detailReattempt => '再挑戦をおすすめします — データが積み重なります。';

  @override
  String detailHistoryStat(int predicted, int actual) {
    return '予測 $predicted · 実際 $actual';
  }

  @override
  String customLimitPremium(int cap) {
    return '今月の上限（自分の段 $cap 個）に達しました — 来月にリセットされます。';
  }

  @override
  String get customLimitFree => '無料プランには自分の段が5個含まれます — アップグレードすると毎月さらに追加できます。';

  @override
  String get customDefaultWhat => '自分自身に課した挑戦。';

  @override
  String get customDefaultWhy => '自分で名づけた — だからこそ意味があります。';

  @override
  String get customSubtitle => 'あなたの状況は特別です — この段はあなただけのものです。';

  @override
  String get customWhatLabel => '何をしますか？';

  @override
  String get customWhatHint => '例：上司にフィードバックを求める';

  @override
  String get customNoteLabel => '自分へのメモ（任意）';

  @override
  String customDifficulty(int value) {
    return 'どれくらい難しく感じますか？ $value/10';
  }

  @override
  String get customAddToLadder => 'はしごに追加';

  @override
  String get paywallSwitchToFree => '無料プランに切り替え';

  @override
  String get paywallHeroTitle => 'ひとりで立ち向かわなくていい。';

  @override
  String get paywallHeroBody =>
      '毎日の練習はいつでも無料です。プレミアムは、あなたの味方になる専属コーチと、そばにいる大きなコミュニティを加えます — もっと先へ進む準備ができたときのために。';

  @override
  String get paywallWhatsIncluded => '含まれるもの';

  @override
  String get paywallPlusHeader => 'さらに、すべての加入者に';

  @override
  String get paywallBenefitCoach => 'いつでも使える専属コーチ — これからの場面を練習したり、終わったあとに話したり';

  @override
  String get paywallBenefitPods =>
      'ひとりではありません — より多くのサポートグループに参加（月額で3つ、年額は無制限）';

  @override
  String get paywallBenefitCustom => '自分だけのはしごを無制限に — 自分の段に上限なし';

  @override
  String get paywallBenefitDepth =>
      '準備ができたらもっと深く — 1コースあたり最大40段（無料でも10段の完全な流れ）';

  @override
  String get paywallPlusStreak => '連続記録の保護 — 1日抜けても連続記録は途切れません';

  @override
  String get paywallPlusInsights => 'より深いインサイト — 1か月をひと目で';

  @override
  String get paywallPlusShare => '共有カードの個人向けスタイル';

  @override
  String get paywallPlusPrivacy => 'いつでも非公開、いつでも広告なし';

  @override
  String get paywallYearly => '年額';

  @override
  String get paywallPerYear => '年あたり · 最もお得';

  @override
  String get paywallSave => '33% お得';

  @override
  String get paywallMonthly => '月額';

  @override
  String get paywallPerMonth => '月あたり';

  @override
  String get paywallSwitchYearly => '年額に切り替え';

  @override
  String get paywallSwitchMonthly => '月額に切り替え';

  @override
  String paywallStartYearly(String price) {
    return '年額をはじめる — $price';
  }

  @override
  String paywallStartMonthly(String price) {
    return '月額をはじめる — $price';
  }

  @override
  String get paywallRestore => '購入を復元';

  @override
  String paywallCurrentPlan(String plan) {
    return '現在のプラン：$plan。いつでも解約できます。';
  }

  @override
  String get paywallCancelAnytime => 'いつでも解約できます。中心となる機能はずっと無料です。';

  @override
  String get paywallSimulated =>
      'プレミアム有効（シミュレーション — 実際の購入には RevenueCat のキーを追加してください）。';

  @override
  String get paywallPlanUnavailable => 'そのプランは現在ご利用いただけません。しばらくしてからお試しください。';

  @override
  String get paywallThankYou => 'プレミアム有効 — ありがとうございます。🌱';

  @override
  String get paywallPurchaseFailed => '購入は完了しませんでした。料金は請求されていません。';

  @override
  String get paywallRestored => '購入を復元しました。';

  @override
  String get paywallNoRestore => 'このアカウントに以前の購入は見つかりませんでした。';

  @override
  String get paywallRestoreFailed => '今は復元できませんでした。しばらくしてからお試しください。';

  @override
  String get profileAddName => '名前を追加';

  @override
  String get profileLockTitle => 'プロフィールをロック';

  @override
  String get profileLockedSub => '非表示 — グループのメンバーは詳細を開けません。';

  @override
  String get profileUnlockedSub => 'グループのメンバーはアバターをタップして詳細を見られます。';

  @override
  String get profilePlanTitle => 'あなたのプラン';

  @override
  String get profilePremium => 'プレミアム';

  @override
  String get profileUpgrade => 'アップグレード';

  @override
  String get profileToneDesc =>
      'Rung は既定ではやさしく語りかけます。不安が場面によるものなら、少し力強いトーンのほうが合うかもしれません。';

  @override
  String get profileToneIntrovert => '内向型';

  @override
  String get profileToneSituational => '場面による';

  @override
  String get profileSafetySub => 'Rung の位置づけ — そして、さらに助けを求めるとき';

  @override
  String get profileBlockedTitle => 'ブロックしたメンバー';

  @override
  String get profileBlockedSub => 'ブロックした人を確認・解除します';

  @override
  String get profileRestoreTitle => '進捗を復元';

  @override
  String get profileRestoreSub => '連続記録とチャレンジをクラウドから取得します';

  @override
  String get profileRestoring => '復元中…';

  @override
  String get profileRestoreOk => 'クラウドから進捗を復元しました。';

  @override
  String profileRestoreFail(String error) {
    return '復元に失敗しました：$error';
  }

  @override
  String get profileLogout => 'ログアウト';

  @override
  String get profileChangePwTitle => 'パスワードの変更';

  @override
  String get profileChangePwSub => 'アカウントの新しいパスワードを設定します';

  @override
  String get profileChangePwSaved => 'パスワードを更新しました';

  @override
  String get profileSignedIn => 'ログイン中';

  @override
  String get profileLogoutConfirmTitle => 'ログアウトしますか？';

  @override
  String get profileLogoutConfirmBody => '進捗はクラウドに保存されており、再度ログインすると戻ります。';

  @override
  String get profileLoggingOut => 'ログアウト中…';

  @override
  String get profileRateTitle => 'Rung を評価';

  @override
  String get profileRateSub => '調子を教えてください — 本当に助かります';

  @override
  String get profilePrivacyTitle => 'プライバシーポリシー';

  @override
  String get profilePrivacySub => '保存するもの — そして端末に残るもの';

  @override
  String get profileTermsTitle => '利用規約';

  @override
  String get profileTermsSub => 'Rung を使うための取り決め';

  @override
  String get profileDeleteTitle => 'アカウントを削除';

  @override
  String get profileDeleteSub => 'アカウントとデータを完全に消去します';

  @override
  String get profileFooter => 'Rung · 練習であって治療ではありません。データはあなたのものです。';

  @override
  String get profileDeleteConfirmTitle => 'アカウントを削除しますか？';

  @override
  String get profileDeleteConfirmBody =>
      'アカウント、グループのメッセージ、保存された進捗が完全に削除されます。元に戻せません。';

  @override
  String get profileDelete => '削除';

  @override
  String get profileDeleting => 'アカウントを削除しています…';

  @override
  String get profileDeleteFail => 'アカウントを削除できませんでした。もう一度お試しください。';

  @override
  String get profileBioPlaceholder => '静かな登り手。';

  @override
  String get profileHaptics => '触覚フィードバック';

  @override
  String get profileHapticsSub => 'タップや達成時のやさしい振動';

  @override
  String get profileNotifications => '通知';

  @override
  String get profileNotificationsSub => 'この端末での Rung からの通知';

  @override
  String get profilePodAlerts => 'グループのメッセージ通知';

  @override
  String get profilePodAlertsSub => 'グループに投稿があったら知らせる';

  @override
  String get profileEnableNotifs => 'リマインダーを受け取るには、設定で通知を有効にしてください。';

  @override
  String get profileReminderHelp => 'いつ声をかけましょうか？';

  @override
  String get profileReminderTitle => 'やさしい毎日のリマインダー';

  @override
  String profileReminderOn(String time) {
    return '毎日 $time · スイッチをタップしてオフにできます';
  }

  @override
  String get profileReminderOff => '小さな一歩を促す、穏やかで罪悪感のない合図';

  @override
  String get profileAvatarTitle => 'アバターを選ぶ';

  @override
  String get profileAvatarSub => '変更できるのはあなただけです — グループの仲間にも表示されます。';

  @override
  String get commonClose => '閉じる';

  @override
  String get checkInMoodCalm => '穏やか';

  @override
  String get checkInMoodOkay => 'まあまあ';

  @override
  String get checkInMoodAnxious => '不安';

  @override
  String get checkInMoodLow => '落ち込み';

  @override
  String get checkInMoodTense => '緊張';

  @override
  String get checkInTitle => '今日はどんな気分で来ましたか？';

  @override
  String get checkInDismiss => '閉じる';

  @override
  String get checkInCalmCta => '穏やかなひとときを試す';

  @override
  String get checkInStepCta => '今日の一歩を見る';

  @override
  String get supportTitle => '抱えているものが大きそうですね。';

  @override
  String get supportBody =>
      'Rung は練習のためのツールで、危機対応サービスではありません。つらい状況にあるなら、今すぐ助けになれる人 — 信頼できる人や地域の相談窓口 — に連絡してください。あなたには本当の支えを受ける価値があります。';

  @override
  String get supportResources => '支援窓口を見る';

  @override
  String get progressChallenges => 'チャレンジ';

  @override
  String get progressCurrentStreak => '現在の連続記録';

  @override
  String get progressBestStreak => '最高の連続記録';

  @override
  String get progressThisWeek => '今週';

  @override
  String get progressCategoryBreakdown => 'カテゴリ別の内訳';

  @override
  String get insightsHistory => '履歴';

  @override
  String checkInAckTitle(String mood) {
    return '記録しました — 気分は「$mood」';
  }

  @override
  String get checkInAckGentle =>
      '正直に話してくれてありがとう。今日はやさしくいきましょう — 小さくてやさしいこと一つで十分です。';

  @override
  String get checkInAckStep => 'いいですね。準備ができたら、小さな一歩が勢いを保ってくれます。';

  @override
  String get sharePremiumPerk => '✨ カードのスタイルが増えるのはプレミアム特典です。';

  @override
  String get shareSeePremium => 'プレミアムを見る';

  @override
  String get shareText => '小さな勇気の一歩を、一段ずつ。🌱 #Rung';

  @override
  String get shareError => '共有を開けませんでした。もう一度お試しください。';

  @override
  String get shareTitle => '進捗を共有';

  @override
  String get shareSubtitle => '数字だけ — プライベートな内容は含みません。';

  @override
  String get shareCta => '共有';

  @override
  String get shareCardHeadline => '私の勇気ある一歩';

  @override
  String get shareCardFearsFaced => '向き合った不安';

  @override
  String get shareCardCurrentStreak => '現在の連続記録';

  @override
  String get shareCardBestStreak => '最高の連続記録';

  @override
  String get shareCardTagline => '人づきあいの不安に、小さな一段ずつ向き合う。';

  @override
  String get helpNow => '今すぐ助けて';

  @override
  String get helpCalmMoment => '穏やかなひととき';

  @override
  String get helpTabBreathe => '呼吸';

  @override
  String get helpTabGround => '落ち着く';

  @override
  String get helpTabSay => 'こう言う';

  @override
  String get helpBreatheIn => '吸って…';

  @override
  String get helpBreatheOut => '吐いて…';

  @override
  String get helpBreatheHint => '円に合わせて。急ぐ必要はありません。';

  @override
  String get helpGround5 => 'つ、目に見えるもの';

  @override
  String get helpGround4 => 'つ、触れられるもの';

  @override
  String get helpGround3 => 'つ、聞こえるもの';

  @override
  String get helpGround2 => 'つ、においを感じるもの';

  @override
  String get helpGround1 => 'つ、味わえるもの';

  @override
  String get helpGroundTitle => '心の中で、静かに数えて…';

  @override
  String get helpGroundHint => 'これが今この瞬間に戻してくれます — あなたが安全な場所へ。';

  @override
  String get helpOpener1 => 'ここの人たちとはどういうご関係ですか？';

  @override
  String get helpOpener2 => 'この場所、いいですね — 来たことはありますか？';

  @override
  String get helpOpener3 => '名前を覚えるのが苦手で — もう一度うかがえますか？';

  @override
  String get helpOpener4 => '今週は何をされていましたか？';

  @override
  String get helpExit1 => '飲み物を取ってきますね — お話しできてよかったです。';

  @override
  String get helpExit2 => '少し挨拶してきます、失礼します。';

  @override
  String get helpExit3 => 'どうぞ他の方とも — またあとで。';

  @override
  String get helpOpenersTitle => '気軽な話しかけ方';

  @override
  String get helpExitsTitle => 'スマートな切り上げ方';

  @override
  String get authEnterEmail => 'メールアドレスを入力してください';

  @override
  String get authBadEmail => 'このメールアドレスは正しくないようです';

  @override
  String get authEnterPassword => 'パスワードを入力してください';

  @override
  String get authMin6 => '6文字以上';

  @override
  String get authPwMismatch => 'パスワードが一致しません';

  @override
  String get authConfirmEmail =>
      'メールを確認してから、ログインしてください。（すぐに試したい場合は、Supabase Auth の設定でメール確認を無効にできます。）';

  @override
  String get authGenericError => '問題が発生しました。もう一度お試しください。';

  @override
  String get authCreateTitle => 'アカウントを作成';

  @override
  String get authWelcomeBack => 'おかえりなさい';

  @override
  String get authSignUpSub => 'グループに参加して、進捗を端末をまたいで安全に保ちましょう。';

  @override
  String get authSignInSub => 'ログインして、グループと同期された進捗にアクセスします。';

  @override
  String get authDisplayName => '表示名（任意）';

  @override
  String get authEmail => 'メールアドレス';

  @override
  String get authPassword => 'パスワード';

  @override
  String get authShowPassword => 'パスワードを表示';

  @override
  String get authHidePassword => 'パスワードを隠す';

  @override
  String get authConfirmPassword => 'パスワードを確認';

  @override
  String get authForgotPassword => 'パスワードをお忘れですか？';

  @override
  String get authResetTitle => 'パスワードをリセット';

  @override
  String get authResetBody =>
      'アカウントのメールアドレスを入力してください。新しいパスワードを設定するためのリンクをお送りします。';

  @override
  String get authResetSend => 'リンクを送信';

  @override
  String get authResetSent => 'そのメールアドレスに登録があれば、リンクをお送りしました。';

  @override
  String get authNewPassword => '新しいパスワード';

  @override
  String get authConfirmNewPassword => '新しいパスワード（確認）';

  @override
  String get authUpdatePasswordCta => 'パスワードを更新';

  @override
  String get authCreateCta => 'アカウントを作成';

  @override
  String get authSignInCta => 'ログイン';

  @override
  String get authHaveAccount => 'すでにアカウントを持っています';

  @override
  String get authNewAccount => '初めてです — アカウントを作成';

  @override
  String get authLegalPrefixSignUp => 'アカウントを作成すると、以下に同意したことになります：';

  @override
  String get authLegalPrefixSignIn => '続行すると、以下に同意したことになります：';

  @override
  String get authTerms => '利用規約';

  @override
  String get authAnd => ' および ';

  @override
  String get gamesIntro =>
      '集中と静けさのための穏やかなゲーム — 心が落ち着くと感じられる脳トレです。端末と対戦するか、友だちに渡してどうぞ。';

  @override
  String gamesBestMs(int ms) {
    return '最高 $ms ミリ秒';
  }

  @override
  String gamesBestLevel(int level) {
    return '最高レベル $level';
  }

  @override
  String gamesBest(String score) {
    return '最高 $score';
  }

  @override
  String gamesBestMoves(int moves) {
    return '最少 $moves 手';
  }

  @override
  String gamesWinsVsPhone(int count) {
    return '端末に $count 勝';
  }

  @override
  String get gameTitleReaction => '反応速度';

  @override
  String get gameTitleSequence => '順番記憶';

  @override
  String get gameTitleQuickMath => '計算スプリント';

  @override
  String get gameTitleMemory => '神経衰弱';

  @override
  String get gameSubReaction => '集中 · 緑になったらタップ';

  @override
  String get gameSubSequence => '記憶 · 見て、繰り返す';

  @override
  String get gameSub2048 => '戦略 · スワイプして合体';

  @override
  String get gameSubQuickMath => '暗算 · 30秒スプリント';

  @override
  String get gameSubTicTacToe => '端末と対戦 · または2人で';

  @override
  String get gameSubConnect4 => '端末と対戦 · または2人で';

  @override
  String get gameSubMemory => 'ひとりで · ペアを見つける';

  @override
  String get gameHelpTooltip => '遊び方';

  @override
  String gameHelpTitle(String game) {
    return '遊び方 · $game';
  }

  @override
  String get gameGotIt => 'わかりました';

  @override
  String get tierFree => '無料';

  @override
  String get tierMonthly => 'プレミアム · 月額';

  @override
  String get tierYearly => 'プレミアム · 年額';

  @override
  String get podsUnlimited => '無制限のグループ';

  @override
  String podsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 個のグループ',
    );
    return '$_temp0';
  }

  @override
  String get groupsSignedOutTitle => '小さくてやさしいグループに参加';

  @override
  String get groupsSignedOutBody =>
      'グループを安全であなたのものにするため、簡単なアカウントが必要です。練習の記録は非公開のまま、アカウントなしで使えます。';

  @override
  String get groupsSignInCta => '続けるにはログイン';

  @override
  String get groupsLoadError => 'グループを読み込めませんでした。引っ張って再試行してください。';

  @override
  String groupsJoined(String pod) {
    return '$pod に参加しました。準備ができたら挨拶してみてください。';
  }

  @override
  String get groupsJoinedNew => '新しいグループに参加しました。準備ができたら挨拶してみてください。';

  @override
  String get groupsNoPodFound => '今はグループが見つかりませんでした。もう一度お試しください。';

  @override
  String groupsLeaveTitle(String pod) {
    return '$pod を退出しますか？';
  }

  @override
  String get groupsLeave => '退出';

  @override
  String groupsLeft(String pod) {
    return '$pod を退出しました。';
  }

  @override
  String get groupsLeaveError => 'グループを退出できませんでした。もう一度お試しください。';

  @override
  String get groupsHeader => '小さなグループ、やさしい人たち';

  @override
  String get groupsYourPods => 'あなたのグループ';

  @override
  String get groupsDiscoverPods => 'グループを見つける';

  @override
  String get groupsJoinAnother => '別のグループに参加';

  @override
  String get groupsNoOthers => '今、参加できる他のグループはありません。';

  @override
  String groupsJoinedShort(String pod) {
    return '$pod に参加しました。';
  }

  @override
  String get groupsJoin => '参加';

  @override
  String get groupsPodOptions => 'グループの設定';

  @override
  String get groupsLeavePod => 'グループを退出';

  @override
  String groupsMembers(int count, int capacity) {
    return '$count/$capacity 人';
  }

  @override
  String groupsTierPods(String tier, String pods) {
    return '$tier では $pods に参加できます。';
  }

  @override
  String groupsCapacityTierPods(int capacity, String tier, String pods) {
    return '1グループあたり最大 $capacity 人。$tier では $pods に参加できます。';
  }

  @override
  String groupsInYourPods(String pods) {
    return '現在 $pods に参加中です';
  }

  @override
  String get groupsUpgradeBody => 'プレミアムでもっと参加できます — 月額で3つ、年額なら好きなだけ。';

  @override
  String get groupsSafetyLive =>
      'やさしくいきましょう。誰でもプロフィールから報告・ブロックできます。ロックされたプロフィールは非公開のままです。';

  @override
  String get groupsSafetyPreview => 'プレビューです。ログインを設定すると、グループは実際の管理付きチャットになります。';

  @override
  String get groupsLeaveBody => 'このグループのメッセージは表示されなくなります。あとで再参加できます。';

  @override
  String get podRulesTitle => 'グループのルール';

  @override
  String get podRulesIntro => 'グループは、全員が安心できてはじめて成り立ちます。参加すると、次に同意したことになります：';

  @override
  String get podRule1 => 'やさしくしてください。ここにいる誰もが、難しいことに取り組んでいます。';

  @override
  String get podRule2 => '嫌がらせ、憎悪、有害な内容は禁止です。決して。';

  @override
  String get podRule3 => '不快に感じる相手は、報告またはブロックしてください。';

  @override
  String get podRule4 => 'プライバシーを尊重してください — ここで共有されたことはここに留めます。';

  @override
  String get podRule5 =>
      'グループは仲間どうしの支え合いであり、危機対応サービスではありません。緊急時は専門家または地域の相談窓口に連絡してください。';

  @override
  String get podRulesAgree => '同意します — 参加する';

  @override
  String chatIntrosBeKind(int count, int capacity) {
    return '内向的な仲間 $count/$capacity 人 · やさしく';
  }

  @override
  String get chatHint => 'やさしい言葉をどうぞ…';

  @override
  String get chatPreviewBanner =>
      'プレビュー · メッセージは当面この端末に保存されます。実際の管理付きグループはアカウント導入とともに始まります。';

  @override
  String get chatYou => 'あなた';

  @override
  String get reportHarassment => '嫌がらせ・いじめ';

  @override
  String get reportHate => '憎悪または有害な表現';

  @override
  String get reportSpam => 'スパムまたは詐欺';

  @override
  String get reportUnsafe => '不安を感じる';

  @override
  String get reportOther => 'その他';

  @override
  String get memberPrivateTitle => '非公開プロフィール';

  @override
  String get memberPrivateBody =>
      'このメンバーはプロフィールを非公開にしています。チャットはできます — 必要なら報告やブロックもできます。';

  @override
  String memberStreak(int days) {
    return '$days 日連続';
  }

  @override
  String memberChallenges(int count) {
    return '$count 件のチャレンジ';
  }

  @override
  String memberClimbing(String track) {
    return '挑戦中：$track';
  }

  @override
  String get memberReport => '報告';

  @override
  String get memberBlock => 'ブロック';

  @override
  String get memberReportThanks => 'ありがとうございます — 確認します。';

  @override
  String get memberBlockToo => 'ブロックもする';

  @override
  String get memberBlocked => 'ブロックしました。相手のメッセージは表示されません。';

  @override
  String get memberBlockError => 'ブロックできませんでした。もう一度お試しください。';

  @override
  String get memberReportError => '報告を送信できませんでした。もう一度お試しください。';

  @override
  String get memberBlockConfirmTitle => 'このメンバーをブロックしますか？';

  @override
  String get memberBlockConfirmBody => 'お互いのメッセージが表示されなくなります。あとで解除できます。';

  @override
  String get memberSoonReporting => '報告機能は管理付きグループで有効になります（ログインするとご利用いただけます）。';

  @override
  String get memberSoonBlocking => 'ブロック機能は管理付きグループで有効になります（ログインするとご利用いただけます）。';

  @override
  String get memberWhatsWrong => 'どうされましたか？';

  @override
  String get memberFallback => 'メンバー';

  @override
  String get blockedUnblockError => 'ブロックを解除できませんでした。もう一度お試しください。';

  @override
  String blockedUnblocked(String name) {
    return '$name のブロックを解除しました。メッセージが再び表示されます。';
  }

  @override
  String get blockedIntro =>
      'ブロックすると、相手のメッセージがあなたに、あなたのメッセージが相手に、双方向で表示されなくなります。下から解除できます。';

  @override
  String get blockedLabel => 'ブロック済み';

  @override
  String get blockedUnblock => 'ブロック解除';

  @override
  String get blockedEmptyTitle => 'ブロックした人はいません';

  @override
  String get blockedEmptyBody =>
      'まだ誰もブロックしていません。ブロックすると相手のメッセージが双方向で表示されなくなります — いつでもここで解除できます。';

  @override
  String get chatCheckInPosted => 'お疲れさまです。グループへのチェックインを投稿しました。';

  @override
  String get chatCheckInError => '今はチェックインできませんでした。もう一度お試しください。';

  @override
  String get chatDeleteMsgTitle => 'メッセージを削除しますか？';

  @override
  String get chatDeleteMsgBody => 'グループの全員から削除されます。';

  @override
  String get chatReply => '返信';

  @override
  String get chatEdit => '編集';

  @override
  String get chatDailyPrompt => '今日のグループのお題';

  @override
  String get chatCheckedInToday => '今日チェックイン済み';

  @override
  String get chatDidMyStep => '一歩を踏み出しました';

  @override
  String chatCheckedInCount(int count) {
    return '$count 人がチェックイン';
  }

  @override
  String get chatNoMessages => 'まだメッセージはありません。ひとこと「こんにちは」も、勇気ある最初の一段です。';

  @override
  String get chatEditingMessage => 'メッセージを編集中';

  @override
  String chatReplyingTo(String name) {
    return '$name に返信';
  }

  @override
  String get chatYourself => '自分自身';

  @override
  String get chatMsgDeleted => 'このメッセージは削除されました';

  @override
  String get chatPrivateMember => '非公開メンバー';

  @override
  String chatBeKind(int count, int capacity) {
    return '$count/$capacity · やさしく';
  }

  @override
  String get chatDeletedMessageShort => '削除されたメッセージ';

  @override
  String get gameYouWin => 'あなたの勝ち！🎉';

  @override
  String get gamePhoneWins => '端末の勝ち';

  @override
  String get gamePhoneThinking => '端末が考えています…';

  @override
  String get gamePlayPhone => '端末と対戦';

  @override
  String get game2Players => '2人で';

  @override
  String get gameNewGame => '新しいゲーム';

  @override
  String get gameYou => 'あなた';

  @override
  String get gamePhone => '端末';

  @override
  String get gameDraws => '引き分け';

  @override
  String get tttP1Wins => 'プレイヤー1（X）の勝ち！🎉';

  @override
  String get tttP2Wins => 'プレイヤー2（O）の勝ち！🎉';

  @override
  String get tttYourTurn => 'あなたの番';

  @override
  String get tttP1Turn => 'プレイヤー1 · X';

  @override
  String get tttP2Turn => 'プレイヤー2 · O';

  @override
  String get tttP1Label => 'P1（X）';

  @override
  String get tttP2Label => 'P2（O）';

  @override
  String get tttRule1 => '3×3のマスに交互に印を置きます。';

  @override
  String get tttRule2 => '自分の印を縦・横・斜めのいずれかに3つ並べると勝ちです。';

  @override
  String get tttRule3 => '「端末と対戦」はシンプルなAIとの対戦です。「2人で」は毎回端末を渡して遊びます。';

  @override
  String get c4P1Wins => 'プレイヤー1の勝ち！🎉';

  @override
  String get c4P2Wins => 'プレイヤー2の勝ち！🎉';

  @override
  String get c4Turn => 'あなたの番 — 列をタップ';

  @override
  String get c4P1Turn => 'プレイヤー1 · 赤';

  @override
  String get c4P2Turn => 'プレイヤー2 · 黄';

  @override
  String get c4P1Label => 'P1';

  @override
  String get c4P2Label => 'P2';

  @override
  String get c4Rule1 => '列をタップしてコマを落とすと、いちばん下の空いた場所に落ちます。';

  @override
  String get c4Rule2 => '自分の色を縦・横・斜めのいずれかに4つ並べると勝ちです。';

  @override
  String get c4Rule3 => '「端末と対戦」はシンプルなAIとの対戦です。「2人で」は端末を渡して遊びます。';

  @override
  String get gameDraw => '引き分けです 🤝';

  @override
  String get gamePlayAgain => 'もう一度遊ぶ';

  @override
  String get gameStart => 'はじめる';

  @override
  String get g2048Rule1 => '上下左右にスワイプすると、すべてのタイルが動きます。';

  @override
  String get g2048Rule2 => '同じ数字のタイル2つが合わさり、2倍の数字になります。';

  @override
  String get g2048Rule3 => '合体を重ねて2048のタイルを作りましょう。盤面は埋まっていきます — 先を読んで！';

  @override
  String get g2048Score => 'スコア';

  @override
  String get g2048Best => '最高';

  @override
  String get g2048GameOver => 'ゲームオーバー';

  @override
  String get g2048Won => '2048を作りました！🎉';

  @override
  String get g2048SwipeToMerge => 'スワイプして合体';

  @override
  String get qmRule1 => '30秒間 — できるだけ多く解きましょう。';

  @override
  String get qmRule2 => '4つの選択肢から正しい答えをタップします。';

  @override
  String get qmRule3 => '間違えると2秒減るので、よく読んでください。';

  @override
  String qmTimeScored(Object score) {
    return '終了！ $score 問正解';
  }

  @override
  String qmBestSub(Object best) {
    return '最高 $best · 30秒、できるだけ多く答えましょう。';
  }

  @override
  String get qmStartSub => '30秒。間違えると2秒減ります。';

  @override
  String get qmCorrect => '正解';

  @override
  String get mmRule1 => 'カードをタップしてめくり、もう1枚めくります。';

  @override
  String get mmRule2 => '2つの絵文字が同じならそのまま、違えば裏に戻ります。';

  @override
  String get mmRule3 => 'できるだけ少ない手数で、すべてのペアを見つけましょう。';

  @override
  String mmAllMatched(Object moves) {
    return '$moves 手で全部そろいました！🎉';
  }

  @override
  String mmFindPairs(Object moves) {
    return 'ペアを見つけよう · $moves 手';
  }

  @override
  String mmBest(Object best) {
    return '最少：$best 手';
  }

  @override
  String get mmShuffle => 'シャッフル';

  @override
  String get rxTapStart => 'タップしてスタート';

  @override
  String get rxWaitGreen => '緑になるまで待って、素早くタップ';

  @override
  String get rxWait => '待って…';

  @override
  String get rxTapMoment => '緑になった瞬間にタップ';

  @override
  String rxBestRetry(Object ms) {
    return '最高 $ms ミリ秒 · タップで再挑戦';
  }

  @override
  String get rxTapRetry => 'タップで再挑戦';

  @override
  String get rxTooSoon => '早すぎます！';

  @override
  String get rxWaitRetry => '緑になるまで待って · タップで再挑戦';

  @override
  String get rxTap => 'タップ！';

  @override
  String get rxRule1 => '画面をタップして開始し、待ちます — 画面が琥珀色になります。';

  @override
  String get rxRule2 => '緑になった瞬間、できるだけ速くタップしてください。';

  @override
  String get rxRule3 => '早くタップするとやり直しです。時間（ミリ秒）は短いほど良い記録です。';

  @override
  String get smWatchRepeat => 'パターンを見てから、同じように繰り返します。';

  @override
  String get smWatch => '見て…';

  @override
  String smYourTurn(Object current, Object total) {
    return 'あなたの番 · $total 個中 $current 個目';
  }

  @override
  String smReachedBest(Object best, Object reached) {
    return '$reached まで到達 · 最高 $best';
  }

  @override
  String smReached(Object reached) {
    return '$reached まで到達';
  }

  @override
  String get smRule1 => 'タイルが一つずつ光るのを見ます。';

  @override
  String get smRule2 => '同じ順番でタイルをタップして繰り返します。';

  @override
  String get smRule3 => 'ラウンドごとに一つずつ増えます — どこまで行けるか試しましょう。';

  @override
  String smRound(Object round) {
    return 'ラウンド $round';
  }

  @override
  String get safetyScreenTitle => 'これは自分に合っていますか？';

  @override
  String get safetyPracticeTitle => 'Rung は練習であって、治療ではありません。';

  @override
  String get safetyIntro =>
      'Rung は自信と練習のためのツールです。日常の社会的な場面に、自分のペースで少しずつ向き合う手助けをします。心理療法でも、医療行為でも、診断でもありません。';

  @override
  String get safetyPoint1 =>
      '目標は、扱える程度の不安 — かつて避けていた場面で、少し楽に感じられるようになることです。別人になることではありません。';

  @override
  String get safetyPoint2 => 'スキップはいつでも大丈夫で、決して不利になりません。ここに恥をかかせる仕組みはありません。';

  @override
  String get safetyPoint3 => 'データはあなたのものです。すべてオフラインで動き、アカウントは不要です。';

  @override
  String get safetyMoreTitle => '単なる緊張以上の場合';

  @override
  String get safetyMoreBody =>
      '不安が日常生活に深刻な影響を与えている場合、または自分を傷つけたいと思うことがある場合は、資格のある専門家またはお住まいの地域の相談窓口にご連絡ください。それは強く健やかな一歩です — そして Rung はその代わりにはなりません。';

  @override
  String get legalLastUpdated => '最終更新：2026年6月';

  @override
  String legalQuestions(String email) {
    return 'ご質問は $email までご連絡ください。';
  }

  @override
  String get privacyTitle => 'プライバシーポリシー';

  @override
  String get privacyIntro =>
      'Rung は、人づきあいの自信を育てるための非公開の練習ツールです。収集する情報は可能な限り少なくし、あなたが書いた最も個人的な内容が端末を離れることはありません。このポリシーでは、何を保存し、なぜ保存するのかを説明します。';

  @override
  String get ppWhatStaysHead => '端末だけに残るもの';

  @override
  String get ppWhatStaysBody =>
      '振り返りのメモと予測のメモ — ある瞬間どう感じたかについて書いた個人的な内容 — は、端末上のアプリ内にのみ保存されます。当社のサーバーにアップロードされることは一切ありません。';

  @override
  String get ppCloudHead => 'クラウドに保存するもの';

  @override
  String get ppCloudBody =>
      'アカウントを作成すると、次の情報を保存します：メールアドレス（ログイン用。パスワードは暗号化され、当社が見ることはありません）、任意の表示名と自己紹介、そしてプライバシーロックの設定。コミュニティ（「グループ」）を運営するために、投稿したメッセージと、行ったブロックや報告を保存します。端末をまたいで進捗を安全に保つため、バックアップするのは数値のみです — 連続記録、達成したチャレンジ、不安の評価（予測と実際）、そして作成した自分の段。メモの本文が含まれることはありません。';

  @override
  String get ppAnalyticsHead => '分析';

  @override
  String get ppAnalyticsBody =>
      'どの機能が役立っているかを把握するため、プライバシーに配慮した製品分析（PostHog）を使用し、「画面を開いた」「一歩を完了した」といった匿名の利用イベントを記録します。メモやメッセージの内容を分析に送ることは一切ありません。';

  @override
  String get ppUseHead => '情報の利用方法';

  @override
  String get ppUseBody =>
      'アプリの提供のためだけに使用します：ログイン、グループの運営、進捗の復元、そして集計された匿名の傾向をもとにした Rung の改善。データを販売したり、広告に利用したりすることはありません。';

  @override
  String get ppProcessHead => 'データを処理する事業者';

  @override
  String get ppProcessBody =>
      'Supabase（認証・データベース・ホスティング）と PostHog（分析）をデータ処理者として利用しています。両社は自らのセキュリティおよびプライバシーの約束のもと、当社に代わってデータを扱います。';

  @override
  String get ppRightsHead => 'あなたの権利と選択';

  @override
  String get ppRightsBody =>
      'プロフィールを編集したり、他のメンバーに見えないようロックしたり、プロフィール → アカウントを削除 から、いつでもアカウントと関連するすべてのクラウドデータを完全に削除できます。データへのアクセスや削除のご依頼は、メールでも承ります。';

  @override
  String get ppSecurityHead => 'セキュリティと保存期間';

  @override
  String get ppSecurityBody =>
      'データは通信中に暗号化され、すべてのテーブルは行レベルのセキュリティで保護されているため、アクセスできるのは自分のデータ（および参加しているグループのメッセージ）だけです。データはアカウントを削除するか、削除をご依頼いただくまで保持します。';

  @override
  String get ppChildrenHead => 'お子さまについて';

  @override
  String get ppChildrenBody =>
      'Rung は16歳未満の方を対象としていません。お子さまがアカウントを作成したと思われる場合はご連絡ください。削除いたします。';

  @override
  String get ppMedicalHead => '医療行為ではありません';

  @override
  String get ppMedicalBody =>
      'Rung は段階的な練習を支えますが、心理療法・診断・医学的助言ではありません。危機的な状況にある場合は、地域の救急サービスまたは相談窓口にご連絡ください。';

  @override
  String get ppChangesHead => '変更';

  @override
  String get ppChangesBody =>
      'このポリシーを更新する場合は、上記の日付を変更し、重要な変更についてはアプリ内でお知らせします。';

  @override
  String get termsTitle => '利用規約';

  @override
  String get termsIntro =>
      '本規約は、アプリをご利用いただく際の、あなたと Rung との間の取り決めです。アカウントを作成するか Rung を利用することで、本規約に同意したことになります。';

  @override
  String get tosMedicalHead => '医療サービスではありません';

  @override
  String get tosMedicalBody =>
      'Rung はセルフヘルプと練習のためのツールであり、心理療法や医療ではなく、専門的な支援の代わりにはなりません。特定の結果を保証することはできません。危機的な状況にある場合、または自分や他者を傷つけるおそれがある場合は、直ちに地域の救急サービスにご連絡ください。';

  @override
  String get tosEligibilityHead => '利用資格';

  @override
  String get tosEligibilityBody =>
      'Rung のご利用は16歳以上の方に限られ、本規約に同意する権利を有している必要があります。';

  @override
  String get tosAccountHead => 'あなたのアカウント';

  @override
  String get tosAccountBody =>
      'ログイン情報は安全に保管してください — アカウント上の行為についてはあなたに責任があります。不正利用が疑われる場合は、速やかにご連絡ください。';

  @override
  String get tosCommunityHead => 'コミュニティのルール（グループ）';

  @override
  String get tosCommunityBody =>
      'グループはやさしさと支え合いのための場です。嫌がらせ、脅迫、侮辱、スパム、憎悪的または違法な内容の投稿を行わないこと、また他人の個人情報を共有しないことに同意していただきます。これらのルールに違反した内容の削除や、アカウントの停止を行う場合があります。他のメンバーはいつでもブロック・報告できます。';

  @override
  String get tosContentHead => 'あなたが投稿する内容';

  @override
  String get tosContentBody =>
      '書いた内容の権利はあなたに帰属します。グループに投稿することで、コミュニティが機能するよう、その内容を保存し、そのグループのメンバーに表示する許可を当社に与えることになります。共有する権利のないものは投稿しないでください。';

  @override
  String get tosSubsHead => 'サブスクリプション';

  @override
  String get tosSubsBody =>
      '一部の機能と追加の練習コンテンツは、有料サブスクリプションでご利用いただけます。課金が有効な場合、購入と更新はアプリストアが処理し、ストアのアカウントから管理または解約できます。価格や内容は、事前の通知のうえ変更されることがあります。';

  @override
  String get tosDisclaimerHead => '免責と責任';

  @override
  String get tosDisclaimerBody =>
      'Rung は「現状のまま」提供され、いかなる保証も行いません。法律が認める最大限の範囲において、アプリの利用から生じる間接的または結果的な損害について、当社は責任を負いません。';

  @override
  String get tosEndingHead => '利用の終了';

  @override
  String get tosEndingBody =>
      'プロフィール → アカウントを削除 から、いつでもアカウントを削除できます。本規約が重大にまたは繰り返し破られた場合、アクセスを停止または終了することがあります。';

  @override
  String get tosChangesHead => '変更';

  @override
  String get tosChangesBody =>
      '本規約を更新する場合があります。その際は上記の日付を更新し、重要な変更についてはアプリ内でお知らせします。Rung の利用を続けることは、更新後の規約に同意したことを意味します。';

  @override
  String get breatheCta => '不安を感じますか？ まず呼吸を';

  @override
  String get breatheIntro => '60秒。円に合わせるだけ。';

  @override
  String get breatheIn => '吸って';

  @override
  String get breatheHold => '止めて';

  @override
  String get breatheOut => '吐いて';

  @override
  String get breatheSkip => 'スキップ';

  @override
  String get breatheDoneTitle => 'これでおしまい。';

  @override
  String get breatheDoneSub => '少し落ち着きましたか？ 準備ができたら、あなたの一段へ。';

  @override
  String get breatheDoneBtn => '完了';

  @override
  String get insightsDeeperTitle => 'より深いインサイト';

  @override
  String get insightsLockedBody =>
      '1か月をひと目で — 不安が現実をどれだけ上回っていたか、そして何度それを高く見積もっていたか。プレミアム特典です。';

  @override
  String get insightsUnlockCta => 'プレミアムで解除';

  @override
  String get insightsNoSteps => '今月はまだ記録がありません。いくつか向き合うと、ここにまとめが表示されます。';

  @override
  String get insightsFearsFacedMonth => '今月向き合った不安';

  @override
  String insightsGapHotter(String points) {
    return 'あなたの不安は、平均して現実より $points ポイント高めでした。';
  }

  @override
  String get insightsGapTougher => '今月は現実のほうが予測より少し大変でした — それも勇気ある記録です。';

  @override
  String get insightsGapSpotOn => '今月の予測は、ほぼぴったりでした。';

  @override
  String insightsOverPredicted(int rate) {
    return '不安を高く見積もった割合は $rate% でした。';
  }

  @override
  String get insightsTrendSame => '先月と同じ';

  @override
  String insightsTrendMore(int count) {
    return '先月より $count 件多い';
  }

  @override
  String insightsTrendFewer(int count) {
    return '先月より $count 件少ない';
  }

  @override
  String get rateTitle => 'Rung はいかがですか？';

  @override
  String get ratePromptNone => 'Rung の使い心地はいかがですか？';

  @override
  String get ratePromptLow => 'お役に立てず申し訳ありません。何が足りませんか？';

  @override
  String get ratePromptMid => 'ありがとうございます — どうすれば5になりますか？';

  @override
  String get ratePromptHigh => 'とても励みになります。どんなところが好きですか？';

  @override
  String get rateHintLove => '気に入っている点はありますか？（任意）';

  @override
  String get rateHintMore => 'もう少し教えてください（任意）';

  @override
  String get rateSend => '送信';

  @override
  String get rateThanksHigh => 'ありがとうございます — 本当に励みになります。🌱';

  @override
  String get rateThanksLow => '正直なご意見をありがとうございます — 改善に役立てます。';

  @override
  String get editProfileTitle => 'プロフィールを編集';

  @override
  String get editDisplayName => '表示名';

  @override
  String get editDisplayNameHint => 'グループでは何と呼ばれたいですか？';

  @override
  String get editBio => 'ひとこと自己紹介（任意）';

  @override
  String get editBioHint => 'あなたについて一行 — プロフィールをロックすると非公開のままです。';

  @override
  String get errorOffline => 'オフラインです。インターネットに接続して、もう一度お試しください。';

  @override
  String get errorGeneric => '問題が発生しました。もう一度お試しください。';

  @override
  String get errorSaveFailed =>
      '保存できませんでした — 端末の空き容量が不足している可能性があります。空き容量を増やして、もう一度お試しください。';
}
