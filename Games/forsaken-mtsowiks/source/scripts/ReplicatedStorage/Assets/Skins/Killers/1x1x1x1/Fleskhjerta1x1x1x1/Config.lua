-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["DisplayName"] = "Fleskhjerta",
	["Description"] = "\"I like this place, Seriously =)\"",
	["RenderImage"] = "rbxassetid://112714984590846",
	["Price"] = 1000,
	["IntroLighting"] = script.IntroLighting,
	["OutroLighting"] = script.OutroLighting,
	["SwordsTemplate"] = script.Swords,
	["ZombieTemplate"] = script.Zombie,
	["ShockwaveTemplate"] = script.Shockwave,
	["OutroVFXFolder"] = script.OutroVFX,
	["HighlightProperties"] = {
		["FillColor"] = Color3.fromRGB(74, 74, 74),
		["OutlineColor"] = Color3.new(),
		["FillTransparency"] = 15,
		["OutlineTransparency"] = 0.95
	}
}
local v2 = {}
local v3 = {
	[60] = {
		["ID"] = "rbxassetid://79989973483220",
		["BPM"] = 81
	},
	[40] = {
		["ID"] = "rbxassetid://117824203073270",
		["BPM"] = 81
	},
	[20] = {
		["ID"] = "rbxassetid://110504020396112",
		["BPM"] = 81
	},
	[6] = {
		["ID"] = "rbxassetid://84501396823054",
		["BPM"] = 81,
		["Chase"] = true
	}
}
v2.TerrorRadiusThemes = v3
v2.EntanglementActivate = "rbxassetid://71268794382131"
v2.UnstableEyeActivate = "rbxassetid://111650974960357"
v2.UnstableEyeMode = "rbxassetid://134037097890097"
v2.RejuvenateTheRottenActivate = "rbxassetid://134770542596997"
v2.MassInfectionActivate = "rbxassetid://98004754767597"
v2.Chains = "rbxassetid://73504812754586"
v2.Execution = "rbxassetid://133034027945572"
v2.Swing = "rbxassetid://85853080745515"
v2.Hit = "rbxassetid://72380247081945"
v2.Introduction = "rbxassetid://78268505965525"
v1.Sounds = v2
local v4 = {
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
v1.Animations = v4
return v1