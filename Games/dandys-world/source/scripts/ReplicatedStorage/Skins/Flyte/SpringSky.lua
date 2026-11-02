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
-- CQMoBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRtyYnhhc3NldGlkOi8vODgyODY2NzgyODAxNjIJVGV4dHVyZUlEBkNvbmZpZwxXYWl0Rm9yQ2hpbGQLSHVydFRleHR1cmUbcmJ4YXNzZXRpZDovLzc0MzI0MTUxMDg0ODQwB1RleHR1cmUNTm9ybWFsVGV4dHVyZQxCbGlua1RleHR1cmUccmJ4YXNzZXRpZDovLzEzODQwNzgxMzc3MDcwMwRnYW1lDVNlcnZlclN0b3JhZ2UQU2tpbk1vZGVsU3RvcmFnZQpNb2R1bGVOYW1lBVZhbHVlBnNjcmlwdAROYW1lBUNsb25lC0dldENoaWxkcmVuA0hhdAhJbnN0YW5jZQNuZXcEV2VsZARIZWFkBlBhcmVudAVQYXJ0MAVQYXJ0MQhBbmNob3JlZAxUcmFuc3BhcmVuY3kGRGVicmlzCkdldFNlcnZpY2UHQWRkSXRlbQlBcHBseVNraW4KU3ByaW5nIFNreQtIb2xpZGF5U2tpbgpFYXN0ZXJTa2luAAIQAQAAAACbAaQBAQAAAABAvAIARwIAAACfAgIAnwEABBcBCABvCAMAvAYF/gQAAACfBgMCDgYDAG8GBQAwBgWEBgAAAG4B9/8CAAAAbwMHALwBANMIAAAAnwEDAm8ECQC8AgHTCAAAAJ8CAwJvAwoAMAMCTwsAAABvBQwAvAMB0wgAAACfAwMCbwYNALwEAdMIAAAAnwQDAm8FBQAwBQNPCwAAAG8FDgAwBQRPCwAAAKQHEAAAAPBATQcHyBEAAABNBweEEgAAAE0IANkHAAAATQgIXRMAAABNCAjsFAAAAIcGBwikBxYAAABQQU0HB7oXAAAAhwUGB6QHFgAAAFBBTQcHuhcAAACHBgUHvAYGOhgAAACfBgICpAcBAAAAAEC8CAZoGQAAAJ8IAgCfBwAEFwdCAG8OAwC8DAv+BAAAAJ8MAwIODD0ATQwLuhcAAADwDBkAGgAAgKQMHQAAcLCBbw0eAJ8MAgJvDx8AvA0A0wgAAACfDQMCMA0LJCAAAAAwCwwkIAAAADALDDwhAAAAbw8fALwNANMIAAAAnw0DAjANDLEiAAAAqQ0AADANC0UjAAAAZQAhAKQMHQAAcLCBbw0eAJ8MAgJNDwu6FwAAALwNANMIAAAAnw0DAjANCyQgAAAAMAsMJCAAAAAwCww8IQAAAE0PC7oXAAAAvA0A0wgAAACfDQMCMA0MsSIAAACpDQAAMA0LRSMAAABNDwu6FwAAALwNANMIAAAAnw0DAowOAQAwDg3ZJAAAAG4Hvf8CAAAApAcQAAAA8EBvCSUAvAcHFiYAAACfBwMCUgkGAIwKCgC8Bwd4JwAAAJ8HBAGCAAEAKAMBBAAAAEADAgMDAwQDBQMGAwcDCAMJAwoDCwMMAw0DDgMPBAAA8EADEAMRAxIDEwMUBAAAUEEDFQMWAxcDGAMZAxoEAHCwgQMbAxwDHQMeAx8DIAMhAyIDIwMkAAolARgAAAAAAAAAAQAAAAABAAD+AAYAAAABAAAAAgAAAgAAAAEAAAACAAABAAABAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAIAAAAAAAABAAAAAAIAAAABAAAAAQAAAAAAAQABAAEAAAAAAAEAAAACAAAAAQAAAAAAAAEAAQABAAAAAAAAAQAAAQAAAAAAAADvABYAAAAAAAAAAAAAAgsAAAAAAgAAAQIAEKMAAAD/AAMAAAAAAG8BAAAwAQC6AQAAAKkBAQAwAQC8AgAAAKkBAQAwAQDYAwAAAMABBAAwAQDpBQAAAIIAAgAGAyYDFQMnAygGAAMlAQABAAEYAAAAAgAAAgAAAQAABAAALgEAAAAAAcIu5y8zwCcKlMa+jNqlUcayNvBb8OqNLg==

-- https://lua.expert/
return {
	Name = "Spring Sky",
	HolidaySkin = true,
	EasterSkin = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 10 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://88286678280162"
			end
		end

		local Config = p1:WaitForChild("Config")

		Config:WaitForChild("HurtTexture").Texture = "rbxassetid://74324151084840"

		local NormalTexture = Config:WaitForChild("NormalTexture")
		local BlinkTexture = Config:WaitForChild("BlinkTexture")

		NormalTexture.Texture = "rbxassetid://88286678280162"
		BlinkTexture.Texture = "rbxassetid://138407813770703"

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