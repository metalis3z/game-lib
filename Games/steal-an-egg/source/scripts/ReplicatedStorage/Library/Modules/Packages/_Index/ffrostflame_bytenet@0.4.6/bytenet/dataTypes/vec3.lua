-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local bufferWriter = require(script.Parent.Parent.process.bufferWriter)

require(script.Parent.Parent.types)

local writef32NoAlloc = bufferWriter.writef32NoAlloc
local alloc = bufferWriter.alloc
local t = {
	read = function(p1, p2) --[[ read | Line: 11 ]]
		local v1 = buffer.readf32(p1, p2)
		local v2 = buffer.readf32(p1, p2 + 4)

		return Vector3.new(v1, v2, (buffer.readf32(p1, p2 + 8))), 12
	end,
	write = function(p1) --[[ write | Line: 15 | Upvalues: alloc (copy), writef32NoAlloc (copy) ]]
		alloc(12)
		writef32NoAlloc(p1.X)
		writef32NoAlloc(p1.Y)
		writef32NoAlloc(p1.Z)
	end
}

return function() --[[ Line: 23 | Upvalues: t (copy) ]]
	return t
end