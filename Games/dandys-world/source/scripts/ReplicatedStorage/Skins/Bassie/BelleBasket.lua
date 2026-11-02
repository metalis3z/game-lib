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
-- CQMoBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRxyYnhhc3NldGlkOi8vMTMxODIxMzAyOTg3MDA4CVRleHR1cmVJRAZDb25maWcMV2FpdEZvckNoaWxkC0h1cnRUZXh0dXJlHHJieGFzc2V0aWQ6Ly8xMTcxMTk2ODMwNTAwMTYHVGV4dHVyZQ1Ob3JtYWxUZXh0dXJlDEJsaW5rVGV4dHVyZRtyYnhhc3NldGlkOi8vOTM5MzE2NTk5OTA1MjIEZ2FtZQ1TZXJ2ZXJTdG9yYWdlEFNraW5Nb2RlbFN0b3JhZ2UKTW9kdWxlTmFtZQVWYWx1ZQZzY3JpcHQETmFtZQVDbG9uZQtHZXRDaGlsZHJlbgNIYXQISW5zdGFuY2UDbmV3BFdlbGQESGVhZAZQYXJlbnQFUGFydDAFUGFydDEIQW5jaG9yZWQMVHJhbnNwYXJlbmN5BkRlYnJpcwpHZXRTZXJ2aWNlB0FkZEl0ZW0JQXBwbHlTa2luDEJlbGxlIEJhc2tldAtIb2xpZGF5U2tpbgpFYXN0ZXJTa2luAAIQAQAAAACbAaQBAQAAAABAvAIARwIAAACfAgIAnwEABBcBCABvCAMAvAYF/gQAAACfBgMCDgYDAG8GBQAwBgWEBgAAAG4B9/8CAAAAbwMHALwBANMIAAAAnwEDAm8ECQC8AgHTCAAAAJ8CAwJvAwoAMAMCTwsAAABvBQwAvAMB0wgAAACfAwMCbwYNALwEAdMIAAAAnwQDAm8FBQAwBQNPCwAAAG8FDgAwBQRPCwAAAKQHEAAAAPBATQcHyBEAAABNBweEEgAAAE0IANkHAAAATQgIXRMAAABNCAjsFAAAAIcGBwikBxYAAABQQU0HB7oXAAAAhwUGB6QHFgAAAFBBTQcHuhcAAACHBgUHvAYGOhgAAACfBgICpAcBAAAAAEC8CAZoGQAAAJ8IAgCfBwAEFwdCAG8OAwC8DAv+BAAAAJ8MAwIODD0ATQwLuhcAAADwDBkAGgAAgKQMHQAAcLCBbw0eAJ8MAgJvDx8AvA0A0wgAAACfDQMCMA0LJCAAAAAwCwwkIAAAADALDDwhAAAAbw8fALwNANMIAAAAnw0DAjANDLEiAAAAqQ0AADANC0UjAAAAZQAhAKQMHQAAcLCBbw0eAJ8MAgJNDwu6FwAAALwNANMIAAAAnw0DAjANCyQgAAAAMAsMJCAAAAAwCww8IQAAAE0PC7oXAAAAvA0A0wgAAACfDQMCMA0MsSIAAACpDQAAMA0LRSMAAABNDwu6FwAAALwNANMIAAAAnw0DAowOAQAwDg3ZJAAAAG4Hvf8CAAAApAcQAAAA8EBvCSUAvAcHFiYAAACfBwMCUgkGAIwKCgC8Bwd4JwAAAJ8HBAGCAAEAKAMBBAAAAEADAgMDAwQDBQMGAwcDCAMJAwoDCwMMAw0DDgMPBAAA8EADEAMRAxIDEwMUBAAAUEEDFQMWAxcDGAMZAxoEAHCwgQMbAxwDHQMeAx8DIAMhAyIDIwMkAAolARgAAAAAAAAAAQAAAAABAAD+AAYAAAABAAAAAgAAAgAAAAEAAAACAAABAAACAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAIAAAAAAAABAAAAAAIAAAABAAAAAQAAAAAAAQABAAEAAAAAAAEAAAACAAAAAQAAAAAAAAEAAQABAAAAAAAAAQAAAQAAAAAAAADvABYAAAAAAAAAAAAAAQsAAAAAAgAAAQIAEKMAAAD/AAMAAAAAAG8BAAAwAQC6AQAAAKkBAQAwAQC8AgAAAKkBAQAwAQDYAwAAAMABBAAwAQDpBQAAAIIAAgAGAyYDFQMnAygGAAMlAQABAAEYAAAAAgAAAgAAAQAABAAALgEAAAAAAYKe5UqFPz7TK24SLuwir13yhvI+sFqPSw==

-- https://lua.expert/
return {
	Name = "Belle Basket",
	HolidaySkin = true,
	EasterSkin = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 10 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://131821302987008"
			end
		end

		local Config = p1:WaitForChild("Config")

		Config:WaitForChild("HurtTexture").Texture = "rbxassetid://117119683050016"

		local NormalTexture = Config:WaitForChild("NormalTexture")
		local BlinkTexture = Config:WaitForChild("BlinkTexture")

		NormalTexture.Texture = "rbxassetid://131821302987008"
		BlinkTexture.Texture = "rbxassetid://93931659990522"

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