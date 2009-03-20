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
	"CHAT_MSG_MONSTER_YELL"
)

local isMelee = select(2, UnitClass("player")) == "ROGUE"
	     or select(2, UnitClass("player")) == "WARRIOR"
	     or select(2, UnitClass("player")) == "DEATHKNIGHT"

mod:AddBoolOption("PlaySoundOnShockBlast", isMelee, "announce")
mod:AddBoolOption("PlaySoundOnDarkGlare", true, "announce")

local warnShockBlast		= mod:NewSpecialWarning("WarningShockBlast", isMelee)
local timerProximityMines	= mod:NewTimer(35, "ProximityMines", 63027)

local timerDarkGlareCast	= mod:NewTimer(15, "DarkGlare", 63274)
local timerNextDarkGlare	= mod:NewTimer(60, "NextDarkGlare", 63274)
local warnDarkGlare		= mod:NewSpecialWarning("DarkGlare")

local timerP1toP2		= mod:NewTimer(30, "TimeToP2")
local timerSpinUp		= mod:NewTimer(4, "SpinUp", 63414)

function mod:OnCombatStart(delay)
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
	if msg == L.YellPhase2 then
		timerProximityMines:Stop()
		timerP1toP2:Start()
	elseif msg == L.YellPhase3 then
		timerDarkGlare:Stop()
	end
end






