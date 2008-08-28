local L

L = DBM:GetModLocalization("The Test Mod")

L:SetGeneralLocalization({
	name = "Localized name [Test]"
})

L:SetWarningLocalization({
	shield_applied	= "Shield on >%s<",
	shield_expire	= "Shield was casted 3 sec ago",
	shield_expire2	= ">%s< casted %s 6 sec ago",
	shield_removed	= "Shield removed",
})

L:SetTimerLocalization({
	shield_timer	= "Shield: %s",
})

L:SetOptionLocalization({
	shield_applied	= "shield_applied (localized)",
	shield_expire	= "shield_expire (localized)",
	testoption		= "testoption (localized)",
	shield_removed	= "shield_removed (localized)",
})

L:SetMiscLocalization({
	test1 = "Localized test1",
	test2 = "Localized test2",
})





--[[
local L

L = DBM:GetModLocalization("The Test Mod")

L:SetWarningLocalization({
	shield_applied	= "Schild auf %s",
	shield_expire	= "Schild wurde vor 3 Sek gecastet",
	shield_expire2	= ">%s< hat %s vor 6 Sek gecastet",
	shield_removed	= "Schild entfernt",
})
]]--