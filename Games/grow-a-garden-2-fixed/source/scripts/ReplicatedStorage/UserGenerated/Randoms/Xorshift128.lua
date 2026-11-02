--credit to quartz games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.UserGenerated.Randoms.Base)

local GenerateSeed = require(ReplicatedStorage.UserGenerated.IO.Crypto.GenerateSeed)
local Theory = require(script.Theory)
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
local format = string.format
local v1 = Vector2.new
local v2 = Vector3.new

assert(true)

local v3 = Random.new()

local function Mul32(p1, p2) --[[ Mul32 | Line: 44 | Upvalues: rshift (copy), band (copy), lshift (copy) ]]
	local v1 = rshift(p1, 16)
	local v2 = band(p1, 65535)
	local v3 = rshift(p2, 16)
	local v4 = band(p2, 65535)

	return lshift(band(v1 * v4 + v2 * v3, 65535), 16) + v2 * v4
end

local function IsInteger(p1) --[[ IsInteger | Line: 55 | Upvalues: floor (copy) ]]
	return if type(p1) == "number" and (floor(p1) == p1 and p1 ~= (1 / 0)) then p1 ~= (-1 / 0) else false
end

local function AssertInteger(p1) --[[ AssertInteger | Line: 62 | Upvalues: floor (copy) ]]
	if if type(p1) == "number" and (floor(p1) == p1 and p1 ~= (1 / 0)) then p1 ~= (-1 / 0) else false then
		return
	end

	error("Integer", 2)
end

local function AssertIntegerNonNegative(p1) --[[ AssertIntegerNonNegative | Line: 67 | Upvalues: floor (copy) ]]
	if not (if type(p1) == "number" and (floor(p1) == p1 and p1 ~= (1 / 0)) then if p1 == (-1 / 0) then false else true else false) then
		error("Integer", 2)
	end

	if p1 >= 0 then
		return
	end

	error("NonNegative", 2)
end

local function NextU32(p1) --[[ NextU32 | Line: 88 | Upvalues: lshift (copy), bxor (copy), rshift (copy) ]]
	local x = p1.x
	local w = p1.w
	local v1 = bxor(x, (lshift(x, 11)))
	local v2 = bxor(bxor(bxor(v1, (rshift(v1, 8))), w), (rshift(w, 19)))
	local z = p1.z

	p1.x = p1.y
	p1.y = z
	p1.z = w
	p1.w = v2

	return v2
end

local function NextU64(p1) --[[ NextU64 | Line: 98 | Upvalues: lshift (copy), bxor (copy), rshift (copy), ldexp (copy) ]]
	local x = p1.x
	local w = p1.w
	local v1 = bxor(x, (lshift(x, 11)))
	local v2 = bxor(bxor(bxor(v1, (rshift(v1, 8))), w), (rshift(w, 19)))
	local z = p1.z

	p1.x = p1.y
	p1.y = z
	p1.z = w
	p1.w = v2

	local v3 = ldexp(v2, 32)
	local x2 = p1.x
	local w2 = p1.w
	local v4 = bxor(x2, (lshift(x2, 11)))
	local v5 = bxor(bxor(bxor(v4, (rshift(v4, 8))), w2), (rshift(w2, 19)))
	local z2 = p1.z

	p1.x = p1.y
	p1.y = z2
	p1.z = w2
	p1.w = v5

	return v3 + v5
end

local function NextFloat(p1) --[[ NextFloat | Line: 102 | Upvalues: lshift (copy), bxor (copy), rshift (copy), ldexp (copy) ]]
	local x = p1.x
	local w = p1.w
	local v1 = bxor(x, (lshift(x, 11)))
	local v2 = bxor(bxor(bxor(v1, (rshift(v1, 8))), w), (rshift(w, 19)))
	local z = p1.z

	p1.x = p1.y
	p1.y = z
	p1.z = w
	p1.w = v2

	return ldexp(v2, -32)
end

local function NextDouble(p1) --[[ NextDouble | Line: 106 | Upvalues: lshift (copy), bxor (copy), rshift (copy), ldexp (copy) ]]
	local x = p1.x
	local w = p1.w
	local v1 = bxor(x, (lshift(x, 11)))
	local v2 = bxor(bxor(bxor(v1, (rshift(v1, 8))), w), (rshift(w, 19)))
	local z = p1.z

	p1.x = p1.y
	p1.y = z
	p1.z = w
	p1.w = v2

	local v3 = ldexp(v2, 32)
	local x2 = p1.x
	local w2 = p1.w
	local v4 = bxor(x2, (lshift(x2, 11)))
	local v5 = bxor(bxor(bxor(v4, (rshift(v4, 8))), w2), (rshift(w2, 19)))
	local z2 = p1.z

	p1.x = p1.y
	p1.y = z2
	p1.z = w2
	p1.w = v5

	return ldexp(v3 + v5, -64)
end

local function NextNumber(p1, p2, p3) --[[ NextNumber | Line: 110 | Upvalues: lshift (copy), bxor (copy), rshift (copy), ldexp (copy) ]]
	local x = p1.x
	local w = p1.w
	local v1 = bxor(x, (lshift(x, 11)))
	local v2 = bxor(bxor(bxor(v1, (rshift(v1, 8))), w), (rshift(w, 19)))
	local z = p1.z

	p1.x = p1.y
	p1.y = z
	p1.z = w
	p1.w = v2

	local v3 = ldexp(v2, 32)
	local x2 = p1.x
	local w2 = p1.w
	local v4 = bxor(x2, (lshift(x2, 11)))
	local v5 = bxor(bxor(bxor(v4, (rshift(v4, 8))), w2), (rshift(w2, 19)))
	local z2 = p1.z

	p1.x = p1.y
	p1.y = z2
	p1.z = w2
	p1.w = v5

	return p2 + (p3 - p2) * ldexp(v3 + v5, -64)
end

local function NextInteger(p1, p2, p3) --[[ NextInteger | Line: 114 | Upvalues: lshift (copy), bxor (copy), rshift (copy), ldexp (copy), floor (copy) ]]
	local x = p1.x
	local w = p1.w
	local v1 = bxor(x, (lshift(x, 11)))
	local v2 = bxor(bxor(bxor(v1, (rshift(v1, 8))), w), (rshift(w, 19)))
	local z = p1.z

	p1.x = p1.y
	p1.y = z
	p1.z = w
	p1.w = v2

	local v3 = ldexp(v2, 32)
	local x2 = p1.x
	local w2 = p1.w
	local v4 = bxor(x2, (lshift(x2, 11)))
	local v5 = bxor(bxor(bxor(v4, (rshift(v4, 8))), w2), (rshift(w2, 19)))
	local z2 = p1.z

	p1.x = p1.y
	p1.y = z2
	p1.z = w2
	p1.w = v5

	return floor(p2 + (p3 - p2 + 1) * ldexp(v3 + v5, -64))
end

local function NextNormal(p1, p2, p3) --[[ NextNormal | Line: 118 | Upvalues: lshift (copy), bxor (copy), rshift (copy), ldexp (copy), max (copy), log (copy), sqrt (copy), cos (copy), sin (copy) ]]
	local x = p1.x
	local w = p1.w
	local v1 = bxor(x, (lshift(x, 11)))
	local v2 = bxor(bxor(bxor(v1, (rshift(v1, 8))), w), (rshift(w, 19)))
	local z = p1.z

	p1.x = p1.y
	p1.y = z
	p1.z = w
	p1.w = v2

	local v3 = ldexp(v2, 32)
	local x2 = p1.x
	local w2 = p1.w
	local v4 = bxor(x2, (lshift(x2, 11)))
	local v5 = bxor(bxor(bxor(v4, (rshift(v4, 8))), w2), (rshift(w2, 19)))
	local z2 = p1.z

	p1.x = p1.y
	p1.y = z2
	p1.z = w2
	p1.w = v5

	local v6 = sqrt(log((max(2.2250738585072014e-308, (ldexp(v3 + v5, -64))))) * -2) * (p3 or 0)
	local x3 = p1.x
	local w3 = p1.w
	local v7 = bxor(x3, (lshift(x3, 11)))
	local v8 = bxor(bxor(bxor(v7, (rshift(v7, 8))), w3), (rshift(w3, 19)))
	local z3 = p1.z

	p1.x = p1.y
	p1.y = z3
	p1.z = w3
	p1.w = v8

	local v9 = ldexp(v8, 32)
	local x4 = p1.x
	local w4 = p1.w
	local v10 = bxor(x4, (lshift(x4, 11)))
	local v11 = bxor(bxor(bxor(v10, (rshift(v10, 8))), w4), (rshift(w4, 19)))
	local z4 = p1.z

	p1.x = p1.y
	p1.y = z4
	p1.z = w4
	p1.w = v11

	local v12 = 6.283185307179586 * ldexp(v9 + v11, -64)
	local v13 = p2 or 0

	return cos(v12) * v6 + v13, sin(v12) * v6 + v13
end

local function NextBoolean(p1, p2) --[[ NextBoolean | Line: 130 | Upvalues: lshift (copy), bxor (copy), rshift (copy), ldexp (copy) ]]
	local x = p1.x
	local w = p1.w
	local v1 = bxor(x, (lshift(x, 11)))
	local v2 = bxor(bxor(bxor(v1, (rshift(v1, 8))), w), (rshift(w, 19)))
	local z = p1.z

	p1.x = p1.y
	p1.y = z
	p1.z = w
	p1.w = v2

	local v3 = ldexp(v2, 32)
	local x2 = p1.x
	local w2 = p1.w
	local v4 = bxor(x2, (lshift(x2, 11)))
	local v5 = bxor(bxor(bxor(v4, (rshift(v4, 8))), w2), (rshift(w2, 19)))
	local z2 = p1.z

	p1.x = p1.y
	p1.y = z2
	p1.z = w2
	p1.w = v5

	return ldexp(v3 + v5, -64) < (p2 or 0.5)
end

local function NextVector2(p1, p2) --[[ NextVector2 | Line: 134 | Upvalues: lshift (copy), bxor (copy), rshift (copy), ldexp (copy), v1 (copy), cos (copy), sin (copy) ]]
	local v12 = p2 or 1
	local x = p1.x
	local w = p1.w
	local v2 = bxor(x, (lshift(x, 11)))
	local v3 = bxor(bxor(bxor(v2, (rshift(v2, 8))), w), (rshift(w, 19)))
	local z = p1.z

	p1.x = p1.y
	p1.y = z
	p1.z = w
	p1.w = v3

	local v4 = ldexp(v3, 32)
	local x2 = p1.x
	local w2 = p1.w
	local v5 = bxor(x2, (lshift(x2, 11)))
	local v6 = bxor(bxor(bxor(v5, (rshift(v5, 8))), w2), (rshift(w2, 19)))
	local z2 = p1.z

	p1.x = p1.y
	p1.y = z2
	p1.z = w2
	p1.w = v6

	local v7 = 6.283185307179586 * ldexp(v4 + v6, -64)

	return v1(cos(v7) * v12, sin(v7) * v12)
end

local function NextVector3(p1, p2) --[[ NextVector3 | Line: 143 | Upvalues: lshift (copy), bxor (copy), rshift (copy), ldexp (copy), sqrt (copy), cos (copy), sin (copy), v2 (copy) ]]
	local v1 = p2 or 1
	local x = p1.x
	local w = p1.w
	local v22 = bxor(x, (lshift(x, 11)))
	local v3 = bxor(bxor(bxor(v22, (rshift(v22, 8))), w), (rshift(w, 19)))
	local z = p1.z

	p1.x = p1.y
	p1.y = z
	p1.z = w
	p1.w = v3

	local v4 = ldexp(v3, 32)
	local x2 = p1.x
	local w2 = p1.w
	local v5 = bxor(x2, (lshift(x2, 11)))
	local v6 = bxor(bxor(bxor(v5, (rshift(v5, 8))), w2), (rshift(w2, 19)))
	local z2 = p1.z

	p1.x = p1.y
	p1.y = z2
	p1.z = w2
	p1.w = v6

	local v7 = 6.283185307179586 * ldexp(v4 + v6, -64)
	local x3 = p1.x
	local w3 = p1.w
	local v8 = bxor(x3, (lshift(x3, 11)))
	local v9 = bxor(bxor(bxor(v8, (rshift(v8, 8))), w3), (rshift(w3, 19)))
	local z3 = p1.z

	p1.x = p1.y
	p1.y = z3
	p1.z = w3
	p1.w = v9

	local v10 = ldexp(v9, 32)
	local x4 = p1.x
	local w4 = p1.w
	local v11 = bxor(x4, (lshift(x4, 11)))
	local v12 = bxor(bxor(bxor(v11, (rshift(v11, 8))), w4), (rshift(w4, 19)))
	local z4 = p1.z

	p1.x = p1.y
	p1.y = z4
	p1.z = w4
	p1.w = v12

	local v13 = ldexp(v10 + v12, -64) * 2 - 1
	local v14 = sqrt(1 - v13 * v13)

	return v2(cos(v7) * v14 * v1, sin(v7) * v14 * v1, v13 * v1)
end

local function NextUUIDv4(p1) --[[ NextUUIDv4 | Line: 155 | Upvalues: format (copy), lshift (copy), bxor (copy), rshift (copy), band (copy), bor (copy) ]]
	local x = p1.x
	local w = p1.w
	local v2 = bxor(x, (lshift(x, 11)))
	local v3 = bxor(bxor(bxor(v2, (rshift(v2, 8))), w), (rshift(w, 19)))
	local z = p1.z

	p1.x = p1.y
	p1.y = z
	p1.z = w
	p1.w = v3

	local x2 = p1.x
	local w2 = p1.w
	local v4 = bxor(x2, (lshift(x2, 11)))
	local v5 = bxor(bxor(bxor(v4, (rshift(v4, 8))), w2), (rshift(w2, 19)))
	local z2 = p1.z

	p1.x = p1.y
	p1.y = z2
	p1.z = w2
	p1.w = v5

	local v6 = bor(band(v5, 4294905855), 16384)
	local x3 = p1.x
	local w3 = p1.w
	local v7 = bxor(x3, (lshift(x3, 11)))
	local v8 = bxor(bxor(bxor(v7, (rshift(v7, 8))), w3), (rshift(w3, 19)))
	local z3 = p1.z

	p1.x = p1.y
	p1.y = z3
	p1.z = w3
	p1.w = v8

	local v9 = bor(band(v8, 1073741823), 2147483648)
	local x4 = p1.x
	local w4 = p1.w
	local v10 = bxor(x4, (lshift(x4, 11)))
	local v11 = bxor(bxor(bxor(v10, (rshift(v10, 8))), w4), (rshift(w4, 19)))
	local z4 = p1.z

	p1.x = p1.y
	p1.y = z4
	p1.z = w4
	p1.w = v11

	return format("%08x%08x%08x%08x", v3, v6, v9, v11)
end

local function Seed(p1, p2) --[[ Seed | Line: 165 | Upvalues: v3 (copy), bor (copy), rshift (copy), band (copy), lshift (copy) ]]
	local v1 = if p2 == nil then {} elseif type(p2) == "number" then { p2 } else p2
	local v2 = v1[1]
	local v32 = v1[2]
	local v4 = v1[3]
	local v5 = v1[4]

	if not v2 then
		v2 = v3:NextInteger(0, 4294967295)
	end

	local v7 = bor(v2, 0)

	if not v32 then
		local v8 = rshift(v7, 16)
		local v9 = band(v7, 65535)

		v32 = lshift(band(v9 * 27655 + v8 * 35173, 65535), 16) + v9 * 35173 + 1
	end

	local v11 = bor(v32, 0)

	if not v4 then
		local v12 = rshift(v11, 16)
		local v13 = band(v11, 65535)

		v4 = lshift(band(v13 * 27655 + v12 * 35173, 65535), 16) + v13 * 35173 + 1
	end

	local v15 = bor(v4, 0)

	if not v5 then
		local v16 = rshift(v15, 16)
		local v17 = band(v15, 65535)

		v5 = lshift(band(v17 * 27655 + v16 * 35173, 65535), 16) + v17 * 35173 + 1
	end

	local v19 = bor(v5, 0)

	p1.x = v7
	p1.y = v11
	p1.z = v15
	p1.w = v19
end

local function Shuffle(p1, p2) --[[ Shuffle | Line: 196 | Upvalues: lshift (copy), bxor (copy), rshift (copy), ldexp (copy), floor (copy) ]]
	assert(if type(p2) == "table" then true else false)

	for i = #p2, 2, -1 do
		local x = p1.x
		local w = p1.w
		local v2 = bxor(x, (lshift(x, 11)))
		local v3 = bxor(bxor(bxor(v2, (rshift(v2, 8))), w), (rshift(w, 19)))
		local z = p1.z

		p1.x = p1.y
		p1.y = z
		p1.z = w
		p1.w = v3

		local v4 = ldexp(v3, 32)
		local x2 = p1.x
		local w2 = p1.w
		local v5 = bxor(x2, (lshift(x2, 11)))
		local v6 = bxor(bxor(bxor(v5, (rshift(v5, 8))), w2), (rshift(w2, 19)))
		local z2 = p1.z

		p1.x = p1.y
		p1.y = z2
		p1.z = w2
		p1.w = v6

		local v7 = floor((i - 1 + 1) * ldexp(v4 + v6, -64) + 1)
		local v9 = p2[i]

		p2[i] = p2[v7]
		p2[v7] = v9
	end
end

local function Clone(p1) --[[ Clone | Line: 204 ]]
	return setmetatable({
		x = p1.x,
		y = p1.y,
		z = p1.z,
		w = p1.w
	}, (getmetatable(p1)))
end

local function GetState(p1) --[[ GetState | Line: 214 ]]
	return {
		p1.x,
		p1.y,
		p1.z,
		p1.w
	}
end

local function Skip(p1, p2) --[[ Skip | Line: 218 | Upvalues: floor (copy), Theory (copy) ]]
	if if type(p2) == "number" and (floor(p2) == p2 and p2 ~= (1 / 0)) then if p2 == (-1 / 0) then false else true else false then
		local v2, v3, v4, v5

		v2, v3, v4, v5 = Theory.Transform(p1.x, p1.y, p1.z, p1.w, p2)
		p1.x = v2
		p1.y = v3
		p1.z = v4
		p1.w = v5

		return
	end

	error("Integer", 2)
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
		Clone = Clone,
		GetState = GetState,
		Skip = Skip
	})
})
local t = {
	new = function(p1) --[[ new | Line: 246 | Upvalues: Seed (copy), v5 (copy) ]]
		local t = {
			x = 0,
			y = 0,
			z = 0,
			w = 0
		}

		Seed(t, p1)

		return setmetatable(t, v5)
	end
}

function t.Unique(p1) --[[ Unique | Line: 257 | Upvalues: floor (copy), clamp (copy), t (copy), GenerateSeed (copy) ]]
	if p1 ~= nil then
		if not (if type(p1) == "number" and (floor(p1) == p1 and p1 ~= (1 / 0)) then if p1 == (-1 / 0) then false else true else false) then
			error("Integer", 2)
		end

		if not (p1 >= 0) then
			error("NonNegative", 2)
		end
	end

	return t.new(GenerateSeed((clamp(p1 or 4, 0, 4))))
end
t.R = t.Unique()

return table.freeze(t)