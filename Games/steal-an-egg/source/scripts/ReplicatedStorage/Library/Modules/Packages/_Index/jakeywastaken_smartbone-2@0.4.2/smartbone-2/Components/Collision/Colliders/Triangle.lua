-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Dot = Vector3.new().Dot
local Cross = Vector3.new().Cross
local clamp = math.clamp

local function SafeUnit(p1) --[[ SafeUnit | Line: 12 ]]
	if p1.Magnitude == 0 then
		return Vector3.new(0, 0, 0)
	end

	return p1.Unit
end

local function ClosestPointOnLineSegment(p1, p2, p3) --[[ ClosestPointOnLineSegment | Line: 20 | Upvalues: Dot (copy), clamp (copy) ]]
	local v1 = p2 - p1

	return p1 + clamp(Dot(p3 - p1, v1) / Dot(v1, v1), 0, 1) * v1
end

local function ProjectOnPlane(p1, p2, p3) --[[ ProjectOnPlane | Line: 26 ]]
	return p3 - (p3 - p1):Dot(p2) * p2
end

local function SameSide(p1, p2, p3, p4) --[[ SameSide | Line: 34 | Upvalues: Cross (copy), Dot (copy) ]]
	return Dot(Cross(p4 - p3, p1 - p3), (Cross(p4 - p3, p2 - p3))) >= 0
end

local function PointInTriangle(p1, p2, p3, p4) --[[ PointInTriangle | Line: 44 | Upvalues: Cross (copy), Dot (copy) ]]
	if not (Dot(Cross(p4 - p3, p1 - p3), (Cross(p4 - p3, p2 - p3))) >= 0) then
		return false
	end

	if not (Dot(Cross(p4 - p2, p1 - p2), (Cross(p4 - p2, p3 - p2))) >= 0) then
		return false
	end

	if Dot(Cross(p3 - p2, p1 - p2), (Cross(p3 - p2, p4 - p2))) >= 0 then
		return true
	end

	return false
end

return function(p1, p2, p3, p4) --[[ ClosestPointOnTri | Line: 52 | Upvalues: Dot (copy), clamp (copy), Cross (copy) ]]
	local v1 = p2 - p1
	local v2 = p1 + clamp(Dot(p4 - p1, v1) / Dot(v1, v1), 0, 1) * v1
	local v3 = p3 - p2
	local v4 = p2 + clamp(Dot(p4 - p2, v3) / Dot(v3, v3), 0, 1) * v3
	local v5 = p1 - p3
	local v6 = p3 + clamp(Dot(p4 - p3, v5) / Dot(v5, v5), 0, 1) * v5
	local v7 = Cross(p2 - p1, p3 - p1)
	local v8 = if v7.Magnitude == 0 then Vector3.new(0, 0, 0) else v7.Unit
	local v9 = p4 - (p4 - (p1 + p2 + p3) * 0.3333):Dot(v8) * v8
	local v11, v12

	if if Dot(Cross(p3 - p2, p4 - p2), (Cross(p3 - p2, p1 - p2))) >= 0 then true else false then
		local v13 = Dot(Cross(p3 - p1, p4 - p1), (Cross(p3 - p1, p2 - p1))) >= 0

		if v13 and Dot(Cross(p2 - p1, p4 - p1), (Cross(p2 - p1, p3 - p1))) >= 0 then
			v11 = true
			v12 = v9
		else
			v12 = v9
			v11 = false
		end
	else
		v12 = v9
		v11 = false
	end

	if v11 then
		return v12, v8
	end

	local Magnitude = (v2 - p4).Magnitude
	local Magnitude2 = (v4 - p4).Magnitude
	local Magnitude3 = (v6 - p4).Magnitude
	local v15 = math.min(Magnitude, Magnitude2, Magnitude3)

	if v15 == Magnitude then
		return v2, v8
	end

	if v15 == Magnitude2 then
		return v4, v8
	end

	if v15 == Magnitude3 then
		return v6, v8
	end

	return p4, v8
end