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
-- CQMjB3JlcXVpcmUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQ5Nb25zdGVyTW9kdWxlcw9TcGVjaWFsQW5pbWF0b3IDbmV3E1NwZWNpYWxBbmltYXRvckRhdGEGQ29uZmlnDVR3aXN0ZWQgVGlzaGEETmFtZQZDb21tb24GUmFyaXR5GHJieGFzc2V0aWQ6Ly8xODE2Mjg4NjIxMQRJY29uDFZpc2lvblJhZGl1cw1JbnN0YW50UmFkaXVzCVdhbGtTcGVlZAhSdW5TcGVlZAxJbnRlcmVzdFRpbWUNSGVhcmluZ1JhZGl1cwtMaW5lT2ZTaWdodAZEYW1hZ2UKS2lsbFJhZGl1cwtIaXRDb29sZG93bgxDaGFzZUFiaWxpdHkPQWJpbGl0eUNvb2xkb3duCFdhaXRUaW1lBk1vZHVsZR5Nb25zdGVyTW9kdWxlcy9TcGVjaWFsQW5pbWF0b3IMQmxpbmtUZXh0dXJlHHJieGFzc2V0aWQ6Ly8xMDExOTg0OTkyNjI5MzMNTm9ybWFsVGV4dHVyZRxyYnhhc3NldGlkOi8vMTIxNTMyOTkyNjcxNjA4DUF0dGFja1RleHR1cmUccmJ4YXNzZXRpZDovLzEwNzY2MzA4NDg4MjUxMgACBQEBAAAAFaQBAQAAAABApAIDAAAAIEBNAgI/BAAAAE0CAsoFAAAATQICkAYAAACfAQICTQIB7wcAAABSAwAA+wQAAE0EBPgIAAAATQQE2QkAAACfAgMBggABAAoDAQQAAABAAwIEAAAgQAMDAwQDBQMGAwcDCAAnBQEYAAAAAAAAAAAAAAABAAAAAAAAAAABKAAAAAADAAABAgA+owAAAP8ABgAAAAAAbwEAADABALoBAAAAbwECADABAPIDAAAAbwEEADABAK4FAAAAjAE8ADABAIsGAAAAjAEaADABAEMHAAAAjAEKADABAI4IAAAAjAESADABAEMJAAAAbwEKADABANsLAAAAjAF9ADABAFgMAAAAbwENADABAAEOAAAAjAEBADABAA8PAAAAbwEQADABALARAAAAjAEDADABAFcSAAAAqQEAADABALcTAAAAjAEAADABALsUAAAAjAEKADABANwVAAAA4gEZAOICIAAwAgHZGAAAADABAPghAAAAwAEiABIAAAAwAQCQIwAAAIIAAgAkAwkDCgMLAwwDDQMOAw8DEAMRAxICAAAAAAAA+D8DEwMUApqZmZmZmdk/AxUDFgKkcD0K16MKQAMXAxgDGQMaAxsDHAMdAwgIAhYXAAAAGP////8DHgMfAyADIQMiAyMIAxobAAAAHB0AAAAeHwAAAAMHBgADBQEAAQABGAAAAAIAAAEAAAEAAAMAAAEAAAEAAAEAAAEAAAMAAAEAAAMAAAEAAAEAAAMAAAEAAAMAAAICAAD+AAkAAAAFAQAAAAABJFddnz9rswFyoarLN7NT/FRPSusWkzee

-- https://lua.expert/
local t = {
	Name = "Twisted Tisha",
	Rarity = "Common",
	Icon = "rbxassetid://18162886211",
	VisionRadius = 60,
	InstantRadius = 26,
	WalkSpeed = 10,
	RunSpeed = 18,
	InterestTime = 1.5,
	HearingRadius = 125,
	LineOfSight = 0.4,
	Damage = 1,
	KillRadius = 3.33,
	HitCooldown = 3,
	ChaseAbility = false,
	AbilityCooldown = 0,
	WaitTime = 10,
	SpecialAnimatorData = {
		Module = "MonsterModules/SpecialAnimator",
		Config = {
			BlinkTexture = "rbxassetid://101198499262933",
			NormalTexture = "rbxassetid://121532992671608",
			AttackTexture = "rbxassetid://107663084882512"
		}
	}
}

function t.SpecialAnimator(p1) --[[ SpecialAnimator | Line: 39 | Upvalues: t (copy) ]]
	require(game.ReplicatedStorage.MonsterModules.SpecialAnimator).new(p1, t.SpecialAnimatorData.Config)
end

return t