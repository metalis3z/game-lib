-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {}

local function transform(v2) -- line 18
    if v2 >= 0.04045 then
        return ((v2 + 0.055) / 1.055) ^ 2.4
    end
    return v2 / 12.92
end

local function inverse(v3) -- line 28
    if v3 >= 0.0031308 then
        return v3 ^ 0.4166666666666667 * 1.055 - 0.055
    end
    return v3 * 12.92
end

function v1.fromLinear(v4) -- line 37
    local new = Color3.new
    local R = v4.R
    local v5 = if R >= 0.04045 then ((R + 0.055) / 1.055) ^ 2.4 else R / 12.92
    local G = v4.G
    local v6 = if G >= 0.04045 then ((G + 0.055) / 1.055) ^ 2.4 else G / 12.92
    local B = v4.B
    local v7 = if B >= 0.04045 then ((B + 0.055) / 1.055) ^ 2.4 else B / 12.92
    return new(v5, v6, v7)
end

function v1.toLinear(v8) -- line 47
    local new = Color3.new
    local R = v8.R
    local v9 = if R >= 0.0031308 then R ^ 0.4166666666666667 * 1.055 - 0.055 else R * 12.92
    local G = v8.G
    local v10 = if G >= 0.0031308 then G ^ 0.4166666666666667 * 1.055 - 0.055 else G * 12.92
    local B = v8.B
    local v11 = if B >= 0.0031308 then B ^ 0.4166666666666667 * 1.055 - 0.055 else B * 12.92
    return new(v9, v10, v11)
end

return v1
