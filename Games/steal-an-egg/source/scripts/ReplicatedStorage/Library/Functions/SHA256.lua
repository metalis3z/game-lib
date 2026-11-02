-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	1116352408,
	1899447441,
	3049323471,
	3921009573,
	961987163,
	1508970993,
	2453635748,
	2870763221,
	3624381080,
	310598401,
	607225278,
	1426881987,
	1925078388,
	2162078206,
	2614888103,
	3248222580,
	3835390401,
	4022224774,
	264347078,
	604807628,
	770255983,
	1249150122,
	1555081692,
	1996064986,
	2554220882,
	2821834349,
	2952996808,
	3210313671,
	3336571891,
	3584528711,
	113926993,
	338241895,
	666307205,
	773529912,
	1294757372,
	1396182291,
	1695183700,
	1986661051,
	2177026350,
	2456956037,
	2730485921,
	2820302411,
	3259730800,
	3345764771,
	3516065817,
	3600352804,
	4094571909,
	275423344,
	430227734,
	506948616,
	659060556,
	883997877,
	958139571,
	1322822218,
	1537002063,
	1747873779,
	1955562222,
	2024104815,
	2227730452,
	2361852424,
	2428436474,
	2756734187,
	3204031479,
	3329325298
}

local function ProcessNumber(p1, p2) --[[ ProcessNumber | Line: 70 ]]
	local v1 = ""

	for i = 1, p2 do
		local v2 = bit32.band(p1, 255)

		v1 = v1 .. string.char(v2)
		p1 = bit32.rshift(p1 - v2, 8)
	end

	return string.reverse(v1)
end

local function StringTo32BitNumber(p1, p2) --[[ StringTo32BitNumber | Line: 82 ]]
	local v1 = 0

	for i = p2, p2 + 3 do
		v1 = v1 * 256 + string.byte(p1, i)
	end

	return v1
end

local function PreProcess(p1, p2) --[[ PreProcess | Line: 92 | Upvalues: ProcessNumber (copy) ]]
	local v1 = 64 - bit32.band(p2 + 9, 63)
	local v2 = ProcessNumber(8 * p2, 8)
	local v3 = p1 .. "\128" .. string.rep("\0", v1) .. v2

	assert(#v3 % 64 == 0, "Preprocessed content does not have a valid length of 64 bytes, and can not continue.")

	return v3
end

local function DigestBlock(p1, p2, p3) --[[ DigestBlock | Line: 105 | Upvalues: t (copy) ]]
	local v1 = table.create(64, 0)

	for i = 1, 16 do
		local v2 = p2 + (i - 1) * 4
		local v3 = 0

		for j = v2, v2 + 3 do
			v3 = v3 * 256 + string.byte(p1, j)
		end

		v1[i] = v3
	end

	for k = 17, 64 do
		local v4 = v1[k - 15]
		local v8 = bit32.bxor(bit32.rrotate(v4, 7), bit32.rrotate(v4, 18), (bit32.rshift(v4, 3)))
		local v9 = v1[k - 2]

		v1[k] = v1[k - 16] + v8 + v1[k - 7] + bit32.bxor(bit32.rrotate(v9, 17), bit32.rrotate(v9, 19), (bit32.rshift(v9, 10)))
	end

	local v14 = p3[1]
	local v15 = p3[2]
	local v16 = p3[3]
	local v17 = p3[4]
	local v18 = p3[5]
	local v19 = p3[6]
	local v20 = p3[7]
	local v21 = p3[8]

	for n = 1, 64 do
		local v25 = bit32.bxor(bit32.rrotate(v14, 2), bit32.rrotate(v14, 13), (bit32.rrotate(v14, 22)))
		local v29 = v25 + bit32.bxor(bit32.band(v14, v15), bit32.band(v14, v16), (bit32.band(v15, v16)))
		local v33 = bit32.bxor(bit32.rrotate(v18, 6), bit32.rrotate(v18, 11), (bit32.rrotate(v18, 25)))
		local v37 = v21 + v33 + bit32.bxor(bit32.band(v18, v19), (bit32.band(bit32.bnot(v18), v20))) + t[n] + v1[n]

		v18, v19, v20, v21, v17, v14, v15, v16 = v17 + v37, v18, v19, v20, v16, v37 + v29, v14, v15
	end

	for i, v in ipairs({ v14, v15, v16, v17, v18, v19, v20, v21 }) do
		p3[i] = bit32.band(p3[i] + v)
	end
end

return function(p1) --[[ Hash | Line: 163 | Upvalues: ProcessNumber (copy), DigestBlock (copy) ]]
	assert(type(p1) == "string", "Argument #1 must be type\"string\".")

	local v2 = #p1
	local v3 = 64 - bit32.band(v2 + 9, 63)
	local v4 = ProcessNumber(8 * v2, 8)
	local v5 = p1 .. "\128" .. string.rep("\0", v3) .. v4

	assert(#v5 % 64 == 0, "Preprocessed content does not have a valid length of 64 bytes, and can not continue.")

	local v7, v8 = v5, { 1779033703, 3144134277, 1013904242, 2773480762, 1359893119, 2600822924, 528734635, 1541459225 }

	for i = 1, #v5, 64 do
		DigestBlock(v7, i, v8)
	end

	local t = {}

	for i, v in ipairs(v8) do
		table.insert(t, ProcessNumber(v, 4))
	end

	return table.concat(t)
end