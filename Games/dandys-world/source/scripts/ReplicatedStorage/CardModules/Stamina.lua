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
-- CQMdBnNjcmlwdAROYW1lDkZpbmRGaXJzdENoaWxkCEluc3RhbmNlA25ldwtOdW1iZXJWYWx1ZQVWYWx1ZQZQYXJlbnQFcGFpcnMJd29ya3NwYWNlDUluR2FtZVBsYXllcnMLR2V0Q2hpbGRyZW4FU3RhdHMMV2FpdEZvckNoaWxkD09yaWdpbmFsU3RhbWluYQ5DdXJyZW50U3RhbWluYRBBcHBseUNhcmRFZmZlY3RzBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQ1TZXJ2ZXJTdG9yYWdlBEluZm8NQ2FyZE1vZGlmaWVycwtQbGF5ZXJTdGF0cwpXZWxsLVBhY2VkGHJieGFzc2V0aWQ6Ly8xNzcwMjM2MzI4MwRJY29uLUluY3JlYXNlcyB0aGUgbWF4IFN0YW1pbmEgb2YgYWxsIFRvb25zIGJ5IDEwLgtEZXNjcmlwdGlvbgACCwABAAAAQvsAAACkAgEAAAAAQE0CAroCAAAAvAAAAwMAAACfAAMCKwA4AKQABgAAFECAbwEHAJ8AAgKkAQEAAAAAQE0BAboCAAAAMAEAugIAAACMAQoAMAEA7AgAAAD7AQAAMAEAJAkAAACkAQsAAACgQKQCDQAAAMBATQICSg4AAAC8AgJoDwAAAJ8CAgCfAQAEFwEbAA4FGgBvCBAAvAYF0xEAAACfBgMCbwkSALwHBtMRAAAAnwcDAm8KEwC8CAbTEQAAAJ8IAwJNCQfsCAAAAE0KAOwIAAAAQwkJCjAJB+wIAAAATQkI7AgAAABNCgDsCAAAAEMJCQowCQjsCAAAAG4B5P8CAAAAggABABQDAQQAAABAAwIDAwMEAwUEABRAgAMGAwcDCAMJBAAAoEADCgQAAMBAAwsDDAMNAw4DDwMQAAwRARgAAAAAAAAAAAABAAAAAQAAAAAAAQAAAQAAAQAAAAAAAAAAAAABAQAAAAEAAAABAAAAAQAAAAAAAAEAAAAAAAD6AAoNAAAAAAYAAAECACmjAAAA/wADAAAAAACkAQEAAAAAQG8DAgC8AQEWAwAAAJ8BAwKkAgEAAAAAQG8EBAC8AgIWAwAAAJ8CAwKkAwYAAABQQE0DA3oHAAAATQMDpAgAAACkBAYAAABQQE0EBHoHAAAATQQEAQkAAABvBQoAMAUAugsAAABvBQwAMAUArg0AAABvBQ4AMAUA4g8AAADABRAAEgADADAFAIMRAAAAggACABIDEgQAAABAAxMDFAMVAwoEAABQQAMWAxcDGAMZAwIDGgMbAxwDHQYAAxEBAAEAARgAAAACAAAAAAABAAAAAAABAAAAAAABAAAAAAACAAABAAABAAACAAAAEgEAAAAAAfBJi1UxB8XQg9zVwkKOCYGAUZwhwo3hVA==

-- https://lua.expert/
local t = {}

game:GetService("ReplicatedStorage")
game:GetService("ServerStorage")

local CardModifiers = workspace.Info.CardModifiers
local PlayerStats = workspace.Info.PlayerStats

t.Name = "Well-Paced"
t.Icon = "rbxassetid://17702363283"
t.Description = "Increases the max Stamina of all Toons by 10."
function t.ApplyCardEffects() --[[ ApplyCardEffects | Line: 12 | Upvalues: CardModifiers (copy) ]]
	if CardModifiers:FindFirstChild(script.Name) then
		return
	end

	local v1 = Instance.new("NumberValue")

	v1.Name = script.Name
	v1.Value = 10
	v1.Parent = CardModifiers

	for k, v in pairs(workspace.InGamePlayers:GetChildren()) do
		if v then
			local Stats = v:WaitForChild("Stats")
			local OriginalStamina = Stats:WaitForChild("OriginalStamina")
			local CurrentStamina = Stats:WaitForChild("CurrentStamina")

			OriginalStamina.Value = OriginalStamina.Value + v1.Value
			CurrentStamina.Value = CurrentStamina.Value + v1.Value
		end
	end
end

return t