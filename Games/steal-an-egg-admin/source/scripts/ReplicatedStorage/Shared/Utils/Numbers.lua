-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    k = 1000,
    m = 1000000,
    b = 1000000000,
    t = 1000000000000,
    q = 1000000000000000
}
local v2 = {
    AddCommas = function(v3) -- AddCommas | line 14
        local v4 = type(v3) == "number"
        assert(v4, "amount must be a number")
        if v3 == v3 then
            if v3 == (1/0) then
                return "Infinity"
            end
            if v3 == (-1/0) then
                return "-Infinity"
            end
            local v5 = if v3 >= 0 then "" else "-"
            local v6 = if v3 >= 0 then v3 else -v3
            local v7 = math.round(v6)
            local v8 = v5 .. tostring(v7)
            local v9
            while true do
                local v10
                v9, v10 = string.gsub(v8, "^(-?%d+)(%d%d%d)", "%1,%2")
                if v10 == 0 then
                    break
                end
                v8 = v9
            end
            return v9
        end
        return "NaN"
    end
}

function v2.Parse(v11) -- line 47 | captures: v1
    local v12 = type(v11) == "string"
    assert(v12, "text must be a string")
    local v13 = string.gsub(v11, "[,%s%c%z]", "")
    local v14 = v1[string.lower((string.sub(v13, -1)))]
    if v14 == nil then
        return (tonumber(v13))
    end
    local v15 = string.sub(v13, 1, -2)
    local v16 = tonumber(v15)
    if v16 == nil then
        return nil
    end
    return v16 * v14
end

return table.freeze(v2)
