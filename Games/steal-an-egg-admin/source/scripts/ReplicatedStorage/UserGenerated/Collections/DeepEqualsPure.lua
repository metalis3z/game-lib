-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

function DeepEqualsPure(v1, v2, v3) -- line 6
    if type(v1) == "table" and type(v2) == "table" then
        local v4 = v3 or {}
        if not v4[v1] and not v4[v2] then
            if rawequal(v1, v2) then
                return true
            end
            if rawlen(v1) == rawlen(v2) and getmetatable(v1) == getmetatable(v2) then
                v4[v1] = true
                v4[v2] = true
                for v5, v6 in next, v1 do
                    local v7 = rawget(v2, v5)
                    if v7 == nil or not DeepEqualsPure(v6, v7, v4) then
                        return false
                    end
                end
                for v8, v9 in next, v2 do
                    if rawget(v1, v8) == nil then
                        return false
                    end
                end
                v4[v1] = nil
                v4[v2] = nil
                return true
            end
            return false
        end
        return false
    end
    if rawequal(v1, v2) then
        return true
    end
    if v1 == v1 then
        return false
    end
    return v2 ~= v2
end

return DeepEqualsPure
