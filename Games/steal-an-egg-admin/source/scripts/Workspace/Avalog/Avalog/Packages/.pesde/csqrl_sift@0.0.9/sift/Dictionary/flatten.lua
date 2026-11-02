-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Types)
return ((function()
    local function v1(v2, v3) -- line 30 | captures: v1
        local v4 = if type(v3) == "number" then v3 else (1/0)
        local v5 = {}
        for v6, v7 in pairs(v2) do
            if type(v7) == "table" and v4 > 0 then
                local v8 = v1(v7, v4 - 1)
                for v9, v10 in pairs(v5) do
                    v8[v9] = v10
                end
                v5 = v8
            else
                v5[v6] = v7
            end
        end
        return v5
    end

    return v1
end)())
