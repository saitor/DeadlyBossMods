local L

--------------
--  Onyxia  --
--------------
L = DBM:GetModLocalization("Onyxia")

L:SetGeneralLocalization{
	name = "Onyxia"
}

L:SetWarningLocalization{
	SpecWarnBreath	= "Deep Breath",
	WarnWhelpsSoon	= "Whelp spawn soon",
	WarnPhase3Soon	= "Phase 3 incoming soon"
}

L:SetTimerLocalization{
	TimerBreath	= "Deep Breath",
	TimerWhelps = "Whelp Spawn"
}

L:SetOptionLocalization{
	SpecWarnBreath	= "Show special warning for Deep Breath",
	TimerBreath		= "Show timer for Deep Breath",
	TimerWhelps		= "Show timer for whelp spawns",
	WarnWhelpsSoon	= "Show pre-warning for whelp spawns",
	SoundBreath		= "Play sound on Deep Breath",
	SoundWTF		= "Play some funny sounds of a legendary Onyxia classic raid",
	WarnPhase3Soon	= "Pre warn on P3 (at ~41%)"
}

L:SetMiscLocalization{
	Breath = "%s takes in a deep breath...",
	YellP2 = "This meaningless exertion bores me. I'll incinerate you all from above!",
	YellP3 = "It seems you'll need another lesson, mortals!"
}


