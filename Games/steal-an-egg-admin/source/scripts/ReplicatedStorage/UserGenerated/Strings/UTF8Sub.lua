-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function(v1, v2, v3) -- line 6
    local v4 = v3 or -1
    local v5 = utf8.offset(v1, v2)
    if v5 then
        local v6
        if v4 == -1 then
            v6 = #v1
        else
            local v7 = utf8.offset(v1, v4 + 1)
            if v7 then
                v6 = v7 - 1
            elseif v4 >= 0 then
                v6 = #v1
            else
                v6 = 0
            end
        end
        return (string.sub(v1, v5, v6))
    end
    if v2 > 0 then
        return ""
    end
    local v8
    if v4 == -1 then
        v8 = #v1
    else
        local v9 = utf8.offset(v1, v4 + 1)
        if v9 then
            v8 = v9 - 1
        elseif v4 >= 0 then
            v8 = #v1
        else
            v8 = 0
        end
    end
    return (string.sub(v1, 1, v8))
end
