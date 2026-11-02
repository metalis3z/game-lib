-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_RunService_0 = game:GetService("RunService");
local _ = l_RunService_0:IsClient();
local v3 = l_RunService_0:IsServer();
local v4 = require(game.ReplicatedStorage.Modules.Network);
local v5 = require(game.ReplicatedStorage.Modules.Util);
local v6 = require(game.ReplicatedStorage.Modules.Sounds);
local v7 = require(game.ReplicatedStorage.Modules.Schematics.Lighting);
local v8 = Random.new();
local v9 = {
    SpawnChance = 50, 
    MinSpawned = 1, 
    MaxSpawned = 8
};
v0.GetSelectableMaps = function(_) --[[ Line: 23 ]] --[[ Name: GetSelectableMaps ]]
    -- upvalues: v3 (copy)
    if not v3 then
        return;
    else
        local v11 = {};
        local l_Children_0 = game.ServerStorage.Assets.Maps:GetChildren();
        for _, v14 in pairs(l_Children_0) do
            local l_Config_0 = v14:FindFirstChild("Config");
            local v16 = l_Config_0 and require(l_Config_0);
            if v16 then
                local v17 = true;
                if v16.Disabled or v16.Exclusive then
                    v17 = false;
                end;
                local l_CurrentSession_0 = require(game.ServerStorage.ServerSystems.RoundManager).CurrentSession;
                local v19 = l_CurrentSession_0 and l_CurrentSession_0.Players;
                if v19 and v16.PlayerRequirement then
                    if typeof(v16.PlayerRequirement) == "NumberRange" and (#v19 < v16.PlayerRequirement.Min or #v19 > v16.PlayerRequirement.Max) then
                        v17 = false;
                    end;
                    if typeof(v16.PlayerRequirement) == "number" and #v19 < v16.PlayerRequirement then
                        v17 = false;
                    end;
                end;
                if v16.BlacklistedKillers then
                    for _, v21 in pairs(workspace.Players.Killers:GetChildren()) do
                        if table.find(v16.BlacklistedKillers, v21.Name) then
                            v17 = false;
                        end;
                    end;
                end;
                if v17 and v14:FindFirstChild("Map") and v14.Map:FindFirstChild("SpawnPoints") then
                    table.insert(v11, v14);
                end;
            end;
        end;
        return v11;
    end;
end;
v0.SelectRandomMap = function(_) --[[ Line: 71 ]] --[[ Name: SelectRandomMap ]]
    -- upvalues: v0 (copy), v5 (copy)
    if v0.__randomMapOrder and v0.__randomMapOrder[1] then
        local v23 = v0.__randomMapOrder[1];
        table.remove(v0.__randomMapOrder, 1);
        return v23;
    else
        v0.__randomMapOrder = v0:GetSelectableMaps();
        if v0.__randomMapOrder[1] then
            v5:ShuffleTable(v0.__randomMapOrder);
            return v0:SelectRandomMap();
        else
            return game.ServerStorage.Assets.Maps["Planet Voss"];
        end;
    end;
end;
v0.CreateMap = function(_, v25) --[[ Line: 87 ]] --[[ Name: CreateMap ]]
    -- upvalues: v3 (copy), v0 (copy), v7 (copy), v9 (copy), v8 (copy), v6 (copy), v4 (copy)
    if not v3 then
        return;
    else
        if workspace:GetAttribute("ForcedMap") and v25:lower():find("random") then
            v25 = workspace:GetAttribute("ForcedMap");
            workspace:SetAttribute("ForcedMap", nil);
        end;
        if typeof(v25) == "string" and not v25:lower():find("random") then
            v25 = game.ServerStorage.Assets.Maps:FindFirstChild(v25) or "random";
        end;
        if typeof(v25) == "string" and v25:lower():find("random") then
            v25 = v0:SelectRandomMap();
        end;
        if typeof(v25) ~= "Instance" then
            return;
        else
            local v26 = {
                MapFolder = v25, 
                Map = v25.Map:Clone(), 
                Config = require(v25.Config)
            };
            v26.Map.Parent = workspace.Map.Ingame;
            require(game.ReplicatedStorage.Modules.Stats):UpdateRoundStat("MapName", "Set", v26.Config.DisplayName);
            if v25:FindFirstChild("Lighting") then
                v7:SetCustomLighting(v25.Lighting);
            end;
            for _, v28 in pairs(workspace.Players:GetChildren()) do
                local l_FirstChild_0 = v26.Map.SpawnPoints:FindFirstChild(v28.Name);
                if l_FirstChild_0 then
                    for _, v31 in pairs(v28:GetChildren()) do
                        if v31.PrimaryPart then
                            local l_l_FirstChild_0_Children_0 = l_FirstChild_0:GetChildren();
                            local v33 = l_l_FirstChild_0_Children_0[math.random(1, #l_l_FirstChild_0_Children_0)];
                            if v33 then
                                v31.PrimaryPart.Anchored = true;
                                task.spawn(function() --[[ Line: 120 ]]
                                    -- upvalues: v31 (copy), v33 (copy)
                                    local v34 = 0;
                                    while v31.PrimaryPart and v34 <= 4 do
                                        v31:SetPrimaryPartCFrame(v33.CFrame + Vector3.new(0, 2, 0, 0));
                                        v34 = v34 + task.wait(0.15);
                                    end;
                                    if v31.PrimaryPart then
                                        v31.PrimaryPart.Anchored = false;
                                    end;
                                end);
                            end;
                        end;
                    end;
                end;
            end;
            task.spawn(function() --[[ Line: 135 ]]
                -- upvalues: v26 (copy)
                local v35 = OverlapParams.new();
                v35.FilterType = Enum.RaycastFilterType.Include;
                v35.FilterDescendantsInstances = {
                    workspace.Players.Survivors, 
                    workspace.Players.Killers, 
                    workspace.Players.Spectating
                };
                while task.wait(1) and v26.Map.Parent do
                    local l_BoundingBox_0, v37 = v26.Map:GetBoundingBox();
                    local l_workspace_PartBoundsInBox_0 = workspace:GetPartBoundsInBox(l_BoundingBox_0, v37, v35);
                    for _, v40 in pairs({
                        workspace.Players.Survivors, 
                        workspace.Players.Killers
                    }) do
                        for _, v42 in pairs(v40:GetChildren()) do
                            if v42.PrimaryPart and not table.find(l_workspace_PartBoundsInBox_0, v42.PrimaryPart) then
                                local l_FirstChild_1 = v26.Map.SpawnPoints:FindFirstChild(v40.Name);
                                local v44 = l_FirstChild_1 and l_FirstChild_1:GetChildren();
                                local v45 = v44 and v44[math.random(1, #v44)];
                                if v45 then
                                    for _, v47 in pairs(v42:GetDescendants()) do
                                        if v47:IsA("BasePart") then
                                            v47.Velocity = Vector3.new();
                                        end;
                                    end;
                                    v42:SetPrimaryPartCFrame(v45.CFrame + Vector3.new(0, 2, 0, 0));
                                end;
                            end;
                        end;
                    end;
                    for _, v49 in pairs(workspace.Players.Spectating:GetChildren()) do
                        if v49.PrimaryPart and table.find(l_workspace_PartBoundsInBox_0, v49.PrimaryPart) then
                            local l_Humanoid_0 = v49:FindFirstChild("Humanoid");
                            if l_Humanoid_0 then
                                l_Humanoid_0.Health = 0;
                            end;
                        end;
                    end;
                end;
            end);
            for _, v52 in pairs(v26.Map.SpawnPoints:GetChildren()) do
                for _, v54 in pairs(v52:GetChildren()) do
                    v54:ClearAllChildren();
                    v54.Transparency = 1;
                    v54.Anchored = true;
                    v54.CanCollide = false;
                    v54.CanQuery = false;
                    v54.CanTouch = false;
                    if v54:IsA("SpawnLocation") then
                        v54.Enabled = false;
                    end;
                end;
			end;
            require(game.ReplicatedStorage.Modules.Objectives):InitializeObjectives(v25:FindFirstChild("Objectives"), v26);
            local l_ItemLocations_0 = v26.Map:FindFirstChild("ItemLocations");
            if l_ItemLocations_0 then
                local v56 = {};
                for _, v58 in pairs(l_ItemLocations_0:GetChildren()) do
                    if game.ReplicatedStorage.Assets.Items:FindFirstChild(v58.Name) then
                        if not v56[v58.Name] then
                            v56[v58.Name] = {};
                        end;
                        table.insert(v56[v58.Name], v58);
                    else
                        warn((("tried to create item (%*) that doesn't exist in the %* map!"):format(v58.Name, v25.Name)));
                    end;
                    v58:Destroy();
                end;
                local v59 = #game.Players:GetPlayers() / game.Players.MaxPlayers + 1;
                for v60, v61 in pairs(v56) do
                    local l_FirstChild_2 = game.ReplicatedStorage.Assets.Items:FindFirstChild(v60);
                    local v63 = l_FirstChild_2 and l_FirstChild_2:FindFirstChild("Config") and require(l_FirstChild_2.Config) or {};
                    local v64 = v26.Config.ItemSpawnInfo and v26.Config.ItemSpawnInfo[v60] or v63.SpawnInfo or v9;
                    local v65 = 0;
                    for _ = 1, math.clamp(math.round(v64.MaxSpawned * v59), 0, v64.MaxSpawned) do
                        local v67 = true;
                        if v65 > v64.MinSpawned then
                            v67 = false;
                            if v65 <= v64.MaxSpawned then
                                v67 = v8:NextNumber(0, 100) <= v64.SpawnChance;
                            end;
                        end;
                        if v67 then
                            local v68 = math.random(1, (math.clamp(#v61, 1, 1e999)));
                            local v69 = v61[v68];
                            if v69 then
                                local l_Item_0 = require(game.ReplicatedStorage.Modules.Items):CreateItem(v60);
                                l_Item_0.Item.Parent = workspace.Map.Ingame;
                                l_Item_0:SetCFrame(v69.CFrame);
                                table.remove(v61, v68);
                                v65 = v65 + 1;
                            end;
                        end;
                    end;
                end;
            end;
            for _, v72 in pairs(v26.Map:GetDescendants()) do
                if v72:IsA("BasePart") and not v72.CanCollide and not v72:FindFirstChild("ClickDetector") then
                    v72.CanQuery = false;
                end;
            end;
            for _, v74 in pairs(v26.Map:GetDescendants()) do
                if v74.Name == "MapBorder" and v74:IsA("BasePart") then
                    v6:Play("mapBorderStatic", {
                        Parent = v74, 
                        Looped = true, 
                        RollOffMinDistance = 0, 
                        RollOffMaxDistance = 30
                    });
                end;
            end;
            if v26.Config.Ambience then
                local v75 = v26.Config.AmbienceProperties or {};
                if not v75.Priority then
                    v75.Priority = 0.5;
                end;
                v75.Name = "MapAmbience";
                v6:PlayTheme(v26.Config.Ambience, v75);
            end;
            if v26.Config.Created then
                v26.Config.Created(v26);
            end;
            local v76 = v25.Config:Clone();
            v76.Parent = v26.Map;
            v4:FireAllClientConnection("ReplicateMapCreation", "REMOTE_EVENT", v76);
            v26.Map.AncestryChanged:Connect(function(_, v78) --[[ Line: 274 ]]
                -- upvalues: v7 (ref), v6 (ref), v26 (copy)
                if not v78 then
                    game.ReplicatedStorage.ObjectiveStorage:ClearAllChildren();
                    v7:SetDefaultLighting();
                    v6:StopTheme("MapAmbience");
                    if v26.Config.Destroyed then
                        v26.Config.Destroyed(v26);
                    end;
                end;
            end);
            return v26;
        end;
    end;
end;
return v0;