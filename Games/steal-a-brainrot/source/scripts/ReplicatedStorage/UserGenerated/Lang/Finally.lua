-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--!native
local v0 = require(game.ReplicatedStorage.UserGenerated.Lang.WCall);
local function v3(v1, v2, ...) --[[ Line: 7 ]] --[[ Name: Handle ]]
    -- upvalues: v0 (copy)
    v0(v1);
    if not v2 then
        error((select(1, ...)));
    end;
    return ...;
end;
local function v5(v4) --[[ Line: 19 ]] --[[ Name: ErrorHandler ]]
    return (("%*\nStack Begin\n%*Stack End"):format(tostring(v4), (debug.traceback(nil, 3))));
end;
return function(v6, v7, ...) --[[ Line: 23 ]] --[[ Name: Finally ]]
    -- upvalues: v3 (copy), v5 (copy)
    return v3(v7, xpcall(v6, v5, ...));
end;