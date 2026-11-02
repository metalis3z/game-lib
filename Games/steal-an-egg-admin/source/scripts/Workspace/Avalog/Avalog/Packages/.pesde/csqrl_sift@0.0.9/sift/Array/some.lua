-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function some(v1, v2) -- line 24
    for v3, v4 in ipairs(v1) do
        if v2(v4, v3, v1) then
            return true
        end
    end
    return false
end

return some
