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
-- CQMeBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQQxGYWNlVGV4dHVyZXMGTm9ybWFsCVRleHR1cmVJRAlBcHBseVNraW4OQ29sb3JmdWwgQXByaWwETmFtZQRDb3N0CkRhbmR5U3RvcmULVHJhY2tTb3VyY2UccmJ4YXNzZXRpZDovLzEyMTg4NzU5NzA1NjE2OQNSdW4ccmJ4YXNzZXRpZDovLzExMzQ5MzI3NjAzMDc5OQRXYWxrG3JieGFzc2V0aWQ6Ly85NDY3MjkzOTM3MDE0OQRJZGxlHHJieGFzc2V0aWQ6Ly8xMjA1MjQ4OTY2NTc3NjcFUXVpcmsbcmJ4YXNzZXRpZDovLzgxMTk1MzUwOTMxNzM1BkRlY29kZRNPdmVyd3JpdGVBbmltYXRpb25zG3JieGFzc2V0aWQ6Ly85NjM2MzQzNTU0NzQyOBtyYnhhc3NldGlkOi8vOTQxNjc2MDQ1MDg4NzcESHVydBtyYnhhc3NldGlkOi8vOTMyNDUxMTE3MTYyMjMFQmxpbmsOVVNFX1NLSU5fTU9ERUwAAgkBAQAABgMAAAUBBxakAQEAAAAAQLwCAEcCAAAAnwICAJ8BAAQXAQwAbwgDALwGBf4EAAAAnwYDAg4GBwD7BgAATQYGIQUAAABNBgYQBgAAADAGBYQHAAAAbgHz/wIAAACCAAEACAMBBAAAAEADAgMDAwQDBQMGAwcAGAgBGAAAAAAAAAABAAAAAAEAAAAAAAD+AAQcAAAAAAMAAAECADejAAAA/wAEAAAAAABvAQAAMAEAugEAAACMAVgCMAEAIwIAAACpAQEAMAEATgMAAACpAQEAMAEAzAQAAAD/AQQAAAAAAG8CBQAwAgEWBgAAAG8CBwAwAgGfCAAAAG8CCQAwAgGSCgAAAG8CCwAwAgF4DAAAAG8CDQAwAgHuDgAAADABAOkPAAAA/wEDAAAAAABvAhAAMAIBEBEAAABvAhIAMAIBxRMAAABvAhQAMAIBmRUAAAAwAQAhFgAAAKkBAQAwAQDCFwAAAMABGAASAAAAMAEA6RkAAACCAAIAGgMJAwoDCwMMAw0DDgMPAxADEQMSAxMDFAMVAxYDFwMYAxkDBgMaAxsDHAMdAwUDHgYAAwgBAAEAARgAAAACAAABAAABAAABAAACAAEAAAEAAAEAAAEAAAEAAPsACAABAAABAAABAAD9AAYAAAIAAAAKAQAAAAABQ2NVmVf1aUIezWNErPbWXzN7Qu1xpz+Y

-- https://lua.expert/
local t = {
	Name = "Colorful April",
	Cost = 600,
	DandyStore = true,
	TrackSource = true,
	OverwriteAnimations = {
		Run = "rbxassetid://121887597056169",
		Walk = "rbxassetid://113493276030799",
		Idle = "rbxassetid://94672939370149",
		Quirk = "rbxassetid://120524896657767",
		Decode = "rbxassetid://81195350931735"
	},
	FaceTextures = {
		Normal = "rbxassetid://96363435547428",
		Hurt = "rbxassetid://94167604508877",
		Blink = "rbxassetid://93245111716223"
	},
	USE_SKIN_MODEL = true
}

function t.ApplySkin(p1) --[[ ApplySkin | Line: 24 | Upvalues: t (copy) ]]
	for k, v in pairs(p1:GetDescendants()) do
		if v:IsA("MeshPart") then
			v.TextureID = t.FaceTextures.Normal
		end
	end
end

return t