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
-- CQMqCUFwcGx5U2tpbgVwYWlycw5HZXREZXNjZW5kYW50cw5Sb3BlQ29uc3RyYWludANJc0EKQnJpY2tDb2xvcgNuZXcKTGlseSB3aGl0ZQVDb2xvcgRCYXNlDFdhaXRGb3JDaGlsZARUYWlsBE1lc2gGTWVzaElkCVRleHR1cmVJRAlUZXh0dXJlSWQKVXNlQWJpbGl0eQ1DcmFmdHkgQ2FsaWNvBE5hbWUEQ29zdApEYW5keVN0b3JlG3JieGFzc2V0aWQ6Ly85ODg1MDY1NDc2NzIyNwdBYmlsaXR5G3JieGFzc2V0aWQ6Ly84MjgxMzA1MjM0MjQwMwNSdW4ccmJ4YXNzZXRpZDovLzEwMzQ2ODQ4NTAxMzcyMgRJZGxlHHJieGFzc2V0aWQ6Ly8xMTc2Mjg0NjA4MDUwMDkEV2FsaxxyYnhhc3NldGlkOi8vMTE1NTM2MDk2NjA3NzY5BkRlY29kZRtyYnhhc3NldGlkOi8vODQ2MzM3Njg1Mjg1MzgFUXVpcmsTT3ZlcndyaXRlQW5pbWF0aW9ucxtyYnhhc3NldGlkOi8vODI0NzYyNjcyMjkxODUFQmxpbmsbcmJ4YXNzZXRpZDovLzc0MTU1NzE1NjE2ODU3BEh1cnQccmJ4YXNzZXRpZDovLzExNzk1NDI2NzQzNjEyNQZOb3JtYWwMRmFjZVRleHR1cmVzDlVTRV9TS0lOX01PREVMAAMBAQAAAAYDAAAFAQcBggABAAAAGAEBGAAqAAAAAAoCAAAABwQAAAUCBwcxpAIBAAAAAEC8AwFHAgAAAJ8DAgCfAgAEFwILAG8JAwC8Bwb+BAAAAJ8HAwIOBwYApAcHAAAYUIBvCAgAnwcCAjAHBqQJAAAAbgL0/wIAAABvBAoAvAIB0wsAAACfAgMCbwQMALwCAtMLAAAAnwIDAm8EDQC8AgLTCwAAAJ8CAwJvBQwAvAMA0wsAAACfAwMCTQMD1Q4AAAAwAwLVDgAAAG8FDAC8AwDTCwAAAJ8DAwJNAwOEDwAAADADAvcQAAAAggABABEDAgQAAABAAwMDBAMFAwYDBwQAGFCAAwgDCQMKAwsDDAMNAw4DDwMQACwRARgAAAAAAAAAAQAAAAABAAAAAAD+AAYAAAAAAAAAAAAAAAIAAAAAAAAAAQAAAAAAAAACLgAAAAADAAABAgA5owAAAP8ABAAAAAAAbwEAADABALoBAAAAjAFYAjABACMCAAAAqQEBADABAE4DAAAA/wEEAAAAAABvAgQAMAIB9AUAAABvAgYAMAIBFgcAAABvAggAMAIBkgkAAABvAgoAMAIBnwsAAABvAgwAMAIB7g0AAABvAg4AMAIBeA8AAAAwAQDpEAAAAP8BAwAAAAAAbwIRADACAZkSAAAAbwITADACAcUUAAAAbwIVADACARAWAAAAMAEAIRcAAACpAQEAMAEAwhgAAADAARkAMAEA6RoAAADAARsAMAEAshwAAACCAAIAHQMSAxMDFAMVAxYDFwMYAxkDGgMbAxwDHQMeAx8DIAMhAyIDIwMkAyUDJgMnAygDKQMqBgADAQYBAxECAAEBAAEYAAAAAgAAAQAAAQAAAgABAAABAAABAAABAAABAAABAAD6AAkAAQAAAQAAAQAA/QAGAAACAAAUAAARAQAAAAACz2oKlC+Ar/t2ZvyVw3y18r9yHeD9rmCV

-- https://lua.expert/
return {
	Name = "Crafty Calico",
	Cost = 600,
	DandyStore = true,
	OverwriteAnimations = {
		Ability = "rbxassetid://98850654767227",
		Run = "rbxassetid://82813052342403",
		Idle = "rbxassetid://103468485013722",
		Walk = "rbxassetid://117628460805009",
		Decode = "rbxassetid://115536096607769",
		Quirk = "rbxassetid://84633768528538"
	},
	FaceTextures = {
		Blink = "rbxassetid://82476267229185",
		Hurt = "rbxassetid://74155715616857",
		Normal = "rbxassetid://117954267436125"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 24 ]] end,
	UseAbility = function(p1, p2) --[[ UseAbility | Line: 44 ]]
		for k, v in pairs(p2:GetDescendants()) do
			if v:IsA("RopeConstraint") then
				v.Color = BrickColor.new("Lily white")
			end
		end

		local Mesh = p2:WaitForChild("Base"):WaitForChild("Tail"):WaitForChild("Mesh")

		Mesh.MeshId = p1:WaitForChild("Tail").MeshId
		Mesh.TextureId = p1:WaitForChild("Tail").TextureID
	end
}