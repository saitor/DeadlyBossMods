local mod	= DBM:NewMod("Troves", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 8980 $"):sub(12, -3))
mod:SetZone()

mod:RegisterCombat("scenario", 934)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"UNIT_AURA"
)

local warnStoneSmash		= mod:NewCastAnnounce(139777, 3, nil, nil, false)

local timerEvent			= mod:NewBuffFadesTimer(300, 140000)
local timerStoneSmash		= mod:NewCastTimer(3, 139777, nil, false)

mod:RemoveOption("HealthFrame")

local timerDebuff = GetSpellInfo(140000)
local timerStarted = false

function mod:SPELL_CAST_START(args)
	if args.spellId == 139777 then
		warnStoneSmash:Show()
		timerStoneSmash:Start(3, args.sourceGUID)
	end
end

--Apparently this doesn't fire in combat log, have to use UNIT_AURA instead.
function mod:UNIT_AURA(uId)
	if uId ~= "player" then return end
	if UnitDebuff("player", timerDebuff) and not timerStarted then
		timerEvent:Start()
		timerStarted = true
	elseif not UnitDebuff("player", timerDebuff) and timerStarted then
		timerStarted = false
	end
end
