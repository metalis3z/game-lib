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
-- CQMmEEh1bWFub2lkUm9vdFBhcnQORmluZEZpcnN0Q2hpbGQJVG9vbkxpZ2h0CkV4dHJhTGlnaHQKUG9pbnRMaWdodAZDb2xvcjMHZnJvbVJHQgVDb2xvcglBcHBseVNraW4LR291cmQgR3VhcmQETmFtZQpTb3VsdmVzdGVyCVRvd2VyTmFtZRJObyBkZXNjcmlwdGlvbiB5ZXQLRGVzY3JpcHRpb24HTWFzdGVyeQRDb3N0CUhhbGxvd2VlbgtIb2xpZGF5U2tpbhxyYnhhc3NldGlkOi8vMTIwMTcxMzExNzI5MDIxBkRlY29kZRxyYnhhc3NldGlkOi8vMTA2MjU4NTYxNTc3NDgyBVF1aXJrG3JieGFzc2V0aWQ6Ly83NDY4MDg2MjYyMjEwNwRJZGxlHHJieGFzc2V0aWQ6Ly8xMzc2MTY1NzE0MzkzMzcEV2FsaxtyYnhhc3NldGlkOi8vODY1NzczODAwMDMzNTADUnVuE092ZXJ3cml0ZUFuaW1hdGlvbnMbcmJ4YXNzZXRpZDovLzgzNzQ1NzkwMjEzNzA2BEh1cnQccmJ4YXNzZXRpZDovLzExODA2ODMwNzYzNDE3MwVCbGluaxxyYnhhc3NldGlkOi8vMTE0NzExMzUxMDI5MTYwBk5vcm1hbAxGYWNlVGV4dHVyZXMOVVNFX1NLSU5fTU9ERUwAAgoBAAAABgMAAAUBBy9vAwAAvAEAAwEAAACfAQMCUgIBAA4CBABvBAIAvAIBAwEAAACfAgMCUgMBAA4DBABvBQMAvAMBAwEAAACfAwMCUgQCAA4EBABvBgQAvAQCAwEAAACfBAMCUgUDAA4FBABvBwQAvAUDAwEAAACfBQMCDgQIAKQGBwAAGFCAjAfbAIwImQCMCTAAnwYEAjAGBKQIAAAADgUIAKQGBwAAGFCAjAfbAIwImQCMCTAAnwYEAjAGBaQIAAAAggABAAkDAQMCAwMDBAMFAwYDBwQAGFCAAwgAHgkBGAAAAAABAAAAAAABAAAAAAABAAAAAAABAAAAAAACAQAAAAAAAAACAQAAAAAAAAADIAAAAAADAAABAgA/owAAAP8ABQAAAAAAbwEAADABALoBAAAAbwECADABAIcDAAAAbwEEADABAOIFAAAAqQEAADABADwGAAAAjAFYAjABACMHAAAAqQEBADABAGkIAAAAqQEBADABALwJAAAA/wEEAAAAAABvAgoAMAIB7gsAAABvAgwAMAIBeA0AAABvAg4AMAIBkg8AAABvAhAAMAIBnxEAAABvAhIAMAIBFhMAAAAwAQDpFAAAAP8BAwAAAAAAbwIVADACAcUWAAAAbwIXADACAZkYAAAAbwIZADACARAaAAAAMAEAIRsAAACpAQEAMAEAwhwAAADAAR0AMAEA6R4AAACCAAIAHwMKAwsDDAMNAw4DDwMQAxEDEgMTAxQDFQMWAxcDGAMZAxoDGwMcAx0DHgMfAyADIQMiAyMDJAMlAyYGAAMJAQABAAEYAAAAAgAAAQAAAQAAAQAAAgAAAwAAAQAAAgABAAABAAABAAABAAABAAD7AAgAAQAAAQAAAQAA/QAGAAACAAARAQAAAAAB/uIstjJUVCswOfDasggZ3I76O8LMJka3

-- https://lua.expert/
return {
	Name = "Gourd Guard",
	TowerName = "Soulvester",
	Description = "No description yet",
	Mastery = false,
	Cost = 600,
	Halloween = true,
	HolidaySkin = true,
	OverwriteAnimations = {
		Decode = "rbxassetid://120171311729021",
		Quirk = "rbxassetid://106258561577482",
		Idle = "rbxassetid://74680862622107",
		Walk = "rbxassetid://137616571439337",
		Run = "rbxassetid://86577380003350"
	},
	FaceTextures = {
		Hurt = "rbxassetid://83745790213706",
		Blink = "rbxassetid://118068307634173",
		Normal = "rbxassetid://114711351029160"
	},
	USE_SKIN_MODEL = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 30 ]]
		local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")
		local v1 = if HumanoidRootPart then HumanoidRootPart:FindFirstChild("ToonLight") else HumanoidRootPart
		local v2 = if HumanoidRootPart then HumanoidRootPart:FindFirstChild("ExtraLight") else HumanoidRootPart
		local v3 = if v1 then v1:FindFirstChild("PointLight") else v1
		local v4 = if v2 then v2:FindFirstChild("PointLight") else v2

		if v3 then
			v3.Color = Color3.fromRGB(219, 153, 48)
		end

		if not v4 then
			return
		end

		v4.Color = Color3.fromRGB(219, 153, 48)
	end
}