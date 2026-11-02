--credit to prince games studio
local bxor = bit32.bxor
local copy = buffer.copy
local create = buffer.create
local len = buffer.len
local readu8 = buffer.readu8
local readu32 = buffer.readu32
local _ = buffer.tostring
local writestring = buffer.writestring
local writeu8 = buffer.writeu8
local writeu32 = buffer.writeu32
local floor = math.floor
local random = math.random
local pack = string.pack
local v1 = create(16)

local function addByteCtr(p1, p2, p3, p4, p5) --[[ addByteCtr | Line: 30 | Upvalues: readu8 (copy), writeu8 (copy) ]]
	if p5 then
		local v1 = readu8(p1, p3) + p2

		writeu8(p1, p3, v1)

		if not (v1 >= 256) then
			return
		end

		for i = p3 + 1, p4 do
			local v2 = readu8(p1, i) + 1

			writeu8(p1, i, v2)

			if v2 < 256 then
				break
			end
		end

		return
	end

	local v3 = readu8(p1, p4) + p2

	writeu8(p1, p4, v3)

	if not (v3 >= 256) then
		return
	end

	for j = p4 - 1, p3, -1 do
		local v4 = readu8(p1, j) + 1

		writeu8(p1, j, v4)

		if v4 < 256 then
			break
		end
	end
end

local t = {
	ECB = {
		FwdMode = function(p1, p2, p3, p4) --[[ FwdMode | Line: 66 | Upvalues: len (copy) ]]
			local v1 = len(p3) - 16

			assert(if v1 % 16 == 0 then true else false, "Input length must be a multiple of 16 bytes")

			for i = 0, v1, 16 do
				p1(p3, i, p4, i)
			end
		end,
		InvMode = function(p1, p2, p3, p4) --[[ InvMode | Line: 73 | Upvalues: len (copy) ]]
			local v1 = len(p3) - 16

			assert(if v1 % 16 == 0 then true else false, "Input length must be a multiple of 16 bytes")

			for i = 0, v1, 16 do
				p2(p3, i, p4, i)
			end
		end
	}
}

table.freeze(t.ECB)
t.CBC = {
	FwdMode = function(p1, p2, p3, p4, p5, p6) --[[ FwdMode | Line: 89 | Upvalues: len (copy), v1 (copy), readu32 (copy), bxor (copy), writeu32 (copy) ]]
		local v12 = len(p3) - 16

		assert(if v12 % 16 == 0 then true else false, "Input length must be a multiple of 16 bytes")

		local v3 = if p6 then p6 else v1

		assert(if len(v3) == 16 then true else false, "Initialization vector must be 16 bytes long")
		writeu32(p4, 0, (bxor(readu32(p3, 0), (readu32(v3, 0)))))
		writeu32(p4, 4, (bxor(readu32(p3, 4), (readu32(v3, 4)))))
		writeu32(p4, 8, (bxor(readu32(p3, 8), (readu32(v3, 8)))))
		writeu32(p4, 12, (bxor(readu32(p3, 12), (readu32(v3, 12)))))
		p1(p4, 0, p4, 0)

		for i = 16, v12, 16 do
			writeu32(p4, i, (bxor(readu32(p3, i), (readu32(p4, i - 16)))))
			writeu32(p4, i + 4, (bxor(readu32(p3, i + 4), (readu32(p4, i - 12)))))
			writeu32(p4, i + 8, (bxor(readu32(p3, i + 8), (readu32(p4, i - 8)))))
			writeu32(p4, i + 12, (bxor(readu32(p3, i + 12), (readu32(p4, i - 4)))))
			p1(p4, i, p4, i)
		end
	end,
	InvMode = function(p1, p2, p3, p4, p5, p6) --[[ InvMode | Line: 107 | Upvalues: len (copy), v1 (copy), readu32 (copy), bxor (copy), writeu32 (copy) ]]
		local v12 = len(p3) - 16

		assert(if v12 % 16 == 0 then true else false, "Input length must be a multiple of 16 bytes")

		local v3 = if p6 then p6 else v1

		assert(if len(v3) == 16 then true else false, "Initialization vector must be 16 bytes long")

		local v5 = readu32(p3, 0)
		local v6 = readu32(p3, 4)
		local v7 = readu32(p3, 8)
		local v8 = readu32(p3, 12)

		p2(p3, 0, p4, 0)
		writeu32(p4, 0, (bxor(readu32(p4, 0), (readu32(v3, 0)))))
		writeu32(p4, 4, (bxor(readu32(p4, 4), (readu32(v3, 4)))))
		writeu32(p4, 8, (bxor(readu32(p4, 8), (readu32(v3, 8)))))
		writeu32(p4, 12, (bxor(readu32(p4, 12), (readu32(v3, 12)))))

		for i = 16, v12, 16 do
			local v9 = readu32(p3, i)
			local v10 = readu32(p3, i + 4)
			local v11 = readu32(p3, i + 8)
			local v122 = readu32(p3, i + 12)

			p2(p3, i, p4, i)
			writeu32(p4, i, (bxor(readu32(p4, i), v5)))
			writeu32(p4, i + 4, (bxor(readu32(p4, i + 4), v6)))
			writeu32(p4, i + 8, (bxor(readu32(p4, i + 8), v7)))
			writeu32(p4, i + 12, (bxor(readu32(p4, i + 12), v8)))
			v5, v6, v7, v8 = v9, v10, v11, v122
		end
	end
}
table.freeze(t.CBC)
t.PCBC = {
	FwdMode = function(p1, p2, p3, p4, p5, p6) --[[ FwdMode | Line: 142 | Upvalues: len (copy), v1 (copy), readu32 (copy), bxor (copy), writeu32 (copy) ]]
		local v12 = len(p3) - 16

		assert(if v12 % 16 == 0 then true else false, "Input length must be a multiple of 16 bytes")

		local v3 = if p6 then p6 else v1

		assert(if len(v3) == 16 then true else false, "Initialization vector must be 16 bytes long")

		local v5 = readu32(p3, 0)
		local v6 = readu32(p3, 4)
		local v7 = readu32(p3, 8)
		local v8 = readu32(p3, 12)

		writeu32(p4, 0, (bxor(v5, (readu32(v3, 0)))))
		writeu32(p4, 4, (bxor(v6, (readu32(v3, 4)))))
		writeu32(p4, 8, (bxor(v7, (readu32(v3, 8)))))
		writeu32(p4, 12, (bxor(v8, (readu32(v3, 12)))))
		p1(p4, 0, p4, 0)

		for i = 16, v12, 16 do
			local v9 = readu32(p3, i)
			local v10 = readu32(p3, i + 4)
			local v11 = readu32(p3, i + 8)
			local v122 = readu32(p3, i + 12)

			writeu32(p4, i, (bxor(v5, v9, (readu32(p4, i - 16)))))
			writeu32(p4, i + 4, (bxor(v6, v10, (readu32(p4, i - 12)))))
			writeu32(p4, i + 8, (bxor(v7, v11, (readu32(p4, i - 8)))))
			writeu32(p4, i + 12, (bxor(v8, v122, (readu32(p4, i - 4)))))
			p1(p4, i, p4, i)
			v5, v6, v7, v8 = v9, v10, v11, v122
		end
	end,
	InvMode = function(p1, p2, p3, p4, p5, p6) --[[ InvMode | Line: 168 | Upvalues: len (copy), v1 (copy), readu32 (copy), bxor (copy), writeu32 (copy) ]]
		local v12 = len(p3) - 16

		assert(if v12 % 16 == 0 then true else false, "Input length must be a multiple of 16 bytes")

		local v3 = if p6 then p6 else v1

		assert(if len(v3) == 16 then true else false, "Initialization vector must be 16 bytes long")

		local v5 = readu32(p3, 0)
		local v6 = readu32(p3, 4)
		local v7 = readu32(p3, 8)
		local v8 = readu32(p3, 12)

		p2(p3, 0, p4, 0)

		local v9 = bxor(readu32(p4, 0), (readu32(v3, 0)))
		local v10 = bxor(readu32(p4, 4), (readu32(v3, 4)))
		local v11 = bxor(readu32(p4, 8), (readu32(v3, 8)))
		local v122 = bxor(readu32(p4, 12), (readu32(v3, 12)))

		writeu32(p4, 0, v9)
		writeu32(p4, 4, v10)
		writeu32(p4, 8, v11)
		writeu32(p4, 12, v122)

		local sum = 8
		local sum2 = 12
		local sum3 = 0
		local sum4 = 4

		for i = 16, v12, 16 do
			sum3 = sum3 + 16
			sum4 = sum4 + 16
			sum = sum + 16
			sum2 = sum2 + 16

			local v13 = readu32(p3, sum3)
			local v14 = readu32(p3, sum4)
			local v15 = readu32(p3, sum)
			local v16 = readu32(p3, sum2)

			p2(p3, i, p4, i)

			local v17 = bxor(v5, v9, (readu32(p4, sum3)))
			local v18 = bxor(v6, v10, (readu32(p4, sum4)))
			local v19 = bxor(v7, v11, (readu32(p4, sum)))
			local v20 = bxor(v8, v122, (readu32(p4, sum2)))

			writeu32(p4, sum3, v17)
			writeu32(p4, sum4, v18)
			writeu32(p4, sum, v19)
			writeu32(p4, sum2, v20)
			v7, v5, v9, v6, v10, v11, v8, v122 = v15, v13, v17, v14, v18, v19, v16, v20
		end
	end
}
table.freeze(t.PCBC)

local function cfbFwd(p1, p2, p3, p4, p5, p6) --[[ cfbFwd | Line: 216 | Upvalues: len (copy), v1 (copy), create (copy), readu8 (copy), bxor (copy), writeu8 (copy), copy (copy) ]]
	local SegmentSize = p5.SegmentSize
	local v12 = len(p3)

	assert(if v12 % SegmentSize == 0 then true else false, "Input length must be a multiple of segment size")

	local v3 = if p6 then p6 else v1

	assert(if len(v3) == 16 then true else false, "Initialization vector must be 16 bytes long")

	local v5 = p5.CommonTemp or create(31)

	if v12 == SegmentSize then
		p1(v3, 0, v5, 0)

		for i = 0, SegmentSize - 1 do
			writeu8(p4, i, (bxor(readu8(p3, i), (readu8(v5, i)))))
		end
	else
		p1(v3, 0, v5, 0)
		v6 = v3
		v7 = 16 - SegmentSize
		v8 = v12 - SegmentSize

		for j = 0, SegmentSize - 1 do
			writeu8(p4, j, (bxor(readu8(p3, j), (readu8(v5, j)))))
		end

		copy(v5, 0, v6, SegmentSize, v7)
		copy(v5, v7, p4, 0, SegmentSize)

		for k = SegmentSize, v8 - SegmentSize, SegmentSize do
			copy(v5, 16, v5, SegmentSize, v7)
			p1(v5, 0, v5, 0)

			local count = 0

			for n = k, k + SegmentSize - 1 do
				writeu8(p4, n, (bxor(readu8(p3, n), (readu8(v5, count)))))
				count = count + 1
			end

			copy(v5, 0, v5, 16, v7)
			copy(v5, v7, p4, k, SegmentSize)
		end

		p1(v5, 0, v5, 0)

		local count = 0

		for m = v8, v12 - 1 do
			writeu8(p4, m, (bxor(readu8(p3, m), (readu8(v5, count)))))
			count = count + 1
		end
	end
end

local function cfbInv(p1, p2, p3, p4, p5, p6) --[[ cfbInv | Line: 256 | Upvalues: len (copy), v1 (copy), create (copy), readu8 (copy), bxor (copy), writeu8 (copy), copy (copy) ]]
	local v12 = len(p3)
	local SegmentSize = p5.SegmentSize

	assert(if v12 % SegmentSize == 0 then true else false, "Input length must be a multiple of segment size")

	local v3 = if p6 then p6 else v1

	assert(if len(v3) == 16 then true else false, "Initialization vector must be 16 bytes long")

	local v5 = p5.CommonTemp or create(31)

	if v12 == SegmentSize then
		p1(v3, 0, v5, 0)

		for i = 0, SegmentSize - 1 do
			writeu8(p4, i, (bxor(readu8(p3, i), (readu8(v5, i)))))
		end
	else
		p1(v3, 0, v5, 0)
		v6 = v3
		v7 = 16 - SegmentSize
		v8 = v12 - SegmentSize

		for j = 0, SegmentSize - 1 do
			writeu8(p4, j, (bxor(readu8(p3, j), (readu8(v5, j)))))
		end

		copy(v5, 0, v6, SegmentSize, v7)
		copy(v5, v7, p3, 0, SegmentSize)

		for k = SegmentSize, v8 - SegmentSize, SegmentSize do
			copy(v5, 16, v5, SegmentSize, v7)
			p1(v5, 0, v5, 0)

			local count = 0

			for n = k, k + SegmentSize - 1 do
				writeu8(p4, n, (bxor(readu8(p3, n), (readu8(v5, count)))))
				count = count + 1
			end

			copy(v5, 0, v5, 16, v7)
			copy(v5, v7, p3, k, SegmentSize)
		end

		p1(v5, 0, v5, 0)

		local count = 0

		for m = v8, v12 - 1 do
			writeu8(p4, m, (bxor(readu8(p3, m), (readu8(v5, count)))))
			count = count + 1
		end
	end
end

local function ofbMode(p1, p2, p3, p4, p5, p6) --[[ ofbMode | Line: 304 | Upvalues: len (copy), v1 (copy), readu32 (copy), bxor (copy), writeu32 (copy) ]]
	local v12 = len(p3) - 16

	assert(if v12 % 16 == 0 then true else false, "Input length must be a multiple of 16 bytes")

	local v3 = if p6 then p6 else v1

	assert(if len(v3) == 16 then true else false, "Initialization vector must be 16 bytes long")

	local v5 = readu32(p3, 0)
	local v6 = readu32(p3, 4)
	local v7 = readu32(p3, 8)
	local v8 = readu32(p3, 12)

	p1(v3, 0, p4, 0)

	local v13, v14, v15, v16 = bxor(v5, (readu32(p4, 0))), bxor(v6, (readu32(p4, 4))), bxor(v7, (readu32(p4, 8))), bxor(v8, (readu32(p4, 12)))

	for i = 16, v12, 16 do
		local v17 = readu32(p3, i)
		local v18 = readu32(p3, i + 4)
		local v19 = readu32(p3, i + 8)
		local v20 = readu32(p3, i + 12)

		p1(p4, i - 16, p4, i)
		writeu32(p4, i - 16, v13)
		writeu32(p4, i - 12, v14)
		writeu32(p4, i - 8, v15)
		writeu32(p4, i - 4, v16)

		local v21 = bxor(v17, (readu32(p4, i)))
		local v22 = bxor(v18, (readu32(p4, i + 4)))
		local v23 = bxor(v19, (readu32(p4, i + 8)))

		v13, v14, v15, v16 = v21, v22, v23, bxor(v20, (readu32(p4, i + 12)))
	end

	writeu32(p4, v12, v13)
	writeu32(p4, v12 + 4, v14)
	writeu32(p4, v12 + 8, v15)
	writeu32(p4, v12 + 12, v16)
end

t.OFB = {
	FwdMode = ofbMode,
	InvMode = ofbMode
}
table.freeze(t.OFB)

local function ctrMode(p1, p2, p3, p4, p5) --[[ ctrMode | Line: 357 | Upvalues: len (copy), writestring (copy), readu32 (copy), bxor (copy), writeu32 (copy), addByteCtr (copy) ]]
	local v1 = len(p3) - 16

	assert(if v1 % 16 == 0 then true else false, "Input length must be a multiple of 16 bytes")

	local CommonTemp = p5.CommonTemp
	local InitValue = p5.InitValue
	local Prefix = p5.Prefix
	local Step = p5.Step
	local LittleEndian = p5.LittleEndian
	local v3 = #Prefix
	local v4 = v3 + #InitValue - 1

	writestring(CommonTemp, 0, Prefix)
	writestring(CommonTemp, v3, InitValue)
	writestring(CommonTemp, v4 + 1, p5.Suffix)

	local v5 = readu32(p3, 0)
	local v6 = readu32(p3, 4)
	local v7 = readu32(p3, 8)
	local v8 = readu32(p3, 12)

	p1(CommonTemp, 0, p4, 0)
	writeu32(p4, 0, (bxor(readu32(p4, 0), v5)))
	writeu32(p4, 4, (bxor(readu32(p4, 4), v6)))
	writeu32(p4, 8, (bxor(readu32(p4, 8), v7)))
	writeu32(p4, 12, (bxor(readu32(p4, 12), v8)))

	for i = 16, v1, 16 do
		local v9 = readu32(p3, i)
		local v10 = readu32(p3, i + 4)
		local v11 = readu32(p3, i + 8)
		local v12 = readu32(p3, i + 12)

		addByteCtr(CommonTemp, Step, v3, v4, LittleEndian)
		p1(CommonTemp, 0, p4, i)
		writeu32(p4, i, (bxor(v9, (readu32(p4, i)))))
		writeu32(p4, i + 4, (bxor(v10, (readu32(p4, i + 4)))))
		writeu32(p4, i + 8, (bxor(v11, (readu32(p4, i + 8)))))
		writeu32(p4, i + 12, (bxor(v12, (readu32(p4, i + 12)))))
	end
end

local t2 = {
	__index = function(p1, p2) --[[ __index | Line: 390 | Upvalues: cfbFwd (copy), cfbInv (copy), create (copy), ctrMode (copy), pack (copy), random (copy) ]]
		if p2 == "CFB" then
			return {
				SegmentSize = 16,
				FwdMode = cfbFwd,
				InvMode = cfbInv,
				CommonTemp = create(31)
			}
		end

		if p2 == "CTR" then
			return {
				Prefix = "",
				Suffix = "",
				Step = 1,
				LittleEndian = false,
				FwdMode = ctrMode,
				InvMode = ctrMode,
				InitValue = pack("I2I2I2I2I2I2I2I2", random(0, 65535), random(0, 65535), random(0, 65535), random(0, 65535), random(0, 65535), random(0, 65535), random(0, 65535), random(0, 65535)),
				CommonTemp = create(16)
			}
		end

		return nil
	end,
	__newindex = function() --[[ __newindex | Line: 403 ]] end
}

setmetatable(t, t2)
t.CFB = {}
t.CTR = {}
table.freeze(t)
t2.__metatable = "This metatable is locked"

return t