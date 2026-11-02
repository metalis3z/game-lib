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
-- CQMjB3JlcXVpcmUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQ5Nb25zdGVyTW9kdWxlcw9TcGVjaWFsQW5pbWF0b3IDbmV3E1NwZWNpYWxBbmltYXRvckRhdGEGQ29uZmlnDVR3aXN0ZWQgUG9wcHkETmFtZQZDb21tb24GUmFyaXR5GHJieGFzc2V0aWQ6Ly8xNzAxMTQ5MzkwMQRJY29uDFZpc2lvblJhZGl1cw1JbnN0YW50UmFkaXVzCVdhbGtTcGVlZAhSdW5TcGVlZAxJbnRlcmVzdFRpbWUNSGVhcmluZ1JhZGl1cwZEYW1hZ2UIV2FpdFRpbWULTGluZU9mU2lnaHQKS2lsbFJhZGl1cwtIaXRDb29sZG93bgxDaGFzZUFiaWxpdHkPQWJpbGl0eUNvb2xkb3duBk1vZHVsZR5Nb25zdGVyTW9kdWxlcy9TcGVjaWFsQW5pbWF0b3IMQmxpbmtUZXh0dXJlHHJieGFzc2V0aWQ6Ly8xMTkwNTUyMDYyNjc2OTgNTm9ybWFsVGV4dHVyZRtyYnhhc3NldGlkOi8vODY0NTA5MjIzODY5MTENQXR0YWNrVGV4dHVyZRtyYnhhc3NldGlkOi8vODQzNDYyNDMzMTI0MzkAAgUBAQAAABWkAQEAAAAAQKQCAwAAACBATQICPwQAAABNAgLKBQAAAE0CApAGAAAAnwECAk0CAe8HAAAAUgMAAPsEAABNBAT4CAAAAE0EBNkJAAAAnwIDAYIAAQAKAwEEAAAAQAMCBAAAIEADAwMEAwUDBgMHAwgAIAUBGAAAAAAAAAAAAAAAAQAAAAAAAAAAASEAAAAAAwAAAQIAPqMAAAD/AAYAAAAAAG8BAAAwAQC6AQAAAG8BAgAwAQDyAwAAAG8BBAAwAQCuBQAAAIwBPAAwAQCLBgAAAIwBGgAwAQBDBwAAAIwBCgAwAQCOCAAAAIwBEgAwAQBDCQAAAG8BCgAwAQDbCwAAAIwBfQAwAQBYDAAAAIwBAQAwAQAPDQAAAIwBAQAwAQDcDgAAAG8BDwAwAQABEAAAAG8BEQAwAQCwEgAAAIwBAwAwAQBXEwAAAKkBAAAwAQC3FAAAAIwBAAAwAQC7FQAAAOIBGQDiAiAAMAIB2RgAAAAwAQD4IQAAAMABIgASAAAAMAEAkCMAAACCAAIAJAMJAwoDCwMMAw0DDgMPAxADEQMSAgAAAAAAAPg/AxMDFAMVAxYCmpmZmZmZ2T8DFwJEi2zn+6kKQAMYAxkDGgMbAxwDHQMICAIWFwAAABj/////Ax4DHwMgAyEDIgMjCAMaGwAAABwdAAAAHh8AAAADBwYAAwUBAAEAARgAAAACAAABAAABAAADAAABAAABAAABAAABAAABAAABAAABAAABAAABAAABAAADAAABAAACAgAA/gAIAAAABQEAAAAAAVdXndLS1uheICfC69nzV/InT4qmZZP30w==

-- https://lua.expert/
local t = {
	Name = "Twisted Poppy",
	Rarity = "Common",
	Icon = "rbxassetid://17011493901",
	VisionRadius = 60,
	InstantRadius = 26,
	WalkSpeed = 10,
	RunSpeed = 18,
	InterestTime = 1.5,
	HearingRadius = 125,
	Damage = 1,
	WaitTime = 1,
	LineOfSight = 0.4,
	KillRadius = 3.333,
	HitCooldown = 3,
	ChaseAbility = false,
	AbilityCooldown = 0,
	SpecialAnimatorData = {
		Module = "MonsterModules/SpecialAnimator",
		Config = {
			BlinkTexture = "rbxassetid://119055206267698",
			NormalTexture = "rbxassetid://86450922386911",
			AttackTexture = "rbxassetid://84346243312439"
		}
	}
}

function t.SpecialAnimator(p1) --[[ SpecialAnimator | Line: 32 | Upvalues: t (copy) ]]
	require(game.ReplicatedStorage.MonsterModules.SpecialAnimator).new(p1, t.SpecialAnimatorData.Config)
end

return t