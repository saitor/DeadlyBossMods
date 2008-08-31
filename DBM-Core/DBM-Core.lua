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



DBM = {}

DBM_SavedOptions = {}

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
	TestOption = "hallo",
	TestBool = true,
	Enabled = true,
}

local DBT = DBT:New()
DBM.Bars = DBT
DBM.Mods = {}

local updateFunctions = {}
local modSyncSpam = {}
local mainFrame = CreateFrame("Frame")

local registeredEvents = {
	["COMBAT_LOG_EVENT_UNFILTERED"] = {DBM},
	["ZONE_CHANGED_NEW_AREA"] = {DBM},
	["ADDON_LOADED"] = {DBM},
	["RAID_ROSTER_UPDATE"] = {DBM},
	["PARTY_MEMBERS_CHANGED"] = {DBM},
	["CHAT_MSG_ADDON"] = {DBM}
}
for i in pairs(registeredEvents) do
	mainFrame:RegisterEvent(i)
end

local function checkEntry(t, val)
	for i, v in ipairs(t) do
		if v == val then
			return true
		end
	end
	return nil
end

local function onEvent(self, event, ...)
	for i, v in ipairs(registeredEvents[event]) do
		if type(v[event]) == "function" and (not v.zones or checkEntry(v.zones, GetRealZoneText())) then
			v[event](v, ...)
		end
	end
end

local schedule, unschedule, onUpdate
do
	local scheduleTables = {}
	setmetatable(scheduleTables, {__mode = "kv"})
	local scheduleData = {}
	


	function onUpdate(self, elapsed)
		self = DBM
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
		do
			local k, v = next(modSyncSpam, nil)
			if v and (time - v > 2.5) then
				modSyncSpam[k] = nil
			end
		end		
	end
	
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

mainFrame:SetScript("OnEvent", onEvent)
mainFrame:SetScript("OnUpdate", onUpdate)


do
	local raid = {}
	local inRaid = false
	local playerRank = 0
	function DBM:RAID_ROSTER_UPDATE()
		if GetNumRaidMembers() >= 1 then
			if not inRaid then
				inRaid = true
--				sync("blah") --NYI
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
				--sync("blah") -- nyi
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

do
	local function addDefaults(t1, t2)
		for i, v in pairs(t2) do
			if not t1[i] then
				t1[i] = v
			elseif type(v) == "table" then
				addDefaults(v, t2[i])
			end
		end
	end
	
	function DBM:ADDON_LOADED(modname)
		if modname == "DBM-Core" then
			DBM.Options = DBM_SavedOptions
			addDefaults(DBM.Options, DBM.DefaultOptions)
			
			self.AddOns = {}
			for i = 1, GetNumAddOns() do
				if GetAddOnMetadata(i, "X-DBM-Mod") then
					table.insert(self.AddOns, {
						sort		= GetAddOnMetadata(i, "X-DBM-Mod-Sort") or math.huge,
						category	= GetAddOnMetadata(i, "X-DBM-Mod-Category") or "Other",
						name		= GetAddOnMetadata(i, "X-DBM-Mod-Name") or "",
						zone		= GetAddOnMetadata(i, "X-DBM-Mod-Zone"),
						modId		= GetAddOnInfo(i),
					})
				end
			end
			table.sort(self.AddOns, function(v1, v2) return v1.sort > v2.sort end)
			
			RaidWarningFrame:SetPoint(self.Options.WarningPosition.Point, UIParent, self.Options.WarningPosition.Point, self.Options.WarningPosition.X, self.Options.WarningPosition.Y)
			
			self.initialized = true
			self:ZONE_CHANGED_NEW_AREA()
			self:RAID_ROSTER_UPDATE()
			self:PARTY_MEMBERS_CHANGED()
		end
	end
end

function DBM:ZONE_CHANGED_NEW_AREA()
	if not self.initialized then return end -- do not load mods before DBM itself is initialized
	for i, v in ipairs(self.AddOns) do
		if v.zone == GetRealZoneText() and not IsAddOnLoaded(v.modId) then
			self:LoadMod(v)
		end
	end
end

function DBM:CHAT_MSG_ADDON(prefix, msg, channel, sender)
	local time = GetTime()
	if prefix == "DBMv4-Boss" and msg and channel ~= "WHISPER" and channel ~= "GUILD" then
		if not modSyncSpam[msg] or (time - modSyncSpam[msg] > 2.5) then
			modSyncSpam[msg] = time
			local mod, event, arg = msg:split("\t")
			mod = self:GetModByName(mod or "")
			if mod and event and arg then
				mod:ReceiveSync(event, arg, sender)
			end
		end
	end
end

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

do
	local args = {}
	local function clearArgs()
		for i, v in pairs(args) do
			args[i] = nil
		end
	end
	
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
		
		for i, v in ipairs(registeredEvents[event]) do
			if type(v[event]) == "function" then
				v[event](v, args)
			end
		end
	end
end

function DBM:AddMsg(text, prefix)
	prefix = prefix or (self.localization and self.localization.general.name) or "Deadly Boss Mods"
	DEFAULT_CHAT_FRAME:AddMessage(("|cffff7d0a<|r|cffffd200%s|r|cffff7d0a>|r %s"):format(tostring(prefix), tostring(text)), 0.41, 0.8, 0.94)
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
		self:InitializeMods()
		if DBM_GUI.UpdateModList then
			DBM_GUI:UpdateModList()
		end
		return true
	end
end

function DBM:InitializeMods()
	for i, v in ipairs(self.Mods) do
		if not v.initialized then
			v.initialized = true
		end
	end
end

function DBM:Schedule(t, f, ...)
	schedule(t, f, nil, ...)
end

function DBM:Disable()
	self.Options.Enabled = false
end

function DBM:Enable()
	self.Options.Enabled = true
end

function DBM:IsEnabled()
	return self.Options.Enabled
end


local announcePrototype = {}

function announcePrototype:Show(...)
	if not self.option or self.mod.Options[self.option] then
		local colorCode = ("|cff%.2x%.2x%.2x"):format(self.color.r * 255, self.color.g * 255, self.color.b * 255)
		local text = ("%s%s|r"):format(colorCode, self.text:format(...))
		text = text:gsub(">%S+<", function(cap)
			cap = cap:sub(2, -2)
			if DBM:GetRaidClass(cap) then
				local color = RAID_CLASS_COLORS[DBM:GetRaidClass(cap)] or self.color
				cap = ("|r|cff%.2x%.2x%.2x%s|r%s"):format(color.r * 255, color.g * 255, color.b * 255, cap, colorCode)
			end
			return cap
		end)
		RaidNotice_AddMessage(RaidWarningFrame, text, ChatTypeInfo["RAID_WARNING"]) -- the color option doesn't work
		self.mod:AddMsg(text)
	end
end


function announcePrototype:Schedule(t, ...)
	schedule(t, self.Show, self.mod, self, ...)
end

function announcePrototype:Cancel(...)
	unschedule(self.Show, self.mod, self, ...)
end


local timerPrototype = {}

do
	local function removeEntry(t, v)
		for i = #t, 1, -1 do
			if t[i] == v then
				table.remove(t, i)
			end
		end
	end
	
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


local bossModPrototype = {}

function bossModPrototype:RegisterEvents(...)
	for i = 1, select("#", ...) do
		local ev = select(i, ...)
		registeredEvents[ev] = registeredEvents[ev] or {}
		table.insert(registeredEvents[ev], self)
		mainFrame:RegisterEvent(ev)
	end
end

bossModPrototype.AddMsg = DBM.AddMsg

function bossModPrototype:RegisterOnUpdateHandler(func, interval)
	if type(func) ~= "function" then return end
	self.elapsed = 0
	self.updateInterval = interval or 0
	updateFunctions[self] = func
end

do
	local mt = {__index = announcePrototype}
	function bossModPrototype:NewAnnounce(text, color, optionDefault, optionName)
		local obj = setmetatable(
			{
				text = self.localization.warnings[text] or text or "",
				color = DBM.Options.WarningColors[color or 1] or DBM.Options.WarningColors[1],
				option = optionName or text,
				mod = self,
			},
			mt
		)
		if optionName == false then
			obj.option = nil
		else
			self:AddOption(optionName or text, optionDefault, "announce")
		end
		table.insert(self.announces, obj)
		return obj
	end
end

do
	local mt = {__index = timerPrototype}
	function bossModPrototype:NewTimer(timer, name, icon, optionDefault, optionName, r, g, b)
		local obj = setmetatable(
			{
				text = self.localization.timers[name] or name,
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
			self:AddOption(optionName or name, optionDefault, "timer")
		end
		table.insert(self.timers, obj)
		return obj
	end
end

function bossModPrototype:AddOption(name, default, cat)
	cat = cat or "misc"
	self.Options[name] = (default == nil) or default
	self.optionCategories[cat] = self.optionCategories[cat] or {}
	table.insert(self.optionCategories[cat], name)
end

function bossModPrototype:SetOptionCategory(name, cat) -- TODO
end

function bossModPrototype:SetZone(...)
	self.zone = {...}
end

function bossModPrototype:IsInCombat()
	return self.inCombat
end

function bossModPrototype:RegisterCombat(type)
	-- TODO
end

function bossModPrototype:SetCreatureID(id)
	self.creatureId = id
end

do
	local enragePrototype = {}
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
	local mt = {__index = enragePrototype}
	function bossModPrototype:NewEnrageTimer(timer, text, barText, barIcon)
		local warning1 = self:NewAnnounce(text or DBM_CORE_GENERIC_WARNING_ENRAGE, 1, nil, false)
		local warning2 = self:NewAnnounce(text or DBM_CORE_GENERIC_WARNING_ENRAGE, 4, nil, false)
		local bar = self:NewTimer(timer or 600, barText or DBM_CORE_GENERIC_TIMER_ENRAGE, barIcon or 28131, nil, false)
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

function bossModPrototype:SendSync(event, arg)
	event = event or ""
	arg = arg or ""
	local str = ("%s\t%s\t%s"):format(self.id, event, arg)
	local time = GetTime()
	if not modSyncSpam[str] or (time - modSyncSpam[str]) > 2.5 then
		modSyncSpam[str] = time
		self:ReceiveSync(event, arg, UnitName("player"))
		if select(2, IsInInstance()) == "pvp" then
			SendAddonMessage("DBMv4-Boss", str, "BATTLEGROUND")
		elseif GetNumRaidMembers() > 0 then
			SendAddonMessage("DBMv4-Boss", str, "RAID")
		else
			SendAddonMessage("DBMv4-Boss", str, "PARTY")
		end		
	end
end

function bossModPrototype:ReceiveSync(event, arg, sender)
	if self.OnSync then
		self:OnSync(event, arg, sender)
	end
end

function bossModPrototype:GetLocalizedStrings()
	return self.localization.miscStrings
end

function bossModPrototype:EnableMod()
	self.Options.Enabled = true
end

function bossModPrototype:DisableMod()
	self.Options.Enabled = false
end

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

function bossModPrototype:GetIcon(target)
	return GetRaidTargetIndex(DBM:GetRaidUnitId(target))
end

function bossModPrototype:RemoveIcon(target, timer)
	self:SetIcon(target, 0, timer)
end

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

do
	local mt = {__index = bossModPrototype}
	function DBM:NewMod(name, modId, ...)
		local obj = setmetatable(
			{
				Options = {
					Enabled = true,
				},
				optionCategories = {
				},
				id = name,
				announces = {},
				timers = {},
				modId = modId,
				localization = self:GetModLocalization(name)
			},
			mt
		)
		table.insert(self.Mods, obj)
		self.modsByName = self.modsByName or {}
		self.modsByName[name] = obj
		return obj
	end
end

function DBM:GetModByName(name)
	return self.modsByName and self.modsByName[name]
end

do
	local modLocalizations = {}
	local modLocalizationPrototype = {}
	
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
	
	function modLocalizationPrototype:SetMiscLocalization(t)
		for i, v in pairs(t) do
			self.miscStrings[i] = v
		end
	end

	do
		local mt = {__index = modLocalizationPrototype}
		function DBM:CreateModLocalization(name)
			local obj = {
				general = {},
				warnings = {},
				options = {},
				timers = {},
				miscStrings = {}
			}
			setmetatable(obj, mt)
			modLocalizations[name] = obj
			return obj
		end
	end
	
	function DBM:GetModLocalization(name)
		return modLocalizations[name] or self:CreateModLocalization(name)
	end
end
