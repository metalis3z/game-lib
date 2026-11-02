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
-- CQMmBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRxyYnhhc3NldGlkOi8vMTM5NDg0NjAyMzg2ODgwCVRleHR1cmVJRAZDb25maWcMV2FpdEZvckNoaWxkC0h1cnRUZXh0dXJlG3JieGFzc2V0aWQ6Ly85NDU5MjExMDg5MTk3MgdUZXh0dXJlDU5vcm1hbFRleHR1cmUMQmxpbmtUZXh0dXJlHHJieGFzc2V0aWQ6Ly8xMzcwMDI0OTU4OTc1MzQEZ2FtZQ1TZXJ2ZXJTdG9yYWdlEFNraW5Nb2RlbFN0b3JhZ2UKTW9kdWxlTmFtZQVWYWx1ZQZzY3JpcHQETmFtZQVDbG9uZQtHZXRDaGlsZHJlbgNIYXQISW5zdGFuY2UDbmV3BFdlbGQESGVhZAZQYXJlbnQFUGFydDAFUGFydDEIQW5jaG9yZWQMVHJhbnNwYXJlbmN5BkRlYnJpcwpHZXRTZXJ2aWNlB0FkZEl0ZW0JQXBwbHlTa2luDkNvbG9yZnVsIEFwcmlsAAIQAQAAAACbAaQBAQAAAABAvAIARwIAAACfAgIAnwEABBcBCABvCAMAvAYF/gQAAACfBgMCDgYDAG8GBQAwBgWEBgAAAG4B9/8CAAAAbwMHALwBANMIAAAAnwEDAm8ECQC8AgHTCAAAAJ8CAwJvAwoAMAMCTwsAAABvBQwAvAMB0wgAAACfAwMCbwYNALwEAdMIAAAAnwQDAm8FBQAwBQNPCwAAAG8FDgAwBQRPCwAAAKQHEAAAAPBATQcHyBEAAABNBweEEgAAAE0IANkHAAAATQgIXRMAAABNCAjsFAAAAIcGBwikBxYAAABQQU0HB7oXAAAAhwUGB6QHFgAAAFBBTQcHuhcAAACHBgUHvAYGOhgAAACfBgICpAcBAAAAAEC8CAZoGQAAAJ8IAgCfBwAEFwdCAG8OAwC8DAv+BAAAAJ8MAwIODD0ATQwLuhcAAADwDBkAGgAAgKQMHQAAcLCBbw0eAJ8MAgJvDx8AvA0A0wgAAACfDQMCMA0LJCAAAAAwCwwkIAAAADALDDwhAAAAbw8fALwNANMIAAAAnw0DAjANDLEiAAAAqQ0AADANC0UjAAAAZQAhAKQMHQAAcLCBbw0eAJ8MAgJNDwu6FwAAALwNANMIAAAAnw0DAjANCyQgAAAAMAsMJCAAAAAwCww8IQAAAE0PC7oXAAAAvA0A0wgAAACfDQMCMA0MsSIAAACpDQAAMA0LRSMAAABNDwu6FwAAALwNANMIAAAAnw0DAowOAQAwDg3ZJAAAAG4Hvf8CAAAApAcQAAAA8EBvCSUAvAcHFiYAAACfBwMCUgkGAIwKCgC8Bwd4JwAAAJ8HBAGCAAEAKAMBBAAAAEADAgMDAwQDBQMGAwcDCAMJAwoDCwMMAw0DDgMPBAAA8EADEAMRAxIDEwMUBAAAUEEDFQMWAxcDGAMZAxoEAHCwgQMbAxwDHQMeAx8DIAMhAyIDIwMkAAclARgAAAAAAAAAAQAAAAABAAD+AAYAAAABAAAAAgAAAgAAAAEAAAACAAABAAACAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAIAAAAAAAABAAAAAAIAAAABAAAAAQAAAAAAAQABAAEAAAAAAAEAAAACAAAAAQAAAAAAAAEAAQABAAAAAAAAAQAAAQAAAAAAAADvABYAAAAAAAAAAAAAAQgAAAAAAgAAAQIACqMAAAD/AAIAAAAAAG8BAAAwAQC6AQAAAMABAgAwAQDpAwAAAIIAAgAEAyYDFQYAAyUBAAEAARgAAAACAAAEAAAuAQAAAAAB0eAhPKqOuozfIRW0gWG/96H4NkjjJEs9

-- https://lua.expert/
return {
	Name = "Colorful April",
	ApplySkin = function(p1) --[[ ApplySkin | Line: 7 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://139484602386880"
			end
		end

		local Config = p1:WaitForChild("Config")

		Config:WaitForChild("HurtTexture").Texture = "rbxassetid://94592110891972"

		local NormalTexture = Config:WaitForChild("NormalTexture")
		local BlinkTexture = Config:WaitForChild("BlinkTexture")

		NormalTexture.Texture = "rbxassetid://139484602386880"
		BlinkTexture.Texture = "rbxassetid://137002495897534"

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