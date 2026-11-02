local v1 = {
	["DisplayName"] = "Sonic.EXE",
	["Quote"] = "I AM GOD!!",
	["Credits"] = "Made By: sobbe & BruhMoment",
	["RenderImage"] = "rbxassetid://126745088439226",
	["Price"] = 3600,
	["Exclusive"] = false,
	["Health"] = 900,
	["Speed"] = 6.5,
	["HipHeight"] = 2,
	["SprintSpeed"] = 30,
	["StaminaLoss"] = 10,
	["StaminaGain"] = 20,
	["MaxStamina"] = 110,
	["AttackDamage"] = 17.5,
	["GodspeedSpeedMultiplier"] = 5,
	["GodspeedTimeout"] = 16
}
local v2 = {
	["Idle"] = "rbxassetid://80144667684252",
	["Walk"] = "rbxassetid://115090096851320",
	["Run"] = "rbxassetid://113910425897405",
	["Introduction"] = {
		["KillerRig"] = "rbxassetid://119491637304018",
		["CameraRig"] = "rbxassetid://93943993599704"
	},
	["Execution"] = {
		["KillerRig"] = "rbxassetid://118183116133933",
		["PlayerRig"] = "rbxassetid://119584988860385",
		["PlayerCFrameOffset"] = CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, 2.5)
	},
	["Attack"] = "rbxassetid://118951485876413",
	["Fly"] = "rbxassetid://96165447201453",
	["FoundYou"] = "rbxassetid://93367888848811",
	["Hallucinations"] = {
		"rbxassetid://122294373562500",
		"rbxassetid://105409135132748",
		"rbxassetid://113834973264426",
		"rbxassetid://100346863574206"
	}
}
v1.Animations = v2
local v3 = {
	["Footsteps"] = { "rbxassetid://74143861617780", "rbxassetid://108704374609564" }
}
local v4 = {
	[60] = {
		["ID"] = "rbxassetid://120294964296004",
		["BPM"] = 120
	},
	[45] = {
		["ID"] = "rbxassetid://110922898152026",
		["BPM"] = 120
	},
	[30] = {
		["ID"] = "rbxassetid://76502709323654",
		["BPM"] = 120
	},
	[6] = {
		["ID"] = "rbxassetid://80353033277436",
		["BPM"] = 120,
		["Chase"] = true
	}
}
v3.TerrorRadiusThemes = v4
v3.Introduction = "rbxassetid://91191831997334"
v3.Execution = "rbxassetid://102946562824825"
v3.GodspeedLoop = "rbxassetid://110113824866574"
v3.FoundYou = "rbxassetid://82532443067807"
v3.Hit = "rbxassetid://115537810094042"
v3.Swing = "rbxassetid://136695489790441"
v1.Sounds = v3
return v1
