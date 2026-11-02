-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function SafeUnit(p1) --[[ SafeUnit | Line: 1 ]]
	if p1.Magnitude == 0 then
		return Vector3.new(0, 0, 0)
	end

	return p1.Unit
end

return function(p1, p2, p3, p4) --[[ Line: 11 ]]
	local v1 = p4:Inverse() * p2
	local X = v1.X
	local Y = v1.Y
	local Z = v1.Z
	local XAxisLimits = p1.XAxisLimits
	local YAxisLimits = p1.YAxisLimits
	local ZAxisLimits = p1.ZAxisLimits
	local v2 = if p1.AxisLocked[1] then 0 else 1
	local v3 = if p1.AxisLocked[2] then 0 else 1
	local v4 = if p1.AxisLocked[3] then 0 else 1

	if XAxisLimits.Min == (-1 / 0) and (XAxisLimits.Max == (1 / 0) and (YAxisLimits.Min == (-1 / 0) and (YAxisLimits.Max == (1 / 0) and (ZAxisLimits.Min == (-1 / 0) and ZAxisLimits.Max == (1 / 0))))) then
		if v2 == 1 and (v3 == 1 and v4 == 1) then
			return p2
		end

		return p4 * Vector3.new(X * v2, Y * v3, Z * v4)
	end

	local v5 = XAxisLimits.Min + p1.Radius
	local v6 = v5 <= XAxisLimits.Max - p1.Radius and XAxisLimits.Max - p1.Radius or v5
	local v7 = YAxisLimits.Min + p1.Radius
	local v8 = v7 <= YAxisLimits.Max - p1.Radius and YAxisLimits.Max - p1.Radius or v7
	local v9 = ZAxisLimits.Min + p1.Radius
	local v10 = v9 <= ZAxisLimits.Max - p1.Radius and ZAxisLimits.Max - p1.Radius or v9
	local v11 = if X < v5 then v5 elseif v6 < X then v6 else X
	local v12, v13

	if Y < v7 then
		v12 = v7
		v13 = v11
	elseif v8 < Y then
		v12 = v8
		v13 = v11
	else
		v13 = v11
		v12 = Y
	end

	local v14, v15

	if Z < v9 then
		v14 = v9
		v15 = v12
	elseif v10 < Z then
		v14 = v10
		v15 = v12
	else
		v15 = v12
		v14 = Z
	end

	local v16 = v13 * v2
	local v17 = v15 * v3
	local v18 = v14 * v4
	local v19 = p4 * Vector3.new(v16, v17, v18)
	local RightVector = p4.RightVector
	local UpVector = p4.UpVector
	local LookVector = p4.LookVector
	local v20 = v19 - p3
	local v21 = if v20.Magnitude == 0 then Vector3.new(0, 0, 0) else v20.Unit
	local v22

	if v16 == v1.X then
		v22 = v19
	else
		local v23

		if RightVector:Dot(v21) < 0 then
			v23 = -RightVector

			if v23 then
				v22 = v19
			else
				v22 = v19
				v23 = RightVector
			end
		else
			v22 = v19
			v23 = RightVector
		end

		p1:ClipVelocity(v22, v23)
	end

	if v17 ~= v1.Y then
		p1:ClipVelocity(v22, UpVector:Dot(v21) < 0 and -UpVector or UpVector)
	end

	if v18 ~= v1.Z then
		p1:ClipVelocity(v22, LookVector:Dot(v21) > 0 and -LookVector or LookVector)
	end

	return v22
end