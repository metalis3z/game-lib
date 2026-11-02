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
-- CQMFDGdldG1ldGF0YWJsZQxzZXRtZXRhdGFibGUGdHlwZW9mBXRhYmxlCGRlZXBDb3B5AAIJAQEAAAAg/wIAAAAAAAC7PAADUgQAAKQDAQAAAABAnwMCAp49AgMDAAAApAEDAAAAIECfAQMCUgIAAMYDAADGBAAAZAINALssBgNSCAYApAcFAAAAQECfBwIC8AcGAAYAAID7BwAAUggGAJ8HAgJqBwEFZQABAGoGAQVuAvL/AgAAAIIBAgAHAwEEAAAAQAMCBAAAIEADAwQAAEBAAwQABAUBGAAAAAAAAAAAAAAAAAIAAAABAAAAAAAAAQAAAAED+gAJBQAAAAABAAABAgAEowAAAMAAAAASAAAAggACAAEGAAEAAQABGAADAA8BAAAAAAEfxoKvF/rQRJ+X8fW7mGn5b96V2y0C6K4=

-- https://lua.expert/
local function v1(p1) --[[ deepCopy | Line: 4 | Upvalues: v1 (copy) ]]
	local v2 = setmetatable({}, (getmetatable(p1)))

	for v3, v4 in p1 do
		if typeof(v4) == "table" then
			v2[v3] = v1(v4)

			continue
		end

		v2[v3] = v4
	end

	return v2
end

return v1