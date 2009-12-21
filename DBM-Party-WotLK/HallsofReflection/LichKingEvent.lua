local mod = DBM:NewMod("LichKingEvent", "DBM-Party-WotLK", 16)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2153 $"):sub(12, -3))
mod:SetCreatureID(37226, 36954)--Both creature Ids used in Halls of Reflection

mod:RegisterCombat("yell", L.CombatStart)
mod:RegisterKill("yell", L.YellCombatEnd)
mod:SetMinCombatTime(480)-- if you wipe, pull yell happens as soon as you zone back in despite the event not actually being started until you tell jaina you're ready to try again. This is only way to hack around this so mod doesn't wipe you for not being in combat after yell.
--The above also makes an achievement timer not possible. It would be right first pull but any pull after a wipe there is no way at all to detect when real event is started
mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

local WarnWave1	= mod:NewAnnounce("WarnWave1", 2, nil, nil)
local WarnWave2	= mod:NewAnnounce("WarnWave2", 2, nil, nil)
local WarnWave3	= mod:NewAnnounce("WarnWave3", 2, nil, nil)
local WarnWave4	= mod:NewAnnounce("WarnWave4", 2, nil, nil)
mod:AddBoolOption("ShowWaves", true, "announce")

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