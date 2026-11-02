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
-- CQMfBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRxyYnhhc3NldGlkOi8vMTIzOTAyNTAyNDM4NzY4CVRleHR1cmVJRAZDb25maWcMV2FpdEZvckNoaWxkDU5vcm1hbFRleHR1cmULSHVydFRleHR1cmUMQmxpbmtUZXh0dXJlFlRyYW5zZm9ybU5vcm1hbFRleHR1cmUUVHJhbnNmb3JtSHVydFRleHR1cmUVVHJhbnNmb3JtQmxpbmtUZXh0dXJlEEh1bWFub2lkUm9vdFBhcnQORmluZEZpcnN0Q2hpbGQJVG9vbkxpZ2h0CkV4dHJhTGlnaHQKUG9pbnRMaWdodAZDb2xvcjMHZnJvbVJHQgVDb2xvcgdUZXh0dXJlG3JieGFzc2V0aWQ6Ly84ODgwODcxMzA5MjUzNxtyYnhhc3NldGlkOi8vOTQzMzM1ODg4MzkwMzMccmJ4YXNzZXRpZDovLzEyNDUyMDYzNjg0NTEwMg1CbGFja291dExpZ2h0CUFwcGx5U2tpbg9WaW50YWdlIEVjbGlwc2UETmFtZQdNYXN0ZXJ5AAISAQAAAAB8pAEBAAAAAEC8AgBHAgAAAJ8CAgCfAQAEFwEIAG8IAwC8BgX+BAAAAJ8GAwIOBgMAbwYFADAGBYQGAAAAbgH3/wIAAABvAwcAvAEA0wgAAACfAQMCbwQJALwCAdMIAAAAnwIDAm8FCgC8AwHTCAAAAJ8DAwJvBgsAvAQB0wgAAACfBAMCbwcMALwFAdMIAAAAnwUDAm8IDQC8BgHTCAAAAJ8GAwJvCQ4AvAcB0wgAAACfBwMCbwoPALwIAAMQAAAAnwgDAlIJCAAOCQQAbwsRALwJCAMQAAAAnwkDAlIKCAAOCgQAbwwSALwKCAMQAAAAnwoDAlILCQAOCwQAbw0TALwLCQMQAAAAnwsDAlIMCgAODAQAbw4TALwMCgMQAAAAnwwDAg4LCACkDRYAAFRAgYwOgACMD4AAjBCAAJ8NBAIwDQukFwAAAA4MCACkDRYAAFRAgYwOgACMD4AAjBCAAJ8NBAIwDQykFwAAAG8NBQAwDQJPGAAAAG8NGQAwDQNPGAAAAG8NGgAwDQRPGAAAAG8NGwAwDQVPGAAAAG8NGQAwDQZPGAAAAG8NGgAwDQdPGAAAAG8PHACpEAEAvA0AAxAAAACfDQQCDg0IAKQOFgAAVECBjA+AAIwQgACMEYAAnw4EAjAODaQXAAAAggABAB0DAQQAAABAAwIDAwMEAwUDBgMHAwgDCQMKAwsDDAMNAw4DDwMQAxEDEgMTAxQDFQQAVECBAxYDFwMYAxkDGgMbAAYcARgAAAAAAAAAAQAAAAABAAD+AAYAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAACAAAAAQAAAAAAAQAAAAAAAQAAAAAAAQAAAAAAAgEAAAAAAAAAAgEAAAAAAAAAAwAAAQAAAQAABQAAAQAAAQAAAwAAAAABAQAAAAAAAAACBwAAAAACAAABAgANowAAAP8AAwAAAAAAbwEAADABALoBAAAAqQEBADABADwCAAAAwAEDADABAOkEAAAAggACAAUDHQMeAx8GAAMcAQABAAEYAAAAAgAAAQAAAgAAMAEAAAAAAcF1BVlbOnfwfJcHvqz2tmmxbRIt87FvWA==

-- https://lua.expert/
return {
	Name = "Vintage Eclipse",
	Mastery = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 6 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://123902502438768"
			end
		end

		local Config = p1:WaitForChild("Config")
		local NormalTexture = Config:WaitForChild("NormalTexture")
		local HurtTexture = Config:WaitForChild("HurtTexture")
		local BlinkTexture = Config:WaitForChild("BlinkTexture")
		local TransformNormalTexture = Config:WaitForChild("TransformNormalTexture")
		local TransformHurtTexture = Config:WaitForChild("TransformHurtTexture")
		local TransformBlinkTexture = Config:WaitForChild("TransformBlinkTexture")
		local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")
		local v1 = if HumanoidRootPart then HumanoidRootPart:FindFirstChild("ToonLight") else HumanoidRootPart
		local v2 = if HumanoidRootPart then HumanoidRootPart:FindFirstChild("ExtraLight") else HumanoidRootPart
		local v3 = if v1 then v1:FindFirstChild("PointLight") else v1
		local v4 = if v2 then v2:FindFirstChild("PointLight") else v2

		if v3 then
			v3.Color = Color3.fromRGB(128, 128, 128)
		end

		if v4 then
			v4.Color = Color3.fromRGB(128, 128, 128)
		end

		NormalTexture.Texture = "rbxassetid://123902502438768"
		HurtTexture.Texture = "rbxassetid://88808713092537"
		BlinkTexture.Texture = "rbxassetid://94333588839033"
		TransformNormalTexture.Texture = "rbxassetid://124520636845102"
		TransformHurtTexture.Texture = "rbxassetid://88808713092537"
		TransformBlinkTexture.Texture = "rbxassetid://94333588839033"

		local BlackoutLight = p1:FindFirstChild("BlackoutLight", true)

		if not BlackoutLight then
			return
		end

		BlackoutLight.Color = Color3.fromRGB(128, 128, 128)
	end
}