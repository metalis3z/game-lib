--credit to quartz games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.UserGenerated.Randoms.Base)

local GenerateSeed = require(ReplicatedStorage.UserGenerated.IO.Crypto.GenerateSeed)
local bxor = bit32.bxor
local bor = bit32.bor
local band = bit32.band
local lshift = bit32.lshift
local rshift = bit32.rshift
local floor = math.floor
local ldexp = math.ldexp
local sqrt = math.sqrt
local log = math.log
local max = math.max
local sin = math.sin
local cos = math.cos
local clamp = math.clamp
local create = table.create
local clone = table.clone
local format = string.format
local v1 = Vector2.new
local v2 = Vector3.new

assert(true)

local v3 = Random.new()

local function IsInteger(p1) --[[ IsInteger | Line: 45 | Upvalues: floor (copy) ]]
	return if type(p1) == "number" and (floor(p1) == p1 and p1 ~= (1 / 0)) then p1 ~= (-1 / 0) else false
end

local function AssertIntegerNonNegative(p1) --[[ AssertIntegerNonNegative | Line: 53 | Upvalues: floor (copy) ]]
	if not (if type(p1) == "number" and (floor(p1) == p1 and p1 ~= (1 / 0)) then if p1 == (-1 / 0) then false else true else false) then
		error("Integer", 2)
	end

	if p1 >= 0 then
		return
	end

	error("NonNegative", 2)
end

local function IsaacMix(p1) --[[ IsaacMix | Line: 77 | Upvalues: lshift (copy), bxor (copy), bor (copy), rshift (copy) ]]
	local v2 = p1[2]
	local v3 = p1[3]
	local v9 = bxor(p1[1], (lshift(v2, 11)))
	local v10 = bor(p1[4] + v9, 0)
	local v11 = bxor(bor(v2 + v3, 0), (rshift(v3, 2)))
	local v12 = bor(p1[5] + v11, 0)
	local v13 = bxor(bor(v3 + v10, 0), (lshift(v10, 8)))
	local v14 = bor(p1[6] + v13, 0)
	local v15 = bxor(bor(v10 + v12, 0), (rshift(v12, 16)))
	local v16 = bor(p1[7] + v15, 0)
	local v17 = bxor(bor(v12 + v14, 0), (lshift(v14, 10)))
	local v18 = bor(p1[8] + v17, 0)
	local v19 = bxor(bor(v14 + v16, 0), (rshift(v16, 4)))
	local v20 = bor(v9 + v19, 0)
	local v21 = bxor(bor(v16 + v18, 0), (lshift(v18, 8)))
	local v22 = bor(v11 + v21, 0)
	local v23 = bxor(bor(v18 + v20, 0), (rshift(v20, 9)))
	local v24 = bor(v13 + v23, 0)

	p1[1] = bor(v20 + v22, 0)
	p1[2] = v22
	p1[3] = v24
	p1[4] = v15
	p1[5] = v17
	p1[6] = v19
	p1[7] = v21
	p1[8] = v23
end

local function Isaac(p1) --[[ Isaac | Line: 92 | Upvalues: bor (copy), band (copy), rshift (copy), bxor (copy), lshift (copy) ]]
	local AA = p1.AA
	local MM = p1.MM
	local RSL = p1.RSL
	local v1 = bor(p1.CC + 1, 0)
	local v3, v4 = bor(p1.BB + v1, 0), v1

	for i = 1, 256 do
		local v5 = MM[i]
		local v6 = band(i, 3)

		if v6 == 0 then
			AA = bxor(AA, (rshift(AA, 16)))
		elseif v6 == 1 then
			AA = bxor(AA, (lshift(AA, 13)))
		elseif v6 == 2 then
			AA = bxor(AA, (rshift(AA, 6)))
		elseif v6 == 3 then
			AA = bxor(AA, (lshift(AA, 2)))
		end

		local v11 = bor(MM[band(i + 127, 255) + 1] + AA, 0)
		local v12 = bor(MM[band(rshift(v5, 2), 255) + 1] + v11 + v3, 0)

		MM[i] = v12

		local v13 = bor(MM[band(rshift(v12, 10), 255) + 1] + v5, 0)

		RSL[i] = v13
		AA, v3 = v11, v13
	end

	p1.AA = AA
	p1.BB = v3
	p1.CC = v4
end

local function IsaacInit(p1, p2) --[[ IsaacInit | Line: 115 | Upvalues: create (copy), IsaacMix (copy), bor (copy) ]]
	p1.AA = 0
	p1.BB = 0
	p1.CC = 0
	p1.Count = 256

	local MM = p1.MM
	local RSL = p1.RSL
	local v1 = create(8, 2654435769)

	IsaacMix(v1)
	IsaacMix(v1)
	IsaacMix(v1)
	IsaacMix(v1)

	for i = 0, 255, 8 do
		if p2 then
			for j = 1, 8 do
				v1[j] = bor(v1[j] + RSL[i + j], 0)
			end
		end

		IsaacMix(v1)
		MM[i + 1] = v1[1]
		MM[i + 2] = v1[2]
		MM[i + 3] = v1[3]
		MM[i + 4] = v1[4]
		MM[i + 5] = v1[5]
		MM[i + 6] = v1[6]
		MM[i + 7] = v1[7]
		MM[i + 8] = v1[8]
	end

	if not p2 then
		return
	end

	for k = 0, 255, 8 do
		for n = 1, 8 do
			v1[n] = bor(v1[n] + MM[k + n], 0)
		end

		IsaacMix(v1)
		MM[k + 1] = v1[1]
		MM[k + 2] = v1[2]
		MM[k + 3] = v1[3]
		MM[k + 4] = v1[4]
		MM[k + 5] = v1[5]
		MM[k + 6] = v1[6]
		MM[k + 7] = v1[7]
		MM[k + 8] = v1[8]
	end
end

local function NextU32(p1) --[[ NextU32 | Line: 152 | Upvalues: Isaac (copy) ]]
	local v1 = p1.Count + 1

	if v1 > 256 then
		Isaac(p1)
		v1 = 1
	end

	p1.Count = v1

	return p1.RSL[v1]
end

local function NextU64(p1) --[[ NextU64 | Line: 162 | Upvalues: Isaac (copy), ldexp (copy) ]]
	local v1 = p1.Count + 1

	if v1 > 256 then
		Isaac(p1)
		v1 = 1
	end

	p1.Count = v1

	local v2 = ldexp(p1.RSL[v1], 32)
	local v3 = p1.Count + 1

	if v3 > 256 then
		Isaac(p1)
		v3 = 1
	end

	p1.Count = v3

	return v2 + p1.RSL[v3]
end

local function NextFloat(p1) --[[ NextFloat | Line: 166 | Upvalues: Isaac (copy), ldexp (copy) ]]
	local v1 = p1.Count + 1

	if v1 > 256 then
		Isaac(p1)
		v1 = 1
	end

	p1.Count = v1

	return ldexp(p1.RSL[v1], -32)
end

local function NextDouble(p1) --[[ NextDouble | Line: 170 | Upvalues: Isaac (copy), ldexp (copy) ]]
	local v1 = p1.Count + 1

	if v1 > 256 then
		Isaac(p1)
		v1 = 1
	end

	p1.Count = v1

	local v2 = ldexp(p1.RSL[v1], 32)
	local v3 = p1.Count + 1

	if v3 > 256 then
		Isaac(p1)
		v3 = 1
	end

	p1.Count = v3

	return ldexp(v2 + p1.RSL[v3], -64)
end

local function NextNumber(p1, p2, p3) --[[ NextNumber | Line: 174 | Upvalues: Isaac (copy), ldexp (copy) ]]
	local v2 = p1.Count + 1

	if v2 > 256 then
		Isaac(p1)
		v2 = 1
	end

	p1.Count = v2

	local v3 = ldexp(p1.RSL[v2], 32)
	local v4 = p1.Count + 1

	if v4 > 256 then
		Isaac(p1)
		v4 = 1
	end

	p1.Count = v4

	return p2 + (p3 - p2) * ldexp(v3 + p1.RSL[v4], -64)
end

local function NextInteger(p1, p2, p3) --[[ NextInteger | Line: 178 | Upvalues: Isaac (copy), ldexp (copy), floor (copy) ]]
	local v2 = p1.Count + 1

	if v2 > 256 then
		Isaac(p1)
		v2 = 1
	end

	p1.Count = v2

	local v3 = ldexp(p1.RSL[v2], 32)
	local v4 = p1.Count + 1

	if v4 > 256 then
		Isaac(p1)
		v4 = 1
	end

	p1.Count = v4

	return floor(p2 + (p3 - p2 + 1) * ldexp(v3 + p1.RSL[v4], -64))
end

local function NextNormal(p1, p2, p3) --[[ NextNormal | Line: 182 | Upvalues: Isaac (copy), ldexp (copy), max (copy), log (copy), sqrt (copy), cos (copy), sin (copy) ]]
	local v2 = p1.Count + 1

	if v2 > 256 then
		Isaac(p1)
		v2 = 1
	end

	p1.Count = v2

	local v3 = ldexp(p1.RSL[v2], 32)
	local v4 = p1.Count + 1

	if v4 > 256 then
		Isaac(p1)
		v4 = 1
	end

	p1.Count = v4

	local v5 = sqrt(log((max(2.2250738585072014e-308, (ldexp(v3 + p1.RSL[v4], -64))))) * -2) * (p3 or 0)
	local v7 = p1.Count + 1

	if v7 > 256 then
		Isaac(p1)
		v7 = 1
	end

	p1.Count = v7

	local v8 = ldexp(p1.RSL[v7], 32)
	local v9 = p1.Count + 1

	if v9 > 256 then
		Isaac(p1)
		v9 = 1
	end

	p1.Count = v9

	local v10 = 6.283185307179586 * ldexp(v8 + p1.RSL[v9], -64)
	local v11 = p2 or 0

	return cos(v10) * v5 + v11, sin(v10) * v5 + v11
end

local function NextBoolean(p1, p2) --[[ NextBoolean | Line: 194 | Upvalues: Isaac (copy), ldexp (copy) ]]
	local v1 = p1.Count + 1

	if v1 > 256 then
		Isaac(p1)
		v1 = 1
	end

	p1.Count = v1

	local v2 = ldexp(p1.RSL[v1], 32)
	local v3 = p1.Count + 1

	if v3 > 256 then
		Isaac(p1)
		v3 = 1
	end

	p1.Count = v3

	return ldexp(v2 + p1.RSL[v3], -64) < (p2 or 0.5)
end

local function NextVector2(p1, p2) --[[ NextVector2 | Line: 198 | Upvalues: Isaac (copy), ldexp (copy), v1 (copy), cos (copy), sin (copy) ]]
	local v12 = p2 or 1
	local v3 = p1.Count + 1

	if v3 > 256 then
		Isaac(p1)
		v3 = 1
	end

	p1.Count = v3

	local v4 = ldexp(p1.RSL[v3], 32)
	local v5 = p1.Count + 1

	if v5 > 256 then
		Isaac(p1)
		v5 = 1
	end

	p1.Count = v5

	local v6 = 6.283185307179586 * ldexp(v4 + p1.RSL[v5], -64)

	return v1(cos(v6) * v12, sin(v6) * v12)
end

local function NextVector3(p1, p2) --[[ NextVector3 | Line: 207 | Upvalues: Isaac (copy), ldexp (copy), sqrt (copy), cos (copy), sin (copy), v2 (copy) ]]
	local v1 = p2 or 1
	local v3 = p1.Count + 1

	if v3 > 256 then
		Isaac(p1)
		v3 = 1
	end

	p1.Count = v3

	local v4 = ldexp(p1.RSL[v3], 32)
	local v5 = p1.Count + 1

	if v5 > 256 then
		Isaac(p1)
		v5 = 1
	end

	p1.Count = v5

	local v6 = 6.283185307179586 * ldexp(v4 + p1.RSL[v5], -64)
	local v7 = p1.Count + 1

	if v7 > 256 then
		Isaac(p1)
		v7 = 1
	end

	p1.Count = v7

	local v8 = ldexp(p1.RSL[v7], 32)
	local v9 = p1.Count + 1

	if v9 > 256 then
		Isaac(p1)
		v9 = 1
	end

	p1.Count = v9

	local v10 = ldexp(v8 + p1.RSL[v9], -64) * 2 - 1
	local v11 = sqrt(1 - v10 * v10)

	return v2(cos(v6) * v11 * v1, sin(v6) * v11 * v1, v10 * v1)
end

local function NextUUIDv4(p1) --[[ NextUUIDv4 | Line: 219 | Upvalues: format (copy), Isaac (copy), band (copy), bor (copy) ]]
	local v3 = p1.Count + 1

	if v3 > 256 then
		Isaac(p1)
		v3 = 1
	end

	p1.Count = v3

	local v4 = p1.RSL[v3]
	local v5 = p1.Count + 1

	if v5 > 256 then
		Isaac(p1)
		v5 = 1
	end

	p1.Count = v5

	local v6 = bor(band(p1.RSL[v5], 4294905855), 16384)
	local v7 = p1.Count + 1

	if v7 > 256 then
		Isaac(p1)
		v7 = 1
	end

	p1.Count = v7

	local v8 = bor(band(p1.RSL[v7], 1073741823), 2147483648)
	local v9 = p1.Count + 1

	if v9 > 256 then
		Isaac(p1)
		v9 = 1
	end

	p1.Count = v9

	return format("%08x%08x%08x%08x", v4, v6, v8, p1.RSL[v9])
end

local function Seed(p1, p2, p3) --[[ Seed | Line: 229 | Upvalues: v3 (copy), bor (copy), IsaacInit (copy) ]]
	local v1

	if p2 == nil then
		v1 = { v3:NextInteger(0, 4294967295) }
	elseif type(p2) == "number" then
		v1 = { p2 }
	else
		assert(type(p2) == "table")
		v1 = p2
	end

	local v32

	if p3 == nil then
		v32 = true
	else
		assert(type(p3) == "boolean")
		v32 = p3
	end

	local v5 = math.min(256, #v1)
	local MM = p1.MM
	local RSL = p1.RSL

	for i = 1, 256 do
		MM[i] = 0
		RSL[i] = 0
	end

	for j = 1, v5 do
		RSL[j] = bor(v1[j], 0)
	end

	IsaacInit(p1, v32)
end

local function Shuffle(p1, p2) --[[ Shuffle | Line: 260 | Upvalues: Isaac (copy), ldexp (copy), floor (copy) ]]
	assert(if type(p2) == "table" then true else false)

	for i = #p2, 2, -1 do
		local v3 = p1.Count + 1

		if v3 > 256 then
			Isaac(p1)
			v3 = 1
		end

		p1.Count = v3

		local v4 = ldexp(p1.RSL[v3], 32)
		local v5 = p1.Count + 1

		if v5 > 256 then
			Isaac(p1)
			v5 = 1
		end

		p1.Count = v5

		local v6 = floor((i - 1 + 1) * ldexp(v4 + p1.RSL[v5], -64) + 1)
		local v8 = p2[i]

		p2[i] = p2[v6]
		p2[v6] = v8
	end
end

local function Clone(p1) --[[ Clone | Line: 268 | Upvalues: clone (copy) ]]
	local t = {
		RSL = clone(p1.RSL),
		Count = p1.Count,
		MM = clone(p1.MM),
		AA = p1.AA,
		BB = p1.BB,
		CC = p1.CC
	}

	return setmetatable(t, (getmetatable(p1)))
end

local v5 = table.freeze({
	__index = table.freeze({
		NextU32 = NextU32,
		NextU64 = NextU64,
		NextFloat = NextFloat,
		NextDouble = NextDouble,
		NextNumber = NextNumber,
		NextInteger = NextInteger,
		NextNormal = NextNormal,
		NextBoolean = NextBoolean,
		NextVector2 = NextVector2,
		NextVector3 = NextVector3,
		NextUUIDv4 = NextUUIDv4,
		Seed = Seed,
		Shuffle = Shuffle,
		Clone = Clone
	})
})
local t = {
	new = function(p1, p2) --[[ new | Line: 300 | Upvalues: create (copy), Seed (copy), v5 (copy) ]]
		local t = {
			Count = 0,
			AA = 0,
			BB = 0,
			CC = 0,
			RSL = create(256, 0),
			MM = create(256, 0)
		}

		Seed(t, p1, p2)

		return setmetatable(t, v5)
	end
}

function t.Unique(p1) --[[ Unique | Line: 316 | Upvalues: floor (copy), clamp (copy), t (copy), GenerateSeed (copy) ]]
	if p1 ~= nil then
		if not (if type(p1) == "number" and (floor(p1) == p1 and p1 ~= (1 / 0)) then if p1 == (-1 / 0) then false else true else false) then
			error("Integer", 2)
		end

		if not (p1 >= 0) then
			error("NonNegative", 2)
		end
	end

	return t.new(GenerateSeed((clamp(p1 or 32, 0, 256))), true)
end
t.R = t.Unique()

return table.freeze(t)