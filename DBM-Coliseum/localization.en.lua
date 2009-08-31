local L

------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "Northrend Beasts"
}

L:SetMiscLocalization{
	Charge			= "^%%s glares at (%S+) and lets out",
	CombatStart		= "Hailing from the deepest, darkest caverns of the Storm Peaks, Gormok the Impaler! Battle on, heroes!";
}

L:SetOptionLocalization{
	WarningImpale				= "Show warning for Impale",
	WarningFireBomb				= "Show warning for Fire Bomb",
	WarningBreath				= "Show warning for Arctic Breath",
--	WarningSpray				= "Show warning for Paralytic Spray",
	WarningRage					= "Show warning for Frothing Rages",
	WarningCharge				= "Show warning for Charge Target",
	WarningToxin				= "Show warning for Toxin Targets",
	WarningBile					= "Show warning for Burning Bile Targets",
	SpecialWarningImpale3		= "Show special warning for Impale (>=3 Stacks)",
	SpecialWarningFireBomb		= "Show special warning for Fire Bomb on You",
	SpecialWarningSlimePool		= "Show special warning for Slime Pool",
	SpecialWarningSilence		= "Show special warning for Spell Block",
	SpecialWarningSpray			= "Show special warning if you have Paralytic Spray",
	SpecialWarningToxin			= "Show special warning if you have Paralytic Toxin",
	SpecialWarningBile			= "Show special warning if you have Burning Bile",
	SpecialWarningCharge		= "Show special warning when Icehowl is about to charge You",
	SpecialWarningChargeNear	= "Show special warning when Icehowl charges near You",
	SetIconOnChargeTarget		= "Set Icon on Charge Target (skull)",
	SetIconOnBileTarget			= "Set Icon on Burning Bile Targets",
}

L:SetWarningLocalization{
	WarningImpale				= "%s on >%s<",
	WarningFireBomb				= "Fire Bomb",
--	WarningSpray				= "%s on >%s<",
	WarningBreath				= "Arctic Breath",
	WarningRage					= "Frothing Rages",
	WarningCharge				= "Charge on >%s<",
	WarningToxin				= "Toxin on >%s<",
	WarningBile					= "Burning Bile on >%s<",
	SpecialWarningImpale3		= "Impale >%d< on You",
	SpecialWarningFireBomb		= "Fire Bomb on You",
	SpecialWarningSlimePool		= "Slime Pool, Move out!",
	SpecialWarningSilence		= "Spell Block in ~1.5 Seconds!",
	SpecialWarningSpray			= "Paralytic Spray on You",
	SpecialWarningToxin			= "Toxin on You! Move!",
	SpecialWarningCharge		= "Charge on You! Run!",
	SpecialWarningChargeNear	= "Charge near You! Run!"
}



-------------------
-- Lord Jaraxxus --
-------------------
L = DBM:GetModLocalization("Jaraxxus")

L:SetGeneralLocalization{
	name = "Lord Jaraxxus"
}

L:SetWarningLocalization{
	WarnFlame				= "Legion Flame on >%s<",
	WarnTouch				= "Touch of Jaraxxus on >%s<",
	WarnNetherPower			= "Nether Power on Jaraxxus! Dispel Now!",
	WarnPortalSoon			= "Nether Portal Soon!",
	WarnVolcanoSoon			= "Infernal Volcano Soon!",
	SpecWarnFlesh			= "Incinerate Flesh on YOU!",
	SpecWarnTouch			= "Touch of Jaraxxus on YOU!",
	SpecWarnKiss			= "Mistress' Kiss",
	SpecWarnTouchNear		= "Touch of Jaraxxus on >%s< near you",
	SpecWarnFlame			= "Legion Flame! Run!",
	SpecWarnNetherPower		= "Dispell Now!",
	SpecWarnFelInferno		= "Fel Inferno! Run Away!"
}

L:SetMiscLocalization{
	WhisperFlame			= "Legion Flame on YOU!",
}

L:SetOptionLocalization{
	WarnFlame				= "Warns for Legion Flame",
	WarnTouch				= "Show warning for Touch of Jaraxxus",
	WarnNetherPower			= "Warn when Jaraxxus gains Nether Power (for dispel/steal)",
	WarnPortalSoon			= "Prewarn Nether Portal spawning",
	WarnVolcanoSoon			= "Prewarn Infernal Volcano spawning",
	SpecWarnFlame			= "Special warning when you have Legion Flame",
	SpecWarnFlesh			= "Special warning when you have Incinerate Flesh",
	SpecWarnTouch			= "Special warning for Touch of Jaraxxus on you",
	SpecWarnTouchNear		= "Special warning for Touch of Jaraxxus near you",
	SpecWarnKiss			= "Special warning for Mistress' Kiss on you",
	SpecWarnNetherPower		= "Special warning for Nether Power (to dispell jaraxxus)",
	SpecWarnFelInferno		= "Special warning when you are to near to an Fel Inferno",
	TouchJaraxxusIcon		= "Set Icon on Touch of Jaraxxus target (cross)",
	IncinerateFleshIcon		= "Set Icon on Incinerate Flesh target (skull)",
	LegionFlameIcon			= "Set Icon on Legion Flame target (square)",
	LegionFlameWhisper		= "Send Whisper to Legion Flame target"
}


-----------------------
-- Faction Champions --
-----------------------
L = DBM:GetModLocalization("Champions")

L:SetGeneralLocalization{
	name = "Faction Champions"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
}

L:SetMiscLocalization{
	Gorgrim		= "DK - Gorgrim Shadowcleave",	-- 34458
	Birana 		= "D - Birana Stormhoof",	-- 34451
	Erin		= "D - Erin Misthoof",		-- 34459
	Rujkah		= "H - Ruj'kah",		-- 34448
	Ginselle	= "M - Ginselle Blightslinger",	-- 34449
	Liandra		= "P - Liandra Suncaller",	-- 45
	Malithas	= "P - Malithas Brightblade",	-- 56
	Caiphus		= "PR - Caiphus the Stern",	-- 47
	Vivienne	= "PR - Vivienne Blackwhisper",	-- 41
	Mazdinah	= "R - Maz'dinah",		-- 54
	Thrakgar	= "S - Thrakgar",		--  44
	Broln		= "S - Broln Stouthorn",	-- 55
	Harkzog		= "WL - Harkzog",		-- 50
	Narrhok		= "W - Narrhok Steelbreaker"	-- 53
} 

L:SetOptionLocalization{
}


------------------
-- Valkyr Twins --
------------------
L = DBM:GetModLocalization("Twins")

L:SetGeneralLocalization{
	name = "Valkyr Twins"
}

L:SetTimerLocalization{
	TimerSpecialSpell	= "Next Special Ability"	
}

L:SetWarningLocalization{
	WarnSpecialSpellSoon	= "Special Ability Soon!",
	SpecWarnSpecial		= "Change color!"
}

L:SetMiscLocalization{
	YellPull 	= "In the name of our dark master. For the Lich King. You. Will. Die.",
	Fjola 		= "Fjola Lightbane",
	Eydis		= "Eydis Darkbane"
}

L:SetOptionLocalization{
	TimerSpecialSpell	= "Show a timer for the next special ability",
	WarnSpecialSpellSoon	= "Prewarning for the next Special Ability",
	SpecWarnSpecial		= "Show a special warning when you have to change color"
}


------------------
-- Anub'arak --
------------------
L = DBM:GetModLocalization("Anub'arak_Coliseum")

L:SetGeneralLocalization{
	name = "Anub'arak"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	WarnBurrow	= "Burrow!",
	WarnPursue	= "Pursuing >%s<",
	SpecWarnPursue	= "Pursuing YOU!"
}

L:SetMiscLocalization{
	YellPull	= "This place will serve as your tomb!"
}

L:SetOptionLocalization{
	WarnBurrow	= "Warning for Submerge",
	WarnPursue	= "Warning who is being followed",
	SpecWarnPursue	= "Special warning if YOU are followed"
}


