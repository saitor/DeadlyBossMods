local mod = DBM:NewMod("The Test Mod", "DBM-TestMod")

local L = mod:GetLocalizedStrings()

mod:SetZone(GetAddOnMetadata("DBM-TestMod", "X-DBM-Mod-LoadZone"))

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local testWarning1 = mod:NewAnnounce("shield_applied", 1)
local testWarning2 = mod:NewAnnounce("shield_expire", 4)
local testWarning3 = mod:NewAnnounce("shield_expire2", 2, nil, "testoption")
local testWarning4 = mod:NewAnnounce("shield_removed", 3)

local testTimer1 = mod:NewTimer(30, "shield_timer")

local enrageTest = mod:NewEnrageTimer(600)

mod:RegisterCombat

function mod:OnCombatStart(delay)
	enrageTest:Start()
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 48065 then -- Power Word: Shield (Rank 13)
		testWarning1:Show(args.destName)
		testWarning2:Schedule(3)
		testWarning3:Schedule(6, args.sourceName, args.spellName)
		testTimer1:Start(args.destName)
	elseif args.spellId == 48168 then -- Inner Fire (Rank 9)
		testTimer1:Stop()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 48065 then
		testWarning4:Show()
		self:ScheduleMethod(1, "TestCancel")
		testTimer1:Stop(args.destName)
	end
end

function mod:TestCancel()
	testWarning2:Cancel()
	testWarning3:Cancel()
end

function mod:OnUpdate(elapsed)
--	self:AddMsg("Test: "..elapsed)
end

mod:RegisterOnUpdateHandler(mod.OnUpdate, 15)
