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
-- CQMqCUFwcGx5U2tpbhFDcmlua2xlZCBDb25mZXR0aQROYW1lBVlhdHRhCVRvd2VyTmFtZRJObyBkZXNjcmlwdGlvbiB5ZXQLRGVzY3JpcHRpb24HTWFzdGVyeQRDb3N0B0Jhc2tldHMMUmVxdWlyZW1lbnQxBENvaW4MUmVxdWlyZW1lbnQyB3JlcXVpcmUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlClNoYXJlZERhdGEMUmVsZWFzZVRpbWVzDUVhc3RlcjIwMjZfVzQHVW5sb2NrcwZFYXN0ZXILSG9saWRheVNraW4ccmJ4YXNzZXRpZDovLzEyMTg4NzU5NzA1NjE2OQNSdW4ccmJ4YXNzZXRpZDovLzExMzQ5MzI3NjAzMDc5OQRXYWxrG3JieGFzc2V0aWQ6Ly85NDY3MjkzOTM3MDE0OQRJZGxlHHJieGFzc2V0aWQ6Ly8xMjA1MjQ4OTY2NTc3NjcFUXVpcmsbcmJ4YXNzZXRpZDovLzgxMTk1MzUwOTMxNzM1BkRlY29kZRNPdmVyd3JpdGVBbmltYXRpb25zHHJieGFzc2V0aWQ6Ly8xMTM5NDMxNDkxMzEyOTgGTm9ybWFsG3JieGFzc2V0aWQ6Ly84ODYzNDUzMDU5MTA5NwVCbGluaxtyYnhhc3NldGlkOi8vNzYwMDA4MzYzOTg0OTYESHVydAxGYWNlVGV4dHVyZXMOVVNFX1NLSU5fTU9ERUwAAgEBAAAABgMAAAUBBwGCAAEAAAAkAQEYACYAAAAABQAAAQIAYKMAAAD/AAUAAAAAAG8BAAAwAQC6AQAAAG8BAgAwAQCHAwAAAG8BBAAwAQDiBQAAAKkBAAAwAQA8BgAAAIwBsAQwAQAjBwAAAP8BAAACAAAAbwIIAIwDsATFAQIDAQAAADABAJ8JAAAA/wEAAAIAAABvAgoAjAOwBMUBAgMBAAAAMAEAxgsAAACkAQ0AAADAQKQCDwAAAOBAbwQQALwCAhYRAAAAnwIDAk0CAmQSAAAATQICChMAAACfAQICTQEB/xQAAAAwAQBRFQAAAKkBAQAwAQARFgAAAKkBAQAwAQC8FwAAAP8BBAAAAAAAbwIYADACARYZAAAAbwIaADACAZ8bAAAAbwIcADACAZIdAAAAbwIeADACAXgfAAAAbwIgADACAe4hAAAAMAEA6SIAAAD/AQMAAAAAAG8CIwAwAgEQJAAAAG8CJQAwAgGZJgAAAG8CJwAwAgHFKAAAADABACEpAAAAqQEBADABAMIqAAAAwAErADABAOksAAAAggACAC0DAgMDAwQDBQMGAwcDCAMJAwoDCwMMAw0DDgQAAMBAAw8EAADgQAMQAxEDEgMTAxQDFQMWAxcDGAMZAxoDGwMcAx0DHgMfAyADIQMiAyMDJAMlAyYDJwMoAykDKgYAAwEBAAEAARgAAAACAAABAAABAAABAAACAAADAAAAAAAAAAEAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAADAAABAAACAAEAAAEAAAEAAAEAAAEAAPsACAABAAABAAABAAD9AAYAAAIAAAQBAAAAAAHnEk+en/NuGOqE3IsWBKUUlwpY6tXWJZ8=

-- https://lua.expert/
return {
	Name = "Crinkled Confetti",
	TowerName = "Yatta",
	Description = "No description yet",
	Mastery = false,
	Cost = 1200,
	Requirement1 = { "Baskets", 1200 },
	Requirement2 = { "Coin", 1200 },
	Unlocks = require(game:GetService("ReplicatedStorage").SharedData.ReleaseTimes).Easter2026_W4,
	Easter = true,
	HolidaySkin = true,
	OverwriteAnimations = {
		Run = "rbxassetid://121887597056169",
		Walk = "rbxassetid://113493276030799",
		Idle = "rbxassetid://94672939370149",
		Quirk = "rbxassetid://120524896657767",
		Decode = "rbxassetid://81195350931735"
	},
	FaceTextures = {
		Normal = "rbxassetid://113943149131298",
		Blink = "rbxassetid://88634530591097",
		Hurt = "rbxassetid://76000836398496"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 36 ]] end
}