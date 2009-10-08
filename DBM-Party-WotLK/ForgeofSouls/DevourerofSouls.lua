local mod = DBM:NewMod("DevourerofSouls", "DBM-Party-WotLK", 16)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1728 $"):sub(12, -3))
mod:SetCreatureID(38400)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)

local warnMirroredSoul			= mod:NewTargetAnnounce(69051)
local warnUnleashedSouls			= mod:NewTargetAnnounce(68939)
local warnWailingSouls			= mod:NewTargetAnnounce(68899)
local warnWellofSouls				= mod:NewAnnounce("warnWellofSouls")
local specwarnMirroredSoul	= mod:NewSpecialWarning("specwarnMirroredSoul")

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(68820) then							-- Well of Souls
		warnWellofSouls:Show(args.spellName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(69051) then							-- Mirroed Soul
		if args:IsPlayer() then
			warnMirroredSoul:Show()
			specwarnMirroredSoul:Show()
		end
	elseif args:IsSpellID(68939) then							-- Unleashed Souls
		warnUnleashedSouls:Show(args.destName)
	elseif args:IsSpellID(68899) then							-- Wailing Souls
		warnWailingSouls:Show(args.destName)
	end
end

