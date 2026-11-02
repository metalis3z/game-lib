-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Types)

local function differenceSymmetric(v1, ...) -- line 21
    local v2 = table.clone(v1)
    for v3, v4 in { ... } do
        if typeof(v4) == "table" then
            for v5 in v4 do
                v2[v5] = v2[v5] == nil
            end
        end
    end
    for v6, v7 in v2 do
        if v7 then
            v2[v6] = true
        else
            v2[v6] = nil
        end
    end
    return v2
end

return differenceSymmetric
