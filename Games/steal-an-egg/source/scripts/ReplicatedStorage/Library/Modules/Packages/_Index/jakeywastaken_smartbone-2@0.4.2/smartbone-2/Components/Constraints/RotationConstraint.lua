-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function SafeUnit(p1) --[[ SafeUnit | Line: 1 ]]
	if p1.Magnitude == 0 then
		return Vector3.new(0, 0, 0)
	end

	return p1.Unit
end

return function(p1, p2, p3) --[[ Line: 9 ]]
	local v1 = p3.Bones[p1.ParentIndex]

	if not v1 then
		return p2
	end

	local RotationLimit = v1.RotationLimit

	if RotationLimit >= 180 then
		return p2
	end

	local v2 = p3.Bones[v1.ParentIndex]

	if not v2 then
		return p2
	end

	local Position = v1.Position
	local v3 = v1.Position - v2.Position
	local v4 = if v3.Magnitude == 0 then Vector3.new(0, 0, 0) else v3.Unit
	local Magnitude = (p2 - Position).Magnitude
	local v5 = p2 - Position
	local v6 = if v5.Magnitude == 0 then Vector3.new(0, 0, 0) else v5.Unit

	if RotationLimit <= 0 then
		return Position + v4 * Magnitude
	end

	local v7 = math.rad(p1.RotationLimit)
	local v9

	if v7 <= math.acos((v4:Dot(v6))) then
		local v10 = v4:Cross(v6)

		v9 = CFrame.fromAxisAngle(if v10.Magnitude == 0 then Vector3.new(0, 0, 0) else v10.Unit, v7) * v4
	else
		v9 = v6
	end

	return Position + v9 * Magnitude
end