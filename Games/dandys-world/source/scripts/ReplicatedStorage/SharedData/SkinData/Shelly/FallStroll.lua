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
-- CQMpB3JlcXVpcmULU2hhcmVkVXRpbHMIVW5pdmVyc2UHSXNMb2JieQRIZWFkDFdhaXRGb3JDaGlsZApBdHRhY2htZW50BUNsb25lBlBhcmVudAlBcHBseVNraW4PUGFydGljbGVFbWl0dGVyBEVtaXQKVXNlQWJpbGl0eQRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2ULRmFsbCBTdHJvbGwETmFtZQRDb3N0CkRhbmR5U3RvcmUccmJ4YXNzZXRpZDovLzEzNzgzMjQ0MTc2NzA4MQRXYWxrHHJieGFzc2V0aWQ6Ly8xNDA2Mzc2MTIzMTcxMjAESWRsZRxyYnhhc3NldGlkOi8vMTE4MzQyNzY0Mjk2ODI0B0FiaWxpdHkccmJ4YXNzZXRpZDovLzEzNzQ3NjcwMDU5Nzg2MANSdW4bcmJ4YXNzZXRpZDovLzg0MTcwODk4MTc0ODU3BVF1aXJrHHJieGFzc2V0aWQ6Ly8xMTc4NDg5MzgyMjU4NzMGRGVjb2RlE092ZXJ3cml0ZUFuaW1hdGlvbnMccmJ4YXNzZXRpZDovLzEwNzc5ODA3OTM3NjIzNAZOb3JtYWwccmJ4YXNzZXRpZDovLzEyNTIwMTI4MjU3NjA4NgVCbGluaxtyYnhhc3NldGlkOi8vNzE5MDY1MTk1MDM4MzkESHVydAxGYWNlVGV4dHVyZXMOVVNFX1NLSU5fTU9ERUwAAwcCAQAABwQAAAUCBwcfpAIBAAAAAED7AwAATQMDoAIAAABNAwMZAwAAAJ8CAgK8AwIjBAAAAJ8DAgIOAwEAggABAG8FBQC8AwHTBgAAAJ8DAwJvBQcAvAMD0wYAAACfAwMCvAMDOggAAACfAwICbwYFALwEANMGAAAAnwQDAjAEAyQJAAAAggABAAoDAQQAAABAAwIDAwMEAwUDBgMHAwgDCQAZCgEYAAAAAAAAAAABAAAAAAIAAAAAAAAAAAAAAQAAAAAAAhsAAAAABwEAAAAAEW8DAAC8AQDTAQAAAJ8BAwJvBAIAvAIB0wEAAACfAgMCbwUDALwDAtMBAAAAnwMDAowGAgC8BANWBAAAAJ8EAwGCAAEABQMFAwYDBwMLAwwAIw0BGAAAAAABAAAAAQAAAAEAAAABJAAAAAAEAAABAgBAowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAv8BBAAAAAAAbwIEADACAboFAAAAjAJYAjACASMGAAAAqQIBADACAU4HAAAA/wIEAAAAAABvAwgAMAMCnwkAAABvAwoAMAMCkgsAAABvAwwAMAMC9A0AAABvAw4AMAMCFg8AAABvAxAAMAMCeBEAAABvAxIAMAMC7hMAAAAwAgHpFAAAAP8CAwAAAAAAbwMVADADAhAWAAAAbwMXADADApkYAAAAbwMZADADAsUaAAAAMAIBIRsAAACpAgEAMAIBwhwAAADAAh0AEgAAADACAekeAAAAwAIfADACAbIgAAAAggECACEDDgQAAABAAw8DEAMRAxIDEwMUAxUDFgMXAxgDGQMaAxsDHAMdAx4DHwMgAyEDIgMjAyQDJQMmAycDKAMpBgADCgYBAw0CAAEBAAEYAAAAAAAAAAEAAgAAAQAAAQAAAgABAAABAAABAAABAAABAAABAAD6AAkAAQAAAQAAAQAA/QAGAAACAAAACgAABwEAAAAAAq++mhVcCvZbcbzGHAAK/qPfpo1hnXrwFA==

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

return {
	Name = "Fall Stroll",
	Cost = 600,
	DandyStore = true,
	OverwriteAnimations = {
		Walk = "rbxassetid://137832441767081",
		Idle = "rbxassetid://140637612317120",
		Ability = "rbxassetid://118342764296824",
		Run = "rbxassetid://137476700597860",
		Quirk = "rbxassetid://84170898174857",
		Decode = "rbxassetid://117848938225873"
	},
	FaceTextures = {
		Normal = "rbxassetid://107798079376234",
		Blink = "rbxassetid://125201282576086",
		Hurt = "rbxassetid://71906519503839"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1, p2) --[[ ApplySkin | Line: 25 | Upvalues: ReplicatedStorage (copy) ]]
		if not require(ReplicatedStorage.SharedUtils.Universe):IsLobby() then
			p2:WaitForChild("Head"):WaitForChild("Attachment"):Clone().Parent = p1:WaitForChild("Head")
		end
	end,
	UseAbility = function(p1) --[[ UseAbility | Line: 35 ]]
		p1:WaitForChild("Head"):WaitForChild("Attachment"):WaitForChild("ParticleEmitter"):Emit(2)
	end
}