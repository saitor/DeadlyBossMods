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

local warningSmash	=	 mod:NewAnnounce("WarningSmash", 1, 42723)
local warningGrowl		= mod:NewAnnounce("WarningGrowl", 3, 42708)
local warningWoeStrike	= mod:NewAnnounce("WarningWoeStrike", 2, 42730)
local timerSmash		= mod:NewTimer(3, "TimerSmash", 42723)
local timerWoeStrike	= mod:NewTimer(10, "TimerWoeStrike", 42723)

local specWarnSpelllock	= mod:NewSpecialWarning("SpecialWarningSpelllock")


function mod:SPELL_CAST_START(args)
	if args.spellId == 42723 or args.spellId == 42669 then
		warningSmash:Show(tostring(args.spellName))
		timerSmash:Start()
	elseif args.spellId == 42708 or args.spellId == 42729
	or args.spellId == 59708 or args.spellId == 59734 then
		warningGrowl:Show(tostring(args.spellName))
	end
	if args.spellId == 42723 then
		specWarnSpelllock:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 42730 or args.spellId == 59735 then
		warningWoeStrike:Show(tostring(args.destName))
		timerWoeStrike:Start(tostring(args.destName))
		mod:SetIcon(args.destName, 8, 10)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 42730 or args.spellId == 59735 then
		timerWoeStrike:Cancel()
	end
end




