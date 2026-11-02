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
-- CQMSBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQQROYW1lBkxpZEdlbxxyYnhhc3NldGlkOi8vMTE0NDU5MDc1NzM5MDg5CVRleHR1cmVJRAZDb25maWcMV2FpdEZvckNoaWxkDU5vcm1hbFRleHR1cmULSHVydFRleHR1cmUMQmxpbmtUZXh0dXJlG3JieGFzc2V0aWQ6Ly84OTMyMTgzNjY0MjIxMgdUZXh0dXJlG3JieGFzc2V0aWQ6Ly84NTQ0MjUxMTY0MzIwMQlBcHBseVNraW4MVmludGFnZSBHaWdpAAIJAQAAAAAvpAEBAAAAAEC8AgBHAgAAAJ8CAgCfAQAEFwEMAG8IAwC8BgX+BAAAAJ8GAwIOBgcATQYFugUAAADwBgQABgAAAG8GBwAwBgWECAAAAG4B8/8CAAAAbwMJALwBANMKAAAAnwEDAm8ECwC8AgHTCgAAAJ8CAwJvBQwAvAMB0woAAACfAwMCbwYNALwEAdMKAAAAnwQDAm8FDgAwBQRPDwAAAG8FEAAwBQNPDwAAAG8FBwAwBQJPDwAAAIIAAQARAwEEAAAAQAMCAwMDBAMFAwYDBwMIAwkDCgMLAwwDDQMOAw8DEAAFEQEYAAAAAAAAAAEAAAAAAAAAAAEAAP4ABgAAAAEAAAABAAAAAQAAAAIAAAEAAAEAAAIHAAAAAAIAAAECAAqjAAAA/wACAAAAAABvAQAAMAEAugEAAADAAQIAMAEA6QMAAACCAAIABAMSAwUGAAMRAQABAAEYAAAAAgAAAgAAFQEAAAAAAVHCqHVImkw+CsFCf4bsQ1gh2r8BYwbCdA==

-- https://lua.expert/
return {
	Name = "Vintage Gigi",
	ApplySkin = function(p1) --[[ ApplySkin | Line: 5 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") and v.Name ~= "LidGeo" then
				v.TextureID = "rbxassetid://114459075739089"
			end
		end

		local Config = p1:WaitForChild("Config")
		local NormalTexture = Config:WaitForChild("NormalTexture")
		local HurtTexture = Config:WaitForChild("HurtTexture")

		Config:WaitForChild("BlinkTexture").Texture = "rbxassetid://89321836642212"
		HurtTexture.Texture = "rbxassetid://85442511643201"
		NormalTexture.Texture = "rbxassetid://114459075739089"
	end
}