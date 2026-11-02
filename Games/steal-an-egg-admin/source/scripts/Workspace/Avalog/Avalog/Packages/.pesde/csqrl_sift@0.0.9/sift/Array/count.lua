-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Util = require(script.Parent.Parent.Util)

local function count(v1, v2) -- line 25 | captures: Util
    local v3 = if type(v2) == "function" then v2 else Util.func.truthy
    local v4 = 0
    for v5, v6 in ipairs(v1) do
        if v3(v6, v5, v1) then
            v4 += 1
        end
    end
    return v4
end

return count
