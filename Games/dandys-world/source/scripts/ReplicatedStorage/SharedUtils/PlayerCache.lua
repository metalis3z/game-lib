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
-- CQMLEmdldFBsYXllckZyb21DYWNoZRFzYXZlUGxheWVyVG9DYWNoZRZHZXROYW1lRnJvbVVzZXJJZEFzeW5jBXBjYWxsBlBsYXllchhmZXRjaFBsYXllck5hbWVGcm9tQ2FjaGUEZ2FtZQdQbGF5ZXJzCkdldFNlcnZpY2UHUGxheWVyMQdQbGF5ZXIyAAUDAQEAAAYDAAAFAQID+wIAAIcBAgCCAQIAAAAMAQEYAAAADQAAAAADAgEAAAcEAAAFAgIDA/sCAABqAQIAggABAAAAEAIBGAAAAREAAAAAAwACAAAABvsAAAD7AgEAvAAA9AAAAACfAAMAggAAAAEDAwAbAAEYAAAAAAAAHAAAAAAHAQIAAAYDAAAFAQIY+wEAAE0BAa4AAAAAUgIAAJ8BAgIOAQEAggECAKQCAgAAABBA2QMAABICAQASAAAAnwICAw4CCAAOAwcA+wQAAE0EBFkDAAAAUgUAAFIGAwCfBAMBggMCAG8EBACCBAIABQMBAwQEAAAQQAMCAwUBAhQGARgAAAAAAAEBBAAAAAAAAwABAAAAAAABAwAVAAAAAAUAAAECAB+jAAAA/wADAAAAAACkAQEAAAAAQG8DAgC8AQEWAwAAAJ8BAwL/AgIAAAAAAIwD//9vBAQAagQCA4wD/v9vBAUAagQCA8ADBgASAAIAMAMArgcAAADAAwgAEgACADADAFkJAAAAwAMKABIAAAASAAEAMAMAWQsAAACCAAIADAMHBAAAAEADCAMJAwoDCwYAAwEGAQMCBgMDBgMAAQMBAAEYAAAAAgAAAAAAAgABAAABAAAFAAAABAAAAAQAAAAAFAEAAAAABFJWAcQ4Pau5BwpHmZhU50AiThawYJJrxQ==

-- https://lua.expert/
local t = {}
local Players = game:GetService("Players")
local t2 = {
	[-1] = "Player1",
	[-2] = "Player2"
}

function t.getPlayerFromCache(p1) --[[ getPlayerFromCache | Line: 12 | Upvalues: t2 (copy) ]]
	return t2[p1]
end
function t.savePlayerToCache(p1, p2) --[[ savePlayerToCache | Line: 16 | Upvalues: t2 (copy) ]]
	t2[p1] = p2
end
function t.fetchPlayerNameFromCache(p1) --[[ fetchPlayerNameFromCache | Line: 20 | Upvalues: t (copy), Players (copy) ]]
	local v1 = t.getPlayerFromCache(p1)

	if v1 then
		return v1
	end

	local ok, result = pcall(function() --[[ Line: 27 | Upvalues: Players (ref), p1 (copy) ]]
		return Players:GetNameFromUserIdAsync(p1)
	end)

	if ok and result then
		t.savePlayerToCache(p1, result)

		return result
	end

	return "Player"
end

return t