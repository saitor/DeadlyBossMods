local mod = DBM:NewMod("Ick", "DBM-Party-WotLK", 15)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1665 $"):sub(12, -3))
mod:SetCreatureID(36476, 36477)
--mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_RAID_BOSS_WHISPER",
	"SPELL_PERIODIC_DAMAGE"
)

local warnPursuit				= mod:NewAnnounce("warnPursuit")
local timerPursuitConfusion				= mod:NewBuffActiveTimer(12, 69029)
local warnPustulantFlesh			= mod:NewTargetAnnounce(69581)
local timerPustulantFlesh				= mod:NewTargetTimer(10, 69581)
local specWarnToxic		= mod:NewSpecialWarning("specWarnToxic")
local specWarnPursuit		= mod:NewSpecialWarning("specWarnPursuit")

--mod:AddBoolOption("SetIconOnPursuitTarget", true) --Needs syncing implimentation to be added.

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(68987) then							-- Pursuit
		warnPursuit:Show(args.spellName)
	end
end

function mod:CHAT_MSG_RAID_BOSS_WHISPER(msg)
	if msg == L.IckPursuit then
		specWarnPursuit:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(69029, 70850) then							-- Pursuit Confusion
		timerPursuitConfusion:Show(args.destName)
	elseif args:IsSpellID(69581, 70273) then							-- Pustulant Flesh
		warnPustulantFlesh:Show(args.destName)
		timerPustulantFlesh:Show(args.destName)
	end
end

do 
	local lasttoxic = 0
	function mod:SPELL_PERIODIC_DAMAGE(args)
		if args:IsSpellID(69024, 70274, 70436) and args:IsPlayer() and time() - lasttoxic > 2 then		-- Toxic Waste, MOVE!
			specWarnToxic:Show()
			lasttoxic = time()
		end
	end
end

