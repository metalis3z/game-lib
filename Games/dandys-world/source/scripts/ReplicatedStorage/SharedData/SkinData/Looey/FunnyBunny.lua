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
-- CQMmCUFwcGx5U2tpbgtGdW5ueSBCdW5ueQROYW1lBUxvb2V5CVRvd2VyTmFtZRJObyBkZXNjcmlwdGlvbiB5ZXQLRGVzY3JpcHRpb24HTWFzdGVyeQRDb3N0B3JlcXVpcmUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlClNoYXJlZERhdGEMUmVsZWFzZVRpbWVzDUVhc3RlcjIwMjZfVzIHVW5sb2NrcwZFYXN0ZXILSG9saWRheVNraW4ccmJ4YXNzZXRpZDovLzEyODYyMjUyNjI3OTcxNwRXYWxrHHJieGFzc2V0aWQ6Ly8xMDE1Njc1MTEyNDY2MDkESWRsZRtyYnhhc3NldGlkOi8vNzc1MzE3MjQ5OTA2NzgGRGVjb2RlG3JieGFzc2V0aWQ6Ly85OTcwODIzMTY1ODQxOANSdW4bcmJ4YXNzZXRpZDovLzgxOTgyODQyNzEzMTE4BVF1aXJrE092ZXJ3cml0ZUFuaW1hdGlvbnMbcmJ4YXNzZXRpZDovLzgxODkxMTM1MjgwNzk1Bk5vcm1hbBtyYnhhc3NldGlkOi8vODMxNDA4OTgyMDU1MzkFQmxpbmsccmJ4YXNzZXRpZDovLzEzMjQ3ODM5NTE1NTIzMQRIdXJ0DEZhY2VUZXh0dXJlcw5VU0VfU0tJTl9NT0RFTAACAQEAAAAGAwAABQEHAYIAAQAAAB8BARgAIwAAAAAFAAABAgBQowAAAP8ABQAAAAAAbwEAADABALoBAAAAbwECADABAIcDAAAAbwEEADABAOIFAAAAqQEAADABADwGAAAAjAFYAjABACMHAAAApAEJAAAAgECkAgsAAACgQG8EDAC8AgIWDQAAAJ8CAwJNAgJkDgAAAE0CAgoPAAAAnwECAk0BAfwQAAAAMAEAUREAAACpAQEAMAEAERIAAACpAQEAMAEAvBMAAAD/AQQAAAAAAG8CFAAwAgGfFQAAAG8CFgAwAgGSFwAAAG8CGAAwAgHuGQAAAG8CGgAwAgEWGwAAAG8CHAAwAgF4HQAAADABAOkeAAAA/wEDAAAAAABvAh8AMAIBECAAAABvAiEAMAIBmSIAAABvAiMAMAIBxSQAAAAwAQAhJQAAAKkBAQAwAQDCJgAAAMABJwAwAQDpKAAAAIIAAgApAwIDAwMEAwUDBgMHAwgDCQMKBAAAgEADCwQAAKBAAwwDDQMOAw8DEAMRAxIDEwMUAxUDFgMXAxgDGQMaAxsDHAMdAx4DHwMgAyEDIgMjAyQDJQMmBgADAQEAAQABGAAAAAIAAAEAAAEAAAEAAAIAAAEAAAAAAAAAAAAAAAAAAAAAAwAAAQAAAgABAAABAAABAAABAAABAAD7AAgAAQAAAQAAAQAA/QAGAAACAAAGAQAAAAABrPoqqKRgYZnGVb5Qo6zwctziPdyePkCp

-- https://lua.expert/
return {
	Name = "Funny Bunny",
	TowerName = "Looey",
	Description = "No description yet",
	Mastery = false,
	Cost = 600,
	Unlocks = require(game:GetService("ReplicatedStorage").SharedData.ReleaseTimes).Easter2026_W2,
	Easter = true,
	HolidaySkin = true,
	OverwriteAnimations = {
		Walk = "rbxassetid://128622526279717",
		Idle = "rbxassetid://101567511246609",
		Decode = "rbxassetid://77531724990678",
		Run = "rbxassetid://99708231658418",
		Quirk = "rbxassetid://81982842713118"
	},
	FaceTextures = {
		Normal = "rbxassetid://81891135280795",
		Blink = "rbxassetid://83140898205539",
		Hurt = "rbxassetid://132478395155231"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 31 ]] end
}