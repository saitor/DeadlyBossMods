local mod	= DBM:NewMod(856, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71859, 71858)--haromm, Kardris
mod:SetZone()
mod:SetUsedIcons(5, 4, 3, 2, 1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED"
)

--Dogs
local warnRend						= mod:NewStackAnnounce(144304, 2, nil, mod:IsTank() or mod:IsHealer(), nil, nil, nil, nil, 2)

--General
local warnPoisonmistTotem			= mod:NewSpellAnnounce(144288, 3)--85%
local warnFoulstreamTotem			= mod:NewSpellAnnounce(144289, 3)--65%
local warnAshflareTotem				= mod:NewSpellAnnounce(144290, 3)--45%
local warnRustedIronTotem			= mod:NewSpellAnnounce(144291, 3)--Heroic (95%)

--Earthbreaker Haromm
local warnFroststormStrike			= mod:NewStackAnnounce(144215, 2, nil, mod:IsTank() or mod:IsHealer(), nil, nil, nil, nil, 2)
local warnToxicMists				= mod:NewTargetAnnounce(144089, 2, nil, false, nil, nil, nil, nil, 2)
local warnFoulStream				= mod:NewTargetAnnounce(144090, 4)
local warnAshenWall					= mod:NewSpellAnnounce(144070, 4)
local warnIronTomb					= mod:NewSpellAnnounce(144328, 3)
--Wavebinder Kardris
local warnToxicStorm				= mod:NewTargetAnnounce(144005, 2)
local warnFoulGeyser				= mod:NewTargetAnnounce(143990, 4)
local warnFallingAsh				= mod:NewCastAnnounce(143973, 4, 15)
local warnIronPrison				= mod:NewTargetAnnounce(144330, 3)

--Earthbreaker Haromm
local specWarnFroststormStrike		= mod:NewSpecialWarningStack(144215, mod:IsTank(), 5)
local specWarnFroststormStrikeOther	= mod:NewSpecialWarningTarget(144215, mod:IsTank())
local specWarnFoulStreamYou			= mod:NewSpecialWarningYou(144090)
local yellFoulStream				= mod:NewYell(144090)
local specWarnFoulStream			= mod:NewSpecialWarningSpell(144090, nil, nil, nil, 2)
local specWarnAshenWall				= mod:NewSpecialWarningSpell(144070, not mod:IsHealer(), nil, nil, 2, 2)
local specWarnIronTomb				= mod:NewSpecialWarningSpell(144328, nil, nil, nil, 2)
--Wavebinder Kardris
local specWarnToxicStorm			= mod:NewSpecialWarningYou(144017)--Spellid changed to force an option default reset. melee default was for ptr version that always targeted tank
local specWarnToxicStormNear		= mod:NewSpecialWarningClose(144005)
local yellToxicStorm				= mod:NewYell(144005)
local specWarnFoulGeyser			= mod:NewSpecialWarningSpell(143990)
local yellFoulGeyser				= mod:NewYell(143990)
local specWarnFallingAsh			= mod:NewSpecialWarningPreWarn(143973, nil, 3, nil, 2)
local specWarnIronPrison			= mod:NewSpecialWarningSoon(144330)--If this generic isn't too clear i'll localize it. this is warning that it's about to expire not that it's just been applied
local yellIronPrisonFades			= mod:NewYell(144330, L.PrisonYell, false)--Off by default since it's an atypical yell (it's not used for avoiding person it's used to get healer attention to person)

--Earthbreaker Haromm
local timerFroststormStrike			= mod:NewTargetTimer(30, 144215, nil, mod:IsTank())
local timerToxicMistsCD				= mod:NewCDTimer(32, 144089)--Pretty much a next timers unless boss is casting something else
local timerFoulStreamCD				= mod:NewCDTimer(32.5, 144090)--Pretty much a next timers unless boss is casting something else
local timerAshenWallCD				= mod:NewCDTimer(32.5, 144070)--Pretty much a next timers unless boss is casting something else
local timerIronTombCD				= mod:NewCDTimer(31.5, 144328)--Pretty much a next timers unless boss is casting something else
--Wavebinder Kardris
local timerToxicStormCD				= mod:NewCDTimer(32, 144005)--Pretty much a next timers unless boss is casting something else
local timerFoulGeyserCD				= mod:NewCDTimer(32.5, 143990)--Pretty much a next timers unless boss is casting something else
local timerFallingAsh				= mod:NewCastTimer(15, 143973)
local timerFallingAshCD				= mod:NewCDCountTimer(32.5, 143973)--Pretty much a next timers unless boss is casting something else
local timerIronPrison				= mod:NewTargetTimer(60, 144330, nil, mod:IsHealer())
local timerIronPrisonCD				= mod:NewCDTimer(31.5, 144330)--Pretty much a next timers unless boss is casting something else
local timerIronPrisonSelf			= mod:NewBuffFadesTimer(60, 144330)

local countdownFoulGeyser			= mod:NewCountdown(32.5, 143990, mod:IsRangedDps(), nil, nil, nil, nil, 2)
local countdownAshenWall			= mod:NewCountdown(32.5, 144070, not mod:IsHealer(), nil, nil, nil, true, 2)

local berserkTimer					= mod:NewBerserkTimer(540)

mod:AddRangeFrameOption(4, 143990)--This is more or less for foul geyser and foul stream splash damage
mod:AddSetIconOption("SetIconOnToxicMists", 144089, false)

local toxicMistsTargets = {}
local toxicMistsTargetsIcons = {}
local ironPrisonTargets = {}
local UnitExists, UnitGUID, UnitDetailedThreatSituation = UnitExists, UnitGUID, UnitDetailedThreatSituation
local playerName = UnitName("player")
local ashCount = 0

local function warnToxicMistTargets()
	if mod:CheckTargetDistance(71859, 50) then
		warnToxicMists:Show(table.concat(toxicMistsTargets, "<, >"))
		timerToxicMistsCD:Start()
	end
	table.wipe(toxicMistsTargets)
end

local function warnIronPrisonTargets()
	if mod:CheckTargetDistance(71858, 50) then
		warnIronPrison:Show(table.concat(ironPrisonTargets, "<, >"))
	end
	table.wipe(ironPrisonTargets)
end

local function ClearToxicMistTargets()
	table.wipe(toxicMistsTargetsIcons)
end

do
	local function sort_by_group(v1, v2)
		return DBM:GetRaidSubgroup(DBM:GetUnitFullName(v1)) < DBM:GetRaidSubgroup(DBM:GetUnitFullName(v2))
	end
	function mod:SetToxicIcons()
		table.sort(toxicMistsTargetsIcons, sort_by_group)
		local toxicIcon = 1
		for i, v in ipairs(toxicMistsTargetsIcons) do
			self:SetIcon(v, toxicIcon)
			toxicIcon = toxicIcon + 1
		end
		self:Schedule(1.5, ClearToxicMistTargets)--Table wipe delay so if icons go out too early do to low fps or bad latency, when they get new target on table, resort and reapplying should auto correct teh icon within .2-.4 seconds at most.
	end
end

function mod:FoulStreamTarget(targetname, uId)
	if not targetname then return end
	if self:IsTanking(uId) then--Never target tanks, so if target is tank, that means scanning failed.
		specWarnFoulStream:Show()
	else
		warnFoulStream:Show(targetname)
		timerFoulStreamCD:Start()
		if targetname == UnitName("player") then
			specWarnFoulStreamYou:Show()
			yellFoulStream:Yell()
		else
			specWarnFoulStream:Show()
		end
	end
end

function mod:ToxicStormTarget(targetname, uId)
	if not targetname then return end
	warnToxicStorm:Show(targetname)
	if targetname == UnitName("player") then
		specWarnToxicStorm:Show()
		yellToxicStorm:Yell()
	else
		if uId then
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			local inRange = DBM.RangeCheck:GetDistance("player", x, y)
			if inRange and inRange < 8 then--Range guesswork
				specWarnToxicStormNear:Show(targetname)
			end
		end
	end
end

function mod:OnCombatStart(delay)
	ashCount = 0
	table.wipe(toxicMistsTargets)
	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 144005 and self:CheckTargetDistance(CheckTankDistance, 50) then
		self:BossTargetScanner(71858, "ToxicStormTarget", 0.05, 16)
		timerToxicStormCD:Start()
	elseif args.spellId == 144090 and self:CheckTargetDistance(CheckTankDistance, 50) then
		self:BossTargetScanner(71859, "FoulStreamTarget", 0.05, 16)
	elseif args.spellId == 143990 and self:CheckTargetDistance(CheckTankDistance, 50) then
		timerFoulGeyserCD:Start()
		specWarnFoulGeyser:Show()
		countdownFoulGeyser:Start()
	elseif args.spellId == 144070 and self:CheckTargetDistance(CheckTankDistance, 50) then
		warnAshenWall:Show()
		timerAshenWallCD:Start()
		countdownAshenWall:Start()
		specWarnAshenWall:Show()--Give special warning cause this ability concerns you
	elseif args.spellId == 143973 then--No filter, damages entire raid
		ashCount = ashCount + 1
		warnFallingAsh:Show()
		timerFallingAsh:Start()
		timerFallingAshCD:Start(nil, ashCount+1)
		specWarnFallingAsh:Schedule(12)--Give special warning 3 seconds before happens, not cast
	elseif args.spellId == 144330 and self:CheckTargetDistance(CheckTankDistance, 50) then
		timerIronPrisonCD:Start()
	elseif args.spellId == 144328 and self:CheckTargetDistance(CheckTankDistance, 50) then
		warnIronTomb:Show()
		timerIronTombCD:Start()
		specWarnIronTomb:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 144288 and self:AntiSpam() then
		warnPoisonmistTotem:Show()
	elseif args.spellId == 144289 and self:AntiSpam() then
		warnFoulstreamTotem:Show()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(4)
		end
	elseif args.spellId == 144290 and self:AntiSpam() then
		warnAshflareTotem:Show()
	elseif args.spellId == 144291 and self:AntiSpam() then
		warnRustedIronTotem:Show()
	elseif args.spellId == 143990 then
		if self:CheckTargetDistance(CheckTankDistance, 50) then
			warnFoulGeyser:Show(args.destName)
		end
		if args:IsPlayer() then
			yellFoulGeyser:Yell()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 144304 then
		local amount = args.amount or 1
		if amount % 3 == 0 then
			warnRend:Show(args.destName, amount)
		end
	elseif args.spellId == 144089 then
		--Filter warnings only
		toxicMistsTargets[#toxicMistsTargets + 1] = args.destName
		self:Unschedule(warnToxicMistTargets)
		self:Schedule(0.5, warnToxicMistTargets)
		--Not filter icons, in case the only person with assist/icons enabled is far away.
		if self.Options.SetIconOnToxicMists and args:IsDestTypePlayer() then--Filter further on icons because we don't want to set icons on grounding totems
			table.insert(toxicMistsTargetsIcons, DBM:GetRaidUnitId(DBM:GetFullPlayerNameByGUID(args.destGUID)))
			self:UnscheduleMethod("SetToxicIcons")
			if self:LatencyCheck() then--lag can fail the icons so we check it before allowing.
				self:ScheduleMethod(0.5, "SetToxicIcons")
			end
		end
	elseif args.spellId == 144330 then
		ironPrisonTargets[#ironPrisonTargets + 1] = args.destName
		self:Unschedule(warnIronPrisonTargets)
		self:Schedule(0.5, warnIronPrisonTargets)
	elseif args.spellId == 144215 then
		local amount = args.amount or 1
		timerFroststormStrike:Start(args.destName)
		if amount % 2 == 0 then
			warnFroststormStrike:Show(args.destName, amount)
		end
		if amount >= 5 then
			if args:IsPlayer() then
				specWarnFroststormStrike:Show(amount)
			else
				specWarnFroststormStrikeOther:Show(args.destName)
			end
		end
	elseif args.spellId == 144330 then
		timerIronPrison:Start(args.destName)
		if args:IsPlayer() then
			specWarnIronPrison:Schedule(5)
			timerIronPrisonSelf:Start()
			yellIronPrisonFades:Schedule(59, playerName, 1)
			yellIronPrisonFades:Schedule(58, playerName, 2)
			yellIronPrisonFades:Schedule(57, playerName, 3)
			yellIronPrisonFades:Schedule(56, playerName, 4)
			yellIronPrisonFades:Schedule(55, playerName, 5)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 144089 and self.Options.SetIconOnToxicMists then
		self:SetIcon(args.destName, 0)
	elseif args.spellId == 144215 then
		timerFroststormStrike:Cancel(args.destName)
	elseif args.spellId == 144330 then
		timerIronPrison:Cancel(args.destName)
		if args:IsPlayer() then
			specWarnIronPrison:Cancel()
			yellIronPrisonFades:Cancel()
			timerIronPrisonSelf:Cancel()
		end
	end
end
