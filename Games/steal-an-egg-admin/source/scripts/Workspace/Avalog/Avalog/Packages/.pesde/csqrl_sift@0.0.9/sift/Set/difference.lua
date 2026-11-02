-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Types)

local function difference(v1, ...) -- line 21
    local v2 = table.clone(v1)
    for v3, v4 in { ... } do
        if typeof(v4) == "table" then
            for v5 in v4 do
                v2[v5] = nil
            end
        end
    end
    return v2
end

return difference
