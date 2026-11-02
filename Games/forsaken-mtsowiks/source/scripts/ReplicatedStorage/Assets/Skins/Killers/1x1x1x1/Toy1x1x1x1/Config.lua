-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["DisplayName"] = "Toy",
	["Description"] = "Pure plastic.",
	["RenderImage"] = "rbxassetid://95290181860002",
	["Price"] = 700,
	["HighlightDisabled"] = true,
	["SwordsTemplate"] = script.Swords,
	["ZombieTemplate"] = script.Zombie,
	["HighlightProperties"] = {
		["FillColor"] = Color3.fromRGB(74, 74, 74),
		["OutlineColor"] = Color3.new(),
		["FillTransparency"] = 3,
		["OutlineTransparency"] = 0.95
	}
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
return v1