-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Types)
return ((function()
    local function v1(v2) -- line 22 | captures: v1
        local v3 = {}
        for v4, v5 in pairs(v2) do
            if type(v5) == "table" then
                v3[v4] = v1(v5)
            else
                v3[v4] = v5
            end
        end
        table.freeze(v3)
        return v3
    end

    return v1
end)())
