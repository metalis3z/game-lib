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
-- CQMWBnNjcmlwdAROYW1lDkZpbmRGaXJzdENoaWxkCEluc3RhbmNlA25ldwtOdW1iZXJWYWx1ZQVWYWx1ZQZQYXJlbnQQQXBwbHlDYXJkRWZmZWN0cwRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UNU2VydmVyU3RvcmFnZQl3b3Jrc3BhY2UESW5mbw1DYXJkTW9kaWZpZXJzC1BsYXllclN0YXRzCkF2YXJpY2lvdXMYcmJ4YXNzZXRpZDovLzE3NzAyMzY0MTg0BEljb25WU2xpZ2h0bHkgaW5jcmVhc2VzIHRoZSBjaGFuY2VzIG9mIHJhcmVyIGl0ZW1zIGFwcGVhcmluZyBvbiBGbG9vcnMgYW5kIGluIERhbmR5J3MgU2hvcC4LRGVzY3JpcHRpb24AAgMAAQAAABr7AAAApAIBAAAAAEBNAgK6AgAAALwAAAMDAAAAnwADAisAEACkAAYAABRAgG8BBwCfAAICpAEBAAAAAEBNAQG6AgAAADABALoCAAAAbwEIADABAOwJAAAA+wEAADABACQKAAAAggABAAsDAQQAAABAAwIDAwMEAwUEABRAgAMGAs3MzMzMzOw/AwcDCAAMCQEYAAAAAAAAAAAAAQAAAAEAAAAAAAEAAAEAAAINAAAAAAYAAAECACmjAAAA/wADAAAAAACkAQEAAAAAQG8DAgC8AQEWAwAAAJ8BAwKkAgEAAAAAQG8EBAC8AgIWAwAAAJ8CAwKkAwYAAABQQE0DA3oHAAAATQMDpAgAAACkBAYAAABQQE0EBHoHAAAATQQEAQkAAABvBQoAMAUAugsAAABvBQwAMAUArg0AAABvBQ4AMAUA4g8AAADABRAAEgADADAFAIMRAAAAggACABIDCgQAAABAAwsDDAMNAw4EAABQQAMPAxADEQMSAwIDEwMUAxUDFgYAAwkBAAEAARgAAAACAAAAAAABAAAAAAABAAAAAAABAAAAAAACAAABAAABAAACAAAACQEAAAAAAbdF30fLEw+Zr576gaCmH7rHXcgzhYG1Rg==

-- https://lua.expert/
local Avaricious = {}

game:GetService("ReplicatedStorage")
game:GetService("ServerStorage")

local CardModifiers = workspace.Info.CardModifiers
local PlayerStats = workspace.Info.PlayerStats

Avaricious.Name = "Avaricious"
Avaricious.Icon = "rbxassetid://17702364184"
Avaricious.Description = "Slightly increases the chances of rarer items appearing on Floors and in Dandy\'s Shop."
function Avaricious.ApplyCardEffects() --[[ ApplyCardEffects | Line: 12 | Upvalues: CardModifiers (copy) ]]
	if CardModifiers:FindFirstChild(script.Name) then
		return
	end

	local v1 = Instance.new("NumberValue")

	v1.Name = script.Name
	v1.Value = 0.9
	v1.Parent = CardModifiers
end

return Avaricious