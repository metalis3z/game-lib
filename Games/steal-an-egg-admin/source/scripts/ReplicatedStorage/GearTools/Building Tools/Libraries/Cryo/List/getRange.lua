-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function getRange(v1, v2, v3) -- line 5
    local v4 = v2 <= v3
    assert(v4, "startIndex must be less than or equal to endIndex")
    local v5 = {}
    local v6 = math.max(1, v2)
    local v7 = #v1
    local v8 = math.min(v7, v3)
    local v9 = 1
    for v10 = v6, v8 do
        v5[v9] = v1[v10]
        v9 += 1
    end
    return v5
end

return getRange
