﻿if GetLocale() ~= "ruRU" then return end

local L

--------------
--  Magmaw  --
--------------
L = DBM:GetModLocalization("Magmaw")

L:SetGeneralLocalization({
	name = "Магмарь"
})

L:SetWarningLocalization({
	SpecWarnInferno	= "Появляется Пыляющее костяное создание! (~4сек)",
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecWarnInferno	= "Предупреждать заранее о $spell:92190 (~4сек)",
	RangeFrame		= "Показывать окно проверки дистанции на второй фазе (5м)"
})

L:SetMiscLocalization({
	Slump			= "%s внезапно падает, выставляя клешки!",
	HeadExposed		= "%s насаживается на пику, обнажая голову!",
	YellPhase2		= "Непостижимо! Вы, кажется, можете уничтожить моего лавового червяка! Пожалуй, я помогу ему."
})

-------------------------------
--  Dark Iron Golem Council  --
-------------------------------
L = DBM:GetModLocalization("DarkIronGolemCouncil")

L:SetGeneralLocalization({
	name = "Защитная система Омнотрона"
})

L:SetWarningLocalization({
	SpecWarnActivated			= "Смена цели на: %s!",
	specWarnGenerator			= "Генератор энергии - Двигайтесь %s!"
})

L:SetTimerLocalization({
	timerArcaneBlowbackCast		= "Чародейская обратная вспышка",
	timerShadowConductorCast	= "Проводник тьмы",
	timerNefAblity				= "Восст. баффа", --Ability Buff CD
	timerArcaneLockout			= "Волшебный уничтожитель"
})

L:SetOptionLocalization({
	timerShadowConductorCast	= "Показывать таймер применения $spell:92053",
	timerArcaneBlowbackCast		= "Показывать таймер применения $spell:91879",
	timerArcaneLockout			= "Показывать таймер блокировки $spell:91542",
	timerNefAblity				= "Показывать таймер восстановления баффа (героический режим)",
	SpecWarnActivated			= "Показывать особое предупреждение при активации нового босса",
	specWarnGenerator			= "Показывать особое предупреждение, когда босс стоит в $spell:91557",
	YellOnChemBomb				= "Кричать, когда на вас $spell:80157",
	YellBombTarget				= "Кричать, когда на вас $spell:80094",
	YellOnLightning				= "Кричать, когда на вас $spell:79888",
	YellOnShadowCast			= "Кричать, когда на вас $spell:92053",
	YellOnTarget				= "Кричать, когда на вас $spell:92037",
	YellOnTargetLock			= "Кричать, когда на вас $spell:92023",
	AcquiringTargetIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79501),
	ConductorIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79888),
	ShadowConductorIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92053)
})

L:SetMiscLocalization({
	Magmatron					= "Магматрон",
	Electron					= "Электрон",
	Toxitron					= "Токситрон",
	Arcanotron					= "Чаротрон",
	SayBomb						= "На МНЕ - Ядовитая бомба!",
	YellLightning				= "На МНЕ - Проводник молний!",
	YellShadowCast				= "На МНЕ - Проводник тьмы!",
	YellTarget					= "На МНЕ - Выбор цели!",
	YellTargetLock				= "На МНЕ - Обрамляющие тени! Прочь от меня!",
	YellCloud					= "На МНЕ - Химическая бомба!"
})

----------------
--  Maloriak  --
----------------
L = DBM:GetModLocalization("Maloriak")

L:SetGeneralLocalization({
	name = "Малориак"
})

L:SetWarningLocalization({
	WarnPhase			= "%s фаза",
	WarnRemainingAdds	= "Осталось аберраций: %d"
})

L:SetTimerLocalization({
	TimerPhase			= "Следующая фаза"
})

L:SetOptionLocalization({
	WarnPhase			= "Предупреждать о переходе фаз",
	WarnRemainingAdds	= "Предупреждать об оставшемся количестве аберраций",
	TimerPhase			= "Показывать таймер до следующей фазы",
	RangeFrame			= "В ходе синей фазы, показывать окно проверки дистанции (6м)",
	SetTextures			= "Автоматически отключить \"Проецирование текстур\" в темной фазе\n(включается обратно при выходе из фазы)",
	FlashFreezeIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92979),
	BitingChillIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77760),
	ConsumingFlamesIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77786)
})

L:SetMiscLocalization({
	YellRed				= "красный|r пузырек в котел!",--Partial matchs, no need for full strings unless you really want em, mod checks for both.
	YellBlue			= "синий|r пузырек в котел!",
	YellGreen			= "зеленый|r пузырек в котел!",
	YellDark			= "магию на котле!",
	Red		     		= "Огненная",
	Blue				= "Ледяная",
	Green				= "Кислотная",
	Dark				= "Тёмная"
})

-----------------
--  Chimaeron  --
-----------------
L = DBM:GetModLocalization("Chimaeron")

L:SetGeneralLocalization({
	name = "Химерон"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	RangeFrame		= "Показывать окно проверки дистанции (6м)",
	SetIconOnSlime	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82935),
	InfoFrame		= "Показывать информационное окно со здоровьем (<10к хп)"
})

L:SetMiscLocalization({
	HealthInfo	= "Инфо о здоровье"
})

-----------------
--  Atramedes  --
-----------------
L = DBM:GetModLocalization("Atramedes")

L:SetGeneralLocalization({
	name = "Атрамед"
})

L:SetWarningLocalization({
	WarnAirphase			= "Воздушная фаза",
	WarnGroundphase			= "Наземная фаза",
	WarnShieldsLeft			= "Древний дворфийский щит - %d осталось",
	warnAddSoon				= "Призван Гнусный бес",
	specWarnAddTargetable	= "%s - активен"
})

L:SetTimerLocalization({
	TimerAirphase			= "Воздушная фаза",
	TimerGroundphase		= "Наземная фаза"
})

L:SetOptionLocalization({
	WarnAirphase			= "Показывать предупреждение, когда Атрамед взлетает",
	WarnGroundphase			= "Показывать предупреждение, когда Атрамед приземляется",
	WarnShieldsLeft			= "Показывать предупреждение, когда используется Древний дворфийский щит",
	warnAddSoon				= "Показывать предупреждение, когда Нефариан призывает помощников",
	specWarnAddTargetable	= "Показывать особое предупреждение, когда Гнусного беса можно взять в цель",
	TimerAirphase			= "Показывать таймер до следующей воздушной фазы",
	TimerGroundphase		= "Показывать таймер до следующей наземной фазы",
	InfoFrame				= "Показывать информационное окно для уровня звуков",
	YellOnPestered			= "Кричать, когда на вас $spell:92685",
	TrackingIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(78092)
})

L:SetMiscLocalization({
	AncientDwarvenShield	= "Древний дворфийский щит",
	Soundlevel				= "Уровень звука",
	YellPestered			= "На МНЕ - Гнусный бес!",--npc 49740
	NefAdd					= "Атрамед, они вон там!",
	Airphase				= "Да, беги! С каждым шагом твое сердце бьется все быстрее. Эти громкие, оглушительные удары... Тебе некуда бежать!"
})

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian-BD")	-- No conflict with BWL version :)

L:SetGeneralLocalization({
	name = "Нефариан"
})

L:SetWarningLocalization({
	OnyTailSwipe		= "Удар хвостом (Ониксия)",
	NefTailSwipe		= "Удар хвостом (Нефариан)",
	OnyBreath			= "Дыхание темного огня (Ониксия)",
	NefBreath			= "Дыхание темного огня (Нефариан)",
	specWarnShadowblazeSoon	= "Скоро Пламя тени (~5с)"
})

L:SetTimerLocalization({
	OnySwipeTimer		= "Удар хвостом - перезарядка (Ониксия)",
	NefSwipeTimer		= "Удар хвостом - перезарядка (Нефариан)",
	OnyBreathTimer		= "Дыхание темного огня (Ониксия)",
	NefBreathTimer		= "Дыхание темного огня (Нефариан)"
})

L:SetOptionLocalization({
	OnyTailSwipe		= "Показывать предупреждение для $spell:77827 Ониксии",
	NefTailSwipe		= "Показывать предупреждение для $spell:77827 Нефариана",
	OnyBreath			= "Показывать предупреждение для $spell:94124 Ониксии",
	NefBreath			= "Показывать предупреждение для $spell:94124 Нефариана",
	specWarnShadowblazeSoon	= "Показывать предупреждение для $spell:94085 (~5с)",
	OnySwipeTimer		= "Показывать таймер перезарядки для $spell:77827 Ониксии",
	NefSwipeTimer		= "Показывать таймер перезарядки для $spell:77827 Нефариана",
	OnyBreathTimer		= "Показывать таймер перезарядки для $spell:94124 Ониксии",
	NefBreathTimer		= "Показывать таймер перезарядки для $spell:94124 Нефариана",
	YellOnCinder		= "Кричать, когда на вас $spell:79339",
	RangeFrame			= "Показывать окно проверки дистанции (10м) когда на вас $spell:79339",
	InfoFrame			= "Показывать информационное окно для Электрического заряда Ониксии",
	SetIconOnCinder		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79339)
})

L:SetMiscLocalization({
	NefAoe				= "В воздухе трещат электрические разряды!",
	YellPhase2			= "Дерзкие смертные! Неуважение к чужой собственности нужно пресекать самым жестоким образом!",
	YellPhase3			= "Я пытался следовать законам гостеприимства, но вы все никак не умрете! Придется отбросить условности и просто... УБИТЬ ВАС ВСЕХ!",
	YellCinder			= "На МНЕ - Взрывчатая субстанция!",
	Nefarian			= "Нефариан",
	Onyxia				= "Ониксия",
	Charge				= "Электрический заряд"
})

--------------
--  Blackwing Descent Trash  --
--------------
L = DBM:GetModLocalization("BWDTrash")

L:SetGeneralLocalization({
	name = "Существа Твердыни Крыла Тьмы"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})