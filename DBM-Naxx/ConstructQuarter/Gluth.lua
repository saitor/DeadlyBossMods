local mod = DBM:NewMod("Gluth", "DBM-Naxx", 2)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(15932)
mod:SetZone()

mod:RegisterCombat("combat")

mod:EnableModel()

mod:RegisterEvents(
	"SPELL_DAMAGE"
)


local warnDecimateSoon	= mod:NewAnnounce("WarningDecimateSoon", 2, 54426)
local warnDecimateNow	= mod:NewAnnounce("WarningDecimateNow", 3, 54426)

local timerDecimate		= mod:NewTimer(108, "TimerDecimate", 54426)
local enrageTimer		= mod:NewEnrageTimer(360)

function mod:OnCombatStart(delay)
	enrageTimer:Start(360 - delay)
	timerDecimate:Start(110 - delay)
	warnDecimateSoon:Schedule(100 - delay)
end

local decimateSpam = 0
function mod:SPELL_DAMAGE(args)
	if args.spellId == 28375 and (GetTime() - decimateSpam) > 20 then
		decimateSpam = GetTime()
		warnDecimateNow:Show()
		timerDecimate:Start()
		warnDecimateSoon:Schedule(98)
	end
end
