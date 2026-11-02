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
-- CQMSBHR5cGUGbnVtYmVyAARtYXRoBWZsb29yCERhdGVUaW1lEWZyb21Vbml4VGltZXN0YW1wBWVuLXVzE0Zvcm1hdFVuaXZlcnNhbFRpbWUPRm9ybWF0TG9jYWxUaW1lBmZvcm1hdAhNL0QvWVlZWQp1bml4VG9EYXRlBmg6bW0gQQp1bml4VG9UaW1lAm9zBHRpbWUQdW5peFRvRGF0ZU9yVGltZQAFBwMAAAAIBQAABQOCA4IpuygAA1IEAACkAwEAAAAAQJ8DAgLwAwQAAgAAgIwDAAB9AAMAAwAAAG8DAwCCAwIAuwwAA1IEAACkAwYAABRAgJ8DAgJSAAMARwIMAAAAAACkAwkAACBwgFsFAgpDBAAFnwMCAlIFAQBvBgsAvAMDiwwAAACfAwQAggMAAKQDCQAAIHCAUgQAAJ8DAgJSBQEAbwYLALwDA8YNAAAAnwMEAIIDAAAOAwEEAAAAQAMCAwMDBAMFBAAUQIADBgMHBAAgcIACAAAAAAAgrEADCAMJAwoAFAsBGAAAAAAAAAAAAAABAAUAAAAAAAIAAwAAAAAAAAAAAAAEAAAAAAAAAAAAFQAAAAAGAgEAAAcEAAAFAoKCCPsCAABNAgKNAAAAAFIDAABvBAEAUgUBAJ8CBACCAgAAAgMLAwwAJw0BGAAAAAAAAAAAKAAAAAAGAgEAAAcEAAAFAoKCCPsCAABNAgKNAAAAAFIDAABvBAEAUgUBAJ8CBACCAgAAAgMLAw4AKw8BGAAAAAAAAAAALAAAAAAHAgEAAAcEAAAFAoKCIvsCAABNAgKNAAAAAKQDAwAACBCAnwMBAm8EBABSBQEAnwIEAvsDAABNAwONAAAAAFIEAABvBQQAUgYBAJ8DBALwAwoABQAAAJoDCAACAAAA+wQAAE0EBJIGAAAAUgUAAFIGAQCfBAMAggQAAPsEAABNBATKBwAAAFIFAABSBgEAnwQDAIIEAAAIAwsDEAMRBAAIEIADDAMDAw8DDQAvEgEYAAAAAAAAAAAAAQAAAAAAAAIAAAABAAAAAAAAAwAAAAAAADEAAAAAAgAAAQIAE6MAAAD/AAMAAAAAAMABAAAwAQCNAQAAAMABAgASAAAAMAEAygMAAADAAQQAEgAAADABAJIFAAAAwAEGABIAAAAwAQDDBwAAAIIAAgAIBgADCwYBAw0GAgMPBgMDEgQAAQIDAQABGAANAAYAABMAAAAEAAAABAAAAAwBAAAAAAT2lvOfhSvYuTt/bhuJIxnVho7k68RSmZ4=

-- https://lua.expert/
local t = {
	format = function(p1, p2, p3) --[[ format | Line: 20 ]]
		if type(p1) ~= "number" or p1 <= 0 then
			return ""
		end

		local v1 = math.floor(p1)

		if p3 == nil then
			return DateTime.fromUnixTimestamp(v1):FormatLocalTime(p2, "en-us")
		end

		return DateTime.fromUnixTimestamp(v1 + p3 * 3600):FormatUniversalTime(p2, "en-us")
	end
}

function t.unixToDate(p1, p2) --[[ unixToDate | Line: 39 | Upvalues: t (copy) ]]
	return t.format(p1, "M/D/YYYY", p2)
end
function t.unixToTime(p1, p2) --[[ unixToTime | Line: 43 | Upvalues: t (copy) ]]
	return t.format(p1, "h:mm A", p2)
end
function t.unixToDateOrTime(p1, p2) --[[ unixToDateOrTime | Line: 47 | Upvalues: t (copy) ]]
	local v1 = t.format(os.time(), "M/D/YYYY", p2)
	local v2 = t.format(p1, "M/D/YYYY", p2)

	if v2 == "" or v2 ~= v1 then
		return t.unixToDate(p1, p2)
	end

	return t.unixToTime(p1, p2)
end

return t