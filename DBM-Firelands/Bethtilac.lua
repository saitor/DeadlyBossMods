local mod	= DBM:NewMod("Bethtilac", "DBM-Firelands")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(52498)
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_DIED"
)

--[[
	Smoldering Devastation has a blizzard emote
--]]

local timerSpinners 			= mod:NewTimer(18, "TimerSpinners") -- 10secs after Smoldering (10+8)
local timerSpiderlings			= mod:NewTimer(30, "TimerSpiderlings")
local timerDrone			= mod:NewTimer("TimerDrone", 60)
local timerSmolderingDevastation	= mod:NewNextTimer(90, 99052)
local timerSmolderingDevastationTimer	= mod:NewCastTimer(8, 99052)

local droneCount = 0

function mod:repeatSpiderlings()
	timerSpiderlings:Start()
	self:ScheduleMethod(30, "repeatSpiderlings")
end

function mod:repeatDrone()
	if droneCount >= 4 then return end	-- 4th dead = P2 = no more drones?
	timerDrone:Start()
	self:ScheduleMethod(60, "repeatDrone")
end

function mod:OnCombatStart(delay)
	timerSmolderingDevastation:Start(-delay)
	timerSpinners:Start(11-delay)
	timerSpiderlings:Start(12-delay)
	self:ScheduleMethod(11-delay , "repeatSpiderlings")
	timerDrone:Start(45-delay)
	self:ScheduleMethod(45-delay, "repeatDrone")
	droneCount = 0
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(99052) then
		timerSmolderingDevastation:Start()
		timerSmolderingDevastationTimer:Start()
		timerSpinners:Start() -- 10secs after Smoldering Devastation
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 53635 then -- guessed creature ID
		droneCount = droneCount + 1
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.EmoteSpiderlings then
		self:UnscheduleMethod("repeatSpiderlings")	-- in case it is off for some reason (if it is a little random)
		self:repeatSpiderlings()
	end
end
