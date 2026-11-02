-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {
	["DisplayName"] = "SWAT Officer",
	["Quote"] = "\"Target spotted!\"",
	["Credits"] = "",
	["Class"] = "Sentinel",
	["RenderImage"] = "rbxassetid://960406711",
	["Price"] = 999999,
	["Exclusive"] = true,
	["Speed"] = 12,
	["FlashbangCooldown"] = 60,
	["FlashbangThrowForce"] = 60,
	["FlashbangFuseDuration"] = 3,
	["FlashbangRadius"] = 20,
	["FlashbangBlindnessDuration"] = 5,
	["FlashbangSmokeVFX"] = script.Smoke
}
local v2 = {}
local v3 = {
	["SwatIdle"] = {
		["DisplayName"] = "Idle",
		["Description"] = "Let your higher ups know that you\'re okay",
		["AssetIDs"] = { "rbxassetid://6889206060", "rbxassetid://6889205069" }
	},
	["EnemyEngaged"] = {
		["DisplayName"] = "Engage",
		["Description"] = "All units, FIRE!",
		["AssetIDs"] = { "rbxassetid://6933452457", "rbxassetid://6933455471" }
	},
	["TargetSpotted"] = {
		["DisplayName"] = "Target Spotted",
		["Description"] = "All units, lock in!",
		["AssetIDs"] = { "rbxassetid://6933447501", "rbxassetid://6933443275", "rbxassetid://6933450252" }
	}
}
v2.Voicelines = v3
v1.Emotes = v2
v1.Expressions = {
	["Happy"] = "rbxassetid://129518825455437",
	["Default"] = "rbxassetid://72727389118160",
	["Hurt"] = "rbxassetid://88158089214276",
	["Injured"] = "rbxassetid://137934480549683",
	["Dead"] = "rbxassetid://99128042122280",
	["Drinking"] = "rbxassetid://122817821371080"
}
v1.Animations = {
	["ThrowFlashbang"] = "rbxassetid://82716153510935"
}
v1.Sounds = {
	["FlashbangThrown"] = "rbxassetid://2552682980"
}
return v1
