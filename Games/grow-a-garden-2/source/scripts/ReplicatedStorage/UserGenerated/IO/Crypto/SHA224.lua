--credit to leon games studio
require(game.ReplicatedStorage.UserGenerated.IO.Crypto.Hash)

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
local v1 = table.create(64, 0)

function processBlocks(p1, p2, p3, p4) --[[ processBlocks | Line: 49 | Upvalues: v1 (copy), t (copy) ]]
	local v12 = v1
	local v2 = p1[1]
	local v3 = p1[2]
	local v4 = p1[3]
	local v5 = p1[4]
	local v6 = p1[5]
	local v7 = p1[6]
	local v8 = p1[7]
	local v9 = p1[8]

	for i = p3, p4, 64 do
		local sum = i

		for j = 1, 16 do
			local v10, v11, v122, v13 = string.byte(p2, sum, sum + 3)
			local v14 = bit32.lshift(v10, 24)
			local v15 = bit32.lshift(v11, 16)

			v12[j] = bit32.bor(v14, v15, bit32.lshift(v122, 8), v13)
			sum = sum + 4
		end

		for k = 17, 64 do
			local v17 = v12[k - 2]
			local v18 = v12[k - 15]
			local v22 = bit32.bxor(bit32.rrotate(v17, 17), bit32.rrotate(v17, 19), (bit32.rshift(v17, 10))) + v12[k - 7]

			v12[k] = v22 + bit32.bxor(bit32.rrotate(v18, 7), bit32.rrotate(v18, 18), (bit32.rshift(v18, 3))) + v12[k - 16]
		end

		local v26, v27, v28, v29, v30, v31, v32, v33 = v7, v8, v4, v3, v2, v5, v6, v9

		for n = 1, 64 do
			local v34 = bit32.rrotate(v32, 6)
			local v35 = bit32.rrotate(v32, 11)
			local v36 = bit32.rrotate(v32, 25)
			local v37 = v33 + bit32.bxor(v34, v35, v36) + bit32.band(v32, v26)
			local v39 = v37 + bit32.band(bit32.bnot(v32), v27) + t[n] + v12[n]
			local v40 = bit32.band(v28, v29)
			local v42 = v40 + bit32.band(v30, (bit32.bxor(v28, v29)))

			v26, v27, v28, v29, v30, v31, v32, v33 = v32, v26, v29, v30, v39 + (v42 + bit32.bxor(bit32.rrotate(v30, 2), bit32.rrotate(v30, 13), (bit32.rrotate(v30, 22)))), v28, v31 + v39, v27
		end

		local v47 = bit32.bor(v30 + v2, 0)
		local v48 = bit32.bor(v29 + v3, 0)
		local v49 = bit32.bor(v28 + v4, 0)
		local v50 = bit32.bor(v31 + v5, 0)
		local v51 = bit32.bor(v32 + v6, 0)
		local v52 = bit32.bor(v26 + v7, 0)
		local v53 = bit32.bor(v27 + v8, 0)

		v5, v6, v7, v8, v9, v2, v3, v4 = v50, v51, v52, v53, bit32.bor(v33 + v9, 0), v47, v48, v49
	end

	p1[1] = v2
	p1[2] = v3
	p1[3] = v4
	p1[4] = v5
	p1[5] = v6
	p1[6] = v7
	p1[7] = v8
	p1[8] = v9
end
function sha224(p1) --[[ sha224 | Line: 128 ]]
	local t = { 3238371032, 914150663, 812702999, 4144912697, 4290775857, 1750603025, 1694076839, 3204075428 }
	local v1 = #p1
	local v2 = v1 % 64

	if v1 >= 64 then
		processBlocks(t, p1, 1, v1 - v2)
	end

	local v3 = bit32.band(v2 + 32, 4294967232)
	local t2 = {}

	t2[1] = if v2 == 0 then "" else string.sub(p1, -v2)
	t2[2] = "\128"
	t2[3] = string.rep("\0", (v3 - v2 - 9) % 64)
	t2[4] = string.pack(">L", v1 * 8)

	local v5 = table.concat(t2)

	processBlocks(t, v5, 1, #v5)

	local v6 = buffer.create(28)

	buffer.writeu32(v6, 0, (bit32.byteswap(t[1])))
	buffer.writeu32(v6, 4, (bit32.byteswap(t[2])))
	buffer.writeu32(v6, 8, (bit32.byteswap(t[3])))
	buffer.writeu32(v6, 12, (bit32.byteswap(t[4])))
	buffer.writeu32(v6, 16, (bit32.byteswap(t[5])))
	buffer.writeu32(v6, 20, (bit32.byteswap(t[6])))
	buffer.writeu32(v6, 24, (bit32.byteswap(t[7])))

	return v6
end

local t2 = {
	Name = "SHA-224",
	BlockSize = 64,
	OutputSize = 28,
	Digest = function(p1) --[[ Digest | Line: 172 ]]
		return buffer.tostring(sha224(p1))
	end,
	DigestBuffer = function(p1) --[[ DigestBuffer | Line: 175 ]]
		return sha224(buffer.tostring(p1))
	end,
	DigestToBuffer = sha224
}

table.freeze(t2)

return t2