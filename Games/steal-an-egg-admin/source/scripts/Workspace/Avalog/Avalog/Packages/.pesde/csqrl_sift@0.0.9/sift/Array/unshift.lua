-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function unshift(v1, ...) -- line 22
    local v2 = { ... }
    for v3, v4 in ipairs(v1) do
        table.insert(v2, v4)
    end
    return v2
end

return unshift
