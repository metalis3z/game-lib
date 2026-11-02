-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function reduceRight(v1, v2, v3) -- line 28
    local v4 = #v1
    local v5
    if v3 == nil then
        v5, v4 = v1[v4], v4 - 1
    else
        v5 = v3
    end
    for v6 = v4, 1, -1 do
        v5 = v2(v5, v1[v6], v6, v1)
    end
    return v5
end

return reduceRight
