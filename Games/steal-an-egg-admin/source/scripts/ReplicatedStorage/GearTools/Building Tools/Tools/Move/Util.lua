-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return {
    TranslatePartsRelativeToPart = function(v1, v2, v3) -- TranslatePartsRelativeToPart | line 1
        local v4 = v2[v1].CFrame:inverse()
        for v5, v6 in pairs(v2) do
            local v7 = v4 * v6.CFrame
            v5.CFrame = v1.CFrame * v7
        end
        for v8, v9 in pairs(v3) do
            local v10 = v4 * v9.Pivot
            v8.WorldPivot = v1.CFrame * v10
        end
    end,
    GetIncrementMultiple = function(v11, v12) -- GetIncrementMultiple | line 25
        local v13 = v11 % v12
        local v14 = v11 - v13
        local v15 = v11 - v13 + v12
        local v16 = v11 - v14
        local v17 = math.abs(v16)
        local v18 = v11 - v15
        if v17 <= math.abs(v18) then
            return v14
        end
        return v15
    end
}
