-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: FakeNoli, time of decompilation: Fri Nov 28 21:06:23 2025 ]]
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
        for _, v21 in v15.Rig:GetChildren() do
            if v21:IsA("BasePart") then
                v21.Massless = true;
            end;
        end;
        v15.Humanoid = v15.Rig.Humanoid;
        v15.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false);
        v15.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
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
        for _, v23 in ipairs(v15.Rig:GetDescendants()) do
            if v23:IsA("Sound") or v23.Name == "StunProtection" then
                v23:Destroy();
            elseif v23:IsA("BasePart") then
                v23.CollisionGroup = "Killers";
            end;
        end;
        v15.Rig.Parent = workspace.Players.Killers;
        v15.Root.Anchored = false;
        v15.InVoidRush = false;
        for _, v25 in ipairs({
            "Idle", 
            "Walk", 
            "Run", 
            "Stab"
        }) do
            v15.Animations[v25] = v9:LoadAnimationFromID(v15.Rig, l_Killer_0.Config.Animations[v25]);
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
        local v27 = l_Attribute_0 * (l_Killer_0.Config.SprintSpeed / l_Attribute_0);
        local v28 = (l_Killer_0.Config.StaminaLoss or 10) * 1.45;
        local v29 = l_Killer_0.Config.StaminaGain or 10;
        local v30 = l_Killer_0.Config.MaxStamina or 100;
        local v31 = l_Killer_0.Config.MinStamina or 0;
        local v32 = l_Killer_0.MovementAnimSpeed or l_Killer_0.Config.MovementAnimSpeed;
        local v33 = "Idle";
        local v34 = "Idle";
        local l_v30_0 = v30;
        local v36 = nil;
        local v37 = math.random(1, 4);
        local v38 = {};
        local function _(v39) --[[ Line: 169 ]] --[[ Name: since ]]
            -- upvalues: v38 (copy)
            return v38[v39] and tick() - v38[v39] or 1e999;
        end;
        local function _() --[[ Line: 174 ]] --[[ Name: getPlrPos ]]
            -- upvalues: l_Survivor_0 (copy)
            return l_Survivor_0.Rig.PrimaryPart.Position;
        end;
        local function v42() --[[ Line: 178 ]] --[[ Name: stopDashing ]]
            -- upvalues: v15 (copy), v12 (ref), v38 (copy)
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
                v38.LastVoidRush = tick();
                v38.RushStop = tick();
                return;
            end;
        end;
        v15.NeuronConnection = l_RunService_0.Heartbeat:Connect(function(v43) --[[ Line: 199 ]]
            -- upvalues: v15 (copy), l_Survivor_0 (copy), l_Killer_0 (copy), v38 (copy), l_v30_0 (ref), v37 (ref), v33 (ref), v12 (ref), v36 (ref), v42 (copy), v11 (ref), v13 (ref), l_RunService_0 (ref), v28 (copy), v29 (copy), v31 (copy), v30 (copy), v27 (copy), l_Attribute_0 (copy), v34 (ref), v32 (copy)
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
                if (v38.ExpensiveCheck and tick() - v38.ExpensiveCheck or 1e999) > 0.05 then
                    local v44 = v15:LOSCheck();
                    local v45 = v15:OnScreenCheck();
                    v38.LastLOS = v44 and tick() or v38.LastLOS;
                    v38.LastOnScreen = v45 and tick() or v38.LastOnScreen;
                    v38.ExpensiveCheck = tick();
                end;
                if not v15.InVoidRush then
                    local l_v15_0 = v15;
                    l_v15_0.RushPatience = l_v15_0.RushPatience + v43 * math.random(1, 4);
                end;
                local v47 = true;
                if (v38.RushStart and tick() - v38.RushStart or 1e999) >= 1.5 then
                    v47 = false;
                    if (v38.LastSwing and tick() - v38.LastSwing or 1e999) > 1 then
                        v47 = false;
                        if (v38.LastLOS and tick() - v38.LastLOS or 1e999) < 1 then
                            v47 = false;
                            if (l_Survivor_0.Rig.PrimaryPart.Position - v15.Root.Position).Magnitude > 15 then
                                v47 = false;
                                if (v38.LastVoidRush and tick() - v38.LastVoidRush or 1e999) > 8 then
                                    v47 = v15.RushPatience > 4;
                                end;
                            end;
                        end;
                    end;
                end;
                local v48 = true;
                if (v38.LastBait and tick() - v38.LastBait or 1e999) >= v15.BaitTime then
                    v48 = false;
                    if v15.Survivor.Config.Class == "Sentinel" then
                        v48 = false;
                        if math.random(1, 20) == 2 then
                            v48 = false;
                            if (v38.LastBait and tick() - v38.LastBait or 1e999) > 10 then
                                v48 = (v15.Root.Position - l_Survivor_0.Rig.PrimaryPart.Position).Magnitude < 9.5;
                            end;
                        end;
                    end;
                end;
                local v49 = (l_Survivor_0.Rig.PrimaryPart.Position - v15.Root.Position).Magnitude > 3.5;
                local v50 = false;
                if (v38.LastLOS and tick() - v38.LastLOS or 1e999) >= 0.65 then
                    v50 = (l_Survivor_0.Rig.PrimaryPart.Position - v15.Root.Position).Magnitude > 100;
                end;
                if (v38.RushStop and tick() - v38.RushStop or 1e999) > 2.2 and not v47 and not v15.InVoidRush and l_v30_0 > 0 and ((v38.LastHit and tick() - v38.LastHit or 1e999) > 0.8 and (v38.StaminaDepleted and tick() - v38.StaminaDepleted or 1e999) > v37 and v49 or v50 or v48) then
                    v33 = "Run";
                    if v48 and (v38.LastBait and tick() - v38.LastBait or 1e999) >= v15.BaitTime then
                        v38.LastBait = tick();
                        v15.BaitTime = math.random(4, 6) / 20;
                    end;
                    v38.LastRan = tick();
                else
                    if v47 and (v38.RushStart and tick() - v38.RushStart or 1e999) >= 2 and not v15.InVoidRush then
                        v15.RushPatience = 0;
                        v15.Animations.VoidRush.Priority = Enum.AnimationPriority.Action4;
                        v15.Animations.VoidRush:Play();
                        if math.random(1, 3) ~= 1 then
                            task.delay(l_Killer_0.Config.VoidRushChargeLength, function() --[[ Line: 263 ]]
                                -- upvalues: v15 (ref), v12 (ref), v36 (ref), v38 (ref), l_Killer_0 (ref), v42 (ref)
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
                                v15.VoidRushDir = ((v36 - v15.Root.Position) * Vector3.new(1, 0, 1, 0)).Unit;
                                v38.RushDashStart = tick();
                                v15.VRT = task.delay(l_Killer_0.Config.VoidRushDashLength, v42);
                            end);
                        else
                            task.delay(math.random(4, 8) / 10, function() --[[ Line: 278 ]]
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
                        v38.LastVoidRush = tick();
                        v38.RushStart = tick();
                    end;
                    v37 = math.random(2, 5);
                    v33 = "Walk";
                end;
                local _ = 1 - math.clamp((v15.Root.Position - l_Survivor_0.Rig.PrimaryPart.Position).Magnitude / 7, 0.1, 0.4);
                if (v38.PositionSet and tick() - v38.PositionSet or 1e999) > 0.2 then
                    if (v38.LastLOS and tick() - v38.LastLOS or 1e999) < 1.5 then
                        v36 = l_Survivor_0.Rig.PrimaryPart.Position + l_Survivor_0.Rig.PrimaryPart.AssemblyLinearVelocity * ((math.sin(tick() * 2.5) * 10 + 15) / 50 + 0.28);
                    else
                        v36 = l_Survivor_0.Rig.PrimaryPart.Position;
                    end;
                    if (v38.BufferAdded and tick() - v38.BufferAdded or 1e999) > 0.01 then
                        v38.BufferAdded = tick();
                        table.insert(v15.PlayerRootPositionBuffer, v36);
                        if #v15.PlayerRootPositionBuffer > 4 then
                            table.remove(v15.PlayerRootPositionBuffer, 1);
                        end;
                    end;
                    v36 = v15.PlayerRootPositionBuffer[1] or v36;
                    v38.PositionSet = tick();
                end;
                if v33 == "Idle" or v15.OUCH then
                    v15.Path:Stop();
                    v15.Humanoid:MoveTo(v15.Root.Position);
                else
                    local v52 = l_Survivor_0.Rig.PrimaryPart.Position.Y - v15.Root.Position.Y > 4;
                    if not v15.InVoidRush and (v38.LastBait and tick() - v38.LastBait or 1e999) < v15.BaitTime then
                        v15.Humanoid:MoveTo(v15.Root.Position + (v15.Root.Position - v15.Survivor.Rig.PrimaryPart.Position).Unit * 100);
                    elseif v15.InVoidRush or (v38.LastLOS and tick() - v38.LastLOS or 1e999) < 0.45 and not v52 then
                        v15.Path:Stop();
                        local l_Unit_0 = v15.Humanoid.MoveDirection.Unit;
                        if l_Unit_0 ~= l_Unit_0 then
                            l_Unit_0 = Vector3.new(0, 0, 0, 0);
                        end;
                        local v54 = v36 - v15.Root.Position;
                        local l_Unit_1 = Vector3.new(v54.X, 0, v54.Z).Unit;
                        local v56 = l_Unit_1 - l_Unit_0;
                        local l_Magnitude_0 = v56.Magnitude;
                        if l_Magnitude_0 > 0 then
                            local v58 = v43 * (v15.InVoidRush and l_Killer_0.Config.VoidRushTurnSpeed or math.clamp((v15.Root.Position - l_Survivor_0.Rig.PrimaryPart.Position).Magnitude * 6.6, 15, 35));
                            l_Unit_0 = (if l_Magnitude_0 <= v58 then l_Unit_1 else l_Unit_0 + v56.Unit * v58).Unit;
                        end;
                        v15.Humanoid:Move(l_Unit_0);
                        v15.Baited = false;
                    elseif (v38.LastPathfind and tick() - v38.LastPathfind or 1e999) > ((not (v33 == "Run") or v50) and 0.2 or 0.04) then
                        if not v15.Path:Run(v36) and v15.Path._lastError ~= v11.ErrorType.LimitReached then
                            v15.Humanoid:MoveTo(v36);
                        end;
                        v38.LastPathfind = tick();
                        v15.Baited = false;
                    end;
                end;
                if (v15.Root.Position - v36).Magnitude < 9 and (v38.LastSwing and tick() - v38.LastSwing or 1e999) > l_Killer_0.Config.StabCooldown and (v38.RushStop and tick() - v38.RushStop or 1e999) > 2.5 and (v38.RushStart and tick() - v38.RushStart or 1e999) > 0.8 and not v48 and not v47 and not v15.InVoidRush then
                    v15.Animations.Stab.Priority = Enum.AnimationPriority.Action4;
                    v15.Animations.Stab:Play();
                    v38.LastSwing = tick();
                    v12:Play(l_Killer_0.Config.Sounds.Swing, {
                        Parent = v15.Root
                    });
                    task.delay(l_Killer_0.Config.StabWindup, function() --[[ Line: 379 ]]
                        -- upvalues: l_Killer_0 (ref), v15 (ref), l_Survivor_0 (ref), v12 (ref), v13 (ref), l_RunService_0 (ref)
                        local v59 = tick();
                        local v60 = 0.035;
                        local v61 = nil;
                        while true do
                            if tick() - v59 < l_Killer_0.Config.StabLinger and v15 and v15.Root and not v15.OUCH then
                                if v60 > 0.03 then
                                    v60 = v60 - 0.03;
                                    local l_Part_0 = Instance.new("Part");
                                    l_Part_0.Name = "SIKE&Hitbox";
                                    l_Part_0.Transparency = 1;
                                    l_Part_0.CanCollide = false;
                                    l_Part_0.CanTouch = false;
                                    l_Part_0.CanQuery = false;
                                    l_Part_0.Anchored = true;
                                    l_Part_0.Size = Vector3.new(4.5, 6, 7.5, 0);
                                    l_Part_0.CFrame = v15.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -(math.random(160, 180) / 100));
                                    l_Part_0.Parent = workspace:FindFirstChild("Hitboxes");
                                    l_Part_0.Color = Color3.new(1, 0.25, 0.25);
                                    v61 = l_Part_0;
                                    game.Debris:AddItem(l_Part_0, 2);
                                end;
                                local v63 = RaycastParams.new();
                                v63.FilterDescendantsInstances = {
                                    l_Survivor_0.Rig
                                };
                                v63.FilterType = Enum.RaycastFilterType.Include;
                                local v64 = workspace:Spherecast(v15.Root.Position, 1.4, v15.Root.CFrame.LookVector * 6, v63);
                                if v64 and v64.Instance then
                                    local l_Humanoid_0 = l_Survivor_0.Rig.Humanoid;
                                    l_Humanoid_0:SetAttribute("FakeDamage", (l_Humanoid_0:GetAttribute("FakeDamage") or 0) + l_Killer_0.Config.HallucinationCloneFakeDamage);
                                    v12:Play(l_Killer_0.Config.Sounds.Hit, {
                                        Parent = l_Survivor_0.Rig.PrimaryPart
                                    });
                                    v13:FireServerConnection(("%*CloneEvent"):format(l_Killer_0.Player.Name), "REMOTE_EVENT", "TOOKDAMAGE");
                                    v61.Color = Color3.new(0.5, 1, 0.5);
                                    return;
                                else
                                    v60 = v60 + l_RunService_0.Heartbeat:Wait();
                                end;
                            else
                                return;
                            end;
                        end;
                    end);
                end;
                if (l_Survivor_0.Rig.PrimaryPart.Position - v15.Root.Position).Magnitude < 50 and (v38.LastLOS and tick() - v38.LastLOS or 1e999) < 4 then
                    v15.Orient.MaxAngularVelocity = (7.7 - math.min(0.7, v15.Survivor.Rig.PrimaryPart.CFrame.LookVector:Dot(v15.Root.CFrame.LookVector) * 3.5) * 4.6) / 2;
                    v15.WorldAtt.CFrame = CFrame.new(v15.Root.Position * Vector3.new(1, 0, 1, 0), v36 * Vector3.new(1, 0, 1, 0));
                    v38.LookPlayer = tick();
                else
                    if (v38.TurnRateChanged and tick() - v38.TurnRateChanged or 1e999) > 1 then
                        v38.TurnRateChanged = tick();
                        v15.Orient.MaxAngularVelocity = math.random(7, 10);
                    end;
                    v15.WorldAtt.CFrame = CFrame.new(v15.Root.Position * Vector3.new(1, 0, 1, 0), (v15.Root.Position + v15.Root.Velocity + Vector3.new(0.20000000298023224, 0, 0, 0)) * Vector3.new(1, 0, 1, 0));
                end;
                v15.Orient.Enabled = not v15.InVoidRush;
                v15.Humanoid.AutoRotate = v15.InVoidRush;
                if not v15.InVoidRush then
                    if v33 == "Run" and not v50 then
                        l_v30_0 = l_v30_0 - v28 * v43;
                        v38.Ran = tick();
                    elseif (v38.Ran and tick() - v38.Ran or 1e999) > 1 then
                        l_v30_0 = l_v30_0 + v29 * v43;
                    end;
                    l_v30_0 = math.clamp(l_v30_0, v31, v30);
                    if l_v30_0 == v31 then
                        v38.StaminaDepleted = tick();
                    end;
                end;
                if v15.InVoidRush then
                    v15.Humanoid.WalkSpeed = l_Killer_0.Config.VoidRushDashSpeed;
                    if (v38.RushHitbox and tick() - v38.RushHitbox or 1e999) > 0.03 then
                        local l_Part_1 = Instance.new("Part");
                        l_Part_1.Name = "SIKEHitbox";
                        l_Part_1.Transparency = 1;
                        l_Part_1.CanCollide = false;
                        l_Part_1.CanTouch = false;
                        l_Part_1.CanQuery = false;
                        l_Part_1.Anchored = true;
                        l_Part_1.Size = Vector3.new(6, 4, 4, 0);
                        l_Part_1.CFrame = v15.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -math.clamp((v38.RushDashStart and tick() - v38.RushDashStart or 1e999) * 2 - 0.2, 0, 2.8 - math.sin(tick() * math.random(3, 5))));
                        l_Part_1.Parent = workspace:FindFirstChild("Hitboxes");
                        l_Part_1.Color = Color3.new(1, 0.25, 0.25);
                        game.Debris:AddItem(l_Part_1, 2);
                        v38.RushHitbox = tick();
                    end;
                    if (v38.RushDashStart and tick() - v38.RushDashStart or 1e999) > 0.5 and v15.Root.Velocity.Magnitude < 12 or (l_Survivor_0.Rig.PrimaryPart.Position - v15.Root.Position).Magnitude < 6 or v15.VoidRushDir and v15.VoidRushDir:Dot(((l_Survivor_0.Rig.PrimaryPart.Position - v15.Root.Position) * Vector3.new(1, 0, 1, 0)).Unit) < -0.2 then
                        v42();
                    end;
                else
                    local v67 = (not ((v38.RushStop and tick() - v38.RushStop or 1e999) >= 2.2) or (v38.RushStart and tick() - v38.RushStart or 1e999) < 2) and 0.65 or 1;
                    local v68 = v15.Root.Velocity.Magnitude <= 0 and 0.1 or (v15.Root.CFrame.LookVector:Dot(v15.Root.Velocity.Unit) + 6) / 7;
                    local v69 = v27 * v68 * v67;
                    local v70 = l_Attribute_0 * v67;
                    v15.Humanoid.WalkSpeed = math.clamp(v15.Humanoid.WalkSpeed + v43 / 0.75 * (v69 - v70) * (v33 == "Run" and 1 or -1), v70, v69);
                end;
                if v34 ~= v33 then
                    for _, v72 in ipairs({
                        "Walk", 
                        "Run", 
                        "Idle"
                    }) do
                        v15.Animations[v72]:Stop(0.125);
                    end;
                    v15.Animations[v33]:Play(0.125);
                end;
                v15.Animations[v33]:AdjustSpeed(v32);
                v34 = v33;
                return;
            end;
        end);
        v15.HitboxConnection = workspace.Hitboxes.ChildAdded:Connect(function(v73) --[[ Line: 514 ]]
            -- upvalues: v15 (copy), l_ReplicatedStorage_0 (ref), l_Survivor_0 (copy), v12 (ref), l_Killer_0 (copy), v10 (ref), v13 (ref), l_RunService_0 (ref)
            if not v15.OUCH and v73:IsA("BasePart") and v73.Name == v15.Player.Name .. "Hitbox" and v15.Rig and v15.Rig:FindFirstChild("QueryHitbox") then
                local v74 = OverlapParams.new();
                v74.FilterType = Enum.RaycastFilterType.Include;
                v74.FilterDescendantsInstances = {
                    v15.Rig.QueryHitbox
                };
                local l_workspace_PartsInPart_0 = workspace:GetPartsInPart(v73, v74);
                if l_workspace_PartsInPart_0 and next(l_workspace_PartsInPart_0) then
                    local v76 = require(l_ReplicatedStorage_0.Modules.Ragdolls);
                    local v77 = (v15.Root.Position - l_Survivor_0.Rig.PrimaryPart.Position).Unit * 50;
                    local v78 = Instance.new("BodyVelocity", v15.Root);
                    v78.P = 999999;
                    v78.MaxForce = Vector3.new(9999999, 9999999, 9999999, 0);
                    v78.Velocity = v77 == v77 and v77 or Vector3.new(0, 50, 0, 0);
                    game.Debris:AddItem(v78, 0.1);
                    for _, v80 in pairs(v15.Animations) do
                        v80:Stop();
                    end;
                    v76.EnableRagdoll(v15.Rig);
                    v15.OUCH = true;
                    v15.HitboxConnection:Disconnect();
                    v15.Rig:SetAttribute("Undetectable", true);
                    local l_pairs_0 = pairs;
                    local v82 = l_Survivor_0.Config.Sounds or {};
                    for v83, v84 in l_pairs_0(v82) do
                        if v83:lower():find("hit") then
                            v12:Play(v84, {
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
                    for _, v86 in ipairs(v15.Rig:GetDescendants()) do
                        if v86:IsA("ParticleEmitter") or v86:IsA("Beam") or v86:IsA("Trail") then
                            v86.Enabled = false;
                        end;
                    end;
                    l_pairs_0 = v15.Rig;
                    v15.Rig = nil;
                    v13:FireServerConnection(("%*CloneEvent"):format(l_Killer_0.Player.Name), "REMOTE_EVENT", "KILLED");
                    task.delay(2.5, function() --[[ Line: 565 ]]
                        -- upvalues: l_pairs_0 (copy), l_RunService_0 (ref)
                        local v87 = tick();
                        local v88 = {};
                        for _, v90 in ipairs(l_pairs_0:GetDescendants()) do
                            if v90:IsA("BasePart") then
                                v88[v90] = v90.Transparency;
                            end;
                        end;
                        while tick() - v87 <= 1 do
                            for v91, v92 in pairs(v88) do
                                v91.Transparency = v92 + (tick() - v87) * (1 - v92);
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
v14.LOSCheck = function(v93) --[[ Line: 589 ]] --[[ Name: LOSCheck ]]
    if not v93.Survivor or not v93.Root or not v93.Survivor.Rig or not v93.Survivor.Rig.PrimaryPart then
        return false;
    else
        local v94 = nil;
        local v95 = nil;
        local v96 = 0;
        local v97 = RaycastParams.new();
        v97.CollisionGroup = "Killers";
        v97.FilterType = Enum.RaycastFilterType.Exclude;
        v97.FilterDescendantsInstances = {
            workspace.Players
        };
        v97.RespectCanCollide = true;
        repeat
            local v98 = v93.Survivor.Rig.PrimaryPart.Position - v93.Root.Position;
            v94 = workspace:Spherecast(v93.Root.Position, 1, v98, v97);
            if v94 then
                local _ = v94.Instance;
                v95 = false;
            else
                v95 = false;
            end;
            v96 = v96 + 1;
        until not v94 or v94 and not v95 or v96 > 25;
        if v96 > 25 then
            warn("we raycasted tooooo much");
            return false;
        elseif not v94 then
            return true;
        else
            return false;
        end;
    end;
end;
v14.OnScreenCheck = function(v100) --[[ Line: 635 ]] --[[ Name: OnScreenCheck ]]
    -- upvalues: v9 (copy)
    local v101 = true;
    if (v100.Root.Position - v100.Survivor.Rig.PrimaryPart.Position).Magnitude >= 10 then
        v101 = v9:IsOnScreen(v100.Rig);
    end;
    return v101;
end;
v14.Destroy = function(v102) --[[ Line: 639 ]] --[[ Name: Destroy ]]
    -- upvalues: v10 (copy)
    local l_ipairs_0 = ipairs;
    local v104 = v102.InstanceCache or {};
    for _, v106 in l_ipairs_0(v104) do
        v106.LocalTransparencyModifier = v106.LocalTransparencyModifier - 0.8;
    end;
    if v102.Killer and v102.Killer.Rig then
        v102.Killer.Rig:SetAttribute("Undetectable", nil);
    end;
    if v102.Rig then
        v102.Rig:Destroy();
    end;
    if v102.WorldAtt then
        v102.WorldAtt:Destroy();
    end;
    if v102.HitboxConnection then
        v102.HitboxConnection:Disconnect();
    end;
    if v102.NeuronConnection then
        v102.NeuronConnection:Disconnect();
    end;
    if v102.Path then
        v102.Path:Destroy();
    end;
    v10:KillerRemoved(v102);
    v102:Clean();
end;
return v14;