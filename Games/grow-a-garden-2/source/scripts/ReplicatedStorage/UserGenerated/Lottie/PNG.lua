--credit to quartz games studio
require(script.Types)

local chunks = require(script.chunks)
local crc32 = require(script.crc32)
local zlib = require(script.zlib)
local t = {
	[0] = 1,
	[2] = 3,
	[3] = 1,
	[4] = 2,
	[6] = 4
}
local t2 = { 0, 0, 4, 0, 2, 0, 1 }
local t3 = { 0, 4, 0, 2, 0, 1, 0 }
local t4 = { 8, 8, 8, 4, 4, 2, 2 }
local t5 = { 8, 8, 4, 4, 2, 2, 1 }

return {
	decode = function(p1, p2) --[[ decode | Line: 38 | Upvalues: crc32 (copy), chunks (copy), t (copy), t3 (copy), t5 (copy), t2 (copy), t4 (copy), zlib (copy) ]]
		local v1 = buffer.len(p1)

		assert(if v1 >= 8 then true else false, "not a PNG")
		assert(if buffer.readstring(p1, 0, 8) == "\137PNG\r\n\26\n" then true else false, "not a PNG")

		local v4 = table.create(3)
		local v5 = 8
		local v6 = if p2 == nil then false elseif p2.allowIncorrectCRC == true then true else false

		while true do
			local v8 = bit32.byteswap((buffer.readu32(p1, v5)))
			local v9 = buffer.readstring(p1, v5 + 4, 4)

			assert(string.match(v9, "%a%a%a%a"), (("invalid chunk type %*"):format(v9)))

			local v12 = v5 + 8
			local v13 = v12 + v8 + 4

			assert(if v13 <= v1 then true else false, (("EOF while reading %* chunk"):format(v9)))

			local v17 = bit32.byteswap((buffer.readu32(p1, v13 - 4)))

			assert(if v6 then v6 else v17 == crc32(p1, v5 + 4, v13 - 5), (("incorrect checksum in %*"):format(v9)))
			table.insert(v4, {
				type = v9,
				offset = v12,
				length = v8
			})

			if v1 <= v13 then
				assert(if v13 == v1 then true else false, "trailing data in file")

				for v22, v23 in v4 do
					local v24 = v23.type

					if bit32.extract(string.byte(v24, 1, 1), 5) == 0 and (v24 ~= "IHDR" and (v24 ~= "IDAT" and (v24 ~= "PLTE" and v24 ~= "IEND"))) then
						error((("unhandled critical chunk %*"):format(v24)))
					end
				end

				local v26 = v4[1]

				assert(if v26.type == "IHDR" then true else false, "first chunk must be IHDR")

				for i = 2, #v4 do
					assert(v4[i].type ~= "IHDR", "multiple IHDR chunks are not allowed")
				end

				local v29, v30, sum, v31 = -1, -1, 0, chunks.IHDR(p1, v26)

				for v32, v33 in v4 do
					if v33.type == "IDAT" then
						if v29 < 0 then
							v29 = v32
						else
							assert(v32 == v30 + 1, "multiple IDAT chunks must be consecutive")
						end

						sum = sum + v33.length
						v30 = v32
					end
				end

				assert(if v29 > 0 then true else false, "no IDAT chunks")
				assert(if sum > 0 then true else false, "no image data in IDAT chunks")

				local v37 = nil
				local v38 = -1

				for v39, v40 in v4 do
					if v40.type == "PLTE" then
						assert(not v37, "multiple PLTE chunks are not allowed")
						assert(if v39 < v29 then true else false, "PLTE not allowed after IDAT chunks")
						assert(if v31.colorType == 0 then false elseif v31.colorType == 4 then false else true, "PLTE not allowed for color type")
						v37, v38 = chunks.PLTE(p1, v40, v31), v39
					end
				end

				if v31.colorType == 3 then
					assert(v37 ~= nil, "color type requires a PLTE chunk")
				end

				local v45 = nil

				for v46, v47 in v4 do
					if v47.type == "tRNS" then
						assert(if v45 == nil then true else false, "multiple tRNS chunks are not allowed")
						assert(if v46 < v29 then true else false, "tRNS not allowed after IDAT chunks")
						assert(not v37 or (if v38 < v46 then true else false), "tRNS must be after PLTE")
						assert(if v31.colorType == 4 then false elseif v31.colorType == 6 then false else true, "tRNS not allowed for color type")
						v45 = chunks.tRNS(p1, v47, v31, v37)
					end
				end

				local v53 = v4[#v4]

				assert(if v53.type == "IEND" then true else false, "final chunk must be IEND")
				assert(if v53.length == 0 then true else false, "IEND chunk must be empty")

				for j = 2, #v4 - 1 do
					assert(v4[j].type ~= "IEND", "multiple IEND chunks are not allowed")
				end

				local v56 = buffer.create(sum)
				local sum2 = 0

				for v57, v58 in v4 do
					if v58.type == "IDAT" then
						buffer.copy(v56, sum2, p1, v58.offset, v58.length)
						sum2 = sum2 + v58.length
					end
				end

				local width = v31.width
				local height = v31.height
				local bitDepth = v31.bitDepth
				local colorType = v31.colorType
				local v59 = t[colorType]
				local sum3 = 0

				if v31.interlaced then
					for k = 1, 7 do
						local v61 = math.ceil((width - t3[k]) / t5[k])
						local v63 = math.ceil((height - t2[k]) / t4[k])

						if v61 > 0 and v63 > 0 then
							sum3 = sum3 + v63 * (math.ceil(v61 * v59 * bitDepth / 8) + 1)
						end
					end
				else
					sum3 = height * (math.ceil(width * v59 * bitDepth / 8) + 1)
				end

				local v64 = if v37 then v37.colors else nil
				local v65 = if colorType == 3 or not (bitDepth < 8) then nil else 255 / (2 ^ bitDepth - 1)
				local v66 = math.ceil(v59 * bitDepth / 8)
				local v67 = 2 ^ bitDepth - 1
				local v68 = 0
				local v69 = buffer.create(sum3)

				assert(if zlib.inflate(v56, v69) == sum3 then true else false, "decompressed data size mismatch")

				local v71 = buffer.create(width * height * 4)
				local v72 = if v45 then v45.gray else -1
				local v73 = if v45 then v45.red else -1
				local v74 = if v45 then v45.green else -1
				local v75 = if v45 then v45.blue else -1

				local function pass(p1, p2, p3, p4) --[[ pass | Line: 190 | Upvalues: width (copy), height (copy), v59 (copy), bitDepth (copy), v68 (ref), v69 (copy), v66 (copy), colorType (copy), v72 (copy), v67 (copy), v73 (copy), v74 (copy), v75 (copy), v64 (ref), v65 (ref), v71 (copy) ]]
					local v2 = math.ceil((width - p1) / p3)
					local v4 = math.ceil((height - p2) / p4)

					if v2 < 1 or v4 < 1 then
						return
					end

					local v5 = v2 * v59 * bitDepth / 8
					local v6 = math.ceil(v5)
					local sum = v68

					for i = 1, v4 do
						local v9 = buffer.readu8(v69, v68)

						v68 = v68 + 1

						if v9 == 0 or v9 == 2 and i == 1 then
							v68 = v68 + v6

							continue
						end

						if v9 == 1 then
							for j = 1, v6 do
								local v10

								v10 = if j <= v66 then 0 else buffer.readu8(v69, v68 - v66)
								buffer.writeu8(v69, v68, (bit32.band(buffer.readu8(v69, v68) + v10, 255)))
								v68 = v68 + 1
							end

							continue
						end

						if v9 == 2 then
							for k = 1, v6 do
								local v21 = buffer.readu8(v69, v68 - v6 - 1)

								buffer.writeu8(v69, v68, (bit32.band(buffer.readu8(v69, v68) + v21, 255)))
								v68 = v68 + 1
							end

							continue
						end

						if v9 == 3 then
							for n = 1, v6 do
								local v28, v29

								v28 = if n <= v66 then 0 else buffer.readu8(v69, v68 - v66)
								v29 = if i == 1 then 0 else buffer.readu8(v69, v68 - v6 - 1)
								buffer.writeu8(v69, v68, (bit32.band(buffer.readu8(v69, v68) + bit32.rshift(v28 + v29, 1), 255)))
								v68 = v68 + 1
							end

							continue
						end

						if v9 == 4 then
							for m = 1, v6 do
								local v40, v41, v42, v43

								v40 = if m <= v66 then 0 else buffer.readu8(v69, v68 - v66)
								v41 = if i == 1 then 0 else buffer.readu8(v69, v68 - v6 - 1)
								v42 = if m <= v66 or i == 1 then 0 else buffer.readu8(v69, v68 - v6 - v66 - 1)

								local v50 = math.abs(v41 - v42)
								local v51 = math.abs(v40 - v42)
								local v52 = math.abs(v40 + v41 - v42 * 2)

								v43 = if v50 <= v51 and v50 <= v52 then v40 elseif v51 <= v52 then v41 else v42
								buffer.writeu8(v69, v68, (bit32.band(buffer.readu8(v69, v68) + v43, 255)))
								v68 = v68 + 1
							end

							continue
						end

						error("invalid row filter")
					end

					local sum2 = 8

					local function readValue() --[[ readValue | Line: 249 | Upvalues: v69 (ref), sum (ref), bitDepth (ref), sum2 (ref) ]]
						local v3 = buffer.readu8(v69, sum)
						local v4

						if bitDepth < 8 then
							local v7 = bit32.extract(v3, sum2 - bitDepth, bitDepth)

							sum2 = sum2 - bitDepth

							if sum2 == 0 then
								sum2 = 8
								sum = sum + 1

								return v7
							end

							v4 = v7
						else
							if bitDepth == 8 then
								sum = sum + 1

								return v3
							end

							local v12 = bit32.bor(bit32.lshift(v3, 8), (buffer.readu8(v69, sum + 1)))

							sum = sum + 2
							v4 = v12
						end

						return v4
					end

					for i = 1, v4 do
						sum = sum + 1

						if sum2 < 8 then
							sum2 = 8
							sum = sum + 1
						end

						for i2 = 1, v2 do
							local v592 = nil
							local v60 = nil
							local v61 = nil
							local v62 = nil

							if colorType == 0 then
								local v642 = buffer.readu8(v69, sum)

								if bitDepth < 8 then
									local v672 = bit32.extract(v642, sum2 - bitDepth, bitDepth)

									sum2 = sum2 - bitDepth

									if sum2 == 0 then
										sum2 = 8
										sum = sum + 1
									end

									v642 = v672
								elseif bitDepth == 8 then
									sum = sum + 1
								else
									local v712 = bit32.bor(bit32.lshift(v642, 8), (buffer.readu8(v69, sum + 1)))

									sum = sum + 2
									v642 = v712
								end

								if v642 == v72 then
									v592 = v642
									v60 = v642
									v61 = v642
									v62 = 0
								else
									v62 = v67
									v592 = v642
									v60 = v642
									v61 = v642
								end
							elseif colorType == 2 then
								local v732 = buffer.readu8(v69, sum)

								if bitDepth < 8 then
									local v76 = bit32.extract(v732, sum2 - bitDepth, bitDepth)

									sum2 = sum2 - bitDepth

									if sum2 == 0 then
										sum2 = 8
										sum = sum + 1
									end

									v732 = v76
								elseif bitDepth == 8 then
									sum = sum + 1
								else
									local v80 = bit32.bor(bit32.lshift(v732, 8), (buffer.readu8(v69, sum + 1)))

									sum = sum + 2
									v732 = v80
								end

								local v83 = buffer.readu8(v69, sum)

								if bitDepth < 8 then
									local v86 = bit32.extract(v83, sum2 - bitDepth, bitDepth)

									sum2 = sum2 - bitDepth

									if sum2 == 0 then
										sum2 = 8
										sum = sum + 1
									end

									v83 = v86
								elseif bitDepth == 8 then
									sum = sum + 1
								else
									local v91 = bit32.bor(bit32.lshift(v83, 8), (buffer.readu8(v69, sum + 1)))

									sum = sum + 2
									v83 = v91
								end

								local v94 = buffer.readu8(v69, sum)

								if bitDepth < 8 then
									local v97 = bit32.extract(v94, sum2 - bitDepth, bitDepth)

									sum2 = sum2 - bitDepth

									if sum2 == 0 then
										sum2 = 8
										sum = sum + 1
									end

									v94 = v97
									v592 = v732
								elseif bitDepth == 8 then
									sum = sum + 1
									v592 = v732
								else
									local v102 = bit32.bor(bit32.lshift(v94, 8), (buffer.readu8(v69, sum + 1)))

									sum = sum + 2
									v94 = v102
									v592 = v732
								end

								v60 = v83
								v61 = v94
								v62 = if v592 == v73 and (v83 == v74 and v94 == v75) then 0 else v67
							elseif colorType == 3 then
								local v105 = buffer.readu8(v69, sum)

								if bitDepth < 8 then
									local v108 = bit32.extract(v105, sum2 - bitDepth, bitDepth)

									sum2 = sum2 - bitDepth

									if sum2 == 0 then
										sum2 = 8
										sum = sum + 1
									end

									v105 = v108
								elseif bitDepth == 8 then
									sum = sum + 1
								else
									local v112 = bit32.bor(bit32.lshift(v105, 8), (buffer.readu8(v69, sum + 1)))

									sum = sum + 2
									v105 = v112
								end

								local v113 = v64[v105 + 1]

								v592 = v113.r
								v60 = v113.g
								v61 = v113.b
								v62 = v113.a
							elseif colorType == 4 then
								local v115 = buffer.readu8(v69, sum)

								if bitDepth < 8 then
									local v118 = bit32.extract(v115, sum2 - bitDepth, bitDepth)

									sum2 = sum2 - bitDepth

									if sum2 == 0 then
										sum2 = 8
										sum = sum + 1
									end

									v115 = v118
								elseif bitDepth == 8 then
									sum = sum + 1
								else
									local v122 = bit32.bor(bit32.lshift(v115, 8), (buffer.readu8(v69, sum + 1)))

									sum = sum + 2
									v115 = v122
								end

								local v125 = buffer.readu8(v69, sum)

								if bitDepth < 8 then
									local v128 = bit32.extract(v125, sum2 - bitDepth, bitDepth)

									sum2 = sum2 - bitDepth

									if sum2 == 0 then
										sum2 = 8
										sum = sum + 1
									end

									v125 = v128
								elseif bitDepth == 8 then
									sum = sum + 1
								else
									local v133 = bit32.bor(bit32.lshift(v125, 8), (buffer.readu8(v69, sum + 1)))

									sum = sum + 2
									v125 = v133
								end

								v592 = v115
								v60 = v115
								v61 = v115
								v62 = v125
							elseif colorType == 6 then
								local v135 = buffer.readu8(v69, sum)

								if bitDepth < 8 then
									local v138 = bit32.extract(v135, sum2 - bitDepth, bitDepth)

									sum2 = sum2 - bitDepth

									if sum2 == 0 then
										sum2 = 8
										sum = sum + 1
									end

									v135 = v138
								elseif bitDepth == 8 then
									sum = sum + 1
								else
									local v142 = bit32.bor(bit32.lshift(v135, 8), (buffer.readu8(v69, sum + 1)))

									sum = sum + 2
									v135 = v142
								end

								local v145 = buffer.readu8(v69, sum)

								if bitDepth < 8 then
									local v148 = bit32.extract(v145, sum2 - bitDepth, bitDepth)

									sum2 = sum2 - bitDepth

									if sum2 == 0 then
										sum2 = 8
										sum = sum + 1
									end

									v145 = v148
								elseif bitDepth == 8 then
									sum = sum + 1
								else
									local v153 = bit32.bor(bit32.lshift(v145, 8), (buffer.readu8(v69, sum + 1)))

									sum = sum + 2
									v145 = v153
								end

								local v156 = buffer.readu8(v69, sum)

								if bitDepth < 8 then
									local v159 = bit32.extract(v156, sum2 - bitDepth, bitDepth)

									sum2 = sum2 - bitDepth

									if sum2 == 0 then
										sum2 = 8
										sum = sum + 1
									end

									v156 = v159
									v592 = v135
								elseif bitDepth == 8 then
									sum = sum + 1
									v592 = v135
								else
									local v164 = bit32.bor(bit32.lshift(v156, 8), (buffer.readu8(v69, sum + 1)))

									sum = sum + 2
									v156 = v164
									v592 = v135
								end

								local v167 = buffer.readu8(v69, sum)

								if bitDepth < 8 then
									local v170 = bit32.extract(v167, sum2 - bitDepth, bitDepth)

									sum2 = sum2 - bitDepth

									if sum2 == 0 then
										sum2 = 8
										sum = sum + 1
									end

									v167 = v170
									v60 = v145
								elseif bitDepth == 8 then
									sum = sum + 1
									v60 = v145
								else
									local v175 = bit32.bor(bit32.lshift(v167, 8), (buffer.readu8(v69, sum + 1)))

									sum = sum + 2
									v167 = v175
									v60 = v145
								end

								v61 = v156
								v62 = v167
							end

							if v65 then
								local v178 = math.round(v592 * v65)
								local v180 = math.round(v60 * v65)
								local v182 = math.round(v61 * v65)

								v62, v61, v60, v592 = math.round(v62 * v65), v182, v180, v178
							elseif bitDepth == 16 then
								local v185 = bit32.rshift(v592, 8)
								local v186 = bit32.rshift(v60, 8)
								local v187 = bit32.rshift(v61, 8)

								v62, v61, v60, v592 = bit32.rshift(v62, 8), v187, v186, v185
							end

							buffer.writeu32(v71, ((p2 + (i - 1) * p4) * width + (p1 + (i2 - 1) * p3)) * 4, (bit32.bor(bit32.lshift(v62, 24), bit32.lshift(v61, 16), bit32.lshift(v60, 8), v592)))
						end
					end
				end

				if v31.interlaced then
					for n = 1, 7 do
						pass(t3[n], t2[n], t5[n], t4[n])
					end
				else
					pass(0, 0, 1, 1)
				end

				return {
					width = width,
					height = height,
					pixels = v71,
					readPixel = function(p1, p2) --[[ readPixel | Line: 336 | Upvalues: width (copy), height (copy), v71 (copy) ]]
						assert(if p1 >= 1 and (p1 <= width and p2 >= 1) then if p2 <= height then true else false else false, "pixel out of range")

						local v2 = ((p2 - 1) * width + p1 - 1) * 4

						return buffer.readu8(v71, v2), buffer.readu8(v71, v2 + 1), buffer.readu8(v71, v2 + 2), buffer.readu8(v71, v2 + 3)
					end
				}
			end

			v5 = v13
		end
	end,
	encode = function(p1, p2) --[[ encode | Line: 354 | Upvalues: zlib (copy), crc32 (copy) ]]
		local width = p2.width
		local height = p2.height
		local v1 = buffer.len(p1)
		local v2 = width * height * 4

		assert(v1 == v2, (("expected %* bytes, got %* bytes"):format(v2, v1)))

		local v5 = width * 4 + 1
		local v6 = buffer.create(height * v5)

		for i = 0, height - 1 do
			local v7 = i * v5

			buffer.writeu8(v6, v7, 0)
			buffer.copy(v6, v7 + 1, p1, i * width * 4, width * 4)
		end

		local v8, v9 = zlib.deflate(v6)
		local v10 = buffer.create(33 + (8 + v9 + 4) + 12)

		buffer.writestring(v10, 0, "\137PNG\r\n\26\n")
		buffer.writeu32(v10, 8, (bit32.byteswap(13)))
		buffer.writestring(v10, 12, "IHDR")
		buffer.writeu32(v10, 16, (bit32.byteswap(width)))
		buffer.writeu32(v10, 20, (bit32.byteswap(height)))
		buffer.writeu8(v10, 24, 8)
		buffer.writeu8(v10, 25, 6)
		buffer.writeu8(v10, 26, 0)
		buffer.writeu8(v10, 27, 0)
		buffer.writeu8(v10, 28, 0)
		buffer.writeu32(v10, 29, (bit32.byteswap((crc32(v10, 12, 28)))))
		buffer.writeu32(v10, 33, (bit32.byteswap(v9)))
		buffer.writestring(v10, 37, "IDAT")
		buffer.copy(v10, 41, v8, 0, v9)

		local v17 = 41 + v9

		buffer.writeu32(v10, v17, (bit32.byteswap((crc32(v10, 37, v17 - 1)))))
		buffer.writeu32(v10, v17 + 4, 0)
		buffer.writestring(v10, v17 + 8, "IEND")
		buffer.writeu32(v10, v17 + 12, 2187346606)

		return v10
	end
}