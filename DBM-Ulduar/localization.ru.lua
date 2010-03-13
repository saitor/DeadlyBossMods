﻿if GetLocale() ~= "ruRU" then return end

local L

-----------------------
--  Flame Leviathan  --
-----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization{
	name = "Огненный Левиафан"
}

L:SetTimerLocalization{
}
	
L:SetMiscLocalization{
	YellPull	= "Обнаружены противники. Запуск протокола оценки угрозы. Главная цель выявлена. Повторный анализ через 30 секунд.",
	Emote		= "%%s наводится на (%S+)%."
}

L:SetWarningLocalization{
	PursueWarn				= "Преследуется >%s<",
	warnNextPursueSoon		= "Смена цели через 5 секунд",
	SpecialPursueWarnYou	= "Преследует вас - бегите",
	SystemOverload			= "Отключение системы",
	warnWardofLife			= "Призыв Защитника жизни"
}

L:SetOptionLocalization{
	SystemOverload			= "Спец-предупреждение для Отключения системы",
	SpecialPursueWarnYou	= "Спец-предупреждение для Преследования",
	PursueWarn				= "Объявлять преследуемого игрока",
	warnNextPursueSoon		= "Предупреждать перед следующим преследованием",
	warnWardofLife			= "Спец-предупреждение для призыва Защитника жизни"
}

--------------------------------
--  Ignis the Furnace Master  --
--------------------------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name = "Повелитель Горнов Игнис"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	WarningSlagPot		= ">%s< в шлаковом ковше",
	SpecWarnJetsCast	= "Огненная струя - прекратите чтение заклинаний"
}

L:SetOptionLocalization{
	SpecWarnJetsCast	= "Спец-предупреждение для Огненной струи",
	WarningSlagPot		= "Объявлять цели, помещенные в шлаковый ковш",
	SlagPotIcon			= "Устанавливать метки на цели в шлаковом ковше"
}

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name = "Острокрылая"
}

L:SetWarningLocalization{	
	SpecWarnDevouringFlame		= "Лавовая бомба - отбегите",
	warnTurretsReadySoon		= "Гарпунные пушки будут собраны через 20 секунд",
	warnTurretsReady			= "Гарпунные пушки собраны",
	SpecWarnDevouringFlameCast	= "Лавовая бомба на вас",
	WarnDevouringFlameCast		= "Лавовая бомба на |3-5(>%s<)" 
}

L:SetTimerLocalization{
	timerTurret1	= "Гарпунная пушка 1",
	timerTurret2	= "Гарпунная пушка 2",
	timerTurret3	= "Гарпунная пушка 3",
	timerTurret4	= "Гарпунная пушка 4",
	timerGrounded	= "на земле"
}

L:SetOptionLocalization{
	SpecWarnDevouringFlame		= "Спец-предупреждение, когда на вас Лавовая бомба",
	PlaySoundOnDevouringFlame	= "Звуковой сигнал, когда на вас Лавовая бомба",
	warnTurretsReadySoon		= "Пред-предупреждение для пушек",
	warnTurretsReady			= "Предупреждение для пушек",
	SpecWarnDevouringFlameCast	= "Спец-предупреждение, когда на вас применяется Лавовая бомба",
	timerTurret1				= "Отсчет времени до пушки 1",
	timerTurret2				= "Отсчет времени до пушки 2",
	timerTurret3				= "Отсчет времени до пушки 3 (25 чел.)",
	timerTurret4				= "Отсчет времени до пушки 4 (25 чел.)",
	OptionDevouringFlame		= "Объявлять цели заклинания Лавовая бомба (неточно)",
	timerGrounded			    = "Отсчет времени для наземной фазы"
}

L:SetMiscLocalization{
	YellAir				= "Дайте время подготовить пушки.",
	YellAir2			= "Огонь прекратился! Надо починить пушки!",
	YellGround			= "Быстрее! Сейчас она снова взлетит!",
	EmotePhase2			= "%%s обессилела и больше не может летать!",
	FlamecastUnknown	= DBM_CORE_UNKNOWN
}

----------------------------
--  XT-002 Deconstructor  --
----------------------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization{
	name = "Разрушитель XT-002"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	SpecialWarningLightBomb 	= "Опаляющий свет на вас",
	SpecialWarningGravityBomb	= "Гравитационная бомба на вас",
	specWarnConsumption			= "Увядание - отбегите"
}

L:SetOptionLocalization{
	SpecialWarningLightBomb		= "Спец-предупреждение, когда на вас Опаляющий свет",
	SpecialWarningGravityBomb	= "Спец-предупреждение, когда на вас Гравитационная бомба",
	specWarnConsumption			= "Спец-предупреждение, когда на вас Увядание",
	SetIconOnLightBombTarget	= "Устанавливать метки на цели заклинания Опаляющий свет",
	SetIconOnGravityBombTarget	= "Устанавливать метки на цели заклинания Гравитационная бомба"
}

--------------------
--  Iron Council  --
--------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization{
	name = "Железное Собрание"
}

L:SetWarningLocalization{
	WarningSupercharge	= "Суперзаряд"
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	WarningSupercharge			= "Предупреждение о применении заклинания Суперзаряд",
	PlaySoundLightningTendrils	= "Звуковой сигнал при Светящихся придатках",
	SetIconOnOverwhelmingPower	= "Устанавливать метки на цели заклинания Переполняющая энергия",
	SetIconOnStaticDisruption	= "Устанавливать метки на цели заклинания Статический сбой",
	AlwaysWarnOnOverload		= "Всегда предупреждать при Перегрузке (иначе, только когда босс в цели)",
	PlaySoundOnOverload			= "Звуковой сигнал при Перегрузке",
	PlaySoundDeathRune			= "Звуковой сигнал при Рунах смерти"
}

L:SetMiscLocalization{
	Steelbreaker		= "Сталелом",
	RunemasterMolgeim	= "Мастер рун Молгейм",
	StormcallerBrundir 	= "Буревестник Брундир"
}

----------------------------
--  Algalon the Observer  --
----------------------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization{
	name = "Алгалон Наблюдатель"
}

L:SetTimerLocalization{
	NextCollapsingStar		= "Вспыхивающая звезда",
	PossibleNextCosmicSmash	= "Кара небесная",
	TimerCombatStart		= "Битва начнется через"
}

L:SetWarningLocalization{
	WarningPhasePunch		= "Фазовый удар на |3-5(>%s<) - cтак %d",
	WarningCosmicSmash 		= "Кара небесная - взрыв через 4 секунды",
	WarnPhase2Soon			= "Скоро фаза 2",
	warnStarLow				= "У Вспыхивающей звезды мало здоровья"
}

L:SetOptionLocalization{
	WarningPhasePunch		= "Объявлять цели заклинания Фазовый удар",
	NextCollapsingStar		= "Отсчет времени до появления Вспыхивающей звезды",
	WarningCosmicSmash 		= "Предупреждение для Кары небесной",
	PossibleNextCosmicSmash	= "Отсчет времени до следующей Кары небесной",
	TimerCombatStart		= "Отсчет времени до начала боя",
	WarnPhase2Soon			= "Предупреждать заранее о фазе 2 (на ~23%)",
	warnStarLow				= "Спец-предупреждение, когда у Вспыхивающей звезды мало здоровья (на ~25%)"
}

L:SetMiscLocalization{
	YellPull				= "Ваши действия нелогичны. Все возможные исходы этой схватки просчитаны. Пантеон получит сообщение от Наблюдателя в любом случае.",
	YellKill				= "I have seen worlds bathed in the Makers' flames. Their denizens fading without so much as a whimper. Entire planetary systems born and raised in the time that it takes your mortal hearts to beat once. Yet all throughout, my own heart, devoid of emotion... of empathy. I... have... felt... NOTHING! A million, million lives wasted. Had they all held within them your tenacity? Had they all loved life as you do?",
	Emote_CollapsingStar	= "%s призывает вспыхивающие звезды!",
	Phase2					= "Узрите чудо созидания!",
	PullCheck				= "Алгалон подаст сигнал бедствия через (%d+) мин."
}

----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization{
	name = "Кологарн"
}

L:SetWarningLocalization{
	SpecialWarningEyebeam	= "Сосредоточенный взгляд на вас - бегите",
	WarningEyeBeam			= "Сосредоточенный взгляд на |3-5(>%s<)",
	WarnGrip				= "Каменная хватка на |3-5(>%s<)",
	SpecWarnCrunchArmor2	= "Хруст доспеха >%d< на вас"
}

L:SetTimerLocalization{
	timerLeftArm		= "Возрождение левой руки",
	timerRightArm		= "Возрождение правой руки",
	achievementDisarmed	= "Обезоружен"
}

L:SetOptionLocalization{
	SpecialWarningEyebeam	= "Спец-предупреждение, когда Сосредоточенный взгляд на вас",
	SpecWarnCrunchArmor2	= "Спец-предупреждение для Хруста доспеха (>=2 стаков)",
	WarningEyeBeam			= "Объявлять цель под воздействием Сосредоточенный взгляд",
	timerLeftArm			= "Отсчет времени до Возрождения левой руки",
	timerRightArm			= "Отсчет времени до Возрождения правой руки",
	achievementDisarmed		= "Отсчет времени для достижения Обезоружен",
	WarnGrip				= "Объявлять цели заклинания Каменная хватка",
	SetIconOnGripTarget		= "Устанавливать метки на цели заклинания Каменная хватка",
	SetIconOnEyebeamTarget	= "Устанавливать метки на цели заклинания Сосредоточенный взгляд (луна)",
	PlaySoundOnEyebeam		= "Звуковой сигнал при Сосредоточенном взгляде"
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left	= "Царапина...",
	Yell_Trigger_arm_right	= "Всего лишь плоть!",
	Health_Body				= "Кологарн",
	Health_Right_Arm		= "Правая рука",
	Health_Left_Arm			= "Левая рука",
	FocusedEyebeam			= "%s устремляет на вас свой взгляд!"
}

---------------
--  Auriaya  --
---------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization{
	name = "Ауриайа"
}

L:SetMiscLocalization{
	Defender = "Дикий эащитник (%d)",
	YellPull = "Вы зря сюда заявились!"
}

L:SetTimerLocalization{
	timerDefender	= "Возрождение Дикого защитника"
}

L:SetWarningLocalization{
	SpecWarnBlast	= "Удар часового - прерывание",
	SpecWarnVoid	= "Портал бездны - отбегите",
	WarnCatDied		= "Дикий эащитник погибает (осталось %d жизней)",
	WarnCatDiedOne	= "Дикий эащитник погибает (осталась 1 жизнь)",
	WarnFearSoon	= "Скоро следующий Ужасающий вопль"
}

L:SetOptionLocalization{
	SpecWarnBlast	= "Спец-предупреждение об Ударе часового (для прерывания)",
	SpecWarnVoid	= "Спец-предупреждение, когда на вас Дикая сущность",
	WarnFearSoon	= "Предупреждать заранее об Ужасающем вопле",
	WarnCatDied		= "Предупреждение, когда Дикий защитник погибает",
	WarnCatDiedOne	= "Предупреждение, когда у Дикого защитника остается 1 жизнь",
	timerDefender	= "Отсчет времени до возрождения Дикого защитника"
}

-------------
--  Hodir  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization{
	name = "Ходир"
}

L:SetWarningLocalization{
	WarningFlashFreeze	= "Мгновенная заморозка",
	specWarnBitingCold	= "Трескучий мороз - двигайтесь"
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	WarningFlashFreeze		= "Спец-предупреждение для Мгновенной заморозки",
	PlaySoundOnFlashFreeze	= "Звуковой сигнал при Мгновенной заморозке",
	YellOnStormCloud		= "Кричать, когда на вас Грозовая туча",
	SetIconOnStormCloud		= "Устанавливать метки на цели заклинания Грозовая туча",
	specWarnBitingCold		= "Спец-предупреждение, когда на вас Трескучий мороз"
}

L:SetMiscLocalization{
	YellKill	= "Наконец-то я... свободен от его оков…",
	YellCloud	= "На мне Грозовая Туча!"
}

--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization{
	name = "Торим"
}

L:SetWarningLocalization{
	LightningOrb	= "Поражение громом на вас - отбегите"
}

L:SetTimerLocalization{
	TimerHardmode	= "Высокая сложность"
}

L:SetOptionLocalization{
	TimerHardmode	= "Отсчет времени для высокой сложности",
	RangeFrame		= "Отображать окно допустимой дистанции",
	AnnounceFails	= "Объявлять игроков, потерпевших неудачу от Разряда молнии, в рейд-чат\n(требуются права лидера или помощника)",
	LightningOrb	= "Спец-предупреждение для Поражения громом"
}

L:SetMiscLocalization{
	YellPhase1	= "Незваные гости! Вы заплатите за то, что посмели вмешаться... Погодите, вы...",
	YellPhase2	= "Бесстыжие выскочки, вы решили бросить вызов мне лично? Я сокрушу вас всех!",
	YellKill	= "Придержите мечи! Я сдаюсь.",
	ChargeOn	= "Разряд молнии: %s",
	Charge		= "Потерпели неудачу от Разряда молнии (за эту попытку): %s" 
}

-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization{
	name = "Фрейя"
}

L:SetMiscLocalization{
	SpawnYell          = "Помогите мне, дети мои!",
	WaterSpirit        = "Древний дух воды",
	Snaplasher         = "Хватоплет",
	StormLasher        = "Грозовой плеточник",
	YellKill           = "Он больше не властен надо мной. Мой взор снова ясен. Благодарю вас, герои.",
	TrashRespawnTimer  = "Возрождение монстров"
}

L:SetWarningLocalization{
	WarnSimulKill	= "Первый союзник погибает - воскрешение через 1 минуту",
	SpecWarnFury	= "Гнев природы на вас",
	WarningTremor	= "Дрожание земли - остановите чтение заклинаний",
	WarnRoots		= ">%s< в корнях",
	UnstableEnergy	= "Нестабильная энергия - бегите"
}

L:SetTimerLocalization{
	TimerSimulKill	= "Воскрешение"
}

L:SetOptionLocalization{
	WarnSimulKill	= "Объявлять, когда первый монстр погибает",
	WarnRoots		= "Объявлять цели Железных корней",
	SpecWarnFury	= "Спец-предупреждение, когда на вас Гнев природы",
	WarningTremor	= "Спец-предупреждение для Дрожания земли (высокая сложность)",
	PlaySoundOnFury = "Звуковой сигнал, когда на вас Гнев природы",
	TimerSimulKill	= "Отсчет времени до воскрешения монстров",
	UnstableEnergy	= "Спец-предупреждение для Нестабильной энергии"
}

----------------------
--  Freya's Elders  --
----------------------
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization{
	name = "Древни Фрейи"
}

L:SetMiscLocalization{
	TrashRespawnTimer	= "Возрождение монстров"
}

L:SetWarningLocalization{
	SpecWarnGroundTremor	= "Дрожание земли - остановите чтение заклинаний!",
	SpecWarnFistOfStone		= "Каменные кулаки"
}

L:SetOptionLocalization{
	SpecWarnFistOfStone		= "Спец-предупреждение для Каменных кулаков",
	SpecWarnGroundTremor	= "Спец-предупреждение для Дрожания земли",
	PlaySoundOnFistOfStone	= "Звуковой сигнал при Каменных кулаках",
	TrashRespawnTimer		= "Отсчет времени до возрождения монстров"
}

---------------
--  Mimiron  --
---------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization{
	name = "Мимирон"
}

L:SetWarningLocalization{
	DarkGlare			= "Лазерное заграждение",
	MagneticCore		= "Магнитное ядро у |3-1(>%s<)",
	WarningShockBlast	= "Шоковый удар - бегите",
	WarnBombSpawn		= "Бомбот"
}

L:SetTimerLocalization{
	TimerHardmode	= "Высокая сложность - Самоуничтожение",
	TimeToPhase2	= "Фаза 2",
	TimeToPhase3	= "Фаза 3",
	TimeToPhase4	= "Фаза 4"
}

L:SetOptionLocalization{
	DarkGlare				= "Отсчет времени для Лазерного заграждения",
	TimeToPhase2			= "Отсчет времени для фазы 2",
	TimeToPhase3			= "Отсчет времени для фазы 3",
	TimeToPhase4			= "Отсчет времени для фазы 4",
	MagneticCore			= "Объявлять подобравших Магнитное ядро",
	HealthFramePhase4		= "Отображать индикатор здоровья в фазе 4",
	AutoChangeLootToFFA		= "Смена режима добычи на Каждый за себя в фазе 3",
	WarnBombSpawn			= "Объявлять Бомботов",
	TimerHardmode			= "Отсчет времени для высокой сложности",
	PlaySoundOnShockBlast	= "Звуковой сигнал при Взрыве плазмы",
	PlaySoundOnDarkGlare	= "Звуковой сигнал при Лазерном заграждении",
	ShockBlastWarningInP1	= "Спец-предупреждение для Взрыва плазмы в фазе 1",
	ShockBlastWarningInP4	= "Спец-предупреждение для Взрыва плазмы в фазе 4",
	RangeFrame				= "Показывать окно допустимой дистанции в фазе 1 (6 м)"
}

L:SetMiscLocalization{
	MobPhase1		= "Левиафан II",
	MobPhase2		= "VX-001 <Противопехотная пушка>",
	MobPhase3		= "Воздушное судно",
	YellPull		= "У нас мало времени, друзья! Вы поможете испытать новейшее и величайшее из моих изобретений. И учтите: после того, что вы натворили с XT-002, отказываться просто некрасиво.",
	YellHardPull	= "Так, зачем вы это сделали? Разве вы не видели надпись \"НЕ НАЖИМАЙТЕ ЭТУ КНОПКУ!\"? Ну как мы сумеем завершить испытания при включенном механизме самоликвидации, а?",
	YellPhase2		= "ПРЕВОСХОДНО! Просто восхитительный результат! Целостность обшивки – 98,9 процента! Почти что ни царапинки! Продолжаем!",
	YellPhase3		= "Спасибо, друзья! Благодаря вам я получил ценнейшие сведения! Так, а куда же я дел... – ах, вот куда.",
	YellPhase4		= "Фаза предварительной проверки завершена. Пора начать главный тест!",
	LootMsg			= "([^%s]+).*Hitem:(%d+)"
}

---------------------
--  General Vezax  --
---------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization{
	name = "Генерал Везакс"
}

L:SetTimerLocalization{
	hardmodeSpawn = "Саронитовый враг"
}

L:SetWarningLocalization{
	SpecialWarningShadowCrash		= "Темное сокрушение на вас - отбегите",
	SpecialWarningSurgeDarkness		= "Наплыв Тьмы",
	WarningShadowCrash				= "Темное сокрушение на |3-5(>%s<)",
	SpecialWarningShadowCrashNear	= "Темное сокрушение около вас - остерегайтесь",
	WarningLeechLife				= "Вытягивание жизни на |3-5(>%s<)",
	SpecialWarningLLYou				= "Вытягивание жизни на вас",
	SpecialWarningLLNear			= "Вытягивание жизни на |3-5(%s) около вас"
}

L:SetOptionLocalization{
	WarningShadowCrash				= "Объявлять цели заклинания Темное сокрушение",
	SetIconOnShadowCrash			= "Устанавливать метки на цели заклинания Темное сокрушение (череп)",
	SetIconOnLifeLeach				= "Устанавливать метки на цели заклинания Вытягивание жизни (крест)",
	SpecialWarningSurgeDarkness		= "Спец-предупреждение для Наплыва Тьмы",
	SpecialWarningShadowCrash		= "Спец-предупреждение для Темного сокрушения (должен быть в цели или фокусе хотя бы у одного члена рейда)",
	SpecialWarningShadowCrashNear	= "Спец-предупреждение о Темном сокрушении около вас",
	SpecialWarningLLYou				= "Спец-предупреждение, когда на вас Вытягивание жизни",
	SpecialWarningLLNear			= "Спец-предупреждение о Вытягивании жизни около вас",
	CrashWhisper					= "Отправлять сообщение целям заклинания Темное сокрушение",
	YellOnLifeLeech					= "Кричать, когда на вас Вытягивание жизни",
	YellOnShadowCrash				= "Кричать, когда на вас Темное сокрушение",
	WarningLeechLife				= "Объявлять цели заклинания Вытягивание жизни",
	hardmodeSpawn					= "Отсчет времени до появления Саронитового врага (высокая сложность)"
}

L:SetMiscLocalization{
	EmoteSaroniteVapors	= "Облако саронитовых паров образовывается поблизости!",
	CrashWhisper		= "Темное сокрушение на вас - бегите",
	YellLeech			= "Вытягивание жизни на мне!",
	YellCrash			= "Темное сокрушение на мне!"
}

------------------
--  Yogg-Saron  --
------------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
	name = "Йогг-Сарон"
}

L:SetMiscLocalization{
	YellPull 			= "Скоро мы сразимся с главарем этих извергов! Обратите гнев и ненависть против его прислужников!",
	YellPhase2	 		= "Я – это сон наяву.",
	Sara 				= "Сара",
	WarningYellSqueeze	= "Выдавливание на мне! Помогите!"
}

L:SetWarningLocalization{
	WarningGuardianSpawned 			= "Страж %d",
	WarningCrusherTentacleSpawned	= "Тяжелое щупальце",
	SpecWarnBrainLink 				= "Схожее мышление на вас",
	WarningSanity 					= "Эффект Здравомыслия: %d",
	SpecWarnSanity 					= "Эффект Здравомыслия: %d",
	SpecWarnGuardianLow				= "Прекратите атаковать этого Стража",
	SpecWarnMadnessOutNow			= "Доведение до помешательства заканчивается - выбегайте",
	WarnBrainPortalSoon				= "Портал через 3 секунды",	
	SpecWarnFervor					= "Рвение Сары на вас",
	SpecWarnFervorCast				= "Рвение Сары накладывается на вас",
	WarnEmpowerSoon					= "Приближается Сгущение тьмы!",
	SpecWarnMaladyNear				= "Душевная болезнь на |3-5(%s) около вас",
	SpecWarnDeafeningRoar			= "Оглушающий рев",
	specWarnBrainPortalSoon			= "Скоро Портал"
}

L:SetTimerLocalization{
	NextPortal	= "Следующий портал"
}

L:SetOptionLocalization{
	WarningGuardianSpawned			= "Предупреждение о появлении Стража",
	WarningCrusherTentacleSpawned	= "Предупреждение о появлении Тяжелого щупальца",
	WarningBrainLink				= "Объявлять цели заклинания Схожее мышление",
	SpecWarnBrainLink				= "Спец-предупреждение, когда на вас Схожее мышление",
	WarningSanity					= "Предупреждение, когда у вас мало Здравомыслия",
	SpecWarnSanity					= "Спец-предупреждение, когда у вас очень мало Здравомыслия",
	SpecWarnGuardianLow				= "Спец-предупреждение, когда у Стража (в фазе 1) мало здоровья (для бойцов)",
	WarnBrainPortalSoon				= "Предупреждать заранее о Портале разума",
	SpecWarnMadnessOutNow			= "Спец-предупреждение незадолго до окончания Доведения до помешательства",
	SetIconOnFearTarget				= "Устанавливать метки на цели заклинания Душевная болезнь",
	SpecWarnFervor					= "Спец-предупреждение, когда на вас Рвение Сары",
	SpecWarnFervorCast				= "Спец-предупреждение, когда на вас накладывается Рвение Сары (должна быть в цели или фокусе хотя бы у одного члена рейда)",
	specWarnBrainPortalSoon			= "Спец-предупреждение о следующем Портале",
	WarningSqueeze					= "Кричать, когда на вас Выдавливание",
	NextPortal						= "Отсчет времени до следующего Портала",
	SetIconOnFervorTarget			= "Устанавливать метки на цели заклинания Рвение Сары",
	SetIconOnMCTarget				= "Устанавливать метки на цели контроля над разумом",
	ShowSaraHealth					= "Показывать здоровье Сары в фазе 1 (должна быть в цели или фокусе хотя бы у одного члена рейда)",
	WarnEmpowerSoon					= "Предупреждать заранее о Сгущении тьмы",
	SpecWarnMaladyNear				= "Спец-предупреждение о Душевной болезни около вас",
	SpecWarnDeafeningRoar			= "Спец-предупреждение, когда применяется Оглушающий рев (молчание и для легендарного оружия)",
	SetIconOnBrainLinkTarget		= "Устанавливать метки на цели заклинания Схожее мышление"
}

