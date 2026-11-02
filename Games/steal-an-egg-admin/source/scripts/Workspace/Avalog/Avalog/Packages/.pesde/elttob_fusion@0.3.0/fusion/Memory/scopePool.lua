-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local poisonScope = require(Parent.Memory.poisonScope)
local ExternalDebug = require(Parent.ExternalDebug)
local v1 = {}
local v2 = 0
local v3 = {}

function v3.giveIfEmpty(v4) -- line 18 | captures: poisonScope, ExternalDebug
    if next(v4) == nil then
        ExternalDebug.untrackScope(v4)
        poisonScope(v4, "previously passed to the internal scope pool, which indicates a Fusion bug.")
        return nil
    end
    return v4
end

function v3.clearAndGive(v5) -- line 34 | captures: poisonScope, ExternalDebug
    ExternalDebug.untrackScope(v5)
    table.clear(v5)
    poisonScope(v5, "previously passed to the internal scope pool, which indicates a Fusion bug.")
end

function v3.reuseAny() -- line 46 | captures: v2, v1
    if v2 == 0 then
        return nil
    end
    local v6 = v1[v2]
    v2 -= 1
    return v6
end

return v3
