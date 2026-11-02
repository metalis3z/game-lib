-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local bufferWriter = require(script.Parent.Parent.process.bufferWriter)

require(script.Parent.Parent.types)

local writef32NoAlloc = bufferWriter.writef32NoAlloc
local alloc = bufferWriter.alloc
local t = {
	read = function(p1, p2) --[[ read | Line: 8 ]]
		local v1 = buffer.readf32(p1, p2)
		local v2 = buffer.readf32(p1, p2 + 4)
		local v3 = buffer.readf32(p1, p2 + 8)
		local v4 = buffer.readf32(p1, p2 + 12)
		local v5 = buffer.readf32(p1, p2 + 16)
		local v6 = buffer.readf32(p1, p2 + 20)

		return CFrame.new(v1, v2, v3) * CFrame.Angles(v4, v5, v6), 24
	end,
	write = function(p1) --[[ write | Line: 18 | Upvalues: alloc (copy), writef32NoAlloc (copy) ]]
		local v1, v2, v3 = p1:ToEulerAnglesXYZ()

		alloc(24)
		writef32NoAlloc(p1.X)
		writef32NoAlloc(p1.Y)
		writef32NoAlloc(p1.Z)
		writef32NoAlloc(v1)
		writef32NoAlloc(v2)
		writef32NoAlloc(v3)
	end
}

return function() --[[ Line: 33 | Upvalues: t (copy) ]]
	return t
end