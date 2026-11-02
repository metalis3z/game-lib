--██   ██  █████   ██████ ██  ██  ███████ ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██   ██
--███████ ███████ ██      ████    █████   ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██  ██ 
--██   ██ ██   ██  ██████ ██  ██  ███████ ██   ██
--
--██████  ███████  ██████  █████  ██   ██ ██████  ███ ██      ███████ ██████ 
--██   ██ ██      ██      ██   ██ ███ ███ ██   ██ ██  ██      ██      ██   ██
--██   ██ █████   ██      ██   ██ ██ █ ██ ██████  ██  ██      █████   ██████ 
--██   ██ ██      ██      ██   ██ ██   ██ ██      ██  ██      ██      ██  ██ 
--██████  ███████  ██████  █████  ██   ██ ██      ███ ███████ ███████ ██   ██
--[[
Hacker Decompiler 
Hacker Uncopylocked Discord Link : https://discord.gg/T7BXynvdMb
Owner of Hacker Decompiler: HackerKing
Owner of Hacker Uncopylocked: HackerKing
--]]


-- Bytecode (Base64):
-- CQMlCUFwcGx5U2tpbglMdW5hIE1vdGgETmFtZQVGbHl0ZQlUb3dlck5hbWUEQ29zdAZFYXN0ZXILSG9saWRheVNraW4HcmVxdWlyZQRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UKU2hhcmVkRGF0YQxSZWxlYXNlVGltZXMNRWFzdGVyMjAyNl9XMQdVbmxvY2tzG3JieGFzc2V0aWQ6Ly85ODc2ODY5ODQyMzI0OQNSdW4ccmJ4YXNzZXRpZDovLzEzMjEyMTIwODgwOTM4NARXYWxrG3JieGFzc2V0aWQ6Ly83MTkwNzY2OTU3NjQxMQRJZGxlG3JieGFzc2V0aWQ6Ly83MzAzNzc4MTk2NTMxNgVRdWlyaxtyYnhhc3NldGlkOi8vODk0MzU0Mzc1MTU3ODQGRGVjb2RlG3JieGFzc2V0aWQ6Ly84ODA5MTkzMTg4MTk2MAdBYmlsaXR5E092ZXJ3cml0ZUFuaW1hdGlvbnMccmJ4YXNzZXRpZDovLzEzNDQ5MTQ3NDg4MjE0NwZOb3JtYWwccmJ4YXNzZXRpZDovLzEwNDE0MTg2NDIxMjUyNAVCbGluaxtyYnhhc3NldGlkOi8vOTM4Nzc2OTg3MjA4MTgESHVydAxGYWNlVGV4dHVyZXMOVVNFX1NLSU5fTU9ERUwAAgEBAAAABgMAAAUBBwGCAAEAAAAeAQEYACAAAAAABQAAAQIATaMAAAD/AAUAAAAAAG8BAAAwAQC6AQAAAG8BAgAwAQCHAwAAAIwBWAIwAQAjBAAAAKkBAQAwAQARBQAAAKkBAQAwAQC8BgAAAKQBCAAAAHBApAIKAAAAkEBvBAsAvAICFgwAAACfAgMCTQICZA0AAABNAgIKDgAAAJ8BAgJNAQGnDwAAADABAFEQAAAA/wEEAAAAAABvAhEAMAIBFhIAAABvAhMAMAIBnxQAAABvAhUAMAIBkhYAAABvAhcAMAIBeBgAAABvAhkAMAIB7hoAAABvAhsAMAIB9BwAAAAwAQDpHQAAAP8BAwAAAAAAbwIeADACARAfAAAAbwIgADACAZkhAAAAbwIiADACAcUjAAAAMAEAISQAAACpAQEAMAEAwiUAAADAASYAMAEA6ScAAACCAAIAKAMCAwMDBAMFAwYDBwMIAwkEAABwQAMKBAAAkEADCwMMAw0DDgMPAxADEQMSAxMDFAMVAxYDFwMYAxkDGgMbAxwDHQMeAx8DIAMhAyIDIwMkAyUGAAMBAQABAAEYAAAAAgAAAQAAAQAAAwAAAQAAAgAAAAAAAAAAAAAAAAAAAAACAAEAAAEAAAEAAAEAAAEAAAEAAPoACQABAAABAAABAAD9AAYAAAIAAAQBAAAAAAHBe6srsMzDxvl7/fcoU5EIsWO8X/O/wSo=

-- https://lua.expert/
return {
	Name = "Luna Moth",
	TowerName = "Flyte",
	Cost = 600,
	Easter = true,
	HolidaySkin = true,
	Unlocks = require(game:GetService("ReplicatedStorage").SharedData.ReleaseTimes).Easter2026_W1,
	OverwriteAnimations = {
		Run = "rbxassetid://98768698423249",
		Walk = "rbxassetid://132121208809384",
		Idle = "rbxassetid://71907669576411",
		Quirk = "rbxassetid://73037781965316",
		Decode = "rbxassetid://89435437515784",
		Ability = "rbxassetid://88091931881960"
	},
	FaceTextures = {
		Normal = "rbxassetid://134491474882147",
		Blink = "rbxassetid://104141864212524",
		Hurt = "rbxassetid://93877698720818"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 30 ]] end
}