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
-- CQMYBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRxyYnhhc3NldGlkOi8vMTI5NzUzMzM1ODE3MDEzCVRleHR1cmVJRAZDb25maWcMV2FpdEZvckNoaWxkC0h1cnRUZXh0dXJlG3JieGFzc2V0aWQ6Ly85MDQwNzE5MjI3ODA2NwdUZXh0dXJlDU5vcm1hbFRleHR1cmUMQmxpbmtUZXh0dXJlG3JieGFzc2V0aWQ6Ly85MTE5NzkyMDM1MTkxMBBIdW1hbm9pZFJvb3RQYXJ0CVRvb25MaWdodApQb2ludExpZ2h0BkNvbG9yMwdmcm9tUkdCBUNvbG9yCUFwcGx5U2tpbgtWaW50YWdlIFZlZQROYW1lB01hc3RlcnkAAgoBAAAAADmkAQEAAAAAQLwCAEcCAAAAnwICAJ8BAAQXAQgAbwgDALwGBf4EAAAAnwYDAg4GAwBvBgUAMAYFhAYAAABuAff/AgAAAG8DBwC8AQDTCAAAAJ8BAwJvBAkAvAIB0wgAAACfAgMCbwMKADADAk8LAAAAbwUMALwDAdMIAAAAnwMDAm8GDQC8BAHTCAAAAJ8EAwJvBQUAMAUDTwsAAABvBQ4AMAUETwsAAABNBQBmDwAAAE0FBWwQAAAATQUFOREAAACkBhQAAEwggYwHzwCMCM8AjAnPAJ8GBAIwBgWkFQAAAIIAAQAWAwEEAAAAQAMCAwMDBAMFAwYDBwMIAwkDCgMLAwwDDQMOAw8DEAMRAxIDEwQATCCBAxQABhUBGAAAAAAAAAABAAAAAAEAAP4ABgAAAAEAAAACAAACAAAAAQAAAAIAAAEAAAIAAAAAAAAAAAAAAAAAAQcAAAAAAgAAAQIADaMAAAD/AAMAAAAAAG8BAAAwAQC6AQAAAKkBAQAwAQA8AgAAAMABAwAwAQDpBAAAAIIAAgAFAxYDFwMYBgADFQEAAQABGAAAAAIAAAEAAAIAABcBAAAAAAHXX2CB52bUu//fqh+oQ5VEp0d39eWbCoA=

-- https://lua.expert/
return {
	Name = "Vintage Vee",
	Mastery = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 6 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://129753335817013"
			end
		end

		local Config = p1:WaitForChild("Config")

		Config:WaitForChild("HurtTexture").Texture = "rbxassetid://90407192278067"

		local NormalTexture = Config:WaitForChild("NormalTexture")
		local BlinkTexture = Config:WaitForChild("BlinkTexture")

		NormalTexture.Texture = "rbxassetid://129753335817013"
		BlinkTexture.Texture = "rbxassetid://91197920351910"
		p1.HumanoidRootPart.ToonLight.PointLight.Color = Color3.fromRGB(207, 207, 207)
	end
}