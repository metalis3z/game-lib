-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent
local formatError = require(Parent.Logging.formatError)
require(Parent.Types)
local v1 = { safetyTimerMultiplier = 1 }
local v2 = {}
local v3
local v4 = 0

function v1.setExternalProvider(v5) -- line 36 | captures: v3
    local v6 = v3
    if v6 ~= nil then
        v6.stopScheduler()
    end
    v3 = v5
    if v5 ~= nil then
        v5.startScheduler()
    end
    return v6
end

local function isTimeCritical() -- line 53
    return false
end

v1.isTimeCritical = isTimeCritical

function v1.doTaskImmediate(v7) -- line 60 | captures: v3, v1
    if v3 == nil then
        v1.logError("noTaskScheduler")
    else
        v3.doTaskImmediate(v7)
    end
end

function v1.doTaskDeferred(v8) -- line 73 | captures: v3, v1
    if v3 == nil then
        v1.logError("noTaskScheduler")
    else
        v3.doTaskDeferred(v8)
    end
end

function v1.logError(v9, v10, ...) -- line 86 | captures: v3, formatError
    error(formatError(v3, v9, v10, ...), 0)
end

function v1.logErrorNonFatal(v11, v12, ...) -- line 97 | captures: v3, formatError
    local v13 = formatError(v3, v11, v12, ...)
    if v3 == nil then
        print(v13)
    else
        v3.logErrorNonFatal(v13)
    end
end

function v1.logWarn(v14, ...) -- line 113 | captures: v3, formatError
    local v15 = formatError(v3, v14, debug.traceback(nil, 2), ...)
    if v3 == nil then
        print(v15)
    else
        v3.logWarn(v15)
    end
end

function v1.bindToUpdateStep(v16) -- line 135 | captures: v2
    local v17 = {}
    v2[v17] = v16
    return function() -- line 142 | captures: v17, v2
        v2[v17] = nil
    end
end

function v1.performUpdateStep(v18) -- line 152 | captures: v4, v2
    v4 = v18
    for v19, v20 in v2 do
        v20(v18)
    end
end

function v1.lastUpdateStep() -- line 164 | captures: v4
    return v4
end

return v1
