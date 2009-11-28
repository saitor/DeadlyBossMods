local mod	= DBM:NewMod("ScourgelordTyrannus", "DBM-Party-WotLK", 15)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(36658, 36661)
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"SPELL_PERIODIC_DAMAGE"
)

local warnForcefulSmash			= mod:NewSpellAnnounce(69627)
local warnOverlordsBrand		= mod:NewTargetAnnounce(69172)
local timerOverlordsBrand		= mod:NewTargetTimer(8, 69172)
local warnTyrannusEngaged		= mod:NewAnnounce("warnTyrannusEngaged", false)
local specWarnIcyBlast			= mod:NewSpecialWarning("specWarnIcyBlast")

local warnHoarfrost				= mod:NewSpellAnnounce(69246)
local specWarnHoarfrost			= mod:NewSpecialWarning("specWarnHoarfrost")
local specWarnHoarfrostNear		= mod:NewSpecialWarning("specWarnHoarfrostNear")

local timerForcefulSmash		= mod:NewCDTimer(40, 69627) --Experimental, Timer may not be exact.
local timerUnholyPower			= mod:NewBuffActiveTimer(10, 69629)

mod:AddBoolOption("SetIconOnHoarfrostTarget", true)

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.TyrannusYell then		-- Tyrannus Jumps down from drake. Phase 2 so to speak.
		timerForcefulSmash:Start()  --Experimental support for possible next Forceful smash after he's been engaged.
		specTyrannusEngaged:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(69155, 69627) then					-- Forceful Smash
        warnForcefulSmash:Show()
        timerForcefulSmash:Start()
	end
end

do 
	local lasticyblast = 0
	function mod:SPELL_PERIODIC_DAMAGE(args)
		if args:IsSpellID(69238, 69628) and args:IsPlayer() and time() - lasticyblast > 2 then		-- Icy Blast, MOVE!
			specWarnIcyBlast:Show()
			lasticyblast = time()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(69629, 69167) then						-- Unholy Power
        warnUnholyPower:Show()
		timerUnholyPower:Show(args.destName)
	elseif args:IsSpellID(69172) then							-- Overlord's Brand
		warnOverlordsBrand:Show(args.destName)
		timerOverlordsBrand:Show(args.destName)
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	local target = msg and msg:match(L.HoarfrostTarget)
	if target then
		self:SendSync("Hoarfrost: "..target)
	end
end

function mod:OnSync(msg)
	if msg:find("Hoarfrost") then
		local _, _, target = string.find(msg, "Hoarfrost: (%s+)")
		if target == UnitName("player") then
			specWarnHoarfrost:Show()
		elseif target then
			local uId = DBM:GetRaidUnitID(target)
			if uId then
				local inRange = CheckInteractDistance(uId, 2)
				if inRange then
					specWarnHoarfrostNear:Show()
				end
			end
		end
		if self.Options.SetIconOnHoarfrostTarget then
			self:SetIcon(target, 8, 5)
		end
	end
end


