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
-- CQMVDlR3aXN0ZWQgUm9kZ2VyBE5hbWUIVW5jb21tb24GUmFyaXR5GHJieGFzc2V0aWQ6Ly8xNzEwNTkyNTQxNwRJY29uDFZpc2lvblJhZGl1cw1JbnN0YW50UmFkaXVzCVdhbGtTcGVlZAhSdW5TcGVlZAxJbnRlcmVzdFRpbWUNSGVhcmluZ1JhZGl1cwZEYW1hZ2UIV2FpdFRpbWULTGluZU9mU2lnaHQKS2lsbFJhZGl1cwtIaXRDb29sZG93bgdOb0NoYXNlClJldHVyblRpbWUMQ2hhc2VBYmlsaXR5D0FiaWxpdHlDb29sZG93bgABAgAAAQIAO6MAAAD/AAYAAAAAAG8BAAAwAQC6AQAAAG8BAgAwAQDyAwAAAG8BBAAwAQCuBQAAAIwBPAAwAQCLBgAAAIwBHgAwAQBDBwAAAIwBCgAwAQCOCAAAAIwBEgAwAQBDCQAAAIwBAQAwAQDbCgAAAIwBfQAwAQBYCwAAAIwBAQAwAQAPDAAAAIwBAQAwAQDcDQAAAG8BDgAwAQABDwAAAE0BAEMHAAAAMAEAsBAAAACMAQIAMAEAVxEAAACpAQEAMAEAlhIAAACMAQ8AMAEA2BMAAACpAQAAMAEAtxQAAACMAQAAMAEAuxUAAACCAAIAFgMBAwIDAwMEAwUDBgMHAwgDCQMKAwsDDAMNAw4CmpmZmZmZ2T8DDwMQAxEDEgMTAxQDFQABAAEYAAAAAgAAAQAAAQAAAwAAAQAAAQAAAQAAAQAAAQAAAwAAAQAAAQAAAQAAAAEAAAMAAAEAAAEAAAEAAAIBAAAAAADjON6FpubImnXNV3H0Eb/nkyDJ8dH8tIQ=

-- https://lua.expert/
local t = {
	Name = "Twisted Rodger",
	Rarity = "Uncommon",
	Icon = "rbxassetid://17105925417",
	VisionRadius = 60,
	InstantRadius = 30,
	WalkSpeed = 10,
	RunSpeed = 18,
	InterestTime = 1,
	HearingRadius = 125,
	Damage = 1,
	WaitTime = 1,
	LineOfSight = 0.4
}

t.KillRadius = t.InstantRadius
t.HitCooldown = 2
t.NoChase = true
t.ReturnTime = 15
t.ChaseAbility = false
t.AbilityCooldown = 0

return t