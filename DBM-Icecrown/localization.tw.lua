﻿if GetLocale() ~= "zhTW" then return end

local L

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization({
	name = "瑪洛嘉領主"
})

L:SetWarningLocalization({
	warnImpale				= ">%s< 被刺穿了",
	specWarnWhirlwind		= "旋風斬 - 快跑開",
	specWarnColdflame		= "冷焰 - 快跑開"
})

L:SetOptionLocalization({
	warnImpale				= "提示刺穿的目標",
	specWarnWhirlwind		= "為旋風斬顯示特別警告",
	specWarnColdflame		= "當你受到冷焰的傷害時顯示特別警告",
	PlaySoundOnWhirlwind	= "為旋風斬播放音效"
})

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization({
	name = "緋紅亡語者"
})

L:SetTimerLocalization({
	TimerAdds		= "新的小怪"
})

L:SetWarningLocalization({
	WarnAddsSoon		= "新的小怪即將到來",
	WarnDeathDecay		= "死亡凋零",
	WarnAdherent		= "Cult Adherent transforming",
	WarnPhase2		= "第2階段",
	SpecWarnDeathDecay	= "死亡凋零 - 快跑開",
	SpecWarnCurseTorpor	= "你中了Curse of Torpor"
})

L:SetOptionLocalization({
	WarnAddsSoon		= "為新的小怪即將出現顯示警告",
	WarnDeathDecay		= "為死亡凋零顯示警告",
	WarnPhase2		= "為第2階段顯示警告",
	WarnAdherent		= "為Adherent的大叫顯示警告",	-- Cult Adherent -> Reanimated Adherent transformation iirc
	SpecWarnDeathDecay	= "當你中了死亡凋零時顯示特別警告",
	SpecWarnCurseTorpor	= "當你中了Curse of Torpor時顯示特別警告",
	TimerAdds		= "為新的小怪出現顯示計時器"
})

L:SetMiscLocalization({
	YellAdds		= "Arise, and exult in your pure form!",
	YellPull		= "What is this disturbance? You dare trespass upon this hallowed ground? This shall be your final resting place!",
	YellAdherent		= "Loyal adherent, I release you from the curse of flesh!",
	YellEmbrace		= "Embrace the darkness... darkness eternal.",
	YellBlessing		= "Take this blessing and show these intruders a taste of the Master's power!"
})

------------------------
--  The Deathbringer  --
------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization({
	name = "The Deathbringer"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization({
	name = "Gunship Battle"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization({
	name = "膿腸"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization({
	name = "腐臉"
})

L:SetWarningLocalization({
	SpecWarnStickyOoze			= "Sticky Ooze - 快跑開",
	SpecWarnRadiatingOoze		= "Radiating Ooze",
	SpecWarnMutatedInfection 	= "你中了Mutated Infection"
})

L:SetTimerLocalization({
	NextPoisonSlimePipes		= "下一次 Poison Slime Pipes"
})

L:SetOptionLocalization({
	SpecWarnStickyOoze			= "為Sticky Ooze顯示特別警告",
	SpecWarnRadiatingOoze		= "為Radiating Ooze顯示特別警告",
	NextPoisonSlimePipes		= "為下一次 Poison Slime Pipes顯示計時器",
	SpecWarnMutatedInfection 	= "為Mutated Infection顯示特別警告",
	InfectionIcon				= "為Mutated Infection的目標設置標記",
	WarnOozeSpawn				= "為小軟泥怪出現顯示警告"
})

L:SetMiscLocalization({
	YellSlimePipes				= "Good news, everyone! I've fixed the poison slime pipes!"	-- Professor Putricide
})

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization({
	name = "普崔希德教授"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization({
	name = "Blood Prince Council"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

-----------------------
--  Queen Lana'thel  --
-----------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization({
	name = "菈娜薩爾女王"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization({
	name = "瓦莉絲瑞雅．夢行者"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

------------------
--  Sindragosa  --
------------------
L = DBM:GetModLocalization("Sindragosa")

L:SetGeneralLocalization({
	name = "辛德拉苟莎"
})

L:SetTimerLocalization({
	NextAirphase			= "下一次 空中階段",
	NextGroundphase			= "下一次 地上階段"
})

L:SetWarningLocalization({
	WarnAirphase			= "空中階段",
	WarnBlisteringCold		= "Blistering Cold",
	SpecWarnBlisteringCold	= "Blistering Cold - 快跑開",
	SpecWarnFrostBeacon		= "你中了Frost beacon",
	PrewarnGroundphase		= "辛德拉苟莎 即將著陸",
	SpecWarnUnchainedMagic	= "你中了Unchained Magic"
})

L:SetOptionLocalization({
	WarnAirphase			= "提示空中階段",
	WarnBlisteringCold		= "為Blistering Cold顯示警告",
	SpecWarnBlisteringCold	= "為Blistering Cold顯示特別警告",
	SpecWarnFrostBeacon		= "為Frost Beacon顯示特別警告",
	PrewarnGroundphase		= "為地上階段顯示預先警告",
	NextAirphase			= "為下一次 空中階段顯示計時器",
	NextGroundphase			= "為下一次 地上階段顯示計時器",
	SpecWarnUnchainedMagic	= "為Unchained Magic顯示特別警告"
})

L:SetMiscLocalization({
	YellAirphase			= "Your incursion ends here! None shall survive!",
	YellPull				= "You are fools to have come to this place. The icy winds of Northrend will consume your souls!"
})

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization({
	name = "巫妖王"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})