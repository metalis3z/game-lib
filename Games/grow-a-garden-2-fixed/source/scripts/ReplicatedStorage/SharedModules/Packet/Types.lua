--credit to quartz games studio
local v1 = nil
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local t = {}
local t2 = {}
local t3 = {}
local t4 = {}
local t5 = {}

local function Allocate(p1) --[[ Allocate | Line: 47 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + p1

	if not (v3 < v12) then
		return
	end

	while v3 < v12 do
		v3 = v3 * 2
	end

	local v22 = buffer.create(v3)

	buffer.copy(v22, 0, v2, 0, v4)
	v1.Buffer = v22
	v2 = v22
end

local function ReadS8() --[[ ReadS8 | Line: 58 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readi8(v2, v4)

	v4 = v4 + 1

	return v3
end

local function WriteS8(p1) --[[ WriteS8 | Line: 59 | Upvalues: v2 (ref), v4 (ref) ]]
	buffer.writei8(v2, v4, p1)
	v4 = v4 + 1
end

local function ReadS16() --[[ ReadS16 | Line: 60 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readi16(v2, v4)

	v4 = v4 + 2

	return v3
end

local function WriteS16(p1) --[[ WriteS16 | Line: 61 | Upvalues: v2 (ref), v4 (ref) ]]
	buffer.writei16(v2, v4, p1)
	v4 = v4 + 2
end

local function ReadS24() --[[ ReadS24 | Line: 62 | Upvalues: v2 (ref), v4 (ref) ]]
	local v1 = buffer.readbits(v2, v4 * 8, 24) - 8388608

	v4 = v4 + 3

	return v1
end

local function WriteS24(p1) --[[ WriteS24 | Line: 63 | Upvalues: v2 (ref), v4 (ref) ]]
	buffer.writebits(v2, v4 * 8, 24, p1 + 8388608)
	v4 = v4 + 3
end

local function ReadS32() --[[ ReadS32 | Line: 64 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readi32(v2, v4)

	v4 = v4 + 4

	return v3
end

local function WriteS32(p1) --[[ WriteS32 | Line: 65 | Upvalues: v2 (ref), v4 (ref) ]]
	buffer.writei32(v2, v4, p1)
	v4 = v4 + 4
end

local function ReadU8() --[[ ReadU8 | Line: 66 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	return v3
end

local function WriteU8(p1) --[[ WriteU8 | Line: 67 | Upvalues: v2 (ref), v4 (ref) ]]
	buffer.writeu8(v2, v4, p1)
	v4 = v4 + 1
end

local function ReadU16() --[[ ReadU16 | Line: 68 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readu16(v2, v4)

	v4 = v4 + 2

	return v3
end

local function WriteU16(p1) --[[ WriteU16 | Line: 69 | Upvalues: v2 (ref), v4 (ref) ]]
	buffer.writeu16(v2, v4, p1)
	v4 = v4 + 2
end

local function ReadU24() --[[ ReadU24 | Line: 70 | Upvalues: v2 (ref), v4 (ref) ]]
	local v1 = buffer.readbits(v2, v4 * 8, 24)

	v4 = v4 + 3

	return v1
end

local function WriteU24(p1) --[[ WriteU24 | Line: 71 | Upvalues: v2 (ref), v4 (ref) ]]
	buffer.writebits(v2, v4 * 8, 24, p1)
	v4 = v4 + 3
end

local function ReadU32() --[[ ReadU32 | Line: 72 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readu32(v2, v4)

	v4 = v4 + 4

	return v3
end

local function WriteU32(p1) --[[ WriteU32 | Line: 73 | Upvalues: v2 (ref), v4 (ref) ]]
	buffer.writeu32(v2, v4, p1)
	v4 = v4 + 4
end

local function ReadF32() --[[ ReadF32 | Line: 74 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	return v3
end

local function WriteF32(p1) --[[ WriteF32 | Line: 75 | Upvalues: v2 (ref), v4 (ref) ]]
	buffer.writef32(v2, v4, p1)
	v4 = v4 + 4
end

local function ReadF64() --[[ ReadF64 | Line: 76 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readf64(v2, v4)

	v4 = v4 + 8

	return v3
end

local function WriteF64(p1) --[[ WriteF64 | Line: 77 | Upvalues: v2 (ref), v4 (ref) ]]
	buffer.writef64(v2, v4, p1)
	v4 = v4 + 8
end

local function ReadString(p1) --[[ ReadString | Line: 78 | Upvalues: v2 (ref), v4 (ref) ]]
	local v1 = buffer.readstring(v2, v4, p1)

	v4 = v4 + p1

	return v1
end

local function WriteString(p1) --[[ WriteString | Line: 79 | Upvalues: v2 (ref), v4 (ref) ]]
	buffer.writestring(v2, v4, p1)
	v4 = v4 + #p1
end

local function ReadBuffer(p1) --[[ ReadBuffer | Line: 80 | Upvalues: v2 (ref), v4 (ref) ]]
	local v1 = buffer.create(p1)

	buffer.copy(v1, 0, v2, v4, p1)
	v4 = v4 + p1

	return v1
end

local function WriteBuffer(p1) --[[ WriteBuffer | Line: 81 | Upvalues: v2 (ref), v4 (ref) ]]
	buffer.copy(v2, v4, p1)
	v4 = v4 + buffer.len(p1)
end

local function ReadInstance() --[[ ReadInstance | Line: 82 | Upvalues: v6 (ref), v5 (ref) ]]
	v6 = v6 + 1

	return v5[v6]
end

local function WriteInstance(p1) --[[ WriteInstance | Line: 83 | Upvalues: v6 (ref), v5 (ref) ]]
	v6 = v6 + 1
	v5[v6] = p1
end

local function ReadF16() --[[ ReadF16 | Line: 85 | Upvalues: v4 (ref), v2 (ref) ]]
	local v1 = v4 * 8

	v4 = v4 + 2

	local v22 = buffer.readbits(v2, v1 + 0, 10)
	local v3 = buffer.readbits(v2, v1 + 10, 5)
	local v42 = buffer.readbits(v2, v1 + 15, 1)

	if v22 == 0 then
		if v3 == 0 then
			return 0
		end

		if v3 == 31 then
			if v42 == 0 then
				return (1 / 0)
			end

			return (-1 / 0)
		end
	elseif v3 == 31 then
		return (0 / 0)
	end

	if v42 == 0 then
		return (v22 / 1024 + 1) * 2 ^ (v3 - 15)
	end

	return -(v22 / 1024 + 1) * 2 ^ (v3 - 15)
end

local function WriteF16(p1) --[[ WriteF16 | Line: 101 | Upvalues: v4 (ref), v2 (ref) ]]
	local v1 = v4 * 8

	v4 = v4 + 2

	if p1 == 0 then
		buffer.writebits(v2, v1, 16, 0)

		return
	end

	if p1 >= 65520 then
		buffer.writebits(v2, v1, 16, 31744)

		return
	end

	if p1 <= -65520 then
		buffer.writebits(v2, v1, 16, 64512)

		return
	end

	if p1 ~= p1 then
		buffer.writebits(v2, v1, 16, 31745)

		return
	end

	local v22

	if p1 < 0 then
		p1 = -p1
		v22 = 1
	else
		v22 = 0
	end

	local v3, v42 = math.frexp(p1)

	buffer.writebits(v2, v1 + 0, 10, v3 * 2048 - 1023.5)
	buffer.writebits(v2, v1 + 10, 5, v42 + 14)
	buffer.writebits(v2, v1 + 15, 1, v22)
end

local function ReadF24() --[[ ReadF24 | Line: 122 | Upvalues: v4 (ref), v2 (ref) ]]
	local v1 = v4 * 8

	v4 = v4 + 3

	local v22 = buffer.readbits(v2, v1 + 0, 17)
	local v3 = buffer.readbits(v2, v1 + 17, 6)
	local v42 = buffer.readbits(v2, v1 + 23, 1)

	if v22 == 0 then
		if v3 == 0 then
			return 0
		end

		if v3 == 63 then
			if v42 == 0 then
				return (1 / 0)
			end

			return (-1 / 0)
		end
	elseif v3 == 63 then
		return (0 / 0)
	end

	if v42 == 0 then
		return (v22 / 131072 + 1) * 2 ^ (v3 - 31)
	end

	return -(v22 / 131072 + 1) * 2 ^ (v3 - 31)
end

local function WriteF24(p1) --[[ WriteF24 | Line: 138 | Upvalues: v4 (ref), v2 (ref) ]]
	local v1 = v4 * 8

	v4 = v4 + 3

	if p1 == 0 then
		buffer.writebits(v2, v1, 24, 0)

		return
	end

	if p1 >= 4294959104 then
		buffer.writebits(v2, v1, 24, 8257536)

		return
	end

	if p1 <= -4294959104 then
		buffer.writebits(v2, v1, 24, 16646144)

		return
	end

	if p1 ~= p1 then
		buffer.writebits(v2, v1, 24, 8257537)

		return
	end

	local v22

	if p1 < 0 then
		p1 = -p1
		v22 = 1
	else
		v22 = 0
	end

	local v3, v42 = math.frexp(p1)

	buffer.writebits(v2, v1 + 0, 17, v3 * 262144 - 131071.5)
	buffer.writebits(v2, v1 + 17, 6, v42 + 30)
	buffer.writebits(v2, v1 + 23, 1, v22)
end

t.Any = "Any"
function t2.Any() --[[ Line: 162 | Upvalues: t4 (copy), v2 (ref), v4 (ref) ]]
	local v42 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	return t4[v42]()
end
function t3.Any(p1) --[[ Line: 163 | Upvalues: t5 (copy) ]]
	t5[typeof(p1)](p1)
end
t.Nil = "Nil"
function t2.Nil() --[[ Line: 166 ]]
	return nil
end
function t3.Nil(p1) --[[ Line: 167 ]] end
t.NumberS8 = "NumberS8"
function t2.NumberS8() --[[ Line: 170 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readi8(v2, v4)

	v4 = v4 + 1

	return v3
end
function t3.NumberS8(p1) --[[ Line: 171 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 1

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writei8(v2, v4, p1)
	v4 = v4 + 1
end
t.NumberS16 = "NumberS16"
function t2.NumberS16() --[[ Line: 174 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readi16(v2, v4)

	v4 = v4 + 2

	return v3
end
function t3.NumberS16(p1) --[[ Line: 175 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 2

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writei16(v2, v4, p1)
	v4 = v4 + 2
end
t.NumberS24 = "NumberS24"
function t2.NumberS24() --[[ Line: 178 | Upvalues: v2 (ref), v4 (ref) ]]
	local v1 = buffer.readbits(v2, v4 * 8, 24) - 8388608

	v4 = v4 + 3

	return v1
end
function t3.NumberS24(p1) --[[ Line: 179 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 3

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writebits(v2, v4 * 8, 24, p1 + 8388608)
	v4 = v4 + 3
end
t.NumberS32 = "NumberS32"
function t2.NumberS32() --[[ Line: 182 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readi32(v2, v4)

	v4 = v4 + 4

	return v3
end
function t3.NumberS32(p1) --[[ Line: 183 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 4

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writei32(v2, v4, p1)
	v4 = v4 + 4
end
t.NumberU8 = "NumberU8"
function t2.NumberU8() --[[ Line: 186 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	return v3
end
function t3.NumberU8(p1) --[[ Line: 187 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 1

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writeu8(v2, v4, p1)
	v4 = v4 + 1
end
t.NumberU16 = "NumberU16"
function t2.NumberU16() --[[ Line: 190 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readu16(v2, v4)

	v4 = v4 + 2

	return v3
end
function t3.NumberU16(p1) --[[ Line: 191 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 2

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writeu16(v2, v4, p1)
	v4 = v4 + 2
end
t.NumberU24 = "NumberU24"
function t2.NumberU24() --[[ Line: 194 | Upvalues: v2 (ref), v4 (ref) ]]
	local v1 = buffer.readbits(v2, v4 * 8, 24)

	v4 = v4 + 3

	return v1
end
function t3.NumberU24(p1) --[[ Line: 195 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 3

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writebits(v2, v4 * 8, 24, p1)
	v4 = v4 + 3
end
t.NumberU32 = "NumberU32"
function t2.NumberU32() --[[ Line: 198 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readu32(v2, v4)

	v4 = v4 + 4

	return v3
end
function t3.NumberU32(p1) --[[ Line: 199 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 4

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writeu32(v2, v4, p1)
	v4 = v4 + 4
end
t.NumberF16 = "NumberF16"
function t2.NumberF16() --[[ Line: 202 | Upvalues: ReadF16 (copy) ]]
	return ReadF16()
end
function t3.NumberF16(p1) --[[ Line: 203 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref), WriteF16 (copy) ]]
	local v12 = v4 + 2

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	WriteF16(p1)
end
t.NumberF24 = "NumberF24"
function t2.NumberF24() --[[ Line: 206 | Upvalues: ReadF24 (copy) ]]
	return ReadF24()
end
function t3.NumberF24(p1) --[[ Line: 207 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref), WriteF24 (copy) ]]
	local v12 = v4 + 3

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	WriteF24(p1)
end
t.NumberF32 = "NumberF32"
function t2.NumberF32() --[[ Line: 210 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	return v3
end
function t3.NumberF32(p1) --[[ Line: 211 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 4

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writef32(v2, v4, p1)
	v4 = v4 + 4
end
t.NumberF64 = "NumberF64"
function t2.NumberF64() --[[ Line: 214 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readf64(v2, v4)

	v4 = v4 + 8

	return v3
end
function t3.NumberF64(p1) --[[ Line: 215 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 8

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writef64(v2, v4, p1)
	v4 = v4 + 8
end
t.String = "String"
function t2.String() --[[ Line: 218 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	local v42 = buffer.readstring(v2, v4, v3)

	v4 = v4 + v3

	return v42
end
function t3.String(p1) --[[ Line: 219 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = #p1
	local v22 = v4 + (v12 + 1)

	if v3 < v22 then
		while v3 < v22 do
			v3 = v3 * 2
		end

		local v32 = buffer.create(v3)

		buffer.copy(v32, 0, v2, 0, v4)
		v1.Buffer = v32
		v2 = v32
	end

	buffer.writeu8(v2, v4, v12)
	v4 = v4 + 1
	buffer.writestring(v2, v4, p1)
	v4 = v4 + #p1
end
t.StringLong = "StringLong"
function t2.StringLong() --[[ Line: 222 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readu16(v2, v4)

	v4 = v4 + 2

	local v42 = buffer.readstring(v2, v4, v3)

	v4 = v4 + v3

	return v42
end
function t3.StringLong(p1) --[[ Line: 223 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = #p1
	local v22 = v4 + (v12 + 2)

	if v3 < v22 then
		while v3 < v22 do
			v3 = v3 * 2
		end

		local v32 = buffer.create(v3)

		buffer.copy(v32, 0, v2, 0, v4)
		v1.Buffer = v32
		v2 = v32
	end

	buffer.writeu16(v2, v4, v12)
	v4 = v4 + 2
	buffer.writestring(v2, v4, p1)
	v4 = v4 + #p1
end
t.Buffer = "Buffer"
function t2.Buffer() --[[ Line: 226 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	local v42 = buffer.create(v3)

	buffer.copy(v42, 0, v2, v4, v3)
	v4 = v4 + v3

	return v42
end
function t3.Buffer(p1) --[[ Line: 227 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = buffer.len(p1)
	local v22 = v4 + (1 + v12)

	if v3 < v22 then
		while v3 < v22 do
			v3 = v3 * 2
		end

		local v32 = buffer.create(v3)

		buffer.copy(v32, 0, v2, 0, v4)
		v1.Buffer = v32
		v2 = v32
	end

	buffer.writeu8(v2, v4, v12)
	v4 = v4 + 1
	buffer.copy(v2, v4, p1)
	v4 = v4 + buffer.len(p1)
end
t.BufferLong = "BufferLong"
function t2.BufferLong() --[[ Line: 230 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readu16(v2, v4)

	v4 = v4 + 2

	local v42 = buffer.create(v3)

	buffer.copy(v42, 0, v2, v4, v3)
	v4 = v4 + v3

	return v42
end
function t3.BufferLong(p1) --[[ Line: 231 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = buffer.len(p1)
	local v22 = v4 + (2 + v12)

	if v3 < v22 then
		while v3 < v22 do
			v3 = v3 * 2
		end

		local v32 = buffer.create(v3)

		buffer.copy(v32, 0, v2, 0, v4)
		v1.Buffer = v32
		v2 = v32
	end

	buffer.writeu16(v2, v4, v12)
	v4 = v4 + 2
	buffer.copy(v2, v4, p1)
	v4 = v4 + buffer.len(p1)
end
t.Instance = "Instance"
function t2.Instance() --[[ Line: 235 | Upvalues: v6 (ref), v5 (ref) ]]
	v6 = v6 + 1

	return v5[v6]
end
function t3.Instance(p1) --[[ Line: 236 | Upvalues: v6 (ref), v5 (ref) ]]
	v6 = v6 + 1
	v5[v6] = p1
end
t.Boolean8 = "Boolean8"
function t2.Boolean8() --[[ Line: 239 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	return v3 == 1
end
function t3.Boolean8(p1) --[[ Line: 240 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 1

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writeu8(v2, v4, if p1 then 1 else 0)
	v4 = v4 + 1
end
t.NumberRange = "NumberRange"
function t2.NumberRange() --[[ Line: 243 | Upvalues: v2 (ref), v4 (ref) ]]
	local v1 = NumberRange.new
	local v42 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	local v7 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	return v1(v42, v7)
end
function t3.NumberRange(p1) --[[ Line: 244 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 8

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writef32(v2, v4, p1.Min)
	v4 = v4 + 4
	buffer.writef32(v2, v4, p1.Max)
	v4 = v4 + 4
end
t.BrickColor = "BrickColor"
function t2.BrickColor() --[[ Line: 247 | Upvalues: v2 (ref), v4 (ref) ]]
	local v1 = BrickColor.new
	local v42 = buffer.readu16(v2, v4)

	v4 = v4 + 2

	return v1(v42)
end
function t3.BrickColor(p1) --[[ Line: 248 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 2

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writeu16(v2, v4, p1.Number)
	v4 = v4 + 2
end
t.Color3 = "Color3"
function t2.Color3() --[[ Line: 251 | Upvalues: v2 (ref), v4 (ref) ]]
	local fromRGB = Color3.fromRGB
	local v3 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	local v6 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	local v9 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	return fromRGB(v3, v6, v9)
end
function t3.Color3(p1) --[[ Line: 252 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 3

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writeu8(v2, v4, p1.R * 255 + 0.5)
	v4 = v4 + 1
	buffer.writeu8(v2, v4, p1.G * 255 + 0.5)
	v4 = v4 + 1
	buffer.writeu8(v2, v4, p1.B * 255 + 0.5)
	v4 = v4 + 1
end
t.UDim = "UDim"
function t2.UDim() --[[ Line: 255 | Upvalues: v2 (ref), v4 (ref) ]]
	local v1 = UDim.new
	local v42 = buffer.readi16(v2, v4)

	v4 = v4 + 2

	local v8 = buffer.readi16(v2, v4)

	v4 = v4 + 2

	return v1(v42 / 1000, v8)
end
function t3.UDim(p1) --[[ Line: 256 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 4

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writei16(v2, v4, p1.Scale * 1000)
	v4 = v4 + 2
	buffer.writei16(v2, v4, p1.Offset)
	v4 = v4 + 2
end
t.UDim2 = "UDim2"
function t2.UDim2() --[[ Line: 259 | Upvalues: v2 (ref), v4 (ref) ]]
	local v1 = UDim2.new
	local v42 = buffer.readi16(v2, v4)

	v4 = v4 + 2

	local v7 = buffer.readi16(v2, v4)

	v4 = v4 + 2

	local v10 = buffer.readi16(v2, v4)

	v4 = v4 + 2

	local v14 = buffer.readi16(v2, v4)

	v4 = v4 + 2

	return v1(v42 / 1000, v7, v10 / 1000, v14)
end
function t3.UDim2(p1) --[[ Line: 260 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 8

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writei16(v2, v4, p1.X.Scale * 1000)
	v4 = v4 + 2
	buffer.writei16(v2, v4, p1.X.Offset)
	v4 = v4 + 2
	buffer.writei16(v2, v4, p1.Y.Scale * 1000)
	v4 = v4 + 2
	buffer.writei16(v2, v4, p1.Y.Offset)
	v4 = v4 + 2
end
t.Rect = "Rect"
function t2.Rect() --[[ Line: 263 | Upvalues: v2 (ref), v4 (ref) ]]
	local v1 = Rect.new
	local v42 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	local v7 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	local v10 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	local v13 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	return v1(v42, v7, v10, v13)
end
function t3.Rect(p1) --[[ Line: 264 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 16

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writef32(v2, v4, p1.Min.X)
	v4 = v4 + 4
	buffer.writef32(v2, v4, p1.Min.Y)
	v4 = v4 + 4
	buffer.writef32(v2, v4, p1.Max.X)
	v4 = v4 + 4
	buffer.writef32(v2, v4, p1.Max.Y)
	v4 = v4 + 4
end
t.Vector2S16 = "Vector2S16"
function t2.Vector2S16() --[[ Line: 267 | Upvalues: v2 (ref), v4 (ref) ]]
	local v1 = Vector2.new
	local v42 = buffer.readi16(v2, v4)

	v4 = v4 + 2

	local v7 = buffer.readi16(v2, v4)

	v4 = v4 + 2

	return v1(v42, v7)
end
function t3.Vector2S16(p1) --[[ Line: 268 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 4

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writei16(v2, v4, p1.X)
	v4 = v4 + 2
	buffer.writei16(v2, v4, p1.Y)
	v4 = v4 + 2
end
t.Vector2F24 = "Vector2F24"
function t2.Vector2F24() --[[ Line: 271 | Upvalues: ReadF24 (copy) ]]
	return Vector2.new(ReadF24(), (ReadF24()))
end
function t3.Vector2F24(p1) --[[ Line: 272 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref), WriteF24 (copy) ]]
	local v12 = v4 + 6

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	WriteF24(p1.X)
	WriteF24(p1.Y)
end
t.Vector2F32 = "Vector2F32"
function t2.Vector2F32() --[[ Line: 275 | Upvalues: v2 (ref), v4 (ref) ]]
	local v1 = Vector2.new
	local v42 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	local v7 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	return v1(v42, v7)
end
function t3.Vector2F32(p1) --[[ Line: 276 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 8

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writef32(v2, v4, p1.X)
	v4 = v4 + 4
	buffer.writef32(v2, v4, p1.Y)
	v4 = v4 + 4
end
t.Vector3S16 = "Vector3S16"
function t2.Vector3S16() --[[ Line: 279 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readi16(v2, v4)

	v4 = v4 + 2

	local v6 = buffer.readi16(v2, v4)

	v4 = v4 + 2

	local v9 = buffer.readi16(v2, v4)

	v4 = v4 + 2

	return Vector3.new(v3, v6, v9)
end
function t3.Vector3S16(p1) --[[ Line: 280 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 6

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writei16(v2, v4, p1.X)
	v4 = v4 + 2
	buffer.writei16(v2, v4, p1.Y)
	v4 = v4 + 2
	buffer.writei16(v2, v4, p1.Z)
	v4 = v4 + 2
end
t.Vector3F24 = "Vector3F24"
function t2.Vector3F24() --[[ Line: 283 | Upvalues: ReadF24 (copy) ]]
	local v1 = ReadF24()
	local v2 = ReadF24()

	return Vector3.new(v1, v2, (ReadF24()))
end
function t3.Vector3F24(p1) --[[ Line: 284 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref), WriteF24 (copy) ]]
	local v12 = v4 + 9

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	WriteF24(p1.X)
	WriteF24(p1.Y)
	WriteF24(p1.Z)
end
t.InstanceVector3F24Array = "InstanceVector3F24Array"
function t2.InstanceVector3F24Array() --[[ Line: 287 | Upvalues: v2 (ref), v4 (ref), v6 (ref), v5 (ref), ReadF24 (copy) ]]
	local v3 = buffer.readu16(v2, v4)

	v4 = v4 + 2

	local v42 = table.create(v3)

	for i = 1, v3 do
		local t = {}

		v6 = v6 + 1

		local v62 = ReadF24()
		local v7 = ReadF24()
		local v8 = ReadF24()

		t[1] = v5[v6]
		t[2] = Vector3.new(v62, v7, v8)
		v42[i] = t
	end

	return v42
end
function t3.InstanceVector3F24Array(p1) --[[ Line: 295 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref), v6 (ref), v5 (ref), WriteF24 (copy) ]]
	local v12 = #p1

	if v12 > 65535 then
		v12 = 65535
	end

	local v22 = v4 + 2

	if v3 < v22 then
		while v3 < v22 do
			v3 = v3 * 2
		end

		local v32 = buffer.create(v3)

		buffer.copy(v32, 0, v2, 0, v4)
		v1.Buffer = v32
		v2 = v32
	end

	buffer.writeu16(v2, v4, v12)
	v4 = v4 + 2

	for i = 1, v12 do
		local v62 = p1[i]

		v6 = v6 + 1
		v5[v6] = v62[1]

		local v8 = v62[2]
		local v9 = v4 + 9

		if v3 < v9 then
			while v3 < v9 do
				v3 = v3 * 2
			end

			local v10 = buffer.create(v3)

			buffer.copy(v10, 0, v2, 0, v4)
			v1.Buffer = v10
			v2 = v10
		end

		WriteF24(v8.X)
		WriteF24(v8.Y)
		WriteF24(v8.Z)
	end
end
t.Vector3F32 = "Vector3F32"
function t2.Vector3F32() --[[ Line: 312 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	local v6 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	local v9 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	return Vector3.new(v3, v6, v9)
end
function t3.Vector3F32(p1) --[[ Line: 313 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 12

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writef32(v2, v4, p1.X)
	v4 = v4 + 4
	buffer.writef32(v2, v4, p1.Y)
	v4 = v4 + 4
	buffer.writef32(v2, v4, p1.Z)
	v4 = v4 + 4
end
t.NumberU4 = "NumberU4"
function t2.NumberU4() --[[ Line: 316 | Upvalues: v4 (ref), v2 (ref) ]]
	local v1 = v4 * 8

	v4 = v4 + 1

	return { buffer.readbits(v2, v1 + 0, 4), buffer.readbits(v2, v1 + 4, 4) }
end
function t3.NumberU4(p1) --[[ Line: 324 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 1

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	local v32 = v4 * 8

	v4 = v4 + 1
	buffer.writebits(v2, v32 + 0, 4, p1[1])
	buffer.writebits(v2, v32 + 4, 4, p1[2])
end
t.BooleanNumber = "BooleanNumber"
function t2.BooleanNumber() --[[ Line: 333 | Upvalues: v4 (ref), v2 (ref) ]]
	local v1 = v4 * 8

	v4 = v4 + 1

	local t = {}

	t.Boolean = buffer.readbits(v2, v1 + 0, 1) == 1
	t.Number = buffer.readbits(v2, v1 + 1, 7)

	return t
end
function t3.BooleanNumber(p1) --[[ Line: 341 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 1

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	local v32 = v4 * 8

	v4 = v4 + 1
	buffer.writebits(v2, v32 + 0, 1, if p1.Boolean then 1 else 0)
	buffer.writebits(v2, v32 + 1, 7, p1.Number)
end
t.Boolean1 = "Boolean1"
function t2.Boolean1() --[[ Line: 350 | Upvalues: v4 (ref), v2 (ref) ]]
	local v1 = v4 * 8

	v4 = v4 + 1

	local t = {}
	local v22 = buffer.readbits(v2, v1 + 0, 1) == 1
	local v3 = if buffer.readbits(v2, v1 + 1, 1) == 1 then true else false
	local v42 = if buffer.readbits(v2, v1 + 2, 1) == 1 then true else false
	local v5 = if buffer.readbits(v2, v1 + 3, 1) == 1 then true else false
	local v6 = if buffer.readbits(v2, v1 + 4, 1) == 1 then true else false
	local v7 = if buffer.readbits(v2, v1 + 5, 1) == 1 then true else false
	local v8 = if buffer.readbits(v2, v1 + 6, 1) == 1 then true else false
	local v9 = if buffer.readbits(v2, v1 + 7, 1) == 1 then true else false

	t[1] = v22
	t[2] = v3
	t[3] = v42
	t[4] = v5
	t[5] = v6
	t[6] = v7
	t[7] = v8
	t[8] = v9

	return t
end
function t3.Boolean1(p1) --[[ Line: 364 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 1

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	local v32 = v4 * 8

	v4 = v4 + 1
	buffer.writebits(v2, v32 + 0, 1, if p1[1] then 1 else 0)
	buffer.writebits(v2, v32 + 1, 1, if p1[2] then 1 else 0)
	buffer.writebits(v2, v32 + 2, 1, if p1[3] then 1 else 0)
	buffer.writebits(v2, v32 + 3, 1, if p1[4] then 1 else 0)
	buffer.writebits(v2, v32 + 4, 1, if p1[5] then 1 else 0)
	buffer.writebits(v2, v32 + 5, 1, if p1[6] then 1 else 0)
	buffer.writebits(v2, v32 + 6, 1, if p1[7] then 1 else 0)
	buffer.writebits(v2, v32 + 7, 1, if p1[8] then 1 else 0)
end
t.CFrameF24U8 = "CFrameF24U8"
function t2.CFrameF24U8() --[[ Line: 379 | Upvalues: v2 (ref), v4 (ref), ReadF24 (copy) ]]
	local fromEulerAnglesXYZ = CFrame.fromEulerAnglesXYZ
	local v3 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	local v6 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	local v9 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	local v10 = fromEulerAnglesXYZ(v3 / 40.58451048843331, v6 / 40.58451048843331, v9 / 40.58451048843331)

	return v10 + Vector3.new(ReadF24(), ReadF24(), (ReadF24()))
end
function t3.CFrameF24U8(p1) --[[ Line: 383 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref), WriteF24 (copy) ]]
	local v12, v22, v32 = p1:ToEulerAnglesXYZ()
	local v42 = v4 + 12

	if v3 < v42 then
		while v3 < v42 do
			v3 = v3 * 2
		end

		local v5 = buffer.create(v3)

		buffer.copy(v5, 0, v2, 0, v4)
		v1.Buffer = v5
		v2 = v5
	end

	buffer.writeu8(v2, v4, v12 * 40.58451048843331 + 0.5)
	v4 = v4 + 1
	buffer.writeu8(v2, v4, v22 * 40.58451048843331 + 0.5)
	v4 = v4 + 1
	buffer.writeu8(v2, v4, v32 * 40.58451048843331 + 0.5)
	v4 = v4 + 1
	WriteF24(p1.X)
	WriteF24(p1.Y)
	WriteF24(p1.Z)
end
t.CFrameF32U8 = "CFrameF32U8"
function t2.CFrameF32U8() --[[ Line: 391 | Upvalues: v2 (ref), v4 (ref) ]]
	local fromEulerAnglesXYZ = CFrame.fromEulerAnglesXYZ
	local v3 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	local v6 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	local v9 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	local v10 = fromEulerAnglesXYZ(v3 / 40.58451048843331, v6 / 40.58451048843331, v9 / 40.58451048843331)
	local v13 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	local v16 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	local v19 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	return v10 + Vector3.new(v13, v16, v19)
end
function t3.CFrameF32U8(p1) --[[ Line: 395 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12, v22, v32 = p1:ToEulerAnglesXYZ()
	local v42 = v4 + 15

	if v3 < v42 then
		while v3 < v42 do
			v3 = v3 * 2
		end

		local v5 = buffer.create(v3)

		buffer.copy(v5, 0, v2, 0, v4)
		v1.Buffer = v5
		v2 = v5
	end

	buffer.writeu8(v2, v4, v12 * 40.58451048843331 + 0.5)
	v4 = v4 + 1
	buffer.writeu8(v2, v4, v22 * 40.58451048843331 + 0.5)
	v4 = v4 + 1
	buffer.writeu8(v2, v4, v32 * 40.58451048843331 + 0.5)
	v4 = v4 + 1
	buffer.writef32(v2, v4, p1.X)
	v4 = v4 + 4
	buffer.writef32(v2, v4, p1.Y)
	v4 = v4 + 4
	buffer.writef32(v2, v4, p1.Z)
	v4 = v4 + 4
end
t.CFrameF32U16 = "CFrameF32U16"
function t2.CFrameF32U16() --[[ Line: 403 | Upvalues: v2 (ref), v4 (ref) ]]
	local fromEulerAnglesXYZ = CFrame.fromEulerAnglesXYZ
	local v3 = buffer.readu16(v2, v4)

	v4 = v4 + 2

	local v6 = buffer.readu16(v2, v4)

	v4 = v4 + 2

	local v9 = buffer.readu16(v2, v4)

	v4 = v4 + 2

	local v10 = fromEulerAnglesXYZ(v3 / 10430.219195527361, v6 / 10430.219195527361, v9 / 10430.219195527361)
	local v13 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	local v16 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	local v19 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	return v10 + Vector3.new(v13, v16, v19)
end
function t3.CFrameF32U16(p1) --[[ Line: 407 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12, v22, v32 = p1:ToEulerAnglesXYZ()
	local v42 = v4 + 18

	if v3 < v42 then
		while v3 < v42 do
			v3 = v3 * 2
		end

		local v5 = buffer.create(v3)

		buffer.copy(v5, 0, v2, 0, v4)
		v1.Buffer = v5
		v2 = v5
	end

	buffer.writeu16(v2, v4, v12 * 10430.219195527361 + 0.5)
	v4 = v4 + 2
	buffer.writeu16(v2, v4, v22 * 10430.219195527361 + 0.5)
	v4 = v4 + 2
	buffer.writeu16(v2, v4, v32 * 10430.219195527361 + 0.5)
	v4 = v4 + 2
	buffer.writef32(v2, v4, p1.X)
	v4 = v4 + 4
	buffer.writef32(v2, v4, p1.Y)
	v4 = v4 + 4
	buffer.writef32(v2, v4, p1.Z)
	v4 = v4 + 4
end
t.Region3 = "Region3"
function t2.Region3() --[[ Line: 415 | Upvalues: v2 (ref), v4 (ref) ]]
	local v1 = Region3.new
	local v42 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	local v7 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	local v10 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	local v11 = Vector3.new(v42, v7, v10)
	local v14 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	local v17 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	local v20 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	return v1(v11, (Vector3.new(v14, v17, v20)))
end
function t3.Region3(p1) --[[ Line: 421 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = p1.Size / 2
	local v22 = p1.CFrame.Position - v12
	local v32 = p1.CFrame.Position + v12
	local v42 = v4 + 24

	if v3 < v42 then
		while v3 < v42 do
			v3 = v3 * 2
		end

		local v5 = buffer.create(v3)

		buffer.copy(v5, 0, v2, 0, v4)
		v1.Buffer = v5
		v2 = v5
	end

	buffer.writef32(v2, v4, v22.X)
	v4 = v4 + 4
	buffer.writef32(v2, v4, v22.Y)
	v4 = v4 + 4
	buffer.writef32(v2, v4, v22.Z)
	v4 = v4 + 4
	buffer.writef32(v2, v4, v32.X)
	v4 = v4 + 4
	buffer.writef32(v2, v4, v32.Y)
	v4 = v4 + 4
	buffer.writef32(v2, v4, v32.Z)
	v4 = v4 + 4
end
t.NumberSequence = "NumberSequence"
function t2.NumberSequence() --[[ Line: 431 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	local v42 = table.create(v3)

	for i = 1, v3 do
		local v5 = NumberSequenceKeypoint.new
		local v8 = buffer.readu8(v2, v4)

		v4 = v4 + 1

		local v11 = buffer.readu8(v2, v4)

		v4 = v4 + 1

		local v14 = buffer.readu8(v2, v4)

		v4 = v4 + 1
		table.insert(v42, v5(v8 / 255, v11 / 255, v14 / 255))
	end

	return NumberSequence.new(v42)
end
function t3.NumberSequence(p1) --[[ Line: 439 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = #p1.Keypoints
	local v22 = v4 + (v12 * 3 + 1)

	if v3 < v22 then
		while v3 < v22 do
			v3 = v3 * 2
		end

		local v32 = buffer.create(v3)

		buffer.copy(v32, 0, v2, 0, v4)
		v1.Buffer = v32
		v2 = v32
	end

	buffer.writeu8(v2, v4, v12)
	v4 = v4 + 1

	for v6, v7 in p1.Keypoints do
		buffer.writeu8(v2, v4, v7.Time * 255 + 0.5)
		v4 = v4 + 1
		buffer.writeu8(v2, v4, v7.Value * 255 + 0.5)
		v4 = v4 + 1
		buffer.writeu8(v2, v4, v7.Envelope * 255 + 0.5)
		v4 = v4 + 1
	end
end
t.ColorSequence = "ColorSequence"
function t2.ColorSequence() --[[ Line: 449 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	local v42 = table.create(v3)

	for i = 1, v3 do
		local v5 = ColorSequenceKeypoint.new
		local v8 = buffer.readu8(v2, v4)

		v4 = v4 + 1

		local fromRGB = Color3.fromRGB
		local v11 = buffer.readu8(v2, v4)

		v4 = v4 + 1

		local v14 = buffer.readu8(v2, v4)

		v4 = v4 + 1

		local v17 = buffer.readu8(v2, v4)

		v4 = v4 + 1
		table.insert(v42, v5(v8 / 255, fromRGB(v11, v14, v17)))
	end

	return ColorSequence.new(v42)
end
function t3.ColorSequence(p1) --[[ Line: 457 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = #p1.Keypoints
	local v22 = v4 + (v12 * 4 + 1)

	if v3 < v22 then
		while v3 < v22 do
			v3 = v3 * 2
		end

		local v32 = buffer.create(v3)

		buffer.copy(v32, 0, v2, 0, v4)
		v1.Buffer = v32
		v2 = v32
	end

	buffer.writeu8(v2, v4, v12)
	v4 = v4 + 1

	for v6, v7 in p1.Keypoints do
		buffer.writeu8(v2, v4, v7.Time * 255 + 0.5)
		v4 = v4 + 1
		buffer.writeu8(v2, v4, v7.Value.R * 255 + 0.5)
		v4 = v4 + 1
		buffer.writeu8(v2, v4, v7.Value.G * 255 + 0.5)
		v4 = v4 + 1
		buffer.writeu8(v2, v4, v7.Value.B * 255 + 0.5)
		v4 = v4 + 1
	end
end

local Characters = require(script.Characters)
local t6 = {}

for v7, v8 in Characters do
	t6[v8] = v7
end

local v10 = math.ceil((math.log(#Characters + 1, 2)))
local v11 = v10 / 8

t.Characters = "Characters"
function t2.Characters() --[[ Line: 473 | Upvalues: v2 (ref), v4 (ref), v11 (copy), Characters (copy), v10 (copy) ]]
	local v3 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	local v42 = table.create(v3)
	local sum = v4 * 8

	v4 = v4 + math.ceil(v3 * v11)

	for i = 1, v3 do
		table.insert(v42, Characters[buffer.readbits(v2, sum, v10)])
		sum = sum + v10
	end

	return table.concat(v42)
end
function t3.Characters(p1) --[[ Line: 484 | Upvalues: v11 (copy), v4 (ref), v3 (ref), v2 (ref), v1 (ref), v10 (copy), t6 (copy) ]]
	local v12 = #p1
	local v32 = math.ceil(v12 * v11)
	local v42 = v4 + (v32 + 1)

	if v3 < v42 then
		while v3 < v42 do
			v3 = v3 * 2
		end

		local v5 = buffer.create(v3)

		buffer.copy(v5, 0, v2, 0, v4)
		v1.Buffer = v5
		v2 = v5
	end

	buffer.writeu8(v2, v4, v12)
	v4 = v4 + 1

	local sum = v4 * 8

	for i = 1, v12 do
		buffer.writebits(v2, sum, v10, t6[p1:sub(i, i)])
		sum = sum + v10
	end

	v4 = v4 + v32
end

local v12 = require(script.Enums)
local t7 = {}

for v13, v14 in v12 do
	t7[v14] = v13
end

t.EnumItem = "EnumItem"
function t2.EnumItem() --[[ Line: 501 | Upvalues: v12 (copy), v2 (ref), v4 (ref) ]]
	local v42 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	local v8 = buffer.readu16(v2, v4)

	v4 = v4 + 2

	return v12[v42]:FromValue(v8)
end
function t3.EnumItem(p1) --[[ Line: 502 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref), t7 (copy) ]]
	local v12 = v4 + 3

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writeu8(v2, v4, t7[p1.EnumType])
	v4 = v4 + 1
	buffer.writeu16(v2, v4, p1.Value)
	v4 = v4 + 2
end

local Static1 = require(script.Static1)
local t8 = {}

for v15, v16 in Static1 do
	t8[v16] = v15
end

t.Static1 = "Static1"
function t2.Static1() --[[ Line: 508 | Upvalues: Static1 (copy), v2 (ref), v4 (ref) ]]
	local v42 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	return Static1[v42]
end
function t3.Static1(p1) --[[ Line: 509 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref), t8 (copy) ]]
	local v12 = v4 + 1

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writeu8(v2, v4, t8[p1] or 0)
	v4 = v4 + 1
end

local Static2 = require(script.Static2)
local t9 = {}

for v17, v18 in Static2 do
	t9[v18] = v17
end

t.Static2 = "Static2"
function t2.Static2() --[[ Line: 515 | Upvalues: Static2 (copy), v2 (ref), v4 (ref) ]]
	local v42 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	return Static2[v42]
end
function t3.Static2(p1) --[[ Line: 516 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref), t9 (copy) ]]
	local v12 = v4 + 1

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writeu8(v2, v4, t9[p1] or 0)
	v4 = v4 + 1
end

local Static3 = require(script.Static3)
local t10 = {}

for v19, v20 in Static3 do
	t10[v20] = v19
end

t.Static3 = "Static3"
function t2.Static3() --[[ Line: 522 | Upvalues: Static3 (copy), v2 (ref), v4 (ref) ]]
	local v42 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	return Static3[v42]
end
function t3.Static3(p1) --[[ Line: 523 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref), t10 (copy) ]]
	local v12 = v4 + 1

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writeu8(v2, v4, t10[p1] or 0)
	v4 = v4 + 1
end
t4[0] = function() --[[ Line: 527 ]]
	return nil
end
t5["nil"] = function(p1) --[[ Line: 528 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 1
	local v32

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v42 = buffer.create(v3)

		buffer.copy(v42, 0, v2, 0, v4)
		v1.Buffer = v42
		v2 = v42
	end

	v32 = v4
	buffer.writeu8(v2, v32, 0)
	v4 = v4 + 1
end
t4[1] = function() --[[ Line: 530 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	return -v3
end
t4[2] = function() --[[ Line: 531 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readu16(v2, v4)

	v4 = v4 + 2

	return -v3
end
t4[3] = function() --[[ Line: 532 | Upvalues: v2 (ref), v4 (ref) ]]
	local v1 = buffer.readbits(v2, v4 * 8, 24)

	v4 = v4 + 3

	return -v1
end
t4[4] = function() --[[ Line: 533 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readu32(v2, v4)

	v4 = v4 + 4

	return -v3
end
t4[5] = function() --[[ Line: 534 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	return v3
end
t4[6] = function() --[[ Line: 535 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readu16(v2, v4)

	v4 = v4 + 2

	return v3
end
t4[7] = function() --[[ Line: 536 | Upvalues: v2 (ref), v4 (ref) ]]
	local v1 = buffer.readbits(v2, v4 * 8, 24)

	v4 = v4 + 3

	return v1
end
t4[8] = function() --[[ Line: 537 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readu32(v2, v4)

	v4 = v4 + 4

	return v3
end
t4[9] = function() --[[ Line: 538 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	return v3
end
t4[10] = function() --[[ Line: 539 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readf64(v2, v4)

	v4 = v4 + 8

	return v3
end
function t5.number(p1) --[[ Line: 540 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	if p1 % 1 == 0 then
		if p1 < 0 then
			if p1 > -256 then
				local v12 = v4 + 2

				if v3 < v12 then
					while v3 < v12 do
						v3 = v3 * 2
					end

					local v22 = buffer.create(v3)

					buffer.copy(v22, 0, v2, 0, v4)
					v1.Buffer = v22
					v2 = v22
				end

				buffer.writeu8(v2, v4, 1)
				v4 = v4 + 1
				buffer.writeu8(v2, v4, -p1)
				v4 = v4 + 1
			elseif p1 > -65536 then
				local v7 = v4 + 3

				if v3 < v7 then
					while v3 < v7 do
						v3 = v3 * 2
					end

					local v8 = buffer.create(v3)

					buffer.copy(v8, 0, v2, 0, v4)
					v1.Buffer = v8
					v2 = v8
				end

				buffer.writeu8(v2, v4, 2)
				v4 = v4 + 1
				buffer.writeu16(v2, v4, -p1)
				v4 = v4 + 2
			elseif p1 > -16777216 then
				local v13 = v4 + 4

				if v3 < v13 then
					while v3 < v13 do
						v3 = v3 * 2
					end

					local v14 = buffer.create(v3)

					buffer.copy(v14, 0, v2, 0, v4)
					v1.Buffer = v14
					v2 = v14
				end

				buffer.writeu8(v2, v4, 3)
				v4 = v4 + 1
				buffer.writebits(v2, v4 * 8, 24, -p1)
				v4 = v4 + 3
			elseif p1 > -4294967296 then
				local v17 = v4 + 5

				if v3 < v17 then
					while v3 < v17 do
						v3 = v3 * 2
					end

					local v18 = buffer.create(v3)

					buffer.copy(v18, 0, v2, 0, v4)
					v1.Buffer = v18
					v2 = v18
				end

				buffer.writeu8(v2, v4, 4)
				v4 = v4 + 1
				buffer.writeu32(v2, v4, -p1)
				v4 = v4 + 4
			else
				local v23 = v4 + 9

				if v3 < v23 then
					while v3 < v23 do
						v3 = v3 * 2
					end

					local v24 = buffer.create(v3)

					buffer.copy(v24, 0, v2, 0, v4)
					v1.Buffer = v24
					v2 = v24
				end

				buffer.writeu8(v2, v4, 10)
				v4 = v4 + 1
				buffer.writef64(v2, v4, p1)
				v4 = v4 + 8
			end
		elseif p1 < 256 then
			local v29 = v4 + 2

			if v3 < v29 then
				while v3 < v29 do
					v3 = v3 * 2
				end

				local v30 = buffer.create(v3)

				buffer.copy(v30, 0, v2, 0, v4)
				v1.Buffer = v30
				v2 = v30
			end

			buffer.writeu8(v2, v4, 5)
			v4 = v4 + 1
			buffer.writeu8(v2, v4, p1)
			v4 = v4 + 1
		elseif p1 < 65536 then
			local v35 = v4 + 3

			if v3 < v35 then
				while v3 < v35 do
					v3 = v3 * 2
				end

				local v36 = buffer.create(v3)

				buffer.copy(v36, 0, v2, 0, v4)
				v1.Buffer = v36
				v2 = v36
			end

			buffer.writeu8(v2, v4, 6)
			v4 = v4 + 1
			buffer.writeu16(v2, v4, p1)
			v4 = v4 + 2
		elseif p1 < 16777216 then
			local v41 = v4 + 4

			if v3 < v41 then
				while v3 < v41 do
					v3 = v3 * 2
				end

				local v42 = buffer.create(v3)

				buffer.copy(v42, 0, v2, 0, v4)
				v1.Buffer = v42
				v2 = v42
			end

			buffer.writeu8(v2, v4, 7)
			v4 = v4 + 1
			buffer.writebits(v2, v4 * 8, 24, p1)
			v4 = v4 + 3
		elseif p1 < 4294967296 then
			local v45 = v4 + 5

			if v3 < v45 then
				while v3 < v45 do
					v3 = v3 * 2
				end

				local v46 = buffer.create(v3)

				buffer.copy(v46, 0, v2, 0, v4)
				v1.Buffer = v46
				v2 = v46
			end

			buffer.writeu8(v2, v4, 8)
			v4 = v4 + 1
			buffer.writeu32(v2, v4, p1)
			v4 = v4 + 4
		else
			local v51 = v4 + 9

			if v3 < v51 then
				while v3 < v51 do
					v3 = v3 * 2
				end

				local v52 = buffer.create(v3)

				buffer.copy(v52, 0, v2, 0, v4)
				v1.Buffer = v52
				v2 = v52
			end

			buffer.writeu8(v2, v4, 10)
			v4 = v4 + 1
			buffer.writef64(v2, v4, p1)
			v4 = v4 + 8
		end
	elseif p1 > -1048576 and p1 < 1048576 then
		local v57 = v4 + 5

		if v3 < v57 then
			while v3 < v57 do
				v3 = v3 * 2
			end

			local v58 = buffer.create(v3)

			buffer.copy(v58, 0, v2, 0, v4)
			v1.Buffer = v58
			v2 = v58
		end

		buffer.writeu8(v2, v4, 9)
		v4 = v4 + 1
		buffer.writef32(v2, v4, p1)
		v4 = v4 + 4
	else
		local v63 = v4 + 9

		if v3 < v63 then
			while v3 < v63 do
				v3 = v3 * 2
			end

			local v64 = buffer.create(v3)

			buffer.copy(v64, 0, v2, 0, v4)
			v1.Buffer = v64
			v2 = v64
		end

		buffer.writeu8(v2, v4, 10)
		v4 = v4 + 1
		buffer.writef64(v2, v4, p1)
		v4 = v4 + 8
	end
end
t4[11] = function() --[[ Line: 574 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	local v42 = buffer.readstring(v2, v4, v3)

	v4 = v4 + v3

	return v42
end
function t5.string(p1) --[[ Line: 575 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = #p1
	local v22 = v4 + (v12 + 2)

	if v3 < v22 then
		while v3 < v22 do
			v3 = v3 * 2
		end

		local v32 = buffer.create(v3)

		buffer.copy(v32, 0, v2, 0, v4)
		v1.Buffer = v32
		v2 = v32
	end

	buffer.writeu8(v2, v4, 11)
	v4 = v4 + 1
	buffer.writeu8(v2, v4, v12)
	v4 = v4 + 1
	buffer.writestring(v2, v4, p1)
	v4 = v4 + #p1
end
t4[12] = function() --[[ Line: 577 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	local v42 = buffer.create(v3)

	buffer.copy(v42, 0, v2, v4, v3)
	v4 = v4 + v3

	return v42
end
function t5.buffer(p1) --[[ Line: 578 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = buffer.len(p1)
	local v22 = v4 + (2 + v12)

	if v3 < v22 then
		while v3 < v22 do
			v3 = v3 * 2
		end

		local v32 = buffer.create(v3)

		buffer.copy(v32, 0, v2, 0, v4)
		v1.Buffer = v32
		v2 = v32
	end

	buffer.writeu8(v2, v4, 12)
	v4 = v4 + 1
	buffer.writeu8(v2, v4, v12)
	v4 = v4 + 1
	buffer.copy(v2, v4, p1)
	v4 = v4 + buffer.len(p1)
end
t4[13] = function() --[[ Line: 580 | Upvalues: v6 (ref), v5 (ref) ]]
	v6 = v6 + 1

	return v5[v6]
end
function t5.Instance(p1) --[[ Line: 581 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref), v6 (ref), v5 (ref) ]]
	local v12 = v4 + 1

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writeu8(v2, v4, 13)
	v4 = v4 + 1
	v6 = v6 + 1
	v5[v6] = p1
end
t4[14] = function() --[[ Line: 583 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	return v3 == 1
end
function t5.boolean(p1) --[[ Line: 584 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 2

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writeu8(v2, v4, 14)
	v4 = v4 + 1
	buffer.writeu8(v2, v4, if p1 then 1 else 0)
	v4 = v4 + 1
end
t4[15] = function() --[[ Line: 586 | Upvalues: v2 (ref), v4 (ref) ]]
	local v1 = NumberRange.new
	local v42 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	local v7 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	return v1(v42, v7)
end
function t5.NumberRange(p1) --[[ Line: 587 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 9

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writeu8(v2, v4, 15)
	v4 = v4 + 1
	buffer.writef32(v2, v4, p1.Min)
	v4 = v4 + 4
	buffer.writef32(v2, v4, p1.Max)
	v4 = v4 + 4
end
t4[16] = function() --[[ Line: 589 | Upvalues: v2 (ref), v4 (ref) ]]
	local v1 = BrickColor.new
	local v42 = buffer.readu16(v2, v4)

	v4 = v4 + 2

	return v1(v42)
end
function t5.BrickColor(p1) --[[ Line: 590 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 3

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writeu8(v2, v4, 16)
	v4 = v4 + 1
	buffer.writeu16(v2, v4, p1.Number)
	v4 = v4 + 2
end
t4[17] = function() --[[ Line: 592 | Upvalues: v2 (ref), v4 (ref) ]]
	local fromRGB = Color3.fromRGB
	local v3 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	local v6 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	local v9 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	return fromRGB(v3, v6, v9)
end
function t5.Color3(p1) --[[ Line: 593 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 4

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writeu8(v2, v4, 17)
	v4 = v4 + 1
	buffer.writeu8(v2, v4, p1.R * 255 + 0.5)
	v4 = v4 + 1
	buffer.writeu8(v2, v4, p1.G * 255 + 0.5)
	v4 = v4 + 1
	buffer.writeu8(v2, v4, p1.B * 255 + 0.5)
	v4 = v4 + 1
end
t4[18] = function() --[[ Line: 595 | Upvalues: v2 (ref), v4 (ref) ]]
	local v1 = UDim.new
	local v42 = buffer.readi16(v2, v4)

	v4 = v4 + 2

	local v8 = buffer.readi16(v2, v4)

	v4 = v4 + 2

	return v1(v42 / 1000, v8)
end
function t5.UDim(p1) --[[ Line: 596 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 5

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writeu8(v2, v4, 18)
	v4 = v4 + 1
	buffer.writei16(v2, v4, p1.Scale * 1000)
	v4 = v4 + 2
	buffer.writei16(v2, v4, p1.Offset)
	v4 = v4 + 2
end
t4[19] = function() --[[ Line: 598 | Upvalues: v2 (ref), v4 (ref) ]]
	local v1 = UDim2.new
	local v42 = buffer.readi16(v2, v4)

	v4 = v4 + 2

	local v7 = buffer.readi16(v2, v4)

	v4 = v4 + 2

	local v10 = buffer.readi16(v2, v4)

	v4 = v4 + 2

	local v14 = buffer.readi16(v2, v4)

	v4 = v4 + 2

	return v1(v42 / 1000, v7, v10 / 1000, v14)
end
function t5.UDim2(p1) --[[ Line: 599 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 9

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writeu8(v2, v4, 19)
	v4 = v4 + 1
	buffer.writei16(v2, v4, p1.X.Scale * 1000)
	v4 = v4 + 2
	buffer.writei16(v2, v4, p1.X.Offset)
	v4 = v4 + 2
	buffer.writei16(v2, v4, p1.Y.Scale * 1000)
	v4 = v4 + 2
	buffer.writei16(v2, v4, p1.Y.Offset)
	v4 = v4 + 2
end
t4[20] = function() --[[ Line: 601 | Upvalues: v2 (ref), v4 (ref) ]]
	local v1 = Rect.new
	local v42 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	local v7 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	local v10 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	local v13 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	return v1(v42, v7, v10, v13)
end
function t5.Rect(p1) --[[ Line: 602 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 17

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writeu8(v2, v4, 20)
	v4 = v4 + 1
	buffer.writef32(v2, v4, p1.Min.X)
	v4 = v4 + 4
	buffer.writef32(v2, v4, p1.Min.Y)
	v4 = v4 + 4
	buffer.writef32(v2, v4, p1.Max.X)
	v4 = v4 + 4
	buffer.writef32(v2, v4, p1.Max.Y)
	v4 = v4 + 4
end
t4[21] = function() --[[ Line: 604 | Upvalues: v2 (ref), v4 (ref) ]]
	local v1 = Vector2.new
	local v42 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	local v7 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	return v1(v42, v7)
end
function t5.Vector2(p1) --[[ Line: 605 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 9

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writeu8(v2, v4, 21)
	v4 = v4 + 1
	buffer.writef32(v2, v4, p1.X)
	v4 = v4 + 4
	buffer.writef32(v2, v4, p1.Y)
	v4 = v4 + 4
end
t4[22] = function() --[[ Line: 607 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	local v6 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	local v9 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	return Vector3.new(v3, v6, v9)
end
function t5.Vector3(p1) --[[ Line: 608 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = v4 + 13

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writeu8(v2, v4, 22)
	v4 = v4 + 1
	buffer.writef32(v2, v4, p1.X)
	v4 = v4 + 4
	buffer.writef32(v2, v4, p1.Y)
	v4 = v4 + 4
	buffer.writef32(v2, v4, p1.Z)
	v4 = v4 + 4
end
t4[23] = function() --[[ Line: 610 | Upvalues: v2 (ref), v4 (ref) ]]
	local fromEulerAnglesXYZ = CFrame.fromEulerAnglesXYZ
	local v3 = buffer.readu16(v2, v4)

	v4 = v4 + 2

	local v6 = buffer.readu16(v2, v4)

	v4 = v4 + 2

	local v9 = buffer.readu16(v2, v4)

	v4 = v4 + 2

	local v10 = fromEulerAnglesXYZ(v3 / 10430.219195527361, v6 / 10430.219195527361, v9 / 10430.219195527361)
	local v13 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	local v16 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	local v19 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	return v10 + Vector3.new(v13, v16, v19)
end
function t5.CFrame(p1) --[[ Line: 614 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12, v22, v32 = p1:ToEulerAnglesXYZ()
	local v42 = v4 + 19

	if v3 < v42 then
		while v3 < v42 do
			v3 = v3 * 2
		end

		local v5 = buffer.create(v3)

		buffer.copy(v5, 0, v2, 0, v4)
		v1.Buffer = v5
		v2 = v5
	end

	buffer.writeu8(v2, v4, 23)
	v4 = v4 + 1
	buffer.writeu16(v2, v4, v12 * 10430.219195527361 + 0.5)
	v4 = v4 + 2
	buffer.writeu16(v2, v4, v22 * 10430.219195527361 + 0.5)
	v4 = v4 + 2
	buffer.writeu16(v2, v4, v32 * 10430.219195527361 + 0.5)
	v4 = v4 + 2
	buffer.writef32(v2, v4, p1.X)
	v4 = v4 + 4
	buffer.writef32(v2, v4, p1.Y)
	v4 = v4 + 4
	buffer.writef32(v2, v4, p1.Z)
	v4 = v4 + 4
end
t4[24] = function() --[[ Line: 622 | Upvalues: v2 (ref), v4 (ref) ]]
	local v1 = Region3.new
	local v42 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	local v7 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	local v10 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	local v11 = Vector3.new(v42, v7, v10)
	local v14 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	local v17 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	local v20 = buffer.readf32(v2, v4)

	v4 = v4 + 4

	return v1(v11, (Vector3.new(v14, v17, v20)))
end
function t5.Region3(p1) --[[ Line: 628 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = p1.Size / 2
	local v22 = p1.CFrame.Position - v12
	local v32 = p1.CFrame.Position + v12
	local v42 = v4 + 25

	if v3 < v42 then
		while v3 < v42 do
			v3 = v3 * 2
		end

		local v5 = buffer.create(v3)

		buffer.copy(v5, 0, v2, 0, v4)
		v1.Buffer = v5
		v2 = v5
	end

	buffer.writeu8(v2, v4, 24)
	v4 = v4 + 1
	buffer.writef32(v2, v4, v22.X)
	v4 = v4 + 4
	buffer.writef32(v2, v4, v22.Y)
	v4 = v4 + 4
	buffer.writef32(v2, v4, v22.Z)
	v4 = v4 + 4
	buffer.writef32(v2, v4, v32.X)
	v4 = v4 + 4
	buffer.writef32(v2, v4, v32.Y)
	v4 = v4 + 4
	buffer.writef32(v2, v4, v32.Z)
	v4 = v4 + 4
end
t4[25] = function() --[[ Line: 638 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	local v42 = table.create(v3)

	for i = 1, v3 do
		local v5 = NumberSequenceKeypoint.new
		local v8 = buffer.readu8(v2, v4)

		v4 = v4 + 1

		local v11 = buffer.readu8(v2, v4)

		v4 = v4 + 1

		local v14 = buffer.readu8(v2, v4)

		v4 = v4 + 1
		table.insert(v42, v5(v8 / 255, v11 / 255, v14 / 255))
	end

	return NumberSequence.new(v42)
end
function t5.NumberSequence(p1) --[[ Line: 646 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = #p1.Keypoints
	local v22 = v4 + (v12 * 3 + 2)

	if v3 < v22 then
		while v3 < v22 do
			v3 = v3 * 2
		end

		local v32 = buffer.create(v3)

		buffer.copy(v32, 0, v2, 0, v4)
		v1.Buffer = v32
		v2 = v32
	end

	buffer.writeu8(v2, v4, 25)
	v4 = v4 + 1
	buffer.writeu8(v2, v4, v12)
	v4 = v4 + 1

	for v8, v9 in p1.Keypoints do
		buffer.writeu8(v2, v4, v9.Time * 255 + 0.5)
		v4 = v4 + 1
		buffer.writeu8(v2, v4, v9.Value * 255 + 0.5)
		v4 = v4 + 1
		buffer.writeu8(v2, v4, v9.Envelope * 255 + 0.5)
		v4 = v4 + 1
	end
end
t4[26] = function() --[[ Line: 656 | Upvalues: v2 (ref), v4 (ref) ]]
	local v3 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	local v42 = table.create(v3)

	for i = 1, v3 do
		local v5 = ColorSequenceKeypoint.new
		local v8 = buffer.readu8(v2, v4)

		v4 = v4 + 1

		local fromRGB = Color3.fromRGB
		local v11 = buffer.readu8(v2, v4)

		v4 = v4 + 1

		local v14 = buffer.readu8(v2, v4)

		v4 = v4 + 1

		local v17 = buffer.readu8(v2, v4)

		v4 = v4 + 1
		table.insert(v42, v5(v8 / 255, fromRGB(v11, v14, v17)))
	end

	return ColorSequence.new(v42)
end
function t5.ColorSequence(p1) --[[ Line: 664 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref) ]]
	local v12 = #p1.Keypoints
	local v22 = v4 + (v12 * 4 + 2)

	if v3 < v22 then
		while v3 < v22 do
			v3 = v3 * 2
		end

		local v32 = buffer.create(v3)

		buffer.copy(v32, 0, v2, 0, v4)
		v1.Buffer = v32
		v2 = v32
	end

	buffer.writeu8(v2, v4, 26)
	v4 = v4 + 1
	buffer.writeu8(v2, v4, v12)
	v4 = v4 + 1

	for v8, v9 in p1.Keypoints do
		buffer.writeu8(v2, v4, v9.Time * 255 + 0.5)
		v4 = v4 + 1
		buffer.writeu8(v2, v4, v9.Value.R * 255 + 0.5)
		v4 = v4 + 1
		buffer.writeu8(v2, v4, v9.Value.G * 255 + 0.5)
		v4 = v4 + 1
		buffer.writeu8(v2, v4, v9.Value.B * 255 + 0.5)
		v4 = v4 + 1
	end
end
t4[27] = function() --[[ Line: 675 | Upvalues: v12 (copy), v2 (ref), v4 (ref) ]]
	local v42 = buffer.readu8(v2, v4)

	v4 = v4 + 1

	local v8 = buffer.readu16(v2, v4)

	v4 = v4 + 2

	return v12[v42]:FromValue(v8)
end
function t5.EnumItem(p1) --[[ Line: 678 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref), t7 (copy) ]]
	local v12 = v4 + 4

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writeu8(v2, v4, 27)
	v4 = v4 + 1
	buffer.writeu8(v2, v4, t7[p1.EnumType])
	v4 = v4 + 1
	buffer.writeu16(v2, v4, p1.Value)
	v4 = v4 + 2
end
t4[28] = function() --[[ Line: 685 | Upvalues: v2 (ref), v4 (ref), t4 (copy) ]]
	local t = {}

	while true do
		local v3 = buffer.readu8(v2, v4)

		v4 = v4 + 1

		if v3 == 0 then
			break
		end

		local v42 = t4[v3]()
		local v8 = buffer.readu8(v2, v4)

		v4 = v4 + 1
		t[v42] = t4[v8]()
	end

	return t
end
function t5.table(p1) --[[ Line: 692 | Upvalues: v4 (ref), v3 (ref), v2 (ref), v1 (ref), t5 (copy) ]]
	local v12 = v4 + 1

	if v3 < v12 then
		while v3 < v12 do
			v3 = v3 * 2
		end

		local v22 = buffer.create(v3)

		buffer.copy(v22, 0, v2, 0, v4)
		v1.Buffer = v22
		v2 = v22
	end

	buffer.writeu8(v2, v4, 28)
	v4 = v4 + 1

	for v5, v6 in p1 do
		t5[typeof(v5)](v5)
		t5[typeof(v6)](v6)
	end

	local v7 = v4 + 1
	local v9

	if not (v3 < v7) then
		local v8

		v8 = v2
		v9 = v4
		buffer.writeu8(v2, v9, 0)
		v4 = v4 + 1

		return
	end

	while v3 < v7 do
		v3 = v3 * 2
	end

	local v10 = buffer.create(v3)

	buffer.copy(v10, 0, v2, 0, v4)
	v1.Buffer = v10
	v2 = v10
	v9 = v4
	buffer.writeu8(v10, v9, 0)
	v4 = v4 + 1
end

return {
	Import = function(p1) --[[ Import | Line: 702 | Upvalues: v1 (ref), v2 (ref), v3 (ref), v4 (ref), v5 (ref), v6 (ref) ]]
		v1 = p1
		v2 = p1.Buffer
		v3 = p1.BufferLength
		v4 = p1.BufferOffset
		v5 = p1.Instances
		v6 = p1.InstancesOffset
	end,
	Export = function() --[[ Export | Line: 711 | Upvalues: v1 (ref), v3 (ref), v4 (ref), v6 (ref) ]]
		v1.BufferLength = v3
		v1.BufferOffset = v4
		v1.InstancesOffset = v6

		return v1
	end,
	Truncate = function() --[[ Truncate | Line: 718 | Upvalues: v4 (ref), v2 (ref), v6 (ref), v5 (ref) ]]
		local v1 = buffer.create(v4)

		buffer.copy(v1, 0, v2, 0, v4)

		if v6 == 0 then
			return v1
		end

		return v1, v5
	end,
	Ended = function() --[[ Ended | Line: 724 | Upvalues: v4 (ref), v3 (ref) ]]
		return v3 <= v4
	end,
	Types = t,
	Reads = t2,
	Writes = t3
}