-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    "k",
    "m",
    "b",
    "t",
    "q",
    "Qt",
    "Sx",
    "Sp",
    "o",
    "n",
    "d",
    "u",
    "Du",
    "Tr"
}
return function(v2, v3, v4) -- line 22 | captures: v1
    local v5 = type(v2) == "number"
    assert(v5)
    local v6 = if v3 == nil then true else type(v3) == "number"
    assert(v6)
    local v7 = if v4 == nil then true else type(v4) == "number"
    assert(v7)
    if v2 == v2 then
        if v2 == (1/0) then
            return "Infinity"
        end
        if v2 == (-1/0) then
            return "-Infinity"
        end
        local v8 = v3 or 3
        local v9 = math.abs(v2)
        local v10 = -#v1 * 3
        local v11 = math.pow(10, v10)
        local v12 = math.max(v9, v11)
        local v13 = math.log10(v12)
        local v14 = math.ceil(v13)
        local v15 = #v1 * 3 + v8
        local v16 = 10 ^ (math.min(v14, v15) - (v4 or 0) - v8)
        local v17 = v12 / v16
        local v18 = math.round(v17) * v16
        local v19 = math.max(v18, 1)
        local v20 = math.log10(v19) / 3
        local v21 = math.floor(v20)
        local v22 = #v1
        local v23 = math.min(v21, v22)
        local v24 = v18 * math.sign(v2)
        local v25 = string.format("%f", v24 / 10 ^ (v23 * 3)):gsub("%.?0+$", "")
        if v23 >= 1 then
            return v25 .. v1[v23]
        end
        return v25
    end
    return "NaN"
end
