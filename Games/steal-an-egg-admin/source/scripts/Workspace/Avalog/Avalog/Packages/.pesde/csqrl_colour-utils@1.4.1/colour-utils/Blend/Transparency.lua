-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function applyTransparency(v1, v2, v3) -- line 10
    local v4 = 1 - v3
    local v5 = v2.R * v4 + v1.R * v3
    local v6 = v2.G * v4 + v1.G * v3
    local v7 = v2.B * v4 + v1.B * v3
    return Color3.new(v5, v6, v7)
end

return applyTransparency
