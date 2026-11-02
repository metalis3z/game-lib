-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["DisplayName"] = "Everfrost",
	["Description"] = "A figure stands alone, deep in the icy caves. They have been unthawed.",
	["RenderImage"] = "rbxassetid://135539128161746",
	["Price"] = 1000,
	["HighlightProperties"] = {
		["FillColor"] = Color3.fromRGB(255, 88, 58),
		["OutlineColor"] = Color3.fromRGB(255, 255, 255),
		["FillTransparency"] = 5,
		["OutlineTransparency"] = 0.99
	},
	["ShockwaveTemplate"] = script.shockwave,
	["IntroLighting"] = script.lighting,
	["ZombieTemplate"] = script.Zombie,
	["SwordsTemplate"] = script.Swords,
	["PopupsFolder"] = script.Popups
}
local v2 = {
	["Ambience"] = "rbxassetid://97284862014669",
	["EntanglementActivate"] = {
		["SoundId"] = "rbxassetid://123815798662353",
		["Volume"] = 0.25
	},
	["UnstableEyeActivate"] = {
		["SoundId"] = "rbxassetid://138156817866645",
		["Volume"] = 0.25
	},
	["RejuvenateTheRottenActivate"] = {
		["SoundId"] = "rbxassetid://97821062132060",
		["Volume"] = 0.25
	},
	["RejuvenateTheRottenMinionHit"] = "rbxassetid://107236274943855",
	["MassInfectionActivate"] = {
		["SoundId"] = "rbxassetid://139289790129544",
		["Volume"] = 0.25
	},
	["Swing"] = "rbxassetid://119089145505438",
	["Hit"] = "rbxassetid://107236274943855",
	["Introduction"] = "rbxassetid://103919058809165",
	["VictoryTheme"] = {
		["SoundId"] = "rbxassetid://118345745826963",
		["Volume"] = 0.35
	}
}
v1.Sounds = v2
return v1