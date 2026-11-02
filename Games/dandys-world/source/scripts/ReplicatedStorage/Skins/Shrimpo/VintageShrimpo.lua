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
-- CQMkBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRxyYnhhc3NldGlkOi8vMTA0OTE1ODU3ODIwOTA2CVRleHR1cmVJRAZDb25maWcMV2FpdEZvckNoaWxkC0h1cnRUZXh0dXJlHHJieGFzc2V0aWQ6Ly8xMjI0MjU5NTc1ODYyNDUHVGV4dHVyZQ1Ob3JtYWxUZXh0dXJlDEJsaW5rVGV4dHVyZRxyYnhhc3NldGlkOi8vMTM3OTYxNjgyMTAwOTUzBGdhbWUNU2VydmVyU3RvcmFnZRBTa2luTW9kZWxTdG9yYWdlCk1vZHVsZU5hbWUFVmFsdWUGc2NyaXB0BE5hbWUFQ2xvbmULR2V0Q2hpbGRyZW4ISW5zdGFuY2UDbmV3BFdlbGQGUGFyZW50BVBhcnQwBVBhcnQxCEFuY2hvcmVkDFRyYW5zcGFyZW5jeQZEZWJyaXMKR2V0U2VydmljZQdBZGRJdGVtCUFwcGx5U2tpbg9WaW50YWdlIFNocmltcG8AAhABAAAAAH+kAQEAAAAAQLwCAEcCAAAAnwICAJ8BAAQXAQgAbwgDALwGBf4EAAAAnwYDAg4GAwBvBgUAMAYFhAYAAABuAff/AgAAAG8DBwC8AQDTCAAAAJ8BAwJvBAkAvAIB0wgAAACfAgMCbwMKADADAk8LAAAAbwUMALwDAdMIAAAAnwMDAm8EBQAwBANPCwAAAG8GDQC8BAHTCAAAAJ8EAwJvBQ4AMAUETwsAAACkBxAAAADwQE0HB8gRAAAATQcHhBIAAABNCADZBwAAAE0ICF0TAAAATQgI7BQAAACHBgcIpAcWAAAAUEFNBwe6FwAAAIcFBgekBxYAAABQQU0HB7oXAAAAhwYFB7wGBjoYAAAAnwYCAqQHAQAAAABAvAgGaBkAAACfCAIAnwcABBcHJgBvDgMAvAwL/gQAAACfDAMCDgwhAKQMHAAAbKCBbw0dAJ8MAgJNDwu6FwAAALwNANMIAAAAnw0DAjANCyQeAAAAMAsMJB4AAAAwCww8HwAAAE0PC7oXAAAAvA0A0wgAAACfDQMCMA0MsSAAAACpDQAAMA0LRSEAAABNDwu6FwAAALwNANMIAAAAnw0DAowOAQAwDg3ZIgAAAG4H2f8CAAAApAcQAAAA8EBvCSMAvAcHFiQAAACfBwMCUgkGAIwKCgC8Bwd4JQAAAJ8HBAGCAAEAJgMBBAAAAEADAgMDAwQDBQMGAwcDCAMJAwoDCwMMAw0DDgMPBAAA8EADEAMRAxIDEwMUBAAAUEEDFQMWAxcDGAMZBABsoIEDGgMbAxwDHQMeAx8DIAMhAyIABSMBGAAAAAAAAAABAAAAAAEAAP4ABgAAAAEAAAACAAACAAAAAQAAAgAAAAEAAAIAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAgAAAAAAAAEAAAAAAQAAAAEAAAAAAAABAAEAAQAAAAAAAAEAAAEAAAAAAAAA+AAMAAAAAAAAAAAAAAEGAAAAAAIAAAECAAqjAAAA/wACAAAAAABvAQAAMAEAugEAAADAAQIAMAEA6QMAAACCAAIABAMkAxUGAAMjAQABAAEYAAAAAgAAAgAAJgEAAAAAAct5tdLKM5TI5mgR4+zjbdG7YaKm+b3f0w==

-- https://lua.expert/
return {
	Name = "Vintage Shrimpo",
	ApplySkin = function(p1) --[[ ApplySkin | Line: 5 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://104915857820906"
			end
		end

		local Config = p1:WaitForChild("Config")

		Config:WaitForChild("HurtTexture").Texture = "rbxassetid://122425957586245"
		Config:WaitForChild("NormalTexture").Texture = "rbxassetid://104915857820906"
		Config:WaitForChild("BlinkTexture").Texture = "rbxassetid://137961682100953"

		local v1 = game.ServerStorage.SkinModelStorage[p1.Config.ModuleName.Value][script.Name][script.Name]:Clone()

		for k, v in pairs(v1:GetChildren()) do
			if v:IsA("MeshPart") then
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