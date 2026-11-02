

local t1 = {}

t1.__index = t1

function t1.new(p1, p2: ((...any) -> ...any)?)
	local v4 = p1 or 0
	local v5 = p2 or os.clock

	return (setmetatable({
		_damper = 1,
		_speed = 1,
		_clock = v5,
		_time0 = v5(),
		_position0 = v4,
		_velocity0 = 0 * v4,
		_target = v4
	}, t1))
end
function t1.Impulse(p3, p4)
	p3.Velocity = p3.Velocity + p4
end
function t1.TimeSkip(p5, n1: number)
	local v10 = p5._clock()
	local v11, v12 = p5:_positionVelocity(v10 + n1)

	p5._position0 = v11
	p5._velocity0 = v12
	p5._time0 = v10
end
function t1.SetTarget(p6, p7, b1: boolean?)
	if b1 then
		local v16 = p6._clock()

		p6._position0 = p7
		p6._velocity0 = 0 * p7
		p6._target = p7
		p6._time0 = v16

		return
	end

	p6.Target = p7
end
function t1.__index(p8, p9)
	if t1[p9] then
		return t1[p9]
	end

	if p9 == "Value" or p9 == "Position" or p9 == "p" then
		local v19, _ = p8:_positionVelocity(p8._clock())

		return v19
	end

	if p9 == "Velocity" or p9 == "v" then
		local _, v22 = p8:_positionVelocity(p8._clock())

		return v22
	end

	if p9 == "Target" or p9 == "t" then
		return p8._target
	end

	if p9 == "Damper" or p9 == "d" then
		return p8._damper
	end

	if p9 == "Speed" or p9 == "s" then
		return p8._speed
	end

	if p9 == "Clock" then
		return p8._clock
	end

	error(string.format("%q is not a valid member of Spring", (tostring(p9))), 2)
end
function t1.__newindex(p10, p11, p12)
	local v26 = p10._clock()

	if p11 == "Value" or (p11 == "Position" or p11 == "p") then
		local _, v28 = p10:_positionVelocity(v26)

		p10._position0 = p12
		p10._velocity0 = v28
		p10._time0 = v26

		return
	end

	if p11 == "Velocity" or p11 == "v" then
		local v29, _ = p10:_positionVelocity(v26)

		p10._position0 = v29
		p10._velocity0 = p12
		p10._time0 = v26

		return
	end

	if p11 == "Target" or p11 == "t" then
		local v31, v32 = p10:_positionVelocity(v26)

		p10._position0 = v31
		p10._velocity0 = v32
		p10._target = p12
		p10._time0 = v26

		return
	end

	if p11 == "Damper" or p11 == "d" then
		local v33, v34 = p10:_positionVelocity(v26)

		p10._position0 = v33
		p10._velocity0 = v34
		p10._damper = p12
		p10._time0 = v26

		return
	end

	if p11 == "Speed" or p11 == "s" then
		local v35, v36 = p10:_positionVelocity(v26)

		p10._position0 = v35
		p10._velocity0 = v36
		p10._speed = if not (p12 < 0) then p12 else 0
		p10._time0 = v26

		return
	end

	if p11 == "Clock" then
		local v37, v38 = p10:_positionVelocity(v26)

		p10._position0 = v37
		p10._velocity0 = v38
		p10._clock = p12
		p10._time0 = p12()

		return
	end

	error(string.format("%q is not a valid member of Spring", (tostring(p11))), 2)
end
function t1._positionVelocity(p13, n2: number)
	local _position0 = p13._position0
	local _velocity0 = p13._velocity0
	local _target = p13._target
	local _damper = p13._damper
	local _speed = p13._speed
	local v46 = _speed * (n2 - p13._time0)
	local v47 = _damper * _damper
	local v48, v50, v51

	if v47 < 1 then
		v48 = math.sqrt(1 - v47)

		local v49 = math.exp(-_damper * v46) / v48

		v50 = v49 * math.cos(v48 * v46)
		v51 = v49 * math.sin(v48 * v46)
	elseif v47 == 1 then
		v48 = 1
		v50 = math.exp(-_damper * v46) / v48
		v51 = v50 * v46
	else
		v48 = math.sqrt(v47 - 1)

		local v52 = math.exp((-_damper + v48) * v46) / (2 * v48)
		local v53 = math.exp((-_damper - v48) * v46) / (2 * v48)

		v50 = v52 + v53
		v51 = v52 - v53
	end

	local v54 = v48 * v50 + _damper * v51
	local v55 = 1 - (v48 * v50 + _damper * v51)
	local v56 = v51 / _speed
	local v57 = -_speed * v51
	local v58 = _speed * v51
	local v59 = v48 * v50 - _damper * v51

	return v54 * _position0 + v55 * _target + v56 * _velocity0, v57 * _position0 + v58 * _target + v59 * _velocity0
end

return t1
