-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function fromArrays(v1, v2) -- line 20
    local v3 = #v1
    local v4 = {}
    for v5 = 1, v3 do
        v4[v1[v5]] = v2[v5]
    end
    return v4
end

return fromArrays
