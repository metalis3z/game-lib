-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--!native
local function v1(v0) --[[ Line: 5 ]] --[[ Name: ErrorHandler ]]
    warn((("%*\nStack Begin\n%*Stack End"):format(tostring(v0), (debug.traceback(nil, 3)))));
end;
return function(v2, ...) --[[ Line: 9 ]] --[[ Name: WCall ]]
    -- upvalues: v1 (copy)
    return xpcall(v2, v1, ...);
end;