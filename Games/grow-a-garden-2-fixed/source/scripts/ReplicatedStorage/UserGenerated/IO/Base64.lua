--credit to leon games studio
local v1 = buffer.create(64)
local v2 = buffer.create(256)

for i = 1, 64 do
	local v3 = i - 1
	local v4 = string.byte("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/", i)

	buffer.writeu8(v1, v3, v4)
	buffer.writeu8(v2, v4, v3)
end

function encode(p1, p2) --[[ encode | Line: 42 | Upvalues: v1 (copy) ]]
	local v12 = if p2 then p2 else buffer.len(p1)
	local v2 = math.ceil(v12 / 3)
	local v3 = v2 * 4
	local v4 = buffer.create(v3)

	for i = 1, v2 - 1 do
		local v5 = (i - 1) * 4
		local v7 = bit32.byteswap((buffer.readu32(p1, (i - 1) * 3)))
		local v8 = bit32.rshift(v7, 26)
		local v10 = bit32.band(bit32.rshift(v7, 20), 63)
		local v122 = bit32.band(bit32.rshift(v7, 14), 63)
		local v14 = bit32.band(bit32.rshift(v7, 8), 63)

		buffer.writeu8(v4, v5, (buffer.readu8(v1, v8)))
		buffer.writeu8(v4, v5 + 1, (buffer.readu8(v1, v10)))
		buffer.writeu8(v4, v5 + 2, (buffer.readu8(v1, v122)))
		buffer.writeu8(v4, v5 + 3, (buffer.readu8(v1, v14)))
	end

	local v23 = v12 % 3

	if v23 == 1 then
		local v24 = buffer.readu8(p1, v12 - 1)
		local v25 = bit32.rshift(v24, 2)
		local v27 = bit32.band(bit32.lshift(v24, 4), 63)

		buffer.writeu8(v4, v3 - 4, (buffer.readu8(v1, v25)))
		buffer.writeu8(v4, v3 - 3, (buffer.readu8(v1, v27)))
		buffer.writeu8(v4, v3 - 2, 61)
		buffer.writeu8(v4, v3 - 1, 61)

		return v4
	end

	if v23 == 2 then
		local v35 = bit32.bor(bit32.lshift(buffer.readu8(p1, v12 - 2), 8), (buffer.readu8(p1, v12 - 1)))
		local v36 = bit32.rshift(v35, 10)
		local v38 = bit32.band(bit32.rshift(v35, 4), 63)
		local v40 = bit32.band(bit32.lshift(v35, 2), 63)

		buffer.writeu8(v4, v3 - 4, (buffer.readu8(v1, v36)))
		buffer.writeu8(v4, v3 - 3, (buffer.readu8(v1, v38)))
		buffer.writeu8(v4, v3 - 2, (buffer.readu8(v1, v40)))
		buffer.writeu8(v4, v3 - 1, 61)

		return v4
	end

	if v23 == 0 and v12 ~= 0 then
		local v52 = bit32.bor(bit32.lshift(buffer.readu8(p1, v12 - 3), 16), bit32.lshift(buffer.readu8(p1, v12 - 2), 8), (buffer.readu8(p1, v12 - 1)))
		local v53 = bit32.rshift(v52, 18)
		local v55 = bit32.band(bit32.rshift(v52, 12), 63)
		local v57 = bit32.band(bit32.rshift(v52, 6), 63)
		local v58 = bit32.band(v52, 63)

		buffer.writeu8(v4, v3 - 4, (buffer.readu8(v1, v53)))
		buffer.writeu8(v4, v3 - 3, (buffer.readu8(v1, v55)))
		buffer.writeu8(v4, v3 - 2, (buffer.readu8(v1, v57)))
		buffer.writeu8(v4, v3 - 1, (buffer.readu8(v1, v58)))
	end

	return v4
end
function decode(p1) --[[ decode | Line: 115 | Upvalues: v2 (copy) ]]
	local v1 = buffer.len(p1)
	local v22 = math.ceil(v1 / 4)
	local count = 0

	if v1 ~= 0 then
		if buffer.readu8(p1, v1 - 1) == 61 then
			count = count + 1
		end

		if buffer.readu8(p1, v1 - 2) == 61 then
			count = count + 1
		end
	end

	local v3 = buffer.create(v22 * 3 - count)

	for i = 1, v22 - 1 do
		local v4 = (i - 1) * 4
		local v5 = (i - 1) * 3
		local v8 = buffer.readu8(v2, (buffer.readu8(p1, v4)))
		local v11 = buffer.readu8(v2, (buffer.readu8(p1, v4 + 1)))
		local v14 = buffer.readu8(v2, (buffer.readu8(p1, v4 + 2)))
		local v17 = buffer.readu8(v2, (buffer.readu8(p1, v4 + 3)))
		local v21 = bit32.bor(bit32.lshift(v8, 18), bit32.lshift(v11, 12), bit32.lshift(v14, 6), v17)
		local v222 = bit32.rshift(v21, 16)
		local v24 = bit32.band(bit32.rshift(v21, 8), 255)
		local v25 = bit32.band(v21, 255)

		buffer.writeu8(v3, v5, v222)
		buffer.writeu8(v3, v5 + 1, v24)
		buffer.writeu8(v3, v5 + 2, v25)
	end

	if v1 ~= 0 then
		local v26 = (v22 - 1) * 4
		local v27 = (v22 - 1) * 3
		local v30 = buffer.readu8(v2, (buffer.readu8(p1, v26)))
		local v33 = buffer.readu8(v2, (buffer.readu8(p1, v26 + 1)))
		local v36 = buffer.readu8(v2, (buffer.readu8(p1, v26 + 2)))
		local v39 = buffer.readu8(v2, (buffer.readu8(p1, v26 + 3)))
		local v43 = bit32.bor(bit32.lshift(v30, 18), bit32.lshift(v33, 12), bit32.lshift(v36, 6), v39)

		if count <= 2 then
			buffer.writeu8(v3, v27, (bit32.rshift(v43, 16)))

			if count <= 1 then
				buffer.writeu8(v3, v27 + 1, (bit32.band(bit32.rshift(v43, 8), 255)))

				if count == 0 then
					buffer.writeu8(v3, v27 + 2, (bit32.band(v43, 255)))
				end
			end
		end
	end

	return v3
end
function Encode(p1) --[[ Encode | Line: 189 ]]
	return buffer.tostring(encode(buffer.fromstring(p1)))
end
function Decode(p1) --[[ Decode | Line: 193 ]]
	return buffer.tostring(decode(buffer.fromstring(p1)))
end

return table.freeze({
	Encode = Encode,
	Decode = Decode,
	EncodeBuffer = encode,
	DecodeBuffer = decode
})