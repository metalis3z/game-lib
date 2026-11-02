-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function removeIndex(v1, v2) -- line 19
    local v3 = #v1
    local v4 = {}
    local v5 = if v2 < 1 then v2 + v3 else v2
    for v6, v7 in ipairs(v1) do
        if v6 ~= v5 then
            table.insert(v4, v7)
        end
    end
    return v4
end

return removeIndex
