-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1

local function acquireRunnerThreadAndCallEventHandler(v2, ...) -- line 54 | captures: v1
    local v3 = v1
    v1 = nil
    v2(...)
    v1 = v3
end

local function runEventHandlerInFreeThread() -- line 65 | captures: acquireRunnerThreadAndCallEventHandler
    while true do
        acquireRunnerThreadAndCallEventHandler(coroutine.yield())
    end
end

local v4 = {}

v4.__index = v4

function v4.new(v5, v6) -- line 80 | captures: v4
    local v7 = {
        _connected = true,
        _next = false,
        _signal = v5,
        _fn = v6
    }
    return (setmetatable(v7, v4))
end

local function Disconnect(v8) -- line 89
    v8._connected = false
    if v8._signal._handlerListHead == v8 then
        v8._signal._handlerListHead = v8._next
    else
        local v9 = v8._signal._handlerListHead
        while v9 do
            if v9._next == v8 then
                break
            end
            v9 = v9._next
        end
        if v9 then
            v9._next = v8._next
        end
    end
end

v4.Disconnect = Disconnect
v4.Destroy = v4.Disconnect

local v10 = {
    __index = function(v11, v12) -- __index | line 113
        error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(v12))), 2)
    end,
    __newindex = function(v13, v14, v15) -- __newindex | line 116
        error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(v14))), 2)
    end
}
setmetatable(v4, v10)
local v16 = { ClassName = "Signal" }

v16.__index = v16

function v16.new() -- line 130 | captures: v16
    local v17 = { _handlerListHead = false }
    return (setmetatable(v17, v16))
end

function v16.isSignal(v18) -- line 142 | captures: v16
    if type(v18) == "table" then
        return getmetatable(v18) == v16
    end
    return false
end

function v16.Connect(v19, v20) -- line 153 | captures: v4
    local v21 = v4.new(v19, v20)
    if v19._handlerListHead then
        v21._next = v19._handlerListHead
    end
    v19._handlerListHead = v21
    return v21
end

local function DisconnectAll(v22) -- line 172
    v22._handlerListHead = false
end

v16.DisconnectAll = DisconnectAll

function v16.Fire(v23, ...) -- line 188 | captures: v1, runEventHandlerInFreeThread
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

local function Wait(v25) -- line 214
    local v26 = coroutine.running()
    local v27
    v27 = v25:Connect(function(...) -- line 217 | captures: v27, v26
        v27:Disconnect()
        task.spawn(v26, ...)
    end)
    return coroutine.yield()
end

v16.Wait = Wait

local function Once(v28, v29) -- line 235
    local v30
    v30 = v28:Connect(function(...) -- line 237 | captures: v30, v29
        if v30._connected then
            v30:Disconnect()
        end
        v29(...)
    end)
    return v30
end

v16.Once = Once
v16.Destroy = v16.DisconnectAll

local v31 = {
    __index = function(v32, v33) -- __index | line 256
        error(("Attempt to get Signal::%s (not a valid member)"):format((tostring(v33))), 2)
    end,
    __newindex = function(v34, v35, v36) -- __newindex | line 259
        error(("Attempt to set Signal::%s (not a valid member)"):format((tostring(v35))), 2)
    end
}
setmetatable(v16, v31)
return v16
