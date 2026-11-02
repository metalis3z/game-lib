--credit to quartz games studio
local EncodingService = game:GetService("EncodingService")
local v1 = newproxy(false)

local function Coalesce(p1, p2) --[[ Coalesce | Line: 9 | Upvalues: v1 (copy) ]]
	if p1 == v1 then
		return p2
	end

	return p1
end

local function Optional(p1) --[[ Optional | Line: 13 | Upvalues: v1 (copy) ]]
	if p1 == nil then
		return v1
	end

	return p1
end

local t = {}

function t.new(p1, p2) --[[ newExtension | Line: 22 | Upvalues: t (copy) ]]
	return {
		_msgpackType = t,
		type = p1,
		data = p2
	}
end
table.freeze(t)

local t2 = {}

function t2.new(p1, p2) --[[ newInt64 | Line: 38 | Upvalues: t2 (copy) ]]
	return {
		_msgpackType = t2,
		mostSignificantPart = p1,
		leastSignificantPart = p2
	}
end
table.freeze(t2)

local t3 = {}

function t3.new(p1, p2) --[[ newUInt64 | Line: 54 | Upvalues: t3 (copy) ]]
	return {
		_msgpackType = t3,
		mostSignificantPart = p1,
		leastSignificantPart = p2
	}
end
table.freeze(t3)

local function byteswap16(p1) --[[ byteswap16 | Line: 64 ]]
	local v1 = bit32.band(p1, 65535)

	return bit32.bor(bit32.rshift(v1, 8), (bit32.band(bit32.lshift(v1, 8), 65535)))
end

local function writeu16be(p1, p2, p3) --[[ writeu16be | Line: 69 ]]
	local v1 = bit32.band(p3, 65535)

	buffer.writeu16(p1, p2, (bit32.bor(bit32.rshift(v1, 8), (bit32.band(bit32.lshift(v1, 8), 65535)))))
end

local function writei16be(p1, p2, p3) --[[ writei16be | Line: 73 ]]
	local v1 = bit32.band(p3, 65535)

	buffer.writeu16(p1, p2, (bit32.bor(bit32.rshift(v1, 8), (bit32.band(bit32.lshift(v1, 8), 65535)))))
end

local function writeu32be(p1, p2, p3) --[[ writeu32be | Line: 77 ]]
	buffer.writeu32(p1, p2, (bit32.byteswap(p3)))
end

local function writei32be(p1, p2, p3) --[[ writei32be | Line: 81 ]]
	buffer.writeu32(p1, p2, (bit32.byteswap(p3)))
end

local function _writef32be(p1, p2, p3) --[[ _writef32be | Line: 86 ]]
	buffer.writef32(p1, p2, p3)
	buffer.writeu32(p1, p2, (bit32.byteswap((buffer.readu32(p1, p2)))))
end

local function writef64be(p1, p2, p3) --[[ writef64be | Line: 91 ]]
	buffer.writef64(p1, p2, p3)

	local v2 = bit32.byteswap((buffer.readu32(p1, p2)))

	buffer.writeu32(p1, p2, (bit32.byteswap((buffer.readu32(p1, p2 + 4)))))
	buffer.writeu32(p1, p2 + 4, v2)
end

local function readu16be(p1, p2) --[[ readu16be | Line: 99 ]]
	local v2 = bit32.band(buffer.readu16(p1, p2), 65535)

	return bit32.bor(bit32.rshift(v2, 8), (bit32.band(bit32.lshift(v2, 8), 65535)))
end

local function readi16be(p1, p2) --[[ readi16be | Line: 103 ]]
	local v2 = bit32.band(buffer.readu16(p1, p2), 65535)
	local v6 = bit32.bor(bit32.rshift(v2, 8), (bit32.band(bit32.lshift(v2, 8), 65535)))

	if v6 >= 32768 then
		return v6 - 65536
	end

	return v6
end

local function readu32be(p1, p2) --[[ readu32be | Line: 111 ]]
	return bit32.byteswap((buffer.readu32(p1, p2)))
end

local function readi32be(p1, p2) --[[ readi32be | Line: 115 ]]
	local v2 = bit32.byteswap((buffer.readu32(p1, p2)))

	if v2 >= 2147483648 then
		return v2 - 4294967296
	end

	return v2
end

local function readf32be(p1, p2) --[[ readf32be | Line: 123 ]]
	buffer.writeu32(p1, p2, (bit32.byteswap((buffer.readu32(p1, p2)))))

	return buffer.readf32(p1, p2)
end

local function readf64be(p1, p2) --[[ readf64be | Line: 128 ]]
	local v2 = bit32.byteswap((buffer.readu32(p1, p2)))

	buffer.writeu32(p1, p2, (bit32.byteswap((buffer.readu32(p1, p2 + 4)))))
	buffer.writeu32(p1, p2 + 4, v2)

	return buffer.readf64(p1, p2)
end

local function v2(p1, p2) --[[ parse | Line: 138 | Upvalues: v1 (copy), t (copy), v2 (copy) ]]
	local v12 = buffer.readu8(p1, p2)

	if v12 == 192 then
		return v1, p2 + 1
	end

	if v12 == 194 then
		return false, p2 + 1
	end

	if v12 == 195 then
		return true, p2 + 1
	end

	if v12 == 196 then
		local v22 = buffer.readu8(p1, p2 + 1)
		local v3 = buffer.create(v22)

		buffer.copy(v3, 0, p1, p2 + 2, v22)

		return v3, p2 + 2 + v22
	end

	if v12 == 197 then
		local v5 = bit32.band(buffer.readu16(p1, p2 + 1), 65535)
		local v9 = bit32.bor(bit32.rshift(v5, 8), (bit32.band(bit32.lshift(v5, 8), 65535)))
		local v10 = buffer.create(v9)

		buffer.copy(v10, 0, p1, p2 + 3, v9)

		return v10, p2 + 3 + v9
	end

	if v12 == 198 then
		local v122 = bit32.byteswap((buffer.readu32(p1, p2 + 1)))
		local v13 = buffer.create(v122)

		buffer.copy(v13, 0, p1, p2 + 5, v122)

		return v13, p2 + 5 + v122
	end

	if v12 == 199 then
		local v14 = buffer.readu8(p1, p2 + 1)
		local v15 = buffer.create(v14)

		buffer.copy(v15, 0, p1, p2 + 3, v14)

		return {
			_msgpackType = t,
			type = buffer.readu8(p1, p2 + 2),
			data = v15
		}, p2 + 3 + v14
	end

	if v12 == 200 then
		local v17 = bit32.band(buffer.readu16(p1, p2 + 1), 65535)
		local v21 = bit32.bor(bit32.rshift(v17, 8), (bit32.band(bit32.lshift(v17, 8), 65535)))
		local v22 = buffer.create(v21)

		buffer.copy(v22, 0, p1, p2 + 4, v21)

		return {
			_msgpackType = t,
			type = buffer.readu8(p1, p2 + 3),
			data = v22
		}, p2 + 4 + v21
	end

	if v12 == 201 then
		local v24 = bit32.byteswap((buffer.readu32(p1, p2 + 1)))
		local v25 = buffer.create(v24)

		buffer.copy(v25, 0, p1, p2 + 6, v24)

		return {
			_msgpackType = t,
			type = buffer.readu8(p1, p2 + 5),
			data = v25
		}, p2 + 6 + v24
	end

	if v12 == 202 then
		local v26 = p2 + 1

		buffer.writeu32(p1, v26, (bit32.byteswap((buffer.readu32(p1, v26)))))

		return buffer.readf32(p1, v26), p2 + 5
	end

	if v12 == 203 then
		local v29 = p2 + 1
		local v31 = bit32.byteswap((buffer.readu32(p1, v29)))

		buffer.writeu32(p1, v29, (bit32.byteswap((buffer.readu32(p1, v29 + 4)))))
		buffer.writeu32(p1, v29 + 4, v31)

		return buffer.readf64(p1, v29), p2 + 9
	end

	if v12 == 204 then
		return buffer.readu8(p1, p2 + 1), p2 + 2
	end

	if v12 == 205 then
		local v35 = bit32.band(buffer.readu16(p1, p2 + 1), 65535)

		return bit32.bor(bit32.rshift(v35, 8), (bit32.band(bit32.lshift(v35, 8), 65535))), p2 + 3
	end

	if v12 == 206 then
		return bit32.byteswap((buffer.readu32(p1, p2 + 1))), p2 + 5
	end

	if v12 == 207 then
		local v41 = bit32.byteswap((buffer.readu32(p1, p2 + 1)))

		return v41 * 4294967296 + bit32.byteswap((buffer.readu32(p1, p2 + 5))), p2 + 9
	end

	if v12 == 208 then
		return buffer.readi8(p1, p2 + 1), p2 + 2
	end

	if v12 == 209 then
		local v44 = bit32.band(buffer.readu16(p1, p2 + 1), 65535)
		local v48 = bit32.bor(bit32.rshift(v44, 8), (bit32.band(bit32.lshift(v44, 8), 65535)))

		return if v48 >= 32768 then v48 - 65536 else v48, p2 + 3
	end

	if v12 == 210 then
		local v51 = bit32.byteswap((buffer.readu32(p1, p2 + 1)))

		return if v51 >= 2147483648 then v51 - 4294967296 else v51, p2 + 5
	end

	if v12 == 211 then
		local v54 = bit32.byteswap((buffer.readu32(p1, p2 + 1)))
		local v56 = bit32.byteswap((buffer.readu32(p1, p2 + 5)))

		if v54 >= 2147483648 then
			return (v54 - 4294967296) * 4294967296 + v56, p2 + 9
		end

		return v54 * 4294967296 + v56, p2 + 9
	end

	if v12 == 212 then
		local v57 = buffer.create(1)

		buffer.copy(v57, 0, p1, p2 + 2, 1)

		return {
			_msgpackType = t,
			type = buffer.readu8(p1, p2 + 1),
			data = v57
		}, p2 + 3
	end

	if v12 == 213 then
		local v58 = buffer.create(2)

		buffer.copy(v58, 0, p1, p2 + 2, 2)

		return {
			_msgpackType = t,
			type = buffer.readu8(p1, p2 + 1),
			data = v58
		}, p2 + 4
	end

	if v12 == 214 then
		local v59 = buffer.create(4)

		buffer.copy(v59, 0, p1, p2 + 2, 4)

		return {
			_msgpackType = t,
			type = buffer.readu8(p1, p2 + 1),
			data = v59
		}, p2 + 6
	end

	if v12 == 215 then
		local v60 = buffer.create(8)

		buffer.copy(v60, 0, p1, p2 + 2, 8)

		return {
			_msgpackType = t,
			type = buffer.readu8(p1, p2 + 1),
			data = v60
		}, p2 + 10
	end

	if v12 == 216 then
		local v61 = buffer.create(16)

		buffer.copy(v61, 0, p1, p2 + 2, 16)

		return {
			_msgpackType = t,
			type = buffer.readu8(p1, p2 + 1),
			data = v61
		}, p2 + 18
	end

	if v12 == 217 then
		local v62 = buffer.readu8(p1, p2 + 1)

		return buffer.readstring(p1, p2 + 2, v62), p2 + 2 + v62
	end

	if v12 == 218 then
		local v64 = bit32.band(buffer.readu16(p1, p2 + 1), 65535)
		local v68 = bit32.bor(bit32.rshift(v64, 8), (bit32.band(bit32.lshift(v64, 8), 65535)))

		return buffer.readstring(p1, p2 + 3, v68), p2 + 3 + v68
	end

	if v12 == 219 then
		local v70 = bit32.byteswap((buffer.readu32(p1, p2 + 1)))

		return buffer.readstring(p1, p2 + 5, v70), p2 + 5 + v70
	end

	if v12 == 220 then
		local v72 = bit32.band(buffer.readu16(p1, p2 + 1), 65535)
		local v76 = bit32.bor(bit32.rshift(v72, 8), (bit32.band(bit32.lshift(v72, 8), 65535)))
		local v77 = table.create(v76)
		local v78 = p2 + 3

		for i = 1, v76 do
			local v79, v80 = v2(p1, v78)

			v77[i] = v79
			v78 = v80
		end

		return v77, v78
	end

	if v12 == 221 then
		local v82 = bit32.byteswap((buffer.readu32(p1, p2 + 1)))
		local v83 = table.create(v82)
		local v84 = p2 + 5

		for j = 1, v82 do
			local v85, v86 = v2(p1, v84)

			v83[j] = v85
			v84 = v86
		end

		return v83, v84
	end

	if v12 == 222 then
		local v88 = bit32.band(buffer.readu16(p1, p2 + 1), 65535)
		local v92 = p2 + 3
		local t2 = {}

		for k = 1, bit32.bor(bit32.rshift(v88, 8), (bit32.band(bit32.lshift(v88, 8), 65535))) do
			local v93, v94 = v2(p1, v92)
			local v95, v96 = v2(p1, v94)

			t2[v93] = v95
			v92 = v96
		end

		return t2, v92
	end

	if v12 == 223 then
		local v98 = p2 + 5
		local t2 = {}

		for n = 1, bit32.byteswap((buffer.readu32(p1, p2 + 1))) do
			local v99, v100 = v2(p1, v98)
			local v101, v102 = v2(p1, v100)

			t2[v99] = v101
			v98 = v102
		end

		return t2, v98
	end

	if v12 >= 224 then
		return v12 - 256, p2 + 1
	end

	if v12 <= 127 then
		return v12, p2 + 1
	end

	if v12 - 128 <= 15 then
		local v103 = p2 + 1
		local t2 = {}

		for m = 1, bit32.band(v12, 15) do
			local v104, v105 = v2(p1, v103)
			local v106, v107 = v2(p1, v105)

			t2[v104] = v106
			v103 = v107
		end

		return t2, v103
	end

	if v12 - 144 <= 15 then
		local v108 = bit32.band(v12, 15)
		local v109 = table.create(v108)
		local v110 = p2 + 1

		for i = 1, v108 do
			local v111, v112 = v2(p1, v110)

			v109[i] = v111
			v110 = v112
		end

		return v109, v110
	end

	if v12 - 160 <= 31 then
		local v113 = v12 - 160

		return buffer.readstring(p1, p2 + 1, v113), p2 + 1 + v113
	end

	error("Unknown type")
end

local function inflate(p1, p2) --[[ inflate | Line: 303 ]]
	local v1 = buffer.len(p1)

	if p2 <= v1 then
		return p1
	end

	while v1 < p2 do
		v1 = v1 * 2
	end

	local v2 = buffer.create(v1)

	buffer.copy(v2, 0, p1)

	return v2
end

local t4 = {
	[1] = 212,
	[2] = 213,
	[4] = 214,
	[8] = 215,
	[16] = 216
}

local function v3(p1, p2, p3, p4) --[[ encode | Line: 324 | Upvalues: v1 (copy), inflate (copy), t2 (copy), t3 (copy), t (copy), t4 (copy), v3 (copy) ]]
	if p3 == v1 then
		p3 = nil
	end

	local v12 = type(p3)

	if p3 == nil then
		local v2 = inflate(p1, p2 + 1)

		buffer.writestring(v2, p2, "\192")

		return v2, p2 + 1
	end

	if p3 == false then
		local v32 = inflate(p1, p2 + 1)

		buffer.writestring(v32, p2, "\194")

		return v32, p2 + 1
	end

	if p3 == true then
		local v4 = inflate(p1, p2 + 1)

		buffer.writestring(v4, p2, "\195")

		return v4, p2 + 1
	end

	if v12 == "string" then
		local v5 = #p3

		if v5 <= 31 then
			local v6 = inflate(p1, p2 + 1 + v5)

			buffer.writeu8(v6, p2, (bit32.bor(160, v5)))
			buffer.writestring(v6, p2 + 1, p3)

			return v6, p2 + 1 + v5
		end

		if v5 <= 255 then
			local v8 = inflate(p1, p2 + 2 + v5)

			buffer.writeu8(v8, p2, 217)
			buffer.writeu8(v8, p2 + 1, v5)
			buffer.writestring(v8, p2 + 2, p3)

			return v8, p2 + 2 + v5
		end

		if v5 <= 65535 then
			local v9 = inflate(p1, p2 + 3 + v5)

			buffer.writeu8(v9, p2, 218)

			local v10 = bit32.band(v5, 65535)

			buffer.writeu16(v9, p2 + 1, (bit32.bor(bit32.rshift(v10, 8), (bit32.band(bit32.lshift(v10, 8), 65535)))))
			buffer.writestring(v9, p2 + 3, p3)

			return v9, p2 + 3 + v5
		end

		if v5 <= 4294967295 then
			local v15 = inflate(p1, p2 + 5 + v5)

			buffer.writeu8(v15, p2, 219)
			buffer.writeu32(v15, p2 + 1, (bit32.byteswap(v5)))
			buffer.writestring(v15, p2 + 5, p3)

			return v15, p2 + 5 + v5
		end

		error("Could not encode - too long string")
	elseif v12 == "buffer" then
		local v17 = buffer.len(p3)

		if v17 <= 255 then
			local v18 = inflate(p1, p2 + 2 + v17)

			buffer.writeu8(v18, p2, 196)
			buffer.writeu8(v18, p2 + 1, v17)
			buffer.copy(v18, p2 + 2, p3)

			return v18, p2 + 2 + v17
		end

		if v17 <= 65535 then
			local v19 = inflate(p1, p2 + 3 + v17)

			buffer.writeu8(v19, p2, 197)

			local v20 = bit32.band(v17, 65535)

			buffer.writeu16(v19, p2 + 1, (bit32.bor(bit32.rshift(v20, 8), (bit32.band(bit32.lshift(v20, 8), 65535)))))
			buffer.copy(v19, p2 + 3, p3)

			return v19, p2 + 3 + v17
		end

		if v17 <= 4294967295 then
			local v25 = inflate(p1, p2 + 5 + v17)

			buffer.writeu8(v25, p2, 198)
			buffer.writeu32(v25, p2 + 1, (bit32.byteswap(v17)))
			buffer.copy(v25, p2 + 5, p3)

			return v25, p2 + 5 + v17
		end

		error("Could not encode - too long binary buffer")
	elseif v12 == "number" then
		if p3 == 0 then
			local v27 = inflate(p1, p2 + 1)

			buffer.writeu8(v27, p2, 0)

			return v27, p2 + 1
		end

		if p3 ~= p3 then
			local v28 = inflate(p1, p2 + 5)

			buffer.writestring(v28, p2, "\202\127\128\0\1")

			return v28, p2 + 5
		end

		if p3 == (1 / 0) then
			local v29 = inflate(p1, p2 + 5)

			buffer.writestring(v29, p2, "\202\127\128\0\0")

			return v29, p2 + 5
		end

		if p3 == (-1 / 0) then
			local v30 = inflate(p1, p2 + 5)

			buffer.writestring(v30, p2, "\202\255\128\0\0")

			return v30, p2 + 5
		end

		local v31, v32 = math.modf(p3)
		local v33 = math.sign(p3)

		if v32 ~= 0 or (v31 > 4294967295 or v31 < -2147483648) then
			local v34 = inflate(p1, p2 + 9)

			buffer.writeu8(v34, p2, 203)

			local v35 = p2 + 1

			buffer.writef64(v34, v35, p3)

			local v37 = bit32.byteswap((buffer.readu32(v34, v35)))

			buffer.writeu32(v34, v35, (bit32.byteswap((buffer.readu32(v34, v35 + 4)))))
			buffer.writeu32(v34, v35 + 4, v37)

			return v34, p2 + 9
		end

		if v33 > 0 then
			if v31 <= 127 then
				local v40 = inflate(p1, p2 + 1)

				buffer.writeu8(v40, p2, v31)

				return v40, p2 + 1
			end

			if v31 <= 255 then
				local v41 = inflate(p1, p2 + 2)

				buffer.writeu8(v41, p2, 204)
				buffer.writeu8(v41, p2 + 1, v31)

				return v41, p2 + 2
			end

			if v31 <= 65535 then
				local v42 = inflate(p1, p2 + 3)

				buffer.writeu8(v42, p2, 205)

				local v43 = bit32.band(v31, 65535)

				buffer.writeu16(v42, p2 + 1, (bit32.bor(bit32.rshift(v43, 8), (bit32.band(bit32.lshift(v43, 8), 65535)))))

				return v42, p2 + 3
			end

			if v31 <= 4294967295 then
				local v48 = inflate(p1, p2 + 5)

				buffer.writeu8(v48, p2, 206)
				buffer.writeu32(v48, p2 + 1, (bit32.byteswap(v31)))

				return v48, p2 + 5
			end
		else
			if v31 >= -32 then
				local v50 = inflate(p1, p2 + 1)

				buffer.writeu8(v50, p2, (bit32.bor(224, (bit32.extract(v31, 0, 5)))))

				return v50, p2 + 1
			end

			if v31 >= -128 then
				local v53 = inflate(p1, p2 + 2)

				buffer.writeu8(v53, p2, 208)
				buffer.writei8(v53, p2 + 1, v31)

				return v53, p2 + 2
			end

			if v31 >= -32768 then
				local v54 = inflate(p1, p2 + 3)

				buffer.writeu8(v54, p2, 209)

				local v55 = bit32.band(v31, 65535)

				buffer.writeu16(v54, p2 + 1, (bit32.bor(bit32.rshift(v55, 8), (bit32.band(bit32.lshift(v55, 8), 65535)))))

				return v54, p2 + 3
			end

			if v31 >= -2147483648 then
				local v60 = inflate(p1, p2 + 5)

				buffer.writeu8(v60, p2, 210)
				buffer.writeu32(v60, p2 + 1, (bit32.byteswap(v31)))

				return v60, p2 + 5
			end
		end

		error(string.format("Could not encode - unhandled number \"%s\"", (typeof(p3))))
	elseif v12 == "table" then
		local _msgpackType = p3._msgpackType

		if _msgpackType and (_msgpackType == t2 or _msgpackType == t3) then
			local v62 = inflate(p1, p2 + 9)

			buffer.writeu8(v62, p2, if _msgpackType == t3 then 207 else 211)
			buffer.writeu32(v62, p2 + 1, (bit32.byteswap(p3.mostSignificantPart)))
			buffer.writeu32(v62, p2 + 5, (bit32.byteswap(p3.leastSignificantPart)))

			return v62, p2 + 9
		elseif _msgpackType and _msgpackType == t then
			local v66 = buffer.len(p3.data)
			local v67 = t4[v66]

			if v67 then
				local v68 = inflate(p1, p2 + 2 + v66)

				buffer.writeu8(v68, p2, v67)
				buffer.writeu8(v68, p2 + 1, p3.type)
				buffer.copy(v68, p2 + 2, p3.data)

				return v68, p2 + 2 + v66
			end

			if v66 <= 255 then
				local v70 = inflate(p1, p2 + 3 + v66)

				buffer.writeu8(v70, p2, 199)
				buffer.writeu8(v70, p2 + 1, v66)
				buffer.writeu8(v70, p2 + 2, p3.type)
				buffer.copy(v70, p2 + 3, p3.data)

				return v70, p2 + 3 + v66
			end

			if v66 <= 65535 then
				local v72 = inflate(p1, p2 + 4 + v66)

				buffer.writeu8(v72, p2, 200)

				local v73 = bit32.band(v66, 65535)

				buffer.writeu16(v72, p2 + 1, (bit32.bor(bit32.rshift(v73, 8), (bit32.band(bit32.lshift(v73, 8), 65535)))))
				buffer.writeu8(v72, p2 + 3, p3.type)
				buffer.copy(v72, p2 + 4, p3.data)

				return v72, p2 + 4 + v66
			end

			if v66 <= 4294967295 then
				local v79 = inflate(p1, p2 + 6 + v66)

				buffer.writeu8(v79, p2, 201)
				buffer.writeu32(v79, p2 + 1, (bit32.byteswap(v66)))
				buffer.writeu8(v79, p2 + 5, p3.type)
				buffer.copy(v79, p2 + 6, p3.data)

				return v79, p2 + 6 + v66
			end

			error("Could not encode - too long extension data")
		end

		if p4[p3] then
			error("Can not serialize cyclic table")
		end

		p4[p3] = true

		local count = 0
		local v82 = #p3

		for k, v in pairs(p3) do
			count = count + 1
		end

		if v82 == count then
			local v83

			if v82 <= 15 then
				local v84 = inflate(p1, p2 + 1)

				buffer.writeu8(v84, p2, (bit32.bor(144, count)))
				p1 = v84
				v83 = p2 + 1
			elseif v82 <= 65535 then
				local v86 = inflate(p1, p2 + 3)

				buffer.writeu8(v86, p2, 220)

				local v87 = bit32.band(v82, 65535)

				buffer.writeu16(v86, p2 + 1, (bit32.bor(bit32.rshift(v87, 8), (bit32.band(bit32.lshift(v87, 8), 65535)))))
				p1 = v86
				v83 = p2 + 3
			elseif v82 <= 4294967295 then
				local v92 = inflate(p1, p2 + 5)

				buffer.writeu8(v92, p2, 221)
				buffer.writeu32(v92, p2 + 1, (bit32.byteswap(v82)))
				p1 = v92
				v83 = p2 + 5
			else
				error("Could not encode - too long array")
			end

			for i, v in ipairs(p3) do
				local v94, v95 = v3(p1, v83, v, p4)

				p1, v83 = v94, v95
			end

			return p1, v83
		end

		local v96

		if count <= 15 then
			local v97 = inflate(p1, p2 + 1)

			buffer.writeu8(v97, p2, (bit32.bor(128, count)))
			p1 = v97
			v96 = p2 + 1
		elseif count <= 65535 then
			local v99 = inflate(p1, p2 + 3)

			buffer.writeu8(v99, p2, 222)

			local v100 = bit32.band(count, 65535)

			buffer.writeu16(v99, p2 + 1, (bit32.bor(bit32.rshift(v100, 8), (bit32.band(bit32.lshift(v100, 8), 65535)))))
			p1 = v99
			v96 = p2 + 3
		elseif count <= 4294967295 then
			local v105 = inflate(p1, p2 + 5)

			buffer.writeu8(v105, p2, 223)
			buffer.writeu32(v105, p2 + 1, (bit32.byteswap(count)))
			p1 = v105
			v96 = p2 + 5
		else
			error("Could not encode - too long map")
		end

		for k, v in pairs(p3) do
			local v107, v108 = v3(p1, v96, k, p4)
			local v109, v110 = v3(v107, v108, v, p4)

			p1, v96 = v109, v110
		end

		return p1, v96
	end

	error(string.format("Could not encode - unsupported datatype \"%s\"", (typeof(p3))))
end

local function utf8Encode(p1) --[[ utf8Encode | Line: 594 ]]
	local v1 = math.ceil(#p1 * 1.1428571428571428)
	local v2 = buffer.create(v1)
	local sum = 0

	for i = 1, v1 do
		local v3 = math.floor(sum / 8) + 1
		local v4 = sum % 8
		local v5 = string.byte(p1, v3)

		if v4 == 0 then
			buffer.writeu8(v2, i - 1, (bit32.extract(v5, 1, 7)))
		elseif v4 == 1 then
			buffer.writeu8(v2, i - 1, (bit32.extract(v5, 0, 7)))
		else
			local v8 = string.byte(p1, v3 + 1) or 0

			buffer.writeu8(v2, i - 1, (bit32.bor(bit32.lshift(bit32.extract(v5, 0, 8 - v4), v4 - 1), (bit32.extract(v8, 9 - v4, v4 - 1)))))
		end

		sum = sum + 7
	end

	return buffer.tostring(v2)
end

local function utf8Decode(p1) --[[ utf8Decode | Line: 623 ]]
	local v1 = math.floor(#p1 * 7 / 8)
	local v2 = buffer.create(v1)
	local sum = 0

	for i = 1, v1 do
		local v3 = sum % 7
		local v5 = string.byte(p1, math.floor(sum / 7) + 1)
		local v7 = string.byte(p1, math.floor(sum / 7) + 2)

		buffer.writeu8(v2, i - 1, (bit32.bor(bit32.lshift(bit32.extract(v5, 0, 7 - v3), v3 + 1), (bit32.extract(v7, 6 - v3, v3 + 1)))))
		sum = sum + 8
	end

	return buffer.tostring(v2)
end

local function decodeData(p1) --[[ decodeData | Line: 644 | Upvalues: v2 (copy) ]]
	assert(type(p1) == "string", "must be string")
	assert(#p1 > 0, "input too short")

	return v2(buffer.fromstring(p1), 0)
end

local v4 = buffer.create(4096)

local function encodeData(p1) --[[ encodeData | Line: 654 | Upvalues: v3 (copy), v4 (ref) ]]
	local v1, v2 = v3(v4, 0, p1, {})

	v4 = v1

	return buffer.readstring(v1, 0, v2)
end

local function encodeb64(p1) --[[ encodeb64 | Line: 660 | Upvalues: v3 (copy), v4 (ref), EncodingService (copy) ]]
	local v1, v2 = v3(v4, 0, p1, {})

	v4 = v1

	local v32 = buffer.create(v2)

	buffer.copy(v32, 0, v1, 0, v2)

	return buffer.tostring(EncodingService:Base64Encode(v32))
end

local function decodeb64(p1) --[[ decodeb64 | Line: 668 | Upvalues: EncodingService (copy), v2 (copy) ]]
	return v2(EncodingService:Base64Decode(buffer.fromstring(p1)), 0)
end

local function unpack64(p1) --[[ unpack64 | Line: 673 ]]
	if p1 < 0 then
		local v1 = -1 - p1

		return bit32.bnot(v1 // 4294967296), bit32.bnot(v1)
	end

	return bit32.bor(p1 // 4294967296, 0), bit32.bor(p1, 0)
end

local function uint64(p1) --[[ uint64 | Line: 681 | Upvalues: t3 (copy) ]]
	local v1, v2

	if p1 < 0 then
		local v3 = -1 - p1
		local v4 = bit32.bnot(v3 // 4294967296)

		v1, v2 = v4, bit32.bnot(v3)
	else
		local v6 = bit32.bor(p1 // 4294967296, 0)

		v2 = bit32.bor(p1, 0)
		v1 = v6
	end

	return {
		_msgpackType = t3,
		mostSignificantPart = v1,
		leastSignificantPart = v2
	}
end

local function int64(p1) --[[ int64 | Line: 686 | Upvalues: t2 (copy) ]]
	local v1, v2

	if p1 < 0 then
		local v3 = -1 - p1
		local v4 = bit32.bnot(v3 // 4294967296)

		v1, v2 = v4, bit32.bnot(v3)
	else
		local v6 = bit32.bor(p1 // 4294967296, 0)

		v2 = bit32.bor(p1, 0)
		v1 = v6
	end

	return {
		_msgpackType = t2,
		mostSignificantPart = v1,
		leastSignificantPart = v2
	}
end

local function uint64optional(p1) --[[ uint64optional | Line: 691 | Upvalues: t3 (copy) ]]
	if p1 == nil then
		return nil
	end

	local v1, v2

	if p1 < 0 then
		local v3 = -1 - p1
		local v4 = bit32.bnot(v3 // 4294967296)

		v1, v2 = v4, bit32.bnot(v3)
	else
		local v6 = bit32.bor(p1 // 4294967296, 0)

		v2 = bit32.bor(p1, 0)
		v1 = v6
	end

	return {
		_msgpackType = t3,
		mostSignificantPart = v1,
		leastSignificantPart = v2
	}
end

local function int64optional(p1) --[[ int64optional | Line: 698 | Upvalues: t2 (copy) ]]
	if p1 == nil then
		return nil
	end

	local v1, v2

	if p1 < 0 then
		local v3 = -1 - p1
		local v4 = bit32.bnot(v3 // 4294967296)

		v1, v2 = v4, bit32.bnot(v3)
	else
		local v6 = bit32.bor(p1 // 4294967296, 0)

		v2 = bit32.bor(p1, 0)
		v1 = v6
	end

	return {
		_msgpackType = t2,
		mostSignificantPart = v1,
		leastSignificantPart = v2
	}
end

return table.freeze({
	Null = v1,
	Coalesce = Coalesce,
	Optional = Optional,
	Int64 = t2,
	UInt64 = t3,
	Extension = t,
	uint64 = uint64,
	int64 = int64,
	uint64optional = uint64optional,
	int64optional = int64optional,
	utf8Encode = utf8Encode,
	utf8Decode = utf8Decode,
	decode = decodeData,
	decodeBuffer = v2,
	encode = encodeData,
	encodeb64 = encodeb64,
	decodeb64 = decodeb64
})