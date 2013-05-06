local mod	= DBM:NewMod("SPMGeneral", "DBM-Party-MoP", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone()

mod:RegisterCombat("challenge", 877)

--this is basically a stub mod to enable instance completion timers, such as a "fastast clear" timer for a challenge mode. :)
--TODO: maybe expand this with options to enable it's use beyond just challenge modes (such as supporting timer in normal heroic or challenge)
--This also gives more freedom to add 5 man trash warnings in future if each zone has a zone based mod
mod:RemoveOption("HealthFrame")
