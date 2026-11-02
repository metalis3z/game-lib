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
-- CQMSBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQQxGYWNlVGV4dHVyZXMGTm9ybWFsCVRleHR1cmVJRAlBcHBseVNraW4NVmludGFnZSBZYXR0YQROYW1lB01hc3RlcnkTT3ZlcndyaXRlQW5pbWF0aW9ucxtyYnhhc3NldGlkOi8vOTk4NjU1MjgxNTI0NzcbcmJ4YXNzZXRpZDovLzk1MzMzMDM4MzgwNDc3BEh1cnQbcmJ4YXNzZXRpZDovLzgzMTQzMzgwMTM1OTg5BUJsaW5rDlVTRV9TS0lOX01PREVMAAIJAQEAAAYDAAAFAQcWpAEBAAAAAEC8AgBHAgAAAJ8CAgCfAQAEFwEMAG8IAwC8BgX+BAAAAJ8GAwIOBgcA+wYAAE0GBiEFAAAATQYGEAYAAAAwBgWEBwAAAG4B8/8CAAAAggABAAgDAQQAAABAAwIDAwMEAwUDBgMHABEIARgAAAAAAAAAAQAAAAABAAAAAAAA/gAGEwAAAAADAAABAgAiowAAAP8ABAAAAAAAbwEAADABALoBAAAAqQEBADABADwCAAAA/wEAAAAAAAAwAQDpAwAAAP8BAwAAAAAAbwIEADACARAFAAAAbwIGADACAcUHAAAAbwIIADACAZkJAAAAMAEAIQoAAACpAQAAMAEAwgsAAADAAQwAEgAAADABAOkNAAAAggACAA4DCQMKAwsDDAMNAwYDDgMPAxADEQMFAxIGAAMIAQABAAEYAAAAAgAAAQAAAgAAAAMAAQAAAQAAAQAA/QAGAAACAAAACgEAAAAAAdTowO+Z9RjPlo5nUeJ+e2Sk8Neb5iyq7g==

-- https://lua.expert/
local t = {
	Name = "Vintage Yatta",
	Mastery = true,
	OverwriteAnimations = {},
	FaceTextures = {
		Normal = "rbxassetid://99865528152477",
		Hurt = "rbxassetid://95333038380477",
		Blink = "rbxassetid://83143380135989"
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