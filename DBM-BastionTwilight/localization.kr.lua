﻿if GetLocale() ~= "koKR" then return end
local L

--------------------------
--  Halfus Wyrmbreaker  --
--------------------------
L = DBM:GetModLocalization("HalfusWyrmbreaker")

L:SetGeneralLocalization({
	name =	"할푸스 웜브레이커"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	ShowDrakeHealth		= "풀려난 용의 체력 프레임 보기"
})

L:SetMiscLocalization({
})

---------------------------
--  Valiona & Theralion  --
---------------------------
L = DBM:GetModLocalization("ValionaTheralion")

L:SetGeneralLocalization({
	name =	"발리오나와 테랄리온"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	YellOnEngulfing			= "$spell:86622 외치기",
	YellOnTwilightMeteor	= "$spell:88518 외치기",
	YellOnTwilightBlast		= "$spell:92898 외치기",
	TBwarnWhileBlackout		= "$spell:86788 이 활성화 중 일때 $spell:92898 경고 보기",
	TwilightBlastArrow		= "당신 근처에 $spell:92898이 시전된 경우 DBM 화살표 보기",
	RangeFrame				= "거리 프레임 보기(10m)",
	BlackoutIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92878),
	EngulfingIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(86622)
})

L:SetMiscLocalization{
	Trigger1				= "들이쉽니다!",
	YellMeteor				= "나에게 황혼 유성!!",
	YellTwilightBlast		= "나에게 황혼 폭발!!",	
	YellEngulfing			= "나에게 사로잡힌 마법!"
}

----------------------------------
--  Twilight Ascendant Council  --
----------------------------------
L = DBM:GetModLocalization("AscendantCouncil")

L:SetGeneralLocalization({
	name =	"승천 의회"
})

L:SetWarningLocalization({
	SpecWarnGrounded		= "접지 버프 받기!!",
	SpecWarnSearingWinds	= "소용돌이 치는 바람 버프 받기!!",
	warnGravityCoreJump		= "중력 핵 전이: >%s<",
	warnStaticOverloadJump	= "전하 과부하 전이: >%s<"
})

L:SetTimerLocalization({
	timerTransition			= "전환 단계"
})

L:SetOptionLocalization({
	SpecWarnGrounded		= "$spell:83581 버프가 없을 경우, 특수 경고 보기\n(~10초 전)",
	SpecWarnSearingWinds	= "$spell:83500 버프가 없을 경우, 특수 경고 보기\n(~10초 전)",
	timerTransition			= "전환 단계 타이머 보기",
	RangeFrame				= "거리 프레임이 필요하게 될 경우 자동으로 보기",
	YellOnLightningRod		= "$spell:83099 외치기",
	warnGravityCoreJump		= "$spell:92538 전이 경고 보기",
	warnStaticOverloadJump	= "$spell:92467 전이 경고 보기",
	HeartIceIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82665),
	BurningBloodIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82660),
	LightningRodIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(83099),
	GravityCrushIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(84948),
	FrostBeaconIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92307),
	StaticOverloadIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92067),
	GravityCoreIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92075)
})

L:SetMiscLocalization({
	Quake			= "발밑의 땅이 불길하게 우르릉거립니다...",
	Thundershock	= "주변의 공기가 에너지로 진동합니다...",
	Switch			= "우리가 상대하겠다!",--"We will handle them!" comes 3 seconds after this one
	Phase3			= "꽤나 인상적이었다만...",--"BEHOLD YOUR DOOM!" is about 13 seconds after	
	YellLightning	= "나에게 벼락 막대!",
	Ignacious		= "이그니시우스",
	Feludius		= "펠루디우스",
	Arion			= "아리온",
	Terrastra		= "테라스트라",
	Monstrosity		= "엘레멘티움 괴물",
	Kill			= "이럴 수가..."
})

----------------
--  Cho'gall  --
----------------
L = DBM:GetModLocalization("Chogall")

L:SetGeneralLocalization({
	name =	"초갈"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	YellOnCorrupting		= "$spell:93178 외치기",
	CorruptingCrashArrow	= "당신 근처에 $spell:93178이 시전 된 경우 DBM 화살표 보기",
	InfoFrame				= "$spell:81701 정보 프레임 보기",
	RangeFrame				= "$spell:82235의 영항을 받을시 거리 프레임(5m) 보기",
	SetIconOnWorship		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(91317),
	SetIconOnCreature		= "어둠에 물든 창조물에 전술 목표 아이콘 설정"
})

L:SetMiscLocalization({
	YellCrash				= "나에게 부패의 충돌!",
	Bloodlevel				= "오염된 피"
})

----------------
--  Sinestra  --
----------------
L = DBM:GetModLocalization("Sinestra")

L:SetGeneralLocalization({
	name =   "시네스트라"
})

L:SetWarningLocalization({
	WarnSlicerSoon		= "%d초 후 황혼 절단!",
	WarnDragon			= "새끼용 등장",
	WarnEggWeaken		= "황혼 껍질 사라짐",
	SpecWarnSlicer		= "곧 황혼 절단!",
	SpecWarnDispel		= "마지막 파멸 후 %d초 지남 - 지금 해제!",
	SpecWarnEggWeaken	= "황혼 껍질 사라짐 - 알 극딜!",
	SpecWarnEggShield	= "황혼 껍질 재생성!"
})

L:SetTimerLocalization({
	TimerDragon        	= "다음 새끼용 등장",
	TimerEggWeakening 	= "황혼 껍질 제거",
	TimerEggWeaken		= "황혼 껍질 재생성"
})	

L:SetOptionLocalization({
	WarnDragon       	= "새끼용 등장 경고 보기",
	WarnSlicerSoon		= "$spell:92954의 사전 경고 보기 (5초 전부터, 1초 마다)\n(예상 경보이며, 정확하지 않을 수 있습니다.)",
	WarnEggWeaken    	= "$spell:87654 제거 사전 경고 보기",
	SpecWarnSlicer		= "$spell:92954의 특수 경고 보기 (예상 경보이며, 정확하지 않을 수 있습니다.)",
	SpecWarnDispel		= "$spell:92955이 시전/전이 된 후 일정 시간이 지나면 특수 경고 보기(해제)",
	SpecWarnEggWeaken	= "$spell:87654 사라짐 특수 경고 보기",
	SpecWarnEggShield	= "$spell:87654의 재생성 특수 경고 보기",
	TimerDragon        	= "다음 새끼용 등장 타이머 보기",
	TimerEggWeakening  	= "$spell:87654 사라짐 타이머 보기",
	TimerEggWeaken		= "$spell:87654 재생성 타이머 보기"
})

L:SetMiscLocalization({
	YellDragon    = "얘들아, 먹어치워라",
	YellEgg       = "이게 약해지는 걸로 보이느냐? 멍청한 놈!"
})