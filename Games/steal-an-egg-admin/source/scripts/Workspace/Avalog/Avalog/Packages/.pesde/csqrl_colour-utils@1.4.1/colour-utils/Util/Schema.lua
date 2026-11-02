-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return {
    Loose = function(v1, v2) -- Loose | line 1
        if type(v2) == "table" then
            local v3 = {}
            for v4, v5 in pairs(v1) do
                v3[v4] = v2[v4] or v5
            end
            return v3
        end
        return v1
    end,
    Strict = function(v6, v7) -- Strict | line 15
        if type(v7) == "table" then
            local v8 = {}
            for v9, v10 in pairs(v6) do
                local v11 = v7[v9]
                if typeof(v11) == typeof(v10) then
                    v8[v9] = v7[v9]
                else
                    v8[v9] = v10
                end
            end
            return v8
        end
        return v6
    end
}
