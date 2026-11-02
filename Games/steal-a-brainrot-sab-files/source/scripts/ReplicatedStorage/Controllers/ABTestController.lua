-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_HttpService_0 = game:GetService("HttpService");
local l_Players_0 = game:GetService("Players");
local v3 = require(l_ReplicatedStorage_0.Packages.Signal);
local v4 = require(l_ReplicatedStorage_0.Packages.GameAnalytics);
local v5 = require(l_ReplicatedStorage_0.Shared.ABTestExperiments);
local _ = require(l_ReplicatedStorage_0.Shared.ABTestExperiments.ABTestTypes);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
return {
    _loaded = false, 
    _loadedSignal = v3.new(), 
    _remoteConfigs = {}, 
    _runExperiments = function(v8)
        if not v8._remoteConfigs then
            return;
        else
            for _, v10 in v5 do
                if not v10.Disabled then
                    local v11 = v8._remoteConfigs[v10.RemoteConfig] or v10.DefaultState;
                    local v12 = v10.States[v11];
                    if v12 and v12.Client then
                        task.defer(v12.Client, l_LocalPlayer_0, v11);
                    end;
                end;
            end;
            return;
        end;
    end, 
    IsLoaded = function(v13)
        return v13._loaded;
    end, 
    OnLoad = function(v14, v15)
        return v14._loadedSignal:Connect(v15);
    end, 
    GetRemoteConfig = function(v16, v17)
        return v16._remoteConfigs[v17], v16:IsLoaded();
    end, 
    Start = function(v18)
        v4:initClient();
        l_ReplicatedStorage_0:WaitForChild("GameAnalyticsRemoteConfigs").OnClientEvent:Connect(function(v19)
            if typeof(v19) ~= "table" then
                return;
            else
                local v20 = {};
                for v21, v22 in v19 do
                    local l_status_0, l_result_0 = pcall(l_HttpService_0.JSONDecode, l_HttpService_0, v22);
                    v20[v21] = if l_status_0 and l_result_0 ~= nil then l_result_0 else v22;
                end;
                v18._remoteConfigs = v20;
                if not v18._loaded then
                    v18._loaded = true;
                    v18._loadedSignal:Fire(v20);
                    v18:_runExperiments();
                end;
                return;
            end;
        end);
    end
};