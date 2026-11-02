-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--!native
local v0 = {
    ServiceLive = false, 
    NetworkingConnection = nil
};
local l_RunService_0 = game:GetService("RunService");
local v2 = nil;
local v3 = nil;
local v4 = nil;
local v5 = nil;
local function v11(v6, v7, v8, v9, ...) --[[ Line: 17 ]] --[[ Name: onConnection ]]
    local v10 = nil;
    if v6[v9] then
        if v6[v9].Type ~= v8 then
            return;
        else
            v10 = if v7 then v6[v9].Callback(v7, ...) else v6[v9].Callback(...);
            if v8 == "REMOTE_FUNCTION" then
                return v10;
            end;
        end;
    end;
end;
local _ = function() --[[ Line: 36 ]] --[[ Name: getRE ]]
    -- upvalues: l_RunService_0 (copy)
    local _ = nil;
    if l_RunService_0:IsServer() then
        return (Instance.new("RemoteEvent", script));
    else
        return (script:WaitForChild("RemoteEvent", 15));
    end;
end;
local _ = function() --[[ Line: 46 ]] --[[ Name: getRF ]]
    -- upvalues: l_RunService_0 (copy)
    local _ = nil;
    if l_RunService_0:IsServer() then
        return (Instance.new("RemoteFunction", script));
    else
        return (script:WaitForChild("RemoteFunction", 15));
    end;
end;
local _ = function() --[[ Line: 56 ]] --[[ Name: getURE ]]
    -- upvalues: l_RunService_0 (copy)
    local _ = nil;
    if l_RunService_0:IsServer() then
        return (Instance.new("UnreliableRemoteEvent", script));
    else
        return (script:WaitForChild("UnreliableRemoteEvent", 15));
    end;
end;
local _ = function() --[[ Line: 66 ]] --[[ Name: getBE ]]
    -- upvalues: l_RunService_0 (copy)
    local _ = nil;
    if l_RunService_0:IsServer() then
        return (Instance.new("BindableEvent", script));
    else
        return (script:WaitForChild("Event", 15));
    end;
end;
v0.New = function(v20) --[[ Line: 79 ]] --[[ Name: New ]]
    -- upvalues: v2 (ref), l_RunService_0 (copy), v3 (ref), v4 (ref), v5 (ref), v11 (copy)
    local v21 = nil;
    v2 = if l_RunService_0:IsServer() then Instance.new("RemoteEvent", script) else script:WaitForChild("RemoteEvent", 15);
    v21 = nil;
    v3 = if l_RunService_0:IsServer() then Instance.new("RemoteFunction", script) else script:WaitForChild("RemoteFunction", 15);
    v21 = nil;
    v4 = if l_RunService_0:IsServer() then Instance.new("UnreliableRemoteEvent", script) else script:WaitForChild("UnreliableRemoteEvent", 15);
    v21 = nil;
    v5 = if l_RunService_0:IsServer() then Instance.new("BindableEvent", script) else script:WaitForChild("Event", 15);
    v20.Connections = {};
    if l_RunService_0:IsServer() then
        v20.Signals = {
            RemoteEvent = v2 and v2.OnServerEvent:Connect(function(v22, ...) --[[ Line: 89 ]]
                -- upvalues: v11 (ref), v20 (copy)
                v11(v20.Connections, v22, "REMOTE_EVENT", ...);
            end), 
            UnreliableRemoteEvent = v4 and v4.OnServerEvent:Connect(function(v23, ...) --[[ Line: 90 ]]
                -- upvalues: v11 (ref), v20 (copy)
                v11(v20.Connections, v23, "UREMOTE_EVENT", ...);
            end), 
            BindableEvent = v5 and v5.Event:Connect(function(...) --[[ Line: 91 ]]
                -- upvalues: v11 (ref), v20 (copy)
                v11(v20.Connections, nil, "BINDABLE_EVENT", ...);
            end)
        };
    else
        v20.Signals = {
            RemoteEvent = v2 and v2.OnClientEvent:Connect(function(...) --[[ Line: 95 ]]
                -- upvalues: v11 (ref), v20 (copy)
                v11(v20.Connections, nil, "REMOTE_EVENT", ...);
            end), 
            UnreliableRemoteEvent = v4 and v4.OnClientEvent:Connect(function(...) --[[ Line: 96 ]]
                -- upvalues: v11 (ref), v20 (copy)
                v11(v20.Connections, nil, "UREMOTE_EVENT", ...);
            end), 
            BindableEvent = v5 and v5.Event:Connect(function(...) --[[ Line: 97 ]]
                -- upvalues: v11 (ref), v20 (copy)
                v11(v20.Connections, nil, "BINDABLE_EVENT", ...);
            end)
        };
    end;
    if v3 then
        if l_RunService_0:IsServer() then
            v3.OnServerInvoke = function(v24, ...) --[[ Line: 103 ]]
                -- upvalues: v11 (ref), v20 (copy)
                return v11(v20.Connections, v24, "REMOTE_FUNCTION", ...);
            end;
        else
            v3.OnClientInvoke = function(...) --[[ Line: 105 ]]
                -- upvalues: v11 (ref), v20 (copy)
                return v11(v20.Connections, nil, "REMOTE_FUNCTION", ...);
            end;
        end;
    end;
    v20.ServiceLive = true;
end;
v0.SetConnection = function(v25, v26, v27, v28) --[[ Line: 121 ]] --[[ Name: SetConnection ]]
    if not v26 and not v27 and not v28 then
        return;
    else
        local v29 = {
            Name = v26, 
            Type = v27, 
            Callback = v28
        };
        v25.Connections[v26] = v29;
        return v29;
    end;
end;
v0.IsLive = function(v30) --[[ Line: 134 ]] --[[ Name: IsLive ]]
    return v30.ServiceLive;
end;
v0.FireClientConnection = function(_, v32, v33, v34, ...) --[[ Line: 145 ]] --[[ Name: FireClientConnection ]]
    -- upvalues: l_RunService_0 (copy), v2 (ref), v4 (ref), v3 (ref)
    if l_RunService_0:IsClient() then
        return;
    elseif not v32 or not v32:IsA("Player") then
        return;
    elseif v34 == "REMOTE_EVENT" and v2 then
        v2:FireClient(v32, v33, ...);
        return;
    elseif v34 == "UREMOTE_EVENT" and v4 then
        v4:FireClient(v32, v33, ...);
        return;
    elseif v34 == "REMOTE_FUNCTION" and v3 then
        return v3:InvokeClient(v32, v33, ...);
    else
        return;
    end;
end;
v0.FireAllClientConnection = function(_, v36, v37, ...) --[[ Line: 158 ]] --[[ Name: FireAllClientConnection ]]
    -- upvalues: l_RunService_0 (copy), v2 (ref), v4 (ref)
    if l_RunService_0:IsClient() or v37 == "REMOTE_FUNCTION" then
        return;
    elseif v37 == "REMOTE_EVENT" and v2 then
        v2:FireAllClients(v36, ...);
        return;
    else
        if v37 == "UREMOTE_EVENT" and v4 then
            v4:FireAllClients(v36, ...);
        end;
        return;
    end;
end;
v0.FireServerConnection = function(_, v39, v40, ...) --[[ Line: 173 ]] --[[ Name: FireServerConnection ]]
    -- upvalues: l_RunService_0 (copy)
    if l_RunService_0:IsServer() then
        return;
    elseif v40 == "REMOTE_EVENT" then
        local _ = nil;
        (if l_RunService_0:IsServer() then Instance.new("RemoteEvent", script) else script:WaitForChild("RemoteEvent", 15)):FireServer(v39, ...);
        return;
    elseif v40 == "UREMOTE_EVENT" then
        local _ = nil;
        (if l_RunService_0:IsServer() then Instance.new("UnreliableRemoteEvent", script) else script:WaitForChild("UnreliableRemoteEvent", 15)):FireServer(v39, ...);
        return;
    elseif v40 == "REMOTE_FUNCTION" then
        local _ = nil;
        return (if l_RunService_0:IsServer() then Instance.new("RemoteFunction", script) else script:WaitForChild("RemoteFunction", 15)):InvokeServer(v39, ...);
    else
        return;
    end;
end;
v0.FireConnection = function(_, v45, ...) --[[ Line: 190 ]] --[[ Name: FireConnection ]]
    -- upvalues: v5 (ref)
    if v5 then
        v5:Fire(v45, ...);
    end;
end;
v0.GetRemote = function(_, v47) --[[ Line: 196 ]] --[[ Name: GetRemote ]]
    -- upvalues: l_RunService_0 (copy)
    if v47 == "REMOTE_EVENT" then
        local _ = nil;
        return if l_RunService_0:IsServer() then Instance.new("RemoteEvent", script) else script:WaitForChild("RemoteEvent", 15);
    elseif v47 == "UREMOTE_EVENT" then
        local _ = nil;
        return if l_RunService_0:IsServer() then Instance.new("UnreliableRemoteEvent", script) else script:WaitForChild("UnreliableRemoteEvent", 15);
    elseif v47 == "REMOTE_FUNCTION" then
        local _ = nil;
        return if l_RunService_0:IsServer() then Instance.new("RemoteFunction", script) else script:WaitForChild("RemoteFunction", 15);
    elseif v47 == "BINDABLE_EVENT" then
        local _ = nil;
        return if l_RunService_0:IsServer() then Instance.new("BindableEvent", script) else script:WaitForChild("Event", 15);
    else
        print("[Network] Could not locate the remote, maybe check the requested remote?");
        return;
    end;
end;
v0.RemoveConnection = function(v52, v53, v54) --[[ Line: 218 ]] --[[ Name: RemoveConnection ]]
    local v55 = nil;
    if v52.Connections[v53] then
        if v52.Connections[v53].Type ~= v54 then
            return;
        else
            v55 = v52.Connections[v53];
            v52.Connections[v53] = nil;
        end;
    end;
    if v55 then
        return v55;
    else
        return;
    end;
end;
v0.Destroy = function(v56) --[[ Line: 237 ]] --[[ Name: Destroy ]]
    -- upvalues: v3 (ref)
    table.clear(v56.Connections);
    for v57 = 1, #v56.Signals do
        if v56.Signals[v57] then
            v56.Signals[v57].OnServerEvent:Disconnect();
        end;
    end;
    if v3 then
        v3.OnServerInvoke = function() --[[ Line: 248 ]]

        end;
    end;
end;
v0.GetProperty = function(v58, v59) --[[ Line: 261 ]] --[[ Name: GetProperty ]]
    local _, l_result_0 = pcall(function() --[[ Line: 262 ]]
        -- upvalues: v58 (copy), v59 (copy)
        return v58[v59];
    end);
    return l_result_0;
end;
v0.Init = function(_) --[[ Line: 281 ]] --[[ Name: Init ]]
    -- upvalues: v0 (copy), l_RunService_0 (copy)
    v0:New();
    for _, v64 in (script:GetChildren()) do
        if v64:IsA("ModuleScript") then
            local l_status_1, l_result_1 = pcall(function() --[[ Line: 287 ]]
                -- upvalues: v64 (copy), v0 (ref)
                require(v64):CreateNetwork(v0);
            end);
            if not l_status_1 then
                warn("[ClientNetworking] There was an issue with creating SubNetwork: ", v64.Name, " with the error: \n", l_result_1);
            end;
        end;
    end;
    if l_RunService_0:IsServer() then
        game:BindToClose(function() --[[ Line: 298 ]]
            -- upvalues: v0 (ref)
            v0:Destroy();
        end);
    end;
end;
return v0;