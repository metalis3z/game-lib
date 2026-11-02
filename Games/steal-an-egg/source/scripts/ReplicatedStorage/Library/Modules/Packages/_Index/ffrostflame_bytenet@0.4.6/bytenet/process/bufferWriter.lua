-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.types)

local v1 = nil
local v2 = nil
local v3 = nil
local v4 = nil
local copy = buffer.copy
local create = buffer.create

return {
	alloc = function(p1) --[[ alloc | Line: 29 | Upvalues: v2 (ref), v1 (ref), create (copy), copy (copy), v3 (ref) ]]
		if v1 <= v2 + p1 then
			v1 = v1 * 2

			local v12 = create(v1)

			copy(v12, 0, v3)
			v3 = v12
		end
	end,
	dyn_alloc = function(p1) --[[ dyn_alloc | Line: 42 | Upvalues: v2 (ref), v1 (ref), v3 (ref) ]]
		while v1 <= v2 + p1 do
			v1 = v1 * 2
		end

		local v12 = buffer.create(v1)

		buffer.copy(v12, 0, v3)
		v3 = v12
	end,
	writeu8NoAlloc = function(p1) --[[ writeu8NoAlloc | Line: 59 | Upvalues: v3 (ref), v2 (ref) ]]
		buffer.writeu8(v3, v2, p1)
		v2 = v2 + 1
	end,
	writeu8 = function(p1) --[[ writeu8 | Line: 64 | Upvalues: v2 (ref), v1 (ref), create (copy), copy (copy), v3 (ref) ]]
		if v1 <= v2 + 1 then
			v1 = v1 * 2

			local v12 = create(v1)

			copy(v12, 0, v3)
			v3 = v12
		end

		buffer.writeu8(v3, v2, p1)
		v2 = v2 + 1
	end,
	writei8 = function(p1) --[[ writei8 | Line: 70 | Upvalues: v2 (ref), v1 (ref), create (copy), copy (copy), v3 (ref) ]]
		if v1 <= v2 + 1 then
			v1 = v1 * 2

			local v12 = create(v1)

			copy(v12, 0, v3)
			v3 = v12
		end

		buffer.writei8(v3, v2, p1)
		v2 = v2 + 1
	end,
	writeReference = function(p1) --[[ writeReference | Line: 77 | Upvalues: v4 (ref), v3 (ref), v2 (ref) ]]
		table.insert(v4, p1)
		buffer.writeu8(v3, v2, #v4)
		v2 = v2 + 1
	end,
	writeu16 = function(p1) --[[ writeu16 | Line: 85 | Upvalues: v2 (ref), v1 (ref), create (copy), copy (copy), v3 (ref) ]]
		if v1 <= v2 + 2 then
			v1 = v1 * 2

			local v12 = create(v1)

			copy(v12, 0, v3)
			v3 = v12
		end

		buffer.writeu16(v3, v2, p1)
		v2 = v2 + 2
	end,
	writei16 = function(p1) --[[ writei16 | Line: 91 | Upvalues: v2 (ref), v1 (ref), create (copy), copy (copy), v3 (ref) ]]
		if v1 <= v2 + 2 then
			v1 = v1 * 2

			local v12 = create(v1)

			copy(v12, 0, v3)
			v3 = v12
		end

		buffer.writeu16(v3, v2, p1)
		v2 = v2 + 2
	end,
	writeu32 = function(p1) --[[ writeu32 | Line: 97 | Upvalues: v2 (ref), v1 (ref), create (copy), copy (copy), v3 (ref) ]]
		if v1 <= v2 + 4 then
			v1 = v1 * 2

			local v12 = create(v1)

			copy(v12, 0, v3)
			v3 = v12
		end

		buffer.writeu32(v3, v2, p1)
		v2 = v2 + 4
	end,
	writestring = function(p1) --[[ writestring | Line: 103 | Upvalues: v3 (ref), v2 (ref) ]]
		buffer.writestring(v3, v2, p1)
		v2 = v2 + string.len(p1)
	end,
	writei32 = function(p1) --[[ writei32 | Line: 108 | Upvalues: v2 (ref), v1 (ref), create (copy), copy (copy), v3 (ref) ]]
		if v1 <= v2 + 4 then
			v1 = v1 * 2

			local v12 = create(v1)

			copy(v12, 0, v3)
			v3 = v12
		end

		buffer.writei32(v3, v2, p1)
		v2 = v2 + 4
	end,
	writef32NoAlloc = function(p1) --[[ writef32NoAlloc | Line: 114 | Upvalues: v3 (ref), v2 (ref) ]]
		buffer.writef32(v3, v2, p1)
		v2 = v2 + 4
	end,
	writef64NoAlloc = function(p1) --[[ writef64NoAlloc | Line: 119 | Upvalues: v3 (ref), v2 (ref) ]]
		buffer.writef64(v3, v2, p1)
		v2 = v2 + 4
	end,
	writef32 = function(p1) --[[ writef32 | Line: 124 | Upvalues: v2 (ref), v1 (ref), create (copy), copy (copy), v3 (ref) ]]
		if v1 <= v2 + 4 then
			v1 = v1 * 2

			local v12 = create(v1)

			copy(v12, 0, v3)
			v3 = v12
		end

		buffer.writef32(v3, v2, p1)
		v2 = v2 + 4
	end,
	writef64 = function(p1) --[[ writef64 | Line: 130 | Upvalues: v2 (ref), v1 (ref), create (copy), copy (copy), v3 (ref) ]]
		if v1 <= v2 + 8 then
			v1 = v1 * 2

			local v12 = create(v1)

			copy(v12, 0, v3)
			v3 = v12
		end

		buffer.writef64(v3, v2, p1)
		v2 = v2 + 8
	end,
	writecopy = function(p1) --[[ writecopy | Line: 136 | Upvalues: v3 (ref), v2 (ref) ]]
		buffer.copy(v3, v2, p1)
		v2 = v2 + buffer.len(p1)
	end,
	writebool = function(p1) --[[ writebool | Line: 141 | Upvalues: v2 (ref), v1 (ref), create (copy), copy (copy), v3 (ref) ]]
		if v1 <= v2 + 1 then
			v1 = v1 * 2

			local v12 = create(v1)

			copy(v12, 0, v3)
			v3 = v12
		end

		buffer.writeu8(v3, v2, if p1 then 1 else 0)
		v2 = v2 + 1
	end,
	writePacket = function(p1, p2, p3, p4) --[[ writePacket | Line: 147 | Upvalues: v1 (ref), v2 (ref), v4 (ref), v3 (ref), create (copy), copy (copy) ]]
		v1 = p1.size
		v2 = p1.cursor
		v4 = p1.references
		v3 = p1.buff

		if v1 <= v2 + 1 then
			v1 = v1 * 2

			local v12 = create(v1)

			copy(v12, 0, v3)
			v3 = v12
		end

		buffer.writeu8(v3, v2, p2)
		v2 = v2 + 1
		p3(p4)
		p1.size = v1
		p1.cursor = v2
		p1.references = v4
		p1.buff = v3

		return p1
	end
}