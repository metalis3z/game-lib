-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)

local function poisonScope(v1, v2) -- line 14 | captures: External
    local v3 = getmetatable(v1)
    if typeof(v3) == "table" and v3._FUSION_POISONED then
        return
    end
    table.clear(v1)
    local v4 = { _FUSION_POISONED = true }

    function v4.__index() -- line 25 | captures: v2, External
        External.logError("poisonedScope", nil, v2)
    end

    function v4.__newindex() -- line 28 | captures: v2, External
        External.logError("poisonedScope", nil, v2)
    end

    setmetatable(v1, v4)
end

return poisonScope
