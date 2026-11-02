-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local parseError = require(Parent.Logging.parseError)
local v1 = { type = "Contextual" }
local v2 = table.freeze({ __index = v1 })
local v3 = table.freeze({ __mode = "k" })

local function Contextual(v4) -- line 28 | captures: v2, v3
    local v5 = {}
    local v6 = {}
    v5._valuesNow = setmetatable(v6, v3)
    v5._defaultValue = v4
    return (setmetatable(v5, v2))
end

function v1.now(v7) -- line 48
    local v8 = coroutine.running()
    local v9 = v7._valuesNow[v8]
    if typeof(v9) == "table" then
        return v9.value
    end
    return v7._defaultValue
end

function v1.is(v10, v11) -- line 63 | captures: External, parseError
    local v12 = {}

    function v12.during(v13, v14, ...) -- line 69 | captures: v10, v11, External, parseError
        local v15 = coroutine.running()
        local v16 = v10._valuesNow[v15]
        v10._valuesNow[v15] = { value = v11 }
        local v17, v18 = xpcall(v14, parseError, ...)
        v10._valuesNow[v15] = v16
        if not v17 then
            External.logError("callbackError", v18)
        end
        return v18
    end

    return v12
end

table.freeze(v1)
return Contextual
