local mod	= DBM:NewMod(324, "DBM-DragonSoul", nil, 187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(55308)
mod:SetModelID(39138)
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"UNIT_SPELLCAST_SUCCEEDED",
	"CHAT_MSG_MONSTER_YELL"
)

local warnVoidofUnmaking		= mod:NewSpellAnnounce(103571, 4, 103527)
local warnVoidDiffusion			= mod:NewStackAnnounce(106836, 2)
local warnFocusedAnger			= mod:NewStackAnnounce(104543, 3, nil, false)
local warnPsychicDrain			= mod:NewSpellAnnounce(104322, 4)
local warnShadows				= mod:NewSpellAnnounce(103434, 3)

local specWarnVoidofUnmaking	= mod:NewSpecialWarningSpell(103571, nil, nil, nil, true)
local specWarnBlackBlood		= mod:NewSpecialWarningSpell(104378, nil, nil, nil, true)
local specWarnPsychicDrain		= mod:NewSpecialWarningSpell(104322, false)
local specWarnShadows			= mod:NewSpecialWarningYou(103434)
local yellShadows				= mod:NewYell(103434, nil, false, L.ShadowYell)--Requested by 10 man guilds, but a spammy mess in 25s, so off by default. With the option to enable when desired.

local timerVoidofUnmakingCD		= mod:NewCDTimer(6, 103571, nil, nil, nil, 103527)
local timerVoidDiffusionCD		= mod:NewCDTimer(5, 106836)--Can not be triggered more then once per 5 seconds.
local timerFocusedAngerCD		= mod:NewCDTimer(6, 104543, nil, false)--Off by default as it may not be entirely useful information to know, but an option just for heck of it. You know SOMEONE is gonna request it
local timerPsychicDrainCD		= mod:NewCDTimer(20, 104322)--Every 20-25 seconds, variates.
local timerShadowsCD			= mod:NewCDTimer(25, 103434)--Every 25-30, variates
local timerBlackBlood			= mod:NewBuffActiveTimer(30, 104378)

local berserkTimer				= mod:NewBerserkTimer(360)

mod:AddBoolOption("RangeFrame", true)--For heroic shadows, with debuff filtering.
mod:AddBoolOption("NoFilterRangeFrame", false)--For those that want the range frame to simply work as it used to, always show everyone.

local shadowsTargets = {}
local phase2Started = false
local voidWarned = false
--local voidStacks = 0

--[[
local voidTimers = { -- all timers is guessed and can't find in my logs (: please check this,
	[0] = 48, --Unknown
	[1] = 43, -- confirmed in my latest lfr.
	[2] = 38, --Unknown
	[3] = 33, --Confirmed 33 on 10 man heroic and 10 man normal
	[4] = 28, --Unknown
	[5] = 22, --Confirmed 22 normal 10 and normal 25
	[6] = 9.5, --Questionable 9.5 on 10 man normal. Had one log with this timing but it makes no sense. I'd like to verify it further. This makes no sense in the pattern. maybe a bad time stamp, 19.5 would make more sense IMO
	[7] = 12, --Confirmed, 3 seconds earlier then heroic in both 10 and 25 normal.
	[8] = 12, --Assumed, based on normal being -3 from heroic
	[9] = 12, --Assumed, based on normal being -3 from heroic
	[10]= 6 --Confirmed
}
local heroicvoidTimers = { -- all timers is guessed and can't find in my logs (: please check this,
	[0] = 48, --Unknown
	[1] = 43, --Unknown in my latest lfr.
	[2] = 38, --Unknown
	[3] = 33, --Confirmed 33 on 10 man heroic and 10 man normal
	[4] = 28, --Unknown
	[5] = 22, --Unknown for heroic, could be 22, or 25. the 9 7 7 5 strategy lacks the luxury of seeing the 4th black phase end :(
	[6] = 12.5, --Unknown. the normal version doesn't even make much sense, 
	[7] = 15, --Confirmed in 10 heroic and 25 man heroic
	[8] = 15, --Unknown, but unlikely changed being in the middle of 7 and 9
	[9] = 15, --Confirmed in 10 heroic and 25 man heroic
	[10]= 6 --Unknown, is it +3 seconds from normal, or the same?
}

3 stack normal 10:
[21:30:17.044] Void of the Unmaking afflicted by Void Diffusion (3) from Void of the Unmaking
[21:30:25.671] Anshlun afflicted by Black Blood of Go'rath from Warlord Zon'ozz
[21:30:55.671] Anshlun fake arg
[21:31:37.872] Warlord Zon'ozz casts Psychic Drain (42)
3 stack heroic 10:
[22:30:48.983] Void of the Unmaking afflicted by Void Diffusion (3) from Void of the Unmaking
[22:30:59.993] Karnadas afflicted by Black Blood of Go'rath from Eye of Go'rath
[22:31:29.993] Karnadas fake arg
[22:32:11.796] Warlord Zon'ozz casts Psychic Drain (42 on heroic as well, disproves the +3 theory being across the board)

5 Stack normal 25:
[21:04:36.002] Void of the Unmaking afflicted by Void Diffusion (5) from Void of the Unmaking
[21:04:44.710] Shiramune afflicted by Black Blood of Go'rath from Warlord Zon'ozz
[21:05:14.710] Shiramune fake arg
[21:05:46.022] Warlord Zon'ozz casts Psychic Drain (30-31.5 sec for 5 stack on 25 man normal)
5 Stack normal 10:
[20:49:05.332] Void of the Unmaking afflicted by Void Diffusion (5) from Void of the Unmaking
[20:49:14.223] Erej afflicted by Black Blood of Go'rath from  Warlord Zon'ozz
[20:50:44.223] Erej fake arg
[20:50:15.600]  Warlord Zon'ozz casts Psychic Drain (30-31.5 sec for a 5 stack on 10 man normal)

6 Stack normal 10:
[19:39:15.772] Void of the Unmaking afflicted by Void Diffusion (6) from Void of the Unmaking
[19:39:26.244] Erej afflicted by Black Blood of Go'rath from Warlord Zon'ozz
[19:39:56.244] Erej fake arg
[19:40:14.372] Warlord Zon'ozz casts Psychic Drain (18 sec for a 6 stack on 10 man normal)

7 stack normal 25:
[19:46:42.409] Void of the Unmaking afflicted by Void Diffusion (7) from Void of the Unmaking
[19:46:51.628] Shiramune afflicted by Black Blood of Go'rath from Warlord Zon'ozz
[19:47:21.628] Shiramune fake arg
[19:47:42.127] Warlord Zon'ozz casts Psychic Drain (drain was 20.5 seconds later)
7 Stack heroic 25:
[19:43:52.721] Void of the Unmaking afflicted by Void Diffusion (7) from Void of the Unmaking
[19:44:03.283] Shiramune afflicted by Black Blood of Go'rath from Eye of Go'rath
[19:44:33.283] Shiramune fake arg
[19:44:56.201] Void of the Unmaking afflicted by Void Diffusion from Void of the Unmaking
[19:44:56.998] Warlord Zon'ozz casts Psychic Drain (drain was 23 seconds later, over multiple logs the variation was 23-24, 23.5 is the consistent average, maybe heroic adds +3?)
7 Stack normal 10:
[19:33:50.795] Void of the Unmaking afflicted by Void Diffusion (7) from Void of the Unmaking
[19:34:00.051] Erej afflicted by Black Blood of Go'rath from Warlord Zon'ozz
[19:34:30.051] Erej fake arg
[19:34:50.520] Warlord Zon'ozz casts Psychic Drain (drain was 20 sec on 10 man normal, but i only have 1 pull)
7 stack heroic 10:
[22:26:01.708] Void of the Unmaking afflicted by Void Diffusion (7) from Void of the Unmaking
[22:26:12.087] Karnadas afflicted by Black Blood of Go'rath from Eye of Go'rath
[22:26:42.087] Karnadas fake arg
[22:27:05.819] Warlord Zon'ozz casts Psychic Drain (23-24 again, just ilke 25 heroic, again, confirms heroic vs normal is heroic is 3 seconds later)

9 Stack heroic 25:
[19:53:23.358] Void of the Unmaking afflicted by Void Diffusion (9) from Void of the Unmaking
[19:53:34.172] Shiramune afflicted by Black Blood of Go'rath from Eye of Go'rath
[19:54:04.172] Shiramune Fake arg
[19:54:27.827] Warlord Zon'ozz casts Psychic Drain (drain was 23 seconds later, over multiple logs the variation was 23-24, 23.5 is the consistent average))
9 stack heroic 10:
[22:41:34.932] Void of the Unmaking afflicted by Void Diffusion (9) from Void of the Unmaking
[22:41:45.620] Karnadas afflicted by Black Blood of Go'rath from Eye of Go'rath
[22:42:15.620] Karnadas fake arg
[22:42:39.388] Warlord Zon'ozz casts Psychic Drain (drain was 23.5 on 10 man heroic as well)

10 Stack normal 25:
[21:03:06.726] Void of the Unmaking afflicted by Void Diffusion (10) from Void of the Unmaking
[21:03:31.232] Shiramune afflicted by Black Blood of Go'rath from Warlord Zon'ozz
[21:04:01.232] fake arg
[21:04:15.735] Warlord Zon'ozz casts Psychic Drain (14.5 for a 10 stack, confirmed the same in LFR and 25 man)
]]

local function warnShadowsTargets()
	warnShadows:Show(table.concat(shadowsTargets, "<, >"))
	timerShadowsCD:Start()
	table.wipe(shadowsTargets)
end

local shadowsDebuffFilter
do
	shadowsDebuffFilter = function(uId)
		return UnitDebuff(uId, (GetSpellInfo(103434)))
	end
end

function mod:updateRangeFrame()
	if not self.Options.RangeFrame then return end -- only update/show if this is enabled
	if not self:IsDifficulty("heroic10", "heroic25") then return end--Not needed on normal or LFR
	if self.Options.NoFilterRangeFrame or UnitDebuff("player", GetSpellInfo(103434)) then
		DBM.RangeCheck:Show(10, nil)--Show everyone.
	else
		DBM.RangeCheck:Show(10, shadowsDebuffFilter)--Show only people who have debuff.
	end
end

local function blackBloodEnds()
	voidWarned = false
	phase2Started = false
	timerFocusedAngerCD:Start(6)
	timerShadowsCD:Start(6)
	--it's timer depends on Void Diffusion stacks. But since timer not confirmed, temporarly commented it.
	--It DOES appear to be difficulty based to a minor extent, i've verified it through MANY guilds 10 and 25 herioc logs. particularly the 7-9 stack on heroic without a doubt being 3 seconds later then normal in every log.
	--Still need data for the following (0, 2, 4, 6, 8 stacks in all difficulties. 1, 10 for heroic difficulties. 8 and 9 for normal difficulties)
	--[[
	timerVoidofUnmakingCD:Start(voidTimers[voidStacks])
	timerPsychicDrainCD:Start(voidTimers[voidStacks] + 8.5)
	voidStacks = 0
	]]
	if mod:IsDifficulty("lfr25") then -- absoultely 10 stacks
		timerVoidofUnmakingCD:Start()
		timerPsychicDrainCD:Start(14.5)
	elseif mod:IsDifficulty("normal25") then -- maybe 8 stacks?
		timerVoidofUnmakingCD:Start(12)
		timerPsychicDrainCD:Start(20.5)
	elseif mod:IsDifficulty("heroic10", "heroic25") then -- maybe 7 stacks?
		timerVoidofUnmakingCD:Start(15)
		timerPsychicDrainCD:Start(23.5)
	elseif mod:IsDifficulty("normal10") then -- maybe 5 stacks?
		timerVoidofUnmakingCD:Start(22.5)
		timerPsychicDrainCD:Start(31)
	end
end

function mod:OnCombatStart(delay)
	voidWarned = false
	phase2Started = false
--	voidStacks = 0
	table.wipe(shadowsTargets)
	timerVoidofUnmakingCD:Start(5.5-delay)
	timerFocusedAngerCD:Start(10.5-delay)
	timerPsychicDrainCD:Start(16.5-delay)
	timerShadowsCD:Start(-delay)
	self:updateRangeFrame()
	if not self:IsDifficulty("lfr25") then--Can confirm what others saw, LFR definitely doesn't have a 6 min berserk. It's either much longer or not there.
		berserkTimer:Start(-delay)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(104322, 104606, 104607, 104608) then--104378 confirmed 10 man normal
		warnPsychicDrain:Show()
		specWarnPsychicDrain:Show()
		timerPsychicDrainCD:Start()
	end
end	

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(104377, 104378, 110322, 110306) and not phase2Started then--All spellids Confirmed
		phase2Started = true
		timerFocusedAngerCD:Cancel()
		timerPsychicDrainCD:Cancel()
		timerShadowsCD:Cancel()
		specWarnBlackBlood:Show()
		timerBlackBlood:Start()
		self:Schedule(30, blackBloodEnds)--More accurate way then tracking spell aura removed of black blood. Players dying in the phase were falsely triggering the phase ending early.
	elseif args:IsSpellID(104543, 109409, 109410, 109411) then--104543 confirmed 10 man normal
		warnFocusedAnger:Show(args.destName, args.amount or 1)
		timerFocusedAngerCD:Start()
	elseif args:IsSpellID(106836) then--106836 confirmed 10/25 man normal, do NOT add 103527 to this, that's a seperate spellid for when BOSS is affected by diffusion, this warning is counting the ball stacks.
		warnVoidDiffusion:Show(args.destName, args.amount or 1)
		timerVoidDiffusionCD:Start()
--		if args.amount or 1 < 11 then
--			voidStacks = args.amount or 1
--		end
	elseif args:IsSpellID(103434, 104599, 104600, 104601) then--103434 confirmed 10 man normal.
		shadowsTargets[#shadowsTargets + 1] = args.destName
		if args:IsPlayer() and self:IsDifficulty("heroic10", "heroic25") then
			specWarnShadows:Show()
			yellShadows:Yell()
			self:updateRangeFrame()
		end
		self:Unschedule(warnShadowsTargets)
		if (self:IsDifficulty("normal10") and #shadowsTargets >= 3) then--Don't know the rest yet, will tweak as they are discovered
			warnShadowsTargets()
		else
			self:Schedule(0.3, warnShadowsTargets)
		end
	end
end		
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(104600, 104601) and args:IsPlayer() then--Only heroic spellids here, no reason to call functions that aren't needed on normal or LFR
		self:updateRangeFrame()
	end
end

--It looks this event doesn't fire in raid finder. It seems to still fire in normal and heroic modes.
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName, _, _, spellID)
	if uId ~= "boss1" then return end--Anti spam to ignore all other args (like target/focus/mouseover)
	--Void of the unmaking cast, do not use spellname because we want to ignore events using spellid 103627 which fires when the sphere dispurses on the boss.
	if spellID == 103571 and not voidWarned then--This spellid is same in 10/25 and raid finder, and assuming also same in heroic. No reason to use spellname, or other IDs.
		timerVoidofUnmakingCD:Cancel()
		voidWarned = true
		warnVoidofUnmaking:Show()
		specWarnVoidofUnmaking:Show()
	end
end

--"<10.8> [UNIT_SPELLCAST_SUCCEEDED] Warlord Zon'ozz:Possible Target<Erej>:boss1:Void of the Unmaking::0:103571", -- [371]
--"<11.0> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#Gul'kafh an'qov N'Zoth.#Warlord Zon'ozz###Warlord Zon'ozz##0#0##0#3201##0#false", -- [413]
--Backup trigger for LFR where UNIT_SPELLCAST_SUCCEEDED doesn't fire for void cast
function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L.voidYell or msg:find(L.voidYell)) and not voidWarned then
		timerVoidofUnmakingCD:Cancel()
		voidWarned = true
		warnVoidofUnmaking:Show()
		specWarnVoidofUnmaking:Show()
	end
end