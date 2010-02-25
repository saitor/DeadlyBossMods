﻿local mod	= DBM:NewMod("Sindragosa", "DBM-Icecrown", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(36853)
mod:RegisterCombat("combat")
mod:SetMinCombatTime(25)
mod:SetMinSyncRevision(3712)
mod:SetUsedIcons(3, 4, 5, 6, 7, 8)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_SUCCESS",
	"UNIT_HEALTH",
	"CHAT_MSG_MONSTER_YELL"
)

local warnAirphase				= mod:NewAnnounce("WarnAirphase")
local warnGroundphaseSoon		= mod:NewAnnounce("WarnGroundphaseSoon", 2)
local warnPhase2soon			= mod:NewAnnounce("warnPhase2soon")
local warnPhase2				= mod:NewPhaseAnnounce(2)
local warnInstability			= mod:NewAnnounce("warnInstability", 2, nil, false)
local warnChilledtotheBone		= mod:NewAnnounce("warnChilledtotheBone", 2, nil, false)
local warnMysticBuffet			= mod:NewAnnounce("warnMysticBuffet", 2, nil, false)
local warnFrostBeacon			= mod:NewTargetAnnounce(70126)
local warnBlisteringCold		= mod:NewSpellAnnounce(70123, 3)
local warnFrostBreath			= mod:NewSpellAnnounce(71056, 3)
local warnUnchainedMagic		= mod:NewTargetAnnounce(69762)

local specWarnBlisteringCold	= mod:NewSpecialWarningRun(70123)
local specWarnUnchainedMagic	= mod:NewSpecialWarningYou(69762)
local specWarnFrostBeacon		= mod:NewSpecialWarningYou(70126)
local specWarnInstability		= mod:NewSpecialWarningStack(69766, nil, 4)
local specWarnChilledtotheBone	= mod:NewSpecialWarningStack(70106, nil, 4)
local specWarnMysticBuffet		= mod:NewSpecialWarningStack(70128, false, 4)

local timerNextAirphase			= mod:NewTimer(110, "TimerNextAirphase", 43810)
local timerNextGroundphase		= mod:NewTimer(45, "TimerNextGroundphase", 43810)
local timerNextFrostBreath		= mod:NewNextTimer(22, 71056)
local timerNextBlisteringCold	= mod:NewCDTimer(69, 70123)
local timerBlisteringCold		= mod:NewCastTimer(6, 70123)
local timerInstability			= mod:NewBuffActiveTimer(8, 69766)
local timerChilledtotheBone		= mod:NewBuffActiveTimer(8, 70106)
local timerMysticBuffet			= mod:NewBuffActiveTimer(8, 70128)
local timerNextMysticBuffet		= mod:NewNextTimer(6, 70128)

local berserkTimer				= mod:NewBerserkTimer(600)

local soundBlisteringCold = mod:NewSound(70123)
mod:AddBoolOption("SetIconOnFrostBeacon", true)
mod:AddBoolOption("SetIconOnUnchainedMagic", true)
mod:AddBoolOption("ClearIconsOnAirphase", true)
mod:AddBoolOption("AnnounceFrostBeaconIcons", false)

local beaconTargets		= {}
local beaconIconTargets	= {}
local unchainedTargets	= {}
local warned_P2 = false
local unchainedIcons = 8

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	timerNextAirphase:Start(50-delay)
	timerNextBlisteringCold:Start(35-delay)
	warned_P2 = false
	table.wipe(beaconTargets)
	table.wipe(beaconIconTargets)
	table.wipe(unchainedTargets)
	unchainedIcons = 8
end

do
	local function sort_by_group(v1, v2)
		return DBM:GetRaidSubgroup(UnitName(v1)) < DBM:GetRaidSubgroup(UnitName(v2))
	end
	function mod:SetBeaconIcons()
		if DBM:GetRaidRank() > 0 then
			table.sort(beaconIconTargets, sort_by_group)
			local beaconIcons = 8
			for i, v in ipairs(beaconIconTargets) do
				if self.Options.AnnounceFrostBeaconIcons then
					SendChatMessage(L.BeaconIconSet:format(beaconIcons, UnitName(v)), "RAID")
				end
				mod:SetIcon(UnitName(v), beaconIcons, 8)
				beaconIcons = beaconIcons - 1
			end
			table.wipe(beaconIconTargets)
		end
	end
end

local function warnBeaconTargets()
	warnFrostBeacon:Show(table.concat(beaconTargets, "<, >"))
	table.wipe(beaconTargets)
end

local function warnUnchainedTargets()
	warnUnchainedMagic:Show(table.concat(unchainedTargets, "<, >"))
	table.wipe(unchainedTargets)
	unchainedIcons = 8
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(69649, 71056, 71057, 71058) then--Frost Breath
		warnFrostBreath:Show()
		timerNextFrostBreath:Start()
	end
end	

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(70126) then
		beaconTargets[#beaconTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnFrostBeacon:Show()
		end
		if self.Options.SetIconOnFrostBeacon then
			table.insert(beaconIconTargets, DBM:GetRaidUnitId(args.destName))
			mod:ScheduleMethod(0.3, "SetBeaconIcons")
		end
		self:Unschedule(warnBeaconTargets)
		if #beaconTargets >= 6 then
			warnBeaconTargets()
		else
			self:Schedule(0.3, warnBeaconTargets)
		end
	elseif args:IsSpellID(69762) then
		unchainedTargets[#unchainedTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnUnchainedMagic:Show()
		end
		if self.Options.SetIconOnUnchainedMagic then
			self:SetIcon(args.destName, unchainedIcons, 30)
			unchainedIcons = unchainedIcons - 1
		end
		self:Unschedule(warnUnchainedTargets)
		if #unchainedTargets >= 6 then
			warnUnchainedTargets()
		else
			self:Schedule(0.3, warnUnchainedTargets)
		end
	elseif args:IsSpellID(70106) then	--Chilled to the bone (melee)
		if args:IsPlayer() then
			warnChilledtotheBone:Show(args.amount or 1)
			timerChilledtotheBone:Start()
			if (args.amount or 1) >= 4 then
				specWarnChilledtotheBone:Show(args.amount)
			end
		end
	elseif args:IsSpellID(69766) then	--Instability (casters)
		if args:IsPlayer() then
			warnInstability:Show(args.amount or 1)
			timerInstability:Start()
			if (args.amount or 1) >= 4 then
				specWarnInstability:Show(args.amount)
			end
		end
	elseif args:IsSpellID(70127, 72528, 72529, 72530) then	--Mystic Buffet (phase 3 - everyone)
		if args:IsPlayer() then
			warnMysticBuffet:Show(args.amount or 1)
			timerMysticBuffet:Start()
			timerNextMysticBuffet:Start()
			if (args.amount or 1) >= 4 then
				specWarnMysticBuffet:Show(args.amount)
			end
		end
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(70117) then--Icy Grip Cast, not blistering cold, but adds an extra 1sec to the warning
		warnBlisteringCold:Show()
		specWarnBlisteringCold:Show()
		timerBlisteringCold:Start()
		timerNextBlisteringCold:Start()
		soundBlisteringCold:Play()
	end
end	

function mod:UNIT_HEALTH(uId)
	if not warned_P2 and self:GetUnitCreatureId(uId) == 36853 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.38 then
		warned_P2 = true
		warnPhase2soon:Show()	
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellAirphase or msg:find(L.YellAirphase) then
		self:SendSync("Airphase")
	elseif msg == L.YellPhase2 or msg:find(L.YellPhase2) then
		self:SendSync("Phase2")
	end
end

function mod:OnSync(msg, arg)
	if msg == "Airphase" then
		warnAirphase:Show()
		timerNextFrostBreath:Cancel()
		timerNextBlisteringCold:Start(89)--Not exact anywhere from 90-110seconds after airphase begin
		timerNextAirphase:Start()
		timerNextGroundphase:Start()
		warnGroundphaseSoon:Schedule(40)
		if self.Options.ClearIconsOnAirphase then
			self:ClearIcons()
		end
	elseif msg == "Phase2" then
		warnPhase2:Show()
		timerNextAirphase:Cancel()
		timerNextGroundphase:Cancel()
		warnGroundphaseSoon:Cancel()
	end
end


--[[
-- Middle
[02:06:50]Dump: value=GetPlayerMapPosition"player"
[02:06:50][1]=0.36565238237381,
[02:06:50][2]=0.23331482708454

-- right side
[02:08:23]Dump: value=GetPlayerMapPosition"player"
[02:08:23][1]=0.37875413894653,
[02:08:23][2]=0.23325897753239

-- front side
[02:09:07]Dump: value=GetPlayerMapPosition"player"
[02:09:07][1]=0.36571484804153,
[02:09:07][2]=0.25335687398911

-- left side
[02:09:49]Dump: value=GetPlayerMapPosition"player"
[02:09:49][1]=0.35263139009476,
[02:09:49][2]=0.23302799463272

-- back side
[02:11:19]Dump: value=GetPlayerMapPosition"player"
[02:11:19][1]=0.36497965455055,
[02:11:19][2]=0.21286574006081


-- 10er front
[02:13:25]Dump: value=GetPlayerMapPosition"player"
[02:13:25][1]=0.37788701057434,
[02:13:25][2]=0.22191077470779
-- back
[02:13:42]Dump: value=GetPlayerMapPosition"player"
[02:13:42][1]=0.3777784705162,
[02:13:42][2]=0.24382147192955


-- Phase2 Position @ 10er
[02:15:58]Dump: value=GetPlayerMapPosition"player"
[02:15:58][1]=0.39305117726326,
[02:15:58][2]=0.1760238558054

-- additional @ 25er
[02:16:42]Dump: value=GetPlayerMapPosition"player"
[02:16:42][1]=0.39389464259148,
[02:16:42][2]=0.24755308032036
--]]



