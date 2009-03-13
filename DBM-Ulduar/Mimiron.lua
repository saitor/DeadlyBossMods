local mod = DBM:NewMod("Mimiron", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 694 $"):sub(12, -3))
mod:SetCreatureID(33350) -- Mob ID Required!
mod:SetZone()

mod:RegisterCombat("combat")


--mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED"
)

local isMelee = select(2, UnitClass("player")) == "ROGUE"
or select(2, UnitClass("player")) == "WARRIOR"
or select(2, UnitClass("player")) == "DEATHKNIGHT"

mod:AddBoolOption("PlaySoundOnShockBlast", isMelee, "announce")
mod:AddBoolOption("PlaySoundOnDarkGlare", true, "announce")

local warnShockBlast		= mod:NewSpecialWarning("WarningShockBlast", isMelee)
local timerProximityMines	= mod:NewTimer(40, "ProximityMines")

local timerDarkGlare		= mod:NewTimer(15, "DarkGlare")
local timerNextDarkGlare		= mod:NewTimer(65, "NextDarkGlare")
local warnDarkGlare		= mod:NewSpecialWarning("DarkGlare")

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
	if args.spellId == 63027 then	-- mines
		timerProximityMines:Start()
	end
end

local spam = 0
function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 63274 and GetTime() - spam > 3 then
		spam = GetTime()
		timerDarkGlare:Start()
		timerNextDarkGlare:Schedule(15)
		warnDarkGlare:Show()
		if self.Options.PlaySoundOnDarkGlare then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end
	end
end





