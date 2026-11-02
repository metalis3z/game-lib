--credit to leon games studio
local t = {}

function t.new(p1) --[[ new | Line: 42 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)
	local v3 = p1 or 0

	rawset(v2, "_time0", tick())
	rawset(v2, "_position0", v3)
	rawset(v2, "_velocity0", 0 * v3)
	rawset(v2, "_target", v3)
	rawset(v2, "_damper", 1)
	rawset(v2, "_speed", 1)

	return v2
end
function t.Impulse(p1, p2) --[[ Impulse | Line: 58 ]]
	p1.Velocity = p1.Velocity + p2
end
function t.Update(p1, p2) --[[ Update | Line: 64 ]]
	local v1 = tick()
	local v2, v3 = p1:_positionVelocity(v1 + p2)

	rawset(p1, "_position0", v2)
	rawset(p1, "_velocity0", v3)
	rawset(p1, "_time0", v1)
end
function t.__index(p1, p2) --[[ __index | Line: 72 | Upvalues: t (copy) ]]
	if t[p2] then
		return t[p2]
	end

	if p2 == "Value" or (p2 == "Position" or p2 == "p") then
		local v1, _ = p1:_positionVelocity(tick())

		return v1
	end

	if p2 == "Velocity" or p2 == "v" then
		local _, v2 = p1:_positionVelocity(tick())

		return v2
	end

	if p2 == "Target" or p2 == "t" then
		return rawget(p1, "_target")
	end

	if p2 == "Damper" or p2 == "d" then
		return rawget(p1, "_damper")
	end

	if p2 == "Speed" or p2 == "s" then
		return rawget(p1, "_speed")
	end

	error(("%q is not a valid member of Spring"):format((tostring(p2))), 2)
end
function t.__newindex(p1, p2, p3) --[[ __newindex | Line: 92 ]]
	local v1 = tick()

	if p2 == "Value" or (p2 == "Position" or p2 == "p") then
		local _, v2 = p1:_positionVelocity(v1)

		rawset(p1, "_position0", p3)
		rawset(p1, "_velocity0", v2)
	elseif p2 == "Velocity" or p2 == "v" then
		local v3, _ = p1:_positionVelocity(v1)

		rawset(p1, "_position0", v3)
		rawset(p1, "_velocity0", p3)
	elseif p2 == "Target" or p2 == "t" then
		local v4, v5 = p1:_positionVelocity(v1)

		rawset(p1, "_position0", v4)
		rawset(p1, "_velocity0", v5)
		rawset(p1, "_target", p3)
	elseif p2 == "Damper" or p2 == "d" then
		local v6, v7 = p1:_positionVelocity(v1)

		rawset(p1, "_position0", v6)
		rawset(p1, "_velocity0", v7)
		rawset(p1, "_damper", (math.clamp(p3, 0, 1)))
	elseif p2 == "Speed" or p2 == "s" then
		local v9, v10 = p1:_positionVelocity(v1)

		rawset(p1, "_position0", v9)
		rawset(p1, "_velocity0", v10)
		rawset(p1, "_speed", if p3 < 0 then 0 else p3)
	else
		error(("%q is not a valid member of Spring"):format((tostring(p2))), 2)
	end

	rawset(p1, "_time0", v1)
end
function t._positionVelocity(p1, p2) --[[ _positionVelocity | Line: 125 ]]
	local v1 = p2 - rawget(p1, "_time0")
	local v2 = rawget(p1, "_position0")
	local v3 = rawget(p1, "_velocity0")
	local v4 = rawget(p1, "_target")
	local v5 = rawget(p1, "_damper")
	local v6 = rawget(p1, "_speed")
	local v7 = v2 - v4

	if v6 == 0 then
		return v2, 0
	end

	if v5 < 1 then
		local v8 = (1 - v5 * v5) ^ 0.5
		local v9 = (v3 / v6 + v5 * v7) / v8
		local v10 = math.cos(v8 * v6 * v1)
		local v11 = math.sin(v8 * v6 * v1)
		local v12 = 2.718281828459045 ^ (v5 * v6 * v1)

		return v4 + (v7 * v10 + v9 * v11) / v12, v6 * ((v8 * v9 - v5 * v7) * v10 - (v8 * v7 + v5 * v9) * v11) / v12
	end

	local v13 = v3 / v6 + v7
	local v14 = 2.718281828459045 ^ (v6 * v1)

	return v4 + (v7 + v13 * v6 * v1) / v14, v6 * (v13 - v7 - v13 * v6 * v1) / v14
end

return t