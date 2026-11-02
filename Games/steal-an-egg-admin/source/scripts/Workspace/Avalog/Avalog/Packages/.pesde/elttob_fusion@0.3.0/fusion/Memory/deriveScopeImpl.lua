-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local merge = require(Parent.Utility.merge)
local scopePool = require(Parent.Memory.scopePool)

local function deriveScopeImpl(v1, v2, ...) -- line 20 | captures: merge, scopePool
    local v3 = getmetatable(v1)
    if v2 ~= nil then
        v3 = table.clone(v3)
        v3.__index = merge(true, {}, v3.__index, merge(false, {}, v2, ...))
    end
    local v4 = scopePool.reuseAny() or {}
    return (setmetatable(v4, v3))
end

return deriveScopeImpl
