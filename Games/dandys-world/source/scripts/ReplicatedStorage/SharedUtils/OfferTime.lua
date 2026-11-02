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
-- CQMOB3JlcXVpcmULU2hhcmVkVXRpbHMMV2FpdEZvckNoaWxkDVNpbXVsYXRlZFRpbWUDbm93DVVuaXhUaW1lc3RhbXAFcGNhbGwEdHlwZQZudW1iZXICb3MEdGltZQRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UABAQAAgAAAA6kAAEAAAAAQPsBAQBvAwIAvAEB0wMAAACfAQMCbwMEALwBAdMDAAAAnwEDAJ8AAALeAAAAggABAAUDAQQAAABAAwIDAwMEAAcAARgAAAAAAAAAAAAAAAAAAQgAAAAAAQABAAAAB/sAAABNAACaAAAAAJ8AAQJNAAC3AQAAAIIAAgACAwUDBgANAAEYAAAAAAAAAA4AAAAABAABAAAAFPsAAAAOAA4ApAABAAAAAEDZAQAAEgIAAJ8AAgMOAAgAuygBA1IDAQCkAgMAAAAgQJ8CAgLwAgIABAAAgIIBAgCkAAcAABhQgJ8AAQCCAAAACAMHBAAAAEADCAQAACBAAwkDCgMLBAAYUIABAQsAARgAAAEAAAAAAwAAAAAAAAABAwAAAAwAAAAABAAAAQIAEqMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwLGAQAApAIFAAAAQEDZAwAAEgEB/xIAAACfAgIC2QMBABIBAf/BAQAAggMCAAYDDAQAAABAAw0DDgMHBAAAQEACAAIBAAEYAAMAAAAAAAIBAAAAAAAEAAAAAQAAAAADk3Tju/aQplia0eM9DU1n1+Ns9M+hsIm6

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local v1 = nil

pcall(function() --[[ Line: 7 | Upvalues: v1 (ref), ReplicatedStorage (copy) ]]
	v1 = require(ReplicatedStorage:WaitForChild("SharedUtils"):WaitForChild("SimulatedTime"))
end)

return function() --[[ Line: 11 | Upvalues: v1 (ref) ]]
	if not v1 then
		return os.time()
	end

	local ok, result = pcall(function() --[[ Line: 13 | Upvalues: v1 (ref) ]]
		return v1.now().UnixTimestamp
	end)

	if ok and type(result) == "number" then
		return result
	end

	return os.time()
end