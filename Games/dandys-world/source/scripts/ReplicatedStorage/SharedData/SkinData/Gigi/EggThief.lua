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
-- CQMoCUFwcGx5U2tpbglFZ2cgVGhpZWYETmFtZQRHaWdpCVRvd2VyTmFtZRJObyBkZXNjcmlwdGlvbiB5ZXQLRGVzY3JpcHRpb24HTWFzdGVyeQRDb3N0B3JlcXVpcmUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlClNoYXJlZERhdGEMUmVsZWFzZVRpbWVzDUVhc3RlcjIwMjZfVzQHVW5sb2NrcwZFYXN0ZXILSG9saWRheVNraW4bcmJ4YXNzZXRpZDovLzkyNDU1MDQxNTc2MjEwB0FiaWxpdHkbcmJ4YXNzZXRpZDovLzk4OTYzMzg3NDg4OTg1BkRlY29kZRxyYnhhc3NldGlkOi8vMTI1Njg2NjYwNTI2NjgzBElkbGUbcmJ4YXNzZXRpZDovLzk3NTM3Mzc0NDUyNTYzBVF1aXJrHHJieGFzc2V0aWQ6Ly8xMDk5NDE1OTUyMjY2NjADUnVuG3JieGFzc2V0aWQ6Ly84ODE0MDg0NDQ4MzQ1NQRXYWxrE092ZXJ3cml0ZUFuaW1hdGlvbnMccmJ4YXNzZXRpZDovLzExMjI1OTkyMTA1NzYzOQZOb3JtYWwccmJ4YXNzZXRpZDovLzEyMzU3MjU0Mzk2MTk1MAVCbGluaxtyYnhhc3NldGlkOi8vOTkyNTM0MTk3NjY0MzIESHVydAxGYWNlVGV4dHVyZXMOVVNFX1NLSU5fTU9ERUwAAgEBAAAAAAGCAAEAAAAgAQEYACQAAAAABQAAAQIAU6MAAAD/AAUAAAAAAG8BAAAwAQC6AQAAAG8BAgAwAQCHAwAAAG8BBAAwAQDiBQAAAKkBAAAwAQA8BgAAAIwBWAIwAQAjBwAAAKQBCQAAAIBApAILAAAAoEBvBAwAvAICFg0AAACfAgMCTQICZA4AAABNAgIKDwAAAJ8BAgJNAQH/EAAAADABAFERAAAAqQEBADABABESAAAAqQEBADABALwTAAAA/wEEAAAAAABvAhQAMAIB9BUAAABvAhYAMAIB7hcAAABvAhgAMAIBkhkAAABvAhoAMAIBeBsAAABvAhwAMAIBFh0AAABvAh4AMAIBnx8AAAAwAQDpIAAAAP8BAwAAAAAAbwIhADACARAiAAAAbwIjADACAZkkAAAAbwIlADACAcUmAAAAMAEAIScAAACpAQEAMAEAwigAAADAASkAMAEA6SoAAACCAAIAKwMCAwMDBAMFAwYDBwMIAwkDCgQAAIBAAwsEAACgQAMMAw0DDgMPAxADEQMSAxMDFAMVAxYDFwMYAxkDGgMbAxwDHQMeAx8DIAMhAyIDIwMkAyUDJgMnAygGAAMBAQABAAEYAAAAAgAAAQAAAQAAAQAAAgAAAQAAAAAAAAAAAAAAAAAAAAADAAABAAACAAEAAAEAAAEAAAEAAAEAAAEAAPoACQABAAABAAABAAD9AAYAAAIAAAYBAAAAAAEzpPybC8g1pan9NYfx+nHHQ7zr7wFglpo=

-- https://lua.expert/
return {
	Name = "Egg Thief",
	TowerName = "Gigi",
	Description = "No description yet",
	Mastery = false,
	Cost = 600,
	Unlocks = require(game:GetService("ReplicatedStorage").SharedData.ReleaseTimes).Easter2026_W4,
	Easter = true,
	HolidaySkin = true,
	OverwriteAnimations = {
		Ability = "rbxassetid://92455041576210",
		Decode = "rbxassetid://98963387488985",
		Idle = "rbxassetid://125686660526683",
		Quirk = "rbxassetid://97537374452563",
		Run = "rbxassetid://109941595226660",
		Walk = "rbxassetid://88140844483455"
	},
	FaceTextures = {
		Normal = "rbxassetid://112259921057639",
		Blink = "rbxassetid://123572543961950",
		Hurt = "rbxassetid://99253419766432"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 32 ]] end
}