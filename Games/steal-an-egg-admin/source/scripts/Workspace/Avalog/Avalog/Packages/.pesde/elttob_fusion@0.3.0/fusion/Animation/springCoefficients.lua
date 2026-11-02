-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function springCoefficients(v1, v2, v3) -- line 22
    if v1 == 0 or v3 == 0 then
        return 1, 0, 0, 1
    end
    if v2 > 1 then
        local v4 = v2 ^ 2 - 1
        local v5 = math.sqrt(v4)
        local v6 = -0.5 / (v5 * v3)
        local v7 = v3 * (v5 + v2) * -1
        local v8 = v3 * (v5 - v2)
        local v9 = v1 * v7
        local v10 = math.exp(v9)
        local v11 = v1 * v8
        local v12 = math.exp(v11)
        return (v12 * v7 - v10 * v8) * v6, (v10 - v12) * v6 / v3, (v12 - v10) * v6 * v3, (v10 * v7 - v12 * v8) * v6
    end
    if v2 == 1 then
        local v13 = v1 * v3
        local v14 = v13 * -1
        local v15 = math.exp(v14)
        return v15 * (v13 + 1), v15 * v1, v15 * (v14 * v3), v15 * (v14 + 1)
    end
    local v16 = 1 - v2 ^ 2
    local v17 = v3 * math.sqrt(v16)
    local v18 = 1 / v17
    local v19 = v1 * -1 * v3 * v2
    local v20 = math.exp(v19)
    local v21 = v17 * v1
    local v22 = math.sin(v21)
    local v23 = v17 * v1
    local v24 = math.cos(v23)
    local v25 = v20 * v22
    local v26 = v20 * v24
    local v27 = v25 * v3 * v2 * v18
    return v27 + v26, v25 * v18, (v25 * v17 + v3 * v2 * v27) * -1, v26 - v27
end

return springCoefficients
