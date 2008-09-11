------------------------
-- Deadly Bar Timers ---
------------------------
-- This addon is written and copyrighted by:
--    * Paul Emmerich (Tandanu @ EU-Aegwynn)
--    * Martin Verges (Nitram @ EU-Azshara)
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


---------------
--  Globals  --
---------------
DBT = {}
DBT_SavedOptions = {}

--------------
--  Locals  --
--------------
local fCounter = 1
local barPrototype = {}
local unusedBars = {}
local unusedBarObjects = setmetatable({}, {__mode = "kv"})
local options
local function stringFromTimer(t)
	if t <= 60 then
		return ("%.1f"):format(t)
	else
		return ("%d:%0.2d"):format(t/60, math.fmod(t, 60))
	end
end


-----------------------
--  Default Options  --
-----------------------
options = {
	BarXOffset = {
		type = "number",
		default = 0,
	},	
	BarYOffset = {
		type = "number",
		default = 0,
	},
	ExpandUpwards = {
		type = "boolean",
		default = false,
	},
	Flash = {
		type = "boolean",
		default = true,
	},
	FadeIn = {
		type = "boolean",
		default = true,
	},
	Shine = {
		type = "boolean",
		default = true,
	},
	Break = {
		type = "boolean",
		default = true,
	},
	Icon = {
		type = "boolean",
		default = true,
	},
	IconLeft = {
		type = "boolean",
		default = true,
	},
	IconRight = {
		type = "boolean",
		default = false,
	},
	Texture = {
		type = "string",
		default = "Interface\\AddOns\\DBM-Core\\textures\\default.tga",
	},
	StartColorR = {
		type = "number",
		default = 1,
	},
	StartColorG = {
		type = "number",
		default = 0.7,
	},
	StartColorB = {
		type = "number",
		default = 0,
	},
	EndColorR = {
		type = "number",
		default = 1,
	},
	EndColorG = {
		type = "number",
		default = 0,
	},
	EndColorB = {
		type = "number",
		default = 0,
	},
	DynamicColor = {
		type = "boolean",
		default = true,
	},
	Width = {
		type = "number",
		default = 260,
	},
	Scale = {
		type = "number",
		default = 0.75,
	},
	HugeBarsEnabled = {
		type = "boolean",
		default = true,
	},
	HugeWidth = {
		type = "number",
		default = 215,
	},
	HugeScale = {
		type = "number",
		default = 1.05,
	},
}


-------------------------------
--  DBT Constructor/Options  --
-------------------------------
do
	local mt = {__index = DBT}
	local optionMT = {
		__index = function(t, k)
			if options[k] then
				return options[k].default
			else
				return nil
			end
		end
	}
	
	function DBT:New()
		local obj = setmetatable(
			{
				options = setmetatable({}, optionMT),
				defaultOptions = setmetatable({}, optionMT),
				mainAnchor = CreateFrame("Frame", nil, UIParent),
				secAnchor = CreateFrame("Frame", nil, UIParent),
				mainFirstBar = nil,
				mainLastBar = nil,
				secFirstBar = nil,
				secLastBar = nil,
			},
			mt
		)
		obj.mainAnchor:SetHeight(1)
		obj.mainAnchor:SetWidth(1)
		obj.mainAnchor:SetPoint("CENTER", 0, 0)
		obj.mainAnchor:SetClampedToScreen(true)
		obj.mainAnchor:SetMovable(true)
		obj.mainAnchor:Show()
		return obj
	end
	
	function DBT:LoadOptions(id)
		DBT_SavedOptions[id] = DBT_SavedOptions[id] or {}
		self.options = setmetatable(DBT_SavedOptions[id], optionMT)
	end
end

function DBT:SetOption(option, value)
	if not options[option] then
		error(("Invalid option: %s"):format(tostring(option)), 2)
	elseif options[option].type and type(value) ~= options[option].type then
		error(("The option %s requires a %s value. (tried to assign a %s value)"):format(tostring(option), tostring(options[option].type), tostring(type(value))), 2)
	elseif options[option].checkFunc then
		local ok, errMsg = options[option].checkFunc(self, option, value)
		if not ok then
			error(("Error while setting option %s to %s: %s"):format(tostring(option), tostring(value), tostring(errMsg)), 2)
		end
	end
	local oldValue = self.options[option]
	self.options[option] = value
	if options[option].onChange then
		options[option].onChange(self, value, oldValue)
	end
end

function DBT:GetOption(option)
	return self.options[option]
end



-----------------------
--  Bar Constructor  --
-----------------------
do
	local function createBarFrame(self)
		local frame
		if unusedBars[#unusedBars] then
			frame = unusedBars[#unusedBars]
			unusedBars[#unusedBars] = nil
		else
			frame = CreateFrame("Frame", "DBT_Bar_"..fCounter, self.mainAnchor, "DBTBarTemplate")
			local icon = frame:CreateTexture("DBT_Bar_"..fCounter.."Icon", "OVERLAY")
			icon:SetHeight(20)
			icon:SetWidth(20)
			icon:SetPoint("RIGHT", frame, "LEFT", 0, 0)
			fCounter = fCounter + 1
		end
		return frame
	end	
	local mt = {__index = barPrototype}
	
	function DBT:CreateDummyBar()
		local newBar
		newBar = next(unusedBarObjects, nil)
		if newBar then
			unusedBarObjects[newBar] = nil
		else
			newBar = setmetatable({}, mt)
		end
		newBar.frame = createBarFrame(self)
		newBar.id = "dummy"
		newBar.timer = 100
		newBar.totalTime = 100
		newBar.owner = self
		newBar.frame.obj = newBar
		newBar:ApplyStyle()
		newBar.frame:SetScript("OnUpdate", nil)
		return newBar
	end
	
	function DBT:CreateBar(timer, id, icon)
		local newBar = self:GetBar(id)
		if newBar then
			newBar:SetTimer(timer)
			newBar:SetElapsed(0)
		else
			newBar = next(unusedBarObjects, nil)
			if newBar then
				unusedBarObjects[newBar] = nil
			else
				newBar = setmetatable({}, mt)
			end
			newBar.prev = self.mainLastBar
			newBar.next = nil
			newBar.frame = createBarFrame(self)
			newBar.id = id
			newBar.timer = timer
			newBar.totalTime = timer
			newBar.owner = self
			if self.mainLastBar then
				self.mainLastBar.next = newBar
			end
			self.mainLastBar = newBar
			self.mainFirstBar = self.mainFirstBar or newBar		
			newBar.frame.obj = newBar
			newBar:SetPosition()
		end
		newBar.flashing = false
		newBar:ApplyStyle()
		newBar:SetText(id)
		newBar:SetIcon(icon)
		newBar:Update(0)
		return newBar
	end
end


-----------------------------
--  General Bar Functions  --
-----------------------------
do
	local function iterator(self, frame)
		return not frame and self.mainFirstBar or frame and frame.next
	end
	
	local function reverseIterator(self, frame)
		return not frame and self.mainLastBar or frame and frame.prev
	end

	function DBT:GetBarIterator(reverse)
		return (reverse and reverseIterator) or iterator, self, nil
	end
end

function DBT:GetBar(id)
	for bar in self:GetBarIterator() do
		if id == bar.id then
			return bar
		end
	end
end

function DBT:CancelBar(id)
	for bar in self:GetBarIterator() do
		if id == bar.id then
			bar:Cancel()
			return true
		end
	end
	return false
end

function DBT:UpdateBar(id, elapsed, totalTime)
	for bar in self:GetBarIterator() do
		if id == bar.id then
			bar:SetTimer(totalTime or bar.totalTime)
			bar:SetElapsed(elapsed or self.totalTime - self.timer)
			return true
		end
	end
	return false
end

---------------------------
--  General Bar Methods  --
---------------------------
function barPrototype:SetTimer(timer)
	self.totalTime = timer
	self:Update(0)
end

function barPrototype:SetElapsed(elapsed)
	self.timer = self.totalTime - elapsed
	self:Update(0)
end

function barPrototype:SetText(text)
	getglobal(self.frame:GetName().."Name"):SetText(text)
end

function barPrototype:SetIcon(icon)
	getglobal(self.frame:GetName().."Icon"):SetTexture("")
	getglobal(self.frame:GetName().."Icon"):SetTexture(icon)
end

------------------
--  Bar Update  --
------------------
function barPrototype:Update(elapsed)
	local bar = getglobal(self.frame:GetName().."Bar")
	local spark = getglobal(self.frame:GetName().."BarSpark")
	local timer = getglobal(self.frame:GetName().."Timer")
	local obj = self.owner
	self.timer = self.timer - elapsed
	if obj.options.DynamicColor then
		local r = obj.options.StartColorR  + (obj.options.EndColorR - obj.options.StartColorR) * (1 - self.timer/self.totalTime)
		local g = obj.options.StartColorG  + (obj.options.EndColorG - obj.options.StartColorG) * (1 - self.timer/self.totalTime)
		local b = obj.options.StartColorB  + (obj.options.EndColorB - obj.options.StartColorB) * (1 - self.timer/self.totalTime)
		bar:SetStatusBarColor(r, g, b)
		spark:SetVertexColor(r, g, b)
	end
	if self.timer <= 0 then
		self:Cancel()
		return
	else
		bar:SetValue(1 - self.timer/self.totalTime)
		spark:ClearAllPoints()
		spark:SetPoint("CENTER", bar, "LEFT", bar:GetValue() * bar:GetWidth(), -1)
		timer:SetText(stringFromTimer(self.timer))
	end	
	if self.timer <= 7.75 and not self.flashing and obj.options.Flash then
		self.flashing = true
		self.ftimer = 0
	end
	if self.flashing then
		local ftime = self.ftimer % 1.25
		if ftime >= 0.5 then
			bar:SetAlpha(1)
		elseif ftime >= 0.25 then
			bar:SetAlpha(1 - (0.5 - ftime) / 0.25)
		else
			bar:SetAlpha(1 - (ftime / 0.25))
		end
		self.ftimer = self.ftimer + elapsed
	end
end


-------------------
--  Movable Bar  --
-------------------
do
	local function moveEnd(self)
		for bar in self:GetBarIterator() do
			bar.frame:SetMovable(nil)
		end
		self.mainAnchor:StopMovingOrSizing()
		local point, _, _, x, y = self.mainAnchor:GetPoint(1)
		if self.OnPositionChanged then self:OnPositionChanged(point, x, y) end
	end
	
	function DBT:ShowMovableBar()
		local bar = self:CreateBar(20, "Move1", "Interface\\Icons\\Spell_Nature_WispSplode")
		bar:SetText(DBM_CORE_MOVABLE_BAR)
		for bar in self:GetBarIterator() do
			bar.frame:SetMovable(true)
		end
		DBM:Schedule(20, moveEnd, self)
	end
end


------------------
--  Bar Cancel  --
------------------
function barPrototype:Cancel()
	table.insert(unusedBars, self.frame)
	self.frame:Hide()
	self.frame.obj = nil
	if self == self.owner.mainFirstBar then
		if self.next then
			self.next.prev = nil
			self.owner.mainFirstBar = self.next
		else
			self.owner.mainFirstBar = nil
			self.owner.mainLastBar = nil
		end
	elseif self == self.owner.mainLastBar then
		if self.prev then
			self.prev.next = nil
			self.owner.mainLastBar = self.prev
		else
			self.owner.mainLastBar = nil
			self.owner.mainFirstBar = nil
		end
	else
		self.prev.next = self.next
		self.next.prev = self.prev
	end
	if self.next then
		self.next:SetPosition()
	end
	unusedBarObjects[self] = self
end


-----------------
--  Bar Style  --
-----------------
function DBT:ApplyStyle()
	for bar in self:GetBarIterator() do
		bar:ApplyStyle()
	end
end

function barPrototype:ApplyStyle()
	local bar = getglobal(self.frame:GetName().."Bar")
	local spark = getglobal(self.frame:GetName().."BarSpark")
	local texture = getglobal(self.frame:GetName().."BarTexture")
	texture:SetTexture(self.owner.options.Texture)
	bar:SetStatusBarColor(self.owner.options.ColorR, self.owner.options.ColorG, self.owner.options.ColorB)
	spark:SetVertexColor(self.owner.options.ColorR, self.owner.options.ColorG, self.owner.options.ColorB)
	self.frame:Show()
	bar:SetAlpha(1)
end

function DBT:UpdateOrientation()
	for bar in self:GetBarIterator() do
		bar:SetPosition()
	end
end
options.ExpandUpwards.onChange = DBT.UpdateOrientation

function barPrototype:SetPosition()
	local anchor = (self.prev and self.prev.frame) or self.owner.mainAnchor
	self.frame:ClearAllPoints()
	if self.owner.options.ExpandUpwards then
		self.frame:SetPoint("BOTTOM", anchor, "TOP", self.owner.options.BarXOffset, -self.owner.options.BarYOffset)
	else
		self.frame:SetPoint("TOP", anchor, "BOTTOM", self.owner.options.BarXOffset, self.owner.options.BarYOffset)
	end
end
