-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--!native
local v0 = {};
local l_RunService_0 = game:GetService("RunService");
local l_pack_0 = table.pack;
local _ = table.clear;
local v4 = nil;
local v5 = nil;
local v6 = nil;
local v7 = nil;
local function v13(v8, v9, v10, v11, ...) --[[ Line: 17 ]] --[[ Name: onConnection ]]
    local v12 = nil;
    if v8[v11] then
        if v8[v11].Type ~= v10 then
            return;
        else
            v12 = if v9 then v8[v11].Callback(v9, ...) else v8[v11].Callback(...);
            if v10 == "REMOTE_FUNCTION" then
                return v12;
            end;
        end;
    end;
end;
local _ = function() --[[ Line: 37 ]] --[[ Name: getRE ]]
    -- upvalues: l_RunService_0 (copy)
    local _ = nil;
    if l_RunService_0:IsServer() then
        return (Instance.new("RemoteEvent", script));
    else
        return (script:WaitForChild("RemoteEvent", 15));
    end;
end;
local _ = function() --[[ Line: 47 ]] --[[ Name: getRF ]]
    -- upvalues: l_RunService_0 (copy)
    local _ = nil;
    if l_RunService_0:IsServer() then
        return (Instance.new("RemoteFunction", script));
    else
        return (script:WaitForChild("RemoteFunction", 15));
    end;
end;
local _ = function() --[[ Line: 57 ]] --[[ Name: getURE ]]
    -- upvalues: l_RunService_0 (copy)
    local _ = nil;
    if l_RunService_0:IsServer() then
        return (Instance.new("UnreliableRemoteEvent", script));
    else
        return (script:WaitForChild("UnreliableRemoteEvent", 15));
    end;
end;
local _ = function() --[[ Line: 67 ]] --[[ Name: getBE ]]
    -- upvalues: l_RunService_0 (copy)
    local _ = nil;
    if l_RunService_0:IsServer() then
        return (Instance.new("BindableEvent", script));
    else
        return (script:WaitForChild("Event", 15));
    end;
end;
v0.New = function(v22) --[[ Line: 80 ]] --[[ Name: New ]]
    -- upvalues: v4 (ref), v5 (ref), v6 (ref), v7 (ref), l_RunService_0 (copy), v13 (copy)
    local v23 = nil;
    local v24 = if l_RunService_0:IsServer() then Instance.new("RemoteEvent", script) else script:WaitForChild("RemoteEvent", 15);
    local v25 = nil;
    v23 = if l_RunService_0:IsServer() then Instance.new("RemoteFunction", script) else script:WaitForChild("RemoteFunction", 15);
    local v26 = nil;
    v25 = if l_RunService_0:IsServer() then Instance.new("UnreliableRemoteEvent", script) else script:WaitForChild("UnreliableRemoteEvent", 15);
    local _ = nil;
    v26 = if l_RunService_0:IsServer() then Instance.new("BindableEvent", script) else script:WaitForChild("Event", 15);
    v4 = v24;
    v5 = v23;
    v6 = v25;
    v7 = v26;
    v22.Connections = {};
    if l_RunService_0:IsServer() then
        v22.Signals = {
            RemoteEvent = v4 and v4.OnServerEvent:Connect(function(v28, ...) --[[ Line: 87 ]]
                -- upvalues: v13 (ref), v22 (copy)
                v13(v22.Connections, v28, "REMOTE_EVENT", ...);
            end), 
            UnreliableRemoteEvent = v6 and v6.OnServerEvent:Connect(function(v29, ...) --[[ Line: 88 ]]
                -- upvalues: v13 (ref), v22 (copy)
                v13(v22.Connections, v29, "UREMOTE_EVENT", ...);
            end), 
            BindableEvent = v7 and v7.Event:Connect(function(...) --[[ Line: 89 ]]
                -- upvalues: v13 (ref), v22 (copy)
                v13(v22.Connections, nil, "BINDABLE_EVENT", ...);
            end)
        };
    else
        v22.Signals = {
            RemoteEvent = v4 and v4.OnClientEvent:Connect(function(...) --[[ Line: 93 ]]
                -- upvalues: v13 (ref), v22 (copy)
                v13(v22.Connections, nil, "REMOTE_EVENT", ...);
            end), 
            UnreliableRemoteEvent = v6 and v6.OnClientEvent:Connect(function(...) --[[ Line: 94 ]]
                -- upvalues: v13 (ref), v22 (copy)
                v13(v22.Connections, nil, "UREMOTE_EVENT", ...);
            end), 
            BindableEvent = v7 and v7.Event:Connect(function(...) --[[ Line: 95 ]]
                -- upvalues: v13 (ref), v22 (copy)
                v13(v22.Connections, nil, "BINDABLE_EVENT", ...);
            end)
        };
    end;
    if v5 then
        if l_RunService_0:IsServer() then
            v5.OnServerInvoke = function(v30, ...) --[[ Line: 101 ]]
                -- upvalues: v13 (ref), v22 (copy)
                return v13(v22.Connections, v30, "REMOTE_FUNCTION", ...);
            end;
            return v22;
        else
            v5.OnClientInvoke = function(...) --[[ Line: 103 ]]
                -- upvalues: v13 (ref), v22 (copy)
                return v13(v22.Connections, nil, "REMOTE_FUNCTION", ...);
            end;
        end;
    end;
    return v22;
end;
v0.SetConnection = function(v31, v32, v33, v34) --[[ Line: 119 ]] --[[ Name: SetConnection ]]
    assert(v32, "need ConnectionName, must be string");
    assert(v33, "need ConnectionType, must be RemoteConnection");
    assert(v34, "need ConnectionName, must be ( player: Player, ... any ) -> any?");
    local v35 = {
        Name = v32, 
        Type = v33, 
        Callback = v34
    };
    v31.Connections[v32] = v35;
end;
v0.SetSignal = function(_, v37) --[[ Line: 134 ]] --[[ Name: SetSignal ]]
    -- upvalues: v0 (copy), l_pack_0 (copy), l_RunService_0 (copy)
    local v38 = false;
    local v39 = nil;
    local v40 = nil;
    v40 = v0:SetConnection(("Signal%*"):format(v37), "REMOTE_EVENT", function(v41) --[[ Line: 138 ]]
        -- upvalues: v38 (ref), v39 (ref), l_pack_0 (ref), v0 (ref), v37 (copy)
        v38 = true;
        v39 = l_pack_0(v41);
        v0:RemoveConnection(("Signal%*"):format(v37), "REMOTE_EVENT");
    end);
    return {
        Wait = function() --[[ Line: 145 ]] --[[ Name: Wait ]]
            -- upvalues: l_RunService_0 (ref), v38 (ref), v39 (ref)
            repeat
                l_RunService_0.Heartbeat:Wait();
            until v38;
            return v39;
        end
    };
end;
v0.FireSignal = function(_, v43, v44, ...) --[[ Line: 155 ]] --[[ Name: FireSignal ]]
    -- upvalues: l_RunService_0 (copy), v0 (copy)
    if l_RunService_0:IsClient() then
        v0:FireServerConnection(("Signal%*"):format(v43), "REMOTE_EVENT", ...);
        return;
    else
        if l_RunService_0:IsServer() and v44 then
            v0:FireClientConnection(v44, ("Signal%*"):format(v43), "REMOTE_EVENT", ...);
        end;
        return;
    end;
end;
v0.FireClientConnection = function(_, v46, v47, v48, ...) --[[ Line: 170 ]] --[[ Name: FireClientConnection ]]
    -- upvalues: l_RunService_0 (copy), v4 (ref), v6 (ref), v5 (ref)
    if l_RunService_0:IsClient() then
        return;
    elseif not v46 or not v46:IsA("Player") then
        return;
    elseif v48 == "REMOTE_EVENT" and v4 then
        v4:FireClient(v46, v47, ...);
        return;
    elseif v48 == "UREMOTE_EVENT" and v6 then
        v6:FireClient(v46, v47, ...);
        return;
    elseif v48 == "REMOTE_FUNCTION" and v5 then
        return v5:InvokeClient(v46, v47, ...);
    else
        return;
    end;
end;
v0.FireAllClientConnection = function(_, v50, v51, ...) --[[ Line: 185 ]] --[[ Name: FireAllClientConnection ]]
    -- upvalues: l_RunService_0 (copy), v4 (ref), v6 (ref)
    if l_RunService_0:IsClient() or v51 == "REMOTE_FUNCTION" then
        return;
    elseif v51 == "REMOTE_EVENT" and v4 then
        v4:FireAllClients(v50, ...);
        return;
    else
        if v51 == "UREMOTE_EVENT" and v6 then
            v6:FireAllClients(v50, ...);
        end;
        return;
    end;
end;
v0.FireServerConnection = function(_, v53, v54, ...) --[[ Line: 200 ]] --[[ Name: FireServerConnection ]]
    -- upvalues: l_RunService_0 (copy)
    if l_RunService_0:IsServer() then
        return;
    elseif v54 == "REMOTE_EVENT" then
        local _ = nil;
        (if l_RunService_0:IsServer() then Instance.new("RemoteEvent", script) else script:WaitForChild("RemoteEvent", 15)):FireServer(v53, ...);
        return;
    elseif v54 == "UREMOTE_EVENT" then
        local _ = nil;
        (if l_RunService_0:IsServer() then Instance.new("UnreliableRemoteEvent", script) else script:WaitForChild("UnreliableRemoteEvent", 15)):FireServer(v53, ...);
        return;
    elseif v54 == "REMOTE_FUNCTION" then
        local _ = nil;
        return (if l_RunService_0:IsServer() then Instance.new("RemoteFunction", script) else script:WaitForChild("RemoteFunction", 15)):InvokeServer(v53, ...);
    else
        return;
    end;
end;
v0.FireConnection = function(_, v59, ...) --[[ Line: 219 ]] --[[ Name: FireConnection ]]
    -- upvalues: v7 (ref)
    if v7 then
        v7:Fire(v59, ...);
    end;
end;
v0.GetRemote = function(_, v61) --[[ Line: 225 ]] --[[ Name: GetRemote ]]
    -- upvalues: l_RunService_0 (copy)
    if v61 == "REMOTE_EVENT" then
        local _ = nil;
        return if l_RunService_0:IsServer() then Instance.new("RemoteEvent", script) else script:WaitForChild("RemoteEvent", 15);
    elseif v61 == "UREMOTE_EVENT" then
        local _ = nil;
        return if l_RunService_0:IsServer() then Instance.new("UnreliableRemoteEvent", script) else script:WaitForChild("UnreliableRemoteEvent", 15);
    elseif v61 == "REMOTE_FUNCTION" then
        local _ = nil;
        return if l_RunService_0:IsServer() then Instance.new("RemoteFunction", script) else script:WaitForChild("RemoteFunction", 15);
    elseif v61 == "BINDABLE_EVENT" then
        local _ = nil;
        return if l_RunService_0:IsServer() then Instance.new("BindableEvent", script) else script:WaitForChild("Event", 15);
    else
        print("[Network] Could not locate the remote, maybe check the requested remote?");
        return nil;
    end;
end;
v0.RemoveConnection = function(v66, v67, v68) --[[ Line: 248 ]] --[[ Name: RemoveConnection ]]
    local v69 = v66.Connections[v67];
    if v69 then
        if v69.Type ~= v68 then
            return nil;
        else
            v66.Connections[v67] = nil;
            return v69;
        end;
    else
        return nil;
    end;
end;
v0.Init = function(_) --[[ Line: 292 ]] --[[ Name: Init ]]
    -- upvalues: v0 (copy)
    v0:New();
end;
return v0;