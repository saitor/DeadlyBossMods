local mod	= DBM:NewMod(1873, "DBM-TombofSargeras", nil, 875)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(120436)--Oath-Keeper Sacraya 120437
mod:SetEncounterID(2038)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(15581)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 239207 239132 235572 236571 233856 233556 240623 239418",
	"SPELL_CAST_SUCCES 234059 239132 236494 240594 239739",
	"SPELL_AURA_APPLIED 234009 234059 236494 240728 239739",
	"SPELL_AURA_APPLIED_DOSE 236494 240728",
	"SPELL_AURA_REMOVED 234009 234059 239739",
	"SPELL_PERIODIC_DAMAGE 239212",
	"SPELL_PERIODIC_MISSED 239212",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, two entirely different version sof Touch of Sargeras. Figure out which one is actually used where
--TODO, verify phase 2 trigger is in combat log, or use UNIT event instead
--TODO, Matrix stuff to be improved when I see how they activate/deactivate (cooldown? power based? health based?)
--TODO, figure out mythic stack count to start warning. Right now it's 4
--TODO, improve Dark Mark to match Touch of Sargeras if multiple targets, else, clean it up for 1 target
--Stage One: A Slumber Disturbed
local warnTouchofSargeras			= mod:NewTargetAnnounce(234009, 3)
local warnUnboundChaos				= mod:NewTargetAnnounce(234059, 3)
local warnDesolate					= mod:NewStackAnnounce(236494, 3, nil, "Healer|Tank")
local warnPhase2					= mod:NewPhaseAnnounce(2, 2)
--Stage Two: An Avatar Awakened
local warnDarkmark					= mod:NewTargetAnnounce(239739, 3)
local warnBlackWinds				= mod:NewSpellAnnounce(239418, 2)

--Stage One: A Slumber Disturbed
local specWarnTouchofSargeras		= mod:NewSpecialWarningYou(234009, nil, nil, nil, 1, 2)
local specWarnTouchofSargerasOther	= mod:NewSpecialWarningMoveTo(234009, nil, nil, nil, 1, 2)--Exclude tank?
local yellTouchofSargeras			= mod:NewPosYell(234009)
local yellTouchofSargerasFades		= mod:NewFadesYell(234009)
local specWarnRuptureRealities		= mod:NewSpecialWarningRun(239132, nil, nil, nil, 4, 2)
local specWarnUnboundChaos			= mod:NewSpecialWarningMoveAway(234059, nil, nil, nil, 1, 2)
local yellUnboundChaos				= mod:NewYell(234059)
local specWarnShadowyBlades			= mod:NewSpecialWarningMoveAway(236571, nil, nil, nil, 1, 2)
local specWarnLingeringDarkness		= mod:NewSpecialWarningMove(239212, nil, nil, nil, 1, 2)
local specWarnDesolateYou			= mod:NewSpecialWarningStack(236494, nil, 2, nil, nil, 1, 6)
local specWarnDesolateOther			= mod:NewSpecialWarningTaunt(236494, nil, nil, nil, 1, 2)
----Oath-Keeper Sacraya
local specWarnCleansingProtocol		= mod:NewSpecialWarningSwitch(233856, "-Healer", nil, nil, 3, 2)
local specWarnTaintedEssence		= mod:NewSpecialWarningStack(240728, nil, 3, nil, nil, 1, 6)
--Stage Two: An Avatar Awakened
local specWarnDarkMark				= mod:NewSpecialWarningYou(239739, nil, nil, nil, 1, 2)
local specWarnDarkMarkOther			= mod:NewSpecialWarningMoveTo(239739, nil, nil, nil, 1, 2)
local yellDarkMark					= mod:NewYell(239739)
local yellDarkMarkFades				= mod:NewFadesYell(239739)
local specWarnRainoftheDestroyer	= mod:NewSpecialWarningDodge(240396, nil, nil, nil, 2, 2)

--Stage One: A Slumber Disturbed
local timerTouchofSargerasCD		= mod:NewAITimer(31, 239207, nil, nil, nil, 3)
local timerRuptureRealitiesCD		= mod:NewAITimer(31, 239132, nil, nil, nil, 2)
local timerUnboundChaosCD			= mod:NewAITimer(31, 234059, nil, nil, nil, 3)
local timerShadowyBladesCD			= mod:NewAITimer(31, 236571, nil, nil, nil, 3)
local timerDesolateCD				= mod:NewAITimer(31, 236494, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
----Oath-Keeper Sacraya
local timerCorruptedMatrixCD		= mod:NewCastTimer(10, 233556, nil, nil, nil, 6)
local timerTaintedMatrixCD			= mod:NewCastTimer(10, 240623, nil, nil, nil, 6)--Mythic
--Stage Two: An Avatar Awakened
local timerDarkMarkCD				= mod:NewAITimer(31, 239739, nil, nil, nil, 3)
local timerBlackWindsCD				= mod:NewAITimer(31, 239418, nil, nil, nil, 3)
local timerRainoftheDestroyerCD		= mod:NewAITimer(31, 240396, nil, nil, nil, 3)

--local berserkTimer				= mod:NewBerserkTimer(300)

--Stage One: A Slumber Disturbed
--local countdownDrawPower			= mod:NewCountdown(33, 227629)

--Stage One: A Slumber Disturbed
local voiceTouchofSargeras			= mod:NewVoice(234009)--gathershare/targetyou
local voiceRuptureRealities			= mod:NewVoice(239132)--justrun
local voiceUnboundChaos				= mod:NewVoice(234059)--runout/keepmove
local voiceShadowyBlades			= mod:NewVoice(236571)--scatter
local voiceLingeringDarkness		= mod:NewVoice(239212)--runaway
local voiceDesolate					= mod:NewVoice(236494, "Tank")--stackhigh/tauntboss
----Oath-Keeper Sacraya
local voiceCleansingProtocol		= mod:NewVoice(233856, "-Healer")--targetchange
local voiceTaintedEssence			= mod:NewVoice(240728)--stackhigh
--Stage Two: An Avatar Awakened
local voiceDarkMark					= mod:NewVoice(239739)--gathershare/targetyou
local voiceRainoftheDestroyer		= mod:NewVoice(240396)--watchstep

mod:AddSetIconOption("SetIconOnTouchofSargeras", 234009, true)
mod:AddBoolOption("InfoFrame", true)
mod:AddRangeFrameOption(10, 236571)
mod:AddNamePlateOption("NPAuraOnTouchofSargeras", 234009)
mod:AddNamePlateOption("NPAuraOnDarkMark", 239739)

mod.vb.phase = 1
local TouchofSargerasTargets = {}
local playerName = UnitName("player")

--Change to be more complex like touch of sargeras if more than one target
local function checkDarkMark(self, spellName)
	local playerDebuffed = UnitDebuff("player", spellName)
	if playerDebuffed then
		specWarnDarkMarkOther:Show(DBM_ALLY)
		voiceDarkMark:Play("gathershare")
	end
end

local function showTouchofSargerasTargets(self)
	table.sort(TouchofSargerasTargets)
	local playerAffected = false
	warnTouchofSargeras:Show(table.concat(TouchofSargerasTargets, "<, >"))
	for i = 1, #TouchofSargerasTargets do
		if i == 9 then break end--It's a wipe, plus can't do more than 8 of these with icons
		local name = TouchofSargerasTargets[i]
		if name == playerName then
			yellTouchofSargeras:Yell(i, i, i)
			playerAffected = true
		end
		if self.Options.SetIconOnTouchofSargeras then
			self:SetIcon(name, i)
		end
	end
	if not playerAffected then
		specWarnTouchofSargerasOther:Show(DBM_ALLY)
		voiceTouchofSargeras:Play("gathershare")
	end
	table.wipe(TouchofSargerasTargets)--Remove from here if cast start event works
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	table.wipe(TouchofSargerasTargets)
	timerTouchofSargerasCD:Start(1-delay)
	timerRuptureRealitiesCD:Start(1-delay)
	timerUnboundChaosCD:Start(1-delay)
	timerShadowyBladesCD:Start(1-delay)
	timerDesolateCD:Start(1-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(POWER_TYPE_POWER)
		DBM.InfoFrame:Show(2, "enemypower", 2, ALTERNATE_POWER_INDEX)
	end
	if self.Options.NPAuraOnTouchofSargeras or self.Options.NPAuraOnDarkMark then
		DBM:FireEvent("BossMod_EnableFriendlyNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnTouchofSargeras or self.Options.NPAuraOnDarkMark then
		DBM.Nameplate:Hide(false, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 239207 then
		table.wipe(TouchofSargerasTargets)
		timerTouchofSargerasCD:Start()
	elseif spellId == 239132 or spellId == 235572 then
		specWarnRuptureRealities:Show()
		voiceRuptureRealities:Play("justrun")
		timerRuptureRealitiesCD:Start()
	elseif spellId == 236571 then
		specWarnShadowyBlades:Show()
		voiceShadowyBlades:Play("scatter")
		timerShadowyBladesCD:Start()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10)
		end
	elseif spellId == 233856 then
		specWarnCleansingProtocol:Show()
		voiceCleansingProtocol:Play("targetchange")
	elseif spellId == 233556 then
		timerCorruptedMatrixCD:Start(50)
	elseif spellId == 240623 then
		timerTaintedMatrixCD:Start(60)
	elseif spellId == 239418 then
		warnBlackWinds:Show()
		timerBlackWindsCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 234059 then
		timerUnboundChaosCD:Start()
	elseif spellId == 236571 then
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 236494 then
		timerDesolateCD:Start()
	elseif spellId == 240594 then
		self.vb.phase = 2
		timerTouchofSargerasCD:Stop()
		timerShadowyBladesCD:Stop()
		timerRuptureRealitiesCD:Stop()
		timerDesolateCD:Stop()
		timerUnboundChaosCD:Stop()
		timerCorruptedMatrixCD:Stop()
		timerTaintedMatrixCD:Stop()
		
		warnPhase2:Show()
		timerRuptureRealitiesCD:Start(2)
		timerDesolateCD:Start(2)
		timerDarkMarkCD:Start(2)
		timerBlackWindsCD:Start(2)
		timerRainoftheDestroyerCD:Start(2)
	elseif spellId == 239739 then
		timerDarkMarkCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 234009 then
		TouchofSargerasTargets[#TouchofSargerasTargets+1] = args.destName
		self:Unschedule(showTouchofSargerasTargets)
		self:Schedule(0.3, showTouchofSargerasTargets, self)--Change to 0.5 for laggy users?
		if args:IsPlayer() then
			specWarnTouchofSargeras:Show()
			voiceTouchofSargeras:Play("targetyou")
			yellTouchofSargerasFades:Schedule(9, 1)
			yellTouchofSargerasFades:Schedule(8, 2)
			yellTouchofSargerasFades:Schedule(7, 3)
		end
		if self.Options.NPAuraOnTouchofSargeras then
			DBM.Nameplate:Show(false, args.destName, spellId, nil, 10)
		end
	elseif spellId == 239739 then
		warnDarkmark:CombinedShow(0.3, args.destName)
		self:Unschedule(checkDarkMark)
		self:Schedule(0.3, checkDarkMark, self, args.spellName)
		if args:IsPlayer() then
			specWarnDarkMark:Show()
			voiceDarkMark:Play("targetyou")
			yellDarkMark:Yell()
			yellDarkMarkFades:Schedule(9, 1)
			yellDarkMarkFades:Schedule(8, 2)
			yellDarkMarkFades:Schedule(7, 3)
		end
		if self.Options.NPAuraOnDarkMark then
			DBM.Nameplate:Show(false, args.destName, spellId, nil, 6)
		end
	elseif spellId == 234059 then
		warnUnboundChaos:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnUnboundChaos:Show()
			voiceUnboundChaos:Play("runout")
			voiceUnboundChaos:Schedule(1, "keepmove")
			yellUnboundChaos:Yell()
		end
	elseif spellId == 236494 then
		local amount = args.amount or 1
		if args:IsPlayer() then
			if amount >= 2 then
				specWarnDesolateYou:Show(amount)
				voiceDesolate:Play("stackhigh")
			else
				warnDesolate:Show(args.destName, amount)
			end
		else
			if not UnitIsDeadOrGhost("player") and not UnitDebuff("player", args.spellName) then
				specWarnDesolateOther:Show(args.destName)
				voiceDesolate:Play("tauntboss")
			else
				warnDesolate:Show(args.destName, amount)
			end
		end
	elseif spellId == 240728 then
		if args:IsPlayer() then
			local amount = args.amount or 1
			if amount >= 4 then
				specWarnTaintedEssence:Show(amount)
				voiceTaintedEssence:Play("stackhigh")
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 234009 then
		if args:IsPlayer() then
			yellTouchofSargerasFades:Cancel()
		end
		if self.Options.NPAuraOnTouchofSargeras then
			DBM.Nameplate:Hide(false, args.destName, spellId)
		end
		if self.Options.SetIconOnTouchofSargeras then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 239739 then
		if args:IsPlayer() then
			yellDarkMarkFades:Cancel()
		end
		if self.Options.NPAuraOnDarkMark then
			DBM.Nameplate:Hide(false, args.destName, spellId)
		end
	elseif spellId == 234059 then
		--Do Stuff?
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 239212 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnLingeringDarkness:Show()
		voiceLingeringDarkness:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:228162") then

	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 234417 then
		specWarnRainoftheDestroyer:Show()
		voiceRainoftheDestroyer:Play("watchstep")
		timerRainoftheDestroyerCD:Start()
	end
end

