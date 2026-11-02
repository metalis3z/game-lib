--credit to leon games studio
local function Mix(p1, p2, p3) --[[ Mix | Line: 20 ]]
	local v1 = bit32.bor(p1, 0)
	local v2 = bit32.bor(p2, 0)
	local v3 = bit32.bor(p3, 0)
	local v5 = bit32.bxor(v1 - v2 - v3, (bit32.rshift(v3, 13)))
	local v7 = bit32.bxor(v2 - v3 - v5, (bit32.lshift(v5, 8)))
	local v9 = bit32.bxor(v3 - v5 - v7, (bit32.rshift(v7, 13)))
	local v11 = bit32.bxor(v5 - v7 - v9, (bit32.rshift(v9, 12)))
	local v13 = bit32.bxor(v7 - v9 - v11, (bit32.lshift(v11, 16)))
	local v15 = bit32.bxor(v9 - v11 - v13, (bit32.rshift(v13, 5)))
	local v17 = bit32.bxor(v11 - v13 - v15, (bit32.rshift(v15, 3)))
	local v19 = bit32.bxor(v13 - v15 - v17, (bit32.lshift(v17, 10)))

	return bit32.bxor(v15 - v17 - v19, (bit32.rshift(v19, 15)))
end

local function Unpack64(p1) --[[ Unpack64 | Line: 34 ]]
	if p1 < 0 then
		local v1 = -1 - p1

		return bit32.bnot(v1 // 4294967296), bit32.bnot(v1)
	end

	return bit32.bor(p1 // 4294967296, 0), bit32.bor(p1, 0)
end

local function DoubleFromInt64(p1, p2) --[[ DoubleFromInt64 | Line: 44 | Upvalues: Mix (copy) ]]
	local v1, v2

	if p1 < 0 then
		local v3 = -1 - p1
		local v4 = bit32.bnot(v3 // 4294967296)

		v1, v2 = bit32.bnot(v3), v4
	else
		local v6 = bit32.bor(p1 // 4294967296, 0)

		v1 = bit32.bor(p1, 0)
		v2 = v6
	end

	return Mix(v1, v2, p2) / 4294967296
end

local function ParseUUID(p1) --[[ ParseUUID | Line: 53 ]]
	return tonumber(string.sub(p1, 1, 8), 16), tonumber(string.sub(p1, 10, 13) .. string.sub(p1, 15, 18), 16), tonumber(string.sub(p1, 20, 23) .. string.sub(p1, 25, 28), 16), tonumber(string.sub(p1, 29, 36), 16)
end

local function DoubleFromUUID(p1, p2) --[[ DoubleFromUUID | Line: 59 | Upvalues: Mix (copy) ]]
	local v2 = tonumber(string.sub(p1, 1, 8), 16)
	local v4 = tonumber(string.sub(p1, 10, 13) .. string.sub(p1, 15, 18), 16)
	local v6 = tonumber(string.sub(p1, 20, 23) .. string.sub(p1, 25, 28), 16)
	local v8 = tonumber(string.sub(p1, 29, 36), 16)

	return Mix(Mix(v2, v4, 2197175160), Mix(v6, v8, 2821953579), p2) / 4294967296
end

local function IntegerFromUUID(p1, p2, p3, p4) --[[ IntegerFromUUID | Line: 68 | Upvalues: Mix (copy) ]]
	local v2 = tonumber(string.sub(p1, 1, 8), 16)
	local v4 = tonumber(string.sub(p1, 10, 13) .. string.sub(p1, 15, 18), 16)
	local v6 = tonumber(string.sub(p1, 20, 23) .. string.sub(p1, 25, 28), 16)
	local v8 = tonumber(string.sub(p1, 29, 36), 16)

	return math.floor(p3 + (p4 - p3 + 1) * (Mix(Mix(v2, v4, 2197175160), Mix(v6, v8, 2821953579), p2) / 4294967296))
end

return table.freeze({
	Mix = Mix,
	DoubleFromInt64 = DoubleFromInt64,
	DoubleFromUUID = DoubleFromUUID,
	IntegerFromUUID = IntegerFromUUID
})