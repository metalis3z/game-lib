-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

function DeepCopyPureUnsafe(v1) -- line 6
    if type(v1) == "table" then
        local v2 = {}
        for v3, v4 in next, v1 do
            v2[DeepCopyPureUnsafe(v3)] = DeepCopyPureUnsafe(v4)
        end
        return v2
    end
    return v1
end

return DeepCopyPureUnsafe
