local mod = DBM:NewMod("LichKingEvent", "DBM-Party-WotLK", 16)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2153 $"):sub(12, -3))
mod:SetCreatureID(37226, 36954)--Both creature Ids used in Halls of Reflection

if UnitFactionGroup("player") == "Alliance" then
	mod:RegisterCombat("yell", L.ACombatStart)
else
	mod:RegisterCombat("yell", L.HCombatStart)
end

mod:RegisterKill("yell", L.YellCombatEnd)--Combat does not end for another 8 or so seconds after this yell (for achievement credit). Not sure how to go about fixing this yet.
--[[			"<473.2> [MONSTER_YELL] CHAT_MSG_MONSTER_YELL:FIRE! FIRE!:High Captain Justin Bartlett:::::0:0::0:2277::", -- [9219]
				"<481.6> [CAST_SUCCEEDED] The Lich King:Achievement Check::0:", -- [9224]
				"<481.7> [WORLD_STATE] |0:0:Spirit Wave = 0/10:::Number of Spirit waves encountered.:::0:0:0:", -- [9225]
				"<482.1> [REGEN_ENABLED]  -- < Regen Enabled : Leaving combat! -- < ", -- [9226]--]]

mod:SetMinCombatTime(120)--Dirty Hack to engage mod after a wipe on zonein and keep it engaged. if you wipe, pull yell happens as soon as you zone back in despite the event not actually being started until you tell jaina/sylvanas you're ready to try again. This is only way to hack around this so mod doesn't wipe you for not being in combat after yell.
--The above also makes an achievement timer not possible on pull.
mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

local WarnWave1	= mod:NewAnnounce("WarnWave1", 2, nil, nil, false)
local WarnWave2	= mod:NewAnnounce("WarnWave2", 2, nil, nil, false)
local WarnWave3	= mod:NewAnnounce("WarnWave3", 2, nil, nil, false)
local WarnWave4	= mod:NewAnnounce("WarnWave4", 2, nil, nil, false)
mod:AddBoolOption("ShowWaves", true, "announce")

local timerEscape	= mod:NewAchievementTimer(344, 4526, "achievementEscape")--Time adjusted as it cannot be started on pull detection has to be started with first add wave.

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Wave1 or msg:find(L.Wave1) then
		self:SendSync("Wave1")
	elseif msg == L.Wave2 or msg:find(L.Wave2) then
		self:SendSync("Wave2")
	elseif msg == L.Wave3 or msg:find(L.Wave3) then
		self:SendSync("Wave3")
	elseif msg == L.Wave4 or msg:find(L.Wave4) then
		self:SendSync("Wave4")
	end
end

function mod:OnSync(msg, arg)
	if msg == "Wave1" then
		if mod:IsDifficulty("heroic5") then
			timerEscape:Start()
		end
		if self.Options.ShowWaves then
			WarnWave1:Show()
		end
	elseif msg == "Wave2" then
		if self.Options.ShowWaves then
			WarnWave2:Show()
		end
	elseif msg == "Wave3" then
		if self.Options.ShowWaves then
			WarnWave3:Show()
		end
	elseif msg == "Wave4" then
		if self.Options.ShowWaves then
			WarnWave4:Show()
		end
	end
end