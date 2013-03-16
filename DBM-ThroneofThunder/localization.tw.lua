﻿if GetLocale() ~= "zhTW" then return end
local L

--------------------------
-- Jin'rokh the Breaker --
--------------------------
L= DBM:GetModLocalization(827)

L:SetOptionLocalization({
	RangeFrame		= "顯示距離框架"
})

--------------
-- Horridon --
--------------
L= DBM:GetModLocalization(819)

L:SetWarningLocalization({
	warnAdds	= "%s"
})

L:SetTimerLocalization({
	timerDoor		= "下一個部族的門",
	timerAdds		= "下一波%s"
})

L:SetOptionLocalization({
	warnAdds		= "提示小怪跳下",
	timerDoor		= "為下一個部族的門顯示計時器",
	timerAdds		= "為下一次小怪跳下顯示計時器"
})

L:SetMiscLocalization({
	newForces		= "的門蜂擁而出!",--Farraki forces pour from the Farraki Tribal Door!
	chargeTarget	= "用力拍動尾巴!"--Horridon sets his eyes on Eraeshio and stamps his tail!
})

---------------------------
-- The Council of Elders --
---------------------------
L= DBM:GetModLocalization(816)

L:SetOptionLocalization({
	warnPossessed		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(136442),
	specWarnPossessed	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch:format(136442),
	warnSandBolt		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(136189),
	PHealthFrame		= "為$spell:136442消散顯示剩餘血量框架(需要首領血量框架開啟)",
	RangeFrame			= "顯示距離框架"
})

------------
-- Tortos --
------------
L= DBM:GetModLocalization(825)

L:SetWarningLocalization({
	warnKickShell			= "%s被>%s<使用 (還剩餘%d)",
	specWarnCrystalShell	= "取得%s"
})

L:SetOptionLocalization({
	warnKickShell			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(134031),
	specWarnCrystalShell	= "當你沒有$spell:137633減益時顯示特別警告",
	InfoFrame				= "為玩家沒有$spell:137633顯示訊息框架",
	SetIconOnTurtles		= "為$journal:7129標示團隊圖示(超過一名以上的團隊助理時不可靠)",
})

L:SetMiscLocalization({
	WrongDebuff		= "沒有%s"
})

-------------
-- Megaera --
-------------
L= DBM:GetModLocalization(821)

L:SetMiscLocalization({
	rampageEnds	= "梅賈拉的怒氣平息了。"
})

------------
-- Ji-Kun --
------------
L= DBM:GetModLocalization(828)

L:SetWarningLocalization({
	warnFlock		= "%s %s (%s)",
	specWarnFlock	= "%s %s (%s)"
})

L:SetTimerLocalization({
	timerFlockCD	= "蛋巢 (%d): %s"
})

L:SetOptionLocalization({
	warnFlock		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.count:format("ej7348"),
	specWarnFlock	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch:format("ej7348"),
	timerFlockCD	= DBM_CORE_AUTO_TIMER_OPTIONS.nextcount:format("ej7348"),
	RangeFrame		= "為$spell:138923顯示距離框架(8碼)"
})

L:SetMiscLocalization({
	eggsHatchL		= "下層巢裡的蛋開始孵化了!",
	eggsHatchU		= "上層巢裡的蛋開始孵化了!",
	Upper			= "上層",
	Lower			= "下層",
	UpperAndLower	= "上層和下層"
})

--------------------------
-- Durumu the Forgotten --
--------------------------
L= DBM:GetModLocalization(818)

L:SetWarningLocalization({
	warnAddsLeft				= "霧獸剩餘: %d",
	specWarnFogRevealed			= "照出%s了!",
	specWarnDisintegrationBeam	= "%s (%s)"
})

L:SetOptionLocalization({
	warnAddsLeft				= "提示還剩餘多少霧獸",
	specWarnFogRevealed			= "為照出霧獸顯示特別警告",
	specWarnDisintegrationBeam	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format("ej6882"),
	ArrowOnBeam					= "為$journal:6882指示DBM箭頭移動方向",
	SetIconRays					= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format("ej6891")
})

L:SetMiscLocalization({
	Eye		= "魔眼"
})

----------------
-- Primordius --
----------------
L= DBM:GetModLocalization(820)

L:SetOptionLocalization({
	RangeFrame		= "顯示距離框架(2碼/5碼)",
})

-----------------
-- Dark Animus --
-----------------
L= DBM:GetModLocalization(824)

L:SetWarningLocalization({
	warnMatterSwapped	= "%s: >%s< 和 >%s< 交換"
})

L:SetOptionLocalization({
	warnMatterSwapped	= "提示目標被$spell:138618交換"
})

L:SetMiscLocalization({
	Pull	= "寶珠爆炸了!"
})

--------------
-- Iron Qon --
--------------
L= DBM:GetModLocalization(817)

L:SetWarningLocalization({
	warnDeadZone	= "%s:%s跟%s開盾"
})

L:SetOptionLocalization({
	warnDeadZone	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(137229),
	RangeFrame		= "顯示動態距離框架(當太多人太接近時會動態顯示)",
	InfoFrame		= "為玩家有$spell:136193顯示訊息框架"
})

-------------------
-- Twin Consorts --
-------------------
L= DBM:GetModLocalization(829)

L:SetOptionLocalization({
	RangeFrame		= "顯示距離框架(8碼)"
})

L:SetMiscLocalization({
	DuskPhase		= "盧凜!借本宮力量!"--Not in use, but a backup just in case, so translate in case it's switched to on moments notice on live or next PTR test
})

--------------
-- Lei Shen --
--------------
L= DBM:GetModLocalization(832)

L:SetOptionLocalization({
	RangeFrame			= "顯示距離框架",--For two different spells
	StaticShockArrow	= "當某人中了$spell:135695顯示DBM箭頭",
	OverchargeArrow		= "當某人中了$spell:136295顯示DBM箭頭",
	SetIconOnOvercharge	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(136295),
	SetIconOnStaticShock= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(135695)
})

------------
-- Ra-den --
------------
L= DBM:GetModLocalization(831)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ToTTrash")

L:SetGeneralLocalization({
	name =	"雷霆王座小怪"
})

L:SetOptionLocalization({
	RangeFrame		= "顯示距離框架(10碼)"--For 3 different spells
})
