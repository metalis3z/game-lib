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
-- CQMSBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQQxGYWNlVGV4dHVyZXMGTm9ybWFsCVRleHR1cmVJRAlBcHBseVNraW4OVmludGFnZSBCb3h0ZW4ETmFtZQdNYXN0ZXJ5E092ZXJ3cml0ZUFuaW1hdGlvbnMccmJ4YXNzZXRpZDovLzEzMzc4MzQ4MjE3NjkxNgVCbGluaxxyYnhhc3NldGlkOi8vMTIwODQzMjE4NDQ4MjY0BEh1cnQYcmJ4YXNzZXRpZDovLzE3Njc1OTgyOTM4DlVTRV9TS0lOX01PREVMAAIJAQEAAAYDAAAFAQcWpAEBAAAAAEC8AgBHAgAAAJ8CAgCfAQAEFwEMAG8IAwC8BgX+BAAAAJ8GAwIOBgcA+wYAAE0GBiEFAAAATQYGEAYAAAAwBgWEBwAAAG4B8/8CAAAAggABAAgDAQQAAABAAwIDAwMEAwUDBgMHABEIARgAAAAAAAAAAQAAAAABAAAAAAAA/gAGEwAAAAADAAABAgAiowAAAP8ABAAAAAAAbwEAADABALoBAAAAqQEBADABADwCAAAA/wEAAAAAAAAwAQDpAwAAAP8BAwAAAAAAbwIEADACAZkFAAAAbwIGADACAcUHAAAAbwIIADACARAJAAAAMAEAIQoAAACpAQAAMAEAwgsAAADAAQwAEgAAADABAOkNAAAAggACAA4DCQMKAwsDDAMNAw4DDwMQAxEDBgMFAxIGAAMIAQABAAEYAAAAAgAAAQAAAgAAAAMAAQAAAQAAAQAA/QAGAAACAAAADAEAAAAAAX2avG4rf2JqA2GTmxkTztMNgqsaT17Wbw==

-- https://lua.expert/
local t = {
	Name = "Vintage Boxten",
	Mastery = true,
	OverwriteAnimations = {},
	FaceTextures = {
		Blink = "rbxassetid://133783482176916",
		Hurt = "rbxassetid://120843218448264",
		Normal = "rbxassetid://17675982938"
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