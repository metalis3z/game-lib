-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local function v0(...) --[[ Line: 65 ]] --[[ Name: pack ]]
    return {
        n = select("#", ...); 
        ...
    };
end;
local v1 = {
    __index = {}
};
v1.__index.Disconnect = function(v2) --[[ Line: 71 ]] --[[ Name: Disconnect ]]
    if v2.conn then
        v2.conn:Disconnect();
        v2.conn = nil;
    end;
    if not v2.signal then
        return;
    else
        v2.Connected = false;
        local l_connections_0 = v2.signal.connections;
        for v4 = 1, #l_connections_0 do
            if l_connections_0[v4] == v2 then
                table.remove(l_connections_0, v4);
                break;
            end;
        end;
        v2.signal:destruct();
        v2.signal = nil;
        return;
    end;
end;
v1.__index.IsConnected = function(v5) --[[ Line: 91 ]] --[[ Name: IsConnected ]]
    if v5.conn then
        return v5.conn.Connected;
    else
        return false;
    end;
end;
local v6 = {
    __index = {}
};
v6.__index.Connect = function(v7, v8) --[[ Line: 102 ]] --[[ Name: Connect ]]
    -- upvalues: v1 (copy)
    local l_signal_0 = v7.signal;
    l_signal_0:construct();
    local v12 = setmetatable({
        signal = l_signal_0, 
        conn = l_signal_0.usignal.Event:Connect(function(v10) --[[ Line: 107 ]]
            -- upvalues: l_signal_0 (copy), v8 (copy)
            local v11 = l_signal_0.args[v10];
            v11[1] = v11[1] - 1;
            if v11[1] <= 0 then
                l_signal_0.args[v10] = nil;
            end;
            v8(unpack(v11[2], 1, v11[2].n));
        end), 
        Connected = true
    }, v1);
    table.insert(l_signal_0.connections, v12);
    return v12;
end;
local v13 = {
    __index = {}
};
v13.__index.GetEvent = function(v14) --[[ Line: 125 ]] --[[ Name: GetEvent ]]
    return v14.event;
end;
v13.__index.Fire = function(v15, ...) --[[ Line: 129 ]] --[[ Name: Fire ]]
    -- upvalues: v0 (copy)
    local l_nextID_0 = v15.nextID;
    v15.nextID = v15.nextID + 1;
    v15.args[l_nextID_0] = {
        #v15.connections + v15.threads, 
        v0(...)
    };
    v15.threads = 0;
    v15.usignal:Fire(l_nextID_0);
end;
v13.__index.Wait = function(v17) --[[ Line: 137 ]] --[[ Name: Wait ]]
    v17.threads = v17.threads + 1;
    local v18 = v17.usignal.Event:Wait();
    local v19 = v17.args[v18];
    v19[1] = v19[1] - 1;
    if v19[1] <= 0 then
        v17.args[v18] = nil;
    end;
    return unpack(v19[2], 1, v19[2].n);
end;
v13.__index.Destroy = function(v20) --[[ Line: 148 ]] --[[ Name: Destroy ]]
    v20.usignal:Destroy();
    v20.usignal = Instance.new("BindableEvent");
    local l_connections_1 = v20.connections;
    for v22 = #l_connections_1, 1, -1 do
        local v23 = l_connections_1[v22];
        v23.signal = nil;
        v23.conn = nil;
        v23.Connected = false;
        l_connections_1[v22] = nil;
    end;
    v20.threads = 0;
    v20:destruct();
end;
v13.__index.construct = function(v24) --[[ Line: 163 ]] --[[ Name: construct ]]
    -- upvalues: v0 (copy)
    if #v24.connections > 0 then
        return;
    else
        if v24.ctor and not v24.ctorData then
            v24.ctorData = v0(v24:ctor());
        end;
        return;
    end;
end;
v13.__index.destruct = function(v25) --[[ Line: 172 ]] --[[ Name: destruct ]]
    if #v25.connections > 0 then
        return;
    else
        if v25.dtor and v25.ctorData then
            v25:dtor(unpack(v25.ctorData, 1, v25.ctorData.n));
            v25.ctorData = nil;
        end;
        return;
    end;
end;
return function(v26, v27) --[[ Line: 182 ]] --[[ Name: Signal ]]
    -- upvalues: v6 (copy), v13 (copy)
    local v28 = {
        ctor = v26, 
        dtor = v27, 
        ctorData = nil, 
        args = {}, 
        nextID = 0, 
        connections = {}, 
        usignal = Instance.new("BindableEvent"), 
        threads = 0
    };
    v28.event = setmetatable({
        signal = v28
    }, v6);
    v28.Event = v28.event;
    return (setmetatable(v28, v13));
end;