-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("TweenService");
local l_Assets_0 = l_ReplicatedStorage_0.Assets;
local _ = l_Assets_0.Skins;
local _ = l_Assets_0.Killers;
local l_TerrorRadiusThemes_0 = require(l_ReplicatedStorage_0.Assets.Killers.Slasher.Config).Sounds.TerrorRadiusThemes;
local _ = {
    Head = true, 
    Torso = true, 
    ["Left Arm"] = true, 
    ["Left Leg"] = true, 
    ["Right Arm"] = true, 
    ["Right Leg"] = true
};
local v8 = require(script:FindFirstAncestor("HallucinationClass"));
local v9 = require(l_ReplicatedStorage_0.Modules.Util);
local v10 = require(l_ReplicatedStorage_0.Systems.Character.Game.ChaseThemes);
local v11 = require(l_ReplicatedStorage_0.Modules.SimplePath);
local v12 = require(l_ReplicatedStorage_0.Modules.Sounds);
local v13 = require(l_ReplicatedStorage_0.Modules.Network);
local v14 = {
    ApplyAt = l_RunService_0:IsStudio() and 1 or 3, 
    ForceApply = true
};
v14.__index = v14;
setmetatable(v14, v8);
v14.new = function(...) --[[ Line: 48 ]] --[[ Name: new ]]
    -- upvalues: v8 (copy), v14 (copy)
    return (setmetatable(v8.new(...), v14));
end;
v14.Init = function(v15) --[[ Line: 55 ]] --[[ Name: Init ]]
    -- upvalues: v9 (copy), l_TerrorRadiusThemes_0 (copy), v11 (copy), v8 (copy), v10 (copy), v12 (copy), l_RunService_0 (copy), v13 (copy), l_ReplicatedStorage_0 (copy)
    local l_Killer_0 = v15.Killer;
    local l_Survivor_0 = v15.Survivor;
    if not l_Killer_0 or not l_Killer_0.Config or not l_Killer_0.Rig or not l_Killer_0.Rig.Parent then
        return;
    else
        local l_Rig_0 = l_Killer_0.Rig;
        local v19 = false;
        if l_Killer_0.Config.Sounds.isSensitiveTerrorRadius == true then
            v19 = v9:GetSettingValue("SensitiveMusicMode", game.Players.LocalPlayer) == true;
        end;
        v15.InstanceCache = {};
        v15.Rig = l_Rig_0:Clone();
        v9:AddHitboxes(v15.Rig, "Killers");
        v15.Humanoid = v15.Rig.Humanoid;
        v15.Humanoid.AutoRotate = false;
        v15.Root = v15.Rig.PrimaryPart;
        v15.Config = {
            Sounds = {
                TerrorRadiusThemes = v19 and l_TerrorRadiusThemes_0 or l_Killer_0.Config.Sounds.TerrorRadiusThemes, 
                VoidRushStart = l_Killer_0.Config.Sounds.VoidRushStart, 
                VoidRushCharge = l_Killer_0.Config.Sounds.VoidRushDash1, 
                VoidRushLoop = l_Killer_0.Config.Sounds.VoidRushDashLoop, 
                VoidRushStop = l_Killer_0.Config.Sounds.VoidRushCancel
            }
        };
        v15.Animations = {};
        v15.Path = v11.new(v15.Rig);
        v15.RootAttachment = Instance.new("Attachment", v15.Rig.HumanoidRootPart);
        v15.Orient = script.AlignOrientation:Clone();
        v15.Orient.Parent = v15.Rig.HumanoidRootPart;
        v15.Orient.Attachment0 = v15.RootAttachment;
        v15.WorldAtt = Instance.new("Attachment", workspace.Terrain);
        v15.WorldAtt.Name = "NPCAligner";
        v15.Orient.Attachment1 = v15.WorldAtt;
        v15.PlayerRootPositionBuffer = {};
        v15.BaitTime = 0;
        v15.RushPatience = 0;
        v15.Root.Anchored = true;
        v15.Rig:SetPrimaryPartCFrame(CFrame.new(v8.getClosestSpawnPos(l_Survivor_0.Rig.PrimaryPart.Position, 80)));
        for _, v21 in ipairs(v15.Rig:GetDescendants()) do
            if v21:IsA("Sound") or v21.Name == "StunProtection" then
                v21:Destroy();
            elseif v21:IsA("BasePart") then
                v21.CollisionGroup = "Killers";
            end;
        end;
        v15.Rig.Parent = workspace.Players.Killers;
        v15.Root.Anchored = false;
        v15.InVoidRush = false;
        for _, v23 in ipairs({
            "Idle", 
            "Walk", 
            "Run", 
            "Stab"
        }) do
            v15.Animations[v23] = v9:LoadAnimationFromID(v15.Rig, l_Killer_0.Config.Animations[v23]);
        end;
        v15.Animations.VoidRush = v9:LoadAnimationFromID(v15.Rig, l_Killer_0.Config.Animations.VoidRush.StartCharge);
        v15.Animations.ChargeStart = v9:LoadAnimationFromID(v15.Rig, l_Killer_0.Config.Animations.VoidRush.StartDashInit);
        v15.Animations.ChargeLoop = v9:LoadAnimationFromID(v15.Rig, l_Killer_0.Config.Animations.VoidRush.LoopDashInit);
        v15.Animations.ChargeStop = v9:LoadAnimationFromID(v15.Rig, l_Killer_0.Config.Animations.VoidRush.EndDash);
        v15.Animations.ChargeStart.Priority = Enum.AnimationPriority.Action4;
        v15.Animations.ChargeStop.Priority = Enum.AnimationPriority.Action4;
        v15.Animations.ChargeLoop.Priority = Enum.AnimationPriority.Action3;
        l_Rig_0:SetAttribute("Undetectable", true);
        v10:KillerAdded(v15);
        local l_Attribute_0 = v15.Humanoid:GetAttribute("BaseSpeed");
        local v25 = l_Attribute_0 * (l_Killer_0.Config.SprintSpeed / l_Attribute_0);
        local v26 = (l_Killer_0.Config.StaminaLoss or 10) * 1.45;
        local v27 = l_Killer_0.Config.StaminaGain or 10;
        local v28 = l_Killer_0.Config.MaxStamina or 100;
        local v29 = l_Killer_0.Config.MinStamina or 0;
        local v30 = l_Killer_0.MovementAnimSpeed or l_Killer_0.Config.MovementAnimSpeed;
        local v31 = "Idle";
        local v32 = "Idle";
        local l_v28_0 = v28;
        local v34 = nil;
        local v35 = math.random(1, 4);
        local v36 = {};
        local function _(v37) --[[ Line: 163 ]] --[[ Name: since ]]
            -- upvalues: v36 (copy)
            return v36[v37] and tick() - v36[v37] or 1e999;
        end;
        local function _() --[[ Line: 168 ]] --[[ Name: getPlrPos ]]
            -- upvalues: l_Survivor_0 (copy)
            return l_Survivor_0.Rig.PrimaryPart.Position;
        end;
        local function v40() --[[ Line: 172 ]] --[[ Name: stopDashing ]]
            -- upvalues: v15 (copy), v12 (ref), v36 (copy)
            if not v15.InVoidRush then
                return;
            else
                if v15.VRT then
                    pcall(task.cancel, v15.VRT);
                end;
                v15.VRT = nil;
                if v15.RushSound then
                    v15.RushSound:Destroy();
                end;
                v15.Animations.ChargeStart:Stop();
                v15.Animations.ChargeLoop:Stop();
                v15.Animations.ChargeStop:Play();
                v12:Play(v15.Config.Sounds.VoidRushStop, {
                    Parent = v15.Root, 
                    RollOffMaxDistance = 45
                });
                v15.InVoidRush = false;
                v36.LastVoidRush = tick();
                v36.RushStop = tick();
                return;
            end;
        end;
        v15.NeuronConnection = l_RunService_0.Heartbeat:Connect(function(v41) --[[ Line: 193 ]]
            -- upvalues: v15 (copy), l_Survivor_0 (copy), l_Killer_0 (copy), v36 (copy), l_v28_0 (ref), v35 (ref), v31 (ref), v12 (ref), v34 (ref), v40 (copy), v11 (ref), v13 (ref), l_RunService_0 (ref), v26 (copy), v27 (copy), v29 (copy), v28 (copy), v25 (copy), l_Attribute_0 (copy), v32 (ref), v30 (copy)
            if not v15 or not v15.Running or not v15.Rig or not l_Survivor_0 or not l_Survivor_0.Rig or not l_Survivor_0.Rig.PrimaryPart or v15.OUCH then
                if v15.NeuronConnection then
                    v15.NeuronConnection:Disconnect();
                    v15.NeuronConnection = nil;
                end;
                return;
            elseif not l_Killer_0 or not l_Killer_0.Config or not l_Killer_0.Rig or not l_Killer_0.Rig.Parent or not l_Killer_0.Rig:FindFirstChild("Humanoid") or l_Killer_0.Rig.Humanoid.Health <= 0 then
                if v15.NeuronConnection then
                    v15.NeuronConnection:Disconnect();
                    v15.NeuronConnection = nil;
                end;
                return;
            else
                if (v36.ExpensiveCheck and tick() - v36.ExpensiveCheck or 1e999) > 0.05 then
                    local v42 = v15:LOSCheck();
                    local v43 = v15:OnScreenCheck();
                    v36.LastLOS = v42 and tick() or v36.LastLOS;
                    v36.LastOnScreen = v43 and tick() or v36.LastOnScreen;
                    v36.ExpensiveCheck = tick();
                end;
                if not v15.InVoidRush then
                    local l_v15_0 = v15;
                    l_v15_0.RushPatience = l_v15_0.RushPatience + v41 * math.random(1, 4);
                end;
                local v45 = true;
                if (v36.RushStart and tick() - v36.RushStart or 1e999) >= 1.5 then
                    v45 = false;
                    if (v36.LastSwing and tick() - v36.LastSwing or 1e999) > 1 then
                        v45 = false;
                        if (v36.LastLOS and tick() - v36.LastLOS or 1e999) < 1 then
                            v45 = false;
                            if (l_Survivor_0.Rig.PrimaryPart.Position - v15.Root.Position).Magnitude > 15 then
                                v45 = false;
                                if (v36.LastVoidRush and tick() - v36.LastVoidRush or 1e999) > 8 then
                                    v45 = v15.RushPatience > 4;
                                end;
                            end;
                        end;
                    end;
                end;
                local v46 = true;
                if (v36.LastBait and tick() - v36.LastBait or 1e999) >= v15.BaitTime then
                    v46 = false;
                    if v15.Survivor.Config.Class == "Sentinel" then
                        v46 = false;
                        if math.random(1, 20) == 2 then
                            v46 = false;
                            if (v36.LastBait and tick() - v36.LastBait or 1e999) > 10 then
                                v46 = (v15.Root.Position - l_Survivor_0.Rig.PrimaryPart.Position).Magnitude < 9.5;
                            end;
                        end;
                    end;
                end;
                local v47 = (l_Survivor_0.Rig.PrimaryPart.Position - v15.Root.Position).Magnitude > 3.5;
                local v48 = false;
                if (v36.LastLOS and tick() - v36.LastLOS or 1e999) >= 0.65 then
                    v48 = (l_Survivor_0.Rig.PrimaryPart.Position - v15.Root.Position).Magnitude > 100;
                end;
                if (v36.RushStop and tick() - v36.RushStop or 1e999) > 2.2 and not v45 and not v15.InVoidRush and l_v28_0 > 0 and ((v36.LastHit and tick() - v36.LastHit or 1e999) > 0.8 and (v36.StaminaDepleted and tick() - v36.StaminaDepleted or 1e999) > v35 and v47 or v48 or v46) then
                    v31 = "Run";
                    if v46 and (v36.LastBait and tick() - v36.LastBait or 1e999) >= v15.BaitTime then
                        v36.LastBait = tick();
                        v15.BaitTime = math.random(4, 6) / 20;
                    end;
                    v36.LastRan = tick();
                else
                    if v45 and (v36.RushStart and tick() - v36.RushStart or 1e999) >= 2 and not v15.InVoidRush then
                        v15.RushPatience = 0;
                        v15.Animations.VoidRush.Priority = Enum.AnimationPriority.Action4;
                        v15.Animations.VoidRush:Play();
                        if math.random(1, 3) ~= 1 then
                            task.delay(l_Killer_0.Config.VoidRushChargeLength, function() --[[ Line: 257 ]]
                                -- upvalues: v15 (ref), v12 (ref), v34 (ref), v36 (ref), l_Killer_0 (ref), v40 (ref)
                                v15.RushSound = v12:Play(v15.Config.Sounds.VoidRushLoop, {
                                    Parent = v15.Root, 
                                    RollOffMaxDistance = 45
                                });
                                v12:Play(v15.Config.Sounds.VoidRushCharge, {
                                    Parent = v15.Root, 
                                    RollOffMaxDistance = 45
                                });
                                v15.Animations.ChargeStart:Play();
                                v15.Animations.ChargeLoop:Play();
                                v15.InVoidRush = true;
                                v15.VoidRushDir = ((v34 - v15.Root.Position) * Vector3.new(1, 0, 1, 0)).Unit;
                                v36.RushDashStart = tick();
                                v15.VRT = task.delay(l_Killer_0.Config.VoidRushDashLength, v40);
                            end);
                        else
                            task.delay(math.random(4, 8) / 10, function() --[[ Line: 272 ]]
                                -- upvalues: v15 (ref), v12 (ref)
                                v15.Animations.VoidRush:Play();
                                v12:Play(v15.Config.Sounds.VoidRushCancel, {
                                    Parent = v15.Root, 
                                    RollOffMaxDistance = 45
                                });
                            end);
                        end;
                        v12:Play(v15.Config.Sounds.VoidRushStart, {
                            Parent = v15.Root, 
                            RollOffMaxDistance = 100
                        });
                        v36.LastVoidRush = tick();
                        v36.RushStart = tick();
                    end;
                    v35 = math.random(2, 5);
                    v31 = "Walk";
                end;
                local _ = 1 - math.clamp((v15.Root.Position - l_Survivor_0.Rig.PrimaryPart.Position).Magnitude / 7, 0.1, 0.4);
                if (v36.PositionSet and tick() - v36.PositionSet or 1e999) > 0.2 then
                    if (v36.LastLOS and tick() - v36.LastLOS or 1e999) < 1.5 then
                        v34 = l_Survivor_0.Rig.PrimaryPart.Position + l_Survivor_0.Rig.PrimaryPart.AssemblyLinearVelocity * ((math.sin(tick() * 2.5) * 10 + 15) / 50 + 0.28);
                    else
                        v34 = l_Survivor_0.Rig.PrimaryPart.Position;
                    end;
                    if (v36.BufferAdded and tick() - v36.BufferAdded or 1e999) > 0.01 then
                        v36.BufferAdded = tick();
                        table.insert(v15.PlayerRootPositionBuffer, v34);
                        if #v15.PlayerRootPositionBuffer > 4 then
                            table.remove(v15.PlayerRootPositionBuffer, 1);
                        end;
                    end;
                    v34 = v15.PlayerRootPositionBuffer[1] or v34;
                    v36.PositionSet = tick();
                end;
                if v31 == "Idle" or v15.OUCH then
                    v15.Path:Stop();
                    v15.Humanoid:MoveTo(v15.Root.Position);
                else
                    local v50 = l_Survivor_0.Rig.PrimaryPart.Position.Y - v15.Root.Position.Y > 4;
                    if not v15.InVoidRush and (v36.LastBait and tick() - v36.LastBait or 1e999) < v15.BaitTime then
                        v15.Humanoid:MoveTo(v15.Root.Position + (v15.Root.Position - v15.Survivor.Rig.PrimaryPart.Position).Unit * 100);
                    elseif v15.InVoidRush or (v36.LastLOS and tick() - v36.LastLOS or 1e999) < 0.45 and not v50 then
                        v15.Path:Stop();
                        local l_Unit_0 = v15.Humanoid.MoveDirection.Unit;
                        if l_Unit_0 ~= l_Unit_0 then
                            l_Unit_0 = Vector3.new(0, 0, 0, 0);
                        end;
                        local v52 = v34 - v15.Root.Position;
                        local l_Unit_1 = Vector3.new(v52.X, 0, v52.Z).Unit;
                        local v54 = l_Unit_1 - l_Unit_0;
                        local l_Magnitude_0 = v54.Magnitude;
                        if l_Magnitude_0 > 0 then
                            local v56 = v41 * (v15.InVoidRush and l_Killer_0.Config.VoidRushTurnSpeed or math.clamp((v15.Root.Position - l_Survivor_0.Rig.PrimaryPart.Position).Magnitude * 6.6, 15, 35));
                            l_Unit_0 = (if l_Magnitude_0 <= v56 then l_Unit_1 else l_Unit_0 + v54.Unit * v56).Unit;
                        end;
                        v15.Humanoid:Move(l_Unit_0);
                        v15.Baited = false;
                    elseif (v36.LastPathfind and tick() - v36.LastPathfind or 1e999) > ((not (v31 == "Run") or v48) and 0.2 or 0.04) then
                        if not v15.Path:Run(v34) and v15.Path._lastError ~= v11.ErrorType.LimitReached then
                            v15.Humanoid:MoveTo(v34);
                        end;
                        v36.LastPathfind = tick();
                        v15.Baited = false;
                    end;
                end;
                if (v15.Root.Position - v34).Magnitude < 9 and (v36.LastSwing and tick() - v36.LastSwing or 1e999) > l_Killer_0.Config.StabCooldown and (v36.RushStop and tick() - v36.RushStop or 1e999) > 2.5 and (v36.RushStart and tick() - v36.RushStart or 1e999) > 0.8 and not v46 and not v45 and not v15.InVoidRush then
                    v15.Animations.Stab.Priority = Enum.AnimationPriority.Action4;
                    v15.Animations.Stab:Play();
                    v36.LastSwing = tick();
                    v12:Play(l_Killer_0.Config.Sounds.Swing, {
                        Parent = v15.Root
                    });
                    task.delay(l_Killer_0.Config.StabWindup, function() --[[ Line: 375 ]]
                        -- upvalues: l_Killer_0 (ref), v15 (ref), l_Survivor_0 (ref), v12 (ref), v13 (ref), l_RunService_0 (ref)
                        local v57 = tick();
                        local v58 = 0.035;
                        local v59 = nil;
                        while true do
                            if tick() - v57 < l_Killer_0.Config.StabLinger and v15 and v15.Root and not v15.OUCH then
                                if v58 > 0.03 then
                                    v58 = v58 - 0.03;
                                    local l_Part_0 = Instance.new("Part");
                                    l_Part_0.Name = "SIKEHitbox";
                                    l_Part_0.Transparency = 1;
                                    l_Part_0.CanCollide = false;
                                    l_Part_0.CanTouch = false;
                                    l_Part_0.CanQuery = false;
                                    l_Part_0.Anchored = true;
                                    l_Part_0.Size = Vector3.new(4.5, 6, 7.5, 0);
                                    l_Part_0.CFrame = v15.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -1.25) + -v15.Rig.PrimaryPart.Velocity / 6.8;
                                    l_Part_0.Parent = workspace:FindFirstChild("Hitboxes");
                                    l_Part_0.Color = Color3.new(1, 0.25, 0.25);
                                    v59 = l_Part_0;
                                    game.Debris:AddItem(l_Part_0, 2);
                                end;
                                local v61 = RaycastParams.new();
                                v61.FilterDescendantsInstances = {
                                    l_Survivor_0.Rig
                                };
                                v61.FilterType = Enum.RaycastFilterType.Include;
                                local v62 = workspace:Spherecast(v15.Root.Position, 1.4, v15.Root.CFrame.LookVector * 6, v61);
                                if v62 and v62.Instance then
                                    local l_Humanoid_0 = l_Survivor_0.Rig.Humanoid;
                                    l_Humanoid_0:SetAttribute("FakeDamage", (l_Humanoid_0:GetAttribute("FakeDamage") or 0) + l_Killer_0.Config.HallucinationCloneFakeDamage);
                                    v12:Play(l_Killer_0.Config.Sounds.Hit, {
                                        Parent = l_Survivor_0.Rig.PrimaryPart
                                    });
                                    v13:FireServerConnection(("%*CloneEvent"):format(l_Killer_0.Player.Name), "REMOTE_EVENT", "TOOKDAMAGE");
                                    v59.Color = Color3.new(0.5, 1, 0.5);
                                    return;
                                else
                                    v58 = v58 + l_RunService_0.Heartbeat:Wait();
                                end;
                            else
                                return;
                            end;
                        end;
                    end);
                end;
                if (l_Survivor_0.Rig.PrimaryPart.Position - v15.Root.Position).Magnitude < 50 and (v36.LastLOS and tick() - v36.LastLOS or 1e999) < 4 then
                    v15.Orient.MaxAngularVelocity = (7.7 - math.min(0.7, v15.Survivor.Rig.PrimaryPart.CFrame.LookVector:Dot(v15.Root.CFrame.LookVector) * 3.5) * 4.6) / 2;
                    v15.WorldAtt.CFrame = CFrame.new(v15.Root.Position * Vector3.new(1, 0, 1, 0), v34 * Vector3.new(1, 0, 1, 0));
                    v36.LookPlayer = tick();
                else
                    if (v36.TurnRateChanged and tick() - v36.TurnRateChanged or 1e999) > 1 then
                        v36.TurnRateChanged = tick();
                        v15.Orient.MaxAngularVelocity = math.random(7, 10);
                    end;
                    v15.WorldAtt.CFrame = CFrame.new(v15.Root.Position * Vector3.new(1, 0, 1, 0), (v15.Root.Position + v15.Root.Velocity + Vector3.new(0.20000000298023224, 0, 0, 0)) * Vector3.new(1, 0, 1, 0));
                end;
                v15.Orient.Enabled = not v15.InVoidRush;
                v15.Humanoid.AutoRotate = v15.InVoidRush;
                if not v15.InVoidRush then
                    if v31 == "Run" and not v48 then
                        l_v28_0 = l_v28_0 - v26 * v41;
                        v36.Ran = tick();
                    elseif (v36.Ran and tick() - v36.Ran or 1e999) > 1 then
                        l_v28_0 = l_v28_0 + v27 * v41;
                    end;
                    l_v28_0 = math.clamp(l_v28_0, v29, v28);
                    if l_v28_0 == v29 then
                        v36.StaminaDepleted = tick();
                    end;
                end;
                if v15.InVoidRush then
                    v15.Humanoid.WalkSpeed = l_Killer_0.Config.VoidRushDashSpeed;
                    if (v36.RushHitbox and tick() - v36.RushHitbox or 1e999) > 0.03 then
                        local l_Part_1 = Instance.new("Part");
                        l_Part_1.Name = "SIKEHitbox";
                        l_Part_1.Transparency = 1;
                        l_Part_1.CanCollide = false;
                        l_Part_1.CanTouch = false;
                        l_Part_1.CanQuery = false;
                        l_Part_1.Anchored = true;
                        l_Part_1.Size = Vector3.new(6, 4, 4, 0);
                        l_Part_1.CFrame = v15.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -math.clamp((v36.RushDashStart and tick() - v36.RushDashStart or 1e999) * 2 - 0.2, 0, 2.8 - math.sin(tick() * math.random(3, 5))));
                        l_Part_1.Parent = workspace:FindFirstChild("Hitboxes");
                        l_Part_1.Color = Color3.new(1, 0.25, 0.25);
                        game.Debris:AddItem(l_Part_1, 2);
                        v36.RushHitbox = tick();
                    end;
                    if (v36.RushDashStart and tick() - v36.RushDashStart or 1e999) > 0.5 and v15.Root.Velocity.Magnitude < 12 or (l_Survivor_0.Rig.PrimaryPart.Position - v15.Root.Position).Magnitude < 6 or v15.VoidRushDir and v15.VoidRushDir:Dot(((l_Survivor_0.Rig.PrimaryPart.Position - v15.Root.Position) * Vector3.new(1, 0, 1, 0)).Unit) < -0.2 then
                        v40();
                    end;
                else
                    local v65 = (not ((v36.RushStop and tick() - v36.RushStop or 1e999) >= 2.2) or (v36.RushStart and tick() - v36.RushStart or 1e999) < 2) and 0.65 or 1;
                    local v66 = v15.Root.Velocity.Magnitude <= 0 and 0.1 or (v15.Root.CFrame.LookVector:Dot(v15.Root.Velocity.Unit) + 6) / 7;
                    local v67 = v25 * v66 * v65;
                    local v68 = l_Attribute_0 * v65;
                    v15.Humanoid.WalkSpeed = math.clamp(v15.Humanoid.WalkSpeed + v41 / 0.75 * (v67 - v68) * (v31 == "Run" and 1 or -1), v68, v67);
                end;
                if v32 ~= v31 then
                    for _, v70 in ipairs({
                        "Walk", 
                        "Run", 
                        "Idle"
                    }) do
                        v15.Animations[v70]:Stop(0.125);
                    end;
                    v15.Animations[v31]:Play(0.125);
                end;
                v15.Animations[v31]:AdjustSpeed(v30);
                v32 = v31;
                return;
            end;
        end);
        v15.HitboxConnection = workspace.Hitboxes.ChildAdded:Connect(function(v71) --[[ Line: 510 ]]
            -- upvalues: v15 (copy), l_ReplicatedStorage_0 (ref), l_Survivor_0 (copy), v12 (ref), l_Killer_0 (copy), v10 (ref), v13 (ref), l_RunService_0 (ref)
            if not v15.OUCH and v71:IsA("BasePart") and v71.Name == v15.Player.Name .. "Hitbox" and v15.Rig and v15.Rig:FindFirstChild("QueryHitbox") then
                local v72 = OverlapParams.new();
                v72.FilterType = Enum.RaycastFilterType.Include;
                v72.FilterDescendantsInstances = {
                    v15.Rig.QueryHitbox
                };
                local l_workspace_PartsInPart_0 = workspace:GetPartsInPart(v71, v72);
                if l_workspace_PartsInPart_0 and next(l_workspace_PartsInPart_0) then
                    local v74 = require(l_ReplicatedStorage_0.Modules.Ragdolls);
                    local v75 = (v15.Root.Position - l_Survivor_0.Rig.PrimaryPart.Position).Unit * 50;
                    local v76 = Instance.new("BodyVelocity", v15.Root);
                    v76.P = 999999;
                    v76.MaxForce = Vector3.new(9999999, 9999999, 9999999, 0);
                    v76.Velocity = v75 == v75 and v75 or Vector3.new(0, 50, 0, 0);
                    game.Debris:AddItem(v76, 0.1);
                    for _, v78 in pairs(v15.Animations) do
                        v78:Stop();
                    end;
                    v74.EnableRagdoll(v15.Rig);
                    v15.OUCH = true;
                    v15.HitboxConnection:Disconnect();
                    v15.Rig:SetAttribute("Undetectable", true);
                    local l_pairs_0 = pairs;
                    local v80 = l_Survivor_0.Config.Sounds or {};
                    for v81, v82 in l_pairs_0(v80) do
                        if v81:lower():find("hit") then
                            v12:Play(v82, {
                                Parent = l_Survivor_0.Rig.PrimaryPart
                            });
                            break;
                        end;
                    end;
                    v12:Play(l_Killer_0.Config.Sounds.HallucinationCloneDeath, {
                        Parent = v15.Root, 
                        Volume = 0.07
                    });
                    v10:KillerRemoved(v15);
                    for _, v84 in ipairs(v15.Rig:GetDescendants()) do
                        if v84:IsA("ParticleEmitter") or v84:IsA("Beam") or v84:IsA("Trail") then
                            v84.Enabled = false;
                        end;
                    end;
                    l_pairs_0 = v15.Rig;
                    v15.Rig = nil;
                    v13:FireServerConnection(("%*CloneEvent"):format(l_Killer_0.Player.Name), "REMOTE_EVENT", "KILLED");
                    task.delay(2.5, function() --[[ Line: 561 ]]
                        -- upvalues: l_pairs_0 (copy), l_RunService_0 (ref)
                        local v85 = tick();
                        local v86 = {};
                        for _, v88 in ipairs(l_pairs_0:GetDescendants()) do
                            if v88:IsA("BasePart") then
                                v86[v88] = v88.Transparency;
                            end;
                        end;
                        while tick() - v85 <= 1 do
                            for v89, v90 in pairs(v86) do
                                v89.Transparency = v90 + (tick() - v85) * (1 - v90);
                            end;
                            l_RunService_0.Heartbeat:Wait();
                        end;
                        l_pairs_0:Destroy();
                    end);
                end;
            end;
        end);
        return;
    end;
end;
v14.LOSCheck = function(v91) --[[ Line: 585 ]] --[[ Name: LOSCheck ]]
    if not v91.Survivor or not v91.Root or not v91.Survivor.Rig or not v91.Survivor.Rig.PrimaryPart then
        return false;
    else
        local v92 = nil;
        local v93 = nil;
        local v94 = 0;
        local v95 = RaycastParams.new();
        v95.CollisionGroup = "Killers";
        v95.FilterType = Enum.RaycastFilterType.Exclude;
        v95.FilterDescendantsInstances = {
            workspace.Players
        };
        v95.RespectCanCollide = true;
        repeat
            local v96 = v91.Survivor.Rig.PrimaryPart.Position - v91.Root.Position;
            v92 = workspace:Spherecast(v91.Root.Position, 1, v96, v95);
            if v92 then
                local _ = v92.Instance;
                v93 = false;
            else
                v93 = false;
            end;
            v94 = v94 + 1;
        until not v92 or v92 and not v93 or v94 > 25;
        if v94 > 25 then
            warn("we raycasted tooooo much");
            return false;
        elseif not v92 then
            return true;
        else
            return false;
        end;
    end;
end;
v14.OnScreenCheck = function(v98) --[[ Line: 631 ]] --[[ Name: OnScreenCheck ]]
    -- upvalues: v9 (copy)
    local v99 = true;
    if (v98.Root.Position - v98.Survivor.Rig.PrimaryPart.Position).Magnitude >= 10 then
        v99 = v9:IsOnScreen(v98.Rig);
    end;
    return v99;
end;
v14.Destroy = function(v100) --[[ Line: 635 ]] --[[ Name: Destroy ]]
    -- upvalues: v10 (copy)
    local l_ipairs_0 = ipairs;
    local v102 = v100.InstanceCache or {};
    for _, v104 in l_ipairs_0(v102) do
        v104.LocalTransparencyModifier = v104.LocalTransparencyModifier - 0.8;
    end;
    if v100.Killer and v100.Killer.Rig then
        v100.Killer.Rig:SetAttribute("Undetectable", nil);
    end;
    if v100.Rig then
        v100.Rig:Destroy();
    end;
    if v100.WorldAtt then
        v100.WorldAtt:Destroy();
    end;
    if v100.HitboxConnection then
        v100.HitboxConnection:Disconnect();
    end;
    if v100.NeuronConnection then
        v100.NeuronConnection:Disconnect();
    end;
    if v100.Path then
        v100.Path:Destroy();
    end;
    v10:KillerRemoved(v100);
    v100:Clean();
end;
return v14;