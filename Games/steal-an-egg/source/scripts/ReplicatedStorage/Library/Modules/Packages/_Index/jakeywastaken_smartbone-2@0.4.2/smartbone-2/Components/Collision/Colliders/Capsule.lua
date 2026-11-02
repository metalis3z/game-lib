-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function SafeUnit(p1) --[[ SafeUnit | Line: 2 ]]
	if p1.Magnitude == 0 then
		return Vector3.new(0, 0, 0)
	end

	return p1.Unit
end

local function solve(p1, p2, p3, p4) --[[ solve | Line: 10 ]]
	return p1 + p2 * math.clamp((p4 - p1):Dot(p2), -p3, p3)
end

local function ClosestPointFunc(p1, p2, p3, p4) --[[ ClosestPointFunc | Line: 17 ]]
	local Position = p1.Position
	local UpVector = p1.UpVector
	local v1 = p2 * 0.5
	local v3 = Position + UpVector * math.clamp((p4 - Position):Dot(UpVector), -v1, v1)
	local v4 = p4 - v3
	local v5 = if v4.Magnitude == 0 then Vector3.new(0, 0, 0) else v4.Unit

	return if (v3 - p4).Magnitude <= p3 then true else false, v3 + v5 * p3, v5
end

return function(p1, p2, p3, p4) --[[ Line: 27 ]]
	local v2 = (p2.Y < p2.Z and p2.Y or p2.Z) * 0.5
	local v3 = p1 * CFrame.Angles(1.5707963267948966, -1.5707963267948966, 0)
	local Position = v3.Position
	local UpVector = v3.UpVector
	local v4 = p2.X * 0.5
	local v6 = Position + UpVector * math.clamp((p3 - Position):Dot(UpVector), -v4, v4)
	local v7 = p3 - v6
	local v8 = if v7.Magnitude == 0 then Vector3.new(0, 0, 0) else v7.Unit
	local v9 = if (v6 - p3).Magnitude <= v2 then true else false
	local v10 = v6 + v8 * v2

	if v9 then
		return v9, v10, v8
	end

	return (v10 - p3).Magnitude < p4, v10, v8
end