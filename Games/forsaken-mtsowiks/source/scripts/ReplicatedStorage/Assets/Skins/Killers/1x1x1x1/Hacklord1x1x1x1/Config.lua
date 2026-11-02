-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["DisplayName"] = "Hacklord",
	["Description"] = "Thus approaches the final chapter of this tale.",
	["RenderImage"] = "rbxassetid://91171756002206",
	["Price"] = 0,
	["Exclusive"] = true,
	["HighlightProperties"] = {
		["FillColor"] = Color3.fromRGB(113, 94, 255),
		["OutlineColor"] = Color3.fromRGB(2, 59, 10),
		["FillTransparency"] = 1.5,
		["OutlineTransparency"] = -10
	},
	["IntroLighting"] = script.IntroLighting,
	["ShockwaveTemplate"] = script.shockwave,
	["IntroHeadTemplate"] = script.ShedletskyHead,
	["SwordsTemplate"] = script.Swords,
	["ZombieTemplate"] = script.Zombie,
	["PopupsFolder"] = script.Popups,
	["HighlightDisabled"] = true
}
local v2 = {
	["Idle"] = "rbxassetid://134763474977177",
	["Walk"] = "rbxassetid://140209919705179",
	["Run"] = "rbxassetid://138474600326243",
	["InjuredIdle"] = "rbxassetid://134763474977177",
	["InjuredWalk"] = "rbxassetid://140209919705179",
	["InjuredRun"] = "rbxassetid://138474600326243",
	["Introduction"] = {
		["KillerRig"] = "rbxassetid://114595886036812",
		["CameraRig"] = "rbxassetid://95307907761043"
	},
	["Execution"] = {
		["KillerRig"] = "rbxassetid://114894472426139",
		["PlayerRig"] = "rbxassetid://91536671001607",
		["PlayerCFrameOffset"] = CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, 5)
	},
	["ExecutionShedletsky"] = {
		["KillerRig"] = "rbxassetid://132066098662810",
		["PlayerRig"] = "rbxassetid://116342158477201",
		["PlayerCFrameOffset"] = CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, 5)
	},
	["Slash"] = "rbxassetid://112215626560024",
	["Entanglement"] = "rbxassetid://118683032948915",
	["UnstableEye"] = "rbxassetid://116521385605390",
	["RejuvenateTheRotten"] = "rbxassetid://101193670485310",
	["MassInfection"] = "rbxassetid://70788710244264"
}
v1.Animations = v2
v1.Relations = { "HeartbrokenShedletsky" }
local v3 = {}
local v4 = {
	["ThemeID"] = "rbxassetid://134062685653533",
	["ThemeProperties"] = {
		["Volume"] = 1
	},
	["RoundTime"] = 91
}
v3.HeartbrokenShedletsky = v4
v1.LastManStandingEmotionalData = v3
local v5 = {
	["Footsteps"] = { "rbxassetid://86946421252636", "rbxassetid://109338938491835" }
}
local v6 = {
	[60] = {
		["ID"] = "rbxassetid://93048884381328",
		["BPM"] = 150
	},
	[40] = {
		["ID"] = "rbxassetid://138654094443448",
		["BPM"] = 150
	},
	[20] = {
		["ID"] = "rbxassetid://90284498070064",
		["BPM"] = 150
	},
	[6] = {
		["ID"] = "rbxassetid://98876295878451",
		["BPM"] = 150,
		["Chase"] = true
	}
}
v5.TerrorRadiusThemes = v6
v5.Execution = "rbxassetid://107844494806365"
v5.ExecutionShedletsky = "rbxassetid://133758815058484"
v5.Stunned = "rbxassetid://102398799721605"
v5.EntanglementActivate = "rbxassetid://130247421279831"
v5.UnstableEyeActivate = "rbxassetid://116607543967887"
v5.UnstableEyeMode = "rbxassetid://134037097890097"
v5.RejuvenateTheRottenActivate = "rbxassetid://96908026446030"
v5.MassInfectionActivate = "rbxassetid://79291895885110"
v5.Introduction = "rbxassetid://79630377899438"
v5.Swing = "rbxassetid://119942598489800"
v5.Hit = { "rbxassetid://105491491801026", "rbxassetid://74491072589342" }
v1.Sounds = v5
return v1