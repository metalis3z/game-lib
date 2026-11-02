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
-- CQMmCUFwcGx5U2tpbg1RdWlldCBDYXJvbGVyBE5hbWUGQm94dGVuCVRvd2VyTmFtZRJObyBkZXNjcmlwdGlvbiB5ZXQLRGVzY3JpcHRpb24HTWFzdGVyeQRDb3N0B3JlcXVpcmUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlClNoYXJlZERhdGEMUmVsZWFzZVRpbWVzEENocmlzdG1hczIwMjVfVzMHVW5sb2NrcwlDaHJpc3RtYXMLSG9saWRheVNraW4ccmJ4YXNzZXRpZDovLzEyNzEyNzc3OTgzMDc3MgNSdW4ccmJ4YXNzZXRpZDovLzEyNTE1NDAxODcwMjM5OARXYWxrG3JieGFzc2V0aWQ6Ly84ODIyMjc0NjE4NTgzOQRJZGxlG3JieGFzc2V0aWQ6Ly83NDA4NDQ1ODQ3NzQ1MQZEZWNvZGUccmJ4YXNzZXRpZDovLzEzMjgxMDAwNzA4MzA5MgVRdWlyaxNPdmVyd3JpdGVBbmltYXRpb25zG3JieGFzc2V0aWQ6Ly85NzkwMDU4Mjk5MzMzMwVCbGluaxxyYnhhc3NldGlkOi8vMTI3ODQxODgxOTI5MzI5BEh1cnQbcmJ4YXNzZXRpZDovLzk2NTUyNzM3MzI5MzczBk5vcm1hbAxGYWNlVGV4dHVyZXMOVVNFX1NLSU5fTU9ERUwAAgEBAAAAAAGCAAEAAAAgAQEYACQAAAAABQAAAQIAUKMAAAD/AAUAAAAAAG8BAAAwAQC6AQAAAG8BAgAwAQCHAwAAAG8BBAAwAQDiBQAAAKkBAAAwAQA8BgAAAIwBWAIwAQAjBwAAAKQBCQAAAIBApAILAAAAoEBvBAwAvAICFg0AAACfAgMCTQICZA4AAABNAgIKDwAAAJ8BAgJNAQEwEAAAADABAFERAAAAqQEBADABAK0SAAAAqQEBADABALwTAAAA/wEEAAAAAABvAhQAMAIBFhUAAABvAhYAMAIBnxcAAABvAhgAMAIBkhkAAABvAhoAMAIB7hsAAABvAhwAMAIBeB0AAAAwAQDpHgAAAP8BAwAAAAAAbwIfADACAZkgAAAAbwIhADACAcUiAAAAbwIjADACARAkAAAAMAEAISUAAACpAQEAMAEAwiYAAADAAScAMAEA6SgAAACCAAIAKQMCAwMDBAMFAwYDBwMIAwkDCgQAAIBAAwsEAACgQAMMAw0DDgMPAxADEQMSAxMDFAMVAxYDFwMYAxkDGgMbAxwDHQMeAx8DIAMhAyIDIwMkAyUDJgYAAwEBAAEAARgAAQACAAABAAABAAABAAACAAABAAAAAAAAAAAAAAAAAAAAAAMAAAEAAAIAAQAAAQAAAQAAAQAAAQAA+wAIAAEAAAEAAAEAAP0ABgAAAgAABgEAAAAAARmVz/FtlktbTO6dNR+z/rVpjdiFK1Gl8A==

-- https://lua.expert/
return {
	Name = "Quiet Caroler",
	TowerName = "Boxten",
	Description = "No description yet",
	Mastery = false,
	Cost = 600,
	Unlocks = require(game:GetService("ReplicatedStorage").SharedData.ReleaseTimes).Christmas2025_W3,
	Christmas = true,
	HolidaySkin = true,
	OverwriteAnimations = {
		Run = "rbxassetid://127127779830772",
		Walk = "rbxassetid://125154018702398",
		Idle = "rbxassetid://88222746185839",
		Decode = "rbxassetid://74084458477451",
		Quirk = "rbxassetid://132810007083092"
	},
	FaceTextures = {
		Blink = "rbxassetid://97900582993333",
		Hurt = "rbxassetid://127841881929329",
		Normal = "rbxassetid://96552737329373"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 32 ]] end
}