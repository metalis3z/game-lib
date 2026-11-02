-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["DisplayName"] = "1x1x1x1",
	["Quote"] = "\"Then, in a footnote, <font color=\"rgb(200,200,0)\">he</font> mentions the evil 1x1x1x1.\"",
	["Credits"] = "By: AndrewDotWeb & nickelj",
	["RenderImage"] = "rbxassetid://129384396545278",
	["Price"] = 1250,
	["Health"] = 1100,
	["Speed"] = 8,
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
	["ThemeID"] = "rbxassetid://122690652418264",
	["ThemeProperties"] = {
		["Volume"] = 0.5
	},
	["RoundTime"] = 91
}
v1.LastManStandingEmotionalData = v2
v1.IntroHeadTemplate = script.ShedletskyHead
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
v1.MassInfectionSlashDamage = 28
v1.MassInfectionSlashPoisonLevel = 5
v1.MassInfectionSlashPoisonDuration = 3
v1.MassInfectionSlashGlitchLevel = 2
v1.MassInfectionSlashGlitchDuration = 6
v1.MassInfectionShockwaveSpeed = 80
v1.MassInfectionShockwaveLifetime = 6
v1.MassInfectionShockwaveDamage = 35
v1.MassInfectionShockwavePoisonLevel = 1
v1.MassInfectionShockwavePoisonDuration = 5
v1.MassInfectionShockwaveGlitchLevel = 1
v1.MassInfectionShockwaveGlitchDuration = 5
v1.MassInfectionShockwaveAuraDuration = 2
v1.ShockwaveTemplate = script.Shockwave
v1.EntanglementCooldown = 18
v1.EntanglementSpeed = 125
v1.EntanglementLifetime = 10
v1.EntanglementDamage = 10
v1.EntanglementPoisonLevel = 2
v1.EntanglementPoisonDuration = 16
v1.EntanglementGlitchLevel = 3
v1.EntanglementGlitchDuration = 16
v1.EntanglementHelplessDuration = 10
v1.EntanglementAuraDuration = 2
v1.EntanglementSurvivorSpeedBuffDuration = 1.25
v1.EntanglementKillerSpeedBuffDuration = 3
v1.EntanglementPopupCount = 5
v1.SwordsTemplate = script.Swords
v1.PopupsFolder = script.Popups
v1.UnstableEyeCooldown = 25
v1.UnstableEyeBuffDuration = 5
v1.UnstableEyeDebuffDuration = 5
v1.UnstableEyeAuraDuration = 7
v1.RejuvenateTheRottenCooldown = 200
v1.ZombieHealth = 5
v1.ZombieWalkSpeed = 6
v1.ZombieSprintSpeed = 17.5
v1.ZombieAttackCooldown = 3
v1.ZombieAttackDamage = 14
v1.ZombieAttackRange = 5
v1.ZombieTargetRange = 30
v1.ZombieLoseFocusRange = 50
v1.ZombieKillSpeedLevel = 1
v1.ZombieKillSpeedDuration = 10
v1.ZombieTemplate = script.Zombie
v1.ZombieAnimations = {
	["Idle"] = "rbxassetid://114618828676903",
	["Walk"] = "rbxassetid://73133376900765",
	["Run"] = "rbxassetid://129376203551070",
	["Attack"] = "rbxassetid://117430583584746",
	["Summon"] = "rbxassetid://78631393387548"
}
v1.IntroLighting = script.IntroLighting
v1.OutroLighting = script.OutroLighting
local v3 = {
	["Idle"] = "rbxassetid://113884418016805",
	["Walk"] = "rbxassetid://90849533342327",
	["Run"] = "rbxassetid://107548161293607",
	["InjuredIdle"] = "rbxassetid://113884418016805",
	["InjuredWalk"] = "rbxassetid://90849533342327",
	["InjuredRun"] = "rbxassetid://107548161293607",
	["Introduction"] = {
		["KillerRig"] = "rbxassetid://93631393862880",
		["CameraRig"] = "rbxassetid://72673765763845"
	},
	["Execution"] = {
		["KillerRig"] = "rbxassetid://116311831890699",
		["PlayerRig"] = "rbxassetid://129579947547975"
	},
	["ExecutionShedletsky"] = {
		["KillerRig"] = "rbxassetid://108348470619514",
		["PlayerRig"] = "rbxassetid://72047950361515"
	},
	["BetterIdle"] = "rbxassetid://139772711089050",
	["BetterWalk"] = "rbxassetid://114742312287716",
	["BetterRun"] = "rbxassetid://94845527287903",
	["Slash"] = "rbxassetid://124976530998275",
	["Entanglement"] = "rbxassetid://125855029516810",
	["UnstableEye"] = "rbxassetid://140357073445535",
	["RejuvenateTheRotten"] = "rbxassetid://100646958509833",
	["MassInfection"] = "rbxassetid://136208327582382",
	["Stunned"] = {
		["Start"] = "rbxassetid://75755594103290",
		["Loop"] = "rbxassetid://91639031309501",
		["End"] = "rbxassetid://72433672651391"
	},
	["Victory"] = {
		["KillerRig"] = "rbxassetid://111052018148816",
		["CameraRig"] = "rbxassetid://132118889620529",
		["ShedletskyRig"] = "rbxassetid://86986717987066"
	}
}
v1.Animations = v3
local v4 = {
	["Ambience"] = "rbxassetid://135626822769942",
	["Footsteps"] = { "rbxassetid://113371148599785", "rbxassetid://96378940470010", "rbxassetid://83310314949003" }
}
local v5 = {
	[60] = {
		["ID"] = "rbxassetid://139957641994343",
		["BPM"] = 81
	},
	[40] = {
		["ID"] = "rbxassetid://107607873139123",
		["BPM"] = 81
	},
	[20] = {
		["ID"] = "rbxassetid://105551772469406",
		["BPM"] = 81
	},
	[6] = {
		["ID"] = "rbxassetid://129183326022098",
		["BPM"] = 81,
		["Chase"] = true
	}
}
v4.TerrorRadiusThemes = v5
v4.EntanglementActivate = "rbxassetid://101593173978979"
v4.EntanglementProjectile = "rbxassetid://79665854201966"
v4.UnstableEyeActivate = "rbxassetid://108076060525747"
v4.UnstableEyeMode = "rbxassetid://134037097890097"
v4.RejuvenateTheRottenActivate = "rbxassetid://134547664735830"
v4.RejuvenateTheRottenRevive = "rbxassetid://102233628962479"
v4.RejuvenateTheRottenMinionIdle = "rbxassetid://82189934633503"
v4.RejuvenateTheRottenMinionHit = "rbxassetid://132370686359251"
v4.MassInfectionActivate = "rbxassetid://72296288942160"
v4.MassInfectionProjectile = "rbxassetid://136644374644573"
v4.Chains = "rbxassetid://97061990471922"
v4.Stunned = {
	["Start"] = "rbxassetid://137226563866993",
	["End"] = "rbxassetid://102731091551965"
}
v4.Execution = "rbxassetid://114489075814479"
v4.ExecutionShedletsky = "rbxassetid://109911656332309"
v4.Swing = "rbxassetid://115026634746636"
v4.Hit = "rbxassetid://74183834601348"
v4.Introduction = "rbxassetid://108230052895205"
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
local v13 = ("%* swings his sword infront of him.\n"):format("<font color=\"rgb(50,225,50)\">1x1x1x1</font>")
local v14 = v1.SlashGlitchLevel
local v15 = require(game.ReplicatedStorage.Modules.Util):IntToRoman(v14)
local v16 = v1.SlashGlitchDuration
local v17 = v1.SlashPoisonLevel
v8.Text = v9 .. v10 .. v11 .. v12 .. "Length: 7.5 studs\n" .. v13 .. ("Inflicts <b>Glitched %*</b> for %*s and <b>Poisoned %*</b> for %*s.\n"):format(v15, v16, require(game.ReplicatedStorage.Modules.Util):IntToRoman(v17), v1.SlashPoisonDuration)
local v18 = {
	["Header"] = "MASS INFECTION",
	["Quote"] = "\"Blame \226\150\136\226\150\136\226\150\136\226\150\136.\" - Roblox Admin"
}
local v19 = ("Cooldown: %*s\n"):format(v1.MassInfectionCooldown)
local v20 = ("Damage: %*\n"):format(v1.MassInfectionShockwaveDamage)
local v21 = ("Projectile Lifetime: %*\n"):format(v1.MassInfectionShockwaveLifetime)
local v22 = ("Following a windup of 1.7s, %* takes his two swords and performs a horizontal split with them, creating a sharp shockwave that deals damage to those it hits.\n"):format("<font color=\"rgb(50,225,50)\">1x1x1x1</font>")
local v23 = v1.MassInfectionSlashGlitchLevel
local v24 = require(game.ReplicatedStorage.Modules.Util):IntToRoman(v23)
local v25 = v1.MassInfectionSlashGlitchDuration
local v26 = v1.MassInfectionSlashPoisonLevel
local v27 = ("Inflicts <b>Glitched %*</b> for %*s and <b>Poisoned %*</b> for %*s if %* hits a player up close.\n"):format(v24, v25, require(game.ReplicatedStorage.Modules.Util):IntToRoman(v26), v1.MassInfectionSlashPoisonDuration, "<font color=\"rgb(50,225,50)\">1x1x1x1</font>")
local v28 = v1.MassInfectionShockwaveGlitchLevel
local v29 = require(game.ReplicatedStorage.Modules.Util):IntToRoman(v28)
local v30 = v1.MassInfectionShockwaveGlitchDuration
local v31 = v1.MassInfectionShockwavePoisonLevel
v18.Text = v19 .. v20 .. v21 .. v22 .. v27 .. ("Inflicts <b>Glitched %*</b> for %*s and <b>Poisoned %*</b> for %*s if %* hits a player with the created shockwave.\n"):format(v29, v30, require(game.ReplicatedStorage.Modules.Util):IntToRoman(v31), v1.MassInfectionShockwavePoisonDuration, "<font color=\"rgb(50,225,50)\">1x1x1x1</font>") .. ("<b>It should be noted that the windup of this attack can be heard by all players within a 400 stud radius of %*.</b>\n"):format("<font color=\"rgb(50,225,50)\">1x1x1x1</font>")
local v32 = {
	["Header"] = "ENTANGLEMENT",
	["Quote"] = "\"I joined him in Crossroads, and it started raining heads saying things along the lines of \"He\'s coming back!\" and \"1x1x1x1 is coming for you!\" and the likes.\" - Roblox Admin",
	["Text"] = ("Cooldown: %*s\n"):format(v1.EntanglementCooldown) .. ("Damage: %*\n"):format(v1.EntanglementDamage) .. ("Projectile Lifetime: %*\n"):format(v1.EntanglementLifetime) .. ("Following a windup of 0.75s, %* throws his two swords forwards at a speed of %* studs per second.\n"):format("<font color=\"rgb(50,225,50)\">1x1x1x1</font>", v1.EntanglementSpeed) .. ("If it hits a survivor, then %* gains <b>Speed II</b> for %*s, the hit survivor has their aura revealed to the killer for %*s, gains <b>Helpless I</b> for %*s, and gains <b>Slowness X</b>. The survivor is required to do a \'minigame\' to have their <b>Slowness X</b> removed.\n"):format("<font color=\"rgb(50,225,50)\">1x1x1x1</font>", v1.EntanglementKillerSpeedBuffDuration, v1.EntanglementAuraDuration, v1.EntanglementHelplessDuration) .. ("The minigame requires the survivor to click on %* pop ups on their screen to free themselves.\n"):format(v1.EntanglementPopupCount) .. ("Survivors are automatically freed from <b>ENTANGLEMENT</b> after 3 seconds, and being freed grants <b>Speed I</b> to the survivor for %* seconds.\n"):format(v1.EntanglementSurvivorSpeedBuffDuration)
}
local v33 = {
	["Header"] = "UNSTABLE EYE",
	["Quote"] = "<b>\"I see you.\"</b>",
	["Text"] = ("Cooldown: %*s\n"):format(v1.UnstableEyeCooldown) .. ("%* digs into his glaring red eye and tears at it, inflicting himself with multiple buffs & debuffs afterwards.\n"):format("<font color=\"rgb(50,225,50)\">1x1x1x1</font>") .. ("Reveals the auras of all living players to you and applies <b>Speed I</b> for %*s while also applying <b>Blindness III</b> for %*s.\n"):format(v1.UnstableEyeBuffDuration, v1.UnstableEyeDebuffDuration) .. "This ability starts on a halved cooldown at the beginning of the game.\n"
}
local v34 = {
	["Header"] = "REJUVENATE THE ROTTEN",
	["Quote"] = "\"He sent me a message, telling me he had something to demonstrate.\" - Roblox Admin"
}
local v35 = ("Cooldown: %*s\n"):format(v1.RejuvenateTheRottenCooldown)
local v36 = ("%* forces his swords into himself and pulls them out, resurrecting any players that he killed in the form of rotten zombies that serve him.\n"):format("<font color=\"rgb(50,225,50)\">1x1x1x1</font>")
local v37 = ("Summoned zombies wander aimlessly upon spawning and target players that are within a %* stud distance from them. They lose focus on their target if the distance between them & the target exceeds a distance of %* studs.\n"):format(v1.ZombieTargetRange, v1.ZombieLoseFocusRange)
local v38 = ("Summoned zombies have %* Health and deal %* damage to players.\n"):format(v1.ZombieHealth, v1.ZombieAttackDamage)
local v39 = v1.ZombieKillSpeedLevel
v34.Text = v35 .. v36 .. v37 .. v38 .. ("Although the zombies are loyal to %*, %* can kill them to gain <b>Speed %*</b> for %*s.\n"):format("<font color=\"rgb(50,225,50)\">1x1x1x1</font>", "<font color=\"rgb(50,225,50)\">1x1x1x1</font>", require(game.ReplicatedStorage.Modules.Util):IntToRoman(v39), v1.ZombieKillSpeedDuration) .. "This ability starts off with 0 charges and a charge is given on kill. Max of 1 charge.\n"
v6={{
	["Separator"] = "GENERAL INFO"
}, {
	["Header"] = "1x1x1x1",
	["Text"] = "The physical manifeststion of pure malice, hatred, and negativity himself; the one who despises no one else more than the former admin, Shedletsky. With the daemonshank in his hands, he can summon beings of rot from the deceased, as well as target survivors from afar, poisoning them in the process.\n"
}, v7, {
	["Separator"] = "ABILITIES"
}, v8, v18, v32, v33, v34}
v1.Information = v6
return v1
