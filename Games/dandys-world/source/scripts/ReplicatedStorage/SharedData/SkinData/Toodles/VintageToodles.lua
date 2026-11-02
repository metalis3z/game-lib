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
-- CQMSBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQQxGYWNlVGV4dHVyZXMGTm9ybWFsCVRleHR1cmVJRAlBcHBseVNraW4PVmludGFnZSBUb29kbGVzBE5hbWUHTWFzdGVyeRNPdmVyd3JpdGVBbmltYXRpb25zHHJieGFzc2V0aWQ6Ly8xMzU0MzQ1MTY2OTg3MDEFQmxpbmsccmJ4YXNzZXRpZDovLzEyMTExMDA5NTg4NTU4NwRIdXJ0HHJieGFzc2V0aWQ6Ly8xMDQxMTIwMjg3Mzg3MTEOVVNFX1NLSU5fTU9ERUwAAgkBAQAAABakAQEAAAAAQLwCAEcCAAAAnwICAJ8BAAQXAQwAbwgDALwGBf4EAAAAnwYDAg4GBwD7BgAATQYGIQUAAABNBgYQBgAAADAGBYQHAAAAbgHz/wIAAACCAAEACAMBBAAAAEADAgMDAwQDBQMGAwcAEQgBGAAAAAAAAAABAAAAAAEAAAAAAAD+AAYTAAAAAAMAAAECACKjAAAA/wAEAAAAAABvAQAAMAEAugEAAACpAQEAMAEAPAIAAAD/AQAAAAAAADABAOkDAAAA/wEDAAAAAABvAgQAMAIBmQUAAABvAgYAMAIBxQcAAABvAggAMAIBEAkAAAAwAQAhCgAAAKkBAAAwAQDCCwAAAMABDAASAAAAMAEA6Q0AAACCAAIADgMJAwoDCwMMAw0DDgMPAxADEQMGAwUDEgYAAwgBAAEAARgAAAACAAABAAACAAAAAwABAAABAAABAAD9AAYAAAIAAAAMAQAAAAAB82YHfDcuyiSwPW9scf5P1YN+EAjBom19

-- https://lua.expert/
local t = {
	Name = "Vintage Toodles",
	Mastery = true,
	OverwriteAnimations = {},
	FaceTextures = {
		Blink = "rbxassetid://135434516698701",
		Hurt = "rbxassetid://121110095885587",
		Normal = "rbxassetid://104112028738711"
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