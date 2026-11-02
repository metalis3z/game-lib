-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function ErrorHandler(v1) -- line 6
    local v2 = tostring(v1)
    warn((("%*\nStack Begin\n%*Stack End"):format(v2, (debug.traceback(nil, 3)))))
end

local function Handle(v3, v4, ...) -- line 10 | captures: ErrorHandler
    xpcall(v3, ErrorHandler)
    if not v4 then
        error((select(1, ...)))
    end
    return ...
end

return function(v5, v6, ...) -- line 17 | captures: ErrorHandler, Handle
    return Handle(v6, xpcall(v5, ErrorHandler, ...))
end
