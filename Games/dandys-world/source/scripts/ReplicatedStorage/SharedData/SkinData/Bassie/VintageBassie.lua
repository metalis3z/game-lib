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
-- CQMSBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQQxGYWNlVGV4dHVyZXMGTm9ybWFsCVRleHR1cmVJRAlBcHBseVNraW4OVmludGFnZSBCYXNzaWUETmFtZQdNYXN0ZXJ5E092ZXJ3cml0ZUFuaW1hdGlvbnMbcmJ4YXNzZXRpZDovLzgyMzYzMDE5NzE4NzQ0HHJieGFzc2V0aWQ6Ly8xMjcwMDQ3ODA3MDAwNTIFQmxpbmsccmJ4YXNzZXRpZDovLzExMjg4MjE2ODM1MzgxMARIdXJ0DlVTRV9TS0lOX01PREVMAAIJAQEAAAYDAAAFAQcWpAEBAAAAAEC8AgBHAgAAAJ8CAgCfAQAEFwEMAG8IAwC8BgX+BAAAAJ8GAwIOBgcA+wYAAE0GBiEFAAAATQYGEAYAAAAwBgWEBwAAAG4B8/8CAAAAggABAAgDAQQAAABAAwIDAwMEAwUDBgMHABEIARgAAAAAAAAAAQAAAAABAAAAAAAA/gAGEwAAAAADAAABAgAiowAAAP8ABAAAAAAAbwEAADABALoBAAAAqQEBADABADwCAAAA/wEAAAAAAAAwAQDpAwAAAP8BAwAAAAAAbwIEADACARAFAAAAbwIGADACAZkHAAAAbwIIADACAcUJAAAAMAEAIQoAAACpAQAAMAEAwgsAAADAAQwAEgAAADABAOkNAAAAggACAA4DCQMKAwsDDAMNAwYDDgMPAxADEQMFAxIGAAMIAQABAAEYAAAAAgAAAQAAAgAAAAMAAQAAAQAAAQAA/QAGAAACAAAACgEAAAAAAX3UIisDNksEILqxBkK+qmUNzDVfTxBIKg==

-- https://lua.expert/
local t = {
	Name = "Vintage Bassie",
	Mastery = true,
	OverwriteAnimations = {},
	FaceTextures = {
		Normal = "rbxassetid://82363019718744",
		Blink = "rbxassetid://127004780700052",
		Hurt = "rbxassetid://112882168353810"
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