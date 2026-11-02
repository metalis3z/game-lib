--credit to prince games studio
require(game.ReplicatedStorage.UserGenerated.IO.Crypto.Hash)

local v1 = table.create(80, 0)
local v2 = table.create(80, 0)
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
	3329325298,
	3391569614,
	3515267271,
	3940187606,
	4118630271,
	116418474,
	174292421,
	289380356,
	460393269,
	685471733,
	852142971,
	1017036298,
	1126000580,
	1288033470,
	1501505948,
	1607167915,
	1816402316
}
local t2 = {
	3609767458,
	602891725,
	3964484399,
	2173295548,
	4081628472,
	3053834265,
	2937671579,
	3664609560,
	2734883394,
	1164996542,
	1323610764,
	3590304994,
	4068182383,
	991336113,
	633803317,
	3479774868,
	2666613458,
	944711139,
	2341262773,
	2007800933,
	1495990901,
	1856431235,
	3175218132,
	2198950837,
	3999719339,
	766784016,
	2566594879,
	3203337956,
	1034457026,
	2466948901,
	3758326383,
	168717936,
	1188179964,
	1546045734,
	1522805485,
	2643833823,
	2343527390,
	1014477480,
	1206759142,
	344077627,
	1290863460,
	3158454273,
	3505952657,
	106217008,
	3606008344,
	1432725776,
	1467031594,
	851169720,
	3100823752,
	1363258195,
	3750685593,
	3785050280,
	3318307427,
	3812723403,
	2003034995,
	3602036899,
	1575990012,
	1125592928,
	2716904306,
	442776044,
	593698344,
	3733110249,
	2999351573,
	3815920427,
	3928383900,
	566280711,
	3454069534,
	4000239992,
	1914138554,
	2731055270,
	3203993006,
	320620315,
	587496836,
	1086792851,
	365543100,
	2618297676,
	3409855158,
	4234509866,
	987167468,
	1246189591
}

function lil_sig0(p1, p2) --[[ lil_sig0 | Line: 76 ]]
	local v1 = bit32.rshift(p1, 1)
	local v6 = bit32.bxor(v1, bit32.lshift(p2, 31), bit32.rshift(p1, 8), bit32.lshift(p2, 24), (bit32.rshift(p1, 7)))
	local v7 = bit32.rshift(p2, 1)
	local v8 = bit32.lshift(p1, 31)

	return v6, bit32.bxor(v7, v8, bit32.rshift(p2, 8), bit32.lshift(p1, 24), bit32.rshift(p2, 7), (bit32.lshift(p1, 25)))
end
function lil_sig1(p1, p2) --[[ lil_sig1 | Line: 98 ]]
	local v1 = bit32.rshift(p1, 19)
	local v6 = bit32.bxor(v1, bit32.lshift(p2, 13), bit32.lshift(p1, 3), bit32.rshift(p2, 29), (bit32.rshift(p1, 6)))
	local v7 = bit32.rshift(p2, 19)
	local v8 = bit32.lshift(p1, 13)

	return v6, bit32.bxor(v7, v8, bit32.lshift(p2, 3), bit32.rshift(p1, 29), bit32.rshift(p2, 6), (bit32.lshift(p1, 26)))
end
function big_sig0(p1, p2) --[[ big_sig0 | Line: 119 ]]
	local v1 = bit32.rshift(p1, 28)
	local v2 = bit32.lshift(p2, 4)
	local v7 = bit32.bxor(v1, v2, bit32.lshift(p1, 30), bit32.rshift(p2, 2), bit32.lshift(p1, 25), (bit32.rshift(p2, 7)))
	local v8 = bit32.rshift(p2, 28)
	local v9 = bit32.lshift(p1, 4)

	return v7, bit32.bxor(v8, v9, bit32.lshift(p2, 30), bit32.rshift(p1, 2), bit32.lshift(p2, 25), (bit32.rshift(p1, 7)))
end
function big_sig1(p1, p2) --[[ big_sig1 | Line: 137 ]]
	local v1 = bit32.rshift(p1, 14)
	local v2 = bit32.lshift(p2, 18)
	local v7 = bit32.bxor(v1, v2, bit32.rshift(p1, 18), bit32.lshift(p2, 14), bit32.lshift(p1, 23), (bit32.rshift(p2, 9)))
	local v8 = bit32.rshift(p2, 14)
	local v9 = bit32.lshift(p1, 18)

	return v7, bit32.bxor(v8, v9, bit32.rshift(p2, 18), bit32.lshift(p1, 14), bit32.lshift(p2, 23), (bit32.rshift(p1, 9)))
end
function processBlocks(p1, p2, p3, p4, p5) --[[ processBlocks | Line: 157 | Upvalues: v1 (copy), v2 (copy), t2 (copy), t (copy) ]]
	local v12 = v1
	local v22 = v2
	local v3 = p1[1]
	local v4 = p1[2]
	local v5 = p1[3]
	local v6 = p1[4]
	local v7 = p1[5]
	local v8 = p1[6]
	local v9 = p1[7]
	local v10 = p1[8]
	local v11 = p2[1]
	local v122 = p2[2]
	local v13 = p2[3]
	local v14 = p2[4]
	local v15 = p2[5]
	local v16 = p2[6]
	local v17 = p2[7]
	local v18 = p2[8]

	for i = p4, p5, 128 do
		local sum = i

		for j = 1, 16 do
			local v19, v20, v21, v222, v23, v24, v25, v26 = string.byte(p3, sum, sum + 7)
			local v27 = bit32.lshift(v19, 24)
			local v28 = bit32.lshift(v20, 16)

			v12[j] = bit32.bor(v27, v28, bit32.lshift(v21, 8), v222)

			local v30 = bit32.lshift(v23, 24)
			local v31 = bit32.lshift(v24, 16)

			v22[j] = bit32.bor(v30, v31, bit32.lshift(v25, 8), v26)
			sum = sum + 8
		end

		for k = 17, 80 do
			local v33, v34 = lil_sig0(v12[k - 15], v22[k - 15])
			local v35, v36 = lil_sig1(v12[k - 2], v22[k - 2])
			local v37 = v22[k - 16] + v34 + v22[k - 7] + v36

			v22[k] = bit32.bor(v37, 0)
			v12[k] = v12[k - 16] + v33 + v12[k - 7] + v35 + v37 // 4294967296
		end

		local v38, v39, v40, v41, v42, v43, v44, v45, v46, v47, v48, v49, v50, v51, v52, v53 = v15, v18, v16, v17, v10, v8, v9, v3, v11, v7, v13, v122, v5, v4, v14, v6

		for n = 1, 80 do
			local v54, v55 = big_sig0(v45, v46)
			local v56, v57 = big_sig1(v47, v38)
			local v60 = v39 + v57 + bit32.bor(bit32.band(v38, v40), bit32.band(-1 - v38, v41), 0) + t2[n] + v22[n]
			local v63 = v42 + v56 + bit32.bor(bit32.band(v47, v43), bit32.band(-1 - v47, v44), 0) + t[n] + v12[n] + v60 // 4294967296
			local v64 = bit32.bor(v60, 0)
			local v65 = v55 + bit32.band(v48, v49)
			local v67 = v65 + bit32.band(v46, (bit32.bxor(v48, v49)))
			local v68 = v54 + bit32.band(v50, v51)
			local v70 = v68 + bit32.band(v45, (bit32.bxor(v50, v51)))
			local v71 = v64 + v52
			local v73 = v64 + v67

			v38, v39, v40, v41, v42, v43, v44, v45, v46, v47, v48, v49, v50, v51, v52, v53 = bit32.bor(v71, 0), v41, v38, v40, v44, v47, v43, v63 + v70 + v73 // 4294967296, bit32.bor(v73, 0), v63 + v53 + v71 // 4294967296, v49, v46, v51, v45, v48, v50
		end

		local v75 = v11 + v46
		local v76 = bit32.bor(v3 + v45 + v75 // 4294967296, 0)
		local v77 = bit32.bor(v75, 0)
		local v78 = v122 + v49
		local v79 = bit32.bor(v4 + v51 + v78 // 4294967296, 0)
		local v80 = bit32.bor(v78, 0)
		local v81 = v13 + v48
		local v82 = bit32.bor(v5 + v50 + v81 // 4294967296, 0)
		local v83 = bit32.bor(v81, 0)
		local v84 = v14 + v52
		local v85 = bit32.bor(v6 + v53 + v84 // 4294967296, 0)
		local v86 = bit32.bor(v84, 0)
		local v87 = v15 + v38
		local v88 = bit32.bor(v7 + v47 + v87 // 4294967296, 0)
		local v89 = bit32.bor(v87, 0)
		local v90 = v16 + v40
		local v91 = bit32.bor(v8 + v43 + v90 // 4294967296, 0)
		local v92 = bit32.bor(v90, 0)
		local v93 = v17 + v41
		local v94 = bit32.bor(v9 + v44 + v93 // 4294967296, 0)
		local v95 = bit32.bor(v93, 0)
		local v96 = v18 + v39
		local v97 = bit32.bor(v10 + v42 + v96 // 4294967296, 0)

		v13, v14, v15, v16, v5, v6, v11, v122, v7, v8, v9, v10, v17, v18, v3, v4 = v83, v86, v89, v92, v82, v85, v77, v80, v88, v91, v94, v97, v95, bit32.bor(v96, 0), v76, v79
	end

	p1[1] = v3
	p2[1] = v11
	p1[2] = v4
	p2[2] = v122
	p1[3] = v5
	p2[3] = v13
	p1[4] = v6
	p2[4] = v14
	p1[5] = v7
	p2[5] = v15
	p1[6] = v8
	p2[6] = v16
	p1[7] = v9
	p2[7] = v17
	p1[8] = v10
	p2[8] = v18
end
function sha384(p1) --[[ sha384 | Line: 297 ]]
	local t = { 3418070365, 1654270250, 2438529370, 355462360, 1731405415, 2394180231, 3675008525, 1203062813 }
	local t2 = { 3238371032, 914150663, 812702999, 4144912697, 4290775857, 1750603025, 1694076839, 3204075428 }
	local v1 = #p1

	if v1 > 1125899906842624 then
		error("cannot calculate the SHA-384 hash of a string longer than 2^50 bytes", 2)
	end

	local v2 = v1 % 128

	if v1 >= 128 then
		processBlocks(t, t2, p1, 1, v1 - v2)
	end

	local v3 = bit32.band(v2 + 64, 4294963200)
	local t3 = {}

	t3[1] = if v2 == 0 then "" else string.sub(p1, -v2)
	t3[2] = "\128"
	t3[3] = string.rep("\0", (v3 - v2 - 17) % 128)
	t3[4] = string.pack(">L", v1 * 8 / 4294967296)
	t3[5] = string.pack(">L", (bit32.bor(v1 * 8)))

	local v5 = table.concat(t3)

	processBlocks(t, t2, v5, 1, #v5)

	local v6 = buffer.create(48)

	for i = 1, 6 do
		buffer.writeu32(v6, (i - 1) * 8, (bit32.byteswap(t[i])))
		buffer.writeu32(v6, (i - 1) * 8 + 4, (bit32.byteswap(t2[i])))
	end

	return v6
end

local t3 = {
	Name = "SHA-384",
	BlockSize = 128,
	OutputSize = 48,
	Digest = function(p1) --[[ Digest | Line: 348 ]]
		return buffer.tostring(sha384(p1))
	end,
	DigestBuffer = function(p1) --[[ DigestBuffer | Line: 351 ]]
		return sha384(buffer.tostring(p1))
	end,
	DigestToBuffer = sha384
}

table.freeze(t3)

return t3