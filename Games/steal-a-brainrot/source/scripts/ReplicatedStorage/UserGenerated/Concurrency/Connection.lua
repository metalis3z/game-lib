-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--!native
local v5 = {
    IsConnected = function(v0) --[[ Line: 49 ]] --[[ Name: IsConnected ]]
        return v0.Cn;
    end, 
    Disconnect = function(v1) --[[ Line: 53 ]] --[[ Name: Disconnect ]]
        if not v1.Cn then
            return;
        else
            v1.Cn = false;
            v1:Dc(table.unpack(v1.Da));
            return;
        end;
    end, 
    Invoke = function(v2, ...) --[[ Line: 61 ]] --[[ Name: Invoke ]]
        assert(v2.Cn, "Disconnected");
        return v2.Cb(...);
    end, 
    Spawn = function(v3, ...) --[[ Line: 66 ]] --[[ Name: Spawn ]]
        assert(v3.Cn, "Disconnected");
        return task.spawn(v3.Cb, ...);
    end, 
    GetPriority = function(v4) --[[ Line: 71 ]] --[[ Name: GetPriority ]]
        return v4.Pr;
    end
};
local v6 = {};
local v7 = table.freeze({
    __index = table.freeze(v5)
});
v6.new = function(v8, v9, v10, ...) --[[ Line: 80 ]] --[[ Name: new ]]
    -- upvalues: v7 (copy)
    assert(type(v8) == "function");
    assert(type(v10) == "function");
    assert(type(v9) == "number");
    return (setmetatable({
        Cn = true, 
        Cb = v8, 
        Pr = v9, 
        Dc = v10, 
        Da = table.pack(...)
    }, v7));
end;
return table.freeze(v6);