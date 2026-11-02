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
-- CQMIBXBhaXJzBHR5cGUFdGFibGUKcHJvZHVjdEtleQxieVByb2R1Y3RLZXkNU3RhcnRlckJ1bmRsZQdyZXF1aXJlBnNjcmlwdAACCAEBAAAAFaQBAQAAAABA+wIAAJ8BAgQXAQwAuygFA1IHBQCkBgMAAAAgQJ8GAgLwBgYABAAAgE0GBQUFAAAAmgYCAAAAAACCBQIAbgHz/wIAAADGAQAAggECAAYDAQQAAABAAwIEAAAgQAMDAwQABwUBGAAAAAAAAQAAAAAAAAAAAAAB/gAFAAgAAAAAAwAAAQIAEKMAAADiAAEApAEDAAAAIECkAgUAAABAQE0CAtYAAAAAnwECAjABANYAAAAAwAEGABIAAAAwAQBuBwAAAIIAAgAIAwYFAQADBwQAACBAAwgEAABAQAYAAwUBAAEAARgAAQEAAAAAAAAAAAQAAAAJAQAAAAABH+JTzKviDFY1WaaAtCDV+2/6RLgtJjnN

-- https://lua.expert/
local t = {
	StarterBundle = require(script.StarterBundle)
}

function t.byProductKey(p1) --[[ byProductKey | Line: 7 | Upvalues: t (copy) ]]
	for k, v in pairs(t) do
		if type(v) == "table" and v.productKey == p1 then
			return v
		end
	end

	return nil
end

return t