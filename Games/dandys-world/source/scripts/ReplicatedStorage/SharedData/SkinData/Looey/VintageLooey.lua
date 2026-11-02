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
-- CQMSBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQQxGYWNlVGV4dHVyZXMGTm9ybWFsCVRleHR1cmVJRAlBcHBseVNraW4NVmludGFnZSBMb29leQROYW1lB01hc3RlcnkTT3ZlcndyaXRlQW5pbWF0aW9ucxtyYnhhc3NldGlkOi8vNzg0Nzk5MjYyNDA4ODYbcmJ4YXNzZXRpZDovLzg2MjI2NjM0MjU0NzA0BEh1cnQccmJ4YXNzZXRpZDovLzExMzI0NzExMDQ2NzM3NQVCbGluaw5VU0VfU0tJTl9NT0RFTAACCQEBAAAGAwAABQEHFqQBAQAAAABAvAIARwIAAACfAgIAnwEABBcBDABvCAMAvAYF/gQAAACfBgMCDgYHAPsGAABNBgYhBQAAAE0GBhAGAAAAMAYFhAcAAABuAfP/AgAAAIIAAQAIAwEEAAAAQAMCAwMDBAMFAwYDBwARCAEYAAAAAAAAAAEAAAAAAQAAAAAAAP4ABhMAAAAAAwAAAQIAIqMAAAD/AAQAAAAAAG8BAAAwAQC6AQAAAKkBAQAwAQA8AgAAAP8BAAAAAAAAMAEA6QMAAAD/AQMAAAAAAG8CBAAwAgEQBQAAAG8CBgAwAgHFBwAAAG8CCAAwAgGZCQAAADABACEKAAAAqQEAADABAMILAAAAwAEMABIAAAAwAQDpDQAAAIIAAgAOAwkDCgMLAwwDDQMGAw4DDwMQAxEDBQMSBgADCAEAAQABGAAAAAIAAAEAAAIAAAADAAEAAAEAAAEAAP0ABgAAAgAAAAoBAAAAAAHFBPtEaGy3VxEHr6sElQuBtRzsMPfAkUU=

-- https://lua.expert/
local t = {
	Name = "Vintage Looey",
	Mastery = true,
	OverwriteAnimations = {},
	FaceTextures = {
		Normal = "rbxassetid://78479926240886",
		Hurt = "rbxassetid://86226634254704",
		Blink = "rbxassetid://113247110467375"
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