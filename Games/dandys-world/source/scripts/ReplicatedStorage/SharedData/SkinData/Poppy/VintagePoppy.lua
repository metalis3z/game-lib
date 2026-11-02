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
-- CQMSBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQQxGYWNlVGV4dHVyZXMGTm9ybWFsCVRleHR1cmVJRAlBcHBseVNraW4NVmludGFnZSBQb3BweQROYW1lB01hc3RlcnkTT3ZlcndyaXRlQW5pbWF0aW9ucxxyYnhhc3NldGlkOi8vMTAyNzkwMTQzNjc2MTkzBUJsaW5rGHJieGFzc2V0aWQ6Ly8xNzY3NTcxMjg3MQRIdXJ0GHJieGFzc2V0aWQ6Ly8xNzY3NTcxMDAyMg5VU0VfU0tJTl9NT0RFTAACCQEBAAAGAwAABQEHFqQBAQAAAABAvAIARwIAAACfAgIAnwEABBcBDABvCAMAvAYF/gQAAACfBgMCDgYHAPsGAABNBgYhBQAAAE0GBhAGAAAAMAYFhAcAAABuAfP/AgAAAIIAAQAIAwEEAAAAQAMCAwMDBAMFAwYDBwARCAEYAAAAAAAAAAEAAAAAAQAAAAAAAP4ABhMAAAAAAwAAAQIAIqMAAAD/AAQAAAAAAG8BAAAwAQC6AQAAAKkBAQAwAQA8AgAAAP8BAAAAAAAAMAEA6QMAAAD/AQMAAAAAAG8CBAAwAgGZBQAAAG8CBgAwAgHFBwAAAG8CCAAwAgEQCQAAADABACEKAAAAqQEAADABAMILAAAAwAEMABIAAAAwAQDpDQAAAIIAAgAOAwkDCgMLAwwDDQMOAw8DEAMRAwYDBQMSBgADCAEAAQABGAAAAAIAAAEAAAIAAAADAAEAAAEAAAEAAP0ABgAAAgAAAAwBAAAAAAFw/AOfOVa1r+jeO+cIpIVrAOQU60I4aZ4=

-- https://lua.expert/
local t = {
	Name = "Vintage Poppy",
	Mastery = true,
	OverwriteAnimations = {},
	FaceTextures = {
		Blink = "rbxassetid://102790143676193",
		Hurt = "rbxassetid://17675712871",
		Normal = "rbxassetid://17675710022"
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