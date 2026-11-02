-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function includes(v1, v2) -- line 19
    for v3, v4 in pairs(v1) do
        if v4 == v2 then
            return true
        end
    end
    return false
end

return includes
