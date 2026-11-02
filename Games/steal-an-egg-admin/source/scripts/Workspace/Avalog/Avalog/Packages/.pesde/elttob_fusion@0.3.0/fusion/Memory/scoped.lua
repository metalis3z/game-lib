-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local ExternalDebug = require(Parent.ExternalDebug)
local merge = require(Parent.Utility.merge)
local scopePool = require(Parent.Memory.scopePool)

local function scoped(...) -- line 16 | captures: ExternalDebug, merge, scopePool
    local v1 = scopePool.reuseAny() or {}
    local v2 = { __index = merge(false, {}, ...) }
    local v3 = setmetatable(v1, v2)
    ExternalDebug.trackScope(v3)
    return v3
end

return scoped
