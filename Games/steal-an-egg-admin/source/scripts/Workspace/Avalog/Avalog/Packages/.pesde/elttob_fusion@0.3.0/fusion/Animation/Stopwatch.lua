-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local checkLifetime = require(Parent.Memory.checkLifetime)
local depend = require(Parent.Graph.depend)
local change = require(Parent.Graph.change)
local peek = require(Parent.State.peek)
local nicknames = require(Parent.Utility.nicknames)
local v1 = {
    type = "State",
    kind = "Stopwatch",
    timeliness = "lazy"
}
local v2 = table.freeze({ __index = v1 })

local function Stopwatch(v3, v4) -- line 44 | captures: checkLifetime, depend, nicknames, v2
    local v5 = {
        awake = true,
        lastChange = nil,
        validity = "invalid",
        _EXTREMELY_DANGEROUS_usedAsValue = 0,
        _measureTimeSince = 0,
        _playing = false,
        createdAt = os.clock(),
        dependencySet = {},
        dependentSet = {},
        scope = v3,
        _timer = v4
    }
    local v6 = setmetatable(v5, v2)

    local function v7() -- line 65 | captures: v6
        v6.scope = nil
    end

    v6.oldestTask = v7
    nicknames[v6.oldestTask] = "Stopwatch"
    table.insert(v3, v7)
    checkLifetime.bOutlivesA(v3, v6.oldestTask, v4.scope, v4.oldestTask, checkLifetime.formatters.parameter, "timer")
    depend(v6, v4)
    return v6
end

function v1.zero(v8) -- line 81 | captures: change, peek
    local v9 = peek(v8._timer)
    if v9 == v8._measureTimeSince then
        return
    end
    v8._measureTimeSince = v9
    v8._EXTREMELY_DANGEROUS_usedAsValue = 0
    change(v8)
end

function v1.pause(v10) -- line 92 | captures: change
    if v10._playing == true then
        v10._playing = false
        change(v10)
    end
end

function v1.unpause(v11) -- line 101 | captures: change, peek
    if v11._playing ~= false then
        return
    end
    v11._playing = true
    v11._measureTimeSince = peek(v11._timer) - v11._EXTREMELY_DANGEROUS_usedAsValue
    change(v11)
end

function v1._evaluate(v12) -- line 111 | captures: depend, peek
    if v12._playing then
        depend(v12, v12._timer)
        local v13 = peek(v12._timer)
        local _EXTREMELY_DANGEROUS_usedAsValue = v12._EXTREMELY_DANGEROUS_usedAsValue
        local v14 = v13 - v12._measureTimeSince
        v12._EXTREMELY_DANGEROUS_usedAsValue = v14
        return _EXTREMELY_DANGEROUS_usedAsValue ~= v14
    end
    return false
end

table.freeze(v1)
return Stopwatch
