-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function oneChild(v1) -- line 8
    if v1 then
        local v2, v3 = next(v1)
        if v3 then
            if next(v1, v2) then
                error("Expected at most child, had more than one child.", 2)
            end
            return v3
        end
    end
    return nil
end

return oneChild
