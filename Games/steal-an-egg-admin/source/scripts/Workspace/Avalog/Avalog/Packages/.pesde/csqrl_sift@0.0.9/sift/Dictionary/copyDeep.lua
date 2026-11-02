-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return ((function()
    local function v1(v2) -- line 20 | captures: v1
        local v3 = table.clone(v2)
        for v4, v5 in pairs(v2) do
            if type(v5) == "table" then
                v3[v4] = v1(v5)
            end
        end
        return v3
    end

    return v1
end)())
