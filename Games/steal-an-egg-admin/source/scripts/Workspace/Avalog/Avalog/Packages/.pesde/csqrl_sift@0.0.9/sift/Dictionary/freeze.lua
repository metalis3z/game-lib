-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Types)
local copy = require(script.Parent.copy)

local function freeze(v1) -- line 23 | captures: copy
    local v2 = copy(v1)
    table.freeze(v2)
    return v2
end

return freeze
