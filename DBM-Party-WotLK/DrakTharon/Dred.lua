local mod = DBM:NewMod("KingDred", "DBM-Party-WotLK", 4)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 106 $"):sub(12, -3))
mod:SetCreatureID(27483)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)
