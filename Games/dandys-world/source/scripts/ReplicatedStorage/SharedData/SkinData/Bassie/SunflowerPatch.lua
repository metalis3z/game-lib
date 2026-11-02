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
-- CQMnCUFwcGx5U2tpbg9TdW5mbG93ZXIgUGF0Y2gETmFtZQZCYXNzaWUJVG93ZXJOYW1lBENvc3QGRWFzdGVyC0hvbGlkYXlTa2luB3JlcXVpcmUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlClNoYXJlZERhdGEMUmVsZWFzZVRpbWVzDUVhc3RlcjIwMjZfVzEHVW5sb2NrcxtyYnhhc3NldGlkOi8vNzEzOTcxODYxNDkzMTQDUnVuHHJieGFzc2V0aWQ6Ly8xMTYxNTQ5NTk0MTgwNDUEV2FsaxtyYnhhc3NldGlkOi8vOTE2MDc0MjgyNjc4MTkESWRsZRtyYnhhc3NldGlkOi8vOTgyMjIyNDA2MzU1NDQFUXVpcmsccmJ4YXNzZXRpZDovLzEyMTUyNDM5ODQxOTE2NQZEZWNvZGUccmJ4YXNzZXRpZDovLzEwOTg5Nzk5MTYxMTQ2NAhTaXRfSWRsZRxyYnhhc3NldGlkOi8vMTIzNjA3NzI0NTUxNzMzCFNpdF9XYXZlE092ZXJ3cml0ZUFuaW1hdGlvbnMccmJ4YXNzZXRpZDovLzEyMDY1MDMxMjA3NDQyNAZOb3JtYWwccmJ4YXNzZXRpZDovLzEyNzYzMjIwNzI4OTE4NQVCbGluaxtyYnhhc3NldGlkOi8vNzc3MDc0MzcxNDIyNzQESHVydAxGYWNlVGV4dHVyZXMOVVNFX1NLSU5fTU9ERUwAAgEBAAAABgMAAAUBBwGCAAEAAAAiAQEYACQAAAAABQAAAQIAUKMAAAD/AAUAAAAAAG8BAAAwAQC6AQAAAG8BAgAwAQCHAwAAAIwBWAIwAQAjBAAAAKkBAQAwAQARBQAAAKkBAQAwAQC8BgAAAKQBCAAAAHBApAIKAAAAkEBvBAsAvAICFgwAAACfAgMCTQICZA0AAABNAgIKDgAAAJ8BAgJNAQGnDwAAADABAFEQAAAA/wEEAAAAAABvAhEAMAIBFhIAAABvAhMAMAIBnxQAAABvAhUAMAIBkhYAAABvAhcAMAIBeBgAAABvAhkAMAIB7hoAAABvAhsAMAIBYBwAAABvAh0AMAIBxx4AAAAwAQDpHwAAAP8BAwAAAAAAbwIgADACARAhAAAAbwIiADACAZkjAAAAbwIkADACAcUlAAAAMAEAISYAAACpAQEAMAEAwicAAADAASgAMAEA6SkAAACCAAIAKgMCAwMDBAMFAwYDBwMIAwkEAABwQAMKBAAAkEADCwMMAw0DDgMPAxADEQMSAxMDFAMVAxYDFwMYAxkDGgMbAxwDHQMeAx8DIAMhAyIDIwMkAyUDJgMnBgADAQEAAQABGAAAAAIAAAEAAAEAAAMAAAEAAAIAAAAAAAAAAAAAAAAAAAAABQABAAABAAABAAABAAABAAABAAABAAD5AAoAAQAAAQAAAQAA/QAGAAACAAAEAQAAAAABf6Y3uJHqFrvQ4LRnU3mdmw++IMxNYl25

-- https://lua.expert/
return {
	Name = "Sunflower Patch",
	TowerName = "Bassie",
	Cost = 600,
	Easter = true,
	HolidaySkin = true,
	Unlocks = require(game:GetService("ReplicatedStorage").SharedData.ReleaseTimes).Easter2026_W1,
	OverwriteAnimations = {
		Run = "rbxassetid://71397186149314",
		Walk = "rbxassetid://116154959418045",
		Idle = "rbxassetid://91607428267819",
		Quirk = "rbxassetid://98222240635544",
		Decode = "rbxassetid://121524398419165",
		Sit_Idle = "rbxassetid://109897991611464",
		Sit_Wave = "rbxassetid://123607724551733"
	},
	FaceTextures = {
		Normal = "rbxassetid://120650312074424",
		Blink = "rbxassetid://127632207289185",
		Hurt = "rbxassetid://77707437142274"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 34 ]] end
}