local mod	= DBM:NewMod("Goggnathog", "DBM-GarrisonInvasions")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 13849 $"):sub(12, -3))
mod:SetCreatureID(90995)
mod:SetZone()

mod:RegisterCombat("combat")
mod:SetMinCombatTime(15)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 180819 180816",
	"SPELL_AURA_APPLIED 180908 180816 180815",
	"SPELL_AURA_APPLIED_DOSE 180816",
	"SPELL_AURA_REMOVED 180908"
)

--TODO, refine interrupt/dispel warnings to be less spammy by checking if interrupt/dispel on Cooldown
local warnUnleashedEnergy		= mod:NewTargetAnnounce(180908, 4)
local warnWildPolymorph			= mod:NewTargetAnnounce(180815, 2)

local specWarnUnleashedEnergy	= mod:NewSpecialWarningMoveAway(180908)
local yellUnleashedEnergy		= mod:NewYell(180908)
local specWarnArcaneOrb			= mod:NewSpecialWarningSpell(180819, nil, nil, nil, 2)
local specWarnArcaneSurge		= mod:NewSpecialWarningInterrupt(180816, false)
local specWarnArcaneSurgeDispel	= mod:NewSpecialWarningDispel(180816, "MagicDispeller")

mod:AddRangeFrameOption(10, 180908)
mod:AddHudMapOption("HudMapOnUnleashed", 180908)

mod.vb.debuffCount = 0
local debuffName = GetSpellInfo(180908)
local debuffFilter
do
	debuffFilter = function(uId)
		if UnitDebuff(uId, debuffName) then
			return true
		end
	end
end

local function updateRangeFrame(self)
	if not self.Options.RangeFrame then return end
	if self.vb.debuffCount > 0 then
		if UnitDebuff("player", debuffName) then
			DBM.RangeCheck:Show(10)
		else
			DBM.RangeCheck:Show(10, debuffName)
		end
	else
		DBM.RangeCheck:Hide()
	end
end

function mod:OnCombatStart(delay)
	self.vb.debuffCount = 0
end

function mod:OnCombatEnd()
	if self.Options.HudMapOnUnleashed then
		DBMHudMap:Disable()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 180819 then
		specWarnArcaneOrb:Show()
	elseif spellId == 180816 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnArcaneSurge:Show(args.sourceName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 180908 then
		self.vb.debuffCount = self.vb.debuffCount + 1
		warnUnleashedEnergy:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnUnleashedEnergy:Show()
			yellUnleashedEnergy:Yell()
		end
		if self.Options.HudMapOnUnleashed then
			DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 5, 30, 1, 1, 0, 0.5, nil, true, 1):Pulse(0.5, 0.5)
		end
		updateRangeFrame(self)
	elseif spellId == 180816 and not args:IsDestTypePlayer() and self:AntiSpam(3, 1) then
		specWarnArcaneSurgeDispel:Show(args.destName)
	elseif spellId == 180815 then
		warnWildPolymorph:CombinedShow(0.5, args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 180908 then
		self.vb.debuffCount = self.vb.debuffCount - 1
		if self.Options.HudMapOnUnleashed then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
		updateRangeFrame(self)
	end
end