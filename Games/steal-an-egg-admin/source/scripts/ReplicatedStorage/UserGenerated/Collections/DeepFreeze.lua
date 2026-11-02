-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

function DeepFreeze(v1, v2) -- line 6
    if type(v1) == "table" then
        if not table.isfrozen(v1) then
            table.freeze(v1)
        end
        local v3 = v2 or {}
        if not v3[v1] then
            v3[v1] = true
            for v4, v5 in next, v1 do
                DeepFreeze(v4, v3)
                DeepFreeze(v5, v3)
            end
            v3[v1] = nil
        end
    end
    return v1
end

return DeepFreeze
