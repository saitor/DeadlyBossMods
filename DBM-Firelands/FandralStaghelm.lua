local mod	= DBM:NewMod("FandralStaghelm", "DBM-Firelands")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(52571)
mod:SetModelID(37953) -- Temporary till real modelID is known
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)

function mod:OnCombatStart(delay)
end