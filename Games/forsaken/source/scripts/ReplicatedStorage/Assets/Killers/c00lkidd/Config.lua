-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["DisplayName"] = "c00lkidd",
	["Quote"] = "join team c00lkidd today!!",
	["Credits"] = "Made By: BruhMoment",
	["RenderImage"] = "rbxassetid://18997973596",
	["Price"] = 900,
	["Health"] = 800,
	["Speed"] = 7.5,
	["SprintSpeed"] = 28,
	["StaminaLoss"] = 9.5,
	["StaminaGain"] = 21,
	["MaxStamina"] = 110,
	["Relations"] = { "007n7" },
	["LastManStandingEmotionalData"] = {
		["ThemeID"] = "rbxassetid://122057487411052",
		["RoundTime"] = 88
	},
	["AttackDamage"] = 26.5,
	["PunchWindup"] = 0.1,
	["PunchLinger"] = 0.3,
	["RootPartDamage"] = 15,
	["WalkspeedOverrideDamage"] = 30,
	["WalkspeedOverrideSpeed"] = 90,
	["WalkspeedOverrideDuration"] = 1.34,
	["WalkspeedOverrideWindup"] = 0.55,
	["WalkspeedOverrideKnockback"] = 20,
	["c00lguiTemplate"] = script.c00lgui,
	["PizzaDeliveryGuyLifetime"] = 30,
	["PizzaDeliveryGuyAttackRadius"] = 6,
	["PizzaDeliveryGuySpeed"] = 14,
	["PizzaDeliveryGuyHealth"] = 20,
	["PizzaDeliveryGuyDamage"] = 15,
	["PizzaDeliveryRig"] = script.PizzaDeliveryRig,
	["PizzaDeliveryAnimations"] = {
		["Summoned"] = "rbxassetid://79957088666139",
		["Idle"] = "rbxassetid://97075269140767",
		["Walk"] = "rbxassetid://99491273790932",
		["Hit"] = "rbxassetid://107383276844749"
	},
	["IntroSky"] = script.IntroSky,
	["OutroLighting"] = script.OutroLighting
}
local v2 = {
	["Idle"] = "rbxassetid://133028760890192",
	["Walk"] = "rbxassetid://123052483214488",
	["Run"] = "rbxassetid://90148889401526",
	["InjuredIdle"] = "rbxassetid://133028760890192",
	["InjuredWalk"] = "rbxassetid://123052483214488",
	["InjuredRun"] = "rbxassetid://90148889401526",
	["Stunned"] = {
		["Start"] = "rbxassetid://83181565332729",
		["Loop"] = "rbxassetid://138065667444392",
		["End"] = "rbxassetid://89978756462600"
	},
	["Introduction"] = {
		["KillerRig"] = "rbxassetid://140027271743138",
		["CameraRig"] = "rbxassetid://136928162779728"
	},
	["Victory"] = {
		["KillerRig"] = "rbxassetid://96354664951164",
		["KillerRigLoop"] = "rbxassetid://116605064816126",
		["CameraRig"] = "rbxassetid://125554169548503"
	},
	["Execution"] = {
		["KillerRig"] = "rbxassetid://100331353959391",
		["PlayerRig"] = "rbxassetid://128231846481982"
	},
	["Execution007n7"] = {
		["KillerRig"] = "rbxassetid://109243003903321",
		["PlayerRig"] = "rbxassetid://79905009426086"
	},
	["Attack"] = "rbxassetid://103168220540569",
	["CorruptNature"] = "rbxassetid://77233642407900",
	["SummonPizzaDelivery"] = "rbxassetid://119171930909171",
	["WalkspeedOverrideStart"] = "rbxassetid://73384632766849",
	["WalkspeedOverrideLoop"] = "rbxassetid://130892289447421",
	["WalkspeedOverrideHit"] = "rbxassetid://136178751233910",
	["WalkspeedOverrideMiss"] = "rbxassetid://92820743099613"
}
v1.Animations = v2
local v5 = {
	["ID"] = "rbxassetid://80814147615195",
	["Properties"] = {
		["Volume"] = 1.45,
		["Looped"] = false,
		["TimePosition"] = 0.75
	}
}
local v3 = {
	Footsteps = {
		"rbxassetid://106029794447542", 
		"rbxassetid://96762479007469"
	}, 
	TerrorRadiusThemes = {
		[60] = {
			ID = "rbxassetid://123676748918993", 
			BPM = 81
		}, 
		[40] = {
			ID = "rbxassetid://117756121527078", 
			BPM = 81
		}, 
		[20] = {
			ID = "rbxassetid://113960555777390", 
			BPM = 81
		}, 
		[6] = {
			ID = "rbxassetid://125330510042694", 
			BPM = 81, 
			Chase = true
		}
	}, 
	Execution = "rbxassetid://128847092888454", 
	CorruptThrow = "rbxassetid://87707149812049", 
	CorruptAmbience = "rbxassetid://96773587810814", 
	CorruptHit = "rbxassetid://88364150149692", 
	PizzaDeliveryGuySpawned = "rbxassetid://119993322066460", 
	PizzaDeliveryPunchGround = "rbxassetid://73139934333155", 
	PizzaDeliveryMinionHit = "rbxassetid://98330897555423", 
	PizzaDeliveryMinionIdle = "rbxassetid://127664785736025", 
	WalkspeedOverrideLunge = "rbxassetid://87494146688413", 
	WalkspeedOverrideHit = "rbxassetid://93597265746717", 
	WalkspeedOverrideTimeout = "rbxassetid://100389837735960", 
	WalkspeedOverrideCollide = "rbxassetid://131584836684993", 
	Hit = "rbxassetid://110759725172567", 
	Swing = "rbxassetid://102228729296384", 
	Introduction = "rbxassetid://120121923711079"
}
v3.VictoryTheme = v5
v1.Sounds = v3
v1.Voicelines = {
	["Idle"] = {
		"rbxassetid://85013528805835",
		"rbxassetid://89051751055413",
		"rbxassetid://96655719596596",
		"rbxassetid://70715705402715"
	},
	["LastSurvivorEmotional"] = { "rbxassetid://112211393260474" },
	["LastSurvivor"] = {
		"rbxassetid://133562999570990",
		"rbxassetid://92718770679056",
		"rbxassetid://112117153842215",
		"rbxassetid://105716035516753"
	},
	["KillNoob"] = { "rbxassetid://95829099724404", "rbxassetid://130499159104935" },
	["KillElliot"] = { "rbxassetid://98150327458539" },
	["KillGuest1337"] = { "rbxassetid://76125983874457" },
	["Kill"] = {
		"rbxassetid://99081289911669",
		"rbxassetid://96130441593862",
		"rbxassetid://129971792713796",
		"rbxassetid://71598859342038"
	},
	["Kill007n7"] = {
		"rbxassetid://84205518608518",
		"rbxassetid://126510487087796",
		"rbxassetid://118752854049740",
		"rbxassetid://106784455859707",
		"rbxassetid://131717739827974",
		"rbxassetid://73651367921334",
		"rbxassetid://107647850299675"
	},
	["Stunned"] = { "rbxassetid://120845231654029", "rbxassetid://100629345519622" },
	["CorruptNature"] = {
		"rbxassetid://139061125247165",
		"rbxassetid://109567597460934",
		"rbxassetid://125628353438049",
		"rbxassetid://96885987194098"
	},
	["PizzaDelivery"] = {
		"rbxassetid://83260878877136",
		"rbxassetid://129979761093198",
		"rbxassetid://98481947447411",
		"rbxassetid://77553956755455",
		"rbxassetid://124389575913805"
	},
	["PizzaDeliveryHit"] = { "rbxassetid://79554277951408", "rbxassetid://115476331903507" },
	["WalkspeedOverride"] = { "rbxassetid://73762171929471", "rbxassetid://98389337191287", "rbxassetid://78461604068568" },
	["WalkspeedOverrideHit"] = { "rbxassetid://97100466324703", "rbxassetid://74000375845213" },
	["WalkspeedOverrideCollide"] = { "rbxassetid://111502315377475", "rbxassetid://84340345572285", "rbxassetid://120394605928086" },
	["WalkspeedOverrideTimeout"] = { "rbxassetid://134973085112081" }
}
v1.Information = {
	{
		["Separator"] = "GENERAL INFO"
	},
	{
		["Header"] = "C00LKIDD",
		["Text"] = "An adopted son from a single father with childlike curiosity, but with the strength of a monster. He appears as a red, flesh-like humanoid that can kill fast and traverse fast. He is known for his association with a vandalization group called \"<font color=\"rgb(200,20,20)\">team c00lkidd</font>\".\n"
	},
	{
		["Header"] = "STATS",
		["Text"] = "Difficulty: \226\152\133\226\152\133\226\152\133\226\152\134\226\152\134\n" .. ("Health: %*\n"):format(v1.Health) .. ("Regular Speed: %*\n"):format(v1.Speed) .. ("Sprinting Speed: %*\n"):format(v1.SprintSpeed) .. ("Max Stamina: %*\n"):format(v1.MaxStamina) .. ("Stamina Loss per sec: %*\n"):format(v1.StaminaLoss) .. ("Stamina Gain per sec: %*\n"):format(v1.StaminaGain) .. "Terror Radius: 60 studs\n"
	},
	{
		["Separator"] = "ABILITIES"
	},
	{
		["Image"] = "rbxassetid://93874368032471",
		["Header"] = "PUNCH",
		["Quote"] = "\"Let\'s play again sometime!\" - c00lkidd",
		["Text"] = "Cooldown: 2s\n" .. ("Damage: %*\n"):format(v1.AttackDamage) .. ("Windup: %*s\n"):format(v1.PunchWindup) .. ("Linger: %*s\n"):format(v1.PunchLinger) .. "Length: 5 studs\n<font color=\"rgb(200,20,20)\">c00lkidd</font> does a basic punch.\n"
	},
	{
		["Image"] = "rbxassetid://81200466982776",
		["Header"] = "CORRUPT NATURE",
		["Quote"] = "\"Hahahaha!\" - c00lkidd",
		["Text"] = "Cooldown: 12s\n" .. ("Damage: %*\n"):format(v1.RootPartDamage) .. "<font color=\"rgb(200,20,20)\">c00lkidd</font> immediately launches a projectile that goes through walls and survivors.\nIf a survivor is hit by the projectile, they are damaged, inflicted with <b>Slowness I</b> for 4s, and their aura is revealed to <font color=\"rgb(200,20,20)\">c00lkidd</font> for 10 seconds.\n"
	},
	{
		["Image"] = "rbxassetid://101955457812737",
		["Header"] = "WALKSPEED OVERRIDE",
		["Quote"] = "\"I\'m it I\'m it I\'M IT!\" - c00lkidd",
		["Text"] = "Cooldown: 20s\n" .. ("Damage: %*\n"):format(v1.WalkspeedOverrideDamage) .. ("After a very short windup, <font color=\"rgb(200,20,20)\">c00lkidd</font> does a lengthy lunge forwards for %*s.\n"):format(v1.WalkspeedOverrideDuration) .. "The lunge stops prematurely upon collision of a survivor or obstacle.\nColliding with a survivor during the lunge causes the survivor to take damage, applying the <b>Burning I</b> effect for 8 seconds.\n"
	},
	{
		["Image"] = "rbxassetid://105652328381208",
		["Header"] = "PIZZA DELIVERY",
		["Quote"] = "\"This one\'s on the house!\" - c00lkidd",
		["Text"] = "Cooldown: 50s\n" .. ("Damage: %*\n"):format(v1.PizzaDeliveryGuyDamage) .. "After a long windup, <font color=\"rgb(200,20,20)\">c00lkidd</font> summons two pizza delivery bots. They automatically seek out the closest survivors.\nIf a survivor is damaged by a bot, their aura is revealed to <font color=\"rgb(200,20,20)\">c00lkidd</font> for 15 seconds and gains <b>Burning I</b> and <b>Slowness II</b> for 3 seconds.\n"
	}
}
return v1
