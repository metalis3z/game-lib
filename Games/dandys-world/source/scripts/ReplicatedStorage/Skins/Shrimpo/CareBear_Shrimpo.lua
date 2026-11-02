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
-- CQMkBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRtyYnhhc3NldGlkOi8vODM2MzQxODM4MTc1OTQJVGV4dHVyZUlEBkNvbmZpZwxXYWl0Rm9yQ2hpbGQLSHVydFRleHR1cmUccmJ4YXNzZXRpZDovLzEwNzk0ODA4NTE2MzQ0NQdUZXh0dXJlDU5vcm1hbFRleHR1cmUMQmxpbmtUZXh0dXJlHHJieGFzc2V0aWQ6Ly8xMTA2Mjc5NzY4Mjk5ODMEZ2FtZQ1TZXJ2ZXJTdG9yYWdlEFNraW5Nb2RlbFN0b3JhZ2UKTW9kdWxlTmFtZQVWYWx1ZQZzY3JpcHQETmFtZQVDbG9uZQtHZXRDaGlsZHJlbghJbnN0YW5jZQNuZXcEV2VsZAZQYXJlbnQFUGFydDAFUGFydDEIQW5jaG9yZWQMVHJhbnNwYXJlbmN5BkRlYnJpcwpHZXRTZXJ2aWNlB0FkZEl0ZW0JQXBwbHlTa2luC0dydW1weSBCZWFyAAIQAQAAAAB/pAEBAAAAAEC8AgBHAgAAAJ8CAgCfAQAEFwEIAG8IAwC8BgX+BAAAAJ8GAwIOBgMAbwYFADAGBYQGAAAAbgH3/wIAAABvAwcAvAEA0wgAAACfAQMCbwQJALwCAdMIAAAAnwIDAm8DCgAwAwJPCwAAAG8FDAC8AwHTCAAAAJ8DAwJvBAUAMAQDTwsAAABvBg0AvAQB0wgAAACfBAMCbwUOADAFBE8LAAAApAcQAAAA8EBNBwfIEQAAAE0HB4QSAAAATQgA2QcAAABNCAhdEwAAAE0ICOwUAAAAhwYHCKQHFgAAAFBBTQcHuhcAAACHBQYHpAcWAAAAUEFNBwe6FwAAAIcGBQe8BgY6GAAAAJ8GAgKkBwEAAAAAQLwIBmgZAAAAnwgCAJ8HAAQXByYAbw4DALwMC/4EAAAAnwwDAg4MIQCkDBwAAGyggW8NHQCfDAICTQ8LuhcAAAC8DQDTCAAAAJ8NAwIwDQskHgAAADALDCQeAAAAMAsMPB8AAABNDwu6FwAAALwNANMIAAAAnw0DAjANDLEgAAAAqQ0AADANC0UhAAAATQ8LuhcAAAC8DQDTCAAAAJ8NAwKMDgEAMA4N2SIAAABuB9n/AgAAAKQHEAAAAPBAbwkjALwHBxYkAAAAnwcDAlIJBgCMCgoAvAcHeCUAAACfBwQBggABACYDAQQAAABAAwIDAwMEAwUDBgMHAwgDCQMKAwsDDAMNAw4DDwQAAPBAAxADEQMSAxMDFAQAAFBBAxUDFgMXAxgDGQQAbKCBAxoDGwMcAx0DHgMfAyADIQMiAAUjARgAAAAAAAAAAQAAAAABAAD+AAYAAAABAAAAAgAAAgAAAAEAAAIAAAABAAACAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAIAAAAAAAABAAAAAAEAAAABAAAAAAAAAQABAAEAAAAAAAABAAABAAAAAAAAAPgADAAAAAAAAAAAAAABBgAAAAACAAABAgAKowAAAP8AAgAAAAAAbwEAADABALoBAAAAwAECADABAOkDAAAAggACAAQDJAMVBgADIwEAAQABGAAAAAIAAAIAACQBAAAAAAEuz+2drizWWcSnfGbTYKs4Xtf66RwLh5w=

-- https://lua.expert/
return {
	Name = "Grumpy Bear",
	ApplySkin = function(p1) --[[ ApplySkin | Line: 5 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://83634183817594"
			end
		end

		local Config = p1:WaitForChild("Config")

		Config:WaitForChild("HurtTexture").Texture = "rbxassetid://107948085163445"
		Config:WaitForChild("NormalTexture").Texture = "rbxassetid://83634183817594"
		Config:WaitForChild("BlinkTexture").Texture = "rbxassetid://110627976829983"

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