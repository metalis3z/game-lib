-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    internalTypeChecks = false,
    typeChecks = false,
    elementTracing = false,
    propValidation = false
}
local v2 = {}
for v3 in pairs(v1) do
    table.insert(v2, v3)
end
local v4 = {}

function v4.new() -- line 35 | captures: v1, v2, v4
    local v5 = {}
    local v6 = {}
    local v7 = {
        __index = function(v8, v9) -- __index | line 39 | captures: v2
            local v10 = ("Invalid global configuration key %q. Valid configuration keys are: %s"):format(tostring(v9), table.concat(v2, ", "))
            error(v10, 3)
        end
    }
    v5._currentConfig = setmetatable(v6, v7)

    function v5.set(...) -- line 54 | captures: v5, v4
        return v4.set(v5, ...)
    end

    function v5.get(...) -- line 58 | captures: v5, v4
        return v4.get(v5, ...)
    end

    function v5.scoped(...) -- line 62 | captures: v5, v4
        return v4.scoped(v5, ...)
    end

    v5.set(v1)
    return v5
end

function v4.set(v11, v12) -- line 71 | captures: v1, v2
    for v13, v14 in pairs(v12) do
        if v1[v13] == nil then
            local v15 = ("Invalid global configuration key %q (type %s). Valid configuration keys are: %s"):format(tostring(v13), typeof(v13), table.concat(v2, ", "))
            error(v15, 3)
        end
        if typeof(v14) ~= "boolean" then
            local v16 = ("Invalid value %q (type %s) for global configuration key %q. Valid values are: true, false"):format(tostring(v14), typeof(v14), (tostring(v13)))
            error(v16, 3)
        end
        v11._currentConfig[v13] = v14
    end
end

local function get(v17) -- line 104
    return v17._currentConfig
end

v4.get = get

local function scoped(v18, v19, v20) -- line 108
    local v21 = {}
    for v22, v23 in pairs(v18._currentConfig) do
        v21[v22] = v23
    end
    v18.set(v19)
    local v24, v25 = pcall(v20)
    v18.set(v21)
    assert(v24, v25)
end

v4.scoped = scoped
return v4
