-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function(v1, v2) -- line 1
    local v3 = v1 > 0
    assert(v3, "Limit must be greater than 0")
    local v4 = {}
    local v5 = 0
    return function(v6) -- line 7 | captures: v5, v1, v2, v4
        if v6 then
            local v7 = v4[v6]
            if v7 == nil then
                task.delay(v2, function() -- line 14 | captures: v6, v4
                    v4[v6] = nil
                end)
                v7 = 0
            end
            if v7 == v1 then
                return false
            end
            v4[v6] = v7 + 1
        else
            if v5 == 0 then
                task.delay(v2, function() -- line 26 | captures: v5
                    v5 = 0
                end)
            end
            if v5 == v1 then
                return false
            end
            v5 += 1
        end
        return true
    end
end
