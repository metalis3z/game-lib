-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function findWhere(v1, v2) -- line 5
    local v3 = #v1
    for v4 = 1, v3 do
        if v2(v1[v4], v4) then
            return v4
        end
    end
    return nil
end

return findWhere
