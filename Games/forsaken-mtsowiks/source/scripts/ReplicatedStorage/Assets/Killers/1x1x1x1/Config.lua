--My name is 1eggs. I made the breakfast. It was difficult, to put the meal together. But unfortunately, something went so wrong. And now I can't do anything but sing this stupid song! My name is 1eggs! 1eggs! 1eggs! 1eggs! 1eggs!
local v1 = {
	["DisplayName"] = "1x1x1x1",
	["Quote"] = "\"Then, in a footnote, <font color=\"rgb(200,200,0)\">he</font> mentions the evil 1x1x1x1.\"",
	["Credits"] = "Decompiled by: Keve",
	["RenderImage"] = "rbxassetid://81142920821937",
	["Price"] = 1250,
	["Health"] = 1100,
	["Speed"] = 8.5,
	["HighlightDisabled"] = false,
	["HighlightProperties"] = {
		["FillColor"] = Color3.fromRGB(74, 74, 74),
		["OutlineColor"] = Color3.new(),
		["FillTransparency"] = 15,
		["OutlineTransparency"] = 0.95
	},
	["SprintSpeed"] = 27,
	["StaminaLoss"] = 9.5,
	["StaminaGain"] = 21,
	["MaxStamina"] = 110,
	["Relations"] = { "Shedletsky" }
}
local v2 = {
	["ThemeID"] = "rbxassetid://115884097233860",
	["ThemeProperties"] = {
		["Volume"] = 0.5
	},
	["RoundTime"] = 91
}
v1.LastManStandingEmotionalData = v2
v1.IntroHeadTemplate = script.ShedletskyHead
v1.ELMSLighting = script.ELMSLighting
v1.OutroVFXFolder = script.OutroVFX
v1.SlashDamage = 20
v1.SlashWindup = 0.4
v1.SlashLinger = 0.25
v1.SlashPoisonLevel = 1
v1.SlashPoisonDuration = 5
v1.SlashGlitchLevel = 1
v1.SlashGlitchDuration = 5
v1.SlashCooldown = 1.75
v1.MassInfectionCooldown = 14
v1.MassInfectionSlashDamage = 25
v1.MassInfectionSlashEffects = {
	{
		"Poisoned",
		{
			["Stackable"] = true,
			["Level"] = 1,
			["Duration"] = 5
		}
	},
	{
		"Glitched",
		{
			["Stackable"] = true,
			["Level"] = 1,
			["Duration"] = 5
		}
	}
}
v1.MassInfectionShockwaveVignette = script.MainVignette
v1.MassInfectionShockwaveSpeed = 106.48
v1.MassInfectionShockwaveLunge = 42
v1.MassInfectionShockwaveLifetime = 6
v1.MassInfectionShockwaveDamage = 30
v1.MassInfectionShockwaveBonusDamage = 10
v1.MassInfectionShockwaveEffects = {
	{
		"Poisoned",
		{
			["Stackable"] = true,
			["Level"] = 5,
			["Duration"] = 3
		}
	},
	{
		"Glitched",
		{
			["Stackable"] = true,
			["Level"] = 2,
			["Duration"] = 6
		}
	}
}
v1.MassInfectionShockwaveAuraDuration = 12
v1.ShockwaveTemplate = script.Shockwave
v1.EntanglementCooldown = 15
v1.EntanglementSpeed = 125
v1.EntanglementLifetime = 1
v1.EntanglementDamage = 15
v1.EntanglementPullFactor = 45
v1.EntangelmentInFrontOffset = 2.5
v1.EntanglementMaxPullDistance = 15
v1.EntanglementEffects = {
	{
		"Glitched",
		{
			["Stackable"] = true,
			["Level"] = 1,
			["Duration"] = 6
		}
	}
}
v1.EntanglementHelplessDuration = 6
v1.EntanglementAuraDuration = 12
v1.EntanglementSurvivorSpeedBuffDuration = 1.25
v1.EntanglementKillerSpeedBuffDuration = 3
v1.EntanglementPopupCount = 9
v1.SwordsTemplate = script.Swords
v1.PopupsFolder = script.Popups
v1.UnstableEyeVignette = script.UnstableEyeVignette
v1.UnstableEyeCooldown = 25
v1.UnstableEyeEffects = {
	{
		"Speed",
		{
			["Stackable"] = true,
			["Level"] = 2,
			["Duration"] = 1.25
		}
	},
	{
		"Blindness",
		{
			["Stackable"] = true,
			["Level"] = 3,
			["Duration"] = 7
		}
	}
}
v1.UnstableEyeAuraDuration = 8
v1.RejuvenateTheRottenCooldown = 30
v1.ZombieHealth = 25
v1.ZombieWalkSpeed = 6
v1.ZombieSprintSpeed = 17.5
v1.ZombieAttackCooldown = 3
v1.ZombieAttackDamage = 1
v1.ZombieAttackEffects = {
	{
		"Poisoned",
		{
			["Stackable"] = true,
			["Level"] = 1,
			["Duration"] = 8
		}
	},
	{
		"Glitched",
		{
			["Stackable"] = true,
			["Level"] = 1,
			["Duration"] = 8
		}
	}
}
v1.ZombieRevealTime = 8
v1.ZombieAttackRange = 5
v1.ZombieTargetRange = 24
v1.ZombieLoseFocusRange = 40
v1.ZombieKillSpeedLevel = 1
v1.ZombieKillSpeedDuration = 10
v1.ZombieTemplate = script.Zombie
v1.ZombieAnimations = {
	["Idle"] = "rbxassetid://113898108956185",
	["Walk"] = "rbxassetid://74440013321163",
	["Run"] = "rbxassetid://72917616022858",
	["Attack"] = "rbxassetid://125131415070973",
	["Summon"] = "rbxassetid://136298645880374"
}
v1.IntroLighting = script.IntroLighting
v1.OutroLighting = script.OutroLighting
local v3 = {
	["Idle"] = "rbxassetid://123465806588610",
	["Walk"] = "rbxassetid://107936475276291",
	["Run"] = "rbxassetid://88954761757615",
	["InjuredIdle"] = "rbxassetid://114747774368637",
	["InjuredWalk"] = "rbxassetid://95392612165581",
	["InjuredRun"] = "rbxassetid://94202100018904",
	["Introduction"] = {
		["KillerRig"] = "rbxassetid://122689789705297",
		["CameraRig"] = "rbxassetid://137349092965387"
	},
	["Execution"] = {
		["KillerRig"] = "rbxassetid://106304031101923",
		["PlayerRig"] = "rbxassetid://77307979584072"
	},
	["ExecutionShedletsky"] = {
		["KillerRig"] = "rbxassetid://85243689897000",
		["PlayerRig"] = "rbxassetid://100992238394650"
	},
	["BetterIdle"] = "rbxassetid://114747774368637",
	["BetterWalk"] = "rbxassetid://104524990445799",
	["BetterRun"] = "rbxassetid://73108995288570",
	["Slash"] = "rbxassetid://88754451646023",
	["Entanglement"] = "rbxassetid://119779152795622",
	["UnstableEye"] = "rbxassetid://86200035840251",
	["RejuvenateTheRotten"] = "rbxassetid://134238358898806",
	["MassInfection"] = "rbxassetid://93781743809491",
	["Stunned"] = {
		["Start"] = "rbxassetid://105168764868836",
		["Loop"] = "rbxassetid://105250982881737",
		["End"] = "rbxassetid://102561656978036"
	},
	["Victory"] = {
		["KillerRig"] = "rbxassetid://97969539425245",
		["CameraRig"] = "rbxassetid://129409537698052",
		["ShedletskyRig"] = "rbxassetid://122588922351855"
	}
}
v1.Animations = v3
local v4 = {
	["Ambience"] = "rbxassetid://135626822769942",
	["Footsteps"] = { "rbxassetid://102841463330362", "rbxassetid://75158876617166", "rbxassetid://109875074239430" }
}
local v5 = {
	[60] = {
		["ID"] = "rbxassetid://134354733736550",
		["BPM"] = 81
	},
	[40] = {
		["ID"] = "rbxassetid://122342201702234",
		["BPM"] = 81
	},
	[20] = {
		["ID"] = "rbxassetid://102116402118323",
		["BPM"] = 81
	},
	[6] = {
		["ID"] = "rbxassetid://115134963214095",
		["BPM"] = 81,
		["Chase"] = true
	}
}
v4.TerrorRadiusThemes = v5
v4.EntanglementActivate = "rbxassetid://105934041806374"
v4.EntanglementProjectile = "rbxassetid://81989261113189"
v4.EntanglementHit = "rbxassetid://129108619555351"
v4.EntanglementJumpscare = ""
v4.EntanglementPopup = "rbxassetid://75455886794852"
v4.UnstableEyeActivate = "rbxassetid://91495033241141"
v4.UnstableEyeMode = "rbxassetid://134037097890097"
v4.RejuvenateTheRottenActivate = "rbxassetid://120877949577353"
v4.RejuvenateTheRottenRevive = "rbxassetid://75781371200025"
v4.RejuvenateTheRottenMinionIdle = "rbxassetid://118031993029128"
v4.RejuvenateTheRottenMinionHit = "rbxassetid://104635986451636"
v4.MassInfectionActivate = "rbxassetid://132331977491979"
v4.MassInfectionProjectile = "rbxassetid://77100821793542"
v4.Chains = "rbxassetid://70845653728841"
v4.Stunned = {
	["Start"] = "rbxassetid://109104623884660",
	["End"] = "rbxassetid://91701352272641"
}
v4.Execution = "rbxassetid://88079488176845"
v4.ExecutionShedletsky = "rbxassetid://78889935571145"
v4.Swing = "rbxassetid://117173212095661"
v4.Hit = "rbxassetid://100321250424257"
v4.Introduction = "rbxassetid://140542418397406"
v4.VictoryTheme = "rbxassetid://99627234761732"
v1.Sounds = v4
local v6 = {}
local v7 = {
	["Header"] = "STATS",
	["Text"] = "Difficulty: \226\152\133\226\152\133\226\152\133\226\152\133\226\152\134\n" .. ("Health: %*\n"):format(v1.Health) .. ("Regular Speed: %*\n"):format(v1.Speed) .. ("Sprinting Speed: %*\n"):format(v1.SprintSpeed) .. ("Max Stamina: %*\n"):format(v1.MaxStamina) .. ("Stamina Loss per sec: %*\n"):format(v1.StaminaLoss) .. ("Stamina Gain per sec: %*\n"):format(v1.StaminaGain) .. "Terror Radius: 60 studs\n"
}
local v8 = {
	["Header"] = "SLASH",
	["Quote"] = "\"Turns out they fixed nothing but the floating plates and jump pads, and the exploits in this game are insane.\" - Concerned SFOTH Player"
}
local v9 = ("Cooldown: %*s\n"):format(v1.SlashCooldown)
local v10 = ("Damage: %*\n"):format(v1.SlashDamage)
local v11 = ("Windup: %*s\n"):format(v1.SlashWindup)
local v12 = ("Linger: %*s\n"):format(v1.SlashLinger)
local v13 = v1.SlashGlitchLevel
local v14 = require(game.ReplicatedStorage.Modules.Util):IntToRoman(v13)
local v15 = v1.SlashGlitchDuration
local v16 = v1.SlashPoisonLevel
v8.Text = v9 .. v10 .. v11 .. v12 .. "Length: 7.5 studs\n" .. "<font color=\"rgb(50,225,50)\">1x1x1x1</font> swings his sword infront of him.\n" .. ("Inflicts <b>Glitched %*</b> for %*s and <b>Poisoned %*</b> for %*s.\n"):format(v14, v15, require(game.ReplicatedStorage.Modules.Util):IntToRoman(v16), v1.SlashPoisonDuration)
local v17 = {
	["Header"] = "MASS INFECTION",
	["Quote"] = "\"Blame \226\150\136\226\150\136\226\150\136\226\150\136.\" - Roblox Admin"
}
local v18 = ("Cooldown: %*s\n"):format(v1.MassInfectionCooldown)
local v19 = ("Damage: %*\n"):format(v1.MassInfectionShockwaveDamage)
local v20 = ("Projectile Lifetime: %*s\n"):format(v1.MassInfectionShockwaveLifetime)
local v21 = v1.MassInfectionSlashPoisonLevel
local v22 = ("Inflicts <b>Glitched I</b> for 5s and <b>Poisoned %*</b> for %*s and deals 25 damage if <font color=\"rgb(50,225,50)\">1x1x1x1</font> hits a player up close.\n"):format(require(game.ReplicatedStorage.Modules.Util):IntToRoman(v21), v1.MassInfectionSlashPoisonDuration)
local v23 = v1.MassInfectionShockwavePoisonLevel
v17.Text = v18 .. v19 .. v20 .. "Following a windup of 1.7s, <font color=\"rgb(50,225,50)\">1x1x1x1</font> takes his two swords and performs a horizontal split with them, creating a sharp shockwave that deals damage to those it hits.\n" .. v22 .. ("Inflicts <b>Glitched II</b> for 6s and <b>Poisoned %*</b> for %*s if <font color=\"rgb(50,225,50)\">1x1x1x1</font> hits a player with the created shockwave.\n"):format(require(game.ReplicatedStorage.Modules.Util):IntToRoman(v23), v1.MassInfectionShockwavePoisonDuration) .. ("The created shockwave deals an additional %* damage if it hits a survivor already afflicted with <b>Glitched</b>.\n"):format(v1.MassInfectionShockwaveBonusDamage) .. ("Survivors hit by the shockwave have their aura revealed to <font color=\"rgb(50,225,50)\">1x1x1x1</font> for %*s\n"):format(v1.MassInfectionShockwaveAuraDuration) .. "Upon releasing the shockwave, <font color=\"rgb(50,225,50)\">1x1x1x1</font> is granted a 25% speed boost for 1s.\n<b>It should be noted that the windup of this attack can be heard by all survivors regardless of proximity to <font color=\"rgb(50,225,50)\">1x1x1x1</font>.</b>\n"
local v24 = {
	["Header"] = "ENTANGLEMENT",
	["Quote"] = "\"I joined him in Crossroads, and it started raining heads saying things along the lines of \"He\'s coming back!\" and \"1x1x1x1 is coming for you!\" and the likes.\" - Roblox Admin",
	["Text"] = ("Cooldown: %*s\n"):format(v1.EntanglementCooldown) .. ("Damage: %*\n"):format(v1.EntanglementDamage) .. ("Projectile Lifetime: %*s\n"):format(v1.EntanglementLifetime) .. ("Following a windup of 0.75s, <font color=\"rgb(50,225,50)\">1x1x1x1</font> throws his two swords forwards at a speed of %* studs per second.\n"):format(v1.EntanglementSpeed) .. "Upon hitting a survivor, they will be completely unable to move for 1s and popups will appear on their screen.\n" .. "Additionally, hit survivors are slightly pulled towards <font color=\"rgb(50,225,50)\">1x1x1x1</font> and are inflicted with <b>Glitched I</b> and <b>Helpless I</b> for 6s.\n" .. "The strength of the pull is increased by 50% if <b>ENTANGLEMENT</b> hits a survivor already inflicted with <b>Glitched</b>.\n" .. ("Survivors hit by <b>ENTANGLEMENT</b> have their aura revealed to <font color=\"rgb(50,225,50)\">1x1x1x1</font> for %*s.\n"):format(v1.EntanglementAuraDuration)
}
local v25 = {
	["Header"] = "UNSTABLE EYE",
	["Quote"] = "<b>\"I see you.\"</b>",
	["Text"] = ("Cooldown: %*s\n"):format(v1.UnstableEyeCooldown) .. "<font color=\"rgb(50,225,50)\">1x1x1x1</font> digs into his glaring red eye and tears at it, inflicting himself with multiple buffs & debuffs afterwards.\n" .. ("Reveals the auras of all living players to you for %*s while also applying <b>Speed II</b> for 1.25s and <b>Blindness III</b> for 7s.\n"):format(v1.UnstableEyeAuraDuration) .. "The aura reveal of this ability displays the amount of health the revealed player has upon use, starting at green for full health and scaling down to red at very low health.\nThis ability is able to be heard by every survivor when used regardless of proximity to <font color=\"rgb(50,225,50)\">1x1x1x1</font>.\nThis ability starts on a 12.5s cooldown at the beginning of the game.\n"
}
local v26 = {
	["Header"] = "REJUVENATE THE ROTTEN",
	["Quote"] = "\"He sent me a message, telling me he had something to demonstrate.\" - Roblox Admin"
}
local v27 = ("Cooldown: %*s\n"):format(v1.RejuvenateTheRottenCooldown)
local v28 = ("Summoned zombies wander aimlessly upon spawning and target players that are within a %* stud distance from them. They lose focus on their target if the distance between them & the target exceeds a distance of %* studs.\n"):format(v1.ZombieTargetRange, v1.ZombieLoseFocusRange)
local v29 = ("Summoned zombies have %* Health.\n"):format(v1.ZombieHealth)
local v30 = ("If a summoned zombie manages to hit a survivor, they will be inflicted with <b>Poison I, Glitched I, and have their aura revealed</b> for %*s.\n"):format(v1.ZombieRevealTime)
local v31 = v1.ZombieKillSpeedLevel
v26.Text = v27 .. "<font color=\"rgb(50,225,50)\">1x1x1x1</font> forces his swords into himself and pulls them out, resurrecting any players that he killed in the form of rotten zombies that serve him.\n" .. v28 .. v29 .. v30 .. "Summoned zombies are only able to kill survivors if they are already inflicted with <b>Glitched</b> when being hit by a zombie.\n" .. ("Although the zombies are loyal to <font color=\"rgb(50,225,50)\">1x1x1x1</font>, <font color=\"rgb(50,225,50)\">1x1x1x1</font> can kill them to gain <b>Speed %*</b> for %*s. However, <b>MASS INFECTION</b> will not kill them.\n"):format(require(game.ReplicatedStorage.Modules.Util):IntToRoman(v31), v1.ZombieKillSpeedDuration) .. "<font color=\"rgb(50,225,50)\">1x1x1x1</font> is unable to ressurect players that he has already resurrected with a previous use of the ability.\nThis ability starts off with 0 charges and a charge is given on kill. Max of 1 charge.\n"
v6[1] = {{
	["Separator"] = "GENERAL INFO"
}, {
	["Header"] = "1x1x1x1",
	["Text"] = "The physical manifeststion of pure malice, hatred, and negativity himself; the one who despises no one else more than the former admin, Shedletsky. With the daemonshank in his hands, he can summon beings of rot from the deceased, as well as target survivors from afar, poisoning them in the process.\n"
}, v7, {
	["Separator"] = "ABILITIES"
}, v8, v17, v24, v25, v26}
v1.Information = v6
return v1