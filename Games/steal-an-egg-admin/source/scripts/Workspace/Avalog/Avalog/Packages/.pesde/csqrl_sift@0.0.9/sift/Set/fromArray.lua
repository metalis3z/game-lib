-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function fromArray(v1) -- line 20
    local v2 = table.create(#v1)
    for v3, v4 in ipairs(v1) do
        v2[v4] = true
    end
    return v2
end

return fromArray
