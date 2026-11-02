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
-- CQMWBnNjcmlwdAROYW1lDkZpbmRGaXJzdENoaWxkCEluc3RhbmNlA25ldwtOdW1iZXJWYWx1ZQVWYWx1ZQZQYXJlbnQQQXBwbHlDYXJkRWZmZWN0cwRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UNU2VydmVyU3RvcmFnZQl3b3Jrc3BhY2UESW5mbw1DYXJkTW9kaWZpZXJzC1BsYXllclN0YXRzB0RlY2VuY3kYcmJ4YXNzZXRpZDovLzE3NzAyMzY0MzUwBEljb24rQWRkcyA1IHNlY29uZHMgdG8gdGhlIGVsZXZhdG9yIHBhbmljIHRpbWVyLgtEZXNjcmlwdGlvbgACAwABAAAAGvsAAACkAgEAAAAAQE0CAroCAAAAvAAAAwMAAACfAAMCKwAQAKQABgAAFECAbwEHAJ8AAgKkAQEAAAAAQE0BAboCAAAAMAEAugIAAACMAQUAMAEA7AgAAAD7AQAAMAEAJAkAAACCAAEACgMBBAAAAEADAgMDAwQDBQQAFECAAwYDBwMIAAwJARgAAAAAAAAAAAABAAAAAQAAAAAAAQAAAQAAAg0AAAAABgAAAQIAKaMAAAD/AAMAAAAAAKQBAQAAAABAbwMCALwBARYDAAAAnwEDAqQCAQAAAABAbwQEALwCAhYDAAAAnwIDAqQDBgAAAFBATQMDegcAAABNAwOkCAAAAKQEBgAAAFBATQQEegcAAABNBAQBCQAAAG8FCgAwBQC6CwAAAG8FDAAwBQCuDQAAAG8FDgAwBQDiDwAAAMAFEAASAAMAMAUAgxEAAACCAAIAEgMKBAAAAEADCwMMAw0DDgQAAFBAAw8DEAMRAxIDAgMTAxQDFQMWBgADCQEAAQABGAAAAAIAAAAAAAEAAAAAAAEAAAAAAAEAAAAAAAIAAAEAAAEAAAIAAAAJAQAAAAABiGzAG3guQfjF/k1udo4Hu/h012+6qKoa

-- https://lua.expert/
local Decency = {}

game:GetService("ReplicatedStorage")
game:GetService("ServerStorage")

local CardModifiers = workspace.Info.CardModifiers
local PlayerStats = workspace.Info.PlayerStats

Decency.Name = "Decency"
Decency.Icon = "rbxassetid://17702364350"
Decency.Description = "Adds 5 seconds to the elevator panic timer."
function Decency.ApplyCardEffects() --[[ ApplyCardEffects | Line: 12 | Upvalues: CardModifiers (copy) ]]
	if CardModifiers:FindFirstChild(script.Name) then
		return
	end

	local v1 = Instance.new("NumberValue")

	v1.Name = script.Name
	v1.Value = 5
	v1.Parent = CardModifiers
end

return Decency