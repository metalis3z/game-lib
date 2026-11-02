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
-- CQMXBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRtyYnhhc3NldGlkOi8vOTMyNTk0MTQ2MDE5MDIJVGV4dHVyZUlEBkNvbmZpZwxXYWl0Rm9yQ2hpbGQLSHVydFRleHR1cmUccmJ4YXNzZXRpZDovLzEyMTYxMzY1MTg5MDQ4MQdUZXh0dXJlDU5vcm1hbFRleHR1cmUMQmxpbmtUZXh0dXJlG3JieGFzc2V0aWQ6Ly85MDI5OTc4MTk5NDAyMBBIdW1hbm9pZFJvb3RQYXJ0CVRvb25MaWdodApQb2ludExpZ2h0BkNvbG9yMwdmcm9tUkdCBUNvbG9yCUFwcGx5U2tpbg5WaW50YWdlIENvbm5pZQROYW1lAAIKAQAAAAA5pAEBAAAAAEC8AgBHAgAAAJ8CAgCfAQAEFwEIAG8IAwC8BgX+BAAAAJ8GAwIOBgMAbwYFADAGBYQGAAAAbgH3/wIAAABvAwcAvAEA0wgAAACfAQMCbwQJALwCAdMIAAAAnwIDAm8DCgAwAwJPCwAAAG8FDAC8AwHTCAAAAJ8DAwJvBg0AvAQB0wgAAACfBAMCbwUFADAFA08LAAAAbwUOADAFBE8LAAAATQUAZg8AAABNBQVsEAAAAE0FBTkRAAAApAYUAABMIIGMB88AjAjPAIwJzwCfBgQCMAYFpBUAAACCAAEAFgMBBAAAAEADAgMDAwQDBQMGAwcDCAMJAwoDCwMMAw0DDgMPAxADEQMSAxMEAEwggQMUAAUVARgAAAAAAAAAAQAAAAABAAD+AAYAAAABAAAAAgAAAgAAAAEAAAACAAABAAACAAAAAAAAAAAAAAAAAAIGAAAAAAIAAAECAAqjAAAA/wACAAAAAABvAQAAMAEAugEAAADAAQIAMAEA6QMAAACCAAIABAMWAxcGAAMVAQABAAEYAAAAAgAAAgAAFgEAAAAAAWz/Ct/ESXB288PwZN3cn/8c5x2rXjtg3g==

-- https://lua.expert/
return {
	Name = "Vintage Connie",
	ApplySkin = function(p1) --[[ ApplySkin | Line: 5 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://93259414601902"
			end
		end

		local Config = p1:WaitForChild("Config")

		Config:WaitForChild("HurtTexture").Texture = "rbxassetid://121613651890481"

		local NormalTexture = Config:WaitForChild("NormalTexture")
		local BlinkTexture = Config:WaitForChild("BlinkTexture")

		NormalTexture.Texture = "rbxassetid://93259414601902"
		BlinkTexture.Texture = "rbxassetid://90299781994020"
		p1.HumanoidRootPart.ToonLight.PointLight.Color = Color3.fromRGB(207, 207, 207)
	end
}