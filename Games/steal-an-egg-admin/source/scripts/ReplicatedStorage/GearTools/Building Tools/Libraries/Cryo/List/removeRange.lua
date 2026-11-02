-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function removeRange(v1, v2, v3) -- line 4
    local v4 = v2 <= v3
    assert(v4, "startIndex must be less than or equal to endIndex")
    local v5 = {}
    local v6 = #v1
    local v7 = v2 - 1
    local v8 = math.min(v6, v7)
    local v9 = 1
    for v10 = 1, v8 do
        v5[v9] = v1[v10]
        v9 += 1
    end
    local v11 = v3 + 1
    local v12 = #v1
    for v13 = v11, v12 do
        v5[v9] = v1[v13]
        v9 += 1
    end
    return v5
end

return removeRange
