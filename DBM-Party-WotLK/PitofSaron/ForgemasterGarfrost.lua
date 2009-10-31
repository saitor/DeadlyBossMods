local mod = DBM:NewMod("ForgemasterGarfrost", "DBM-Party-WotLK", 15)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(36494)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CREATE",
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_RAID_BOSS_WHISPER",
	"SPELL_AURA_APPLIED_DOSE"
)

local warnForgeWeapon				= mod:NewSpellAnnounce(70335)
local warnDeepFreeze			= mod:NewTargetAnnounce(70384)
local warnSaroniteRock				= mod:NewAnnounce("warnSaroniteRock")
local specWarnSaroniteRock	= mod:NewSpecialWarning("specWarnSaroniteRock")
local specWarnPermafrost	= mod:NewSpecialWarning("specWarnPermafrost", false)

--mod:AddBoolOption("SetIconOnSaroniteRockTarget", true) --Needs syncing implimentation to be added.

function mod:SPELL_CREATE(args)
	if args:IsSpellID(68789, 70851) then							-- Saronite Rock
		warnSaroniteRock:Show(args.spellName)
	end
end

function mod:CHAT_MSG_RAID_BOSS_WHISPER(msg)
	if msg == L.SaroniteRockThrow then
		specWarnSaroniteRock:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(70380, 70384) then						-- Deep Freeze
		warnDeepFreeze:Show(args.destName)
	elseif args:IsSpellID(68785, 70335) then						-- Forge Frostborn Mace
		warnForgeWeapon:Show(args.destName)
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args:IsSpellID(68786, 70336) and args.destName == UnitName("player") then
		if args.amount >= 11 then --Unsure of a good amount, this is subject to tuning based on what damage it does when it goes live.
			specWarnPermafrost:Show(args.spellName, args.amount)
		end
	end
end