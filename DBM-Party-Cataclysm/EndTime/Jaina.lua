local mod	= DBM:NewMod("EchoJaina", "DBM-Party-Cataclysm", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 6526 $"):sub(12, -3))
mod:SetCreatureID(12345)
mod:SetModelID(38802)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)
