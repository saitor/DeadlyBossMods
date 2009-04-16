local mod = DBM:NewMod("Hodir", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(0) -- Mob ID Required!
mod:SetZone()

-- disclaimer: we never did this boss on the PTR, this boss mod is based on combat logs and movies. This boss mod might be completely wrong or broken, we will replace it with an updated version asap

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START"
)

mod:AddBoolOption("PlaySoundOnFlashFreeze", true, "announce")

local timerFlashFreeze	= mod:NewTimer(9, "TimerFlashFreeze", 61968)

local warnFlashFreeze	= mod:NewSpecialWarning("WarningFlashFreeze")
local warnBitingCold	= mod:NewSpecialWarning("WarningBitingCold")

local enrageTimer	= mod:NewEnrageTimer(600)


function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 61968 then
		timerFlashFreeze:Start()
		warnFlashFreeze:Show()

		if self.Options.PlaySoundOnFlashFreeze then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end	
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args.spellId == 62188 and bits.band(args.destFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0 and bits.band(args.destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0 then -- Biting Cold
		if args.amount >= 5 then
			warnBitingCold:Show()
		end
	end
end


