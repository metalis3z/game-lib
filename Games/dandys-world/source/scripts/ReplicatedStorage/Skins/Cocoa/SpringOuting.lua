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
-- CQMoBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRxyYnhhc3NldGlkOi8vMTA2ODcwOTc4Mzg0NjI5CVRleHR1cmVJRAZDb25maWcMV2FpdEZvckNoaWxkC0h1cnRUZXh0dXJlHHJieGFzc2V0aWQ6Ly8xNDAyOTQwNDAyODA2OTIHVGV4dHVyZQ1Ob3JtYWxUZXh0dXJlDEJsaW5rVGV4dHVyZRxyYnhhc3NldGlkOi8vMTI3Mzc1ODQ4NzI1OTc3BGdhbWUNU2VydmVyU3RvcmFnZRBTa2luTW9kZWxTdG9yYWdlCk1vZHVsZU5hbWUFVmFsdWUGc2NyaXB0BE5hbWUFQ2xvbmULR2V0Q2hpbGRyZW4DSGF0CEluc3RhbmNlA25ldwRXZWxkBEhlYWQGUGFyZW50BVBhcnQwBVBhcnQxCEFuY2hvcmVkDFRyYW5zcGFyZW5jeQZEZWJyaXMKR2V0U2VydmljZQdBZGRJdGVtCUFwcGx5U2tpbg1TcHJpbmcgT3V0aW5nC0hvbGlkYXlTa2luCkVhc3RlclNraW4AAhABAAAAAJsBpAEBAAAAAEC8AgBHAgAAAJ8CAgCfAQAEFwEIAG8IAwC8BgX+BAAAAJ8GAwIOBgMAbwYFADAGBYQGAAAAbgH3/wIAAABvAwcAvAEA0wgAAACfAQMCbwQJALwCAdMIAAAAnwIDAm8DCgAwAwJPCwAAAG8FDAC8AwHTCAAAAJ8DAwJvBg0AvAQB0wgAAACfBAMCbwUFADAFA08LAAAAbwUOADAFBE8LAAAApAcQAAAA8EBNBwfIEQAAAE0HB4QSAAAATQgA2QcAAABNCAhdEwAAAE0ICOwUAAAAhwYHCKQHFgAAAFBBTQcHuhcAAACHBQYHpAcWAAAAUEFNBwe6FwAAAIcGBQe8BgY6GAAAAJ8GAgKkBwEAAAAAQLwIBmgZAAAAnwgCAJ8HAAQXB0IAbw4DALwMC/4EAAAAnwwDAg4MPQBNDAu6FwAAAPAMGQAaAACApAwdAABwsIFvDR4AnwwCAm8PHwC8DQDTCAAAAJ8NAwIwDQskIAAAADALDCQgAAAAMAsMPCEAAABvDx8AvA0A0wgAAACfDQMCMA0MsSIAAACpDQAAMA0LRSMAAABlACEApAwdAABwsIFvDR4AnwwCAk0PC7oXAAAAvA0A0wgAAACfDQMCMA0LJCAAAAAwCwwkIAAAADALDDwhAAAATQ8LuhcAAAC8DQDTCAAAAJ8NAwIwDQyxIgAAAKkNAAAwDQtFIwAAAE0PC7oXAAAAvA0A0wgAAACfDQMCjA4BADAODdkkAAAAbge9/wIAAACkBxAAAADwQG8JJQC8BwcWJgAAAJ8HAwJSCQYAjAoKALwHB3gnAAAAnwcEAYIAAQAoAwEEAAAAQAMCAwMDBAMFAwYDBwMIAwkDCgMLAwwDDQMOAw8EAADwQAMQAxEDEgMTAxQEAABQQQMVAxYDFwMYAxkDGgQAcLCBAxsDHAMdAx4DHwMgAyEDIgMjAyQACSUBGAAAAAAAAAABAAAAAAEAAP4ABgAAAAEAAAACAAACAAAAAQAAAAIAAAEAAAIAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAgAAAAAAAAEAAAAAAgAAAAEAAAABAAAAAAABAAEAAQAAAAAAAQAAAAIAAAABAAAAAAAAAQABAAEAAAAAAAABAAABAAAAAAAAAO8AFgAAAAAAAAAAAAABCgAAAAACAAABAgAQowAAAP8AAwAAAAAAbwEAADABALoBAAAAqQEBADABALwCAAAAqQEBADABANgDAAAAwAEEADABAOkFAAAAggACAAYDJgMVAycDKAYAAyUBAAEAARgAAAACAAACAAABAAADAAAuAQAAAAABqTGNiSL/M2DzyXXZD35SP9kpmv2b9eeI

-- https://lua.expert/
return {
	Name = "Spring Outing",
	HolidaySkin = true,
	EasterSkin = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 9 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://106870978384629"
			end
		end

		local Config = p1:WaitForChild("Config")

		Config:WaitForChild("HurtTexture").Texture = "rbxassetid://140294040280692"

		local NormalTexture = Config:WaitForChild("NormalTexture")
		local BlinkTexture = Config:WaitForChild("BlinkTexture")

		NormalTexture.Texture = "rbxassetid://106870978384629"
		BlinkTexture.Texture = "rbxassetid://127375848725977"

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