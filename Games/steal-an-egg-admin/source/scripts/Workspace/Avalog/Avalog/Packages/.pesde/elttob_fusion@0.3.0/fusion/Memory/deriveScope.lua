-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local ExternalDebug = require(Parent.ExternalDebug)
local deriveScopeImpl = require(Parent.Memory.deriveScopeImpl)

local function deriveScope(...) -- line 18 | captures: ExternalDebug, deriveScopeImpl
    local v1 = deriveScopeImpl(...)
    ExternalDebug.trackScope(v1)
    return v1
end

return deriveScope
