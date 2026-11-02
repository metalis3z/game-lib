-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function(v1) -- line 6
    local v2 = type(v1) == "number"
    assert(v2)
    if v1 == v1 then
        if v1 == (1/0) then
            return "Infinity"
        end
        if v1 == (-1/0) then
            return "-Infinity"
        end
        local v3 = string.format("%f", v1)
        local v4, v5 = string.match(v3, "^([^%.]*)%.?(.*)$")
        assert(v4)
        if v5 then
            local v6 = string.gsub(v5, "0+$", "")
            if #v6 == 0 then
                return v4
            end
            return (("%*.%*"):format(v4, v6))
        end
        return v4
    end
    return "NaN"
end
