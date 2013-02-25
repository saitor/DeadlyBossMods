if select(4, GetBuildInfo()) < 50200 then return end--Don't load on live
local mod	= DBM:NewMod(819, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(68476)
mod:SetModelID(47325)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_DIED"
)

local warnCharge				= mod:NewTargetAnnounce(136769, 4)
local warnPuncture				= mod:NewStackAnnounce(136767, 2, nil, mod:IsTank() or mod:IsHealer())
local warnDoubleSwipe			= mod:NewSpellAnnounce(136741, 3)
local warnDino					= mod:NewSpellAnnounce("ej7086", 3, 137237)
local warnMending				= mod:NewSpellAnnounce(136797, 4)
local warnBestialCry			= mod:NewStackAnnounce(136817, 3)
local warnRampage				= mod:NewTargetAnnounce(136821, 4, nil, mod:IsTank() or mod:IsHealer())
local warnDisorientingRoar		= mod:NewTargetAnnounce(137458, 4)

local specWarnCharge			= mod:NewSpecialWarningYou(136769)--Maybe add a near warning later. person does have 3.4 seconds to react though and just move out of group.
local yellCharge				= mod:NewYell(136769)
local specWarnDoubleSwipe		= mod:NewSpecialWarningSpell(136741, nil, nil, nil, 2)
local specWarnPuncture			= mod:NewSpecialWarningStack(136767, mod:IsTank(), 9)--9 seems like a good number, we'll start with that. Timing wise the swap typically comes when switching gates though.
local specWarnPunctureOther		= mod:NewSpecialWarningTarget(136767, mod:IsTank())
local specWarnSandTrap			= mod:NewSpecialWarningMove(136723)
local specWarnDino				= mod:NewSpecialWarningSwitch("ej7086", not mod:IsHealer())
local specWarnMending			= mod:NewSpecialWarningInterrupt(136797, mod:IsDps())--High priority interrupt. All dps needs warning because boss heals 1% per second it's not interrupted.
local specWarnFrozenBolt		= mod:NewSpecialWarningMove(136573)--Debuff used by Frozen Orbs
local specWarnJalak				= mod:NewSpecialWarningSwitch("ej7087", mod:IsTank())--To pick him up
local specWarnRampage			= mod:NewSpecialWarningTarget(136821, mod:IsTank() or mod:IsHealer())--Dog is pissed master died, need more heals and cooldowns. Maybe warn dps too? his double swipes and charges will be 100% worse too.
local specWarnDisorientingRoar	= mod:NewSpecialWarningSpell(137458, nil, nil, nil, 2)--Heroic

local timerAddsCD				= mod:NewTimer(113.5, "timerAddsCD", 2457)--They seem to be timed off last door start, not last door end. They MAY come earlier if you kill off all first doors adds though not sure yet. If they do, we'll just start new timer anyways
local timerDinoCD				= mod:NewNextTimer(56.75, "ej7086", nil, nil, nil, 137237)--It's between 55 and 60 seconds, I will need a more thorough log to verify by yelling when they spawn
local timerCharge				= mod:NewCastTimer(3.4, 136769)
local timerChargeCD				= mod:NewCDTimer(50, 136769)--50-60 second depending on i he's casting other stuff or stunned
local timerDoubleSwipeCD		= mod:NewCDTimer(18, 136741)--18 second cd unless delayed by a charge triggered double swipe, then it's extended by failsafe code
local timerPuncture				= mod:NewTargetTimer(90, 136767, nil, mod:IsTank() or mod:IsHealer())
local timerPunctureCD			= mod:NewCDTimer(11, 136767, nil, mod:IsTank() or mod:IsHealer())
local timerJalakCD				= mod:NewNextTimer(10, "ej7087", nil, nil, nil, 2457)--Maybe it's time for a better worded spawn timer than "Next mobname". Maybe NewSpawnTimer with "mobname activates" or something.
local timerBestialCryCD			= mod:NewNextCountTimer(10, 136817)
local timerDisorientingRoarCD	= mod:NewCDTimer(55, 137458)--Heroic

local jalakEngaged = false

function mod:OnCombatStart(delay)
	jalakEngaged = false
	timerPunctureCD:Start(-delay)
	timerDoubleSwipeCD:Start(16-delay)--16-17 second variation
	timerAddsCD:Start(16.5-delay)
	timerChargeCD:Start(31-delay)--31-35sec variation
	if self:IsDifficulty("heroic10", "heroic25") then
		timerDisorientingRoarCD:Start(-delay)
	end
	self:RegisterShortTermEvents(
		"INSTANCE_ENCOUNTER_ENGAGE_UNIT"--We register here to prevent detecting first heads on pull before variables reset from first engage fire. We'll catch them on delayed engages fired couple seconds later
	)
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

--[[
Back to backs, as expected
"<244.6 15:11:23> [CLEU] SPELL_CAST_START#false#0xF1310B7C0000383C#Horridon#68168#0##nil#-2147483648#-2147483648#136741#Double Swipe#1", -- [17383]
"<262.7 15:11:42> [CLEU] SPELL_CAST_START#false#0xF1310B7C0000383C#Horridon#68168#0##nil#-2147483648#-2147483648#136741#Double Swipe#1", -- [19036]
Delayed by Charge version
"<59.8 15:08:19> [CLEU] SPELL_CAST_START#false#0xF1310B7C0000383C#Horridon#68168#0##nil#-2147483648#-2147483648#136741#Double Swipe#1", -- [4747]
"<70.7 15:08:30> [CLEU] SPELL_CAST_START#false#0xF1310B7C0000383C#Horridon#68168#0##nil#-2147483648#-2147483648#136769#Charge#1", -- [5273]
"<74.8 15:08:34> [CLEU] SPELL_CAST_START#false#0xF1310B7C0000383C#Horridon#68168#0##nil#-2147483648#-2147483648#136770#Double Swipe#1", -- [5452]
"<86.4 15:08:45> [CLEU] SPELL_CAST_START#false#0xF1310B7C0000383C#Horridon#2632#0##nil#-2147483648#-2147483648#136741#Double Swipe#1", -- [6003]
--]]
function mod:SPELL_CAST_START(args)
	if args:IsSpellID(136741) then--Regular double swipe
		warnDoubleSwipe:Show()
		specWarnDoubleSwipe:Show()
		--The only flaw is charge is sometimes delayed by unexpected events like using an orb, we may fail to start timer once in a while when it DOES come before a charge.
		if timerChargeCD:GetTime() < 32 then--Check if charge is less than 18 seconds away, if it is, double swipe is going tobe delayed by quite a bit and we'll trigger timer after charge
			timerDoubleSwipeCD:Start()
		end
	elseif args:IsSpellID(136770) then--Double swipe that follows a charge (136769)
		warnDoubleSwipe:Show()
		specWarnDoubleSwipe:Show()
		timerDoubleSwipeCD:Start(11.5)--Hard coded failsafe. 136741 version is always 11.5 seconds after 136770 version
	elseif args:IsSpellID(137458) then
		warnDisorientingRoar:Show()
		specWarnDisorientingRoar:Show()
		timerDisorientingRoarCD:Start()--CD is reset when he breaks a door though.
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(136767) then
		warnPuncture:Show(args.destName, args.amount or 1)
		timerPuncture:Start(args.destName)
		timerPunctureCD:Start()
		if args:IsPlayer() then
			if (args.amount or 1) >= 9 then
				specWarnPuncture:Show(args.amount)
			end
		else
			if (args.amount or 1) >= 9 and not UnitDebuff("player", GetSpellInfo(136767)) and not UnitIsDeadOrGhost("player") then--Other tank has at least one stack and you have none
				specWarnPunctureOther:Show(args.destName)--So nudge you to taunt it off other tank already.
			end
		end
	--"<317.2 15:12:36> [CLEU] SPELL_AURA_APPLIED_DOSE#false#0xF1310B7C0000383C#Horridon#68168#0#0xF1310B7C0000383C#Horridon#68168#0#137240#Cracked Shell#1#BUFF#4", -- [21950]
	--"<327.0 15:12:46> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args:#1#1#Horridon#0xF1310B7C0000383C#elite#261178058#1#1#War-God Jalak <--War-God Jalak jumps down
	--He jumps down 10 seconds after 4th door is smashed, or when Horridon reaches 30%
	elseif args:IsSpellID(137240) and (args.amount or 1) == 4 and not jalakEngaged then--We check door smashes and whether or not jalak has jumped down yet
		timerJalakCD:Start(10)
	elseif args:IsSpellID(136817) then
		warnBestialCry:Show(args.destName, args.amount or 1)
		timerBestialCryCD:Start(5, (args.amount or 1)+1)
	elseif args:IsSpellID(136821) then
		warnRampage:Show(args.destName)
		specWarnRampage:Show(args.destName)
	elseif args:IsSpellID(136797) then
		warnMending:Show()
		specWarnMending:Show(args.sourceName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(136767) then
		timerPuncture:Cancel(args.destName)
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 136723 and destGUID == UnitGUID("player") and self:AntiSpam(3, 3) then
		specWarnSandTrap:Show()
	elseif spellId == 136573 and destGUID == UnitGUID("player") and self:AntiSpam(3, 3) then
		specWarnFrozenBolt:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT(event)
	if UnitExists("boss2") and tonumber(UnitGUID("boss2"):sub(6, 10), 16) == 69374 and not jalakEngaged then--Jalak is jumping down
		jalakEngaged = true--Set this so we know not to concern with 4th door anymore (plus so we don't fire extra warnings when we wipe and ENGAGE fires more)
		specWarnJalak:Show()
		timerBestialCryCD:Start(5, 1)
		self:UnregisterShortTermEvents()--TODO, maybe add unit health checks to warn dog is close to 40% if we aren't done with doors yet. If it's added, we can unregister health here as well
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find(L.chargeTarget) then
		warnCharge:Show(target)
		timerCharge:Start()
		timerChargeCD:Start()
		if target == UnitName("player") then
			specWarnCharge:Show()
			yellCharge:Yell()
		end
	elseif msg:find(L.newForces) then
		timerDinoCD:Start()
		warnDino:Schedule(56.75)
		specWarnDino:Schedule(56.75)
		timerAddsCD:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 69374 then
		timerBestialCryCD:Cancel()
	end
end
