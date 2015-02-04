local mod	= DBM:NewMod(1147, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(76906)--81315 Crack-Shot, 81197 Raider, 77487 Grom'kar Firemender, 80791 Grom'kar Man-at-Arms, 81318 Iron Gunnery Sergeant, 77560 Obliterator Cannon, 81612 Deforester
mod:SetEncounterID(1692)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 160140 163753",
	"SPELL_CAST_SUCCESS 155864",
	"SPELL_AURA_APPLIED 155921 159481 165195",
	"SPELL_AURA_APPLIED_DOSE 155921",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_YELL"
)

--TODO, maybe range finder for when Man-at_arms is out (reckless Charge)
--TODO, train timers, as well as what mobs get off with each train.
--TODO, mythic "move out of fire" warnings and maybe cast warnings too
--TODO, add audio countdown for trains when the train timers are proven good and support whole fight.
--Operator Thogar
local warnProtoGrenade				= mod:NewSpellAnnounce(155864, 3)
local warnEnkindle					= mod:NewStackAnnounce(155921, 2, nil, "Tank")
local warnTrain						= mod:NewCountAnnounce(176312, 4)--Switch from generic and make informing one when mythicTrains (and non mythic trains too) are more populated.
--Adds
local warnDelayedSiegeBomb			= mod:NewTargetAnnounce(159481, 3)

--Operator Thogar
local specWarnProtoGrenade			= mod:NewSpecialWarningMove(165195, nil, nil, nil, nil, nil, 2)
local specWarnEnkindle				= mod:NewSpecialWarningStack(155921, nil, 2)--Maybe need 3 for new cd?
local specWarnEnkindleOther			= mod:NewSpecialWarningTaunt(155921)
--Adds
local specWarnCauterizingBolt		= mod:NewSpecialWarningInterrupt(160140, not "Healer")
local specWarnIronbellow			= mod:NewSpecialWarningSpell(163753, nil, nil, nil, 2)
local specWarnDelayedSiegeBomb		= mod:NewSpecialWarningYou(159481)
local yellDelayedSiegeBomb			= mod:NewYell(159481)
local specWarnManOArms				= mod:NewSpecialWarningSwitch("ej9549", "-Healer")
--local specWarnObliteration		= mod:NewSpecialWarningMove(156494)--Debuff doesn't show in combat log, and dot persists after moving out of it so warning is pretty useless right now. TODO, see if UNIT_AURA player type check can work.

--Operator Thogar
local timerProtoGrenadeCD			= mod:NewCDTimer(12, 155864)
local timerEnkindleCD				= mod:NewCDTimer(12, 155921, nil, "Tank")
local timerTrainCD					= mod:NewNextCountTimer("d15", 176312)
--Adds
--local timerCauterizingBoltCD		= mod:NewNextTimer(30, 160140)
local timerIronbellowCD				= mod:NewCDTimer(12, 163753)

local countdownTrain				= mod:NewCountdown(5, 176312)

local voiceTrain					= mod:NewVoice(176312) --see mythicVoice{} otherVoice{} tables for more details
local voiceProtoGrenade				= mod:NewVoice(165195) --runaway

mod.vb.trainCount = 0
local Train = GetSpellInfo(174806)
local Cannon = GetSpellInfo(62357)
local Reinforcements = EJ_GetSectionInfo(9537)
local ManOArms = EJ_GetSectionInfo(9549)
local Deforester = EJ_GetSectionInfo(10329)

--Crap code. I lack patience or time to do it cleaner.
--Note, all trains spawn 5 second after yell for that train
--this means that for 5 second cd trains you may see a yell for NEXT train as previous train is showing up. Do not confuse this!
--Also be aware that older beta videos are worng, blizz has changed train orders few times, so don't try to fill in missing data by putting "thogar" into youtube unless it's a RECENT video.
local mythicTrains = {
	[1] = ManOArms.." (4)",--+7 after pull
	[2] = Deforester.." (1)",--+5 after 1
	[3] = Train.." (2)",--+5 after 2.
	[4] = Train.." (3)",--+15 after 3.
	[5] = Train..L.threeTrains,--+15 after 4
	[6] = Cannon.." (1, 4)",--+15 after 5
	[7] = Train.." (2)",--+5 after 6.
	[8] = Train.." (3)",--+5 after 7.
	[9] = Train.." (2)",--+15 after 8.
	[10] = Reinforcements.." (2, 3)",--+20 after 9
	[11] = Train.." (1, 4)",--+15 after 10.
	[12] = Train.." (2, 4)",--+15 after 11
	[13] = UNKNOWN,--+15/20? after 12
}
--[[ All non mythic difficulties
		["DBM_Announce"] = {
			"<224.82 22:56:55> DBM_Announce#Moving Train (1)", -- [1]
			"<234.85 22:57:05> DBM_Announce#Moving Train (2)", -- [2]
			"<239.89 22:57:10> DBM_Announce#Moving Train (3)", -- [3]
			"<254.87 22:57:25> DBM_Announce#Moving Train (4)", -- [4]
			"<259.91 22:57:30> DBM_Announce#Moving Train (5)", -- [5]
			"<284.87 22:57:55> DBM_Announce#Moving Train (6)", -- [7]
			"<289.82 22:58:00> DBM_Announce#Moving Train (7)", -- [9]
			"<314.82 22:58:25> DBM_Announce#Moving Train (8)", -- [13]
			--329 Fake 9
			"<369.91 22:59:20> DBM_Announce#Moving Train (10)", -- [17]
			"<379.89 22:59:30> DBM_Announce#Moving Train (11)", -- [19]
			"<394.83 22:59:45> DBM_Announce#Moving Train (12)", -- [21]
			"<404.89 22:59:55> DBM_Announce#Moving Train (13)", -- [23]
			"<425.01 23:00:15> DBM_Announce#Moving Train (14)", -- [24]
			"<434.90 23:00:25> DBM_Announce#Moving Train (15)", -- [25]
			"<444.83 23:00:35> DBM_Announce#Moving Train (16)", -- [26]
			"<459.89 23:00:50> DBM_Announce#Moving Train (17)", -- [28]
			"<479.90 23:01:10> DBM_Announce#Moving Train (18)", -- [31]
			--484 Fake 19
			"<514.97 23:01:45> DBM_Announce#Moving Train (20)", -- [40]
			"<524.91 23:01:55> DBM_Announce#Moving Train (21)", -- [41]
			"<549.90 23:02:20> DBM_Announce#Moving Train (22)", -- [47]
			"<579.88 23:02:50> DBM_Announce#Moving Train (23)", -- [50]
			"<594.86 23:03:05> DBM_Announce#Moving Train (24)", -- [52]
			"<614.86 23:03:25> DBM_Announce#Moving Train (25)", -- [55]
		},
--]]
local otherTrains = {
	[1] = Train.." (4)",--+12 after pull
	[2] = Train.." (2)",--+10 after 1
	[3] = Reinforcements.." (1)",--+5 after 2
	[4] = Train.." (3)",--+15 after 3
	[5] = Cannon.." (4)",--+5 after 4
	[6] = Train.." (2)",--+25 after 5
	[7] = ManOArms.." (3)",--+5 after 6
	[8] = Train.." (1)",--+25 after 7
	--WARNING, Train 9 does not fire a yell
	[9] = Reinforcements.." (2) "..Reinforcements.." (3)",--+15 after 8
	--WARNING, Train 9 does not fire a yell
	[10] = Train.." (1, 4)",--+40 after 9
	[11] = Cannon.." (1)",--+10 after 10
	[12] = Train.." (2)",--+15 after 11
	[13] = Reinforcements.." (4)",--+10 after 12
	[14] = Train.." (3)",--+20 after 13
	[15] = Train.." (2)",--+10 after 14
	[16] = Train.." (1)",--+10 after 15
	[17] = ManOArms.." (2) "..Cannon.." (4)",--+15 after 16
	[18] = Train.." (1)",--+20 after 17
	--WARNING, Train 19 does not fire a yell
	[19] = Train.." (3)",--+5 after 18
	--WARNING, Train 19 does not fire a yell
	[20] = Cannon.." (1, 4)",--+30 after 19
	[21] = Train.." (2)",--+10 after 20
	[22] = Train.." (2)",--+25 after 21
	[23] = Reinforcements.." (2) "..ManOArms.." (3)",--+30 after 22
	[24] = Train,--+15 after 23 (random train, seen 3 and 4 diff pulls)
	[25] = Train.." (1)",--+20 after 24 (Possibly also random?)
	[26] = Reinforcements.." (1, 4)",--+20 after 25
}

local function fakeTrainYell(self)
	self:CHAT_MSG_MONSTER_YELL("Fake", nil, nil, nil, Train)
	DBM:Debug("Fake yell fired, Boss skipped a yell?")
end

--  Voicelist
--	A: just rushing through the lane(express)
--	B: small Adds(Reinforcements)
--	C: cannon
--	D: big Adds (ManOArms)
--	E: fire(Deforester) 
--	F: random express (3x trainType A)
--	X: random rail

local mythicVoice = {
	[1] = "D4",
	[2] = "E1",
	[3] = "A2",
	[4] = "A3",
	[5] = "F",
	[6] = "CX",
	[7] = "A2",
	[8] = "A3",
	[9] = "A2",
	[10] = "BX",
	[11] = "A14",
	[12] = "F"
}

local otherVoice = {
	[1] = "A4",
	[2] = "A2",
	[3] = "B1",
	[4] = "A3",
	[5] = "C4",
	[6] = "A2",
	[7] = "D3",
	[8] = "A1",
	[9] = "B23",
	[10] = "A14",
	[11] = "C1",
	[12] = "A2",
	[13] = "B4",
	[14] = "A3",
	[15] = "A2",
	[16] = "A1",
	[17] = "D2C4",
	[18] = "A1",
	[19] = "A3",
	[20] = "C14",
	[21] = "A2",
	[22] = "A2",
	[23] = "B2D3",
	[24] = "AX",
	[25] = "A1",--Possibly also random?
	[26] = "B14",
}

function mod:OnCombatStart(delay)
	self.vb.trainCount = 0
	timerProtoGrenadeCD:Start(6-delay)
	timerEnkindleCD:Start(15-delay)
	if not self.Options.ShowedThogarMessage then
		DBM:AddMsg(L.helperMessage)
		self.Options.ShowedThogarMessage = true
	end
	if self:IsMythic() then
		timerTrainCD:Start(12-delay, 1)
	else
		timerTrainCD:Start(17-delay, 1)
	end
end

function mod:OnCombatEnd()

end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 155864 then
		warnProtoGrenade:Show()
		timerProtoGrenadeCD:Start()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 160140 then
		specWarnCauterizingBolt:Show(args.sourceName)
	elseif spellId == 163753 then
		if self:AntiSpam() then
			specWarnIronbellow:Show()
		end
		timerIronbellowCD:Start(12, args.sourceGUID)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 155921 then
		local amount = args.amount or 1
		warnEnkindle:Show(args.destName, amount)
		timerEnkindleCD:Start()
		if amount >= 2 then
			if args:IsPlayer() then
				specWarnEnkindle:Show(amount)
			else--Taunt as soon as stacks are clear, regardless of stack count.
				if not UnitDebuff("player", GetSpellInfo(155921)) and not UnitIsDeadOrGhost("player") then
					specWarnEnkindleOther:Show(args.destName)
				end
			end
		end
	elseif spellId == 159481 then
		warnDelayedSiegeBomb:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnDelayedSiegeBomb:Show()
			yellDelayedSiegeBomb:Yell()
		end
	elseif spellId == 165195 and args:IsPlayer() then
		specWarnProtoGrenade:Show()
		voiceProtoGrenade:Play("runaway")
--[[	elseif spellId == 156494 and args:IsPlayer() and self:AntiSpam() then
		specWarnObliteration:Show()--]]
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 80791 then
		timerIronbellowCD:Cancel(args.destGUID)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg, npc, _, _, target)
	if target == Train then
		self:Unschedule(fakeTrainYell)--Always unschedule
		self.vb.trainCount = self.vb.trainCount + 1
		local count = self.vb.trainCount
		warnTrain:Show(count)
		countdownTrain:Start()--All trains are delayed 5 seconds from yell now, so we can just put 5 second countdown here.
		if self:IsMythic() then
			if mythicVoice[count] then
				voiceTrain:Play("Thogar\\"..mythicVoice[count])
			end
			if count >= 12 then
				print("Train Set: "..count..". DBM has no train data beyond this point. Write down lane(s) trains come from in 5 seconds with train set number and give it to us")
				return
			end
			--+5 added to all timers so timers are for train coming down the lane.
			--yes this means sometimes two timers up at a time instead of one. this is fine, fight doesn't have many timers.
			local expectedTime
			if count == 1 or count == 2 or count == 6 or count == 7 then
				expectedTime = 5
			elseif count == 9 then
				expectedTime = 20
			else
				expectedTime = 15
			end
			if expectedTime then
				if msg == "Fake" then expectedTime = expectedTime - 2.5 end
				timerTrainCD:Schedule(5, expectedTime, count+1)
				self:Schedule(expectedTime+2.5, fakeTrainYell, self)--Schedule fake yell 2.5 seconds after we should have seen one.
			else
				timerTrainCD:Start(count)
			end
			if count == 1 then--I'm sure they spawn again sometime later, find that data
				specWarnManOArms:Show()
			end
		else
			if otherVoice[count] then
				voiceTrain:Play("Thogar\\"..otherVoice[count])
			end
			if count >= 23 then
				print("Train Set: "..count..". DBM has no train data beyond this point. Write down lane(s) trains come from in 5 seconds with train set number and give it to us")
				return
			end
			--Next Train 5 seconds after: 2, 4, 6, 18
			--Next Train 10 seconds after: 1, 10, 14, 15, 20
			--Next Train 15 seconds after: 3, 8, 11, 16
			--Next Train 20 seconds after: 13, 17, 24
			--Next Train 25 seconds after: 5, 7, 21
			--Next Train 30 seconds after: 19
			--Next Train 40 seconds after: 9
			local expectedTime
			if count == 2 or count == 4 or count == 6 or count == 18 then
				expectedTime = 5
			elseif count == 1 or count == 10 or count == 14 or count == 15 or count == 20 or count == 23 then
				expectedTime = 10
			elseif count == 3 or count == 8 or count == 11 or count == 16 then
				expectedTime = 15
			elseif count == 13 or count == 17 or count == 24 then
				expectedTime = 20
			elseif count == 5 or count == 7 or count == 21 then
				expectedTime = 25
			elseif count == 19 or count == 22 then
				expectedTime = 30
			elseif count == 9 then
				expectedTime = 40
			end
			if expectedTime then
				if msg == "Fake" then expectedTime = expectedTime - 2.5 end
				timerTrainCD:Schedule(5, expectedTime, count+1)--Show timer for next train from current yell (previous yell already has timer for yell this train is for so no 5 second timer needed)
				self:Schedule(expectedTime+2.5, fakeTrainYell, self)--Schedule fake yell 2.5 seconds after we should have seen one.
			else
				timerTrainCD:Start(5, count)--Show timer for incoming train for current yell if we have no data for next
			end
			if count == 7 or count == 17 or count == 23 then--I'm sure they spawn again sometime later, find that data
				specWarnManOArms:Show()
			end
		end
	end
end
