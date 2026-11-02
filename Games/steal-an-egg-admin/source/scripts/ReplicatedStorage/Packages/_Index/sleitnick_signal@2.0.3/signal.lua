-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1
local Packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages")
local v2 = require(Packages:WaitForChild("t"))

local function acquireRunnerThreadAndCallEventHandler(v3, ...) -- line 10 | captures: v1
    v1 = nil
    v3(...)
end

local function runEventHandlerInFreeThread(...) -- line 15 | captures: acquireRunnerThreadAndCallEventHandler
    acquireRunnerThreadAndCallEventHandler(...)
    while true do
        acquireRunnerThreadAndCallEventHandler(coroutine.yield())
    end
end

local function getOrCreateReusableRunnerThread(...) -- line 21 | captures: v1, runEventHandlerInFreeThread
    v1 = v1 or coroutine.create(runEventHandlerInFreeThread)
    task.spawn(v1, ...)
end

local v4 = {}

v4.__index = v4

local function Disconnect(v5) -- line 29
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
    __index = function(v8, v9) -- __index | line 52
        local v10 = ("Attempt to get Connection::%s (not a valid member)"):format((tostring(v9)))
        error(v10, 2)
    end,
    __newindex = function(v11, v12, v13) -- __newindex | line 56
        local v14 = ("Attempt to set Connection::%s (not a valid member)"):format((tostring(v12)))
        error(v14, 2)
    end
}
setmetatable(v4, v7)
local v15 = {}

v15.__index = v15

function v15._deployStickyBehavior(v16, v17) -- line 63 | captures: getOrCreateReusableRunnerThread
    local _stickyBehavior = rawget(v16, "_stickyBehavior")
    if _stickyBehavior then
        getOrCreateReusableRunnerThread(_stickyBehavior, v17)
    end
end

function v15.new(v18) -- line 70 | captures: v2, v15
    v2.strict(v2.optional(v2.callback))(v18)
    local v19 = {
        _handlerListHead = false,
        _stickyBehavior = v18
    }
    return (setmetatable(v19, v15))
end

function v15.Wrap(v20) -- line 76 | captures: v15
    local v21 = typeof(v20) == "RBXScriptSignal"
    local v22 = "Argument #1 to Signal.Wrap must be a RBXScriptSignal; got " .. typeof(v20)
    assert(v21, v22)
    local v23 = v15.new()
    v23._proxyHandler = v20:Connect(function(...) -- line 80 | captures: v23
        v23:Fire(...)
    end)
    return v23
end

function v15.Is(v24) -- line 85 | captures: v15
    if type(v24) == "table" then
        return getmetatable(v24) == v15
    end
    return false
end

function v15.Connect(v25, v26) -- line 93 | captures: v4
    local v27 = {
        Connected = true,
        _next = false,
        _signal = v25,
        _fn = v26
    }
    local v28 = setmetatable(v27, v4)
    if v25._handlerListHead then
        v28._next = v25._handlerListHead
    end
    v25._handlerListHead = v28
    v25:_deployStickyBehavior(v26)
    return v28
end

local function ConnectOnce(v29, v30) -- line 104
    return v29:Once(v30)
end

v15.ConnectOnce = ConnectOnce

local function Once(v31, v32) -- line 107
    local v33
    local v34 = false
    v33 = v31:Connect(function(...) -- line 110 | captures: v33, v34, v32
        if v34 then
            return
        end
        v34 = true
        v33:Disconnect()
        v32(...)
    end)
    return v33
end

v15.Once = Once

local function GetConnections(v35) -- line 120
    local v36 = {}
    local v37 = v35._handlerListHead
    while v37 do
        table.insert(v36, v37)
        v37 = v37._next
    end
    return v36
end

v15.GetConnections = GetConnections

local function DisconnectAll(v38) -- line 129
    local v39 = v38._handlerListHead
    while v39 do
        v39.Connected = false
        v39 = v39._next
    end
    v38._handlerListHead = false
    local _yieldedThreads = rawget(v38, "_yieldedThreads")
    if _yieldedThreads then
        for v40 in _yieldedThreads do
            if coroutine.status(v40) == "suspended" then
                warn(debug.traceback(v40, "signal disconnected; yielded thread cancelled", 2))
                task.cancel(v40)
            end
        end
        table.clear(v38._yieldedThreads)
    end
end

v15.DisconnectAll = DisconnectAll

function v15.Fire(v41, ...) -- line 150 | captures: getOrCreateReusableRunnerThread
    local v42 = v41._handlerListHead
    while true do
        if v42 then
            if v42.Connected then
                getOrCreateReusableRunnerThread(v42._fn, ...)
            end
        else
            break
        end
        v42 = v42._next
    end
end

local function FireDeferred(v43, ...) -- line 159
    local v44 = v43._handlerListHead
    while v44 do
        local defer = task.defer
        local v45 = v44
        defer(function(...) -- line 163 | captures: v45
            if v45.Connected then
                v45._fn(...)
            end
        end, ...)
        v44 = v44._next
    end
end

v15.FireDeferred = FireDeferred

local function Wait(v46) -- line 171
    local _yieldedThreads = rawget(v46, "_yieldedThreads")
    local _yieldedThreads_2 = _yieldedThreads
    if not _yieldedThreads then
        _yieldedThreads = {}
        _yieldedThreads_2 = _yieldedThreads
        rawset(v46, "_yieldedThreads", _yieldedThreads)
    end
    local v47 = coroutine.running()
    _yieldedThreads[v47] = true
    v46:Once(function(...) -- line 179 | captures: _yieldedThreads_2, v47
        _yieldedThreads_2[v47] = nil
        if coroutine.status(v47) == "suspended" then
            task.spawn(v47, ...)
        end
    end)
    return coroutine.yield()
end

v15.Wait = Wait

local function Destroy(v48, v49) -- line 187
    v48:DisconnectAll()
    local _proxyHandler = rawget(v48, "_proxyHandler")
    if _proxyHandler then
        _proxyHandler:Disconnect()
    end
    if v49 then
        setmetatable(v48, nil)
        table.clear(v48)
    end
end

v15.Destroy = Destroy

local v50 = {
    __index = function(v51, v52) -- __index | line 200
        local v53 = ("Attempt to get Signal::%s (not a valid member)"):format((tostring(v52)))
        error(v53, 2)
    end,
    __newindex = function(v54, v55, v56) -- __newindex | line 204
        local v57 = ("Attempt to set Signal::%s (not a valid member)"):format((tostring(v55)))
        error(v57, 2)
    end
}
setmetatable(v15, v50)
return table.freeze({
    new = v15.new,
    Wrap = v15.Wrap,
    Is = v15.Is
})
