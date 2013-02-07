﻿if GetLocale() ~= "koKR" then return end
local L

--------------------------
-- Jin'rokh the Breaker --
--------------------------
L= DBM:GetModLocalization(827)

--------------
-- Horridon --
--------------
L= DBM:GetModLocalization(819)

L:SetTimerLocalization({
	timerAddsCD		= "다음 부족의 문 열림",
})

L:SetOptionLocalization({
	timerAddsCD		= "다음 부족의 문 열림 바 표시",
})

L:SetMiscLocalization({
	newForces		= "forces pour from the",--Farraki forces pour from the Farraki Tribal Door!
	chargeTarget	= "stamps his tail!"--Horridon sets his eyes on Eraeshio and stamps his tail!
})

---------------------------
-- The Council of Elders --
---------------------------
L= DBM:GetModLocalization(816)

L:SetOptionLocalization({
	warnSandBolt	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(136189),
	RangeFrame		= "거리 창 보기"
})

------------
-- Tortos --
------------
L= DBM:GetModLocalization(825)

-------------
-- Megaera --
-------------
L= DBM:GetModLocalization(821)

L:SetMiscLocalization({
	rampageEnds	= "Megaera's rage subsides."
})

------------
-- Ji-Kun --
------------
L= DBM:GetModLocalization(828)

L:SetMiscLocalization({
	eggsHatch	= "The eggs in one of the lower nests begin to hatch!"
})

--------------------------
-- Durumu the Forgotten --
--------------------------
L= DBM:GetModLocalization(818)

----------------
-- Primordius --
----------------
L= DBM:GetModLocalization(820)

-----------------
-- Dark Animus --
-----------------
L= DBM:GetModLocalization(824)

L:SetWarningLocalization({
	warnMatterSwapped	= "%s: >%s< 와 >%s< 교체됨"--추후 변경 필요
})

L:SetOptionLocalization({
	warnMatterSwapped	= "$spell:138618 교체 대상 알림"--추후 변경 필요
})

--------------
-- Iron Qon --
--------------
L= DBM:GetModLocalization(817)

L:SetOptionLocalization({
	RangeFrame		= "전투 진영에 따라 거리 창 보기\n(일정 인원 이상이 뭉쳐 있을 때만 표시되는 똑똑한 거리 창 입니다.)"
})

-------------------
-- Twin Consorts --
-------------------
L= DBM:GetModLocalization(829)

L:SetOptionLocalization({
	RangeFrame		= "거리 창 보기(8m)"
})

--------------
-- Lei Shen --
--------------
L= DBM:GetModLocalization(832)

L:SetOptionLocalization({
	RangeFrame		= "거리 창 보기"
})

------------
-- Ra-den --
------------
L= DBM:GetModLocalization(831)

