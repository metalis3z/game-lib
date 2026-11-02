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
-- CQMmCUFwcGx5U2tpbhFDb25maWRlbnQgQ2Fyb2xlcgROYW1lBVBvcHB5CVRvd2VyTmFtZRJObyBkZXNjcmlwdGlvbiB5ZXQLRGVzY3JpcHRpb24HTWFzdGVyeQRDb3N0B3JlcXVpcmUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlClNoYXJlZERhdGEMUmVsZWFzZVRpbWVzEENocmlzdG1hczIwMjVfVzMHVW5sb2NrcwlDaHJpc3RtYXMLSG9saWRheVNraW4ccmJ4YXNzZXRpZDovLzEzMDQ1NzU4MjgyODc2MQNSdW4bcmJ4YXNzZXRpZDovLzc0MjM4MzA2NjM5MzAwBFdhbGsbcmJ4YXNzZXRpZDovLzg3MDg4NTY5MzM3Mjc1BElkbGUbcmJ4YXNzZXRpZDovLzgwMjQzMTE1MzcxMzQ5BVF1aXJrHHJieGFzc2V0aWQ6Ly8xMjA4NTk5Njg5MTc0OTIGRGVjb2RlE092ZXJ3cml0ZUFuaW1hdGlvbnMbcmJ4YXNzZXRpZDovLzc3NDUwNDg1OTUwMjQ2BUJsaW5rHHJieGFzc2V0aWQ6Ly8xMzAyNzM2OTMxMzA0NTMESHVydBtyYnhhc3NldGlkOi8vOTkwMDc2NTM2NzMwMjIGTm9ybWFsDEZhY2VUZXh0dXJlcw5VU0VfU0tJTl9NT0RFTAACAQEAAAAGAwAABQEHAYIAAQAAAB8BARgAIwAAAAAFAAABAgBQowAAAP8ABQAAAAAAbwEAADABALoBAAAAbwECADABAIcDAAAAbwEEADABAOIFAAAAqQEAADABADwGAAAAjAFYAjABACMHAAAApAEJAAAAgECkAgsAAACgQG8EDAC8AgIWDQAAAJ8CAwJNAgJkDgAAAE0CAgoPAAAAnwECAk0BATAQAAAAMAEAUREAAACpAQEAMAEArRIAAACpAQEAMAEAvBMAAAD/AQQAAAAAAG8CFAAwAgEWFQAAAG8CFgAwAgGfFwAAAG8CGAAwAgGSGQAAAG8CGgAwAgF4GwAAAG8CHAAwAgHuHQAAADABAOkeAAAA/wEDAAAAAABvAh8AMAIBmSAAAABvAiEAMAIBxSIAAABvAiMAMAIBECQAAAAwAQAhJQAAAKkBAQAwAQDCJgAAAMABJwAwAQDpKAAAAIIAAgApAwIDAwMEAwUDBgMHAwgDCQMKBAAAgEADCwQAAKBAAwwDDQMOAw8DEAMRAxIDEwMUAxUDFgMXAxgDGQMaAxsDHAMdAx4DHwMgAyEDIgMjAyQDJQMmBgADAQEAAQABGAAAAAIAAAEAAAEAAAEAAAIAAAEAAAAAAAAAAAAAAAAAAAAAAwAAAQAAAgABAAABAAABAAABAAABAAD7AAgAAQAAAQAAAQAA/QAGAAACAAAGAQAAAAABXuOP9C7GdGGg+Wmcd2iqOS77mIBsJ+X1

-- https://lua.expert/
return {
	Name = "Confident Caroler",
	TowerName = "Poppy",
	Description = "No description yet",
	Mastery = false,
	Cost = 600,
	Unlocks = require(game:GetService("ReplicatedStorage").SharedData.ReleaseTimes).Christmas2025_W3,
	Christmas = true,
	HolidaySkin = true,
	OverwriteAnimations = {
		Run = "rbxassetid://130457582828761",
		Walk = "rbxassetid://74238306639300",
		Idle = "rbxassetid://87088569337275",
		Quirk = "rbxassetid://80243115371349",
		Decode = "rbxassetid://120859968917492"
	},
	FaceTextures = {
		Blink = "rbxassetid://77450485950246",
		Hurt = "rbxassetid://130273693130453",
		Normal = "rbxassetid://99007653673022"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 31 ]] end
}