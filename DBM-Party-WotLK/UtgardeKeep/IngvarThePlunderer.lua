local mod = DBM:NewMod("IngvarThePlunderer", "DBM-Party-WotLK", 10)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(23980)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warningSmash	= mod:NewAnnounce("WarningSmash", 3, 42723)
local warningGrowl	= mod:NewAnnounce("WarningGrowl", 3, 42708)
local warningWoeStrike	= mod:NewAnnounce("WarningWoeStrike", 3, 42730)
local timerSmash	= mod:NewTimer(3, "TimerSmash", 42723)	-- move away (best tactic) for HC ini
local timerWoeStrike	= mod:NewTimer(10, "TimerWoeStrike", 42723)

local specWarnSpelllock	= mod:NewSpecialWarning("SpecialWarningSpelllock")


function mod:SPELL_CAST_START(args)
	if args.spellId == 42723 or args.spellId == 42669 then
		local spellName = GetSpellInfo(args.spellId)
		warningSmash:Show(tostring(spellName))
		timerSmash:Start()
	elseif args.spellId == 42708 or args.spellId == 42729 then
		local spellName = GetSpellInfo(args.spellId)
		warningGrowl:Show(tostring(spellName))
	end

	if args.spellId == 42723 then
		specWarnSpelllock:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 42730 then
		warningWoeStrike:Show(tostring(args.destName))
		timerWoeStrike:Start(nil, tostring(args.destName))
		mod:SetIcon(args.destName, 8, 10)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 42730 then
		timerWoeStrike:Cancel()
	end
end




