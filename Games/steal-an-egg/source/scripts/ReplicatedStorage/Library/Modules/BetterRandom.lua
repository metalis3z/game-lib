-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local t = {}

t.__index = t
t.__class = "RandomWrapper"
function t.new(p1) --[[ new | Line: 24 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)

	v2:_init(p1)

	return v2
end
function t._init(p1, p2) --[[ _init | Line: 30 ]]
	if p2 == nil then
		p1._rng = Random.new()

		return
	end

	if type(p2) == "number" then
		p1._rng = Random.new(p2)

		return
	end

	if typeof(p2) == "Random" then
		p1._rng = p2
	else
		error((("Unknown seed type: %*"):format((typeof(p2)))))
	end
end
function t.handle(p1) --[[ handle | Line: 46 ]]
	return p1._rng
end
function t.clone(p1) --[[ clone | Line: 51 | Upvalues: t (copy) ]]
	return t.new(p1._rng:Clone())
end
function t.seed(p1, p2) --[[ seed | Line: 55 ]]
	p1._rng = Random.new(p2)
end
function t.number(p1, p2, p3) --[[ number | Line: 59 ]]
	if p2 == nil or p3 == nil then
		return p1._rng:NextNumber(0, 1)
	end

	return p1._rng:NextNumber(p2, p3)
end
function t.takeCutOffNumber(p1, p2, p3) --[[ takeCutOffNumber | Line: 67 | Upvalues: Asserts (copy) ]]
	Asserts.number(p2)
	Asserts.number(p3)

	local v1 = math.abs(p2) * p3

	return p1:number(p2 - v1, p2 + v1)
end
function t.boolean(p1, p2) --[[ boolean | Line: 78 ]]
	return p1._rng:NextNumber() < (p2 or 0.5)
end
function t.integer(p1, p2, p3) --[[ integer | Line: 82 ]]
	return p1._rng:NextInteger(p2, p3)
end
function t.integerArray(p1, p2) --[[ integerArray | Line: 86 | Upvalues: Asserts (copy) ]]
	Asserts.table(p2)
	Asserts.array.notEmpty(p2)

	if #p2 == 1 then
		return p2[1]
	end

	return p1._rng:NextInteger(unpack(p2))
end
function t.numberArray(p1, p2) --[[ numberArray | Line: 97 | Upvalues: Asserts (copy) ]]
	Asserts.table(p2)
	Asserts.array.notEmpty(p2)

	if #p2 == 1 then
		return p2[1]
	end

	return p1._rng:NextNumber(unpack(p2))
end
function t.normal(p1, p2, p3) --[[ normal | Line: 109 ]]
	local v3 = math.sqrt(math.log((math.max(2.2250738585072014e-308, p1._rng:NextNumber()))) * -2) * (p3 or 1)
	local v4 = p1._rng:NextNumber() * 6.283185307179586
	local v5 = p2 or 0

	return v3 * math.cos(v4) + v5, v3 * math.sin(v4) + v5
end
function t.Vector3(p1, p2) --[[ Vector3 | Line: 117 ]]
	return p1._rng:NextUnitVector() * (p2 or 1)
end
function t.Vector2(p1, p2) --[[ Vector2 | Line: 122 ]]
	local v1 = p1._rng:NextNumber() * 6.283185307179586

	return Vector2.new(math.cos(v1), (math.sin(v1))) * (p2 or 1)
end
function t.positiveYVector3(p1, p2) --[[ positiveYVector3 | Line: 127 ]]
	local v1 = p1:Vector3(p2)

	return Vector3.new(v1.X, math.max(0, v1.Y), v1.Z)
end
function t.flatVector3PositiveY(p1, p2) --[[ flatVector3PositiveY | Line: 132 ]]
	return Vector3.new(0, math.abs(p2 or 1), 0)
end

return t