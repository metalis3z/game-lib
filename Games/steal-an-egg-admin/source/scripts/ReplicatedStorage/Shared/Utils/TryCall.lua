-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function onError(v1) -- line 6
    local v2 = tostring(v1)
    return debug.traceback(v2, 2)
end

return function(v3, ...) -- line 10 | captures: onError
    local v4 = table.pack(xpcall(v3, onError, ...))
    if v4[1] then
        local n = v4.n
        return true, table.unpack(v4, 2, n)
    end
    local warn_2 = warn
    local v5 = v4[2]
    warn_2("protected call failed: " .. tostring(v5))
    return false, v4[2]
end
