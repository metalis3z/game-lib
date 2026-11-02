-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local insert = table.insert

return {
    map = function(v1, v2) -- map | line 3 | captures: insert
        local v3 = {}
        for v4, v5 in ipairs(v1) do
            local v6 = v2(v5, v4)
            if v6 ~= nil then
                insert(v3, v6)
            end
        end
        return v3
    end,
    reduce = function(v7, v8, v9) -- reduce | line 17
        local v10, v11
        if v9 then
            v11 = v9
            v10 = 1
        else
            v11 = v7[1]
            v10 = 2
        end
        local v12 = #v7
        for v13 = v10, v12 do
            v11 = v8(v11, v7[v13], v13)
        end
        return v11
    end
}
