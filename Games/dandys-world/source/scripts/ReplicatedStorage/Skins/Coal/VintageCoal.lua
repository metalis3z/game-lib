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
-- CQMRBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRtyYnhhc3NldGlkOi8vODU4MzQ1NzUzMTY2MDAJVGV4dHVyZUlEBkNvbmZpZwxXYWl0Rm9yQ2hpbGQMQmxpbmtUZXh0dXJlC0h1cnRUZXh0dXJlDU5vcm1hbFRleHR1cmUccmJ4YXNzZXRpZDovLzExNDE1MjkzODY5ODYxNgdUZXh0dXJlHHJieGFzc2V0aWQ6Ly8xMTc2MzAwMjU5MTEwMDAJQXBwbHlTa2luDFZpbnRhZ2UgQ29hbAROYW1lAAIJAQAAAAArpAEBAAAAAEC8AgBHAgAAAJ8CAgCfAQAEFwEIAG8IAwC8BgX+BAAAAJ8GAwIOBgMAbwYFADAGBYQGAAAAbgH3/wIAAABvAwcAvAEA0wgAAACfAQMCbwQJALwCAdMIAAAAnwIDAm8FCgC8AwHTCAAAAJ8DAwJvBgsAvAQB0wgAAACfBAMCbwUMADAFAk8NAAAAbwUOADAFA08NAAAAbwUFADAFBE8NAAAAggABAA8DAQQAAABAAwIDAwMEAwUDBgMHAwgDCQMKAwsDDAMNAw4ABQ8BGAAAAAAAAAABAAAAAAEAAP4ABgAAAAIAAAABAAAAAQAAAAIAAAEAAAEAAAEGAAAAAAIAAAECAAqjAAAA/wACAAAAAABvAQAAMAEAugEAAADAAQIAMAEA6QMAAACCAAIABAMQAxEGAAMPAQABAAEYAAAAAgAAAgAAEgEAAAAAAVM2qPwwlkSRiy2O6jvZbvojLr+IYfLC/Q==

-- https://lua.expert/
return {
	Name = "Vintage Coal",
	ApplySkin = function(p1) --[[ ApplySkin | Line: 5 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://85834575316600"
			end
		end

		local Config = p1:WaitForChild("Config")
		local BlinkTexture = Config:WaitForChild("BlinkTexture")
		local HurtTexture = Config:WaitForChild("HurtTexture")
		local NormalTexture = Config:WaitForChild("NormalTexture")

		BlinkTexture.Texture = "rbxassetid://114152938698616"
		HurtTexture.Texture = "rbxassetid://117630025911000"
		NormalTexture.Texture = "rbxassetid://85834575316600"
	end
}