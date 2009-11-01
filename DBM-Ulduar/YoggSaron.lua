local mod = DBM:NewMod("YoggSaron", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(33288)

mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON",
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_AURA_REMOVED_DOSE",
	"UNIT_HEALTH",
	"UNIT_DIED"
)

mod:SetUsedIcons(4, 6, 7, 8)


local warnGuardianSpawned 			= mod:NewAnnounce("WarningGuardianSpawned", 3, 62979)
local warnCrusherTentacleSpawned	= mod:NewAnnounce("WarningCrusherTentacleSpawned", 2)
local warnP2 						= mod:NewAnnounce("WarningP2", 2)
local warnP3 						= mod:NewAnnounce("WarningP3", 2)
local warnSanity 					= mod:NewAnnounce("WarningSanity", 3)
local specWarnGuardianLow 			= mod:NewSpecialWarning("SpecWarnGuardianLow", false)
local warnBrainLink 				= mod:NewAnnounce("WarningBrainLink", 2)
local specWarnBrainLink 			= mod:NewSpecialWarning("SpecWarnBrainLink")
local specWarnSanity 				= mod:NewSpecialWarning("SpecWarnSanity")
local warnMadness 					= mod:NewAnnounce("WarnMadness", 1)
local timerMadness 					= mod:NewCastTimer(60, 64059)
local specWarnMadnessOutNow			= mod:NewSpecialWarning("SpecWarnMadnessOutNow")
local warnBrainPortalSoon			= mod:NewAnnounce("WarnBrainPortalSoon", 1)
local specWarnBrainPortalSoon		= mod:NewSpecialWarning("specWarnBrainPortalSoon", false)
local warnSqueeze					= mod:NewAnnounce("WarnSqueeze", 1)
local brainportal					= mod:NewTimer(20, "NextPortal")
local warnFavor						= mod:NewAnnounce("WarnFavor", 1)
local specWarnFavor					= mod:NewSpecialWarning("SpecWarnFavor")
local timerLunaricGaze				= mod:NewCastTimer(4, 64163)
local timerNextLunaricGaze			= mod:NewCDTimer(8.5, 64163)
local warnEmpowerSoon				= mod:NewAnnounce("WarnEmpowerSoon", 4)
local timerEmpower					= mod:NewCDTimer(46, 64465)
local timerEmpowerDuration			= mod:NewBuffActiveTimer(10, 64465)
local specWarnMaladyNear			= mod:NewSpecialWarning("SpecWarnMaladyNear", true)

local warnDeafeningRoarSoon			= mod:NewPreWarnAnnounce(64189, 5, 3)
local timerCastDeafeningRoar		= mod:NewCastTimer(2.3, 64189)
local timerNextDeafeningRoar		= mod:NewNextTimer(30, 64189)
local specWarnDeafeningRoar			= mod:NewSpecialWarning("SpecWarnDeafeningRoar", false)


local timerAchieve	= mod:NewAchievementTimer(420, 3012, "TimerSpeedKill")

mod:AddBoolOption("ShowSaraHealth")
mod:AddBoolOption("WhisperBrainLink", false)
mod:AddBoolOption("WarningSqueeze", false, "announce")
mod:AddBoolOption("SetIconOnFearTarget")
mod:AddBoolOption("SetIconOnFavorTarget")
mod:AddBoolOption("SetIconOnMCTarget")
--mod:AddBoolOption("RaidRageSpam", false)


local enrageTimer	= mod:NewEnrageTimer(900)

local phase = 1
local targetWarningsShown = {}
local brainLink1

function mod:OnCombatStart(delay)
	phase = 1
	brainLink1 = nil
	enrageTimer:Start()
	timerAchieve:Start()
	if self.Options.ShowSaraHealth and not self.Options.HealthFrame then
		DBM.BossHealth:Show(L.name)
	end
	if self.Options.ShowSaraHealth then
		DBM.BossHealth:AddBoss(33134, L.Sara)
	end
	table.wipe(targetWarningsShown)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(64059) then	-- Induce Madness
		timerMadness:Start()
		warnMadness:Show()
		brainportal:Schedule(60)
		warnBrainPortalSoon:Schedule(78)
		specWarnBrainPortalSoon:Schedule(78)
		specWarnMadnessOutNow:Schedule(55)
	elseif args:IsSpellID(64189) then		--Deafening Roar
		timerNextDeafeningRoar:Start()
		warnDeafeningRoarSoon:Schedule(55)
		timerCastDeafeningRoar:Start()
		specWarnDeafeningRoar:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg, sender)
	if msg == L.YellRage then
		if self.Options.RaidRageSpam then
--			SendChatMessage(L.RaidRage, "RAID")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(64144) and self:GetUnitCreatureId(args.sourceGUID) == 33966 then 
		warnCrusherTentacleSpawned:Show()
	end
end


function mod:SPELL_SUMMON(args)
	if args:IsSpellID(62979) then
		warnGuardianSpawned:Show()
	end
end

-- 4/24 21:56:29.656  SPELL_AURA_APPLIED,0xF150008208022C87,"Yogg-Saron",0xa48,0xF150008208022C87,"Yogg-Saron",0xa48,63894,"Shadowy Barrier",0x20,BUFFfunction mod:SPELL_AURA_APPLIED(args)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(63802) then		-- Brain Link
		if not brainLink1 then
			self:SetIcon(args.destName, 6, 30)
			brainLink1 = args.destName
		else
			self:SetIcon(args.destName, 7, 30)
			warnBrainLink:Show(brainLink1, args.destName)
			self:AnnounceBrainLink(brainLink1, args.destName)
			self:AnnounceBrainLink(args.destName, brainLink1)
			brainLink1 = nil
		end

	elseif args:IsSpellID(63830, 63881) and self.Options.SetIconOnFearTarget then   -- Malady of the Mind (Fear) 
		self:SetIcon(args.destName, 8, 30) 
		local uId = DBM:GetRaidUnitId(args.destName) 
		if uId then 
			local inRange = CheckInteractDistance(uId, 2) 
			if inRange then 
				specWarnMaladyNear:Show(args.destName) 
			end 
		end 
		
	elseif args:IsSpellID(63042) and self.Options.SetIconOnMCTarget then	-- MC
		self:SetIcon(args.destName, 4, 30)

	elseif args:IsSpellID(64126, 64125) then	-- Squeeze		
		warnSqueeze:Show(args.destName)		
		if args:IsPlayer() and self.Options.WarningSqueeze then			
			SendChatMessage(L.WarningYellSqueeze, "YELL")			
		end	

	elseif args:IsSpellID(63138) then	-- Sara's Favor
		warnFavor:Show(args.destName)
		if self.Options.SetIconOnFavorTarget then
			self:SetIcon(args.destName, 4, 30)
		end
		if args:IsPlayer() then 
			specWarnFavor:Show()
		end

	elseif args:IsSpellID(63894) then	-- Shadowy Barrier of Yogg-Saron (this is happens when p2 starts)
		phase = 2
		brainportal:Start(60)
		warnBrainPortalSoon:Schedule(57)
		specWarnBrainPortalSoon:Schedule(57)
		warnP2:Show()
		if self.Options.ShowSaraHealth then
			DBM.BossHealth:RemoveBoss(33134)
			if not self.Options.HealthFrame then
				DBM.BossHealth:Hide()
			end
		end
	elseif args:IsSpellID(64167, 64163) then	-- Lunatic Gaze (reduces sanity)
		timerLunaricGaze:Start()
	elseif args:IsSpellID(64465) then
        timerEmpower:Start()
		timerEmpowerDuration:Start()
		warnEmpowerSoon:Schedule(40)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(63894) then		-- Shadowy Barrier removed from Yogg-Saron (start p3)
		warnP3:Show()
		phase = 3
		brainportal:Stop()
        timerEmpower:Start()
        warnEmpowerSoon:Schedule(40)	
		warnBrainPortalSoon:Cancel()
		timerNextDeafeningRoar:Start(30)
		warnDeafeningRoarSoon:Schedule(25)
	elseif args:IsSpellID(64167, 64163) then	-- Lunatic Gaze
		timerNextLunaricGaze:Start()
	end
end

function mod:AnnounceBrainLink(player, other)
	if player == UnitName("player") then
		specWarnBrainLink:Show(other)
	end
	if DBM:GetRaidRank() >= 1 and self.Options.WhisperBrainLink then
		self:SendWhisper(L.WhisperBrainLink:format(other), player)
	end
end


function mod:SPELL_AURA_REMOVED_DOSE(args)
	if args:IsSpellID(63050) and args.destGUID == UnitGUID("player") then
		if args.amount == 50 then
			warnSanity:Show(args.amount)
		elseif args.amount == 25 or args.amount == 15 or args.amount == 5 then
			warnSanity:Show(args.amount)
			specWarnSanity:Show(args.amount)
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if phase == 1 and uId == "target" and self:GetUnitCreatureId(uId) == 33136 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.3 and not targetWarningsShown[UnitGUID(uId)] then
		targetWarningsShown[UnitGUID(uId)] = true
		specWarnGuardianLow:Show()
	end
end


