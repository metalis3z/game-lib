-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["DisplayName"] = "Timeless",
	["Description"] = "Commonly mistaken as \'Spirit\'. He\'s not a fan.",
	["RenderImage"] = "rbxassetid://133348211508023",
	["Price"] = 1750,
	["ZombieTemplate"] = script.Zombie,
	["HighlightDisabled"] = true
}
local v2 = {
	["Idle"] = "rbxassetid://84576483754206",
	["Walk"] = "rbxassetid://78699039349450",
	["Run"] = "rbxassetid://80760033755588",
	["Introduction"] = {
		["KillerRig"] = "rbxassetid://108772454550279",
		["CameraRig"] = "rbxassetid://92426226316147"
	},
	["Execution"] = {
		["KillerRig"] = "rbxassetid://134292666158183",
		["PlayerRig"] = "rbxassetid://93666484604456"
	},
	["Slash"] = "rbxassetid://85395695347005",
	["Entanglement"] = "rbxassetid://113745645636988",
	["UnstableEye"] = "rbxassetid://138017110758980",
	["RejuvenateTheRotten"] = "rbxassetid://137895497709601",
	["MassInfection"] = "rbxassetid://84312301245713",
	["Stunned"] = {
		["Start"] = "rbxassetid://91666868901845",
		["Loop"] = "rbxassetid://109962431018151",
		["End"] = "rbxassetid://91325129676721"
	}
}
v1.Animations = v2
local v3 = {}
local v4 = {
	[60] = {
		["ID"] = "rbxassetid://85224548359205",
		["BPM"] = 143
	},
	[40] = {
		["ID"] = "rbxassetid://121183357781246",
		["BPM"] = 143
	},
	[20] = {
		["ID"] = "rbxassetid://122469557104509",
		["BPM"] = 143
	},
	[6] = {
		["ID"] = "rbxassetid://81124588818507",
		["BPM"] = 143,
		["Chase"] = true
	}
}
v3.TerrorRadiusThemes = v4
v3.EntanglementActivate = "rbxassetid://116792970438827"
v3.UnstableEyeActivate = "rbxassetid://87284124610600"
v3.UnstableEyeMode = "rbxassetid://134037097890097"
v3.RejuvenateTheRottenActivate = "rbxassetid://134770542596997"
v3.MassInfectionActivate = "rbxassetid://98004754767597"
v3.Chains = "rbxassetid://73504812754586"
v3.Execution = "rbxassetid://81088644266477"
v3.ExecutionShedletsky = "rbxassetid://136239410827349"
v3.Swing = "rbxassetid://85853080745515"
v3.Hit = "rbxassetid://72380247081945"
v3.Introduction = "rbxassetid://78268505965525"
v3.VictoryTheme = "rbxassetid://89043663897133"
v1.Sounds = v3
return v1