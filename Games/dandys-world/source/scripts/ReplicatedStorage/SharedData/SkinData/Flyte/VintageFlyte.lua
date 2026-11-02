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
-- CQMSBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQQxGYWNlVGV4dHVyZXMGTm9ybWFsCVRleHR1cmVJRAlBcHBseVNraW4NVmludGFnZSBGbHl0ZQROYW1lB01hc3RlcnkTT3ZlcndyaXRlQW5pbWF0aW9ucxtyYnhhc3NldGlkOi8vNzc2NzgzNTc2NjQyOTQccmJ4YXNzZXRpZDovLzEwNTE0NTc0NTg4NTU3NARIdXJ0HHJieGFzc2V0aWQ6Ly8xMTI0NDY3MDc1ODY3ODgFQmxpbmsOVVNFX1NLSU5fTU9ERUwAAgkBAQAABgMAAAUBBxakAQEAAAAAQLwCAEcCAAAAnwICAJ8BAAQXAQwAbwgDALwGBf4EAAAAnwYDAg4GBwD7BgAATQYGIQUAAABNBgYQBgAAADAGBYQHAAAAbgHz/wIAAACCAAEACAMBBAAAAEADAgMDAwQDBQMGAwcAEQgBGAAAAAAAAAABAAAAAAEAAAAAAAD+AAYTAAAAAAMAAAECACKjAAAA/wAEAAAAAABvAQAAMAEAugEAAACpAQEAMAEAPAIAAAD/AQAAAAAAADABAOkDAAAA/wEDAAAAAABvAgQAMAIBEAUAAABvAgYAMAIBxQcAAABvAggAMAIBmQkAAAAwAQAhCgAAAKkBAAAwAQDCCwAAAMABDAASAAAAMAEA6Q0AAACCAAIADgMJAwoDCwMMAw0DBgMOAw8DEAMRAwUDEgYAAwgBAAEAARgAAAACAAABAAACAAAAAwABAAABAAABAAD9AAYAAAIAAAAKAQAAAAAB4O2FzAcHEm3cU3P1D3NEqZD1krjSKe/N

-- https://lua.expert/
local t = {
	Name = "Vintage Flyte",
	Mastery = true,
	OverwriteAnimations = {},
	FaceTextures = {
		Normal = "rbxassetid://77678357664294",
		Hurt = "rbxassetid://105145745885574",
		Blink = "rbxassetid://112446707586788"
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