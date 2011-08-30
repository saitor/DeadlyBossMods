local mod	= DBM:NewMod("JulakDoom", "DBM-Party-Cataclysm", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(50089)
mod:SetModelID(24301)
mod:SetZone()
mod:SetUsedIcons(8, 7)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"SPELL_MISSED"
)

local warnShockwave			= mod:NewCastAnnounce(93610, 3)
local warnMCTargets			= mod:NewTargetAnnounce(93621, 4)

local specWarnShockwave		= mod:NewSpecialWarningMove(93610, mod:IsTank())
local specWarnBreath		= mod:NewSpecialWarningMove(93612)

local timerShockwaveCD		= mod:NewNextTimer(28.5, 93610)
local timerMCCD				= mod:NewNextTimer(40, 93621)

mod:AddBoolOption("SetIconOnMC", true)

local warnMCTargets = {}
local mcIcon = 8
local lastBreath = 0

function mod:OnCombatStart(delay)
	table.wipe(warnMCTargets)
	mcIcon = 8
	lastBreath = 0
	--timerShockwaveCD:Start(-delay)
	--timerMCCD:Start(-delay)
end

local function showMC()
	warnMC:Show(table.concat(warnMCTargets, "<, >"))
	table.wipe(warnMCTargets)
	mcIcon = 8
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(93621) then
		warnShockwave:Show()
		specWarnShockwave:Show()
		timerShockwaveCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(93621) then
		warnMCTargets[#warnMCTargets + 1] = args.destName
		timerMCCD:Start()
		if self.Options.SetIconOnMC then
			self:SetIcon(args.destName, mcIcon)
			mcIcon = mcIcon - 1
		end
		self:Unschedule(showMC)
		self:Schedule(0.3, showMC)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(93621) and self.Options.SetIconOnMC then
		self:SetIcon(args.destName, 0)
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(93612) and args:IsPlayer() and GetTime() - lastBreath > 3 then
		if args:IsPlayer() and GetTime() - lastBreath > 3  then
			specWarnBreath:Show()
			lastBreath = GetTime()
		end
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE