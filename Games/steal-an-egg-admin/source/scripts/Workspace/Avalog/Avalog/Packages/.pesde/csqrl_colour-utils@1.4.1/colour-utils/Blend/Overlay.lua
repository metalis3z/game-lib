-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return require(script.Parent._Filter)("Overlay", function(v1, v2) -- line 11
    local v3 = v1 * 255
    local v4 = v2 * 255
    return v3 < 128 and v4 * 2 * v3 / 255 or 255 - (255 - v3) * 2 * (255 - v4) / 255
end)
