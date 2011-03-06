﻿if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

--------------
--  Magmaw  --
--------------
L = DBM:GetModLocalization("Magmaw")

L:SetGeneralLocalization({
	name = "Faucemagma"
})

L:SetWarningLocalization({
	SpecWarnInferno	= "Ensamblaje osario llameante pronto (~4s)",
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
	Slump			= "¡%s cae hacia delante y deja expuestas sus tenazas!",
	HeadExposed		= "¡%s acaba empalado en el pincho y deja expuesta la cabeza!",
	YellPhase2		= "Inconceivable! You may actually defeat my lava worm! Perhaps I can help... tip the scales."--translate
})

L:SetOptionLocalization({
	SpecWarnInferno	= "Mostrar pre-aviso especial para $spell:92190 (~4s)",
	RangeFrame		= "Mostrar distancia en Fase 2 (5 yardas)"

})

-------------------------------
--  Dark Iron Golem Council  --
-------------------------------
L = DBM:GetModLocalization("DarkIronGolemCouncil")

L:SetGeneralLocalization({
	name = "Sistema de defensa de Omnotron"
})

L:SetWarningLocalization({
	SpecWarnActivated			= "Cambia el objetivo a %s!",
})

L:SetTimerLocalization({
	timerArcaneBlowbackCast		= "Retorno Arcano",
	timerShadowConductorCast	= "Conductor de las Sombras",
	timerNefAblity				= "CD de Bufo de Habilidad"
})

L:SetOptionLocalization({
	timerShadowConductorCast	= "Mostrar tiempo para lanzamiento de $spell:92053",
	timerArcaneBlowbackCast	= "Mostrar tiempo para lanzamiento de $spell:91879",
	timerNefAblity				= "Mostrar tiempo de CoolDown de las habilidades de bufos en heroico",
	SpecWarnActivated			= "Mostrar aviso especial cuando se activa un nuevo boss",
	YellBombTarget			= "Gritar cuando tengas $spell:80094",
	YellOnLightning				= "Gritar en $spell:79888",
	YellOnShadowCast			= "Gritar en $spell:92053",
	YellOnTarget				= "Gritar en $spell:92037",
	YellOnTargetLock			= "Gritar en $spell:92023",
	AcquiringTargetIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79501),
	ConductorIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79888),
	BombTargetIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(80094),
	ShadowConductorIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92053)
})

L:SetMiscLocalization({
	Magmatron	= "Magmatron",
	Electron	= "Electron",
	Toxitron	= "Toxitron",
	Arcanotron	= "Arcanotron",
	SayBomb		= "¡Bomba de veneno en mi!",
	YellLightning		= "¡Conductor de relámpagos en mi!",
	YellShadowCast		= "¡Conductor de las Sombras en mi!",
	YellTarget			= "¡Fijando objetivo en mi!",
	YellTargetLock		= "¡Sombras atrapantes! ¡Apartaos de mi!"

})

----------------
--  Maloriak  --
----------------
L = DBM:GetModLocalization("Maloriak")

L:SetGeneralLocalization({
	name = "Maloriak"
})

L:SetWarningLocalization({
	WarnPhase		= "Fase %s",
	WarnRemainingAdds	= "%d aberraciones restantes"
})

L:SetTimerLocalization({
	TimerPhase		= "Siguiente fase"
})

L:SetMiscLocalization({
	YellRed			= "rojo|r a la caldera!",
	YellBlue		= "azul|r a la caldera!",
	YellGreen		= "verde|r a la caldera!",
	YellDark		= "oscura|r en el caldero!",
	Red				= "Rojo",
	Blue			= "Azul",
	Green			= "Verde",
	Dark			= "Oscuro"
})

L:SetOptionLocalization({
	WarnPhase		= "Mostrar aviso de la fase que viene",
	WarnRemainingAdds	= "Mostrar un aviso con las aberraciones restantes",
	TimerPhase		= "Mostrar tiempo para la siguiente fase",	
	RangeFrame		= "Mostrar distancia (6 yardas) durante la fase azul",
	FlashFreezeIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92979),
	BitingChillIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77760),
	ConsumingFlamesIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77786)
})


-----------------
--  Chimaeron  --
-----------------
L = DBM:GetModLocalization("Chimaeron")

L:SetGeneralLocalization({
	name = "Chimaeron"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	RangeFrame		= "Mostrar distancia (6 yardas)",
	SetIconOnSlime	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82935),
	InfoFrame	= "Mostrar información sobre la vida (<10k vida)"
})

L:SetMiscLocalization({
	HealthInfo	= "Información de vida"
})

-----------------
--  Atramedes  --
-----------------
L = DBM:GetModLocalization("Atramedes")

L:SetGeneralLocalization({
	name = "Atramedes"
})

L:SetWarningLocalization({
	WarnAirphase		= "Fase aerea",
	WarnGroundphase		= "Fase en tierra",
	WarnShieldsLeft		= "Antiguo escudo enano usado - %d restantes",
	warnAddSoon				= "Maligno Execrable invocado",
	specWarnAddTargetable	= "%s es targeteable"
})

L:SetTimerLocalization({
	TimerAirphase		= "Siguente Fase aerea",
	TimerGroundphase	= "Siguente Fase en tierra"
})

L:SetOptionLocalization({
	WarnAirphase		= "Mostrar aviso cuando Atramedes levanta el vuelo",
	WarnGroundphase		= "Mostrar aviso cuando Atramedes aterriza",
	WarnShieldsLeft		= "Mostrar aviso cuando Antiguo escudo enano sea usado",
	warnAddSoon				= "Mostrar aviso especial cuando Nefarian invoca adds",
	specWarnAddTargetable	= "Mostrar aviso especial cuando los adds son targeteables",
	TimerAirphase		= "Mostrar tiempo para siguiente Fase aerea",
	TimerGroundphase	= "Mostrar tiempo para siguiente Fase en tierra",
	InfoFrame			= "Mostrar información de los niveles de sonido",
	YellOnPestered			= "Gritar cuando tengas $spell:92685",
	TrackingIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(78092)
})

L:SetMiscLocalization({
	AncientDwarvenShield	= "Antiguo escudo enano",
	Soundlevel				= "Nivel de sonido",
	YellPestered			= "¡Maligno Execrable en mi!",
	NefAdd					= "Atramedes, the heroes are right THERE!",--translate
	Airphase		= "¡Sí, corred! Con cada paso, vuestros corazones se aceleran. El latido, fuerte y clamoroso... Casi ensordecedor. ¡No podéis escapar!"
})

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian-BD")

L:SetGeneralLocalization({
	name = "Nefarian"
})

L:SetWarningLocalization({
	OnyTailSwipe		= "Latigazo de cola (Onyxia)",
	NefTailSwipe		= "Latigazo de cola (Nefarian)",
	OnyBreath			= "Aliento (Onyxia)",
	NefBreath			= "Aliento (Nefarian)",
	specWarnShadowblazeSoon	= "Llamarada de las Sombras pronto (~5s)"
})

L:SetTimerLocalization({
	OnySwipeTimer		= "Latigazo de cola CD (Ony)",
	NefSwipeTimer		= "Latigazo de cola CD (Nef)",
	OnyBreathTimer		= "Aliento CD (Ony)",
	NefBreathTimer		= "Aliento CD (Nef)"
})

L:SetOptionLocalization({
	OnyTailSwipe		= "Mostrar aviso para el $spell:77827 de Onyxia",
	NefTailSwipe		= "Mostrar aviso para el $spell:77827 de Nefarian",
	OnyBreath			= "Mostrar aviso para el $spell:94124 de Onyxia",
	NefBreath			= "Mostrar aviso para el $spell:94124 de Nefarian",
	specWarnShadowblazeSoon	= "Mostrar pre-aviso especial para $spell:94085 (~5s)",
	OnySwipeTimer		= "Mostrar tiempo de cooldown de $spell:77827 de Onyxia",
	NefSwipeTimer		= "Mostrar tiempo de cooldown de $spell:77827 de Nefarian",
	OnyBreathTimer		= "Mostrar tiempo de cooldown de $spell:94124 de Onyxia",
	NefBreathTimer		= "Mostrar tiempo de cooldown de $spell:94124 de Nefarian",
	YellOnCinder		= "Gritar cuando tengas $spell:79339",
	RangeFrame			= "Mostrar distancia (10 yardas) cuando tengas $spell:79339",
	InfoFrame				= "Mostrar información sobre la carga eléctrica de Onyxia",
	SetIconOnCinder		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79339)
})

L:SetMiscLocalization({
	NefAoe			= "¡El aire crepita cargado de electricidad!",
	YellPhase2		= "¡Os maldigo, mortales! ¡Ese cruel menosprecio por las posesiones de uno debe ser castigado con fuerza extrema!",--translate
	YellPhase3		= "He intentado ser un buen anfitrión, pero ¡no morís! Es hora de dejarnos de tonterías y simplemente... ¡MATAROS A TODOS!",--translate
	YellCinder		= "¡Cenizas explosivas en mi!",
	Onyxia				= "Onyxia",
	Charge				= "Carga Eléctrica"
})