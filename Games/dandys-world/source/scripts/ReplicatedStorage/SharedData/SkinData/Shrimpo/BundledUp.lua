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
-- CQMqCUFwcGx5U2tpbgpCdW5kbGVkIFVwBE5hbWUHU2hyaW1wbwlUb3dlck5hbWUSTm8gZGVzY3JpcHRpb24geWV0C0Rlc2NyaXB0aW9uB01hc3RlcnkEQ29zdAdyZXF1aXJlBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQpTaGFyZWREYXRhDFJlbGVhc2VUaW1lcxBDaHJpc3RtYXMyMDI1X1c0B1VubG9ja3MWQ2hyaXN0bWFzMjAyNU9ybmFtZW50cwxSZXF1aXJlbWVudDEEQ29pbgxSZXF1aXJlbWVudDIJQ2hyaXN0bWFzC0hvbGlkYXlTa2luG3JieGFzc2V0aWQ6Ly85MTkwNjc5Mjc5ODM0OQRXYWxrHHJieGFzc2V0aWQ6Ly8xMDI4OTA1MDExNTA4NTgDUnVuHHJieGFzc2V0aWQ6Ly8xMjcxMTk5MzQ1MDUwODQFUXVpcmsccmJ4YXNzZXRpZDovLzEzMTQyODE0ODQyNzA3MwRJZGxlHHJieGFzc2V0aWQ6Ly8xMjM3NTI4MjYxNjE0MjUGRGVjb2RlE092ZXJ3cml0ZUFuaW1hdGlvbnMbcmJ4YXNzZXRpZDovLzg2Mjg2NzQyNjQ0MjI5BUJsaW5rHHJieGFzc2V0aWQ6Ly8xMTgzNTE3MTYxNzYxOTcESHVydBtyYnhhc3NldGlkOi8vNzI1MjUwMjY4MzczNTMGTm9ybWFsDEZhY2VUZXh0dXJlcw5VU0VfU0tJTl9NT0RFTAACAQEAAAAGAwAABQEHAYIAAQAAACMBARgAJwAAAAAFAAABAgBgowAAAP8ABQAAAAAAbwEAADABALoBAAAAbwECADABAIcDAAAAbwEEADABAOIFAAAAqQEAADABADwGAAAAjAGwBDABACMHAAAApAEJAAAAgECkAgsAAACgQG8EDAC8AgIWDQAAAJ8CAwJNAgJkDgAAAE0CAgoPAAAAnwECAk0BAXUQAAAAMAEAUREAAAD/AQAAAgAAAG8CEgCMA7AExQECAwEAAAAwAQCfEwAAAP8BAAACAAAAbwIUAIwDsATFAQIDAQAAADABAMYVAAAAqQEBADABAK0WAAAAqQEBADABALwXAAAA/wEEAAAAAABvAhgAMAIBnxkAAABvAhoAMAIBFhsAAABvAhwAMAIBeB0AAABvAh4AMAIBkh8AAABvAiAAMAIB7iEAAAAwAQDpIgAAAP8BAwAAAAAAbwIjADACAZkkAAAAbwIlADACAcUmAAAAbwInADACARAoAAAAMAEAISkAAACpAQEAMAEAwioAAADAASsAMAEA6SwAAACCAAIALQMCAwMDBAMFAwYDBwMIAwkDCgQAAIBAAwsEAACgQAMMAw0DDgMPAxADEQMSAxMDFAMVAxYDFwMYAxkDGgMbAxwDHQMeAx8DIAMhAyIDIwMkAyUDJgMnAygDKQMqBgADAQEAAQABGAAAAAIAAAEAAAEAAAEAAAIAAAEAAAAAAAAAAAAAAAAAAAAAAwAAAAAAAAABAAAAAAAAAAMAAAEAAAIAAQAAAQAAAQAAAQAAAQAA+wAIAAEAAAEAAAEAAP0ABgAAAgAACAEAAAAAAcDHmwXFj6chPEEzmrxo1jmw34xx8gPxBA==

-- https://lua.expert/
return {
	Name = "Bundled Up",
	TowerName = "Shrimpo",
	Description = "No description yet",
	Mastery = false,
	Cost = 1200,
	Unlocks = require(game:GetService("ReplicatedStorage").SharedData.ReleaseTimes).Christmas2025_W4,
	Requirement1 = { "Christmas2025Ornaments", 1200 },
	Requirement2 = { "Coin", 1200 },
	Christmas = true,
	HolidaySkin = true,
	OverwriteAnimations = {
		Walk = "rbxassetid://91906792798349",
		Run = "rbxassetid://102890501150858",
		Quirk = "rbxassetid://127119934505084",
		Idle = "rbxassetid://131428148427073",
		Decode = "rbxassetid://123752826161425"
	},
	FaceTextures = {
		Blink = "rbxassetid://86286742644229",
		Hurt = "rbxassetid://118351716176197",
		Normal = "rbxassetid://72525026837353"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 35 ]] end
}