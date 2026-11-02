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
-- CQMlBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRxyYnhhc3NldGlkOi8vMTQwNTU3Nzc2MDI5NjQ2CVRleHR1cmVJRAZDb25maWcMV2FpdEZvckNoaWxkC0h1cnRUZXh0dXJlHHJieGFzc2V0aWQ6Ly8xMTAzMTY4MjIxNjQzOTIHVGV4dHVyZQ1Ob3JtYWxUZXh0dXJlDEJsaW5rVGV4dHVyZRtyYnhhc3NldGlkOi8vODY3ODIzMzk4MDE1MTEEZ2FtZQ1TZXJ2ZXJTdG9yYWdlEFNraW5Nb2RlbFN0b3JhZ2UKTW9kdWxlTmFtZQVWYWx1ZQZzY3JpcHQETmFtZQVDbG9uZQtHZXRDaGlsZHJlbghJbnN0YW5jZQNuZXcEV2VsZAZQYXJlbnQFUGFydDAFUGFydDEIQW5jaG9yZWQMVHJhbnNwYXJlbmN5BkRlYnJpcwpHZXRTZXJ2aWNlB0FkZEl0ZW0JQXBwbHlTa2luDFByZXNlbnQgQ29hbAtIb2xpZGF5U2tpbgACEAEAAAAAf6QBAQAAAABAvAIARwIAAACfAgIAnwEABBcBCABvCAMAvAYF/gQAAACfBgMCDgYDAG8GBQAwBgWEBgAAAG4B9/8CAAAAbwMHALwBANMIAAAAnwEDAm8ECQC8AgHTCAAAAJ8CAwJvAwoAMAMCTwsAAABvBQwAvAMB0wgAAACfAwMCbwQFADAEA08LAAAAbwYNALwEAdMIAAAAnwQDAm8FDgAwBQRPCwAAAKQHEAAAAPBATQcHyBEAAABNBweEEgAAAE0IANkHAAAATQgIXRMAAABNCAjsFAAAAIcGBwikBxYAAABQQU0HB7oXAAAAhwUGB6QHFgAAAFBBTQcHuhcAAACHBgUHvAYGOhgAAACfBgICpAcBAAAAAEC8CAZoGQAAAJ8IAgCfBwAEFwcmAG8OAwC8DAv+BAAAAJ8MAwIODCEApAwcAABsoIFvDR0AnwwCAk0PC7oXAAAAvA0A0wgAAACfDQMCMA0LJB4AAAAwCwwkHgAAADALDDwfAAAATQ8LuhcAAAC8DQDTCAAAAJ8NAwIwDQyxIAAAAKkNAAAwDQtFIQAAAE0PC7oXAAAAvA0A0wgAAACfDQMCjA4BADAODdkiAAAAbgfZ/wIAAACkBxAAAADwQG8JIwC8BwcWJAAAAJ8HAwJSCQYAjAoKALwHB3glAAAAnwcEAYIAAQAmAwEEAAAAQAMCAwMDBAMFAwYDBwMIAwkDCgMLAwwDDQMOAw8EAADwQAMQAxEDEgMTAxQEAABQQQMVAxYDFwMYAxkEAGyggQMaAxsDHAMdAx4DHwMgAyEDIgAGIwEYAAAAAAAAAAEAAAAAAQAA/gAGAAAAAQAAAAIAAAIAAAABAAACAAAAAQAAAwAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAPAAAAAAAAAQAAAAACAAAAAQAAAAAAAAEAAQABAAAAAAAAAQAAAQAAAAAAAAD3AA0AAAAAAAAAAAAAAgcAAAAAAgAAAQIADaMAAAD/AAMAAAAAAG8BAAAwAQC6AQAAAKkBAQAwAQC8AgAAAMABAwAwAQDpBAAAAIIAAgAFAyQDFQMlBgADIwEAAQABGAAAAAIAAAEAAAIAADQBAAAAAAH1XqgwU0Dq7vm6rAqOKuMhhUa/RMeawjE=

-- https://lua.expert/
return {
	Name = "Present Coal",
	HolidaySkin = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 6 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://140557776029646"
			end
		end

		local Config = p1:WaitForChild("Config")

		Config:WaitForChild("HurtTexture").Texture = "rbxassetid://110316822164392"
		Config:WaitForChild("NormalTexture").Texture = "rbxassetid://140557776029646"
		Config:WaitForChild("BlinkTexture").Texture = "rbxassetid://86782339801511"

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