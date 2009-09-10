if GetLocale() ~= "koKR" then return end
local L

------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "노스랜드의 야수"
}

L:SetMiscLocalization{
	--Charge		= "^%%s (%S+)|1을;를; 노려보며 큰 소리로 울부짖습니다.",
	Charge			= "^%%s (%S+) 노려보며 큰 소리로 울부짖습니다.",
	CombatStart		= "폭풍우 봉우리의 가장 깊고 어두운 동굴에서 온, 꿰뚫는 자 고르목일세! 영웅들이여, 전투에 임하게!",
	Phase3			= "The air itself freezes with the introduction of our next combatant, Icehowl! Kill or be killed, champions!"
	Gormok			= "꿰뚫는 자 고르목",
	Acidmaw			= "산성아귀",
	Dreadscale		= "공포비늘",
	Icehowl			= "얼음울음"	
}

L:SetOptionLocalization{
	WarningImpale				= "꿰뚫기 경보 보기",
	WarningFireBomb				= "화염 폭탄 경보 보기",
	WarningBreath				= "북극의 숨결 경보 보기",
	WarningRage					= "분노 경보 보기",
	WarningCharge				= "사나운 돌진 대상 경보 보기",
	WarningToxin				= "마비 독 대상 경보 보기",
	WarningBile					= "타오르는 담즙 대상 경보 보기",	
	SpecialWarningImpale3		= "꿰뚫기 특수 경보 보기(>=3 중첩)",
	SpecialWarningFireBomb		= "자신의 화염 폭탄 특수 경보 보기",
	SpecialWarningSlimePool		= "독 구름 특수 경보 보기",
	SpecialWarningSilence		= "주문 차단 특수 경보 보기",
	SpecialWarningSpray			= "당신이 마비의 이빨에 걸릴 경우 특수 경보 보기",
	SpecialWarningToxin			= "당신이 마비독에 걸릴 경우 특수 경보 보기",
	SpecialWarningBile			= "당신이 타오르는 담즙에 걸릴 경우 특수 경보 보기",
	SpecialWarningCharge		= "얼음울음이 당신에게 사나운 돌진을 할 경우 특수 경보 보기",
	SpecialWarningChargeNear	= "얼음울음이 당신 주변에 사나운 돌진을 할 경우 특수 경보 보기",
	SetIconOnChargeTarget		= "사나운 돌진 대상 아이콘 설정 (해골)",
	SetIconOnToxinTarget		= "마비 독 대상 아이콘 설정 (해골)",
	SetIconOnBileTarget			= "타오르는 담즙 대상 아이콘 설정",
	ClearIconsOnIceHowl			= "얼음울음의 사나운 돌진 이후 모든 공격대 아이콘 없앰",
	TimerNextBoss				= "다음 보스 등장 타이머 보기"
}

L:SetTimerLocalization{
	TimerNextBoss				= "곧 다음 보스"
}

L:SetWarningLocalization{
	WarningImpale				= " %s : >%s<",
	WarningFireBomb				= "화염 폭탄",
	WarningBreath				= "북극의 숨결",
	WarningRage					= "분노",
	WarningCharge				= "사나운 돌진 : >%s<",	
	WarningToxin				= "마비 독 : >%s<",
	WarningBile					= "타오르는 담즙 : >%s<",	
	SpecialWarningImpale3		= "당신에게 꿰뚫기(3중첩 이상)",
	SpecialWarningFireBomb		= "당신에게 화염 폭탄!",
	SpecialWarningSlimePool		= "독 구름, 벗어나세요!",
	SpecialWarningBile			= "당신에게 타오르는 담즙!",
	SpecialWarningSilence		= "1.5 초이내 주문 차단!!!",
	SpecialWarningSpray			= "당신에게 마비의 이빨!",
	SpecialWarningToxin			= "당신에게 마비독! 이동하세요!",
	SpecialWarningCharge		= "당신에게 사나운 돌진! 뛰세요!",
	SpecialWarningChargeNear	= "당신 주변에 사나운 돌진! 뛰세요!"	
}


-------------------
-- Lord Jaraxxus --
-------------------
L = DBM:GetModLocalization("Jaraxxus")

L:SetGeneralLocalization{
	name = "군주 자락서스"
}

L:SetWarningLocalization{
	WarnFlame				= "군단 불꽃 : >%s<!",
	WarnTouch				= "자락서스의 손길 : >%s<",
	WarnNetherPower			= "자락서스가 황천의 힘을 얻었습니다! 해제하세요!",
	WarnPortalSoon			= "곧 황천의 차원문!",
	WarnVolcanoSoon			= "곧 지옥불 정령 분출!",
	SpecWarnFlesh			= "당신에게 살점 소각!",
	SpecWarnTouch			= "당신에게 자락서스의 손길!",
	SpecWarnKiss			= "여군주의 키스",
	SpecWarnTouchNear		= "당신 주변에 자락서스의 손길 : >%s<",
	SpecWarnFlame			= "군단 불꽃! 뛰세요!",
	SpecWarnNetherPower		= "지금 해제!",
	SpecWarnFelInferno		= "군단 불꽃! 움직이세요!"	
}

L:SetMiscLocalization{
	WhisperFlame			= "당신에게 군단의 불꽃!",
}

L:SetOptionLocalization{
	WarnFlame				= "군단 불꽃 경고 알리기",
	WarnTouch				= "자락서스의 손길 경고 알리기",
	WarnNetherPower			= "자락서스가 황천의 힘을 얻었을 경우 경고 하기 (해제를 위한 경고)",
	WarnPortalSoon			= "황천의 차원문 생성 사전 경고 알리기",
	WarnVolcanoSoon			= "지옥불 정령 분출 사전 경고 알리기",
	SpecWarnFlame			= "군단 불꽃에 걸렸을 경우 특수 경보 알리기",
	SpecWarnFlesh			= "살점 소각에 걸렸을 경우 특수 경보 알리기",
	SpecWarnTouch			= "당신이 자락서스의 손길에 걸렸을 경우 특수 경고 알리기",
	SpecWarnTouchNear		= "당신 주변의 플레이어가 자락서스의 손길에 걸렸을 경우 특수 경고 알리기",
	SpecWarnKiss			= "당신이 여군주의 키스에 걸렸을 경우 특수 경고 알리기",
	SpecWarnNetherPower		= "황천의 힘 특수 경고 알리기 (자락서스 해제클래스-법사/사제/주술사)",
	SpecWarnFelInferno		= "당신 주변에 군단 불꽃이 있을 경우 특수 경고 알리기(바닥)",
	TouchJaraxxusIcon		= "자락서스의 손길 대상 공격대 아이콘 설정 (엑스)",
	IncinerateFleshIcon		= "살점 소각의 공격대 대상 아이콘 설정 (해골)",
	LegionFlameIcon			= "군단의 불꽃의 공격대 대상 아이콘 설정 (네모)",
	LegionFlameWhisper		= "군단의 불꽃 대상에게 귓속말 보내기",
}


-----------------------
-- Faction Champions --
-----------------------
L = DBM:GetModLocalization("Champions")

L:SetGeneralLocalization{
	name = "진영 대표 용사"
}

L:SetTimerLocalization{
	WarnHellfire		= "지옥의 불길",
	SpecWarnHellfire	= "지옥의 불길! 이동 하세요!"
}

L:SetWarningLocalization{
	WarnHellfire		= "지옥의 불길",
	SpecWarnHellfire	= "지옥의 불길! 이동 하세요!"
}

L:SetMiscLocalization{
	Gorgrim		= "죽기 - 고어그림 쉐도우클리브",		-- 34458, Horde
	Tyrius		= "죽기 - 티리우스 더스크블레이드",		-- 34461, Allience
	Birana 		= "조드 - 비라나 스톰후프",				-- 34451, Horde
	Erin		= "회드 - 에린 미스트후프",				-- 34459, Horde
	Kavina		= "조드 - 카비나 그루브송",				-- 34460, Allience
	Melador		= "회드 - 말라도르 베일스트라이더",		-- 34469, Allience
	Rujkah		= "사냥꾼 - 루즈카",					-- 34448, Horde
	Alyssia 	= "사냥꾼 - 앨리시아",					-- 34467, Allience
	Ginselle	= "마법사 - 진셀 블라이트링거",			-- 34449, Horde
	Noozle		= "마법사 - 누즐 위즐스틱",				-- 34468, Allience
	Liandra		= "신성 - 태양의 소환사 리안드리아",	-- 34445, Horde
	Malithas	= "징벌 - 말리사스 브라이트블레이드",	-- 34456, Horde
	Baelnor 	= "신성 - 빛의 인도자 밸누어",			-- 34471, Allience
	Velanaa		= "징벌 - 벨라나", 						-- 34465, Allience
	Caiphus		= "수양 - 엄격한 캐퍼스",				-- 34447, Horde
	Vivienne	= "암흑 - 검은휘파람의 비비엔느",		-- 34441, Horde
	Anthar		= "안타르 포지멘더",			 		-- 34466, Allience
	Brienna		= "암흑 - 브리에나 나이트펠",			-- 34473, Allience
	Mazdinah	= "도적 - 마즈디나",					-- 34454, Horde
	Irieth		= "도적 - 이리에스 쉐도우스텝",			-- 34472, Allience
	Thrakgar	= "정기 - 스라가",						-- 34444, Horde
	Broln		= "고양 - 브롤른 스타우트혼",			-- 34455, Horde
	Saamul		= "사아물", 							-- 34470, Allience
	Shaabad		= "고양 - 샤베드", 						-- 34463, Allience
	Harkzog		= "흑마법사 - 학조그",					-- 34450, Horde
	Serissa		= "세리사 그림데블러",					-- 34474, Allience
	Narrhok		= "전사 - 나르호크 스틸브레이커",		-- 34453, Horde
	Shocuul		= "쇼쿨",								-- 34475, Allience
	YellKill	= "상처뿐인 승리로군. 오늘 받은 손해로 우리 전력은 약해졌네. 이런 어리석은 짓으로 리치 왕 말고 또 누가 이득을 보겠나? 위대한 용사들이 목숨을 잃었네. 무엇을 위해서였나? 진짜 위협은 저 앞에 있네. 리치 왕이 우리 모두를 죽음 안에서 기다린다네.",
}

L:SetOptionLocalization{
	WarnHellfire			= "지옥의 불길을 시전할 때 경고",
	SpecWarnHellfire		= "지옥의 불길로 인해 피해를 입을 경우 특수 경고 보기"
}


------------------
-- Valkyr Twins --
------------------
L = DBM:GetModLocalization("Twins")

L:SetGeneralLocalization{
	name = "발키르 쌍둥이"
}

L:SetTimerLocalization{
	TimerSpecialSpell	= "다음 속성의 소용돌이"	
}

L:SetWarningLocalization{
	WarnSpecialSpellSoon		= "곧 속성의 소용돌이!",
	SpecWarnSpecial				= "속성(빛/어둠) 변경!",
	SpecWarnEmpoweredDarkness	= "강화된 어둠",
	SpecWarnEmpoweredLight		= "강화된 빛"
}

L:SetMiscLocalization{
	YellPull 	= "어둠의 주인님을 받들어. 리치 왕을 위하여. 너희에게. 죽음을. 안기리라.",
	Fjola 		= "피욜라 라이트베인",
	Eydis		= "아이디스 다크베인"
}

L:SetOptionLocalization{
	TimerSpecialSpell			= "다음 속성의 소용돌이의 타이머 보기",
	WarnSpecialSpellSoon		= "다음 속성의 소용돌이 사전 경고 보기",
	SpecWarnSpecial				= "속성(색) 변경을 해야할 때 특수 경고 보기",
	SpecWarnEmpoweredDarkness	= "강화된 어둠 특수 경고 보기",
	SpecWarnEmpoweredLight		= "강화된 빛 특수 경고 보기",
}


------------------
-- Anub'arak --
------------------
L = DBM:GetModLocalization("Anub'arak_Coliseum")

L:SetGeneralLocalization{
	name = "아눕아락"
}

L:SetTimerLocalization{
	TimerEmerge			= "출현",
	TimerSubmerge		= "숨기"
}

L:SetWarningLocalization{
	WarnEmerge			= "아눕아락 출현!",
	WarnEmergeSoon		= "아눕아락 10초 이내 출현!",
	WarnSubmerge		= "아눕아락 잠수!",
	WarnSubmergeSoon	= "아눕아락 10초 이내 잠수!",
	WarnPursue			= "아눕아락의 추격 : >%s<",
	SpecWarnPursue		= "당신을 추격 합니다!"
}

L:SetMiscLocalization{
	YellPull			= "여기가 네 무덤이 되리라!",
	Swarm				= "The swarm shall overtake you!",
	Emerge				= "%s 땅속에서 모습을 드러냅니다!",
	Burrow				= "%s 땅속으로 숨어버립니다!"
}

L:SetOptionLocalization{
	WarnEmerge			= "출현 경고 보기",
	WarnEmergeSoon		= "출현의 사전 경고 보기",
	WarnSubmerge		= "숨기 경고 보기",
	WarnSubmergeSoon	= "숨기의 사전 경고 보기",
	SpecWarnPursue		= "당신을 추격하기 시작할 때 특수 경고 알리기",
	TimerEmerge			= "출현 타이머 보기",
	TimerSubmerge		= "숨기 타이머 보기",
	PlaySoundOnPursue	= "당신을 추격하기 시작할 때 특수 소리 재생",
	PursueIcon			= "추격 대상자 공격대 아이콘 설정하기",
	WarnPursue			= "추격 대상자 알리기"
}