-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Parent.Fusion)

local function CombineProps(v1, v2, v3) -- line 16
    for v4, v5 in pairs(v1) do
        if v3 == nil or table.find(v3, v4) == nil then
            v2[v4] = v5
        end
    end
    return v2
end

return CombineProps
