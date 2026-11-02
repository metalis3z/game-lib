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
-- CQMWBnNjcmlwdAROYW1lDkZpbmRGaXJzdENoaWxkCEluc3RhbmNlA25ldwtOdW1iZXJWYWx1ZQVWYWx1ZQZQYXJlbnQQQXBwbHlDYXJkRWZmZWN0cwRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UNU2VydmVyU3RvcmFnZQl3b3Jrc3BhY2UESW5mbw1DYXJkTW9kaWZpZXJzC1BsYXllclN0YXRzCVNwYXJrcGx1ZxhyYnhhc3NldGlkOi8vMTc3MDE0Njc1MzIESWNvbjNUb29ucyB3aWxsIGdsb3cgc2xpZ2h0bHkgYnJpZ2h0ZXIgZHVyaW5nIEJsYWNrb3V0cy4LRGVzY3JpcHRpb24AAgMAAQAAABr7AAAApAIBAAAAAEBNAgK6AgAAALwAAAMDAAAAnwADAisAEACkAAYAABRAgG8BBwCfAAICpAEBAAAAAEBNAQG6AgAAADABALoCAAAAbwEIADABAOwJAAAA+wEAADABACQKAAAAggABAAsDAQQAAABAAwIDAwMEAwUEABRAgAMGAmZmZmZmZvI/AwcDCAAMCQEYAAAAAAAAAAAAAQAAAAEAAAAAAAEAAAEAAAINAAAAAAYAAAECACmjAAAA/wADAAAAAACkAQEAAAAAQG8DAgC8AQEWAwAAAJ8BAwKkAgEAAAAAQG8EBAC8AgIWAwAAAJ8CAwKkAwYAAABQQE0DA3oHAAAATQMDpAgAAACkBAYAAABQQE0EBHoHAAAATQQEAQkAAABvBQoAMAUAugsAAABvBQwAMAUArg0AAABvBQ4AMAUA4g8AAADABRAAEgADADAFAIMRAAAAggACABIDCgQAAABAAwsDDAMNAw4EAABQQAMPAxADEQMSAwIDEwMUAxUDFgYAAwkBAAEAARgAAAACAAAAAAABAAAAAAABAAAAAAABAAAAAAACAAABAAABAAACAAAACQEAAAAAAQgsYUU0n/HgQXwRUZiAi554NHYxOugLRA==

-- https://lua.expert/
local Sparkplug = {}

game:GetService("ReplicatedStorage")
game:GetService("ServerStorage")

local CardModifiers = workspace.Info.CardModifiers
local PlayerStats = workspace.Info.PlayerStats

Sparkplug.Name = "Sparkplug"
Sparkplug.Icon = "rbxassetid://17701467532"
Sparkplug.Description = "Toons will glow slightly brighter during Blackouts."
function Sparkplug.ApplyCardEffects() --[[ ApplyCardEffects | Line: 12 | Upvalues: CardModifiers (copy) ]]
	if CardModifiers:FindFirstChild(script.Name) then
		return
	end

	local v1 = Instance.new("NumberValue")

	v1.Name = script.Name
	v1.Value = 1.15
	v1.Parent = CardModifiers
end

return Sparkplug