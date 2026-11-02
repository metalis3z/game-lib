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
-- CQMlB3JlcXVpcmUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQ5Nb25zdGVyTW9kdWxlcw9TcGVjaWFsQW5pbWF0b3IDbmV3E1NwZWNpYWxBbmltYXRvckRhdGEGQ29uZmlnF1R3aXN0ZWQgUmF6emxlICYgRGF6emxlBE5hbWUIVW5jb21tb24GUmFyaXR5GHJieGFzc2V0aWQ6Ly8xNzY0MDQ5MDE2NgRJY29uDFZpc2lvblJhZGl1cw1JbnN0YW50UmFkaXVzCVdhbGtTcGVlZAhSdW5TcGVlZAxJbnRlcmVzdFRpbWUNSGVhcmluZ1JhZGl1cwZEYW1hZ2UIV2FpdFRpbWULTGluZU9mU2lnaHQKS2lsbFJhZGl1cwtIaXRDb29sZG93bgxDaGFzZUFiaWxpdHkPQWJpbGl0eUNvb2xkb3duB05vQ2hhc2UKUmV0dXJuVGltZQZNb2R1bGUeTW9uc3Rlck1vZHVsZXMvU3BlY2lhbEFuaW1hdG9yDEJsaW5rVGV4dHVyZRxyYnhhc3NldGlkOi8vMTEwOTc1NjY1NDIyMzA1DU5vcm1hbFRleHR1cmUbcmJ4YXNzZXRpZDovLzk3NTk5MjAzNTYxOTQ0DUF0dGFja1RleHR1cmUccmJ4YXNzZXRpZDovLzEwNjE5MDA1NTc3Mzc4MgACBQEBAAAAFaQBAQAAAABApAIDAAAAIEBNAgI/BAAAAE0CAsoFAAAATQICkAYAAACfAQICTQIB7wcAAABSAwAA+wQAAE0EBPgIAAAATQQE2QkAAACfAgMBggABAAoDAQQAAABAAwIEAAAgQAMDAwQDBQMGAwcDCAAmBQEYAAAAAAAAAAAAAAABAAAAAAAAAAABJwAAAAADAAABAgBFowAAAP8ABgAAAAAAbwEAADABALoBAAAAbwECADABAPIDAAAAbwEEADABAK4FAAAAjAE8ADABAIsGAAAAjAEoADABAEMHAAAAjAEKADABAI4IAAAAjAESADABAEMJAAAAbwEKADABANsLAAAAjAF9ADABAFgMAAAAjAEBADABAA8NAAAAjAEBADABANwOAAAAbwEPADABAAEQAAAATQEAQwcAAAAwAQCwEQAAAIwBAgAwAQBXEgAAAKkBAAAwAQC3EwAAAMYBAAAwAQC7FAAAAKkBAQAwAQCWFQAAAIwBDwAwAQDYFgAAAOIBGgDiAiEAMAIB2RkAAAAwAQD4IgAAAMABIwASAAAAMAEAkCQAAACCAAIAJQMJAwoDCwMMAw0DDgMPAxADEQMSAgAAAAAAAOA/AxMDFAMVAxYCmpmZmZmZ2T8DFwMYAxkDGgMbAxwDHQMeAx8DCAgCFxgAAAAZ/////wMgAyEDIgMjAyQDJQgDGxwAAAAdHgAAAB8gAAAAAwcGAAMFAQABAAEYAAAAAgAAAQAAAQAAAwAAAQAAAQAAAQAAAQAAAQAAAwAAAQAAAQAAAQAAAAEAAAMAAAEAAAMAAAEAAAICAAD+AAgAAAAGAQAAAAABnCYIeYGvg0v02qBEKIXeAuw+Hw2u4mJ4

-- https://lua.expert/
local t = {
	Name = "Twisted Razzle & Dazzle",
	Rarity = "Uncommon",
	Icon = "rbxassetid://17640490166",
	VisionRadius = 60,
	InstantRadius = 40,
	WalkSpeed = 10,
	RunSpeed = 18,
	InterestTime = 0.5,
	HearingRadius = 125,
	Damage = 1,
	WaitTime = 1,
	LineOfSight = 0.4
}

t.KillRadius = t.InstantRadius
t.HitCooldown = 2
t.ChaseAbility = false
t.AbilityCooldown = nil
t.NoChase = true
t.ReturnTime = 15
t.SpecialAnimatorData = {
	Module = "MonsterModules/SpecialAnimator",
	Config = {
		BlinkTexture = "rbxassetid://110975665422305",
		NormalTexture = "rbxassetid://97599203561944",
		AttackTexture = "rbxassetid://106190055773782"
	}
}
function t.SpecialAnimator(p1) --[[ SpecialAnimator | Line: 38 | Upvalues: t (copy) ]]
	require(game.ReplicatedStorage.MonsterModules.SpecialAnimator).new(p1, t.SpecialAnimatorData.Config)
end

return t