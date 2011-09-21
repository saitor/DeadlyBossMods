local mod	= DBM:NewMod("EchoSylvanas", "DBM-Party-Cataclysm", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 6479 $"):sub(12, -3))
mod:SetCreatureID(12345)
mod:SetModelID(12345)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)
