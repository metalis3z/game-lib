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
-- CQMSBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQQxGYWNlVGV4dHVyZXMGTm9ybWFsCVRleHR1cmVJRAlBcHBseVNraW4OVmludGFnZSBHaW5nZXIETmFtZQdNYXN0ZXJ5E092ZXJ3cml0ZUFuaW1hdGlvbnMbcmJ4YXNzZXRpZDovLzkwNzQ5NzAwNTI4MzI0G3JieGFzc2V0aWQ6Ly85OTY4NTYyMDMyNjUwMgVCbGluaxtyYnhhc3NldGlkOi8vODAyODAxNzA1ODgzNTAESHVydA5VU0VfU0tJTl9NT0RFTAACCQEBAAAGAwAABQEHFqQBAQAAAABAvAIARwIAAACfAgIAnwEABBcBDABvCAMAvAYF/gQAAACfBgMCDgYHAPsGAABNBgYhBQAAAE0GBhAGAAAAMAYFhAcAAABuAfP/AgAAAIIAAQAIAwEEAAAAQAMCAwMDBAMFAwYDBwASCAEYAAAAAAAAAAEAAAAAAQAAAAAAAP4ABhQAAAAAAwAAAQIAIqMAAAD/AAQAAAAAAG8BAAAwAQC6AQAAAKkBAQAwAQA8AgAAAP8BAAAAAAAAMAEA6QMAAAD/AQMAAAAAAG8CBAAwAgEQBQAAAG8CBgAwAgGZBwAAAG8CCAAwAgHFCQAAADABACEKAAAAqQEAADABAMILAAAAwAEMABIAAAAwAQDpDQAAAIIAAgAOAwkDCgMLAwwDDQMGAw4DDwMQAxEDBQMSBgADCAEAAQABGAAAAAIAAAEAAAIAAAADAAEAAAEAAAEAAP0ABgAAAwAAAAoBAAAAAAH4072rVZw0VJTL/ALcxdjRiMuq38oX16o=

-- https://lua.expert/
local t = {
	Name = "Vintage Ginger",
	Mastery = true,
	OverwriteAnimations = {},
	FaceTextures = {
		Normal = "rbxassetid://90749700528324",
		Blink = "rbxassetid://99685620326502",
		Hurt = "rbxassetid://80280170588350"
	},
	USE_SKIN_MODEL = false
}

function t.ApplySkin(p1) --[[ ApplySkin | Line: 18 | Upvalues: t (copy) ]]
	for k, v in pairs(p1:GetDescendants()) do
		if v:IsA("MeshPart") then
			v.TextureID = t.FaceTextures.Normal
		end
	end
end

return t