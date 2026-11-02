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
-- CQMqCUFwcGx5U2tpbgVwYWlycw5HZXREZXNjZW5kYW50cw5Sb3BlQ29uc3RyYWludANJc0EKQnJpY2tDb2xvcgNuZXcKTGlseSB3aGl0ZQVDb2xvcgRCYXNlDFdhaXRGb3JDaGlsZARUYWlsBE1lc2gGTWVzaElkCVRleHR1cmVJRAlUZXh0dXJlSWQKVXNlQWJpbGl0eQ9SYWluYm93IFNoZXJiZXQETmFtZQRDb3N0CkRhbmR5U3RvcmUccmJ4YXNzZXRpZDovLzExMjExMTAyMjA5MzA5MQNSdW4ccmJ4YXNzZXRpZDovLzEwMzEwNTQ3NDAxOTA5MwRXYWxrHHJieGFzc2V0aWQ6Ly8xMzQyNzI1NDg2MzUyMzIESWRsZRxyYnhhc3NldGlkOi8vMTI4ODMwOTkyNDYxMDAzBVF1aXJrG3JieGFzc2V0aWQ6Ly83Njg4NjgzNDM2OTQ2MgZEZWNvZGUbcmJ4YXNzZXRpZDovLzgxOTg2NDg3MDQ0NDg1B0FiaWxpdHkTT3ZlcndyaXRlQW5pbWF0aW9ucxxyYnhhc3NldGlkOi8vMTM4ODk0ODU4NDY1MzQ2Bk5vcm1hbBxyYnhhc3NldGlkOi8vMTAwMTM1MDIyMTI3NDcxBUJsaW5rHHJieGFzc2V0aWQ6Ly8xMTkzMzk1NDg0MDk4ODcESHVydAxGYWNlVGV4dHVyZXMOVVNFX1NLSU5fTU9ERUwAAwEBAAAABgMAAAUBBwGCAAEAAAAYAQEYABoAAAAACgIAAAAHBAAABQIHBzGkAgEAAAAAQLwDAUcCAAAAnwMCAJ8CAAQXAgsAbwkDALwHBv4EAAAAnwcDAg4HBgCkBwcAABhQgG8ICACfBwICMAcGpAkAAABuAvT/AgAAAG8ECgC8AgHTCwAAAJ8CAwJvBAwAvAIC0wsAAACfAgMCbwQNALwCAtMLAAAAnwIDAm8FDAC8AwDTCwAAAJ8DAwJNAwPVDgAAADADAtUOAAAAbwUMALwDANMLAAAAnwMDAk0DA4QPAAAAMAMC9xAAAACCAAEAEQMCBAAAAEADAwMEAwUDBgMHBAAYUIADCAMJAwoDCwMMAw0DDgMPAxAAHBEBGAAAAAAAAAABAAAAAAEAAAAAAP4ABgAAAAAAAAAAAAAAAgAAAAAAAAABAAAAAAAAAAIeAAAAAAMAAAECADmjAAAA/wAEAAAAAABvAQAAMAEAugEAAACMAVgCMAEAIwIAAACpAQEAMAEATgMAAAD/AQQAAAAAAG8CBAAwAgEWBQAAAG8CBgAwAgGfBwAAAG8CCAAwAgGSCQAAAG8CCgAwAgF4CwAAAG8CDAAwAgHuDQAAAG8CDgAwAgH0DwAAADABAOkQAAAA/wEDAAAAAABvAhEAMAIBEBIAAABvAhMAMAIBmRQAAABvAhUAMAIBxRYAAAAwAQAhFwAAAKkBAQAwAQDCGAAAAMABGQAwAQDpGgAAAMABGwAwAQCyHAAAAIIAAgAdAxIDEwMUAxUDFgMXAxgDGQMaAxsDHAMdAx4DHwMgAyEDIgMjAyQDJQMmAycDKAMpAyoGAAMBBgEDEQIAAQEAARgAAAACAAABAAABAAACAAEAAAEAAAEAAAEAAAEAAAEAAPoACQABAAABAAABAAD9AAYAAAIAAAQAABABAAAAAAJjsjVSWYW+3bpACqMjgrxFE6oiJlF2X1M=

-- https://lua.expert/
return {
	Name = "Rainbow Sherbet",
	Cost = 600,
	DandyStore = true,
	OverwriteAnimations = {
		Run = "rbxassetid://112111022093091",
		Walk = "rbxassetid://103105474019093",
		Idle = "rbxassetid://134272548635232",
		Quirk = "rbxassetid://128830992461003",
		Decode = "rbxassetid://76886834369462",
		Ability = "rbxassetid://81986487044485"
	},
	FaceTextures = {
		Normal = "rbxassetid://138894858465346",
		Blink = "rbxassetid://100135022127471",
		Hurt = "rbxassetid://119339548409887"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 24 ]] end,
	UseAbility = function(p1, p2) --[[ UseAbility | Line: 28 ]]
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