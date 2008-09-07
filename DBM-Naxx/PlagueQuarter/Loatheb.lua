local mod = DBM:NewMod("Loatheb", "DBM-Naxx", 3)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(16011)
mod:SetZone(GetAddOnMetadata("DBM-Naxx", "X-DBM-Mod-LoadZone"))

mod:RegisterCombat("combat")

--[[
9/6 21:49:24.875  SPELL_CAST_SUCCESS,0xF130003E8B005E06,"Loatheb",0xa48,0x0000000000000000,nil,0x80000000,29234,"Summon Spore",0x1
9/6 21:50:00.671  SPELL_CAST_SUCCESS,0xF130003E8B005E06,"Loatheb",0xa48,0x0000000000000000,nil,0x80000000,29234,"Summon Spore",0x1 36
9/6 21:50:36.781  SPELL_CAST_SUCCESS,0xF130003E8B005E06,"Loatheb",0xa48,0x0000000000000000,nil,0x80000000,29234,"Summon Spore",0x1 36
9/6 21:51:12.218  SPELL_CAST_SUCCESS,0xF130003E8B005E06,"Loatheb",0xa48,0x0000000000000000,nil,0x80000000,29234,"Summon Spore",0x1 36
9/6 21:51:48.296  SPELL_CAST_SUCCESS,0xF130003E8B005E06,"Loatheb",0xa48,0x0000000000000000,nil,0x80000000,29234,"Summon Spore",0x1 36

]]--

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS"
)

local warnSporeNow	= mod:NewAnnounce("WarningSporeNow", 2, 32329)
local warnSporeSoon	= mod:NewAnnounce("WarningSporeSoon", 1, 32329)
local warnDoomNow	= mod:NewAnnounce("WarningDoomNow", 3, 29204)
local warnHealSoon	= mod:NewAnnounce("WarningHealSoon", 4, 48071)
local warnHealNow	= mod:NewAnnounce("WarningHealNow", 1, 48071, false)


local timerSpore		= mod:NewTimer(36, "TimerSpore", 32329)
local timerDoom			= mod:NewTimer(180, "TimerDoom", 29204)
local timerAura			= mod:NewTimer(17, "TimerAura", 55593)

local doomCounter = 0

function mod:OnCombatStart(delay)
	doomCounter = 0
	timerSpore:Start(36 - delay)
	warnSporeSoon:Schedule(31 - delay)
	timerDoom:Start(120 - delay, doomCounter + 1)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 29234 then
		timerSpore:Start()
		warnSporeNow:Show()
		warnSporeSoon:Schedule(31)		
	elseif args.spellId == 29204 then
		doomCounter = doomCounter + 1
		local timer = 30
		if doomCounter >= 7 then
			if doomCounter % 2 == 0 then timer = 17
			else timer = 12 end
		end
		warnDoomNow:Show(doomCounter)
		timerDoom:Start(timer, doomCounter + 1)
	elseif args.spellId == 55593 then
		timerAura:Start()
		warnHealSoon:Schedule(14)
		warnHealNow:Schedule(17)
	end
end

