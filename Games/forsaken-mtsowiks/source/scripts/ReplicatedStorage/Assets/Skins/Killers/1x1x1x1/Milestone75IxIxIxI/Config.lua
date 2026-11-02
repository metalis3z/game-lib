-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["DisplayName"] = "Milestone III",
	["Description"] = "I\'m more than you ever could be. More than a creation of your hatred.",
	["RenderImage"] = "rbxassetid://114419566356757",
	["Price"] = -7,
	["Exclusive"] = true,
	["HighlightDisabled"] = true,
	["SwordsTemplate"] = script.Swords,
	["ZombieTemplate"] = script.Zombie
}
local v2 = {}
local v3 = {
	[60] = {
		["ID"] = "rbxassetid://90058215813927",
		["BPM"] = 81
	},
	[40] = {
		["ID"] = "rbxassetid://118591422375012",
		["BPM"] = 81
	},
	[20] = {
		["ID"] = "rbxassetid://108462672716852",
		["BPM"] = 81
	},
	[6] = {
		["ID"] = "rbxassetid://83084480770095",
		["BPM"] = 81,
		["Chase"] = true
	}
}
v2.TerrorRadiusThemes = v3
v2.Execution = "rbxassetid://70963268844961"
v2.ExecutionShedletsky = "rbxassetid://72131853433943"
v1.Sounds = v2
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
	["UnstableEye"] = "rbxassetid://104663408023476",
	["RejuvenateTheRotten"] = "rbxassetid://103615571867923",
	["MassInfection"] = "rbxassetid://137152100842145"
}
v1.Animations = v4
return v1