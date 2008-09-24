﻿-- ------------------------------------------------------ --
--          Deadly Boss Mods - Sunwell Module             --
--             русская локализация вер .002               --
--              by Necros ariett@mail.ru                  --
--     Перевод сделан с неоценимой помощью гильдии        --
--              Гесс Ху @ Свежеватель Душ                 --
--                                                        --
--                                                        --
-- Все замечания по переводу и локализации этого и других --
--   модулей ДБМ присылайте на email ariett@mail.ru       --
-- ------------------------------------------------------ --






if GetLocale() == "ruRU" then

DBM_SUNWELL						= "Плато Солнечного Колодца"

-- Kalecgos
DBM_KAL_NAME					= "Калесгос"
DBM_KAL_DESCRIPTION 			= "Announces and shows timers for Frost Breath, Wild Magic and Curse of Boundless Agony."

DBM_KAL_KILL_NAME				= "Сатроварр Осквернитель"
DBM_KAL_DEMON_SHORT				= "Сатроварр"

DBM_KAL_OPTION_BREATH			= "Анонс Холодное Дыхание"
DBM_KAL_OPTION_PREBREATH		= "Показать \"скоро Холодное Дыхание\" Предупреждение"
DBM_KAL_OPTION_WM_WARN			= "Анонс Wild Magic"
DBM_KAL_OPTION_WM_WHISPER		= "Send whisper to Wild Magic targets"
DBM_KAL_OPTION_COA_WARN			= "Анонс Curse of Boundless Agony"
DBM_KAL_OPTION_COA_ICON			= "Set icon on Curse of Boundless Agony target"
DBM_KAL_OPTION_PORT_PREWARN		= "Показать \"скоро Портал\" Предупреждение"
DBM_KAL_OPTION_PORT_WARN		= "Анонс Порталов"
DBM_KAL_OPTION_WM_WARN2			= "Show Wild Magic debuff type"
DBM_KAL_OPTION_SHOWFRAME		= "Show Spectral Realm frame"
DBM_KAL_FRAME_UPWARDS			= "Expand Spectral Realm frame upwards"
DBM_KAL_FRAME_UPWARDS2			= "Expand upwards"
DBM_KAL_FRAME_COLORS			= "Use class colors"
DBM_KAL_OPTION_RANGE			= "Show range check frame"
DBM_KAL_OPTION_STRIKE			= "Announce Corrupting Strike"
DBM_KAL_OPTION_FRAME			= "Show health frame"

DBM_KAL_SPELLID_BREATH			= 44799
DBM_KAL_SPELLIDS_WM				= { -- DO NOT TRANSLATE
	[44978] = "Heal",	-- Healing done by spells and effects increased by 100%.
	[45001] = "Cast",	-- Casting time increased by 100%.
	[45002] = "Hit",	-- Chance to hit with melee and ranged attacks reduced by 50%.
	[45004] = "Crit",	-- Damage done by critical hits increased by 100%.
	[45006] = "Aggro",	-- Increases threat generated by 100%.
	[45010] = "Cost"	-- Spell and ability costs reduced by 50%.
}
DBM_KAL_SPELLID_COA1			= 45032
DBM_KAL_SPELLID_COA2			= 45034
DBM_KAL_SPELLID_PORT1			= 46021
DBM_KAL_SPELLID_BLAST			= 44866
DBM_KAL_SPELLID_BUFFET			= 45018
DBM_KAL_YELL_PULL				= "Аххх! Я больше никогда не буду рабом Малигоса! Осмелься бросить мне вызов – и я уничтожу тебя!"

DBM_KAL_WARN_BREATH				= "Холодное Дыхание"
DBM_KAL_WARN_BREATH_SOON		= "скоро Холодное Дыхание"
DBM_KAL_WHISPER_WM				= "Wild Magic: %s"
DBM_KAL_WARN_COA				= "Curse of Boundless Agony: >%s<"
DBM_KAL_WARN_PORT				= "Портал #%d: >%s< (Group %d)"
DBM_KAL_WARN_PORT_SOON			= "скоро Портал #%d"
DBM_KAL_WARN_STRIKE				= "Corrupting Strike on >%s<"

DBM_KAL_WARN_CASTTIME			= "+100% время каста"
DBM_KAL_WARN_HIT				= "-50% hit chance"
DBM_KAL_WARN_CRIT				= "+100% крит дамага"
DBM_KAL_WARN_AGGRO				= "+100% threat"
DBM_KAL_WARN_COST				= "-50% spell costs"
DBM_KAL_WARN_HEAL				= "+100% хила"

DBM_KAL_FRAME_TITLE				= "Spectral Realm"
DBM_KAL_MENU_LOCK				= "Закрепить рамку"
DBM_KAL_FRAME_HIDE				= "Скрыть рамку"

DBM_KAL_HEALTHFRAME_TITLE		= "Дракон/Демон ХП"

DBM_KAL_STATUS_MSG				= "Дракон: %d%%%% Демон: %d%%%%"

-- Brutallus 
DBM_BRUTALLUS_NAME				= "Бруталл" 
DBM_BRUTALLUS_DESCRIPTION		= "Анонс and shows timers for Burn and Enrage."  

DBM_BRUTALLUS_YELL_PULL			= "О, а вот и новые агнцы идут на заклание!"

DBM_BRUTALLUS_OPTION_BURN		= "Announce Burn"
DBM_BRUTALLUS_OPTION_BURN2		= "Announce jumped Burn debuffs"
DBM_BRUTALLUS_OPTION_BAR_BURN2	= "Jumped Burn: <target>"
DBM_BRUTALLUS_OPTION_METEOR		= "Announce Meteor"
DBM_BRUTALLUS_OPTION_STOMP		= "Announce Stomp"
DBM_BRUTALLUS_OPTION_BURN3		= "Set icon on Burn target"
DBM_BRUTALLUS_OPTION_BURN4		= "Show special warning when you have Burn"
DBM_BRUTALLUS_OPTION_DEL_BURN	= "Show delayed Burn timer"
DBM_BRUTALLUS_OPTION_DEL_BURN2	= "Show delayed Burn announce"
DBM_BRUTALLUS_OPTION_PRESTOMP	= "Show 5 sec warning for Stomp"

DBM_BRUTALLUS_WARN_BURN			= "Burn: >%s<"
DBM_BRUTALLUS_WHISP_BURN		= "Burn on you!"
DBM_BRUTALLUS_WARN_STOMP		= "Stomp: >%s<"
DBM_BRUTALLUS_WARN_METEOR		= "Meteor"
DBM_BRUTALLUS_WARN_DEL_BURN		= "15 sec Burn on >%s<"
DBM_BRUTALLUS_WARN_STOMP_SOON	= "Stomp in 5 sec"


-- Felmyst
DBM_FELMYST_NAME				= "Пророк Скверны"
DBM_FELMYST_DESCRIPTION			= "Анонсировать Кольцо Газа, Глубокое дыхание и Демонический Пар"

DBM_FELMYST_OPTION_SPECGAS		= "Показать спец. предупреждение for Gas Nova"
DBM_FELMYST_OPTION_GASSOON		= "Показать предупреждение \"Gas Nova soon\""
DBM_FELMYST_OPTION_BREATH_SOON	= "Показать предупреждение \"скоро Глубокий Вздох\""
DBM_FELMYST_OPTION_VAPOR		= "Анонс Demonic Vapor цель"

DBM_FELMYST_EMOTE_BREATH		= "%s глубоко вздыхает."

DBM_FELMYST_WARN_GAS			= "Gas Nova"
DBM_FELMYST_WARN_GAS_SOON		= "Gas Nova soon"
DBM_FELMYST_WARN_ENCAPS			= "Энкапсулэйт: >%s<"
DBM_FELMYST_WARN_AIR			= "Воздушная Фаза"
DBM_FELMYST_LAND_SOON			= "Земная Фаза через 10 сек"
DBM_FELMYST_BREATH_SOON_FMT		= "Глубокий Вздох #%d через 10 сек"
DBM_FELMYST_BREATH_SOON5_FMT	= "Глубокий Вздох #%d через 5 сек"
DBM_FELMYST_BREATH_NOW_FMT		= "Глубокий Вздох #%d"
DBM_FELMYST_ENCAPS_WARN_SAY		= "На мне Энкапсулейт! Убегайте!"
DBM_FELMYST_WARN_VAPOR			= "Demonic Vapor: >%s<"


-- Eredar Twins
DBM_TWINS_NAME					= "Близнецы"
DBM_TWINS_DESCRIPTION			= "Announces and shows timers for Shadow Blades, Shadow Nova, Pyrogenics and Conflagration."
DBM_TWINS_OPTION_BLADES			= "Announce Shadow Blades"
DBM_TWINS_OPTION_BUFF			= "Announce Pyrogenics"
DBM_TWINS_OPTION_BLOW			= "Announce Confounding Blow"
DBM_TWINS_OPTION_BLOW_SOON		= "Show \"Confounding Blow soon\" warning"
DBM_TWINS_OPTION_CONFLAG		= "Conflagration: Announce"
DBM_TWINS_OPTION_CONFLAG2		= "Conflagration: Whisper"
DBM_TWINS_OPTION_CONFLAG3		= "Conflagration: Special Warning"
DBM_TWINS_OPTION_CONFLAG4		= "Conflagration: Icon"
DBM_TWINS_OPTION_NOVA			= "Shadow Nova: Announce"
DBM_TWINS_OPTION_NOVA2			= "Shadow Nova: Whisper"
DBM_TWINS_OPTION_NOVA3			= "Shadow Nova: Special Warning"
DBM_TWINS_OPTION_NOVA4			= "Shadow Nova: Icon"
DBM_TWINS_OPTION_TOUCH1			= "Show special warning for Dark Touched debuffs"
DBM_TWINS_OPTION_TOUCH2			= "Show special warning for Fire Touched debuffs"

DBM_TWINS_MOB_WL				= "Главная чернокнижница Алитесса"
DBM_TWINS_MOB_SOCR				= "Леди Сакролаш"
DBM_TWINS_EMOTE_CONFLAG			= "Алайтесс воздействует на"
DBM_TWINS_EMOTE_NOVA			= "Sacrolash directs Shadow Nova at (.+)%."

DBM_TWINS_WARN_BLADES			= "Shadow Blades"
DBM_TWINS_WARN_NOVA_ON			= "Shadow Nova: >%s<"
DBM_TWINS_WARN_BUFF				= "Pyrogenics"
DBM_TWINS_WARN_CONFLAG_ON		= "Conflagration: >%s<"
DBM_TWINS_WARN_BLOW_SOON		= "Confounding Blow soon"
DBM_TWINS_WARN_BLOW				= "Confounding Blow"
DBM_TWINS_WHISPER_CONFLAG		= "Conflagration on you!"
DBM_TWINS_WHISPER_NOVA			= "Shadow Nova on you!"

DBM_TWINS_SPECWARN_SHADOW		= "Dark Touched: %d"
DBM_TWINS_SPECWARN_FIRE			= "Flame Touched: %d"


-- M'uru
DBM_MURU_NAME					= "М'ару"
DBM_MURU_DESCRIPTION			= "Announces Darkness, Fiends, Black Holes, Void Sentinels and humanoid spawns."
DBM_MURU_OPTION_VOID			= "Announce Void Sentinels"
DBM_MURU_OPTION_VOID_SOON		= "Show 5 sec warning for Void Sentinels"
DBM_MURU_OPTION_HUM				= "Announce Humanoids"
DBM_MURU_OPTION_HUM_SOON		= "Show 5 sec warning for Humanoids"
DBM_MURU_OPTION_DARKNESS		= "Announce Darkness and Fiends in phase 1"
DBM_MURU_OPTION_DARKNESS_SOON	= "Show \"Darkness/Fiends soon\" warning"
DBM_MURU_OPTION_HOLE_WARN		= "Announce Black Hole"
DBM_MURU_OPTION_HOLE_SOON_WARN	= "Show \"Black Hole soon\" warning"
DBM_MURU_OPTION_WARN_FIEND		= "Announce Fiends in phase 2"

DBM_MURU_ENTROPIUS				= "Энтропий"

DBM_MURU_DARKNESS_SOON			= "Darkness and Fiends in 5 sec"
DBM_MURU_DARKNESS_INC			= "Darkness and Fiends"
DBM_MURU_WARN_VOID_SOON			= "Void Sentinel in 5 sec"
DBM_MURU_WARN_VOID_NOW			= "Void Sentinel spawned"
DBM_MURU_WARN_HUMANOIDS_SOON	= "Humanoids in 5 sec"
DBM_MURU_WARN_HUMANOIDS_NOW		= "Humanoids spawned"
DBM_MURU_WARN_FIEND				= "Dark Fiend spawned"
DBM_MURU_WARN_BLACKHOLE			= "Black Hole spawned"
DBM_MURU_WARN_BLACKHOLE_SOON	= "Black Hole soon"
DBM_MURU_WARN_P2				= "Фаза 2"

-- Kil'jaeden
DBM_KIL_NAME					= "Кил'джеден"
DBM_KIL_DESCRIPTION				= "Announces Orbs, Darkness, Shield, Reflections and Fire Bloom"

DBM_KIL_OPTION_RANGE			= "Показывать рамку дистанции"
DBM_KIL_OPTION_SHIELD			= "Объявлять Shield of the Blue"
DBM_KIL_OPTION_ORB				= "Объявлять Orbs"
DBM_KIL_OPTION_FIRETARGET		= "Объявлять цели Fire Bloom"
DBM_KIL_OPTION_FIRESAY			= "Send chat message when you are afflicted by Fire Bloom"
DBM_KIL_OPTION_FIREWHISP		= "Send whisper to Fire Bloom targets"
DBM_KIL_OPTION_FIREICON			= "Вешать метку на цель Fire Bloom"
DBM_KIL_OPTION_SHOWFRAME		= "Показывать список целей Fire Bloom"
DBM_KIL_OPTION_WARNREFL			= "Объявлять Sinister Reflections"
DBM_KIL_OPTION_DARTS			= "Объявлять Flame Darts"
DBM_KIL_OPTION_DRAGONORB		= "Объявлять Dragon Orbs"

DBM_KIL_YELL_PULL				= "Жалкие твари уничтожены. Да будет так! Я сделаю то, что не удалось Саргерасу. Я выпущу кровь из этого мерзкого мира и стану истинным повелителем Пылающего Легиона! Конец близок! Да свершится падение этого мира!"
DBM_KIL_YELL_PHASE2_1			= "Враг среди вас!" -- this actually announces Sinister Reflections and not phase 2
DBM_KIL_YELL_PHASE2_2			= "Кому ты можешь верить!"

DBM_KIL_WARN_PHASE1				= "Фаза 2"
DBM_KIL_WARN_PHASE2				= "Фаза 3"
DBM_KIL_WARN_PHASE3				= "Фаза 4 - Метеоры"
DBM_KIL_WARN_PHASE4				= "Фаза 5 - Озверение"
DBM_KIL_WARN_SHIELD				= "Shield of the Blue"
DBM_KIL_WARN_DARKNESS			= "Darkness"
DBM_KIL_WARN_DARKNESS_SOON		= "Darkness soon"
DBM_KIL_WARN_ORB				= "Orb spawned"
DBM_KIL_WARN_ORBS				= "Orbs spawned"
--DBM_KIL_WARN_FIRE				= "Fire Bloom incoming"
DBM_KIL_WARN_FIRE_ON			= "Fire Bloom: >%s<"
DBM_KIL_WARN_DARKNESS_NOW		= "Darkness of a Thousand Souls"
DBM_KIL_WARN_REFLECTIONS		= "Sinister Reflections"
DBM_KIL_WARN_FIRE_SAY			= "Fire Bloom на мне!"
DBM_KIL_WARN_FIRE_WHISPER		= "Fire Bloom на тебе!"
DBM_KIL_WARN_DARTS_SOON			= "Flame Darts через 5 сек"
DBM_KIL_WARN_DARTS				= "Flame Darts"
DBM_KIL_WARN_DRAGORB_SOON		= "Dragon Orb через 5 сек"
DBM_KIL_WARN_DRAGORB_NOW		= "Dragon Orb spawned"


DBM_KIL_FRAME_TITLE				= "Fire Bloom"
DBM_KIL_MENU_LOCK				= DBM_KAL_MENU_LOCK
DBM_KIL_FRAME_COLORS			= DBM_KAL_FRAME_COLORS
DBM_KIL_FRAME_UPWARDS			= "Expand Fire Bloom target list upwards"
DBM_KIL_FRAME_UPWARDS2			= DBM_KAL_FRAME_UPWARDS2
DBM_KIL_FRAME_HIDE				= DBM_KAL_FRAME_HIDE
end