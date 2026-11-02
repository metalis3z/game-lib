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
-- CQMjB3JlcXVpcmUEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQ5Nb25zdGVyTW9kdWxlcw9TcGVjaWFsQW5pbWF0b3IDbmV3E1NwZWNpYWxBbmltYXRvckRhdGEGQ29uZmlnD1R3aXN0ZWQgRmx1dHRlcgROYW1lBFJhcmUGUmFyaXR5GHJieGFzc2V0aWQ6Ly8xODIzOTIyNzQxMARJY29uDFZpc2lvblJhZGl1cw1JbnN0YW50UmFkaXVzCVdhbGtTcGVlZAhSdW5TcGVlZAxJbnRlcmVzdFRpbWUNSGVhcmluZ1JhZGl1cwZEYW1hZ2UIV2FpdFRpbWULTGluZU9mU2lnaHQKS2lsbFJhZGl1cwtIaXRDb29sZG93bgxDaGFzZUFiaWxpdHkPQWJpbGl0eUNvb2xkb3duBk1vZHVsZR5Nb25zdGVyTW9kdWxlcy9TcGVjaWFsQW5pbWF0b3INQXR0YWNrVGV4dHVyZRtyYnhhc3NldGlkOi8vOTUyMjAwNzI3NzE2OTMMQmxpbmtUZXh0dXJlHHJieGFzc2V0aWQ6Ly8xMDkyNzMyNzI0NDEwMTcNTm9ybWFsVGV4dHVyZRxyYnhhc3NldGlkOi8vMTM5MDk4NjcwMjc5MTM3AAIFAQEAAAAVpAEBAAAAAECkAgMAAAAgQE0CAj8EAAAATQICygUAAABNAgKQBgAAAJ8BAgJNAgHvBwAAAFIDAAD7BAAATQQE+AgAAABNBATZCQAAAJ8CAwGCAAEACgMBBAAAAEADAgQAACBAAwMDBAMFAwYDBwMIACQFARgAAAAAAAAAAAAAAAEAAAAAAAAAAAElAAAAAAMAAAECAD6jAAAA/wAGAAAAAABvAQAAMAEAugEAAABvAQIAMAEA8gMAAABvAQQAMAEArgUAAACMAUEAMAEAiwYAAACMAR4AMAEAQwcAAACMARIAMAEAjggAAABvAQkAMAEAQwoAAACMAQIAMAEA2wsAAACMAYcAMAEAWAwAAACMAQEAMAEADw0AAACMAQAAMAEA3A4AAABvAQ8AMAEAARAAAABvAREAMAEAsBIAAACMAQMAMAEAVxMAAACpAQAAMAEAtxQAAACMAQAAMAEAuxUAAADiARkA4gIgADACAdkYAAAAMAEA+CEAAADAASIAEgAAADABAJAjAAAAggACACQDCQMKAwsDDAMNAw4DDwMQAxECAAAAAACAMkADEgMTAxQDFQMWApqZmZmZmdk/AxcCRIts5/upCkADGAMZAxoDGwMcAx0DCAgCFhcAAAAY/////wMeAx8DIAMhAyIDIwgDGhsAAAAcHQAAAB4fAAAAAwcGAAMFAQABAAEYAAAAAgAAAQAAAQAAAwAAAQAAAQAAAQAAAQAAAQAAAwAAAQAAAQAAAQAAAQAAAwAAAQAAAwIAAP4ACQAAAAUBAAAAAAFvGwTrOdJeNTtp/Nnj6OacHwMTn13fbuo=

-- https://lua.expert/
local t = {
	Name = "Twisted Flutter",
	Rarity = "Rare",
	Icon = "rbxassetid://18239227410",
	VisionRadius = 65,
	InstantRadius = 30,
	WalkSpeed = 18,
	RunSpeed = 18.5,
	InterestTime = 2,
	HearingRadius = 135,
	Damage = 1,
	WaitTime = 0,
	LineOfSight = 0.4,
	KillRadius = 3.333,
	HitCooldown = 3,
	ChaseAbility = false,
	AbilityCooldown = 0,
	SpecialAnimatorData = {
		Module = "MonsterModules/SpecialAnimator",
		Config = {
			AttackTexture = "rbxassetid://95220072771693",
			BlinkTexture = "rbxassetid://109273272441017",
			NormalTexture = "rbxassetid://139098670279137"
		}
	}
}

function t.SpecialAnimator(p1) --[[ SpecialAnimator | Line: 36 | Upvalues: t (copy) ]]
	require(game.ReplicatedStorage.MonsterModules.SpecialAnimator).new(p1, t.SpecialAnimatorData.Config)
end

return t