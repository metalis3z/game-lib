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
-- CQMqCUFwcGx5U2tpbgVwYWlycw5HZXREZXNjZW5kYW50cw5Sb3BlQ29uc3RyYWludANJc0EKQnJpY2tDb2xvcgNuZXcKTGlseSB3aGl0ZQVDb2xvcgRCYXNlDFdhaXRGb3JDaGlsZARUYWlsBE1lc2gGTWVzaElkCVRleHR1cmVJRAlUZXh0dXJlSWQKVXNlQWJpbGl0eQxQYXN0ZWwgUGFwZXIETmFtZQRDb3N0CkRhbmR5U3RvcmUccmJ4YXNzZXRpZDovLzEyNjM0MDc2MTU0ODcwNwNSdW4ccmJ4YXNzZXRpZDovLzEzNDA4NTEyMDk2MTIwOARXYWxrHHJieGFzc2V0aWQ6Ly8xMjk1Nzg0MTg2MzE5OTYESWRsZRxyYnhhc3NldGlkOi8vMTA3MzMyMzkzNDI5NjUwBVF1aXJrG3JieGFzc2V0aWQ6Ly85MjQwMTkwNTA4ODg5MgZEZWNvZGUbcmJ4YXNzZXRpZDovLzg3OTIwNjM4MDA0MjIwB0FiaWxpdHkTT3ZlcndyaXRlQW5pbWF0aW9ucxtyYnhhc3NldGlkOi8vNzM5NTgwNjYxNzk0MTIGTm9ybWFsHHJieGFzc2V0aWQ6Ly8xMzIzNjkyMzQxNzA4NjAFQmxpbmsbcmJ4YXNzZXRpZDovLzk2OTUxNjI2NTU1NTYwBEh1cnQMRmFjZVRleHR1cmVzDlVTRV9TS0lOX01PREVMAAMBAQAAAAYDAAAFAQcBggABAAAAGAEBGAAqAAAAAAoCAAAABwQAAAUCBwcxpAIBAAAAAEC8AwFHAgAAAJ8DAgCfAgAEFwILAG8JAwC8Bwb+BAAAAJ8HAwIOBwYApAcHAAAYUIBvCAgAnwcCAjAHBqQJAAAAbgL0/wIAAABvBAoAvAIB0wsAAACfAgMCbwQMALwCAtMLAAAAnwIDAm8EDQC8AgLTCwAAAJ8CAwJvBQwAvAMA0wsAAACfAwMCTQMD1Q4AAAAwAwLVDgAAAG8FDAC8AwDTCwAAAJ8DAwJNAwOEDwAAADADAvcQAAAAggABABEDAgQAAABAAwMDBAMFAwYDBwQAGFCAAwgDCQMKAwsDDAMNAw4DDwMQACwRARgAAAAAAAAAAQAAAAABAAAAAAD+AAYAAAAAAAAAAAAAAAIAAAAAAAAAAQAAAAAAAAACLgAAAAADAAABAgA5owAAAP8ABAAAAAAAbwEAADABALoBAAAAjAFYAjABACMCAAAAqQEBADABAE4DAAAA/wEEAAAAAABvAgQAMAIBFgUAAABvAgYAMAIBnwcAAABvAggAMAIBkgkAAABvAgoAMAIBeAsAAABvAgwAMAIB7g0AAABvAg4AMAIB9A8AAAAwAQDpEAAAAP8BAwAAAAAAbwIRADACARASAAAAbwITADACAZkUAAAAbwIVADACAcUWAAAAMAEAIRcAAACpAQEAMAEAwhgAAADAARkAMAEA6RoAAADAARsAMAEAshwAAACCAAIAHQMSAxMDFAMVAxYDFwMYAxkDGgMbAxwDHQMeAx8DIAMhAyIDIwMkAyUDJgMnAygDKQMqBgADAQYBAxECAAEBAAEYAAAAAgAAAQAAAQAAAgABAAABAAABAAABAAABAAABAAD6AAkAAQAAAQAAAQAA/QAGAAACAAAUAAAQAQAAAAACB3WPwIxxT4BO7/dcAHbzGHdtmLQ1seXB

-- https://lua.expert/
return {
	Name = "Pastel Paper",
	Cost = 600,
	DandyStore = true,
	OverwriteAnimations = {
		Run = "rbxassetid://126340761548707",
		Walk = "rbxassetid://134085120961208",
		Idle = "rbxassetid://129578418631996",
		Quirk = "rbxassetid://107332393429650",
		Decode = "rbxassetid://92401905088892",
		Ability = "rbxassetid://87920638004220"
	},
	FaceTextures = {
		Normal = "rbxassetid://73958066179412",
		Blink = "rbxassetid://132369234170860",
		Hurt = "rbxassetid://96951626555560"
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