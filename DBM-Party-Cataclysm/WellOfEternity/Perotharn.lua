local mod	= DBM:NewMod("Perotharn", "DBM-Party-Cataclysm", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision:$"):sub(12, -3))
mod:SetCreatureID(12345)
mod:SetModelID(12345)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)
