-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

t.__index = t
function t.new(p1, p2, p3, p4) --[[ new | Line: 60 | Upvalues: t (copy) ]]
	local v2 = setmetatable({
		X = p1,
		Y = p2,
		Z = p3,
		W = p4
	}, t)

	table.freeze(v2)

	return v2
end
function t.euler(p1, p2, p3) --[[ euler | Line: 81 | Upvalues: t (copy) ]]
	local v1 = math.cos(p1 * 0.5)
	local v2 = math.cos(p2 * 0.5)
	local v3 = math.cos(p3 * 0.5)
	local v4 = math.sin(p1 * 0.5)
	local v5 = math.sin(p2 * 0.5)
	local v6 = math.sin(p3 * 0.5)

	return t.new(v1 * v5 * v6 + v2 * v3 * v4, v1 * v3 * v5 - v2 * v4 * v6, v1 * v2 * v6 - v3 * v4 * v5, v4 * v5 * v6 + v1 * v2 * v3)
end
function t.axisAngle(p1, p2) --[[ axisAngle | Line: 105 | Upvalues: t (copy) ]]
	local v1 = p2 / 2
	local v2 = math.sin(v1)

	return t.new(v2 * p1.X, v2 * p1.Y, v2 * p1.Z, (math.cos(v1)))
end
function t.lookRotation(p1, p2) --[[ lookRotation | Line: 122 | Upvalues: t (copy) ]]
	local v1 = if p2 == nil then Vector3.new(0, 1, 0) else p2.Unit
	local Unit = p1.Unit
	local v2 = v1:Cross(Unit)
	local v3 = Unit:Cross(v2)
	local X = v2.X
	local Y = v2.Y
	local Z = v2.Z
	local X2 = v3.X
	local Y2 = v3.Y
	local Z2 = v3.Z
	local X3 = Unit.X
	local Y3 = Unit.Y
	local Z3 = Unit.Z
	local v4 = X + Y2 + Z3

	if v4 > 0 then
		local v5 = math.sqrt(v4 + 1)

		return t.new((Z2 - Y3) * v5, (X3 - Z) * v5, (Y - X2) * v5, v5 * 0.5)
	end

	if Y2 <= X and Z3 <= X then
		local v6 = math.sqrt(1 + X - Y2 - Z3)
		local v7 = 0.5 / v6

		return t.new(v6 * 0.5, (Y + X2) * v7, (Z + X3) * v7, (Z2 - Y3) * v7)
	end

	if Z3 < Y2 then
		local v8 = math.sqrt(1 + Y2 - X - Z3)
		local v9 = 0.5 / v8

		return t.new((X2 + Y) * v9, v8 * 0.5, (Y3 + Z2) * v9, (X3 - Z) * v9)
	end

	local v10 = math.sqrt(Z3 + 1 - X - Y2)
	local v11 = 0.5 / v10

	return t.new((X3 + Z) * v11, (Y3 + Z2) * v11, v10 * 0.5, (Y - X2) * v11)
end
function t.cframe(p1) --[[ cframe | Line: 179 | Upvalues: t (copy) ]]
	local _, _2, _3, v1, v2, v3, v4, v5, v6, v7, v8, v9 = p1:Orthonormalize():GetComponents()
	local v10 = v1 + v5 + v9
	local v11, v12, v13, v14

	if v10 > 0 then
		local v15 = math.sqrt(v10 + 1) * 2

		v11 = (v8 - v6) / v15
		v12 = (v3 - v7) / v15
		v13 = (v4 - v2) / v15
		v14 = v15 * 0.25
	elseif v5 < v1 and v9 < v1 then
		local v16 = math.sqrt(1 + v1 - v5 - v9) * 2

		v11 = v16 * 0.25
		v12 = (v2 + v4) / v16
		v13 = (v3 + v7) / v16
		v14 = (v8 - v6) / v16
	elseif v9 < v5 then
		local v17 = math.sqrt(1 + v5 - v1 - v9) * 2

		v11 = (v2 + v4) / v17
		v12 = v17 * 0.25
		v13 = (v6 + v8) / v17
		v14 = (v3 - v7) / v17
	else
		local v18 = math.sqrt(1 + v9 - v1 - v5) * 2

		v11 = (v3 + v7) / v18
		v12 = (v6 + v8) / v18
		v13 = v18 * 0.25
		v14 = (v4 - v2) / v18
	end

	return t.new(v11, v12, v13, v14)
end
function t.Dot(p1, p2) --[[ Dot | Line: 226 ]]
	return p1.X * p2.X + p1.Y * p2.Y + p1.Z * p2.Z + p1.W * p2.W
end
function t.Slerp(p1, p2, p3) --[[ Slerp | Line: 246 | Upvalues: t (copy) ]]
	local v1 = p1:Dot(p2)
	local v2

	if v1 < 0 then
		v1 = -v1
		v2 = true
	else
		v2 = false
	end

	local v3, v4

	if v1 > 0.99999 then
		v3 = 1 - p3
		v4 = if v2 then -p3 else p3
	else
		local v5 = math.acos(v1)
		local v6 = 1 / math.sin(v5)

		v3 = math.sin((1 - p3) * v5) * v6
		v4 = if v2 then -math.sin(p3 * v5) * v6 else math.sin(p3 * v5) * v6
	end

	return t.new(v3 * p1.X + v4 * p2.X, v3 * p1.Y + v4 * p2.Y, v3 * p1.Z + v4 * p2.Z, v3 * p1.W + v4 * p2.W)
end
function t.Angle(p1, p2) --[[ Angle | Line: 283 ]]
	local v3 = math.min(math.abs((p1:Dot(p2))), 1)

	if v3 > 0.99999 then
		return 0
	end

	return math.acos(v3) * 2
end
function t.RotateTowards(p1, p2, p3) --[[ RotateTowards | Line: 305 ]]
	local v1 = p1:Angle(p2)

	if v1 == 0 then
		return p1
	end

	return p1:Slerp(p2, p3 / v1)
end
function t.ToCFrame(p1, p2) --[[ ToCFrame | Line: 340 ]]
	local v1 = if p2 == nil then Vector3.new(0, 0, 0) else p2

	return CFrame.new(v1.X, v1.Y, v1.Z, p1.X, p1.Y, p1.Z, p1.W)
end
function t.ToEulerAngles(p1) --[[ ToEulerAngles | Line: 358 ]]
	local v1 = p1.X * p1.Y + p1.Z * p1.W

	if v1 > 0.49999 then
		return Vector3.new(0, math.atan2(p1.X, p1.W) * 2, 1.5707963267948966)
	end

	if v1 < -0.49999 then
		return Vector3.new(0, math.atan2(p1.X, p1.W) * -2, -1.5707963267948966)
	end

	local v6 = p1.Z * p1.Z

	return Vector3.new(math.atan2(p1.X * 2 * p1.W - p1.Y * 2 * p1.Z, 1 - p1.X * p1.X * 2 - v6 * 2), math.atan2(p1.Y * 2 * p1.W - p1.X * 2 * p1.Z, 1 - p1.Y * p1.Y * 2 - v6 * 2), (math.asin(v1 * 2)))
end
function t.ToAxisAngle(p1) --[[ ToAxisAngle | Line: 388 ]]
	local v2 = math.sqrt(p1.X * p1.X + p1.Y * p1.Y + p1.Z * p1.Z)

	if math.abs(v2) < 0.00001 or (p1.W > 1 or p1.W < -1) then
		return Vector3.new(0, 1, 0), 0
	end

	local v3 = 1 / v2

	return Vector3.new(p1.X * v3, p1.Y * v3, p1.Z * v3), math.acos(p1.W) * 2
end
function t.Inverse(p1) --[[ Inverse | Line: 414 | Upvalues: t (copy) ]]
	local v1 = 1 / p1:Dot(p1)

	return t.new(-p1.X * v1, -p1.Y * v1, -p1.Z * v1, p1.W * v1)
end
function t.Conjugate(p1) --[[ Conjugate | Line: 431 | Upvalues: t (copy) ]]
	return t.new(-p1.X, -p1.Y, -p1.Z, p1.W)
end
function t.Normalize(p1) --[[ Normalize | Line: 446 | Upvalues: t (copy) ]]
	local v1 = p1:Magnitude()

	if v1 < 0.00001 then
		return t.identity
	end

	return t.new(p1.X / v1, p1.Y / v1, p1.Z / v1, p1.W / v1)
end
function t.Magnitude(p1) --[[ Magnitude | Line: 467 ]]
	return math.sqrt((p1:Dot(p1)))
end
function t.SqrMagnitude(p1) --[[ SqrMagnitude | Line: 482 ]]
	return p1:Dot(p1)
end
function t._MulVector3(p1, p2) --[[ _MulVector3 | Line: 486 ]]
	local v1 = p1.X * 2
	local v2 = p1.Y * 2
	local v3 = p1.Z * 2
	local v4 = p1.X * v1
	local v5 = p1.Y * v2
	local v6 = p1.Z * v3
	local v7 = p1.X * v2
	local v8 = p1.X * v3
	local v9 = p1.Y * v3
	local v10 = p1.W * v1
	local v11 = p1.W * v2
	local v12 = p1.W * v3

	return Vector3.new((1 - (v5 + v6)) * p2.X + (v7 - v12) * p2.Y + (v8 + v11) * p2.Z, (v7 + v12) * p2.X + (1 - (v4 + v6)) * p2.Y + (v9 - v10) * p2.Z, (v8 - v11) * p2.X + (v9 + v10) * p2.Y + (1 - (v4 + v5)) * p2.Z)
end
function t._MulQuaternion(p1, p2) --[[ _MulQuaternion | Line: 508 | Upvalues: t (copy) ]]
	return t.new(p1.W * p2.X + p1.X * p2.W + p1.Y * p2.Z - p1.Z * p2.Y, p1.W * p2.Y + p1.Y * p2.W + p1.Z * p2.X - p1.X * p2.Z, p1.W * p2.Z + p1.Z * p2.W + p1.X * p2.Y - p1.Y * p2.X, p1.W * p2.W - p1.X * p2.X - p1.Y * p2.Y - p1.Z * p2.Z)
end
function t.__mul(p1, p2) --[[ __mul | Line: 526 | Upvalues: t (copy) ]]
	local v1 = typeof(p2)

	if v1 == "Vector3" then
		return t._MulVector3(p1, p2)
	end

	if v1 == "table" and getmetatable(p2) == t then
		return t._MulQuaternion(p1, p2)
	end

	error(("cannot multiply quaternion with type %*"):format(v1), 2)
end
function t.__unm(p1) --[[ __unm | Line: 537 | Upvalues: t (copy) ]]
	return t.new(-p1.X, -p1.Y, -p1.Z, -p1.W)
end
function t.__eq(p1, p2) --[[ __eq | Line: 541 ]]
	return if p1.X == p2.X and (p1.Y == p2.Y and p1.Z == p2.Z) then p1.W == p2.W else false
end
function t.__tostring(p1) --[[ __tostring | Line: 545 ]]
	return ("%*, %*, %*, %*"):format(p1.X, p1.Y, p1.Z, p1.W)
end
t.mul = t.__mul
t.identity = t.new(0, 0, 0, 1)

return {
	new = t.new,
	euler = t.euler,
	axisAngle = t.axisAngle,
	lookRotation = t.lookRotation,
	cframe = t.cframe,
	identity = t.identity
}