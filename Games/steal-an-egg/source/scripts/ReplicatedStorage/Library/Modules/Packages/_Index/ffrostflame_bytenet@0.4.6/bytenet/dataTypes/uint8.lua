-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.types)

local t = {
	write = require(script.Parent.Parent.process.bufferWriter).writeu8,
	read = function(p1, p2) --[[ read | Line: 9 ]]
		return buffer.readu8(p1, p2), 1
	end
}

return function() --[[ Line: 14 | Upvalues: t (copy) ]]
	return t
end