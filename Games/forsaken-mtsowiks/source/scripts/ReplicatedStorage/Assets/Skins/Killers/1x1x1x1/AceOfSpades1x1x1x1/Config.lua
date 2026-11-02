-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["DisplayName"] = "xX4ceOfSpadesXx",
	["Description"] = "WE DONT HAVE TO REACH YOU",
	["RenderImage"] = "rbxassetid://131854991707079",
	["Price"] = 1000,
	["Exclusive"] = false,
	["CollabInfo"] = "RecallAHollowHeart",
	["ShockwaveTemplate"] = script.Shockwave,
	["IntroLighting"] = script.Lighting,
	["ZombieTemplate"] = script.Zombie,
	["SpecialZombieTemplate"] = script.SpecialZombie,
	["PopupsFolder"] = script.Popups,
	["SwordsTemplate"] = script.Swords,
	["OutroLighting"] = script.OutroLighting,
	["OutroVFXFolder"] = script.OutroVFX,
	["HighlightProperties"] = {
		["FillColor"] = Color3.fromRGB(74, 74, 74),
		["OutlineColor"] = Color3.fromRGB(255, 255, 255),
		["FillTransparency"] = 2,
		["OutlineTransparency"] = 0.9
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
local v3 = {}
local v4 = {
	[60] = {
		["ID"] = "rbxassetid://129172325753018",
		["BPM"] = 171
	},
	[40] = {
		["ID"] = "rbxassetid://119758368982849",
		["BPM"] = 171
	},
	[20] = {
		["ID"] = "rbxassetid://71756336541280",
		["BPM"] = 171
	},
	[6] = {
		["ID"] = "rbxassetid://72331023089960",
		["BPM"] = 171,
		["Chase"] = true
	}
}
v3.TerrorRadiusThemes = v4
v3.EntanglementActivate = "rbxassetid://100150551345482"
v3.EntanglementProjectile = "rbxassetid://79665854201966"
v3.UnstableEyeActivate = "rbxassetid://98178049305058"
v3.UnstableEyeMode = "rbxassetid://134037097890097"
v3.RejuvenateTheRottenActivate = "rbxassetid://108829275072240"
v3.RejuvenateTheRottenRevive = "rbxassetid://102233628962479"
v3.MassInfectionActivate = "rbxassetid://111198701120158"
v3.MassInfectionProjectile = "rbxassetid://136644374644573"
v3.Chains = "rbxassetid://97061990471922"
v3.Stunned = {
	["Start"] = "rbxassetid://135955028855726",
	["End"] = "rbxassetid://102731091551965"
}
v3.Execution = "rbxassetid://114489075814479"
v3.ExecutionShedletsky = "rbxassetid://109911656332309"
v3.Swing = "rbxassetid://115026634746636"
v3.Hit = "rbxassetid://74183834601348"
v3.Introduction = "rbxassetid://102726054678561"
v3.VictoryTheme = "rbxassetid://117583812005990"
v1.Sounds = v3
return v1