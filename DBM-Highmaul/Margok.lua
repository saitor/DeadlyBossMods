local mod	= DBM:NewMod(1197, "DBM-Highmaul", nil, 477)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 12433 $"):sub(12, -3))
mod:SetCreatureID(77428, 78623)
mod:SetEncounterID(1705)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)--Unknown total number of icons replication will use.
mod:SetBossHPInfoToHighest()--For mythic chogal
--Could not find south path on internet
mod:SetHotfixNoticeRev(12370)
mod:SetMinSyncRevision(12073)--Avoid premature combat end on mythic

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 156238 156467 157349 163988 164075 156471 164299 164232 164301 163989 164076 164235 163990 164077 164240 164303 158605 164176 164178 164191 165243 165876 178607",
	"SPELL_CAST_SUCCESS 158563 165102",
	"SPELL_AURA_APPLIED 157763 158553 156225 164004 164005 164006 158605 164176 164178 164191 157801 178468 165102 165595 176533",
	"SPELL_AURA_APPLIED_DOSE 158553 178468 165595 159515",
	"SPELL_AURA_REFRESH 157763",
	"SPELL_AURA_REMOVED 158605 164176 164178 164191 157763 156225 164004 164005 164006 165102 165595",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2"
)

--TODO, do more fancy stuff with radar in phase 4 when i have more logs, like closing it when it's not needed. Or may just leave it as is depending on preferences.
--TODO, Night-Twisted Faithful stuff (no spawn trigger or yell, but 30 second loop, like oozes on that boss in ToT)
--TODO, see if target scanning works on dark star, or if that player gets an emote whisper or something. If can find dark star target, then need "nearby" warnings to move away from location
--TODO, 3 tank strat makes the accelerated confusing. todo, check number of tanks on pull, if 3, require margok be current target for accelerated warning
--All Phases
local warnPhase									= mod:NewPhaseChangeAnnounce()
mod:AddBoolOption("warnBranded", true, "announce")
local warnBranded								= mod:NewStackAnnounce("OptionVersion2", 156225, 4, nil, nil, false)
local warnBrandedDisplacement					= mod:NewStackAnnounce("OptionVersion2", 164004, 4, nil, nil, false)
local warnBrandedFortification					= mod:NewStackAnnounce("OptionVersion2", 164005, 4, nil, nil, false)
local warnBrandedReplication					= mod:NewStackAnnounce("OptionVersion2", 164006, 4, nil, nil, false)
mod:AddBoolOption("warnMarkOfChaos", true, "announce")
local warnMarkOfChaos							= mod:NewTargetAnnounce("OptionVersion2", 158605, 4, nil, nil, false)
local warnMarkOfChaosDisplacement				= mod:NewTargetAnnounce("OptionVersion2", 164176, 4, nil, nil, false)
local warnMarkOfChaosFortification				= mod:NewTargetAnnounce("OptionVersion2", 164178, 4, nil, nil, false)
local warnMarkOfChaosReplication				= mod:NewTargetAnnounce("OptionVersion2", 164191, 4, nil, nil, false)
local warnAcceleratedAssault					= mod:NewStackAnnounce(159515, 3, nil, mod:IsTank())
--Intermission: Dormant Runestones
local warnFixate								= mod:NewTargetAnnounce("OptionVersion3", 157763, 3)
--Intermission: Lineage of Power
local warnCrushArmor							= mod:NewStackAnnounce(158553, 2, nil, mod:IsTank())
--Mythic
local warnGlimpseOfMadness						= mod:NewCountAnnounce(165243, 3)
local warnDarkStar								= mod:NewSpellAnnounce(178607, 3)
local warnEnvelopingNight						= mod:NewCountAnnounce(165876, 3)
local warnInfiniteDarkness						= mod:NewTargetAnnounce(165102, 3, nil, mod:IsHealer())
local warnGazeSelf								= mod:NewStackAnnounce(165595, 4)

--All Phases
--Special warnings cannot be combined because it breaks custom sounds, however, they will be grouped up better now at least.
local specWarnAcceleratedAssault				= mod:NewSpecialWarningCount(159515, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.stack:format(5, 159515))
local specWarnAcceleratedAssaultOther			= mod:NewSpecialWarningTaunt(159515, nil, nil, nil, nil, nil, true)

local specWarnDestructiveResonance				= mod:NewSpecialWarningSpell(156467, nil, nil, nil, 2)
local specWarnDestructiveResonanceDisplacement	= mod:NewSpecialWarningSpell(164075, nil, nil, nil, 2)
local specWarnDestructiveResonanceFortification	= mod:NewSpecialWarningSpell(164076, nil, nil, nil, 2)
local specWarnDestructiveResonanceReplication	= mod:NewSpecialWarningSpell(164077, nil, nil, nil, 2)

local specWarnMarkOfChaos						= mod:NewSpecialWarningMoveAway(158605, nil, nil, nil, 3, nil, true)
local specWarnMarkOfChaosDisplacement			= mod:NewSpecialWarningMoveAway(164176, nil, nil, nil, 3, nil, true)
local specWarnMarkOfChaosFortification			= mod:NewSpecialWarningMoveAway(164178, nil, nil, nil, 3, nil, true)
local specWarnMarkOfChaosReplication			= mod:NewSpecialWarningMoveAway(164191, nil, nil, nil, 3, nil, true)

local specWarnMarkOfChaosFortificationNear		= mod:NewSpecialWarningClose(164178, nil, nil, nil, 3, nil, true)
local yellMarkOfChaosFortification				= mod:NewYell(164178)
local yellMarkOfChaosReplication				= mod:NewYell(164191)

local specWarnForceNova							= mod:NewSpecialWarningSpell(157349, nil, nil, nil, 2, nil, true)
local specWarnForceNovaRep						= mod:NewSpecialWarningMoveAway(164240, nil, nil, nil, 3, nil, true)

local specWarnMarkOfChaosOther					= mod:NewSpecialWarningTaunt(158605, nil, nil, nil, nil, nil, true)
local specWarnMarkOfChaosDisplacementOther		= mod:NewSpecialWarningTaunt(164176, nil, nil, nil, nil, nil, true)
local specWarnMarkOfChaosFortificationOther		= mod:NewSpecialWarningTaunt(164178, nil, nil, nil, nil, nil, true)
local specWarnMarkOfChaosReplicationOther		= mod:NewSpecialWarningTaunt(164191, nil, nil, nil, nil, nil, true)

local specWarnBranded							= mod:NewSpecialWarningStack(156225, nil, 5)--Debuff Name "Branded" for Arcane Wrath
local specWarnBrandedDisplacement				= mod:NewSpecialWarningStack(164004, nil, 5)
local specWarnBrandedFortification				= mod:NewSpecialWarningStack(164005, nil, 5)
local specWarnBrandedReplication				= mod:NewSpecialWarningStack(164006, nil, 5)
local yellBranded								= mod:NewYell(156225, L.BrandedYell)

local specWarnBrandedDisplacementNear			= mod:NewSpecialWarningClose(164004)--Displacement version of branded makes player unable to move from raid, raid moves from player

local specWarnAberration						= mod:NewSpecialWarningSwitchCount("ej9945", not mod:IsHealer())--can use short name for all of them

--Intermission: Dormant Runestones
local specWarnFixate							= mod:NewSpecialWarningMoveAway(157763, nil, nil, nil, nil, nil, true)
local yellFixate								= mod:NewYell(157763)
local specWarnSlow								= mod:NewSpecialWarningDispel(157801, mod:IsHealer(), nil, nil, nil, nil, true)--Seems CD long enough not too spammy, requested feature.
local specWarnTransitionEnd						= mod:NewSpecialWarningEnd(157278)
local specWarnNetherEnergy						= mod:NewSpecialWarningCount(178468, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.stack:format(3, 178468))
--Intermission: Lineage of Power
local specWarnKickToTheFace						= mod:NewSpecialWarningSpell(158563, mod:IsTank())
local specWarnKickToTheFaceOther				= mod:NewSpecialWarningTaunt(158563)
--Mythic
local specWarnGaze								= mod:NewSpecialWarningStack(165595, nil, 1)--For now, warn for all stacks until more conclusive understanding of fight.
local yellGaze									= mod:NewYell(165595, L.GazeYell)
local specWarnEnvelopingNight					= mod:NewSpecialWarningSpell(165876, nil, nil, nil, 2, nil, true)
local specWarnGrowingDarkness					= mod:NewSpecialWarningMove(176533, nil, nil, nil, nil, nil, true)
local specWarnDarkStar							= mod:NewSpecialWarningSpell(178607, nil, nil, nil, 2)--Change to target/near warning if targetscanning or any other method to detect target possible.

--All Phases (No need to use different timers for empowered abilities. Short names better for timers.)
local timerArcaneWrathCD						= mod:NewCDTimer(50, 156238, nil, not mod:IsTank())--Pretty much a next timer, HOWEVER can get delayed by other abilities so only reason it's CD timer anyways
local timerDestructiveResonanceCD				= mod:NewCDTimer(15, 156467, nil, not mod:IsMelee())--16-30sec variation noted. I don't like it
local timerMarkOfChaos							= mod:NewTargetTimer(8, 158605, nil, mod:IsTank())
local timerMarkOfChaosCD						= mod:NewCDTimer(50.5, 158605, nil, mod:IsTank())
local timerForceNovaCD							= mod:NewCDCountTimer(45, 157349)--45-52
local timerForceNovaFortification				= mod:NewNextTimer(9, 157349)--For replication nova
local timerSummonArcaneAberrationCD				= mod:NewCDCountTimer(45, "ej9945", nil, not mod:IsHealer(), nil, 156471)--45-52 Variation Noted
local timerTransition							= mod:NewPhaseTimer(74)
--Intermission: Lineage of Power
local timerCrushArmorCD							= mod:NewNextTimer(6, 158553, nil, mod:IsTank())
local timerKickToFaceCD							= mod:NewNextTimer(20, 158563, nil, mod:IsTank())
--Mythic
local timerGaze									= mod:NewBuffFadesTimer(10, 165595)
local timerGlimpseOfMadnessCD					= mod:NewNextCountTimer(27, 165243)
local timerInfiniteDarknessCD					= mod:NewNextTimer(62, 165102)
local timerEnvelopingNightCD					= mod:NewNextCountTimer(63, 165876)--60 seconds plus 3 second cast
local timerDarkStarCD							= mod:NewCDTimer(61, 178607)--61-65 Variations noticed

local countdownArcaneWrath						= mod:NewCountdown(50, 156238, not mod:IsTank())--Probably will add for whatever proves most dangerous on mythic
local countdownMarkofChaos						= mod:NewCountdown("Alt50", 158605, mod:IsTank())
local countdownForceNova						= mod:NewCountdown("AltTwo45", 157349)
local countdownTransition						= mod:NewCountdown(74, 157278)
--Mythic
local countdownEnvelopingNight					= mod:NewCountdown(63, 165876)
local countdownGaze								= mod:NewCountdownFades("Alt10", 165595)
local countdownDarkStar							= mod:NewCountdown("AltTwo61", 178607)

local voiceDestructiveResonance 				= mod:NewVoice(156467, not mod:IsMelee())
local voiceForceNova	 						= mod:NewVoice(157349)
local voiceAcceleratedAssault					= mod:NewVoice(159515, mod:IsTank())
local voiceMarkOfChaos							= mod:NewVoice(158605)
local voicePhaseChange							= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT) --this string should write into language file
local voiceFixate								= mod:NewVoice(157763)
local voiceArcaneAberration						= mod:NewVoice("OptionVersion2", 156471, not mod:IsHealer())
local voiceEnvelopingNight 						= mod:NewVoice(165876)
local voiceGrowingDarkness						= mod:NewVoice(176533)
local voiceBranded								= mod:NewVoice(156225)
local voiceSlow									= mod:NewVoice(157801, mod:IsHealer())

mod:AddRangeFrameOption("35/13/5/4")
mod:AddSetIconOption("SetIconOnBrandedDebuff", 156225, false)
mod:AddSetIconOption("SetIconOnInfiniteDarkness", 165102, false)
mod:AddInfoFrameOption(176537)

mod.vb.markActive = false
mod.vb.noTaunt = false--Almost same as mark active, but during cast too
mod.vb.playerHasBranded = false
mod.vb.playerHasMark = false
mod.vb.isTransition = false
mod.vb.lastMarkedTank = nil
mod.vb.RepNovaActive = nil
mod.vb.jumpDistance = 13
mod.vb.phase = 1
mod.vb.arcaneAdd = 0
mod.vb.madnessAdd = 0
mod.vb.envelopingCount = 0

local jumpDistance1 = {
	[1] = 200, [2] = 100, [3] = 50, [4] = 25, [5] = 12.5, [6] = 7,--Or 5
}
local jumpDistance2 = {
	[1] = 200, [2] = 150, [3] = 113, [4] = 85, [5] = 63, [6] = 48, [7] =36, [8] = 27, [9] = 21, [10] = 16, [11] = 12, [12] = 9, [13] = 7,--or 5
}
local GetSpellInfo, UnitDebuff, UnitDetailedThreatSituation, select = GetSpellInfo, UnitDebuff, UnitDetailedThreatSituation, select
local chaosDebuff1 = GetSpellInfo(158605)
local chaosDebuff2 = GetSpellInfo(164176)
local chaosDebuff3 = GetSpellInfo(164178)
local chaosDebuff4 = GetSpellInfo(164191)
local brandedDebuff1 = GetSpellInfo(156225)
local brandedDebuff2 = GetSpellInfo(164004)
local brandedDebuff3 = GetSpellInfo(164005)
local brandedDebuff4 = GetSpellInfo(164006)
local fixateDebuff = GetSpellInfo(157763)
local gazeDebuff = GetSpellInfo(165595)
local playerName = UnitName("player")
local chogallName = EJ_GetEncounterInfo(167)
local inter1 = EJ_GetSectionInfo(9891)
local inter2 = EJ_GetSectionInfo(9893)

local debuffFilterMark, debuffFilterBranded, debuffFilterFixate, debuffFilterGaze
do
	debuffFilterMark = function(uId)
		if UnitDebuff(uId, chaosDebuff1) or UnitDebuff(uId, chaosDebuff2) or UnitDebuff(uId, chaosDebuff3) or UnitDebuff(uId, chaosDebuff4) then
			return true
		end
	end
	debuffFilterBranded = function(uId)
		if UnitDebuff(uId, brandedDebuff1) or UnitDebuff(uId, brandedDebuff2) or UnitDebuff(uId, brandedDebuff3) or UnitDebuff(uId, brandedDebuff4) then
			return true
		end
	end
	debuffFilterFixate = function(uId)
		if UnitDebuff(uId, fixateDebuff) then
			return true
		end
	end
	debuffFilterGaze = function(uId)
		if select(11, UnitDebuff(uId, gazeDebuff)) == 165595 then--Two debuffs with same name, need correct one
			return true
		end
	end
end

local function updateRangeFrame(self, markPreCast)
	if not self.Options.RangeFrame then return end
	if self:IsMythic() and self.vb.phase == 4 then
		if select(11, UnitDebuff("player", gazeDebuff)) == 165595 then--Player has gaze
			DBM.RangeCheck:Show(8, nil)
		else
			DBM.RangeCheck:Show(8, debuffFilterGaze)
		end
		return--Other crap doesn't happen in phase 4 mythic so stop here.
	end
	if not self:IsTank() and self.vb.brandedActive > 0 then--Active branded out there, not a tank. Branded is always prioritized over mark for non tanks since 90% of time tanks handle this on their own, while rest of raid must ALWAYS handle branded
		local distance = self.vb.jumpDistance
		if self.vb.playerHasBranded then--Player has Branded debuff
			DBM.RangeCheck:Show(distance, nil)--Show everyone
		else--No branded debuff on player, so show a filtered range finder
			if self.vb.markActive and self.vb.lastMarkedTank and self:CheckNearby(38, self.vb.lastMarkedTank) then--There is an active tank with debuff and they are too close
				DBM.RangeCheck:Show(35, debuffFilterMark)--Show marked instead of branded if the marked tank is NOT far enough out
			else--no branded tank in range, So show ONLY branded dots
				DBM.RangeCheck:Show(distance, debuffFilterBranded)
			end
		end
	else--no branded, or player is a tank
		if markPreCast or self.vb.markActive then--Mark of Chaos is active, or is being cast
			if self.vb.playerHasMark then--Player has mark of chaos debuff, or is current highest threat during mark of chaos cast
				DBM.RangeCheck:Show(35, nil)
			else--Not boss target during cast, not debuffed, use filtered range frame to show only players affected by mark of chaos.
				DBM.RangeCheck:Show(35, debuffFilterMark)
			end
		elseif self.vb.RepNovaActive then--Replicating Nova Active
			DBM.RangeCheck:Show(4, nil)
		elseif self.vb.isTransition then
			if UnitDebuff("player", fixateDebuff) then
				DBM.RangeCheck:Show(5, nil)
			else
				DBM.RangeCheck:Show(5, debuffFilterFixate)
			end
		else--We got this far, no mark of chaos, no branded, fixate, no nothing, finally hide the range frame!
			DBM.RangeCheck:Hide()
		end
	end
end

local function delayedRangeUpdate(self)
	self.vb.RepNovaActive = nil
	updateRangeFrame(self)
end

function mod:OnCombatStart(delay)
	self.vb.markActive = false
	self.vb.noTaunt = false
	self.vb.playerHasMark = false
	self.vb.playerHasBranded = false
	self.vb.isTransition = false
	self.vb.lastMarkedTank = nil
	self.vb.RepNovaActive = nil
	self.vb.brandedActive = 0
	self.vb.forceCount = 0
	self.vb.jumpDistance = 13
	self.vb.phase = 1
	self.vb.arcaneAdd = 0
	self.vb.madnessAdd = 0
	self.vb.envelopingCount = 0
	timerArcaneWrathCD:Start(6-delay)
	countdownArcaneWrath:Start(6-delay)
	timerDestructiveResonanceCD:Start(15-delay)
	timerSummonArcaneAberrationCD:Start(25-delay, 1)
	timerMarkOfChaosCD:Start(33.5-delay)
	countdownMarkofChaos:Start(33.5-delay)
	timerForceNovaCD:Start(-delay, 1)
	countdownForceNova:Start(-delay)
	voiceForceNova:Schedule(38.5-delay, "157349")
	--Fix number of bosses reported by status whispers for normal
	--Assuming this can be changed after mod load without breaking things.
	if self:IsMythic() then
		self:SetBossHPInfoToHighest(2)
	else
		self:SetBossHPInfoToHighest(1)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	self:UnregisterShortTermEvents()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if args:IsSpellID(156238, 163988, 163989, 163990) then
		timerArcaneWrathCD:Start()
		countdownArcaneWrath:Start()
	-----
	elseif spellId == 156467 then
		specWarnDestructiveResonance:Show()
		timerDestructiveResonanceCD:Start()
		voiceDestructiveResonance:Play("runaway")
	elseif spellId == 164075 then
		specWarnDestructiveResonanceDisplacement:Show()
		timerDestructiveResonanceCD:Start()
		voiceDestructiveResonance:Play("runaway")
	elseif spellId == 164076 then
		specWarnDestructiveResonanceFortification:Show()
		timerDestructiveResonanceCD:Start()
		voiceDestructiveResonance:Play("runaway")
	elseif spellId == 164077 then
		specWarnDestructiveResonanceReplication:Show()
		timerDestructiveResonanceCD:Start()
		voiceDestructiveResonance:Play("watchstep")
	-----
	elseif spellId == 157349 then
		self.vb.forceCount = self.vb.forceCount + 1
		specWarnForceNova:Show()
		timerForceNovaCD:Start(nil, self.vb.forceCount+1)
		countdownForceNova:Start()
		voiceForceNova:Schedule(38.5, "157349")
	elseif spellId == 164232 then
		self.vb.forceCount = self.vb.forceCount + 1
		timerForceNovaCD:Start(nil, self.vb.forceCount+1)
		countdownForceNova:Start()
		voiceForceNova:Schedule(38.5, "157349")
		if self:IsMythic() and self.vb.phase == 1 then--Also replication empowered
			self.vb.RepNovaActive = true
			self:Schedule(9, delayedRangeUpdate, self)
			updateRangeFrame(self)
			--Trhee extra checks to make sure we update 35 to 5 if tank was too close briefly if they came at same time
			self:Schedule(1, updateRangeFrame, self)
			self:Schedule(2, updateRangeFrame, self)
			self:Schedule(5, updateRangeFrame, self)
			voiceForceNova:Play("range5")
			specWarnForceNovaRep:Show()
		else
			specWarnForceNova:Show()
		end
	elseif spellId == 164235 then
		self.vb.forceCount = self.vb.forceCount + 1
		specWarnForceNova:Show()
		timerForceNovaCD:Start(nil, self.vb.forceCount+1)
		countdownForceNova:Start()
		voiceForceNova:Schedule(38.5, "157349")
		--Fortified novas, 3 novas not just 1. Start additional timer/Countdown for novas 2 and 3
		timerForceNovaFortification:Start()
		timerForceNovaFortification:Schedule(9)
		countdownForceNova:Start(9)
		countdownForceNova:Start(18)
		specWarnForceNova:Schedule(9)
		specWarnForceNova:Schedule(18)
	elseif spellId == 164240 then
		self.vb.forceCount = self.vb.forceCount + 1
		self.vb.RepNovaActive = true
		if self:IsMythic() then
			self:Schedule(27, delayedRangeUpdate, self)--Also Fortification empowered
			--Fortified novas, 3 novas not just 1. Start additional timer/Countdown for novas 2 and 3
			timerForceNovaFortification:Start()
			timerForceNovaFortification:Schedule(9)
			countdownForceNova:Start(9)
			countdownForceNova:Start(18)
			specWarnForceNovaRep:Schedule(9)
			specWarnForceNovaRep:Schedule(18)
			voiceForceNova:Schedule(9, "range5")
			voiceForceNova:Schedule(18, "range5")
		else
			self:Schedule(9, delayedRangeUpdate, self)
		end
		updateRangeFrame(self)
		--Three extra checks to make sure we update 35 to 5 if tank was too close briefly if they came at same time
		self:Schedule(1, updateRangeFrame, self)
		self:Schedule(2, updateRangeFrame, self)
		self:Schedule(5, updateRangeFrame, self)
		specWarnForceNovaRep:Show()
		timerForceNovaCD:Start(nil, self.vb.forceCount+1)
		voiceForceNova:Schedule(38.5, "157349")
		voiceForceNova:Play("range5") --keep range 5 yards
	-----
	elseif spellId == 156471 then
		self.vb.arcaneAdd = self.vb.arcaneAdd + 1
		specWarnAberration:Show(self.vb.arcaneAdd)
		timerSummonArcaneAberrationCD:Start(nil, self.vb.arcaneAdd+1)
		voiceArcaneAberration:Play("killmob")
	elseif spellId == 164299 then
		self.vb.arcaneAdd = self.vb.arcaneAdd + 1
		specWarnAberration:Show(self.vb.arcaneAdd)
		timerSummonArcaneAberrationCD:Start(nil, self.vb.arcaneAdd+1)
		voiceArcaneAberration:Play("killmob")
	elseif spellId == 164301 then
		self.vb.arcaneAdd = self.vb.arcaneAdd + 1
		specWarnAberration:Show(self.vb.arcaneAdd)
		timerSummonArcaneAberrationCD:Start(nil, self.vb.arcaneAdd+1)
		voiceArcaneAberration:Play("killmob")
	elseif spellId == 164303 then
		self.vb.arcaneAdd = self.vb.arcaneAdd + 1
		specWarnAberration:Show(self.vb.arcaneAdd)
		timerSummonArcaneAberrationCD:Start(nil, self.vb.arcaneAdd+1)
		voiceArcaneAberration:Play("killmob")
	elseif args:IsSpellID(158605, 164176, 164178, 164191) then
		local targetName, uId = self:GetBossTarget(77428)
		local tanking, status = UnitDetailedThreatSituation("player", "boss1")
		self.vb.noTaunt = true
		timerMarkOfChaosCD:Start()
		countdownMarkofChaos:Start()
		if spellId == 158605 then
			if self.Options.warnMarkOfChaos and targetName then
				warnMarkOfChaos:Show(targetName)
			end
			if tanking or (status == 3) then
				specWarnMarkOfChaos:Show()
				voiceMarkOfChaos:Play("runout")
			else
				specWarnMarkOfChaosOther:Show(targetName)
				voiceMarkOfChaos:Play("changemt")
			end
		elseif spellId == 164176 then
			if self.Options.warnMarkOfChaos and targetName then
				warnMarkOfChaosDisplacement:Show(targetName)
			end
			if tanking or (status == 3) then
				--No action, displacement you don't run out until fast FINISHES since cast finish ports you into raid.
			else
				specWarnMarkOfChaosDisplacementOther:Show(targetName)
				voiceMarkOfChaos:Play("changemt")
			end
		elseif spellId == 164178 then
			if self.Options.warnMarkOfChaos and targetName then
				warnMarkOfChaosFortification:Show(targetName)
			end
			if tanking or (status == 3) then
				specWarnMarkOfChaosFortification:Show()
				voiceMarkOfChaos:Play("runout")--Tank can still run out during cast. This spellid is only used phase 3 in all modes, never displacement
			else
				specWarnMarkOfChaosFortificationOther:Show(targetName)
				voiceMarkOfChaos:Play("changemt")
			end
		elseif spellId == 164191 then
			if self.Options.warnMarkOfChaos and targetName then
				warnMarkOfChaosReplication:Show(targetName)
			end
			if tanking or (status == 3) then
				specWarnMarkOfChaosReplication:Show()
				yellMarkOfChaosReplication:Yell()
				voiceMarkOfChaos:Play("runout")
			else
				specWarnMarkOfChaosReplicationOther:Show(targetName)
				voiceMarkOfChaos:Play("changemt")
				voiceMarkOfChaos:Schedule(1.5, "watchstep")
			end
		end
		if tanking or (status == 3) then
			self.vb.playerHasMark = true
		else
			self.vb.playerHasMark = false
		end
		updateRangeFrame(self, true)
		self:Schedule(4, updateRangeFrame, self)--Cast + 1, since sometimes tank resists, so we'll want to hide frame after 4 seconds if no debuff has gone out in 2.
	elseif spellId == 165243 then
		self.vb.madnessAdd = self.vb.madnessAdd + 1
		warnGlimpseOfMadness:Show(self.vb.madnessAdd)
		timerGlimpseOfMadnessCD:Start(nil, self.vb.madnessAdd+1)
	elseif spellId == 165876 then
		self.vb.envelopingCount = self.vb.envelopingCount + 1
		warnEnvelopingNight:Show(self.vb.envelopingCount)
		specWarnEnvelopingNight:Show(self.vb.envelopingCount)
		voiceEnvelopingNight:Play("aesoon")
		timerEnvelopingNightCD:Start(nil, self.vb.envelopingCount+1)
		countdownEnvelopingNight:Start()
	elseif spellId == 178607 then
		warnDarkStar:Show()
		specWarnDarkStar:Show()
		timerDarkStarCD:Start()
		countdownDarkStar:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 158563 then
		timerKickToFaceCD:Start()
		if args:IsPlayer() then
			specWarnKickToTheFace:Show()
		else
			specWarnKickToTheFaceOther:Show(args.destName)
		end
	elseif spellId == 165102 then
		timerInfiniteDarknessCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 157763 then
		warnFixate:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnFixate:Show()
			if not self:IsLFR() then
				yellFixate:Yell()
				voiceFixate:Play("runout")
				voiceFixate:Schedule(1.5,"targetyou")
			end
			updateRangeFrame(self)
		end
	elseif args:IsSpellID(156225, 164004, 164005, 164006) then
		self.vb.brandedActive = self.vb.brandedActive + 1
		local uId = DBM:GetRaidUnitId(args.destName)
		local _, _, _, currentStack = UnitDebuff(uId, GetSpellInfo(spellId))
		local fortified = (self:IsMythic() and self.vb.phase >= 3) or spellId == 164005--Phase 3 uses replication ID, so need hack for mythic fortified/replication phase.
		if not currentStack then
			print("currentStack is nil, report to dbm authors. Branded warning disabled.")--Should never happen but added just in case.
			return
		end
		if fortified then
			self.vb.jumpDistance = jumpDistance2[currentStack] or 5
		else
			self.vb.jumpDistance = jumpDistance1[currentStack] or 5
		end
		--Yell for all stacks
		if args:IsPlayer() then
			self.vb.playerHasBranded = true
			if not self:IsLFR() then
				yellBranded:Yell(currentStack.."-"..self.vb.jumpDistance, playerName)
			end
		end
		--General warnings after 3 stacks
		if currentStack > 2 then
			if spellId == 156225 then
				if self.Options.warnBranded then
					warnBranded:Show(args.destName, currentStack)
				end
				if args:IsPlayer() and currentStack > 4 then--Special warning only for person that needs to get out
					specWarnBranded:Show(currentStack)
					voiceBranded:Play("runout")
				end
			elseif spellId == 164004 then
				if self.Options.warnBranded then
					warnBrandedDisplacement:CombinedShow(0.5, args.destName, currentStack)
				end
				if currentStack > 4  then--Special warning only for person that needs to get out
					if args:IsPlayer() then
						specWarnBrandedDisplacement:Show(currentStack)
					elseif self:CheckNearby(self.vb.jumpDistance, args.destName) then
						specWarnBrandedDisplacementNear:Show(args.destName)
					end
				end
			elseif spellId == 164005 then
				if self.Options.warnBranded then
					warnBrandedFortification:Show(args.destName, currentStack)
				end
				if args:IsPlayer() and currentStack > 4 then--Special warning all stacks 5 and higher because even if can't get out, high damage
					specWarnBrandedFortification:Show(currentStack)
					if (self:IsMythic() and currentStack > 4) or currentStack > 6 then
						voiceBranded:Play("runout")
					end
				end
			elseif spellId == 164006 then
				if self.Options.warnBranded then
					warnBrandedReplication:CombinedShow(0.5, args.destName, currentStack)
				end
				if args:IsPlayer() and currentStack > 4 then--Special warning only for person that needs to get out
					specWarnBrandedReplication:Show(currentStack)
					voiceBranded:Play("runout")
				end
			end
			if self.Options.SetIconOnBrandedDebuff then
				if spellId == 164006 or (self:IsMythic() and spellId == 164004) then--On mythic, displacement/replication in phase 1. Using dipslacemnet spellid, on two targets.
					self:SetSortedIcon(1, args.destName, 1, 2)
				else
					self:SetIcon(args.destName, 1)
				end
			end
			updateRangeFrame(self)--Update it here cause we don't need it before stacks get to relevant levels.
		end
	elseif spellId == 158553 then
		local amount = args.amount or 1
		warnCrushArmor:Show(args.destName, amount)
		timerCrushArmorCD:Start()
	elseif spellId == 178468 and ((UnitGUID("target") == args.destGUID) or (UnitGUID("focus") == args.destGUID)) then
		local amount = args.amount or 1
		if amount >= 3 then
			specWarnNetherEnergy:Show(amount)
		end
	elseif spellId == 159515 then
		local amount = args.amount or 1
		--5 may seem low stack, most wait longer on easier difficulties, but this boss has taunt DR flag turned OFF, there is really no reason to wait for higher stacks, and on mythic 5 is common number to reduce tank damage
		if (amount == 5 or amount >= 8) and not self.vb.noTaunt and self:AntiSpam(3, 3) then--First warning at 5, then a decent amount of time until 8. then spam every 3 seconds at 8 and above.
			local elapsed, total = timerMarkOfChaosCD:GetTime()
			local remaining = total - elapsed
			if (remaining > 0) and (remaining < 5) then
				self.vb.noTaunt = true--don't warn if mark of chaos very soon
				return
			end
			warnAcceleratedAssault:Show(args.destName, amount)
			local tanking, status = UnitDetailedThreatSituation("player", "boss1")
			if tanking or (status == 3) then
				specWarnAcceleratedAssault:Show(amount)
			else
				specWarnAcceleratedAssaultOther:Show(L.name)
			end
			voiceAcceleratedAssault:Play("changemt")
		end
	elseif args:IsSpellID(158605, 164176, 164178, 164191) then
		--Update frame again in case he swaped targets during cast (happens)
		self.vb.markActive = true
		self.vb.lastMarkedTank = args.destName
		local uId = DBM:GetRaidUnitId(args.destName)
		local _, _, _, _, _, duration, expires, _, _ = UnitDebuff(uId, args.spellName)
		timerMarkOfChaos:Start(duration, args.destName)
		if args:IsPlayer() then
			self.vb.playerHasMark = true
			if spellId == 164176 then 
				--Displacement you cannot run out on cast start (you get ported back on cast finish). Only warn after cast finish.
				if self:IsMythic() and self.vb.phase == 2 then--Mythic phase 2 uses displacement spellid but it's also fortified
					specWarnMarkOfChaosFortification:Show()--So show fortified warning, not displacement.
				else
					specWarnMarkOfChaosDisplacement:Show()
				end
				voiceMarkOfChaos:Play("runout")
			elseif spellId == 164178 then
				yellMarkOfChaosFortification:Yell()--Always yell when root occurs in all modes though.
			end
		else
			self.vb.playerHasMark = false
			if spellId == 164178 and self:CheckNearby(38, args.destName) then
				specWarnMarkOfChaosFortificationNear:Show(args.destName)
				voiceMarkOfChaos:Play("justrun")
			end
		end
		self:Unschedule(updateRangeFrame)
		updateRangeFrame(self)
	elseif spellId == 157801 then
		specWarnSlow:Show(args.destName)
		voiceSlow:Play("dispelnow")
	elseif spellId == 165102 then
		warnInfiniteDarkness:CombinedShow(0.3, args.destName)
		if self.Options.SetIconOnInfiniteDarkness then
			self:SetSortedIcon(1, args.destName, 1, 3)
		end
	elseif spellId == 165595 then
		if args:IsPlayer() then
			local amount = args.amount or 1
			warnGazeSelf:Show(args.destName, amount)
			specWarnGaze:Show(amount)
			timerGaze:Cancel()
			countdownGaze:Cancel()
			timerGaze:Start()
			countdownGaze:Start()
			yellGaze:Cancel()
			yellGaze:Schedule(9, 1)
			yellGaze:Schedule(8, 2)
			yellGaze:Schedule(7, 3)
			yellGaze:Schedule(6, 4)
			yellGaze:Schedule(5, 5)
			yellGaze:Schedule(3, 7)
			yellGaze:Yell(10)
		end
		updateRangeFrame(self)
	elseif spellId == 176533 and args:IsPlayer() and self:AntiSpam(2, 1) then
		specWarnGrowingDarkness:Show()
		voiceGrowingDarkness:Play("runout")
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REFRESH(args)
	local spellId = args.spellId
	if spellId == 157763 then
		warnFixate:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnFixate:Show()
			if not self:IsLFR() then
				yellFixate:Yell()
				voiceFixate:Play("runout")
				voiceFixate:Schedule(1.5,"targetyou")
			end
			updateRangeFrame(self)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if args:IsSpellID(158605, 164176, 164178, 164191) then
		self.vb.markActive = false
		self.vb.noTaunt = false
		self.vb.lastMarkedTank = nil
		if args:IsPlayer() then
			self.vb.playerHasMark = false
		end
		updateRangeFrame(self)
	elseif spellId == 157763 and args:IsPlayer() and self.Options.RangeFrame then
		updateRangeFrame(self)
	elseif args:IsSpellID(156225, 164004, 164005, 164006) then
		self.vb.brandedActive = self.vb.brandedActive - 1
		if args:IsPlayer() then
			self.vb.playerHasBranded = false
		end
		if self.Options.SetIconOnBrandedDebuff then
			self:SetIcon(args.destName, 0)
		end
		updateRangeFrame(self)
	elseif spellId == 165102 and self.Options.SetIconOnInfiniteDarkness then
		self:SetIcon(args.destName, 0)
	elseif spellId == 165595 then
		if args:IsPlayer() then
			timerGaze:Cancel()
			countdownGaze:Cancel()
		end
		updateRangeFrame(self)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 176533 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnGrowingDarkness:Show()
		voiceGrowingDarkness:Play("runout")
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 78549 then--Reaver
		timerCrushArmorCD:Cancel()
		timerKickToFaceCD:Cancel()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 164751 or spellId == 164810 then--Teleport to Fortification/Teleport to Replication.
		self.vb.isTransition = true
		timerArcaneWrathCD:Cancel()
		countdownArcaneWrath:Cancel()
		timerDestructiveResonanceCD:Cancel()
		timerSummonArcaneAberrationCD:Cancel()
		timerMarkOfChaosCD:Cancel()
		countdownMarkofChaos:Cancel()
		timerForceNovaCD:Cancel()
		countdownForceNova:Cancel()
		voiceForceNova:Cancel()
		timerForceNovaFortification:Cancel()
		countdownForceNova:Cancel()
		specWarnForceNova:Cancel()
		timerTransition:Start()
		countdownTransition:Start()
		voicePhaseChange:Play("ptran")
		updateRangeFrame(self)
		if spellId == 164810 then
			timerCrushArmorCD:Start(23)
			timerKickToFaceCD:Start(42)
			warnPhase:Show(inter2)
		else
			warnPhase:Show(inter1)
		end
	elseif spellId == 158012 or spellId == 157964 then--Power of Foritification/Replication
		self.vb.forceCount = 0
		self.vb.arcaneAdd = 0
		self.vb.isTransition = false
		specWarnTransitionEnd:Show()
		timerArcaneWrathCD:Start(8.5)
		countdownArcaneWrath:Start(8.5)
		timerDestructiveResonanceCD:Start(18)
		timerSummonArcaneAberrationCD:Start(28, 1)
		timerMarkOfChaosCD:Start(36.5)
		countdownMarkofChaos:Start(36.5)
		timerForceNovaCD:Start(48.5, 1)
		voiceForceNova:Schedule(42, "157349")
		countdownForceNova:Start(48.5)
		if spellId == 158012 then
			if self:IsMythic() then
				self.vb.phase = 2
				warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.phase:format(2))
				voicePhaseChange:Play("ptwo")
			else
				self.vb.phase = 3
				warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.phase:format(3))
				voicePhaseChange:Play("pthree")
			end
		end
		if spellId == 157964 then
			if self:IsMythic() then
				self.vb.phase = 3
				warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.phase:format(3))
				voicePhaseChange:Play("pthree")
				self:RegisterShortTermEvents(
					"CHAT_MSG_MONSTER_YELL"
				)
			else
				self.vb.phase = 4
				warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.phase:format(4))
				voicePhaseChange:Play("pfour")
			end
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 164336 then--Teleport to Displacement (first phase change that has no transition)
		--This needs complicated work. Timers that have > 10 seconds remaining get extended by about 3-4 seconds.
		--But timers that have < 10 seconds remaining get extended by like 10-13 seconds. 
		--So besides code that's already done below, need to check time remaining < or > 10 and do all kinds of nasty crap. maybe not worth it
--[[		countdownArcaneWrath:Cancel()
		countdownMarkofChaos:Cancel()
		countdownForceNova:Cancel()
		voiceForceNova:Cancel()
		local te1, te2, te3, te4, te5
		local tt1, tt2, tt3, tt4, tt5
		te1, tt1 = timerArcaneWrathCD:GetTime()
		te2, tt2 = timerDestructiveResonanceCD:GetTime()
		te3, tt3 = timerSummonArcaneAberrationCD:GetTime()
		te4, tt4 = timerMarkOfChaosCD:GetTime()
		te5, tt5 = timerForceNovaCD:GetTime()
		local tr1, tr2, tr3, tr4, tr5 = tt1-te1,tt2-te2,tt3-te3,tt4-te4,tt5-te5
		countdownArcaneWrath:Start(tr1+n)
		timerArcaneWrathCD:Start(tr1+n)
		timerDestructiveResonanceCD:Start(tr2+n)
		timerSummonArcaneAberrationCD:Start(tr3+n)
		timerMarkOfChaosCD:Start(tr4+n)		
		countdownMarkofChaos:Start(tr4+n)
		timerForceNovaCD:Start(tr5+n)
		countdownForceNova:Start(tr5+n)--]]
		self.vb.phase = 2
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.phase:format(2))
		voicePhaseChange:Play("ptwo")
	elseif spellId == 70628 then --Margok being killed by chogal
		self.vb.phase = 4
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.phase:format(4))
		voicePhaseChange:Play("pfour")
		timerArcaneWrathCD:Cancel()
		countdownArcaneWrath:Cancel()
		timerDestructiveResonanceCD:Cancel()
		timerSummonArcaneAberrationCD:Cancel()
		timerMarkOfChaosCD:Cancel()
		countdownMarkofChaos:Cancel()
		timerForceNovaCD:Cancel()
		voiceForceNova:Cancel()
		countdownForceNova:Cancel()
		timerForceNovaFortification:Cancel()
		countdownForceNova:Cancel()
		specWarnForceNova:Cancel()
		updateRangeFrame(self)
		timerInfiniteDarknessCD:Start(9)--First timer 8-12 second variable, almost always 10. I'll make 9 for now so it's semi accurate in both situations
		timerGlimpseOfMadnessCD:Start(20, 1)
		timerDarkStarCD:Start(29)
		countdownDarkStar:Start(29)
		timerEnvelopingNightCD:Start(55, 1)
		countdownEnvelopingNight:Start(55)
		self:RegisterShortTermEvents(
			"SPELL_PERIODIC_DAMAGE 176533",
			"SPELL_ABSORBED 176533"
		)
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(L.PlayerDebuffs)
			DBM.InfoFrame:Show(5, "playerbaddebuffbyspellid", 176537)
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg, npc)
	if npc == chogallName then--Some creative shit right here. Screw localized text. This will trigger off first yell at start of 35 second RP Sender is 丘加利 (Cho'gall)
		self:UnregisterShortTermEvents()--Unregister Yell
		timerTransition:Start(34)--Boss/any arcane adds still active during this, so do not cancel timers here, canceled on margok death
	end
end
