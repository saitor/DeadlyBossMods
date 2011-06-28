﻿if GetLocale() ~= "koKR" then return end
local L

---------------
-- Alysrazor --
---------------
L= DBM:GetModLocalization(194)

L:SetWarningLocalization({
	WarnPhase		= "%d 단계"
})

L:SetTimerLocalization({
	TimerPhaseChange	= "%d 단계",
	TimerHatchEggs		= "용암 알 부화"
})

L:SetOptionLocalization({
	WarnPhase			= "단계 전환 경고 보기",
	TimerPhaseChange	= "단계 전환 타이머 보기",
	TimerHatchEggs		= "용암 알 부화 타이머 보기",
	InfoFrame			= "녹아내리는 힘 정보 프레임 보기"
})

L:SetMiscLocalization({
	YellPull		= "I serve a new master now, mortals!",
	YellPhase2		= "These skies are MINE!",
	PowerLevel		= "녹아내리는 힘"
})

-------------------
-- Lord Rhyolith --
-------------------
L= DBM:GetModLocalization(193)

L:SetWarningLocalization({
	WarnElementals		= "정령 소환"
})

L:SetTimerLocalization({
	TimerElementals		= "다음 정령"
})

L:SetOptionLocalization({
	WarnElementals		= "정령 소환 경고 보기",
	TimerElementals		= "다음 정령 소환 타이머 보기"
})

L:SetMiscLocalization({
})

----------------
-- Beth'tilac --
----------------
L= DBM:GetModLocalization(192)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerSpinners 		= "다음 잿그물 거미",
	TimerSpiderlings	= "다음 잿그물 새끼거미",
	TimerDrone			= "다음 잿그물 일거미"
})

L:SetOptionLocalization({
	TimerSpinners		= "다음 $journal:2770 타이머 보기",
	TimerSpiderlings	= "다음 $journal:2778 타이머 보기",
	TimerDrone			= "다음 $journal:2773 타이머 보기"
})

L:SetMiscLocalization({
	EmoteSpiderlings 	= "Spiderlings have been roused from their nest!"
})

-------------
-- Shannox --
-------------
L= DBM:GetModLocalization(195)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SetIconOnFaceRage	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99945),
	SetIconOnRage		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(100415)
})

L:SetMiscLocalization({
})

-------------
-- Baleroc --
-------------
L= DBM:GetModLocalization(196)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerBladeActive	= "%s",
	TimerBladeNext		= "다음 칼날"
})

L:SetOptionLocalization({
	TimerBladeActive	= "칼날 유지 타이머 보기",
	TimerBladeNext		= "다음 칼날 타이머 보기",
	SetIconOnCountdown	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(99516),
	ArrowOnCountdown	= "$spell:99516의 영향을 받은 경우 DBM 화살표 보기"
})

L:SetMiscLocalization({
})

--------------------------------
-- Majordomo Fandral Staghelm --
--------------------------------
L= DBM:GetModLocalization(197)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

--------------
-- Ragnaros --
--------------
L= DBM:GetModLocalization(198)

L:SetTimerLocalization({
	TimerPhaseSons		= "자손 단계 종료"
})

L:SetOptionLocalization({
	TimerPhaseSons		= "'용암의 자손' 단계 지속 타이머 보기",
	RangeFrame			= "거리 프레임 보기"
})

L:SetMiscLocalization({
})