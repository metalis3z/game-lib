-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["DisplayName"] = "SPECIAL Yourself",
	["Description"] = "You but if you were messed up and twisted",
	["RenderImage"] = "rbxassetid://73866168183864",
	["Price"] = 19000,
	["Exclusive"] = true,
	["Legendary"] = true,
	["Relations"] = { "Shedletsky" }
}
local v2 = {
	["ThemeID"] = "rbxassetid://134174166564242",
	["ThemeProperties"] = {
		["Volume"] = 1.3
	},
	["RoundTime"] = 97
}
v1.LastManStandingEmotionalData = v2
local v3 = {
	["ThemeID"] = "rbxassetid://116564900353263",
	["ThemeProperties"] = {
		["Volume"] = 1
	},
	["RoundTime"] = 73
}
v1.LastManStandingData = v3
v1.ZombieTemplate = script.Zombie
v1.ZombieAnimations = {
	["Idle"] = "rbxassetid://88739021830059",
	["Walk"] = "rbxassetid://89019997988480",
	["Run"] = "rbxassetid://97417264935446",
	["Attack"] = "rbxassetid://87294932873484",
	["Summon"] = "rbxassetid://87956852045378"
}
local v4 = {
	["Idle"] = "rbxassetid://137175790357124",
	["Walk"] = "rbxassetid://99116945179921",
	["Run"] = "rbxassetid://97417264935446",
	["InjuredIdle"] = "rbxassetid://137175790357124",
	["InjuredWalk"] = "rbxassetid://99116945179921",
	["InjuredRun"] = "rbxassetid://97417264935446",
	["Execution"] = {
		["KillerRig"] = "rbxassetid://72885578036506",
		["PlayerRig"] = "rbxassetid://82292540006782",
		["ZombieRig"] = "rbxassetid://126357173433107"
	},
	["ExecutionShedletsky"] = {
		["KillerRig"] = "rbxassetid://77300869870923",
		["PlayerRig"] = "rbxassetid://93044640106022"
	},
	["Slash"] = "rbxassetid://132560656071534",
	["Entanglement"] = "rbxassetid://110670433838313",
	["UnstableEye"] = "rbxassetid://119262838395356",
	["RejuvenateTheRotten"] = "rbxassetid://103615571867923",
	["MassInfection"] = "rbxassetid://137152100842145"
}
v1.Animations = v4
local v5 = {}
local v6 = {
	[60] = {
		["ID"] = "rbxassetid://84997151279917",
		["BPM"] = 81
	},
	[40] = {
		["ID"] = "rbxassetid://96363865981263",
		["BPM"] = 81
	},
	[20] = {
		["ID"] = "rbxassetid://72678598382706",
		["BPM"] = 81
	},
	[6] = {
		["ID"] = "rbxassetid://97471175174756",
		["BPM"] = 81,
		["Chase"] = true
	}
}
v5.TerrorRadiusThemes = v6
v5.Execution = "rbxassetid://70963268844961"
v5.ExecutionShedletsky = "rbxassetid://72131853433943"
v1.Sounds = v5
return v1