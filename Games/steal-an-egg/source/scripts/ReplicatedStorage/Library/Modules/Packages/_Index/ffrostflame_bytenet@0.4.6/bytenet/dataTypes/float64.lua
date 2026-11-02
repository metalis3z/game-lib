-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local bufferWriter = require(script.Parent.Parent.process.bufferWriter)

require(script.Parent.Parent.types)

local t = {
	write = bufferWriter.writef64,
	read = function(p1, p2) --[[ read | Line: 9 ]]
		return buffer.readf64(p1, p2), 8
	end
}

return function() --[[ Line: 14 | Upvalues: t (copy) ]]
	return t
end