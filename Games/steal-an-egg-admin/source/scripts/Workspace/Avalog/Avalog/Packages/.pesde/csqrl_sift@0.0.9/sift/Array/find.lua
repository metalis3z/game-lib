-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function find(v1, v2, v3) -- line 25
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
    return table.find(v1, v2, v5)
end

return find
