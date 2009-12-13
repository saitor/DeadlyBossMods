﻿if GetLocale() ~= "ruRU" then return end

local L

--------------
--  Onyxia  --
--------------
L = DBM:GetModLocalization("Onyxia")

L:SetGeneralLocalization{
	name = "Ониксия"
}

L:SetWarningLocalization{
	SpecWarnBreath		= "Глубокий вдох",
	SpecWarnBlastNova	= "Вспышка Огненной звезды - бегите",
	WarnWhelpsSoon		= "Скоро дракончики Ониксии",
	WarnPhase2Soon		= "Скоро фаза 2",
	WarnPhase3Soon		= "Скоро фаза 3"
}

L:SetTimerLocalization{
	TimerWhelps	= "Вызов дракончиков Ониксии"
}

L:SetOptionLocalization{
	SpecWarnBreath			= "Спец-предупреждение для Глубокого вдоха",
	SpecWarnBlastNova		= "Спец-предупреждение для Вспышки Огненной звезды",
	TimerWhelps				= "Отсчет времени до дракончиков Ониксии",
	WarnWhelpsSoon			= "Предупредить зарание о дракончиках Ониксии",
	SoundBreath				= "Звуковой сигнал, когда Глубокий вдох",
	PlaySoundOnBlastNova	= "Звуковой сигнал, когда Вспышка Огненной звезды",
	SoundWTF				= "Воспроизводить забавное озвучивание легендарного классического рейда на Ониксию (англ.)",
	WarnPhase2Soon			= "Предупредить заранее о фазе 2 (при ~67% здоровья босса)",
	WarnPhase3Soon			= "Предупредить заранее о фазе 3 (при ~41% здоровья босса)"
}

L:SetMiscLocalization{
	YellP2 = "Эта бессмысленная возня вгоняет меня в тоску. Я сожгу вас всех!",
	YellP3 = "Похоже, вам требуется преподать еще один урок, смертные!"
}

