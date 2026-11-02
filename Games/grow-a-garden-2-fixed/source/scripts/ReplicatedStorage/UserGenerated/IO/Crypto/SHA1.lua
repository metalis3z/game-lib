--credit to quartz games studio
require(game.ReplicatedStorage.UserGenerated.IO.Crypto.Hash)

local v1 = table.create(80, 0)

function processBlocks(p1, p2, p3, p4) --[[ processBlocks | Line: 37 | Upvalues: v1 (copy) ]]
	local v12 = v1
	local v2 = p1[1]
	local v3 = p1[2]
	local v4 = p1[3]
	local v5 = p1[4]
	local v6 = p1[5]

	for i = p3, p4, 64 do
		local sum = i

		for j = 1, 16 do
			local v7, v8, v9, v10 = string.byte(p2, sum, sum + 3)
			local v11 = bit32.lshift(v7, 24)
			local v122 = bit32.lshift(v8, 16)

			v12[j] = bit32.bor(v11, v122, bit32.lshift(v9, 8), v10)
			sum = sum + 4
		end

		for k = 17, 80 do
			v12[k] = bit32.lrotate(bit32.bxor(v12[k - 3], v12[k - 8], v12[k - 14], v12[k - 16]), 1)
		end

		local v19, v20, v21, v22, v23 = v2, v3, v4, v5, v6

		for n = 1, 20 do
			local v24 = bit32.lrotate(v19, 5) + bit32.band(v20, v21)

			v19, v20, v21, v22, v23 = v24 + bit32.band(bit32.bnot(v20), v22) + v23 + 1518500249 + v12[n], v19, bit32.lrotate(v20, 30), v21, v22
		end

		for m = 21, 40 do
			local v28 = bit32.lrotate(v19, 5) + bit32.bxor(v20, v21, v22) + v23 + 1859775393 + v12[m]

			v19, v20, v21, v22, v23 = v28, v19, bit32.lrotate(v20, 30), v21, v22
		end

		for i2 = 41, 60 do
			local v30 = bit32.lrotate(v19, 5) + bit32.band(v22, v21)

			v19, v22, v21, v20, v23 = v30 + bit32.band(v20, (bit32.bxor(v22, v21))) + v23 + 2400959708 + v12[i2], v21, bit32.lrotate(v20, 30), v19, v22
		end

		for i2 = 61, 80 do
			local v34 = bit32.lrotate(v19, 5) + bit32.bxor(v20, v21, v22) + v23 + 3395469782 + v12[i2]

			v19, v20, v21, v22, v23 = v34, v19, bit32.lrotate(v20, 30), v21, v22
		end

		local v36 = bit32.bor(v19 + v2, 0)
		local v37 = bit32.bor(v20 + v3, 0)
		local v38 = bit32.bor(v21 + v4, 0)
		local v39 = bit32.bor(v22 + v5, 0)

		v5, v6, v2, v3, v4 = v39, bit32.bor(v23 + v6, 0), v36, v37, v38
	end

	p1[1] = v2
	p1[2] = v3
	p1[3] = v4
	p1[4] = v5
	p1[5] = v6
end
function sha1(p1) --[[ sha1 | Line: 112 ]]
	local t = { 1732584193, 4023233417, 2562383102, 271733878, 3285377520 }
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

	local v6 = buffer.create(20)

	buffer.writeu32(v6, 0, (bit32.byteswap(t[1])))
	buffer.writeu32(v6, 4, (bit32.byteswap(t[2])))
	buffer.writeu32(v6, 8, (bit32.byteswap(t[3])))
	buffer.writeu32(v6, 12, (bit32.byteswap(t[4])))
	buffer.writeu32(v6, 16, (bit32.byteswap(t[5])))

	return v6
end

local t = {
	Name = "SHA-1",
	BlockSize = 64,
	OutputSize = 20,
	Digest = function(p1) --[[ Digest | Line: 153 ]]
		return buffer.tostring(sha1(p1))
	end,
	DigestBuffer = function(p1) --[[ DigestBuffer | Line: 156 ]]
		return sha1(buffer.tostring(p1))
	end,
	DigestToBuffer = sha1
}

table.freeze(t)

return t