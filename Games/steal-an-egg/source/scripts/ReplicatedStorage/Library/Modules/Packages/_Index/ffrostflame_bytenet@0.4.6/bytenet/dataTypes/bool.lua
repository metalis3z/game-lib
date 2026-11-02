-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local bufferWriter = require(script.Parent.Parent.process.bufferWriter)

require(script.Parent.Parent.types)

local t = {
	length = 1,
	read = function(p1, p2) --[[ read | Line: 11 ]]
		return buffer.readu8(p1, p2) == 1, 1
	end,
	write = bufferWriter.writebool
}

return function() --[[ Line: 20 | Upvalues: t (copy) ]]
	return t
end