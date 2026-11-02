-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.__index = v0;
local l_RunService_0 = game:GetService("RunService");
local v2 = l_RunService_0:IsClient();
local v3 = l_RunService_0:IsServer();
v0.Created = function(_) --[[ Line: 11 ]] --[[ Name: Created ]]

end;
v0.Destroyed = function(v5) --[[ Line: 18 ]] --[[ Name: Destroyed ]]
    -- upvalues: v0 (copy)
    v0.Unequipped(v5);
end;
v0.Equipped = function(v6) --[[ Line: 23 ]] --[[ Name: Equipped ]]
    -- upvalues: v3 (copy)
    if v3 then
        for _, v8 in pairs(v6.Item:GetDescendants()) do
            if v8:IsA("Motor6D") and (not v8.Part0 or v8:GetAttribute("WeldToPrimaryPart")) then
                v8:SetAttribute("WeldToPrimaryPart", true);
                v8.Part0 = v6.Player.Character and v6.Player.Character.PrimaryPart;
            end;
        end;
    end;
end;
v0.Unequipped = function(v9) --[[ Line: 35 ]] --[[ Name: Unequipped ]]
    -- upvalues: v2 (copy)
    if v9.HealingThreads and not v9.Completed then
        for _, v11 in pairs(v9.HealingThreads) do
            task.cancel(v11);
        end;
        v9.HealingThreads = nil;
    end;
    if v9.SFX then
        v9.SFX:Destroy();
    end;
    if v9.UI then
        v9.UI:Destroy();
        v9.UI = nil;
    end;
    if v9.SpeedModifier then
        game.TweenService:Create(v9.SpeedModifier, TweenInfo.new(0.5), {
            Value = 1
        }):Play();
        game.Debris:AddItem(v9.SpeedModifier, 0.5);
        v9.SpeedModifier = nil;
    end;
    if v2 then
        require(game.ReplicatedStorage.Modules.Network):FireConnection("DisableSprinting", "UsingMedkit", false);
        if v9.Item and v9.Item.Parent then
            for _, v13 in pairs(v9.Item:GetDescendants()) do
                if v13:IsA("BasePart") then
                    v13.Transparency = 0;
                end;
            end;
        end;
    end;
    local l_pairs_0 = pairs;
    local v15 = v9.BehaviorConnections or {};
    for _, v17 in l_pairs_0(v15) do
        v17:Disconnect();
    end;
    v9.BehaviorConnections = nil;
end;
v0.Activated = function(v18) --[[ Line: 81 ]] --[[ Name: Activated ]]
    -- upvalues: v0 (copy), v2 (copy), v3 (copy)
    local l_Health_0 = v18.Character.Humanoid.Health;
    local v20 = v18.Character.Humanoid:GetAttribute("Overheal") or 0;
    v18.BehaviorConnections = {
        v18.Character.Humanoid.HealthChanged:Connect(function(v21) --[[ Line: 86 ]]
            -- upvalues: l_Health_0 (ref), v0 (ref), v18 (copy), v2 (ref)
            if v21 < l_Health_0 then
                v0.Unequipped(v18);
                if v2 then
                    v18.Animations.Heal:Stop();
                    return;
                end;
            else
                l_Health_0 = v21;
            end;
        end), 
        v18.Character.Humanoid:GetAttributeChangedSignal("Overheal"):Connect(function() --[[ Line: 97 ]]
            -- upvalues: v18 (copy), v20 (ref), v0 (ref), v2 (ref)
            local v22 = v18.Character.Humanoid:GetAttribute("Overheal") or -50;
            if v22 + 5 < v20 then
                v0.Unequipped(v18);
                if v2 then
                    v18.Animations.Heal:Stop();
                    return;
                end;
            else
                v20 = v22;
            end;
        end)
    };
    if v3 and not v18.HealingThreads then
        v18.SFX = require(game.ReplicatedStorage.Modules.Sounds):Play(v18.Config.Sounds.Healing, {
            Parent = v18.Item.ItemRoot
        });
        v18.HealingThreads = {
            task.delay(v18.Config.HealTime, function() --[[ Line: 116 ]]
                -- upvalues: v18 (copy)
                v18.Completed = true;
                local l_Humanoid_0 = v18.Character.Humanoid;
                l_Humanoid_0.Health = l_Humanoid_0.Health + v18.Config.HealAmount;
                v18:Destroy();
            end)
        };
    elseif v2 and not v18.UI then
        v18.Animations.Heal:Play();
        v18.SpeedModifier = require(game.ReplicatedStorage.Modules.Util):CreateSpeedMultiplier(v18.Player, 1, "Medkit");
        game.TweenService:Create(v18.SpeedModifier, TweenInfo.new(0.5), {
            Value = v18.Config.HealSpeedMultiplier
        }):Play();
        require(game.ReplicatedStorage.Modules.Network):FireConnection("DisableSprinting", "UsingMedkit", true);
        v18.UI = game.ReplicatedStorage.Assets.UI.ProgressBar:Clone();
        v18.UI.Title.Text = "Healing";
        v18.UI.Parent = v18.Player.PlayerGui:FindFirstChild("TemporaryUI");
        local function v33(v24, v25) --[[ Line: 141 ]] --[[ Name: createProp ]]
            if not v24 then
                return;
            elseif typeof(v24) == "Instance" then
                local v26 = v24:Clone();
                v26.CanCollide = true;
                v26.Parent = workspace.Map.Ingame;
                v26.Velocity = v25 or Vector3.new();
                v24.Transparency = 1;
                return;
            else
                if typeof(v24) == "table" then
                    local v27 = {};
                    for v28, v29 in pairs(v24) do
                        v27[v28] = v29:Clone();
                        v27[v28]:ClearAllChildren();
                        v27[v28].CanCollide = true;
                        v29.Transparency = 1;
                        if v28 ~= 1 then
                            local l_WeldConstraint_0 = Instance.new("WeldConstraint");
                            l_WeldConstraint_0.Parent = v27[v28];
                            l_WeldConstraint_0.Part1 = v27[v28];
                            l_WeldConstraint_0.Part0 = v27[1];
                        end;
                    end;
                    for _, v32 in pairs(v27) do
                        v32.Parent = workspace.Map.Ingame;
                    end;
                end;
                return;
            end;
        end;
        v18.HealingThreads = {
            task.delay(1.666, function() --[[ Line: 170 ]]
                -- upvalues: v33 (copy), v18 (copy)
                v33(v18.Item.ItemRoot.Parts:FindFirstChild("syringidk0"), v18.Character.PrimaryPart.CFrame.LookVector * -2);
            end), 
            task.delay(2.533, function() --[[ Line: 174 ]]
                -- upvalues: v18 (copy), v33 (copy)
                local l_Children_0 = v18.Item.ItemRoot.Parts:GetChildren();
                table.insert(l_Children_0, v18.Item.ItemRoot);
                for v35 = #l_Children_0, 1, -1 do
                    local v36 = l_Children_0[v35];
                    if v36 and (v36.Name == "syringidk0" or v36.Name == "bandag") then
                        table.remove(l_Children_0, v35);
                    end;
                end;
                v33(l_Children_0, v18.Character.PrimaryPart.CFrame.LookVector * -2);
            end)
        };
        local function v42(v37, v38, v39) --[[ Line: 188 ]] --[[ Name: updateBar ]]
            local v40 = math.clamp(v38, 0, v39) / v39;
            local v41 = v40 == 0 and 0 or 1 / v40;
            v37.Clipping.Size = UDim2.fromScale(v40, 1);
            v37.Clipping.Top.Size = UDim2.fromScale(v41, 1);
        end;
        v42(v18.UI.Bar, 0, v18.Config.HealTime);
        local v43 = 0;
        while v18.UI and v18.UI.Parent do
            if v18.Config.HealTime <= v43 then
                v0.Unequipped(v18);
            else
                v42(v18.UI.Bar, v43, v18.Config.HealTime);
            end;
            v43 = v43 + game["Run Service"].Heartbeat:Wait();
        end;
    end;
end;
v0.Deactivated = function(_) --[[ Line: 218 ]] --[[ Name: Deactivated ]]

end;
return v0;