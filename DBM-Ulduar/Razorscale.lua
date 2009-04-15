local mod = DBM:NewMod("Razorscale", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(33186)
mod:SetZone()


mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)

local specWarnDevouringFlame	= mod:NewSpecialWarning("SpecWarnDevouringFlame")
local timerDeepBreathCooldown	= mod:NewTimer(21, "timerDeepBreathCooldown", 64021)
local timerDeepBreathCast		= mod:NewTimer(2.5, "timerDeepBreathCast", 64021)
local timerAllTurretsReady		= mod:NewTimer(115, "timerAllTurretsReady") -- todo: icon?
local warnTurretsReadySoon		= mod:NewAnnounce("warnTurretsReadySoon", 1)
local warnTurretsReady			= mod:NewAnnounce("warnTurretsReady", 3)

mod:AddBoolOption("PlaySoundOnDevouringFlame", false, "announce")


function mod:OnCombatStart(delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 63816 and args.destName == UnitName("player") then		-- you are standing in Devouring Flame
		specWarnDevouringFlame:Show()
		if self.Options.PlaySoundOnDevouringFlame then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end		
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg, mob)
	if msg == L.YellAir then
		timerAllTurretsReady:Start()
		warnTurretsReadySoon:Schedule(95)
		warnTurretsReady:Schedule(115)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 64021 then	-- deep breath
		timerDeepBreathCast:Start()
		timerDeepBreathCooldown:Start()
	end
end

