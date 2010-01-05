if GetLocale() ~= "esES" then return end

local L

--------------
--  Onyxia  --
--------------
L = DBM:GetModLocalization("Onyxia")

L:SetGeneralLocalization{
	name = "Onyxia"
}

L:SetWarningLocalization{
	SpecWarnBreath	= "Aliento profundo",
	WarnWhelpsSoon	= "Pronto saldran crias",
	WarnPhase2Soon		= "Fase 2 pronto",
	WarnPhase3Soon		= "Fase 3 pronto"
}

L:SetTimerLocalization{
	TimerWhelps = "Salen crias"
}

L:SetOptionLocalization{
	SpecWarnBreath	= "Mostrar aviso especial para Aliento Profundo ( Echa fuego )",
	TimerWhelps		= "Mostrar tiempo para las crias",
	WarnWhelpsSoon	= "Mostrar pre-aviso para las crias",
	SoundBreath		= "Sonido si estas en el area del fuego",
	PlaySoundOnBlastNova	= "Reproducir sonido en Nova Explosiva",
	SoundWTF				= "Reproducir sonidos divertidos de una raid legendaria de Onyxia classico",
	WarnPhase2Soon			= "Mostrar pre-aviso para Fase 2 (al ~67%)",
	WarnPhase3Soon			= "Mostrar pre-aviso para Fase 3 (al ~41%)"
}

L:SetMiscLocalization{
	YellP2 = "Este ejercicio sin sentido me aburre. �Os incenerar� a todos desde arriba!",
	YellP3 = "�Parece ser que vais a necesitar otra lecci�n, mortales!"
}
