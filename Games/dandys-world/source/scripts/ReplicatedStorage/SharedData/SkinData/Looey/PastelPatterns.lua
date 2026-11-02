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
-- CQMqCUFwcGx5U2tpbg9QYXN0ZWwgUGF0dGVybnMETmFtZQVMb29leQlUb3dlck5hbWUSTm8gZGVzY3JpcHRpb24geWV0C0Rlc2NyaXB0aW9uB01hc3RlcnkEQ29zdAdCYXNrZXRzDFJlcXVpcmVtZW50MQRDb2luDFJlcXVpcmVtZW50MgdyZXF1aXJlBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQpTaGFyZWREYXRhDFJlbGVhc2VUaW1lcw1FYXN0ZXIyMDI2X1c0B1VubG9ja3MGRWFzdGVyC0hvbGlkYXlTa2luG3JieGFzc2V0aWQ6Ly83OTc2ODYzNzA3MTM0MQZEZWNvZGUccmJ4YXNzZXRpZDovLzExNDE2NDk1MDQzMjEzMARJZGxlHHJieGFzc2V0aWQ6Ly8xMjQ5MjY3Mzg3NDU0NDIFUXVpcmsccmJ4YXNzZXRpZDovLzEyMDYwNzg1NzA0ODAzNQNSdW4ccmJ4YXNzZXRpZDovLzEzOTc2MzY1MzI4ODg5NgRXYWxrE092ZXJ3cml0ZUFuaW1hdGlvbnMbcmJ4YXNzZXRpZDovLzgwMjE4NDQ3NjA3MDgyBk5vcm1hbBxyYnhhc3NldGlkOi8vMTM1MTc1MzY1OTQ3NTEzBUJsaW5rG3JieGFzc2V0aWQ6Ly84ODE1NDQ0MDA0NjI3MgRIdXJ0DEZhY2VUZXh0dXJlcw5VU0VfU0tJTl9NT0RFTAACAQEAAAAGAwAABQEHAYIAAQAAACQBARgAJgAAAAAFAAABAgBgowAAAP8ABQAAAAAAbwEAADABALoBAAAAbwECADABAIcDAAAAbwEEADABAOIFAAAAqQEAADABADwGAAAAjAGwBDABACMHAAAA/wEAAAIAAABvAggAjAOwBMUBAgMBAAAAMAEAnwkAAAD/AQAAAgAAAG8CCgCMA7AExQECAwEAAAAwAQDGCwAAAKQBDQAAAMBApAIPAAAA4EBvBBAAvAICFhEAAACfAgMCTQICZBIAAABNAgIKEwAAAJ8BAgJNAQH/FAAAADABAFEVAAAAqQEBADABABEWAAAAqQEBADABALwXAAAA/wEEAAAAAABvAhgAMAIB7hkAAABvAhoAMAIBkhsAAABvAhwAMAIBeB0AAABvAh4AMAIBFh8AAABvAiAAMAIBnyEAAAAwAQDpIgAAAP8BAwAAAAAAbwIjADACARAkAAAAbwIlADACAZkmAAAAbwInADACAcUoAAAAMAEAISkAAACpAQEAMAEAwioAAADAASsAMAEA6SwAAACCAAIALQMCAwMDBAMFAwYDBwMIAwkDCgMLAwwDDQMOBAAAwEADDwQAAOBAAxADEQMSAxMDFAMVAxYDFwMYAxkDGgMbAxwDHQMeAx8DIAMhAyIDIwMkAyUDJgMnAygDKQMqBgADAQEAAQABGAAAAAIAAAEAAAEAAAEAAAIAAAMAAAAAAAAAAQAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAMAAAEAAAIAAQAAAQAAAQAAAQAAAQAA+wAIAAEAAAEAAAEAAP0ABgAAAgAABAEAAAAAAUkemaLA9Bv7yH59r43b/eQ5Bo7We9rzow==

-- https://lua.expert/
return {
	Name = "Pastel Patterns",
	TowerName = "Looey",
	Description = "No description yet",
	Mastery = false,
	Cost = 1200,
	Requirement1 = { "Baskets", 1200 },
	Requirement2 = { "Coin", 1200 },
	Unlocks = require(game:GetService("ReplicatedStorage").SharedData.ReleaseTimes).Easter2026_W4,
	Easter = true,
	HolidaySkin = true,
	OverwriteAnimations = {
		Decode = "rbxassetid://79768637071341",
		Idle = "rbxassetid://114164950432130",
		Quirk = "rbxassetid://124926738745442",
		Run = "rbxassetid://120607857048035",
		Walk = "rbxassetid://139763653288896"
	},
	FaceTextures = {
		Normal = "rbxassetid://80218447607082",
		Blink = "rbxassetid://135175365947513",
		Hurt = "rbxassetid://88154440046272"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 36 ]] end
}