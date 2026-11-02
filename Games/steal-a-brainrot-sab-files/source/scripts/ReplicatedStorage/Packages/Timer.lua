local Signal = require(script.Parent.Signal)
local RunService = game:GetService("RunService")

local Timer = {}
Timer.__index = Timer

Timer.new = function(interval)
	assert(type(interval) == "number", "Argument #1 to Timer.new must be a number; got " .. type(interval))
	assert(interval >= 0, "Argument #1 to Timer.new must be greater or equal to 0; got " .. tostring(interval))
	local self = setmetatable({}, Timer)
	self._runHandle = nil
	self.Interval = interval
	self.UpdateSignal = RunService.Heartbeat
	self.TimeFunction = time
	self.AllowDrift = true
	self.Tick = Signal.new()
	return self
end

Timer.Simple = function(interval, callback, fireNow, updateSignal, timeFunction)
	local resolvedUpdateSignal = updateSignal or RunService.Heartbeat
	local resolvedTimeFunction = timeFunction or time
	local nextTick = resolvedTimeFunction() + interval
	if fireNow then
		task.defer(callback)
	end
	return resolvedUpdateSignal:Connect(function()
		debug.profilebegin("Timer")
		local currentTime = resolvedTimeFunction()
		if nextTick <= currentTime then
			nextTick = currentTime + interval
			task.defer(callback)
		end
		debug.profileend()
	end)
end

Timer.Is = function(object)
	local isTimer = false
	if type(object) == "table" then
		isTimer = getmetatable(object) == Timer
	end
	return isTimer
end

Timer._startTimer = function(self)
	local timeFunction = self.TimeFunction
	local nextTick = timeFunction() + self.Interval
	self._runHandle = self.UpdateSignal:Connect(function()
		local currentTime = timeFunction()
		if nextTick <= currentTime then
			nextTick = currentTime + self.Interval
			self.Tick:Fire()
		end
	end)
end

Timer._startTimerNoDrift = function(self)
	assert(self.Interval > 0, "Interval must be greater than 0 when AllowDrift is set to false")
	local timeFunction = self.TimeFunction
	local tickCount = 1
	local startTime = timeFunction()
	local nextTick = startTime + self.Interval
	self._runHandle = self.UpdateSignal:Connect(function()
		local currentTime = timeFunction()
		while nextTick <= currentTime do
			tickCount = tickCount + 1
			nextTick = startTime + self.Interval * tickCount
			self.Tick:Fire()
		end
	end)
end

Timer.Start = function(self)
	if self._runHandle then
		return
	elseif self.AllowDrift then
		self:_startTimer()
		return
	else
		self:_startTimerNoDrift()
		return
	end
end

Timer.StartNow = function(self)
	if self._runHandle then
		return
	else
		self.Tick:Fire()
		self:Start()
		return
	end
end

Timer.Stop = function(self)
	if not self._runHandle then
		return
	else
		self._runHandle:Disconnect()
		self._runHandle = nil
		return
	end
end

Timer.IsRunning = function(self)
	return self._runHandle ~= nil
end

Timer.Destroy = function(self)
	self.Tick:Destroy()
	self:Stop()
end

return Timer