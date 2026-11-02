-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Logging = require(script.Parent.Logging)
local v1 = {
    Disabled = "Disabled",
    Suspended = "Suspended",
    Enabled = "Enabled"
}
local v2 = {}

v2.__index = v2

function v2.new(v3) -- line 23 | captures: v2
    local v4 = {
        _status = "Disabled",
        _isResuming = false,
        _suspendedEventQueue = {},
        _connections = {},
        _listeners = {},
        _instance = v3
    }
    return (setmetatable(v4, v2))
end

local function connectEvent(v5, v6, v7) -- line 51
    v5:_connect(v6, v5._instance[v6], v7)
end

v2.connectEvent = connectEvent

local function connectPropertyChange(v8, v9, v10) -- line 55
    local v11, v12 = pcall(function() -- line 56 | captures: v8, v9
        return v8._instance:GetPropertyChangedSignal(v9)
    end)
    if not v11 then
        error(("Cannot get changed signal on property %q: %s"):format(tostring(v9), v12), 0)
    end
    v8:_connect("Change." .. v9, v12, v10)
end

v2.connectPropertyChange = connectPropertyChange

local function _connect(v13, v14, v15, v16) -- line 70
    if v16 == nil then
        if v13._connections[v14] ~= nil then
            v13._connections[v14]:Disconnect()
            v13._connections[v14] = nil
        end
        v13._listeners[v14] = nil
    else
        if v13._connections[v14] == nil then
            v13._connections[v14] = v15:Connect(function(...) -- line 81 | captures: v13, v14
                if v13._status == "Enabled" then
                    v13._listeners[v14](v13._instance, ...)
                elseif v13._status == "Suspended" then
                    local v17 = select("#", ...)
                    local _suspendedEventQueue = v13._suspendedEventQueue
                    local v18 = {
                        v14,
                        v17,
                        ...
                    }
                    table.insert(_suspendedEventQueue, v18)
                end
            end)
        end
        v13._listeners[v14] = v16
    end
end

v2._connect = _connect

local function suspend(v19) -- line 98
    v19._status = "Suspended"
end

v2.suspend = suspend

function v2.resume(v20) -- line 102 | captures: Logging
    if v20._isResuming then
        return
    end
    v20._isResuming = true
    local v21 = 1
    while true do
        if v21 <= #v20._suspendedEventQueue then
            local v22 = v20._suspendedEventQueue[v21]
            local v23 = v20._listeners[v22[1]]
            local v24 = v22[2]
            if v23 ~= nil then
                local v25 = coroutine.create(v23)
                local resume = coroutine.resume
                local _instance = v20._instance
                local v26 = 2 + v24
                local v27, v28 = resume(v25, _instance, unpack(v22, 3, v26))
                if not v27 then
                    Logging.warn("%s", v28)
                end
            end
        else
            break
        end
        v21 += 1
    end
    v20._isResuming = false
    v20._status = "Enabled"
    v20._suspendedEventQueue = {}
end

return v2
