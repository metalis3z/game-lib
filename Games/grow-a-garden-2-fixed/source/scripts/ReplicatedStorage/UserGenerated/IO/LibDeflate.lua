--credit to leon games studio
local byte = string.byte
local char = string.char
local find = string.find
local gsub = string.gsub
local sub = string.sub
local concat = table.concat
local sort = table.sort
local t = {}
local t2 = {}
local t3 = {}
local t4 = {}
local t5 = {}
local t6 = {}
local t7 = {}
local t8 = {}
local t9 = {}
local t10 = {}
local t11 = {}
local t12 = {}
local t13 = {}
local t14 = {
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
local t15 = {
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
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
local t16 = {}
local t17 = {}
local t18 = {}
local t19 = {
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
local t20 = {
	[0] = 1,
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
local t21 = {
	[0] = 0,
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
local t22 = {}

for i = 0, 255 do
	t[i] = char(i)
end

local v1 = 1

for j = 0, 32 do
	t2[j] = v1
	v1 = v1 * 2
end

for k = 1, 9 do
	t3[k] = {}

	for n = 0, t2[k + 1] - 1 do
		local v2, v3 = 0, n

		for m = 1, k do
			local v4

			v4 = if v2 % 2 == 1 or v3 % 2 == 1 then 1 else 0
			v2 = (v2 - v2 % 2 + v4) * 2
			v3 = (v3 - v3 % 2) / 2
		end

		t3[k][n] = (v2 - v2 % 2) / 2
	end
end

local count = 1
local sum = 18
local v6 = 16
local sum2 = 265

for i = 3, 258 do
	if i <= 10 then
		t5[i] = i + 254
		t6[i] = 0

		continue
	end

	if i == 258 then
		t5[i] = 285
		t6[i] = 0

		continue
	end

	if sum < i then
		sum = sum + v6
		v6 = v6 * 2
		sum2 = sum2 + 4
		count = count + 1
	end

	local v7 = i - sum - 1 + v6 / 2

	t5[i] = (v7 - v7 % (v6 / 8)) / (v6 / 8) + sum2
	t6[i] = count
	t4[i] = v7 % (v6 / 8)
end

t7[1] = 0
t7[2] = 1
t8[1] = 0
t8[2] = 0

local v8 = 4
local v9 = 3
local sum3 = 2
local count2 = 0

for i = 3, 256 do
	if v8 < i then
		v9 = v9 * 2
		sum3 = sum3 + 2
		count2 = count2 + 1
		v8 = v8 * 2
	end

	t7[i] = i <= v9 and sum3 or sum3 + 1
	t8[i] = if count2 < 0 then 0 else count2

	if v8 >= 8 then
		t9[i] = (i - v8 / 2 - 1) % (v8 / 4)
	end
end

function t13.Adler32(p1, p2) --[[ Adler32 | Line: 371 | Upvalues: byte (copy) ]]
	if type(p2) ~= "string" then
		error(("Usage: LibDeflate:Adler32(str): \'str\' - string expected got \'%s\'."):format((type(p2))), 2)
	end

	local v1 = #p2
	local sum = 1
	local v2 = 1
	local v3 = 0

	while sum <= v1 - 15 do
		local v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19 = byte(p2, sum, sum + 15)

		sum = sum + 16
		v2 = (v2 + v4 + v5 + v6 + v7 + v8 + v9 + v10 + v11 + v12 + v13 + v14 + v15 + v16 + v17 + v18 + v19) % 65521
		v3 = (v3 + v2 * 16 + v4 * 16 + 15 * v5 + 14 * v6 + 13 * v7 + 12 * v8 + 11 * v9 + 10 * v10 + 9 * v11 + 8 * v12 + 7 * v13 + 6 * v14 + 5 * v15 + 4 * v16 + 3 * v17 + 2 * v18 + v19) % 65521
	end

	while sum <= v1 do
		v2 = (v2 + byte(p2, sum, sum)) % 65521
		sum = sum + 1
		v3 = (v3 + v2) % 65521
	end

	return (v3 * 65536 + v2) % 4294967296
end

local function IsEqualAdler32(p1, p2) --[[ IsEqualAdler32 | Line: 416 ]]
	return p1 % 4294967296 == p2 % 4294967296
end

function t13.CreateDictionary(p1, p2, p3, p4) --[[ CreateDictionary | Line: 462 | Upvalues: byte (copy) ]]
	if type(p2) ~= "string" then
		error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): \'str\' - string expected got \'%s\'."):format((type(p2))), 2)
	end

	if type(p3) ~= "number" then
		error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): \'strlen\' - number expected got \'%s\'."):format((type(p3))), 2)
	end

	if type(p4) ~= "number" then
		error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): \'adler32\' - number expected got \'%s\'."):format((type(p4))), 2)
	end

	if p3 ~= #p2 then
		error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): \'strlen\' does not match the actual length of \'str\'. \'strlen\': %u, \'#str\': %u . Please check if \'str\' is modified unintentionally."):format(p3, #p2))
	end

	if p3 == 0 then
		error("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): \'str\' - Empty string is not allowed.", 2)
	end

	if p3 > 32768 then
		error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): \'str\' - string longer than 32768 bytes is not allowed. Got %d bytes."):format(p3), 2)
	end

	local v1 = p1:Adler32(p2)

	if not (if p4 % 4294967296 == v1 % 4294967296 then true else false) then
		error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): \'adler32\' does not match the actual adler32 of \'str\'. \'adler32\': %u, \'Adler32(str)\': %u . Please check if \'str\' is modified unintentionally."):format(p4, v1))
	end

	local t = {
		adler32 = p4,
		hash_tables = {},
		string_table = {},
		strlen = p3
	}
	local string_table = t.string_table
	local hash_tables = t.hash_tables

	string_table[1] = byte(p2, 1, 1)
	string_table[2] = byte(p2, 2, 2)

	if p3 >= 3 then
		local v3 = string_table[1] * 256 + string_table[2]
		local count = 1

		while count <= p3 - 2 - 3 do
			local v4, v5, v6, v7 = byte(p2, count + 2, count + 5)

			string_table[count + 2] = v4
			string_table[count + 3] = v5
			string_table[count + 4] = v6
			string_table[count + 5] = v7

			local v8 = (v3 * 256 + v4) % 16777216
			local v9 = hash_tables[v8]

			if not v9 then
				v9 = {}
				hash_tables[v8] = v9
			end

			v9[#v9 + 1] = count - p3

			local v10 = count + 1
			local v11 = (v8 * 256 + v5) % 16777216
			local v12 = hash_tables[v11]

			if not v12 then
				v12 = {}
				hash_tables[v11] = v12
			end

			v12[#v12 + 1] = v10 - p3

			local v13 = v10 + 1
			local v14 = (v11 * 256 + v6) % 16777216
			local v15 = hash_tables[v14]

			if not v15 then
				v15 = {}
				hash_tables[v14] = v15
			end

			v15[#v15 + 1] = v13 - p3

			local v16 = v13 + 1

			v3 = (v14 * 256 + v7) % 16777216

			local v17 = hash_tables[v3]

			if not v17 then
				v17 = {}
				hash_tables[v3] = v17
			end

			v17[#v17 + 1] = v16 - p3
			count = v16 + 1
		end

		while count <= p3 - 2 do
			local v18 = byte(p2, count + 2)

			string_table[count + 2] = v18
			v3 = (v3 * 256 + v18) % 16777216

			local v19 = hash_tables[v3]

			if not v19 then
				v19 = {}
				hash_tables[v3] = v19
			end

			v19[#v19 + 1] = count - p3
			count = count + 1
		end
	end

	return t
end

local function IsValidDictionary(p1) --[[ IsValidDictionary | Line: 560 ]]
	if p1 == nil or type(p1) ~= "table" then
		return false, ("\'dictionary\' - table expected got \'%s\'."):format((type(p1)))
	end

	if type(p1.adler32) == "number" and (type(p1.string_table) == "table" and (type(p1.strlen) == "number" and (not (p1.strlen <= 0) and (not (p1.strlen > 32768) and p1.strlen == #p1.string_table)) and type(p1.hash_tables) == "table")) then
		return true, ""
	end

	return false, ("\'%s\' - corrupted dictionary."):format((type(p1)))
end

local t23 = {
	[0] = { false, nil, 0, 0, 0 },
	[1] = { false, nil, 4, 8, 4 },
	[2] = { false, nil, 5, 18, 8 },
	[3] = { false, nil, 6, 32, 32 },
	[4] = { true, 4, 4, 16, 16 },
	[5] = { true, 8, 16, 32, 32 },
	[6] = { true, 8, 16, 128, 128 },
	[7] = { true, 8, 32, 128, 256 },
	[8] = { true, 32, 128, 258, 1024 },
	[9] = { true, 32, 258, 258, 4096 }
}

local function IsValidArguments(p1, p2, p3, p4, p5) --[[ IsValidArguments | Line: 640 | Upvalues: IsValidDictionary (copy), t23 (copy) ]]
	if type(p1) ~= "string" then
		return false, ("\'str\' - string expected got \'%s\'."):format((type(p1)))
	end

	if p2 then
		local v1, v2 = IsValidDictionary(p3)

		if not v1 then
			return false, v2
		end
	end

	if not p4 then
		return true, ""
	end

	local v3 = type(p5)

	if v3 ~= "nil" and v3 ~= "table" then
		return false, ("\'configs\' - nil or table expected got \'%s\'."):format((type(p5)))
	end

	if v3 ~= "table" then
		return true, ""
	end

	assert(p5)

	for k, v in pairs(p5) do
		if k ~= "level" and k ~= "strategy" then
			return false, ("\'configs\' - unsupported table key in the configs: \'%s\'."):format(k)
		end

		if k == "level" and not t23[v] then
			return false, ("\'configs\' - unsupported \'level\': %s."):format((tostring(v)))
		end

		if k == "strategy" and (v ~= "fixed" and (v ~= "huffman_only" and v ~= "dynamic")) then
			return false, ("\'configs\' - unsupported \'strategy\': \'%s\'."):format((tostring(v)))
		end
	end

	return true, ""
end

local function CreateWriter() --[[ CreateWriter | Line: 702 | Upvalues: t2 (copy), t (copy), char (copy), concat (copy) ]]
	local v1 = 0
	local v2 = 0
	local v3 = 0
	local v4 = 0
	local t3 = {}
	local t4 = {}

	return function(p1, p2) --[[ WriteBits | Line: 715 | Upvalues: v2 (ref), t2 (ref), v3 (ref), v4 (ref), v1 (ref), t3 (ref), t (ref) ]]
		v2 = v2 + p1 * t2[v3]
		v3 = v3 + p2
		v4 = v4 + p2

		if not (v3 >= 32) then
			return
		end

		v1 = v1 + 1
		t3[v1] = t[v2 % 256] .. t[(v2 - v2 % 256) / 256 % 256] .. t[(v2 - v2 % 65536) / 65536 % 256] .. t[(v2 - v2 % 16777216) / 16777216 % 256]

		local v12 = t2[32 - v3 + p2]

		v2 = (p1 - p1 % v12) / v12
		v3 = v3 - 32
	end, function(p1) --[[ WriteString | Line: 737 | Upvalues: v3 (ref), v1 (ref), t3 (ref), v2 (ref), char (ref), v4 (ref) ]]
		for i = 1, v3, 8 do
			v1 = v1 + 1
			t3[v1] = char(v2 % 256)
			v2 = (v2 - v2 % 256) / 256
		end

		v3 = 0
		v1 = v1 + 1
		t3[v1] = p1
		v4 = v4 + #p1 * 8
	end, function(p1) --[[ FlushWriter | Line: 756 | Upvalues: v4 (ref), v3 (ref), v2 (ref), t2 (ref), v1 (ref), t3 (ref), t (ref), concat (ref), t4 (copy) ]]
		if p1 == 3 then
			return v4, nil
		end

		if p1 == 1 or p1 == 2 then
			local v12 = (8 - v3 % 8) % 8

			if v3 > 0 then
				v2 = v2 - t2[v3] + t2[v3 + v12]

				for i = 1, v3, 8 do
					v1 = v1 + 1
					t3[v1] = t[v2 % 256]
					v2 = (v2 - v2 % 256) / 256
				end

				v2 = 0
				v3 = 0
			end

			if p1 == 2 then
				v4 = v4 + v12

				return v4, nil
			end
		end

		local v22 = concat(t3)

		t3 = {}
		v1 = 0
		t4[#t4 + 1] = v22

		if p1 == 0 then
			return v4, nil
		end

		return v4, concat(t4)
	end
end

local function MinHeapPush(p1, p2, p3) --[[ MinHeapPush | Line: 808 ]]
	local v1 = p3 + 1

	p1[v1] = p2

	local v3, v4 = (v1 - v1 % 2) / 2, v1

	while v3 >= 1 and p2[1] < p1[v3][1] do
		local v5 = p1[v3]

		p1[v3] = p2
		p1[v4] = v5
		v3, v4 = (v3 - v3 % 2) / 2, v3
	end
end

local function MinHeapPop(p1, p2) --[[ MinHeapPop | Line: 829 ]]
	local v1 = p1[1]
	local v2 = p1[p2]
	local v3 = v2[1]

	p1[1] = v2
	p1[p2] = v1

	local v4 = 1
	local v5 = v4 * 2
	local v6 = p2 - 1
	local v7 = v5 + 1

	while v5 <= v6 do
		local v8 = p1[v5]

		if v7 <= v6 and p1[v7][1] < v8[1] then
			local v9 = p1[v7]

			if not (v9[1] < v3) then
				break
			end

			p1[v7] = v2
			p1[v4] = v9
			v5 = v7 * 2
			v7, v4 = v5 + 1, v7
		else
			if not (v8[1] < v3) then
				break
			end

			p1[v5] = v2
			p1[v4] = v8

			local v10 = v5 * 2

			v5, v7, v4 = v10, v10 + 1, v5
		end
	end

	return v1
end

local function GetHuffmanCodeFromBitlen(p1, p2, p3, p4) --[[ GetHuffmanCodeFromBitlen | Line: 879 | Upvalues: t3 (copy) ]]
	local v1 = 0
	local t = {}
	local t2 = {}

	for i = 1, p4 do
		v1 = (v1 + (p1[i - 1] or 0)) * 2
		t[i] = v1
	end

	for j = 0, p3 do
		local v2 = p2[j]

		if v2 then
			local v3 = t[v2]

			t[v2] = v3 + 1

			if v2 <= 9 then
				t2[j] = t3[v2][v3]

				continue
			end

			local v4 = 0

			for k = 1, v2 do
				local v5

				v5 = if v4 % 2 == 1 or v3 % 2 == 1 then 1 else 0
				v4 = (v4 - v4 % 2 + v5) * 2
				v3 = (v3 - v3 % 2) / 2
			end

			t2[j] = (v4 - v4 % 2) / 2
		end
	end

	return t2
end

local function SortByFirstThenSecond(p1, p2) --[[ SortByFirstThenSecond | Line: 923 ]]
	return if p1[1] < p2[1] then true elseif p1[1] == p2[1] then p1[2] < p2[2] else false
end

local function GetHuffmanBitlenAndCode(p1, p2, p3) --[[ GetHuffmanBitlenAndCode | Line: 938 | Upvalues: sort (copy), SortByFirstThenSecond (copy), MinHeapPop (copy), MinHeapPush (copy), GetHuffmanCodeFromBitlen (copy) ]]
	local count = 0
	local t = {}
	local t2 = {}
	local t3 = {}
	local v1 = -1
	local t4 = {}
	local t5 = {}

	for k, v in pairs(p1) do
		count = count + 1
		t[count] = { v, k }
	end

	if count == 0 then
		return {}, {}, -1
	end

	if count == 1 then
		local v2 = t[1][2]

		t3[v2] = 1
		t5[v2] = 0

		return t3, t5, v2
	end

	sort(t, SortByFirstThenSecond)

	local v3 = count

	for i = 1, count do
		t2[i] = t[i]
	end

	while v3 > 1 do
		local v4 = MinHeapPop(t2, v3)
		local v5 = v3 - 1
		local v6 = MinHeapPop(t2, v5)
		local v7 = v5 - 1

		MinHeapPush(t2, {
			v4[1] + v6[1],
			-1,
			v4,
			v6
		}, v7)
		v3 = v7 + 1
	end

	local t6 = {
		t2[1],
		{},
		{},
		{}
	}

	t2[1][1] = 0

	local count2 = 1
	local count3 = 1
	local sum = 0

	while count2 <= count3 do
		local v8
		local v9 = t6[count2]
		local v10 = v9[1]
		local v11 = v9[2]
		local v12 = v9[3]
		local v13 = v9[4]

		if v12 then
			count3 = count3 + 1
			t6[count3] = v12
			v12[1] = v10 + 1
		end

		if v13 then
			count3 = count3 + 1
			t6[count3] = v13
			v13[1] = v10 + 1
		end

		count2 = count2 + 1

		if p2 < v10 then
			v10, sum = p2, sum + 1
		end

		if v11 >= 0 then
			t3[v11] = v10
			v8 = if v1 < v11 then v11 else v1
			t4[v10] = (t4[v10] or 0) + 1
			v1 = v8
		end
	end

	if sum > 0 then
		repeat
			local count4 = p2 - 1

			while (t4[count4] or 0) == 0 do
				count4 = count4 - 1
			end

			t4[count4] = t4[count4] - 1
			t4[count4 + 1] = (t4[count4 + 1] or 0) + 2
			t4[p2] = t4[p2] - 1
			sum = sum - 2
		until sum <= 0

		local count4 = 1

		for j = p2, 1, -1 do
			local count5 = t4[j] or 0

			while count5 > 0 do
				t3[t[count4][2]] = j
				count5 = count5 - 1
				count4 = count4 + 1
			end
		end
	end

	return t3, GetHuffmanCodeFromBitlen(t4, t3, p3, p2), v1
end

local function RunLengthEncodeHuffmanBitlen(p1, p2, p3, p4) --[[ RunLengthEncodeHuffmanBitlen | Line: 1073 ]]
	local count = 0
	local t = {}
	local t2 = {}
	local count2 = 0
	local t3 = {}
	local v1 = nil
	local count3 = 0
	local v3 = p2 + (if p4 < 0 then 0 else p4) + 1

	for i = 0, v3 + 1 do
		local v4 = if i <= p2 then p1[i] or 0 elseif i <= v3 then p3[i - p2 - 1] or 0 else nil

		if v4 == v1 then
			count3 = count3 + 1

			if v4 == 0 or count3 ~= 6 then
				if v4 == 0 and count3 == 138 then
					count = count + 1
					t[count] = 18
					count2 = count2 + 1
					t3[count2] = 127
					t2[18] = (t2[18] or 0) + 1
					count3 = 0
				end

				continue
			end

			count = count + 1
			t[count] = 16
			count2 = count2 + 1
			t3[count2] = 3
			t2[16] = (t2[16] or 0) + 1
			count3 = 0

			continue
		end

		if count3 == 1 then
			assert(v1)
			count = count + 1
			t[count] = v1
			t2[v1] = (t2[v1] or 0) + 1
		elseif count3 == 2 then
			assert(v1)

			local v5 = count + 1

			t[v5] = v1
			count = v5 + 1
			t[count] = v1
			t2[v1] = (t2[v1] or 0) + 2
		elseif count3 >= 3 then
			count = count + 1

			local v6 = if v1 == 0 then if count3 <= 10 then 17 else 18 else 16

			t[count] = v6
			t2[v6] = (t2[v6] or 0) + 1
			count2 = count2 + 1
			t3[count2] = count3 <= 10 and count3 - 3 or count3 - 11
		end

		if v4 and v4 ~= 0 then
			count = count + 1
			t[count] = v4
			t2[v4] = (t2[v4] or 0) + 1
			v1 = v4
			count3 = 0

			continue
		end

		v1, count3 = v4, 1
	end

	return t, t3, t2
end

local function LoadStringToTable(p1, p2, p3, p4, p5) --[[ LoadStringToTable | Line: 1162 | Upvalues: byte (copy) ]]
	local sum = p3 - p5

	while sum <= p4 - 15 - p5 do
		local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16 = byte(p1, sum + p5, sum + 15 + p5)

		p2[sum] = v1
		p2[sum + 1] = v2
		p2[sum + 2] = v3
		p2[sum + 3] = v4
		p2[sum + 4] = v5
		p2[sum + 5] = v6
		p2[sum + 6] = v7
		p2[sum + 7] = v8
		p2[sum + 8] = v9
		p2[sum + 9] = v10
		p2[sum + 10] = v11
		p2[sum + 11] = v12
		p2[sum + 12] = v13
		p2[sum + 13] = v14
		p2[sum + 14] = v15
		p2[sum + 15] = v16
		sum = sum + 16
	end

	while sum <= p4 - p5 do
		p2[sum] = byte(p1, sum + p5, sum + p5)
		sum = sum + 1
	end

	return p2
end

local function GetBlockLZ77Result(p1, p2, p3, p4, p5, p6, p7) --[[ GetBlockLZ77Result | Line: 1219 | Upvalues: t23 (copy), t5 (copy), t6 (copy), t7 (copy), t9 (copy), t8 (copy), t4 (copy) ]]
	local v1 = t23[p1]
	local v2 = v1[1]
	local v3 = v1[2]
	local v4 = v1[3]
	local v5 = v1[4]
	local v6 = v1[5]
	local v7 = if v2 or not v4 then 2147483646 else v4
	local v8 = v6 - v6 % 4 / 4
	local v9, v10, v11

	if p7 then
		v9 = p7.hash_tables
		v10 = p7.string_table
		v11 = p7.strlen
		assert(p4 == 1)

		if p4 <= p5 and v11 >= 2 then
			local v13 = v10[v11 - 1] * 65536 + v10[v11] * 256 + p2[1]
			local v14 = p3[v13]

			if not v14 then
				v14 = {}
				p3[v13] = v14
			end

			v14[#v14 + 1] = -1
		end

		if p4 + 1 <= p5 and v11 >= 1 then
			local v15 = v10[v11] * 65536 + p2[1] * 256 + p2[2]
			local v16 = p3[v15]

			if not v16 then
				v16 = {}
				p3[v15] = v16
			end

			v16[#v16 + 1] = 0
		end
	else
		v11 = 0
		v10 = {}
		v9 = {}
	end

	local v17 = v11 + 3
	local v18 = (p2[p4 - p6] or 0) * 256 + (p2[p4 + 1 - p6] or 0)
	local t = {}
	local count = 0
	local t2 = {}
	local t3 = {}
	local count2 = 0
	local t10 = {}
	local t11 = {}
	local count3 = 0
	local t12 = {}
	local count4 = 0
	local v19 = false
	local v20 = 0
	local v21 = 0
	local count5, v23 = p4, p5 + (if v2 then 1 else 0)

	while count5 <= v23 do
		local v24, count6, v25, v26, v27, count7, sum, v28, count8
		local v29 = count5 - p6
		local v30 = p6 - 3
		local v31 = 0

		v18 = (v18 * 256 + (p2[v29 + 2] or 0)) % 16777216

		local v32 = nil
		local v33 = p3[v18]

		if v33 then
			v24 = #v33
			count6 = v24
			v32 = v33
			v25 = v20
			v26 = v21
		else
			v24 = 0
			v33 = {}
			p3[v18] = v33

			if v9 then
				v32 = v9[v18]

				if v32 then
					v27 = #v32

					if v27 then
						v25 = v20
						v26 = v21
					else
						v27 = 0
						v25 = v20
						v26 = v21
					end
				else
					v27 = 0
					v25 = v20
					v26 = v21
				end

				count6 = v27
			else
				count6 = 0
				v25 = v20
				v26 = v21
			end
		end

		if count5 <= p5 then
			v33[v24 + 1] = count5
		end

		if count6 > 0 and (count5 + 2 <= p5 and (not v2 or v25 < v4)) then
			count7 = if v2 and (v3 <= v25 and v8) then v8 else v6

			local v34 = p5 - count5
			local v36 = v29 + 3
			local v37 = (if v34 >= 257 then 257 else v34) + v29

			while count6 >= 1 and count7 > 0 do
				local count9
				local v38 = v32[count6]

				if count5 - v38 > 32768 then
					break
				end

				if v38 < count5 then
					if v38 >= -257 then
						local count10

						count9 = v36
						count10 = v38 - v30

						while count9 <= v37 and p2[count10] == p2[count9] do
							count9 = count9 + 1
							count10 = count10 + 1
						end
					else
						local count10

						count9 = v36
						count10 = v17 + v38

						while count9 <= v37 and v10[count10] == p2[count9] do
							count9 = count9 + 1
							count10 = count10 + 1
						end
					end

					local v39 = count9 - v29

					if v31 < v39 then
						v31 = v39
						v21 = count5 - v38
					end

					if v5 <= v31 then
						break
					end
				end

				count6 = count6 - 1
				count7 = count7 - 1

				if count6 == 0 and (v38 > 0 and v9) then
					v32 = v9[v18]
					count6 = v9[v18] and #v32 or 0
				end
			end
		end

		if not v2 then
			v25 = v31
			v26 = v21
		end

		local v41, v42

		if v2 and not v19 then
			count5 = count5 + 1

			if v2 and not v19 then
				v19 = true
			else
				v41 = v2 and v29 - 1 or v29
				v42 = p2[v41]
				count = count + 1
				t[count] = v42
				t2[v42] = (t2[v42] or 0) + 1
			end
		elseif (v25 > 3 or v25 == 3 and v26 < 4096) and v31 <= v25 then
			local v43 = t5[v25]

			if v26 <= 256 then
				sum = t7[v26]
				v28 = t9[v26]
				count8 = t8[v26]
			else
				count8 = 7

				local v45 = 384
				local v46 = 512

				sum = 16

				while true do
					if v26 <= v45 then
						v28 = (v26 - v46 / 2 - 1) % (v46 / 4)

						break
					end

					if v26 <= v46 then
						sum = sum + 1
						v28 = (v26 - v46 / 2 - 1) % (v46 / 4)

						break
					end

					count8 = count8 + 1
					v45 = v45 * 2
					v46 = v46 * 2
					sum = sum + 2
				end
			end

			count = count + 1
			t[count] = v43
			t2[v43] = (t2[v43] or 0) + 1
			count2 = count2 + 1
			t3[count2] = sum
			t10[sum] = (t10[sum] or 0) + 1

			if t6[v25] > 0 then
				count3 = count3 + 1
				t11[count3] = t4[v25]
			end

			if count8 > 0 then
				count4 = count4 + 1
				t12[count4] = v28
			end

			for i = count5 + 1, count5 + v25 - (if v2 then 2 else 1) do
				v18 = (v18 * 256 + (p2[i - p6 + 2] or 0)) % 16777216

				if v25 <= v7 then
					local v50 = p3[v18]

					if not v50 then
						v50 = {}
						p3[v18] = v50
					end

					v50[#v50 + 1] = i
				end
			end

			count5 = count5 + v25 - (if v2 then 1 else 0)
			v19 = false
		else
			count5 = count5 + 1

			if v2 and not v19 then
				v19 = true
			else
				v41 = v2 and v29 - 1 or v29
				v42 = p2[v41]
				count = count + 1
				t[count] = v42
				t2[v42] = (t2[v42] or 0) + 1
			end
		end

		v20 = v31
	end

	t[count + 1] = 256
	t2[256] = (t2[256] or 0) + 1

	return t, t11, t2, t3, t12, t10
end

local function GetBlockDynamicHuffmanHeader(p1, p2) --[[ GetBlockDynamicHuffmanHeader | Line: 1478 | Upvalues: GetHuffmanBitlenAndCode (copy), RunLengthEncodeHuffmanBitlen (copy), t14 (copy) ]]
	local v1, v2, v3 = GetHuffmanBitlenAndCode(p1, 15, 285)
	local v4, v5, v6 = GetHuffmanBitlenAndCode(p2, 15, 29)
	local v7, v8, v9 = RunLengthEncodeHuffmanBitlen(v1, v3, v4, v6)
	local v10, v11 = GetHuffmanBitlenAndCode(v9, 7, 18)
	local v12 = 0

	for i = 1, 19 do
		if (v10[t14[i]] or 0) ~= 0 then
			v12 = i
		end
	end

	local v15 = v6 + 1 - 1

	if v15 < 0 then
		v15 = 0
	end

	return v3 + 1 - 257, v15, v12 - 4, v10, v11, v7, v8, v1, v2, v4, v5
end

local function GetDynamicHuffmanBlockSize(p1, p2, p3, p4, p5, p6, p7) --[[ GetDynamicHuffmanBlockSize | Line: 1516 | Upvalues: t15 (copy) ]]
	local sum = 17 + (p3 + 4) * 3

	for i = 1, #p5 do
		local v1 = p5[i]

		sum = sum + p4[v1]

		if v1 >= 16 then
			sum = sum + (if v1 == 16 then 2 elseif v1 == 17 then 3 else 7)
		end
	end

	local count = 0

	for j = 1, #p1 do
		local v3 = p1[j]

		sum = sum + p6[v3]

		if v3 > 256 then
			count = count + 1

			if v3 > 264 and v3 < 285 then
				sum = sum + t15[v3 - 256]
			end

			local v4 = p2[count]

			sum = sum + p7[v4]

			if v4 > 3 then
				sum = sum + ((v4 - v4 % 2) / 2 - 1)
			end
		end
	end

	return sum
end

local function CompressDynamicHuffmanBlock(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17) --[[ CompressDynamicHuffmanBlock | Line: 1564 | Upvalues: t14 (copy), t15 (copy) ]]
	p1(if p2 then 1 else 0, 1)
	p1(2, 2)
	p1(p7, 5)
	p1(p8, 5)
	p1(p9, 4)

	for i = 1, p9 + 4 do
		p1(p10[t14[i]] or 0, 3)
	end

	local count = 1

	for j = 1, #p12 do
		local v2 = p12[j]

		p1(p11[v2], p10[v2])

		if v2 >= 16 then
			p1(p13[count], if v2 == 16 then 2 elseif v2 == 17 then 3 else 7)
			count = count + 1
		end
	end

	local count2 = 0
	local count3 = 0
	local count4 = 0

	for k = 1, #p3 do
		local v5 = p3[k]

		p1(p15[v5], p14[v5])

		if v5 > 256 then
			count2 = count2 + 1

			if v5 > 264 and v5 < 285 then
				count3 = count3 + 1
				p1(p4[count3], t15[v5 - 256])
			end

			local v6 = p5[count2]

			p1(p17[v6], p16[v6])

			if v6 > 3 then
				count4 = count4 + 1
				p1(p6[count4], (v6 - v6 % 2) / 2 - 1)
			end
		end
	end
end

local function GetFixedHuffmanBlockSize(p1, p2) --[[ GetFixedHuffmanBlockSize | Line: 1635 | Upvalues: t16 (ref), t15 (copy) ]]
	local sum = 3
	local count = 0

	for i = 1, #p1 do
		local v1 = p1[i]

		sum = sum + t16[v1]

		if v1 > 256 then
			count = count + 1

			if v1 > 264 and v1 < 285 then
				sum = sum + t15[v1 - 256]
			end

			local v2 = p2[count]

			sum = sum + 5

			if v2 > 3 then
				sum = sum + ((v2 - v2 % 2) / 2 - 1)
			end
		end
	end

	return sum
end

local function CompressFixedHuffmanBlock(p1, p2, p3, p4, p5, p6) --[[ CompressFixedHuffmanBlock | Line: 1664 | Upvalues: t17 (ref), t16 (ref), t15 (copy), t18 (ref) ]]
	p1(if p2 then 1 else 0, 1)
	p1(1, 2)

	local count = 0
	local count2 = 0
	local count3 = 0

	for i = 1, #p3 do
		local v2 = p3[i]

		p1(t17[v2], t16[v2])

		if v2 > 256 then
			count2 = count2 + 1

			if v2 > 264 and v2 < 285 then
				count3 = count3 + 1
				p1(p4[count3], t15[v2 - 256])
			end

			local v3 = p5[count2]

			p1(t18[v3], 5)

			if v3 > 3 then
				count = count + 1
				p1(p6[count], (v3 - v3 % 2) / 2 - 1)
			end
		end
	end
end

local function GetStoreBlockSize(p1, p2, p3) --[[ GetStoreBlockSize | Line: 1707 ]]
	assert(if p2 - p1 + 1 <= 65535 then true else false)

	return 3 + (8 - (p3 + 3) % 8) % 8 + 32 + (p2 - p1 + 1) * 8
end

local function CompressStoreBlock(p1, p2, p3, p4, p5, p6, p7) --[[ CompressStoreBlock | Line: 1721 | Upvalues: t2 (copy) ]]
	assert(if p6 - p5 + 1 <= 65535 then true else false)
	p1(if p3 then 1 else 0, 1)
	p1(0, 2)

	local v3 = (8 - (p7 + 3) % 8) % 8

	if v3 > 0 then
		p1(t2[v3] - 1, v3)
	end

	local v4 = p6 - p5 + 1

	p1(v4, 16)
	p1(255 - v4 % 256 + (255 - (v4 - v4 % 256) / 256) * 256, 16)
	p2(p4:sub(p5, p6))
end

local function Deflate(p1, p2, p3, p4, p5, p6) --[[ Deflate | Line: 1752 | Upvalues: LoadStringToTable (copy), GetBlockLZ77Result (copy), GetBlockDynamicHuffmanHeader (copy), GetDynamicHuffmanBlockSize (copy), GetFixedHuffmanBlockSize (copy), CompressStoreBlock (copy), CompressFixedHuffmanBlock (copy), CompressDynamicHuffmanBlock (copy) ]]
	local t = {}
	local tbl = {}
	local v1 = nil
	local v2 = 0
	local sum = 0
	local sum2, _ = p4(3)
	local v3 = #p5
	local v4 = nil
	local v5 = nil

	if p1 then
		if p1.level then
			v4 = p1.level
		end

		if p1.strategy then
			v5 = p1.strategy
		end
	end

	if not v4 then
		v4 = if v3 < 2048 then 7 elseif v3 > 65536 then 3 else 5
	end

	while not v1 do
		local v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27, v28, v29

		if v2 == 0 then
			v2 = 1
			v6 = 0
			sum = 65535
		else
			v2 = sum + 1
			v6 = v2 - 32768 - 1
			sum = sum + 32768
		end

		if v3 <= sum then
			v1 = true
			sum = v3
		else
			v1 = false
		end

		if v4 == 0 then
			v7 = {}
			v8 = nil
			v9 = {}
			v10 = {}
			v11 = nil
			v12 = {}
			v13 = {}
			v14 = {}
			v15 = {}
			v16 = nil
			v17 = {}
			v18 = {}
			v19 = {}
			v20 = {}
			v21 = {}
			v22 = nil
			v23 = nil
		else
			LoadStringToTable(p5, t, v2, sum + 3, v6)

			if v2 == 1 and p6 then
				local string_table = p6.string_table
				local strlen = p6.strlen

				for i = 0, if -strlen + 1 < -257 then -257 else -strlen + 1, -1 do
					t[i] = string_table[strlen + i]
				end
			end

			if v5 == "huffman_only" then
				v18 = {}
				LoadStringToTable(p5, v18, v2, sum, v2 - 1)
				v18[sum - v2 + 2] = 256
				v24 = {}
				v21 = {}

				for j = 1, sum - v2 + 2 do
					local v32 = v18[j]

					v24[v32] = (v24[v32] or 0) + 1
				end

				v25 = {}
				v19 = {}
				v20 = {}
			else
				local v33, v34, v35, v36, v37, v38 = GetBlockLZ77Result(v4, t, tbl, v2, sum, v6, p6)

				v25 = v38
				v18 = v33
				v19 = v36
				v20 = v37
				v21 = v34
				v24 = v35
			end

			local v39, v40, v41, v42, v43, v44, v45, v46, v47, v48, v49 = GetBlockDynamicHuffmanHeader(v24, v25)
			local v50 = GetDynamicHuffmanBlockSize(v18, v19, v41, v42, v44, v46, v48)

			v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v22, v23 = v48, GetFixedHuffmanBlockSize(v18, v19), v42, v49, v41, v43, v44, v45, v46, v50, v47, v39, v40
		end

		assert(if sum - v2 + 1 <= 65535 then true else false)

		local v53 = 3 + (8 - (sum2 + 3) % 8) % 8 + 32 + (sum - v2 + 1) * 8

		if v8 and v8 < v53 then
			v26 = v53
			v27 = v8
		else
			v26 = v53
			v27 = v53
		end

		v28 = if v16 and v16 < v27 then v16 else v27

		if v4 == 0 or v5 ~= "fixed" and (v5 ~= "dynamic" and v26 == v28) then
			CompressStoreBlock(p2, p3, v1, p5, v2, sum, sum2)
			sum2 = sum2 + v26
		else
			local v56 = v28

			if v5 == "dynamic" or v5 ~= "fixed" and v8 ~= v56 then
				if v5 == "dynamic" or v16 == v56 then
					CompressDynamicHuffmanBlock(p2, v1, v18, v21, v19, v20, v22, v23, v11, v9, v12, v13, v14, v15, v17, v7, v10)
					sum2 = sum2 + assert(v16)
				end
			else
				CompressFixedHuffmanBlock(p2, v1, v18, v21, v19, v20)
				sum2 = sum2 + assert(v8)
			end
		end

		v29 = if v1 then p4(3) else p4(0)
		assert(if v29 == sum2 then true else false)

		if not v1 then
			if p6 and v2 == 1 then
				local count = 0

				while t[count] do
					t[count] = nil
					count = count - 1
				end
			end

			local count = 1

			p6 = nil

			for k = sum - 32767, sum do
				t[count] = t[k - v6]
				count = count + 1
			end

			for k, v in pairs(tbl) do
				local v60 = #v

				if v60 > 0 and sum + 1 - v[1] > 32768 then
					if v60 == 1 then
						tbl[k] = nil

						continue
					end

					local count2 = 0
					local t2 = {}

					for n = 2, v60 do
						local v61 = v[n]

						if sum + 1 - v61 <= 32768 then
							count2 = count2 + 1
							t2[count2] = v61
						end
					end

					tbl[k] = t2
				end
			end

			continue
		end
	end
end

local function CompressDeflateInternal(p1, p2, p3) --[[ CompressDeflateInternal | Line: 1966 | Upvalues: CreateWriter (copy), Deflate (copy) ]]
	local v1, v2, v3 = CreateWriter()

	Deflate(p3, v1, v2, v3, p1, p2)

	local v4, v5 = v3(1)

	assert(v5)

	return v5, (8 - v4 % 8) % 8
end

local function CompressZlibInternal(p1, p2, p3) --[[ CompressZlibInternal | Line: 1977 | Upvalues: CreateWriter (copy), Deflate (copy), t13 (copy) ]]
	local v1, v2, v3 = CreateWriter()

	v1(120, 8)

	local v4 = if p2 then 1 else 0
	local v5 = 128 + v4 * 32

	v1(v5 + (31 - (30720 + v5) % 31), 8)

	if v4 == 1 then
		assert(p2)

		local adler32 = p2.adler32
		local v6 = adler32 % 256
		local v7 = (adler32 - v6) / 256
		local v8 = v7 % 256
		local v9 = (v7 - v8) / 256
		local v10 = v9 % 256

		v1((v9 - v10) / 256 % 256, 8)
		v1(v10, 8)
		v1(v8, 8)
		v1(v6, 8)
	end

	Deflate(p3, v1, v2, v3, p1, p2)
	v3(2)

	local v11 = t13:Adler32(p1)
	local v12 = v11 % 256
	local v13 = (v11 - v12) / 256
	local v14 = v13 % 256
	local v15 = (v13 - v14) / 256
	local v16 = v15 % 256

	v1((v15 - v16) / 256 % 256, 8)
	v1(v16, 8)
	v1(v14, 8)
	v1(v12, 8)

	local v17, v18 = v3(1)

	assert(v18)

	return v18, (8 - v17 % 8) % 8
end

function t13.CompressDeflate(p1, p2, p3) --[[ CompressDeflate | Line: 2048 | Upvalues: IsValidArguments (copy), CompressDeflateInternal (copy) ]]
	local v1, v2 = IsValidArguments(p2, false, nil, true, p3)

	if v1 then
		return CompressDeflateInternal(p2, nil, p3)
	end

	error("Usage: LibDeflate:CompressDeflate(str, configs): " .. v2, 2)
end
function t13.CompressDeflateWithDict(p1, p2, p3, p4) --[[ CompressDeflateWithDict | Line: 2072 | Upvalues: IsValidArguments (copy), CompressDeflateInternal (copy) ]]
	local v1, v2 = IsValidArguments(p2, true, p3, true, p4)

	if v1 then
		return CompressDeflateInternal(p2, p3, p4)
	end

	error("Usage: LibDeflate:CompressDeflateWithDict" .. "(str, dictionary, configs): " .. v2, 2)
end
function t13.CompressZlib(p1, p2, p3) --[[ CompressZlib | Line: 2092 | Upvalues: IsValidArguments (copy), CompressZlibInternal (copy) ]]
	local v1, v2 = IsValidArguments(p2, false, nil, true, p3)

	if v1 then
		return CompressZlibInternal(p2, nil, p3)
	end

	error("Usage: LibDeflate:CompressZlib(str, configs): " .. v2, 2)
end
function t13.CompressZlibWithDict(p1, p2, p3, p4) --[[ CompressZlibWithDict | Line: 2113 | Upvalues: IsValidArguments (copy), CompressZlibInternal (copy) ]]
	local v1, v2 = IsValidArguments(p2, true, p3, true, p4)

	if v1 then
		return CompressZlibInternal(p2, p3, p4)
	end

	error("Usage: LibDeflate:CompressZlibWithDict" .. "(str, dictionary, configs): " .. v2, 2)
end

local function CreateReader(p1) --[[ CreateReader | Line: 2142 | Upvalues: t2 (copy), byte (copy), char (copy), sub (copy), t3 (copy) ]]
	local v1 = #p1
	local v2 = 1
	local v3 = 0
	local v4 = 0

	return function(p12) --[[ ReadBits | Line: 2155 | Upvalues: t2 (ref), v3 (ref), v4 (ref), p1 (copy), v2 (ref), byte (ref) ]]
		local v1 = t2[p12]

		if p12 <= v3 then
			local v22 = v4 % v1

			v4 = (v4 - v22) / v1
			v3 = v3 - p12

			return v22
		end

		local v42, v5, v6, v7 = byte(p1, v2, v2 + 3)

		v4 = v4 + ((v42 or 0) + (v5 or 0) * 256 + (v6 or 0) * 65536 + (v7 or 0) * 16777216) * t2[v3]
		v2 = v2 + 4
		v3 = v3 + 32 - p12

		local v8 = v4 % v1

		v4 = (v4 - v8) / v1

		return v8
	end, function(p12, p2, p3) --[[ ReadBytes | Line: 2185 | Upvalues: v3 (ref), v4 (ref), char (ref), v1 (copy), v2 (ref), p1 (copy), sub (ref) ]]
		assert(if v3 % 8 == 0 then true else false)

		local v22 = v3 / 8 < p12 and v3 / 8 or p12

		for i = 1, v22 do
			local v32 = v4 % 256

			p3 = p3 + 1
			p2[p3] = char(v32)
			v4 = (v4 - v32) / 256
		end

		v3 = v3 - v22 * 8

		local v42 = p12 - v22

		if (v1 - v2 - v42 + 1) * 8 + v3 < 0 then
			return -1
		end

		for j = v2, v2 + v42 - 1 do
			p3 = p3 + 1
			p2[p3] = sub(p1, j, j)
		end

		v2 = v2 + v42

		return p3
	end, function(p12, p2, p3) --[[ Decode | Line: 2221 | Upvalues: v3 (ref), p1 (copy), t2 (ref), v2 (ref), byte (ref), v4 (ref), t3 (ref) ]]
		local v1, v22, sum

		if p3 > 0 then
			if v3 < 15 and p1 then
				local v42, v5, v6, v7 = byte(p1, v2, v2 + 3)

				v4 = v4 + ((v42 or 0) + (v5 or 0) * 256 + (v6 or 0) * 65536 + (v7 or 0) * 16777216) * t2[v3]
				v2 = v2 + 4
				v3 = v3 + 32
			end

			local v8 = t2[p3]

			v3 = v3 - p3

			local v9 = v4 % v8

			v4 = (v4 - v9) / v8

			local v10 = t3[p3][v9]
			local v11 = p12[p3]

			if v10 < v11 then
				return p2[v10]
			end

			v1 = v10 * 2
			v22 = v11 * 2
			sum = v11
		else
			v1 = 0
			v22 = 0
			sum = 0
		end

		for i = p3 + 1, 15 do
			local v12 = v4 % 2

			v4 = (v4 - v12) / 2
			v3 = v3 - 1

			local v13 = v12 == 1 and v1 + 1 - v1 % 2 or v1
			local v14 = p12[i] or 0
			local v15 = v13 - v22

			if v15 < v14 then
				return p2[sum + v15]
			end

			v1 = v13 * 2
			v22 = (v22 + v14) * 2
			sum = sum + v14
		end

		return -10
	end, function() --[[ ReaderBitlenLeft | Line: 2273 | Upvalues: v1 (copy), v2 (ref), v3 (ref) ]]
		return (v1 - v2 + 1) * 8 + v3
	end, function() --[[ SkipToByteBoundary | Line: 2277 | Upvalues: v3 (ref), t2 (ref), v4 (ref) ]]
		local v1 = v3 % 8
		local v2 = t2[v1]

		v3 = v3 - v1
		v4 = (v4 - v4 % v2) / v2
	end
end

local function CreateDecompressState(p1, p2) --[[ CreateDecompressState | Line: 2292 | Upvalues: CreateReader (copy) ]]
	local v1, v2, v3, v4, v5 = CreateReader(p1)

	return {
		buffer_size = 0,
		ReadBits = v1,
		ReadBytes = v2,
		Decode = v3,
		ReaderBitlenLeft = v4,
		SkipToByteBoundary = v5,
		buffer = {},
		result_buffer = {},
		dictionary = p2
	}
end

local function GetHuffmanForDecode(p1, p2, p3) --[[ GetHuffmanForDecode | Line: 2318 ]]
	local v1, v2 = p3, {}

	for i = 0, p2 do
		local v3
		local v4 = p1[i] or 0

		v3 = if v4 > 0 and v4 < v1 then v4 else v1
		v2[v4] = (v2[v4] or 0) + 1
		v1 = v3
	end

	if v2[0] == p2 + 1 then
		return 0, v2, {}, 0
	end

	local v5 = 1

	for j = 1, p3 do
		v5 = v5 * 2 - (v2[j] or 0)

		if v5 < 0 then
			return v5, {}, {}, 0
		end
	end

	local t = { 0 }

	for k = 1, p3 - 1 do
		t[k + 1] = t[k] + (v2[k] or 0)
	end

	local t2 = {}

	for n = 0, p2 do
		local v6 = p1[n] or 0

		if v6 ~= 0 then
			t2[t[v6]] = n
			t[v6] = t[v6] + 1
		end
	end

	return v5, v2, t2, v1
end

local function DecodeUntilEndOfBlock(p1, p2, p3, p4, p5, p6, p7) --[[ DecodeUntilEndOfBlock | Line: 2380 | Upvalues: t (copy), t19 (copy), t15 (copy), t20 (copy), t21 (copy), concat (copy) ]]
	local buffer = p1.buffer
	local buffer_size = p1.buffer_size
	local ReadBits = p1.ReadBits
	local Decode = p1.Decode
	local ReaderBitlenLeft = p1.ReaderBitlenLeft
	local result_buffer = p1.result_buffer
	local dictionary = p1.dictionary
	local v1, v2, v3

	if dictionary and not buffer[0] then
		v1 = dictionary.string_table
		v2 = dictionary.strlen
		v3 = -v2 + 1

		for i = 0, if -v2 + 1 < -257 then -257 else -v2 + 1, -1 do
			buffer[i] = t[v1[v2 + i]]
		end
	else
		v1 = {}
		v3 = 1
		v2 = nil
	end

	repeat
		local v6, v7
		local v8 = Decode(p2, p3, p4)

		if v8 < 0 or v8 > 285 then
			return -10
		end

		if v8 < 256 then
			buffer_size = buffer_size + 1
			buffer[buffer_size] = t[v8]
		elseif v8 > 256 then
			local v9 = v8 - 256
			local v10 = t19[v9]
			local v11 = v9 >= 8 and v10 + ReadBits(t15[v9]) or v10
			local v12 = Decode(p5, p6, p7)

			if v12 < 0 or v12 > 29 then
				return -10
			end

			local v13 = t20[v12]

			if v13 > 4 then
				v6 = v13 + ReadBits(t21[v12])

				if v6 then
					v8 = v12
					v7 = v11
				else
					v8 = v12
					v6 = v13
					v7 = v11
				end
			else
				v8 = v12
				v6 = v13
				v7 = v11
			end

			local count = buffer_size - v6 + 1

			if count < v3 then
				return -11
			end

			if count >= -257 then
				for j = 1, v7 do
					buffer_size = buffer_size + 1
					buffer[buffer_size] = buffer[count]
					count = count + 1
				end
			else
				local count2 = v2 + count

				for k = 1, v7 do
					buffer_size = buffer_size + 1
					buffer[buffer_size] = t[v1[count2]]
					count2 = count2 + 1
				end
			end
		end

		if ReaderBitlenLeft() < 0 then
			return 2
		end

		if buffer_size >= 65536 then
			result_buffer[#result_buffer + 1] = concat(buffer, "", 1, 32768)

			for n = 32769, buffer_size do
				buffer[n - 32768] = buffer[n]
			end

			buffer_size = buffer_size - 32768
			buffer[buffer_size + 1] = nil
		end
	until v8 == 256

	p1.buffer_size = buffer_size

	return 0
end

local function DecompressStoreBlock(p1) --[[ DecompressStoreBlock | Line: 2480 | Upvalues: concat (copy) ]]
	local buffer = p1.buffer
	local ReadBits = p1.ReadBits
	local ReaderBitlenLeft = p1.ReaderBitlenLeft
	local result_buffer = p1.result_buffer

	p1.SkipToByteBoundary()

	local v1 = ReadBits(16)

	if ReaderBitlenLeft() < 0 then
		return 2
	end

	local v2 = ReadBits(16)

	if ReaderBitlenLeft() < 0 then
		return 2
	end

	if v1 % 256 + v2 % 256 ~= 255 then
		return -2
	end

	if (v1 - v1 % 256) / 256 + (v2 - v2 % 256) / 256 ~= 255 then
		return -2
	end

	local v3 = p1.ReadBytes(v1, buffer, p1.buffer_size)

	if v3 < 0 then
		return 2
	end

	local v4

	if v3 >= 65536 then
		result_buffer[#result_buffer + 1] = concat(buffer, "", 1, 32768)

		for i = 32769, v3 do
			buffer[i - 32768] = buffer[i]
		end

		v4 = v3 - 32768
		buffer[v4 + 1] = nil
	else
		v4 = v3
	end

	p1.buffer_size = v4

	return 0
end

local function DecompressFixBlock(p1) --[[ DecompressFixBlock | Line: 2526 | Upvalues: DecodeUntilEndOfBlock (copy), t22 (ref), t10 (ref), t11 (ref), t12 (ref) ]]
	return DecodeUntilEndOfBlock(p1, t22, t10, 7, t11, t12, 5)
end

local function DecompressDynamicBlock(p1) --[[ DecompressDynamicBlock | Line: 2536 | Upvalues: t14 (copy), GetHuffmanForDecode (copy), DecodeUntilEndOfBlock (copy) ]]
	local ReadBits = p1.ReadBits
	local Decode = p1.Decode
	local v1 = ReadBits(5) + 257
	local v2 = ReadBits(5) + 1
	local v3 = ReadBits(4) + 4

	if v1 > 286 or v2 > 30 then
		return -3
	end

	local t = {}

	for i = 1, v3 do
		t[t14[i]] = ReadBits(3)
	end

	local v4, v5, v6, v7 = GetHuffmanForDecode(t, 18, 7)

	if v4 ~= 0 then
		return -4
	end

	local count = 0
	local t2 = {}
	local t3 = {}

	while count < v1 + v2 do
		local count2
		local v8 = Decode(v5, v6, v7)

		if v8 < 0 then
			return v8
		end

		if v8 < 16 then
			if count < v1 then
				t2[count] = v8
			else
				t3[count - v1] = v8
			end

			count = count + 1
		else
			local v9 = 0

			if v8 == 16 then
				if count == 0 then
					return -5
				end

				v9 = if count - 1 < v1 then t2[count - 1] else t3[count - v1 - 1]
				count2 = 3 + ReadBits(2)
			else
				count2 = if v8 == 17 then 3 + ReadBits(3) else 11 + ReadBits(7)
			end

			if v1 + v2 < count + count2 then
				return -6
			end

			while count2 > 0 do
				count2 = count2 - 1

				if count < v1 then
					t2[count] = v9
				else
					t3[count - v1] = v9
				end

				count = count + 1
			end

			continue
		end
	end

	if (t2[256] or 0) == 0 then
		return -9
	end

	local v10, v11, v12, v13 = GetHuffmanForDecode(t2, v1 - 1, 15)

	if v10 ~= 0 and (v10 < 0 or v1 ~= (v11[0] or 0) + (v11[1] or 0)) then
		return -7
	end

	local v14, v15, v16, v17 = GetHuffmanForDecode(t3, v2 - 1, 15)

	if v14 ~= 0 and (v14 < 0 or v2 ~= (v15[0] or 0) + (v15[1] or 0)) then
		return -8
	end

	return DecodeUntilEndOfBlock(p1, v11, v12, v13, v15, v16, v17)
end

local function Inflate(p1) --[[ Inflate | Line: 2650 | Upvalues: DecompressStoreBlock (copy), DecodeUntilEndOfBlock (copy), t22 (ref), t10 (ref), t11 (ref), t12 (ref), DecompressDynamicBlock (copy), concat (copy) ]]
	local ReadBits = p1.ReadBits
	local v1 = nil
	local v2

	repeat
		if v1 then
			p1.result_buffer[#p1.result_buffer + 1] = concat(p1.buffer, "", 1, p1.buffer_size)

			return concat(p1.result_buffer), 0
		end

		v1 = ReadBits(1) == 1

		local v3 = ReadBits(2)

		if v3 == 0 then
			v2 = DecompressStoreBlock(p1)

			continue
		end

		if v3 == 1 then
			v2 = DecodeUntilEndOfBlock(p1, t22, t10, 7, t11, t12, 5)

			continue
		end

		if v3 ~= 2 then
			return nil, -1
		end

		v2 = DecompressDynamicBlock(p1)
	until v2 ~= 0

	return nil, v2
end

local function DecompressDeflateInternal(p1, p2) --[[ DecompressDeflateInternal | Line: 2678 | Upvalues: CreateDecompressState (copy), Inflate (copy) ]]
	local v1 = CreateDecompressState(p1, p2)
	local v2, v3 = Inflate(v1)

	if v2 then
		local v4 = v1.ReaderBitlenLeft()

		return v2, (v4 - v4 % 8) / 8
	end

	return nil, v3
end

local function DecompressZlibInternal(p1, p2) --[[ DecompressZlibInternal | Line: 2690 | Upvalues: CreateDecompressState (copy), Inflate (copy), t13 (copy) ]]
	local v1 = CreateDecompressState(p1, p2)
	local ReadBits = v1.ReadBits
	local v2 = ReadBits(8)

	if v1.ReaderBitlenLeft() < 0 then
		return nil, 2
	end

	local v3 = v2 % 16

	if v3 ~= 8 then
		return nil, -12
	end

	if (v2 - v3) / 16 > 7 then
		return nil, -13
	end

	local v5 = ReadBits(8)

	if v1.ReaderBitlenLeft() < 0 then
		return nil, 2
	end

	if (v2 * 256 + v5) % 31 ~= 0 then
		return nil, -14
	end

	if (v5 - v5 % 32) / 32 % 2 == 1 then
		if not p2 then
			return nil, -16
		end

		local v6 = ReadBits(8) * 16777216 + ReadBits(8) * 65536 + ReadBits(8) * 256 + ReadBits(8)

		if v1.ReaderBitlenLeft() < 0 then
			return nil, 2
		end

		if not (v6 % 4294967296 == p2.adler32 % 4294967296) then
			return nil, -17
		end
	end

	local v8, v9 = Inflate(v1)

	if not v8 then
		return nil, v9
	end

	v1.SkipToByteBoundary()

	local v10 = ReadBits(8)
	local v11 = ReadBits(8)
	local v12 = ReadBits(8)
	local v13 = ReadBits(8)

	if v1.ReaderBitlenLeft() < 0 then
		return nil, 2
	end

	if (v10 * 16777216 + v11 * 65536 + v12 * 256 + v13) % 4294967296 == t13:Adler32(v8) % 4294967296 then
		local v15 = v1.ReaderBitlenLeft()

		return v8, (v15 - v15 % 8) / 8
	end

	return nil, -15
end

function t13.DecompressDeflate(p1, p2) --[[ DecompressDeflate | Line: 2772 | Upvalues: DecompressDeflateInternal (copy) ]]
	local v1, v2

	if type(p2) == "string" then
		v1 = true
		v2 = ""
	else
		v2 = ("\'str\' - string expected got \'%s\'."):format((type(p2)))
		v1 = false
	end

	if v1 then
		return DecompressDeflateInternal(p2)
	end

	error("Usage: LibDeflate:DecompressDeflate(str): " .. v2, 2)
end
function t13.DecompressDeflateWithDict(p1, p2, p3) --[[ DecompressDeflateWithDict | Line: 2798 | Upvalues: IsValidDictionary (copy), DecompressDeflateInternal (copy) ]]
	local v1, v2

	if type(p2) == "string" then
		local v3, v4 = IsValidDictionary(p3)

		if v3 then
			v1 = true
			v2 = ""
		else
			v1 = false
			v2 = v4
		end
	else
		v2 = ("\'str\' - string expected got \'%s\'."):format((type(p2)))
		v1 = false
	end

	if v1 then
		return DecompressDeflateInternal(p2, p3)
	end

	error("Usage: LibDeflate:DecompressDeflateWithDict(str, dictionary): " .. v2, 2)
end
function t13.DecompressZlib(p1, p2) --[[ DecompressZlib | Line: 2820 | Upvalues: DecompressZlibInternal (copy) ]]
	local v1, v2

	if type(p2) == "string" then
		v1 = true
		v2 = ""
	else
		v2 = ("\'str\' - string expected got \'%s\'."):format((type(p2)))
		v1 = false
	end

	if v1 then
		return DecompressZlibInternal(p2)
	end

	error("Usage: LibDeflate:DecompressZlib(str): " .. v2, 2)
end
function t13.DecompressZlibWithDict(p1, p2, p3) --[[ DecompressZlibWithDict | Line: 2846 | Upvalues: IsValidDictionary (copy), DecompressZlibInternal (copy) ]]
	local v1, v2

	if type(p2) == "string" then
		local v3, v4 = IsValidDictionary(p3)

		if v3 then
			v1 = true
			v2 = ""
		else
			v1 = false
			v2 = v4
		end
	else
		v2 = ("\'str\' - string expected got \'%s\'."):format((type(p2)))
		v1 = false
	end

	if v1 then
		return DecompressZlibInternal(p2, p3)
	end

	error("Usage: LibDeflate:DecompressZlibWithDict(str, dictionary): " .. v2, 2)
end

local t24 = {}

for i = 0, 143 do
	t24[i] = 8
end

for i = 144, 255 do
	t24[i] = 9
end

t24[256] = 7
t24[257] = 7
t24[258] = 7
t24[259] = 7
t24[260] = 7
t24[261] = 7
t24[262] = 7
t24[263] = 7
t24[264] = 7
t24[265] = 7
t24[266] = 7
t24[267] = 7
t24[268] = 7
t24[269] = 7
t24[270] = 7
t24[271] = 7
t24[272] = 7
t24[273] = 7
t24[274] = 7
t24[275] = 7
t24[276] = 7
t24[277] = 7
t24[278] = 7
t24[279] = 7
t24[280] = 8
t24[281] = 8
t24[282] = 8
t24[283] = 8
t24[284] = 8
t24[285] = 8
t24[286] = 8
t24[287] = 8

local t25 = {}

for i = 0, 31 do
	t25[i] = 5
end

local v12, v13, v14 = GetHuffmanForDecode(t24, 287, 9)

assert(if v12 == 0 then true else false)

local v17, v18, v19 = GetHuffmanForDecode(t25, 31, 5)

assert(if v17 == 0 then true else false)

local _3 = GetHuffmanCodeFromBitlen(v13, t24, 287, 9)
local _4 = GetHuffmanCodeFromBitlen(v18, t25, 31, 5)
local t26 = {
	["\0"] = "%z",
	["("] = "%(",
	[")"] = "%)",
	["."] = "%.",
	["%"] = "%%",
	["+"] = "%+",
	["-"] = "%-",
	["*"] = "%*",
	["?"] = "%?",
	["["] = "%[",
	["]"] = "%]",
	["^"] = "%^",
	["$"] = "%$"
}

local function escape_for_gsub(p1) --[[ escape_for_gsub | Line: 2907 | Upvalues: t26 (copy) ]]
	local v1, _ = p1:gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", t26)

	return v1
end

function t13.CreateCodec(p1, p2, p3, p4) --[[ CreateCodec | Line: 2952 | Upvalues: byte (copy), sub (copy), concat (copy), t26 (copy), t (copy), gsub (copy), find (copy) ]]
	if type(p2) ~= "string" or (type(p3) ~= "string" or type(p4) ~= "string") then
		error("Usage: LibDeflate:CreateCodec(reserved_chars, escape_chars, map_chars): All arguments must be string.", 2)
	end

	if p3 == "" then
		return nil, "No escape characters supplied."
	end

	if #p2 < #p4 then
		return nil, "The number of reserved characters must be at least as many as the number of mapped chars."
	end

	if p2 == "" then
		return nil, "No characters to encode."
	end

	local v1 = p2 .. p3 .. p4
	local t2 = {}

	for i = 1, #v1 do
		local v2 = byte(v1, i, i)

		if t2[v2] then
			return nil, "There must be no duplicate characters in the concatenation of reserved_chars, escape_chars and map_chars."
		end

		t2[v2] = true
	end

	local t3 = {}
	local t4 = {}
	local t5 = {}
	local t6 = {}

	if #p4 > 0 then
		local t7 = {}
		local t8 = {}

		for j = 1, #p4 do
			local v3 = sub(p2, j, j)
			local v4 = sub(p4, j, j)

			t6[v3] = v4
			t5[#t5 + 1] = v3
			t8[v4] = v3
			t7[#t7 + 1] = v4
		end

		local v5, _ = concat(t7):gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", t26)

		t3[#t3 + 1] = "([" .. v5 .. "])"
		t4[#t4 + 1] = t8
	end

	local count = 1
	local v6 = sub(p3, count, count)
	local count2 = 0
	local t7 = {}
	local t8 = {}

	for k = 1, #v1 do
		local v7 = sub(v1, k, k)

		if not t6[v7] then
			while count2 >= 256 or t2[count2] do
				count2 = count2 + 1

				if count2 > 255 then
					local v8, _ = v6:gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", t26)
					local v9, _2 = concat(t7):gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", t26)

					t3[#t3 + 1] = v8 .. "([" .. v9 .. "])"
					t4[#t4 + 1] = t8
					count = count + 1

					local v10 = sub(p3, count, count)

					if not v10 or v10 == "" then
						return nil, "Out of escape characters."
					end

					count2 = 0
					v6 = v10
					t7 = {}
					t8 = {}
				end
			end

			local v11 = t[count2]

			t6[v7] = v6 .. v11
			t5[#t5 + 1] = v7
			t8[v11] = v7
			t7[#t7 + 1] = v11
			count2 = count2 + 1
		end

		if k == #v1 then
			local v12, _ = v6:gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", t26)
			local v13, _2 = concat(t7):gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", t26)

			t3[#t3 + 1] = v12 .. "([" .. v13 .. "])"
			t4[#t4 + 1] = t8
		end
	end

	local t9 = {}
	local v14, _ = concat(t5):gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", t26)
	local v15 = "([" .. v14 .. "])"

	function t9.Encode(p1, p2) --[[ Encode | Line: 3065 | Upvalues: gsub (ref), v15 (copy), t6 (copy) ]]
		if type(p2) ~= "string" then
			error(("Usage: codec:Encode(str): \'str\' - string expected got \'%s\'."):format((type(p2))), 2)
		end

		local v1, _ = gsub(p2, v15, t6)

		return v1
	end

	local v16 = #t3
	local v17, _2 = p2:gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", t26)
	local v18 = "([" .. v17 .. "])"

	function t9.Decode(p1, p2) --[[ Decode | Line: 3078 | Upvalues: find (ref), v18 (copy), v16 (copy), gsub (ref), t3 (copy), t4 (copy) ]]
		if type(p2) ~= "string" then
			error(("Usage: codec:Decode(str): \'str\' - string expected got \'%s\'."):format((type(p2))), 2)
		end

		if find(p2, v18) then
			return nil
		end

		for i = 1, v16 do
			p2 = gsub(p2, t3[i], t4[i])
		end

		return p2
	end

	return t9, ""
end
t13.internals = {
	LoadStringToTable = LoadStringToTable,
	IsValidDictionary = IsValidDictionary,
	IsEqualAdler32 = IsEqualAdler32
}

return table.freeze(t13)