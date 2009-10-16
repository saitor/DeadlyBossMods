local mod = DBM:NewMod("LordMarrowgar", "DBM-Icecrown")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1799 $"):sub(12, -3))
mod:SetCreatureID(1024)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_AURA_APPLIED"
)

local timerFirstWhirlwind			= mod:NewTimer(45, "timerFirstWhirlwind") --Timer for first whirlwind only, will only be called once.
local timerNextWhirlwind		= mod:NewNextTimer(60, 69076) --Timer for all other whirlwinds.
local warnBoneSpike				= mod:NewSpellAnnounce(69057)
local timerBoneSpike		= mod:NewCDTimer(18, 69057) --Currently estimate do to limited combat log data, pug could not kill it.
local timerWhirlwind				= mod:NewBuffActiveTimer(30, 69076)
local warnImpale			= mod:NewTargetAnnounce(69062)
local specWarnWhirlwind				= mod:NewSpecialWarning("specWarnWhirlwind", 2)
local specWarnColdflame				= mod:NewSpecialWarning("specWarnColdflame", 2)

mod:AddBoolOption("PlaySoundOnWhirlwind", true, "announce")

function mod:OnCombatStart(delay)
	timerFirstWhirlwind:Start(-delay)
	timerBoneSpike:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(69076) then						-- Whirlwind
		timerNextWhirlwind:Start()
		specWarnWhirlwind:Show()
		if self.Options.PlaySoundOnWhirlwind then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end	
	elseif args:IsSpellID(69057) then					-- Bone Spike Graveyard
		warnBoneSpike:Show(args.spellName)
		timerBoneSpike:Start()
	end
end

do 
	local lastColdflame = 0
	function mod:SPELL_PERIODIC_DAMAGE(args)
		if args:IsSpellID(69146) and args:IsPlayer() and time() - lastColdflame > 2 then		-- Coldflame, MOVE!
			specWarnColdflame:Show()
			lastColdflame = time()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(69076) then						-- Whirlwind
		timerWhirlwind:Show(args.destName)
	elseif args:IsSpellID(69062) then							-- Impale
		warnImpale:Show(args.destName)
	end
end
