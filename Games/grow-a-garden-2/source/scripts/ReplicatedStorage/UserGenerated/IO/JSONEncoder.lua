--credit to prince games studio
local t = {
	[36] = true,
	[95] = true
}
local t2 = {
	[36] = true,
	[95] = true
}
local t3 = {
	[0] = -12336,
	[1] = -12592,
	[2] = -12848,
	[3] = -13104,
	[4] = -13360,
	[5] = -13616,
	[6] = -13872,
	[7] = -14128,
	[8] = 25180,
	[9] = 29788,
	[10] = 28252,
	[11] = -25136,
	[12] = 26204,
	[13] = 29276,
	[14] = -25904,
	[15] = -26160,
	[16] = -12337,
	[17] = -12593,
	[18] = -12849,
	[19] = -13105,
	[20] = -13361,
	[21] = -13617,
	[22] = -13873,
	[23] = -14129,
	[24] = -14385,
	[25] = -14641,
	[26] = -24881,
	[27] = -25137,
	[28] = -25393,
	[29] = -25649,
	[30] = -25905,
	[31] = -26161
}

for i = 65, 90 do
	t[i] = true
	t2[i] = true
end

for j = 97, 122 do
	t[j] = true
	t2[j] = true
end

t2[48] = true
t2[49] = true
t2[50] = true
t2[51] = true
t2[52] = true
t2[53] = true
t2[54] = true
t2[55] = true
t2[56] = true
t2[57] = true

local function Stream(p1) --[[ Stream | Line: 91 ]]
	return {
		Pos = 0,
		Indent = 0,
		Pretty = false,
		Null = nil,
		QuoteChar = 34,
		UnquoteIdent = false,
		Buf = p1,
		Cap = buffer.len(p1),
		Encoders = {}
	}
end

local function ToString(p1) --[[ ToString | Line: 105 ]]
	return buffer.readstring(p1.Buf, 0, p1.Pos)
end

local function AllocSize(p1) --[[ AllocSize | Line: 109 ]]
	return math.max(p1, 2 ^ math.ceil((math.log(p1, 2))))
end

local function Reserve(p1, p2) --[[ Reserve | Line: 115 ]]
	local Pos = p1.Pos
	local v1 = Pos + p2

	if p1.Cap < v1 then
		local v4 = math.max(v1, 2 ^ math.ceil((math.log(v1, 2))))
		local v5 = buffer.create(v4)

		buffer.copy(v5, 0, p1.Buf, 0, Pos)
		p1.Buf = v5
		p1.Cap = v4
	end

	p1.Pos = v1

	return Pos
end

local function WriteString(p1, p2) --[[ WriteString | Line: 131 | Upvalues: Reserve (copy) ]]
	local v1 = string.len(p2)

	buffer.writestring(p1.Buf, Reserve(p1, v1), p2, v1)
end

local function WriteIndent(p1) --[[ WriteIndent | Line: 137 | Upvalues: Reserve (copy) ]]
	local v1 = p1.Indent * 2
	local v2 = Reserve(p1, v1)
	local Buf = p1.Buf

	for i = 0, v1 - 1 do
		buffer.writeu16(Buf, v2 + i * 2, 8224)
	end
end

local function IncrementIndent(p1, p2) --[[ IncrementIndent | Line: 146 ]]
	p1.Indent = p1.Indent + p2
end

local function WriteU8(p1, p2) --[[ WriteU8 | Line: 150 | Upvalues: Reserve (copy) ]]
	local v1 = Reserve(p1, 1)

	buffer.writeu8(p1.Buf, v1, p2)
end

local function WriteU16(p1, p2) --[[ WriteU16 | Line: 155 | Upvalues: Reserve (copy) ]]
	local v1 = Reserve(p1, 2)

	buffer.writeu16(p1.Buf, v1, p2)
end

local function WriteU32(p1, p2) --[[ WriteU32 | Line: 160 | Upvalues: Reserve (copy) ]]
	local v1 = Reserve(p1, 4)

	buffer.writeu32(p1.Buf, v1, p2)
end

local function EncodeNull(p1, p2) --[[ EncodeNull | Line: 165 | Upvalues: Reserve (copy) ]]
	local v1 = Reserve(p1, 4)

	buffer.writeu32(p1.Buf, v1, 1819047278)
end

local function EncodeBoolean(p1, p2) --[[ EncodeBoolean | Line: 169 | Upvalues: Reserve (copy) ]]
	if p2 then
		local v1 = Reserve(p1, 4)

		buffer.writeu32(p1.Buf, v1, 1702195828)
	else
		local v2 = Reserve(p1, 5)
		local Buf = p1.Buf

		buffer.writeu32(Buf, v2, 1936482662)
		buffer.writeu8(Buf, v2 + 4, 101)
	end
end

local function EncodeNumber(p1, p2) --[[ EncodeNumber | Line: 180 | Upvalues: Reserve (copy) ]]
	if p2 ~= p2 then
		local v1 = Reserve(p1, 3)
		local Buf = p1.Buf

		buffer.writeu16(Buf, v1, 24910)
		buffer.writeu8(Buf, v1 + 2, 78)

		return
	end

	if p2 == (1 / 0) then
		local v2 = Reserve(p1, 8)
		local Buf = p1.Buf

		buffer.writeu32(Buf, v2, 1768320585)
		buffer.writeu32(Buf, v2 + 4, 2037672302)

		return
	end

	if p2 == (-1 / 0) then
		local v3 = Reserve(p1, 9)
		local Buf = p1.Buf

		buffer.writeu8(Buf, v3, 45)
		buffer.writeu32(Buf, v3 + 1, 1768320585)
		buffer.writeu32(Buf, v3 + 5, 2037672302)

		return
	end

	local v4 = tostring(p2)
	local v5 = string.find(v4, "e%+")

	if v5 then
		v4 = string.sub(v4, 1, v5) .. string.sub(v4, v5 + 2)
	end

	local v6 = string.len(v4)

	buffer.writestring(p1.Buf, Reserve(p1, v6), v4, v6)
end

local function IsIdentifierName(p1, p2) --[[ IsIdentifierName | Line: 207 | Upvalues: t (copy), t2 (copy) ]]
	local v1 = string.len(p2)

	if v1 == 0 then
		return false
	end

	if not t[string.byte(p2, 1)] then
		return false
	end

	local v2 = t2

	for i = 2, v1 do
		if not v2[string.byte(p2, i)] then
			return false
		end
	end

	return true
end

local function EncodeString(p1, p2, p3) --[[ EncodeString | Line: 228 | Upvalues: t (copy), t2 (copy), Reserve (copy), t3 (copy) ]]
	local v1, sum, v2, v3, v4, v5, v6

	if p3 then
		local v7 = string.len(p2)
		local v8

		if v7 == 0 or not t[string.byte(p2, 1)] then
			v8 = false
		else
			local v9 = t2

			for i = 2, v7 do
				if not v9[string.byte(p2, i)] then
					v8 = false

					if not v8 then
						p3 = false
					end

					v1 = string.len(p2)
					sum = Reserve(p1, v1 * 6 + 2)
					v2 = p1.Buf
					v3 = p1.QuoteChar

					if not p3 then
						buffer.writeu8(v2, sum, v3)
						sum = sum + 1
					end

					for j = 1, v1 do
						v4 = string.byte(p2, j)

						if v4 > 31 then
							if v4 == v3 or v4 == 92 then
								v5 = bit32.lshift(v4, 8) + 92
								buffer.writeu16(v2, sum, v5)
								sum = sum + 2

								continue
							end

							buffer.writeu8(v2, sum, v4)
							sum = sum + 1

							continue
						end

						v6 = t3[v4]

						if v6 < 0 then
							buffer.writeu32(v2, sum, 808482140)
							sum = sum + 4
							v6 = -v6
						end

						buffer.writeu16(v2, sum, v6)
						sum = sum + 2
					end

					if not p3 then
						buffer.writeu8(v2, sum, v3)
						sum = sum + 1
					end

					p1.Pos = sum

					return
				end
			end

			v8 = true
		end

		if not v8 then
			p3 = false
		end
	end

	v1 = string.len(p2)
	sum = Reserve(p1, v1 * 6 + 2)
	v2 = p1.Buf
	v3 = p1.QuoteChar

	if not p3 then
		buffer.writeu8(v2, sum, v3)
		sum = sum + 1
	end

	for j = 1, v1 do
		v4 = string.byte(p2, j)

		if v4 > 31 then
			if v4 == v3 or v4 == 92 then
				v5 = bit32.lshift(v4, 8) + 92
				buffer.writeu16(v2, sum, v5)
				sum = sum + 2

				continue
			end

			buffer.writeu8(v2, sum, v4)
			sum = sum + 1

			continue
		end

		v6 = t3[v4]

		if v6 < 0 then
			buffer.writeu32(v2, sum, 808482140)
			sum = sum + 4
			v6 = -v6
		end

		buffer.writeu16(v2, sum, v6)
		sum = sum + 2
	end

	if not p3 then
		buffer.writeu8(v2, sum, v3)
		sum = sum + 1
	end

	p1.Pos = sum
end

local function EncodeBuffer(p1, p2) --[[ EncodeBuffer | Line: 278 | Upvalues: Reserve (copy), t3 (copy) ]]
	local v1 = buffer.len(p2)
	local v2 = Reserve(p1, 2 + v1 * 6)
	local Buf = p1.Buf
	local QuoteChar = p1.QuoteChar

	buffer.writeu8(Buf, v2, QuoteChar)

	local sum = v2 + 1

	for i = 0, v1 - 1 do
		local v3 = buffer.readu8(p2, i)

		if v3 > 31 then
			if v3 == QuoteChar or v3 == 92 then
				buffer.writeu16(Buf, sum, bit32.lshift(v3, 8) + 92)
				sum = sum + 2

				continue
			end

			buffer.writeu8(Buf, sum, v3)
			sum = sum + 1

			continue
		end

		local v5 = t3[v3]

		if v5 < 0 then
			buffer.writeu32(Buf, sum, 808482140)
			sum = sum + 4
			v5 = -v5
		end

		buffer.writeu16(Buf, sum, v5)
		sum = sum + 2
	end

	buffer.writeu8(Buf, sum, QuoteChar)
	p1.Pos = sum + 1
end

local function EncodeAny(p1, p2) --[[ EncodeAny | Line: 316 ]]
	if p2 == p1.Null then
		p2 = nil
	end

	p1.Encoders[typeof(p2)](p1, p2)
end

local function EncodeArray(p1, p2) --[[ EncodeArray | Line: 323 | Upvalues: Reserve (copy) ]]
	local Pretty = p1.Pretty
	local v1 = Reserve(p1, 1)

	buffer.writeu8(p1.Buf, v1, 91)

	if Pretty then
		p1.Indent = p1.Indent + 1
	end

	for i, v in ipairs(p2) do
		if i > 1 then
			local v2 = Reserve(p1, 1)

			buffer.writeu8(p1.Buf, v2, 44)
		end

		if Pretty then
			local v3 = Reserve(p1, 1)

			buffer.writeu8(p1.Buf, v3, 10)

			local v4 = p1.Indent * 2
			local v5 = Reserve(p1, v4)
			local Buf3 = p1.Buf

			for i2 = 0, v4 - 1 do
				buffer.writeu16(Buf3, v5 + i2 * 2, 8224)
			end
		end

		local v6 = if v == p1.Null then nil else v

		p1.Encoders[typeof(v6)](p1, v6)
	end

	if Pretty then
		p1.Indent = p1.Indent + -1

		if #p2 > 0 then
			local v7 = Reserve(p1, 1)

			buffer.writeu8(p1.Buf, v7, 10)

			local v8 = p1.Indent * 2
			local v9 = Reserve(p1, v8)
			local Buf3 = p1.Buf

			for j = 0, v8 - 1 do
				buffer.writeu16(Buf3, v9 + j * 2, 8224)
			end
		end
	end

	local v10 = Reserve(p1, 1)

	buffer.writeu8(p1.Buf, v10, 93)
end

local function EncodeMap(p1, p2) --[[ EncodeMap | Line: 350 | Upvalues: Reserve (copy), EncodeString (copy) ]]
	local list = {}

	for k, v in pairs(p2) do
		assert(if type(k) == "string" then true else false)
		table.insert(list, k)
	end

	table.sort(list)

	local Pretty = p1.Pretty
	local UnquoteIdent = p1.UnquoteIdent
	local v2 = Reserve(p1, 1)

	buffer.writeu8(p1.Buf, v2, 123)

	if Pretty then
		p1.Indent = p1.Indent + 1
	end

	for i, v in ipairs(list) do
		if i > 1 then
			local v3 = Reserve(p1, 1)

			buffer.writeu8(p1.Buf, v3, 44)
		end

		if Pretty then
			local v4 = Reserve(p1, 1)

			buffer.writeu8(p1.Buf, v4, 10)

			local v5 = p1.Indent * 2
			local v6 = Reserve(p1, v5)
			local Buf3 = p1.Buf

			for i2 = 0, v5 - 1 do
				buffer.writeu16(Buf3, v6 + i2 * 2, 8224)
			end
		end

		EncodeString(p1, v, UnquoteIdent)

		if Pretty then
			local v7 = Reserve(p1, 2)

			buffer.writeu16(p1.Buf, v7, 8250)
		else
			local v8 = Reserve(p1, 1)

			buffer.writeu8(p1.Buf, v8, 58)
		end

		local v9 = p2[v]

		if v9 == p1.Null then
			v9 = nil
		end

		p1.Encoders[typeof(v9)](p1, v9)
	end

	if Pretty then
		p1.Indent = p1.Indent + -1

		if #list > 0 then
			local v10 = Reserve(p1, 1)

			buffer.writeu8(p1.Buf, v10, 10)

			local v11 = p1.Indent * 2
			local v12 = Reserve(p1, v11)
			local Buf3 = p1.Buf

			for j = 0, v11 - 1 do
				buffer.writeu16(Buf3, v12 + j * 2, 8224)
			end
		end
	end

	local v13 = Reserve(p1, 1)

	buffer.writeu8(p1.Buf, v13, 125)
end

local function EncodeTable(p1, p2) --[[ EncodeTable | Line: 389 | Upvalues: EncodeArray (copy), EncodeMap (copy) ]]
	if not (#p2 > 0) and next(p2) ~= nil then
		EncodeMap(p1, p2)

		return
	end

	EncodeArray(p1, p2)
end

local function EncodeVector2(p1, p2) --[[ EncodeVector2 | Line: 398 | Upvalues: EncodeArray (copy) ]]
	EncodeArray(p1, { p2.X, p2.Y })
end

local function EncodeVector3(p1, p2) --[[ EncodeVector3 | Line: 402 | Upvalues: EncodeArray (copy) ]]
	EncodeArray(p1, { p2.X, p2.Y, p2.Z })
end

local function EncodeVector2int16(p1, p2) --[[ EncodeVector2int16 | Line: 406 | Upvalues: EncodeArray (copy) ]]
	EncodeArray(p1, { p2.X, p2.Y })
end

local function EncodeVector3int16(p1, p2) --[[ EncodeVector3int16 | Line: 410 | Upvalues: EncodeArray (copy) ]]
	EncodeArray(p1, { p2.X, p2.Y, p2.Z })
end

local function EncodeRegion3(p1, p2) --[[ EncodeRegion3 | Line: 414 | Upvalues: EncodeArray (copy) ]]
	local v1 = p2.CFrame * (p2.Size * -0.5)
	local v2 = p2.CFrame * (p2.Size * 0.5)

	EncodeArray(p1, {
		v1.X,
		v1.Y,
		v1.Z,
		v2.X,
		v2.Y,
		v2.Z
	})
end

local function EncodeRegion3int16(p1, p2) --[[ EncodeRegion3int16 | Line: 420 | Upvalues: EncodeArray (copy) ]]
	EncodeArray(p1, {
		p2.Min.X,
		p2.Min.Y,
		p2.Min.Z,
		p2.Max.X,
		p2.Max.Y,
		p2.Max.Z
	})
end

local function EncodeUDim(p1, p2) --[[ EncodeUDim | Line: 424 | Upvalues: EncodeArray (copy) ]]
	EncodeArray(p1, { p2.Scale, p2.Offset })
end

local function EncodeUDim2(p1, p2) --[[ EncodeUDim2 | Line: 428 | Upvalues: EncodeArray (copy) ]]
	EncodeArray(p1, {
		p2.X.Scale,
		p2.X.Offset,
		p2.Y.Scale,
		p2.Y.Offset
	})
end

local function EncodeCFrame(p1, p2) --[[ EncodeCFrame | Line: 432 | Upvalues: EncodeArray (copy) ]]
	EncodeArray(p1, { p2:GetComponents() })
end

local function EncodeColor3(p1, p2) --[[ EncodeColor3 | Line: 436 | Upvalues: EncodeArray (copy) ]]
	local t = {}
	local v3 = math.round(p2.R * 255)
	local v5 = math.round(p2.G * 255)

	t[1] = v3
	t[2] = v5
	t[3] = math.round(p2.B * 255)
	EncodeArray(p1, t)
end

local function EncodeNumberRange(p1, p2) --[[ EncodeNumberRange | Line: 444 | Upvalues: EncodeArray (copy) ]]
	EncodeArray(p1, { p2.Min, p2.Max })
end

local function EncodeRect(p1, p2) --[[ EncodeRect | Line: 448 | Upvalues: EncodeArray (copy) ]]
	EncodeArray(p1, {
		p2.Min.X,
		p2.Min.Y,
		p2.Max.X,
		p2.Max.Y
	})
end

local function EncodeEnumItem(p1, p2) --[[ EncodeEnumItem | Line: 452 | Upvalues: EncodeNumber (copy) ]]
	EncodeNumber(p1, p2.Value)
end

local t4 = {
	["nil"] = EncodeNull,
	boolean = EncodeBoolean,
	number = EncodeNumber,
	string = EncodeString,
	buffer = EncodeBuffer,
	table = EncodeTable
}
local v1 = table.clone(t4)

v1.Vector2 = EncodeVector2
v1.Vector3 = EncodeVector3
v1.Vector2int16 = EncodeVector2int16
v1.Vector3int16 = EncodeVector3int16
v1.Region3 = EncodeRegion3
v1.Region3int16 = EncodeRegion3int16
v1.UDim = EncodeUDim
v1.UDim2 = EncodeUDim2
v1.CFrame = EncodeCFrame
v1.Color3 = EncodeColor3
v1.NumberRange = EncodeNumberRange
v1.Rect = EncodeRect
v1.EnumItem = EncodeEnumItem

local v2 = buffer.create(4096)
local v3 = Stream(v2)

v3.Encoders = t4

local function Compact(p1, p2) --[[ Compact | Line: 485 | Upvalues: v3 (copy), ToString (copy) ]]
	local v1 = v3

	v1.Pos = 0
	v1.Null = p2

	local v2 = if p1 == v1.Null then nil else p1

	v1.Encoders[typeof(v2)](v1, v2)

	return ToString(v1)
end

local v4 = Stream(v2)

v4.Encoders = t4
v4.Pretty = true

local function Pretty(p1, p2) --[[ Pretty | Line: 496 | Upvalues: v4 (copy), ToString (copy) ]]
	local v1 = v4

	v1.Pos = 0
	v1.Indent = 0
	v1.Null = p2

	local v2 = if p1 == v1.Null then nil else p1

	v1.Encoders[typeof(v2)](v1, v2)

	return ToString(v1)
end

local v5 = Stream(v2)

v5.Encoders = v1

local function CompactExt(p1, p2) --[[ CompactExt | Line: 507 | Upvalues: v5 (copy), ToString (copy) ]]
	local v1 = v5

	v1.Pos = 0
	v1.Null = p2

	local v2 = if p1 == v1.Null then nil else p1

	v1.Encoders[typeof(v2)](v1, v2)

	return ToString(v1)
end

local v6 = Stream(v2)

v6.Encoders = v1
v6.Pretty = true

local function PrettyExt(p1, p2) --[[ PrettyExt | Line: 518 | Upvalues: v6 (copy), ToString (copy) ]]
	local v1 = v6

	v1.Pos = 0
	v1.Indent = 0
	v1.Null = p2

	local v2 = if p1 == v1.Null then nil else p1

	v1.Encoders[typeof(v2)](v1, v2)

	return ToString(v1)
end

local v7 = Stream(v2)

v7.Encoders = t4
v7.UnquoteIdent = true
v7.QuoteChar = 39

local function Compact5(p1, p2) --[[ Compact5 | Line: 532 | Upvalues: v7 (copy), ToString (copy) ]]
	local v1 = v7

	v1.Pos = 0
	v1.Null = p2

	local v2 = if p1 == v1.Null then nil else p1

	v1.Encoders[typeof(v2)](v1, v2)

	return ToString(v1)
end

local v8 = Stream(v2)

v8.Encoders = t4
v8.Pretty = true
v8.UnquoteIdent = true
v8.QuoteChar = 39

return table.freeze({
	Compact = Compact,
	Pretty = Pretty,
	CompactExt = CompactExt,
	PrettyExt = PrettyExt,
	Compact5 = Compact5,
	Pretty5 = function(p1, p2) --[[ Pretty5 | Line: 545 | Upvalues: v8 (copy), ToString (copy) ]]
		local v1 = v8

		v1.Pos = 0
		v1.Indent = 0
		v1.Null = p2

		local v2 = if p1 == v1.Null then nil else p1

		v1.Encoders[typeof(v2)](v1, v2)

		return ToString(v1)
	end
})