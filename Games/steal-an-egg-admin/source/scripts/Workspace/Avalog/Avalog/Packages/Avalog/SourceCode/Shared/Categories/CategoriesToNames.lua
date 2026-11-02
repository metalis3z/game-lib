-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent)

local function CategoriesToNames(v1) -- line 3
    local v2 = {}
    for v3, v4 in ipairs(v1) do
        local Name = v4.Name
        table.insert(v2, Name)
    end
    return v2
end

return CategoriesToNames
