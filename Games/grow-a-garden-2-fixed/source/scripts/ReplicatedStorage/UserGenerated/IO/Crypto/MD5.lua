--credit to quartz games studio
require(game.ReplicatedStorage.UserGenerated.IO.Crypto.Hash)

local t = {
	3614090360,
	3905402710,
	606105819,
	3250441966,
	4118548399,
	1200080426,
	2821735955,
	4249261313,
	1770035416,
	2336552879,
	4294925233,
	2304563134,
	1804603682,
	4254626195,
	2792965006,
	1236535329,
	4129170786,
	3225465664,
	643717713,
	3921069994,
	3593408605,
	38016083,
	3634488961,
	3889429448,
	568446438,
	3275163606,
	4107603335,
	1163531501,
	2850285829,
	4243563512,
	1735328473,
	2368359562,
	4294588738,
	2272392833,
	1839030562,
	4259657740,
	2763975236,
	1272893353,
	4139469664,
	3200236656,
	681279174,
	3936430074,
	3572445317,
	76029189,
	3654602809,
	3873151461,
	530742520,
	3299628645,
	4096336452,
	1126891415,
	2878612391,
	4237533241,
	1700485571,
	2399980690,
	4293915773,
	2240044497,
	1873313359,
	4264355552,
	2734768916,
	1309151649,
	4149444226,
	3174756917,
	718787259,
	3951481745
}
local t2 = {
	7,
	12,
	17,
	22,
	7,
	12,
	17,
	22,
	7,
	12,
	17,
	22,
	7,
	12,
	17,
	22,
	5,
	9,
	14,
	20,
	5,
	9,
	14,
	20,
	5,
	9,
	14,
	20,
	5,
	9,
	14,
	20,
	4,
	11,
	16,
	23,
	4,
	11,
	16,
	23,
	4,
	11,
	16,
	23,
	4,
	11,
	16,
	23,
	6,
	10,
	15,
	21,
	6,
	10,
	15,
	21,
	6,
	10,
	15,
	21,
	6,
	10,
	15,
	21
}
local v1 = table.create(64, 0)

function processBlocks(p1, p2, p3, p4) --[[ processBlocks | Line: 66 | Upvalues: v1 (copy), t (copy), t2 (copy) ]]
	local v12 = v1
	local v2 = p1[1]
	local v3 = p1[2]
	local v4 = p1[3]
	local v5 = p1[4]

	for i = p3, p4, 64 do
		local sum = i

		for j = 1, 16 do
			local v6, v7, v8, v9 = string.byte(p2, sum, sum + 3)
			local v10 = bit32.lshift(v9, 24)
			local v11 = bit32.lshift(v8, 16)

			v12[j] = bit32.bor(v10, v11, bit32.lshift(v7, 8), v6)
			sum = sum + 4
		end

		local v13, v14, v15, v16 = v4, v5, v3, v2

		for k = 0, 15 do
			v13, v14, v15, v16 = v15, v13, v15 + bit32.lrotate(v16 + bit32.bxor(v14, (bit32.band(v15, (bit32.bxor(v13, v14))))) + t[k + 1] + v12[k + 1], t2[k + 1]), v14
		end

		for n = 16, 31 do
			v15, v13, v14, v16 = v15 + bit32.lrotate(v16 + bit32.bxor(v13, (bit32.band(v14, (bit32.bxor(v15, v13))))) + t[n + 1] + v12[(n * 5 + 1) % 16 + 1], t2[n + 1]), v15, v13, v14
		end

		for m = 32, 47 do
			v15, v13, v14, v16 = v15 + bit32.lrotate(v16 + bit32.bxor(v15, v13, v14) + t[m + 1] + v12[(m * 3 + 5) % 16 + 1], t2[m + 1]), v15, v13, v14
		end

		for i2 = 48, 63 do
			v14, v15, v13, v16 = v13, v15 + bit32.lrotate(v16 + bit32.bxor(v13, (bit32.bor(v15, (bit32.bnot(v14))))) + t[i2 + 1] + v12[i2 * 7 % 16 + 1], t2[i2 + 1]), v15, v14
		end

		local v35 = bit32.bor(v16 + v2)
		local v36 = bit32.bor(v15 + v3)
		local v37 = bit32.bor(v13 + v4)

		v5, v2, v3, v4 = bit32.bor(v14 + v5), v35, v36, v37
	end

	p1[1] = v2
	p1[2] = v3
	p1[3] = v4
	p1[4] = v5
end
function md5(p1) --[[ md5 | Line: 141 ]]
	local t = { 1732584193, 4023233417, 2562383102, 271733878 }
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
	t2[4] = string.pack("<L", v1 * 8)

	local v5 = table.concat(t2)

	processBlocks(t, v5, 1, #v5)

	local v6 = buffer.create(16)

	buffer.writeu32(v6, 0, t[1])
	buffer.writeu32(v6, 4, t[2])
	buffer.writeu32(v6, 8, t[3])
	buffer.writeu32(v6, 12, t[4])

	return v6
end

local t3 = {
	Name = "MD5",
	BlockSize = 64,
	OutputSize = 16,
	Digest = function(p1) --[[ Digest | Line: 181 ]]
		return buffer.tostring(md5(p1))
	end,
	DigestBuffer = function(p1) --[[ DigestBuffer | Line: 184 ]]
		return md5(buffer.tostring(p1))
	end,
	DigestToBuffer = md5
}

table.freeze(t3)

return t3