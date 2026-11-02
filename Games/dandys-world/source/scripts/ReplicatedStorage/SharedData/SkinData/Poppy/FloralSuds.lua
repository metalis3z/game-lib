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
-- CQMmCUFwcGx5U2tpbgtGbG9yYWwgU3VkcwROYW1lBVBvcHB5CVRvd2VyTmFtZRJObyBkZXNjcmlwdGlvbiB5ZXQLRGVzY3JpcHRpb24HTWFzdGVyeQRDb3N0B3JlcXVpcmUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlClNoYXJlZERhdGEMUmVsZWFzZVRpbWVzDUVhc3RlcjIwMjZfVzUHVW5sb2NrcwZFYXN0ZXILSG9saWRheVNraW4ccmJ4YXNzZXRpZDovLzEzMDQ1NzU4MjgyODc2MQNSdW4bcmJ4YXNzZXRpZDovLzc0MjM4MzA2NjM5MzAwBFdhbGsccmJ4YXNzZXRpZDovLzExMTczNjI1ODMxMTgzNARJZGxlG3JieGFzc2V0aWQ6Ly84MDI0MzExNTM3MTM0OQVRdWlyaxxyYnhhc3NldGlkOi8vMTIwODU5OTY4OTE3NDkyBkRlY29kZRNPdmVyd3JpdGVBbmltYXRpb25zHHJieGFzc2V0aWQ6Ly8xMjA5NjA5NTMzMjAxNDUGTm9ybWFsHHJieGFzc2V0aWQ6Ly8xMDUzNTEzMTA0NzE1NDIFQmxpbmsccmJ4YXNzZXRpZDovLzEwMjEzOTUyMzQ2MjMzMARIdXJ0DEZhY2VUZXh0dXJlcw5VU0VfU0tJTl9NT0RFTAACAQEAAAAGAwAABQEHAYIAAQAAAB8BARgAIwAAAAAFAAABAgBQowAAAP8ABQAAAAAAbwEAADABALoBAAAAbwECADABAIcDAAAAbwEEADABAOIFAAAAqQEAADABADwGAAAAjAFYAjABACMHAAAApAEJAAAAgECkAgsAAACgQG8EDAC8AgIWDQAAAJ8CAwJNAgJkDgAAAE0CAgoPAAAAnwECAk0BAeUQAAAAMAEAUREAAACpAQEAMAEAERIAAACpAQEAMAEAvBMAAAD/AQQAAAAAAG8CFAAwAgEWFQAAAG8CFgAwAgGfFwAAAG8CGAAwAgGSGQAAAG8CGgAwAgF4GwAAAG8CHAAwAgHuHQAAADABAOkeAAAA/wEDAAAAAABvAh8AMAIBECAAAABvAiEAMAIBmSIAAABvAiMAMAIBxSQAAAAwAQAhJQAAAKkBAQAwAQDCJgAAAMABJwAwAQDpKAAAAIIAAgApAwIDAwMEAwUDBgMHAwgDCQMKBAAAgEADCwQAAKBAAwwDDQMOAw8DEAMRAxIDEwMUAxUDFgMXAxgDGQMaAxsDHAMdAx4DHwMgAyEDIgMjAyQDJQMmBgADAQEAAQABGAAAAAIAAAEAAAEAAAEAAAIAAAEAAAAAAAAAAAAAAAAAAAAAAwAAAQAAAgABAAABAAABAAABAAABAAD7AAgAAQAAAQAAAQAA/QAGAAACAAAGAQAAAAABxQ46eV4aY533EzMccN/357UWLQ33ylB4

-- https://lua.expert/
return {
	Name = "Floral Suds",
	TowerName = "Poppy",
	Description = "No description yet",
	Mastery = false,
	Cost = 600,
	Unlocks = require(game:GetService("ReplicatedStorage").SharedData.ReleaseTimes).Easter2026_W5,
	Easter = true,
	HolidaySkin = true,
	OverwriteAnimations = {
		Run = "rbxassetid://130457582828761",
		Walk = "rbxassetid://74238306639300",
		Idle = "rbxassetid://111736258311834",
		Quirk = "rbxassetid://80243115371349",
		Decode = "rbxassetid://120859968917492"
	},
	FaceTextures = {
		Normal = "rbxassetid://120960953320145",
		Blink = "rbxassetid://105351310471542",
		Hurt = "rbxassetid://102139523462330"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 31 ]] end
}