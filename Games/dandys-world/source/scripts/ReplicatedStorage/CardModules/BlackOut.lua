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
-- CQMWBnNjcmlwdAROYW1lDkZpbmRGaXJzdENoaWxkCEluc3RhbmNlA25ldwtOdW1iZXJWYWx1ZQVWYWx1ZQZQYXJlbnQQQXBwbHlDYXJkRWZmZWN0cwRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UNU2VydmVyU3RvcmFnZQl3b3Jrc3BhY2UESW5mbw1DYXJkTW9kaWZpZXJzC1BsYXllclN0YXRzC0VsZWN0cmljaWFuGHJieGFzc2V0aWQ6Ly8xNzcwMjM2NDcxMwRJY29uPURlY3JlYXNlcyB0aGUgY2hhbmNlIG9mIGEgQmxhY2tvdXQgb2NjdXJpbmcgb24gZnV0dXJlIGZsb29ycy4LRGVzY3JpcHRpb24AAgMAAQAAABr7AAAApAIBAAAAAEBNAgK6AgAAALwAAAMDAAAAnwADAisAEACkAAYAABRAgG8BBwCfAAICpAEBAAAAAEBNAQG6AgAAADABALoCAAAAbwEIADABAOwJAAAA+wEAADABACQKAAAAggABAAsDAQQAAABAAwIDAwMEAwUEABRAgAMGAs3MzMzMzOw/AwcDCAAMCQEYAAAAAAAAAAAAAQAAAAEAAAAAAAEAAAEAAAINAAAAAAYAAAECACmjAAAA/wADAAAAAACkAQEAAAAAQG8DAgC8AQEWAwAAAJ8BAwKkAgEAAAAAQG8EBAC8AgIWAwAAAJ8CAwKkAwYAAABQQE0DA3oHAAAATQMDpAgAAACkBAYAAABQQE0EBHoHAAAATQQEAQkAAABvBQoAMAUAugsAAABvBQwAMAUArg0AAABvBQ4AMAUA4g8AAADABRAAEgADADAFAIMRAAAAggACABIDCgQAAABAAwsDDAMNAw4EAABQQAMPAxADEQMSAwIDEwMUAxUDFgYAAwkBAAEAARgAAAACAAAAAAABAAAAAAABAAAAAAABAAAAAAACAAABAAABAAACAAAACQEAAAAAAXI607z4qFCTwQttkQFETGYCIsTIQP65vQ==

-- https://lua.expert/
local Electrician = {}

game:GetService("ReplicatedStorage")
game:GetService("ServerStorage")

local CardModifiers = workspace.Info.CardModifiers
local PlayerStats = workspace.Info.PlayerStats

Electrician.Name = "Electrician"
Electrician.Icon = "rbxassetid://17702364713"
Electrician.Description = "Decreases the chance of a Blackout occuring on future floors."
function Electrician.ApplyCardEffects() --[[ ApplyCardEffects | Line: 12 | Upvalues: CardModifiers (copy) ]]
	if CardModifiers:FindFirstChild(script.Name) then
		return
	end

	local v1 = Instance.new("NumberValue")

	v1.Name = script.Name
	v1.Value = 0.9
	v1.Parent = CardModifiers
end

return Electrician