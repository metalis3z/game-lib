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
-- CQMeBnNjcmlwdAROYW1lDkZpbmRGaXJzdENoaWxkCEluc3RhbmNlA25ldwtOdW1iZXJWYWx1ZQVWYWx1ZQZQYXJlbnQFcGFpcnMJd29ya3NwYWNlDUluR2FtZVBsYXllcnMLR2V0Q2hpbGRyZW4JQWJpbGl0aWVzCEFiaWxpdHkxDFdhaXRGb3JDaGlsZAhDb29sZG93bg9DdXJyZW50Q29vbGRvd24QQXBwbHlDYXJkRWZmZWN0cwRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UNU2VydmVyU3RvcmFnZQRJbmZvDUNhcmRNb2RpZmllcnMLUGxheWVyU3RhdHMIUHJhY3RpY2UYcmJ4YXNzZXRpZDovLzE4MTY2NDA5NzM0BEljb241RGVjcmVhc2VzIFRvb24gQWN0aXZlIEFiaWxpdHkgY29vbGRvd25zIGJ5IDUgc2Vjb25kcy4LRGVzY3JpcHRpb24AAgwAAQAAAFP7AAAApAIBAAAAAEBNAgK6AgAAALwAAAMDAAAAnwADAisASQCkAAYAABRAgG8BBwCfAAICpAEBAAAAAEBNAQG6AgAAADABALoCAAAAjAEKADABAOwIAAAA+wEAADABACQJAAAApAELAAAAoECkAg0AAADAQE0CAkoOAAAAvAICaA8AAACfAgIAnwEABBcBLAAOBSsAbwgQALwGBQMDAAAAnwYDAg4GJgBvCBAAvAYFAwMAAACfBgMCbwgRALwGBgMDAAAAnwYDAg4GHQBvCBAAvAYF0xIAAACfBgMCbwkRALwHBtMSAAAAnwcDAm8KEwC8CAfTEgAAAJ8IAwJvCxQAvAkH0xIAAACfCQMCTQoI7AgAAAB4CgoVMAoI7AgAAABNCgjsCAAAAIwLBQB9CgQACwAAAIwKBQAwCgjsCAAAAG4B0/8CAAAAggABABYDAQQAAABAAwIDAwMEAwUEABRAgAMGAwcDCAMJBAAAoEADCgQAAMBAAwsDDAMNAw4DDwMQAxECAAAAAAAAFEAADBIBGAAAAAAAAAAAAAEAAAABAAAAAAABAAABAAABAAAAAAAAAAAAAAEBAAAAAAEAAAAAAAAAAAEAAAABAAAAAQAAAAEAAAACAAAAAAIAAAAAAQAA9AATDQAAAAAGAAABAgApowAAAP8AAwAAAAAApAEBAAAAAEBvAwIAvAEBFgMAAACfAQMCpAIBAAAAAEBvBAQAvAICFgMAAACfAgMCpAMGAAAAUEBNAwN6BwAAAE0DA6QIAAAApAQGAAAAUEBNBAR6BwAAAE0EBAEJAAAAbwUKADAFALoLAAAAbwUMADAFAK4NAAAAbwUOADAFAOIPAAAAwAUQABIAAwAwBQCDEQAAAIIAAgASAxMEAAAAQAMUAxUDFgMKBAAAUEADFwMYAxkDGgMCAxsDHAMdAx4GAAMSAQABAAEYAAAAAgAAAAAAAQAAAAAAAQAAAAAAAQAAAAAAAgAAAQAAAQAAAgAAABoBAAAAAAGSIrFDsQpTLziJwCJj+US64jqmN6Dm20I=

-- https://lua.expert/
local Practice = {}

game:GetService("ReplicatedStorage")
game:GetService("ServerStorage")

local CardModifiers = workspace.Info.CardModifiers
local PlayerStats = workspace.Info.PlayerStats

Practice.Name = "Practice"
Practice.Icon = "rbxassetid://18166409734"
Practice.Description = "Decreases Toon Active Ability cooldowns by 5 seconds."
function Practice.ApplyCardEffects() --[[ ApplyCardEffects | Line: 12 | Upvalues: CardModifiers (copy) ]]
	if CardModifiers:FindFirstChild(script.Name) then
		return
	end

	local v1 = Instance.new("NumberValue")

	v1.Name = script.Name
	v1.Value = 10
	v1.Parent = CardModifiers

	for k, v in pairs(workspace.InGamePlayers:GetChildren()) do
		if v and (v:FindFirstChild("Abilities") and v:FindFirstChild("Abilities"):FindFirstChild("Ability1")) then
			local Ability1 = v:WaitForChild("Abilities"):WaitForChild("Ability1")
			local Cooldown = Ability1:WaitForChild("Cooldown")

			Ability1:WaitForChild("CurrentCooldown")
			Cooldown.Value = Cooldown.Value - 5

			if Cooldown.Value <= 5 then
				Cooldown.Value = 5
			end
		end
	end
end

return Practice