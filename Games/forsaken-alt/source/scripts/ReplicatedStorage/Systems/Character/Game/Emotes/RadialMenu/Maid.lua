-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v3 = {
    ["function"] = function(v0) --[[ Line: 6 ]]
        v0();
    end, 
    RBXScriptConnection = function(v1) --[[ Line: 9 ]]
        v1:Disconnect();
    end, 
    Instance = function(v2) --[[ Line: 12 ]]
        v2:Destroy();
    end
};
local v4 = {};
v4.__index = v4;
v4.__type = "Maid";
v4.__tostring = function(_) --[[ Line: 23 ]] --[[ Name: __tostring ]]
    -- upvalues: v4 (copy)
    return v4.__type;
end;
v4.new = function() --[[ Line: 29 ]] --[[ Name: new ]]
    -- upvalues: v4 (copy)
    local v6 = setmetatable({}, v4);
    v6.Trash = {};
    return v6;
end;
v4.Mark = function(v7, v8) --[[ Line: 39 ]] --[[ Name: Mark ]]
    -- upvalues: v3 (copy)
    local v9 = typeof(v8);
    if v3[v9] then
        v7.Trash[v8] = v9;
        return;
    else
        error(("Maid does not support type \"%s\""):format(v9), 2);
        return;
    end;
end;
v4.Unmark = function(v10, v11) --[[ Line: 49 ]] --[[ Name: Unmark ]]
    if v11 then
        v10.Trash[v11] = nil;
        return;
    else
        v10.Trash = {};
        return;
    end;
end;
v4.Sweep = function(v12) --[[ Line: 57 ]] --[[ Name: Sweep ]]
    -- upvalues: v3 (copy)
    for v13, v14 in next, v12.Trash do
        v3[v14](v13);
    end;
    v12.Trash = {};
end;
return v4;