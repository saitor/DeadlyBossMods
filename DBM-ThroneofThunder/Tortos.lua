local mod	= DBM:NewMod(825, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(67977)
mod:SetModelID(46559)
mod:SetUsedIcons(8, 7, 6, 5, 4, 3)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"UNIT_AURA"
)

local warnBite						= mod:NewSpellAnnounce(135251, 3, nil, mod:IsTank())
local warnRockfall					= mod:NewSpellAnnounce(134476, 2)
local warnCallofTortos				= mod:NewSpellAnnounce(136294, 3)
local warnQuakeStomp				= mod:NewCountAnnounce(134920, 3)
local warnKickShell					= mod:NewAnnounce("warnKickShell", 2, 134031)
local warnStoneBreath				= mod:NewCastAnnounce(133939, 4)
local warnShellConcussion			= mod:NewTargetAnnounce(136431, 1)

local specWarnCallofTortos			= mod:NewSpecialWarningSpell(136294)
local specWarnQuakeStomp			= mod:NewSpecialWarningSpell(134920, nil, nil, nil, 2)
local specWarnRockfall				= mod:NewSpecialWarningSpell(134476, false, nil, nil, 2)
local specWarnStoneBreath			= mod:NewSpecialWarningInterrupt(133939)
local specWarnCrystalShell			= mod:NewSpecialWarning("specWarnCrystalShell", false)

local timerBiteCD					= mod:NewCDTimer(8, 135251, nil, mod:IsTank())
local timerRockfallCD				= mod:NewCDTimer(10, 134476)
local timerCallTortosCD				= mod:NewNextTimer(60.5, 136294)
local timerStompCD					= mod:NewNextCountTimer(49, 134920)
local timerBreathCD					= mod:NewCDTimer(46, 133939)
local timerStompActive				= mod:NewBuffActiveTimer(10.8, 134920)--Duration f the rapid caveins??
local timerShellConcussion			= mod:NewBuffFadesTimer(20, 136431)

local berserkTimer					= mod:NewBerserkTimer(780)

mod:AddBoolOption("InfoFrame")
if GetLocale() == "koKR" then
	mod:AddBoolOption("SetIconOnTurtles", false)
else
	mod:AddBoolOption("SetIconOnTurtles", true)
end

local shelldName = GetSpellInfo(137633)
local shellConcussion = GetSpellInfo(136431)
local stompActive = false
local stompCount = 0
local firstRockfall = false--First rockfall after a stomp
local shellsRemaining = 0
local lastConcussion = 0
local kickedShells = {}
local addsActivated = 0
local alternateSet = false
local adds = {}
local AddIcon = 8
local iconsSet = 0
local highestVersion = 0
local hasHighestVersion = false

local function resetaddstate()
	table.wipe(adds)
	if addsActivated >= 1 then--1 or more add is up from last set
		if alternateSet then--We check whether we started with skull last time or moon
			AddIcon = 5--Start with moon if we used skull last time
			alternateSet = false
		else
			AddIcon = 8--Start with skull if we used moon last time
			alternateSet = true
		end
	else--No turtles are up at all
		AddIcon = 8--Always start with skull
		alternateSet = true--And reset alternate status so we use moon next time (unless all are dead again, then re always reset to skull)
	end
	iconsSet = 0
end
	
mod:RegisterOnUpdateHandler(function(self)
	if hasHighestVersion and not iconsSet == 3 then
		for i = 1, DBM:GetNumGroupMembers() do
			local uId = "raid"..i.."target"
			local guid = UnitGUID(uId)
			if adds[guid] then
				SetRaidTarget(uId, adds[guid])
				iconsSet = iconsSet + 1
				adds[guid] = nil
			end
			local guid2 = UnitGUID("mouseover")
			if adds[guid2] then
				SetRaidTarget(uId, adds[guid2])
				iconsSet = iconsSet + 1
				adds[guid2] = nil
			end
		end
	end
end, 0.2)

local function clearStomp()
	stompActive = false
	firstRockfall = false--First rockfall after a stomp
	if mod:AntiSpam(9, 1) then--prevent double warn.
		warnRockfall:Show()
		specWarnRockfall:Show()
		timerRockfallCD:Start()--Resume normal CDs, first should be 5 seconds after stomp spammed ones
	end
end

function mod:OnCombatStart(delay)
	stompActive = false
	stompCount = 0
	firstRockfall = false--First rockfall after a stomp
	shellsRemaining = 0
	lastConcussion = 0
	addsActivated = 0
	AddIcon = 8
	iconsSet = 0
	alternateSet = false
	table.wipe(adds)
	table.wipe(kickedShells)
	timerRockfallCD:Start(15-delay)
	timerCallTortosCD:Start(21-delay)
	timerStompCD:Start(29-delay, 1)
	timerBreathCD:Start(-delay)
	berserkTimer:Start(-delay)
	if self.Options.InfoFrame and self:IsDifficulty("heroic10", "heroic25") then
		DBM.InfoFrame:SetHeader(L.WrongDebuff:format(shelldName))
		DBM.InfoFrame:Show(5, "playergooddebuff", 137633)
	end
	if self:GetRaidRank() > 0 and self.Options.SetIconOnTurtles then--You can set marks and you have icons turned on
		self:SendSync("IconCheck", UnitGUID("player"), tostring(DBM.Revision))
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 133939 then
		warnStoneBreath:Show()
		specWarnStoneBreath:Show(args.sourceName)
		timerBreathCD:Start()
	elseif args.spellId == 136294 then
		warnCallofTortos:Show()
		specWarnCallofTortos:Show()
		if self:AntiSpam(59, 3) then -- On below 10%, he casts Call of Tortos always. This cast ignores cooldown, so filter below 10% cast.
			timerCallTortosCD:Start()
		end
	elseif args.spellId == 135251 then
		warnBite:Show()
		timerBiteCD:Start()
	elseif args.spellId == 134920 then
		stompActive = true
		stompCount = stompCount + 1
		warnQuakeStomp:Show(stompCount)
		specWarnQuakeStomp:Show()
		timerStompActive:Start()
		timerRockfallCD:Start(7.4)--When the spam of rockfalls start
		timerStompCD:Start(49, stompCount+1)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 133971 then--Shell Block (turtles dying and becoming kickable)
		shellsRemaining = shellsRemaining + 1
		addsActivated = addsActivated - 1
	elseif args.spellId == 133974 and self.Options.SetIconOnTurtles then--Spinning Shell
		if self:AntiSpam(5, 2) then
			resetaddstate()
		end
		adds[args.destGUID] = AddIcon
		AddIcon = AddIcon - 1
		addsActivated = addsActivated + 1
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 137633 and args:IsPlayer() then
		specWarnCrystalShell:Show(shelldName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 134476 then
		if stompActive then--10 second cd normally, but cd is disabled when stomp active
			if not firstRockfall then--Announce first one only and ignore the next ones spammed for about 9-10 seconds
				firstRockfall = true
				warnRockfall:Show()
				specWarnRockfall:Show()--To warn of massive incoming for the 9 back to back rockfalls that are incoming
				self:Schedule(10, clearStomp)
			end
		else
			if self:AntiSpam(9, 1) then--sometimes clearstomp doesn't work? i can't find reason cause all logs match this system exactly.
				warnRockfall:Show()
				specWarnRockfall:Show()
				timerRockfallCD:Start()
			end
		end
	elseif args.spellId == 134031 and not kickedShells[args.destGUID] then--Kick Shell
		kickedShells[args.destGUID] = true
		shellsRemaining = shellsRemaining - 1
		warnKickShell:Show(args.spellName, args.sourceName, shellsRemaining)
	end
end

function mod:UNIT_AURA(uId)
	if uId ~= "boss1" then return end
	local _, _, _, _, _, duration, expires = UnitDebuff(uId, shellConcussion)
	if expires and lastConcussion ~= expires then
		lastConcussion = expires
		timerShellConcussion:Start()
		if self:AntiSpam(3, 2) then
			warnShellConcussion:Show(L.name)
		end
	end
end

local function FindFastestHighestVersion()
	DBM:SendSync("FastestPerson", UnitGUID("player"))
end

function mod:OnSync(msg, guid, ver)
	if msg == "IconCheck" and guid and ver then
		if tonumber(ver) > highestVersion then
			highestVersion = tonumber(ver)--Keep bumping highest version to highest we recieve from the icon setters
			if guid == UnitGUID("player") then--Check if that highest version was from ourself
				hasHighestVersion = true
				self:Unschedule(FindFastestHighestVersion)
				self:Schedule(5, FindFastestHighestVersion)
			else--Not from self, it means someone with a higher version than us probably sent it
				self:Unschedule(FindFastestHighestVersion)
				hasHighestVersion = false
			end
		end
	elseif msg == "FastestPerson" and guid and self:AntiSpam(10, 4) then--Whoever sends this sync first wins all. They have highest version and fastest computer
		self:Unschedule(FindFastestHighestVersion)
		if guid == UnitGUID("player") then
			hasHighestVersion = true
			print("DBM Debug: You have highest DBM version with icons enabled and fastest computer. You designated icon setter.")
		else
			hasHighestVersion = false
			print("DBM Debug: You will not be setting icons since your DBM version is out of date or your computer is slower")
		end
	end
end
