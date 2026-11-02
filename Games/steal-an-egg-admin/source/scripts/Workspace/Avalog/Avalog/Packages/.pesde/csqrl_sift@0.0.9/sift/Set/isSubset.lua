-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function isSubset(v1, v2) -- line 19
    for v3, v4 in pairs(v1) do
        if v2[v3] ~= v4 then
            return false
        end
    end
    return true
end

return isSubset
