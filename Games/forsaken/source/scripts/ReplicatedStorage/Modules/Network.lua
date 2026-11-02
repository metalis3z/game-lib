-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--!native
local v0 = {};
local l_RunService_0 = game:GetService("RunService");
local l_HttpService_0 = game:GetService("HttpService");
local _ = task.defer;
local _ = task.wait;
local _ = coroutine.close;
local l_pack_0 = table.pack;
local _ = table.clear;
local _ = table.insert;
local l_JSONDecode_0 = l_HttpService_0.JSONDecode;
local l_JSONEncode_0 = l_HttpService_0.JSONEncode;
local l_tostring_0 = buffer.tostring;
local l_fromstring_0 = buffer.fromstring;
local l_Heartbeat_0 = l_RunService_0.Heartbeat;
local v14 = l_RunService_0:IsServer();
local v15 = l_RunService_0:IsClient();
local v16 = l_RunService_0:IsStudio();
local v17 = nil;
local v18 = nil;
local v19 = nil;
local v20 = nil;
local v21 = {};
local v22 = {};
local function _(v23) --[[ Line: 33 ]] --[[ Name: __packBuffer ]]
    -- upvalues: l_JSONEncode_0 (copy), l_HttpService_0 (copy), v16 (copy), l_fromstring_0 (copy)
    local v24 = l_JSONEncode_0(l_HttpService_0, v23);
    if v24 == "null" then
        if v16 then
            warn((("[%*/__packBuffer]: Data Type %* cannot be converted to JSON."):format(script, (typeof(v23)))));
        end;
        return nil;
    else
        return l_fromstring_0(v24);
    end;
end;
local function v27(v26) --[[ Line: 47 ]] --[[ Name: __unpackBuffer ]]
    -- upvalues: l_JSONDecode_0 (copy), l_HttpService_0 (copy), l_tostring_0 (copy)
    assert(v26 and typeof(v26) == "buffer", "bad compressedBuffer, must be buffer.");
    return l_JSONDecode_0(l_HttpService_0, l_tostring_0(v26));
end;
local function v28(v29) --[[ Line: 52 ]] --[[ Name: __decompressValue ]]
    -- upvalues: v27 (copy), v28 (copy)
    if typeof(v29) == "buffer" then
        return v27(v29);
    elseif typeof(v29) == "table" then
        local v30 = {};
        for v31, v32 in v29 do
            v30[v31] = v28(v32);
        end;
        return v30;
    else
        return v29;
    end;
end;
local function v33(v34) --[[ Line: 68 ]] --[[ Name: __compressValue ]]
    -- upvalues: v33 (copy), l_JSONEncode_0 (copy), l_HttpService_0 (copy), v16 (copy), l_fromstring_0 (copy)
    if typeof(v34) == "Instance" then
        return v34;
    elseif typeof(v34) == "table" then
        local v35 = {};
        for v36, v37 in v34 do
            v35[v36] = v33(v37);
        end;
        return v35;
    else
        local v38 = l_JSONEncode_0(l_HttpService_0, v34);
        local v39;
        if v38 == "null" then
            if v16 then
                warn((("[%*/__packBuffer]: Data Type %* cannot be converted to JSON."):format(script, (typeof(v34)))));
            end;
            v39 = nil;
        else
            v39 = l_fromstring_0(v38);
        end;
        return v39 or v34;
    end;
end;
local function v44(v40) --[[ Line: 84 ]] --[[ Name: __packTableForBuffer ]]
    -- upvalues: v33 (copy)
    local v41 = {};
    for v42, v43 in v40 do
        if v42 ~= "n" then
            v41[v42] = v33(v43);
        end;
    end;
    return v41;
end;
local function v49(v45) --[[ Line: 95 ]] --[[ Name: __unpackBufferForTable ]]
    -- upvalues: v28 (copy)
    local v46 = {};
    for v47, v48 in v45 do
        v46[v47] = v28(v48);
    end;
    return v46;
end;
local function _(v50, v51) --[[ Line: 105 ]] --[[ Name: getDataCompression ]]
    -- upvalues: v44 (copy), v49 (copy)
    if v50 == "COMPRESS" then
        return (v44(v51));
    elseif v50 == "DECOMPRESS" then
        return (v49(v51));
    else
        return nil;
    end;
end;
local function _(v53, v54) --[[ Line: 115 ]] --[[ Name: __yieldUntilRFResponse ]]
    local l_status_0, l_result_0 = pcall(v54);
    if l_status_0 then
        return l_result_0;
    else
        warn((("[%*/__yieldUntilRFResponse]: Internal Server Error: %* :: %*"):format(script, v53, l_result_0)));
        return nil;
    end;
end;
local function v63(v58, v59, v60, v61) --[[ Line: 125 ]] --[[ Name: onConnection ]]
    -- upvalues: v21 (copy), v49 (copy)
    if v21[v60] ~= nil then
        if v21[v60].Type ~= v59 then
            return;
        else
            local v62 = v49(v61);
            if v58 then
                return v21[v60].Callback(v58, unpack(v62));
            else
                return v21[v60].Callback(unpack(v62));
            end;
        end;
    else
        warn((("[%*/onConnection]: Failed to find a callback method for: %*"):format(script, v60)));
        return;
    end;
end;
local _ = function() --[[ Line: 142 ]] --[[ Name: getRE ]]
    -- upvalues: v14 (copy), v17 (ref)
    local _ = nil;
    if v14 then
        return v17 or Instance.new("RemoteEvent", script);
    else
        return v17 or script:WaitForChild("RemoteEvent", 15);
    end;
end;
local _ = function() --[[ Line: 152 ]] --[[ Name: getRF ]]
    -- upvalues: v14 (copy), v18 (ref)
    local _ = nil;
    if v14 then
        return v18 or Instance.new("RemoteFunction", script);
    else
        return v18 or script:WaitForChild("RemoteFunction", 15);
    end;
end;
local _ = function() --[[ Line: 162 ]] --[[ Name: getURE ]]
    -- upvalues: v14 (copy), v19 (ref)
    local _ = nil;
    if v14 then
        return v19 or Instance.new("UnreliableRemoteEvent", script);
    else
        return v19 or script:WaitForChild("UnreliableRemoteEvent", 15);
    end;
end;
local _ = function() --[[ Line: 172 ]] --[[ Name: getBE ]]
    -- upvalues: v14 (copy), v20 (ref)
    local _ = nil;
    if v14 then
        return v20 or Instance.new("BindableEvent", script);
    else
        return v20 or script:WaitForChild("Event", 15);
    end;
end;
local v72 = nil;
v17 = if v14 then v17 or Instance.new("RemoteEvent", script) else v17 or script:WaitForChild("RemoteEvent", 15);
v72 = nil;
v18 = if v14 then v18 or Instance.new("RemoteFunction", script) else v18 or script:WaitForChild("RemoteFunction", 15);
v72 = nil;
v19 = if v14 then v19 or Instance.new("UnreliableRemoteEvent", script) else v19 or script:WaitForChild("UnreliableRemoteEvent", 15);
v72 = nil;
v20 = if v14 then v20 or Instance.new("BindableEvent", script) else v20 or script:WaitForChild("Event", 15);
v22 = if v14 then {
    RemoteEvent = v17 and v17.OnServerEvent:Connect(function(v73, ...) --[[ Line: 195 ]]
        -- upvalues: v63 (copy)
        v63(v73, "REMOTE_EVENT", ...);
    end), 
    UnreliableRemoteEvent = v19 and v19.OnServerEvent:Connect(function(v74, ...) --[[ Line: 196 ]]
        -- upvalues: v63 (copy)
        v63(v74, "UREMOTE_EVENT", ...);
    end), 
    BindableEvent = v20 and v20.Event:Connect(function(...) --[[ Line: 197 ]]
        -- upvalues: v63 (copy)
        v63(nil, "BINDABLE_EVENT", ...);
    end)
} else {
    RemoteEvent = v17 and v17.OnClientEvent:Connect(function(...) --[[ Line: 201 ]]
        -- upvalues: v63 (copy)
        v63(nil, "REMOTE_EVENT", ...);
    end), 
    UnreliableRemoteEvent = v19 and v19.OnClientEvent:Connect(function(...) --[[ Line: 202 ]]
        -- upvalues: v63 (copy)
        v63(nil, "UREMOTE_EVENT", ...);
    end), 
    BindableEvent = v20 and v20.Event:Connect(function(...) --[[ Line: 203 ]]
        -- upvalues: v63 (copy)
        v63(nil, "BINDABLE_EVENT", ...);
    end)
};
if v18 then
    if v14 then
        v18.OnServerInvoke = function(v75, ...) --[[ Line: 209 ]]
            -- upvalues: v63 (copy)
            return v63(v75, "REMOTE_FUNCTION", ...);
        end;
    else
        v18.OnClientInvoke = function(...) --[[ Line: 211 ]]
            -- upvalues: v63 (copy)
            return v63(nil, "REMOTE_FUNCTION", ...);
        end;
    end;
end;
v0.SetConnection = function(_, v77, v78, v79) --[[ Line: 224 ]] --[[ Name: SetConnection ]]
    -- upvalues: v21 (copy)
    assert(v77, "need ConnectionName, must be string");
    assert(v78, "need ConnectionType, must be RemoteConnection");
    assert(v79, "need ConnectionName, must be ( player: Player, ... any ) -> any?");
    v21[v77] = {
        Name = v77, 
        Type = v78, 
        Callback = v79
    };
end;
v0.SetSignal = function(_, v81) --[[ Line: 239 ]] --[[ Name: SetSignal ]]
    -- upvalues: v0 (copy), l_pack_0 (copy), l_Heartbeat_0 (copy)
    local v82 = false;
    local v83 = {};
    v0:SetConnection(("Signal%*"):format(v81), "REMOTE_EVENT", function(...) --[[ Line: 243 ]]
        -- upvalues: v82 (ref), v83 (ref), l_pack_0 (ref), v0 (ref), v81 (copy)
        v82 = true;
        v83 = l_pack_0(...);
        v0:RemoveConnection(("Signal%*"):format(v81), "REMOTE_EVENT");
    end);
    return {
        Wait = function() --[[ Line: 250 ]] --[[ Name: Wait ]]
            -- upvalues: l_Heartbeat_0 (ref), v82 (ref), v83 (ref)
            repeat
                l_Heartbeat_0:Wait();
            until v82;
            return v83;
        end
    };
end;
v0.FireSignal = function(_, v85, v86, ...) --[[ Line: 260 ]] --[[ Name: FireSignal ]]
    -- upvalues: v15 (copy), v0 (copy), l_pack_0 (copy), v44 (copy), v14 (copy)
    if v15 then
        local l_v0_0 = v0;
        local v88 = ("Signal%*"):format(v85);
        local v89 = "REMOTE_EVENT";
        local v90 = l_pack_0(...);
        l_v0_0:FireServerConnection(v88, v89, (v44(v90)));
        return;
    else
        if v14 and v86 then
            local l_v0_1 = v0;
            local l_v86_0 = v86;
            local v93 = ("Signal%*"):format(v85);
            local v94 = "REMOTE_EVENT";
            local v95 = l_pack_0(...);
            l_v0_1:FireClientConnection(l_v86_0, v93, v94, (v44(v95)));
        end;
        return;
    end;
end;
v0.FireClientConnection = function(_, v97, v98, v99, ...) --[[ Line: 275 ]] --[[ Name: FireClientConnection ]]
    -- upvalues: v15 (copy), v17 (ref), v14 (copy), l_pack_0 (copy), v44 (copy), v19 (ref), v18 (ref)
    if v15 then
        return;
    elseif not v97 or not v97:IsA("Player") then
        return;
    elseif v99 == "REMOTE_EVENT" and v17 then
        local _ = nil;
        local v101 = if v14 then v17 or Instance.new("RemoteEvent", script) else v17 or script:WaitForChild("RemoteEvent", 15);
        local l_v97_0 = v97;
        local l_v98_0 = v98;
        local v104 = l_pack_0(...);
        v101:FireClient(l_v97_0, l_v98_0, (v44(v104)));
        return;
    elseif v99 == "UREMOTE_EVENT" and v19 then
        local _ = nil;
        local v106 = if v14 then v19 or Instance.new("UnreliableRemoteEvent", script) else v19 or script:WaitForChild("UnreliableRemoteEvent", 15);
        local l_v97_1 = v97;
        local l_v98_1 = v98;
        local v109 = l_pack_0(...);
        v106:FireClient(l_v97_1, l_v98_1, (v44(v109)));
        return;
    elseif v99 == "REMOTE_FUNCTION" and v18 then
        local v110 = l_pack_0(...);
        local l_status_1, l_result_1 = pcall(function() --[[ Line: 285 ]]
            -- upvalues: v14 (ref), v18 (ref), v97 (copy), v98 (copy), v110 (copy), v44 (ref)
            local _ = nil;
            return (if v14 then v18 or Instance.new("RemoteFunction", script) else v18 or script:WaitForChild("RemoteFunction", 15)):InvokeClient(v97, v98, (v44(v110)));
        end);
        if l_status_1 then
            return l_result_1;
        else
            warn((("[%*/__yieldUntilRFResponse]: Internal Server Error: %* :: %*"):format(script, v98, l_result_1)));
            return nil;
        end;
    else
        return;
    end;
end;
v0.FireAllClientConnection = function(_, v115, v116, ...) --[[ Line: 293 ]] --[[ Name: FireAllClientConnection ]]
    -- upvalues: v15 (copy), v14 (copy), v17 (ref), l_pack_0 (copy), v44 (copy), v19 (ref)
    if v15 or v116 == "REMOTE_FUNCTION" then
        return;
    elseif v116 == "REMOTE_EVENT" then
        local _ = nil;
        local v118 = if v14 then v17 or Instance.new("RemoteEvent", script) else v17 or script:WaitForChild("RemoteEvent", 15);
        local l_v115_0 = v115;
        local v120 = l_pack_0(...);
        v118:FireAllClients(l_v115_0, (v44(v120)));
        return;
    else
        if v116 == "UREMOTE_EVENT" then
            local _ = nil;
            local v122 = if v14 then v19 or Instance.new("UnreliableRemoteEvent", script) else v19 or script:WaitForChild("UnreliableRemoteEvent", 15);
            local l_v115_1 = v115;
            local v124 = l_pack_0(...);
            v122:FireAllClients(l_v115_1, (v44(v124)));
        end;
        return;
    end;
end;
v0.FireServerConnection = function(_, v126, v127, ...) --[[ Line: 308 ]] --[[ Name: FireServerConnection ]]
    -- upvalues: v14 (copy), v17 (ref), l_pack_0 (copy), v44 (copy), v19 (ref), v18 (ref)
    if v14 then
        return;
    elseif v127 == "REMOTE_EVENT" then
        local _ = nil;
        local v129 = if v14 then v17 or Instance.new("RemoteEvent", script) else v17 or script:WaitForChild("RemoteEvent", 15);
        local l_v126_0 = v126;
        local v131 = l_pack_0(...);
        v129:FireServer(l_v126_0, (v44(v131)));
        return;
    elseif v127 == "UREMOTE_EVENT" then
        local _ = nil;
        local v133 = if v14 then v19 or Instance.new("UnreliableRemoteEvent", script) else v19 or script:WaitForChild("UnreliableRemoteEvent", 15);
        local l_v126_1 = v126;
        local v135 = l_pack_0(...);
        v133:FireServer(l_v126_1, (v44(v135)));
        return;
    elseif v127 == "REMOTE_FUNCTION" then
        local v136 = l_pack_0(...);
        local l_status_2, l_result_2 = pcall(function() --[[ Line: 317 ]]
            -- upvalues: v14 (ref), v18 (ref), v126 (copy), v136 (copy), v44 (ref)
            local _ = nil;
            return (if v14 then v18 or Instance.new("RemoteFunction", script) else v18 or script:WaitForChild("RemoteFunction", 15)):InvokeServer(v126, (v44(v136)));
        end);
        if l_status_2 then
            return l_result_2;
        else
            warn((("[%*/__yieldUntilRFResponse]: Internal Server Error: %* :: %*"):format(script, v126, l_result_2)));
            return nil;
        end;
    else
        return;
    end;
end;
v0.FireConnection = function(_, v141, ...) --[[ Line: 330 ]] --[[ Name: FireConnection ]]
    -- upvalues: v20 (ref), l_pack_0 (copy), v44 (copy)
    if v20 then
        local l_v20_0 = v20;
        local l_v141_0 = v141;
        local v144 = l_pack_0(...);
        l_v20_0:Fire(l_v141_0, (v44(v144)));
    end;
end;
v0.GetRemote = function(_, v146) --[[ Line: 336 ]] --[[ Name: GetRemote ]]
    -- upvalues: v14 (copy), v17 (ref), v19 (ref), v18 (ref), v20 (ref)
    if v146 == "REMOTE_EVENT" then
        local _ = nil;
        return if v14 then v17 or Instance.new("RemoteEvent", script) else v17 or script:WaitForChild("RemoteEvent", 15);
    elseif v146 == "UREMOTE_EVENT" then
        local _ = nil;
        return if v14 then v19 or Instance.new("UnreliableRemoteEvent", script) else v19 or script:WaitForChild("UnreliableRemoteEvent", 15);
    elseif v146 == "REMOTE_FUNCTION" then
        local _ = nil;
        return if v14 then v18 or Instance.new("RemoteFunction", script) else v18 or script:WaitForChild("RemoteFunction", 15);
    elseif v146 == "BINDABLE_EVENT" then
        local _ = nil;
        return if v14 then v20 or Instance.new("BindableEvent", script) else v20 or script:WaitForChild("Event", 15);
    else
        warn((("[%*]: Could not locate the remote, maybe check the requested remote?"):format(script)));
        return nil;
    end;
end;
v0.RemoveConnection = function(_, v152, v153) --[[ Line: 359 ]] --[[ Name: RemoveConnection ]]
    -- upvalues: v21 (copy)
    local v154 = v21[v152];
    if v154 then
        if v154.Type ~= v153 then
            return nil;
        else
            v21[v152] = nil;
            return v154;
        end;
    else
        return nil;
    end;
end;
return v0;