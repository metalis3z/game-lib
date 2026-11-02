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
-- CQMSBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQQxGYWNlVGV4dHVyZXMGTm9ybWFsCVRleHR1cmVJRAlBcHBseVNraW4OVmludGFnZSBTcXVpcm0ETmFtZQdNYXN0ZXJ5E092ZXJ3cml0ZUFuaW1hdGlvbnMbcmJ4YXNzZXRpZDovLzg3OTI3NzcyNzkzODc3BUJsaW5rG3JieGFzc2V0aWQ6Ly84NTc1NjAzNTI1NzIxNwRIdXJ0HHJieGFzc2V0aWQ6Ly8xMjAxOTk4MjU3OTkyMDAOVVNFX1NLSU5fTU9ERUwAAgkBAQAABgMAAAUBBxakAQEAAAAAQLwCAEcCAAAAnwICAJ8BAAQXAQwAbwgDALwGBf4EAAAAnwYDAg4GBwD7BgAATQYGIQUAAABNBgYQBgAAADAGBYQHAAAAbgHz/wIAAACCAAEACAMBBAAAAEADAgMDAwQDBQMGAwcAEQgBGAAAAAAAAAABAAAAAAEAAAAAAAD+AAYTAAAAAAMAAAECACKjAAAA/wAEAAAAAABvAQAAMAEAugEAAACpAQEAMAEAPAIAAAD/AQAAAAAAADABAOkDAAAA/wEDAAAAAABvAgQAMAIBmQUAAABvAgYAMAIBxQcAAABvAggAMAIBEAkAAAAwAQAhCgAAAKkBAAAwAQDCCwAAAMABDAASAAAAMAEA6Q0AAACCAAIADgMJAwoDCwMMAw0DDgMPAxADEQMGAwUDEgYAAwgBAAEAARgAAAACAAABAAACAAAAAwABAAABAAABAAD9AAYAAAIAAAAMAQAAAAABebcA43AnGqVbW/QrwLvvMgmvF5dLc2ri

-- https://lua.expert/
local t = {
	Name = "Vintage Squirm",
	Mastery = true,
	OverwriteAnimations = {},
	FaceTextures = {
		Blink = "rbxassetid://87927772793877",
		Hurt = "rbxassetid://85756035257217",
		Normal = "rbxassetid://120199825799200"
	},
	USE_SKIN_MODEL = false
}

function t.ApplySkin(p1) --[[ ApplySkin | Line: 17 | Upvalues: t (copy) ]]
	for k, v in pairs(p1:GetDescendants()) do
		if v:IsA("MeshPart") then
			v.TextureID = t.FaceTextures.Normal
		end
	end
end

return t