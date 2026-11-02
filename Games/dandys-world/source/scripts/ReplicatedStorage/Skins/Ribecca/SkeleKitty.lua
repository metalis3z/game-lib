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
-- CQMsBGdhbWUNU2VydmVyU3RvcmFnZRBTa2luTW9kZWxTdG9yYWdlBkNvbmZpZwpNb2R1bGVOYW1lBVZhbHVlBnNjcmlwdAROYW1lBUNsb25lDFdhaXRGb3JDaGlsZAxCbGlua1RleHR1cmULSHVydFRleHR1cmUNTm9ybWFsVGV4dHVyZRxyYnhhc3NldGlkOi8vMTE5NDQyNjM2OTk2Mzk5B1RleHR1cmUbcmJ4YXNzZXRpZDovLzgyMDYwMTE0MjIwMjY3HHJieGFzc2V0aWQ6Ly8xMTQxMjAxNzMxMDgyMTEISGVhZF9nZW8ESGVhZAVwYWlycwtHZXRDaGlsZHJlbghNZXNoUGFydANJc0EISW5zdGFuY2UDbmV3BFdlbGQGUGFyZW50BVBhcnQwBVBhcnQxCEFuY2hvcmVkDFRyYW5zcGFyZW5jeQZEZWJyaXMKR2V0U2VydmljZQdBZGRJdGVtCUFwcGx5U2tpbgtTa2VsZS1LaXR0eQdSaWJlY2NhCVRvd2VyTmFtZRJObyBkZXNjcmlwdGlvbiB5ZXQLRGVzY3JpcHRpb24HTWFzdGVyeQRDb3N0CUhhbGxvd2VlbgtIb2xpZGF5U2tpbgACEgEAAAAAbqQDAQAAAABATQMDyAIAAABNAwOEAwAAAE0EANkEAAAATQQEXQUAAABNBATsBgAAAIcCAwSkAwgAAABwQE0DA7oJAAAAhwECA6QDCAAAAHBATQMDugkAAACHAgEDvAICOgoAAACfAgICbwUEALwDANMLAAAAnwMDAm8GDAC8BAPTCwAAAJ8EAwJvBw0AvAUD0wsAAACfBQMCbwgOALwGA9MLAAAAnwYDAm8HDwAwBwRPEAAAAG8HEQAwBwVPEAAAAG8HEgAwBwZPEAAAAP8HAQAAAAAAbwgTADAIBxMUAAAApAgWAAAAUEG8CQJoFwAAAJ8JAgCfCAAEFwghAG8PGAC8DQz+GQAAAJ8NAwIODRwApA0cAABsoIFvDh0Anw0CAk0PDLoJAAAAhw4HDysOAgBNDgy6CQAAAFIRDgC8DwDTCwAAAJ8PAwIwDwwkHgAAADAMDSQeAAAAMAwNPB8AAAAwDw2xIAAAAKkQAAAwEAxFIQAAAIwQAQAwEA/ZIgAAAG4I3v8CAAAApAgBAAAAAEBvCiMAvAgIFiQAAACfCAMCUgoCAIwLCgC8CAh4JQAAAJ8IBAGCAAEAJgMBBAAAAEADAgMDAwQDBQMGAwcEAABwQAMIAwkDCgMLAwwDDQMOAw8DEAMRAxIDEwMUBAAAUEEDFQMWAxcDGAMZBABsoIEDGgMbAxwDHQMeAx8DIAMhAyIADiMBGAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAgAAAAEAAAABAAAAAQAAAAIAAAEAAAEAAAMAAQAAAwAAAAAAAAEAAAAAAQAAAAEAAAAAAAEAAAABAAEAAQABAAEAAAEAAPYADgAAAAAAAAAAAAABEAAAAAACAAABAgAcowAAAP8ABAAAAAAAbwEAADABALoBAAAAbwECADABAIcDAAAAbwEEADABAOIFAAAAqQEAADABADwGAAAAjAFYAjABACMHAAAAqQEBADABAGkIAAAAqQEBADABALwJAAAAwAEKADABAOkLAAAAggACAAwDJAMIAyUDJgMnAygDKQMqAysDLAYAAyMBAAEAARgAAAACAAABAAABAAABAAACAAADAAABAAACAAAkAQAAAAABO2lRnfO7eIXJCbxF4VVnMUtxRukJrTuc

-- https://lua.expert/
return {
	Name = "Skele-Kitty",
	TowerName = "Ribecca",
	Description = "No description yet",
	Mastery = false,
	Cost = 600,
	Halloween = true,
	HolidaySkin = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 14 ]]
		local v1 = game.ServerStorage.SkinModelStorage[p1.Config.ModuleName.Value][script.Name][script.Name]:Clone()
		local Config = p1:WaitForChild("Config")
		local BlinkTexture = Config:WaitForChild("BlinkTexture")
		local HurtTexture = Config:WaitForChild("HurtTexture")
		local NormalTexture = Config:WaitForChild("NormalTexture")

		BlinkTexture.Texture = "rbxassetid://119442636996399"
		HurtTexture.Texture = "rbxassetid://82060114220267"
		NormalTexture.Texture = "rbxassetid://114120173108211"

		local t = {
			Head = "Head_geo"
		}

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