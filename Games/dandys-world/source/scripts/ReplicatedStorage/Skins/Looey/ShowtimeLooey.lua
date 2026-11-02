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
-- CQMnBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRxyYnhhc3NldGlkOi8vMTM2MzExNjI4Mzg2MjQxCVRleHR1cmVJRAROYW1lCkxvd2VyVG9yc28MVHJhbnNwYXJlbmN5BkNvbmZpZwxXYWl0Rm9yQ2hpbGQLSHVydFRleHR1cmUbcmJ4YXNzZXRpZDovLzc2MzU3NDk5MTk1MzE4B1RleHR1cmUNTm9ybWFsVGV4dHVyZQxCbGlua1RleHR1cmUccmJ4YXNzZXRpZDovLzEwMTg3Mzk5NTk5NDU3OQRnYW1lDVNlcnZlclN0b3JhZ2UQU2tpbk1vZGVsU3RvcmFnZQpNb2R1bGVOYW1lBVZhbHVlBnNjcmlwdAVDbG9uZQtHZXRDaGlsZHJlbgNIYXQISW5zdGFuY2UDbmV3BFdlbGQESGVhZAZQYXJlbnQFUGFydDAFUGFydDEIQW5jaG9yZWQGRGVicmlzCkdldFNlcnZpY2UHQWRkSXRlbQlBcHBseVNraW4PU2hvdy1UaW1lIExvb2V5AAIQAQAAAACiAaQBAQAAAABAvAIARwIAAACfAgIAnwEABBcBDwBvCAMAvAYF/gQAAACfBgMCDgYDAG8GBQAwBgWEBgAAAE0GBboHAAAA8AYEAAgAAICMBgEAMAYF2QkAAABuAfD/AgAAAG8DCgC8AQDTCwAAAJ8BAwJvBAwAvAIB0wsAAACfAgMCbwMNADADAk8OAAAAbwUPALwDAdMLAAAAnwMDAm8EBQAwBANPDgAAAG8GEAC8BAHTCwAAAJ8EAwJvBREAMAUETw4AAACkBxMAAAAgQU0HB8gUAAAATQcHhBUAAABNCADZCgAAAE0ICF0WAAAATQgI7BcAAACHBgcIpAcZAAAAgEFNBwe6BwAAAIcFBgekBxkAAACAQU0HB7oHAAAAhwYFB7wGBjoaAAAAnwYCAqQHAQAAAABAvAgGaBsAAACfCAIAnwcABBcHQgBvDgMAvAwL/gQAAACfDAMCDgw9AE0MC7oHAAAA8AwZABwAAICkDB8AAHjQgW8NIACfDAICbw8hALwNANMLAAAAnw0DAjANCyQiAAAAMAsMJCIAAAAwCww8IwAAAG8PIQC8DQDTCwAAAJ8NAwIwDQyxJAAAAKkNAAAwDQtFJQAAAGUAIQCkDB8AAHjQgW8NIACfDAICTQ8LugcAAAC8DQDTCwAAAJ8NAwIwDQskIgAAADALDCQiAAAAMAsMPCMAAABNDwu6BwAAALwNANMLAAAAnw0DAjANDLEkAAAAqQ0AADANC0UlAAAATQ8LugcAAAC8DQDTCwAAAJ8NAwKMDgEAMA4N2QkAAABuB73/AgAAAKQHEwAAACBBbwkmALwHBxYnAAAAnwcDAlIJBgCMCgoAvAcHeCgAAACfBwQBggABACkDAQQAAABAAwIDAwMEAwUDBgMHAwgDCQMKAwsDDAMNAw4DDwMQAxEDEgQAACBBAxMDFAMVAxYDFwQAAIBBAxgDGQMaAxsDHAQAeNCBAx0DHgMfAyADIQMiAyMDJAMlAAUmARgAAAAAAAAAAQAAAAABAAADAAAAAQAA+gAKAAAAAQAAAAIAAAIAAAABAAACAAAAAQAAAgAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAACAAAAAAAAAQAAAAACAAAAAQAAAAEAAAAAAAEAAQABAAAAAAABAAAAAgAAAAEAAAAAAAABAAEAAQAAAAAAAAEAAAEAAAAAAAAA7wAWAAAAAAAAAAAAAAEGAAAAAAIAAAECAAqjAAAA/wACAAAAAABvAQAAMAEAugEAAADAAQIAMAEA6QMAAACCAAIABAMnAwcGAAMmAQABAAEYAAAAAgAAAgAAMgEAAAAAAWmiuyXFDrDDYt9pmE8LP5QZuqxRW2bRJA==

-- https://lua.expert/
return {
	Name = "Show-Time Looey",
	ApplySkin = function(p1) --[[ ApplySkin | Line: 5 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://136311628386241"
			end

			if v.Name == "LowerTorso" then
				v.Transparency = 1
			end
		end

		local Config = p1:WaitForChild("Config")

		Config:WaitForChild("HurtTexture").Texture = "rbxassetid://76357499195318"
		Config:WaitForChild("NormalTexture").Texture = "rbxassetid://136311628386241"
		Config:WaitForChild("BlinkTexture").Texture = "rbxassetid://101873995994579"

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