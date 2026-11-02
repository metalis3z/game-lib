-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.__index = v0;
v0.new = function()
    local v1 = setmetatable({}, v0);
    v1._connections = {};
    return v1;
end;
v0.trackConnection = function(v2, v3, v4)
    if v2._connections[v3] then
        v2._connections[v3]();
    end;
    v2._connections[v3] = function()
        v4:Disconnect();
    end;
end;
v0.trackBoundFunction = function(v5, v6, v7)
    if v5._connections[v6] then
        v5._connections[v6]();
    end;
    v5._connections[v6] = v7;
end;
v0.disconnect = function(v8, v9)
    if v8._connections[v9] then
        v8._connections[v9]();
        v8._connections[v9] = nil;
    end;
end;
v0.disconnectAll = function(v10)
    for _, v12 in pairs(v10._connections) do
        v12();
    end;
    v10._connections = {};
end;
return v0;