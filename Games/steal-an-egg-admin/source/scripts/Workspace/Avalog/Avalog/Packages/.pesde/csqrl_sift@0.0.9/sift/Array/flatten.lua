-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return ((function()
    local function v1(v2, v3) -- line 24 | captures: v1
        local v4 = if type(v3) == "number" then v3 else (1/0)
        local v5 = {}
        for v6, v7 in ipairs(v2) do
            if type(v7) == "table" and v4 > 0 then
                local v8 = v1(v7, v4 - 1)
                for v9, v10 in ipairs(v8) do
                    table.insert(v5, v10)
                end
            else
                table.insert(v5, v7)
            end
        end
        return v5
    end

    return v1
end)())
