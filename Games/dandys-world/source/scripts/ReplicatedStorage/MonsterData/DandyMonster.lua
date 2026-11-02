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
-- CQMmB3JlcXVpcmUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQ5Nb25zdGVyTW9kdWxlcw9TcGVjaWFsQW5pbWF0b3IDbmV3E1NwZWNpYWxBbmltYXRvckRhdGEGQ29uZmlnDVR3aXN0ZWQgRGFuZHkETmFtZQZMZXRoYWwGUmFyaXR5GHJieGFzc2V0aWQ6Ly8xNzUxNTA3Mzg4MgRJY29uDFZpc2lvblJhZGl1cw1JbnN0YW50UmFkaXVzCVdhbGtTcGVlZAhSdW5TcGVlZAxJbnRlcmVzdFRpbWUNSGVhcmluZ1JhZGl1cwZEYW1hZ2UIV2FpdFRpbWULTGluZU9mU2lnaHQKS2lsbFJhZGl1cwtIaXRDb29sZG93bgxDaGFzZUFiaWxpdHkPQWJpbGl0eUNvb2xkb3duEE5vVGFyZ2V0T3ZlcnJpZGULR3VhcmRzVGFwZXMPVGFwZUd1YXJkUmFkaXVzBk1vZHVsZR5Nb25zdGVyTW9kdWxlcy9TcGVjaWFsQW5pbWF0b3IMQmxpbmtUZXh0dXJlG3JieGFzc2V0aWQ6Ly84MTEyNTcyMDc1NTA3OA1Ob3JtYWxUZXh0dXJlG3JieGFzc2V0aWQ6Ly85NTIzMzgwOTYzMjg0MA1BdHRhY2tUZXh0dXJlHHJieGFzc2V0aWQ6Ly8xMzQ1MDkxMjMwMTEzODAAAgUBAQAAABWkAQEAAAAAQKQCAwAAACBATQICPwQAAABNAgLKBQAAAE0CApAGAAAAnwECAk0CAe8HAAAAUgMAAPsEAABNBAT4CAAAAE0EBNkJAAAAnwIDAYIAAQAKAwEEAAAAQAMCBAAAIEADAwMEAwUDBgMHAwgAJwUBGAAAAAAAAAAAAAAAAQAAAAAAAAAAASgAAAAAAwAAAQIAR6MAAAD/AAYAAAAAAG8BAAAwAQC6AQAAAG8BAgAwAQDyAwAAAG8BBAAwAQCuBQAAAIwBUAAwAQCLBgAAAIwBIwAwAQBDBwAAAIwBCQAwAQCOCAAAAIwBEAAwAQBDCQAAAIwBBQAwAQDbCgAAAIwBDycwAQBYCwAAAIwBYwAwAQAPDAAAAIwBAwAwAQDcDQAAAG8BDgAwAQABDwAAAG8BEAAwAQCwEQAAAIwBBQAwAQBXEgAAAKkBAAAwAQC3EwAAAIwBAAAwAQC7FAAAAKkBAQAwAQC4FQAAAKkBAAAwAQCVFgAAAIwBPAAwAQBrFwAAAOIBGwDiAiIAMAIB2RoAAAAwAQD4IwAAAMABJAASAAAAMAEAkCUAAACCAAIAJgMJAwoDCwMMAw0DDgMPAxADEQMSAxMDFAMVAxYCmpmZmZmZ2T8DFwIAAAAAAAAhQAMYAxkDGgMbAxwDHQMeAx8DIAMICAIYGQAAABr/////AyEDIgMjAyQDJQMmCAMcHQAAAB4fAAAAICEAAAADBwYAAwUBAAEAARgAAAACAAABAAABAAADAAABAAABAAABAAABAAABAAABAAABAAABAAABAAABAAADAAABAAADAAAEAAABAAABAgAA/gAIAAAABQEAAAAAAX9MMB5fgB1iDNT9viioutsPVCdqTYhaHw==

-- https://lua.expert/
local t = {
	Name = "Twisted Dandy",
	Rarity = "Lethal",
	Icon = "rbxassetid://17515073882",
	VisionRadius = 80,
	InstantRadius = 35,
	WalkSpeed = 9,
	RunSpeed = 16,
	InterestTime = 5,
	HearingRadius = 9999,
	Damage = 99,
	WaitTime = 3,
	LineOfSight = 0.4,
	KillRadius = 8.5,
	HitCooldown = 5,
	ChaseAbility = false,
	AbilityCooldown = 0,
	NoTargetOverride = true,
	GuardsTapes = false,
	TapeGuardRadius = 60,
	SpecialAnimatorData = {
		Module = "MonsterModules/SpecialAnimator",
		Config = {
			BlinkTexture = "rbxassetid://81125720755078",
			NormalTexture = "rbxassetid://95233809632840",
			AttackTexture = "rbxassetid://134509123011380"
		}
	}
}

function t.SpecialAnimator(p1) --[[ SpecialAnimator | Line: 39 | Upvalues: t (copy) ]]
	require(game.ReplicatedStorage.MonsterModules.SpecialAnimator).new(p1, t.SpecialAnimatorData.Config)
end

return t