if GetLocale() ~= "esES" then return end

local L

------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "Bestias de Rasganorte"
}

L:SetMiscLocalization{
	Charge			= "^%%s glares at (%S+) and lets out",
	CombatStart		= "Desde las cavernas más oscuras y profundas de Las Cumbres Tormentosas: ¡Gormok el Empalador! ¡A luchar, héroes!",
	Phase3			= "The air itself freezes with the introduction of our next combatant, Icehowl! Kill or be killed, champions!"
}

L:SetOptionLocalization{
	WarningImpale				= "Mostrar aviso para Empalar",
	WarningFireBomb				= "Mostrar aviso para Bomba de fuego",
	WarningBreath				= "Mostrar aviso para Aliento articoShow warning for Arctic Breath",
--	WarningSpray				= "Mostrar aviso para Pulverizador paralizador",
	WarningRage					= "Mostrar aviso para Espumarajo",
	WarningCharge				= "Mostrar aviso para el objetivo a cargar",
	WarningToxin				= "Mostrar aviso para el objetivo de toxinas",
	WarningBile					= "Mostrar aviso para el objetivo de Bilis ardiente",
	SpecialWarningImpale3		= "Mostrar aviso especial para Emaplar(>=3 Stacks)",
	SpecialWarningFireBomb		= "Mostrar aviso especial para Bomba de Fuego en Ti",
	SpecialWarningSlimePool		= "Mostrar aviso especial Charco de baba",
	SpecialWarningSilence		= "Mostrar aviso especial para Silencio (bloqueo de hechizos)",
	SpecialWarningSpray			= "Mostrar aviso especial si te afecta Pulverizador paralizador",
	SpecialWarningToxin			= "Mostrar aviso especial si te afecta Toxina paralizadora",
	SpecialWarningBile			= "Mostrar aviso especial si te afecta Bilis ardiente",
	SpecialWarningCharge		= "Mostrar aviso especial si Aullahielo te mira",
	SpecialWarningChargeNear	= "Mostrar aviso especial si Aullahielo va a por ti",
	SetIconOnChargeTarget		= "Poner icono a por quien va",
	SetIconOnBileTarget			= "Poner icono quien tiene Bilis ardiente",
	ClearIconsOnIceHowl			= "Limpiar iconos despues de cargar",
	TimerNextBoss               = "Mostrar tiempo para el proximo boss"
}

L:SetTimerLocalization{
	TimerNextBoss				= "Proximo boss en"
}

L:SetWarningLocalization{
	WarningImpale				= "%s en >%s<",
	WarningFireBomb				= "Bomba de Fuego",
--	WarningSpray				= "%s en >%s<",
	WarningBreath				= "Aliento Artico",
	WarningRage					= "Espumarajo",
	WarningCharge				= "Carga a >%s<",
	WarningToxin				= "Toxina en >%s<",
	WarningBile					= "Bilis ardiente en >%s<",
	SpecialWarningImpale3		= "Empalar >%d< en Ti",
	SpecialWarningFireBomb		= "Bomba de Fuego en Ti",
	SpecialWarningSlimePool		= "Charco de babas, Muevete!",
	SpecialWarningSilence		= "Silencio en ~1.5 segundos!",
	SpecialWarningSpray			= "Pulverizador paralizador en Ti",
	SpecialWarningToxin			= "Toxina en Ti! Muevete!",
	SpecialWarningCharge		= "Te mira a ti! Muevete!",
	SpecialWarningChargeNear	= "Charge near You! Run!",
	SpecialWarningBile			= "Toxina en Ti!"
}



-------------------
-- Lord Jaraxxus --
-------------------
L = DBM:GetModLocalization("Jaraxxus")

L:SetGeneralLocalization{
	name = "Lord Jaraxxus"
}

L:SetWarningLocalization{
	WarnFlame				= "Llama de la Legión en >%s<",
	WarnTouch				= "Toque de Jaraxxus en >%s<",
	WarnNetherPower			= "Poder abisal en Jaraxxus! Dispelead Ya!",
	WarnPortalSoon			= "Portal abisal pronto!",
	WarnVolcanoSoon			= "Erupción infernal pronto!",
	SpecWarnFlesh			= "Incinerar carne en TI!",
	SpecWarnTouch			= "Toque de Jaraxxus en TI!",
	SpecWarnKiss			= "Beso de la Maestra",
	SpecWarnTouchNear		= "Toque de Jaraxxus en >%s< cerca de ti",
	SpecWarnFlame			= "Llama de la Legión! Corre!",
	SpecWarnNetherPower		= "Dispelead Ya!",
	SpecWarnFelInferno		= "Inferno vil! Corred Lejos!"
}

L:SetMiscLocalization{
	WhisperFlame			= "Llama de la Legion en TI!",
}

L:SetOptionLocalization{
	WarnFlame				= "Avisar de Llama de la Legion",
	WarnTouch				= "Mostrar aviso para Toque de Jaraxxus",
	WarnNetherPower			= "Avisar si Jaraxxus tiene Poder abisar (para dsipelear)",
	WarnPortalSoon			= "Pre-aviso para Portal abisal",
	WarnVolcanoSoon			= "Pre-aviso para Erupcion infernal",
	SpecWarnFlame			= "Aviso especial si tienes Llama de la Legion",
	SpecWarnFlesh			= "Aviso especial si tienes Incinerar carne",
	SpecWarnTouch			= "Aviso especial si tienes Toque de Jaraxxus",
	SpecWarnTouchNear		= "Aviso especial si tienes Toque de Jaraxxus cerca",
	SpecWarnKiss			= "Aviso especial si tienes Beso de la maestra",
	SpecWarnNetherPower		= "Aviso especial para Poder abisal(para dispelear a jaraxxus)",
	SpecWarnFelInferno		= "Aviso especial si estas cerca de Inferno vil",
	TouchJaraxxusIcon		= "Poner icono quien tenga Toque de Jaraxxus(X)",
	IncinerateFleshIcon		= "Poner icono quien tenga Carne (calavera)",
	LegionFlameIcon			= "Poner icono quien tenga Llama de la Legion(cuadrado)",
	LegionFlameWhisper		= "Send Whisper to Legion Flame target"
}


-----------------------
-- Faction Champions --
-----------------------
L = DBM:GetModLocalization("Champions")

L:SetGeneralLocalization{
	name = "Campeones de Facción"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
    WarnHellfire		= "Llamas infernales",
	SpecWarnHellfire	= "Llamas infernales! Vete lejos!"
}

L:SetMiscLocalization{
	Gorgrim		= "DK - Gorgrim Shadowcleave",		-- 34458
	Birana 		= "D - Birana Stormhoof",			-- 34451
	Erin		= "D - Erin Misthoof",				-- 34459
	Rujkah		= "H - Ruj'kah",					-- 34448
	Ginselle	= "M - Ginselle Blightslinger",		-- 34449
	Liandra		= "P - Liandra Suncaller",			-- 34445
	Malithas	= "P - Malithas Brightblade",		-- 34456
	Caiphus		= "PR - Caiphus the Stern",			-- 34447
	Vivienne	= "PR - Vivienne Blackwhisper",		-- 34441
	Mazdinah	= "R - Maz'dinah",					-- 34454
	Thrakgar	= "S - Thrakgar",					-- 34444
	Broln		= "S - Broln Stouthorn",			-- 34455
	Harkzog		= "WL - Harkzog",					-- 34450
	Narrhok		= "W - Narrhok Steelbreaker",		-- 34453
	YellKill	= "A shallow and tragic victory. We are weaker as a whole from the losses suffered today. Who but the Lich King could benefit from such foolishness? Great warriors have lost their lives. And for what? The true threat looms ahead - the Lich King awaits us all in death."
} 

L:SetOptionLocalization{
	WarnHellfire			= "Aviso cuando Harzog castea Llamas infernales",
	SpecWarnHellfire		= "Aviso especail cuando sufras el efecto de Llamas Infernales"
}


------------------
-- Valkyr Twins --
------------------
L = DBM:GetModLocalization("Twins")

L:SetGeneralLocalization{
	name = "Gemelas Val’kyrs"
}

L:SetTimerLocalization{
	TimerSpecialSpell	= "Siguiente Habilidad especial"	
}

L:SetWarningLocalization{
	WarnSpecialSpellSoon	= "Habilidad especial pronto!",
	SpecWarnSpecial		= "Cambia color!",
	SpecWarnEmpoweredDarkness	= "Empowered Darkness",
	SpecWarnEmpoweredLight		= "Empowered Light"
}

L:SetMiscLocalization{
	YellPull 	= "En el nombre de nuestro maestro oscuro. Para el Rey Exánime. Tú. Voluntad. Morir.",
	Fjola 		= "Fjola Penívea",
	Eydis		= "Eydis Penalumbra"
}

L:SetOptionLocalization{
	TimerSpecialSpell	= "Mostrar tiempo para la siguiente habilidad especial",
	WarnSpecialSpellSoon	= "Pre-aviso para la siguiente habilidad especial",
	SpecWarnSpecial		= "Mostrar aviso especial si tienes que cambiar de color",
	SpecWarnEmpoweredDarkness	= "Mostrar aviso especial para Empowered Darkness",
	SpecWarnEmpoweredLight		= "Mostrar aviso especial para Empowered Light"
}


------------------
-- Anub'arak --
------------------
L = DBM:GetModLocalization("Anub'arak_Coliseum")

L:SetGeneralLocalization{
	name 				= "Anub'arak"
}

L:SetTimerLocalization{
	TimerEmerge			= "Emerger en",
	TimerSubmerge		= "Sumersion en"
}

L:SetWarningLocalization{
	WarnEmerge			= "Anub'arak emergido",
	WarnEmergeSoon		= "Emerger en 10 seg",
	WarnSubmerge		= "Anub'arak sumergido",
	WarnSubmergeSoon	= "Sumersion en 10 seg",
	WarnPursue			= "Persigue a >%s<",
	SpecWarnPursue		= "Te persigue a ti!"
}

L:SetMiscLocalization{
	YellPull			= "This place will serve as your tomb!",
	Swarm				= "The swarm shall overtake you!",
	Emerge				= "%s emerges from the ground!",
	Burrow				= "%s burrows into the ground!"
}

L:SetOptionLocalization{
	WarnEmerge			= "Mostrar aviso para Emerger",
	WarnEmergeSoon		= "Mostrar pre-aviso para Emerger",
	WarnSubmerge		= "Mostrar aviso para Sumersion",
	WarnSubmergeSoon	= "Mostrar pre-aviso para Sumersion",
	SpecWarnPursue		= "Mostrar aviso especial si te sigue a ti",
	TimerEmerge			= "Mostrar tiempo para Emerger",
	TimerSubmerge		= "Mostrar tiempo para Sumerger",
	PlaySoundOnPursue	= "Reproducir sonidos si te persigue",
	PursueIcon			= "Poner icono en jugador",
	WarnPursue			= "Avisar jugador perseguido"
}
