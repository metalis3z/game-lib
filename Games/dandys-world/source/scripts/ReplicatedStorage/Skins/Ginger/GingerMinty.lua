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
-- CQMlBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRxyYnhhc3NldGlkOi8vMTIzMTU0MTM4MjY1MDk4CVRleHR1cmVJRAZDb25maWcMV2FpdEZvckNoaWxkC0h1cnRUZXh0dXJlHHJieGFzc2V0aWQ6Ly8xMjE3MDkwOTY5NjMzMDMHVGV4dHVyZQ1Ob3JtYWxUZXh0dXJlDEJsaW5rVGV4dHVyZRxyYnhhc3NldGlkOi8vMTMzODg5ODcyNDQwODM5BGdhbWUNU2VydmVyU3RvcmFnZRBTa2luTW9kZWxTdG9yYWdlCk1vZHVsZU5hbWUFVmFsdWUGc2NyaXB0BE5hbWUFQ2xvbmULR2V0Q2hpbGRyZW4ISW5zdGFuY2UDbmV3BFdlbGQGUGFyZW50BVBhcnQwBVBhcnQxCEFuY2hvcmVkDFRyYW5zcGFyZW5jeQZEZWJyaXMKR2V0U2VydmljZQdBZGRJdGVtCUFwcGx5U2tpbgtHaW5nZXIgTWludAtIb2xpZGF5U2tpbgACEAEAAAAAf6QBAQAAAABAvAIARwIAAACfAgIAnwEABBcBCABvCAMAvAYF/gQAAACfBgMCDgYDAG8GBQAwBgWEBgAAAG4B9/8CAAAAbwMHALwBANMIAAAAnwEDAm8ECQC8AgHTCAAAAJ8CAwJvAwoAMAMCTwsAAABvBQwAvAMB0wgAAACfAwMCbwQFADAEA08LAAAAbwYNALwEAdMIAAAAnwQDAm8FDgAwBQRPCwAAAKQHEAAAAPBATQcHyBEAAABNBweEEgAAAE0IANkHAAAATQgIXRMAAABNCAjsFAAAAIcGBwikBxYAAABQQU0HB7oXAAAAhwUGB6QHFgAAAFBBTQcHuhcAAACHBgUHvAYGOhgAAACfBgICpAcBAAAAAEC8CAZoGQAAAJ8IAgCfBwAEFwcmAG8OAwC8DAv+BAAAAJ8MAwIODCEApAwcAABsoIFvDR0AnwwCAk0PC7oXAAAAvA0A0wgAAACfDQMCMA0LJB4AAAAwCwwkHgAAADALDDwfAAAATQ8LuhcAAAC8DQDTCAAAAJ8NAwIwDQyxIAAAAKkNAAAwDQtFIQAAAE0PC7oXAAAAvA0A0wgAAACfDQMCjA4BADAODdkiAAAAbgfZ/wIAAACkBxAAAADwQG8JIwC8BwcWJAAAAJ8HAwJSCQYAjAoKALwHB3glAAAAnwcEAYIAAQAmAwEEAAAAQAMCAwMDBAMFAwYDBwMIAwkDCgMLAwwDDQMOAw8EAADwQAMQAxEDEgMTAxQEAABQQQMVAxYDFwMYAxkEAGyggQMaAxsDHAMdAx4DHwMgAyEDIgAGIwEYAAAAAAAAAAEAAAAAAQAA/gAGAAAAAQAAAAIAAAIAAAABAAACAAAAAQAAAgAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAPAAAAAAAAAQAAAAACAAAAAQAAAAAAAAEAAQABAAAAAAAAAQAAAQAAAAAAAAD3AA0AAAAAAAAAAAAAAgcAAAAAAgAAAQIADaMAAAD/AAMAAAAAAG8BAAAwAQC6AQAAAKkBAQAwAQC8AgAAAMABAwAwAQDpBAAAAIIAAgAFAyQDFQMlBgADIwEAAQABGAAAAAIAAAEAAAIAADMBAAAAAAE2gJnzky14PgKJhH6xaWu0RpiOhwRE8/I=

-- https://lua.expert/
return {
	Name = "Ginger Mint",
	HolidaySkin = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 6 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://123154138265098"
			end
		end

		local Config = p1:WaitForChild("Config")

		Config:WaitForChild("HurtTexture").Texture = "rbxassetid://121709096963303"
		Config:WaitForChild("NormalTexture").Texture = "rbxassetid://123154138265098"
		Config:WaitForChild("BlinkTexture").Texture = "rbxassetid://133889872440839"

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