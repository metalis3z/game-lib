-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent

local function Safe(v1) -- line 13
    local v2, v3 = xpcall(v1.try, v1.fallback)
    return v3
end

return Safe
