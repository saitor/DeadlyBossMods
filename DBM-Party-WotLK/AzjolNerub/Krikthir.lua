local mod = DBM:NewMod("Krikthir", "DBM-Party-WotLK", 2)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(28684)
mod:SetZone()

mod:RegisterCombat("combat")

local warningCurse	= mod:NewSpellAnnounce(52592, 2)
local timerCurseCD	= mod:NewCDTimer(20, 52592)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 52592 or args.spellId == 59368 then
		warningCurse:Show(args.spellName)
		timerCurseCD:Start()
	end
end