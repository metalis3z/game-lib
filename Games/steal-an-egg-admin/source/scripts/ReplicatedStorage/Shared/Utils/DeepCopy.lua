-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1

function v1(v2, v3) -- line 7 | captures: v1
    if type(v2) == "table" then
        local v4 = v3[v2]
        if v4 == nil then
            local v5 = {}
            v3[v2] = v5
            for v6, v7 in v2 do
                v5[v1(v6, v3)] = v1(v7, v3)
            end
            return v5
        end
        return v4
    end
    return v2
end

return function(v8) -- line 27 | captures: v1
    local v9 = {}
    return (v1(v8, v9))
end
