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
-- CQMkB3JlcXVpcmUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQ5Nb25zdGVyTW9kdWxlcw9TcGVjaWFsQW5pbWF0b3IDbmV3E1NwZWNpYWxBbmltYXRvckRhdGEGQ29uZmlnElR3aXN0ZWQgU291bHZlc3RlcgROYW1lCFVuY29tbW9uBlJhcml0eRxyYnhhc3NldGlkOi8vMTEyMzUyODg2Mjk3NjI0BEljb24MVmlzaW9uUmFkaXVzDUluc3RhbnRSYWRpdXMJV2Fsa1NwZWVkCFJ1blNwZWVkDEludGVyZXN0VGltZQ1IZWFyaW5nUmFkaXVzBkRhbWFnZQtMaW5lT2ZTaWdodApLaWxsUmFkaXVzC0hpdENvb2xkb3duB0hvbGlkYXkJSGFsbG93ZWVuCFdhaXRUaW1lEkdlbmVyYXRvcldheXBvaW50cwZNb2R1bGUeTW9uc3Rlck1vZHVsZXMvU3BlY2lhbEFuaW1hdG9yDUF0dGFja1RleHR1cmUbcmJ4YXNzZXRpZDovLzcxMTI0MDE5NDM3MDYzDEJsaW5rVGV4dHVyZRtyYnhhc3NldGlkOi8vNzA5MTc4Njc4ODk5OTINTm9ybWFsVGV4dHVyZRtyYnhhc3NldGlkOi8vNzU5NTY1MDE1NDc3MzQAAgUBAQAAABWkAQEAAAAAQKQCAwAAACBATQICPwQAAABNAgLKBQAAAE0CApAGAAAAnwECAk0CAe8HAAAAUgMAAPsEAABNBAT4CAAAAE0EBNkJAAAAnwIDAYIAAQAKAwEEAAAAQAMCBAAAIEADAwMEAwUDBgMHAwgAJQUBGAAAAAAAAAAAAAAAAQAAAAAAAAAAASYAAAAAAwAAAQIAQaMAAAD/AAYAAAAAAG8BAAAwAQC6AQAAAG8BAgAwAQDyAwAAAG8BBAAwAQCuBQAAAIwBPAAwAQCLBgAAAIwBGgAwAQBDBwAAAIwBCAAwAQCOCAAAAIwBEAAwAQBDCQAAAG8BCgAwAQDbCwAAAIwBfQAwAQBYDAAAAIwBAQAwAQAPDQAAAG8BDgAwAQABDwAAAG8BEAAwAQCwEQAAAIwBAwAwAQBXEgAAAKkBAQAwAQDuEwAAAKkBAQAwAQBpFAAAAIwBCgAwAQDcFQAAAKkBAQAwAQBOFgAAAOIBGgDiAiEAMAIB2RkAAAAwAQD4IgAAAMABIwASAAAAMAEAkCQAAACCAAIAJQMJAwoDCwMMAw0DDgMPAxADEQMSAgAAAAAAAAxAAxMDFAMVApqZmZmZmdk/AxYCpHA9CtejCkADFwMYAxkDGgMbAxwDHQMeAwgIAhcYAAAAGf////8DHwMgAyEDIgMjAyQIAxscAAAAHR4AAAAfIAAAAAMHBgADBQEAAQABGAAAAAIAAAEAAAEAAAIAAAEAAAEAAAEAAAEAAAEAAAIAAAEAAAEAAAEAAAIAAAEAAAIAAAMAAAMCAAD+AAkAAAAFAQAAAAABnp4tPFzTWDt3hUXzdlYKSe6GOkisWkc9

-- https://lua.expert/
local t = {
	Name = "Twisted Soulvester",
	Rarity = "Uncommon",
	Icon = "rbxassetid://112352886297624",
	VisionRadius = 60,
	InstantRadius = 26,
	WalkSpeed = 8,
	RunSpeed = 16,
	InterestTime = 3.5,
	HearingRadius = 125,
	Damage = 1,
	LineOfSight = 0.4,
	KillRadius = 3.33,
	HitCooldown = 3,
	Holiday = true,
	Halloween = true,
	WaitTime = 10,
	GeneratorWaypoints = true,
	SpecialAnimatorData = {
		Module = "MonsterModules/SpecialAnimator",
		Config = {
			AttackTexture = "rbxassetid://71124019437063",
			BlinkTexture = "rbxassetid://70917867889992",
			NormalTexture = "rbxassetid://75956501547734"
		}
	}
}

function t.SpecialAnimator(p1) --[[ SpecialAnimator | Line: 37 | Upvalues: t (copy) ]]
	require(game.ReplicatedStorage.MonsterModules.SpecialAnimator).new(p1, t.SpecialAnimatorData.Config)
end

return t