-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

function DeepCopyPure(v1, v2) -- line 6
    if type(v1) == "table" then
        local v3 = not getmetatable(v1)
        assert(v3)
        local v4 = v2 or {}
        local v5 = not v4[v1]
        assert(v5)
        v4[v1] = true
        local v6 = {}
        for v7, v8 in next, v1 do
            v6[DeepCopyPure(v7, v4)] = DeepCopyPure(v8, v4)
        end
        v4[v1] = nil
        return v6
    end
    return v1
end

return DeepCopyPure
