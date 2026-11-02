-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function ErrorHandler(v1) -- line 6
    local v2 = tostring(v1)
    warn((("%*\nStack Begin\n%*Stack End"):format(v2, (debug.traceback(nil, 3)))))
end

return function(v3, ...) -- line 10 | captures: ErrorHandler
    return xpcall(v3, ErrorHandler, ...)
end
