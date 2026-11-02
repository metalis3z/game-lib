-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {
	["DisplayName"] = "Sonic.EXE",
	Information = {},
	["Quote"] = "I AM GOD!!",
	["Credits"] = "Made By: sobbe & BruhMoment",
	["RenderImage"] = "rbxassetid://126745088439226",
	["Price"] = 400,
	--["Exclusive"] = true,
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
	["Idle"] = "rbxassetid://95488364109031",
	["Walk"] = "rbxassetid://91586477033004",
	["Run"] = "rbxassetid://71114119891667",
	["Introduction"] = {
		["KillerRig"] = "rbxassetid://75017614009037",
		["CameraRig"] = "rbxassetid://74873592181476"
	},
	["Execution"] = {
		["KillerRig"] = "rbxassetid://104399540606969",
		["PlayerRig"] = "rbxassetid://78736088973845",
		["PlayerCFrameOffset"] = CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, 2.5)
	},
	["Attack"] = "rbxassetid://81915999559921",
	["Fly"] = "rbxassetid://87479665255848",
	["FoundYou"] = "rbxassetid://96669956532069",
	["Hallucinations"] = {
		"rbxassetid://117415129704981",
		"rbxassetid://81744982773547",
		"rbxassetid://106300151068698",
		"rbxassetid://127162515742667"
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
