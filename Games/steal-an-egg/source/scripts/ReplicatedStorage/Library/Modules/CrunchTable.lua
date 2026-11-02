-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	Enum = {
		FLOAT = 1,
		VECTOR3 = 2,
		INT32 = 3,
		UBYTE = 4
	}
}

table.freeze(t.Enum)
t.Sizes = { 4, 12, 4, 1 }
table.freeze(t.Sizes)
function t.CreateLayout(p1) --[[ CreateLayout | Line: 23 | Upvalues: t (copy) ]]
	return {
		pairTable = {},
		totalBytes = 0,
		Add = function(p1, p2, p3) --[[ Add | Line: 29 | Upvalues: t (ref) ]]
			table.insert(p1.pairTable, {
				field = p2,
				enum = p3
			})
			t:CalcSize(p1)
		end
	}
end
function t.CalcSize(p1, p2) --[[ CalcSize | Line: 36 | Upvalues: t (copy) ]]
	local sum = 0

	for v1, v2 in p2.pairTable do
		v2.size = t.Sizes[v2.enum]
		sum = sum + v2.size
	end

	p2.totalBytes = sum + 2
end
function t.DeepCopy(p1, p2) --[[ DeepCopy | Line: 46 ]]
	local function v1(p1) --[[ Deep | Line: 47 | Upvalues: v1 (copy) ]]
		local v12 = table.create(#p1)

		for k, v in pairs(p1) do
			if type(v) == "table" then
				v12[k] = v1(v)

				continue
			end

			v12[k] = v
		end

		return v12
	end

	return v1(p2)
end
function t.BinaryEncodeTable(p1, p2, p3) --[[ BinaryEncodeTable | Line: 61 | Upvalues: t (copy) ]]
	local v1 = p1:DeepCopy(p2)
	local v2 = buffer.create(p3.totalBytes)
	local sum = 2
	local count = 0
	local v3 = 0

	for v4, v5 in p3.pairTable do
		local field = v5.field
		local enum = v5.enum
		local v6 = v1[field]

		if enum == t.Enum.INT32 then
			if v6 ~= nil and v6 ~= 0 then
				buffer.writei32(v2, sum, v6)
				sum = sum + v5.size
				v3 = bit32.bor(v3, (bit32.lshift(1, count)))
			end
		elseif enum == t.Enum.FLOAT then
			if v6 ~= nil and v6 ~= 0 then
				buffer.writef32(v2, sum, v6)
				sum = sum + v5.size
				v3 = bit32.bor(v3, (bit32.lshift(1, count)))
			end
		elseif enum == t.Enum.UBYTE then
			if v6 ~= nil and v6 ~= 0 then
				buffer.writeu8(v2, sum, v6)
				sum = sum + v5.size
				v3 = bit32.bor(v3, (bit32.lshift(1, count)))
			end
		elseif enum == t.Enum.VECTOR3 and (v6 ~= nil and v6.magnitude > 0) then
			buffer.writef32(v2, sum, v6.X)

			local v13 = sum + 4

			buffer.writef32(v2, v13, v6.Y)

			local v14 = v13 + 4

			buffer.writef32(v2, v14, v6.Z)
			v3, sum = bit32.bor(v3, (bit32.lshift(1, count))), v14 + 4
		end

		v1[field] = nil
		count = count + 1
	end

	buffer.writeu16(v2, 0, v3)

	local v17 = buffer.create(sum)

	buffer.copy(v17, 0, v2, 0, sum)
	v1._b = v17

	return v1
end
function t.BinaryDecodeTable(p1, p2, p3) --[[ BinaryDecodeTable | Line: 124 | Upvalues: t (copy) ]]
	local v1 = p1:DeepCopy(p2)

	if v1._b == nil then
		error("missing _b field")
	end

	local _b = v1._b

	v1._b = nil

	local v2 = buffer.readu16(_b, 0)
	local count = 0
	local sum = 2

	for v3, v4 in p3.pairTable do
		local field = v4.field
		local enum = v4.enum

		if (if bit32.band(v2, (bit32.lshift(1, count))) > 0 then true else false) == false then
			if enum == t.Enum.INT32 or (enum == t.Enum.FLOAT or enum == t.Enum.UBYTE) then
				v1[field] = 0
			elseif enum == t.Enum.VECTOR3 then
				v1[field] = Vector3.new(0, 0, 0)
			end
		elseif enum == t.Enum.INT32 then
			v1[field] = buffer.readi32(_b, sum)
			sum = sum + v4.size
		elseif enum == t.Enum.FLOAT then
			v1[field] = buffer.readf32(_b, sum)
			sum = sum + v4.size
		elseif enum == t.Enum.UBYTE then
			v1[field] = buffer.readu8(_b, sum)
			sum = sum + v4.size
		elseif enum == t.Enum.VECTOR3 then
			local v7 = buffer.readf32(_b, sum)
			local v8 = sum + 4
			local v9 = buffer.readf32(_b, v8)
			local v10 = v8 + 4

			v1[field] = Vector3.new(v7, v9, (buffer.readf32(_b, v10)))
			sum = v10 + 4
		end

		count = count + 1
	end

	return v1
end

return t