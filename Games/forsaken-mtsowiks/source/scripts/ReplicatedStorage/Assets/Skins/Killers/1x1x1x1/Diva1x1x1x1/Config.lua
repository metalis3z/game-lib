-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["DisplayName"] = "Diva",
	["Description"] = "All eyes on her...",
	["RenderImage"] = "rbxassetid://134481225474280",
	["Price"] = 3500,
	["Exclusive"] = false,
	["HighlightDisabled"] = false,
	["ZombieTemplate"] = script.Zombie,
	["ShockwaveTemplate"] = script.shockwave,
	["SwordsTemplate"] = script.Swords,
	["IntroLighting"] = script.lighting,
	["Relations"] = { "GhoulTwoTime", "Shedletsky" }
}
local v2 = {}
local v3 = {
	["ThemeID"] = "rbxassetid://130101085745481",
	["ThemeProperties"] = {
		["Volume"] = 1.25
	},
	["RoundTime"] = 74
}
v2.GhoulTwoTime = v3
local v4 = {
	["ThemeID"] = "rbxassetid://115884097233860",
	["ThemeProperties"] = {
		["Volume"] = 0.5
	},
	["RoundTime"] = 91
}
v2.Shedletsky = v4
v1.LastManStandingEmotionalData = v2
local v5 = {}
local v6 = {
	[60] = {
		["ID"] = "rbxassetid://76232146872176",
		["BPM"] = 101.333
	},
	[40] = {
		["ID"] = "rbxassetid://88603581115113",
		["BPM"] = 101.333
	},
	[20] = {
		["ID"] = "rbxassetid://99783371279599",
		["BPM"] = 101.333
	},
	[6] = {
		["ID"] = "rbxassetid://81505335942341",
		["BPM"] = 101.333,
		["Chase"] = true
	}
}
v5.TerrorRadiusThemes = v6
v1.Sounds = v5
return v1