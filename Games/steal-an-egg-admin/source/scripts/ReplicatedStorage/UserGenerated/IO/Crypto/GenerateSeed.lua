-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local HttpService = game:GetService("HttpService")

local function GenerateEntropy() -- line 7 | captures: HttpService
    local v1 = HttpService:GenerateGUID(false)
    local v2 = string.sub(v1, 1, 8)
    local v3 = tonumber(v2, 16)
    local v4 = string.sub(v1, 10, 13) .. string.sub(v1, 25, 28)
    local v5 = tonumber(v4, 16)
    local v6 = string.sub(v1, 29, 36)
    return v3, v5, (tonumber(v6, 16))
end

return function(v7) -- line 17 | captures: HttpService
    local v8 = table.create(v7, 0)
    local v9 = v7 // 3
    local v10 = v9 - 1
    for v11 = 0, v10 do
        local v12 = HttpService:GenerateGUID(false)
        local v13 = string.sub(v12, 1, 8)
        local v14 = tonumber(v13, 16)
        local v15 = string.sub(v12, 10, 13) .. string.sub(v12, 25, 28)
        local v16 = tonumber(v15, 16)
        local v17 = string.sub(v12, 29, 36)
        v8[v11 * 3 + 1] = v14
        v8[v11 * 3 + 2] = v16
        v8[v11 * 3 + 3] = tonumber(v17, 16)
    end
    local v18 = v7 - v9 * 3
    if v18 == 1 then
        local v19 = HttpService:GenerateGUID(false)
        local v20 = string.sub(v19, 1, 8)
        local v21 = tonumber(v20, 16)
        local v22 = string.sub(v19, 10, 13) .. string.sub(v19, 25, 28)
        tonumber(v22, 16)
        local v23 = string.sub(v19, 29, 36)
        tonumber(v23, 16)
        v8[v7] = v21
    elseif v18 == 2 then
        local v24 = HttpService:GenerateGUID(false)
        local v25 = string.sub(v24, 1, 8)
        local v26 = tonumber(v25, 16)
        local v27 = string.sub(v24, 10, 13) .. string.sub(v24, 25, 28)
        local v28 = tonumber(v27, 16)
        local v29 = string.sub(v24, 29, 36)
        tonumber(v29, 16)
        v8[v7 - 1] = v26
        v8[v7] = v28
    end
    return v8
end
