-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Players_0 = game:GetService("Players");
local l_RunService_0 = game:GetService("RunService");
local v3 = l_RunService_0:IsServer() and game:GetService("ServerScriptService");
local v4 = l_RunService_0:IsServer() and game:GetService("ServerStorage");
local l_Debris_0 = game:GetService("Debris");
local v6 = require(l_ReplicatedStorage_0.Modules.Items);
local v7 = require(l_ReplicatedStorage_0.Modules.Objectives);
local v8 = require(l_ReplicatedStorage_0.Modules.Stats);
local v9 = require(l_ReplicatedStorage_0.Modules.Network);
local v10 = require(l_ReplicatedStorage_0.Modules.Util);
local v11 = require(l_ReplicatedStorage_0.Modules.Sounds);
local v12 = require(l_ReplicatedStorage_0.Modules.Schematics.Lighting);
local v13 = Random.new();
local v14 = l_RunService_0:IsClient();
local v15 = l_RunService_0:IsServer();
local v16 = l_RunService_0:IsStudio();
local v17 = {};
local v18 = {
    SpawnChance = 50, 
    MinSpawned = 1, 
    MaxSpawned = 8
};
local v19 = nil;
local function _(v20) --[[ Line: 65 ]] --[[ Name: __displayWarn ]]
    warn((("[%*]: %*"):format(script, v20)));
end;
local function v27(v22, v23, ...) --[[ Line: 77 ]] --[[ Name: __pcallMethod ]]
    assert(v22, "bad moduleInfo, must be a table");
    local l_status_0, l_result_0 = pcall(function(...) --[[ Line: 80 ]]
        -- upvalues: v22 (copy), v23 (copy)
        if v22[v23] then
            return v22[v23](...);
        else
            return;
        end;
    end, ...);
    if not l_status_0 then
        local v26 = ("Failed to call :%*() due to: %*"):format(v23, l_result_0);
        warn((("[%*]: %*"):format(script, v26)));
    end;
    return l_result_0;
end;
local function _(v28) --[[ Line: 94 ]] --[[ Name: __isMapValid ]]
    return v28:FindFirstChild("Map") and v28.Map:FindFirstChild("SpawnPoints");
end;
local function v40(v30, v31, v32) --[[ Line: 105 ]] --[[ Name: __positionCharacterToSpawnPoint ]]
    -- upvalues: v10 (copy)
    assert(v30, "bad player, must be Model");
    assert(v31 and v31.Parent, "bad castStart, must be Instance");
    local _ = v10:GetActor(v30);
    local l_v10_DistanceFromGround_0 = v10:GetDistanceFromGround(v30);
    local v35 = RaycastParams.new();
    v35.FilterType = Enum.RaycastFilterType.Exclude;
    v35.FilterDescendantsInstances = v32;
    local v36 = workspace:Raycast(v31.Position, Vector3.new(-0, -100, -0, -0), v35);
    local v37 = CFrame.new(v36.Position + Vector3.new(0, l_v10_DistanceFromGround_0, 0));
    local v38 = ("Spawning player %* at position"):format(v30);
    local _ = v37.Position;
    warn((("[%*]: %*"):format(script, v38)));
    v30:PivotTo(v37);
end;
local v55 = {
    GetSelectableMaps = function(_) --[[ Line: 128 ]] --[[ Name: GetSelectableMaps ]]
        -- upvalues: v15 (copy), v17 (copy), v4 (copy), v3 (copy)
        if not v15 then
            return;
        elseif #v17 > 0 then
            return v17;
        else
            for _, v43 in (v4.Assets.Maps:GetChildren()) do
                local l_Config_0 = v43:FindFirstChild("Config");
                local v45 = l_Config_0 and require(l_Config_0);
                if v45 and not v45.Disabled and not v45.Exclusive then
                    local l_CurrentSession_0 = require(v3.Server.Systems.Core.RoundManager).CurrentSession;
                    local v47 = l_CurrentSession_0 and l_CurrentSession_0.Players;
                    if not v47 or not v45.PlayerRequirement or (typeof(v45.PlayerRequirement) ~= "NumberRange" or #v47 >= v45.PlayerRequirement.Min and #v47 <= v45.PlayerRequirement.Max) and (typeof(v45.PlayerRequirement) ~= "number" or #v47 >= v45.PlayerRequirement) then
                        if v45.BlacklistedKillers then
                            for _, v49 in (workspace.Players.Killers:GetChildren()) do
                                if not table.find(v45.BlacklistedKillers, v49.Name) then

                                end;
                            end;
                        end;
                        local l_Variants_0 = v45.Variants;
                        if l_Variants_0 then
                            local v51 = {
                                Name = v43.Name, 
                                Config = l_Config_0, 
                                Maps = {}
                            };
                            for v52, v53 in l_Variants_0 do
                                local l_v43_FirstChild_0 = v43:FindFirstChild(v52);
                                if l_v43_FirstChild_0 and l_v43_FirstChild_0:FindFirstChild("Map") and l_v43_FirstChild_0.Map:FindFirstChild("SpawnPoints") then
                                    v51.Maps[l_v43_FirstChild_0] = v53;
                                end;
                            end;
                            table.insert(v17, v51);
                        elseif not l_Variants_0 and v43 and v43:FindFirstChild("Map") and v43.Map:FindFirstChild("SpawnPoints") then
                            table.insert(v17, v43);
                        end;
                    end;
                end;
            end;
            return v17;
        end;
    end
};
v55.SelectRandomMap = function(_) --[[ Line: 193 ]] --[[ Name: SelectRandomMap ]]
    -- upvalues: v55 (copy), v10 (copy), v4 (copy)
    local v57 = v55.__randomMapOrder and v55.__randomMapOrder[1];
    if v57 then
        table.remove(v55.__randomMapOrder, 1);
        return v57;
    else
        v55.__randomMapOrder = v55:GetSelectableMaps();
        if v55.__randomMapOrder[1] then
            v10:ShuffleTable(v55.__randomMapOrder);
            return v55:SelectRandomMap();
        else
            return v4.Assets.Maps.TemplateTown;
        end;
    end;
end;
v55.Start = function(_) --[[ Line: 212 ]] --[[ Name: Start ]]
    -- upvalues: v14 (copy), v12 (copy)
    if not v14 then
        return;
    else
        v12:SetAsCurrentLighting();
        return;
    end;
end;
v55.CreateMap = function(_, v60) --[[ Line: 221 ]] --[[ Name: CreateMap ]]
    -- upvalues: v15 (copy), v4 (copy), v55 (copy), v8 (copy), v12 (copy), v7 (copy), v6 (copy), l_Players_0 (copy), l_ReplicatedStorage_0 (copy), v18 (copy), v13 (copy), v11 (copy), v27 (copy), v9 (copy), v40 (copy), v16 (copy), v19 (ref)
    if not v15 then
        return;
    else
        local v61 = nil;
        if workspace:GetAttribute("ForcedMap") and v60:lower():find("random") then
            v60 = workspace:GetAttribute("ForcedMap");
            workspace:SetAttribute("ForcedMap", nil);
        end;
        local v62 = string.split(v60, "/");
        if typeof(v60) == "string" and #v62 >= 2 then
            local l_FirstChild_0 = v4.Assets.Maps:FindFirstChild(v62[1]);
            local v64 = l_FirstChild_0[v62[2]];
            if v64 then
                v60 = v64;
                v61 = l_FirstChild_0:FindFirstChild("Config");
            end;
        end;
        if typeof(v60) == "string" and not v60:lower():find("random") then
            v60 = v4.Assets.Maps:FindFirstChild(v60) or "random";
        end;
        if typeof(v60) == "string" and v60:lower():find("random") then
            v60 = v55:SelectRandomMap();
        end;
        if typeof(v60) ~= "Instance" and typeof(v60) ~= "table" then
            return;
        else
            if typeof(v60) == "table" then
                v61 = v60.Config;
                local l_Maps_0 = v60.Maps;
                local v66 = 0;
                for _, v68 in l_Maps_0 do
                    v66 = v66 + v68;
                end;
                local v69 = math.random(v66);
                local v70 = 0;
                for v71, v72 in l_Maps_0 do
                    v70 = v70 + v72;
                    if v69 <= v70 then
                        local v73 = ("Selected map variant: %*/%* with odds of: %*/%*"):format(v60.Name, v71, v72, v66);
                        warn((("[%*]: %*"):format(script, v73)));
                        v60 = v71;
                        break;
                    end;
                end;
            end;
            local v74 = {
                MapFolder = v60, 
                Map = v60.Map:Clone(), 
                Config = require(v61 or v60.Config)
            };
            v74.Map:SetAttribute("MapName", v60.Name);
            v74.Map.Parent = workspace.Map.Ingame;
            local v75 = ("Generating map scene: %*"):format((v60:GetFullName()));
            warn((("[%*]: %*"):format(script, v75)));
            v8:UpdateRoundStat("MapName", "Set", v74.Config.DisplayName);
            if v60:FindFirstChild("Lighting") then
                v12:SetCustomLighting(v60.Lighting);
            end;
            task.spawn(function() --[[ Line: 291 ]]
                -- upvalues: v74 (copy), v55 (ref)
                local v76 = OverlapParams.new();
                v76.FilterType = Enum.RaycastFilterType.Include;
                v76.FilterDescendantsInstances = {
                    workspace.Players.Survivors, 
                    workspace.Players.Killers, 
                    workspace.Players.Spectating
                };
                while task.wait(1) and v74.Map and v74.Map.Parent do
                    local l_BoundingBox_0, v78 = v74.Map:GetBoundingBox();
                    local l_workspace_PartBoundsInBox_0 = workspace:GetPartBoundsInBox(l_BoundingBox_0, v78, v76);
                    for _, v81 in {
                        workspace.Players.Survivors, 
                        workspace.Players.Killers
                    } do
                        for _, v83 in (v81:GetChildren()) do
                            if v83.PrimaryPart and not table.find(l_workspace_PartBoundsInBox_0, v83.PrimaryPart) then
                                v55.PlayerLeftBounds(v83);
                            end;
                        end;
                    end;
                    for _, v85 in (workspace.Players.Spectating:GetChildren()) do
                        if v85.PrimaryPart and table.find(l_workspace_PartBoundsInBox_0, v85.PrimaryPart) then
                            local l_Humanoid_0 = v85:FindFirstChild("Humanoid");
                            if l_Humanoid_0 and not workspace:GetAttribute("Testing") then
                                l_Humanoid_0.Health = 0;
                            end;
                        end;
                    end;
                end;
            end);
            for _, v88 in (v74.Map.SpawnPoints:GetChildren()) do
                for _, v90 in (v88:GetChildren()) do
                    v90:ClearAllChildren();
                    v90.Transparency = 1;
                    v90.Anchored = true;
                    v90.CanCollide = false;
                    v90.CanQuery = false;
                    v90.CanTouch = false;
                    if v90:IsA("SpawnLocation") then
                        v90.Enabled = false;
                    end;
                end;
            end;
            v7:InitializeObjectives(v60:FindFirstChild("Objectives"), v74);
            v75 = v74.Map:FindFirstChild("ItemLocations");
            if v75 then
                local v91 = {};
                for _, v93 in (v75:GetChildren()) do
                    if v6:DoesItemExist(v93.Name) then
                        if not v91[v93.Name] then
                            v91[v93.Name] = {};
                        end;
                        table.insert(v91[v93.Name], v93);
                    else
                        local v94 = ("Tried to create item (%*) that doesn't exist in the %* map!"):format(v93.Name, v60.Name);
                        warn((("[%*]: %*"):format(script, v94)));
                    end;
                    if v93:IsA("BasePart") then
                        v93:ClearAllChildren();
                        v93.Transparency = 1;
                        v93.CanCollide = false;
                        v93.CanQuery = false;
                        v93.Anchored = true;
                        v93.CanTouch = false;
                    end;
                end;
                local v95 = #l_Players_0:GetPlayers() / l_Players_0.MaxPlayers + 1;
                for v96, v97 in v91 do
                    local l_FirstChild_1 = l_ReplicatedStorage_0.Assets.Items:FindFirstChild(v96);
                    local v99 = l_FirstChild_1 and l_FirstChild_1:FindFirstChild("Config") and (require(l_FirstChild_1.Config) or {});
                    local v100 = v74.Config.ItemSpawnInfo and v74.Config.ItemSpawnInfo[v96] or v99.SpawnInfo or v18;
                    local v101 = 0;
                    for _ = 1, math.clamp(math.round(v100.MaxSpawned * v95), 0, v100.MaxSpawned) do
                        local v103 = true;
                        if v101 > v100.MinSpawned then
                            v103 = false;
                            if v101 <= v100.MaxSpawned then
                                v103 = v13:NextNumber(0, 100) <= v100.SpawnChance;
                            end;
                        end;
                        if v103 then
                            local v104 = math.random((math.clamp(#v97, 1, 1e999)));
                            local v105 = v97[v104];
                            if v105 then
                                local l_v6_Item_0 = v6:CreateItem(v96);
                                l_v6_Item_0.Item.Parent = v74.Map;
                                l_v6_Item_0:SetCFrame(v105.CFrame);
                                table.remove(v97, v104);
                                v101 = v101 + 1;
                            end;
                        end;
                    end;
                end;
            end;
            for _, v108 in (v74.Map:GetDescendants()) do
                if v108:IsA("BasePart") and not v108.CanCollide and not v108:FindFirstChild("ClickDetector") then
                    v108.CanQuery = false;
                end;
            end;
            if v74.Config.Ambience then
                local v109 = v74.Config.AmbienceProperties or {};
                if not v109.Priority then
                    v109.Priority = 0.5;
                end;
                v109.Name = "MapAmbience";
                v11:PlayTheme(v74.Config.Ambience, v109);
            end;
            v27(v74.Config, "Created", v74);
            local v110 = (v61 or v60.Config):Clone();
            v110.Parent = v74.Map;
            v9:FireAllClientConnection("ReplicateMapCreation", "REMOTE_EVENT", v110);
            v74.Map.AncestryChanged:Connect(function(_, v112) --[[ Line: 425 ]]
                -- upvalues: l_ReplicatedStorage_0 (ref), v12 (ref), v11 (ref), v27 (ref), v74 (copy)
                if not v112 then
                    l_ReplicatedStorage_0.ObjectiveStorage:ClearAllChildren();
                    v12:SetDefaultLighting();
                    v11:StopTheme("MapAmbience");
                    v27(v74.Config, "Destroyed", v74);
                end;
            end);
            for _, v114 in (workspace.Players:GetChildren()) do
                local l_FirstChild_2 = v74.Map.SpawnPoints:FindFirstChild(v114.Name);
                if l_FirstChild_2 then
                    local l_l_FirstChild_2_Children_0 = l_FirstChild_2:GetChildren();
                    for _, v118 in (v114:GetChildren()) do
                        if v118.PrimaryPart then
                            local v119 = l_l_FirstChild_2_Children_0[math.random(#l_l_FirstChild_2_Children_0)];
                            if v119 then
                                local v120 = ("Got spawnpoint: %* at: %* for player: %*"):format(v119, v119.Position, v118);
                                warn((("[%*]: %*"):format(script, v120)));
                                v118.PrimaryPart.Anchored = true;
                                v40(v118, v119, {
                                    v119, 
                                    v114
                                });
                                task.delay(v16 and 0 or 4, function() --[[ Line: 449 ]]
                                    -- upvalues: v118 (copy)
                                    if v118.PrimaryPart then
                                        v118.PrimaryPart.Anchored = false;
                                    end;
                                end);
                            end;
                        end;
                    end;
                end;
            end;
            v19 = v74;
            return v74;
        end;
    end;
end;
v55.GenerateKillerScene = function(_, v122, v123) --[[ Line: 464 ]] --[[ Name: GenerateKillerScene ]]
    -- upvalues: v15 (copy), v4 (copy), l_Debris_0 (copy)
    if not v15 then
        return;
    else
        assert(v122, "bad winnerRig, must be Model.");
        assert(v123, "bad sceneType, must be \"Outro\" | \"Intro\"");
        local v124 = v4.Assets.Instances.KillerBackgrounds[v123];
        local v125 = v122 and v124:FindFirstChild(v122.Name);
        if v125 then
            local v126 = v125:FindFirstChild((tostring(v122:GetAttribute("SkinName")))) or v125:FindFirstChild("Default");
            if v126 then
                local l_KillerCutsceneBackground_0 = workspace.Misc:FindFirstChild("KillerCutsceneBackground");
                if l_KillerCutsceneBackground_0 then
                    l_KillerCutsceneBackground_0:Destroy();
                end;
                local v128 = v126:Clone();
                v128.Name = "KillerCutsceneBackground";
                v128.Parent = workspace.Misc;
                v128:PivotTo(CFrame.new(0, 10000, 0));
                l_Debris_0:AddItem(v128, 30);
                local v129 = ("Loading up %*/%* scene: %*..."):format(v122.Name, v123, (v126:GetFullName()));
                warn((("[%*]: %*"):format(script, v129)));
            end;
        end;
        return;
    end;
end;
v55.PlayerLeftBounds = function(v130) --[[ Line: 486 ]] --[[ Name: PlayerLeftBounds ]]
    -- upvalues: l_RunService_0 (copy), l_Players_0 (copy), v19 (ref), v40 (copy)
    if l_RunService_0:IsClient() then
        return;
    else
        local l_l_Players_0_PlayerFromCharacter_0 = l_Players_0:GetPlayerFromCharacter(v130);
        local v132 = v130.Parent and v130.Parent.Name;
        if not l_l_Players_0_PlayerFromCharacter_0 or not v132 or not v19 or not v19.Map or not v19.Map.Parent then
            return;
        else
            local l_SpawnPoints_0 = v19.Map:FindFirstChild("SpawnPoints");
            local v134 = l_SpawnPoints_0 and l_SpawnPoints_0:FindFirstChild(v132);
            if not v134 then
                return;
            else
                local v135 = v134 and v134:GetChildren();
                local v136 = v135 and v135[math.random(#v135)];
                if v136 then
                    local v137 = {};
                    for _, v139 in pairs(v130:GetDescendants()) do
                        if v139:IsA("BasePart") then
                            v139.AssemblyLinearVelocity = Vector3.new(0, 0, 0, 0);
                            if not v139.Anchored then
                                v139.Anchored = true;
                                table.insert(v137, v139);
                            end;
                        end;
                    end;
                    local v140 = ("Attempting to spawn in: %*, as they are out of bounds... Found spawn: %*/%* will attempt to spawn there!"):format(v130, v19.Map, v136);
                    warn((("[%*]: %*"):format(script, v140)));
                    v40(v130, v136, {
                        v136, 
                        {
                            workspace.Players.Survivors, 
                            workspace.Players.Killers
                        }
                    });
                    for _, v142 in v137 do
                        v142.Anchored = false;
                    end;
                end;
                local v143 = ("Player %* (%*) left the confines of the map; repositioning"):format(l_l_Players_0_PlayerFromCharacter_0, v130);
                warn((("[%*]: %*"):format(script, v143)));
                return;
            end;
        end;
    end;
end;
return v55;