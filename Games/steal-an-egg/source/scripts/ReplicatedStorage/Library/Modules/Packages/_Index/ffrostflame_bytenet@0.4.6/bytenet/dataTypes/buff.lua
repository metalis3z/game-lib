-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local bufferWriter = require(script.Parent.Parent.process.bufferWriter)

require(script.Parent.Parent.types)

local writeu16 = bufferWriter.writeu16
local writecopy = bufferWriter.writecopy
local dyn_alloc = bufferWriter.dyn_alloc
local t = {
	read = function(p1, p2) --[[ read | Line: 9 ]]
		local v1 = buffer.readu16(p1, p2)
		local v2 = buffer.create(v1)

		buffer.copy(v2, 0, p1, p2 + 2, v1)

		return v2, v1 + 2
	end,
	write = function(p1) --[[ write | Line: 18 | Upvalues: writeu16 (copy), dyn_alloc (copy), writecopy (copy) ]]
		local v1 = buffer.len(p1)

		writeu16(v1)
		dyn_alloc(v1)
		writecopy(p1)
	end
}

return function() --[[ Line: 29 | Upvalues: t (copy) ]]
	return t
end