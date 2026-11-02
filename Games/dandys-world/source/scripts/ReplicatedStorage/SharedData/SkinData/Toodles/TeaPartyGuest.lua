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
-- CQMoCUFwcGx5U2tpbg9UZWEgUGFydHkgR3Vlc3QETmFtZQdUb29kbGVzCVRvd2VyTmFtZRJObyBkZXNjcmlwdGlvbiB5ZXQLRGVzY3JpcHRpb24HTWFzdGVyeQRDb3N0B3JlcXVpcmUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlClNoYXJlZERhdGEMUmVsZWFzZVRpbWVzDUVhc3RlcjIwMjZfVzUHVW5sb2NrcwZFYXN0ZXILSG9saWRheVNraW4bcmJ4YXNzZXRpZDovLzg1OTg2NjAxMTE1NTI3A1J1bhtyYnhhc3NldGlkOi8vOTkyOTk2NDQzOTY2MTAEV2FsaxtyYnhhc3NldGlkOi8vODQ1OTMyMjI0MDA5NzMESWRsZRxyYnhhc3NldGlkOi8vMTA3OTQwNTMyMzg5NTg3BVF1aXJrG3JieGFzc2V0aWQ6Ly85NDMwOTc5NjM1MTI2OAZEZWNvZGUccmJ4YXNzZXRpZDovLzEyNDAwNTI2ODQ1NjY1MwdBYmlsaXR5E092ZXJ3cml0ZUFuaW1hdGlvbnMccmJ4YXNzZXRpZDovLzExMTk2ODc2MDA1NzU4MAZOb3JtYWwbcmJ4YXNzZXRpZDovLzg5MDgzOTAyNzUyMTYwBUJsaW5rHHJieGFzc2V0aWQ6Ly8xMzM4MDA5MDc1NDAyNTIESHVydAxGYWNlVGV4dHVyZXMOVVNFX1NLSU5fTU9ERUwAAgEBAAAABgMAAAUBBwGCAAEAAAAgAQEYACQAAAAABQAAAQIAU6MAAAD/AAUAAAAAAG8BAAAwAQC6AQAAAG8BAgAwAQCHAwAAAG8BBAAwAQDiBQAAAKkBAAAwAQA8BgAAAIwBWAIwAQAjBwAAAKQBCQAAAIBApAILAAAAoEBvBAwAvAICFg0AAACfAgMCTQICZA4AAABNAgIKDwAAAJ8BAgJNAQHlEAAAADABAFERAAAAqQEBADABABESAAAAqQEBADABALwTAAAA/wEEAAAAAABvAhQAMAIBFhUAAABvAhYAMAIBnxcAAABvAhgAMAIBkhkAAABvAhoAMAIBeBsAAABvAhwAMAIB7h0AAABvAh4AMAIB9B8AAAAwAQDpIAAAAP8BAwAAAAAAbwIhADACARAiAAAAbwIjADACAZkkAAAAbwIlADACAcUmAAAAMAEAIScAAACpAQEAMAEAwigAAADAASkAMAEA6SoAAACCAAIAKwMCAwMDBAMFAwYDBwMIAwkDCgQAAIBAAwsEAACgQAMMAw0DDgMPAxADEQMSAxMDFAMVAxYDFwMYAxkDGgMbAxwDHQMeAx8DIAMhAyIDIwMkAyUDJgMnAygGAAMBAQABAAEYAAAAAgAAAQAAAQAAAQAAAgAAAQAAAAAAAAAAAAAAAAAAAAADAAABAAACAAEAAAEAAAEAAAEAAAEAAAEAAPoACQABAAABAAABAAD9AAYAAAIAAAYBAAAAAAGQxDb+3f7R3hp+LV8Gbvj/4NwhiqIAXP8=

-- https://lua.expert/
return {
	Name = "Tea Party Guest",
	TowerName = "Toodles",
	Description = "No description yet",
	Mastery = false,
	Cost = 600,
	Unlocks = require(game:GetService("ReplicatedStorage").SharedData.ReleaseTimes).Easter2026_W5,
	Easter = true,
	HolidaySkin = true,
	OverwriteAnimations = {
		Run = "rbxassetid://85986601115527",
		Walk = "rbxassetid://99299644396610",
		Idle = "rbxassetid://84593222400973",
		Quirk = "rbxassetid://107940532389587",
		Decode = "rbxassetid://94309796351268",
		Ability = "rbxassetid://124005268456653"
	},
	FaceTextures = {
		Normal = "rbxassetid://111968760057580",
		Blink = "rbxassetid://89083902752160",
		Hurt = "rbxassetid://133800907540252"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 32 ]] end
}