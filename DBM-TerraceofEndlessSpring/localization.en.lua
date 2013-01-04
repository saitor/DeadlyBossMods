local L

------------
-- Protectors of the Endless --
------------
L= DBM:GetModLocalization(683)

L:SetOptionLocalization({
	RangeFrame			= "Show range frame (8) for $spell:111850\n(Shows everyone if you have debuff, only players with debuff if not)",
	SetIconOnPrison		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(117436)
})


------------
-- Tsulong --
------------
L= DBM:GetModLocalization(742)

L:SetMiscLocalization{
	Victory	= "I thank you, strangers. I have been freed."
}
 

-------------------------------
-- Lei Shi --
-------------------------------
L= DBM:GetModLocalization(729)

L:SetWarningLocalization({
	warnHideOver			= "%s has ended",
	warnHideProgress		= "Hits: %s. Damage: %s. Time: %s"
})

L:SetTimerLocalization({
	timerSpecialCD			= "Special CD (%d)"
})

L:SetOptionLocalization({
	warnHideOver			= "Show warning when $spell:123244 has ended",
	warnHideProgress		= "Show statistics for $spell:123244 when it ends",
	timerSpecialCD			= "Show timer for special ability CD",
	SetIconOnGuard			= "Set icons on $journal:6224",
	RangeFrame				= "Show range frame (3) for $spell:123121\n(Shows everyone during Hide, otherwise, only shows tanks)",
	GWHealthFrame			= "Show remaining health frame for $spell:123461 fades\n(Requires boss health frame enabled)" -- maybe bad wording, needs review
})

L:SetMiscLocalization{
	Victory	= "I... ah... oh! Did I...? Was I...? It was... so... cloudy."--wtb alternate and less crappy victory event.
}


----------------------
-- Sha of Fear --
----------------------
L= DBM:GetModLocalization(709)

L:SetWarningLocalization({
	MoveWarningForward			= "Move Through",
	MoveWarningRight			= "Move Right",
	MoveWarningBack				= "Move To Old Position",
	specWarnBreathOfFearSoon	= "Breath of Fear soon - MOVE into wall!"
})

L:SetTimerLocalization({
	timerSpecialAbilityCD		= "Next Special Ability",
	timerSpoHudCD				= "Fear / Waterspout CD",
	timerSpoStrCD				= "Waterspout / Strike CD",
	timerHudStrCD				= "Fear / Strike CD"
})

L:SetOptionLocalization({
	specWarnBreathOfFearSoon	= "Show pre-special warning for $spell:119414 if you not have a $spell:117964 buff",
})

L:SetOptionLocalization({
	RangeFrame					= "Show range frame (2) for $spell:119519",
	MoveWarningForward			= "Show special warning to move through when $spell:120047 is being fired",
	MoveWarningRight			= "Show special warning to move right when $spell:120047 is being fired",
	MoveWarningBack				= "Show special warning to move back to old position when $spell:120047 has ended",
	timerSpecialAbilityCD		= "Show timer for when next special ability will be cast",
	timerSpoHudCD				= "Show timer for next possible $spell:120629 or $spell:120519 cast",
	timerSpoStrCD				= "Show timer for next possible $spell:120519 or $spell:120672 cast",
	timerHudStrCD				= "Show timer for next possible $spell:120629 or $spell:120672 cast"
})
