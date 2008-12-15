local mod = DBM:NewMod("SvalaSorrowgrave", "DBM-Party-WotLK", 11)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(26668)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START"
)

local warningSword	= mod:NewAnnounce("WarningSword", 2, 48276)

function mod:SPELL_CAST_START(args)
	if args.spellId == 48276 then
		warningSword:Show(args.spellName, args.destName)
	end
end