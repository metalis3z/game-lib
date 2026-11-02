-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Signal = require(script.Parent.Signal)
local RunService = game:GetService("RunService")
local t = {}

t.__index = t
function t.new(p1) --[[ new | Line: 73 | Upvalues: t (copy), RunService (copy), Signal (copy) ]]
	assert(type(p1) == "number", "Argument #1 to Timer.new must be a number; got " .. type(p1))
	assert(p1 >= 0, "Argument #1 to Timer.new must be greater or equal to 0; got " .. tostring(p1))

	local v6 = setmetatable({}, t)

	v6._runHandle = nil
	v6.Interval = p1
	v6.UpdateSignal = RunService.Heartbeat
	v6.TimeFunction = time
	v6.AllowDrift = true
	v6.Tick = Signal.new()

	return v6
end
function t.Simple(p1, p2, p3, p4, p5) --[[ Simple | Line: 103 | Upvalues: RunService (copy) ]]
	local v1 = if p4 then p4 else RunService.Heartbeat
	local v2 = p5 or time
	local v3 = v2() + p1

	if p3 then
		task.defer(p2)
	end

	return v1:Connect(function() --[[ Line: 116 | Upvalues: v2 (copy), v3 (ref), p1 (copy), p2 (copy) ]]
		local v1 = v2()

		if not (v3 <= v1) then
			return
		end

		v3 = v1 + p1
		task.defer(p2)
	end)
end
function t.Is(p1) --[[ Is | Line: 128 | Upvalues: t (copy) ]]
	return if type(p1) == "table" then getmetatable(p1) == t else false
end
function t._startTimer(p1) --[[ _startTimer | Line: 132 ]]
	local TimeFunction = p1.TimeFunction
	local v1 = TimeFunction() + p1.Interval

	p1._runHandle = p1.UpdateSignal:Connect(function() --[[ Line: 135 | Upvalues: TimeFunction (copy), v1 (ref), p1 (copy) ]]
		local v12 = TimeFunction()

		if not (v1 <= v12) then
			return
		end

		v1 = v12 + p1.Interval
		p1.Tick:Fire()
	end)
end
function t._startTimerNoDrift(p1) --[[ _startTimerNoDrift | Line: 144 ]]
	assert(p1.Interval > 0, "Interval must be greater than 0 when AllowDrift is set to false")

	local TimeFunction = p1.TimeFunction
	local v2 = 1
	local v3 = TimeFunction()
	local v4 = v3 + p1.Interval

	p1._runHandle = p1.UpdateSignal:Connect(function() --[[ Line: 150 | Upvalues: TimeFunction (copy), v4 (ref), v2 (ref), v3 (copy), p1 (copy) ]]
		while v4 <= TimeFunction() do
			v2 = v2 + 1
			v4 = v3 + p1.Interval * v2
			p1.Tick:Fire()
		end
	end)
end
function t.Start(p1) --[[ Start | Line: 167 ]]
	if p1._runHandle then
		return
	end

	if p1.AllowDrift then
		p1:_startTimer()
	else
		p1:_startTimerNoDrift()
	end
end
function t.StartNow(p1) --[[ StartNow | Line: 186 ]]
	if not p1._runHandle then
		p1.Tick:Fire()
		p1:Start()
	end
end
function t.Stop(p1) --[[ Stop | Line: 201 ]]
	if p1._runHandle then
		p1._runHandle:Disconnect()
		p1._runHandle = nil
	end
end
function t.IsRunning(p1) --[[ IsRunning | Line: 218 ]]
	return p1._runHandle ~= nil
end
function t.Destroy(p1) --[[ Destroy | Line: 225 ]]
	p1.Tick:Destroy()
	p1:Stop()
end

return t