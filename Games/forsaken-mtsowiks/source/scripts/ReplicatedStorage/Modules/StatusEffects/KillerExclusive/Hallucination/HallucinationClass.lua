-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: HallucinationClass, time of decompilation: Fri Nov 28 21:06:21 2025 ]]
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_TweenService_0 = game:GetService("TweenService");
local v3 = require(l_ReplicatedStorage_0.Modules.Sounds);
local v4 = require(l_ReplicatedStorage_0.Modules.Util);
local v5 = require(l_ReplicatedStorage_0.Assets.Killers.Noli.Config);
local v6 = {};
v6.__index = v6;
v6.getClosestSpawnPos = function(v7, v8) --[[ Line: 25 ]] --[[ Name: getClosestSpawnPos ]]
    -- upvalues: v4 (copy)
    local l_v7_0 = v7;
    local v10 = {};
    local l_FirstChild_0 = workspace.Map.Ingame:FindFirstChild("SpawnPoints", true);
    local l_Map_0 = workspace.Map.Ingame:FindFirstChild("Map");
    if l_Map_0 and l_Map_0:FindFirstChild("ItemLocations") then
        for _, v14 in ipairs(l_Map_0.ItemLocations:GetChildren()) do
            if v14:IsA("BasePart") then
                table.insert(v10, v14);
            end;
        end;
    end;
    if l_Map_0 then
        for _, v16 in ipairs(l_Map_0:GetChildren()) do
            if v16:IsA("Model") and (v16.Name == "Generator" or v16.Name == "FakeGenerator") then
                table.insert(v10, v16.Positions.Center);
            end;
        end;
    end;
    if l_FirstChild_0 then
        local v17 = l_FirstChild_0 and l_FirstChild_0:FindFirstChild("Survivors");
        local v18 = l_FirstChild_0 and l_FirstChild_0:FindFirstChild("Killers");
        for _, v20 in ipairs({
            v17, 
            v18
        }) do
            for _, v22 in ipairs(v20:GetChildren()) do
                if v22:IsA("BasePart") then
                    table.insert(v10, v22);
                end;
            end;
        end;
    end;
    if next(v10) then
        local v23 = nil;
        local v24 = nil;
        for _, v26 in ipairs(v10) do
            local l_Magnitude_0 = ((v7 - v26.Position) * Vector3.new(1, 6, 1, 0)).Magnitude;
            if l_Magnitude_0 >= v8 and not v4:IsOnScreen(v26, true) and (not v23 or v24 and l_Magnitude_0 < v24) then
                v23 = v26;
                v24 = l_Magnitude_0;
            end;
        end;
        l_v7_0 = v23.Position;
    end;
    return l_v7_0;
end;
v6.new = function(v28, v29, v30) --[[ Line: 86 ]] --[[ Name: new ]]
    -- upvalues: v6 (copy)
    assert(game["Run Service"]:IsClient(), "what are you doing????");
    local v31 = {
        Running = true, 
        Killer = v29, 
        Survivor = v28, 
        Player = v28.Player, 
        Gui = v28.Player.PlayerGui, 
        Status = v30
    };
    setmetatable(v31, v6);
    return v31;
end;
v6.GetBearing = function(_, v33, v34) --[[ Line: 105 ]] --[[ Name: GetBearing ]]
    local l_CFrame_0 = (v34 or workspace.CurrentCamera).CFrame;
    local l_Unit_0 = (l_CFrame_0.LookVector * Vector3.new(1, 0, 1, 0)).Unit;
    local l_Unit_1 = (l_CFrame_0.RightVector * Vector3.new(1, 0, 1, 0)).Unit;
    return (math.cos((math.rad(v33))) * l_Unit_0 + math.sin((math.rad(v33))) * l_Unit_1).Unit;
end;
v6.GetRandomSpawnInCone = function(v38, v39, v40, v41, v42, v43) --[[ Line: 115 ]] --[[ Name: GetRandomSpawnInCone ]]
    v41 = v41 or 100;
    v42 = v42 or 5;
    v43 = v43 or 1;
    local v44 = (v40.Max - v40.Min) * Random.new():NextNumber();
    local v45 = v40.Min + v44;
    local l_v39_0 = v39;
    for v47 = 0, v40.Max - v40.Min, (v40.Max - v40.Min) / v42 do
        local v48 = v45 + v47;
        while v40.Max < v48 do
            v48 = v48 - (v40.Max - v40.Min);
        end;
        local v49 = RaycastParams.new();
        v49.RespectCanCollide = true;
        v49.CollisionGroup = "Items";
        v49.FilterType = Enum.RaycastFilterType.Exclude;
        v49.FilterDescendantsInstances = {
            workspace.Players
        };
        local v50 = v38:GetBearing(v48) * v41;
        local v51 = workspace:Raycast(v39, v50, v49);
        if v51 then
            if (v51.Position - v39).Magnitude > (l_v39_0 - v39).Magnitude then
                l_v39_0 = v51.Position;
            end;
        else
            l_v39_0 = v39 + v50;
            break;
        end;
    end;
    return v39 + (l_v39_0 - v39) * v43;
end;
v6.CreateFakeStatus = function(v52, v53, v54, v55) --[[ Line: 156 ]] --[[ Name: CreateFakeStatus ]]
    -- upvalues: l_ReplicatedStorage_0 (copy), v4 (copy), l_RunService_0 (copy)
    v52.FakeStatuses = v52.FakeStatuses or {};
    v55 = v55 or 10;
    local v56 = tick();
    local l_StatusContainer_0 = game.Players.LocalPlayer.PlayerGui.MainUI.StatusContainer;
    local v58 = l_ReplicatedStorage_0.Modules.Statuses.StatusDisplay:Clone();
    v58.Name = "Fake" .. v53;
    v58.Timer.Text = v4:FormatTime(math.round(v55 - (tick() - v56)), "Clock");
    v58.Title.Text = ("%* %*"):format(v53, (v4:IntToRoman(v54)));
    v58.Parent = l_StatusContainer_0;
    v58.Visible = true;
    local v60 = l_StatusContainer_0.ChildAdded:Connect(function(v59) --[[ Line: 171 ]]
        -- upvalues: v53 (copy)
        if v59.Name == v53 and v59.Visible then
            v59.Visible = false;
            v59:SetAttribute("WasVisible", true);
        end;
    end);
    v58.Destroying:Connect(function() --[[ Line: 178 ]]
        -- upvalues: v60 (copy), l_StatusContainer_0 (copy), v53 (copy)
        v60:Disconnect();
        local l_l_StatusContainer_0_FirstChild_0 = l_StatusContainer_0:FindFirstChild(v53);
        if l_l_StatusContainer_0_FirstChild_0 and l_l_StatusContainer_0_FirstChild_0:GetAttribute("WasVisible") then
            l_l_StatusContainer_0_FirstChild_0.Visible = true;
            l_l_StatusContainer_0_FirstChild_0:SetAttribute("WasVisible", nil);
        end;
    end);
    if v52.FakeStatuses[v53] then
        v52.FakeStatuses[v53]:Destroy();
        v52.FakeStatuses[v53] = nil;
    end;
    v52.FakeStatuses[v53] = v58;
    local l_l_StatusContainer_0_FirstChild_1 = l_StatusContainer_0:FindFirstChild(v53);
    if l_l_StatusContainer_0_FirstChild_1 and l_l_StatusContainer_0_FirstChild_1.Visible then
        l_l_StatusContainer_0_FirstChild_1.Visible = false;
        l_l_StatusContainer_0_FirstChild_1:SetAttribute("WasVisible", true);
    end;
    task.spawn(function() --[[ Line: 199 ]]
        -- upvalues: v58 (copy), l_StatusContainer_0 (copy), v56 (copy), v55 (ref), v4 (ref), l_RunService_0 (ref)
        while v58 and v58.Parent == l_StatusContainer_0 and tick() - v56 <= v55 do
            v58.Timer.Text = v4:FormatTime(math.round(v55 - (tick() - v56)), "Clock");
            l_RunService_0.Heartbeat:Wait();
        end;
        if v58 then
            v58:Destroy();
        end;
    end);
    return v58;
end;
v6.GetKillerConfig = function(v63) --[[ Line: 213 ]] --[[ Name: GetKillerConfig ]]
    -- upvalues: v5 (copy)
    return v63.Killer and v63.Killer.Config or v5;
end;
v6.Screamer = function(v64) --[[ Line: 217 ]] --[[ Name: Screamer ]]
    -- upvalues: l_RunService_0 (copy), v3 (copy), v4 (copy), l_TweenService_0 (copy)
    local l_v64_KillerConfig_0 = v64:GetKillerConfig();
    local v66 = l_v64_KillerConfig_0 and l_v64_KillerConfig_0.HallucinationScreamer;
    if not v66 then
        return;
    else
        local l_HallucinationScreamer_0 = l_v64_KillerConfig_0.Sounds.HallucinationScreamer;
        task.spawn(function() --[[ Line: 225 ]]
            -- upvalues: v66 (copy), l_RunService_0 (ref), v3 (ref), l_HallucinationScreamer_0 (copy), v4 (ref), v64 (copy), l_TweenService_0 (ref)
            local l_CurrentCamera_0 = workspace.CurrentCamera;
            local v69 = v66:Clone();
            v69.Parent = l_CurrentCamera_0;
            local l_v69_FirstChild_0 = v69:FindFirstChild("Animator", true);
            local l_Animation_0 = v69:FindFirstChildOfClass("Animation");
            local v72 = l_v69_FirstChild_0:LoadAnimation(l_Animation_0);
            print(v69, l_v69_FirstChild_0, l_Animation_0, v72);
            if not v72 or not v69 or not v69:FindFirstChild("MagicGuy") then
                if v69 then
                    v69:Destroy();
                end;
                return;
            else
                while v72.Length == 0 do
                    l_RunService_0.Heartbeat:Wait();
                end;
                v69.Parent = l_CurrentCamera_0;
                v72:Play();
                v3:Play(l_HallucinationScreamer_0);
                local v73 = {};
                for _, v75 in ipairs(v69.MagicGuy:GetDescendants()) do
                    if v75:IsA("ImageLabel") then
                        if not v4:GetSettingValue("EpilepsyMode", game.Players.LocalPlayer) or not v64.Killer.Config.isScreamerSensitive then
                            v75:SetAttribute("Spritesheet", v64.Killer.Config.ScreamerSpritesheet or "NoliLaugh");
                            v75:AddTag("Spritesheet");
                        elseif v4:GetSettingValue("EpilepsyMode", game.Players.LocalPlayer) and v64.Killer.Config.isScreamerSensitive then
                            v75.Image = v64.Killer.Config.SensitiveScreamerImage or "rbxassetid://89949595020859";
                        end;
                        table.insert(v73, v75);
                    end;
                end;
                local v76 = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 266 ]]
                    -- upvalues: v69 (copy), l_CurrentCamera_0 (copy)
                    v69:SetPrimaryPartCFrame(l_CurrentCamera_0.CFrame);
                end);
                local l_Size_0 = v69.MagicGuy.Size;
                v69.MagicGuy.Size = Vector3.new(0, 0, 0, 0);
                l_TweenService_0:Create(v69.MagicGuy, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Size = l_Size_0
                }):Play();
                task.delay(v72.Length - 0.5, function() --[[ Line: 274 ]]
                    -- upvalues: v73 (copy), l_TweenService_0 (ref), v69 (copy)
                    for _, v79 in ipairs(v73) do
                        v79:SetAttribute("TimeScale", 3);
                    end;
                    l_TweenService_0:Create(v69.MagicGuy, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        Size = Vector3.new(0, 0, 0, 0)
                    }):Play();
                end);
                task.delay(v72.Length, function() --[[ Line: 282 ]]
                    -- upvalues: v76 (copy), v69 (copy)
                    v76:Disconnect();
                    v69:Destroy();
                end);
                return;
            end;
        end);
        return;
    end;
end;
v6.Clean = function(v80) --[[ Line: 289 ]] --[[ Name: Clean ]]
    local l_ipairs_0 = ipairs;
    local v82 = v80.FakeStatuses or {};
    for _, v84 in l_ipairs_0(v82) do
        v84:Destroy();
    end;
    v80.Running = false;
    table.clear(v80);
    v80 = nil;
end;
return v6;