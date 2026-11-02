-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function SafeUnit(p1) --[[ SafeUnit | Line: 2 ]]
	if p1.Magnitude == 0 then
		return Vector3.new(0, 0, 0)
	end

	return p1.Unit
end

local function solve(p1, p2, p3, p4) --[[ solve | Line: 10 ]]
	local v2 = math.clamp((p4 - p1):Dot(p2), -p3, p3)

	return p1 + p2 * v2, v2
end

local function ProjectOnPlane(p1, p2, p3) --[[ ProjectOnPlane | Line: 17 ]]
	return p3 - (p3 - p1):Dot(p2) * p2
end

local function ClosestPointFunc(p1, p2, p3) --[[ ClosestPointFunc | Line: 25 ]]
	local v2 = (p2.Y < p2.Z and p2.Y or p2.Z) * 0.5
	local v3 = p2.X * 0.5
	local Position = p1.Position
	local RightVector = p1.RightVector
	local v5 = math.clamp((p3 - Position):Dot(RightVector), -v3, v3)
	local v6 = Position + RightVector * v5
	local v7 = p1.Position + -p1.RightVector * v3
	local v8 = p1.Position + p1.RightVector * v3
	local v9 = -p1.RightVector
	local RightVector2 = p1.RightVector
	local v10 = p3 - (p3 - v7):Dot(v9) * v9
	local v11 = p3 - (p3 - v8):Dot(RightVector2) * RightVector2

	local function GetFinalProj(p1, p2) --[[ GetFinalProj | Line: 39 | Upvalues: v2 (copy) ]]
		local v1 = p1 - p2
		local v22 = if v1.Magnitude == 0 then Vector3.new(0, 0, 0) else v1.Unit
		local Magnitude = (p1 - p2).Magnitude

		return p2 + v22 * (if Magnitude < v2 then Magnitude else v2)
	end

	local v12 = v10 - v7
	local v13 = if v12.Magnitude == 0 then Vector3.new(0, 0, 0) else v12.Unit
	local Magnitude = (v10 - v7).Magnitude
	local v17 = v7 + v13 * (if Magnitude < v2 then Magnitude else v2)
	local v18 = v11 - v8
	local v19 = if v18.Magnitude == 0 then Vector3.new(0, 0, 0) else v18.Unit
	local Magnitude2 = (v11 - v8).Magnitude
	local v21 = v8 + v19 * (if Magnitude2 < v2 then Magnitude2 else v2)
	local v22 = p3 - v6
	local v23 = if v22.Magnitude == 0 then Vector3.new(0, 0, 0) else v22.Unit
	local v24 = if (v6 - p3).Magnitude <= v2 then true else false
	local v25 = v6 + v23 * v2
	local Magnitude4 = (v21 - p3).Magnitude
	local Magnitude5 = (v17 - p3).Magnitude
	local v26 = math.min(Magnitude4, Magnitude5, (v25 - p3).Magnitude)

	if v5 == v3 or v26 == Magnitude4 then
		local v27 = p3 - v21

		return if (if v27.Magnitude == 0 then Vector3.new(0, 0, 0) else v27.Unit):Dot(RightVector2) < 0 then true else false, v21, RightVector2
	end

	if v5 ~= -v3 and v26 ~= Magnitude5 then
		return v24, v25, v23
	end

	local v30 = p3 - v17

	return if (if v30.Magnitude == 0 then Vector3.new(0, 0, 0) else v30.Unit):Dot(v9) < 0 then true else false, v17, v9
end

return function(p1, p2, p3, p4) --[[ Line: 70 | Upvalues: ClosestPointFunc (copy) ]]
	local v1, v2, v3 = ClosestPointFunc(p1, p2, p3)

	if v1 then
		return v1, v2, v3
	end

	return (v2 - p3).Magnitude < p4, v2, v3
end