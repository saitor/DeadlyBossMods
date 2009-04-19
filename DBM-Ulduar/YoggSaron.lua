local mod = DBM:NewMod("YoggSaron", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID() --??
mod:SetZone()

mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_SUMMON"
)

--mod:NewAnnounce("WarningSpark", 1, 59381)
--mod:NewTimer(30, "TimerSpark", 59381)
--mod:NewSpecialWarning("WarningSurgeYou")
--mod:NewEnrageTimer(615)

local warnWellSpawned = mod:NewAnnounce("WarningWellSpawned", 1, 64170)
local warnGuardianSpawned = mod:NewAnnounce("WarningGuardianSpawned", 3, 62979)

mod:AddBoolOption("ShowSaraHealth")

function mod:OnCombatStart(delay)
	if self.Options.ShowSaraHealth and not self.Options.HealthFrame then
		DBM.BossHealth:Show(L.name)
	end
	if self.Options.ShowSaraHealth then
		DBM.BossHealth:AddBoss(33134, L.Sara)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 64170 then
		warnWellSpawned:Show()
	end
end

function mod:UNIT_DIED(args)
	if self.Options.ShowSaraHealth and self:GetCIDFromGUID(args.destGUID) == 33134 then
		DBM.BossHealth:RemoveBoss(33134)
		if not self.Options.HealthFrame then
			DBM.BossHealth:Hide()
		end
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 62979 then
		warnGuardianSpawned:Show()
	end
end
