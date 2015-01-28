﻿if GetLocale() ~= "deDE" then return end
local L

------------
--  Omen  --
------------
L = DBM:GetModLocalization("Omen")

L:SetGeneralLocalization({
	name = "Omen"
})

------------------------------
--  The Crown Chemical Co.  --
------------------------------
L = DBM:GetModLocalization("d288")

L:SetTimerLocalization{
	HummelActive		= "Hummel wird aktiv",
	BaxterActive		= "Baxter wird aktiv",
	FryeActive			= "Frye wird aktiv"
}

L:SetOptionLocalization({
	TrioActiveTimer		= "Zeige Zeit bis Apotheker aktiv werden"
})

L:SetMiscLocalization({
	SayCombatStart		= "Haben sie sich die Mühe gemacht und Euch gesagt, wer ich bin und warum ich das hier tue?"
})

----------------------------
--  The Frost Lord Ahune  --
----------------------------
L = DBM:GetModLocalization("d286")

L:SetWarningLocalization({
	Emerged			= "Aufgetaucht",
	specWarnAttack	= "Ahune ist verwundbar - Angriff!"
})

L:SetTimerLocalization{
	SubmergTimer	= "Abtauchen",
	EmergeTimer		= "Auftauchen"
}

L:SetOptionLocalization({
	Emerged			= "Zeige Warnung, wenn Ahune auftaucht",
	specWarnAttack	= "Spezialwarnung, wenn Ahune verwundbar wird",
	SubmergTimer	= "Zeige Zeit bis Abtauchen",
	EmergeTimer		= "Zeige Zeit bis Auftauchen"
})

L:SetMiscLocalization({
	Pull			= "Der Eisbrocken ist geschmolzen!"
})

----------------------
--  Coren Direbrew  --
----------------------
L = DBM:GetModLocalization("d287")

L:SetWarningLocalization({
	specWarnBrew		= "Werde das Bier los, bevor sie dir noch eins zuwirft!",
	specWarnBrewStun	= "TIPP: Du hast eine Kopfnuss kassiert, trink das Bier beim nächsten Mal!"
})

L:SetOptionLocalization({
	specWarnBrew		= "Spezialwarnung für $spell:47376",
	specWarnBrewStun	= "Spezialwarnung für $spell:47340",
	YellOnBarrel		= "Schreie bei $spell:51413"
})

L:SetMiscLocalization({
	YellBarrel			= "Stecke im Fass!"
})

-----------------------------
--  The Headless Horseman  --
-----------------------------
L = DBM:GetModLocalization("d285")

L:SetWarningLocalization({
	WarnPhase				= "Phase %d",
	warnHorsemanSoldiers	= "Pulsierende Kürbisse erscheinen",
	warnHorsemanHead		= "Kopf des Reiters aktiv"
})

L:SetOptionLocalization({
	WarnPhase				= "Zeige Warnung für jeden Phasenwechsel",
	warnHorsemanSoldiers	= "Zeige Warnung, wenn Pulsierende Kürbnisse erscheinen",
	warnHorsemanHead		= "Zeige Warnung, wenn Kopf des Reiters erscheint"
})

L:SetMiscLocalization({
	HorsemanSummon			= "Erhebe dich, Reiter,...",
	HorsemanSoldiers		= "Soldaten, erhebt Euch und kämpft immer weiter. Bringt endlich den Sieg zum gefallenen Reiter!"
})

------------------------------
--  The Abominable Greench  --
------------------------------
L = DBM:GetModLocalization("Greench")

L:SetGeneralLocalization({
	name = "Der monströse Griesgram"
})

--------------------------
--  Plants Vs. Zombies  --
--------------------------
L = DBM:GetModLocalization("PlantsVsZombies")

L:SetGeneralLocalization({
	name = "Pflanzen gegen Zombies"
})

L:SetWarningLocalization({
	warnTotalAdds	= "Anzahl erschienener Zombies seit letzter Riesiger Welle: %d",
	specWarnWave	= "Riesige Welle!"
})

L:SetTimerLocalization{
	timerWave		= "Nächste Riesige Welle"
}

L:SetOptionLocalization({
	warnTotalAdds	= "Verkünde die Anzahl der erschienenen Zombies zwischen jeder Riesigen Welle",
	specWarnWave	= "Spezialwarnung, wenn eine Riesige Welle beginnt",
	timerWave		= "Zeige Zeit bis nächste Riesige Welle"
})

L:SetMiscLocalization({
	MassiveWave		= "Eine riesige Zombiewelle nähert sich!" --needs to be verified (video-captured translation)
})

--------------------------
--  Garrison Invasions  --
--------------------------
L = DBM:GetModLocalization("GarrisonInvasions")

L:SetGeneralLocalization({
	name = "Garnisionsinvasionen"
})
---- TODO: translate ----
L:SetWarningLocalization({
	specWarnRylak	= "Darkwing Scavenger Incoming",
	specWarnWorker	= "Terrified worker in open",
	specWarnSpy		= "A spy has snuck in",
	specWarnBuilding= "A building is being attacked"
})

L:SetOptionLocalization({
	specWarnRylak	= "Show special warning when a rylak is incoming",
	specWarnWorker	= "Show special warning when a terrified worker is caught in open",
	specWarnSpy		= "Show special warning when a spy has snuck in",
	specWarnBuilding= "Show special warning when a building is under attack"
})

L:SetMiscLocalization({
	--General
	preCombat			= "To arms! To your posts!",--Common in all yells, rest varies based on invasion
	preCombat2			= "The air has taken a turn for the foul...",--Shadow Council doesn't follow format of others :\
	rylakSpawn			= "The commotion of the battle attracts a rylak!",--Source npc Darkwing Scavenger, target playername
	terrifiedWorker		= "A terrified worker is caught in the open!",
	sneakySpy			= "spy has snuck in amidst the chaos!",--Shortened to cut out "horde/alliance"
	buildingAttack		= "Your %s is under attack!",--Your Salvage Yard is under attack!
	--Ogre
	GorianwarCaller		= "A Gorian Warcaller joins the battle to raise morale!",--Maybe combined "add" special warning most adds?
	WildfireElemental	= "A Wildfire Elemental is being summoned at the front gates!",--Maybe combined "add" special warning most adds?
	--Iron Horde
	Assassin			= "An Assassin is hunting your guards!"--Maybe combined "add" special warning most adds?
})
