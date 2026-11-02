-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local t = {
	Disconnect = function(p1) --[[ Disconnect | Line: 4 ]]
		local _connection = p1._connection

		if _connection then
			p1._connection = nil
			_connection:Disconnect()
		end

		local _callbacks = p1._callbacks

		if not (#_callbacks > 0) then
			return
		end

		p1._callbacks = {}

		for i, v in ipairs(_callbacks) do
			v()
		end
	end,
	IsConnected = function(p1) --[[ IsConnected | Line: 18 ]]
		return p1._connection ~= nil
	end,
	Then = function(p1, p2) --[[ Then | Line: 21 ]]
		assert(if type(p2) == "function" then true else false)

		if p1._connection then
			table.insert(p1._callbacks, p2)
		else
			p2()
		end

		return p1
	end,
	Wait = function(p1) --[[ Wait | Line: 30 ]]
		while p1:IsConnected() do
			task.wait()
		end
	end,
	_Step = function(p1, p2) --[[ _Step | Line: 35 ]]
		local _t = p1._t
		local _duration = p1._duration

		if not p1._timeUnrestricted then
			p2 = math.min(p2, _duration - _t)
		end

		local v2 = _t + p2

		if not p1._timeUnrestricted then
			v2 = math.min(v2, _duration)
		end

		p1._t = v2

		local v4

		if p1._timeScaled and _duration ~= (1 / 0) then
			p2 = p2 / _duration
			v4 = v2 / _duration

			if not p1._timeUnrestricted then
				local v5 = math.min(p2, 1 - v4)

				p2, v4 = v5, math.min(v4, 1)
			end
		else
			v4 = v2
		end

		if not (p1._fn(p2, v4) or _duration <= v2) then
			return
		end

		p1:Disconnect()
	end
}

return function(p1, p2, p3, p4) --[[ Line: 67 | Upvalues: t (copy), RunService (copy) ]]
	assert(if type(p1) == "function" then true else false)

	if p2 ~= nil then
		assert(type(p2) == "number")
		assert(if p2 > 0 then true else false)
		assert(if p2 == p2 then true else false)
	end

	local t2 = {
		_t = 0,
		_connection = nil,
		_fn = p1,
		_duration = p2 or (1 / 0)
	}

	t2._timeScaled = if p3 == true then true else false
	t2._timeUnrestricted = p4 == true
	t2._callbacks = {}

	local v7 = setmetatable(t2, {
		__index = t
	})

	v7._connection = RunService.Stepped:Connect(function(p1, p2) --[[ Line: 83 | Upvalues: v7 (copy) ]]
		v7:_Step(p2)
	end)

	return v7
end