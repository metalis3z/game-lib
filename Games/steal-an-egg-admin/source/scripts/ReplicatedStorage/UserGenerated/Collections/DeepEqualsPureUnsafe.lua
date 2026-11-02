-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

function DeepEqualsPureUnsafe(v1, v2) -- line 6
    if rawequal(v1, v2) then
        return true
    end
    if type(v1) == "table" and type(v2) == "table" then
        if rawlen(v1) == rawlen(v2) and getmetatable(v1) == getmetatable(v2) then
            for v3, v4 in next, v1 do
                local v5 = rawget(v2, v3)
                if v5 == nil or not DeepEqualsPureUnsafe(v4, v5) then
                    return false
                end
            end
            for v6, v7 in next, v2 do
                if rawget(v1, v6) == nil then
                    return false
                end
            end
            return true
        end
        return false
    end
    if v1 == v1 then
        return false
    end
    return v2 ~= v2
end

return DeepEqualsPureUnsafe
