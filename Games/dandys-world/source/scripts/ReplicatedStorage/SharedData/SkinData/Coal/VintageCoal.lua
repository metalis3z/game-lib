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
-- CQMSBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQQxGYWNlVGV4dHVyZXMGTm9ybWFsCVRleHR1cmVJRAlBcHBseVNraW4MVmludGFnZSBDb2FsBE5hbWUHTWFzdGVyeRNPdmVyd3JpdGVBbmltYXRpb25zG3JieGFzc2V0aWQ6Ly84NTgzNDU3NTMxNjYwMBxyYnhhc3NldGlkOi8vMTE0MTUyOTM4Njk4NjE2BUJsaW5rHHJieGFzc2V0aWQ6Ly8xMTc2MzAwMjU5MTEwMDAESHVydA5VU0VfU0tJTl9NT0RFTAACCQEBAAAGAwAABQEHFqQBAQAAAABAvAIARwIAAACfAgIAnwEABBcBDABvCAMAvAYF/gQAAACfBgMCDgYHAPsGAABNBgYhBQAAAE0GBhAGAAAAMAYFhAcAAABuAfP/AgAAAIIAAQAIAwEEAAAAQAMCAwMDBAMFAwYDBwARCAEYAAAAAAAAAAEAAAAAAQAAAAAAAP4ABhMAAAAAAwAAAQIAIqMAAAD/AAQAAAAAAG8BAAAwAQC6AQAAAKkBAQAwAQA8AgAAAP8BAAAAAAAAMAEA6QMAAAD/AQMAAAAAAG8CBAAwAgEQBQAAAG8CBgAwAgGZBwAAAG8CCAAwAgHFCQAAADABACEKAAAAqQEAADABAMILAAAAwAEMABIAAAAwAQDpDQAAAIIAAgAOAwkDCgMLAwwDDQMGAw4DDwMQAxEDBQMSBgADCAEAAQABGAAAAAIAAAEAAAIAAAADAAEAAAEAAAEAAP0ABgAAAgAAAAoBAAAAAAHfeaap6g3V5Q5rhfIambmvr2Gx3e29zKg=

-- https://lua.expert/
local t = {
	Name = "Vintage Coal",
	Mastery = true,
	OverwriteAnimations = {},
	FaceTextures = {
		Normal = "rbxassetid://85834575316600",
		Blink = "rbxassetid://114152938698616",
		Hurt = "rbxassetid://117630025911000"
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