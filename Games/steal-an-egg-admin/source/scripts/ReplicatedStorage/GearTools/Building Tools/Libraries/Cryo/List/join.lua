-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local None = require(script.Parent.Parent.None)

local function join(...) -- line 6 | captures: None
    local v1 = {}
    local v2 = select("#", ...)
    for v3 = 1, v2 do
        local v4 = select(v3, ...)
        local v5 = #v1
        local v6 = #v4
        for v7 = 1, v6 do
            if v4[v7] == None then
                v5 -= 1
            else
                v1[v5 + v7] = v4[v7]
            end
        end
    end
    return v1
end

return join
