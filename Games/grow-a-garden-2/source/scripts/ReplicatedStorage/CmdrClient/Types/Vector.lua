--credit to prince games studio
local Util = require(script.Parent.Parent.Shared.Util)

local function validateVector(p1, p2) --[[ validateVector | Line: 3 ]]
	if p1 == nil then
		return false, ("Invalid or missing number at position %d in Vector type."):format(p2)
	end

	return true
end

local v1 = Util.MakeSequenceType({
	Length = 3,
	ValidateEach = validateVector,
	TransformEach = tonumber,
	Constructor = Vector3.new
})
local v2 = Util.MakeSequenceType({
	Length = 2,
	ValidateEach = validateVector,
	TransformEach = tonumber,
	Constructor = Vector2.new
})

return function(p1) --[[ Line: 25 | Upvalues: v1 (copy), Util (copy), v2 (copy) ]]
	p1:RegisterType("vector3", v1)
	p1:RegisterType("vector3s", Util.MakeListableType(v1))
	p1:RegisterType("vector2", v2)
	p1:RegisterType("vector2s", Util.MakeListableType(v2))
end