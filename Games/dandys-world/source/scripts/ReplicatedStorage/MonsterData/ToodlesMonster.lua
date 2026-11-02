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
-- CQMjB3JlcXVpcmUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQ5Nb25zdGVyTW9kdWxlcw9TcGVjaWFsQW5pbWF0b3IDbmV3E1NwZWNpYWxBbmltYXRvckRhdGEGQ29uZmlnD1R3aXN0ZWQgVG9vZGxlcwROYW1lCFVuY29tbW9uBlJhcml0eRhyYnhhc3NldGlkOi8vMTc2NDMzNTAwNzQESWNvbgxWaXNpb25SYWRpdXMNSW5zdGFudFJhZGl1cwlXYWxrU3BlZWQIUnVuU3BlZWQMSW50ZXJlc3RUaW1lDUhlYXJpbmdSYWRpdXMGRGFtYWdlCFdhaXRUaW1lC0xpbmVPZlNpZ2h0CktpbGxSYWRpdXMLSGl0Q29vbGRvd24MQ2hhc2VBYmlsaXR5D0FiaWxpdHlDb29sZG93bgZNb2R1bGUeTW9uc3Rlck1vZHVsZXMvU3BlY2lhbEFuaW1hdG9yDEJsaW5rVGV4dHVyZRxyYnhhc3NldGlkOi8vMTMzMDA0OTQ1OTMwMDk1DU5vcm1hbFRleHR1cmUccmJ4YXNzZXRpZDovLzEzOTI5MDg2NDQxMzA4Mw1BdHRhY2tUZXh0dXJlHHJieGFzc2V0aWQ6Ly8xMDA3NzMwNDE5MzQ4NTQAAgUBAQAAABWkAQEAAAAAQKQCAwAAACBATQICPwQAAABNAgLKBQAAAE0CApAGAAAAnwECAk0CAe8HAAAAUgMAAPsEAABNBAT4CAAAAE0EBNkJAAAAnwIDAYIAAQAKAwEEAAAAQAMCBAAAIEADAwMEAwUDBgMHAwgAIgUBGAAAAAAAAAAAAAAAAQAAAAAAAAAAASMAAAAAAwAAAQIAPqMAAAD/AAYAAAAAAG8BAAAwAQC6AQAAAG8BAgAwAQDyAwAAAG8BBAAwAQCuBQAAAIwBMgAwAQCLBgAAAIwBGQAwAQBDBwAAAIwBDAAwAQCOCAAAAIwBFAAwAQBDCQAAAIwBAQAwAQDbCgAAAIwBfQAwAQBYCwAAAIwBAQAwAQAPDAAAAIwBAQAwAQDcDQAAAG8BDgAwAQABDwAAAG8BEAAwAQCwEQAAAIwBAwAwAQBXEgAAAKkBAAAwAQC3EwAAAIwBAAAwAQC7FAAAAOIBGADiAh8AMAIB2RcAAAAwAQD4IAAAAMABIQASAAAAMAEAkCIAAACCAAIAIwMJAwoDCwMMAw0DDgMPAxADEQMSAxMDFAMVAxYCmpmZmZmZ2T8DFwKkcD0K16MKQAMYAxkDGgMbAxwDHQMICAIVFgAAABf/////Ax4DHwMgAyEDIgMjCAMZGgAAABscAAAAHR4AAAADBwYAAwUBAAEAARgAAAACAAABAAABAAADAAABAAABAAABAAABAAABAAADAAABAAABAAABAAABAAADAAABAAACAgAA/gAIAAAABQEAAAAAAWJ4o/4/qXJJGP3s+O0jkZgSYLSKULzJ/w==

-- https://lua.expert/
local t = {
	Name = "Twisted Toodles",
	Rarity = "Uncommon",
	Icon = "rbxassetid://17643350074",
	VisionRadius = 50,
	InstantRadius = 25,
	WalkSpeed = 12,
	RunSpeed = 20,
	InterestTime = 1,
	HearingRadius = 125,
	Damage = 1,
	WaitTime = 1,
	LineOfSight = 0.4,
	KillRadius = 3.33,
	HitCooldown = 3,
	ChaseAbility = false,
	AbilityCooldown = 0,
	SpecialAnimatorData = {
		Module = "MonsterModules/SpecialAnimator",
		Config = {
			BlinkTexture = "rbxassetid://133004945930095",
			NormalTexture = "rbxassetid://139290864413083",
			AttackTexture = "rbxassetid://100773041934854"
		}
	}
}

function t.SpecialAnimator(p1) --[[ SpecialAnimator | Line: 34 | Upvalues: t (copy) ]]
	require(game.ReplicatedStorage.MonsterModules.SpecialAnimator).new(p1, t.SpecialAnimatorData.Config)
end

return t