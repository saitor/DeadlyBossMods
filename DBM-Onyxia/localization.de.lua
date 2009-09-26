
if GetLocale() ~= "deDE" then return end

local L

--------------
--  Onyxia  --
--------------
L = DBM:GetModLocalization("Onyxia")

L:SetGeneralLocalization{
   name = "Onyxia"
}

L:SetWarningLocalization{
   SpecWarnBreath	= "Tiefer Atem",
   WarnWhelpsSoon	= "Welpen kommen bald",
}

L:SetTimerLocalization{
   TimerBreath	= "Tiefer Atem",
   TimerWhelps	= "Welpenspawn"
}

L:SetOptionLocalization{
   SpecWarnBreath	= "Zeige Spezialwarnung f�r tiefen Atem",
   TimerBreath		= "Zeige Timer f�r tiefen Atem",
   TimerWhelps		= "Zeige Timer f�r Welpenspawn",
   WarnWhelpsSoon	= "Zeige Vorwarnung f�r Welpenspawn",
   SoundBreath		= "Spiele Sound bei tiefem Atem",
   SoundWTF			= "Spiele witzige Sounds eines legend�ren Onyxia-Classic-Raids"
}

L:SetMiscLocalization{
   Breath = "%s atmet tief ein...",
   YellP2 = "Diese sinnlose Anstrengung langweilt mich. Ich werde Euch alle von oben verbrennen!",
   YellP3 = "Mir scheint, dass Ihr noch eine Lektion braucht, sterbliche Wesen!"
}


