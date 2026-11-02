-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function xtypeof(v1) -- line 12
    local v2 = typeof(v1)
    local v3 = v2 == "table"
    local v4
    if v3 then
        local type = v1.type
        v4 = typeof(type) == "string"
    end
    if not v3 or not v4 then
        return v2
    end
    return v1.type
end

return xtypeof
