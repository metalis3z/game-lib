-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local bufferWriter = require(script.Parent.Parent.process.bufferWriter)

require(script.Parent.Parent.types)

local writeu8NoAlloc = bufferWriter.writeu8NoAlloc
local alloc = bufferWriter.alloc
local t = {
	write = function(p1) --[[ write | Line: 8 | Upvalues: alloc (copy), writeu8NoAlloc (copy) ]]
		alloc(3)
		writeu8NoAlloc(p1.R * 255)
		writeu8NoAlloc(p1.G * 255)
		writeu8NoAlloc(p1.B * 255)
	end,
	read = function(p1, p2) --[[ read | Line: 14 ]]
		return Color3.fromRGB(buffer.readu8(p1, p2), buffer.readu8(p1, p2 + 1), (buffer.readu8(p1, p2 + 2))), 3
	end
}

return function() --[[ Line: 19 | Upvalues: t (copy) ]]
	return t
end