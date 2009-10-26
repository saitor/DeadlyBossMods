local mod = DBM:NewMod("Vesperon", "DBM-ChamberOfAspects")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(30449)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
    "SPELL_CAST_SUCCESS"
)

local warnShadowFissure	= mod:NewSpellAnnounce(59127)
local timerShadowFissure = mod:NewCastTimer(5, 59128)
local isInCombatWithVesperon = false

function mod:OnCombatStart(delay)
    isInCombatWithVesperon = true
end

function mod:OnCombatEnd()
    isInCombatWithVesperon = false
end

function mod:SPELL_CAST_SUCCESS(args)
    if (isInCombatWithVesperon) then
        if (args.spellId == 57579 or args.spellId == 59127) then
            warnShadowFissure:Show()
            timerShadowFissure:Start()
        end
    end
end