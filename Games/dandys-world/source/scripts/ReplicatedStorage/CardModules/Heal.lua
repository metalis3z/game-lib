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
-- CQMeCEh1bWFub2lkDFdhaXRGb3JDaGlsZAZIZWFsdGgGc2NyaXB0BE5hbWUORmluZEZpcnN0Q2hpbGQISW5zdGFuY2UDbmV3C051bWJlclZhbHVlBVZhbHVlBlBhcmVudAVwYWlycwl3b3Jrc3BhY2UNSW5HYW1lUGxheWVycwtHZXRDaGlsZHJlbgVwY2FsbAR3YXJuEEFwcGx5Q2FyZEVmZmVjdHMEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlDVNlcnZlclN0b3JhZ2UESW5mbw1DYXJkTW9kaWZpZXJzC1BsYXllclN0YXRzCUZpcnN0IEFpZBhyYnhhc3NldGlkOi8vMTY3OTA1NTYwNDIESWNvbjBIZWFscyBldmVyeSBUb29uIGJ5IDEgSGVhcnQgaWYgdGhleSBhcmUgaW5qdXJlZC4LRGVzY3JpcHRpb24AAwMAAQAAAA37AAAADgAKAPsAAABvAgAAvAAA0wEAAACfAAMCTQEAWgIAAACVAQEDMAEAWgIAAACCAAEABAMBAwIDAwIAAAAAAADwPwATAAEYAAABAAAAAAIAAAAAAhQAAAAACgABAAAAMfsAAACkAgEAAAAAQE0CAroCAAAAvAAAAwMAAACfAAMCKwAnAKQABgAAFECAbwEHAJ8AAgKkAQEAAAAAQE0BAboCAAAAMAEAugIAAACMAQEAMAEA7AgAAAD7AQAAMAEAJAkAAACkAQsAAACgQKQCDQAAAMBATQICSg4AAAC8AgJoDwAAAJ8CAgCfAQAEFwEKAKQGEQAAAABB2QcAABIABQCfBgIDKwYEAKQIEwAAACBBUgkHAJ8IAgFuAfX/AgAAAIIAAQAUAwQEAAAAQAMFAwYDBwMIBAAUQIADCQMKAwsDDAQAAKBAAw0EAADAQAMOAw8DEAQAAABBAxEEAAAgQQEADBIBGAAAAAAAAAAAAAEAAAABAAAAAAABAAABAAABAAAAAAAAAAAAAAEAAAAABwEAAAD3AA0NAAAAAAYAAAECACmjAAAA/wADAAAAAACkAQEAAAAAQG8DAgC8AQEWAwAAAJ8BAwKkAgEAAAAAQG8EBAC8AgIWAwAAAJ8CAwKkAwYAAABQQE0DA3oHAAAATQMDpAgAAACkBAYAAABQQE0EBHoHAAAATQQEAQkAAABvBQoAMAUAugsAAABvBQwAMAUArg0AAABvBQ4AMAUA4g8AAADABRAAEgADADAFAIMRAAAAggACABIDEwQAAABAAxQDFQMWAw0EAABQQAMXAxgDGQMaAwUDGwMcAx0DHgYBAxIBAQEAARgAAAACAAAAAAABAAAAAAABAAAAAAABAAAAAAACAAABAAABAAACAAAAFQEAAAAAAodWtBxrib3iVQybOGOSGx33TqNotZLeHQ==

-- https://lua.expert/
local t = {}

game:GetService("ReplicatedStorage")
game:GetService("ServerStorage")

local CardModifiers = workspace.Info.CardModifiers
local PlayerStats = workspace.Info.PlayerStats

t.Name = "First Aid"
t.Icon = "rbxassetid://16790556042"
t.Description = "Heals every Toon by 1 Heart if they are injured."
function t.ApplyCardEffects() --[[ ApplyCardEffects | Line: 12 | Upvalues: CardModifiers (copy) ]]
	if CardModifiers:FindFirstChild(script.Name) then
		return
	end

	local v1 = Instance.new("NumberValue")

	v1.Name = script.Name
	v1.Value = 1
	v1.Parent = CardModifiers

	for k, v in pairs(workspace.InGamePlayers:GetChildren()) do
		local ok, result = pcall(function() --[[ Line: 19 | Upvalues: v (copy) ]]
			if not v then
				return
			end

			local Humanoid = v:WaitForChild("Humanoid")

			Humanoid.Health = Humanoid.Health + 1
		end)

		if not ok then
			warn(result)
		end
	end
end

return t