﻿local mod	= DBM:NewMod("Algalon", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

--[[
--
--  Thanks to  Apathy @ Vek'nilash  who provided us with Informations and Combatlog about Algalon
--
--]]


mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(32871)

mod:RegisterCombat("combat")

mod:RegisterEvents(
    "UPDATE_WORLD_STATES",
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_YELL"
)

local announceBigBang			= mod:NewCastAnnounce(64584, 3)
local announcePreBigBang		= mod:NewAnnounce("PreWarningBigBang", 3, 64584)
local announceBlackHole			= mod:NewAnnounce("WarningBlackHole", 2, 65108)
local announceCosmicSmash		= mod:NewAnnounce("WarningCosmicSmash", 3, 62311)
local announcePhasePunch		= mod:NewAnnounce("WarningPhasePunch", 4, 65108)
--local WarningFirstPull		= mod:NewAnnounce("WarningFirstPull")--You're group is too much awesome for algalon. He needs more time to prepare

local specWarnPhasePunch		= mod:NewSpecialWarning("SpecWarnPhasePunch")
local specWarnBigBang			= mod:NewSpecialWarning("SpecWarnBigBang")
local specWarnCosmicSmash		= mod:NewSpecialWarning("SpecWarnCosmicSmash")

local timerCombatStart		    = mod:NewTimer(7, "TimerCombatStart")
local enrageTimer				= mod:NewEnrageTimer(360)
local timerNextBigBang			= mod:NewNextTimer(90.5, 64584)
local timerBigBangCast			= mod:NewCastTimer(8, 64584)
local timerNextCollapsingStar	= mod:NewTimer(15, "NextCollapsingStar")
local timerCDCosmicSmash		= mod:NewTimer(25, "PossibleNextCosmicSmash")
local timerCastCosmicSmash		= mod:NewCastTimer(4.5, 62311)
local timerPhasePunch			= mod:NewBuffActiveTimer(45, 64412)
local timerNextPhasePunch		= mod:NewNextTimer(16, 64412)

--[[
function mod:OnCombatStart(delay)
	local text = select(3, GetWorldStateUIInfo(1)) 
	local _, _, time = string.find(text, L.PullCheck) 
	if not time then 
        time = 60
    end
	if time == 60 then
		timerCombatStart:Start(25-delay)
		self:ScheduleMethod(25-delay, "startTimers")	-- 25 seconds roleplaying
	else 
		timerCombatStart:Start(-delay)
		self:ScheduleMethod(7-delay, "startTimers")	-- 7 seconds roleplaying
	end 
end

function mod:startTimers(delay)
	enrageTimer:Start(360 + delay)
	timerNextBigBang:Start(90.5 + delay)
	announcePreBigBang:Schedule(80 + delay)
	timerNextCollapsingStar:Start(15 + delay)
	timerCDCosmicSmash:Start(25 + delay)
end--]]

--Backup function that wouldn't be as pretty but would probably work.

    function mod:OnCombatStart(delay)
	-- added 7 seconds because of +combat until spawn difference
    timerCombatStart:Start(-delay)
	enrageTimer:Start(367-delay)
	timerNextBigBang:Start(97.5-delay)
	announcePreBigBang:Schedule(87-delay)
	timerNextCollapsingStar:Start(22-delay)
	timerCDCosmicSmash:Start(32-delay)
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellPullFirst then
	-- cancel timers and resync to extra delay in combat start(another 10 sec after this yell til actual combat).
	WarningFirstPull:Show()
	enrageTimer:Cancel()
	timerNextBigBang:Cancel()
	announcePreBigBang:Cancel()
	timerNextCollapsingStar:Cancel()
	timerCDCosmicSmash:Cancel()
    timerCombatStart:Start(10-delay)
	enrageTimer:Start(370-delay)
	timerNextBigBang:Start(100.5-delay)
	announcePreBigBang:Schedule(90-delay)
	timerNextCollapsingStar:Start(25-delay)
	timerCDCosmicSmash:Start(35-delay)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(64584, 64443) then 	-- Big Bang
		timerBigBangCast:Start()
		timerNextBigBang:Start()
		announceBigBang:Show()
		announcePreBigBang:Schedule(80)
		specWarnBigBang:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(65108, 64122) then 	-- Black Hole Explosion
		announceBlackHole:Show()

	elseif args:IsSpellID(64598, 62301) then	-- Cosmic Smash
		timerCastCosmicSmash:Start()
		timerCDCosmicSmash:Start()
		announceCosmicSmash:Show()
		specWarnCosmicSmash:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(64412) then
		timerNextPhasePunch:Start()
		local amount = args.amount or 1
		if args:IsPlayer() and amount >= 4 then
			specWarnPhasePunch:Show()
		end
		timerPhasePunch:Start(args.destName)
		announcePhasePunch:Show(args.destName, amount)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED


function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.Emote_CollapsingStar or msg:find(L.Emote_CollapsingStar) then
		timerNextCollapsingStar:Start()
	elseif msg == L.Emote_CosmicSmash or msg:find(L.Emote_CosmicSmash) then
		timerCastCosmicSmash:Start()
		timerCDCosmicSmash:Start()
		announceCosmicSmash:Show()
		specWarnCosmicSmash:Show()
	end
end



