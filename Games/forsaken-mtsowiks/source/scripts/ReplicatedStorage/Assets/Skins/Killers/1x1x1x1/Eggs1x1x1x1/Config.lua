-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["DisplayName"] = "Eggs",
	["Description"] = "collect my eggs",
	["RenderImage"] = "rbxassetid://115153616972379",
	["Price"] = 1366,
	["Exclusive"] = true,
	["ZombieTemplate"] = script.Zombie,
	["HighlightProperties"] = {
		["FillColor"] = Color3.fromRGB(100, 100, 100),
		["OutlineColor"] = Color3.fromRGB(0, 0, 0),
		["FillTransparency"] = 15,
		["OutlineTransparency"] = 0.95
	},
	["ZombieSounds"] = {
		"rbxassetid://129126012209614",
		"rbxassetid://131564418319269",
		"rbxassetid://123303723680076",
		"rbxassetid://136268853453003",
		"rbxassetid://123989190308399"
	},
	["Voicelines"] = {
		["Entanglement"] = { "rbxassetid://110021450108570", "rbxassetid://83373517188611" },
		["UnstableEye"] = { "rbxassetid://74511557077917" },
		["RejuvenateTheRotten"] = { "rbxassetid://106706213242278", "rbxassetid://90250047434159" },
		["MassInfection"] = {
			"rbxassetid://107007647861282",
			"rbxassetid://86162805796041",
			"rbxassetid://99883723563514",
			"rbxassetid://99247817058892",
			"rbxassetid://136250962199212"
		},
		["Idle"] = {
			"rbxassetid://115756037514533",
			"rbxassetid://115579581637886",
			"rbxassetid://126925123053689",
			"rbxassetid://122885002050979"
		},
		["Kill"] = {
			"rbxassetid://87408171624716",
			"rbxassetid://121799875156608",
			"rbxassetid://105934993120754",
			"rbxassetid://95043262822431",
			"rbxassetid://80678816804083",
			"rbxassetid://78580282855299"
		},
		["LastSurvivor"] = { "rbxassetid://123026860534189", "rbxassetid://116417763473919" },
		["Stunned"] = { "rbxassetid://119747284475881", "rbxassetid://112758143619800", "rbxassetid://116436267396764" }
	}
}
local v2 = {}
local v3 = {
	[60] = {
		["ID"] = "rbxassetid://115008988102351",
		["BPM"] = 121
	},
	[40] = {
		["ID"] = "rbxassetid://134100427434871",
		["BPM"] = 121
	},
	[20] = {
		["ID"] = "rbxassetid://126065940852698",
		["BPM"] = 121
	},
	[6] = {
		["ID"] = "rbxassetid://133182164986882",
		["BPM"] = 121,
		["Chase"] = true
	}
}
v2.TerrorRadiusThemes = v3
v1.Sounds = v2
return v1