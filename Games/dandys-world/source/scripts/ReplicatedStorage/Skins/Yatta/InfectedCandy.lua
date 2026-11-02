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
-- CQMsBkNvbmZpZwxXYWl0Rm9yQ2hpbGQMQmxpbmtUZXh0dXJlC0h1cnRUZXh0dXJlDU5vcm1hbFRleHR1cmUccmJ4YXNzZXRpZDovLzEzNjY3MjA4OTUwNTk0NQdUZXh0dXJlG3JieGFzc2V0aWQ6Ly84NjA2MDgzNTA5NjY3MxtyYnhhc3NldGlkOi8vODI0NzU2ODg0NTYyNDEEZ2FtZQ1TZXJ2ZXJTdG9yYWdlEFNraW5Nb2RlbFN0b3JhZ2UKTW9kdWxlTmFtZQVWYWx1ZQZzY3JpcHQETmFtZQVDbG9uZQ1SaWdodExvd2VyTGVnDVJpZ2h0TG93ZXJsZWcFcGFpcnMLR2V0Q2hpbGRyZW4ITWVzaFBhcnQDSXNBCEluc3RhbmNlA25ldwRXZWxkBlBhcmVudAVQYXJ0MAVQYXJ0MQhBbmNob3JlZAxUcmFuc3BhcmVuY3kGRGVicmlzCkdldFNlcnZpY2UHQWRkSXRlbQlBcHBseVNraW4OSW5mZWN0ZWQgQ2FuZHkFWWF0dGEJVG93ZXJOYW1lEk5vIGRlc2NyaXB0aW9uIHlldAtEZXNjcmlwdGlvbgdNYXN0ZXJ5BENvc3QJSGFsbG93ZWVuC0hvbGlkYXlTa2luAAISAQAAAABubwMAALwBANMBAAAAnwEDAm8EAgC8AgHTAQAAAJ8CAwJvBQMAvAMB0wEAAACfAwMCbwYEALwEAdMBAAAAnwQDAm8FBQAwBQJPBgAAAG8FBwAwBQNPBgAAAG8FCAAwBQRPBgAAAKQHCgAAAJBATQcHyAsAAABNBweEDAAAAE0IANkAAAAATQgIXQ0AAABNCAjsDgAAAIcGBwikBxAAAADwQE0HB7oRAAAAhwUGB6QHEAAAAPBATQcHuhEAAACHBgUHvAYGOhIAAACfBgIC/wcBAAAAAABvCBMAMAgHyhQAAACkCBYAAABQQbwJBmgXAAAAnwkCAJ8IAAQXCCEAbw8YALwNDP4ZAAAAnw0DAg4NHACkDRwAAGyggW8OHQCfDQICTQ8MuhEAAACHDgcPKw4CAE0ODLoRAAAAUhEOALwPANMBAAAAnw8DAjAPDCQeAAAAMAwNJB4AAAAwDA08HwAAADAPDbEgAAAAqRAAADAQDEUhAAAAjBABADAQD9kiAAAAbgje/wIAAACkCAoAAACQQG8KIwC8CAgWJAAAAJ8IAwJSCgYAjAsKALwICHglAAAAnwgEAYIAAQAmAwEDAgMDAwQDBQMGAwcDCAMJAwoEAACQQAMLAwwDDQMOAw8EAADwQAMQAxEDEgMTAxQEAABQQQMVAxYDFwMYAxkEAGyggQMaAxsDHAMdAx4DHwMgAyEDIgAOIwEYAAAAAAIAAAABAAAAAQAAAAIAAAEAAAEAAAIAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAgABAAADAAAAAAAAAQAAAAABAAAAAQAAAAAAAQAAAAEAAQABAAEAAQAAAQAA9gAOAAAAAAAAAAAAAAEQAAAAAAIAAAECAByjAAAA/wAEAAAAAABvAQAAMAEAugEAAABvAQIAMAEAhwMAAABvAQQAMAEA4gUAAACpAQAAMAEAPAYAAACMAVgCMAEAIwcAAACpAQEAMAEAaQgAAACpAQEAMAEAvAkAAADAAQoAMAEA6QsAAACCAAIADAMkAxADJQMmAycDKAMpAyoDKwMsBgADIwEAAQABGAAAAAIAAAEAAAEAAAEAAAIAAAEAAAEAAAQAACQBAAAAAAEihn85bkGfqO/oMxGE+DgvUp5oTRBCFTg=

-- https://lua.expert/
return {
	Name = "Infected Candy",
	TowerName = "Yatta",
	Description = "No description yet",
	Mastery = false,
	Cost = 600,
	Halloween = true,
	HolidaySkin = true,
	ApplySkin = function(p1) --[[ ApplySkin | Line: 14 ]]
		local Config = p1:WaitForChild("Config")
		local BlinkTexture = Config:WaitForChild("BlinkTexture")
		local HurtTexture = Config:WaitForChild("HurtTexture")
		local NormalTexture = Config:WaitForChild("NormalTexture")

		BlinkTexture.Texture = "rbxassetid://136672089505945"
		HurtTexture.Texture = "rbxassetid://86060835096673"
		NormalTexture.Texture = "rbxassetid://82475688456241"

		local v1 = game.ServerStorage.SkinModelStorage[p1.Config.ModuleName.Value][script.Name][script.Name]:Clone()
		local t = {
			RightLowerleg = "RightLowerLeg"
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