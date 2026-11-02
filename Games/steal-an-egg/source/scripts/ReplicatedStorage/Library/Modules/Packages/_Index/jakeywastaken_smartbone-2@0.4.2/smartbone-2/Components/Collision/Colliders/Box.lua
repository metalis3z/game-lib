-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function SafeUnit(p1) --[[ SafeUnit | Line: 1 ]]
	if p1.Magnitude == 0 then
		return Vector3.new(0, 0, 0)
	end

	return p1.Unit
end

local function ClosestPointFunc(p1, p2, p3) --[[ ClosestPointFunc | Line: 9 ]]
	local v1 = p1:pointToObjectSpace(p3)
	local x = p2.x
	local y = p2.y
	local z = p2.z
	local x2 = v1.x
	local y2 = v1.y
	local z2 = v1.z
	local v2 = math.clamp(x2, -x * 0.5, x * 0.5)
	local v3 = math.clamp(y2, -y * 0.5, y * 0.5)
	local v4 = math.clamp(z2, -z * 0.5, z * 0.5)

	if v2 == x2 and (v3 == y2 and v4 == z2) then
		local v5 = x2 - x * 0.5
		local v6 = y2 - y * 0.5
		local v7 = z2 - z * 0.5
		local v8 = -x2 - x * 0.5
		local v9 = -y2 - y * 0.5
		local v10 = -z2 - z * 0.5
		local v11 = math.max(v5, v6, v7, v8, v9, v10)

		if v11 == v5 then
			return true, p1 * Vector3.new(x * 0.5, y2, z2), p1.XVector
		end

		if v11 == v6 then
			return true, p1 * Vector3.new(x2, y * 0.5, z2), p1.YVector
		end

		if v11 == v7 then
			return true, p1 * Vector3.new(x2, y2, z * 0.5), p1.ZVector
		end

		if v11 == v8 then
			return true, p1 * Vector3.new(-x * 0.5, y2, z2), -p1.XVector
		end

		if v11 == v9 then
			return true, p1 * Vector3.new(x2, -y * 0.5, z2), -p1.YVector
		end

		if v11 == v10 then
			return true, p1 * Vector3.new(x2, y2, -z * 0.5), -p1.ZVector
		end

		warn("CLOSEST POINT ON BOX FAIL")

		return false, p1.Position, Vector3.new(0, 0, 0)
	end

	local v12 = p1 * Vector3.new(v2, v3, v4)
	local v13 = p3 - v12

	return false, v12, if v13.Magnitude == 0 then Vector3.new(0, 0, 0) else v13.Unit
end

return function(p1, p2, p3, p4) --[[ Line: 60 | Upvalues: ClosestPointFunc (copy) ]]
	local v1, v2, v3 = ClosestPointFunc(p1, p2, p3)

	if v1 then
		return v1, v2, v3
	end

	return (v2 - p3).Magnitude < p4, v2, v3
end