-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1

local function acquireRunnerThreadAndCallEventHandler(v2, ...) -- line 44 | captures: v1
    local v3 = v1
    v1 = nil
    v2(...)
    v1 = v3
end

local function runEventHandlerInFreeThread(...) -- line 55 | captures: acquireRunnerThreadAndCallEventHandler
    acquireRunnerThreadAndCallEventHandler(...)
    while true do
        acquireRunnerThreadAndCallEventHandler(coroutine.yield())
    end
end

local v4 = {}

v4.__index = v4

local function Disconnect(v5) -- line 81
    if v5.Connected then
        v5.Connected = false
        if v5._signal._handlerListHead == v5 then
            v5._signal._handlerListHead = v5._next
        else
            local v6 = v5._signal._handlerListHead
            while v6 do
                if v6._next == v5 then
                    break
                end
                v6 = v6._next
            end
            if v6 then
                v6._next = v5._next
            end
        end
    end
end

v4.Disconnect = Disconnect
v4.Destroy = v4.Disconnect

local v7 = {
    __index = function(v8, v9) -- __index | line 108
        error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(v9))), 2)
    end,
    __newindex = function(v10, v11, v12) -- __newindex | line 111
        error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(v11))), 2)
    end
}
setmetatable(v4, v7)
local v13 = {}

v13.__index = v13

function v13.new() -- line 153 | captures: v13
    local v14 = {
        _handlerListHead = false,
        _proxyHandler = nil,
        _yieldedThreads = nil
    }
    return (setmetatable(v14, v13))
end

function v13.Wrap(v15) -- line 176 | captures: v13
    local v16 = typeof(v15) == "RBXScriptSignal"
    local v17 = "Argument #1 to Signal.Wrap must be a RBXScriptSignal; got " .. typeof(v15)
    assert(v16, v17)
    local v18 = v13.new()
    v18._proxyHandler = v15:Connect(function(...) -- line 183 | captures: v18
        v18:Fire(...)
    end)
    return v18
end

function v13.Is(v19) -- line 196 | captures: v13
    if type(v19) == "table" then
        return getmetatable(v19) == v13
    end
    return false
end

function v13.Connect(v20, v21) -- line 213 | captures: v4
    local v22 = {
        Connected = true,
        _next = false,
        _signal = v20,
        _fn = v21
    }
    local v23 = setmetatable(v22, v4)
    if v20._handlerListHead then
        v23._next = v20._handlerListHead
    end
    v20._handlerListHead = v23
    return v23
end

local function ConnectOnce(v24, v25) -- line 236
    return v24:Once(v25)
end

v13.ConnectOnce = ConnectOnce

local function Once(v26, v27) -- line 255
    local v28
    local v29 = false
    v28 = v26:Connect(function(...) -- line 259 | captures: v28, v29, v27
        if v29 then
            return
        end
        v29 = true
        v28:Disconnect()
        v27(...)
    end)
    return v28
end

v13.Once = Once

local function GetConnections(v30) -- line 272
    local v31 = {}
    local v32 = v30._handlerListHead
    while v32 do
        table.insert(v31, v32)
        v32 = v32._next
    end
    return v31
end

v13.GetConnections = GetConnections

local function DisconnectAll(v33) -- line 292
    local v34 = v33._handlerListHead
    while v34 do
        v34.Connected = false
        v34 = v34._next
    end
    v33._handlerListHead = false
    local _yieldedThreads = rawget(v33, "_yieldedThreads")
    if _yieldedThreads then
        for v35 in _yieldedThreads do
            if coroutine.status(v35) == "suspended" then
                warn(debug.traceback(v35, "signal disconnected; yielded thread cancelled", 2))
                task.cancel(v35)
            end
        end
        table.clear(v33._yieldedThreads)
    end
end

v13.DisconnectAll = DisconnectAll

function v13.Fire(v36, ...) -- line 327 | captures: v1, runEventHandlerInFreeThread
    local v37 = v36._handlerListHead
    while true do
        if v37 then
            if v37.Connected then
                v1 = v1 or coroutine.create(runEventHandlerInFreeThread)
                task.spawn(v1, v37._fn, ...)
            end
        else
            break
        end
        v37 = v37._next
    end
end

local function FireDeferred(v38, ...) -- line 348
    local v39 = v38._handlerListHead
    while v39 do
        local defer = task.defer
        local v40 = v39
        defer(function(...) -- line 352 | captures: v40
            if v40.Connected then
                v40._fn(...)
            end
        end, ...)
        v39 = v39._next
    end
end

v13.FireDeferred = FireDeferred

local function Wait(v41) -- line 376
    local _yieldedThreads = rawget(v41, "_yieldedThreads")
    local _yieldedThreads_2 = _yieldedThreads
    if not _yieldedThreads then
        _yieldedThreads = {}
        _yieldedThreads_2 = _yieldedThreads
        rawset(v41, "_yieldedThreads", _yieldedThreads)
    end
    local v42 = coroutine.running()
    _yieldedThreads[v42] = true
    v41:Once(function(...) -- line 386 | captures: _yieldedThreads_2, v42
        _yieldedThreads_2[v42] = nil
        if coroutine.status(v42) == "suspended" then
            task.spawn(v42, ...)
        end
    end)
    return coroutine.yield()
end

v13.Wait = Wait

local function Destroy(v43) -- line 409
    v43:DisconnectAll()
    local _proxyHandler = rawget(v43, "_proxyHandler")
    if _proxyHandler then
        _proxyHandler:Disconnect()
    end
end

v13.Destroy = Destroy

local v44 = {
    __index = function(v45, v46) -- __index | line 420
        error(("Attempt to get Signal::%s (not a valid member)"):format((tostring(v46))), 2)
    end,
    __newindex = function(v47, v48, v49) -- __newindex | line 423
        error(("Attempt to set Signal::%s (not a valid member)"):format((tostring(v48))), 2)
    end
}
setmetatable(v13, v44)
return table.freeze({
    new = v13.new,
    Wrap = v13.Wrap,
    Is = v13.Is
})
