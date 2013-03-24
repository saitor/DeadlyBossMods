﻿if GetLocale() ~= "koKR" then return end
local L

-----------------------
-- Sha of Anger --
-----------------------
L= DBM:GetModLocalization(691)

L:SetOptionLocalization({
	RangeFrame			= "$spell:119622 상태에 따른 거리 창 보기",
	SetIconOnMC			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(119622)
})

L:SetMiscLocalization({
	Pull				= "Yes, YES! Bring your rage to bear! Try to strike me down!"
})

-----------------------
-- Salyis --
-----------------------
L= DBM:GetModLocalization(725)

L:SetMiscLocalization({
	Pull				= "Bring me their corpses!"
})

--------------
-- Oondasta --
--------------
L= DBM:GetModLocalization(826)

L:SetOptionLocalization({
	RangeFrame			= "$spell:137511 주문에 대한 거리 창 보기"
})

L:SetMiscLocalization({
	Pull				= "감히 우릴 막겠다고? 잔달라 부족을 막을 순 없다! 이번엔 안 돼!"
})

---------------------------
-- Nalak, The Storm Lord --
---------------------------
L= DBM:GetModLocalization(814)

L:SetOptionLocalization({
	RangeFrame			= "$spell:136340 주문에 대한 거리 창 보기(10m)"
})
