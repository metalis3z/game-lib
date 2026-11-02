

--!native
local function v1(v0)
    warn((("%*\nStack Begin\n%*Stack End"):format(tostring(v0), (debug.traceback(nil, 3)))));
end;
return function(v2, ...)
    return xpcall(v2, v1, ...);
end;