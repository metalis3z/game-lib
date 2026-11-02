

--!native
local v0 = require(game.ReplicatedStorage.UserGenerated.Lang.WCall);
local function v3(v1, v2, ...)
    v0(v1);
    if not v2 then
        error((select(1, ...)));
    end;
    return ...;
end;
local function v5(v4)
    return (("%*\nStack Begin\n%*Stack End"):format(tostring(v4), (debug.traceback(nil, 3))));
end;
return function(v6, v7, ...)
    return v3(v7, xpcall(v6, v5, ...));
end;