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
-- CQMtBkNvbG9yMwdmcm9tUkdCBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQQVDb2xvcglBcHBseVNraW4OQ2hyaXN0bWFzIFBhc3QETmFtZQZDb25uaWUJVG93ZXJOYW1lEk5vIGRlc2NyaXB0aW9uIHlldAtEZXNjcmlwdGlvbgdNYXN0ZXJ5BENvc3QHcmVxdWlyZQRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UKU2hhcmVkRGF0YQxSZWxlYXNlVGltZXMQQ2hyaXN0bWFzMjAyNV9XNAdVbmxvY2tzCUNocmlzdG1hcwtIb2xpZGF5U2tpbhxyYnhhc3NldGlkOi8vMTI1NDA1NTY4ODI3NzA4A1J1bhxyYnhhc3NldGlkOi8vMTAxNzg2MzU2ODc5NzE0BFdhbGsbcmJ4YXNzZXRpZDovLzk2NDEyNjc5OTAxOTAyBElkbGUccmJ4YXNzZXRpZDovLzExMzY2NTI5MzM3NzE3MAVRdWlyaxxyYnhhc3NldGlkOi8vMTMzNTAwNjAxNTc1NTA2BkRlY29kZRNPdmVyd3JpdGVBbmltYXRpb25zG3JieGFzc2V0aWQ6Ly84Njc3MzA0MzYyMTQyNAVCbGluaxxyYnhhc3NldGlkOi8vMTA4MjYwOTg5Mjc4Nzc0BEh1cnQccmJ4YXNzZXRpZDovLzExNjIwNzE4MjczNDM0OAZOb3JtYWwMRmFjZVRleHR1cmVzDlVTRV9TS0lOX01PREVMAAIKAQAAAAYDAAAFAQcXpAECAAAEAICMAqIAjAO3AIwE0wCfAQQCpAIEAAAAMEC8AwBHBQAAAJ8DAgCfAgAEFwIHAG8JBgC8Bwb+BwAAAJ8HAwIOBwIAMAEGpAgAAABuAvj/AgAAAIIAAQAJAwEDAgQABACAAwMEAAAwQAMEAwUDBgMHAB8IARgAAAAAAAABAAAAAAAAAQAAAAABAP4ABiIAAAAABQAAAQIAUKMAAAD/AAUAAAAAAG8BAAAwAQC6AQAAAG8BAgAwAQCHAwAAAG8BBAAwAQDiBQAAAKkBAAAwAQA8BgAAAIwBWAIwAQAjBwAAAKQBCQAAAIBApAILAAAAoEBvBAwAvAICFg0AAACfAgMCTQICZA4AAABNAgIKDwAAAJ8BAgJNAQF1EAAAADABAFERAAAAqQEBADABAK0SAAAAqQEBADABALwTAAAA/wEEAAAAAABvAhQAMAIBFhUAAABvAhYAMAIBnxcAAABvAhgAMAIBkhkAAABvAhoAMAIBeBsAAABvAhwAMAIB7h0AAAAwAQDpHgAAAP8BAwAAAAAAbwIfADACAZkgAAAAbwIhADACAcUiAAAAbwIjADACARAkAAAAMAEAISUAAACpAQEAMAEAwiYAAADAAScAMAEA6SgAAACCAAIAKQMJAwoDCwMMAw0DDgMPAxADEQQAAIBAAxIEAACgQAMTAxQDFQMWAxcDGAMZAxoDGwMcAx0DHgMfAyADIQMiAyMDJAMlAyYDJwMoAykDKgMrAywDLQYAAwgBAAEAARgAAAACAAABAAABAAABAAACAAABAAAAAAAAAAAAAAAAAAAAAAMAAAEAAAIAAQAAAQAAAQAAAQAAAQAA+wAIAAEAAAEAAAEAAP0ABgAAAgAADAEAAAAAAY8As6F9AlwNmn6zzzNHDO3/GKTVvcTZoA==

-- https://lua.expert/
return {
	Name = "Christmas Past",
	TowerName = "Connie",
	Description = "No description yet",
	Mastery = false,
	Cost = 600,
	Unlocks = require(game:GetService("ReplicatedStorage").SharedData.ReleaseTimes).Christmas2025_W4,
	Christmas = true,
	HolidaySkin = true,
	OverwriteAnimations = {
		Run = "rbxassetid://125405568827708",
		Walk = "rbxassetid://101786356879714",
		Idle = "rbxassetid://96412679901902",
		Quirk = "rbxassetid://113665293377170",
		Decode = "rbxassetid://133500601575506"
	},
	FaceTextures = {
		Blink = "rbxassetid://86773043621424",
		Hurt = "rbxassetid://108260989278774",
		Normal = "rbxassetid://116207182734348"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 31 ]]
		local v1 = Color3.fromRGB(162, 183, 211)

		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.Color = v1
			end
		end
	end
}