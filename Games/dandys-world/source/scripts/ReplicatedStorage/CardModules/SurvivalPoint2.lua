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
-- CQMbBnNjcmlwdAROYW1lDkZpbmRGaXJzdENoaWxkCEluc3RhbmNlA25ldwtOdW1iZXJWYWx1ZQVWYWx1ZQZQYXJlbnQFcGFpcnMJd29ya3NwYWNlDUluR2FtZVBsYXllcnMLR2V0Q2hpbGRyZW4ESW5mbwtQbGF5ZXJTdGF0cw5TdXJ2aXZhbFBvaW50cwxXYWl0Rm9yQ2hpbGQQQXBwbHlDYXJkRWZmZWN0cwRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UNU2VydmVyU3RvcmFnZQ1DYXJkTW9kaWZpZXJzDVBlbm55IFBpbmNoZXIYcmJ4YXNzZXRpZDovLzE3NzAyMzYzMTExBEljb24dRXZlcnkgVG9vbiByZWNlaXZlcyA0NSBUYXBlcy4LRGVzY3JpcHRpb24AAgoAAQAAAD37AAAApAIBAAAAAEBNAgK6AgAAALwAAAMDAAAAnwADAisAMwCkAAYAABRAgG8BBwCfAAICpAEBAAAAAEBNAQG6AgAAADABALoCAAAAjAEPADABAOwIAAAA+wEAADABACQJAAAApAELAAAAoECkAg0AAADAQE0CAkoOAAAAvAICaA8AAACfAgIAnwEABBcBFgAOBRUApAYNAAAAwEBNBgZ6EAAAAE0GBgERAAAATQgFugIAAAC8BgYDAwAAAJ8GAwIOBgkAbwkSALwHBtMTAAAAnwcDAk0IB+wIAAAAlQgIFDAIB+wIAAAAbgHp/wIAAACCAAEAFQMBBAAAAEADAgMDAwQDBQQAFECAAwYDBwMIAwkEAACgQAMKBAAAwEADCwMMAw0DDgMPAxACAAAAAACARkAADBEBGAAAAAAAAAAAAAEAAAABAAAAAAABAAABAAABAAAAAAAAAAAAAAEBAAAAAAAAAAAAAAEBAAAAAQAAAAD7AAoNAAAAAAYAAAECACmjAAAA/wADAAAAAACkAQEAAAAAQG8DAgC8AQEWAwAAAJ8BAwKkAgEAAAAAQG8EBAC8AgIWAwAAAJ8CAwKkAwYAAABQQE0DA3oHAAAATQMDpAgAAACkBAYAAABQQE0EBHoHAAAATQQEAQkAAABvBQoAMAUAugsAAABvBQwAMAUArg0AAABvBQ4AMAUA4g8AAADABRAAEgADADAFAIMRAAAAggACABIDEgQAAABAAxMDFAMVAwoEAABQQAMNAxYDDgMXAwIDGAMZAxoDGwYAAxEBAAEAARgAAAACAAAAAAABAAAAAAABAAAAAAABAAAAAAACAAABAAABAAACAAAAEgEAAAAAAQwLo0L4vn9TUdgtrTDnwhV8E7Q2Ps/JQw==

-- https://lua.expert/
local t = {}

game:GetService("ReplicatedStorage")
game:GetService("ServerStorage")

local CardModifiers = workspace.Info.CardModifiers
local PlayerStats = workspace.Info.PlayerStats

t.Name = "Penny Pincher"
t.Icon = "rbxassetid://17702363111"
t.Description = "Every Toon receives 45 Tapes."
function t.ApplyCardEffects() --[[ ApplyCardEffects | Line: 12 | Upvalues: CardModifiers (copy) ]]
	if CardModifiers:FindFirstChild(script.Name) then
		return
	end

	local v1 = Instance.new("NumberValue")

	v1.Name = script.Name
	v1.Value = 15
	v1.Parent = CardModifiers

	for k, v in pairs(workspace.InGamePlayers:GetChildren()) do
		if v then
			local v2 = workspace.Info.PlayerStats:FindFirstChild(v.Name)

			if v2 then
				local SurvivalPoints = v2:WaitForChild("SurvivalPoints")

				SurvivalPoints.Value = SurvivalPoints.Value + 45
			end
		end
	end
end

return t