-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return ((function()
    local function v1(v2, v3) -- line 1 | captures: v1
        for v4, v5 in pairs(v2) do
            if typeof(v5) == "table" then
                if not v1(v3[v4], v5) then
                    return false
                end
            elseif v5 ~= v3[v4] then
                return false
            end
        end
        return true
    end

    return v1
end)())
