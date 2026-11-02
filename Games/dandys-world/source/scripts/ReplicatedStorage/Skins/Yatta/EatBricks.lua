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
-- CQMoBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRxyYnhhc3NldGlkOi8vMTA3ODUwODMyOTM5MzUyCVRleHR1cmVJRAZDb25maWcMV2FpdEZvckNoaWxkC0h1cnRUZXh0dXJlG3JieGFzc2V0aWQ6Ly85NzQ2ODg4MDMzOTQ3MgdUZXh0dXJlDU5vcm1hbFRleHR1cmUMQmxpbmtUZXh0dXJlG3JieGFzc2V0aWQ6Ly83NjQ2ODMxMTMyNzE0MgRnYW1lDVNlcnZlclN0b3JhZ2UQU2tpbk1vZGVsU3RvcmFnZQpNb2R1bGVOYW1lBVZhbHVlBnNjcmlwdAROYW1lBUNsb25lC0dldENoaWxkcmVuA0hhdAhJbnN0YW5jZQNuZXcEV2VsZARIZWFkBlBhcmVudAVQYXJ0MAVQYXJ0MQhBbmNob3JlZAxUcmFuc3BhcmVuY3kGRGVicmlzCkdldFNlcnZpY2UHQWRkSXRlbQlBcHBseVNraW4QR3Vlc3MgV2hhdCBJIEVhdARDb3N0CkRhbmR5U3RvcmUAAhABAAAAAJsBpAEBAAAAAEC8AgBHAgAAAJ8CAgCfAQAEFwEIAG8IAwC8BgX+BAAAAJ8GAwIOBgMAbwYFADAGBYQGAAAAbgH3/wIAAABvAwcAvAEA0wgAAACfAQMCbwQJALwCAdMIAAAAnwIDAm8DCgAwAwJPCwAAAG8FDAC8AwHTCAAAAJ8DAwJvBg0AvAQB0wgAAACfBAMCbwUFADAFA08LAAAAbwUOADAFBE8LAAAApAcQAAAA8EBNBwfIEQAAAE0HB4QSAAAATQgA2QcAAABNCAhdEwAAAE0ICOwUAAAAhwYHCKQHFgAAAFBBTQcHuhcAAACHBQYHpAcWAAAAUEFNBwe6FwAAAIcGBQe8BgY6GAAAAJ8GAgKkBwEAAAAAQLwIBmgZAAAAnwgCAJ8HAAQXB0IAbw4DALwMC/4EAAAAnwwDAg4MPQBNDAu6FwAAAPAMGQAaAACApAwdAABwsIFvDR4AnwwCAm8PHwC8DQDTCAAAAJ8NAwIwDQskIAAAADALDCQgAAAAMAsMPCEAAABvDx8AvA0A0wgAAACfDQMCMA0MsSIAAACpDQAAMA0LRSMAAABlACEApAwdAABwsIFvDR4AnwwCAk0PC7oXAAAAvA0A0wgAAACfDQMCMA0LJCAAAAAwCwwkIAAAADALDDwhAAAATQ8LuhcAAAC8DQDTCAAAAJ8NAwIwDQyxIgAAAKkNAAAwDQtFIwAAAE0PC7oXAAAAvA0A0wgAAACfDQMCjA4BADAODdkkAAAAbge9/wIAAACkBxAAAADwQG8JJQC8BwcWJgAAAJ8HAwJSCQYAjAoKALwHB3gnAAAAnwcEAYIAAQAoAwEEAAAAQAMCAwMDBAMFAwYDBwMIAwkDCgMLAwwDDQMOAw8EAADwQAMQAxEDEgMTAxQEAABQQQMVAxYDFwMYAxkDGgQAcLCBAxsDHAMdAx4DHwMgAyEDIgMjAyQACyUBGAAAAAAAAAABAAAAAAEAAP4ABgAAAAEAAAACAAACAAAAAQAAAAIAAAEAAAIAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAwAAAAAAAAEAAAAAAgAAAAEAAAABAAAAAAABAAEAAQAAAAAAAQAAAAIAAAABAAAAAAAAAQABAAEAAAAAAAABAAABAAAAAAAAAO8AFgAAAAAAAAAAAAABDAAAAAACAAABAgAQowAAAP8AAwAAAAAAbwEAADABALoBAAAAjAFYAjABACMCAAAAqQEBADABAE4DAAAAwAEEADABAOkFAAAAggACAAYDJgMVAycDKAYAAyUBAAEAARgAAAACAAADAAABAAAEAAAvAQAAAAABQJ6RAEh05Vu4Vb9AZnGNCTCGhnRyWvsB

-- https://lua.expert/
return {
	Name = "Guess What I Eat",
	Cost = 600,
	DandyStore = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 11 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://107850832939352"
			end
		end

		local Config = p1:WaitForChild("Config")

		Config:WaitForChild("HurtTexture").Texture = "rbxassetid://97468880339472"

		local NormalTexture = Config:WaitForChild("NormalTexture")
		local BlinkTexture = Config:WaitForChild("BlinkTexture")

		NormalTexture.Texture = "rbxassetid://107850832939352"
		BlinkTexture.Texture = "rbxassetid://76468311327142"

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