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
-- CQMRBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRtyYnhhc3NldGlkOi8vOTA3NDk3MDA1MjgzMjQJVGV4dHVyZUlEBkNvbmZpZwxXYWl0Rm9yQ2hpbGQMQmxpbmtUZXh0dXJlC0h1cnRUZXh0dXJlDU5vcm1hbFRleHR1cmUbcmJ4YXNzZXRpZDovLzk5Njg1NjIwMzI2NTAyB1RleHR1cmUbcmJ4YXNzZXRpZDovLzgwMjgwMTcwNTg4MzUwCUFwcGx5U2tpbg5WaW50YWdlIEdpbmdlcgROYW1lAAIJAQAAAAArpAEBAAAAAEC8AgBHAgAAAJ8CAgCfAQAEFwEIAG8IAwC8BgX+BAAAAJ8GAwIOBgMAbwYFADAGBYQGAAAAbgH3/wIAAABvAwcAvAEA0wgAAACfAQMCbwQJALwCAdMIAAAAnwIDAm8FCgC8AwHTCAAAAJ8DAwJvBgsAvAQB0wgAAACfBAMCbwUMADAFAk8NAAAAbwUOADAFA08NAAAAbwUFADAFBE8NAAAAggABAA8DAQQAAABAAwIDAwMEAwUDBgMHAwgDCQMKAwsDDAMNAw4ABQ8BGAAAAAAAAAABAAAAAAEAAP4ABgAAAAIAAAABAAAAAQAAAAIAAAEAAAEAAAEGAAAAAAIAAAECAAqjAAAA/wACAAAAAABvAQAAMAEAugEAAADAAQIAMAEA6QMAAACCAAIABAMQAxEGAAMPAQABAAEYAAAAAgAAAgAAEgEAAAAAAbYUSkCQxf+iV5XKErwrq+rGDF00hNAgQQ==

-- https://lua.expert/
return {
	Name = "Vintage Ginger",
	ApplySkin = function(p1) --[[ ApplySkin | Line: 5 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://90749700528324"
			end
		end

		local Config = p1:WaitForChild("Config")
		local BlinkTexture = Config:WaitForChild("BlinkTexture")
		local HurtTexture = Config:WaitForChild("HurtTexture")
		local NormalTexture = Config:WaitForChild("NormalTexture")

		BlinkTexture.Texture = "rbxassetid://99685620326502"
		HurtTexture.Texture = "rbxassetid://80280170588350"
		NormalTexture.Texture = "rbxassetid://90749700528324"
	end
}