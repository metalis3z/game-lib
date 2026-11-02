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
-- CQMlBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRxyYnhhc3NldGlkOi8vMTE4ODA3OTA3MjU3OTg5CVRleHR1cmVJRAZDb25maWcMV2FpdEZvckNoaWxkC0h1cnRUZXh0dXJlHHJieGFzc2V0aWQ6Ly8xMTg1NzY2NjgxODI3MzgHVGV4dHVyZQ1Ob3JtYWxUZXh0dXJlDEJsaW5rVGV4dHVyZRxyYnhhc3NldGlkOi8vMTM4MjY2NDk3MjE4MzcyBGdhbWUNU2VydmVyU3RvcmFnZRBTa2luTW9kZWxTdG9yYWdlCk1vZHVsZU5hbWUFVmFsdWUGc2NyaXB0BE5hbWUFQ2xvbmULR2V0Q2hpbGRyZW4DSGF0CEluc3RhbmNlA25ldwRXZWxkBEhlYWQGUGFyZW50BVBhcnQwBVBhcnQxCEFuY2hvcmVkDFRyYW5zcGFyZW5jeQlBcHBseVNraW4MQ2xvdWR5IERyZWFtCkRhbmR5U3RvcmUEQ29zdAACEgEAAAAAqgGkAQEAAAAAQLwCAEcCAAAAnwICAJ8BAAQXAQgAbwgDALwGBf4EAAAAnwYDAg4GAwBvBgUAMAYFhAYAAABuAff/AgAAAG8DBwC8AQDTCAAAAJ8BAwJvBAkAvAIB0wgAAACfAgMCbwMKADADAk8LAAAAbwUMALwDAdMIAAAAnwMDAm8EBQAwBANPCwAAAG8GDQC8BAHTCAAAAJ8EAwJvBQ4AMAUETwsAAACkBxAAAADwQE0HB8gRAAAATQcHhBIAAABNCADZBwAAAE0ICF0TAAAATQgI7BQAAACHBgcIpAcWAAAAUEFNBwe6FwAAAIcFBgekBxYAAABQQU0HB7oXAAAAhwYFB7wGBjoYAAAAnwYCAqQJEAAAAPBATQkJyBEAAABNCQmEEgAAAE0KANkHAAAATQoKXRMAAABNCgrsFAAAAIcICQqkCRYAAABQQU0JCboXAAAAhwcICaQJFgAAAFBBTQkJuhcAAACHCAcJvAgIOhgAAACfCAICpAkBAAAAAEC8CghoGQAAAJ8KAgCfCQAEFwlCAG8QAwC8Dg3+BAAAAJ8OAwIODj0ATQ4NuhcAAADwDhkAGgAAgKQOHQAAcLCBbw8eAJ8OAgJvER8AvA8A0wgAAACfDwMCMA8NJCAAAAAwDQ4kIAAAADANDjwhAAAAbxEfALwPANMIAAAAnw8DAjAPDrEiAAAAqQ8AADAPDUUjAAAAZQAhAKQOHQAAcLCBbw8eAJ8OAgJNEQ26FwAAALwPANMIAAAAnw8DAjAPDSQgAAAAMA0OJCAAAAAwDQ48IQAAAE0RDboXAAAAvA8A0wgAAACfDwMCMA8OsSIAAACpDwAAMA8NRSMAAABNEQ26FwAAALwPANMIAAAAnw8DAowQAQAwEA/ZJAAAAG4Jvf8CAAAAggABACUDAQQAAABAAwIDAwMEAwUDBgMHAwgDCQMKAwsDDAMNAw4DDwQAAPBAAxADEQMSAxMDFAQAAFBBAxUDFgMXAxgDGQMaBABwsIEDGwMcAx0DHgMfAyADIQAHIgEYAAAAAAAAAAEAAAAAAQAA/gAGAAAAAQAAAAIAAAMAAAACAAACAAAAAgAAAgAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAHAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAIAAAAAAAABAAAAAAIAAAABAAAAAQAAAAAAAQABAAEAAAAAAAEAAAACAAAAAQAAAAAAAAEAAQABAAAAAAAAAQAAAQAAAAAAAADvABYIAAAAAAIAAAECABCjAAAA/wADAAAAAABvAQAAMAEAugEAAACpAQEAMAEATgIAAACMAVgCMAEAIwMAAADAAQQAMAEA6QUAAACCAAIABgMjAxUDJAMlBgADIgEAAQABGAAAAAIAAAEAAAEAAAIAADoBAAAAAAFC9Tu7G4IKT4pXBpDWpumVMu0sz3AxUbo=

-- https://lua.expert/
return {
	Name = "Cloudy Dream",
	DandyStore = true,
	Cost = 600,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 7 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://118807907257989"
			end
		end

		local Config = p1:WaitForChild("Config")

		Config:WaitForChild("HurtTexture").Texture = "rbxassetid://118576668182738"
		Config:WaitForChild("NormalTexture").Texture = "rbxassetid://118807907257989"
		Config:WaitForChild("BlinkTexture").Texture = "rbxassetid://138266497218372"
		game.ServerStorage.SkinModelStorage[p1.Config.ModuleName.Value][script.Name][script.Name]:Clone()

		for k, v in pairs(game.ServerStorage.SkinModelStorage[p1.Config.ModuleName.Value][script.Name][script.Name]:Clone():GetChildren()) do
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
	end
}