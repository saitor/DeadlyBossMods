---------------
--  DBM Core --
---------------

DBM = {}

DBM.DefaultOptions = {
	
}

local DBT = DBT:New()

local mainFrame = CreateFrame("Frame")

local registeredEvents = {
	["COMBAT_LOG_EVENT_UNFILTERED"] = {DBM},
	["ZONE_CHANGED_NEW_AREA"] = {DBM},
	["ADDON_LOADED"] = {DBM}
}
for i in pairs(registeredEvents) do
	mainFrame:RegisterEvent(i)
end

local function onEvent(self, event, ...)
	for i, v in ipairs(registeredEvents[event]) do
		if type(v[event]) == "function" then
			v[event](v, ...)
		end
	end
end

local function onUpdate(self, elapsed)
	
end

mainFrame:SetScript("OnEvent", onEvent)
mainFrame:SetScript("OnUpdate", onUpdate)

DBM.modName = "Deadly Boss Mods"

function DBM:ADDON_LOADED(modname)
	if modname == "DBM-Core" then
		self.Mods = {}
		for i = 1, GetNumAddOns() do
			if GetAddOnMetadata(i, "X-DBM-Mod") then
				table.insert(self.Mods, {
					sort		= GetAddOnMetadata(i, "X-DBM-Mod-Sort") or math.huge,
					category	= GetAddOnMetadata(i, "X-DBM-Mod-Category") or "WotLK",
					name		= GetAddOnMetadata(i, "X-DBM-Mod-Name") or "",
					zone		= GetAddOnMetadata(i, "X-DBM-Mod-LoadZone"),
					modId		= i,
				})
			end
		end
		table.sort(self.Mods, function(v1, v2) return v1.sort > v2.sort end)
	end
end

function DBM:ZONE_CHANGED_NEW_AREA()
	for i, v in ipairs(self.Mods) do
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
	else
		self:AddMsg(DBM_CORE_LOAD_MOD_SUCCESS:format(tostring(mod.name)))
		self:InitializeMods()
	end
end

function DBM:InitializeMods()
	for i, v in ipairs(self.mods) do
		if not v.initialized then
			v.initialized = true
		end
	end
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
	prefix = prefix or self.modName
	DEFAULT_CHAT_FRAME:AddMessage(("|cffff7d0a<|r|cffffd200%s|r|cffff7d0a>|r %s"):format(tostring(prefix), tostring(text)), 0.41, 0.8, 0.94)
end

local warningColors = {
	{r = 0.41, g = 0.80, b = 0.94},
	{r = 0.95, g = 0.95, b = 0.00},
	{r = 1.00, g = 0.50, b = 0.00},
	{r = 1.00, g = 0.10, b = 0.10},
}


local announcePrototype = {}
function announcePrototype:Show(...)
	if not self.option or self.mod.Options[self.option] then
		RaidNotice_AddMessage(RaidWarningFrame, self.text:format(...), self.color)
	end
end

local bossModPrototype = {}

function bossModPrototype:RegisterEvents(...)
	for i = 1, select("#", ...) do
		local ev = select(i, ...)
		registeredEvents[ev] = registeredEvents[ev] or {}
		table.insert(registeredEvents[ev], self)
	end
end

function bossModPrototype:NewAnnounce(text, color, optionName, optionDefault)
	local obj = setmetatable(
		{
			text = text or "",
			color = warningColors[color or 1] or 1,
			option = optionName,
			mod = self
		},
		{
			__index = announcePrototype
		}
	)
	
	if optionName then
		self:AddBoolOption(optionName, optionDefault)
	end
	
	table.insert(self.Announces, obj)
	return obj
end

function bossModPrototype:AddBoolOption(name, default)
	self.Options[name] = (default == nil) or default
	table.insert(self.BoolOptions, name)
end

function bossModPrototype:GetLocalizedStrings()
	return function(str)
		return self.Localization.MiscStrings[str] or str
	end
end

function bossModPrototype:EnableMod()
	self.Options.Enabled = true
end

function bossModPrototype:DisableMod()
	self.Options.Enabled = false
end


function DBM:NewMod(name)
	local obj = setmetatable(
		{
			Options = {
				Enabled = true,
			},
			announces = {},
			boolOptions = {},
			localization = {
				name = name,
				warnings = {},
				options = {},
				bars = {},
				miscStrings = {}
			}
		},
		{
			__index = bossModPrototype
		}
	)
	self.mods = self.mods or {}
	table.insert(self.mods, obj)
	return obj
end



