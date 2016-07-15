local mod	= DBM:NewMod(1725, "DBM-Nighthold", nil, 786)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(104415)--104731 (Depleted Time Particle). 104676 (Waning Time Particle). 104491 (Accelerated Time particle). 104492 (Slow Time Particle)
mod:SetEncounterID(1865)
mod:SetZone()
--mod:SetUsedIcons(5, 4, 3, 2, 1)--sometimes it was 5 targets, sometimes it was whole raid. even post nerf. have to see
--mod:SetHotfixNoticeRev(12324)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 211927 207228",
	"SPELL_CAST_SUCCESS 219815",
	"SPELL_AURA_APPLIED 206617 206609 207052 207051 206607 211927",
	"SPELL_AURA_APPLIED_DOSE 206607",
	"SPELL_AURA_REMOVED 206617 206609 207052 207051 211927",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
)

--TODO, figure out how often tanks need to swap, adjust warnings accordingly
--TODO, More data to complete sequences of timers
--TODO, Determine if not interrupting OP affects things badly. For most part it shouldn't
--TODO, info frame with debuff shield (health) remaining sorted highest to lowest.
--(ability.id = 206618 or ability.id = 206610 or ability.id = 206614) and type = "cast" or ability.id = 211927
local warnTimeBomb					= mod:NewTargetAnnounce(206617, 3)
local warnTimeRelease				= mod:NewTargetAnnounce(206610, 3, nil, false)--Too many targets
local warnChronometricPart			= mod:NewStackAnnounce(206607, 3, nil, "Tank")

local specWarnTemporalOrbs			= mod:NewSpecialWarningDodge(219815, nil, nil, nil, 2, 2)
local specWarnPowerOverwhelmingKick	= mod:NewSpecialWarningInterrupt(211927, "Tank", nil, nil, 3, 2)
local specWarnTimeBomb				= mod:NewSpecialWarningMoveAway(206617, nil, nil, nil, 1, 2)--When close to expiring, not right away
local yellTimeBomb					= mod:NewFadesYell(206617)
local specWarnWarp					= mod:NewSpecialWarningInterrupt(207228, "HasInterrupt", nil, nil, 1, 2)
local specWarnBigAdd				= mod:NewSpecialWarningSwitch(206700, "-Healer", nil, nil, 1, 2)--Switch to waning time particle when section info known
local specWarnSmallAdd				= mod:NewSpecialWarningSwitch(206699, "Tank", nil, nil, 1, 2)

local timerTemporalOrbsCD			= mod:NewNextCountTimer(30, 219815, nil, nil, nil, 2)
local timerPowerOverwhelmingCD		= mod:NewNextTimer(60, 211927, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerTimeBomb					= mod:NewBuffFadesTimer(30, 206617, nil, nil, nil, 5)
local timerTimeBombCD				= mod:NewNextCountTimer(30, 206617, nil, nil, nil, 3)
local timerBurstofTimeCD			= mod:NewNextCountTimer(30, 206614, nil, nil, nil, 3)
local timerTimeReleaseCD			= mod:NewNextCountTimer(30, 206610, nil, "Healer", nil, 5, nil, DBM_CORE_HEALER_ICON)
local timerChronoPartCD				= mod:NewCDTimer(10.4, 206607, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerBigAddCD					= mod:NewNextTimer(30, 206700, nil, nil, nil, 1)--Switch to waning time particle when section info known
--local timerSmallAddCD				= mod:NewNextTimer(30, 206699, nil, nil, nil, 1)--Switch to Depleted Time Particle when section info known

local countdownBigAdd				= mod:NewCountdown(30, 206700)--Switch to waning time particle when section info known
local countdownTimeBomb				= mod:NewCountdownFades("AltTwo30", 206617)

local voiceTemporalOrbs				= mod:NewVoice(219815)--watchstep
local voicePowerOverwhelming		= mod:NewVoice(211927)--kickcast
local voiceTimeBomb					= mod:NewVoice(206617)--scatter
local voiceWarp						= mod:NewVoice(207228, "HasInterrupt")--kickcast
local voiceBigAdd					= mod:NewVoice(206700, "-Healer")
local voiceSmallAdd					= mod:NewVoice(206699, "Tank")

mod:AddRangeFrameOption(10, 206617)
mod:AddInfoFrameOption(206617)
--mod:AddSetIconOption("SetIconOnTimeRelease", 206610, true)

mod.vb.OPActive = false
mod.vb.normCount = 0
mod.vb.fastCount = 0
mod.vb.slowCount = 0
mod.vb.timeBombDebuffCount = 0

function mod:OnCombatStart(delay)
	self.vb.OPActive = false
	self.vb.normCount = 0
	self.vb.fastCount = 0
	self.vb.slowCount = 0
	self.vb.timeBombDebuffCount = 0
	--No timers here, started by speed events
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 211927 then
		timerChronoPartCD:Stop()--Will be used immediately when this ends.
		timerPowerOverwhelmingCD:Start()
	elseif spellId == 207228 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnWarp:Show(args.sourceName)
		voiceWarp:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 219815 then
		specWarnTemporalOrbs:Show()
		voiceTemporalOrbs:Play("watchstep")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 206617 then
		self.vb.timeBombDebuffCount = self.vb.timeBombDebuffCount + 1
		warnTimeBomb:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			local _, _, _, _, _, duration, expires, _, _ = UnitDebuff("player", args.spellName)
			if expires then
				local debuffTime = expires - GetTime()
				specWarnTimeBomb:Schedule(debuffTime - 5)	-- Show "move away" warning 5secs before explode
				voiceTimeBomb:Schedule(debuffTime - 5, "scatter")
				timerTimeBomb:Start(debuffTime)
				countdownTimeBomb:Start(debuffTime)
				yellTimeBomb:Schedule(debuffTime-1, 1)
				yellTimeBomb:Schedule(debuffTime-2, 2)
				yellTimeBomb:Schedule(debuffTime-3, 3)
				if self.Options.RangeFrame then
					DBM.RangeCheck:Show(10)
				end
			end
		end
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(10, "playerdebuffremaining", args.spellName)
		end
	elseif spellId == 206609 or spellId == 207052 or spellId == 207051 then--207051 and 207052 didn't appear on heroic
		warnTimeRelease:CombinedShow(0.5, args.destName)
--		if self.Options.SetIconOnTimeRelease then
--			self:SetSortedIcon(0.5, args.destName, 1)--Add expected max count when known?
--		end
	elseif spellId == 206607 then
		local amount = args.amount or 1
		warnChronometricPart:Show(args.destName, amount)
		timerChronoPartCD:Start()--Move timer to success if this can be avoided
	elseif spellId == 211927 then
		self.vb.OPActive = true
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 206617 then
		self.vb.timeBombDebuffCount = self.vb.timeBombDebuffCount - 1
		if args:IsPlayer() then
			specWarnTimeBomb:Cancel()
			voiceTimeBomb:Cancel()
			timerTimeBomb:Stop()
			countdownTimeBomb:Cancel()
			yellTimeBomb:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
		if self.Options.InfoFrame and self.vb.timeBombDebuffCount == 0 then
			DBM.InfoFrame:Hide()
		end
	elseif spellId == 206609 or spellId == 207052 or spellId == 207051 then--207051 and 207052 didn't appear on heroic
--		if self.Options.SetIconOnTimeRelease then
--			self:SetIcon(args.destName, 0)
--		end
	elseif spellId == 211927 then--Overwhelming Power ended
		self.vb.OPActive = false
	end
end

local function delayedBurst(self, time, count)
	timerBurstofTimeCD:Start(time, count)
end
local function delayedTimeRelease(self, time, count)
	timerTimeReleaseCD:Start(time, count)
end
local function delayedTimeBomb(self, time, count)
	timerTimeBombCD:Start(time, count)
end
local function delayedOrbs(self, time, count)
	timerTemporalOrbsCD:Start(time, count)
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	--Boss has 3 phase speeds with multiple scripts. Order is predictable however
	--The timers for each variation are hard coded because it's most accurate means of doing them
	--Doing sequence tables is less accurate because of how uninterrupted overwhelming power affect such design.
	if spellId == 207012 then--Speed: Normal
		self.vb.normCount = self.vb.normCount + 1
		if self.vb.normCount == 1 then
			if self:IsMythic() then
				timerTimeBombCD:Start(5, 1)
				timerTimeReleaseCD:Start(10, 1)
				timerBurstofTimeCD:Start(15, 1)
				self:Schedule(15, delayedBurst, self, 10, 2)--25
				self:Schedule(10, delayedTimeRelease, self, 20, 2)--30
				self:Schedule(25, delayedBurst, self, 10, 3)--35
			elseif self:IsHeroic() then--Probably changed.
				timerTimeReleaseCD:Start(5, 1)
				timerBurstofTimeCD:Start(10, 1)
				--timerSmallAddCD:Start(10)
				self:Schedule(5, delayedTimeRelease, self, 15, 2)--20
				timerBigAddCD:Start(25)
				countdownBigAdd:Start(25)
				timerTimeBombCD:Start(35, 1)
				self:Schedule(10, delayedBurst, self, 25, 2)--35
				timerTemporalOrbsCD:Start(40, 1)
				self:Schedule(20, delayedTimeRelease, self, 25, 3)--45
				self:Schedule(35, delayedBurst, self, 20, 3)--55
				timerPowerOverwhelmingCD:Start(60)
			else--Normal confirmed, LFR assumed.
				timerTimeReleaseCD:Start(5, 1)
				timerBurstofTimeCD:Start(13, 1)
				self:Schedule(13, delayedBurst, self, 5, 2)--18
				self:Schedule(5, delayedTimeRelease, self, 20, 2)--25
				timerBigAddCD:Start(33)
				countdownBigAdd:Start(33)
				timerTimeBombCD:Start(40, 1)
				self:Schedule(18, delayedBurst, self, 27, 3)--45
				timerTemporalOrbsCD:Start(53, 1)
				timerPowerOverwhelmingCD:Start(60)
			end
		elseif self.vb.normCount == 2 then
			if self:IsMythic() then
				timerTimeReleaseCD:Start(5, 1)
				timerTemporalOrbsCD:Start(10, 1)
				timerTimeBombCD:Start(15, 1)
				timerPowerOverwhelmingCD:Start(25)
				--Notes. This phase is 48 seconds. Depending on how fast OP is interrupted you'll see another burst of time and time bomb
				--Burst of time will be exactly 10 seconds after interrupt of OP and time bomb 5 seconds after burst.
				--TODO, some complicated mess of code to activate special "additional ability" timers when boss is interrupted during OP
				--For now, timers are below here with less accuracy
				timerBurstofTimeCD:Start(35, 1)
				self:Schedule(15, delayedTimeBomb, self, 25, 2)--40
				timerBigAddCD:Start(45)--Could be 48, but I suspect that was just delayed by a slow interrupt of OP
				countdownBigAdd:Start(45)
			elseif self:IsHeroic() then--Probably changed.
				timerTimeBombCD:Start(5, 1)
				timerTimeReleaseCD:Start(10, 1)
				timerBurstofTimeCD:Start(20, 1)
				self:Schedule(10, delayedTimeRelease, self, 15, 2)--25
				self:Schedule(5, delayedTimeBomb, self, 25, 2)--30
				self:Schedule(25, delayedTimeRelease, self, 10, 3)--35
				timerBigAddCD:Start(45)
				countdownBigAdd:Start(45)
				timerTemporalOrbsCD:Start(55, 1)
				timerPowerOverwhelmingCD:Start(60)
				--There may be some missing timers here based on duration of power overwhelming clipping some other timers
				self:Schedule(35, delayedTimeRelease, self, 50, 4)--85
			else
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			end
		else
			if self:IsMythic() then
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			elseif self:IsHeroic() then--Probably changed.
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			else
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			end
		end
	elseif spellId == 207011 then--Speed: Slow
		self.vb.slowCount = self.vb.slowCount + 1
		if self.vb.slowCount == 1 then
			if self:IsMythic() then
				timerTemporalOrbsCD:Start(5, 1)
				timerBurstofTimeCD:Start(15, 1)
				timerTimeBombCD:Start(18, 1)--Odd, the only non 5s timer in like all of this bosses tables.
				timerTimeReleaseCD:Start(20, 1)
				timerPowerOverwhelmingCD:Start(25)
			elseif self:IsHeroic() then--Probably changed.
				timerTimeReleaseCD:Start(5, 1)
				timerTimeBombCD:Start(20, 1)
				timerBurstofTimeCD:Start(20, 1)
				--timerSmallAddCD:Start(25)
				timerTemporalOrbsCD:Start(30, 1)
				self:Schedule(20, delayedBurst, self, 10, 2)--30
				self:Schedule(5, delayedTimeRelease, self, 30, 2)--35
				self:Schedule(20, delayedTimeBomb, self, 20, 2)--40
				timerBigAddCD:Start(45)
				countdownBigAdd:Start(45)
				self:Schedule(30, delayedBurst, self, 20, 3)--50
				timerPowerOverwhelmingCD:Start(60)
			else
				timerTimeReleaseCD:Start(5, 1)
				timerBurstofTimeCD:Start(13, 1)
				self:Schedule(13, delayedBurst, self, 5, 2)--18
				timerTimeBombCD:Start(25, 1)
				timerTemporalOrbsCD:Start(33, 1)
				timerBigAddCD:Start(40)
				countdownBigAdd:Start(40)
				self:Schedule(5, delayedTimeRelease, self, 43, 2)--48
				self:Schedule(18, delayedBurst, self, 32, 3)--50
				timerPowerOverwhelmingCD:Start(60)
			end
		elseif self.vb.slowCount == 2 then
			if self:IsMythic() then
				timerBurstofTimeCD:Start(5, 1)
				timerTimeReleaseCD:Start(15, 1)
				self:Schedule(5, delayedBurst, self, 20, 2)--25
				self:Schedule(25, delayedBurst, self, 5, 3)--30
				self:Schedule(15, delayedTimeRelease, self, 20, 2)--35
				self:Schedule(25, delayedBurst, self, 20, 4)--45
				timerTemporalOrbsCD:Start(50, 1)
				timerPowerOverwhelmingCD:Start(60)
			elseif self:IsHeroic() then--Probably changed.
				timerTimeReleaseCD:Start(5, 1)
				timerTemporalOrbsCD:Start(15, 1)
				timerBurstofTimeCD:Start(20, 1)
				timerBigAddCD:Start(25)
				countdownBigAdd:Start(25)
				self:Schedule(20, delayedBurst, self, 10, 2)--30
				self:Schedule(30, delayedBurst, self, 5, 3)--35
				timerPowerOverwhelmingCD:Start(40)
				self:Schedule(35, delayedBurst, self, 10, 4)--45
				self:Schedule(45, delayedBurst, self, 5, 5)--50
				--This may be incomplete.
				DBM:AddMsg("There is incomplete timer data beyond 50 second mark of Slow-2 phase. Please submit transcriptor log to improve this mod")
			else
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			end
		else
			if self:IsMythic() then
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			elseif self:IsHeroic() then--Probably changed.
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			else
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			end
		end
	elseif spellId == 207013 then--Speed: Fast
		self.vb.fastCount = self.vb.fastCount + 1
		if self.vb.fastCount == 1 then
			if self:IsMythic() then
				timerTimeReleaseCD:Start(5, 1)
				timerBigAddCD:Start(10)
				countdownBigAdd:Start(10)
				timerBurstofTimeCD:Start(15, 1)
				timerTemporalOrbsCD:Start(25, 1)
				timerPowerOverwhelmingCD:Start(30)
			elseif self:IsHeroic() then--Probably changed.
				timerTimeReleaseCD:Start(5, 1)
				--timerSmallAddCD:Start(10)
				self:Schedule(5, delayedTimeRelease, self, 5, 2)--10
				timerBurstofTimeCD:Start(15, 1)
				timerTimeBombCD:Start(25, 1)
				self:Schedule(10, delayedTimeRelease, self, 20, 3)--30
				timerBigAddCD:Start(35)
				countdownBigAdd:Start(35)
				self:Schedule(30, delayedTimeRelease, self, 10, 4)--40
				timerTemporalOrbsCD:Start(50, 1)
				timerPowerOverwhelmingCD:Start(60)
			else
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			end
		elseif self.vb.fastCount == 2 then
			if self:IsMythic() then
				timerBurstofTimeCD:Start(5, 1)
				timerBurstofTimeCD:Start(8, 2)
				timerTemporalOrbsCD:Start(13, 1)
				timerTimeReleaseCD:Start(23, 1)
				self:Schedule(8, delayedBurst, self, 17, 3)--25
				timerTimeBombCD:Start(30, 1)
				self:Schedule(23, delayedTimeRelease, self, 12, 2)--35
				self:Schedule(35, delayedTimeRelease, self, 5, 3)--40
				self:Schedule(25, delayedBurst, self, 20, 4)--45
				self:Schedule(13, delayedOrbs, self, 37, 2)--50
				timerBigAddCD:Start(55)
				countdownBigAdd:Start(55)
				timerPowerOverwhelmingCD:Start(60)
			elseif self:IsHeroic() then--Probably changed.
				timerBurstofTimeCD:Start(5, 1)
				self:Schedule(5, delayedBurst, self, 5, 2)--10
				self:Schedule(10, delayedBurst, self, 5, 3)--15
				timerTemporalOrbsCD:Start(20, 1)
				self:Schedule(15, delayedBurst, self, 10, 4)--25
				timerTimeBombCD:Start(30, 1)
				timerTimeReleaseCD:Start(40, 1)
				--timerSmallAddCD:Start(45)
				self:Schedule(25, delayedBurst, self, 25, 5)--50
			else
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			end
		elseif self.vb.fastCount == 3 then
			if self:IsMythic() then
				timerTimeReleaseCD:Start(5, 1)
				timerBurstofTimeCD:Start(10, 1)
				self:Schedule(10, delayedBurst, self, 5, 2)--15
				self:Schedule(5, delayedTimeRelease, self, 15, 2)--20
				self:Schedule(15, delayedBurst, self, 10, 3)--25
				self:Schedule(20, delayedTimeRelease, self, 10, 3)--30
				self:Schedule(30, delayedTimeRelease, self, 5, 4)--35
				self:Schedule(35, delayedTimeRelease, self, 5, 5)--40
				DBM:AddMsg("There is incomplete timer data beyond 40 second mark of Fast-3 phase. Please submit transcriptor log to improve this mod")
			elseif self:IsHeroic() then--Probably changed.
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			else
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			end
		else
			if self:IsMythic() then
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			elseif self:IsHeroic() then--Probably changed.
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			else
				DBM:AddMsg("There is no timer data going this far into the fight. Please submit transcriptor log to improve this mod")
			end
		end
	elseif spellId == 206699 then--Summon Haste Add (Small Adds)
		specWarnSmallAdd:Show()
		voiceSmallAdd:Play("mobsoon")
	elseif spellId == 206700 then--Summon Slow Add (Big Adds)
		specWarnBigAdd:Show()
		voiceBigAdd:Play("bigmobsoon")
	elseif spellId == 212072 then--Temporal Rift (Slightly faster than combat log)
		if self.vb.OPActive and self:AntiSpam(5, 1) then--Rift available, boss is casting Overwhelming Power, warn to interrupt now
			specWarnPowerOverwhelmingKick:Show(UnitName("boss1"))
			voicePowerOverwhelming:Play("kickcast")
		end
	end
end
