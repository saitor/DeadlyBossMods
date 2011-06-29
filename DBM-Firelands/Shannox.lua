local mod	= DBM:NewMod(195, "DBM-Firelands", nil, 78)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(53691)
mod:SetModelID(38448)
mod:SetZone()
mod:SetUsedIcons(6, 8) -- cross(7) is hard to see in redish environment?

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON"
)

local warnFaceRage				= mod:NewTargetAnnounce(99945, 4)
local warnRage					= mod:NewTargetAnnounce(100415, 3)
local warnWary					= mod:NewTargetAnnounce(100167, 2, nil, false)	-- which hound has this buff? They get it when being trapped
local warnTears					= mod:NewStackAnnounce(99937, 3)
local warnMagmaFlare			= mod:NewSpellAnnounce(100495, 3)
local warnCrystalPrison			= mod:NewSpellAnnounce(99836, 2)
local warnCrystalPrisonTarget	= mod:NewTargetAnnounce(99837, 4)

local timerRage				= mod:NewTargetTimer(15, 100415)
local timerWary				= mod:NewTargetTimer(25, 100167, nil, false)
local timerTears			= mod:NewTargetTimer(30, 99937)
local timerCrystalPrisonCD	= mod:NewCDTimer(25.5, 99836)--Seems consistent, other trap is not.
local timerMagmaFlareCD		= mod:NewCDTimer(42, 100495)--Use this, since he only does hurl spear until rip dies. every 42-47 seconds

local specWarnRage			= mod:NewSpecialWarningYou(100415)
local specWarnImmTrap		= mod:NewSpecialWarningMove(99838)
local specWarnTears			= mod:NewSpecialWarningStack(99937, 8, nil, mod:IsTank())

mod:AddBoolOption("SetIconOnFaceRage")
mod:AddBoolOption("SetIconOnRage")

local spamFaceRage = 0
function mod:OnCombatStart(delay)
	spamFaceRage = 0
--	timerCrystalPrisonCD:Start(-delay)--Don't know yet, Need to run transcriptor with combat logging turned OFF to get the timestamps right.
	timerMagmaFlareCD:Start(20-delay)--Guesswork
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(100415) then
		warnRage:Show(args.destName)
		timerRage:Start(args.destName)
		if args:IsPlayer() then
			specWarnRage:Show()
		end
		if self.Options.SetIconOnRage then
			self:SetIcon(args.destName, 6, 15)
		end
	elseif args:IsSpellID(100167, 101215, 101216, 101217) then
		warnWary:Show(args.destName)
		timerWary:Start(args.destName)
	elseif args:IsSpellID(99838, 101208, 101209, 101210) then
		if args:IsPlayer() then
			specWarnImmTrap:Show()
		end
	elseif args:IsSpellID(99837) then
		warnCrystalPrisonTarget:Show(args.destName)
	elseif args:IsSpellID(99937, 101218, 101219, 101220) then
		if args.amount or 0 % 3 == 0 then	--Warn every 3 stacks
			warnTears:Show(args.destName, args.amount or 1)
		end
		if args.amount or 0 >= 8 then		-- tank switch @ 8?
			specWarnTears:Show()
		end
		timerTears:Start(args.destName)
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(99945) then
		timerRage:Cancel(args.destName)
		if self.Options.SetIconOnFaceRage then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(99945, 99947) and GetTime() - spamFaceRage > 3 then
		warnFaceRage:Show(args.destName)
		spamFaceRage = GetTime()
		if self.Options.SetIconOnFaceRage then
			self:SetIcon(args.destName, 8)
		end
	elseif args:IsSpellID(100495) then	--This is cast 2 seconds after spear, although when rip dies he stops casting spear and only casts this.
		warnMagmaFlare:Show()
		timerMagmaFlareCD:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(99836) then
		warnCrystalPrison:Show()
		timerCrystalPrisonCD:Start()
	end
end