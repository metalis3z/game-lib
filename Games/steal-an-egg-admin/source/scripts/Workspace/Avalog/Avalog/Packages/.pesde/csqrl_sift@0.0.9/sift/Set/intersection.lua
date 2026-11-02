-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function intersection(...) -- line 20
    local v1 = select("#", ...)
    local v2 = select(1, ...)
    local v3 = {}
    for v4, v5 in pairs(v2) do
        local v6 = true
        for v7 = 2, v1 do
            if select(v7, ...)[v4] ~= true then
                v6 = false
                break
            end
            v6 = true
        end
        if v6 then
            v3[v4] = true
        end
    end
    return v3
end

return intersection
