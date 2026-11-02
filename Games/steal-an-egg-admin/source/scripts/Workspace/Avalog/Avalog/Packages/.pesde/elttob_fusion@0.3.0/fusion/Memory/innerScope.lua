-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local ExternalDebug = require(Parent.ExternalDebug)
local deriveScopeImpl = require(Parent.Memory.deriveScopeImpl)

local function innerScope(v1, ...) -- line 15 | captures: ExternalDebug, deriveScopeImpl
    local v2 = deriveScopeImpl(v1, ...)
    table.insert(v1, v2)

    local function v3() -- line 23 | captures: v1, v2
        local v4 = table.find(v1, v2)
        if v4 ~= nil then
            table.remove(v1, v4)
        end
    end

    table.insert(v2, v3)
    ExternalDebug.trackScope(v2)
    return v2
end

return innerScope
