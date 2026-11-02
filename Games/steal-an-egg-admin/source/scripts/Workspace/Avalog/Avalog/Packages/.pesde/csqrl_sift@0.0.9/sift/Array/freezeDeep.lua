-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return ((function()
    local function v1(v2) -- line 21 | captures: v1
        local function v3(v4, ...)
            table.insert(v4, ...)
        end

        local v5 = {}
        local v6 = #v2
        for v7 = 1, v6 do
            local v8 = v2[v7]
            if type(v8) == "table" then
                v3(v5, v1(v8))
            else
                table.insert(v5, v8)
            end
        end
        table.freeze(v5)
        return v5
    end

    return v1
end)())
