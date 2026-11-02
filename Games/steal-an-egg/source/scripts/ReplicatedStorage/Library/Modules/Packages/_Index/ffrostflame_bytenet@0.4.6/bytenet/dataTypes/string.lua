-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local bufferWriter = require(script.Parent.Parent.process.bufferWriter)

require(script.Parent.Parent.types)

local writeu16 = bufferWriter.writeu16
local writestring = bufferWriter.writestring
local dyn_alloc = bufferWriter.dyn_alloc
local t = {
	read = function(p1, p2) --[[ read | Line: 12 ]]
		local v1 = buffer.readu16(p1, p2)

		return buffer.readstring(p1, p2 + 2, v1), v1 + 2
	end,
	write = function(p1) --[[ write | Line: 17 | Upvalues: writeu16 (copy), dyn_alloc (copy), writestring (copy) ]]
		local v1 = string.len(p1)

		writeu16(v1)
		dyn_alloc(v1)
		writestring(p1)
	end
}

return function() --[[ Line: 26 | Upvalues: t (copy) ]]
	return t
end