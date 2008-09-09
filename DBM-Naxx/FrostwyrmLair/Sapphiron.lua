local mod = DBM:NewMod("Sapphiron", "DBM-Naxx", 5)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(15989)
mod:SetZone(GetAddOnMetadata("DBM-Naxx", "X-DBM-Mod-LoadZone"))

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_EMOTE",
	"SPELL_CAST_SUCCESS"
)


mod:AddBoolOption("WarningIceblock", true, "announce")
local warnDrainLifeNow	= mod:NewAnnounce("WarningDrainLifeNow", 2, 28542)
local warnDrainLifeSoon	= mod:NewAnnounce("WarningDrainLifeSoon", 1, 28542)
local warnAirPhaseSoon	= mod:NewAnnounce("WarningAirPhaseSoon", 3) -- todo: add icon
local warnAirPhaseNow	= mod:NewAnnounce("WarningAirPhaseNow", 4) -- todo: add icon
local warnLanded		= mod:NewAnnounce("WarningLanded", 4) -- todo: add icon

local timerDrainLife	= mod:NewTimer(22, "TimerDrainLifeCD", 28542)
local timerAirPhase		= mod:NewTimer(66, "TimerAir", "") -- todo: add wc3 crypt fiend unburrow icon
local timerLanding		= mod:NewTimer(24, "TimerLanding", "") -- todo: add wc3 crypt fiend burrow icon
local timerIceBlast		= mod:NewTimer(9, "TimerIceBlast", 15876)

local noTargetTime = 0
local isFlying = false

function mod:OnCombatStart(delay)
	noTargetTime = 0
	isFlying = false
	warnAirPhaseSoon:Schedule(38.5 - delay)
	timerAirPhase:Start(48.5 - delay)
end


function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 28522 and args.destName == UnitName("player") and self.Options.WarningIceblock then
		SendChatMessage(L.WarningYellIceblock, "YELL")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 28542      -- Life Drain (10)
	or args.spellId == 55665 then -- Life Drain (25)
		warnDrainLifeNow:Show()
		warnDrainLifeSoon:Schedule(18.5)
		timerDrainLife:Start()
	end
end

function mod:CHAT_MSG_MONSTER_EMOTE(msg)
	if msg == L.EmoteBreath then
		self:SendSync("DeepBreath")
	end
end

function mod:OnSync(event)
	if event == "DeepBreath" then
		timerIceBlast:Show()
		timerLanding:Update(11)
		self:ScheduleMethod(13, "Landing")
	end
end

function mod:Landing()
	warnAirPhaseSoon:Schedule(56)
	warnLanded:Show()
	timerAirPhase:Start()
end

local function resetIsFlying()
	isFlying = false
end

mod:RegisterOnUpdateHandler(function(self, elapsed)
	if not self:IsInCombat() then return end
		local foundBoss, target
		for i = 1, GetNumRaidMembers() do
			local uId = "raid"..i.."target"
			if self:GetUnitCreatureId(uId) == 15989 and UnitAffectingCombat(uId) then
				target = UnitName(uId.."target")
				foundBoss = true
				break
			end
		end
		if foundBoss and not target then
			noTargetTime = noTargetTime + elapsed
		elseif foundBoss then
			noTargetTime = 0
		end
		if noTargetTime > 0.5 and not isFlying then
			noTargetTime = 0
			isFlying = true
			self:Schedule(60, resetIsFlying)
			timerDrainLife:Cancel()
			timerAirPhase:Cancel()
			warnAirPhaseNow:Show()
			timerLanding:Start()
		end
end, 0.2)
