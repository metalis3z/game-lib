-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    QueryObject = function(v2, v3, v4) -- QueryObject | line 7
        local v5 = v2
        for v6, v7 in ipairs(string.split(v3, ".")) do
            if v5 == nil then
                return false
            end
            if v5 == v4 then
                return true
            end
            if type(v5) == "table" then
                v5 = v5[v7]
            else
                return false
            end
        end
        if v5 == nil then
            return false
        end
        if v5 == v4 then
            return true
        end
        return true, v5
    end,
    HasHierarchicalOverlap = function(v8, v9) -- HasHierarchicalOverlap | line 29
        if v8 ~= v9 then
            local v10 = string.split(v8, ".")
            local v11 = string.split(v9, ".")
            local v12 = #v10
            local v13 = #v11
            local v14 = math.min(v12, v13)
            for v15 = 1, v14 do
                if v10[v15] ~= v11[v15] then
                    return false
                end
            end
        end
        return true
    end
}
return table.freeze(v1)
