local mod	= DBM:NewMod("Shannox", "DBM-Firelands")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(53691)
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)

function mod:OnCombatStart(delay)
end