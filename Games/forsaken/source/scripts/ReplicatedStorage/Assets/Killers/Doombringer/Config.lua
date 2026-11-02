local v1 = {
	["DisplayName"] = "Doombringer",
	["Quote"] = "\"It\'s MrDoomBringer! We must flee!\" - Builderman",
	["RenderImage"] = "rbxassetid://90564815185417",
	["Price"] = 2600,
	["Speed"] = 9,
	["SprintSpeed"] = 26.5,
	["StaminaLoss"] = 10,
	["StaminaGain"] = 21.5,
	["MaxStamina"] = 125,
	["Health"] = 2000,
	["SwingCooldown"] = 2.1,
	["SwingDamage"] = 30,
	["SwingWindup"] = 0.75,
	["SwingLinger"] = 0.2,
	["BanstreakCooldown"] = 40,
	["BanstreakSpeed"] = 150,
	["BanstreakMax"] = 3,
	["CraterStunTime"] = 1.5,
	["CraterRadius"] = 15,
	["CraterDamage"] = 20,
	["CraterForce"] = 5,
	["BanwaveCooldown"] = 25,
	["BanwaveDuration"] = 2.2,
	["BanwaveInterval"] = 0.1,
	["BanwaveAmount"] = 10,
	["BanwaveDamage"] = 17,
	["ScanCooldown"] = 18,
	["Relations"] = { "Shedletsky", "Builderman", "Dusekkar" }
}
local v2 = {
	["ThemeID"] = "rbxassetid://140198789885984",
	["ThemeProperties"] = {
		["Volume"] = 0.5
	},
	["RoundTime"] = 95
}
v1.LastManStandingEmotionalData = v2
local v3 = {}
local v4 = {}
local v5 = {
	["DisplayName"] = "Shimmy",
	["Description"] = "GO! STOP!",
	["AssetID"] = "rbxassetid://82283456702434",
	["SFX"] = "rbxassetid://121697785055376",
	["SFXProperties"] = {
		["Looped"] = true
	}
}
v4.bluudanc = v5
v3.Animations = v4
v1.Emotes = v3
v1.Expressions = false
local v6 = {
	["Swing"] = "rbxassetid://115340562700238",
	["Hit"] = "rbxassetid://80192488236820",
	["Hit2"] = "rbxassetid://128750110272163",
	["Banwave"] = "rbxassetid://117581172390352",
	["BSlamExtra"] = "rbxassetid://9118612665",
	["BSlam"] = "rbxassetid://125303463219842",
	["BSlamStart"] = "rbxassetid://120281658150707",
	["Execution2"] = "rbxassetid://124338436100582",
	["Introduction"] = "rbxassetid://127335629760317"
}
local v7 = {
	["ID"] = "rbxassetid://84078774840250",
	["Properties"] = {
		["Volume"] = 0.5,
		["Looped"] = false
	}
}
v6.VictoryTheme = v7
v6.Footsteps = { "rbxassetid://132133543536895", "rbxassetid://115549469959981", "rbxassetid://106694206347291" }
local v8 = {
	[60] = {
		["ID"] = "rbxassetid://79104499431541",
		["BPM"] = 72,
		["Volume"] = 1.2
	},
	[40] = {
		["ID"] = "rbxassetid://105587746960647",
		["BPM"] = 72,
		["Volume"] = 1.2
	},
	[20] = {
		["ID"] = "rbxassetid://98354758248990",
		["BPM"] = 72,
		["Volume"] = 1.2
	},
	[6] = {
		["ID"] = "rbxassetid://108525791816816",
		["BPM"] = 72,
		["Chase"] = true,
		["Volume"] = 1.2
	}
}
v6.TerrorRadiusThemes = v8
v1.Sounds = v6
local v9 = {
	["Idle"] = "rbxassetid://97535322627333",
	["Walk"] = "rbxassetid://101718287222509",
	["Run"] = "rbxassetid://134047051368237",
	["InjuredIdle"] = "rbxassetid://97535322627333",
	["InjuredWalk"] = "rbxassetid://101718287222509",
	["InjuredRun"] = "rbxassetid://134047051368237",
	["Swing"] = "rbxassetid://85061536753786",
	["Banwave"] = "rbxassetid://84057322383307",
	["Scan"] = "rbxassetid://130423328050723",         -- last anim
	["BounceEnded"] = "rbxassetid://109998770307530",
	["BounceCharge"] = "rbxassetid://138089737035235", 
	["BounceStart"] = "rbxassetid://112630535781902", 
	["BounceIdle"] = "rbxassetid://126976578192276",
	["BounceSlam"] = "rbxassetid://113445712159428",
	["Victory"] = {
		["KillerRig"] = "rbxassetid://113489075633466",
		["CameraRig"] = "rbxassetid://117053818455799"
	},
	["Introduction"] = {
		["KillerRig"] = "rbxassetid://111738270899641",
		["CameraRig"] = "rbxassetid://73472946460447"
	},
	["Stunned"] = {
		["Start"] = "rbxassetid://71421323289550",
		["Loop"] = "rbxassetid://83878584625561",
		["End"] = "rbxassetid://96980308126922"
	},
	["Execution"] = {
		["KillerRig"] = "rbxassetid://115486442462622",
		["PlayerRig"] = "rbxassetid://75302364545299"
	}
}
v1.Animations = v9
v1.EyeFX = script.FX
v1.lMod = script.LightningM

local v11_Stats = {
	["Header"] = "STATS",
	["Text"] = "Difficulty: \226\152\133\226\152\133\226\152\133\226\152\133\226\152\134\n" .. ("Health: %*\n"):format(v1.Health) .. ("Regular Speed: %*\n"):format(v1.Speed) .. ("Sprinting Speed: %*\n"):format(v1.SprintSpeed) .. ("Max Stamina: %*\n"):format(v1.MaxStamina) .. ("Stamina Loss per sec: %*\n"):format(v1.StaminaLoss) .. ("Stamina Gain per sec: %*\n"):format(v1.StaminaGain) .. "Terror Radius: 45 studs\n"
}
local v12_Swing = {
	["Image"] = "rbxassetid://114090418086193",
	["Header"] = "SWING",
	["Text"] = ("Cooldown: %*s\n"):format(v1.SwingCooldown) .. ("Damage: %*\n"):format(v1.SwingDamage) .. ("Windup: %*s\n"):format(v1.SwingWindup) .. ("Linger: %*s\n"):format(v1.SwingLinger) .. "Length: 7 studs\n<font color=\"rgb(200, 20, 20)\">Doombringer</font> performs a lengthly swing with his hammer.\nThis swing can hit through multiple people at once.\nA little speed debuff is applied after each swing to compensate for the damage.\n"
}
local v13_Banwave = {
	["Image"] = "rbxassetid://92330475760678",
	["Header"] = "BAN-WAVE",
	["Text"] = ("Cooldown: %*s\n"):format(v1.BanwaveCooldown) .. "A wave of fire pillars will be created in the direction <font color=\"rgb(200, 20, 20)\">Doombringer</font> is facing.\nBeing in the way of these will deal " .. v1.BanwaveDamage .. " damage.\nTouching one will inflict <b>Burning II</b> along with <b>Exhaustion</b>."
}
local v14_Banstreak = {
	["Image"] = "rbxassetid://127733946232246",
	["Header"] = "BAN-STREAK"
}
local v15_Text = ("Cooldown: %*s\n"):format(v1.BanstreakCooldown)
local v16_Damage = v1.CraterDamage * 0.666
v14_Banstreak.Text = v15_Text .. "<font color=\"rgb(200, 20, 20)\">Doombringer</font> will perform a set of hammer slams, being in the radius of a slam will ragdoll you away with damage scaling from " .. math.round(v16_Damage) .. " to " .. v1.CraterDamage * 2 .. ".\n"

v1.Information = {
	{
		["Separator"] = "GENERAL INFO"
	},
	{
		["Header"] = "DOOMBRINGER",
		["Text"] = "People say Doombringer used to be a good person. He was a super moderator who kept order and stopped chaos. But over time, the power changed him. Now he thinks he is the only one who can decide what is right and wrong. He wears a metal bucket helment almost shaped like an angry face, with horns on the sides and chains around his armor. One of his eyes glows, and he carries a huge red ban hammer covered in spikes. He longer believes that the Roblox admins are doing good, so he decided to bring the justice into his own hands.\n"
	},
	v11_Stats,
	{
		["Separator"] = "ABILITIES"
	},
	v12_Swing,
	v13_Banwave,
	v14_Banstreak,
	{
		["Image"] = "rbxassetid://126957130715030",
		["Header"] = "SCAN",
		["Text"] = ("Cooldown: %*s\n"):format(v1.ScanCooldown) .. "<font color=\"rgb(200, 20,20)\">Doombringer</font> se detiene y escanea el área.\n\nRevela el aura de todos los Supervivientes durante 5 segundos."
	}
}

return v1