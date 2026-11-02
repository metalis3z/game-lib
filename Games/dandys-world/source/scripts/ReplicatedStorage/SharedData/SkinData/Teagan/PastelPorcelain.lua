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
-- CQMsCUFwcGx5U2tpbhBQYXN0ZWwgUG9yY2VsYWluBE5hbWUGVGVhZ2FuCVRvd2VyTmFtZRJObyBkZXNjcmlwdGlvbiB5ZXQLRGVzY3JpcHRpb24HTWFzdGVyeQRDb3N0B0Jhc2tldHMMUmVxdWlyZW1lbnQxBENvaW4MUmVxdWlyZW1lbnQyB3JlcXVpcmUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlClNoYXJlZERhdGEMUmVsZWFzZVRpbWVzDUVhc3RlcjIwMjZfVzIHVW5sb2NrcwZFYXN0ZXILSG9saWRheVNraW4bcmJ4YXNzZXRpZDovLzkzMDI1NjM3MDk2MjU5B0FiaWxpdHkbcmJ4YXNzZXRpZDovLzk1NTI0ODI4MjA4NjYzBkRlY29kZRtyYnhhc3NldGlkOi8vODM2OTM2NTc2MDkyODIESWRsZRxyYnhhc3NldGlkOi8vMTMyNjMyNjUyMTE2ODYzBVF1aXJrG3JieGFzc2V0aWQ6Ly85MDk3MTEwNTE5NzQyOQNSdW4ccmJ4YXNzZXRpZDovLzEwMTQ3ODEzNTI5NDY2MwRXYWxrE092ZXJ3cml0ZUFuaW1hdGlvbnMccmJ4YXNzZXRpZDovLzEyNDMxNjk4Nzk0Mzg4NgZOb3JtYWwbcmJ4YXNzZXRpZDovLzgzNDU5NTMyMTgxNjM4BUJsaW5rHHJieGFzc2V0aWQ6Ly8xMjk0MTA2ODk3NTYzODQESHVydAxGYWNlVGV4dHVyZXMOVVNFX1NLSU5fTU9ERUwAAgEBAAAABgMAAAUBBwGCAAEAAAAlAQEYACcAAAAABQAAAQIAY6MAAAD/AAUAAAAAAG8BAAAwAQC6AQAAAG8BAgAwAQCHAwAAAG8BBAAwAQDiBQAAAKkBAAAwAQA8BgAAAIwBsAQwAQAjBwAAAP8BAAACAAAAbwIIAIwDsATFAQIDAQAAADABAJ8JAAAA/wEAAAIAAABvAgoAjAOwBMUBAgMBAAAAMAEAxgsAAACkAQ0AAADAQKQCDwAAAOBAbwQQALwCAhYRAAAAnwIDAk0CAmQSAAAATQICChMAAACfAQICTQEB/BQAAAAwAQBRFQAAAKkBAQAwAQARFgAAAKkBAQAwAQC8FwAAAP8BBAAAAAAAbwIYADACAfQZAAAAbwIaADACAe4bAAAAbwIcADACAZIdAAAAbwIeADACAXgfAAAAbwIgADACARYhAAAAbwIiADACAZ8jAAAAMAEA6SQAAAD/AQMAAAAAAG8CJQAwAgEQJgAAAG8CJwAwAgGZKAAAAG8CKQAwAgHFKgAAADABACErAAAAqQEBADABAMIsAAAAwAEtADABAOkuAAAAggACAC8DAgMDAwQDBQMGAwcDCAMJAwoDCwMMAw0DDgQAAMBAAw8EAADgQAMQAxEDEgMTAxQDFQMWAxcDGAMZAxoDGwMcAx0DHgMfAyADIQMiAyMDJAMlAyYDJwMoAykDKgMrAywGAAMBAQABAAEYAAAAAgAAAQAAAQAAAQAAAgAAAwAAAAAAAAABAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAwAAAQAAAgABAAABAAABAAABAAABAAABAAD6AAkAAQAAAQAAAQAA/QAGAAACAAAEAQAAAAABoAkRR5k/xRlkh5UfADNLptARBjOSzXtG

-- https://lua.expert/
return {
	Name = "Pastel Porcelain",
	TowerName = "Teagan",
	Description = "No description yet",
	Mastery = false,
	Cost = 1200,
	Requirement1 = { "Baskets", 1200 },
	Requirement2 = { "Coin", 1200 },
	Unlocks = require(game:GetService("ReplicatedStorage").SharedData.ReleaseTimes).Easter2026_W2,
	Easter = true,
	HolidaySkin = true,
	OverwriteAnimations = {
		Ability = "rbxassetid://93025637096259",
		Decode = "rbxassetid://95524828208663",
		Idle = "rbxassetid://83693657609282",
		Quirk = "rbxassetid://132632652116863",
		Run = "rbxassetid://90971105197429",
		Walk = "rbxassetid://101478135294663"
	},
	FaceTextures = {
		Normal = "rbxassetid://124316987943886",
		Blink = "rbxassetid://83459532181638",
		Hurt = "rbxassetid://129410689756384"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 37 ]] end
}