-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function findLast(v1, v2, v3) -- line 20
    local v4 = #v1
    if type(v3) == "number" then
        if v3 < 1 then
            v4 += v3
        else
            v4 = v3
        end
    end
    for v5 = v4, 1, -1 do
        if v1[v5] == v2 then
            return v5
        end
    end
end

return findLast
