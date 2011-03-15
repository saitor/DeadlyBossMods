﻿if GetLocale() ~= "ruRU" then return end

local L

--------------------------
--  Halfus Wyrmbreaker  --
--------------------------
L = DBM:GetModLocalization("HalfusWyrmbreaker")

L:SetGeneralLocalization({
	name =	"Халфий Змеерез"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	ShowDrakeHealth		= "Показать здоровье подчиненного дракона\n(Должна быть включена опции отображения здоровья босса)"
})

L:SetMiscLocalization({
})

---------------------------
--  Valiona & Theralion  --
---------------------------
L = DBM:GetModLocalization("ValionaTheralion")

L:SetGeneralLocalization({
	name =	"Валиона и Тералион"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	YellOnEngulfing			= "Крикнуть если на вас $spell:86622",
	YellOnTwilightMeteor	= "Крикнуть если на вас $spell:88518",
	YellOnTwilightBlast		= "Крикнуть если на вас $spell:92898",
	TBwarnWhileBlackout		= "Показывать предупреждение о $spell:92898, когда активно $spell:86788",
	TwilightBlastArrow		= "Показывать стрелку DBM, когда $spell:92898 около вас",
	RangeFrame				= "Окно проверки дистанции (10)",
	BlackoutIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92878),
	EngulfingIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(86622)
})

L:SetMiscLocalization({
	Trigger1				= "Глубокий вдох",--Change this to what deep breath emote is.
	YellEngulfing			= "На МНЕ - Избыточная магия!",
	YellMeteor				= "На МНЕ - Сумеречный метеорит!",
	YellTwilightBlast		= "На МНЕ - Сумеречный взрыв!"
})

----------------------------------
--  Twilight Ascendant Council  --
----------------------------------
L = DBM:GetModLocalization("AscendantCouncil")

L:SetGeneralLocalization({
	name =	"Совет Перерожденных"
})

L:SetWarningLocalization({
	SpecWarnGrounded		= "Получите ауру заземления!",
	SpecWarnSearingWinds	= "Получите ауру кружащихся ветров!",
	warnGravityCoreJump		= "Гравитационное ядро на >%s<",
	warnStaticOverloadJump	= "Статическая перегрузка на >%s<"
})

L:SetTimerLocalization({
	timerTransition			= "Смена фаз"
})

L:SetOptionLocalization({
	SpecWarnGrounded		= "Показывать особое предупреждение, когда у вас не хватает ауры $spell:83581\n(~10сек перед началом применения)",
	SpecWarnSearingWinds	= "Показывать особое предупреждение, когда у вас не хватает ауры $spell:83500\n(~10сек перед началом применения)",
	timerTransition			= "Показывать таймер перехода в другую фазу",
	RangeFrame				= "Автоматически показывать окно проверки дистанции при надобности",
	YellOnLightningRod		= "Кричать, когда на вас $spell:83099",
	warnGravityCoreJump		= "Сообщать о целях, на которых распространяется $spell:92538",
	warnStaticOverloadJump	= "Сообщать о целях, на которых распространяется $spell:92467",
	HeartIceIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82665),
	BurningBloodIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82660),
	LightningRodIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(83099),
	GravityCrushIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(84948),
	FrostBeaconIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92307),
	StaticOverloadIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92067),
	GravityCoreIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92075)
})

L:SetMiscLocalization({
	Quake					= "Земля уходит у вас из-под ног...", -- Yell string: Земля поглатит вас!
	Thundershock			= "Воздух потрескивает от скопившейся энергии...", -- Yell string: Ветер, явись на мой зов!
	Switch					= "Закончим этот фарс!",--"We will handle them!" comes 3 seconds after this one
	Phase3					= "Ваше упорство...",--"BEHOLD YOUR DOOM!" is about 13 seconds after
	YellLightning			= "На МНЕ - Громоотвод!",
	Ignacious				= "Огнис",
	Feludius				= "Акварион",
	Arion					= "Аэрон",
	Terrastra				= "Террастра",
	Monstrosity				= "Элементиевое чудовище",
	Kill					= "Невозможно...."
})

----------------
--  Cho'gall  --
----------------
L = DBM:GetModLocalization("Chogall")

L:SetGeneralLocalization({
	name =	"Чо'Галл"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	YellOnCorrupting		= "Крикнуть если на вас $spell:93178",
	CorruptingCrashArrow	= "Показывать стрелку DBM, когда $spell:93178 около вас",
	InfoFrame				= "Показывать информационное окно для $spell:81701",
	RangeFrame				= "Показывать окно проверки дистанции (5м) для $spell:82235",
	SetIconOnWorship		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(91317),
	SetIconOnCreature		= "Установить иконки на Смутные творения"
})

L:SetMiscLocalization({
	YellCrash				= "На МНЕ - Оскверняющее сокрушение!",
	Bloodlevel				= "Порча"
})

----------------
--  Sinestra  --
----------------
L = DBM:GetModLocalization("Sinestra")

L:SetGeneralLocalization({
	name =	"Синестра"
})

L:SetWarningLocalization({
	WarnDragon			= "Появились сумеречные дракончики",
	WarnSlicerSoon		= "Сумеречное иссечение через %d сек!",
	WarnEggWeaken		= "С яиц убран сумеречный панцирь",
	SpecWarnSlicer		= "Скоро Сумеречное иссечение!",
	SpecWarnDispel		= "%d сек прошло после последнего Смятия - Рассейте!", -- not good translation. check if more better
	SpecWarnEggWeaken	= "Панцирь снят - Весь урон в яйца!", -- not good translation. check if more better
	SpecWarnEggShield	= "Панцирь восстановился!" -- not good translation. check if more better
})

L:SetTimerLocalization({
	TimerDragon			= "След. дракончики",
	TimerEggWeakening	= "Снятие зашиты с яиц",
	TimerEggWeaken		= "Восст. Сумеречного панциря" -- not good translation. check if more better
})

L:SetOptionLocalization({
	WarnDragon			= "Показывать предупреждение, когда появляются сумеречные дракончики",
	WarnSlicerSoon		= "Показывать предупреждение для $spell:92954 (До начало 5с, каждую 1с)\n(Expected warning. may not be accurate. Can be spammy.)",
	WarnEggWeaken		= "Показывать предупреждение кога спадает $spell:87654", -- not good translation. check if more better
	SpecWarnSlicer		= "Показывать особое предупреждение для $spell:92954\n(Expected warning. may not be accurate)",
	SpecWarnDispel		= "Показывать особое предупреждение для рассеивания $spell:92955\n(after certain time elapsed from casted/jumped)", -- not good translation. check if more better
	SpecWarnEggWeaken	= "Показывать особое предупреждение когда $spell:87654 снято", -- not good translation. check if more better
	SpecWarnEggShield	= "Показывать особое предупреждение когда $spell:87654 восстановлено", -- not good translation. check if more better
	TimerDragon			= "Показывать таймер до новых сумеречных дракончиков",
	TimerEggWeakening	= "Показывать таймер до снятия $spell:87654",
	TimerEggWeaken		= "Показывать таймер восстановления $spell:87654"
})

L:SetMiscLocalization({
	YellDragon			= "Ешьте, дети мои! Пусть их мясо насытит вас!",
	YellEgg				= "Ты так в этом уверен? Глупец!"   
})

--------------------------
--  The Bastion of Twilight Trash  --
--------------------------
L = DBM:GetModLocalization("BoTrash")

L:SetGeneralLocalization({
	name =	"Существа Сумеречного бастион"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	YellOnFlameStrike		= "Кричать, когда на вас $spell:93383"
})

L:SetMiscLocalization({
	YellFlameStrike			= "На МНЕ - Огненный столб!"
})