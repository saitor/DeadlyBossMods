local mod	= DBM:NewMod(1703, "DBM-EmeraldNightmare", nil, 768)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 14737 $"):sub(12, -3))
mod:SetCreatureID(102672, 103160)--TODO, figure out which one
mod:SetEncounterID(1853)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 3, 2, 1)
--mod:SetHotfixNoticeRev(12324)

mod:RegisterCombat("combat")

--[[
mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
--	"SPELL_DAMAGE",
--	"SPELL_MISSED",
	"CHAT_MSG_MONSTER_YELL"
)

local warnExpelMagicFrost			= mod:NewTargetAnnounce(161411, 3)

local yellTrample					= mod:NewYell(163101)
local specWarnTrampleNear			= mod:NewSpecialWarningClose(163101)
local specWarnExpelMagicShadow		= mod:NewSpecialWarningSpell(162184, "Healer", nil, nil, nil, 2)

local timerTrampleCD				= mod:NewCDTimer(16, 163101, nil, nil, nil, 3)

local countdownMagicFire			= mod:NewCountdownFades(11.5, 162185)

local voiceExpelMagicFire			= mod:NewVoice(162185)

mod:AddRangeFrameOption("5")
mod:AddSetIconOption("SetIconOnMC", 163472, false)
mod:AddHudMapOption("HudMapOnMC", 163472)

function mod:ArcaneTarget()
	local targetName, uId = self:GetBossTarget(79015)
	local tanking, status = UnitDetailedThreatSituation("player", "boss1")
	if tanking or (status == 3) then--Player is current target
		specWarnExpelMagicArcaneYou:Show()--So show tank warning
		voiceExpelMagicArcane:Play("runout")
	else
		if self:AntiSpam(3.5, targetName) then--Set anti spam with target name
			specWarnExpelMagicArcane:Show(targetName)--Sometimes targetname is nil, and then it warns for unknown, but with the new status == 3 check, it'll still warn correct tank, so useful anyways
			voiceExpelMagicArcane:Play("changemt")
		end
	end
end

function mod:OnCombatStart(delay)

end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.FelArrow then
		DBM.Arrow:Hide()
	end
	if self.Options.HudMapOnMC then
		DBMHudMap:Disable()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 162185 then

	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 161612 and self:AntiSpam(5, 4) then--This won't show balls that hit, only ones caught. Balls that hit require high cpu spell_damage event
		self:SendSync("Ball")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 156803 then
		
	elseif spellId == 172917 and args:IsPlayer() then

	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 162186 then

	elseif spellId == 163472 then

	end
end

function mod:SPELL_DAMAGE()
	if self:AntiSpam(5, 4) then
		self:SendSync("Ball")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:CHAT_MSG_MONSTER_YELL(msg, _, _, _, target)
	if msg:find(L.supressionTarget1) then
		self:SendSync("ChargeTo", target)
	end
end

function mod:OnSync(msg, targetname)
	if not self:IsInCombat() then return end
	if msg == "ChargeTo" then
		
	end
end
--]]
