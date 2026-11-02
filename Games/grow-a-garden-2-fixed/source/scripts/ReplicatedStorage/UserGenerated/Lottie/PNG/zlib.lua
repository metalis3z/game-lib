--credit to prince games studio
local function createHuffmanTable(p1) --[[ createHuffmanTable | Line: 56 ]]
	local v1 = table.create(15, 0)

	v1[0] = 0

	for v2, v3 in p1 do
		if v3 > 0 then
			v1[v3] = (v1[v3] or 0) + 1
		end
	end

	local v4 = table.create(15)
	local v5 = 1

	for i = 1, 15 do
		local v7 = bit32.lshift(v5 + v1[i - 1], 1)

		v4[i] = v7
		v5 = v7
	end

	local t = {}
	local t2 = {}
	local t3 = {}

	for v8, v9 in p1 do
		if v9 > 0 then
			t[v4[v9]] = v8 - 1
			t2[v8 - 1] = bit32.extract(v4[v9], 0, v9)
			t3[v8 - 1] = v9
			v4[v9] = v4[v9] + 1
		end
	end

	return t, t2, t3
end

local t = {
	3,
	4,
	5,
	6,
	7,
	8,
	9,
	10,
	11,
	13,
	15,
	17,
	19,
	23,
	27,
	31,
	35,
	43,
	51,
	59,
	67,
	83,
	99,
	115,
	131,
	163,
	195,
	227,
	258
}
local t2 = {}
local t3 = {}
local t4 = {
	1,
	1,
	1,
	1,
	2,
	2,
	2,
	2,
	3,
	3,
	3,
	3,
	4,
	4,
	4,
	4,
	5,
	5,
	5,
	5,
	0
}
local t5 = {}
local t6 = {
	1,
	2,
	3,
	4,
	5,
	7,
	9,
	13,
	17,
	25,
	33,
	49,
	65,
	97,
	129,
	193,
	257,
	385,
	513,
	769,
	1025,
	1537,
	2049,
	3073,
	4097,
	6145,
	8193,
	12289,
	16385,
	24577
}
local t8 = {
	16,
	17,
	18,
	0,
	8,
	7,
	9,
	6,
	10,
	5,
	11,
	4,
	12,
	3,
	13,
	2,
	14,
	1,
	15
}
local t9 = {
	0,
	0,
	0,
	1,
	1,
	2,
	2,
	3,
	3,
	4,
	4,
	5,
	5,
	6,
	6,
	7,
	7,
	8,
	8,
	9,
	9,
	10,
	10,
	11,
	11,
	12,
	12,
	13,
	13
}

for i = 3, 258 do
	local v1 = nil

	for j = #t, 1, -1 do
		if t[j] <= i then
			v1 = j

			break
		end
	end

	t2[i] = 256 + v1
	t3[i] = i - t[v1]
	t5[i] = t4[v1 - 8] or 0
end

local t10 = {}

for k = 1, 1024 do
	local v2 = nil

	for n = #t6, 1, -1 do
		if t6[n] <= k then
			v2 = n

			break
		end
	end

	t10[k] = v2
end

local v3, v4, v5 = createHuffmanTable({
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	9,
	7,
	7,
	7,
	7,
	7,
	7,
	7,
	7,
	7,
	7,
	7,
	7,
	7,
	7,
	7,
	7,
	7,
	7,
	7,
	7,
	7,
	7,
	7,
	7,
	8,
	8,
	8,
	8,
	8,
	8,
	8,
	8
})
local v6, v7, v8 = createHuffmanTable(table.create(32, 5))

local function getStoreSize(p1) --[[ getStoreSize | Line: 118 ]]
	return math.ceil(p1 / 32768) * 5 + p1
end

local function getDistIdx(p1) --[[ getDistIdx | Line: 122 | Upvalues: t10 (copy) ]]
	if p1 < 1025 then
		return t10[p1]
	end

	if p1 < 1537 then
		return 21
	end

	if p1 < 2049 then
		return 22
	end

	if p1 < 3073 then
		return 23
	end

	if p1 < 4097 then
		return 24
	end

	if p1 < 6145 then
		return 25
	end

	if p1 < 8193 then
		return 26
	end

	if p1 < 12289 then
		return 27
	end

	if p1 < 16385 then
		return 28
	end

	if p1 < 24577 then
		return 29
	end

	return 30
end

local function adler32(p1, p2, p3) --[[ adler32 | Line: 139 ]]
	local sum = 1
	local sum2 = 0
	local count = 0

	for i = p2, p2 + p3 - 1 do
		sum = sum + buffer.readu8(p1, i)
		sum2 = sum2 + sum
		count = count + 1

		if count == 8400000 then
			sum = sum % 65521
			sum2 = sum2 % 65521
			count = 0
		end
	end

	return bit32.bor(bit32.lshift(sum2 % 65521, 16), sum % 65521)
end

return {
	inflate = function(p1, p2) --[[ inflate | Line: 156 | Upvalues: v3 (copy), v6 (copy), t8 (copy), createHuffmanTable (copy), t (copy), t4 (copy), t6 (copy), t9 (copy), adler32 (copy) ]]
		local v1 = buffer.readu8(p1, 0)
		local v2 = buffer.readu8(p1, 1)

		assert(if bit32.extract(v1, 0, 4) == 8 then true else false, "invalid zlib comp method")
		assert(if bit32.extract(v1, 4, 4) <= 7 then true else false, "invalid zlib window size")
		assert(if bit32.extract(v2, 5, 1) == 0 then true else false, "preset dictionary is not allowed")
		assert(if bit32.bor(bit32.lshift(v1, 8), v2) % 31 == 0 then true else false, "zlib header sum mismatch")

		local sum = 2
		local sum2 = 0

		local function readBit() --[[ readBit | Line: 167 | Upvalues: p1 (copy), sum (ref), sum2 (ref) ]]
			local v5 = bit32.extract(buffer.readu8(p1, sum), sum2)

			sum2 = sum2 + 1

			if sum2 ~= 8 then
				return v5
			end

			sum2 = 0
			sum = sum + 1

			return v5
		end

		local function readBits(p12) --[[ readBits | Line: 177 | Upvalues: p1 (copy), sum (ref), sum2 (ref) ]]
			local v1 = buffer.readbits(p1, sum * 8 + sum2, p12)

			sum2 = sum2 + p12
			sum = sum + bit32.rshift(sum2, 3)
			sum2 = bit32.band(sum2, 7)

			return v1
		end

		local function readHuffmanTable(p12) --[[ readHuffmanTable | Line: 185 | Upvalues: p1 (copy), sum (ref), sum2 (ref) ]]
			local v6 = bit32.extract(buffer.readu8(p1, sum), sum2)

			sum2 = sum2 + 1

			if sum2 == 8 then
				sum2 = 0
				sum = sum + 1
			end

			local v7 = 2 + v6

			while not p12[v7] do
				local v8 = 2 * v7
				local v13 = bit32.extract(buffer.readu8(p1, sum), sum2)

				sum2 = sum2 + 1

				if sum2 == 8 then
					sum2 = 0
					sum = sum + 1
					v7 = v8 + v13

					continue
				end

				v7 = v8 + v13
			end

			return p12[v7]
		end

		local sum3 = 0

		repeat
			local v8, v9
			local v13 = bit32.extract(buffer.readu8(p1, sum), sum2)

			sum2 = sum2 + 1

			if sum2 == 8 then
				sum2 = 0
				sum = sum + 1
			end

			local v14 = buffer.readbits(p1, sum * 8 + sum2, 2)

			sum2 = sum2 + 2
			sum = sum + bit32.rshift(sum2, 3)
			sum2 = bit32.band(sum2, 7)
			assert(if v14 == 3 then false else true, "reserved btype")

			if v14 == 0 then
				local v18

				if sum2 > 0 then
					sum = sum + 1
					sum2 = 0
				end

				local v20 = buffer.readu16(p1, sum)

				if bit32.bxor(v20, (buffer.readu16(p1, sum + 2))) == 65535 then
					v8 = true
					v18 = v13
				else
					v8 = false
					v18 = v13
				end

				assert(v8, "len ~= nlen")
				sum = sum + 4
				buffer.copy(p2, sum3, p1, sum, v20)
				sum3 = sum3 + v20
				sum = sum + v20

				continue
			end

			local v23 = v3
			local v24 = v6

			if v14 == 2 then
				local v25 = buffer.readbits(p1, sum * 8 + sum2, 5)

				sum2 = sum2 + 5
				sum = sum + bit32.rshift(sum2, 3)
				sum2 = bit32.band(sum2, 7)

				local v28 = v25 + 257
				local v29 = buffer.readbits(p1, sum * 8 + sum2, 5)

				sum2 = sum2 + 5
				sum = sum + bit32.rshift(sum2, 3)
				sum2 = bit32.band(sum2, 7)

				local v322 = v29 + 1
				local v33 = buffer.readbits(p1, sum * 8 + sum2, 4)

				sum2 = sum2 + 4
				sum = sum + bit32.rshift(sum2, 3)
				sum2 = bit32.band(sum2, 7)

				local v36 = table.create(19, 0)

				for i = 1, v33 + 4 do
					local v38 = buffer.readbits(p1, sum * 8 + sum2, 3)

					sum2 = sum2 + 3
					sum = sum + bit32.rshift(sum2, 3)
					sum2 = bit32.band(sum2, 7)
					v36[t8[i] + 1] = v38
				end

				local v41 = createHuffmanTable(v36)
				local v42 = table.create(v28)
				local v43 = nil

				repeat
					local v48 = bit32.extract(buffer.readu8(p1, sum), sum2)

					sum2 = sum2 + 1

					if sum2 == 8 then
						sum2 = 0
						sum = sum + 1
					end

					local v49 = 2 + v48

					while not v41[v49] do
						local v52 = bit32.extract(buffer.readu8(p1, sum), sum2)

						sum2 = sum2 + 1

						if sum2 == 8 then
							sum2 = 0
							sum = sum + 1
						end

						v49 = 2 * v49 + v52
					end

					local v53 = v41[v49]
					local v54 = 1

					if v53 <= 15 then
						v43 = v53
					elseif v53 == 16 then
						local v55 = buffer.readbits(p1, sum * 8 + sum2, 2)

						sum2 = sum2 + 2
						sum = sum + bit32.rshift(sum2, 3)
						sum2 = bit32.band(sum2, 7)
						v54 = v55 + 3
					elseif v53 == 17 then
						v43 = 0

						local v58 = buffer.readbits(p1, sum * 8 + sum2, 3)

						sum2 = sum2 + 3
						sum = sum + bit32.rshift(sum2, 3)
						sum2 = bit32.band(sum2, 7)
						v54 = v58 + 3
					elseif v53 == 18 then
						v43 = 0

						local v61 = buffer.readbits(p1, sum * 8 + sum2, 7)

						sum2 = sum2 + 7
						sum = sum + bit32.rshift(sum2, 3)
						sum2 = bit32.band(sum2, 7)
						v54 = v61 + 11
					end

					for j = 1, v54 do
						table.insert(v42, v43)
					end
				until v28 <= #v42

				local v64 = createHuffmanTable(v42)
				local v65 = table.create(v322)
				local v66

				v66 = nil
				v23 = v64

				repeat
					local v71 = bit32.extract(buffer.readu8(p1, sum), sum2)

					sum2 = sum2 + 1

					if sum2 == 8 then
						sum2 = 0
						sum = sum + 1
					end

					local v72 = 2 + v71

					while not v41[v72] do
						local v75 = bit32.extract(buffer.readu8(p1, sum), sum2)

						sum2 = sum2 + 1

						if sum2 == 8 then
							sum2 = 0
							sum = sum + 1
						end

						v72 = 2 * v72 + v75
					end

					local v76 = v41[v72]
					local v77 = 1

					if v76 <= 15 then
						v66 = v76
					elseif v76 == 16 then
						local v78 = buffer.readbits(p1, sum * 8 + sum2, 2)

						sum2 = sum2 + 2
						sum = sum + bit32.rshift(sum2, 3)
						sum2 = bit32.band(sum2, 7)
						v77 = v78 + 3
					elseif v76 == 17 then
						v66 = 0

						local v81 = buffer.readbits(p1, sum * 8 + sum2, 3)

						sum2 = sum2 + 3
						sum = sum + bit32.rshift(sum2, 3)
						sum2 = bit32.band(sum2, 7)
						v77 = v81 + 3
					elseif v76 == 18 then
						v66 = 0

						local v84 = buffer.readbits(p1, sum * 8 + sum2, 7)

						sum2 = sum2 + 7
						sum = sum + bit32.rshift(sum2, 3)
						sum2 = bit32.band(sum2, 7)
						v77 = v84 + 11
					end

					for k = 1, v77 do
						table.insert(v65, v66)
					end
				until v322 <= #v65

				v24 = createHuffmanTable(v65)
			end

			repeat
				local v92 = bit32.extract(buffer.readu8(p1, sum), sum2)

				sum2 = sum2 + 1

				if sum2 == 8 then
					sum2 = 0
					sum = sum + 1
				end

				local v93, v94 = v23, 2 + v92

				while not v93[v94] do
					local v97 = bit32.extract(buffer.readu8(p1, sum), sum2)

					sum2 = sum2 + 1

					if sum2 == 8 then
						sum2 = 0
						sum = sum + 1
					end

					v94 = 2 * v94 + v97
				end

				v9 = v93[v94]

				if v9 < 256 then
					buffer.writeu8(p2, sum3, v9)
					sum3 = sum3 + 1

					continue
				end

				if v9 > 256 then
					local sum4 = t[v9 - 256]

					if v9 > 268 then
						local v98 = t4[v9 - 264]
						local v99 = buffer.readbits(p1, sum * 8 + sum2, v98)

						sum2 = sum2 + v98
						sum = sum + bit32.rshift(sum2, 3)
						sum2 = bit32.band(sum2, 7)
						sum4 = sum4 + v99
					elseif v9 > 264 then
						local v103 = bit32.extract(buffer.readu8(p1, sum), sum2)

						sum2 = sum2 + 1

						if sum2 == 8 then
							sum2 = 0
							sum = sum + 1
						end

						sum4 = sum4 + v103
					end

					local v108 = bit32.extract(buffer.readu8(p1, sum), sum2)

					sum2 = sum2 + 1

					if sum2 == 8 then
						sum2 = 0
						sum = sum + 1
					end

					v109 = v24
					v110 = 2 + v108

					while not v109[v110] do
						local v113 = bit32.extract(buffer.readu8(p1, sum), sum2)

						sum2 = sum2 + 1

						if sum2 == 8 then
							sum2 = 0
							sum = sum + 1
						end

						v110 = 2 * v110 + v113
					end

					local v114 = v109[v110]
					local sum5 = t6[v114 + 1]

					if v114 > 5 then
						local v115 = t9[v114]
						local v116 = buffer.readbits(p1, sum * 8 + sum2, v115)

						sum2 = sum2 + v115
						sum = sum + bit32.rshift(sum2, 3)
						sum2 = bit32.band(sum2, 7)
						sum5 = sum5 + v116
					elseif v114 > 3 then
						local v120 = bit32.extract(buffer.readu8(p1, sum), sum2)

						sum2 = sum2 + 1

						if sum2 == 8 then
							sum2 = 0
							sum = sum + 1
						end

						sum5 = sum5 + v120
					end

					if sum4 <= sum5 then
						buffer.copy(p2, sum3, p2, sum3 - sum5, sum4)
						sum3 = sum3 + sum4

						continue
					end

					while true do
						local v121 = math.min(sum4, sum5)

						buffer.copy(p2, sum3, p2, sum3 - sum5, v121)
						sum3 = sum3 + v121
						sum4 = sum4 - v121

						if sum4 == 0 then
							break
						end

						sum5 = sum5 + v121
					end
				end
			until v9 == 256
		until v13 == 1

		if sum2 > 0 then
			sum2 = 0
			sum = sum + 1
		end

		local v122 = adler32(p2, 0, buffer.len(p2))
		local v123 = sum

		assert(if v122 == bit32.byteswap((buffer.readu32(p1, v123))) then true else false, "adler-32 checksum mismatch")

		return sum3
	end,
	deflate = function(p1) --[[ deflate | Line: 322 | Upvalues: v4 (copy), v5 (copy), t2 (copy), t3 (copy), t5 (copy), getDistIdx (copy), v7 (copy), v8 (copy), t6 (copy), t9 (copy), adler32 (copy) ]]
		local v1 = buffer.len(p1)
		local v2 = buffer.create(math.ceil(v1 / 32768) * 5 + v1 + 6)

		buffer.writeu16(v2, 0, 24184)

		local sum = 2
		local sum2 = 0

		local function writeBits(p1, p2) --[[ writeBits | Line: 333 | Upvalues: v2 (copy), sum (ref), sum2 (ref) ]]
			buffer.writebits(v2, sum * 8 + sum2, p2, p1)
			sum2 = sum2 + p2
			sum = sum + bit32.rshift(sum2, 3)
			sum2 = bit32.band(sum2, 7)
		end

		local function writeHuffmanBits(p1, p2) --[[ writeHuffmanBits | Line: 341 | Upvalues: v2 (copy), sum (ref), sum2 (ref) ]]
			local v5 = bit32.bor(bit32.band(bit32.rshift(p1, 1), 1431655765), (bit32.band(bit32.lshift(p1, 1), 2863311530)))
			local v10 = bit32.bor(bit32.band(bit32.rshift(v5, 2), 858993459), (bit32.band(bit32.lshift(v5, 2), 3435973836)))
			local v15 = bit32.bor(bit32.band(bit32.rshift(v10, 4), 252645135), (bit32.band(bit32.lshift(v10, 4), 4042322160)))
			local v20 = bit32.bor(bit32.band(bit32.rshift(v15, 8), 16711935), (bit32.band(bit32.lshift(v15, 8), 4278255360)))

			buffer.writebits(v2, sum * 8 + sum2, p2, (bit32.band(bit32.rshift(bit32.bor(bit32.rshift(v20, 16), (bit32.lshift(v20, 16))), 32 - p2), bit32.lshift(1, p2) - 1)))
			sum2 = sum2 + p2
			sum = sum + bit32.rshift(sum2, 3)
			sum2 = bit32.band(sum2, 7)
		end

		local function writeLitOrLen(p1) --[[ writeLitOrLen | Line: 351 | Upvalues: writeHuffmanBits (copy), v4 (ref), v5 (ref) ]]
			writeHuffmanBits(v4[p1], v5[p1])
		end

		local function writeBackRef(p1, p2) --[[ writeBackRef | Line: 355 | Upvalues: t2 (ref), writeHuffmanBits (copy), v4 (ref), v5 (ref), t3 (ref), t5 (ref), v2 (copy), sum (ref), sum2 (ref), getDistIdx (ref), v7 (ref), v8 (ref), t6 (ref), t9 (ref) ]]
			local v1 = t2[p2]

			writeHuffmanBits(v4[v1], v5[v1])

			if p2 > 10 then
				local v3 = t5[p2]

				buffer.writebits(v2, sum * 8 + sum2, v3, t3[p2])
				sum2 = sum2 + v3
				sum = sum + bit32.rshift(sum2, 3)
				sum2 = bit32.band(sum2, 7)
			end

			local v6 = getDistIdx(p1)

			writeHuffmanBits(v7[v6 - 1], v8[v6 - 1])

			if not (v6 > 3) then
				return
			end

			local v82 = t9[v6 - 1]

			buffer.writebits(v2, sum * 8 + sum2, v82, p1 - t6[v6])
			sum2 = sum2 + v82
			sum = sum + bit32.rshift(sum2, 3)
			sum2 = bit32.band(sum2, 7)
		end

		local function getLitOrLenSize(p1) --[[ getLitOrLenSize | Line: 367 | Upvalues: v5 (ref) ]]
			return v5[p1]
		end

		local function getBackRefSize(p1, p2) --[[ getBackRefSize | Line: 371 | Upvalues: getDistIdx (ref), t2 (ref), v5 (ref), t5 (ref), v8 (ref), t9 (ref) ]]
			local v1 = getDistIdx(p1)

			return v5[t2[p2]] + t5[p2] + v8[v1 - 1] + (t9[v1 - 1] or 0)
		end

		local t = {}
		local t4 = {}
		local t7 = {}
		local count = 0

		local function insertNode(p1, p2) --[[ insertNode | Line: 384 | Upvalues: count (ref), t (copy), t4 (copy) ]]
			count = count + 1
			t[count] = p1
			t4[count] = p2

			return count
		end

		local function clearTables() --[[ clearTables | Line: 391 | Upvalues: t (copy), t4 (copy), t7 (copy), count (ref) ]]
			table.clear(t)
			table.clear(t4)
			table.clear(t7)
			count = 0
		end

		for i = 0, v1 - 1, 32768 do
			local v3 = math.min(v1, i + 32768)
			local sum3, v42, sum4 = i, {}, 0

			while sum3 < v3 - 3 do
				local v6 = bit32.band(buffer.readu32(p1, sum3), 16777215)

				count = count + 1
				t[count] = sum3
				t4[count] = t7[v6] or 0

				local v82 = count

				t7[v6] = v82

				local v9 = t4[v82]
				local v10 = -1
				local count2 = 0
				local v11 = 0

				while true do
					if not (v9 and (sum3 - 32510 <= (t[v9] or (-1 / 0)) and (count2 < 12 and v11 < 96))) then
						break
					end

					local count3 = 3
					local v12 = t[v9]
					local v13 = if sum3 + v11 < math.min(v3, sum3 + 258) and buffer.readu8(p1, v12 + v11) ~= buffer.readu8(p1, sum3 + v11) then true else false

					while not v13 and (count3 < 258 and (sum3 + count3 < v3 and buffer.readu8(p1, v12 + count3) == buffer.readu8(p1, sum3 + count3))) do
						count3 = count3 + 1
					end

					if v11 < count3 then
						if count3 >= 258 then
							v11 = count3
							v10 = v12

							break
						end

						v10 = v12
						v11 = count3
					end

					v9 = t4[v9]
					count2 = count2 + 1
				end

				if v11 == 0 then
					local v14 = buffer.readu8(p1, sum3)

					sum4 = sum4 + v5[v14]
					table.insert(v42, (vector.create(0, v14)))
					sum3 = sum3 + 1
				else
					local v16 = getDistIdx(sum3 - v10)

					sum4 = sum4 + (v5[t2[v11]] + t5[v11] + v8[v16 - 1] + (t9[v16 - 1] or 0))
					table.insert(v42, (vector.create(1, sum3 - v10, v11)))

					for j = sum3 + 1, math.min(sum3 + v11 - 1, v3 - 4) do
						local v19 = bit32.band(buffer.readu32(p1, j), 16777215)

						count = count + 1
						t[count] = j
						t4[count] = t7[v19] or 0
						t7[v19] = count
					end

					sum3 = sum3 + v11
				end
			end

			while sum3 < v3 do
				local v21 = buffer.readu8(p1, sum3)

				sum4 = sum4 + v5[v21]
				table.insert(v42, (vector.create(0, v21)))
				sum3 = sum3 + 1
			end

			table.insert(v42, Vector3.new(0, 256, 0))

			if v3 == v1 then
				buffer.writebits(v2, sum * 8 + sum2, 1, 1)
				sum2 = sum2 + 1
				sum = sum + bit32.rshift(sum2, 3)
				sum2 = bit32.band(sum2, 7)
			else
				buffer.writebits(v2, sum * 8 + sum2, 1, 0)
				sum2 = sum2 + 1
				sum = sum + bit32.rshift(sum2, 3)
				sum2 = bit32.band(sum2, 7)
			end

			local v28 = v3 - i

			if math.ceil((sum4 + v5[256]) / 8) + 1 < math.ceil(v28 / 32768) * 5 + v28 then
				buffer.writebits(v2, sum * 8 + sum2, 2, 1)
				sum2 = sum2 + 2
				sum = sum + bit32.rshift(sum2, 3)
				sum2 = bit32.band(sum2, 7)

				for v31, v32 in v42 do
					if v32.x == 0 then
						local y = v32.y

						writeHuffmanBits(v4[y], v5[y])

						continue
					end

					writeBackRef(v32.y, v32.z)
				end
			else
				buffer.writebits(v2, sum * 8 + sum2, 2, 0)
				sum2 = sum2 + 2
				sum = sum + bit32.rshift(sum2, 3)
				sum2 = bit32.band(sum2, 7)

				if sum2 > 0 then
					sum = sum + 1
					sum2 = 0
				end

				buffer.writeu16(v2, sum, v28)
				buffer.writeu16(v2, sum + 2, (bit32.bxor(65535, v28)))
				buffer.copy(v2, sum + 4, p1, i, v28)
				sum = sum + (v28 + 4)
			end

			if count > 50000 then
				table.clear(t)
				table.clear(t4)
				table.clear(t7)
				count = 0
			end
		end

		if sum2 > 0 then
			sum = sum + 1
		end

		local v40 = sum

		buffer.writeu32(v2, v40, (bit32.byteswap((adler32(p1, 0, buffer.len(p1))))))

		return v2, sum + 4
	end
}