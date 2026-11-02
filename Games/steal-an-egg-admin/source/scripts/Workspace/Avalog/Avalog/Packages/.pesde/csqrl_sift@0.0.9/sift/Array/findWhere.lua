-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function findWhere(v1, v2, v3) -- line 21
    local v4 = #v1
    local v5
    if type(v3) == "number" then
        if v3 < 1 then
            v5 = v4 + v3
        else
            v5 = v3
        end
    else
        v5 = 1
    end
    local v6 = #v1
    for v7 = v5, v6 do
        if v2(v1[v7], v7, v1) then
            return v7
        end
    end
end

return findWhere
