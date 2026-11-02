-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

function DeepCopyWithMetatables(v1, v2) -- line 6
    if type(v1) == "table" then
        local v3 = v2 or {}
        local v4 = v3[v1]
        if v4 then
            return v4
        end
        local v5 = {}
        v3[v1] = v5
        for v6, v7 in next, v1 do
            v5[DeepCopyWithMetatables(v6, v3)] = DeepCopyWithMetatables(v7, v3)
        end
        local v8 = getmetatable(v1)
        if v8 then
            setmetatable(v5, v8)
        end
        return v5
    end
    return v1
end

return DeepCopyWithMetatables
