-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script:WaitForChild("Types"))

local Geometry = require(script:WaitForChild("Geometry"))
local Mesh = require(script:WaitForChild("Mesh"))
local Algebra = require(script:WaitForChild("Algebra"))
local Noise = require(script:WaitForChild("Noise"))
local Pathfind = require(script:WaitForChild("Pathfind"))
local Physics = require(script:WaitForChild("Physics"))
local t = {
	abs = math.abs,
	acos = math.acos,
	asin = math.asin,
	atan = math.atan,
	atan2 = math.atan2,
	ceil = math.ceil,
	clamp = math.clamp,
	cos = math.cos,
	cosh = math.cosh,
	deg = math.deg,
	exp = math.exp,
	floor = math.floor,
	fmod = math.fmod,
	frexp = math.frexp,
	ldexp = math.ldexp,
	log = math.log,
	log10 = math.log10,
	max = math.max,
	min = math.min,
	modf = math.modf,
	noise = math.noise,
	pow = math.pow,
	rad = math.rad,
	random = math.random,
	randomseed = math.randomseed,
	sign = math.sign,
	sin = math.sin,
	sinh = math.sinh,
	sqrt = math.sqrt,
	tan = math.tan,
	tanh = math.tanh,
	huge = (1 / 0),
	pi = math.pi,
	Geometry = Geometry,
	Mesh = Mesh,
	Algebra = Algebra,
	Noise = Noise,
	Pathfind = Pathfind,
	Physics = Physics
}

local function v1(p1, p2) --[[ Line: 179 | Upvalues: v1 (ref) ]]
	local v12 = p2 or 1

	assert(if v12 == nil then false else true)

	if typeof(p1) == "number" then
		return math.round(p1 / v12) * v12
	end

	if typeof(p1) == "Vector2" then
		local v3 = v1(p1.X, v12)

		assert(typeof(v3) == "number")

		local v5 = v1(p1.Y, v12)

		assert(if typeof(v5) == "number" then true else false)

		return Vector2.new(v3, v5)
	end

	if typeof(p1) == "Vector3" then
		local v7 = v1(p1.X, v12)

		assert(typeof(v7) == "number")

		local v9 = v1(p1.X, v12)

		assert(if typeof(v9) == "number" then true else false)

		local v11 = v1(p1.Z, v12)

		assert(if typeof(v11) == "number" then true else false)

		return Vector3.new(v7, v9, v11)
	end

	if typeof(p1) == "Color3" then
		local v13 = v1(p1.R, v12)

		assert(typeof(v13) == "number")

		local v15 = v1(p1.G, v12)

		assert(if typeof(v15) == "number" then true else false)

		local v17 = v1(p1.B, v12)

		assert(if typeof(v17) == "number" then true else false)

		return Color3.new(v13, v15, v17)
	end

	if typeof(p1) ~= "CFrame" then
		error("Bad variable")
	end

	local v19 = v1(p1.Position, v12)

	assert(typeof(v19) == "Vector3")

	local v21 = v1(p1.XVector, v12)

	assert(if typeof(v21) == "Vector3" then true else false)

	local v23 = v1(p1.YVector, v12)

	assert(if typeof(v23) == "Vector3" then true else false)

	local v25 = v1(p1.ZVector, v12)

	assert(if typeof(v25) == "Vector3" then true else false)

	return CFrame.fromMatrix(v19, v21, v23, v25)
end

t.round = v1
t.__index = t

return t