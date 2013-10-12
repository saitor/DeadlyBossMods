local mod	= DBM:NewMod(870, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 10612 $"):sub(12, -3))
mod:SetCreatureID(73720, 71512)
mod:SetZone()

--Can use IEEU to engage now, it's about 4 seconds slower but better than registering an out of combat CLEU event in entire zone.
--"<10.8 23:23:13> [CLEU] SPELL_CAST_SUCCESS#false#0xF13118D10000674F#Secured Stockpile of Pandaren Spoils#2632#0##nil#-2147483648#-2147483648#145687#Unstable Defense Systems#1", -- [169]
--"<14.2 23:23:16> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args:#1#1#Mogu Spoils#0xF1311FF800006750#elite#1#1#1#Mantid Spoils#0xF131175800006752
mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.Victory)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"UNIT_DIED",
	"UPDATE_WORLD_STATES"
)

local warnSuperNova				= mod:NewCastAnnounce(146815, 4)--Heroic
--Massive Crate of Goods
----Mogu
local warnReturnToStone			= mod:NewSpellAnnounce(145489, 2)
----Mantid
local warnSetToBlow				= mod:NewTargetAnnounce(145987, 4)--145996 is cast ID
--Stout Crate of Goods
----Mogu
local warnForbiddenMagic		= mod:NewTargetAnnounce(145230, 2)
local warnMatterScramble		= mod:NewSpellAnnounce(145288, 3)
local warnCrimsonRecon			= mod:NewSpellAnnounce(142947, 4, nil, mod:IsTank(), nil, nil, nil, nil, 2)
local warnEnergize				= mod:NewSpellAnnounce(145461, 3)--May be script spellid that doesn't show in combat log
local warnTorment				= mod:NewSpellAnnounce(142934, 3, nil, mod:IsHealer())
----Mantid
local warnMantidSwarm			= mod:NewSpellAnnounce(142539, 3, nil, mod:IsTank())
local warnResidue				= mod:NewCastAnnounce(145786, 4, nil, nil, mod:IsMagicDispeller())
local warnRageoftheEmpress		= mod:NewCastAnnounce(145812, 4, nil, nil, mod:IsMagicDispeller())
local warnWindStorm				= mod:NewSpellAnnounce(145286, 3)
local warnEnrage				= mod:NewTargetAnnounce(145692, 3, nil, mod:IsTank() or mod:CanRemoveEnrage())--Do not have timer for this yet, add not alive long enough.
--Lightweight Crate of Goods
----Mogu
local warnHardenFlesh			= mod:NewSpellAnnounce(144922, 2, nil, false)
local warnEarthenShard			= mod:NewSpellAnnounce(144923, 2, nil, false)
local warnSparkofLife			= mod:NewSpellAnnounce(142694, 3, nil, false)
--Crate of Pandaren Relics
local warnBreathofFire			= mod:NewSpellAnnounce(146222, 3)--Do not have timer for this yet, add not alive long enough.
local warnGustingCraneKick		= mod:NewSpellAnnounce(146180, 3)

local specWarnSuperNova			= mod:NewSpecialWarningSpell(146815, nil, nil, nil, 2)
--Massive Crate of Goods
local specWarnSetToBlowYou		= mod:NewSpecialWarningYou(145987)
local specWarnSetToBlow			= mod:NewSpecialWarningPreWarn(145996, nil, 4, nil, 3)
--Stout Crate of Goods
----Mogu
local specWarnForbiddenMagic	= mod:NewSpecialWarningInterrupt(145230, mod:IsMelee())
local specWarnMatterScramble	= mod:NewSpecialWarningSpell(145288, nil, nil, nil, 2)
local specWarnCrimsonRecon		= mod:NewSpecialWarningMove(142947, mod:IsTank(), nil, nil, 3)
local specWarnTorment			= mod:NewSpecialWarningSpell(142934, mod:IsHealer())
----Mantid
local specWarnMantidSwarm		= mod:NewSpecialWarningSpell(142539, mod:IsTank())
local specWarnResidue			= mod:NewSpecialWarningSpell(145786, mod:IsMagicDispeller())
local specWarnRageoftheEmpress	= mod:NewSpecialWarningSpell(145812, mod:IsMagicDispeller())
local specWarnEnrage			= mod:NewSpecialWarningDispel(145692, mod:CanRemoveEnrage())--Question is, do we want to dispel it? might make this off by default since kiting it may be more desired than dispeling it
--Lightweight Crate of Goods
----Mogu
local specWarnHardenFlesh		= mod:NewSpecialWarningInterrupt(144922, false)
local specWarnEarthenShard		= mod:NewSpecialWarningInterrupt(144923, false)
----Mantid
local specWarnBlazingCharge		= mod:NewSpecialWarningMove(145716)
local specWarnBubblingAmber		= mod:NewSpecialWarningMove(145748)
local specWarnPathOfBlossoms	= mod:NewSpecialWarningMove(146257)
--Crate of Pandaren Relics
local specWarnGustingCraneKick	= mod:NewSpecialWarningSpell(146180, nil, nil, nil, 2)

--Massive Crate of Goods
local timerReturnToStoneCD		= mod:NewNextTimer(12, 145489)
local timerSetToBlowCD			= mod:NewNextTimer(9.6, 145996)
local timerSetToBlow			= mod:NewBuffFadesTimer(30, 145996)
--Stout Crate of Goods
local timerMatterScrambleCD		= mod:NewCDTimer(18, 145288)--18-22 sec variation. most of time it's 20 exactly, unsure what causes the +-2 variations
local timerCrimsonReconCD		= mod:NewNextTimer(15, 142947)
local timerMantidSwarmCD		= mod:NewCDTimer(35, 142539)
local timerResidueCD			= mod:NewCDTimer(18, 145786, nil, mod:IsMagicDispeller())
local timerWindstormCD			= mod:NewCDTimer(34, 145286, nil, false)--Spammy but might be useful to some, if they aren't releasing a ton of these at once.
local timerRageoftheEmpressCD	= mod:NewCDTimer(18, 145812, nil, mod:IsMagicDispeller())
--Lightweight Crate of Goods
----Most of these timers are included simply because of how accurate they are. Predictable next timers. However, MANY of these adds up at once.
----They are off by default and a user elected choice to possibly pick one specific timer they are in charge of dispeling/interrupting or whatever
local timerEnrage				= mod:NewTargetTimer(10, 145692)
local timerHardenFleshCD		= mod:NewNextTimer(8, 144922, nil, false)
local timerEarthenShardCD		= mod:NewNextTimer(10, 144923, nil, false)
local timerBlazingChargeCD		= mod:NewNextTimer(12, 145712, nil, false)
--Crate of Pandaren Relics
local timerGustingCraneKickCD	= mod:NewCDTimer(18, 146180)
local timerPathOfBlossomsCD		= mod:NewCDTimer(15, 146253)

local countdownSetToBlow		= mod:NewCountdownFades(29, 145996)
local countdownArmageddon		= mod:NewCountdown(270, 145864, nil, nil, nil, nil, true)

local berserkTimer				= mod:NewBerserkTimer(480)

mod:AddRangeFrameOption(10, 145987)

local select, tonumber, GetPlayerMapPosition, GetWorldStateUIInfo = select, tonumber, GetPlayerMapPosition, GetWorldStateUIInfo
local point1 = {0.488816, 0.208129}
local point2 = {0.562330, 0.371684}
local worldTimer = 0

local function isPlayerInMantid()
	local x, y = GetPlayerMapPosition("player")
	if x == 0 and y == 0 then
		SetMapToCurrentZone()
		x, y = GetPlayerMapPosition("player")
	end
	local lineX, diffX, calcY
	lineX = point2[1] - point1[1]
	diffX = x - point1[1]
	if diffX <= 0 then return true end
	if diffX >= lineX then return false end
	calcY = (diffX / lineX) * (point2[2]-point1[2]) + point1[2]
	if y >= calcY then
		return true
	else
		return false
	end
end

local function hideRangeFrame()
	if mod.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:OnCombatStart(delay)
	worldTimer = 0
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 145996 and isPlayerInMantid() then
		timerSetToBlowCD:Start(args.sourceGUID)
	elseif args.spellId == 145288 and not isPlayerInMantid() then
		warnMatterScramble:Show()
		specWarnMatterScramble:Show()
		timerMatterScrambleCD:Start(args.sourceGUID)
	elseif args.spellId == 145461 and not isPlayerInMantid() then
		warnEnergize:Show()
	elseif args.spellId == 142934 and not isPlayerInMantid() then
		warnTorment:Show()
		specWarnTorment:Show()
	elseif args.spellId == 142539 and isPlayerInMantid() then
		warnMantidSwarm:Show()
		specWarnMantidSwarm:Show()
		timerMantidSwarmCD:Start(args.sourceGUID)
	elseif args.spellId == 145286 and isPlayerInMantid() and self:AntiSpam(5, args.sourceGUID) then
		warnWindStorm:Show()
		timerWindstormCD:Start(args.sourceGUID)
	elseif args.spellId == 144922 and not isPlayerInMantid() then
		local source = args.sourceName
		warnHardenFlesh:Show()
		timerHardenFleshCD:Start(args.sourceGUID)
		if source == UnitName("target") or source == UnitName("focus") then 
			specWarnHardenFlesh:Show(source)
		end
	elseif args.spellId == 144923 and not isPlayerInMantid() then
		local source = args.sourceName
		warnEarthenShard:Show()
		timerEarthenShardCD:Start(args.sourceGUID)
		if source == UnitName("target") or source == UnitName("focus") then 
			specWarnEarthenShard:Show(source)
		end
	elseif args.spellId == 146222 and self:CheckTankDistance(args.sourceGUID) then--Relics can be either side, must use CheckTank Distance
		warnBreathofFire:Show()
	elseif args.spellId == 146180 and self:CheckTankDistance(args.sourceGUID) then--Also a Relic
		warnGustingCraneKick:Show()
		specWarnGustingCraneKick:Show()
		timerGustingCraneKickCD:Start(args.sourceGUID)
	elseif args.spellId == 145489 and not isPlayerInMantid() then
		warnReturnToStone:Show()
		timerReturnToStoneCD:Start(args.sourceGUID)
	elseif args.spellId == 142947 and not isPlayerInMantid() then--Pre warn more or less
		warnCrimsonRecon:Show()
	elseif args.spellId == 146815 then--Will do more work on this later, not enough time before raid, but i have an idea for it
		warnSuperNova:Show()
		specWarnSuperNova:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 142694 and not isPlayerInMantid() then
		warnSparkofLife:Show()
	elseif args.spellId == 142947 and not isPlayerInMantid() then
		specWarnCrimsonRecon:Show()--Done here because we want to warn when we need to move mobs, not on cast start (when we can do nothing)
		timerCrimsonReconCD:Start(args.sourceGUID)
	elseif args.spellId == 145712 and isPlayerInMantid() then
		timerBlazingChargeCD:Start(args.sourceGUID)
	elseif args.spellId == 146253 and isPlayerInMantid() then
		timerPathOfBlossomsCD:Start(args.sourceGUID)
	elseif args.spellId == 145230 and not isPlayerInMantid() then
		local source = args.sourceName
		warnForbiddenMagic:Show(args.destName)
		if source == UnitName("target") or source == UnitName("focus") then 
			specWarnForbiddenMagic:Show(source)
		end
	elseif args.spellId == 145786 and isPlayerInMantid() then
		warnResidue:Show()
		timerResidueCD:Start(args.sourceGUID)
		specWarnResidue:Show()
	elseif args.spellId == 145812 and isPlayerInMantid() then
		warnRageoftheEmpress:Show()
		specWarnRageoftheEmpress:Show()
		timerRageoftheEmpressCD:Start(args.sourceGUID)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 145987 and isPlayerInMantid() then
		warnSetToBlow:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnSetToBlowYou:Show()
			countdownSetToBlow:Start()
			timerSetToBlow:Start()
			specWarnSetToBlow:Schedule(26)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)--Range assumed, spell tooltips not informative enough
				self:Schedule(32, hideRangeFrame)
			end
		end
	elseif args.spellId == 145692 and isPlayerInMantid() then
		warnEnrage:Show(args.destName)
		specWarnEnrage:Show(args.destName)
		timerEnrage:Start(args.destName)
	elseif args.spellId == 145998 and not isPlayerInMantid() then--This is a massive crate mogu spawning
		timerReturnToStoneCD:Start(6)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 145987 and args:IsPlayer() then
		countdownSetToBlow:Cancel()
		timerSetToBlow:Cancel()
		specWarnSetToBlow:Cancel()
	elseif args.spellId == 145692 then
		timerEnrage:Cancel(args.destName)
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 145716 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnBlazingCharge:Show()
	elseif spellId == 145748 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnBubblingAmber:Show()
	elseif spellId == 146257 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnPathOfBlossoms:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 71408 then--Shao-Tien Colossus
		timerReturnToStoneCD:Cancel(args.destGUID)
	elseif cid == 71409 then--Ka'thik Demolisher
		timerSetToBlowCD:Cancel(args.destGUID)
	elseif cid == 71395 then--Modified Anima Golem
		timerMatterScrambleCD:Cancel(args.destGUID)
		timerCrimsonReconCD:Cancel(args.destGUID)
	elseif cid == 71397 then--Ka'thik Swarmleader
		timerMantidSwarmCD:Cancel(args.destGUID)
		timerResidueCD:Cancel(args.destGUID)
	elseif cid == 71405 then--Ka'thik Wind Wielder
		timerWindstormCD:Cancel(args.destGUID)
		timerRageoftheEmpressCD:Cancel(args.destGUID)
	elseif cid == 71380 then--Animated Stone Mogu
		timerHardenFleshCD:Cancel(args.destGUID)
		timerEarthenShardCD:Cancel(args.destGUID)
	elseif cid == 71385 then--Ka'thik Bombardier
		timerBlazingChargeCD:Cancel(args.destGUID)
	elseif cid == 72810 then--Wise Mistweaver Spirit
		timerGustingCraneKickCD:Cancel(args.destGUID)
	elseif cid == 72828 then--Nameless Windwalker Spirit
		timerPathOfBlossomsCD:Cancel(args.destGUID)
	end
end

function mod:UPDATE_WORLD_STATES()
	local text = select(4, GetWorldStateUIInfo(5))
	local time = tonumber(string.match(text or "", "%d+"))
	if time > worldTimer then
		berserkTimer:Cancel()
		countdownArmageddon:Cancel()
		berserkTimer:Start(time)
		countdownArmageddon:Start(time)
	end
	worldTimer = time
end
