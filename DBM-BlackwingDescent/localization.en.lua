local L

--------------
--  Magmaw  --
--------------
L = DBM:GetModLocalization("Magmaw")

L:SetGeneralLocalization({
	name = "Magmaw"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
})

-------------------------------
--  Dark Iron Golem Council  --
-------------------------------
L = DBM:GetModLocalization("DarkIronGolemCouncil")

L:SetGeneralLocalization({
	name = "Dark Iron Golem Council"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
	Magmatron	= "Magmatron",
	Electron	= "Electron",
	Toxitron	= "Toxitron",
	Arcanotron	= "Arcanotron",
	SayBomb		= "Poison Bomb on me!"
})

L:SetOptionLocalization({
	SayBombTarget	= "Shout in SAY that you are targeted for $spell:80157"
})

----------------
--  Maloriak  --
----------------
L = DBM:GetModLocalization("Maloriak")

L:SetGeneralLocalization({
	name = "Maloriak"
})

L:SetWarningLocalization({
	WarnPhase		= "%s phase",
	WarnRemainingAdds	= "%d aberrations remaining"
})

L:SetTimerLocalization({
	TimerPhase		= "Next phase"
})

L:SetMiscLocalization({
	YellRed			= "Mix and stir, apply heat...",
	YellBlue		= "How well does the mortal shell handle extreme temperature change? Must find out! For science!",
	YellGreen		= "This one's a little unstable, but what's progress without failure?",
	YellDark		= "Your mixtures are weak, Maloriak! They need a bit more... kick!",
	Red			= "Red",
	Blue			= "Blue",
	Green			= "Green",
	Dark			= "Dark"
})

L:SetOptionLocalization({
	WarnPhase		= "Show warning which phase is incoming",
	WarnRemainingAdds	= "Show warning how many aberrations remain",
	TimerPhase		= "Show timer for next phase"
})

-----------------
--  Chimaeron  --
-----------------
L = DBM:GetModLocalization("Chimaeron")

L:SetGeneralLocalization({
	name = "Chimaeron"
})

L:SetWarningLocalization({
	WarnPhase2Soon	= "Phase 2 soon",
	WarnBreak	= "%s on >%s< (%d)"
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
	WarnPhase2Soon	= "Show a prewarning for Phase 2",
	WarnBreak	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(82881, GetSpellInfo(82881) or "unknown")
})

-----------------
--  Atramedes  --
-----------------
L = DBM:GetModLocalization("Atramedes")

L:SetGeneralLocalization({
	name = "Atramedes"
})

L:SetWarningLocalization({
	WarnAirphase		= "Airphase",
	WarnGroundphase		= "Groundphase",
	WarnShieldsLeft		= "Ancient Dwarven Shield used - %d left"
})

L:SetTimerLocalization({
	TimerAirphase		= "Airphase",
	TimerGroundphase	= "Groundphase"
})

L:SetMiscLocalization({
	AncientDwarvenShield	= "Ancient Dwarven Shield",
	Airphase		= "Yes, run! With every step your heart quickens. The beating, loud and thunderous... Almost deafening. You cannot escape!"
})

L:SetOptionLocalization({
	WarnAirphase		= "Show warning when Atramedes lifts off",
	WarnGroundphase		= "Show warning when Atramedes lands",
	WarnShieldsLeft		= "Show warning when a Ancient Dwarven Shield gets used",
	TimerAirphase		= "Show timer for next airphase",
	TimerGroundphase	= "Show timer for next groundphase"
})

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian-BD")	-- No conflict with BWL version :)

L:SetGeneralLocalization({
	name = "Nefarian"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
})
