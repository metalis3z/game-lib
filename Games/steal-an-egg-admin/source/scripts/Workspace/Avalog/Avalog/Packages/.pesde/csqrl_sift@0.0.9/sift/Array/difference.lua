-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Types)
local toSet = require(script.Parent.toSet)
local toArray = require(script.Parent.Parent.Set.toArray)
local difference = require(script.Parent.Parent.Set.difference)

local function difference_2(v1, ...) -- line 25 | captures: toSet, toArray, difference
    local function v2(v3, ...)
        table.insert(v3, ...)
    end

    local v4 = toSet(v1)
    local v5 = {}
    for v6, v7 in { ... } do
        if typeof(v7) == "table" then
            v2(v5, toSet(v7))
        end
    end
    local v8 = difference(v4, unpack(v5))
    return toArray(v8)
end

return difference_2
