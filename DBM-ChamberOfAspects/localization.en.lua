local L

---------------
--  Shadron  --
---------------
L = DBM:GetModLocalization("Shadron")

L:SetGeneralLocalization({
	name = "Shadron"
})


---------------
--  Tenebron  --
---------------
L = DBM:GetModLocalization("Tenebron")

L:SetGeneralLocalization({
	name = "Tenebron"
})


---------------
--  Vesperon  --
---------------
L = DBM:GetModLocalization("Vesperon")

L:SetGeneralLocalization({
	name = "Vesperon"
})


---------------
--  Sartharion  --
---------------
L = DBM:GetModLocalization("Sartharion")

L:SetGeneralLocalization({
	name = "Sartharion"
})

L:SetWarningLocalization({
	WarningTenebron			= "Tenebron incoming",
	WarningShadron			= "Shadron incoming",
	WarningVesperon			= "Vesperon incoming",
	WarningFireWall			= "Fire Wall - Move away",
	WarningVesperonPortal	= "Vesperon's portal",
	WarningTenebronPortal	= "Tenebron's portal",
	WarningShadronPortal	= "Shadron's portal",
})

L:SetTimerLocalization({
	TimerWall	= "Fire Wall cooldown",
	TimerTenebron	= "Tenebron incoming",
	TimerShadron	= "Shadron incoming",
	TimerVesperon	= "Vesperon incoming"
})

L:SetOptionLocalization({
	PlaySoundOnFireWall	= "Play sound on \"Fire Wall\"",
	AnnounceFails		= "Post player fails for Fire Wall and Void Zone to raid chat (requires announce enabled and promoted/leader status)",

	TimerWall		= "Show timer for \"Fire Wall\"",
	TimerTenebron		= "Show timer for Tenebron",
	TimerShadron		= "Show timer for Shadron",
	TimerVesperon		= "Show timer for Vesperon",

	WarningFireWall		= "Show special warning for \"Fire Wall\"",
	WarningTenebron		= "Show warning for Tenebron spawn",
	WarningShadron		= "Show warning for Shadron spawn",
	WarningVesperon		= "Show warning for Vesperon spawn",

	WarningTenebronPortal	= "Show special warning for Tenebron's portal",
	WarningShadronPortal	= "Show special warning for Shadron's portal",
	WarningVesperonPortal	= "Show special warning for Vesperon's portal",
})

L:SetMiscLocalization({
	Wall			= "The lava surrounding %s churns!",
	Portal			= "%s begins to open a Twilight Portal!",
	NameTenebron	= "Tenebron",
	NameShadron		= "Shadron",
	NameVesperon	= "Vesperon",
	FireWallOn		= "Fire Wall: %s",
	VoidZoneOn		= "Void Zone: %s",
	VoidZones		= "Void Zone fails (this try): %s",
	FireWalls		= "Fire Wall fails (this try): %s",
	--[[ not in use; don't translate.
	Vesperon	= "Vesperon, the clutch is in danger! Assist me!",
	Shadron		= "Shadron! Come to me! All is at risk!",
	Tenebron	= "Tenebron! The eggs are yours to protect as well!"
	--]]
})


