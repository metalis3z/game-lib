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
-- CQMjB3JlcXVpcmUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQ5Nb25zdGVyTW9kdWxlcw9TcGVjaWFsQW5pbWF0b3IDbmV3E1NwZWNpYWxBbmltYXRvckRhdGEGQ29uZmlnD1R3aXN0ZWQgU2hyaW1wbwROYW1lBkNvbW1vbgZSYXJpdHkYcmJ4YXNzZXRpZDovLzE3NTgzMjU2MTEyBEljb24MVmlzaW9uUmFkaXVzDUluc3RhbnRSYWRpdXMJV2Fsa1NwZWVkCFJ1blNwZWVkDEludGVyZXN0VGltZQ1IZWFyaW5nUmFkaXVzBkRhbWFnZQhXYWl0VGltZQtMaW5lT2ZTaWdodApLaWxsUmFkaXVzC0hpdENvb2xkb3duDENoYXNlQWJpbGl0eQ9BYmlsaXR5Q29vbGRvd24GTW9kdWxlHk1vbnN0ZXJNb2R1bGVzL1NwZWNpYWxBbmltYXRvcg1BdHRhY2tUZXh0dXJlHHJieGFzc2V0aWQ6Ly8xMjk1MjMzNzAzNzA4NzgMQmxpbmtUZXh0dXJlHHJieGFzc2V0aWQ6Ly8xMjE5NDU5NjgwMjgyMjANTm9ybWFsVGV4dHVyZRxyYnhhc3NldGlkOi8vMTI3OTIxNjQ0NzU5OTc4AAIFAQEAAAAVpAEBAAAAAECkAgMAAAAgQE0CAj8EAAAATQICygUAAABNAgKQBgAAAJ8BAgJNAgHvBwAAAFIDAAD7BAAATQQE+AgAAABNBATZCQAAAJ8CAwGCAAEACgMBBAAAAEADAgQAACBAAwMDBAMFAwYDBwMIACMFARgAAAAAAAAAAAAAAAEAAAAAAAAAAAEkAAAAAAMAAAECAD6jAAAA/wAGAAAAAABvAQAAMAEAugEAAABvAQIAMAEA8gMAAABvAQQAMAEArgUAAACMAUYAMAEAiwYAAACMARwAMAEAQwcAAABvAQgAMAEAjgkAAABvAQoAMAEAQwsAAACMAQIAMAEA2wwAAACMAX0AMAEAWA0AAACMAQEAMAEADw4AAACMAQEAMAEA3A8AAABvARAAMAEAAREAAABvARIAMAEAsBMAAACMAQMAMAEAVxQAAACpAQAAMAEAtxUAAACMAQAAMAEAuxYAAADiARoA4gIhADACAdkZAAAAMAEA+CIAAADAASMAEgAAADABAJAkAAAAggACACUDCQMKAwsDDAMNAw4DDwMQAgAAAAAAACNAAxECAAAAAACAMEADEgMTAxQDFQMWApqZmZmZmdk/AxcCpHA9CtejCkADGAMZAxoDGwMcAx0DCAgCFxgAAAAZ/////wMeAx8DIAMhAyIDIwgDGxwAAAAdHgAAAB8gAAAAAwcGAAMFAQABAAEYAAAAAgAAAQAAAQAAAwAAAQAAAQAAAQAAAQAAAQAAAwAAAQAAAQAAAQAAAQAAAwAAAQAAAgIAAP4ACQAAAAUBAAAAAAG5+Z67RaSjmXGQ2plzcOGXyeGJz4s99Lo=

-- https://lua.expert/
local t = {
	Name = "Twisted Shrimpo",
	Rarity = "Common",
	Icon = "rbxassetid://17583256112",
	VisionRadius = 70,
	InstantRadius = 28,
	WalkSpeed = 9.5,
	RunSpeed = 16.5,
	InterestTime = 2,
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
			AttackTexture = "rbxassetid://129523370370878",
			BlinkTexture = "rbxassetid://121945968028220",
			NormalTexture = "rbxassetid://127921644759978"
		}
	}
}

function t.SpecialAnimator(p1) --[[ SpecialAnimator | Line: 35 | Upvalues: t (copy) ]]
	require(game.ReplicatedStorage.MonsterModules.SpecialAnimator).new(p1, t.SpecialAnimatorData.Config)
end

return t