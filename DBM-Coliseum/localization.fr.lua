if GetLocale() ~= "frFR" then return end

local L

------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "Les B�tes du Norfendre"
}

L:SetMiscLocalization{
	Charge	= "^%%s glares at (%S+) and lets out",
}

L:SetOptionLocalization{
	WarningImpale				= "Montre une alerte sp�ciale pour Empaler",
	WarningFireBomb				= "Montre une alerte sp�ciale pour les Bombe incendiaire",
	WarningBreath				= "Montre une alerte sp�ciale pour les Souffle arctique",
--	WarningSpray				= "Montre une alerte sp�ciale pour les Jet paralysant",
	WarningRage					= "Montre une alerte sp�ciale pour la Rage �cumeuse",
	WarningCharge				= "Montre une alerte sp�ciale pour la cible de la charge",
	SpecialWarningImpale3		= "Montre une alerte sp�ciale pour l'empaler (>=3 Stacks)",
	SpecialWarningFireBomb		= "Montre une alerte sp�ciale quand la Bombe incendiaire est sur vous",
	SpecialWarningSlimePool		= "Montre une alerte sp�ciale pour les Flaque de bave",
	SpecialWarningSilence		= "Montre une alerte sp�ciale pour le Pi�tinement ahurissant",
	SpecialWarningSpray			= "Montre une alerte sp�ciale si vous �tes victime d'un Jet paralysant",
	SpecialWarningToxin			= "Montre une alerte sp�ciale si vous �tes victime de la Toxine paralysante",
	SpecialWarningCharge		= "Montre une alerte sp�ciale quand Icehowl est sur le point de vous charger",
	SpecialWarningChargeNear	= "Montre une alerte sp�ciale quand Icehowl charge a coter de vous",
	SetIconOnChargeTarget		= "Met une icone sur la cible de la charge ( T�te de mort )"
}

L:SetWarningLocalization{
	WarningImpale				= "%s sur >%s<",
	WarningFireBomb				= "Bombe incendiaire",
--	WarningSpray				= "%s sur >%s<",
	WarningBreath				= "Souffle arctique",
	WarningRage					= "Rage �cumeuse",
	WarningCharge				= "Charge sur >%s<",
	SpecialWarningImpale3		= "Empaler >%d< sur VOUS",
	SpecialWarningFireBomb		= "Bombe incendiaire sur VOUS",
	SpecialWarningSlimePool		= "Flaque de bave, BOUGEZ!",
	SpecialWarningSilence		= "Pi�tinement ahurissant dans 0.5 Seconde!",
	SpecialWarningSpray			= "Jet paralysant",
	SpecialWarningToxin			= "Toxine paralysante sur vous, BOUGEZ!",
	SpecialWarningCharge		= "Charge sur vous! COUREZ!",
	SpecialWarningChargeNear	= "Charge a coter de vous! COUREZ!"
}



