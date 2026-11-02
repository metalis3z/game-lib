-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function(v1) -- line 6
    local v2 = if v1 >= 0 then v1 == v1 else false
    assert(v2, "cooldown duration must be a non-negative number")
    local v3 = true
    return function(v4) -- line 10 | captures: v3, v1
        if v3 then
            v3 = false
            task.delay(v1, function() -- line 15 | captures: v3
                v3 = true
            end)
            if v4 then
                v4()
            end
            return true
        end
        return false
    end
end
