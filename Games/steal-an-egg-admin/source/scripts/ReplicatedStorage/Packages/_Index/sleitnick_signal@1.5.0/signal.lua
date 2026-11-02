-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1

local function acquireRunnerThreadAndCallEventHandler(v2, ...) -- line 7 | captures: v1
    v1 = nil
    v2(...)
end

local function runEventHandlerInFreeThread(...) -- line 12 | captures: acquireRunnerThreadAndCallEventHandler
    acquireRunnerThreadAndCallEventHandler(...)
    while true do
        acquireRunnerThreadAndCallEventHandler(coroutine.yield())
    end
end

local v3 = {}

v3.__index = v3

function v3.new(v4, v5) -- line 20 | captures: v3
    local v6 = {
        Connected = true,
        _next = false,
        _signal = v4,
        _fn = v5
    }
    return (setmetatable(v6, v3))
end

local function Disconnect(v7) -- line 24
    if v7.Connected then
        v7.Connected = false
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
end

v3.Disconnect = Disconnect
v3.Destroy = v3.Disconnect

local v9 = {
    __index = function(v10, v11) -- __index | line 47
        local v12 = ("Attempt to get Connection::%s (not a valid member)"):format((tostring(v11)))
        error(v12, 2)
    end,
    __newindex = function(v13, v14, v15) -- __newindex | line 51
        local v16 = ("Attempt to set Connection::%s (not a valid member)"):format((tostring(v14)))
        error(v16, 2)
    end
}
setmetatable(v3, v9)
local v17 = {}

v17.__index = v17

function v17.new() -- line 58 | captures: v17
    local v18 = { _handlerListHead = false }
    return (setmetatable(v18, v17))
end

function v17.Wrap(v19) -- line 62 | captures: v17
    local v20 = typeof(v19) == "RBXScriptSignal"
    local v21 = "Argument #1 to Signal.Wrap must be a RBXScriptSignal; got " .. typeof(v19)
    assert(v20, v21)
    local v22 = v17.new()
    v22._proxyHandler = v19:Connect(function(...) -- line 66 | captures: v22
        v22:Fire(...)
    end)
    return v22
end

function v17.Is(v23) -- line 71 | captures: v17
    if type(v23) == "table" then
        return getmetatable(v23) == v17
    end
    return false
end

function v17.Connect(v24, v25) -- line 79 | captures: v3
    local v26 = v3.new(v24, v25)
    if v24._handlerListHead then
        v26._next = v24._handlerListHead
    end
    v24._handlerListHead = v26
    return v26
end

local function ConnectOnce(v27, v28) -- line 89
    return v27:Once(v28)
end

v17.ConnectOnce = ConnectOnce

local function Once(v29, v30) -- line 92
    local v31
    local v32 = false
    v31 = v29:Connect(function(...) -- line 95 | captures: v31, v32, v30
        if v32 then
            return
        end
        v32 = true
        v31:Disconnect()
        v30(...)
    end)
    return v31
end

v17.Once = Once

local function GetConnections(v33) -- line 105
    local v34 = {}
    local v35 = v33._handlerListHead
    while v35 do
        table.insert(v34, v35)
        v35 = v35._next
    end
    return v34
end

v17.GetConnections = GetConnections

local function DisconnectAll(v36) -- line 114
    local v37 = v36._handlerListHead
    while v37 do
        v37.Connected = false
        v37 = v37._next
    end
    v36._handlerListHead = false
end

v17.DisconnectAll = DisconnectAll

function v17.Fire(v38, ...) -- line 122 | captures: v1, runEventHandlerInFreeThread
    local v39 = v38._handlerListHead
    while true do
        if v39 then
            if v39.Connected then
                v1 = v1 or coroutine.create(runEventHandlerInFreeThread)
                task.spawn(v1, v39._fn, ...)
            end
        else
            break
        end
        v39 = v39._next
    end
end

local function FireDeferred(v40, ...) -- line 134
    local v41 = v40._handlerListHead
    while v41 do
        task.defer(v41._fn, ...)
        v41 = v41._next
    end
end

v17.FireDeferred = FireDeferred

local function Wait(v42) -- line 141
    coroutine.running()
    return coroutine.yield()
end

v17.Wait = Wait

local function Destroy(v43) -- line 147
    v43:DisconnectAll()
    local _proxyHandler = rawget(v43, "_proxyHandler")
    if _proxyHandler then
        _proxyHandler:Disconnect()
    end
end

v17.Destroy = Destroy

local v44 = {
    __index = function(v45, v46) -- __index | line 155
        local v47 = ("Attempt to get Signal::%s (not a valid member)"):format((tostring(v46)))
        error(v47, 2)
    end,
    __newindex = function(v48, v49, v50) -- __newindex | line 159
        local v51 = ("Attempt to set Signal::%s (not a valid member)"):format((tostring(v49)))
        error(v51, 2)
    end
}
setmetatable(v17, v44)

return {
    new = v17.new,
    Wrap = v17.Wrap,
    Is = v17.Is
}
