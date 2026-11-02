-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_MemoryStoreService_0 = game:GetService("MemoryStoreService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_DataStoreService_0 = game:GetService("DataStoreService");
local l_RunService_0 = game:GetService("RunService");
local v4 = require(l_ReplicatedStorage_0.Packages.Replion);
local v5 = require(l_ReplicatedStorage_0.Packages.Signal);
local _ = require(script.Parent.Types);
local v7 = require(script.Parent.Environments);
local v8 = require(script.Parent.Overrides);
local v9 = (not (game.GameId == 7709344486) or l_RunService_0:IsStudio()) and 2 or 20;
local v10 = (not (game.GameId == 7709344486) or l_RunService_0:IsStudio()) and 2 or 10;
local v11 = Random.new();
local v12 = nil;
local v13 = nil;
local v14 = {
    _loaded = false, 
    _loadedSignal = v5.new(), 
    _updatedSignal = v5.new()
};
local function v20(v15, v16) --[[ Line: 63 ]] --[[ Name: waitForBudget ]]
    -- upvalues: l_DataStoreService_0 (copy)
    local v17 = v16 or 10;
    local v18 = os.clock();
    local l_v18_0 = v18;
    while l_DataStoreService_0:GetRequestBudgetForRequestType(v15) < 1 and l_v18_0 - v18 < v17 do
        task.wait();
        l_v18_0 = os.clock();
    end;
    return l_v18_0 - v18 < v17;
end;
v14.IsLoaded = function(v21) --[[ Line: 76 ]] --[[ Name: IsLoaded ]]
    return v21._loaded;
end;
v14.OnLoad = function(v22, v23) --[[ Line: 80 ]] --[[ Name: OnLoad ]]
    return v22._loadedSignal:Connect(v23);
end;
v14.OnUpdate = function(v24, v25) --[[ Line: 84 ]] --[[ Name: OnUpdate ]]
    return v24._updatedSignal:Connect(v25);
end;
v14.OnChange = function(_, v27, v28) --[[ Line: 88 ]] --[[ Name: OnChange ]]
    -- upvalues: v13 (ref)
    return v13:OnChange({
        "Values", 
        v27
    }, v28);
end;
v14.Get = function(v29, v30, v31) --[[ Line: 93 ]] --[[ Name: Get ]]
    -- upvalues: v13 (ref)
    if not v29:IsLoaded() then
        v29._loadedSignal:Wait();
    end;
    local v32 = v13:Get({
        "Values", 
        v30
    });
    if v32 == nil then
        return v31;
    else
        return v32;
    end;
end;
v14.GetInstant = function(_, v34, v35) --[[ Line: 106 ]] --[[ Name: GetInstant ]]
    -- upvalues: v13 (ref)
    local v36 = v13:Get({
        "Values", 
        v34
    });
    if v36 == nil then
        return v35;
    else
        return v36;
    end;
end;
v14.Set = function(_, v38, v39, v40) --[[ Line: 115 ]] --[[ Name: Set ]]
    -- upvalues: v12 (ref), v13 (ref), v8 (copy), v9 (copy), l_MemoryStoreService_0 (copy), v10 (copy), l_DataStoreService_0 (copy), v20 (copy)
    if v40 == v12 or v40 == "all" or v40 == "local" then
        v13:Set({
            "Values", 
            v38
        }, v39);
        v13:Set("LastChange", workspace:GetServerTimeNow());
    end;
    if v40 == "local" then
        if not v8[v12] then
            v8[v12] = {};
        end;
        v8[v12][v38] = v39;
        return true;
    else
        local function v50(v41) --[[ Line: 130 ]] --[[ Name: transformData ]]
            -- upvalues: v38 (copy), v40 (copy), v39 (copy)
            local l_UnixTimestamp_0 = DateTime.now().UnixTimestamp;
            local v43 = if v41 and typeof(v41) == "table" and typeof(v41.Values) == "table" then v41 else {
                Values = {}, 
                LastUpdate = l_UnixTimestamp_0
            };
            local v44 = false;
            for _, v46 in v43.Values do
                local v47 = v46[1];
                local v48 = v46[3];
                if v38 == v47 and v40 == v48 then
                    v44 = true;
                    v46[2] = v39;
                    if v40 == nil then
                        table.remove(v46, 3);
                    else
                        v46[3] = v40;
                    end;
                end;
            end;
            if not v44 then
                local v49 = {
                    v38, 
                    v39
                };
                if v40 ~= nil then
                    table.insert(v49, v40);
                end;
                table.insert(v43.Values, v49);
            end;
            v43.LastUpdate = DateTime.now().UnixTimestamp;
            return v43;
        end;
        for v51 = 1, v9 do
            local l_status_0, l_result_0 = pcall(function() --[[ Line: 181 ]]
                -- upvalues: l_MemoryStoreService_0 (ref), v51 (copy)
                return l_MemoryStoreService_0:GetHashMap((("FFlags-%*"):format(v51)));
            end);
            if not l_status_0 then
                warn((("Failed to save HashMap FFlags-%*/FFlags: %*"):format(v51, l_result_0)));
            else
                local l_status_1, l_result_1 = pcall(function() --[[ Line: 190 ]]
                    -- upvalues: l_result_0 (copy), v50 (copy)
                    return l_result_0:UpdateAsync("FFlags", v50, 3888000);
                end);
                if not l_status_1 then
                    warn((("Failed to update HashMap FFlags-%*/FFlags: %*"):format(v51, l_result_1)));
                end;
            end;
        end;
        for v56 = 1, v10 do
            local l_status_2, l_result_2 = pcall(function() --[[ Line: 205 ]]
                -- upvalues: l_DataStoreService_0 (ref), v56 (copy)
                return l_DataStoreService_0:GetDataStore((("FFlags-%*"):format(v56)));
            end);
            if not l_status_2 then
                warn((("Failed to save DataStore FFlags-%*/FFlags: %*"):format(v56, l_result_2)));
            elseif not v20(Enum.DataStoreRequestType.UpdateAsync, 30) then
                warn("No DataStore:UpdateAsync() request budget available");
                return false;
            else
                local l_status_3, l_result_3 = pcall(function() --[[ Line: 220 ]]
                    -- upvalues: l_result_2 (copy), v50 (copy)
                    return l_result_2:UpdateAsync("FFlags", v50);
                end);
                if not l_status_3 then
                    warn((("Failed to update DataStore FFlags-%*/FFlags: %*"):format(v56, l_result_3)));
                end;
            end;
        end;
        return true;
    end;
end;
v14._loadMemoryStore = function(_, v62) --[[ Line: 233 ]] --[[ Name: _loadMemoryStore ]]
    -- upvalues: v11 (copy), v9 (copy), l_MemoryStoreService_0 (copy)
    local v63 = v62 or v11:NextInteger(1, v9);
    local l_status_4, l_result_4 = pcall(function() --[[ Line: 235 ]]
        -- upvalues: l_MemoryStoreService_0 (ref), v63 (copy)
        return l_MemoryStoreService_0:GetHashMap((("FFlags-%*"):format(v63)));
    end);
    if not l_status_4 then
        warn((("MemoryStoreService:GetHashMap() failed on 'FFlags-%*': %*"):format(v63, l_result_4)));
        return false;
    else
        local l_status_5, l_result_5 = pcall(function() --[[ Line: 244 ]]
            -- upvalues: l_result_4 (copy)
            return l_result_4:GetAsync("FFlags");
        end);
        if not l_status_5 then
            warn((("Failed to load HashMap FFlags-%*/FFlags: %*"):format(v63, l_result_5)));
            return false;
        elseif typeof(l_result_5) ~= "table" or typeof(l_result_5.Values) ~= "table" then
            warn((("Invalid data format in HashMap FFlags-%*/FFlags: %*"):format(v63, l_result_5)));
            l_result_5 = {
                Values = {}, 
                LastUpdate = 0
            };
            return false;
        else
            local l_UnixTimestamp_1 = DateTime.now().UnixTimestamp;
            local _ = l_UnixTimestamp_1 - (if typeof(l_result_5.LastUpdate) == "number" then l_result_5.LastUpdate else l_UnixTimestamp_1) >= 2592000;
            return true, l_result_5;
        end;
    end;
end;
v14._loadDataStore = function(_, v71) --[[ Line: 308 ]] --[[ Name: _loadDataStore ]]
    -- upvalues: v11 (copy), v10 (copy), l_DataStoreService_0 (copy), v20 (copy)
    local v72 = v71 or v11:NextInteger(1, v10);
    local l_status_6, l_result_6 = pcall(function() --[[ Line: 310 ]]
        -- upvalues: l_DataStoreService_0 (ref), v72 (copy)
        return l_DataStoreService_0:GetDataStore((("FFlags-%*"):format(v72)));
    end);
    if not l_status_6 then
        warn((("DataStoreService:GetDataStore() failed on 'FFlags-%*': %*"):format(v72, l_result_6)));
        return false;
    else
        local l_DataStoreGetOptions_0 = Instance.new("DataStoreGetOptions");
        l_DataStoreGetOptions_0.UseCache = false;
        if not v20(Enum.DataStoreRequestType.GetAsync) then
            warn("No DataStore:GetAsync() request budget available");
            return false;
        else
            local l_status_7, l_result_7 = pcall(function() --[[ Line: 328 ]]
                -- upvalues: l_result_6 (copy), l_DataStoreGetOptions_0 (copy)
                return l_result_6:GetAsync("FFlags", l_DataStoreGetOptions_0);
            end);
            if not l_status_7 then
                warn((("Failed to load DataStore FFlags-%*/FFlags: %*"):format(v72, l_result_7)));
                return false;
            else
                if typeof(l_result_7) ~= "table" or typeof(l_result_7.Values) ~= "table" then
                    warn((("Invalid data format in DataStore FFlags-%*/FFlags: %*"):format(v72, l_result_7)));
                    l_result_7 = {
                        Values = {}, 
                        LastUpdate = 0
                    };
                end;
                return true, l_result_7;
            end;
        end;
    end;
end;
v14.Load = function(v78) --[[ Line: 350 ]] --[[ Name: Load ]]
    -- upvalues: l_RunService_0 (copy), v12 (ref), v13 (ref), v4 (copy), v8 (copy)
    local v79 = nil;
    local v80 = nil;
    if l_RunService_0:IsStudio() then
        local v81, v82 = v78:_loadDataStore();
        v79 = v81;
        v80 = v82;
    else
        local v83, v84 = v78:_loadMemoryStore();
        v79 = v83;
        v80 = v84;
    end;
    if not v79 then
        local v85 = 0;
        while v85 < 3 and not v79 do
            warn((("Failed to load FFlags %*, retrying..."):format(l_RunService_0:IsStudio() and "DataStore" or "MemoryStore HashMap")));
            v85 = v85 + 1;
            task.wait(v85 * 1);
            local v86, v87 = v78:_loadMemoryStore();
            v79 = v86;
            v80 = v87;
        end;
        if not v79 then
            warn("All attempts to load FFlags MemoryStore HashMaps failed, loading DataStore instead");
            local v88, v89 = v78:_loadDataStore();
            v79 = v88;
            v80 = v89;
        end;
    end;
    if not v79 or not v80 then
        warn("Failed to load FFlags: both MemoryStore and DataStore requests failed!");
        return false;
    else
        local v90 = {};
        for _, v92 in v80.Values do
            local v93 = v92[1];
            local v94 = v92[2];
            local v95 = v92[3] or "all";
            if v93 and (v95 ~= "all" or not v90[v93]) and (v95 == v12 or v95 == "all") then
                v90[v93] = v94;
            end;
        end;
        for v96, _ in v13.Data.Values do
            if v90[v96] == nil then
                v90[v96] = v4.None;
            end;
        end;
        if v8[v12] then
            for v98, v99 in v8[v12] do
                v90[v98] = v99;
            end;
        end;
        local l_workspace_ServerTimeNow_0 = workspace:GetServerTimeNow();
        v13:Update({
            Loaded = true, 
            LastUpdate = l_workspace_ServerTimeNow_0, 
            LastChange = l_workspace_ServerTimeNow_0, 
            Values = v90
        });
        if not v78._loaded then
            v78._loaded = true;
            v78._loadedSignal:Fire(v13.Data);
        end;
        v78._updatedSignal:Fire(v13.Data);
        return true;
    end;
end;
v14.Start = function(v101) --[[ Line: 432 ]] --[[ Name: Start ]]
    -- upvalues: v7 (copy), v12 (ref), l_RunService_0 (copy), v11 (copy)
    for v102, v103 in v7 do
        if v103.UniverseIds and table.find(v103.UniverseIds, game.GameId) then
            v12 = if l_RunService_0:IsStudio() and v103.StudioEnvironment then v103.StudioEnvironment else v102;
            break;
        elseif not v103.UniverseIds or #v103.UniverseIds == 0 and not v12 then
            v12 = v102;
        end;
    end;
    if v12 then
        local v104 = 0;
        while true do
            local l_workspace_ServerTimeNow_1 = workspace:GetServerTimeNow();
            if v104 < l_workspace_ServerTimeNow_1 then
                v104 = l_workspace_ServerTimeNow_1 + 300 * v11:NextNumber(0.7, 1.3);
                v101:Load();
            end;
            task.wait(1);
        end;
    end;
--    warn((("Failed to find matching Environment for UniverseId %*"):format(game.GameId)));
end;
v13 = v4.Server.new({
    Channel = "FFlags", 
    ReplicateTo = "All", 
    Data = {
        Values = {}, 
        Loaded = false, 
        LastUpdate = 0, 
        LastChange = 0
    }
});
task.spawn(v14.Start, v14);
return v14;