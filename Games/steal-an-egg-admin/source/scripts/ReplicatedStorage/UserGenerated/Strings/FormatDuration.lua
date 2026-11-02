-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = { 0, 2, 2, 2 }
return function(v2) -- line 7 | captures: v1
    local v3 = type(v2) == "number"
    assert(v3)
    if v2 == (1/0) then
        return "Infinity"
    end
    if v2 == v2 then
        local v4 = math.max(0, v2)
        local v5 = math.ceil(v4)
        local v6 = v5 % 60
        local v7 = v5 // 60
        local v8 = v7 % 60
        local v9 = v7 // 60
        local v10 = {
            v9 // 24,
            v9 % 24,
            v8,
            v6
        }
        local v11 = #v10
        for v12, v13 in ipairs(v10) do
            if v13 > 0 then
                v11 = v12
                break
            end
        end
        if v11 == #v10 then
            return tostring(v6) .. "s"
        end
        local v14 = v10[v11]
        local v15 = { (tostring(v14)) }
        local v16 = #v10
        local v17 = v11 + 1
        for v18 = v17, v16 do
            local v19 = v10[v18]
            local v20 = tostring(v19)
            while #v20 < v1[v18] do
                v20 = "0" .. v20
            end
            local v21 = ":" .. v20
            table.insert(v15, v21)
        end
        return table.concat(v15)
    end
    return "NaN"
end
