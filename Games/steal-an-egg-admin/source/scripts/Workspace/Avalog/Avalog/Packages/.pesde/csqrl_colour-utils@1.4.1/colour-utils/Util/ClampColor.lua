-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local clamp = math.clamp
return function(v1) -- line 3 | captures: clamp
    local R = v1.R
    local v2 = clamp(R, 0, 1)
    local G = v1.G
    local v3 = clamp(G, 0, 1)
    local B = v1.B
    local v4 = clamp(B, 0, 1)
    return Color3.new(v2, v3, v4)
end
