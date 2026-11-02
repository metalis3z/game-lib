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
-- CQMPA0xvdwZOb3JtYWwESGlnaAhDcml0aWNhbAVlcnJvciRJbnZhbGlkIG51bWJlciBmb3IgUmVxdWVzdFByaW9yaXR5OiAIdG9zdHJpbmcMRGVmYXVsdFN0YXJ0C0RlZmF1bHRTdG9wGUludmFsaWQgUmVxdWVzdFByaW9yaXR5OiAGdHlwZW9mBm51bWJlchdDb252ZXJ0UHJpb3JpdHlUb051bWJlchdDb252ZXJ0TnVtYmVyVG9Qcmlvcml0eRFHZXRQcmlvcml0eU51bWJlcgAEBgEAAAAGAwAABQECHYwBAAB9AAMAAQAAAG8BAACCAQIADQADAAEAAIBvAQIAggECAA0AAwADAACAbwEEAIIBAgCMAQMAfQEDAAAAAABvAQUAggECAKQBBwAAAGBAbwMIALs/AANSBQAApAQKAAAAkECfBAICcwIDBJ8BAgGCAAEACwMBAgAAAAAAAPA/AwICAAAAAAAAAEADAwMEAwUEAABgQAMGAwcEAACQQAAFAAEYAAAAAQABAAEAAQABAAEAAAEAAgAAAAAAAAAAAAIGAAAAAAYBAAAABgMAAAUBAyPwAAMAAAAAgIwBAACCAQIA8AADAAEAAICMAQEAggECAPAAAwACAACAjAEBAIIBAgDwAAMAAwAAgIwBAgCCAQIA8AADAAQAAICMAQIAggECAPAAAwAFAACAjAEDAIIBAgCkAQcAAABgQG8DCAC7PwADUgUAAKQECgAAAJBAnwQCAnMCAwSfAQIBggABAAsDAQMIAwIDCQMDAwQDBQQAAGBAAwoDBwQAAJBAABMAARgAAAEAAQABAAEAAQABAAEAAQABAAEAAQACAAAAAAAAAAAAAhQAAAAAAwEBAAAADrssAANSAgAApAEBAAAAAECfAQIC8AECAAIAAICCAAIA+wEAAE0BAb4DAAAAUgIAAJ8BAgCCAQAABAMLBAAAAEADDAMNACUAARgAAAAAAAAAAQMAAAAAACcAAAAAAgAAAQIADqMAAAD/AAMAAAAAAMABAAAwAQA8AQAAAMABAgAwAQC+AwAAAMABBAASAAAAMAEAuAUAAACCAAIABgYAAw4GAQMNBgIDDwMAAQIBAAEYAAIAAgAADgAAEgAAAAkBAAAAAAMuilmQX4ndcgs+y8dhnabqXpJO5BxOM5E=

-- https://lua.expert/
local t = {
	ConvertNumberToPriority = function(p1) --[[ Line: 5 ]]
		if p1 <= 0 then
			return "Low"
		end

		if p1 == 1 then
			return "Normal"
		end

		if p1 == 2 then
			return "High"
		end

		if p1 >= 3 then
			return "Critical"
		end

		error("Invalid number for RequestPriority: " .. tostring(p1))
	end,
	ConvertPriorityToNumber = function(p1) --[[ Line: 19 ]]
		if p1 == "Low" then
			return 0
		end

		if p1 == "DefaultStart" then
			return 1
		end

		if p1 == "Normal" then
			return 1
		end

		if p1 == "DefaultStop" then
			return 2
		end

		if p1 == "High" then
			return 2
		end

		if p1 == "Critical" then
			return 3
		end

		error("Invalid RequestPriority: " .. tostring(p1))
	end
}

function t.GetPriorityNumber(p1) --[[ Line: 37 | Upvalues: t (copy) ]]
	if typeof(p1) == "number" then
		return p1
	end

	return t.ConvertPriorityToNumber(p1)
end

return t