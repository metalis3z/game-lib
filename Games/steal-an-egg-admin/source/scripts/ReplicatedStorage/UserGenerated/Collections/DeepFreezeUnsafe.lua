-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

function DeepFreezeUnsafe(v1) -- line 6
    if type(v1) == "table" then
        if not table.isfrozen(v1) then
            table.freeze(v1)
        end
        for v2, v3 in next, v1 do
            DeepFreezeUnsafe(v2)
            DeepFreezeUnsafe(v3)
        end
    end
    return v1
end

return DeepFreezeUnsafe
