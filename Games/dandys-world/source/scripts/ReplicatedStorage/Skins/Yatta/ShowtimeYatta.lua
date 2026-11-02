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
-- CQMmBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRxyYnhhc3NldGlkOi8vMTAyOTg4MjA0OTk4NDQwCVRleHR1cmVJRAZDb25maWcMV2FpdEZvckNoaWxkC0h1cnRUZXh0dXJlG3JieGFzc2V0aWQ6Ly85NjQzODQ1OTQ4NjQwNgdUZXh0dXJlDU5vcm1hbFRleHR1cmUMQmxpbmtUZXh0dXJlHHJieGFzc2V0aWQ6Ly8xMzMyODU2MTE4OTcwNzkEZ2FtZQ1TZXJ2ZXJTdG9yYWdlEFNraW5Nb2RlbFN0b3JhZ2UKTW9kdWxlTmFtZQVWYWx1ZQZzY3JpcHQETmFtZQVDbG9uZQtHZXRDaGlsZHJlbgNIYXQISW5zdGFuY2UDbmV3BFdlbGQESGVhZAZQYXJlbnQFUGFydDAFUGFydDEIQW5jaG9yZWQMVHJhbnNwYXJlbmN5BkRlYnJpcwpHZXRTZXJ2aWNlB0FkZEl0ZW0JQXBwbHlTa2luD1Nob3ctVGltZSBZYXR0YQACEAEAAAAAmwGkAQEAAAAAQLwCAEcCAAAAnwICAJ8BAAQXAQgAbwgDALwGBf4EAAAAnwYDAg4GAwBvBgUAMAYFhAYAAABuAff/AgAAAG8DBwC8AQDTCAAAAJ8BAwJvBAkAvAIB0wgAAACfAgMCbwMKADADAk8LAAAAbwUMALwDAdMIAAAAnwMDAm8GDQC8BAHTCAAAAJ8EAwJvBQUAMAUDTwsAAABvBQ4AMAUETwsAAACkBxAAAADwQE0HB8gRAAAATQcHhBIAAABNCADZBwAAAE0ICF0TAAAATQgI7BQAAACHBgcIpAcWAAAAUEFNBwe6FwAAAIcFBgekBxYAAABQQU0HB7oXAAAAhwYFB7wGBjoYAAAAnwYCAqQHAQAAAABAvAgGaBkAAACfCAIAnwcABBcHQgBvDgMAvAwL/gQAAACfDAMCDgw9AE0MC7oXAAAA8AwZABoAAICkDB0AAHCwgW8NHgCfDAICbw8fALwNANMIAAAAnw0DAjANCyQgAAAAMAsMJCAAAAAwCww8IQAAAG8PHwC8DQDTCAAAAJ8NAwIwDQyxIgAAAKkNAAAwDQtFIwAAAGUAIQCkDB0AAHCwgW8NHgCfDAICTQ8LuhcAAAC8DQDTCAAAAJ8NAwIwDQskIAAAADALDCQgAAAAMAsMPCEAAABNDwu6FwAAALwNANMIAAAAnw0DAjANDLEiAAAAqQ0AADANC0UjAAAATQ8LuhcAAAC8DQDTCAAAAJ8NAwKMDgEAMA4N2SQAAABuB73/AgAAAKQHEAAAAPBAbwklALwHBxYmAAAAnwcDAlIJBgCMCgoAvAcHeCcAAACfBwQBggABACgDAQQAAABAAwIDAwMEAwUDBgMHAwgDCQMKAwsDDAMNAw4DDwQAAPBAAxADEQMSAxMDFAQAAFBBAxUDFgMXAxgDGQMaBABwsIEDGwMcAx0DHgMfAyADIQMiAyMDJAAJJQEYAAAAAAAAAAEAAAAAAQAA/gAGAAAAAQAAAAIAAAIAAAABAAAAAgAAAQAAAgAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAACAAAAAAAAAQAAAAACAAAAAQAAAAEAAAAAAAEAAQABAAAAAAABAAAAAgAAAAEAAAAAAAABAAEAAQAAAAAAAAEAAAEAAAAAAAAA7wAWAAAAAAAAAAAAAAEKAAAAAAIAAAECAAqjAAAA/wACAAAAAABvAQAAMAEAugEAAADAAQIAMAEA6QMAAACCAAIABAMmAxUGAAMlAQABAAEYAAAAAgAABgAALgEAAAAAAfUnnShHwzTmNA9zwm459B2FP4pcx+P3KQ==

-- https://lua.expert/
return {
	Name = "Show-Time Yatta",
	ApplySkin = function(p1) --[[ ApplySkin | Line: 9 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://102988204998440"
			end
		end

		local Config = p1:WaitForChild("Config")

		Config:WaitForChild("HurtTexture").Texture = "rbxassetid://96438459486406"

		local NormalTexture = Config:WaitForChild("NormalTexture")
		local BlinkTexture = Config:WaitForChild("BlinkTexture")

		NormalTexture.Texture = "rbxassetid://102988204998440"
		BlinkTexture.Texture = "rbxassetid://133285611897079"

		local v1 = game.ServerStorage.SkinModelStorage[p1.Config.ModuleName.Value][script.Name][script.Name]:Clone()

		for k, v in pairs(v1:GetChildren()) do
			if v:IsA("MeshPart") then
				if v.Name == "Hat" then
					local Weld = Instance.new("Weld")

					v.Parent = p1:WaitForChild("Head")
					Weld.Parent = v
					Weld.Part0 = v
					Weld.Part1 = p1:WaitForChild("Head")
					v.Anchored = false

					continue
				end

				local Weld = Instance.new("Weld")

				v.Parent = p1:WaitForChild(v.Name)
				Weld.Parent = v
				Weld.Part0 = v
				Weld.Part1 = p1:WaitForChild(v.Name)
				v.Anchored = false
				p1:WaitForChild(v.Name).Transparency = 1
			end
		end

		game:GetService("Debris"):AddItem(v1, 10)
	end
}