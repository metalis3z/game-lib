-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	_TYPE = "module",
	_NAME = "digest.crc32",
	_VERSION = "0.3.20111128"
}

local function requireany(...) --[[ requireany | Line: 128 ]]
	local t = {}

	for i, v in ipairs({ ... }) do
		if type(v) ~= "string" then
			return v, ""
		end

		local ok, result = pcall(require, v)

		if ok then
			return result, v
		end

		t[#t + 1] = result
	end

	error(table.concat(t, "\n"), 2)
end

local bxor = bit32.bxor
local bnot = bit32.bnot
local band = bit32.band
local rshift = bit32.rshift

local function memoize(p1) --[[ memoize | Line: 152 ]]
	local t = {}
	local v1 = setmetatable({}, t)

	function t.__index(p12, p2) --[[ __index | Line: 155 | Upvalues: p1 (copy), v1 (copy) ]]
		local v12 = p1(p2)

		v1[p2] = v12

		return v12
	end

	return v1
end

local v1 = memoize(function(p1) --[[ Line: 164 | Upvalues: band (copy), rshift (copy), bxor (copy) ]]
	local v1 = p1

	for i = 1, 8 do
		local v2 = band(v1, 1)
		local v3 = rshift(v1, 1)

		if v2 == 1 then
			v1 = bxor(v3, 3988292384)

			continue
		end

		v1 = v3
	end

	return v1
end)

function t.crc32_byte(p1, p2) --[[ crc32_byte | Line: 176 | Upvalues: bnot (copy), rshift (copy), v1 (copy), bxor (copy) ]]
	local v12 = bnot(p2 or 0)

	return bnot((bxor(rshift(v12, 8), v1[bxor(v12 % 256, p1)])))
end

local crc32_byte = t.crc32_byte

function t.crc32_string(p1, p2) --[[ crc32_string | Line: 184 | Upvalues: crc32_byte (copy) ]]
	local v1 = p2 or 0

	for i = 1, #p1 do
		v1 = crc32_byte(p1:byte(i), v1)
	end

	return v1
end

local crc32_string = t.crc32_string

function t.crc32(p1, p2) --[[ crc32 | Line: 193 | Upvalues: crc32_string (copy), crc32_byte (copy) ]]
	if type(p1) == "string" then
		return crc32_string(p1, p2)
	end

	return crc32_byte(p1, p2)
end

return t