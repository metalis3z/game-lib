local survivorInfo = {
	DisplayName = "Veeronica";
	Quote = "SKATTINNGGGGGGG";
	Credits = "Maus4lia, BruhMoment, Agrovient, ffPrankster, voxov_tired, BakedMesh, unconnected and BirdieCandles";
	Class = "Survivalist";
	RenderImage = "rbxassetid://136459648582236";
	Price = 750;
	Exclusive = false;
	NotReplicated = false;
	Health = 100;
	Speed = 12;
	TVScreenSpeed = 1;
	TVScreenInterpolationTime = 2;
	VandalismCooldown = 0.65;
	VandalismPostCooldown = 8;
	VandalismDestroyedCooldown = 8;
	VandalismUsedCooldown = 8;
	VandalismPreset = script.Vandalism_PRESET;
	VandalismSprayBeam = script.SprayBeam_PRESET;
	VandalismDistanceCheck = 7;
	VandalismHealth = 20;
	VandalismSprayDrain = 0;
	VandalismSprayDistance = 9999;
	VandalismSprayWait = 0.35;
	VandalismSprayTime = 5;
	VandalismSprayOffset = 0.025;
	VandalismRange = 30;
	VandalismWidth = 12;
	VandalismDestroyedUI = script.SprayDestroyedUI;
	VandalismSprayImages = {"rbxassetid://73782115919441", "rbxassetid://131590876829922", "rbxassetid://136154888235055", "rbxassetid://81977797734418", "rbxassetid://83241802024833", "rbxassetid://80625367785567", "rbxassetid://136253618010857", "rbxassetid://114566772220660", "rbxassetid://114208341643680", "rbxassetid://109500406786628", "rbxassetid://95744668143682", "rbxassetid://126965984054565", "rbxassetid://94795583765109", "rbxassetid://110291822474947", "rbxassetid://86760468781244", "rbxassetid://108528126969003"};
	VandalismRareSprayImages = {"rbxassetid://302666936", "rbxassetid://5641193985", "rbxassetid://107525379854621", "rbxassetid://13443001858", "rbxassetid://6799068822", "rbxassetid://6033500754", "rbxassetid://124800105503230"};
	VandalismZoneVisual = script.ZonePole;
	VandalismSprayIndicationColors = {
		IN = Color3.fromRGB(13, 255, 0);
		OUT = Color3.fromRGB(255, 46, 46);
	};
	Sk8CD = 5;
	Sk8Speed = 1.15;
	Sk8SpeedExhaust = 1.15;
	Sk8StaminaLossOut = 1.1;
	Sk8StaminaLoss = 0.85;
	Sk8StaminaLossOutNerfed = 1.35;
	Sk8TurnControl = 0.65;
	Sk8BonkDamage = 5;
	Sk8BonkStatuses = {
		Slowness = {
			Level = 4;
			Duration = 2.5;
		};
	};
	Sk8TrickBattery = 2.5;
	Sk8TrickCombo = 3;
	Sk8TrickTurnControl = 50;
	Sk8TrickAirborneSpeed = 1.5;
	Sk8TrickPower = 75;
	Sk8TrickJump = 0.45;
	Sk8TrickGravity = 0.38;
	Sk8TrickCooldown = 1;
	Sk8TrickStamina = 10;
	Sk8TrickStaminaNerfed = 5;
	Sk8TrickHighlightData = {
		TrickReady = {
			FillTransparency = 0.55;
			FillColor = Color3.fromRGB(241, 85, 255);
			OutlineTransparency = 0.5;
			OutlineColor = Color3.fromRGB(255, 104, 252);
		};
		TrickCooldownFlash = {
			FillTransparency = 0.4;
			FillColor = Color3.fromRGB(248, 206, 255);
			OutlineTransparency = 0.2;
			OutlineColor = Color3.fromRGB(248, 170, 255);
		};
		TrickCooldownDecay = {
			FillTransparency = 0.4;
			FillColor = Color3.fromRGB(134, 40, 132);
			OutlineTransparency = 0.25;
			OutlineColor = Color3.fromRGB(83, 49, 85);
		};
		TrickCooldownFail = {
			FillTransparency = 0.5;
			FillColor = Color3.fromRGB(255, 67, 70);
			OutlineTransparency = 0.25;
			OutlineColor = Color3.fromRGB(255, 0, 0);
		};
	};
	Sk8PhaseReboundDamage = 5;
	Sk8PhaseBattery = 7.5;
	Sk8PhaseUses = 1;
	Sk8PhaseTime = 0.5;
	Sk8PhaseStatuses = {
		Resistance = {
			Duration = 3;
			Level = 2;
		};
		Speed = {
			Duration = 1.5;
			Level = 2;
			NoStack = {"HitSpeedBonus"};
		};
	};
	Sk8PhaseChargedStatuses = {
		Resistance = {
			Duration = 3;
			Level = 4;
		};
		Speed = {
			Duration = 2;
			Level = 4;
		};
	};
	Sk8BumpGlobalCooldown = 20;
	Sk8BumpDamage = 5;
	Sk8BumpPower = 14;
	Sk8BumpBattery = 7.5;
	Sk8BumpStatuses = {};
	Sk8BumpChargedDamage = 15;
	Sk8BumpChargedPower = 15;
	Sk8BumpChargedBattery = 15;
	Sk8BumpChargedStatuses = {};
	Sk8TonyTurnDuration = 1;
	Sk8TonyChargedTurnDuration = 2;
	Sk8TonyBonkDamage = 5;
	BroadcastTypeData = {{
		Name = "[Phase]";
		Icon = "rbxassetid://99218231350350";
	}, {
			Name = "[Bumper]";
			Icon = "rbxassetid://115049033276951";
		}, {
			Name = "[Mobile]";
			Icon = "rbxassetid://70948225384237";
		}};
	ActivateBatteryCooldown = 55;
	BatteryRechargeRate = 4;
	BatteryUITemplate = script.BatteryUI_PRESET;
	BatteryGeneratorCharge = 4;
	Sk8UITemplate = script.SkateUI_PRESET;
	S8EffectsTemplate = script.S8VFX;
	Expressions = {
		Happy = "rbxassetid://122882514249818";
		Default = "rbxassetid://73908351202687";
		Hurt = "rbxassetid://102932408723202";
		Injured = "rbxassetid://88469391773512";
		Dead = "rbxassetid://1179108573";
		Drinking = "rbxassetid://78573485331724";
	};
	Animations = {
		Idle = "rbxassetid://84452862276249";
		BroadcastSwitch = "rbxassetid://82246650903008";
		CanTakeout = "rbxassetid://82165504793466";
		CanIdle = "rbxassetid://127644338813621";
		CanSpray = "rbxassetid://111795117003327";
		CanWipe = "rbxassetid://93341960657238";
		Sk8Start = "rbxassetid://139115966220924";
		Sk8Skating = "rbxassetid://127735936545732";
		Sk8Speedup = "rbxassetid://122703575644657";
		Sk8Trick1 = "rbxassetid://78614682378295";
		Sk8Trick2 = "rbxassetid://120744323457934";
		Sk8TrickLand = "rbxassetid://128299624455379";
	};
	Sounds = {
		ChannelSwitch = "rbxassetid://97554827250708";
		VandalismEquip = {
			SoundId = "rbxassetid://79726867580545";
			TimePosition = 0.4;
		};
		VandalismInterrupted = "rbxassetid://105726690559537";
		VandalismSpray = {
			SoundId = "rbxassetid://89115265536079";
			Volume = 0.35;
		};
		VandalismWipe = {
			SoundId = "rbxassetid://119756289563014";
			Volume = 0.35;
		};
		VandalismZoneCreated = "rbxassetid://2499538809";
		VandalismZoneDestroyed = "rbxassetid://154146535";
		VandalismDenied = "rbxassetid://550209561";
		SprayProgression = "rbxassetid://17735373972";
		SprayWiping = "rbxassetid://17735373972";
		SprayDestroyed = "rbxassetid://75290070142856";
		SprayCompleted = "rbxassetid://73564668987207";
		SprayDestroyedNotif = "rbxassetid://86862737444801";
		Sk8Start = "rbxassetid://124934695604847";
		Sk8Loop = {
			SoundId = "rbxassetid://99925276128204";
		};
		Sk8LoopMusic = {
			SoundId = "rbxassetid://112482754524909";
		};
		Sk8Stop = "rbxassetid://101977738852375";
		Sk8Trick = "rbxassetid://91937289286100";
		Sk8Bump = "rbxassetid://82215908430475";
		Sk8Bonk = "rbxassetid://96670784554118";
		Sk8Phase = "rbxassetid://74077625892520";
		Sk8Rebound = "rbxassetid://128936510881280";
		Sk8CooldownFail = "rbxassetid://4612384231";
		Sk8CooldownFlash = "rbxassetid://113341305930125";
		Sk8CooldownReady = "rbxassetid://129325878236136";
		BatteryStart = "rbxassetid://126468398066211";
		BatteryLoop = "rbxassetid://125491655137359";
		BatteryDischarged = "rbxassetid://9061162181";
		BatteryFinished = "rbxassetid://5857614116";
		BatteryInterrupted = "rbxassetid://9120985853";
		ActivateBatteryFailure = "rbxassetid://9118491909";
	};
	KillEffects = {
		Veeronica = true;
	};
	Voicelines = {
		Died = {"rbxassetid://17871250897"};
	};
	TextInteractions = {
		Requests = {
			ElliotPizza = {"ONE 0F OUR FR1ENDS SEEMS HURT! OロO Y0UR PIZZA COULD H3LP THEM A LOT!", "S0MEONE LOOKS HURT OUT TH3RE, I CANNOT DO MUCH TO H3LP, BUT Y0UR P1ZZA COULD MAYBE HELP TH3M. \xB0ㅁ\xB0", "P1ZZA BOY! SOMEONE IS HURT, PLEASE H3LP THEM! \xF3﹏\xF2", "S0MEONE OUT THER3 COULD USE YOUR H3LP, PIZZA BOY! >﹏>", "ONE OF OUR FR1ENDS COULD REALLY USE A PIZZA R1GHT NOW! \xB0ロ\xB0"};
			BuildermanSentry = {"THIS S3EMS LIKE A GOOD SP0T F0R A S3NTRY. ^-^", "A SEN7RY PLACED IN THIS AR3A C0ULD HELP TH3 TEAM OUT A L0T. \xB0v\xB0", "PUT A SENTRY H3RE AND GUN THAT LOS3R D0WN! •̀ v •́", "S1R BU1LDER, A S3NTRY HERE WOULD BE PR3TTY RAD! ^ᴗ^", "SIR BUILD3R, THIS SEEM5 LIKE A G0OD SENTRY SP0T! ^v ^"};
			BuildermanDispenser = {"A D1SPENSER WOULD BE REALLY USEFUL F0R THE TEAM. oᴗo", "A DISPENS3R W0ULD BE GREAT H3R3! I CAN EVEN L3ND YOU 0NE OF MY CANS FOR THE H3ALTH SPR4Y IF YOU'RE SHORT, SIR BU1LDER! OヮO", "THIS PLAC3 SEEMS GR3AT FOR Y0UR D1SPENSER, SIR BU1LDER! 'ᵕ'", "SIR BUILDER, A DISPENSER IN TH1S AREA COULD REALLY B3NEFIT THE TEAM! •ᴗ•", "S1R BUILDER, THIS SEEMS LIK3 A RAD SPOT FOR A D1SPENSER! ^v^"};
			DusekkarProtection = {"YOUR MAG1C SH1ELD WOULD B3 GREAT FOR ME RIGHT N0W! ^ヮ^", "I THINK Y0UR SHIELD WOULD LOOK AWES0M3 ON ME! ^v^", "IT'D BE RE4LLY SICK IF YOU U5ED SOME OF THAT SHIELD MAG1C ON ME!", "M4GIC MAN, A SH1ELD COULD REALLY H3LP ME RIGHT NOW! QᴗQ", "MAGIC M4N, C0ULD YOU USE YOUR AW35OME SH1ELD POWERS TO PROTECT M3? ^∇^"};
			HemmorhageAsk = {"I'M G0ING TO SHUTDOWN 1F I L0SE ANY MORE 4CID, PLEASE H3LP! \xF3ロ\xF2", "I'M LE4KING, C0ULD YOU PLEASE H3LP?", "ALL MY B4TTERY ACID IS L3AKING ONTO THE GR0UND! T﹏T C0ULD YOU PLEASE PATCH M3 UP?", "MY SYST3MS ARE M4LFUNCTION1NG, PLEASE H3LP! Q﹏Q", "H3LP! EVERYTH1NG'S SPILLING 0UT! OロO"};
		};
		Thanks = {
			Regular = {"TH4NK YOU SO MUCH! I COULD TEACH YOU S0ME TRICKS IF YOU EV3R ASK! 'ヮ'", "I R3ALLY APPRECIATE YOU L1STENING TO ME! ^ヮ^", "THANK Y0U! OᴗO", "TH4NK YOU, FRIEND! \xB0∇\xB0", "THANK Y0U, I APPR3CIATE IT! 0ᴗ0"};
		};
	};
};
survivorInfo.Information = {
    {
        Separator = "GENERAL INFO"
    }, 
    {
        Header = "VEERONICA", 
		Text = "A rebellious robot, one with a heart for tags and shredding. Letting her pieces run all while she jumps, kicks, flies through the air! If danger ever finds her, she can slip away rapidly and repair herself. Veeronica stands as a pillar of survivability. Able to hold her own and take care of herself, all while sacrificing some aid from others for sustainability, speed, and style."
    }, 
    {
        Header = "STATS", 
        Text = "Difficulty: \226\152\133\226\152\133\226\152\133\226\152\134\226\152\134\n" .. ("Health: %*\n"):format(survivorInfo.Health or 100) .. ("Regular Speed: %*\n"):format(survivorInfo.Speed or 12) .. ("Sprinting Speed: %*\n"):format(survivorInfo.SprintSpeed or 26) .. ("Max Stamina: %*\n"):format(survivorInfo.MaxStamina or 100) .. ("Stamina Loss per sec: %*\n"):format(survivorInfo.StaminaLoss or 10) .. ("Stamina Gain per sec: %*\n"):format(survivorInfo.StaminaGain or 20)
	},
	{
		Separator = "PASSIVES"
	}, 
	{
		Header = "METAL FRAME";
		Quote = `roger roger`;
		Text = "Veeronica cannot use standard healing items like Medkits, Elliot's Pizza, or Builderman's Dispenser.\nInstead, Veeronica has a rechargeable battery that she can use to heal herself, up to 50 HP at 100% charge.\nVeeronica will begin the round with 50% of her Battery charged.\nCompleting Generator puzzles will fill 8% of her Battery.\n";
	},
    {
        Separator = "ABILITIES"
    }, 
    {
        Image = "rbxassetid://99162825735363", 
        Header = "VANDALISM", 
		Quote = 'HEY! *whistle*', 
        Text = "Veeronica will equip/unequip her spray paint, at which point she can spray Graffiti onto a wall by left clicking and holding.\n" .. "Veeronica is able to destroy her own Graffiti by holding Spacebar near her Graffiti with her can out.\n" .. ("Graffiti can be placed a maximum of %* studs away from eachother.\n"):format(survivorInfo.VandalismSprayDistance) .. "Graffiti have 5 health and can be destroyed by the Killer.\n" .. "Once three Graffiti are placed, a Zone will appear.\n" .. "While Veeronica is in this Zone:\n" .. " * She is able to use Sk8\n" .. " * Sk8 uses much less stamina\n" .. " * Broadcast abilities are amplified\n" .. ("If any of her Graffiti are destroyed while a Zone is active, the Zone will immediately disappear and this move will go on cooldown for %*s."):format(survivorInfo.VandalismPostCooldown)
    }, 
    {
		Image = "rbxassetid://113273966501923", 
        Header = "SK8", 
		Quote = 'subway surfers gameplay in the corner', 
        Text = ("Cooldown: %*s\n"):format(survivorInfo.Sk8CD) .. "Can only be used when inside a Graffiti Zone.\n" .. "Veeronica begins skating at 1.15x her running speed, while using 0.85/1.15x her stamina while inside/outside the Zone.\n" .. "While skating, Veeronica has extremely limited turn control.\n" .. ("Upon crashing into a wall or the Killer, Veeronica will take %* self-damage and be afflicted with <b>Slowness IV</b> for 2.5s.\n"):format(survivorInfo.Sk8BonkDamage) .. "Veeronica can stop skating at any time by recasting the ability.\n" .. "If Veeronica runs out of Stamina, <b>Sk8 will end immediately.</b>"
    }, 
    {
		Image = "rbxassetid://117024006968159", 
        Header = "SK8 - TRICK", 
		Quote = 'NO WAY....', 
        Text = ("Cooldown: %*s\n"):format(survivorInfo.Sk8TrickCooldown) .. "When approaching a collidable surface, Veeronica will glow and can perform a Trick with Spacebar to rebound off of it!\n" .. ("Doing this grants her full air control while airborne, as well as %* Stamina and a speed boost while in the air.\n"):format(survivorInfo.Sk8TrickStamina) .. "Attempting to Trick on nothing will still place Trick on cooldown." .. " "
    }, 
    {
        Image = "rbxassetid://99218231350350", 
        Header = "BROADCAST", 
		Quote = 'subway surfers gameplay in the corner', 
		Text = "Cooldown: 1s\n" .. 
			"Switches between 3 channels, which affect the behavior of Sk8:\n" .. 
			"<b>* Phase</b>\n" .. 
			"   - Upon colliding with a Killer, gain <b>Resistance II</b> for 3s and <b>Speed IV</b> for 1s and phase through them.\n" .. 
			"   - If Veeronica is inside her Zone when she phases through a Killer, the <b>Resistance</b> level will be increased to <b>IV</b>.\n" .. 
			"   - This effect can only be used once per Sk8.\n" .. 
			("   - Additionally, Veeronica will rebound off walls that she collides with instead of crashing into them, though this will still deal %* self-damage.\n"):format(survivorInfo.Sk8PhaseReboundDamage) .. 
			"<b>* Bumper</b>\n" .. 
			("   - Upon crashing into a Killer, Veeronica will knock them back. - Crashing into a Killer this way will deal no self damage, but will still inflict Veeronica with <b>Slowness II</b> for 3s.\n") .. 
			"   - If Veeronica is inside her Zone, knockback power will be increased by 50% and <b>Slowness</b> on crash decreased to <b>I</b> for 2s.\n" .. 
			"   - Sk8 will immediately end once Veeronica crashes into a Killer.\n" .. 
			"<b>* Mobile</b>\n" .. 
			"   - Trick's increased turn control lingers for 1s after landing.\n" .. 
			"   - If Veeronica is inside her Zone, turn control lingers for 2s.\n" .. 
			"   - Veeronica will take <b>3x</b> more self damage from crashing while on this channel.\n" .. 
			"These effects <b>cannot</b> be switched through during Sk8."
	},
	{
		Image = "rbxassetid://111551796924061";
		Header = "ACTIVATE BATTERY";
		Quote = `oktoberfest`;
		Text = `Cooldown: {survivorInfo.ActivateBatteryCooldown}s\n`.."Veeronica begins slowly healing herself with her Battery.\n".."Healing will stop if maximum health is reached, Battery charge runs out, or Veeronica takes any damage.\n";
	}
};
return survivorInfo