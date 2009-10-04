﻿local mod = DBM:NewMod("Anub'arak_Coliseum", "DBM-Coliseum")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(34564)  

mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

mod:SetUsedIcons(3, 4, 5, 6, 7, 8)


-- Pursue
local warnPursue			= mod:NewAnnounce("WarnPursue", 2)
local specWarnPursue		= mod:NewSpecialWarning("SpecWarnPursue")
mod:AddBoolOption("PlaySoundOnPursue")
mod:AddBoolOption("PursueIcon")

-- Emerge
local warnEmerge			= mod:NewAnnounce("WarnEmerge", 3, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnEmergeSoon		= mod:NewAnnounce("WarnEmergeSoon", 1, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local timerEmerge			= mod:NewTimer(65, "TimerEmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")

-- Submerge
local warnSubmerge			= mod:NewAnnounce("WarnSubmerge", 3, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnSubmergeSoon		= mod:NewAnnounce("WarnSubmergeSoon", 1, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local timerSubmerge			= mod:NewTimer(75, "TimerSubmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")

-- Phases
local warnPhase3			= mod:NewPhaseAnnounce(3)
local enrageTimer			= mod:NewEnrageTimer(570)	-- 9:30 ? hmpf (no enrage while submerged... this sucks)

-- Penetrating Cold
local specWarnPCold			= mod:NewSpecialWarning("SpecWarnPCold", false)
local timerPCold			= mod:NewTargetTimer(15, 68509)
mod:AddBoolOption("SetIconsOnPCold", true, "announce")

-- Freezing Slash
local warnFreezingSlash		= mod:NewTargetAnnounce(66012, 2)
local timerFreezingSlash	= mod:NewCDTimer(20, 66012)

-- Shadow Strike
local timerShadowStrike		= mod:NewNextTimer(30, 66134)
local preWarnShadowStrike	= mod:NewSoonAnnounce(66134, 3)
local warnShadowStrike		= mod:NewSpellAnnounce(66134, 4)
local specWarnShadowStrike	= mod:NewSpecialWarning("SpecWarnShadowStrike", false)

local PColdIcon = 7
function mod:resetIcons()
	PColdIcon = 7
end

function mod:OnCombatStart(delay)
	timerSubmerge:Start(80-delay)
	enrageTimer:Start(-delay)
	self:resetIcons()
	timerFreezingSlash:Start(-delay)
	if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
		timerShadowStrike:Start()
		preWarnShadowStrike:Schedule(25)
		self:ScheduleMethod(30, "ShadowStrike")
	end
end

function mod:ShadowStrike()
	if self:IsInCombat() then
		timerShadowStrike:Start()
		preWarnShadowStrike:Cancel()
		preWarnShadowStrike:Schedule(25)
		self:ScheduleMethod(30, "ShadowStrike")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(67574) then			-- Pursue
		if args:IsPlayer() then
			specWarnPursue:Show()
			if self.Options.PlaySoundOnPursue then
				PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
			end
		end
		if self.Options.PursueIcon then
			self:SetIcon(args.destName, 8, 15)
		end
		warnPursue:Show(args.destName)

	elseif args:IsSpellID(66013, 67700, 68509, 68510) then		-- Penetrating Cold
		mod:ScheduleMethod(3, "resetIcons")		
		if args:IsPlayer() then
			specWarnPCold:Show()
		end
		if self.Options.SetIconsOnPCold and PColdIcon > 0 then
			mod:SetIcon(args.destName, PColdIcon, 15)
			PColdIcon = PColdIcon - 1
		end
		timerPCold:Show(args.destName)
	elseif args:IsSpellID(66012) then		-- Freezing Slash
		warnFreezingSlash:Show(args.destName)
		timerFreezingSlash:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(66013, 67700, 68509, 68510) then			-- Penetrating Cold
		mod:SetIcon(args.destName, 0)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(66118, 67630, 68646, 68647) then		-- Swarm
		warnPhase3:Show()
		warnEmergeSoon:Cancel()
		warnSubmergeSoon:Cancel()
		timerEmerge:Stop()
		timerSubmerge:Stop()
	elseif args:IsSpellID(66134) then						-- Shadow Strike
		self:ScheduleMethod(0.1, "ShadowStrike")
		specWarnShadowStrike:Show()
		warnShadowStrike:Show()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg and msg:find(L.Burrow) then
		warnSubmerge:Show()
		warnEmergeSoon:Schedule(55)
		timerEmerge:Start()
		timerFreezingSlash:Stop()
	elseif msg and msg:find(L.Emerge) then
		warnEmerge:Show()
		warnSubmergeSoon:Schedule(75)
		timerSubmerge:Start()
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			self:ScheduleMethod(5, "ShadowStrike")	-- 35sec after Emerge next ShadowStrike
		end
	end
end

