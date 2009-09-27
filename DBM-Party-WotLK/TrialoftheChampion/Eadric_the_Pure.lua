local mod = DBM:NewMod("EadricthePure", "DBM-Party-WotLK", 13)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 559 $"):sub(12, -3))
mod:SetCreatureID(35119)
--mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)

local isDispeller = select(2, UnitClass("player")) == "PRIEST"
              or select(2, UnitClass("player")) == "PALADIN"

local warnHammerofRighteous	= mod:NewAnnounce("warnHammerofRighteous")
local warnHammerofJustice		= mod:NewTargetAnnounce(66940)
local specwarnRadiance	= mod:NewSpecialWarning("specwarnRadiance")
local specwarnHammerofJustice	= mod:NewSpecialWarning("specwarnHammerofJustice", isDispeller)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(66935, 66862, 67681) then							-- Radiance Look Away!
		specwarnRadiance:Show()
	elseif args:IsSpellID(66867) then							-- Hammer of the Righteous
		warnHammerofRighteous:Show(args.spellName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(66940) then							-- Hammer of Justice on <Player>
		warnHammerofJustice:Show(args.destName)
		specwarnHammerofJustice:Show(args.destName)
	end
end