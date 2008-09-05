-- *********************************************************
-- **               Deadly Boss Mods - Core               **
-- **            http://www.deadlybossmods.com            **
-- *********************************************************
--
-- This addon is written and copyrighted by:
--    * Paul Emmerich (Tandanu @ EU-Aegwynn)
--    * Martin Verges (Nitram @ EU-Azshara)
-- 
-- The localizations are written by:
--    * deDE: Tandanu/Nitram
--    * (add your names here!)
--
-- 
-- This work is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License. (see license.txt)
--
--  You are free:
--    * to Share � to copy, distribute, display, and perform the work
--    * to Remix � to make derivative works
--  Under the following conditions:
--    * Attribution. You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work).
--    * Noncommercial. You may not use this work for commercial purposes.
--    * Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under the same or similar license to this one.


-------------------------------
--  Globals/Default Options  --
-------------------------------
DBM = {
	revision = ("$Revision$"):sub(12, -3),
	version = "4.00",
	displayVersion = "4.01"
}

DBM_SavedOptions = {}
DBM_SavedModOptions = {}
DBM_Stats = {}

DBM.DefaultOptions = {
	WarningColors = {
		{r = 0.41, g = 0.80, b = 0.94},
		{r = 0.95, g = 0.95, b = 0.00},
		{r = 1.00, g = 0.50, b = 0.00},
		{r = 1.00, g = 0.10, b = 0.10},
	},
	WarningPosition = {
		Point = "TOP",
		X = 0,
		Y = -192,
	},
	StatusEnabled = true,
	Enabled = true,
	ShowWarningsInChat = true,
	ShowFakedRaidWarnings = true,
	WarningIconLeft = true,
	WarningIconRight = true,
}

DBM.Bars = DBT:New()
DBM.Mods = {}

--------------
--  Locals  --
--------------
local inCombat = {}
local combatInfo = {}
local updateFunctions = {}
local modSyncSpam = {}
local chatPrefix = "<Deadly Boss Mods> "
local chatPrefixShort = "<DBM> "
local mainFrame = CreateFrame("Frame")
local schedule
local unschedule
local loadOptions
local loadModOptions

local function checkEntry(t, val)
	for i, v in ipairs(t) do
		if v == val then
			return true
		end
	end
	return nil
end

local function removeEntry(t, val)
	local existed = false
	for i = #t, 1, -1 do
		if t[i] == val then
			table.remove(t, i)
			existed = true
		end
	end
	return existed
end

local function sendSync(prefix, msg)
	if select(2, IsInInstance()) == "pvp" then
		SendAddonMessage(prefix, msg, "BATTLEGROUND")
	elseif GetNumRaidMembers() > 0 then
		SendAddonMessage(prefix, msg, "RAID")
	else
		SendAddonMessage(prefix, msg, "PARTY")
	end
end

local function strFromTime(time)
	if time < 60 then
		return DBM_CORE_TIMER_FORMAT_SECS:format(time)
	elseif time % 60 == 0 then
		return DBM_CORE_TIMER_FORMAT_MINS:format(time/60)
	else
		return DBM_CORE_TIMER_FORMAT:format(time/60, time % 60)
	end
end


--------------
--  Events  --
--------------
do
	local registeredEvents = {}
	local args = {}
	local function clearArgs()
		for i, v in pairs(args) do
			args[i] = nil
		end
	end
	
	local function handleEvent(self, event, ...)
		for i, v in ipairs(registeredEvents[event]) do
			if type(v[event]) == "function" and (not v.zones or checkEntry(v.zones, GetRealZoneText())) then
				v[event](v, ...)
			end
		end
	end
	
	function DBM:RegisterEvents(...)
		for i = 1, select("#", ...) do
			local ev = select(i, ...)
			registeredEvents[ev] = registeredEvents[ev] or {}
			table.insert(registeredEvents[ev], self)
			mainFrame:RegisterEvent(ev)
		end
	end

	DBM:RegisterEvents("ADDON_LOADED")

	function DBM:COMBAT_LOG_EVENT_UNFILTERED(timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, ...)
		if not registeredEvents[event] then return end
		args.timestamp = timestamp
		args.event = event
		args.sourceGUID = sourceGUID
		args.sourceName = sourceName
		args.sourceFlags = sourceFlags
		args.destGUID = destGUID
		args.destName = destName
		args.destFlags = destFlags
		-- taken from Blizzard_CombatLog.lua
		if event == "SWING_DAMAGE" then 
			args.amount, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = select(1, ...)
		elseif event == "SWING_MISSED" then 
			args.spellName = ACTION_SWING
			args.missType = select(1, ...)
		elseif event:sub(1, 5) == "RANGE" then
			args.spellId, args.spellName, args.spellSchool = select(1, ...)
			if event == "RANGE_DAMAGE" then 
				args.amount, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = select(4, ...)
			elseif event == "RANGE_MISSED" then 
				args.missType = select(4, ...)
			end
		elseif event:sub(1, 5) == "SPELL" then
			args.spellId, args.spellName, args.spellSchool = select(1, ...)
			if event == "SPELL_DAMAGE" then
				args.amount, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = select(4, ...)
			elseif event == "SPELL_MISSED" then 
				args.missType = select(4, ...)
			elseif event == "SPELL_HEAL" then 
				args.amount, args.critical = select(4, ...)
				args.school = args.spellSchool
			elseif event == "SPELL_ENERGIZE" then 
				args.valueType = 2
				args.amount, args.powerType = select(4, ...)
			elseif event:sub(1, 14) == "SPELL_PERIODIC" then
				if event == "SPELL_PERIODIC_MISSED" then
					args.missType = select(4, ...)
				elseif event == "SPELL_PERIODIC_DAMAGE" then
					args.amount, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = select(4, ...)
				elseif event == "SPELL_PERIODIC_HEAL" then
					args.amount, args.critical = select(4, ...)
					args.school = args.spellSchool
				elseif event == "SPELL_PERIODIC_DRAIN" then
					args.amount, args.powerType, args.extraAmount = select(4, ...)
					args.valueType = 2
				elseif event == "SPELL_PERIODIC_LEECH" then
					args.amount, args.powerType, args.extraAmount = select(4, ...)
					args.valueType = 2
				elseif event == "SPELL_PERIODIC_ENERGIZE" then 
					args.amount, args.powerType = select(4, ...)
					args.valueType = 2			
				end
			elseif event == "SPELL_DRAIN" then
				args.amount, args.powerType, args.extraAmount = select(4, ...)
				args.valueType = 2
			elseif event == "SPELL_LEECH" then
				args.amount, args.powerType, args.extraAmount = select(4, ...)
				args.valueType = 2
			elseif event == "SPELL_INTERRUPT" then
				args.extraSpellId, args.extraSpellName, args.extraSpellSchool = select(4, ...)
			elseif event == "SPELL_EXTRA_ATTACKS" then
				args.amount = select(4, ...)
			elseif event == "SPELL_DISPEL_FAILED" then
				args.extraSpellId, args.extraSpellName, args.extraSpellSchool = select(4, ...)
			elseif event == "SPELL_AURA_DISPELLED" then
				args.extraSpellId, args.extraSpellName, args.extraSpellSchool = select(4, ...)
				args.auraType = select(7, ...)
			elseif event == "SPELL_AURA_STOLEN" then
				args.extraSpellId, args.extraSpellName, args.extraSpellSchool = select(4, ...)
				args.auraType = select(7, ...)
			elseif event == "SPELL_AURA_APPLIED" or event == "SPELL_AURA_REMOVED" then
				args.auraType = select(4, ...)
				args.sourceName = args.destName
				args.sourceGUID = args.destGUID
				args.sourceFlags = args.destFlags
			elseif event == "SPELL_AURA_APPLIED_DOSE" or event == "SPELL_AURA_REMOVED_DOSE" then
				args.auraType, args.amount = select(4, ...)
				args.sourceName = args.destName
				args.sourceGUID = args.destGUID
				args.sourceFlags = args.destFlags
			elseif event == "SPELL_CAST_FAILED" then 
				args.missType = select(4, ...)
			end
		elseif event == "DAMAGE_SHIELD" then
			args.spellId, args.spellName, args.spellSchool = select(1, ...)
			args.amount, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = select(4, ...)
		elseif event == "DAMAGE_SHIELD_MISSED" then 
			args.spellId, args.spellName, args.spellSchool = select(1, ...)
			args.missType = select(4, ...)
		elseif event == "ENCHANT_APPLIED" then
			args.spellName = select(1,...)
			args.itemId, args.itemName = select(2,...)
		elseif event == "ENCHANT_REMOVED" then
			args.spellName = select(1,...)
			args.itemId, args.itemName = select(2,...)
		elseif event == "UNIT_DIED" or event == "UNIT_DESTROYED" then
			args.sourceName = args.destName
			args.sourceGUID = args.destGUID
			args.sourceFlags = args.destFlags
		elseif event == "ENVIRONMENTAL_DAMAGE" then
			args.environmentalType = select(1,...)
			args.amount, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = select(2, ...)
			args.spellName = getglobal("ACTION_"..event.."_"..args.environmentalType)
			args.spellSchool = args.school
		elseif event == "DAMAGE_SPLIT" then
			args.spellId, args.spellName, args.spellSchool = select(1, ...)
			args.amount, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = select(4, ...)
		end
		handleEvent(nil, event, args)
	end
	mainFrame:SetScript("OnEvent", handleEvent)
end


--------------------------
--  OnUpdate/Scheduler  --
--------------------------
do
	local scheduleData = {}
	local scheduleTables = {}
	setmetatable(scheduleTables, {__mode = "kv"})

	local function getScheduleTable()
		local v = next(scheduleTables, nil)
		if v then
			scheduleTables[v] = nil
			v.mod = nil
			for i = #v.args, 0, -1 do
				v.args[i] = nil
			end
		else
			v = {args = {}}
		end
		return v
	end
	
	mainFrame:SetScript("OnUpdate", function(self, elapsed)
		local time = GetTime()
		for i, v in pairs(updateFunctions) do
			if i.Options.Enabled and (not i.zones or checkEntry(i.zones, GetRealZoneText())) then
				i.elapsed = (i.elapsed or 0) + elapsed
				if i.elapsed >= (i.updateInterval or 0) then
					v(i, i.elapsed)
					i.elapsed = 0
				end
			end
		end
		for i = #scheduleData, 1, -1 do
			local v = scheduleData[i]
			if time >= v.time and not v.dead then
				table.remove(scheduleData, i)
				scheduleTables[v] = v
				v.func(unpack(v.args))
			elseif v.dead then
				v.dead = nil
				table.remove(scheduleData, i)
				scheduleTables[v] = v
			end
		end
		local k, v = next(modSyncSpam, nil)
		if v and (time - v > 2.5) then
			modSyncSpam[k] = nil
		end
	end)

	function schedule(t, f, mod, ...)
		local v = getScheduleTable()
		v.mod = mod
		v.time = GetTime() + t
		v.func = f
		for i = 1, select("#", ...) do
			v.args[#v.args + 1] = select(i, ...)
		end
		table.insert(scheduleData, v)
	end
	
	function unschedule(f, mod, ...)
		for k = #scheduleData, 1, -1 do
			local v = scheduleData[k]
			if v.func == f and ((not mod) or v.mod == mod) then
				local match = true
				for i = 1, select("#", ...) do
					if select(i, ...) ~= v.args[i] then
						match = false
					end
				end
				if match then
					v.dead = true
				end
			end
		end	
	end
end

function DBM:Schedule(t, f, ...)
	schedule(t, f, nil, ...)
end


----------------------
--  Slash Commands  --
----------------------
SLASH_DEADLYBOSSMODS1 = "/dbm"
SlashCmdList["DEADLYBOSSMODS"] = function(msg)
	if not IsAddOnLoaded("DBM-GUI") then
		local _, _, _, enabled = GetAddOnInfo("DBM-GUI")
		if not enabled then
			EnableAddOn("DBM-GUI")
		end
		local loaded, reason = LoadAddOn("DBM-GUI")
		if not loaded then
			self:AddMsg(DBM_CORE_LOAD_GUI_ERROR:format(tostring(getglobal("ADDON_"..reason or ""))))
			return
		end
	end
	DBM_GUI:ShowHide()
end

---------------------------
--  Raid/Party Handling  --
---------------------------
do
	local raid = {}
	local inRaid = false
	local playerRank = 0
	
	function DBM:RAID_ROSTER_UPDATE()
		if GetNumRaidMembers() >= 1 then
			if not inRaid then
				inRaid = true
				sendSync("DBMv4-Ver", "Hi!")
			end
			for i = 1, GetNumRaidMembers() do
				local name, rank, subgroup, _, _, fileName = GetRaidRosterInfo(i)
				if name then
					raid[name] = raid[name] or {}
					raid[name].name = name
					raid[name].rank = rank
					raid[name].subgroup = subgroup
					raid[name].class = fileName
					raid[name].id = "raid"..i
					raid[name].updated = true
				end
			end
			for i, v in pairs(raid) do
				if not v.updated then
					raid[i] = nil
				else
					v.updated = nil
				end
			end
		else
			inRaid = false
		end
	end
	
	function DBM:PARTY_MEMBERS_CHANGED()
		if GetNumRaidMembers() > 0 then return end 
		if GetNumPartyMembers() >= 1 then
			if not inRaid then
				inRaid = true
				sendSync("DBMv4-Ver", "Hi!")
			end
			for i = 0, GetNumPartyMembers() do
				local id
				if (i == 0) then
					id = "player"
				else
					id = "party"..i
				end
				local name, rank, _, fileName = UnitName(id), UnitIsPartyLeader(id), UnitClass(id)
				if name then
					raid[name] = raid[name] or {}
					raid[name].name = name
					if rank then
						raid[name].rank = 2
					else
						raid[name].rank = 0
					end
					raid[name].class = fileName
					raid[name].id = id
					raid[name].updated = true
				end
			end
			for i, v in pairs(raid) do
				if not v.updated then
					raid[i] = nil
				else
					v.updated = nil
				end
			end
		else
			inRaid = false
		end
	end
	
	function DBM:IsInRaid()
		return inRaid
	end
	
	function DBM:GetRaidRank(name)
		name = name or UnitName("player")
		return (raid[name] and raid[name].rank) or 0
	end
	
	function DBM:GetRaidSubgroup(name)
		name = name or UnitName("player")
		return (raid[name] and raid[name].subgroup) or 0
	end
	
	function DBM:GetRaidClass(name)
		name = name or UnitName("player")
		return (raid[name] and raid[name].class) or "UNKNOWN"
	end
	
	function DBM:GetRaidUnitId(name)
		name = name or UnitName("player")
		return (raid[name] and raid[name].id) or "none"
	end
end


---------------
--  Options  --
---------------
do
	local function addDefaultOptions(t1, t2)
		for i, v in pairs(t2) do
			if not t1[i] then
				t1[i] = v
			elseif type(v) == "table" then
				addDefaultOptions(v, t2[i])
			end
		end
	end
	
	function loadOptions()
		DBM.Options = DBM_SavedOptions
		addDefaultOptions(DBM.Options, DBM.DefaultOptions)
		RaidWarningFrame:SetPoint(DBM.Options.WarningPosition.Point, UIParent, DBM.Options.WarningPosition.Point, DBM.Options.WarningPosition.X, DBM.Options.WarningPosition.Y)
	end
	
	function loadModOptions()
		for i, v in ipairs(DBM.Mods) do
			if not v.initialized then
				DBM_SavedModOptions[v.id] = DBM_SavedModOptions[v.id] or v.Options
				for option, optionValue in pairs(v.Options) do
					if DBM_SavedModOptions[v.id][option] == nil then
						DBM_SavedModOptions[v.id][option] = optionValue
					end
				end
				v.Options = DBM_SavedModOptions[v.id]
				v.initialized = true
			end
		end
	end
end


--------------
--  OnLoad  --
--------------
function DBM:ADDON_LOADED(modname)
	if modname == "DBM-Core" then
		loadOptions()
		self.AddOns = {}
		for i = 1, GetNumAddOns() do
			if GetAddOnMetadata(i, "X-DBM-Mod") then
				table.insert(self.AddOns, {
					sort		= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Sort") or math.huge) or math.huge,
					category	= GetAddOnMetadata(i, "X-DBM-Mod-Category") or "Other",
					name		= GetAddOnMetadata(i, "X-DBM-Mod-Name") or "",
					zone		= GetAddOnMetadata(i, "X-DBM-Mod-LoadZone"),
					modId		= GetAddOnInfo(i),
				})
			end
		end
		table.sort(self.AddOns, function(v1, v2) return v1.sort > v2.sort end)
		self:RegisterEvents(
			"COMBAT_LOG_EVENT_UNFILTERED",
			"ZONE_CHANGED_NEW_AREA",
			"RAID_ROSTER_UPDATE",
			"PARTY_MEMBERS_CHANGED",
			"CHAT_MSG_ADDON",
			"PLAYER_REGEN_DISABLED",
			"UNIT_DIED",
			"UNIT_DESTROYED",
			"CHAT_MSG_WHISPER"
		)
		self:ZONE_CHANGED_NEW_AREA()
		self:RAID_ROSTER_UPDATE()
		self:PARTY_MEMBERS_CHANGED()
	end
end

--------------------------------
--  Load Boss Mods on Demand  --
--------------------------------
function DBM:ZONE_CHANGED_NEW_AREA()
	for i, v in ipairs(self.AddOns) do
		if v.zone == GetRealZoneText() and not IsAddOnLoaded(v.modId) then
			self:LoadMod(v)
		end
	end
end

function DBM:LoadMod(mod)
	local _, _, _, enabled = GetAddOnInfo(mod.modId)
	if not enabled then
		EnableAddOn(mod.modId)
	end

	local loaded, reason = LoadAddOn(mod.modId)
	if not loaded then
		self:AddMsg(DBM_CORE_LOAD_MOD_ERROR:format(tostring(mod.name), tostring(getglobal("ADDON_"..reason or ""))))
		return false
	else
		self:AddMsg(DBM_CORE_LOAD_MOD_SUCCESS:format(tostring(mod.name)))
		loadModOptions()
		if DBM_GUI then
			DBM_GUI:UpdateModList()
		end
		return true
	end
end


-----------------------------
--  Handle Incoming Syncs  --
-----------------------------
do
	local syncHandlers = {}
	syncHandlers["DBMv4-Mod"] = function(msg, channel, sender)
		if not modSyncSpam[msg] or (GetTime() - modSyncSpam[msg] > 2.5) then
			modSyncSpam[msg] = time
			local mod, revision, event, arg = strsplit("\t", msg)
			mod = self:GetModByName(mod or "")
			if mod and event and arg and revision then
				mod:ReceiveSync(event, arg, sender, revision)
			end
		end
	end
	
	syncHandlers["DBMv4-Pull"] = function(msg, channel, sender)
		local delay, mod = strsplit("\t", msg)
		delay = tonumber(delay or 0) or 0
		mod = self:GetModByName(mod or "")
		if mod and delay then
			self:StartCombat(mod, delay, true)
		end
	end
	
	syncHandlers["DBMv4-Kill"] = function(msg, channel, sender)
		local cId = tonumber(msg)
		if cId then self:OnMobKill(cId, true) end
	end
	
	syncHandlers["DBMv4-Ver"] = function(msg, channel, sender)
		if msg == "Hi!" then
			sendSync("DBMv4-Ver", "") -- TODO
		else
		end
	end
	
	function DBM:CHAT_MSG_ADDON(prefix, msg, channel, sender)
		if msg and channel ~= "WHISPER" and channel ~= "GUILD" then
			local handler = syncHandlers[prefix]
			if handler then handler(msg, channel, sender) end
		end
	end
end


------------------------
--  Combat Detection  --
------------------------
do
	local targetList = {}
	local function buildTargetList()
		local uId = ((GetNumRaidMembers() == 0) and "party") or "raid"
		for i = 0, math.max(GetNumRaidMembers(), GetNumPartyMembers()) do
			local id = (i == 0 and "target") or uId..i.."target"
			local guid = UnitGUID(id)
			if guid and bit.band(guid:sub(0, 5), 0x00F) == 3 then
				local cId = tonumber(guid:sub(9, 12), 16)
				targetList[cId] = id
			end
		end
	end
	
	local function clearTargetList()
		for i in pairs(targetList) do
			targetList[i] = nil
		end
		targetList.reset = 1
		targetList.reset = nil
	end
	
	local function scanForCombat(combatInfo)
		if not checkEntry(inCombat, combatInfo.mod) then
			buildTargetList()
			if targetList[combatInfo.mob] and UnitAffectingCombat(targetList[combatInfo.mob]) then
				DBM:StartCombat(combatInfo.mod, 3)
			end
			clearTargetList()
		end
	end
	
	function DBM:PLAYER_REGEN_DISABLED()
		if combatInfo[GetRealZoneText()] then
			buildTargetList()
			for i, v in ipairs(combatInfo[GetRealZoneText()]) do
				if v.type == "combat" then
					local uId = targetList[v.mob]
					if uId and UnitAffectingCombat(uId) then
						self:StartCombat(v.mod, 0)
					elseif uId then
						self:Schedule(3, scanForCombat, v)
					end
				end
			end
			clearTargetList()
		end
	end
end

do
	local checkWipe
	function checkWipe(confirm)
		if #inCombat > 0 then
			local wipe = true
			local uId = ((GetNumRaidMembers() == 0) and "party") or "raid"
			for i = 0, math.max(GetNumRaidMembers(), GetNumPartyMembers()) do
				local id = (i == 0 and "player") or uId..i
				if UnitAffectingCombat(id) then
					wipe = false
					break
				end
			end
			if not wipe then
				DBM:Schedule(3, checkWipe)
			elseif confirm then
				for i = #inCombat, 1, -1 do
					DBM:EndCombat(inCombat[i], true)
				end
			else
				DBM:Schedule(5, checkWipe, true)
			end
		end
	end
	
	function DBM:StartCombat(mod, delay, synced)
		if not checkEntry(inCombat, mod) then
			table.insert(inCombat, mod)
			self:AddMsg(DBM_CORE_COMBAT_STARTED:format(mod.combatInfo.name))
			mod.stats.pulls = mod.stats.pulls + 1
			mod.inCombat = true
			mod.blockSyncs = nil
			if mod.OnCombatStart then mod:OnCombatStart(delay or 0) end
			mod.combatInfo.pull = GetTime() - (delay or 0)
			self:Schedule(mod.minCombatTime or 3, checkWipe)
			if not synced then
				sendSync("DBMv4-Pull", (delay or 0).."\t"..mod.id)
			end
		end
	end
end

function DBM:EndCombat(mod, wipe)
	if removeEntry(inCombat, mod) then
		if mod.OnCombatEnd then mod:OnCombatEnd(wipe) end
		mod.inCombat = false
		mod.blockSyncs = true
		if mod.combatInfo.killMobs then
			for i, v in pairs(mod.combatInfo.killMobs) do
				mod.combatInfo.killMobs[i] = true
			end
		end
		if wipe then
			local thisTime = GetTime() - mod.combatInfo.pull
			if thisTime < 25 then
				mod.stats.pulls = mod.stats.pulls - 1
			end
			self:AddMsg(DBM_CORE_COMBAT_ENDED:format(mod.combatInfo.name, strFromTime(thisTime)))
		else
			local thisTime = GetTime() - mod.combatInfo.pull
			local lastTime = mod.stats.lastTime
			local bestTime = mod.stats.bestTime
			mod.stats.kills = mod.stats.kills + 1
			mod.stats.lastTime = thisTime
			mod.stats.bestTime = math.min(bestTime or math.huge, thisTime)
			if not lastTime then
				self:AddMsg(DBM_CORE_BOSS_DOWN:format(mod.combatInfo.name, strFromTime(thisTime)))
			elseif thisTime < (bestTime or math.huge) then
				self:AddMsg(DBM_CORE_BOSS_DOWN_NEW_RECORD:format(mod.combatInfo.name, strFromTime(thisTime), strFromTime(bestTime)))
			else
				self:AddMsg(DBM_CORE_BOSS_DOWN_LONG:format(mod.combatInfo.name, strFromTime(thisTime), strFromTime(lastTime), strFromTime(bestTime)))
			end
		end
	end
end

function DBM:OnMobKill(cId, synced)
	for i = #inCombat, 1, -1 do
		local v = inCombat[i]
		if v.combatInfo.killMobs and v.combatInfo.killMobs[cId] then
			if not synced then sendSync("DBMv4-Kill", cId) end
			v.combatInfo.killMobs[cId] = false
			local allMobsDown = true
			for i, v in pairs(v.combatInfo.killMobs) do
				if v then allMobsDown = false break end
			end
			if allMobsDown then
				self:EndCombat(v)
			end
		elseif cId == v.combatInfo.mob and not v.combatInfo.killMobs then
			if not synced then sendSync("DBMv4-Kill", cId) end
			self:EndCombat(v)
		end
	end
end

function DBM:UNIT_DIED(args)
	if bit.band(args.destGUID:sub(0, 5), 0x00F) == 3 then
		self:OnMobKill(tonumber(args.destGUID:sub(9, 12), 16))
	end
end
DBM.UNIT_DESTROYED = DBM.UNIT_DIED


------------------------------------
--  Auto-respond/Status whispers  --
------------------------------------
do
	local function getNumAlivePlayers()
		local alive = 0
		if GetNumRaidMembers() > 0 then
			for i = 1, GetNumRaidMembers() do
				alive = alive + ((UnitIsDeadOrGhost("raid"..i) and 0) or 1)
			end
		else
			alive = (UnitIsDeadOrGhost("raid"..i) and 0) or 1
			for i = 1, GetNumPartyMembers() do
				alive = alive + (UnitIsDeadOrGhost("party"..i) and 0) or 1
			end
		end
		return alive
	end
	
	function DBM:CHAT_MSG_WHISPER(msg, sender)
		if msg == "status" and #inCombat > 0 and self.Options.StatusEnabled then
			local mod
			for i, v in ipairs(inCombat) do
				mod = not v.isCustomMod and v
			end
			mod = mod or inCombat[i]
			SendChatMessage(chatPrefix..DBM_CORE_AUTO_RESPOND_WHISPER:format(UnitName("player"), mod.combatInfo.name, mod:GetHP(), getNumAlivePlayers(), math.max(GetNumRaidMembers(), GetNumPartyMembers())), "WHISPER", nil, sender)
		end
	end
end


-------------------
--  Chat Filter  --
-------------------
do
	local function filterOutgoing(msg)
		return msg:sub(0, chatPrefix:len()) == chatPrefix or msg:sub(0, chatPrefixShort:len()) == chatPrefixShort
	end
	local function filterIncoming(msg)
		return msg == "status" and #inCombat > 0
	end
	ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", filterOutgoing)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", filterIncoming)
end


--------------------------
--  Enable/Disable DBM  --
--------------------------
function DBM:Disable()
	self.Options.Enabled = false -- TODO
end

function DBM:Enable()
	self.Options.Enabled = true
end

function DBM:IsEnabled()
	return self.Options.Enabled
end


-----------------------
--  Misc. Functions  --
-----------------------
function DBM:AddMsg(text, prefix)
	prefix = prefix or (self.localization and self.localization.general.name) or "Deadly Boss Mods"
	DEFAULT_CHAT_FRAME:AddMessage(("|cffff7d0a<|r|cffffd200%s|r|cffff7d0a>|r %s"):format(tostring(prefix), tostring(text)), 0.41, 0.8, 0.94)
end


--------------------------
--  Boss Mod Prototype  --
--------------------------
local bossModPrototype = {}


----------------------------
--  Boss Mod Constructor  --
----------------------------
do
	local modsById = {}
	local mt = {__index = bossModPrototype}
	function DBM:NewMod(name, modId, modSubTab)
		if modsById[name] then error("Mod names are used as IDs and must therefore be unique.") end
		local obj = setmetatable(
			{
				Options = {
					Enabled = true,
				},
				subTab = modSubTab,
				optionCategories = {
				},
				categorySort = {},
				id = name,
				announces = {},
				timers = {},
				modId = modId,
				stats = DBM_Stats[name] or {kills = 0, pulls = 0},
				revision = 0,
				localization = self:GetModLocalization(name)
			},
			mt
		)
		DBM_Stats[name] = obj.stats
		table.insert(self.Mods, obj)
		modsById[name] = obj
		return obj
	end
	
	function DBM:GetModByName(name)
		return modsById[name]
	end
end


-----------------------
--  General Methods  --
-----------------------
bossModPrototype.RegisterEvents = DBM.RegisterEvents
bossModPrototype.AddMsg = DBM.AddMsg

function bossModPrototype:SetZone(...)
	self.zones = {...}
end

function bossModPrototype:SetCreatureID(id)
	self.creatureId = id
end

function bossModPrototype:EnableMod()
	self.Options.Enabled = true
end

function bossModPrototype:DisableMod()
	self.Options.Enabled = false
end

function bossModPrototype:RegisterOnUpdateHandler(func, interval)
	if type(func) ~= "function" then return end
	self.elapsed = 0
	self.updateInterval = interval or 0
	updateFunctions[self] = func
end

function bossModPrototype:SetRevision(revision)
	self.revision = revision
end

function bossModPrototype:SendWhisper(msg, target)
	SendChatMessage(chatPrefixShort..msg, "WHISPER", nil, target)
end


-----------------------
--  Announce Object  --
-----------------------
do
	local textureCode = " |T%s:24:24:1|t "
	local textureExp = " |T(%S+):24:24:1|t "
	local announcePrototype = {}
	local mt = {__index = announcePrototype}

	function announcePrototype:Show(...)
		if not self.option or self.mod.Options[self.option] then
			local colorCode = ("|cff%.2x%.2x%.2x"):format(self.color.r * 255, self.color.g * 255, self.color.b * 255)
			local text = ("%s%s%s|r%s"):format(
				(DBM.Options.WarningIconLeft and self.icon and textureCode:format(self.icon)) or "",
				colorCode,
				self.text:format(...),
				(DBM.Options.WarningIconRight and self.icon and textureCode:format(self.icon)) or ""
			)
			text = text:gsub(">%S+<", function(cap)
				cap = cap:sub(2, -2)
				if DBM:GetRaidClass(cap) then
					local color = RAID_CLASS_COLORS[DBM:GetRaidClass(cap)] or self.color
					cap = ("|r|cff%.2x%.2x%.2x%s|r%s"):format(color.r * 255, color.g * 255, color.b * 255, cap, colorCode)
				end
				return cap
			end)
			RaidNotice_AddMessage(RaidWarningFrame, text, ChatTypeInfo["RAID_WARNING"]) -- the color option doesn't work
			if DBM.Options.ShowWarningsInChat then
				text = text:gsub(textureExp, "") -- textures @ chat frame can distort the font
				if DBM.Options.ShowFakedRaidWarnings then
					for i = 1, select("#", GetFramesRegisteredForEvent("CHAT_MSG_RAID_WARNING")) do
						local frame = select(i, GetFramesRegisteredForEvent("CHAT_MSG_RAID_WARNING"))
						if frame ~= RaidWarningFrame and frame:GetScript("OnEvent") then
							frame:GetScript("OnEvent")(frame, "CHAT_MSG_RAID_WARNING", text, UnitName("player"), GetDefaultLanguage("player"), "", UnitName("player"), "", 0, 0, "", 0, 24) -- these are the default args for raid warning messages
						end
					end
				else
					self.mod:AddMsg(text, nil)
				end
			end
		end
	end

	function announcePrototype:Schedule(t, ...)
		schedule(t, self.Show, self.mod, self, ...)
	end

	function announcePrototype:Cancel(...)
		unschedule(self.Show, self.mod, self, ...)
	end
	
	function bossModPrototype:NewAnnounce(text, color, icon, optionDefault, optionName)
		local obj = setmetatable(
			{
				text = self.localization.warnings[text],
				color = DBM.Options.WarningColors[color or 1] or DBM.Options.WarningColors[1],
				option = optionName or text,
				mod = self,
				icon = (type(icon) == "number" and select(3, GetSpellInfo(icon))) or icon,
			},
			mt
		)
		if optionName == false then
			obj.option = nil
		else
			self:AddBoolOption(optionName or text, optionDefault, "announce")
		end
		table.insert(self.announces, obj)
		return obj
	end
end


------------------------------
--  Special Warning Object  --
------------------------------
do
	local frame = CreateFrame("Frame", nil, UIParent)
	local font = frame:CreateFontString(nil, "OVERLAY", "ZoneTextFont")
	frame:SetWidth(1)
	frame:SetHeight(1)
	frame:SetPoint("CENTER", 0, 75)
	frame:Hide()
	font:SetWidth(1024)
	font:SetHeight(0)
	font:SetPoint("CENTER", 0, 0)
	font:SetTextColor(0, 0, 1)
	local specialWarningPrototype = {}
	local mt = {__index = specialWarningPrototype}
	
	frame:SetScript("OnUpdate", function(self, elapsed)
		self.timer = self.timer - elapsed
		if self.timer >= 3 and self.timer <= 4 then
			LowHealthFrame:SetAlpha(self.timer - 3)
		elseif self.timer <= 2 then
			frame:SetAlpha(self.timer/2)
		elseif self.timer <= 0 then
			frame:Hide()
		end
	end)
	
	function specialWarningPrototype:Show(...)
		font:SetText(self.text:format(...))
		LowHealthFrame:Show()
		LowHealthFrame:SetAlpha(1)
		frame:Show()
		frame:SetAlpha(1)
		frame.timer = 5
	end
	
	function specialWarningPrototype:Schedule(t, ...)
		schedule(t, self.Show, self.mod, self, ...)
	end
	
	function specialWarningPrototype:Cancel(t, ...)
		schedule(self.Show, self.mod, self, ...)
	end
	
	function bossModPrototype:NewSpecialWarning(text, optionDefault, optionName)
		local obj = setmetatable(
			{
				text = self.localization.warnings[text],
				option = optionName or text,
				mod = self
			},
			mt
		)
		if optionName == false then
			obj.option = nil
		else
			self:AddBoolOption(optionName or text, optionDefault, "announce")
		end
		return obj
	end
	
	function DBM:ShowSpecialWarning(text)
		font:SetText(text)
		frame:Show()
		frame:SetAlpha(1)
		frame.timer = 5
	end
end


--------------------
--  Timer Object  --
--------------------
do
	local timerPrototype = {}
	local mt = {__index = timerPrototype}
		
	function timerPrototype:Start(...)
		if not self.option or self.mod.Options[self.option] then
			local id = self.id..(("%s"):rep(select("#", ...))):format(...)
			local name = self.text:format(...)
			local bar = DBM.Bars:CreateBar(self.timer, id, self.icon)
			bar:SetText(name)
			table.insert(self.startedTimers, id)
			self.mod:Schedule(self.timer, removeEntry, self.startedTimers, id)
		end
	end
		
	function timerPrototype:Stop(...)
		if select("#", ...) == 0 then
			for i = #self.startedTimers, 1, -1 do
				DBM.Bars:CancelBar(self.startedTimers[i])
				self.startedTimers[i] = nil
			end
		else
			local id = self.id..(("%s"):rep(select("#", ...))):format(...)
			for i = #self.startedTimers, 1, -1 do
				if self.startedTimers[i] == id then
					DBM.Bars:CancelBar(id)
					table.remove(self.startedTimers, i)
				end
			end
		end
	end

	function timerPrototype:GetTime(...)
		return 0 -- TODO
	end

	function timerPrototype:SetTimer(timer)
		self.timer = timer
	end
	
	function bossModPrototype:NewTimer(timer, name, icon, optionDefault, optionName, r, g, b)
		local obj = setmetatable(
			{
				text = self.localization.timers[name],
				timer = timer,
				id = name,
				icon = icon,
				r = r,
				g = g,
				b = b,
				option = optionName or name,
				startedTimers = {},
				mod = self,
			},
			mt
		)
		if optionName == false then
			obj.option = nil
		else
			self:AddBoolOption(optionName or name, optionDefault, "timer")
		end
		table.insert(self.timers, obj)
		return obj
	end
end


---------------------
--  Enrage Object  --
---------------------
do
	local enragePrototype = {}
	local mt = {__index = enragePrototype}
	
	function enragePrototype:Start(timer)
		timer = timer or self.timer or 600
		self.bar:SetTimer(timer)
		self.bar:Start()
		if timer > 600 then self.warning1:Schedule(timer - 600, 10, DBM_CORE_MIN) end
		if timer > 300 then self.warning1:Schedule(timer - 300, 5, DBM_CORE_MIN) end
		if timer > 60 then self.warning2:Schedule(timer - 60, 1, DBM_CORE_MIN) end
		if timer > 30 then self.warning2:Schedule(timer - 30, 30, DBM_CORE_SEC) end
		if timer > 10 then self.warning2:Schedule(timer - 10, 10, DBM_CORE_SEC) end
	end
	
	function enragePrototype:Schedule(t)
		self.owner:Schedule(t, self.Start, self)
	end
	
	function enragePrototype:Cancel()
		self.owner:Unschedule(self.Start, self)
		self.warning1:Cancel()
		self.warning2:Cancel()
		self.bar:Stop()
	end	
	
	function bossModPrototype:NewEnrageTimer(timer, text, barText, barIcon)
		local warning1 = self:NewAnnounce(text or DBM_CORE_GENERIC_WARNING_ENRAGE, 1, nil, "warning_enrage")
		local warning2 = self:NewAnnounce(text or DBM_CORE_GENERIC_WARNING_ENRAGE, 4, nil, "warning_enrage")
		local bar = self:NewTimer(timer or 600, barText or DBM_CORE_GENERIC_TIMER_ENRAGE, barIcon or 28131, nil, "timer_enrage")
		local obj = setmetatable(
			{
				warning1 = warning1,
				warning2 = warning2,
				bar = bar,
				timer = timer,
				owner = self
			},
			mt
		)
		return obj
	end
end


---------------
--  Options  --
---------------
function bossModPrototype:AddBoolOption(name, default, cat)
	cat = cat or "misc"
	self.Options[name] = (default == nil) or default
	self:SetOptionCategory(name, cat)
end

function bossModPrototype:SetOptionCategory(name, cat)
	for _, options in pairs(self.optionCategories)do
		removeEntry(options, name)
	end
	if not self.optionCategories[cat] then
		self.optionCategories[cat] = {}
		table.insert(self.categorySort, cat)
	end
	table.insert(self.optionCategories[cat], name)
end


--------------
--  Combat  --
--------------
function bossModPrototype:RegisterCombat(type, mob, ...)
	local info = {
		type = type,
		mob = mob or self.creatureId,
		name = self.localization.general.name or self.id,
		killMobs = select("#", ...) > 0 and {},
		minCombatTime = minCombatTime,
		mod = self
	}
	for i = 1, select("#", ...) do
		info.killMobs[select(i, ...)] = true
	end
	self.combatInfo = info
	for i, v in ipairs(self.zones) do
		combatInfo[v] = combatInfo[v] or {}
		table.insert(combatInfo[v], info)
	end
end

function bossModPrototype:IsInCombat()
	return self.inCombat
end

function bossModPrototype:SetMinCombatTime(t)
	self.minCombatTime = t
end

function bossModPrototype:GetBossHPString(cId)
	local idType = (GetNumRaidMembers() == 0 and "party") or "raid"
	for i = 0, math.max(GetNumRaidMembers(), GetNumPartyMembers()) do
		local unitId = ((i == 0) and "target") or idType..i.."target"
		local guid = UnitGUID(unitId)
		if guid and tonumber(guid:sub(9, 12), 16) == cId then
			return math.floor(UnitHealth(unitId)/UnitHealthMax(unitId) * 100).."%"
		end
	end
	return DBM_CORE_UNKNOWN
end

function bossModPrototype:GetHP()
	return self:GetBossHPString((self.combatInfo and self.combatInfo.mob) or self.creatureId)
end


-----------------------
--  Synchronization  --
-----------------------
function bossModPrototype:SendSync(event, arg)
	event = event or ""
	arg = arg or ""
	local str = ("%s\t%s\t%s\t%s"):format(self.id, self.revision, event, arg)
	local time = GetTime()
	if not modSyncSpam[str] or (time - modSyncSpam[str]) > 2.5 then
		modSyncSpam[str] = time
		self:ReceiveSync(event, arg, nil, self.revision)
		sendSync("DBMv4-Mod", str)
	end
end

function bossModPrototype:ReceiveSync(event, arg, sender, revision)
	if self.OnSync and (not sender or (not mod.blockSyncs or revision >= self.blockSyncs)) then
		self:OnSync(event, arg, sender)
	end
end

function bossModPrototype:SetMinSyncRevision(revision)
	self.blockSyncs = revision
end


-----------------
--  Scheduler  --
-----------------
function bossModPrototype:Schedule(t, f, ...)
	schedule(t, f, self.mod, ...)
end

function bossModPrototype:Unschedule(f, ...)
	unschedule(f, ...)
end

function bossModPrototype:ScheduleMethod(t, method, ...)
	if not self[method] then
		error(("Method %s does not exist"):format(tostring(method)), 1)
	end
	self:Schedule(t, self[method], self, ...)
end
bossModPrototype.ScheduleEvent = bossModPrototype.ScheduleMethod

function bossModPrototype:UnscheduleMethod(method, ...)
	if not self[method] then
		error(("Method %s does not exist"):format(tostring(method)), 1)
	end
	self:Unschedule(self[method], self, ...)
end
bossModPrototype.UnscheduleEvent = bossModPrototype.UnscheduleMethod


-------------
--  Icons  --
-------------
function bossModPrototype:SetIcon(target, icon, timer)
	if DBM:GetRaidRank() == 0 then return end
	local oldIcon = self:GetIcon(target) or 0
	SetRaidTarget(DBM:GetRaidUnitId(target))
	self:UnscheduleMethod("SetIcon", target)
	if timer then
		self:ScheduleMethod(timer, "RemoveIcon", target)
		if oldIcon then
			self:ScheduleMethod(timer + 1, "SetIcon", target, oldIcon)
		end
	end
end

function bossModPrototype:GetIcon(target)
	return GetRaidTargetIndex(DBM:GetRaidUnitId(target))
end

function bossModPrototype:RemoveIcon(target, timer)
	self:SetIcon(target, 0, timer)
end


-----------------------
--  Model Functions  --
-----------------------
function bossModPrototype:SetModelScale(scale)
	self.modelScale = scale
end

function bossModPrototype:SetModelOffset(x, y, z)
	self.modelOffsetX = x
	self.modelOffsetY = y
	self.modelOffsetZ = z
end

function bossModPrototype:SetModelWalkSequence(id)
	self.walkSequence = id
end

function bossModPrototype:SetModelIdleSquences(...)
	self.idleSequences = {...}
end


--------------------
--  Localization  --
--------------------
function bossModPrototype:GetLocalizedStrings()
	return self.localization.miscStrings
end

do
	local modLocalizations = {}
	local modLocalizationPrototype = {}
	local mt = {__index = modLocalizationPrototype}
	local returnKey = {__index = function(t, k) return k end}
	local defaultCatLocalization = {
		__index = setmetatable({
			timer		= DBM_CORE_OPTION_CATEGORY_TIMERS,
			announce	= DBM_CORE_OPTION_CATEGORY_WARNINGS,
			misc		= DBM_CORE_OPTION_CATEGORY_MISC
		}, returnKey)
	}
	local defaultTimerLocalization = {
		__index = setmetatable({
			timer_enrage = DBM_CORE_OPTION_TIMER_ENRAGE
		}, returnKey)
	}
	local defaultAnnounceLocalization = {
		__index = setmetatable({
			warning_enrage = DBM_CORE_OPTION_BAR_ENRAGE
		}, returnKey)
	}
	
	function modLocalizationPrototype:SetGeneralLocalization(t)
		for i, v in pairs(t) do
			self.general[i] = v
		end
	end
	
	function modLocalizationPrototype:SetWarningLocalization(t)
		for i, v in pairs(t) do
			self.warnings[i] = v
		end
	end
	
	function modLocalizationPrototype:SetTimerLocalization(t)
		for i, v in pairs(t) do
			self.timers[i] = v
		end
	end
	
	function modLocalizationPrototype:SetOptionLocalization(t)
		for i, v in pairs(t) do
			self.options[i] = v
		end
	end
	
	function modLocalizationPrototype:SetOptionCatLocalization(t)
		for i, v in pairs(t) do
			self.cats[i] = v
		end
	end
	
	function modLocalizationPrototype:SetMiscLocalization(t)
		for i, v in pairs(t) do
			self.miscStrings[i] = v
		end
	end

	function DBM:CreateModLocalization(name)
		local obj = {
			general = setmetatable({}, returnKey),
			warnings = setmetatable({}, defaultAnnounceLocalization),
			options = setmetatable({}, returnKey),
			timers = setmetatable({}, defaultTimerLocalization),
			miscStrings = setmetatable({}, returnKey),
			cats = setmetatable({}, defaultCatLocalization),
		}
		setmetatable(obj, mt)
		modLocalizations[name] = obj
		return obj
	end
	
	function DBM:GetModLocalization(name)
		return modLocalizations[name] or self:CreateModLocalization(name)
	end
end


-------------------------------------------------
--  DEBUG STUFF//REMOVE FROM RELEASE VERSIONS  --
-------------------------------------------------
local function serialize(v)
    if type(v) == "string" then
        return ("%q"):format(v)
    else
        return tostring(v)
    end
end

function print_t(t, d, cache)
    d = d or 1
	cache = cache or {}
	cache[t] = true
    if d == 1 then
        DBM:AddMsg("{")
    end
    for i, v in pairs(t) do
        if type(v) == "table" and cache[v] then
			DBM:AddMsg(("%s[%s] = %s,"):format((" "):rep(d * 3), serialize(i), serialize(v)))
		elseif type(v) == "table" then
            DBM:AddMsg(("%s[%s] = {"):format((" "):rep(d * 3), serialize(i)))
            print_t(v, d+1, cache)
            DBM:AddMsg(("%s}"):format((" "):rep(d * 3)))
        else
            DBM:AddMsg(("%s[%s] = %s,"):format((" "):rep(d * 3), serialize(i), serialize(v)))
        end
    end
    if d == 1 then
        DBM:AddMsg("}")
    end
end


SLASH_PRINT1 = "/print"
SlashCmdList["PRINT"] = function(msg)
	local val = loadstring("return "..msg)()
	if type(val) == "table" then
		print_t(val)
	else
		DBM:AddMsg(serialize(val))
	end
end
