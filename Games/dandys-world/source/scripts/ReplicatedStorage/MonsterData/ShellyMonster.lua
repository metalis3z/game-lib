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
-- CQMjB3JlcXVpcmUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQ5Nb25zdGVyTW9kdWxlcw9TcGVjaWFsQW5pbWF0b3IDbmV3E1NwZWNpYWxBbmltYXRvckRhdGEGQ29uZmlnDlR3aXN0ZWQgU2hlbGx5BE5hbWUNTWFpbkNoYXJhY3RlcgZSYXJpdHkYcmJ4YXNzZXRpZDovLzE4MjExNjU3NTUyBEljb24MVmlzaW9uUmFkaXVzDUluc3RhbnRSYWRpdXMJV2Fsa1NwZWVkCFJ1blNwZWVkDEludGVyZXN0VGltZQ1IZWFyaW5nUmFkaXVzBkRhbWFnZQhXYWl0VGltZQtMaW5lT2ZTaWdodApLaWxsUmFkaXVzC0hpdENvb2xkb3duDENoYXNlQWJpbGl0eQ9BYmlsaXR5Q29vbGRvd24GTW9kdWxlHk1vbnN0ZXJNb2R1bGVzL1NwZWNpYWxBbmltYXRvcgxCbGlua1RleHR1cmUbcmJ4YXNzZXRpZDovLzg0NzQzOTk2NDE4NzM4DU5vcm1hbFRleHR1cmUccmJ4YXNzZXRpZDovLzEzNTkwMjI3MDkyOTAzMw1BdHRhY2tUZXh0dXJlG3JieGFzc2V0aWQ6Ly83OTg1NTQxNDM0NDg1MQACBQEBAAAAFaQBAQAAAABApAIDAAAAIEBNAgI/BAAAAE0CAsoFAAAATQICkAYAAACfAQICTQIB7wcAAABSAwAA+wQAAE0EBPgIAAAATQQE2QkAAACfAgMBggABAAoDAQQAAABAAwIEAAAgQAMDAwQDBQMGAwcDCAAiBQEYAAAAAAAAAAAAAAABAAAAAAAAAAABIwAAAAADAAABAgA+owAAAP8ABgAAAAAAbwEAADABALoBAAAAbwECADABAPIDAAAAbwEEADABAK4FAAAAjAE8ADABAIsGAAAAjAEeADABAEMHAAAAjAEKADABAI4IAAAAjAEUADABAEMJAAAAjAECADABANsKAAAAjAGWADABAFgLAAAAjAEBADABAA8MAAAAjAEBADABANwNAAAAbwEOADABAAEPAAAAjAEEADABALAQAAAAjAECADABAFcRAAAAqQEAADABALcSAAAAjAEAADABALsTAAAA4gEXAOICHgAwAgHZFgAAADABAPgfAAAAwAEgABIAAAAwAQCQIQAAAIIAAgAiAwkDCgMLAwwDDQMOAw8DEAMRAxIDEwMUAxUDFgKamZmZmZnZPwMXAxgDGQMaAxsDHAMdAwgIAhQVAAAAFv////8DHgMfAyADIQMiAyMIAxgZAAAAGhsAAAAcHQAAAAMHBgADBQEAAQABGAAAAAIAAAEAAAEAAAMAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAMAAAEAAAMCAAD+AAkAAAAGAQAAAAABA1T1KpVHyZCuOCWHkZLyhXNM4l4xkJ8r

-- https://lua.expert/
local t = {
	Name = "Twisted Shelly",
	Rarity = "MainCharacter",
	Icon = "rbxassetid://18211657552",
	VisionRadius = 60,
	InstantRadius = 30,
	WalkSpeed = 10,
	RunSpeed = 20,
	InterestTime = 2,
	HearingRadius = 150,
	Damage = 1,
	WaitTime = 1,
	LineOfSight = 0.4,
	KillRadius = 4,
	HitCooldown = 2,
	ChaseAbility = false,
	AbilityCooldown = 0,
	SpecialAnimatorData = {
		Module = "MonsterModules/SpecialAnimator",
		Config = {
			BlinkTexture = "rbxassetid://84743996418738",
			NormalTexture = "rbxassetid://135902270929033",
			AttackTexture = "rbxassetid://79855414344851"
		}
	}
}

function t.SpecialAnimator(p1) --[[ SpecialAnimator | Line: 34 | Upvalues: t (copy) ]]
	require(game.ReplicatedStorage.MonsterModules.SpecialAnimator).new(p1, t.SpecialAnimatorData.Config)
end

return t