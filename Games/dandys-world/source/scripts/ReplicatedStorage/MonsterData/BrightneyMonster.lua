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
-- CQMjB3JlcXVpcmUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQ5Nb25zdGVyTW9kdWxlcw9TcGVjaWFsQW5pbWF0b3IDbmV3E1NwZWNpYWxBbmltYXRvckRhdGEGQ29uZmlnEVR3aXN0ZWQgQnJpZ2h0bmV5BE5hbWUIVW5jb21tb24GUmFyaXR5GHJieGFzc2V0aWQ6Ly8xNzYzMjM0OTIzMgRJY29uDFZpc2lvblJhZGl1cw1JbnN0YW50UmFkaXVzCVdhbGtTcGVlZAhSdW5TcGVlZAxJbnRlcmVzdFRpbWUNSGVhcmluZ1JhZGl1cwZEYW1hZ2UIV2FpdFRpbWULTGluZU9mU2lnaHQKS2lsbFJhZGl1cwtIaXRDb29sZG93bgxDaGFzZUFiaWxpdHkPQWJpbGl0eUNvb2xkb3duBk1vZHVsZR5Nb25zdGVyTW9kdWxlcy9TcGVjaWFsQW5pbWF0b3IMQmxpbmtUZXh0dXJlG3JieGFzc2V0aWQ6Ly84NzM5MTk0MzU4MTYwMQ1Ob3JtYWxUZXh0dXJlHHJieGFzc2V0aWQ6Ly8xMjkwNjk0NTk3Mjg4MzENQXR0YWNrVGV4dHVyZRxyYnhhc3NldGlkOi8vMTEzNjQyNzk4NjMzMDkzAAIFAQEAAAAVpAEBAAAAAECkAgMAAAAgQE0CAj8EAAAATQICygUAAABNAgKQBgAAAJ8BAgJNAgHvBwAAAFIDAAD7BAAATQQE+AgAAABNBATZCQAAAJ8CAwGCAAEACgMBBAAAAEADAgQAACBAAwMDBAMFAwYDBwMIACMFARgAAAAAAAAAAAAAAAEAAAAAAAAAAAEkAAAAAAMAAAECAD6jAAAA/wAGAAAAAABvAQAAMAEAugEAAABvAQIAMAEA8gMAAABvAQQAMAEArgUAAACMAUEAMAEAiwYAAACMARoAMAEAQwcAAACMAQwAMAEAjggAAACMARIAMAEAQwkAAACMAQIAMAEA2woAAACMAZYAMAEAWAsAAACMAQEAMAEADwwAAACMAQEAMAEA3A0AAABvAQ4AMAEAAQ8AAABvARAAMAEAsBEAAACMAQMAMAEAVxIAAACpAQAAMAEAtxMAAACMAQAAMAEAuxQAAADiARgA4gIfADACAdkXAAAAMAEA+CAAAADAASEAEgAAADABAJAiAAAAggACACMDCQMKAwsDDAMNAw4DDwMQAxEDEgMTAxQDFQMWApqZmZmZmdk/AxcCZmZmZmZmCkADGAMZAxoDGwMcAx0DCAgCFRYAAAAX/////wMeAx8DIAMhAyIDIwgDGRoAAAAbHAAAAB0eAAAAAwcGAAMFAQABAAEYAAAAAgAAAQAAAQAAAwAAAQAAAQAAAQAAAQAAAQAAAwAAAQAAAQAAAQAAAQAAAwAAAQAAAgIAAP4ACQAAAAUBAAAAAAHx59cdaLKo6hlsWSne4vaegf/AacMjvRw=

-- https://lua.expert/
local t = {
	Name = "Twisted Brightney",
	Rarity = "Uncommon",
	Icon = "rbxassetid://17632349232",
	VisionRadius = 65,
	InstantRadius = 26,
	WalkSpeed = 12,
	RunSpeed = 18,
	InterestTime = 2,
	HearingRadius = 150,
	Damage = 1,
	WaitTime = 1,
	LineOfSight = 0.4,
	KillRadius = 3.3,
	HitCooldown = 3,
	ChaseAbility = false,
	AbilityCooldown = 0,
	SpecialAnimatorData = {
		Module = "MonsterModules/SpecialAnimator",
		Config = {
			BlinkTexture = "rbxassetid://87391943581601",
			NormalTexture = "rbxassetid://129069459728831",
			AttackTexture = "rbxassetid://113642798633093"
		}
	}
}

function t.SpecialAnimator(p1) --[[ SpecialAnimator | Line: 35 | Upvalues: t (copy) ]]
	require(game.ReplicatedStorage.MonsterModules.SpecialAnimator).new(p1, t.SpecialAnimatorData.Config)
end

return t