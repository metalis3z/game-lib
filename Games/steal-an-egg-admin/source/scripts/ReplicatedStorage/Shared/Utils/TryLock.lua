-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 6
    local v1 = false
    return function(v2, ...) -- line 8 | captures: v1
        if v1 then
            return false
        end
        v1 = true
        local v3 = table.pack(xpcall(v2, debug.traceback, ...))
        v1 = false
        if not v3[1] then
            error(v3[2], 0)
        end
        local n = v3.n
        return true, table.unpack(v3, 2, n)
    end
end
