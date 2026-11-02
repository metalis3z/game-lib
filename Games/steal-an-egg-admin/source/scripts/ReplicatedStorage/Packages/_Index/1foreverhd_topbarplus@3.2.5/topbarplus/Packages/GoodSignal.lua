-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1

local function acquireRunnerThreadAndCallEventHandler(v2, ...) -- line 7 | captures: v1
    v1 = nil
    v2(...)
end

local function runEventHandlerInFreeThread() -- line 12 | captures: acquireRunnerThreadAndCallEventHandler
    while true do
        acquireRunnerThreadAndCallEventHandler(coroutine.yield())
    end
end

local v3 = {}

v3.__index = v3

function v3.new(v4, v5) -- line 19 | captures: v3
    local v6 = {
        _connected = true,
        _next = false,
        _signal = v4,
        _fn = v5
    }
    return (setmetatable(v6, v3))
end

local function Disconnect(v7) -- line 23
    v7._connected = false
    if v7._signal._handlerListHead == v7 then
        v7._signal._handlerListHead = v7._next
    else
        local v8 = v7._signal._handlerListHead
        while v8 do
            if v8._next == v7 then
                break
            end
            v8 = v8._next
        end
        if v8 then
            v8._next = v7._next
        end
    end
end

v3.Disconnect = Disconnect
v3.Destroy = v3.Disconnect

local v9 = {
    __index = function(v10, v11) -- __index | line 43
        local v12 = ("Attempt to get Connection::%s (not a valid member)"):format((tostring(v11)))
        error(v12, 2)
    end,
    __newindex = function(v13, v14, v15) -- __newindex | line 47
        local v16 = ("Attempt to set Connection::%s (not a valid member)"):format((tostring(v14)))
        error(v16, 2)
    end
}
setmetatable(v3, v9)
local v17 = {}

v17.__index = v17

function v17.new() -- line 54 | captures: v17
    local v18 = { _handlerListHead = false }
    return (setmetatable(v18, v17))
end

function v17.Connect(v19, v20) -- line 58 | captures: v3
    local v21 = v3.new(v19, v20)
    if v19._handlerListHead then
        v21._next = v19._handlerListHead
    end
    v19._handlerListHead = v21
    return v21
end

local function DisconnectAll(v22) -- line 68
    v22._handlerListHead = false
end

v17.DisconnectAll = DisconnectAll
v17.Destroy = v17.DisconnectAll

function v17.Fire(v23, ...) -- line 72 | captures: v1, runEventHandlerInFreeThread
    local v24 = v23._handlerListHead
    while true do
        if v24 then
            if v24._connected then
                if not v1 then
                    v1 = coroutine.create(runEventHandlerInFreeThread)
                    coroutine.resume(v1)
                end
                task.spawn(v1, v24._fn, ...)
            end
        else
            break
        end
        v24 = v24._next
    end
end

local function Wait(v25) -- line 85
    coroutine.running()
    return coroutine.yield()
end

v17.Wait = Wait

local function Once(v26, v27) -- line 90
    local v28
    v28 = v26:Connect(function(...) -- line 92 | captures: v28, v27
        if v28._connected then
            v28:Disconnect()
        end
        v27(...)
    end)
    return v28
end

v17.Once = Once

local v29 = {
    __index = function(v30, v31) -- __index | line 101
        local v32 = ("Attempt to get Signal::%s (not a valid member)"):format((tostring(v31)))
        error(v32, 2)
    end,
    __newindex = function(v33, v34, v35) -- __newindex | line 105
        local v36 = ("Attempt to set Signal::%s (not a valid member)"):format((tostring(v34)))
        error(v36, 2)
    end
}
setmetatable(v17, v29)
return v17
