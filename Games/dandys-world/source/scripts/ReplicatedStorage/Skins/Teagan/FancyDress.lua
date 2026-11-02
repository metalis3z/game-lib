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
-- CQMkBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRxyYnhhc3NldGlkOi8vMTI1NDMzNjYzNjAwMTEwCVRleHR1cmVJRAZDb25maWcMV2FpdEZvckNoaWxkDEJsaW5rVGV4dHVyZQtIdXJ0VGV4dHVyZQ1Ob3JtYWxUZXh0dXJlG3JieGFzc2V0aWQ6Ly83Njc1NTEwNDgyMjczOAdUZXh0dXJlHHJieGFzc2V0aWQ6Ly8xMzgxMjk3NjUxNjc2MTUEZ2FtZQ1TZXJ2ZXJTdG9yYWdlEFNraW5Nb2RlbFN0b3JhZ2UKTW9kdWxlTmFtZQVWYWx1ZQZzY3JpcHQETmFtZQVDbG9uZQtHZXRDaGlsZHJlbghJbnN0YW5jZQNuZXcEV2VsZAZQYXJlbnQFUGFydDAFUGFydDEIQW5jaG9yZWQMVHJhbnNwYXJlbmN5BkRlYnJpcwpHZXRTZXJ2aWNlB0FkZEl0ZW0JQXBwbHlTa2luD1B1cnBsZSBFbGVnYW5jZQACEgEAAAAAfKQBAQAAAABAvAIARwIAAACfAgIAnwEABBcBCABvCAMAvAYF/gQAAACfBgMCDgYDAG8GBQAwBgWEBgAAAG4B9/8CAAAAbwMHALwBANMIAAAAnwEDAm8ECQC8AgHTCAAAAJ8CAwJvBQoAvAMB0wgAAACfAwMCbwYLALwEAdMIAAAAnwQDAm8FDAAwBQJPDQAAAG8FDgAwBQNPDQAAAG8FBQAwBQRPDQAAAKQHEAAAAPBATQcHyBEAAABNBweEEgAAAE0IANkHAAAATQgIXRMAAABNCAjsFAAAAIcGBwikBxYAAABQQU0HB7oXAAAAhwUGB6QHFgAAAFBBTQcHuhcAAACHBgUHvAYGOhgAAACfBgIC/wcAAAAAAACkCAEAAAAAQLwJBmgZAAAAnwkCAJ8IAAQXCCEAbw8DALwNDP4EAAAAnw0DAg4NHACkDRwAAGyggW8OHQCfDQICTQ8MuhcAAACHDgcPKw4CAE0ODLoXAAAAUhEOALwPANMIAAAAnw8DAjAPDCQeAAAAMAwNJB4AAAAwDA08HwAAADAPDbEgAAAAqRAAADAQDEUhAAAAjBABADAQD9kiAAAAbgje/wIAAACkCBAAAADwQG8KIwC8CAgWJAAAAJ8IAwJSCgYAjAsKALwICHglAAAAnwgEAYIAAQAmAwEEAAAAQAMCAwMDBAMFAwYDBwMIAwkDCgMLAwwDDQMOAw8EAADwQAMQAxEDEgMTAxQEAABQQQMVAxYDFwMYAxkEAGyggQMaAxsDHAMdAx4DHwMgAyEDIgAFIwEYAAAAAAAAAAEAAAAAAQAA/gAGAAAAAQAAAAEAAAABAAAAAgAAAQAAAQAAAgAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAACAAMAAAAAAAABAAAAAAEAAAABAAAAAAABAAAAAQABAAEAAQABAAABAAD2AA4AAAAAAAAAAAAAAgcAAAAAAgAAAQIACqMAAAD/AAIAAAAAAG8BAAAwAQC6AQAAAMABAgAwAQDpAwAAAIIAAgAEAyQDFQYAAyMBAAEAARgAAAACAAACAAArAQAAAAABOfV+0iEzG5B2lwO+dbS8V0ntaaYLMRTT

-- https://lua.expert/
return {
	Name = "Purple Elegance",
	ApplySkin = function(p1) --[[ ApplySkin | Line: 5 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://125433663600110"
			end
		end

		local Config = p1:WaitForChild("Config")
		local BlinkTexture = Config:WaitForChild("BlinkTexture")
		local HurtTexture = Config:WaitForChild("HurtTexture")
		local NormalTexture = Config:WaitForChild("NormalTexture")

		BlinkTexture.Texture = "rbxassetid://76755104822738"
		HurtTexture.Texture = "rbxassetid://138129765167615"
		NormalTexture.Texture = "rbxassetid://125433663600110"

		local v1 = game.ServerStorage.SkinModelStorage[p1.Config.ModuleName.Value][script.Name][script.Name]:Clone()
		local t = {}

		for k, v in pairs(v1:GetChildren()) do
			if v:IsA("MeshPart") then
				local Weld = Instance.new("Weld")
				local v3 = p1:WaitForChild(t[v.Name] or v.Name)

				v.Parent = v3
				Weld.Parent = v
				Weld.Part0 = v
				Weld.Part1 = v3
				v.Anchored = false
				v3.Transparency = 1
			end
		end

		game:GetService("Debris"):AddItem(v1, 10)
	end
}