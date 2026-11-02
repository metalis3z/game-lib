-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
local _ = require(game.ReplicatedStorage.Modules.Network);
v0.Abilities = {
    Slash = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "MainAbility", 
        Callback = function(v6) --[[ Line: 15 ]] --[[ Name: Callback ]]
            -- upvalues: v1 (copy), v3 (copy), v2 (copy)
            if game["Run Service"]:IsServer() then
                v6.AbilitiesDisabled = true;
                task.delay(0.45, function() --[[ Line: 19 ]]
                    -- upvalues: v1 (ref), v6 (copy)
                    v1:Play(v6.Config.Sounds.Swing, {
                        Parent = v6.Rig.PrimaryPart, 
                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                        Volume = 0.25
                    });
                    v1:Play(v6.Config.Voicelines.Swing, {
                        Parent = v6.Rig.PrimaryPart, 
                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                        Volume = 0.25
                    });
                end);
                task.delay(0.5, function() --[[ Line: 25 ]]
                    -- upvalues: v3 (ref), v6 (copy), v2 (ref), v1 (ref)
                    local _ = v3:CreateHitbox(v6.Player, {
                        Size = Vector3.new(7, 6, 8, 0), 
                        CFrameOffset = CFrame.new(0, 0, -2.25), 
                        Damage = 40, 
                        Time = 0.2, 
                        Knockback = 2, 
                        HitMultiple = true, 
                        Connections = {
                            Hit = function(v7, v8) --[[ Line: 36 ]] --[[ Name: Hit ]]
                                -- upvalues: v2 (ref), v1 (ref), v6 (ref)
                                v2:CreateSpeedMultiplier(v7, 1.5, "HitSpeedBonus", 1.25);
                                if v8 then
                                    v1:Play(v6.Config.Sounds.Hit, {
                                        Parent = v6.Rig.PrimaryPart, 
                                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                        Volume = 0.25
                                    });
                                end;
                            end
                        }
                    });
                end);
                task.delay(0.75, function() --[[ Line: 47 ]]
                    -- upvalues: v6 (copy)
                    v6.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v6.Animations.Slash:Play(0.175);
                end;
                return;
            end;
        end
    }, 
    WildHunt = {
        LayoutOrder = 5, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "AltAbility4", 
        Callback = function(v10) --[[ Line: 63 ]] --[[ Name: Callback ]]
            -- upvalues: v2 (copy), v1 (copy)
            if game["Run Service"]:IsServer() then
                task.delay(0.25, function() --[[ Line: 68 ]]
                    -- upvalues: v10 (copy), v2 (ref), v1 (ref)
                    local l_PrimaryPart_0 = v10.Rig.PrimaryPart;
                    local l_pairs_0 = pairs;
                    local v13 = v10.KilledLocations or {};
                    for _, v15 in l_pairs_0(v13) do
                        task.spawn(function() --[[ Line: 71 ]]
                            -- upvalues: v10 (ref), v2 (ref), v15 (copy), l_PrimaryPart_0 (copy), v1 (ref)
                            local v16 = v10.Config.Zombies[math.random(1, 2)]:Clone();
                            v16:SetAttribute("Team", "Killers");
                            v16.Name = "RotZombie";
                            v16.PrimaryPart.Anchored = true;
                            v16.Humanoid.Health = v10.Config.ZombieHealth;
                            v16.Humanoid.EvaluateStateMachine = false;
                            v16.Parent = workspace.Map.Ingame;
                            for _, v18 in pairs(v16:GetDescendants()) do
                                if v18:IsA("BasePart") then
                                    v18.Massless = true;
                                end;
                            end;
                            local v19 = {};
                            for v20, v21 in pairs(v10.Config.ZombieAnimations) do
                                v19[v20] = v2:LoadAnimationFromID(v16, v21);
                            end;
                            v19.Summon:Play(0);
                            v19.Idle:Play(0);
                            v16:SetPrimaryPartCFrame(CFrame.lookAt(v15, (Vector3.new(l_PrimaryPart_0.Position.X, v15.Y, l_PrimaryPart_0.Position.Z))));
                            task.wait(1.25);
                            local v22 = "";
                            v16.Humanoid.Running:Connect(function(v23) --[[ Line: 106 ]]
                                -- upvalues: v16 (copy), v10 (ref), v22 (ref), v19 (copy)
                                if v23 > 0.01 then
                                    if v16.Humanoid.WalkSpeed == v10.Config.ZombieWalkSpeed and v22 ~= "Walk" then
                                        v19.Walk:Play();
                                        v19.Run:Stop();
                                        return;
                                    elseif v16.Humanoid.WalkSpeed == v10.Config.ZombieSprintSpeed and v22 ~= "Run" then
                                        v19.Walk:Stop();
                                        v19.Run:Play();
                                        return;
                                    end;
                                else
                                    v22 = "";
                                    v19.Walk:Stop();
                                    v19.Run:Stop();
                                end;
                            end);
                            v16.PrimaryPart.Anchored = false;
                            v16.Humanoid.EvaluateStateMachine = true;
                            task.spawn(function() --[[ Line: 129 ]]
                                -- upvalues: v16 (copy), v10 (ref), v19 (copy), v1 (ref), v2 (ref)
                                local v24 = 0;
                                local v25 = math.random(6, 12);
                                local v26 = nil;
                                local v27 = require(game.ReplicatedStorage.Modules.SimplePath).new(v16);
                                while v16.Parent and v16.PrimaryPart and v16.Humanoid.Health > 0 do
                                    if v26 and v26.PrimaryPart and v26.Humanoid.Health > 0 and not v26:GetAttribute("Undetectable") then
                                        local l_Magnitude_0 = (v26.PrimaryPart.Position - v16.PrimaryPart.Position).Magnitude;
                                        if l_Magnitude_0 <= v10.Config.ZombieAttackRange then
                                            v19.Attack:Play();
                                            v1:Play(v10.Config.Sounds.Swing, {
                                                Parent = v16.PrimaryPart, 
                                                PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                                Volume = 0.25
                                            });
                                            task.wait(0.21);
                                            v2:ApplyDamage(v26, v10.Config.ZombieAttackDamage);
                                            task.wait(v10.Config.ZombieAttackCooldown);
                                            continue;
                                        elseif v10.Config.ZombieLoseFocusRange <= l_Magnitude_0 then
                                            v26 = nil;
                                            v27:Stop();
                                        else
                                            v16.Humanoid.WalkSpeed = v10.Config.ZombieSprintSpeed;
                                            v27:Run(v26.PrimaryPart.Position);
                                        end;
                                    else
                                        v26 = nil;
                                        v16.Humanoid.WalkSpeed = v10.Config.ZombieWalkSpeed;
                                    end;
                                    local l_v2_ClosestPlayerFromPosition_0 = v2:GetClosestPlayerFromPosition(v16.PrimaryPart.Position, {
                                        PlayerSelection = "Survivors", 
                                        MaxDistance = v10.Config.ZombieTargetRange
                                    });
                                    if l_v2_ClosestPlayerFromPosition_0 then
                                        v26 = l_v2_ClosestPlayerFromPosition_0;
                                    end;
                                    if v25 <= v24 then
                                        v24 = 0;
                                        v25 = math.random(6, 12);
                                        v16.Humanoid:MoveTo(v16.PrimaryPart.Position + Vector3.new(math.random(-80, 80), 0, math.random(-80, 80)));
                                    end;
                                    v16.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true);
                                    v16.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false);
                                    v16.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
                                    v24 = v24 + game["Run Service"].Heartbeat:Wait();
                                end;
                                if v27 then
                                    v27:Destroy();
                                end;
                            end);
                        end);
                    end;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v2:CreateSpeedMultiplier(v10.Player, 0.75, "WildHunt", 1, true);
                end;
                return;
            end;
        end
    }
};
v0.Created = function(_, v31) --[[ Line: 210 ]] --[[ Name: Created ]]
    if game["Run Service"]:IsServer() then
        v31.KilledLocations = {};
        local function v35(v32) --[[ Line: 216 ]] --[[ Name: setDeathConnection ]]
            -- upvalues: v31 (copy)
            local l_Humanoid_0 = v32:FindFirstChild("Humanoid");
            local l_PrimaryPart_1 = v32.PrimaryPart;
            if l_Humanoid_0 and l_PrimaryPart_1 then
                l_Humanoid_0.Died:Connect(function() --[[ Line: 220 ]]
                    -- upvalues: v31 (ref), l_PrimaryPart_1 (copy)
                    v31:IncrementCharges("WildHunt", 1, 1);
                    table.insert(v31.KilledLocations, l_PrimaryPart_1.Position);
                end);
            end;
        end;
        for _, v37 in pairs(workspace.Players.Survivors:GetChildren()) do
            local l_Humanoid_1 = v37:FindFirstChild("Humanoid");
            local l_PrimaryPart_2 = v37.PrimaryPart;
            if l_Humanoid_1 and l_PrimaryPart_2 then
                l_Humanoid_1.Died:Connect(function() --[[ Line: 220 ]]
                    -- upvalues: v31 (copy), l_PrimaryPart_2 (copy)
                    v31:IncrementCharges("WildHunt", 1, 1);
                    table.insert(v31.KilledLocations, l_PrimaryPart_2.Position);
                end);
            end;
        end;
        local v40 = nil;
        v40 = workspace.Players.Survivors.ChildAdded:Connect(v35);
        do
            local l_v40_0 = v40;
            v31.Rig.AncestryChanged:Connect(function(_, v43) --[[ Line: 234 ]]
                -- upvalues: l_v40_0 (ref)
                if not v43 then
                    l_v40_0:Disconnect();
                    l_v40_0 = nil;
                end;
            end);
        end;
    end;
end;
return v0;