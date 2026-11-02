-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BindToRenderStep = require(ReplicatedStorage.Library.Functions.BindToRenderStep)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local t = {}
local v1 = 0

function t.Destroy(p1) --[[ Destroy | Line: 31 ]]
	p1:Disconnect()
	table.clear(p1)
	setmetatable(p1, nil)
end
function t.Disconnect(p1) --[[ Disconnect | Line: 37 ]]
	local _bound = p1._bound

	if _bound then
		p1._bound = nil
		_bound()
	end

	local _callbacks = p1._callbacks

	if not (#_callbacks > 0) then
		return
	end

	p1._callbacks = {}

	for i, v in ipairs(_callbacks) do
		v()
	end
end
function t.IsConnected(p1) --[[ IsConnected | Line: 53 ]]
	return p1._bound ~= nil
end
function t.Then(p1, p2) --[[ Then | Line: 57 | Upvalues: Asserts (copy) ]]
	Asserts.func(p2)

	if p1._bound then
		table.insert(p1._callbacks, p2)
	else
		p2()
	end

	return p1
end
function t.Wait(p1) --[[ Wait | Line: 71 ]]
	while p1:IsConnected() do
		task.wait()
	end
end
function t._Step(p1, p2) --[[ _Step | Line: 77 ]]
	local _t = p1._t
	local _duration = p1._duration
	local _timeUnrestricted = p1._timeUnrestricted

	if not _timeUnrestricted then
		p2 = math.min(p2, _duration - _t)
	end

	local v2 = _t + p2

	if not _timeUnrestricted then
		v2 = math.min(v2, _duration)
	end

	p1._t = v2

	local v4

	if p1._timeScaled and _duration ~= (1 / 0) then
		p2 = p2 / _duration
		v4 = v2 / _duration

		if not _timeUnrestricted then
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

return function(p1, p2, p3, p4, p5) --[[ Line: 116 | Upvalues: Asserts (copy), v1 (ref), t (copy), BindToRenderStep (copy) ]]
	Asserts.func(p1)

	if p2 ~= nil then
		Asserts.number(p2)
		assert(p2 > 0, "Duration must be positive")
		assert(if p2 == p2 then true else false, "Duration must not be NaN")
	end

	if p5 ~= nil then
		Asserts.number(p5)
		assert(p5 >= 0, "Priority must be positive")
		assert(if p5 == p5 then true else false, "Priority must not be NaN")
	end

	v1 = v1 + 1

	local t2 = {
		_t = 0,
		_connection = nil,
		_fn = p1,
		_duration = p2 or (1 / 0)
	}

	t2._timeScaled = if p3 == true then true else false
	t2._timeUnrestricted = if p4 == true then true else false
	t2._key = ("__internal_rs_%d"):format(v1)
	t2._uid = v1
	t2._priority = if p5 then p5 else Enum.RenderPriority.Last.Value
	t2._callbacks = {}

	local v8 = setmetatable(t2, {
		__index = t
	})

	v8._bound = BindToRenderStep(v8._key, v8._priority, function(p1) --[[ Line: 152 | Upvalues: v8 (copy) ]]
		v8:_Step(p1)
	end)

	return v8
end