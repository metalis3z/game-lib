-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function isSimilar(v1, v2) -- line 13
    local v3 = typeof(v1)
    local v4 = v3 == "table"
    local v5 = v3 == "userdata"
    local v6
    if v4 or v5 then
        if v3 == typeof(v2) and (v5 or table.isfrozen(v1) or getmetatable(v1) ~= nil) then
            return v1 == v2
        end
        v6 = false
    else
        local v7, v8
        if v1 == v2 then
            v6 = true
            v8 = true
        elseif v1 == v1 then
            v6 = false
            v8 = true
        else
            v7 = v2 ~= v2
            v8 = false
        end
        if not v8 then
            return v7
        end
    end
    return v6
end

return isSimilar
