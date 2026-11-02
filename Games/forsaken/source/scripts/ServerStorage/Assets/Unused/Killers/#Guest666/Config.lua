-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {
	["DisplayName"] = "Guest 666",
	["Quote"] = "A shell of their former self.",
	["Credits"] = "By: Foolskarp, and Sobbi",
	["RenderImage"] = "rbxassetid://71881824751999",
	["Price"] = 666,
	--["Exclusive"] = true,
	["Health"] = 2500,
	["Speed"] = 8,
	["SprintSpeed"] = 26.5,
	["StaminaLoss"] = 8,
	["StaminaGain"] = 21,
	["MaxStamina"] = 110,
	["SlashDamage"] = 20,
	["SlashHardDamage"] = 10,
	["SlashCooldown"] = 2,
	["BloodOrbGive"] = 10,
	["BloodOrbCollectRange"] = 7,
	["BloodOrbTemplate"] = script.BloodOrb,
	["Relations"] = { "Noob" },
	["LastManStandingEmotionalData"] = {
		["ThemeID"] = "rbxassetid://111873898266298",
		["RoundTime"] = 96
	},
	HipHeight = 1.6,
	Information = {}
}
local v2 = {
	["Idle"] = "rbxassetid://130031848734352",
	["Walk"] = "rbxassetid://118454713616913",
	["Run"] = "rbxassetid://73684068409871",
	["SlashNormal"] = "rbxassetid://79284034431149",
	["Stunned"] = {
		["Start"] = "rbxassetid://135786178831305",
		["Loop"] = "rbxassetid://103334793791001",
		["End"] = "rbxassetid://91557121111937"
	}
}
v1.Animations = v2
local v3 = {
	["Footsteps"] = { "rbxassetid://99809965759734", "rbxassetid://79222929114377" },
	["LastSurvivorStanding"] = "rbxassetid://111873898266298"
}
local v4 = {
	[90] = {
		["ID"] = "rbxassetid://96126792740560",
		["BPM"] = 81
	},
	[60] = {
		["ID"] = "rbxassetid://137834745932444",
		["BPM"] = 81
	},
	[30] = {
		["ID"] = "rbxassetid://134425253761951",
		["BPM"] = 81
	},
	[9] = {
		["ID"] = "rbxassetid://102923570905370",
		["BPM"] = 81,
		["Chase"] = true
	}
}
v3.TerrorRadiusThemes = v4
v3.Swing = "rbxassetid://140242176732868"
v3.Hit = "rbxassetid://90819435118493"
v1.Sounds = v3
return v1
