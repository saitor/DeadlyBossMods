local L


----------------------
--  FlameLeviathan  --
----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization{
	name = "Flame Leviathan"
}

L:SetTimerLocalization{
	timerPursued		= "Pursuing: %s",
	timerFlameVents		= "Flame Vents",
	timerSystemOverload	= "System Overload"
}
	
L:SetMiscLocalization{
	YellPull	= "Hostile entities detected. Threat assessment protocol active. Primary target engaged. Time minus 30 seconds to re-evaluation.",
	Emote		= "%%s pursues (%S+)%."
}

L:SetWarningLocalization{
	PursueWarn				= "Pursuing >%s<",
	warnNextPursueSoon		= "Target change in 5 seconds",
	SpecialPursueWarnYou	= "Pursuing you",
	SystemOverload			= "System Overload"
}

L:SetOptionLocalization{
	timerSystemOverload		= "Show timer for System Overload",
	timerFlameVents			= "Show timer for Flame Vents",
	timerPursued			= "Show timer for pursue",
	SystemOverload			= "Show special warning for System Overload",
	SpecialPursueWarnYou	= "Show special warning when you are being pursued",
	PursueWarn				= "Show warning for pursue on player",
	warnNextPursueSoon		= "Show pre-warning for next pursue"
}


-------------
--  Ignis  --
-------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name = "Ignis the Furnace Master"
}

L:SetTimerLocalization{
	TimerFlameJetsCast		= "Flame Jets",
	TimerFlameJetsCooldown	= "Next Flame Jets in",
	TimerScorch				= "Next Scorch in",
	TimerScorchCast			= "Scorch",
	TimerSlagPot			= "Slag Pot: %s"
}

L:SetWarningLocalization{
	WarningSlagPot			= "Slag Pot on >%s<",
	SpecWarnJetsCast		= "Flame Jets - Stop casting"
}

L:SetOptionLocalization{
	SpecWarnJetsCast		= "Show special warning for Flame Jets cast",
	TimerFlameJetsCast		= "Show timer for Flame Jets cast",
	TimerFlameJetsCooldown	= "Show timer for Flame Jets cooldown",
	TimerScorch				= "Show timer for Scorch cooldown",
	TimerScorchCast			= "Show timer for Scorch cast",
	WarningSlagPot			= "Announce Slag Pot target",
	TimerSlagPot			= "Show timer for Slag Pot",
	SlagPotIcon				= "Set icon on Slag Pot target"
}

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name = "Razorscale"
}

L:SetWarningLocalization{	
	SpecWarnDevouringFlame		= "Devouring Flame - Move",
	warnTurretsReadySoon		= "Last turret ready in 20 seconds",
	warnTurretsReady			= "Last turret ready",
	SpecWarnDevouringFlameCast	= "Devouring Flame on you",
	WarnDevouringFlameCast		= "Devouring Flame on >%s<" 
}
L:SetTimerLocalization{
	timerDeepBreathCooldown		= "Next Flame Breath in",
	timerDeepBreathCast			= "Flame Breath",
	timerAllTurretsReady		= "Turrets",
	timerTurret1				= "Turret 1",
	timerTurret2				= "Turret 2",
	timerTurret3				= "Turret 3",
	timerTurret4				= "Turret 4",
	timerGroundedTemp			= "On the ground"
}
L:SetOptionLocalization{
	timerDeepBreathCooldown		= "Show timer for Flame Breath cooldown",
	timerDeepBreathCast			= "Show timer for Flame Breath cast",
	SpecWarnDevouringFlame		= "Show special warning when you are in a Devouring Flame",
	PlaySoundOnDevouringFlame	= "Play sound when you are affected by Devouring Flame",
	timerAllTurretsReady		= "Show timer for turrets",
	warnTurretsReadySoon		= "Show pre-warning for turrets",
	warnTurretsReady			= "Show warning for turrets",
	SpecWarnDevouringFlameCast	= "Show special warning when Devouring Flame is cast on you",
	timerTurret1				= "Show timer for turret 1",
	timerTurret2				= "Show timer for turret 2",
	timerTurret3				= "Show timer for turret 3 (25 player)",
	timerTurret4				= "Show timer for turret 4 (25 player)",
	OptionDevouringFlame		= "Announce target of Devouring Flame (unreliable)",
	timerGroundedTemp			= "Show timer for ground phase duration"
}

L:SetMiscLocalization{
	YellAir						= "Give us a moment to prepare to build the turrets.",
	YellAir2					= "Fires out! Let's rebuild those turrets!",
	YellGroundTemp				= "Move quickly! She won't remain grounded for long!",
	EmotePhase2					= "%%s grounded permanently!",
	FlamecastUnknown			= DBM_CORE_UNKNOWN
}


-------------
--  XT002  --
-------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization{
	name = "XT-002 Deconstructor"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	SpecialWarningLightBomb 	= "Light Bomb on you",
	WarningLightBomb			= "Light Bomb on >%s<",
	SpecialWarningGravityBomb	= "Gravity Bomb on you",
	WarningGravityBomb			= "Gravity Bomb on >%s<",
}

L:SetOptionLocalization{
	SpecialWarningLightBomb		= "Show special warning when you are affected by Light Bomb",
	WarningLightBomb			= "Announce Light Bomb",
	SpecialWarningGravityBomb	= "Show special warning when you are affected by Gravity Bomb",
	WarningGravityBomb			= "Announce Gravity Bomb",
	PlaySoundOnGravityBomb		= "Play sound when you are affected by Gravity Bomb",
	PlaySoundOnTympanicTantrum	= "Play sound on Tympanic Tantrum",
	SetIconOnLightBombTarget	= "Set icon on Light Bomb target",
	SetIconOnGravityBombTarget	= "Set icon on Gravity Bomb target",
}

-------------------
--  IronCouncil  --
-------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization{
	name = "Iron Council"
}

L:SetWarningLocalization{
	WarningSupercharge			= "Supercharge incoming",
	WarningChainlight			= "Chain Lightning",
	WarningFusionPunch			= "Fusion Punch",
	WarningOverwhelmingPower	= "Overwhelming Power on >%s<",
	WarningRuneofPower			= "Rune of Power",
	WarningRuneofDeath			= "Rune of Death",
	RuneofDeath					= "Rune of Death - Move",
	LightningTendrils			= "Lightning Tendrils - Move",
	WarningRuneofSummoning		= "Rune of Summoning",
	Overload					= "Overload - Move away",
	WarningStaticDisruption		= "Static Disruption on >%s<",
	PlaySoundDeathRune			= "Death Rune"
}

L:SetTimerLocalization{
	TimerSupercharge		= "Supercharge",
	TimerOverload			= "Overload",
	TimerLightningWhirl		= "Lightning Whirl",
	TimerLightningTendrils	= "Lightning Tendrils",
	timerFusionPunchCast	= "Fusion Punch cast",
	timerFusionPunchActive	= "Fusion Punch: %s",
	timerOverwhelmingPower	= "Overwhelming Power: %s",
	timerRunicBarrier		= "Runic Barrier",
	timerRuneofDeath		= "Rune of Death"
}

L:SetOptionLocalization{
	TimerSupercharge			= "Show timer for Supercharge",
	WarningSupercharge			= "Show warning when Supercharge is being cast",
	WarningChainlight			= "Announce Chain Lightning",
	TimerOverload				= "Show timer for Overload cast",
	TimerLightningWhirl			= "Show timer for Lightning Whirl cast",
	LightningTendrils			= "Show special warning for Lightning Tendrils",
	TimerLightningTendrils		= "Show timer for Lightning Tendrils duration",
	PlaySoundLightningTendrils	= "Play sound on Lightning Tendrils",
	WarningFusionPunch			= "Announce Fusion Punch",
	timerFusionPunchCast		= "Show cast bar for Fusion Punch",
	timerFusionPunchActive		= "Show timer for Fusion Punch",
	WarningOverwhelmingPower	= "Announce Overwhelming Power",
	timerOverwhelmingPower		= "Show timer for Overwhelming Power",
	SetIconOnOverwhelmingPower	= "Set icon on Overwhelming Power target",
	timerRunicBarrier			= "Show timer for Runic Barrier",
	WarningRuneofPower			= "Announce Rune of Power",
	WarningRuneofDeath			= "Announce Rune of Death",
	WarningRuneofSummoning		= "Announce Rune of Summoning",
	RuneofDeath					= "Show special warning for Rune of Death",
	timerRuneofDeath			= "Show timer for Rune of Death duration",
	SetIconOnStaticDisruption	= "Set icon on Static Disruption target",
	Overload					= "Show special warning for Overload",
	AllwaysWarnOnOverload		= "Always warn on Overload (otherwise, only when targeted)",
	PlaySoundOnOverload			= "Play sound on Overload",
	WarningStaticDisruption		= "Announce Static Disruption",
	PlaySoundDeathRune			= "Play sound on Rune of Death"
}

L:SetMiscLocalization{
	Steelbreaker		= "Steelbreaker",
	RunemasterMolgeim	= "Runemaster Molgeim",
	StormcallerBrundir 	= "Stormcaller Brundir",
}


---------------
--  Algalon  --
---------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization{
	name = "Algalon the Observer"
}

L:SetTimerLocalization{
	NextCollapsingStar		= "Next Collapsing Star",
	PossibleNextCosmicSmash	= "Next possible Cosmic Smash"
}

L:SetWarningLocalization{
	WarningPhasePunch		= "Phase Punch on >%s< - Stack %d",
	WarningBlackHole		= "Black Hole",
	WarningBigBang			= "Big Bang",
	SpecWarnBigBang			= "Big Bang",
	PreWarningBigBang		= "Big Bang in ~10 seconds",
	WarningCosmicSmash 		= "Cosmic Smash - Explosion in 4 seconds",
	SpecWarnCosmicSmash 	= "Cosmic Smash"
}

L:SetOptionLocalization{
	SpecWarnPhasePunch		= "Show special warning when Phase Punch is on you",
	WarningBigBang			= "Announce Big Bang cast",
	PreWarningBigBang		= "Show pre-warning for Big Bang",
	SpecWarnBigBang			= "Show special warning for Big Bang",
	WarningPhasePunch		= "Announce Phase Punch target",
	WarningBlackHole		= "Announce Black Hole",
	NextCollapsingStar		= "Show timer for next Collapsing Star",
	WarningCosmicSmash 		= "Announce Cosmic Smash",
	SpecWarnCosmicSmash 	= "Show special warning for Cosmic Smash",
	PossibleNextCosmicSmash	= "Show timer for next possible Cosmic Smash"
}

L:SetMiscLocalization{
	YellPull				= "Your actions are illogical. All possible results for this encounter have been calculated. The Pantheon will receive the Observer's message regardless of outcome.",
	YellPullFirst			= "",
	Emote_CollapsingStars	= "%s begins to Summon Collapsing Stars!",
	Emote_CosmicSmash		= "%s begins to cast Cosmic Smash!"

}


----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization{
	name = "Kologarn"
}

L:SetWarningLocalization{
	SpecialWarningEyebeam	= "Eye Beam on you - Move",
	WarningEyeBeam			= "Eye Beam on >%s<",
	WarnGrip				= "Grip on >%s<"
}

L:SetTimerLocalization{
	timerEyebeam			= "Eye Beam: %s",
	timerPetrifyingBreath	= "Petrifying Breath",
	timerNextShockwave		= "Next Shockwave",
	timerLeftArm			= "Left Arm respawn",
	timerRightArm			= "Right Arm respawn",
	achievementDisarmed		= "Timer for Disarm"
}

L:SetOptionLocalization{
	SpecialWarningEyebeam	= "Show a special warning when Eye Beam is on you",
	WarningEyeBeam			= "Announce Eye Beam target",
	timerEyebeam			= "Show timer for Eye Beam",
	timerPetrifyingBreath	= "Show timer for Petrifying Breath",
	timerNextShockwave		= "Show timer for Shockwave",
	timerLeftArm			= "Show timer for Left Arm respawn",
	timerRightArm			= "Show timer for Right Arm respawn",
	achievementDisarmed		= "Show timer for Disarm achievement",
	WarnGrip				= "Announce Grip targets",
	WarnEyeBeam				= "Announce Eye Beam target",
	SetIconOnGripTarget		= "Set icons on Grip targets"
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left	= "Just a scratch!",
	Yell_Trigger_arm_right	= "Only a flesh wound!",
	Health_Body				= "Kologarn Body",
	Health_Right_Arm		= "Right Arm",
	Health_Left_Arm			= "Left Arm",
	FocusedEyebeam			= "%s focuses his eyes on you!"
}

---------------
--  Auriaya  --
---------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization{
	name = "Auriaya"
}

L:SetMiscLocalization{
	Defender = "Feral Defender (%d)"
}

L:SetWarningLocalization{
	SpecWarnBlast		= "Sentinel Blast - Interrupt",
	SpecWarnVoid		= "Void Zone - Move",
	WarnCatDied 		= "Feral Defender down (%d lives remaining)",
	WarnCatDiedOne 		= "Feral Defender down (1 life remaining)",
	WarnFear			= "Terrifying Screech",
	WarnFearSoon 		= "Next Terrifying Screech soon",
	WarnSonic			= "Sonic Screech",
	WarnSwarm			= "Guardian Swarm on >%s<"
}

L:SetOptionLocalization{
	SpecWarnBlast		= "Show special warning for Sentinel Blast",
	SpecWarnVoid		= "Show special warning when standing in Feral Essence",
	WarnFear			= "Show warning for Terrifying Screech",
	WarnFearSoon		= "Show pre-warning for Terrifying Screech",
	WarnCatDied			= "Show warning when Feral Defender dies",
	WarnSwarm			= "Show warning for Guardian Swarm",
	WarnSonic			= "Show warning for Sonic Screech",
	WarnCatDiedOne		= "Show warning when Feral Defender has 1 life remaining"
}


-------------
--  Hodir  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization{
	name = "Hodir"
}

L:SetWarningLocalization{
	WarningFlashFreeze	= "Flash Freeze",
	WarningStormCloud	= "Storm Cloud on >%s<", 
}

L:SetTimerLocalization{
	TimerFlashFreeze	= "Flash Freeze incoming",
}

L:SetOptionLocalization{
	TimerFlashFreeze		= "Show timer for Flash Freeze cast",
	WarningFlashFreeze		= "Show warning for Flash Freeze",
	PlaySoundOnFlashFreeze	= "Play sound on Flash Freeze cast",
	WarningStormCloud		= "Announce Storm Cloud players",
	YellOnStormCloud		= "Yell when Storm Cloud is active",
	SetIconOnStormCloud		= "Set icon on Storm Cloud target"
}

L:SetMiscLocalization{
	YellKill	= "I... I am released from his grasp... at last.",
	YellCloud	= "Storm Cloud on me!"
}


--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization{
	name = "Thorim"
}

L:SetWarningLocalization{
	WarningStormhammer		= "Stormhammer on >%s<",
	UnbalancingStrike		= "Unbalancing Strike on >%s<",
	WarningPhase2			= "Phase 2",
	WarningLightningCharge	= "Lightning Charge",
	WarningBomb				= "Rune Detonation on >%s<",
	LightningOrb			= "Lightning Shock on you - Move"
}

L:SetTimerLocalization{
	TimerHardmode	= "Hard mode"
}

L:SetOptionLocalization{
	TimerHardmode			= "Show timer for hard mode",
	WarningStormhammer		= "Announce Stormhammer target",
	WarningLightningCharge	= "Announce Lightning Charge",
	WarningPhase2			= "Announce Phase 2",
	UnbalancingStrike		= "Announce Unbalancing Strike",
	WarningBomb				= "Announce Rune Detonation",
	RangeFrame				= "Show range frame",
	AnnounceFails			= "Post player fails for Lightning Charge to raid chat (requires announce to be enabled and leader/promoted status)",
	LightningOrb			= "Show special warning for Lightning Shock"
}

L:SetMiscLocalization{
	YellPhase1		= "Interlopers! You mortals who dare to interfere with my sport will pay.... Wait--you...",
	YellPhase2		= "Impertinent whelps, you dare challenge me atop my pedestal? I will crush you myself!",
	YellKill		= "Stay your arms! I yield!",
	ChargeOn		= "Lightning Charge: %s",
	Charge			= "Lightning Charge fails (this try): %s" 
}


-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization{
	name = "Freya"
}

L:SetMiscLocalization{
	SpawnYell	= "Children, assist me!",
	WaterSpirit	= "Ancient Water Spirit",
	Snaplasher	= "Snaplasher",
	StormLasher	= "Storm Lasher",
	YellKill	= "His hold on me dissipates. I can see clearly once more. Thank you, heroes."
}

L:SetWarningLocalization{
	WarnPhase2		= "Phase 2",
	WarnSimulKill	= "First add down - Resurrection in ~12 seconds",
	WarnFury		= "Nature's Fury on >%s<",
	SpecWarnFury	= "Nature's Fury on you",
	WarningTremor	= "Ground Tremor - Stop casting",
	WarnRoots		= "Roots on >%s<",
	UnstableEnergy	= "Unstable Energy - Move"
}

L:SetTimerLocalization{
	TimerUnstableSunBeam	= "Sun Beam: %s",
	TimerSimulKill			= "Resurrection",
	TimerFuryYou			= "Nature's Fury on you",
	TrashRespawnTimer		= "Freya trash respawn"
}

L:SetOptionLocalization{
	WarnPhase2		= "Announce Phase 2",
	WarnSimulKill	= "Announce first mob down",
	WarnFury		= "Announce Nature's Fury target",
	WarnRoots		= "Announce Iron Roots targets",
	SpecWarnFury	= "Show special warning for Nature's Fury",
	WarningTremor	= "Show special warning for Ground Tremor (hard mode)",
	PlaySoundOnFury = "Play sound when you are affected by Nature's Fury",
	TimerSimulKill	= "Show timer for mob resurrection",
	UnstableEnergy	= "Show special warning for Unstable Energy"
}

-- Elders
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization{
	name = "Freya's Elders"
}

L:SetMiscLocalization{
	TrashRespawnTimer	= "Freya trash respawn"
}

L:SetWarningLocalization{
	SpecWarnGroundTremor	= "Ground Tremor - Stop casting",
	SpecWarnFistOfStone		= "Fists of Stone"
}

L:SetOptionLocalization{
	SpecWarnFistOfStone		= "Show special warning for Fists of Stone",
	SpecWarnGroundTremor	= "Show special warning for Ground Tremor",
	PlaySoundOnFistOfStone	= "Play sound on Fists of Stone cast",
	TrashRespawnTimer		= "Show timer for trash respawn"
}


-------------------
--  Mimiron  --
-------------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization{
	name = "Mimiron"
}

L:SetWarningLocalization{
	DarkGlare			= "Laser Barrage",
	WarningPlasmaBlast	= "Plasma Blast on %s - Heal",
	WarnShell			= "Napalm Shells on >%s<",
	WarnBlast			= "Plasma Blast on >%s<",
	MagneticCore		= ">%s< has Magnetic Core",
	WarningShockBlast	= "Shock Blast - Move away",
	WarnBombSpawn		= "Bomb Bot spawned",
	WarnFrostBomb		= "Frost Bomb",
	WarnFlamesSoon		= "New flames in ~5 seconds"
}

L:SetTimerLocalization{
	ProximityMines		= "New Proximity Mines",
	TimerHardmode		= "Hard mode - Self-destruct",
	TimeToPhase2		= "Phase 2",
	TimeToPhase3		= "Phase 3",
	TimeToPhase4		= "Phase 4",
	TimerNewFlames		= "New flames"
}

L:SetOptionLocalization{
	DarkGlare				= "Show special warning for Laser Barrage",
	WarnBlast				= "Announce Plasma Blast target",
	WarnShell				= "Announce Napalm Shells target",
	TimeToPhase2			= "Show timer for Phase 2",
	TimeToPhase3			= "Show timer for Phase 3",
	TimeToPhase4			= "Show timer for Phase 4",
	MagneticCore			= "Announce Magnetic Core looter",
	HealthFramePhase4		= "Show health frame in Phase 4",
	AutoChangeLootToFFA		= "Switch loot mode to Free for All in Phase 3",
	WarnBombSpawn			= "Announce Bomb Bots",
	TimerHardmode			= "Show timer for hard mode",
	PlaySoundOnShockBlast	= "Play sound on Shock Blast",
	PlaySoundOnDarkGlare	= "Play sound on Laser Barrage",
	ShockBlastWarningInP1	= "Show special warning for Shock Blast in Phase 1",
	ShockBlastWarningInP4	= "Show special warning for Shock Blast in Phase 4",
	WarnFrostBomb			= "Announce Frost Bomb"
}

L:SetMiscLocalization{
	MobPhase1		= "Leviathan Mk II",
	MobPhase2		= "VX-001",
	MobPhase3		= "Aerial Command Unit",
	YellPull		= "We haven't much time, friends! You're going to help me test out my latest and greatest creation. Now, before you change your minds, remember that you kind of owe it to me after the mess you made with the XT-002.",	
	YellHardPull	= "Now, why would you go and do something like that? Didn't you see the sign that said, \"DO NOT PUSH THIS BUTTON!\"? How will we finish testing with the self-destruct mechanism active?",
	YellPhase2		= "WONDERFUL! Positively marvelous results! Hull integrity at 98.9 percent! Barely a dent! Moving right along.",
	YellPhase3		= "Thank you, friends! Your efforts have yielded some fantastic data! Now, where did I put-- oh, there it is.",
	YellPhase4		= "Preliminary testing phase complete. Now comes the true test!",
	LootMsg			= "([^%s]+).*Hitem:(%d+)"
}


---------------------
--  General Vezax  --
---------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization{
	name = "General Vezax"
}

L:SetTimerLocalization{
	hardmodeSpawn = "Saronite Animus spawn"
}

L:SetWarningLocalization{
	SpecialWarningShadowCrash		= "Shadow Crash on you",
	SpecialWarningSurgeDarkness		= "Surge of Darkness",
	WarningShadowCrash				= "Shadow Crash on >%s<",
	SpecialWarningShadowCrashNear	= "Shadow Crash near you",
	WarningLeechLife				= "Life Leech on >%s<",
	SpecialWarningLLYou				= "Life Leech on you",
	SpecialWarningLLNear			= "Life Leech on %s near you"
}

L:SetOptionLocalization{
	WarningShadowCrash				= "Show warning for Shadow Crash",
	SetIconOnShadowCrash			= "Set icon on Shadow Crash target (skull)",
	SetIconOnLifeLeach				= "Set icon on Life Leech target (cross)",
	SpecialWarningSurgeDarkness		= "Show special warning for Surge of Darkness",
	SpecialWarningShadowCrash		= "Show special warning for Shadow Crash",
	SpecialWarningShadowCrashNear	= "Show special warning for Shadow Crash near you",
	SpecialWarningLLYou				= "Show special warning when you are affected by Life Leech",
	SpecialWarningLLNear			= "Show special warning for Life Leech near you",
	CrashWhisper					= "Send whisper to Shadow Crash target",
	YellOnLifeLeech					= "Yell on Life Leech",
	YellOnShadowCrash				= "Yell on Shadow Crash",
	WarningLeechLife				= "Announce Life Leech target",
	hardmodeSpawn					= "Show timer for Saronite Animus spawn (hard mode)"
}

L:SetMiscLocalization{
	EmoteSaroniteVapors	= "A cloud of saronite vapors coalesces nearby!",
	CrashWhisper		= "Shadow Crash on you - Run away",
	YellLeech			= "Life Leech on me!",
	YellCrash			= "Shadow Crash on me!"
}


------------------
--  Yogg Saron  --
------------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
	name = "Yogg-Saron"
}

L:SetMiscLocalization{
	YellPull 			= "The time to strike at the head of the beast will soon be upon us! Focus your anger and hatred on his minions!",
	YellPhase2	 		= "I am the lucid dream.",
	Sara 				= "Sara",
	WhisperBrainLink 	= "Brain Link on you - Run to %s",
	WarningYellSqueeze	= "Squeeze on me! Help me!"
}

L:SetWarningLocalization{
	WarningGuardianSpawned 			= "Guardian spawned",
	WarningCrusherTentacleSpawned	= "Crusher Tentacle spawned",
	WarningP2 						= "Phase 2",
	WarningP3 						= "Phase 3",
	WarningBrainLink 				= "Brain Link on >%s< and >%s<",
	SpecWarnBrainLink 				= "Brain Link on you and %s",
	WarningSanity 					= "%d Sanity debuffs remaining",
	SpecWarnSanity 					= "%d Sanity debuffs remaining",
	SpecWarnGuardianLow				= "Stop attacking this Guardian",
	WarnMadness						= "Casting Induce Madness",
	SpecWarnMadnessOutNow			= "Induce Madness ending - Move out",
	WarnBrainPortalSoon				= "Portal in 3 seconds",	
	WarnSqueeze 					= "Squeeze: >%s<",
	WarnFavor						= "Sara's Fervor on >%s<",
	SpecWarnFavor					= "Sara's Fervor on you",
	WarnEmpowerSoon					= "Empowering Shadows soon",
	SpecWarnMaladyNear				= "Malady near you on >%s<"	,
	SpecWarnDeafeningRoar			= "Deafening Roar"
}

L:SetTimerLocalization{
	NextPortal	= "Brain Portal"
}

L:SetOptionLocalization{
	WarningGuardianSpawned			= "Announce Guardian spawns",
	WarningCrusherTentacleSpawned	= "Announce Crusher Tentacle spawns",
	WarningP2						= "Announce Phase 2",
	WarningP3						= "Announce Phase 3",
	WarningBrainLink				= "Announce Brain Links",
	SpecWarnBrainLink				= "Show special warning when Brain Linked",
	WarningSanity					= "Show warning when Sanity is low",
	SpecWarnSanity					= "Show special warning when Sanity is very low",
	SpecWarnGuardianLow				= "Show special warning when Guardian (P1) is low (for DDs)",
	WarnMadness						= "Announce Induce Madness",
	WarnBrainPortalSoon				= "Announce Brain Portal",
	SpecWarnMadnessOutNow			= "Show special warning shortly before Induce Madness ends",
	SetIconOnFearTarget				= "Set icon on Malady of the Mind target",
	WarnFavor						= "Announce Sara's Fervor target",
	SpecWarnFavor					= "Show special warning for Sara's Fervor",
	WarnSqueeze						= "Announce Squeeze target",
	specWarnBrainPortalSoon			= "Announce Brain Portal soon",
	WarningSqueeze					= "Announce Squeeze targets",
	NextPortal						= "Show timer for next Brain Portal",
	WhisperBrainLink				= "Whisper players on Brain Link",
	SetIconOnFavorTarget			= "Set icon on Sara's Fervor target",
	SetIconOnMCTarget				= "Set icon on mind-controlled target",
	ShowSaraHealth					= "Show health frame for Sara in Phase 1 (must be targeted by at least one raid member)",
	WarnEmpowerSoon					= "Show pre-warning for Empowering Shadows",
	SpecWarnMaladyNear				= "Show special warning if someone close to you has Malady of the Mind",
	SpecWarnDeafeningRoar			= "Show special warning when casting Deafening Roar (silence and for legendary)"
}



