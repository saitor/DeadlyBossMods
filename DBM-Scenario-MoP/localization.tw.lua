﻿if GetLocale() ~= "zhTW" then return end
local L

----------------------
-- Theramore's Fall --
----------------------

L= DBM:GetModLocalization("TheramoreFall")

L:SetGeneralLocalization{
	name = "賽拉摩攻防戰"
}

L:SetMiscLocalization{
	AllianceVictory = "All of you have my deepest thanks. With the Focusing Iris removed, this lifeless bomb is merely a sickening testament to Garrosh's brutality. The winds of change blow fiercely; Azeroth is on the brink of war. My apologies, but you must excuse me... I have much to consider. Farewell.", --translate (trigger)
	HordeVictory	= "Danke! Sollen wir von dieser elenden kleinen Insel verschwinden?"
}