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
-- CQMRBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQQxGYWNlVGV4dHVyZXMGTm9ybWFsCVRleHR1cmVJRAlBcHBseVNraW4PVmludGFnZSBTaHJpbXBvBE5hbWUTT3ZlcndyaXRlQW5pbWF0aW9ucxxyYnhhc3NldGlkOi8vMTM3OTYxNjgyMTAwOTUzBUJsaW5rHHJieGFzc2V0aWQ6Ly8xMjI0MjU5NTc1ODYyNDUESHVydBxyYnhhc3NldGlkOi8vMTA0OTE1ODU3ODIwOTA2DlVTRV9TS0lOX01PREVMAAIJAQEAAAYDAAAFAQcWpAEBAAAAAEC8AgBHAgAAAJ8CAgCfAQAEFwEMAG8IAwC8BgX+BAAAAJ8GAwIOBgcA+wYAAE0GBiEFAAAATQYGEAYAAAAwBgWEBwAAAG4B8/8CAAAAggABAAgDAQQAAABAAwIDAwMEAwUDBgMHABAIARgAAAAAAAAAAQAAAAABAAAAAAAA/gAGEgAAAAADAAABAgAfowAAAP8ABAAAAAAAbwEAADABALoBAAAA/wEAAAAAAAAwAQDpAgAAAP8BAwAAAAAAbwIDADACAZkEAAAAbwIFADACAcUGAAAAbwIHADACARAIAAAAMAEAIQkAAACpAQAAMAEAwgoAAADAAQsAEgAAADABAOkMAAAAggACAA0DCQMKAwsDDAMNAw4DDwMQAwYDBQMRBgADCAEAAQABGAAAAAIAAAIAAAADAAEAAAEAAAEAAP0ABgAAAgAAAAwBAAAAAAHk8snVc2e6V5BF9yqocbZtlOreodY2o9Q=

-- https://lua.expert/
local t = {
	Name = "Vintage Shrimpo",
	OverwriteAnimations = {},
	FaceTextures = {
		Blink = "rbxassetid://137961682100953",
		Hurt = "rbxassetid://122425957586245",
		Normal = "rbxassetid://104915857820906"
	},
	USE_SKIN_MODEL = false
}

function t.ApplySkin(p1) --[[ ApplySkin | Line: 16 | Upvalues: t (copy) ]]
	for k, v in pairs(p1:GetDescendants()) do
		if v:IsA("MeshPart") then
			v.TextureID = t.FaceTextures.Normal
		end
	end
end

return t