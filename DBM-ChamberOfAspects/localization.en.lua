local L

----------------------------
--  The Obsidian Sanctum  --
----------------------------
--  Shadron  --
---------------
L = DBM:GetModLocalization("Shadron")

L:SetGeneralLocalization({
	name = "Shadron"
})

----------------
--  Tenebron  --
----------------
L = DBM:GetModLocalization("Tenebron")

L:SetGeneralLocalization({
	name = "Tenebron"
})

----------------
--  Vesperon  --
----------------
L = DBM:GetModLocalization("Vesperon")

L:SetGeneralLocalization({
	name = "Vesperon"
})

------------------
--  Sartharion  --
------------------
L = DBM:GetModLocalization("Sartharion")

L:SetGeneralLocalization({
	name = "Sartharion"
})

L:SetWarningLocalization({
	WarningTenebron			= "Tenebron incoming",
	WarningShadron			= "Shadron incoming",
	WarningVesperon			= "Vesperon incoming",
	WarningFireWall			= "Fire Wall",
	WarningVesperonPortal	= "Vesperon's portal",
	WarningTenebronPortal	= "Tenebron's portal",
	WarningShadronPortal	= "Shadron's portal"
})

L:SetTimerLocalization({
	TimerTenebron	= "Tenebron arrives",
	TimerShadron	= "Shadron arrives",
	TimerVesperon	= "Vesperon arrives"
})

L:SetOptionLocalization({
	PlaySoundOnFireWall		= "Play sound on Fire Wall",
	AnnounceFails			= "Post player fails for Fire Wall and Shadow Fissure to raid chat\n(requires announce to be enabled and leader/promoted status)",
	TimerTenebron			= "Show timer for Tenebron's arrival",
	TimerShadron			= "Show timer for Shadron's arrival",
	TimerVesperon			= "Show timer for Vesperon's arrival",
	WarningFireWall			= "Show special warning for Fire Wall",
	WarningTenebron			= "Announce Tenebron incoming",
	WarningShadron			= "Announce Shadron incoming",
	WarningVesperon			= "Announce Vesperon incoming",
	WarningTenebronPortal	= "Show special warning for Tenebron's portal",
	WarningShadronPortal	= "Show special warning for Shadron's portal",
	WarningVesperonPortal	= "Show special warning for Vesperon's portal"
})

L:SetMiscLocalization({
	Wall			= "The lava surrounding %s churns!",
	Portal			= "%s begins to open a Twilight Portal!",
	NameTenebron	= "Tenebron",
	NameShadron		= "Shadron",
	NameVesperon	= "Vesperon",
	FireWallOn		= "Fire Wall: %s",
	VoidZoneOn		= "Shadow Fissure: %s",
	VoidZones		= "Shadow Fissure fails (this try): %s",
	FireWalls		= "Fire Wall fails (this try): %s"
})

------------------------
--  The Ruby Sanctum  --
------------------------
--  Baltharus the Warborn  --
-----------------------------
L = DBM:GetModLocalization("Baltharus")

L:SetGeneralLocalization({
	name = "Baltharus the Warborn"
})

L:SetWarningLocalization({
	WarningSplitSoon	= "Split soon",
	WarningSplitNow		= "Split"
})

L:SetOptionLocalization({
	WarningSplitSoon	= "Show pre-warning for Split (54%)",
	WarningSplitNow		= "Show warning for Split",
	RangeFrame			= "Show range frame (12 yards)",
	SetIconOnBrand		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(74505)
})

L:SetMiscLocalization({
	SplitTrigger		= ""
})

-------------------------
--  Saviana Ragefire  --
-------------------------
L = DBM:GetModLocalization("Saviana")

L:SetGeneralLocalization({
	name = "Saviana Ragefire"
})

L:SetWarningLocalization({
	specWarnConflagNear		= "Conflagration near you - Watch out",
	SpecialWarningTranq		= "Enrage - Tranq now"
})

L:SetOptionLocalization({
	specWarnConflagNear		= "Show special warning for $spell:74452 near you",
	SpecialWarningTranq		= "Show special warning for Enrage (to tranq)",--$spell:78722 is not in 3.3.3 game files, it cannot be added in to local until 3.3.5
	YellOnConflag			= "Yell on $spell:74452",
	RangeFrame				= "Show range frame (10 yards)",
	ConflagIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(74452)
})

L:SetMiscLocalization{
	YellConflag	= "Conflagration on me!"
}

--------------------------
--  General Zarithrian  --
--------------------------
L = DBM:GetModLocalization("Zarithrian")

L:SetGeneralLocalization({
	name = "General Zarithrian"
})

L:SetWarningLocalization({
	WarnPhase2Soon		= "Phase 2 soon",
	WarnPhase3Soon		= "Phase 3 soon"
})

L:SetOptionLocalization({
})

-------------------------------------
--  Halion the Twilight Destroyer  --
-------------------------------------
L = DBM:GetModLocalization("Halion")

L:SetGeneralLocalization({
	name = "Halion the Twilight Destroyer"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
	WarnPhase2Soon			= "Show pre-warning for Phase 2 (at ~79%)",
	WarnPhase3Soon			= "Show pre-warning for Phase 3 (at ~54%)",
	SoundOnConsumption		= "Play sound on Combustion",--We use localized text for these functions
	SetIconOnConsumption	= "Set icons on Combustion targets"--So we can use single functions for both versions of spell.
})

L:SetMiscLocalization({
	twilightcutter			= "The orbiting spheres pulse with dark energy!"--Might not even use this, but having it standby just in case.
})