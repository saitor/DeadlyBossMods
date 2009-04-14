﻿if GetLocale() ~= "zhTW" then return end

local L


----------------------
--  FlameLeviathan  --
----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization{
	name = "烈焰戰輪"
}

L:SetTimerLocalization{
	timerPursued			= "獵殺: %s",
	timerFlameVents			= "烈焰外洩",
	timerSystemOverload		= "電路超載"
}
	
L:SetMiscLocalization{
	YellPull			= "發現敵意實體。啟動威脅評估協定。首要目標接近中。30秒後將再度評估。",
	Emote				= "%%s獵殺(%S+)%."
}

L:SetWarningLocalization{
	pursueTargetWarn		= "獵殺 >%s<!",
	warnNextPursueSoon		= "5秒後 獵殺轉換"
}

L:SetOptionLocalization{
	timerSystemOverload		= "顯示電路超載計時器",
	timerFlameVents			= "顯示烈焰外洩計時器",
	timerPursued			= "顯示獵殺計時器",
	SystemOverload			= "為電路超載顯示特別警告",
	SpecialPursueWarnYou		= "當獵殺時顯示特別警告",
	PursueWarn			= "當玩家中了獵殺時顯示團隊警告",
	warnNextPursueSoon		= "獵殺轉換前警告"
}


-------------
--  Ignis  --
-------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name = "『火爐之主』伊格尼司"
}

L:SetTimerLocalization{
	TimerFlameJetsCast		= "烈焰噴洩",
	TimerFlameJetsCooldown		= "下一次 烈焰噴洩",
	TimerScorch			= "下一次 灼燒",
	TimerScorchCast			= "灼燒",
	TimerSlagPot			= "熔渣之盆: %s"
}

L:SetWarningLocalization{
	WarningSlagPot			= "熔渣之盆: >%s<"
}

L:SetOptionLocalization{
	SpecWarnJetsCast		= "為烈焰噴洩顯示特別警告 (斷法)",
	TimerFlameJetsCast		= "顯示烈焰噴洩的施法計時器",
	TimerFlameJetsCooldown		= "顯示烈焰噴洩的冷卻計時器",
	TimerScorch			= "顯示灼燒的冷卻計時",
	TimerScorchCast			= "顯示灼燒的施法計時",
	WarningSlagPot			= "提示熔渣之盆的目標",
	TimerSlagPot			= "顯示熔渣之盆計時器"
}

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name = "銳鱗"
}

L:SetWarningLocalization{	
	SpecWarnDevouringFlame		= "吞噬烈焰 - 移動囉!!"
}
L:SetTimerLocalization{
	timerDeepBreathCooldown		= "下一次 火息術",
	timerDeepBreathCast		= "火息術",
}
L:SetOptionLocalization{
	timerDeepBreathCooldown		= "為下一次火息術顯示計時器",
	timerDeepBreathCast		= "顯示火息術的施法計時器",
	SpecWarnDevouringFlame		= "當你在吞噬烈焰的攻擊範圍時顯示特別警告",
	PlaySoundOnDevouringFlame	= "當受到吞噬烈焰時播放音效",
}


-------------
--  XT002  --
-------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization{
	name = "XT-002拆解者"
}

L:SetTimerLocalization{
	timerTympanicTantrumCast	= "躁怒施放",
	timerTympanicTantrum		= "躁怒",
	timerLightBomb			= "裂光彈: %s",
	timerGravityBomb		= "重力彈: %s",
}

L:SetWarningLocalization{
	SpecialWarningLightBomb 	= "你中了裂光彈!",
	WarningLightBomb		= "裂光彈: >%s<",
	SpecialWarningGravityBomb	= "你中了重力彈!",
	WarningGravityBomb		= "重力彈: >%s<",
}

L:SetOptionLocalization{
	timerTympanicTantrumCast	= "顯示躁怒的施法計時器",
	timerTympanicTantrum		= "顯示躁怒的持續時間計時器",
	SpecialWarningLightBomb		= "當你中了裂光彈時顯示特別警告",
	WarningLightBomb		= "提示裂光彈",
	timerLightBomb			= "顯示裂光彈計時器",
	SpecialWarningGravityBomb	= "當你中了重力彈時顯示特別警告",
	WarningGravityBomb		= "提示重力彈",
	timerGravityBomb		= "顯示重力彈計時器",
	PlaySoundOnGravityBomb		= "當你中了重力彈時播放音效",
	PlaySoundOnTympanicTantrum	= "躁怒時播放音效",
	SetIconOnLightBombTarget	= "設置標記在裂光彈的目標",
	SetIconOnGravityBombTarget	= "設置標記在重力彈的目標",
}

-------------------
--  IronCouncil  --
-------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization{
	name = "鐵之議會"
}

L:SetWarningLocalization{
	WarningSupercharge		= "超級充能 即將到來",
	WarningChainlight		= "閃電鏈",
	WarningFusionPunch		= "熔能拳擊",
	WarningOverwhelmingPower	= "極限威能: >%s<",
	WarningRuneofPower		= "力之符文",
	WarningRuneofDeath		= "死亡符文",
	RuneofDeath			= "死亡符文 - 移動",
	LightningTendrils		= "閃電觸鬚 - 跑開!",
}

L:SetTimerLocalization{
	TimerSupercharge		= "超級充能",
	TimerOverload			= "超載",
	TimerLightningWhirl		= "閃電旋風",
	TimerLightningTendrils		= "閃電觸鬚",
	timerFusionPunchCast		= "熔能拳擊施放",
	timerFusionPunchActive		= "熔能拳擊: %s",
	timerOverwhelmingPower		= "極限威能: %s",
	timerRunicBarrier		= "符刻屏障",
	timerRuneofDeath		= "死亡符文",
}

L:SetOptionLocalization{
	TimerSupercharge		= "顯示超級充能計時器",
	WarningSupercharge		= "當超級充能施放時顯示警告",
	WarningChainlight		= "提示閃電鏈",
	TimerOverload			= "顯示超載的施法計時器",
	TimerLightningWhirl		= "顯示閃電旋風的施法計時器",
	LightningTendrils		= "為閃電觸鬚顯示特別警告",
	TimerLightningTendrils		= "顯示閃電旋風的持續時間計時器",
	PlaySoundLightningTendrils	= "閃電觸鬚時播放音效",
	WarningFusionPunch		= "提示熔能拳擊",
	timerFusionPunchCast		= "為熔能拳擊顯示施法計時條",
	timerFusionPunchActive		= "顯示熔能拳擊計時器",
	WarningOverwhelmingPower	= "提示極限威能",
	timerOverwhelmingPower		= "顯示極限威能計時器",
	SetIconOnOverwhelmingPower	= "設置標記在極限威能的目標",
	timerRunicBarrier		= "顯示符刻屏障計時器",
	WarningRuneofPower		= "提示力之符文",
	WarningRuneofDeath		= "提示死亡符文",
	RuneofDeath			= "為死亡符文顯示特別警告",
	timerRuneofDeath		= "顯示死亡符文的持續時間計時器",
}

L:SetMiscLocalization{
	Steelbreaker			= "破鋼者",
	RunemasterMolgeim		= "符文大師墨吉姆",
	StormcallerBrundir 		= "風暴召喚者布倫迪爾",
}


---------------
--  Algalon  --
---------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization{
	name = "艾爾加隆"
}

L:SetTimerLocalization{
	TimerBigBangCast		= "大爆炸 施放",
}
L:SetWarningLocalization{
	WarningPhasePunch		= "相位拳擊: >%s<",
	WarningBlackHole		= "黑洞爆炸",
}

L:SetOptionLocalization{
	TimerBigBangCast		= "為大爆炸顯示施法計時條",
	SpecWarnPhasePunch		= "當你中了相位拳擊顯示特別警告",
	WarningPhasePunch		= "提示相位拳擊的目標",
	WarningBlackHole		= "提示黑洞爆炸",
}


----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization{
	name = "柯洛剛恩"
}

L:SetWarningLocalization{
	SpecialWarningEyebeam		= "集束目光看著你 - 跑開",
	WarningEyebeam			= "集束目光: >%s<"
}

L:SetTimerLocalization{
	timerEyebeam			= "集束目光: %s",
	timerPetrifyingBreath		= "石化之息",
	timerNextShockwave		= "下一個 震攝波",
	timerLeftArm			= "左臂 重生",
	timerRightArm			= "右臂 重生"
}

L:SetOptionLocalization{
	SpecialWarningEyebeam		= "當集束目光看著你顯示特別警告",
	WarningEyebeam			= "提示集束目光的目標",
	timerEyebeam			= "顯示集束目光的計時器",
	SetIconOnEyebeamTarget		= "設置標記在集束目光的目標",
	timerPetrifyingBreath		= "顯示石化之息的計時器",
	timerNextShockwave		= "顯示震攝波的計時器",
	timerLeftArm			= "顯示手臂重生(左) 的計時器",
	timerRightArm			= "顯示手臂重生(右) 的計時器"
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left		= "Just a scratch!",
	Yell_Trigger_arm_right		= "Only a flesh wound!"
}

---------------
--  Auriaya  --
---------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization{
	name = "奧芮雅"
}

L:SetMiscLocalization{
	Defender 			= "野性防衛者 (%d)"
}

L:SetWarningLocalization{
	SpecWarnBlast 			= "哨兵衝擊 - 打斷!",
	WarnCatDied 			= "野性防衛者倒下 (剩餘%d支)",
	WarnFear 			= "恐懼!",
	WarnFearSoon 			= "下一次恐懼即將到來!"
}

L:SetOptionLocalization{
	SpecWarnBlast	 		= "為哨兵衝擊顯示特別警告",
	WarnFear 			= "顯示恐懼警告",
	WarnFearSoon 			= "顯示即將恐懼警告",
	WarnCatDied 			= "當野性防衛者死亡時顯示警告"
}


-------------
--  Hodir  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization{
	name = "霍迪爾"
}

L:SetWarningLocalization{
	WarningFlashFreeze		= "閃霜",
	WarningBitingCold		= "刺骨之寒 - 移動"
}

L:SetTimerLocalization{
	TimerFlashFreeze		= "閃霜 即將到來",  -- all ppl have to move on the rock patches
}

L:SetOptionLocalization{
	TimerFlashFreeze		= "顯示閃霜的施放計時器",
	WarningFlashFreeze		= "為閃霜顯示警告",
}

L:SetMiscLocalization{
	PlaySoundOnFlashFreeze		= "當閃霜施放時播放音效",
}


--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization{
	name = "索林姆"
}

L:SetWarningLocalization{
	WarningStormhammer		= "風暴之錘: >%s<",
	UnbalancingStrike		= "失衡打擊: >%s<",
	WarningPhase2			= "第二階段",
	WarningBomb			= "引爆符文: >%s<",
	LightningOrb 			= "你中了閃電充能! 快跑!"
}

L:SetTimerLocalization{
	TimerStormhammer		= "風暴之錘冷卻",
	TimerUnbalancingStrike		= "失衡打擊冷卻",
	TimerHardmode			= "困難模式"
}

L:SetOptionLocalization{
	TimerStormhammer		= "顯示風暴之錘冷卻時間",
	TimerUnbalancingStrike		= "顯示失衡打擊計時器",
	TimerHardmode			= "顯示困難模式計時器",
	UnbalancingStrike		= "提示失衡打擊的目標",
	WarningStormhammer		= "提示風暴之錘的目標",
	WarningPhase2			= "提示第二階段",
	RangeFrame			= "顯示距離框"
}

L:SetMiscLocalization{
	YellPhase1			= "擅闖者!像你們這種膽敢干涉我好事的凡人將付出…等等--你……",
	YellPhase2			= "無禮的小輩，你竟敢在我的王座之上挑戰我?我會親手碾碎你們!"
}


-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization{
	name = "芙蕾雅"
}

L:SetMiscLocalization{
	SpawnYell 			= "孩子們，協助我!",
	WaterSpirit 			= "上古水之靈",
	Snaplasher 			= "猛攫鞭笞者",
	StormLasher 			= "風暴鞭笞者",
	EmoteTree 			= "???" -- /chatlog failed
}

L:SetWarningLocalization{
	WarnPhase2 			= "第二階段",
	WarnSimulKill			= "第一支小怪死亡 - 1分鐘後復活",
	WarnFury 			= "自然烈怒: >%s<",
	SpecWarnFury 			= "你中了自然烈怒!"
}

L:SetTimerLocalization{
	TimerUnstableSunBeam 		= "太陽光束: %s",
	TimerAlliesOfNature 		= "自然和諧冷卻",
	TimerSimulKill 			= "復活",
	TimerFuryYou 			= "你中了自然烈怒"
}


-------------------
--  Mimiron  --
-------------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization{
	name = "彌米倫"
}

L:SetWarningLocalization{
	WarningPlasmaBlast		= "離子衝擊: %s - 治療",
	Phase2Engaged			= "第二階段即將到來 - 現在重組",
	Phase3Engaged			= "第三階段即將到來 - 現在重組",
}

L:SetTimerLocalization{
	ProximityMines			= "新的環罩地雷",
}

L:SetOptionLocalization{
	WarningShockBlast		= "顯示震爆警告",
	WarningPlasmaBlast		= "顯示離子衝擊",
	ProximityMines			= "顯示環罩地雷計時器",
	PlaySoundOnShockBlast 		= "當震爆施放時播放音效",
}

L:SetMiscLocalization{
	YellPull			= "我們沒有太多時間，朋友們!你們要幫我測試我最新也是最偉大的創作。在你們改變心意之前，別忘了就是你們把XT-002搞得一團糟，你們欠我一次。",	
	YellPhase2			= "太好了!絕妙的良好結果!外殼完整度98.9%!幾乎只有一點擦痕!繼續下去。",
	YellPhase3			= "感謝你，朋友們!我們的努力讓我獲得了一些絕佳的資料!現在，我把東西放在哪兒了--噢，在這裡。",
}


--------------------
--  GeneralVezax  --
--------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization{
	name = "威札斯將軍"
}

L:SetWarningLocalization{
	WarningShadowCrash		= "你中了暗影暴擊",
	SpecialWarningSurgeDarkness	= "暗鬱奔騰",
	WarningShadowCrash		= "暗影暴擊: >%s<",
	specWarnLifeLeechYou		= "你中了無面者印記!",
	specWarnLifeLeechNear		= "接近你的%s中了無面者印記!"
}

L:SetTimerLocalization{
	timerSearingFlamesCast		= "灼熱烈焰",
	timerSurgeofDarkness		= "暗鬱奔騰",
	timerSaroniteVapors		= "下一次 薩倫煙霧"
}

L:SetOptionLocalization{
	WarningShadowCrash		= "為暗影暴擊顯示特別警告",
	timerSearingFlamesCast		= "顯示暗影暴擊計時器",
	timerSurgeofDarkness		= "顯示暗鬱奔騰計時器",
	timerSaroniteVapors		= "顯示薩倫煙霧計時器",
	SetIconOnShadowCrash		= "為暗影暴擊的目標設置標記(頭顱)",
	SetIconOnLifeLeach		= "為無面者印記的目標設置標記(十字)", --Life Leech
	SpecialWarningSurgeDarkness	= "為暗鬱奔騰顯示特別警告",
	SpecialWarningShadowCrash	= "為暗影暴擊顯示特別警告",
}

L:SetMiscLocalization{
	EmoteSaroniteVapors		= "一片薩倫煙霧在附近聚合!!"
}


-----------------
--  YoggSaron  --
-----------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
	name = "尤格薩倫"
}

L:SetMiscLocalization{
}

L:SetWarningLocalization{
}