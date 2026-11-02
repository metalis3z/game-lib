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
-- CQMoBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRxyYnhhc3NldGlkOi8vMTIxMzUwMDQ0NDM5Nzg2CVRleHR1cmVJRAZDb25maWcMV2FpdEZvckNoaWxkC0h1cnRUZXh0dXJlHHJieGFzc2V0aWQ6Ly8xMDA5OTk2NDQ1MTU3MjUHVGV4dHVyZQ1Ob3JtYWxUZXh0dXJlDEJsaW5rVGV4dHVyZRxyYnhhc3NldGlkOi8vMTI0NjkyNjM0MDM5MzE5BGdhbWUNU2VydmVyU3RvcmFnZRBTa2luTW9kZWxTdG9yYWdlCk1vZHVsZU5hbWUFVmFsdWUGc2NyaXB0BE5hbWUFQ2xvbmULR2V0Q2hpbGRyZW4DSGF0CEluc3RhbmNlA25ldwRXZWxkBEhlYWQGUGFyZW50BVBhcnQwBVBhcnQxCEFuY2hvcmVkDFRyYW5zcGFyZW5jeQZEZWJyaXMKR2V0U2VydmljZQdBZGRJdGVtCUFwcGx5U2tpbg9Td2lybGluZyBNaXggVXALSG9saWRheVNraW4KRWFzdGVyU2tpbgACEAEAAAAAmwGkAQEAAAAAQLwCAEcCAAAAnwICAJ8BAAQXAQgAbwgDALwGBf4EAAAAnwYDAg4GAwBvBgUAMAYFhAYAAABuAff/AgAAAG8DBwC8AQDTCAAAAJ8BAwJvBAkAvAIB0wgAAACfAgMCbwMKADADAk8LAAAAbwUMALwDAdMIAAAAnwMDAm8EBQAwBANPCwAAAG8GDQC8BAHTCAAAAJ8EAwJvBQ4AMAUETwsAAACkBxAAAADwQE0HB8gRAAAATQcHhBIAAABNCADZBwAAAE0ICF0TAAAATQgI7BQAAACHBgcIpAcWAAAAUEFNBwe6FwAAAIcFBgekBxYAAABQQU0HB7oXAAAAhwYFB7wGBjoYAAAAnwYCAqQHAQAAAABAvAgGaBkAAACfCAIAnwcABBcHQgBvDgMAvAwL/gQAAACfDAMCDgw9AE0MC7oXAAAA8AwZABoAAICkDB0AAHCwgW8NHgCfDAICbw8fALwNANMIAAAAnw0DAjANCyQgAAAAMAsMJCAAAAAwCww8IQAAAG8PHwC8DQDTCAAAAJ8NAwIwDQyxIgAAAKkNAAAwDQtFIwAAAGUAIQCkDB0AAHCwgW8NHgCfDAICTQ8LuhcAAAC8DQDTCAAAAJ8NAwIwDQskIAAAADALDCQgAAAAMAsMPCEAAABNDwu6FwAAALwNANMIAAAAnw0DAjANDLEiAAAAqQ0AADANC0UjAAAATQ8LuhcAAAC8DQDTCAAAAJ8NAwKMDgEAMA4N2SQAAABuB73/AgAAAKQHEAAAAPBAbwklALwHBxYmAAAAnwcDAlIJBgCMCgoAvAcHeCcAAACfBwQBggABACgDAQQAAABAAwIDAwMEAwUDBgMHAwgDCQMKAwsDDAMNAw4DDwQAAPBAAxADEQMSAxMDFAQAAFBBAxUDFgMXAxgDGQMaBABwsIEDGwMcAx0DHgMfAyADIQMiAyMDJAAGJQEYAAAAAAAAAAEAAAAAAQAA/gAGAAAAAQAAAAIAAAIAAAABAAACAAAAAQAAAgAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAACAAAAAAAAAQAAAAACAAAAAQAAAAEAAAAAAAEAAQABAAAAAAABAAAAAgAAAAEAAAAAAAABAAEAAQAAAAAAAAEAAAEAAAAAAAAA7wAWAAAAAAAAAAAAAAEHAAAAAAIAAAECABCjAAAA/wADAAAAAABvAQAAMAEAugEAAACpAQEAMAEAvAIAAACpAQEAMAEA2AMAAADAAQQAMAEA6QUAAACCAAIABgMmAxUDJwMoBgADJQEAAQABGAAAAAIAAAEAAAEAAAEAAC4BAAAAAAHtgv8yBKcHmG/9z1/JFYK/nZroRt9GlTM=

-- https://lua.expert/
return {
	Name = "Swirling Mix Up",
	HolidaySkin = true,
	EasterSkin = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 6 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://121350044439786"
			end
		end

		local Config = p1:WaitForChild("Config")

		Config:WaitForChild("HurtTexture").Texture = "rbxassetid://100999644515725"
		Config:WaitForChild("NormalTexture").Texture = "rbxassetid://121350044439786"
		Config:WaitForChild("BlinkTexture").Texture = "rbxassetid://124692634039319"

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