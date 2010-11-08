local frame = CreateFrame("Frame")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
frame:SetScript("OnEvent", function(self, event, ...)
	SetMapToCurrentZone()
	local zoneId = GetCurrentMapAreaID()
	if zoneId == 764 or	-- Deadmines
	   zoneId == 756 or	-- Shadowfang Keep
	   zoneId == 768 or	-- Stonecore
	   zoneId == 753 or	-- Blackrock Caverns
	   zoneId == 769 or	-- Throne of the Tides
	   zoneId == 773 or	-- Throne of Four Winds
	   zoneId == 754 or	-- Blackwing Descent
	   zoneId == 752 or	-- Baradin Hold
	   zoneId == 758 then	-- Bastion Twilight
		printz(self)
	end
end)

function printz()
	local zone = GetRealZoneText()
	local DBM = "<DBM-Party> "
	print(DBM.."Welcome in "..zone)
	print(DBM.."We currently need more combatlogs from this zone. To help us, please log them and send the combatlogs to us.")
	print(DBM.."To start logging type:  \"/combatlog\" and \"/chatlog\". Once you finished your dungeon, you can find the logs in: \"<WoW folder> \\ Logs \\\"")
	print(DBM.."You can send the logs to: \"raanegaw@gmail.com\" .. Thank you! :D")
end