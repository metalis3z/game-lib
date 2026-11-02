-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Type = require(script.Parent.Type)
local Symbol = require(script.Parent.Symbol)

local function noop() -- line 4
    return nil
end

local v1 = { UseParentKey = Symbol.named("UseParentKey") }

function v1.iterateElements(v2) -- line 40 | captures: Type, noop, v1
    if Type.of(v2) == Type.Element then
        local v3 = false
        return function() -- line 47 | captures: v3, v2, v1
            if v3 then
                return nil
            end
            v3 = true
            return v1.UseParentKey, v2
        end
    end
    local v4 = typeof(v2)
    if v2 == nil or v4 == "boolean" then
        return noop
    end
    if v4 == "table" then
        return pairs(v2)
    end
    error("Invalid elements")
end

function v1.getElementByKey(v5, v6) -- line 79 | captures: Type, v1
    if v5 == nil or typeof(v5) == "boolean" then
        return nil
    end
    if Type.of(v5) == Type.Element then
        if v6 == v1.UseParentKey then
            return v5
        end
        return nil
    end
    if typeof(v5) == "table" then
        return v5[v6]
    end
    error("Invalid elements")
end

return v1
