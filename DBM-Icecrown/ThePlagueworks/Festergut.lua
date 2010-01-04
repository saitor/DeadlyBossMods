local mod	= DBM:NewMod("Festergut", "DBM-Icecrown", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(36626)
mod:RegisterCombat("combat")
mod:SetUsedIcons(7, 8)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE"
)

local warnInhaledBlight		= mod:NewAnnounce("InhaledBlight")
local warnGasSpore			= mod:NewTargetAnnounce(69279)
local warnVileGas			= mod:NewSpellAnnounce(73020)

local specWarnPungentBlight	= mod:NewSpecialWarningSpell(71219)
local specWarnGasSpore		= mod:NewSpecialWarningYou(69279)
local specWarnInhaled2		= mod:NewSpecialWarningStack(71912, false, 2)

local timerGasSpore			= mod:NewBuffActiveTimer(12, 69279)
local timerPungentBlight	= mod:NewNextTimer(136, 71219)--136 seconds'ish, subject to adjustments
local timerInhaledBlight	= mod:NewNextTimer(34, 71912)--34 seconds'ish (4 of these add up to Pungent Blight, 136 seconds), subject to adjustments
local timerVileGas			= mod:NewCDTimer(30, 71912)--30 cooldown?

local enrageTimer			= mod:NewBerserkTimer(300)

mod:AddBoolOption("SetIconOnGasSpore", true)

local gasSporeTargets	= {}
local gasSporeIcon 	= 8
local spamVileGas = 0

local function warnGasSporeTargets()
	warnGasSpore:Show(table.concat(gasSporeTargets, "<, >"))
	table.wipe(gasSporeTargets)
	timerGasSpore:Start()
	gasSporeIcon = 8
end

function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
	timerInhaledBlight:Start(-delay)--unsure of first one since logs didn't have an exact pull, subject to adjustments
	timerPungentBlight:Start(-delay)--unsure of first one since logs didn't have an exact pull, subject to adjustments
	table.wipe(gasSporeTargets)
	gasSporeIcon = 8
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(69195, 71219, 73031, 73032) then	-- Pungent Blight
		specWarnPungentBlight:Show()
		timerPungentBlight:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(73019, 73020, 72272, 72273) and GetTime() - spamVileGas > 3 then	-- Vile Gas(Spellids drycoded, may not be correct)
		warnVileGas:Show()
		timerVileGas:Start()
		spamVileGas = GetTime()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(69279) then	-- Gas Spore
		gasSporeTargets[#gasSporeTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnGasSpore:Show()
		end
		if self.Options.SetIconOnGasSpore then
			self:SetIcon(args.destName, gasSporeIcon, 12)
			gasSporeIcon = gasSporeIcon - 1
		end
		self:Unschedule(warnGasSporeTargets)
		if #gasSporeTargets >= 2 then
			warnGasSporeTargets()
		else
			self:Schedule(0.3, warnGasSporeTargets)
		end
	elseif args:IsSpellID(69166, 71912) then	-- Inhaled Blight
		warnInhaledBlight:Show(args.amount or 1)
		if (args.amount or 1) >= 2 then	--No idea if i should use 2 here or 3, depends how hard he hits with 2 stacks.
			specWarnInhaled2:Show(args.amount)
		end
		if (args.amount or 1) <= 2 then	--Prevent timer from starting after 3rd stack since he won't cast it a 4th time, he does Pungent instead.
			timerInhaledBlight:Start()
		end
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED