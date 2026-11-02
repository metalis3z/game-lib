-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function removeValue(v1, v2) -- line 19
    local v3 = {}
    for v4, v5 in pairs(v1) do
        if v5 ~= v2 then
            v3[v4] = v5
        end
    end
    return v3
end

return removeValue
