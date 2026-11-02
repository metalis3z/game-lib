-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Util = require(script.Parent.Parent.Util)

local function filter(v1, v2) -- line 24 | captures: Util
    local v3 = {}
    local v4 = if type(v2) == "function" then v2 else Util.func.truthy
    for v5, v6 in pairs(v1) do
        if v4(v6, v5, v1) then
            v3[v5] = v6
        end
    end
    return v3
end

return filter
