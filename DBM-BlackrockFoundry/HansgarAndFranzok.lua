local mod	= DBM:NewMod(1155, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(76974, 76973)
mod:SetEncounterID(1693)
mod:SetZone()
--mod:SetUsedIcons(5, 4, 3, 2, 1)
mod:SetHotfixNoticeRev(12934)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 160838 160845 160847 160848 153470",
	"SPELL_AURA_APPLIED 157139 162124",
	"SPELL_AURA_APPLIED_DOSE 157139",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2",
	"UNIT_TARGETABLE_CHANGED"
)

--TODO, find target scanning for skullcracker. Also, find out how it behaves when it's more than 1 target (just recast?)
--TODO, maybe use http://beta.wowhead.com/spell=154785 for aftershock/Shattered Vertebrae instead?'
--TODO, collect more data to figure out how roar starts/resumes on jump down. One pull/kill is not a sufficient sampling.
local warnSkullcracker					= mod:NewSpellAnnounce(153470, 3, nil, false)--This seems pretty worthless.
local warnShatteredVertebrae			= mod:NewStackAnnounce("OptionVersion2", 157139, 2, nil, false)--Possibly useless or changed. Needs further logs.
local warnJumpSlam						= mod:NewTargetAnnounce("ej9854", 3)--Find pretty icon

local specWarnJumpSlam					= mod:NewSpecialWarningYou("ej9854")
local specWarnJumpSlamNear				= mod:NewSpecialWarningClose("ej9854")
local yellJumpSlam						= mod:NewYell("ej9854")
local specWarnDisruptingRoar			= mod:NewSpecialWarningCast("OptionVersion2", 160838, "SpellCaster")
--Move specWarnCripplingSupplex to a health check, warn when near 85, 55, or 25%
local specWarnCripplingSupplex			= mod:NewSpecialWarningPreWarn("OptionVersion2", 156938, "Tank|Healer", 3, nil, nil, 3)--pop a cooldown.
local specWarnSearingPlates				= mod:NewSpecialWarningSpell(161570, nil, nil, nil, 2)
local specWarnStampers					= mod:NewSpecialWarningSpell(174825, nil, nil, nil, 2)
local specWarnSearingPlatesEnd			= mod:NewSpecialWarningEnd(161570, nil, nil, nil, nil, nil, 2)
local specWarnStampersEnd				= mod:NewSpecialWarningEnd(174825, nil, nil, nil, nil, nil, 2)

local timerDisruptingRoar				= mod:NewCastTimer(2.5, 160838, nil, "SpellCaster")
local timerDisruptingRoarCD				= mod:NewCDTimer(45, 160838, nil, "SpellCaster")
local timerSkullcrackerCD				= mod:NewCDTimer(22, 153470, nil, "Healer")
local timerCripplingSupplex				= mod:NewCastTimer(9.5, 156938, nil, "Tank|Healer")
local timerJumpSlamCD					= mod:NewNextTimer(34, "ej9854")
mod:AddTimerLine(ENCOUNTER_JOURNAL_SECTION_FLAG12)
local timerSmartStamperCD				= mod:NewNextTimer(12, 162124)--Activation

--local berserkTimer						= mod:NewBerserkTimer(360)

local countSmartStampers				= mod:NewCountdown(12, 160582)
local countCripplingSupplex				= mod:NewCountdown("OptionVersion2", "Alt9.5", 156938, "Tank|Healer")

local voiceEnvironmentalThreats			= mod:NewVoice("ej10089")

mod.vb.phase = 1
mod.vb.stamperDodgeCount = 0
mod.vb.bossUp = "NoBody"
--mod.vb.lastJumpTarget = "None"
mod.vb.firstJump = false
local cachedGUID = nil

function mod:JumpTarget(targetname, uId)
	if not targetname then return end
--	self.vb.lastJumpTarget = targetname
	if targetname == UnitName("player") then
		specWarnJumpSlam:Show()
		yellJumpSlam:Yell()
	elseif self:CheckNearby(12, targetname) then--Near warning disabled on mythic, mythic mechanic requires being near it on purpose. Plus raid always stacked
		specWarnJumpSlamNear:Show(targetname)
	else
		warnJumpSlam:Show(targetname)--No reason to show this if you got a special warning. so reduce spam and display this only to let you know jump is far away and you're safe
	end
	self:BossTargetScanner(76973, "JumpTarget", 0.1, 80, true, nil, true, nil, targetname)
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.stamperDodgeCount = 0
	self.vb.bossUp = "NoBody"
--	self.vb.lastJumpTarget = "None"
	self.vb.firstJump = false
	timerSkullcrackerCD:Start(20-delay)
	timerJumpSlamCD:Start(20.5-delay)
	timerDisruptingRoarCD:Start(-delay)
	if self:IsMythic() then
		timerSmartStamperCD:Start(13-delay)
		countSmartStampers:Start(13-delay)
--		berserkTimer:Start(-delay)
	end
end

function mod:OnCombatEnd()

end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if args:IsSpellID(160838, 160845, 160847, 160848) then
		specWarnDisruptingRoar:Show()
		timerDisruptingRoarCD:Start()
		DBM:GetBossUnitId(args.sourceName)
		local _, _, _, _, startTime, endTime = UnitCastingInfo(DBM:GetBossUnitId(args.sourceName))
		local time = ((endTime or 0) - (startTime or 0)) / 1000
		if time then
			timerDisruptingRoar:Start(time)
		end
	elseif spellId == 153470 then
		warnSkullcracker:Show()
		timerSkullcrackerCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 157139 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId, "boss1") or self:IsTanking(uId, "boss2") then--Assume this can hit non tanks at landing site too, filter them
			local amount = args.amount or 1
			warnShatteredVertebrae:Show(args.destName, amount)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if (spellId == 156220 or spellId == 156883) and self.vb.bossUp == "NoBody" then--Tactical Retreat (156883 has lots of invalid casts, so self.vb.bossUp to filter)
		self.vb.phase = self.vb.phase + 1
		DBM:Debug("Tactical Retreat "..UnitName(uId)..". Phase:"..self.vb.phase)
		self.vb.stamperDodgeCount = 0
		self.vb.bossUp = UnitName(uId)
		local cid = self:GetCIDFromGUID(UnitGUID(uId))
		if cid == 76974 then--Fran
			timerDisruptingRoarCD:Cancel()
			timerSkullcrackerCD:Cancel()
		elseif cid == 76973 then--Hans
			timerJumpSlamCD:Cancel()
		end
		--The triggers are these percentages for sure but there is a delay before they do it so it always appears later, but the trigger has been triggered
		if self.vb.phase == 2 then--First belt 85% (15 Energy) (fire plates)
			specWarnSearingPlates:Show()
			voiceEnvironmentalThreats:Play("watchstep")
		elseif self.vb.phase == 3 then--Second belt 55% (45 Energy) (Stampers)
			specWarnStampers:Show()
			voiceEnvironmentalThreats:Play("watchstep")
		elseif self.vb.phase == 4 then--Second belt 25% (75 Energy) (Fire plates, then stampers)
			specWarnSearingPlates:Show()
			voiceEnvironmentalThreats:Play("watchstep")	
		end
	--"<944.72 23:32:59> [UNIT_SPELLCAST_SUCCEEDED] Hans'gar [[boss1:Crippling Suplex::0:156546]]", -- [5133]--Pre cast, Stuns main tank
	--"<948.55 23:33:03> [UNIT_SPELLCAST_SUCCEEDED] Hans'gar [[boss1:Crippling Suplex::0:156609]]", -- [5752]--Secondary target (off tank) no stun
	--"<951.15 23:33:06> [CLEU] SPELL_CAST_START#Vehicle-0-3783-1205-31925-76974-0000518B7D#Franzok##nil#156938#Crippling Suplex#nil#nil", -- [6168]--cast bar for damage
	--"<954.06 23:33:08> [CLEU] SPELL_CAST_SUCCESS#Vehicle-0-3783-1205-31925-76974-0000518B7D#Franzok#Player-76-0580DD5F#playerName#156938#Crippling Suplex#nil#nil", -- [6639]--SMASH (5.5 seconds after stun, VERY tight to cover attack with 6 second cd)
	--http://blue.mmo-champion.com/topic/360651-blackrock-foundry-clarification-known-issues/
	elseif spellId == 156546 or spellId == 156542 then
		specWarnCripplingSupplex:Schedule(6)--warn 3 seconds before, stun removed in 6.1
		timerCripplingSupplex:Start()
		countCripplingSupplex:Start()
	elseif spellId == 157926 then--Jump Activation
		self.vb.firstJump = false--So reset firstjump
--		self.vb.lastJumpTarget = "None"
		DBM:Debug("157926: Jump Activation")
		cachedGUID = UnitGUID(uId)
		timerJumpSlamCD:Start()
	elseif spellId == 157922 then--First jump must use 157922
		local temptarget = UnitName(uId.."target") or "nil"
		if not self.vb.firstJump then
			DBM:Debug("157922: firstJump true")
			self.vb.firstJump = true
			self:BossTargetScanner(76973, "JumpTarget", 0.1, 80, true, nil, false)--Don't include tank in first scan should be enough of a filter for first, it'll grab whatever first non tank target he gets and set that as first jump target and it will be valid
		else--Not first jump
			DBM:Debug("157922: firstJump false")
--			if self.vb.lastJumpTarget ~= "None" then--First jump succeeded
--				self:BossTargetScanner(76973, "JumpTarget", 0.1, 80, nil, nil, true, nil, self.vb.lastJumpTarget)--1.3 seconds worth of scans, because i've seen it take as long as 1.2 to get target, and yet, still faster than 157923 by 0.6 seconds. Most often, it finds target in 0.5 or less
--			else--Boss is recasting first jump because his first cast was interrupted by a stamper, so don't run filter and warn as soon as it finds a target, like first jump
--				DBM:Debug("157922: firstJump failed, initiating another first jump scan")
--				self:BossTargetScanner(76973, "JumpTarget", 0.1, 80, nil, nil, false)
--			end
		end
	elseif spellId == 157923 then--Fallback
		DBM:Debug("157923: mid air")
	elseif spellId == 157925 then--Jump Slam (this id seems to fire when ended)
		DBM:Debug("157925: jumps ended")
		self:BossTargetScannerAbort(76973, "JumpTarget")
	end
end

--Currently functional on 6.0.3. But yell method may still be needed in 6.1
function mod:UNIT_TARGETABLE_CHANGED(uId)
	DBM:Debug("UNIT_TARGETABLE_CHANGED event fired")
	if UnitExists(uId) then--Return, not retreat
		local cid = self:GetCIDFromGUID(UnitGUID(uId))
		if cid == 76973 then--Hansgar
			timerJumpSlamCD:Start(6.8)
		end
		self.vb.bossUp = "NoBody"
		if self.vb.phase == 4 then--Stampers activate on their own after 3rd jump away, when they return.
			specWarnStampers:Show()
			voiceEnvironmentalThreats:Play("watchstep")
		else
			if self.vb.phase == 2 then
				specWarnSearingPlatesEnd:Show()
				if self:IsMythic() then
					timerSmartStamperCD:Start()
					countSmartStampers:Start()
					voiceEnvironmentalThreats:Play("gather")--Must restack for smart stampers
				else
					voiceEnvironmentalThreats:Play("safenow")
				end
			else
				specWarnStampersEnd:Show()
				if self:IsMythic() then
					timerSmartStamperCD:Start()
					countSmartStampers:Start()
					voiceEnvironmentalThreats:Play("gather")--Must restack for smart stampers
				else
					voiceEnvironmentalThreats:Play("safenow")
				end
			end
		end
	end
end
