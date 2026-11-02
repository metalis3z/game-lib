-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function reduce(v1, v2, v3) -- line 27
    local v4, v5
    if v3 == nil then
        v5 = v1[1]
        v4 = 2
    else
        v5 = v3
        v4 = 1
    end
    local v6 = #v1
    for v7 = v4, v6 do
        v5 = v2(v5, v1[v7], v7, v1)
    end
    return v5
end

return reduce
