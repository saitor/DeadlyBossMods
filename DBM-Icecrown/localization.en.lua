local L


----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name = "Lord Marrowgar"
}

L:SetWarningLocalization{
	specWarnWhirlwind			= "Whirlwind! Run away!",
	specWarnColdflame			= "Coldflame, MOVE!"
}

L:SetOptionLocalization{
	specWarnWhirlwind			= "Show special warning for Whirlwind",
	specWarnColdflame			= "Show special warning when you take damage from Coldflame",
	PlaySoundOnWhirlwind		= "Play sound for Whirlwind"
}