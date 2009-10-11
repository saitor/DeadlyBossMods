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
	SpecWarnBreath	= "Глубокий вдох",
	WarnWhelpsSoon	= "Скоро вызов дракончиков",
	WarnPhase3Soon	= "Скоро начнется фаза 3"
}

L:SetTimerLocalization{
	TimerBreath	= "Глубокий вдох",
	TimerWhelps 	= "Вызов дракончиков"
}

L:SetOptionLocalization{
	SpecWarnBreath		= "Спец-предупреждение для \"Глубокого вдоха\"",
	TimerBreath		= "Отсчет времени до \"Глубокого вдоха\"",
	TimerWhelps		= "Отсчет времени до вызова дракончиков",
	WarnWhelpsSoon		= "Предупредить зарание о вызове дракончиков",
	SoundBreath		= "Звуковой сигнал, когда \"Глубокий вдох\"",
	SoundWTF		= "Воспроизводить забавное озвучивание легендарного классического рейда на Ониксию (англ.)",
	WarnPhase3Soon		= "Предупредить зарание о фазе 3 (при ~41% здоровья босса)"
}

L:SetMiscLocalization{
	Breath = "%s под воздействием Глубокого вдоха...",
	YellP2 = "Эта бессмысленная возня вгоняет меня в тоску. Я сожгу вас всех!",
	YellP3 = "Похоже, вам требуется преподать еще один урок, смертные!"
}
