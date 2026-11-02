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
-- CQMlCUFwcGx5U2tpbhFXaWxkYmVycnkgRGVsaWdodAROYW1lBUNvY29hCVRvd2VyTmFtZQRDb3N0BkVhc3RlcgtIb2xpZGF5U2tpbgdyZXF1aXJlBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQpTaGFyZWREYXRhDFJlbGVhc2VUaW1lcw1FYXN0ZXIyMDI2X1cxB1VubG9ja3MccmJ4YXNzZXRpZDovLzEwNjI5NjAxODIxNjA1NANSdW4ccmJ4YXNzZXRpZDovLzEyMjc4NjEzMTkxOTYyMwRXYWxrHHJieGFzc2V0aWQ6Ly8xMjQ5NjY2NDU5MDUzOTIESWRsZRxyYnhhc3NldGlkOi8vMTM1MjA2OTEzMTAwMjI1BVF1aXJrG3JieGFzc2V0aWQ6Ly83ODc2NjM5Nzc4NzM4MQZEZWNvZGUccmJ4YXNzZXRpZDovLzEzOTE3ODIyODgzNDc4NwdBYmlsaXR5E092ZXJ3cml0ZUFuaW1hdGlvbnMbcmJ4YXNzZXRpZDovLzg0MDYzMzgxNTE3NjU1Bk5vcm1hbBxyYnhhc3NldGlkOi8vMTAzOTkxMzIwNTgzNTkxBUJsaW5rHHJieGFzc2V0aWQ6Ly8xMTU0MTQxNzMwMzIyMDgESHVydAxGYWNlVGV4dHVyZXMOVVNFX1NLSU5fTU9ERUwAAgEBAAAABgMAAAUBBwGCAAEAAAAdAQEYAB8AAAAABQAAAQIATaMAAAD/AAUAAAAAAG8BAAAwAQC6AQAAAG8BAgAwAQCHAwAAAIwBWAIwAQAjBAAAAKkBAQAwAQARBQAAAKkBAQAwAQC8BgAAAKQBCAAAAHBApAIKAAAAkEBvBAsAvAICFgwAAACfAgMCTQICZA0AAABNAgIKDgAAAJ8BAgJNAQGnDwAAADABAFEQAAAA/wEEAAAAAABvAhEAMAIBFhIAAABvAhMAMAIBnxQAAABvAhUAMAIBkhYAAABvAhcAMAIBeBgAAABvAhkAMAIB7hoAAABvAhsAMAIB9BwAAAAwAQDpHQAAAP8BAwAAAAAAbwIeADACARAfAAAAbwIgADACAZkhAAAAbwIiADACAcUjAAAAMAEAISQAAACpAQEAMAEAwiUAAADAASYAMAEA6ScAAACCAAIAKAMCAwMDBAMFAwYDBwMIAwkEAABwQAMKBAAAkEADCwMMAw0DDgMPAxADEQMSAxMDFAMVAxYDFwMYAxkDGgMbAxwDHQMeAx8DIAMhAyIDIwMkAyUGAAMBAQABAAEYAAAAAgAAAQAAAQAAAwAAAQAAAgAAAAAAAAAAAAAAAAAAAAACAAEAAAEAAAEAAAEAAAEAAAEAAPoACQABAAABAAABAAD9AAUAAAIAAAQBAAAAAAGM+1AiccRsvuySH63L/C0H/ONHVr4/OiM=

-- https://lua.expert/
return {
	Name = "Wildberry Delight",
	TowerName = "Cocoa",
	Cost = 600,
	Easter = true,
	HolidaySkin = true,
	Unlocks = require(game:GetService("ReplicatedStorage").SharedData.ReleaseTimes).Easter2026_W1,
	OverwriteAnimations = {
		Run = "rbxassetid://106296018216054",
		Walk = "rbxassetid://122786131919623",
		Idle = "rbxassetid://124966645905392",
		Quirk = "rbxassetid://135206913100225",
		Decode = "rbxassetid://78766397787381",
		Ability = "rbxassetid://139178228834787"
	},
	FaceTextures = {
		Normal = "rbxassetid://84063381517655",
		Blink = "rbxassetid://103991320583591",
		Hurt = "rbxassetid://115414173032208"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 29 ]] end
}