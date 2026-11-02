-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Signal = require(script.Parent.Signal)
local RunService = game:GetService("RunService")
local v1 = {}

v1.__index = v1

function v1.new(v2) -- line 10 | captures: Signal, RunService, v1
    local v3 = type(v2) == "number"
    local v4 = "Argument #1 to Timer.new must be a number; got " .. type(v2)
    assert(v3, v4)
    local v5 = v2 >= 0
    local v6 = "Argument #1 to Timer.new must be greater or equal to 0; got " .. tostring(v2)
    assert(v5, v6)
    local v7 = {}
    local v8 = setmetatable(v7, v1)
    v8._runHandle = nil
    v8.Interval = v2
    v8.UpdateSignal = RunService.Heartbeat
    v8.TimeFunction = time
    v8.AllowDrift = true
    v8.Tick = Signal.new()
    return v8
end

function v1.Simple(v9, v10, v11, v12, v13) -- line 24 | captures: RunService
    local v14 = v12 or RunService.Heartbeat
    local v15 = v13
    local time_2
    if v13 then
        time_2 = v13
    else
        time_2 = time
        v15 = time_2
    end
    local v16 = time_2() + v9
    if v11 then
        task.defer(v10)
    end
    return v14:Connect(function() -- line 37 | captures: v15, v16, v9, v10
        local v17 = v15()
        if v16 <= v17 then
            v16 = v17 + v9
            task.defer(v10)
        end
    end)
end

function v1.Is(v18) -- line 45 | captures: v1
    if type(v18) == "table" then
        return getmetatable(v18) == v1
    end
    return false
end

local function _startTimer(v19) -- line 53
    local TimeFunction = v19.TimeFunction
    local v20 = TimeFunction() + v19.Interval
    local UpdateSignal = v19.UpdateSignal
    v19._runHandle = UpdateSignal:Connect(function() -- line 56 | captures: v20, v19, TimeFunction
        local v21 = TimeFunction()
        if v20 <= v21 then
            v20 = v21 + v19.Interval
            v19.Tick:Fire()
        end
    end)
end

v1._startTimer = _startTimer

local function _startTimerNoDrift(v22) -- line 64
    local v23 = v22.Interval > 0
    assert(v23, "Interval must be greater than 0 when AllowDrift is set to false")
    local TimeFunction = v22.TimeFunction
    local v24 = 1
    local v25 = TimeFunction()
    local v26 = v25 + v22.Interval
    local UpdateSignal = v22.UpdateSignal
    v22._runHandle = UpdateSignal:Connect(function() -- line 71 | captures: v24, v26, v22, TimeFunction, v25
        local v27 = TimeFunction()
        while v26 <= v27 do
            v24 += 1
            v26 = v25 + v22.Interval * v24
            v22.Tick:Fire()
        end
    end)
end

v1._startTimerNoDrift = _startTimerNoDrift

local function Start(v28) -- line 80
    if not v28._runHandle then
        if v28.AllowDrift then
            v28:_startTimer()
        else
            v28:_startTimerNoDrift()
        end
    end
end

v1.Start = Start

local function StartNow(v29) -- line 90
    if not v29._runHandle then
        v29.Tick:Fire()
        v29:Start()
    end
end

v1.StartNow = StartNow

local function Stop(v30) -- line 97
    if v30._runHandle then
        v30._runHandle:Disconnect()
        v30._runHandle = nil
    end
end

v1.Stop = Stop

local function IsRunning(v31) -- line 104
    return v31._runHandle ~= nil
end

v1.IsRunning = IsRunning

local function Destroy(v32) -- line 108
    v32.Tick:Destroy()
    v32:Stop()
end

v1.Destroy = Destroy
return v1
