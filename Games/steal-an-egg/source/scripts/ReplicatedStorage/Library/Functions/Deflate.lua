-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	_TYPE = "module",
	_NAME = "compress.deflatelua",
	_VERSION = "0.3.20111128"
}
local sort = table.sort
local max = math.max
local char = string.char
local crc32 = require(script.crc32)

local function requireany(...) --[[ requireany | Line: 124 ]]
	local t = {}

	for i = 1, select("#", ...) do
		local v1 = select(i, ...)

		if type(v1) ~= "string" then
			return v1, ""
		end

		local ok, result = pcall(require, v1)

		if ok then
			return result, v1
		end

		t[#t + 1] = result
	end

	error(table.concat(t, "\n"), 2)
end

local v1 = bit32
local v2, v3, v4

if v1 then
	v2 = bit32.band
	v3 = bit32.lshift
	v4 = bit32.rshift
else
	v3 = nil
	v2 = nil
	v4 = nil
end

local function debug(...) --[[ debug | Line: 153 ]]
	print("DEBUG", ...)
end

local function runtime_error(p1, p2) --[[ runtime_error | Line: 157 ]]
	error({ p1 }, (p2 or 1) + 1)
end

local function make_outstate(p1) --[[ make_outstate | Line: 162 ]]
	return {
		outbs = p1,
		window = {},
		window_pos = 1
	}
end

local function output(p1, p2) --[[ output | Line: 170 ]]
	local window_pos = p1.window_pos

	p1.outbs(p2)
	p1.window[window_pos] = p2
	p1.window_pos = window_pos % 32768 + 1
end

local function noeof(p1) --[[ noeof | Line: 178 ]]
	return assert(p1, "unexpected end of file")
end

local function hasbit(p1, p2) --[[ hasbit | Line: 182 ]]
	return p2 <= p1 % (p2 + p2)
end

local function memoize(p1) --[[ memoize | Line: 186 ]]
	local t = {}
	local v1 = setmetatable({}, t)

	function t.__index(p12, p2) --[[ __index | Line: 189 | Upvalues: p1 (copy), v1 (copy) ]]
		local v12 = p1(p2)

		v1[p2] = v12

		return v12
	end

	return v1
end

local v5 = memoize(function(p1) --[[ Line: 198 ]]
	return 2 ^ p1
end)

local function bytestream_from_file(p1) --[[ bytestream_from_file | Line: 230 ]]
	return {
		read = function(p12) --[[ read | Line: 232 | Upvalues: p1 (copy) ]]
			local v1 = p1:read(1)

			if v1 then
				return v1:byte()
			end
		end
	}
end

local function bytestream_from_string(p1) --[[ bytestream_from_string | Line: 241 ]]
	local v1 = 1

	return {
		read = function(p13) --[[ read | Line: 244 | Upvalues: v1 (ref), p1 (copy) ]]
			local v12

			if v1 <= #p1 then
				local v2 = p1:byte(v1)

				v1 = v1 + 1
				v12 = v2
			else
				v12 = nil
			end

			return v12
		end
	}
end

local function bytestream_from_function(p1) --[[ bytestream_from_function | Line: 255 ]]
	local v1 = 0
	local v2 = ""

	return {
		read = function(p13) --[[ read | Line: 259 | Upvalues: v1 (ref), v2 (ref), p1 (copy) ]]
			v1 = v1 + 1

			if not (#v2 < v1) then
				return v2:byte(v1, v1)
			end

			v2 = p1()

			if not v2 then
				return
			end

			v1 = 1

			return v2:byte(v1, v1)
		end
	}
end

local function bitstream_from_bytestream(p1) --[[ bitstream_from_bytestream | Line: 273 | Upvalues: v1 (copy), v3 (ref), v2 (ref), v4 (ref), v5 (copy) ]]
	local v12 = 0
	local v22 = 0
	local t = {
		nbits_left_in_byte = function(p1) --[[ nbits_left_in_byte | Line: 278 | Upvalues: v22 (ref) ]]
			return v22
		end
	}

	if v1 then
		function t.read(p12, p2) --[[ read | Line: 283 | Upvalues: v22 (ref), p1 (copy), v12 (ref), v3 (ref), v2 (ref), v4 (ref) ]]
			local v1 = p2 or 1

			while v22 < v1 do
				local v23 = p1:read()

				if not v23 then
					return
				end

				v12 = v12 + v3(v23, v22)
				v22 = v22 + 8
			end

			local v32

			if v1 == 0 then
				v32 = 0
			elseif v1 == 32 then
				v32 = v12
				v12 = 0
			else
				local v42 = v2(v12, v4(4294967295, 32 - v1))

				v12 = v4(v12, v1)
				v32 = v42
			end

			v22 = v22 - v1

			return v32
		end
	else
		function t.read(p12, p2) --[[ read | Line: 307 | Upvalues: v22 (ref), p1 (copy), v12 (ref), v5 (ref) ]]
			local v1 = p2 or 1

			while v22 < v1 do
				local v2 = p1:read()

				if not v2 then
					return
				end

				v12 = v12 + v5[v22] * v2
				v22 = v22 + 8
			end

			local v3 = v5[v1]
			local v4 = v12 % v3

			v12 = (v12 - v4) / v3
			v22 = v22 - v1

			return v4
		end
	end

	is_bitstream[t] = true

	return t
end

local function get_bitstream(p1) --[[ get_bitstream | Line: 330 | Upvalues: bitstream_from_bytestream (copy) ]]
	local v1 = nil

	if is_bitstream[p1] then
		return p1
	end

	if type(p1) == "string" then
		local v3 = 1

		return bitstream_from_bytestream({
			read = function(p13) --[[ read | Line: 244 | Upvalues: v3 (ref), p1 (copy) ]]
				local v12

				if v3 <= #p1 then
					local v2 = p1:byte(v3)

					v3 = v3 + 1
					v12 = v2
				else
					v12 = nil
				end

				return v12
			end
		})
	end

	if type(p1) == "function" then
		local v5 = 0
		local v6 = ""

		return bitstream_from_bytestream({
			read = function(p13) --[[ read | Line: 259 | Upvalues: v5 (ref), v6 (ref), p1 (copy) ]]
				v5 = v5 + 1

				if not (#v6 < v5) then
					return v6:byte(v5, v5)
				end

				v6 = p1()

				if not v6 then
					return
				end

				v5 = 1

				return v6:byte(v5, v5)
			end
		})
	end

	error({ "unrecognized type" }, (nil or 1) + 1)
end

local function get_obytestream(p1) --[[ get_obytestream | Line: 344 ]]
	local v1 = nil

	if type(p1) == "function" then
		return p1
	end

	error({ "unrecognized type: " .. tostring(p1) }, (nil or 1) + 1)
end

local function HuffmanTable(p1, p2) --[[ HuffmanTable | Line: 354 | Upvalues: sort (copy), v5 (copy), v1 (copy), v3 (ref), v2 (ref), v4 (ref), memoize (copy) ]]
	local list = {}

	if p2 then
		for k, v in pairs(p1) do
			if v ~= 0 then
				list[#list + 1] = {
					val = k,
					nbits = v
				}
			end
		end
	else
		for i = 1, #p1 - 2, 2 do
			local v12 = p1[i]
			local v22 = p1[i + 1]
			local v32 = p1[i + 2]

			if v22 ~= 0 then
				for j = v12, v32 - 1 do
					list[#list + 1] = {
						val = j,
						nbits = v22
					}
				end
			end
		end
	end

	sort(list, function(p1, p2) --[[ Line: 374 ]]
		return if p1.nbits == p2.nbits and p1.val < p2.val then true else p1.nbits < p2.nbits
	end)

	local v42 = 0
	local count = 1

	for i, v in ipairs(list) do
		if v.nbits ~= v42 then
			count = count * v5[v.nbits - v42]
			v42 = v.nbits
		end

		v.code = count
		count = count + 1
	end

	local v52 = (1 / 0)
	local t = {}

	for i, v in ipairs(list) do
		v52 = math.min(v52, v.nbits)
		t[v.code] = v.val
	end

	local v6 = v1 and (function(p1, p2) --[[ Line: 405 | Upvalues: v3 (ref), v2 (ref), v4 (ref) ]]
		local v1 = 0

		for i = 1, p2 do
			v1 = v3(v1, 1) + v2(p1, 1)
			p1 = v4(p1, 1)
		end

		return v1
	end) or (function(p1, p2) --[[ Line: 413 ]]
		local v1 = 0

		for i = 1, p2 do
			local v2 = p1 % 2

			p1 = (p1 - v2) / 2
			v1 = v1 * 2 + v2
		end

		return v1
	end)
	local v7 = memoize(function(p1) --[[ Line: 423 | Upvalues: v5 (ref), v52 (ref), v6 (copy) ]]
		return v5[v52] + v6(p1, v52)
	end)

	function list.read(p1, p2) --[[ read | Line: 427 | Upvalues: v7 (copy), v52 (ref), t (copy) ]]
		local sum = 0
		local v1 = 1
		local v2

		repeat
			if sum == 0 then
				v1 = v7[assert(p2:read(v52), "unexpected end of file")]
				sum = sum + v52
			else
				v1 = v1 * 2 + assert(p2:read(), "unexpected end of file")
				sum = sum + 1
			end

			v2 = t[v1]
		until v2

		return v2
	end

	return list
end

local function parse_gzip_header(p1) --[[ parse_gzip_header | Line: 454 ]]
	if p1:read(8) ~= 31 or p1:read(8) ~= 139 then
		error({ "not in gzip format" }, (nil or 1) + 1)
	end

	p1:read(8)

	local v1 = p1:read(8)

	p1:read(32)
	p1:read(8)

	if not p1:read(8) then
		error({ "invalid header" }, (nil or 1) + 1)
	end

	if if v1 % 8 >= 4 then true else false then
		local v3 = 0

		for i = 1, p1:read(16) do
			v3 = p1:read(8)
		end

		if not v3 then
			error({ "invalid header" }, (nil or 1) + 1)
		end
	end

	local function parse_zstring(p1) --[[ parse_zstring | Line: 496 ]]
		repeat
			if p1:read(8) then
				continue
			end

			error({ "invalid header" }, (nil or 1) + 1)
		until v1 == 0
	end

	if if v1 % 16 >= 8 then true else false then
		parse_zstring(p1)
	end

	if if v1 % 32 >= 16 then true else false then
		parse_zstring(p1)
	end

	if not (if v1 % 4 >= 2 then true else false) or p1:read(16) then
		return
	end

	error({ "invalid header" }, (nil or 1) + 1)
end

local function parse_zlib_header(p1) --[[ parse_zlib_header | Line: 526 ]]
	local v1 = p1:read(4)
	local v2 = p1:read(4)
	local v3 = p1:read(5)
	local v4 = p1:read(1)
	local v6 = v3 + v4 * 32 + p1:read(2) * 64

	if v1 ~= 8 then
		error({ "unrecognized zlib compression method: " .. v1 }, (nil or 1) + 1)
	end

	if v2 > 7 then
		error({ "invalid zlib window size: cinfo=" .. v2 }, (nil or 1) + 1)
	end

	local v7 = 2 ^ (v2 + 8)

	if ((v2 * 16 + v1) * 256 + v6) % 31 ~= 0 then
		error({ "invalid zlib header (bad fcheck sum)" }, (nil or 1) + 1)
	end

	if v4 ~= 1 then
		return v7
	end

	error({ "FIX:TODO - FDICT not currently implemented" }, (nil or 1) + 1)
end

local function parse_huffmantables(p1) --[[ parse_huffmantables | Line: 555 | Upvalues: HuffmanTable (copy) ]]
	local v1 = p1:read(5)
	local v2 = p1:read(5)
	local t = {
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
	local t2 = {}

	for i = 1, assert(p1:read(4), "unexpected end of file") + 4 do
		t2[t[i]] = p1:read(3)
	end

	local v5 = HuffmanTable(t2, true)

	local function decode(p12) --[[ decode | Line: 590 | Upvalues: v5 (copy), p1 (copy), HuffmanTable (ref) ]]
		local count = 0
		local t = {}
		local v1 = nil

		while count < p12 do
			local v2 = v5:read(p1)
			local v3 = nil

			if v2 <= 15 then
				v3 = 1
				v1 = v2
			elseif v2 == 16 then
				v3 = 3 + assert(p1:read(2), "unexpected end of file")
			elseif v2 == 17 then
				v3 = 3 + assert(p1:read(3), "unexpected end of file")
				v1 = 0
			elseif v2 == 18 then
				v3 = 11 + assert(p1:read(7), "unexpected end of file")
				v1 = 0
			else
				error("ASSERT")
			end

			for i = 1, v3 do
				t[count] = v1
				count = count + 1
			end
		end

		return HuffmanTable(t, true)
	end

	return decode(v1 + 257), decode(v2 + 1)
end

local v6 = nil
local v7 = nil
local v8 = nil
local v9 = nil

local function parse_compressed_item(p1, p2, p3, p4) --[[ parse_compressed_item | Line: 636 | Upvalues: v6 (ref), v7 (ref), v1 (copy), max (copy), v4 (ref), v8 (ref), v9 (ref) ]]
	local v12 = p3:read(p1)

	if v12 < 256 then
		local window_pos = p2.window_pos

		p2.outbs(v12)
		p2.window[window_pos] = v12
		p2.window_pos = window_pos % 32768 + 1
	else
		if v12 == 256 then
			return true
		end

		if not v6 then
			local t = {
				[257] = 3
			}
			local v2 = 1

			for i = 258, 285, 4 do
				for j = i, i + 3 do
					t[j] = t[j - 1] + v2
				end

				if i ~= 258 then
					v2 = v2 * 2
				end
			end

			t[285] = 258
			v6 = t
		end

		if not v7 then
			local t = {}

			if v1 then
				for k = 257, 285 do
					t[k] = v4(max(k - 261, 0), 2)
				end
			else
				for n = 257, 285 do
					local v3 = max(n - 261, 0)

					t[n] = (v3 - v3 % 4) / 4
				end
			end

			t[285] = 0
			v7 = t
		end

		local v42 = v6[v12] + p1:read(v7[v12])

		if not v8 then
			local t = {
				[0] = 1
			}
			local v5 = 1

			for m = 1, 29, 2 do
				for i = m, m + 1 do
					t[i] = t[i - 1] + v5
				end

				if m ~= 1 then
					v5 = v5 * 2
				end
			end

			v8 = t
		end

		if not v9 then
			local t = {}

			if v1 then
				for i = 0, 29 do
					t[i] = v4(max(i - 2, 0), 1)
				end
			else
				for i = 0, 29 do
					local v62 = max(i - 2, 0)

					t[i] = (v62 - v62 % 2) / 2
				end
			end

			v9 = t
		end

		local v72 = p4:read(p1)
		local v82 = v8[v72] + p1:read(v9[v72])

		for i = 1, v42 do
			local v11 = assert(p2.window[(p2.window_pos - 1 - v82) % 32768 + 1], "invalid distance")
			local window_pos = p2.window_pos

			p2.outbs(v11)
			p2.window[window_pos] = v11
			p2.window_pos = window_pos % 32768 + 1
		end
	end

	return false
end

local function parse_block(p1, p2) --[[ parse_block | Line: 726 | Upvalues: parse_huffmantables (copy), HuffmanTable (copy), parse_compressed_item (copy) ]]
	local v1 = p1:read(1)
	local v2 = p1:read(2)

	if v2 == 0 then
		p1:read(p1:nbits_left_in_byte())

		local v3 = p1:read(16)

		assert(p1:read(16), "unexpected end of file")

		for i = 1, v3 do
			local v6 = assert(p1:read(8), "unexpected end of file")
			local window_pos = p2.window_pos

			p2.outbs(v6)
			p2.window[window_pos] = v6
			p2.window_pos = window_pos % 32768 + 1
		end
	elseif v2 == 1 or v2 == 2 then
		local v7, v8

		if v2 == 2 then
			local v9, v10 = parse_huffmantables(p1)

			v7 = v9
			v8 = v10
		else
			local v11 = HuffmanTable({
				0,
				8,
				144,
				9,
				256,
				7,
				280,
				8,
				288,
				nil
			})

			v7, v8 = v11, HuffmanTable({ 0, 5, 32, nil })
		end

		repeat

		until parse_compressed_item(p1, p2, v7, v8)
	else
		error({ "unrecognized compression type" }, (nil or 1) + 1)
	end

	return v1 ~= 0
end

function t.inflate(p1) --[[ inflate | Line: 768 | Upvalues: get_bitstream (copy), parse_block (copy) ]]
	local v1 = get_bitstream(p1.input)
	local output = p1.output
	local v2 = nil

	if type(output) == "function" then
		v2 = output
	else
		error({ "unrecognized type: " .. tostring(output) }, (nil or 1) + 1)
	end

	repeat

	until parse_block(v1, {
		outbs = v2,
		window = {},
		window_pos = 1
	})
end

local inflate = t.inflate

function t.gunzip(p1) --[[ gunzip | Line: 779 | Upvalues: get_bitstream (copy), parse_gzip_header (copy), inflate (copy), crc32 (copy) ]]
	local v1 = get_bitstream(p1.input)
	local output = p1.output
	local v2 = nil

	if type(output) == "function" then
		v2 = output
	else
		error({ "unrecognized type: " .. tostring(output) }, (nil or 1) + 1)
	end

	local v3 = v2
	local disable_crc = p1.disable_crc

	if disable_crc == nil then
		disable_crc = false
	end

	parse_gzip_header(v1)

	local v4 = 0
	local t = {
		input = v1
	}

	t.output = if disable_crc and v3 then v3 else function(p1) --[[ Line: 793 | Upvalues: v4 (ref), crc32 (ref), v3 (copy) ]]
	v4 = crc32(p1, v4)
	v3(p1)
end
	inflate(t)
	v1:read(v1:nbits_left_in_byte())

	local v7 = v1:read(32)

	v1:read(32)

	if not disable_crc and (v4 and v4 ~= v7) then
		error({ "invalid compressed data--crc error" }, (nil or 1) + 1)
	end

	if v1:read() then
		warn("trailing garbage ignored")
	end
end
function t.adler32(p1, p2) --[[ adler32 | Line: 817 ]]
	local v1 = p2 % 65536
	local v3 = (v1 + p1) % 65521

	return ((p2 - v1) / 65536 + v3) % 65521 * 65536 + v3
end
function t.inflate_zlib(p1) --[[ inflate_zlib | Line: 825 | Upvalues: get_bitstream (copy), parse_zlib_header (copy), inflate (copy), t (copy) ]]
	local v1 = get_bitstream(p1.input)
	local output = p1.output
	local v2 = nil

	if type(output) == "function" then
		v2 = output
	else
		error({ "unrecognized type: " .. tostring(output) }, (nil or 1) + 1)
	end

	local v3 = v2
	local disable_crc = p1.disable_crc

	if disable_crc == nil then
		disable_crc = false
	end

	parse_zlib_header(v1)

	local v4 = 1
	local t2 = {
		input = v1
	}

	t2.output = if disable_crc and v3 then v3 else function(p1) --[[ Line: 839 | Upvalues: v4 (ref), t (ref), v3 (copy) ]]
	v4 = t.adler32(p1, v4)
	v3(p1)
end
	inflate(t2)
	v1:read(v1:nbits_left_in_byte())

	if not disable_crc and v4 ~= ((v1:read(8) * 256 + v1:read(8)) * 256 + v1:read(8)) * 256 + v1:read(8) then
		error({ "invalid compressed data--crc error" }, (nil or 1) + 1)
	end

	if v1:read() then
		warn("trailing garbage ignored")
	end
end

return t