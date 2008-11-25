local mod = DBM:NewMod("GortokPalehoof", "DBM-Party-WotLK", 11)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(26687)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

local warningImpale	= mod:NewAnnounce("WarningImpale", 3, 48261)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 48261 or args.spellId == 59268 then
		warningImpale:Show(args.destName)
	end
end