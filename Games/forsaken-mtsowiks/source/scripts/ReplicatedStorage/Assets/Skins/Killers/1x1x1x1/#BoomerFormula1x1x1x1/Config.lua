-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["DisplayName"] = "Boomer Formula",
	["Quote"] = "\"you\'re so old man\"",
	["Credits"] = "By: AndrewDotWeb & nickelj",
	["RenderImage"] = "rbxassetid://129384396545278",
	["Price"] = 1250,
	["Exclusive"] = true,
	["Dev"] = true,
	["Health"] = 1100,
	["Speed"] = 6,
	["HighlightDisabled"] = false,
	["HighlightProperties"] = {
		["FillColor"] = Color3.fromRGB(74, 74, 74),
		["OutlineColor"] = Color3.new(),
		["FillTransparency"] = 15,
		["OutlineTransparency"] = 0.95
	},
	["SprintSpeed"] = 26.5,
	["StaminaLoss"] = 10,
	["StaminaGain"] = 20,
	["MaxStamina"] = 110,
	["Relation"] = "Shedletsky",
	["IntroLighting"] = script.IntroLighting,
	["IntroHeadTemplate"] = script.ShedletskyHead,
	["SlashDamage"] = 20,
	["SlashPoisonLevel"] = 1,
	["SlashPoisonDuration"] = 5,
	["SlashGlitchLevel"] = 1,
	["SlashGlitchDuration"] = 5,
	["SlashCooldown"] = 1.75,
	["MassInfectionCooldown"] = 14,
	["MassInfectionSlashDamage"] = 20,
	["MassInfectionSlashPoisonLevel"] = 5,
	["MassInfectionSlashPoisonDuration"] = 15,
	["MassInfectionSlashGlitchLevel"] = 3,
	["MassInfectionSlashGlitchDuration"] = 15,
	["MassInfectionShockwaveSpeed"] = 100,
	["MassInfectionShockwaveLifetime"] = 5,
	["MassInfectionShockwaveDamage"] = 15,
	["MassInfectionShockwavePoisonLevel"] = 3,
	["MassInfectionShockwavePoisonDuration"] = 10,
	["MassInfectionShockwaveGlitchLevel"] = 1,
	["MassInfectionShockwaveGlitchDuration"] = 10,
	["MassInfectionShockwaveAuraDuration"] = 2,
	["ShockwaveTemplate"] = script.Shockwave,
	["EntanglementCooldown"] = 18,
	["EntanglementSpeed"] = 125,
	["EntanglementLifetime"] = 10,
	["EntanglementDamage"] = 16,
	["EntanglementPoisonLevel"] = 1,
	["EntanglementPoisonDuration"] = 10,
	["EntanglementGlitchLevel"] = 1,
	["EntanglementGlitchDuration"] = 10,
	["EntanglementHelplessDuration"] = 10,
	["EntanglementAuraDuration"] = 2,
	["EntanglementSpeedBuff"] = 1.25,
	["SwordsTemplate"] = script.Swords,
	["PopupsFolder"] = script.Popups,
	["UnstableEyeCooldown"] = 30,
	["UnstableEyeBuffDuration"] = 8,
	["UnstableEyeDebuffDuration"] = 8,
	["UnstableEyeAuraDuration"] = 5,
	["RejuvenateTheRottenCooldown"] = 80,
	["ZombieHealth"] = 30,
	["ZombieWalkSpeed"] = 6,
	["ZombieSprintSpeed"] = 17.5,
	["ZombieAttackCooldown"] = 3,
	["ZombieAttackDamage"] = 14,
	["ZombieAttackRange"] = 5,
	["ZombieTargetRange"] = 28,
	["ZombieLoseFocusRange"] = 75,
	["ZombieTemplate"] = script.Zombie,
	["ZombieAnimations"] = {
		["Idle"] = "rbxassetid://109909949048981",
		["Walk"] = "rbxassetid://84799965587521",
		["Run"] = "rbxassetid://118390000408761",
		["Attack"] = "rbxassetid://135296520297310",
		["Summon"] = "rbxassetid://90708679537111"
	}
}
local v2 = {
	["ThemeID"] = "rbxassetid://116564900353263",
	["ThemeProperties"] = {
		["Volume"] = 1
	},
	["RoundTime"] = 74
}
v1.LastManStandingData = v2
v1.Relations = { "Shedletsky" }
local v3 = {
	["ThemeID"] = "rbxassetid://134174166564242",
	["ThemeProperties"] = {
		["Volume"] = 1.3
	},
	["RoundTime"] = 97
}
v1.LastManStandingEmotionalData = v3
local v4 = {
	["Idle"] = "rbxassetid://96760620437112",
	["Walk"] = "rbxassetid://113507518189677",
	["Run"] = "rbxassetid://124908387144617",
	["Introduction"] = {
		["KillerRig"] = "rbxassetid://80781309072856",
		["CameraRig"] = "rbxassetid://92426226316147"
	},
	["Execution"] = {
		["KillerRig"] = "rbxassetid://112781850305657",
		["PlayerRig"] = "rbxassetid://93666484604456"
	},
	["BetterIdle"] = "rbxassetid://96760620437112",
	["BetterWalk"] = "rbxassetid://93310013089716",
	["BetterRun"] = "rbxassetid://121690303224628",
	["Slash"] = "rbxassetid://84070351761554",
	["Entanglement"] = "rbxassetid://109858705592116",
	["UnstableEye"] = "rbxassetid://74555272477559",
	["RejuvenateTheRotten"] = "rbxassetid://99600370625108",
	["MassInfection"] = "rbxassetid://86900749419349",
	["Stunned"] = {
		["Start"] = "rbxassetid://102633667603785",
		["Loop"] = "rbxassetid://138044793852390",
		["End"] = "rbxassetid://127934927416652"
	}
}
v1.Animations = v4
local v5 = {
	["Footsteps"] = { "rbxassetid://75457135715759", "rbxassetid://95246424997069" },
	["Stunned"] = "rbxassetid://102398799721605"
}
local v6 = {
	[60] = {
		["ID"] = "rbxassetid://139077752274344",
		["BPM"] = 81
	},
	[40] = {
		["ID"] = "rbxassetid://138788478313794",
		["BPM"] = 81
	},
	[20] = {
		["ID"] = "rbxassetid://119190262296427",
		["BPM"] = 81
	},
	[6] = {
		["ID"] = "rbxassetid://120975185858743",
		["BPM"] = 81,
		["Chase"] = true
	}
}
v5.TerrorRadiusThemes = v6
v5.EntanglementActivate = "rbxassetid://128711903717226"
v5.UnstableEyeActivate = "rbxassetid://128439277996285"
v5.UnstableEyeMode = "rbxassetid://134037097890097"
v5.RejuvenateTheRottenActivate = "rbxassetid://128226726836653"
v5.MassInfectionActivate = "rbxassetid://79782181585087"
v5.Chains = "rbxassetid://84279430446111"
v5.Swing = "rbxassetid://101199185291628"
v5.Hit = "rbxassetid://89828271975845"
v5.Introduction = "rbxassetid://97851287933867"
v1.Sounds = v5
local v7 = {}
local v8 = {
	["Header"] = "STATS",
	["Text"] = "Difficulty: \226\152\133\226\152\133\226\152\133\226\152\134\226\152\134\n" .. ("Health: %*\n"):format(v1.Health) .. ("Regular Speed: %*\n"):format(v1.Speed) .. ("Sprinting Speed: %*\n"):format(v1.SprintSpeed) .. ("Max Stamina: %*\n"):format(v1.MaxStamina) .. ("Stamina Loss per sec: %*\n"):format(v1.StaminaLoss) .. ("Stamina Gain per sec: %*\n"):format(v1.StaminaGain)
}
local v9 = {
	["Header"] = "SLASH",
	["Quote"] = "\"Turns out they fixed nothing but the floating plates and jump pads, and the exploits in this game are insane.\" - Concerned SFOTH Player"
}
local v10 = ("Cooldown: %*s\n"):format(v1.SlashCooldown)
local v11 = ("Damage: %*\n"):format(v1.SlashDamage)
local v12 = v1.SlashGlitchLevel
local v13 = require(game.ReplicatedStorage.Modules.Util):IntToRoman(v12)
local v14 = v1.SlashGlitchDuration
local v15 = v1.SlashPoisonLevel
v9.Text = v10 .. v11 .. "<font color=\"rgb(50,225,50)\">1x1x1x1</font> swings his sword infront of him.\n" .. ("Inflicts <b>GlitchedOld %*</b> for %*s and <b>Poisoned %*</b> for %*s.\n"):format(v13, v14, require(game.ReplicatedStorage.Modules.Util):IntToRoman(v15), v1.SlashPoisonDuration)
local v16 = {
	["Header"] = "MASS INFECTION",
	["Quote"] = "\"Blame \226\150\136\226\150\136\226\150\136\226\150\136.\" - Roblox Admin"
}
local v17 = ("Cooldown: %*s\n"):format(v1.MassInfectionCooldown)
local v18 = ("Damage: %*\n"):format(v1.MassInfectionShockwaveDamage)
local v19 = ("Projectile Lifetime: %*\n"):format(v1.MassInfectionShockwaveLifetime)
local v20 = v1.MassInfectionSlashGlitchLevel
local v21 = require(game.ReplicatedStorage.Modules.Util):IntToRoman(v20)
local v22 = v1.MassInfectionSlashGlitchDuration
local v23 = v1.MassInfectionSlashPoisonLevel
local v24 = ("Inflicts <b>GlitchedOld %*</b> for %*s and <b>Poisoned %*</b> for %*s if <font color=\"rgb(50,225,50)\">1x1x1x1</font> hits a player up close.\n"):format(v21, v22, require(game.ReplicatedStorage.Modules.Util):IntToRoman(v23), v1.MassInfectionSlashPoisonDuration)
local v25 = v1.MassInfectionShockwaveGlitchLevel
local v26 = require(game.ReplicatedStorage.Modules.Util):IntToRoman(v25)
local v27 = v1.MassInfectionShockwaveGlitchDuration
local v28 = v1.MassInfectionShockwavePoisonLevel
v16.Text = v17 .. v18 .. v19 .. "Following a windup of 1.7s, <font color=\"rgb(50,225,50)\">1x1x1x1</font> takes his two swords and performs a horizontal split with them, creating a sharp shockwave that deals damage to those it hits.\n" .. v24 .. ("Inflicts <b>GlitchedOld %*</b> for %*s and <b>Poisoned %*</b> for %*s if <font color=\"rgb(50,225,50)\">1x1x1x1</font> hits a player with the created shockwave.\n"):format(v26, v27, require(game.ReplicatedStorage.Modules.Util):IntToRoman(v28), v1.MassInfectionShockwavePoisonDuration)
v7[1] = {{
	["Separator"] = "GENERAL INFO"
}, {
	["Header"] = "1x1x1x1",
	["Text"] = "<font color=\"rgb(50,225,50)\">1x1x1x1</font> is a guy or something idk\n"
}, v8, {
	["Separator"] = "PASSIVES"
}, {
	["Header"] = "PARASITIC",
	["Quote"] = "\"Keep the link to this forum. Distribute it. Tell people the truth.\" - Roblox Admin",
	["Text"] = "Every attack that <font color=\"rgb(50,225,50)\">1x1x1x1</font> has inflicts <b>GlitchedOld</b> and <b>Poisoned</b> to some degree.\n"
}, {
	["Separator"] = "ABILITIES"
}, v9, v16, {
	["Header"] = "ENTANGLEMENT",
	["Quote"] = "\"I joined him in Crossroads, and it started raining heads saying things along the lines of \"He\'s coming back!\" and \"1x1x1x1 is coming for you!\" and the likes.\" - Roblox Admin",
	["Text"] = ("Cooldown: %*s\n"):format(v1.EntanglementCooldown) .. ("Damage: %*\n"):format(v1.EntanglementDamage) .. ("Projectile Lifetime: %*\n"):format(v1.EntanglementLifetime) .. ("Following a windup of 0.75s, <font color=\"rgb(50,225,50)\">1x1x1x1</font> throws his two swords forwards at a speed of %* studs per second.\n"):format(v1.EntanglementSpeed) .. ("If it hits a survivor, the survivor has their aura revealed to the killer for %*s, gains <b>Helpless I</b> for %*s, and gains <b>Slowness X</b>. They\'re required to do a \'minigame\' to exit their <b>Slowness</b> state.\n"):format(v1.EntanglementAuraDuration, v1.EntanglementHelplessDuration) .. "The minigame consists of them clicking on pop ups on their screen to free themselves.\n" .. ("After a survivor escapes <b>ENTANGLEMENT</b>, they gain Speed I for %*s.\n"):format(v1.EntanglementSpeedBuff)
}, {
	["Header"] = "UNSTABLE EYE",
	["Quote"] = "<b>\"I see you.\"</b>",
	["Text"] = ("Cooldown: %*s\n"):format(v1.UnstableEyeCooldown) .. "<font color=\"rgb(50,225,50)\">1x1x1x1</font> digs into his glaring red eye and tears at it, inflicting himself with multiple buffs & debuffs afterwards.\n" .. ("Reveals the auras of all living players to you and applies <b>Speed I</b> for %*s while also applying <b>Blindness III</b> for %*s.\n"):format(v1.UnstableEyeBuffDuration, v1.UnstableEyeDebuffDuration)
}, {
	["Header"] = "REJUVENATE THE ROTTEN",
	["Quote"] = "\"He sent me a message, telling me he had something to demonstrate.\" - Roblox Admin",
	["Text"] = ("Cooldown: %*s\n"):format(v1.RejuvenateTheRottenCooldown) .. "<font color=\"rgb(50,225,50)\">1x1x1x1</font> forces his swords into himself and pulls them out, resurrecting any players that he killed in the form of rotten zombies that serve him.\n" .. ("Summoned zombies wander aimlessly upon spawning and target players that are within a %* stud distance from them. They lose focus on their target if the distance between them & the target exceeds a distance of %* studs.\n"):format(v1.ZombieTargetRange, v1.ZombieLoseFocusRange) .. ("Summoned zombies have %* Health and deal %* damage to players.\n"):format(v1.ZombieHealth, v1.ZombieAttackDamage) .. "This ability starts off with 0 charges and a charge is given on kill. Max of 1 charge.\n"
}}
v1.Information = v7
return v1