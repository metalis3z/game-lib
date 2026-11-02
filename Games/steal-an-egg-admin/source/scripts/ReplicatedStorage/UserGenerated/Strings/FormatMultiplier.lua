-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function(v1, v2) -- line 6
    local v3 = type(v1) == "number"
    assert(v3)
    local v4
    if v2 == nil then
        v4 = true
    elseif type(v2) == "number" and v2 >= 0 then
        v4 = math.floor(v2) == v2
    else
        v4 = false
    end
    assert(v4)
    if v1 == v1 then
        if v1 == (1/0) then
            return "Infinity"
        end
        if v1 == (-1/0) then
            return "-Infinity"
        end
        local v5 = v2 or 2
        if v5 <= 0 then
            local v6 = math.round(v1)
            return (tostring(v6))
        end
        local v7 = ("%%0.%*f"):format(v5)
        return string.format(v7, v1):gsub("(%d)%.?0+$", "%1")
    end
    return "NaN"
end
