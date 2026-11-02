-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local bufferWriter = require(script.Parent.Parent.process.bufferWriter)

require(script.Parent.Parent.types)

local writef32NoAlloc = bufferWriter.writef32NoAlloc
local alloc = bufferWriter.alloc
local t = {
	read = function(p1, p2) --[[ read | Line: 12 ]]
		return Vector2.new(buffer.readf32(p1, p2), (buffer.readf32(p1, p2 + 4))), 8
	end,
	write = function(p1) --[[ write | Line: 16 | Upvalues: alloc (copy), writef32NoAlloc (copy) ]]
		alloc(8)
		writef32NoAlloc(p1.X)
		writef32NoAlloc(p1.Y)
	end
}

return function() --[[ Line: 23 | Upvalues: t (copy) ]]
	return t
end