local t = {}
local v1 = Random.new()

function t.RandomInPart(p1) --[[ RandomInPart | Line: 4 | Upvalues: v1 (copy) ]]
	local X = p1.Size.X
	local Y = p1.Size.Y
	local Z = p1.Size.Z

	return p1.CFrame * Vector3.new(v1:NextNumber(-X / 2, X / 2), v1:NextNumber(-Y / 2, Y / 2), v1:NextNumber(-Z / 2, Z / 2))
end
function t.CheckPointInArea(p1, p2, p3) --[[ CheckPointInArea | Line: 11 ]]
	local v1 = p1 - p2
	local v2 = math.abs(v1.X)
	local v3 = math.abs(v1.Y)

	return if v2 < p3.X / 2 and v3 < p3.Y / 2 then math.abs(v1.Z) < p3.Z / 2 else false
end

return t