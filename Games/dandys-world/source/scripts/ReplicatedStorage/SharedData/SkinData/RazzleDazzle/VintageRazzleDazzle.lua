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
-- CQMSBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQQxGYWNlVGV4dHVyZXMGTm9ybWFsCVRleHR1cmVJRAlBcHBseVNraW4XVmludGFnZSBSYXp6bGUgJiBEYXp6bGUETmFtZQdNYXN0ZXJ5E092ZXJ3cml0ZUFuaW1hdGlvbnMccmJ4YXNzZXRpZDovLzExMTc2MjUyMzUzNjYzNgVCbGluaxxyYnhhc3NldGlkOi8vMTIyODgzNjIyODk5MDk4BEh1cnQccmJ4YXNzZXRpZDovLzEzMjA3Mjg3NDc1MDI0Ng5VU0VfU0tJTl9NT0RFTAACCQEBAAAGAwAABQEHFqQBAQAAAABAvAIARwIAAACfAgIAnwEABBcBDABvCAMAvAYF/gQAAACfBgMCDgYHAPsGAABNBgYhBQAAAE0GBhAGAAAAMAYFhAcAAABuAfP/AgAAAIIAAQAIAwEEAAAAQAMCAwMDBAMFAwYDBwARCAEYAAAAAAAAAAEAAAAAAQAAAAAAAP4ABhMAAAAAAwAAAQIAIqMAAAD/AAQAAAAAAG8BAAAwAQC6AQAAAKkBAQAwAQA8AgAAAP8BAAAAAAAAMAEA6QMAAAD/AQMAAAAAAG8CBAAwAgGZBQAAAG8CBgAwAgHFBwAAAG8CCAAwAgEQCQAAADABACEKAAAAqQEAADABAMILAAAAwAEMABIAAAAwAQDpDQAAAIIAAgAOAwkDCgMLAwwDDQMOAw8DEAMRAwYDBQMSBgADCAEAAQABGAAAAAIAAAEAAAIAAAADAAEAAAEAAAEAAP0ABgAAAgAAAAoBAAAAAAGjmkTa6L2gLLAcmw8pA2hn04JTrpFeLts=

-- https://lua.expert/
local t = {
	Name = "Vintage Razzle & Dazzle",
	Mastery = true,
	OverwriteAnimations = {},
	FaceTextures = {
		Blink = "rbxassetid://111762523536636",
		Hurt = "rbxassetid://122883622899098",
		Normal = "rbxassetid://132072874750246"
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