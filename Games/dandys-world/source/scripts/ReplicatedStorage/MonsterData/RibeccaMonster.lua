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
-- CQMlB3JlcXVpcmUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQ5Nb25zdGVyTW9kdWxlcw9TcGVjaWFsQW5pbWF0b3IDbmV3E1NwZWNpYWxBbmltYXRvckRhdGEGQ29uZmlnD1R3aXN0ZWQgUmliZWNjYQROYW1lBkNvbW1vbgZSYXJpdHkccmJ4YXNzZXRpZDovLzEwODk0Mzc0NTk0ODcwMwRJY29uDFZpc2lvblJhZGl1cw1JbnN0YW50UmFkaXVzCVdhbGtTcGVlZAhSdW5TcGVlZAxJbnRlcmVzdFRpbWUNSGVhcmluZ1JhZGl1cwdIb2xpZGF5CUhhbGxvd2VlbgZEYW1hZ2UIV2FpdFRpbWULTGluZU9mU2lnaHQKS2lsbFJhZGl1cwtIaXRDb29sZG93bgxDaGFzZUFiaWxpdHkPQWJpbGl0eUNvb2xkb3duBk1vZHVsZR5Nb25zdGVyTW9kdWxlcy9TcGVjaWFsQW5pbWF0b3INQXR0YWNrVGV4dHVyZRxyYnhhc3NldGlkOi8vMTM4ODI5MTgyNDA0NDk0DEJsaW5rVGV4dHVyZRtyYnhhc3NldGlkOi8vNzkzMTU4MTU2NTA5MTMNTm9ybWFsVGV4dHVyZRtyYnhhc3NldGlkOi8vNzU1MTk3MTMyNzYzNTQAAgUBAQAAABWkAQEAAAAAQKQCAwAAACBATQICPwQAAABNAgLKBQAAAE0CApAGAAAAnwECAk0CAe8HAAAAUgMAAPsEAABNBAT4CAAAAE0EBNkJAAAAnwIDAYIAAQAKAwEEAAAAQAMCBAAAIEADAwMEAwUDBgMHAwgAJgUBGAAAAAAAAAAAAAAAAQAAAAAAAAAAAScAAAAAAwAAAQIARKMAAAD/AAYAAAAAAG8BAAAwAQC6AQAAAG8BAgAwAQDyAwAAAG8BBAAwAQCuBQAAAIwBPAAwAQCLBgAAAIwBGgAwAQBDBwAAAIwBCgAwAQCOCAAAAIwBEgAwAQBDCQAAAG8BCgAwAQDbCwAAAIwBfQAwAQBYDAAAAKkBAQAwAQDuDQAAAKkBAQAwAQBpDgAAAIwBAQAwAQAPDwAAAIwBAQAwAQDcEAAAAG8BEQAwAQABEgAAAG8BEwAwAQCwFAAAAIwBAwAwAQBXFQAAAKkBAAAwAQC3FgAAAIwBAAAwAQC7FwAAAOIBGwDiAiIAMAIB2RoAAAAwAQD4IwAAAMABJAASAAAAMAEAkCUAAACCAAIAJgMJAwoDCwMMAw0DDgMPAxADEQMSAgAAAAAAAPg/AxMDFAMVAxYDFwMYApqZmZmZmdk/AxkCpHA9CtejCkADGgMbAxwDHQMeAx8DCAgCGBkAAAAa/////wMgAyEDIgMjAyQDJQgDHB0AAAAeHwAAACAhAAAAAwcGAAMFAQABAAEYAAAAAgAAAQAAAQAAAwAAAQAAAQAAAQAAAQAAAQAAAgAAAQAAAgAAAQAAAQAAAQAAAQAAAwAAAQAAAwIAAP4ACQAAAAUBAAAAAAFnatx2zhNZ7+Qkdg+pkpNNF3LLAlWutnc=

-- https://lua.expert/
local t = {
	Name = "Twisted Ribecca",
	Rarity = "Common",
	Icon = "rbxassetid://108943745948703",
	VisionRadius = 60,
	InstantRadius = 26,
	WalkSpeed = 10,
	RunSpeed = 18,
	InterestTime = 1.5,
	HearingRadius = 125,
	Holiday = true,
	Halloween = true,
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
			AttackTexture = "rbxassetid://138829182404494",
			BlinkTexture = "rbxassetid://79315815650913",
			NormalTexture = "rbxassetid://75519713276354"
		}
	}
}

function t.SpecialAnimator(p1) --[[ SpecialAnimator | Line: 38 | Upvalues: t (copy) ]]
	require(game.ReplicatedStorage.MonsterModules.SpecialAnimator).new(p1, t.SpecialAnimatorData.Config)
end

return t