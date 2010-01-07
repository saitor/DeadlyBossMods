﻿if GetLocale() ~= "koKR" then return end

local L

---------------------------
--  Trash - Lower Spire  --
---------------------------
L = DBM:GetModLocalization("LowerSpireTrash")

L:SetGeneralLocalization{
	name = "성채 하층부 일반몹"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	SetIconOnDarkReckoning		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69483)
}

L:SetMiscLocalization{
	WarderTrap1		= "거기... 누구냐?",
	WarderTrap2		= "주인님의 성소를 어지럽혔구나!"
}

---------------------------
--  Trash - Plagueworks  --
---------------------------
L = DBM:GetModLocalization("PlagueworksTrash")

L:SetGeneralLocalization{
	name = "역병작업장 일반몹"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name = "군주 매로우가르"
}

L:SetTimerLocalization{
	achievementBoned	= "탈출 시간"
}

L:SetWarningLocalization{
	WarnImpale				= "꿰뚫기 : >%s<"
}

L:SetOptionLocalization{
	WarnImpale				= "$spell:69062 대상 알리기",
	achievementBoned		= "뼈도 못 추릴라 업적 타이머 보기",	
	SetIconOnImpale			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69062)
}

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization{
	name = "여교주 데스위스퍼"
}

L:SetTimerLocalization{
	TimerAdds						= "이교도 추가"
}

L:SetWarningLocalization{
	WarnReanimating					= "이교도 부활",			-- Reanimating an adherent or fanatic
	WarnTouchInsignificance			= "%s : >%s< (%s)",		-- Touch of Insignificance on >args.destName< (args.amount)
	WarnAddsSoon					= "곧 새로운 이교도 추가"
}

L:SetOptionLocalization{
	WarnAddsSoon					= "이교도 추가 사전 경고 보기",
	WarnReanimating					= "이교도를 부활 할 경우 경고 보기",								-- Reanimated Adherent/Fanatic spawning
	TimerAdds						= "새로운 이교도 추가 타이머 보기",
	ShieldHealthFrame				= "$spell:70842의 방어막 바와 보스 체력바를 함께 보기",	
	WarnTouchInsignificance			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71204, GetSpellInfo(71204) or "unknown"),	-- Warning isnt default (it has a count number), option is default tho (no need for translation this way)
	SetIconOnDominateMind			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71289),
	SetIconOnDeformedFanatic		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70900),
	SetIconOnEmpoweredAdherent		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70901)
}

L:SetMiscLocalization{
	YellPull						= "이게 무슨 소란이지? 감히 이 신성한 땅을 지나가려 해? 여기가 마지막 숨을 거둘 곳이 되리라!",
	YellReanimatedFanatic			= "일어나라, 순수한 모습을 기뻐하라!",
	ShieldPercent					= "마나 방벽"
}

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization{
	name = "얼음왕관 비행선 전투"
}

L:SetWarningLocalization{
	WarnBattleFury		= "%s (%d)",
	WarnAddsSoon		= "곧 추가 몹"
}

L:SetOptionLocalization{
	WarnBattleFury		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(69638, GetSpellInfo(69638) or "전투 격노"),
	TimerCombatStart	= "전투 시작 타이머 보기",
	WarnAddsSoon		= "몹 생성 사전 경고 보기",
	TimerAdds			= "추가 몹 타이머 보기"
}

L:SetTimerLocalization{
	TimerCombatStart	= "전투 시작",
	TimerAdds			= "추가 몹"
}

L:SetMiscLocalization{
	PullAlliance		= "속도를 올려라! 제군들, 곧 운명과 마주할 것이다!",
	KillAlliance		= "악당 놈들, 분명히 경고했다! 형제자매여, 전진!",
	PullHorde			= "호드의 아들딸이여, 일어나라! 오늘 우리는 증오하던 적과 전투를 벌이리라! 록타르 오가르!",
	KillHorde			= "얼라이언스는 기가 꺾였다. 리치 왕을 향해 전진하라!"
}

-----------------------------
--  Deathbringer Saurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name = "죽음의 인도자 사울팽"
}

L:SetWarningLocalization{
	warnFrenzySoon			= "곧 광기"
}

L:SetTimerLocalization{
	TimerCombatStart		= "전투 시작"
}

L:SetOptionLocalization{
	TimerCombatStart		= "전투 시작 타이머 보기",
	warnFrenzySoon			= "광기 사전 경고 보기 (33% 이하)",
	SetIconOnBoilingBlood	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72441),
	SetIconOnMarkCast		= "$spell:72444 대상에게 공격대 아이콘 설정",	
	RangeFrame				= "거리 프레임 보기 (11 미터)",
	RunePowerFrame			= "보스 체력 바와 함께 $spell:72371 바 보기"	
}

L:SetMiscLocalization{
	RunePower				= "피 마력",
	Pull					= "코르크론, 출발하라! 용사들이여, 뒤를 조심하게. 스컬지는..."
}

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization{
	name = "구린속"
}

L:SetWarningLocalization{
	InhaledBlight		= "파멸의 역병 들이마심 : >%d<",
	WarnGastricBloat	= "%s : >%s< (%s)",		-- Gastric Bloat on >args.destName< (args.amount)
}

L:SetOptionLocalization{
	InhaledBlight		= "$spell:71912 경고 보기",
	WarnGastricBloat	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(72551, GetSpellInfo(72551) or "알 수 없음"),	
	SetIconOnGasSpore	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69279)
}

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization{
	name = "썩은얼굴"
}

L:SetWarningLocalization{
	WarnOozeSpawn				= "작은 수액괴물 생성",
	WarnUnstableOoze			= "%s : >%s< (%s)"			-- Unstable Ooze on >args.destName< (args.amount)
}

L:SetTimerLocalization{
	NextPoisonSlimePipes		= "다음 수액 홍수"
}

L:SetOptionLocalization{
	NextPoisonSlimePipes		= "다음 수액 홍수 타이머 보기",
	WarnOozeSpawn				= "작은 수액괴물 생성 경고 보기",
	WarnUnstableOoze			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(69558, GetSpellInfo(69558) or "알 수 없음"),	
	InfectionIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71224),
	ExplosionIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69839)
}

L:SetMiscLocalization{
	YellSlimePipes1				= "좋은 소식이에요, 여러분! 독성 수액 배출관을 고쳤어요!",	-- Professor Putricide
	YellSlimePipes2				= "끝내 주는 소식이에요, 여러분! 수액이 다시 나오는군요!"	-- Professor Putricide	
}

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization{
	name = "교수 퓨트리사이드"
}

L:SetWarningLocalization{
	WarnPhase2Soon		= "곧 2 페이즈",
	WarnPhase3Soon		= "곧 3 페이즈",
	WarnMutatedPlague	= "%s : >%s< (%s)"			-- Mutated Plague on >args.destName< (args.amount)
}

L:SetOptionLocalization{
	WarnPhase2Soon			= "2 페이즈 사전 경고 보기(83% 이하)",
	WarnPhase3Soon			= "3 페이즈 사전 경고 보기(38% 이하)",
	WarnMutatedPlague		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(72451, GetSpellInfo(72451) or "알 수 없음"),
	OozeAdhesiveIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70447),
	GaseousBloatIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70672)
}

L:SetMiscLocalization{
	YellPull		= "좋은 소식이에요, 여러분! 아제로스의 모든 생명체를 파괴할 역병을 완성했어요!"
}

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization{
	name = "피의 공작 의회"
}

L:SetWarningLocalization{
	WarnTargetSwitch		= "Switch target to: %s",		-- Ugh, no nice spellname/id to use for general localization :(
	WarnTargetSwitchSoon	= "곧 대상 전환",			-- Spellname = Invocation of Blood   or   Spellname = Invocation of Blood (X) Move  (server side script where X indicates the first letter of the Prince name
	SpecWarnResonance		= "Shadow Resonance - Move"
}

L:SetTimerLocalization{
	TimerTargetSwitch		= "Possible target switch"
}

L:SetOptionLocalization{
	WarnTargetSwitch		= "대상 전환 경고 보기",								-- Warn when another Prince needs to be damaged
	WarnTargetSwitchSoon	= "대상 전환 사전 경고 보기",							-- Every ~31 secs, you have to dps a different Prince
	TimerTargetSwitch		= "대상 전환 쿨다운 타이머 보기wn",
	SpecWarnResonance		= "Show special warning when a Dark Nucleus is following you"	-- If it follows you, you have to move to the tank
}

L:SetMiscLocalization{
	Keleseth				= "공작 켈레세스",
	Taldaram				= "공작 탈다람",
	Valanar					= "공작 발라나르"
}

-----------------------
--  Queen Lana'thel  --
-----------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization{
	name = "피의 여왕 라나텔"
}

L:SetWarningLocalization{
	SpecWarnPactDarkfallen	= "Pact of the Darkfallen on you"
}

L:SetOptionLocalization{
	SpecWarnPactDarkfallen	= "Show special warning when you are affected by Pact of the Darkfallen"
}

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization{
	name = "발리스리아 드림워커"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

------------------
--  Sindragosa  --
------------------
L = DBM:GetModLocalization("Sindragosa")

L:SetGeneralLocalization{
	name = "신드라고사"
}

L:SetTimerLocalization{
	TimerNextAirphase		= "다음 공중 페이즈",
	TimerNextGroundphase	= "다음 지상 페이즈"
}

L:SetWarningLocalization{
	WarnAirphase			= "공중 페이즈",
	SpecWarnBlisteringCold	= "얼음 손아귀! 뛰세요!",
	SpecWarnFrostBeacon		= "당신에게 냉기 봉화",
	WarnGroundphaseSoon		= "곧 신드라고사 착륙",
	SpecWarnUnchainedMagic	= "당신에게 해방된 마법"
}

L:SetOptionLocalization{
	WarnAirphase			= "공중 페이즈 알리기",
	SpecWarnBlisteringCold	= "얼음 손아귀 특수 경고 보기",
	SpecWarnFrostBeacon		= "냉기 봉화에 영향을 받을 경우 특수 경고 보기",
	WarnGroundphaseSoon		= "지상 페이즈 사전 경고 보기",
	TimerNextAirphase		= "다음 공중 페이즈 타이머 보기",
	TimerNextGroundphase	= "다음 지상 페이즈 타이머 보기",
	SpecWarnUnchainedMagic	= "해방된 마법의 영향을 받을 경우 특수 경고 보기"
}

L:SetMiscLocalization{
	YellAirphase			= "Your incursion ends here! None shall survive!",
	YellPull				= "You are fools to have come to this place. The icy winds of Northrend will consume your souls!"
}

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization({
	name = "리치 왕"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})
