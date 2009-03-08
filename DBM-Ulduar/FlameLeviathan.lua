local mod = DBM:NewMod("FlameLeviathan", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 679 $"):sub(12, -3))

mod:SetZone()

mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE"
)

local guids = {}
stats = {}

local function buildGuidTable()
	table.wipe(guids)
	for i = 1, GetNumRaidMembers() do
		guids[UnitGUID("raid"..i.."pet") or ""] = UnitName("raid"..i)
	end
end

function mod:OnCombatStart(delay)
	buildGuidTable()
	table.wipe(stats)
end

function mod:SPELL_CAST_SUCCESS(args)
	local player = guids[args.sourceGUID]
	if player and args.spellId == 62363 then
		if not stats[player] then
			stats[player] = {kills = 0, hits = 0, casts = 0, player = player}
		end
		stats[player].casts = stats[player].casts + 1
	end
end

function mod:SPELL_DAMAGE(args)
	local player = guids[args.sourceGUID]
--	print(args.destGUID, self:GetCIDFromGUID(args.destGUID), 33214, args.spellId, player)
	if player and args.spellId == 62363  and self:GetCIDFromGUID(args.destGUID) == 33214 then
		if not stats[player] then
			stats[player] = {kills = 0, hits = 0, casts = 0, player = player}
		end
		stats[player].hits = stats[player].hits + 1
		if args.overkill then
			stats[player].kills = stats[player].kills + 1
		end
	end
end

function mod:PrintStats()
	for i, v in pairs(stats) do
		SendChatMessage(("%%d. %s: %d kills (accuracy: %.2f%%)"):format(v.player, v.kills, v.casts / v.hits), "RAID")
	end
end

