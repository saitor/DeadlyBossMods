local mod	= DBM:NewMod(965, "DBM-Party-WoD", 7, 476)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 12100 $"):sub(12, -3))
mod:SetCreatureID(75964)
mod:SetEncounterID(1698)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 153544 156793 153315",
	"SPELL_CAST_SUCCESS 165731 154043",
	"SPELL_PERIODIC_DAMAGE 154043",
	"SPELL_PERIODIC_MISSED 154043"
)

local warnSpinningBlade		= mod:NewSpellAnnounce(153544, 3)
local warnFourWinds			= mod:NewSpellAnnounce(156793, 4)
local warnWindFall			= mod:NewSpellAnnounce(153315, 2)
local warnPiercingRush		= mod:NewTargetAnnounce(165731, 2)--EJ shows tank warning but in my encounter it could target anyone. If this changes I'll tweak the default to tank/healer
local warnLensFlare			= mod:NewTargetAnnounce(154033, 3)

local specWarnSpinningBlade	= mod:NewSpecialWarningSpell(153544, false, nil, nil, 2)
local specWarnFourWinds		= mod:NewSpecialWarningSpell(156793, nil, nil, nil, 2)
local specWarnLensFlareYou	= mod:NewSpecialWarningYou(154043)
local specWarnLensFlare		= mod:NewSpecialWarningMove(154043)
local yellLensFlare			= mod:NewYell(154043)

local timerFourWinds		= mod:NewBuffActiveTimer(18, 156793)
local timerFourWindsCD		= mod:NewCDTimer(30, 156793)

local voiceFourWinds		= mod:NewVoice(156793)
local voiceLensFlare		= mod:NewVoice(154043)

function mod:OnCombatStart(delay)
	timerFourWindsCD:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 153544 then
		warnSpinningBlade:Show()
		specWarnSpinningBlade:Show()
	elseif spellId == 156793 then
		warnFourWinds:Show()
		specWarnFourWinds:Show()
		timerFourWinds:Start()
		timerFourWindsCD:Start()
		voiceFourWinds:Play("wwsoon")
	elseif spellId == 153315 then
		warnWindFall:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 165731 then
		warnPiercingRush:Show(args.destName)
	elseif args.spellId == 154043 then
		warnLensFlare:Show(args.destName)
		if args:IsPlayer() then
			specWarnLensFlareYou:Show()
			yellLensFlare:Yell()
			--no timer yet
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, _, _, _, overkill)
	if spellId == 154043 and destGUID == UnitGUID("player") and self:AntiSpam(2) then
		specWarnLensFlare:Show()
		voiceLensFlare:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
