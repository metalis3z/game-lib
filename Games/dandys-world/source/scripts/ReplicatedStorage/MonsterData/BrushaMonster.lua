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
-- CQMjB3JlcXVpcmUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQ5Nb25zdGVyTW9kdWxlcw9TcGVjaWFsQW5pbWF0b3IDbmV3E1NwZWNpYWxBbmltYXRvckRhdGEGQ29uZmlnDlR3aXN0ZWQgQnJ1c2hhBE5hbWUGQ29tbW9uBlJhcml0eRxyYnhhc3NldGlkOi8vMTIxMzYxNTQxODk4OTcxBEljb24MVmlzaW9uUmFkaXVzDUluc3RhbnRSYWRpdXMJV2Fsa1NwZWVkCFJ1blNwZWVkDEludGVyZXN0VGltZQ1IZWFyaW5nUmFkaXVzBkRhbWFnZQhXYWl0VGltZQtMaW5lT2ZTaWdodApLaWxsUmFkaXVzC0hpdENvb2xkb3duDENoYXNlQWJpbGl0eQ9BYmlsaXR5Q29vbGRvd24GTW9kdWxlHk1vbnN0ZXJNb2R1bGVzL1NwZWNpYWxBbmltYXRvcgxCbGlua1RleHR1cmUbcmJ4YXNzZXRpZDovLzc0MTU3Njg0OTAzODE3DU5vcm1hbFRleHR1cmUccmJ4YXNzZXRpZDovLzExMTY0OTM0MzYwNzk5Nw1BdHRhY2tUZXh0dXJlG3JieGFzc2V0aWQ6Ly84Nzc4NzM4NzQ3MzE3OAACBQEBAAAAFaQBAQAAAABApAIDAAAAIEBNAgI/BAAAAE0CAsoFAAAATQICkAYAAACfAQICTQIB7wcAAABSAwAA+wQAAE0EBPgIAAAATQQE2QkAAACfAgMBggABAAoDAQQAAABAAwIEAAAgQAMDAwQDBQMGAwcDCAAgBQEYAAAAAAAAAAAAAAABAAAAAAAAAAABIQAAAAADAAABAgA+owAAAP8ABgAAAAAAbwEAADABALoBAAAAbwECADABAPIDAAAAbwEEADABAK4FAAAAjAFkADABAIsGAAAAjAEaADABAEMHAAAAjAEKADABAI4IAAAAjAESADABAEMJAAAAbwEKADABANsLAAAAjAF9ADABAFgMAAAAjAEBADABAA8NAAAAjAEBADABANwOAAAAbwEPADABAAEQAAAAbwERADABALASAAAAjAEDADABAFcTAAAAqQEAADABALcUAAAAjAEAADABALsVAAAA4gEZAOICIAAwAgHZGAAAADABAPghAAAAwAEiABIAAAAwAQCQIwAAAIIAAgAkAwkDCgMLAwwDDQMOAw8DEAMRAxICAAAAAAAA+D8DEwMUAxUDFgKamZmZmZnZPwMXAkSLbOf7qQpAAxgDGQMaAxsDHAMdAwgIAhYXAAAAGP////8DHgMfAyADIQMiAyMIAxobAAAAHB0AAAAeHwAAAAMHBgADBQEAAQABGAAAAAIAAAEAAAEAAAMAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAMAAAEAAAICAAD+AAgAAAAFAQAAAAAB0/lwijaPNr2XPevZAgwfdqPhZ/7hPRqL

-- https://lua.expert/
local t = {
	Name = "Twisted Brusha",
	Rarity = "Common",
	Icon = "rbxassetid://121361541898971",
	VisionRadius = 100,
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
			BlinkTexture = "rbxassetid://74157684903817",
			NormalTexture = "rbxassetid://111649343607997",
			AttackTexture = "rbxassetid://87787387473178"
		}
	}
}

function t.SpecialAnimator(p1) --[[ SpecialAnimator | Line: 32 | Upvalues: t (copy) ]]
	require(game.ReplicatedStorage.MonsterModules.SpecialAnimator).new(p1, t.SpecialAnimatorData.Config)
end

return t