-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1

function v1(v2, v3, v4) -- line 7 | captures: v1
    if rawequal(v2, v3) then
        return true
    end
    if type(v2) == "table" and type(v3) == "table" then
        if rawlen(v2) == rawlen(v3) then
            local v5 = getmetatable(v2)
            if v5 == getmetatable(v3) then
                if v5 == nil then
                    local v6 = v4 or {}
                    v6[v2] = v6[v2] or {}
                    v6[v3] = v6[v3] or {}
                    if not v6[v2][v3] then
                        v6[v2][v3] = true
                        v6[v3][v2] = true
                        for v7, v8 in next, v2 do
                            local v9 = rawget(v3, v7)
                            if v9 == nil or not v1(v8, v9, v6) then
                                return false
                            end
                        end
                        for v10, v11 in next, v3 do
                            if rawget(v2, v10) == nil then
                                return false
                            end
                        end
                    end
                    return true
                end
                if v5.__eq then
                    return v2 == v3
                end
                return
            end
        end
        return false
    end
    if v2 == v2 then
        return false
    end
    return v3 ~= v3
end

return v1
