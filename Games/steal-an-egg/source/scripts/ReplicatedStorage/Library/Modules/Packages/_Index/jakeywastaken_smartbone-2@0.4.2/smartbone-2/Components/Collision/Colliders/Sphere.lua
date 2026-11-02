-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function SafeUnit(p1) --[[ SafeUnit | Line: 2 ]]
	if p1.Magnitude == 0 then
		return Vector3.new(0, 0, 0)
	end

	return p1.Unit
end

local function ClosestPointFunc(p1, p2, p3) --[[ ClosestPointFunc | Line: 10 ]]
	local v1 = p3 - p1
	local v2 = if v1.Magnitude == 0 then Vector3.new(0, 0, 0) else v1.Unit

	return if (p1 - p3).Magnitude <= p2 then true else false, p1 + v2 * p2, v2
end

return function(p1, p2, p3, p4) --[[ Line: 18 ]]
	local Position = p1.Position
	local v1 = math.min(p2.X, p2.Y, p2.Z) * 0.5
	local v2 = p3 - Position
	local v3 = if v2.Magnitude == 0 then Vector3.new(0, 0, 0) else v2.Unit
	local v4, v5

	if (Position - p3).Magnitude <= v1 then
		v4 = true
		v5 = Position
	else
		v4 = false
		v5 = Position
	end

	local v6 = v5 + v3 * v1

	if v4 then
		return v4, v6, v3
	end

	return (v6 - p3).Magnitude < p4, v6, v3
end