local mod = DBM:NewMod("Thorim", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(32865)
mod:SetZone()

mod:RegisterCombat("yell", L.YellPhase1)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_CAST_SUCCESS"
)

local timerStormhammer		= mod:NewTimer(16, "TimerStormhammer", 62042)
local timerUnbalancingStrike	= mod:NewTimer(15, "TimerUnbalancingStrike", 62130)
local timerHardmode		= mod:NewTimer(189, "TimerHardmode", 62042)

local warnStormhammer		= mod:NewAnnounce("WarningStormhammer", 2, 62470)
local warnUnbalancingStrike	= mod:NewAnnounce("UnbalancingStrike", 4, 62130)	-- nice blizzard, very new stuff, hmm or not? ^^ aq40 4tw :)
local warnPhase2			= mod:NewAnnounce("WarningPhase2", 1)

local enrageTimer		= mod:NewEnrageTimer(309)

function mod:OnCombatStart(delay)
	enrageTimer:Start()
	timerHardmode:Start()
end

function mod:OnCombatEnd()
	enrageTimer:Stop()
	timerHardmode:Stop()
end

--[[ unbalancing strike
3/17 20:19:19.431  SPELL_CAST_SUCCESS,0xF13000806100D018,"Thorim",0x10a48,0x01000000007BB1B6,"Corsicaxd",0x514,62130,"Unbalancing Strike",0x1
3/17 20:19:46.325  SPELL_CAST_SUCCESS,0xF13000806100D018,"Thorim",0xa48,0x01000000007CE3AF,"Mârilyn",0x10514,62130,"Unbalancing Strike",0x1
3/17 20:20:11.266  SPELL_CAST_SUCCESS,0xF13000806100D018,"Thorim",0xa48,0x01000000007CE3AF,"Mârilyn",0x514,62130,"Unbalancing Strike",0x1
3/17 20:20:36.981  SPELL_CAST_SUCCESS,0xF13000806100D018,"Thorim",0x10a48,0x01000000007BB1B6,"Corsicaxd",0x514,62130,"Unbalancing Strike",0x1
3/17 20:20:57.870  SPELL_CAST_SUCCESS,0xF13000806100D018,"Thorim",0xa48,0x01000000007CE3AF,"Mârilyn",0x514,62130,"Unbalancing Strike",0x1
3/17 20:21:19.891  SPELL_CAST_SUCCESS,0xF13000806100D018,"Thorim",0xa48,0x01000000007CE3AF,"Mârilyn",0x514,62130,"Unbalancing Strike",0x1
3/17 20:21:43.609  SPELL_CAST_SUCCESS,0xF13000806100D018,"Thorim",0xa48,0x01000000007BB1B6,"Corsicaxd",0x514,62130,"Unbalancing Strike",0x1
3/17 20:22:05.700  SPELL_CAST_SUCCESS,0xF13000806100D018,"Thorim",0x10a48,0x01000000007CE3AF,"Mârilyn",0x514,62130,"Unbalancing Strike",0x1
3/17 20:22:37.850  SPELL_CAST_SUCCESS,0xF13000806100D018,"Thorim",0xa48,0x01000000007DDA8E,"Sadai",0x10514,62130,"Unbalancing Strike",0x1
]]--

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 62042 then -- Storm Hammer
		timerStormhammer:Start()
		warnStormhammer:Show(args.destName)

	elseif args.spellId == 62130 then	-- Unbalancing Strike
		warnUnbalancingStrike:Show(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 62130 then	-- Unbalancing Strike
		timerUnbalancingStrike:Start(21)
	end
end


function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellPhase2 then		-- Bossfight (tank and spank)
		self:SendSync("Phase2")
	end
end

function mod:OnSync(event, arg)
	if event == "Phase2" then
		warnPhase2:Show()
		enrageTimer:Stop()
		timerHardmode:Stop()
	end
end



