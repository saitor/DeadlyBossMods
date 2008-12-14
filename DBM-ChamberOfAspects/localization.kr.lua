if GetLocale() ~= "koKR" then return end

local L
---------------
--  샤드론  --
---------------
L = DBM:GetModLocalization("Shadron")

L:SetGeneralLocalization({
	name = "샤드론"
})


---------------
--  테네브론  --
---------------
L = DBM:GetModLocalization("Tenebron")

L:SetGeneralLocalization({
	name = "테네브론"
})


---------------
--  베스페론  --
---------------
L = DBM:GetModLocalization("Vesperon")

L:SetGeneralLocalization({
	name = "베스페론"
})


---------------
--  살타리온  --
---------------
L = DBM:GetModLocalization("Sartharion")

L:SetGeneralLocalization({
	name = "살타리온"
})

L:SetWarningLocalization({
	WarningTenebron			= "Tenebron incoming",
	WarningShadron			= "Shadron incoming",
	WarningVesperon			= "Vesperon incoming",
	WarningFireWall			= "Fire Wall!",
	WarningVesperonPortal	= "Vesperon's Portal!",
	WarningTenebronPortal	= "Tenebron's Portal!",
	WarningShadronPortal	= "Shadron's Portal!",
})

L:SetTimerLocalization({
	TimerWall	= "용암 파도 쿨다운",
	TimerTenebron	= "테네브론 진입",
	TimerShadron	= "샤드론 진입",
	TimerVesperon	= "베스페론 진입"
})

L:SetOptionLocalization({
	PlaySoundOnFireWall	= "\"용암 파도\" 소리 켜기",
	AnnounceFails		= "Post player fails for Fire Wall and Void Zone to the raid chat",

	TimerWall			= "\"용암 파도\" 타이머 보기",
	TimerTenebron		= "테네브론 타이머 보기",
	TimerShadron		= "샤드론 타이머 보기",
	TimerVesperon		= "베스페론 타이머 보기",

	WarningFireWall		= "\"용암 파도\" 특수 경보 보기",
	WarningTenebron		= "테네브론 생성 타이머 보기",
	WarningShadron		= "샤드론 생성 타이머 보기",
	WarningVesperon		= "베스페론 생성 타이머 보기",

	WarningTenebronPortal	= "테네브론 포탈 특수경보 보기",
	WarningShadronPortal	= "샤드론 포탈 특수경보 보기",
	WarningVesperonPortal	= "베스페론 포탈 특수경보 보기",
})

L:SetMiscLocalization({
	Wall			= "The lava surrounding %s churns!",
	Portal			= "%s begins to open a Twilight Portal!",
	NameTenebron	= "테네브론",
	NameShadron		= "샤드론",
	NameVesperon	= "베스페론",
	FireWallOn		= "용암 파도 : %s",
	VoidZoneOn		= "Void zone : %s",
	VoidZones		= "Void zone fails (this try): %s",
	FireWalls		= "Fire wall fails (this try): %s",
	--[[ not in use; don't translate.
	Vesperon	= "베스페론, 알이 위험하다! 날 도와라!",
	Shadron		= "샤드론! 이리 와라! 위험한 상황이다!",
	Tenebron	= "테네브론! 너도 알을 지킬 책임이 있어!"
	--]]
})
