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
-- CQMRBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRtyYnhhc3NldGlkOi8vNzg0Nzk5MjYyNDA4ODYJVGV4dHVyZUlEBkNvbmZpZwxXYWl0Rm9yQ2hpbGQLSHVydFRleHR1cmUbcmJ4YXNzZXRpZDovLzg2MjI2NjM0MjU0NzA0B1RleHR1cmUNTm9ybWFsVGV4dHVyZQxCbGlua1RleHR1cmUccmJ4YXNzZXRpZDovLzExMzI0NzExMDQ2NzM3NQlBcHBseVNraW4NVmludGFnZSBMb29leQROYW1lAAIJAQAAAAArpAEBAAAAAEC8AgBHAgAAAJ8CAgCfAQAEFwEIAG8IAwC8BgX+BAAAAJ8GAwIOBgMAbwYFADAGBYQGAAAAbgH3/wIAAABvAwcAvAEA0wgAAACfAQMCbwQJALwCAdMIAAAAnwIDAm8DCgAwAwJPCwAAAG8FDAC8AwHTCAAAAJ8DAwJvBg0AvAQB0wgAAACfBAMCbwUFADAFA08LAAAAbwUOADAFBE8LAAAAggABAA8DAQQAAABAAwIDAwMEAwUDBgMHAwgDCQMKAwsDDAMNAw4ABQ8BGAAAAAAAAAABAAAAAAEAAP4ABgAAAAEAAAACAAACAAAAAQAAAAIAAAEAAAEGAAAAAAIAAAECAAqjAAAA/wACAAAAAABvAQAAMAEAugEAAADAAQIAMAEA6QMAAACCAAIABAMQAxEGAAMPAQABAAEYAAAAAgAAAgAAEwEAAAAAAZ7JsV5ac7Ik/eLCrZbbiuHu0aYqrA3bXw==

-- https://lua.expert/
return {
	Name = "Vintage Looey",
	ApplySkin = function(p1) --[[ ApplySkin | Line: 5 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://78479926240886"
			end
		end

		local Config = p1:WaitForChild("Config")

		Config:WaitForChild("HurtTexture").Texture = "rbxassetid://86226634254704"

		local NormalTexture = Config:WaitForChild("NormalTexture")
		local BlinkTexture = Config:WaitForChild("BlinkTexture")

		NormalTexture.Texture = "rbxassetid://78479926240886"
		BlinkTexture.Texture = "rbxassetid://113247110467375"
	end
}