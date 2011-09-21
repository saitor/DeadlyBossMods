--[[
local mod	= DBM:NewMod( <EJ encounter ID >, "DBM-DragonSoul", nil, < EJ zone ID >)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 6480 $"):sub(12, -3))
mod:SetCreatureID(12345)
mod:SetModelID(12345)
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)
--]]