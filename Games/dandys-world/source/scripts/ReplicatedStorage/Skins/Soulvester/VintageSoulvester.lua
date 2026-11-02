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
-- CQMSBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRxyYnhhc3NldGlkOi8vMTExOTM0NDYyMDkxNzAyCVRleHR1cmVJRAZDb25maWcMV2FpdEZvckNoaWxkDU5vcm1hbFRleHR1cmULSHVydFRleHR1cmUMQmxpbmtUZXh0dXJlB1RleHR1cmUccmJ4YXNzZXRpZDovLzEwODEwNTM0NzUyMjI4ORxyYnhhc3NldGlkOi8vMTA4MDU2NzQ0ODQ3MzIyCUFwcGx5U2tpbhJWaW50YWdlIFNvdWx2ZXN0ZXIETmFtZQdNYXN0ZXJ5AAIJAQAAAAArpAEBAAAAAEC8AgBHAgAAAJ8CAgCfAQAEFwEIAG8IAwC8BgX+BAAAAJ8GAwIOBgMAbwYFADAGBYQGAAAAbgH3/wIAAABvAwcAvAEA0wgAAACfAQMCbwQJALwCAdMIAAAAnwIDAm8FCgC8AwHTCAAAAJ8DAwJvBgsAvAQB0wgAAACfBAMCbwUFADAFAk8MAAAAbwUNADAFA08MAAAAbwUOADAFBE8MAAAAggABAA8DAQQAAABAAwIDAwMEAwUDBgMHAwgDCQMKAwsDDAMNAw4ABg8BGAAAAAAAAAABAAAAAAEAAP4ABgAAAAEAAAABAAAAAQAAAAIAAAEAAAEAAAEHAAAAAAIAAAECAA2jAAAA/wADAAAAAABvAQAAMAEAugEAAACpAQEAMAEAPAIAAADAAQMAMAEA6QQAAACCAAIABQMQAxEDEgYAAw8BAAEAARgAAAACAAABAAACAAATAQAAAAAB1uUnrDYbPPhCcqG0RBY8Nab9MNjkIU2t

-- https://lua.expert/
return {
	Name = "Vintage Soulvester",
	Mastery = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 6 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://111934462091702"
			end
		end

		local Config = p1:WaitForChild("Config")
		local NormalTexture = Config:WaitForChild("NormalTexture")
		local HurtTexture = Config:WaitForChild("HurtTexture")
		local BlinkTexture = Config:WaitForChild("BlinkTexture")

		NormalTexture.Texture = "rbxassetid://111934462091702"
		HurtTexture.Texture = "rbxassetid://108105347522289"
		BlinkTexture.Texture = "rbxassetid://108056744847322"
	end
}