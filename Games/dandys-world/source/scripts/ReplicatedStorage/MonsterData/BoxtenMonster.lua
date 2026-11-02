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
-- CQMjB3JlcXVpcmUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQ5Nb25zdGVyTW9kdWxlcw9TcGVjaWFsQW5pbWF0b3IDbmV3E1NwZWNpYWxBbmltYXRvckRhdGEGQ29uZmlnDlR3aXN0ZWQgQm94dGVuBE5hbWUGQ29tbW9uBlJhcml0eRhyYnhhc3NldGlkOi8vMTcxNzMzMjc1NDUESWNvbgxWaXNpb25SYWRpdXMNSW5zdGFudFJhZGl1cwlXYWxrU3BlZWQIUnVuU3BlZWQMSW50ZXJlc3RUaW1lDUhlYXJpbmdSYWRpdXMGRGFtYWdlCFdhaXRUaW1lC0xpbmVPZlNpZ2h0CktpbGxSYWRpdXMLSGl0Q29vbGRvd24MQ2hhc2VBYmlsaXR5D0FiaWxpdHlDb29sZG93bgZNb2R1bGUeTW9uc3Rlck1vZHVsZXMvU3BlY2lhbEFuaW1hdG9yDEJsaW5rVGV4dHVyZRtyYnhhc3NldGlkOi8vODM5OTk3MDA2NjAxNTYNTm9ybWFsVGV4dHVyZRtyYnhhc3NldGlkOi8vNzgyOTY0MDA0NzA1NzYNQXR0YWNrVGV4dHVyZRtyYnhhc3NldGlkOi8vOTEwMzYwNTgyMjYwODMAAgUBAQAAABWkAQEAAAAAQKQCAwAAACBATQICPwQAAABNAgLKBQAAAE0CApAGAAAAnwECAk0CAe8HAAAAUgMAAPsEAABNBAT4CAAAAE0EBNkJAAAAnwIDAYIAAQAKAwEEAAAAQAMCBAAAIEADAwMEAwUDBgMHAwgAHgUBGAAAAAAAAAAAAAAAAQAAAAAAAAAAAR8AAAAAAwAAAQIAPqMAAAD/AAYAAAAAAG8BAAAwAQC6AQAAAG8BAgAwAQDyAwAAAG8BBAAwAQCuBQAAAIwBPAAwAQCLBgAAAIwBGgAwAQBDBwAAAIwBCgAwAQCOCAAAAIwBEgAwAQBDCQAAAG8BCgAwAQDbCwAAAIwBfQAwAQBYDAAAAIwBAQAwAQAPDQAAAIwBAQAwAQDcDgAAAG8BDwAwAQABEAAAAG8BEQAwAQCwEgAAAIwBAwAwAQBXEwAAAKkBAAAwAQC3FAAAAIwBAAAwAQC7FQAAAOIBGQDiAiAAMAIB2RgAAAAwAQD4IQAAAMABIgASAAAAMAEAkCMAAACCAAIAJAMJAwoDCwMMAw0DDgMPAxADEQMSAgAAAAAAAPg/AxMDFAMVAxYCmpmZmZmZ2T8DFwKkcD0K16MKQAMYAxkDGgMbAxwDHQMICAIWFwAAABj/////Ax4DHwMgAyEDIgMjCAMaGwAAABwdAAAAHh8AAAADBwYAAwUBAAEAARgAAAACAAABAAABAAACAAABAAABAAABAAABAAABAAABAAABAAABAAABAAABAAACAAABAAACAgAA/gAIAAAABQEAAAAAAer4E6H7aS+vadzYiCRZ+kea4ATV2Dx5oA==

-- https://lua.expert/
local t = {
	Name = "Twisted Boxten",
	Rarity = "Common",
	Icon = "rbxassetid://17173327545",
	VisionRadius = 60,
	InstantRadius = 26,
	WalkSpeed = 10,
	RunSpeed = 18,
	InterestTime = 1.5,
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
			BlinkTexture = "rbxassetid://83999700660156",
			NormalTexture = "rbxassetid://78296400470576",
			AttackTexture = "rbxassetid://91036058226083"
		}
	}
}

function t.SpecialAnimator(p1) --[[ SpecialAnimator | Line: 30 | Upvalues: t (copy) ]]
	require(game.ReplicatedStorage.MonsterModules.SpecialAnimator).new(p1, t.SpecialAnimatorData.Config)
end

return t