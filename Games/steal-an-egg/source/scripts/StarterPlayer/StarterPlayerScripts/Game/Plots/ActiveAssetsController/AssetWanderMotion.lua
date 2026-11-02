-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local AssetWanderArea = require(script.Parent.AssetWanderArea)
local t = {
	YawFromFlatDirection = function(p1) --[[ YawFromFlatDirection | Line: 18 ]]
		return math.atan2(-p1.X, -p1.Z)
	end,
	ShortestYawDelta = function(p1, p2) --[[ ShortestYawDelta | Line: 22 ]]
		local v1 = p2 - p1
		local v2 = math.sin(v1)

		return math.atan2(v2, (math.cos(v1)))
	end
}

function t.StepYawToward(p1, p2, p3) --[[ StepYawToward | Line: 28 | Upvalues: t (copy) ]]
	local v2 = p3 * 3.839724354387525
	local v3 = math.clamp(t.ShortestYawDelta(p1, p2), -v2, v2)

	return p1 + v3, v3
end
function t.StepMoveToward(p1, p2, p3, p4) --[[ StepMoveToward | Line: 36 | Upvalues: t (copy) ]]
	local Position = p2.Position
	local v1 = p3 - Position
	local v2 = Vector3.new(v1.X, 0, v1.Z)
	local Magnitude = v2.Magnitude

	if Magnitude <= 0 then
		return p2, false, 0
	end

	local v3 = math.min(Magnitude, p4 * p1)
	local Unit = v2.Unit
	local LookVector = p2.LookVector
	local v4 = Vector3.new(LookVector.X, 0, LookVector.Z)
	local v6 = t.YawFromFlatDirection(if v4.Magnitude > 0 then v4.Unit else Unit)
	local v7 = t.YawFromFlatDirection(Unit)
	local v8, v9 = t.StepYawToward(v6, v7, p1)
	local v13 = math.clamp((math.cos((math.abs((t.ShortestYawDelta(v8, v7))))) - 0.2) / 0.8, 0, 1)

	return CFrame.new(Position + Unit * v3 * v13) * CFrame.Angles(0, v8, 0), if v13 > 0 then true else math.abs(v9) > 0.008726646259971648, p4 * v13
end
function t.FaceOwnerCFrame(p1, p2, p3, p4) --[[ FaceOwnerCFrame | Line: 69 | Upvalues: t (copy) ]]
	local Position = p1.Position
	local v3 = Vector3.new(p2.X - Position.X, 0, p2.Z - Position.Z)

	if v3.Magnitude <= 0 then
		return p1
	end

	local LookVector = p1.LookVector
	local v4 = Vector3.new(LookVector.X, 0, LookVector.Z)

	assert(if v4.Magnitude > 0 then true else false, "Asset wander CFrame must have a horizontal facing direction")

	local v6 = t.YawFromFlatDirection(v4.Unit)
	local v7 = t.YawFromFlatDirection(v3.Unit)
	local v8 = if p4 == true then v7 else t.StepYawToward(v6, v7, p3)

	return CFrame.new(Position) * CFrame.Angles(0, v8, 0)
end
function t.StepFollowOwner(p1, p2, p3, p4, p5, p6, p7) --[[ StepFollowOwner | Line: 92 | Upvalues: AssetWanderArea (copy), t (copy) ]]
	local v1 = AssetWanderArea.PointNearOwner(p1, p4, p5)
	local v2, v3, v4 = t.StepMoveToward(p2, p3, v1, p6)

	if Vector3.new(v1.X - v2.Position.X, 0, v1.Z - v2.Position.Z).Magnitude <= p7 then
		v2 = t.FaceOwnerCFrame(v2, p4, p2)
	end

	return v2, v3, v4
end
function t.OwnerMoveVector(p1, p2, p3) --[[ OwnerMoveVector | Line: 111 ]]
	if p2 == nil then
		return Vector3.new(0, 0, 0), nil
	end

	if p3 == nil or p1 <= 0 then
		return Vector3.new(0, 0, 0), p2
	end

	local v1 = p2 - p3

	return Vector3.new(v1.X, 0, v1.Z) / p1, p2
end
function t.OrbitGreetingCFrame(p1, p2, p3, p4, p5, p6, p7, p8) --[[ OrbitGreetingCFrame | Line: 127 | Upvalues: AssetWanderArea (copy), t (copy) ]]
	local Position = p3.Position
	local v3 = Vector3.new(Position.X - p4.X, 0, Position.Z - p4.Z)
	local v4

	if v3.Magnitude == 0 then
		local LookVector = p1.CFrame.LookVector
		local v5 = Vector3.new(LookVector.X, 0, LookVector.Z)

		assert(v5.Magnitude > 0, "Asset area must provide a horizontal orbit greeting direction")
		v4 = v5.Unit
	else
		local Unit = v3.Unit
		local v8 = Vector3.new(-Unit.Z, 0, Unit.X)

		v4 = (v8 + Unit * math.clamp((p6 - v3.Magnitude) / p6, -p8, p8)).Unit
	end

	local v10 = v4 * p7 + p5
	local v11 = Vector3.new(v10.X, 0, v10.Z)

	if v11.Magnitude <= 0 then
		return p3, false, 0
	end

	local v12 = AssetWanderArea.ClampedPointToward(p1, Position + v10 * p2)
	local v15 = Vector3.new(v12.X - Position.X, 0, v12.Z - Position.Z)

	if v15.Magnitude <= 0 then
		return p3, false, 0
	end

	local v16 = t.YawFromFlatDirection(v15.Unit)

	return CFrame.new(v12) * CFrame.Angles(0, v16, 0), true, v10.Magnitude
end

return t