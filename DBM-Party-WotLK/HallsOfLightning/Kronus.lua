local mod = DBM:NewMod("Kronus", "DBM-Party-WotLK", 6)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 106 $"):sub(12, -3))
mod:SetCreatureID(28923)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)
