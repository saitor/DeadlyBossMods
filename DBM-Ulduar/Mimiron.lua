local mod = DBM:NewMod("Mimiron", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 694 $"):sub(12, -3))
mod:SetCreatureID(33350)
mod:SetZone()

mod:RegisterCombat("combat")


--mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_AURA_REMOVED"
)

local isMelee = select(2, UnitClass("player")) == "ROGUE"
	     or select(2, UnitClass("player")) == "WARRIOR"
	     or select(2, UnitClass("player")) == "DEATHKNIGHT"

mod:AddBoolOption("PlaySoundOnShockBlast", isMelee, "announce")
mod:AddBoolOption("PlaySoundOnDarkGlare", true, "announce")

local warnShockBlast		= mod:NewSpecialWarning("WarningShockBlast", isMelee)
local timerProximityMines	= mod:NewTimer(35, "ProximityMines", 63027)

local timerDarkGlareCast	= mod:NewTimer(15, "DarkGlare", 63274)
local timerNextDarkGlare	= mod:NewTimer(41, "NextDarkGlare", 63274)
local warnDarkGlare			= mod:NewSpecialWarning("DarkGlare")

local timerP1toP2		= mod:NewTimer(30, "TimeToP2")
local timerSpinUp		= mod:NewTimer(4, "SpinUp", 63414)

local phase = 0 

function mod:OnCombatStart(delay)
	phase = 1
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 63631 then
		warnShockBlast:Show()

		if self.Options.PlaySoundOnShockBlast then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 63027 then		-- mines
		timerProximityMines:Start()

	elseif args.spellId == 63414 then	-- Spinning UP (before DarkGlare)
		timerSpinUp:Start()
		timerDarkGlareCast:Schedule(4)
		timerNextDarkGlare:Schedule(19)	-- 4 (cast spinup) + 15 sec (cast darkglare)
		warnDarkGlare:Show()

		if self.Options.PlaySoundOnDarkGlare then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	self:AddMsg(msg)
	if msg == L.YellPhase2 then
		phase = 2
		timerProximityMines:Stop()
		timerP1toP2:Start()

	elseif msg == L.YellPhase3 then
		phase = 3
		timerDarkGlare:Stop()
	end
end

do 
	local count = 0
	local last = 0
	function mod:SPELL_AURA_REMOVED(args)
		if phase == 1 and self:GetCIDFromGUID(args.destGUID) == 33432 then
			if args.timestamp == last then	-- all events in the same second
				count = count + 1

				if count > 20 then
					DBM:AddMsg("Phase1 ENDE detected")
					DBM:AddMsg("Phase1 ENDE detected")
					DBM:AddMsg("Phase1 ENDE detected")
					DBM:AddMsg("Phase1 ENDE detected")
					DBM:AddMsg("Phase1 ENDE detected")
				end
			else
				count = 1
			end
			last = args.timestamp
		end
	end
end



