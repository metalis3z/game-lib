-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Sun Oct 26 21:31:30 2025 ]]
local v0 = {
    PointLight = {
        Brightness = 0, 
        Range = 0
    }, 
    BlurEffect = {
        Size = 0
    }, 
    ColorCorrectionEffect = {
        Saturation = 0, 
        Brightness = 0, 
        Contrast = 0, 
        TintColor = Color3.new(1, 1, 1)
    }
};
local v1 = {};
local l_RunService_0 = game:GetService("RunService");
local l_CollectionService_0 = game:GetService("CollectionService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local v6 = require(l_ReplicatedStorage_0.Systems.Character.Game.Sprinting);
local v7 = require(l_ReplicatedStorage_0.Modules.Sounds);
local v8 = require(l_ReplicatedStorage_0.Modules.Util);
local v9 = require(l_ReplicatedStorage_0.Modules.Hitboxes);
local v10 = require(l_ReplicatedStorage_0.Modules.Statuses);
local v11 = require(l_ReplicatedStorage_0.Modules.Network);
local v12 = require(l_ReplicatedStorage_0.Modules.Actors);
local v13 = require(l_ReplicatedStorage_0.Modules.Schematics.Lighting);
local v14 = l_RunService_0:IsClient() and game.Players.LocalPlayer;
local function v20(v15) --[[ Line: 26 ]] --[[ Name: getLowestIndexValue ]]
    local v16 = 1e999;
    local v17 = nil;
    for v18, v19 in pairs(v15) do
        assert(typeof(v18) == "number", "Passed dictionary must contained numeric keys only");
        if v18 < v16 then
            v16 = v18;
            v17 = v19;
        end;
    end;
    return v17;
end;
local function v39(v21, v22, v23, v24) --[[ Line: 41 ]] --[[ Name: beamProjectile ]]
    local v25 = v24 ^ 2;
    local v26 = v22 * v24;
    local v27 = 0.5 * v21 * v25 + v26 + v23;
    local v28 = v27 - (v21 * v25 + v26) / 3;
    local v29 = (0.125 * v21 * v25 + 0.5 * v26 + v23 - 0.125 * (v23 + v27)) / 0.375 - v28;
    local l_magnitude_0 = (v29 - v23).magnitude;
    local l_magnitude_1 = (v28 - v27).magnitude;
    local l_unit_0 = (v23 - v27).unit;
    local l_unit_1 = (v29 - v23).unit;
    local l_unit_2 = l_unit_1:Cross(l_unit_0).unit;
    local l_unit_3 = (v28 - v27).unit;
    local l_unit_4 = l_unit_3:Cross(l_unit_0).unit;
    l_unit_0 = l_unit_2:Cross(l_unit_1).unit;
    local v37 = CFrame.new(v23.x, v23.y, v23.z, l_unit_1.x, l_unit_2.x, l_unit_0.x, l_unit_1.y, l_unit_2.y, l_unit_0.y, l_unit_1.z, l_unit_2.z, l_unit_0.z);
    local v38 = CFrame.new(v27.x, v27.y, v27.z, l_unit_3.x, l_unit_4.x, l_unit_0.x, l_unit_3.y, l_unit_4.y, l_unit_0.y, l_unit_3.z, l_unit_4.z, l_unit_0.z);
    return l_magnitude_0, -l_magnitude_1, v37, v38;
end;
v1.LastManStanding = function(_, v41, v42) --[[ Line: 81 ]] --[[ Name: LastManStanding ]]
    -- upvalues: v13 (copy)
    if not game["Run Service"]:IsServer() then
        return;
    else
        if v42 then
            v13:SetCustomLighting(v41.Config.ELMSLighting);
        end;
        return;
    end;
end;
local function v57(v43, v44, v45, v46) --[[ Line: 88 ]] --[[ Name: getTrajectoryPoints ]]
    -- upvalues: v39 (copy)
    local v47 = {};
    local l_v45_0 = v45;
    local v49 = nil;
    local v50 = 5;
    for v51 = 0.05, 5, 0.05 do
        local v52 = v51 ^ 2;
        local v53 = v44 * v51;
        local v54 = 0.5 * v43 * v52 + v53 + v45;
        local v55 = vector.create(v54.x, v54.y, v54.z);
        local v56 = v55 - l_v45_0;
        v49 = workspace:Raycast(l_v45_0, v56, v46);
        if v49 then
            v50 = v51 - 0.05 + (v49.Position - l_v45_0).Magnitude / v56.Magnitude * 0.05;
            table.insert(v47, v49.Position);
            break;
        else
            table.insert(v47, v55);
            l_v45_0 = v55;
        end;
    end;
    return v47, v39(v43, v44, v45, v50);
end;
local function _(v58) --[[ Line: 122 ]] --[[ Name: __warn ]]
    warn("[G666]:", v58);
end;
local _ = function(v60) --[[ Line: 126 ]] --[[ Name: getMass ]]
    assert(v60 and v60:IsA("Model"), "Model argument of getMass must be a model");
    local v61 = 0;
    for _, v63 in pairs(v60:GetDescendants()) do
        if v63:IsA("BasePart") then
            v61 = v61 + v63:GetMass();
        end;
    end;
    return v61;
end;
local function _(v65, v66, v67) --[[ Line: 140 ]] --[[ Name: reward ]]
    -- upvalues: v12 (copy)
    v12:IncrementActorStats(v65.Player, {
        Action = v67, 
        RewardType = v66 .. "KillerAction"
    });
end;
local function _(v69, v70, v71) --[[ Line: 147 ]] --[[ Name: changeProp ]]
    if v69[v70] ~= v71 then
        v69[v70] = v71;
    end;
end;
local function v76(v73, v74, v75) --[[ Line: 153 ]] --[[ Name: alphaSequence ]]
    v73 = math.clamp(v73, 0, 1);
    if v73 <= 0.001 then
        return ColorSequence.new(v75);
    elseif v73 >= 0.999 then
        return ColorSequence.new(v74);
    else
        return (ColorSequence.new({
            ColorSequenceKeypoint.new(0, v74), 
            ColorSequenceKeypoint.new(v73, v74), 
            ColorSequenceKeypoint.new(v73 + 0.001, v75), 
            ColorSequenceKeypoint.new(1, v75)
        }));
    end;
end;
local function v79(v77, v78, ...) --[[ Line: 172 ]] --[[ Name: updateUI ]]
    -- upvalues: v11 (copy)
    v11:FireClientConnection(v77.Player, "666UI", "REMOTE_EVENT", v78, ...);
end;
local function v84(v80, v81) --[[ Line: 176 ]] --[[ Name: applyHemmorhage ]]
    -- upvalues: v10 (copy)
    local v82 = v10:PlayerHasStatus(v81, "Hemmorhage");
    local v83 = math.clamp((v82 and v82.Level or 0) + 1, 1, 3);
    v10:ApplyStatus(v81, "Hemmorhage", {
        Killer = v80, 
        Level = v83, 
        Duration = 1800
    });
end;
local function v89(v85, v86) --[[ Line: 183 ]] --[[ Name: __applyStatusesFromDict ]]
    -- upvalues: v10 (copy)
    for v87, v88 in pairs(v86) do
        v10:ApplyStatus(v85, v87, v88);
    end;
end;
v1.CreateVFX = function(_, v91) --[[ Line: 189 ]] --[[ Name: CreateVFX ]]
    local v92 = {};
    local l_Config_0 = v91.Config;
    local l_Rig_0 = v91.Rig;
    local l_BaseVFX_0 = script.BaseVFX;
    local l_VFXFolder_0 = l_Config_0.VFXFolder;
    for _, v98 in ipairs(l_BaseVFX_0:GetChildren()) do
        local v99 = if l_VFXFolder_0 and l_VFXFolder_0:FindFirstChild(v98.Name) then l_VFXFolder_0[v98.Name] else v98;
        local v100 = v99:GetAttribute("Adornee") or "HumanoidRootPart";
        if l_Rig_0:FindFirstChild(v100) then
            local v101 = v99:Clone();
            v101.Parent = l_Rig_0[v100];
            v92[v98.Name] = v101;
        else
            warn((("[G666/CreateVFX]: Could not create VFX attachment for %* as Adornee %* does not exist"):format(v98.Name, v100)));
        end;
    end;
    return v92;
end;
v1.Created = function(_, v103) --[[ Line: 213 ]] --[[ Name: Created ]]
    -- upvalues: l_RunService_0 (copy), l_ReplicatedStorage_0 (copy), v8 (copy), v11 (copy), v14 (copy), l_CollectionService_0 (copy), l_TweenService_0 (copy), v1 (copy), v76 (copy), v0 (copy), v7 (copy)
    v103.Blood = v103.Config.BloodStartCount;
    v103.MaxBlood = v103.Config.BloodStartMax;
    if l_RunService_0:IsServer() then
        assert(v103.Config.BloodOrbTemplate:IsA("BasePart"), "Blood orb must be a BasePart.");
        v103:SetCooldownOf("DemonicPursuit", v103.Config.PursuitInitialCooldown);
        v103:SetCooldownOf("BloodHunt", v103.Config.BloodHuntInitialCooldown);
        local v104 = {};
        local v105 = {};
        local _ = {};
        local l_Rig_1 = v103.Rig;
        local v108 = Instance.new("Model", workspace.Map);
        v108.Name = v103.Player.Name .. "BloodOrbContainer";
        local v109 = l_ReplicatedStorage_0.Assets.Instances.Nothingburger:Clone();
        v109.Parent = v108;
        v109.Name = "IExist";
        v103.VFX = v103.Behavior:CreateVFX(v103);
        v103.ServerConnections = {};
        v103.Hunting = false;
        v103.RemainingHuntTime = 0;
        v103.BloodOrbs = {};
        v103.BloodContainer = v108;
        v103.Highlights = v104;
        v103.Chases = v105;
        v103.Cache = v103.Cache or {};
        v103.Cache.PursuitCutscene = v8:LoadAnimationFromID(v103.Rig, v103.Config.Animations.DemonicPursuitCutscene.Killer);
        v103.Cache.SlashNormal = v8:LoadAnimationFromID(v103.Rig, v103.Config.Animations.Slash.Slash);
        v103.Cache.SlashPower = v8:LoadAnimationFromID(v103.Rig, v103.Config.Animations.Slash.Bite);
        v103.Rig:SetAttribute("TailPhysicsEnabled", true);
        v103.ShockwaveBuffer = 0;
        v11:SetConnection(("%*666Shockwave"):format(v103.Player.Name), "REMOTE_EVENT", function(v110, v111) --[[ Line: 260 ]]
            -- upvalues: v103 (copy)
            if not v103 or not v111 then
                return;
            elseif v110 ~= v103.Player then
                v110:Kick("do the roar");
                return;
            else
                if v103.Behavior and v103.Behavior.FireShockwave and v103.ShockwaveBuffer then
                    if v103.ShockwaveBuffer > 0 then
                        local l_v103_0 = v103;
                        l_v103_0.ShockwaveBuffer = l_v103_0.ShockwaveBuffer - 1;
                        v103.Behavior.FireShockwave(v103, v111);
                        return;
                    else
                        v110:Kick("do the roar");
                    end;
                end;
                return;
            end;
        end);
        local v113 = 0;
        local l_ManicSpeed_0 = v103.Config.ManicSpeed;
        local l_ManicChaseSpeed_0 = v103.Config.ManicChaseSpeed;
        v103.ManicSpeed = v8:CreateSpeedMultiplier(v103.Player, 1, "666ManicFixation");
        v103.ManicSpeed.Value = 1;
        local v132 = l_RunService_0.Heartbeat:Connect(function(v116) --[[ Line: 283 ]]
            -- upvalues: v103 (copy), l_Rig_1 (copy), v8 (ref), v105 (copy), l_ManicSpeed_0 (copy), l_ManicChaseSpeed_0 (copy), v113 (ref)
            if not v103 or not v103.Rig or not v103.Rig.Parent or not v103.Rig.PrimaryPart then
                return;
            else
                local v117 = v103.Rig:GetAttribute("TerrorMultiplier") or 1;
                for _, v119 in ipairs(workspace.Players.Survivors:GetChildren()) do
                    if not v103.Chases[v119] then
                        local l_PrimaryPart_0 = v119.PrimaryPart;
                        local l_Humanoid_0 = v119:FindFirstChild("Humanoid");
                        if l_PrimaryPart_0 and l_Humanoid_0 and l_Humanoid_0.Health > 0 and ((l_PrimaryPart_0.Position - l_Rig_1.PrimaryPart.Position) * v8.KillerDistanceVector).Magnitude <= v103.Config.ChaseEnterThreshold then
                            v103.Chases[v119] = true;
                        end;
                    end;
                end;
                for v122, _ in pairs(v103.Chases) do
                    if not v8:IsAlive(v122) then
                        v105[v122] = nil;
                    elseif ((v122.PrimaryPart.Position - l_Rig_1.PrimaryPart.Position) * v8.KillerDistanceVector).Magnitude > v103.Config.ChaseLeaveThreshold * v117 then
                        v105[v122] = nil;
                    end;
                end;
                local v124 = 1;
                for v125, _ in pairs(v103.Highlights) do
                    if not v8:IsAlive(v125) or not v103.Behavior.IsHighlighted(v103, v125) then
                        v125:RemoveTag(v103.Player.Name .. "666Highlight");
                        v103.Highlights[v125] = nil;
                    else
                        local l_Unit_0 = ((v125.PrimaryPart.Position - l_Rig_1.PrimaryPart.Position) * v8.KillerDistanceVector).Unit;
                        local l_Unit_1 = l_Rig_1.PrimaryPart.AssemblyLinearVelocity.Unit;
                        if l_Unit_1 == l_Unit_1 and l_Unit_0 == l_Unit_0 and l_Unit_0:Dot(l_Unit_1) > math.cos((math.rad(v103.Config.ManicConeSize))) then
                            if not v105[v125] then
                                v124 = l_ManicSpeed_0;
                                break;
                            else
                                v124 = l_ManicChaseSpeed_0;
                            end;
                        end;
                    end;
                end;
                if not v103.ManicSpeed or not v103.ManicSpeed.Parent or not v103.ManicSpeed:IsDescendantOf(l_Rig_1) then
                    if v103.ManicSpeed then
                        v103.ManicSpeed:Destroy();
                        v103.ManicSpeed = nil;
                    end;
                    v103.ManicSpeed = v8:CreateSpeedMultiplier(v103.Player, 1, "666ManicFixation");
                    v103.ManicSpeed.Value = 1;
                end;
                v113 = v124 ~= 1 and tick() or v113;
                if tick() - v113 >= 1 or v124 ~= 1 then
                    local v129 = math.clamp(v103.ManicSpeed.Value < v124 and v103.ManicSpeed.Value + v116 * v103.Config.ManicBuildRate or v103.ManicSpeed.Value - v116 * v103.Config.ManicDecayRate, 1, l_ManicSpeed_0);
                    v103.ManicSpeed.Value = v129;
                end;
                for v130, _ in pairs(v103.BloodOrbs) do
                    if not v130 or not v130.Parent then
                        if v130 then
                            v130:Destroy();
                        end;
                        v103.BloodOrbs[v130] = nil;
                    elseif (v130.Position - v103.Rig.PrimaryPart.Position).Magnitude < v103.Config.BloodOrbCollectRange and v103.Blood < v103.MaxBlood then
                        v103.BloodOrbs[v130] = nil;
                        v103.Behavior.CollectOrb(v103, v130);
                    end;
                end;
                return;
            end;
        end);
        table.insert(v103.ServerConnections, v132);
        return;
    else
        if l_RunService_0:IsClient() then
            local v133 = v14 == v103.Player;
            local v134 = v103.Config.Tail and require(v103.Config.Tail);
            if v134 then
                v103.Tail = v134.new(v103.Rig);
            end;
            v103.ClientConnections = {};
            v103.BloodOrbs = {};
            v103.OrbTransparencyConnection = l_CollectionService_0:GetInstanceAddedSignal((("%*BloodOrb"):format(v103.Player.Name))):Connect(function(v135) --[[ Line: 397 ]]
                -- upvalues: v133 (copy), v103 (copy)
                if not v133 then
                    task.defer(function() --[[ Line: 400 ]]
                        -- upvalues: v135 (copy), v103 (ref)
                        v135.LocalTransparencyModifier = 0.8;
                        v103.Behavior.DelocalizeBloodOrb(v103, v135);
                        table.insert(v103.BloodOrbs, v135);
                    end);
                    return;
                else
                    local v136 = v135:WaitForChild("AlignPosition", 2);
                    if v135 and v135.Parent and v136 then
                        local v137 = {
                            Mover = v136
                        };
                        v103.BloodOrbs[v135] = v137;
                        if v103.Hunting then
                            v103.Behavior.ToggleOrbVisibility(v103, v135, false);
                            return;
                        end;
                    else
                        warn("failed to find mover for", (tostring(v135)));
                    end;
                    return;
                end;
            end);
            if v133 then
                local v138 = v103.Rig:WaitForChild("Humanoid", 30);
                if v138 then
                    v138.CameraOffset = Vector3.new(0, 1.5, 0, 0);
                    v14.CameraMinZoomDistance = 0;
                    v14.CameraMaxZoomDistance = 20;
                end;
                local v139 = v103.Config.BloodUI:Clone();
                v139.Parent = v14.PlayerGui.TemporaryUI;
                v139.Position = v139.Position + UDim2.fromScale(0, 0.5);
                local v140 = {
                    In = l_TweenService_0:Create(v139, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Position = v139.Position - UDim2.fromScale(0, 0.5)
                    }), 
                    Out = l_TweenService_0:Create(v139, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                        Position = v139.Position
                    })
                };
                local v141 = nil;
                local v142 = false;
                local l_Timer_0 = v139.Timer;
                local l_Gradient_0 = l_Timer_0.Fill.Gradient;
                local l_Time_0 = l_Timer_0.Time;
                local _ = l_Timer_0.Position;
                local v147 = {
                    In = l_TweenService_0:Create(l_Timer_0, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Size = l_Timer_0.Size
                    }), 
                    Out = l_TweenService_0:Create(l_Timer_0, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                        Size = UDim2.fromScale(0, l_Timer_0.Size.Y.Scale)
                    })
                };
                local v148 = nil;
                local v149 = nil;
                local l_Blood_0 = v139.Blood;
                local l_Gradient_1 = l_Blood_0.Fill.Gradient;
                local l_Count_0 = l_Blood_0.Count;
                local l_Max_0 = l_Blood_0.Max;
                v103.BloodHuntEffects = {};
                local v154 = {};
                local function _() --[[ Line: 464 ]] --[[ Name: updateAbilityName ]]
                    -- upvalues: v103 (copy), v1 (ref)
                    local v155 = false;
                    if v103.Blood >= v103.MaxBlood then
                        v155 = not v103.Hunting;
                    end;
                    local l_BloodHunt_0 = v103.Behavior.Abilities.BloodHunt;
                    l_BloodHunt_0.Name = v155 and v1.Abilities.BloodHunt.Name or "Blood Rush";
                    l_BloodHunt_0.Icon = v155 and v1.Abilities.BloodHunt.Icon or "rbxassetid://92254001874516";
                end;
                do
                    local l_v141_0, l_v142_0, l_v148_0, l_v149_0 = v141, v142, v148, v149;
                    local function v166() --[[ Line: 472 ]] --[[ Name: setTimerUI ]]
                        -- upvalues: l_v142_0 (ref), l_Timer_0 (copy), v103 (copy), l_Gradient_0 (copy), v76 (ref), l_Time_0 (copy)
                        if not l_v142_0 then
                            return;
                        else
                            l_Timer_0.Visible = true;
                            local v162 = v103.Rig:GetAttribute("BloodHuntDuration") or v103.Config.BloodHuntDuration;
                            local v163 = v103.Rig:GetAttribute("BloodHuntTimer") or v162;
                            l_Gradient_0.Color = v76(v163 / v103.Rig:GetAttribute("BloodHuntDuration"), Color3.new(1, 1, 1), Color3.new(0.1, 0.1, 0.1));
                            local v164 = tostring((math.floor(v163)));
                            v164 = string.rep("0", 2 - string.len(v164)) .. v164;
                            local v165 = tostring(v163 - math.floor(v163));
                            v165 = string.format("%.2f", v165);
                            l_Time_0.Text = ("%*:%*"):format(v164, (v165:sub(v165:len() - 1, v165:len())));
                            return;
                        end;
                    end;
                    local function v167() --[[ Line: 490 ]] --[[ Name: uiAppear ]]
                        -- upvalues: l_v141_0 (ref), v140 (copy), l_v142_0 (ref)
                        if l_v141_0 then
                            pcall(task.cancel, l_v141_0);
                        end;
                        l_v141_0 = nil;
                        v140.In:Play();
                        if l_v142_0 then
                            return;
                        else
                            l_v141_0 = task.delay(3, function() --[[ Line: 498 ]]
                                -- upvalues: v140 (ref)
                                v140.Out:Play();
                            end);
                            return;
                        end;
                    end;
                    local l_BloodStartMax_0 = v103.Config.BloodStartMax;
                    local l_BloodStartCount_0 = v103.Config.BloodStartCount;
                    l_Max_0.Text = tostring(l_BloodStartMax_0);
                    l_Count_0.Text = tostring(l_BloodStartCount_0);
                    l_Gradient_1.Color = v76(l_BloodStartCount_0 / l_BloodStartMax_0, Color3.new(1, 1, 1), Color3.new(0.1, 0.1, 0.1));
                    l_Gradient_0.Color = v76(0, Color3.new(1, 1, 1), Color3.new(0.1, 0.1, 0.1));
                    l_Timer_0.Visible = false;
                    l_Timer_0.Size = UDim2.fromScale(0, l_Timer_0.Size.Y.Scale);
                    local v170 = false;
                    if v103.Blood >= v103.MaxBlood then
                        v170 = not v103.Hunting;
                    end;
                    local l_BloodHunt_1 = v103.Behavior.Abilities.BloodHunt;
                    l_BloodHunt_1.Name = v170 and v1.Abilities.BloodHunt.Name or "Blood Rush";
                    l_BloodHunt_1.Icon = v170 and v1.Abilities.BloodHunt.Icon or "rbxassetid://92254001874516";
                    v11:SetConnection("666UI", "REMOTE_EVENT", function(v172, ...) --[[ Line: 516 ]]
                        -- upvalues: l_v142_0 (ref), l_v148_0 (ref), l_Timer_0 (copy), v147 (copy), v103 (copy), v0 (ref), l_TweenService_0 (ref), v154 (copy), v166 (copy), l_v149_0 (ref), l_RunService_0 (ref), v167 (copy), l_Time_0 (copy), l_Max_0 (copy), l_Count_0 (copy), l_Gradient_1 (copy), v76 (ref), v1 (ref)
                        local v173 = table.pack(...);
                        if v172 == "START" then
                            if l_v142_0 then
                                return;
                            else
                                if l_v148_0 then
                                    pcall(task.cancel, l_v148_0);
                                    l_v148_0 = nil;
                                end;
                                l_v142_0 = true;
                                l_Timer_0.Visible = true;
                                v147.In:Play();
                                for _, v175 in ipairs({
                                    "Character", 
                                    "Lighting"
                                }) do
                                    for _, v177 in ipairs(v103.Config.BloodHuntVisuals[v175]:GetChildren()) do
                                        local v178 = v177:Clone();
                                        local v179 = v0[v177.ClassName];
                                        if v179 then
                                            local v180 = {};
                                            for v181, v182 in pairs(v179) do
                                                v180[v181] = v177[v181];
                                                v178[v181] = v182;
                                            end;
                                            local v183 = l_TweenService_0:Create(v178, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v180);
                                            local v184 = l_TweenService_0:Create(v178, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v179);
                                            v183:Play();
                                            table.insert(v154, v184);
                                        end;
                                        table.insert(v103.BloodHuntEffects, v178);
                                        v178.Parent = v175 == "Character" and v103.Rig.PrimaryPart or game:GetService("Lighting");
                                    end;
                                end;
                                v166();
                                if l_v149_0 then
                                    l_v149_0:Disconnect();
                                end;
                                l_v149_0 = nil;
                                l_v149_0 = l_RunService_0.Heartbeat:Connect(v166);
                                v103.Hunting = true;
                                for v185, _ in pairs(v103.BloodOrbs) do
                                    v103.Behavior.ToggleOrbVisibility(v103, v185, false);
                                end;
                                v167();
                            end;
                        elseif v172 == "END" then
                            if not l_v142_0 then
                                return;
                            else
                                l_v142_0 = false;
                                if l_v149_0 then
                                    l_v149_0:Disconnect();
                                end;
                                l_v149_0 = nil;
                                l_Time_0.Text = "TIME'S UP";
                                local v187 = v103.BloodHuntEffects or {};
                                for _, v189 in ipairs(v154) do
                                    v189:Play();
                                end;
                                for _, v191 in ipairs(v187) do
                                    game.Debris:AddItem(v191, 1.5);
                                end;
                                table.clear(v187);
                                table.clear(v154);
                                l_v148_0 = task.delay(1.5, function() --[[ Line: 591 ]]
                                    -- upvalues: v147 (ref), l_Timer_0 (ref)
                                    v147.Out:Play();
                                    task.wait(0.6);
                                    l_Timer_0.Visible = false;
                                end);
                                for v192, _ in pairs(v103.BloodOrbs) do
                                    v103.Behavior.ToggleOrbVisibility(v103, v192, true);
                                end;
                                v103.Hunting = nil;
                                v167();
                            end;
                        elseif v172 == "BLOOD" then
                            local v194 = v173[1];
                            local v195 = v173[2];
                            l_Max_0.Text = tostring(v195);
                            l_Count_0.Text = tostring(v194);
                            l_Gradient_1.Color = v76(v194 / v195, Color3.new(1, 1, 1), Color3.new(0.1, 0.1, 0.1));
                            v103.Blood = v194;
                            v103.MaxBlood = v195;
                            v167();
                        end;
                        local v196 = false;
                        if v103.Blood >= v103.MaxBlood then
                            v196 = not v103.Hunting;
                        end;
                        local l_BloodHunt_2 = v103.Behavior.Abilities.BloodHunt;
                        l_BloodHunt_2.Name = v196 and v1.Abilities.BloodHunt.Name or "Blood Rush";
                        l_BloodHunt_2.Icon = v196 and v1.Abilities.BloodHunt.Icon or "rbxassetid://92254001874516";
                    end);
                    v170 = {};
                    l_BloodHunt_1 = {};
                    local v198 = 1;
                    table.insert(v103.ClientConnections, l_CollectionService_0:GetInstanceAddedSignal(v103.Player.Name .. "666Highlight"):Connect(function(v199) --[[ Line: 628 ]]
                        -- upvalues: l_BloodHunt_1 (copy)
                        l_BloodHunt_1[v199] = true;
                    end));
                    table.insert(v103.ClientConnections, l_CollectionService_0:GetInstanceRemovedSignal(v103.Player.Name .. "666Highlight"):Connect(function(v200) --[[ Line: 631 ]]
                        -- upvalues: l_BloodHunt_1 (copy)
                        l_BloodHunt_1[v200] = nil;
                    end));
                    v11:SetConnection(("%*666DisplayHeartbeat"):format(v103.Player.Name), "REMOTE_EVENT", function(...) --[[ Line: 636 ]]
                        -- upvalues: v103 (copy)
                        v103.Behavior.DisplayHeartbeat(v103, ...);
                    end);
                    v103.BloodOrbs = {};
                    l_RunService_0:BindToRenderStep("UpdateOrbs", 1, function() --[[ Line: 641 ]]
                        -- upvalues: v8 (ref), v103 (copy), v198 (ref)
                        local l_Character_0 = game.Players.LocalPlayer.Character;
                        local v202 = l_Character_0 and l_Character_0.PrimaryPart;
                        if not v8:IsAlive(l_Character_0) then
                            return;
                        else
                            for v203, v204 in pairs(v103.BloodOrbs) do
                                if not v203 or not v203.Parent or not v204.Mover then
                                    v103.BloodOrbs[v203] = nil;
                                else
                                    local l_Magnitude_0 = (v202.Position - v203.Position).Magnitude;
                                    local l_BloodOrbAttractRange_0 = v103.Config.BloodOrbAttractRange;
                                    if l_BloodOrbAttractRange_0 < l_Magnitude_0 or v103.Blood >= v103.MaxBlood or v103.Hunting then
                                        if v203.Anchored ~= true then
                                            v203.Anchored = true;
                                        end;
                                        local l_Mover_0 = v204.Mover;
                                        if l_Mover_0.Enabled ~= false then
                                            l_Mover_0.Enabled = false;
                                        end;
                                    else
                                        if v203.Anchored ~= false then
                                            v203.Anchored = false;
                                        end;
                                        local l_Mover_1 = v204.Mover;
                                        local l_Position_1 = l_Character_0.PrimaryPart.Position;
                                        if l_Mover_1.Position ~= l_Position_1 then
                                            l_Mover_1.Position = l_Position_1;
                                        end;
                                        l_Mover_1 = v204.Mover;
                                        if l_Mover_1.Enabled ~= true then
                                            l_Mover_1.Enabled = true;
                                        end;
                                        l_Mover_1 = v204.Mover;
                                        l_Position_1 = math.clamp((l_BloodOrbAttractRange_0 - l_Magnitude_0) / l_BloodOrbAttractRange_0 * 35, 0, 35);
                                        if l_Mover_1.MaxVelocity ~= l_Position_1 then
                                            l_Mover_1.MaxVelocity = l_Position_1;
                                        end;
                                    end;
                                end;
                            end;
                            local v210 = l_Character_0 and l_Character_0:FindFirstChild("SpeedMultipliers") and l_Character_0.SpeedMultipliers:FindFirstChild("666ManicFixation");
                            if v210 then
                                if not v103.ManicLighting or not v103.ManicLighting.Parent then
                                    if v103.ManicLighting then
                                        v103.ManicLighting:Destroy();
                                    end;
                                    v103.ManicLighting = Instance.new("ColorCorrectionEffect", game.Lighting);
                                end;
                                local v211 = math.clamp((v210.Value - 1) / (v103.Config.ManicSpeed - 1), 0, 1);
                                for v212, v213 in pairs(v103.Config.ManicColorCorrectionProperties) do
                                    if typeof(v213) == "Color3" then
                                        local v214 = {};
                                        for _, v216 in ipairs({
                                            "R", 
                                            "G", 
                                            "B"
                                        }) do
                                            table.insert(v214, v8:Lerp(1, v213[v216], v211));
                                        end;
                                        v103.ManicLighting[v212] = Color3.new(v214[1], v214[2], v214[3]);
                                    else
                                        v103.ManicLighting[v212] = v8:Lerp(0, v213, v211);
                                    end;
                                end;
                                v198 = v210.Value;
                            end;
                            return;
                        end;
                    end);
                end;
            end;
            v11:SetConnection(("%*666ShockwaveHit"):format(v103.Player.Name), "REMOTE_EVENT", function() --[[ Line: 701 ]]
                -- upvalues: v103 (copy), v8 (ref), v14 (ref), l_TweenService_0 (ref), l_RunService_0 (ref), v7 (ref)
                local l_Position_2 = v103.Rig.PrimaryPart.Position;
                local l_CurrentCamera_0 = workspace.CurrentCamera;
                local v219 = 0;
                local function _() --[[ Line: 707 ]] --[[ Name: killTween ]]
                    -- upvalues: v103 (ref)
                    if v103.FocusTween then
                        v103.FocusTween:Pause();
                        v103.FocusTween:Destroy();
                        v103.FocusTween = nil;
                    end;
                end;
                if v103.FocusConnection then
                    v103.FocusConnection:Disconnect();
                    v103.FocusConnection = nil;
                end;
                if v103.FocusTween then
                    v103.FocusTween:Pause();
                    v103.FocusTween:Destroy();
                    v103.FocusTween = nil;
                end;
                v8:ApplyCameraShake(0.35, 0.75);
                local l_v8_FOVMultiplier_0 = v8:CreateFOVMultiplier(v14, 1, "666Shockwave");
                local v222 = l_TweenService_0:Create(l_v8_FOVMultiplier_0, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Value = 0.5
                });
                v222:Play();
                game.Debris:AddItem(l_v8_FOVMultiplier_0, 3);
                task.delay(0.12, function() --[[ Line: 721 ]]
                    -- upvalues: v222 (copy), l_TweenService_0 (ref), l_v8_FOVMultiplier_0 (copy)
                    v222:Pause();
                    l_TweenService_0:Create(l_v8_FOVMultiplier_0, TweenInfo.new(1.2000000000000002, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        Value = 1
                    }):Play();
                end);
                v103.FocusConnection = l_RunService_0.RenderStepped:Connect(function(v223) --[[ Line: 727 ]]
                    -- upvalues: v219 (ref), v103 (ref), l_TweenService_0 (ref), l_CurrentCamera_0 (copy), l_Position_2 (copy)
                    v219 = v219 + v223;
                    if v219 > 0.8 then
                        if v103.FocusTween then
                            v103.FocusTween:Pause();
                            v103.FocusTween:Destroy();
                            v103.FocusTween = nil;
                        end;
                        v103.FocusConnection:Disconnect();
                        return;
                    else
                        if v103.FocusTween then
                            v103.FocusTween:Pause();
                            v103.FocusTween:Destroy();
                            v103.FocusTween = nil;
                        end;
                        v103.FocusTween = l_TweenService_0:Create(l_CurrentCamera_0, TweenInfo.new(math.clamp(v219 / 0.8, 0.1, 1) + 0.2), {
                            CFrame = CFrame.lookAt(l_CurrentCamera_0.CFrame.Position, l_Position_2)
                        });
                        v103.FocusTween:Play();
                        return;
                    end;
                end);
                v7:Play(v103.Config.Sounds.CryHit, {
                    Volume = 0.47, 
                    PlaybackSpeed = Random.new():NextNumber(0.9, 1.1), 
                    Parent = workspace
                });
            end);
            table.insert(v103.ClientConnections, workspace:GetAttributeChangedSignal("BloodHuntActive"):Connect(function() --[[ Line: 744 ]]
                -- upvalues: v8 (ref), v14 (ref), v103 (copy)
                local function _() --[[ Line: 745 ]] --[[ Name: isActive ]]
                    -- upvalues: v8 (ref), v14 (ref), v103 (ref)
                    return v8:IsAlive(v14.Character) and v14.Character.Parent == workspace.Players.Survivors and workspace:GetAttribute("BloodHuntActive") and v103 and v8:IsAlive(v103.Rig);
                end;
                if v8:IsAlive(v14.Character) and v14.Character.Parent == workspace.Players.Survivors and workspace:GetAttribute("BloodHuntActive") and v103 and v8:IsAlive(v103.Rig) then
                    if v14:GetAttribute("HuntVFXActive") then
                        return;
                    else
                        v14:SetAttribute("HuntVFXActive", true);
                        task.spawn(v103.Behavior.StartBloodHuntVFX, v103);
                        while task.wait() and v8:IsAlive(v14.Character) and v14.Character.Parent == workspace.Players.Survivors and workspace:GetAttribute("BloodHuntActive") and v103 and v8:IsAlive(v103.Rig) do

                        end;
                        v14:SetAttribute("HuntVFXActive", nil);
                        if v103 and v103.Behavior and v103.Behavior.EndBloodHuntVFX then
                            task.spawn(v103.Behavior.EndBloodHuntVFX, v103);
                        end;
                    end;
                end;
            end));
        end;
        return;
    end;
end;
v1.Destroyed = function(_, v226) --[[ Line: 768 ]] --[[ Name: Destroyed ]]
    -- upvalues: l_RunService_0 (copy), v11 (copy), v14 (copy)
    if l_RunService_0:IsServer() then
        local v227 = v226.BloodOrbs or {};
        for v228, _ in pairs(v227) do
            v228:Destroy();
        end;
        table.clear(v227);
        v226.BloodOrbs = nil;
        while workspace.Map:FindFirstChild(v226.Player.Name .. "BloodOrbContainer") do
            workspace.Map[v226.Player.Name .. "BloodOrbContainer"]:Destroy();
        end;
        v11:RemoveConnection((("%*666Shockwave"):format(v226.Player.Name)));
        local l_ipairs_0 = ipairs;
        local v231 = v226.ServerConnections or {};
        for _, v233 in l_ipairs_0(v231) do
            v233:Disconnect();
        end;
        return;
    else
        if l_RunService_0:IsClient() then
            local v234 = game.Players.LocalPlayer == v226.Player;
            if v226.Tail and v226.Tail.Destroy then
                v226.Tail:Destroy();
                v226.Tail = nil;
            end;
            if v226.OrbTransparencyConnection then
                v226.OrbTransparencyConnection:Disconnect();
            end;
            if v226.ManicLighting then
                v226.ManicLighting:Destroy();
            end;
            if v226.BloodHuntEffects then
                for _, v236 in ipairs(v226.BloodHuntEffects) do
                    game.Debris:AddItem(v236, 2);
                end;
            end;
            v226.BloodOrbs = nil;
            v11:RemoveConnection(("%*666ShockwaveHit"):format(v226.Player.Name), "REMOTE_EVENT");
            if v234 then
                v11:RemoveConnection("666UI", "REMOTE_EVENT");
                v11:RemoveConnection(("%*666DisplayHeartbeat"):format(v226.Player.Name), "REMOTE_EVENT");
                l_RunService_0:UnbindFromRenderStep("UpdateOrbs");
                v14.CameraMinZoomDistance = 0.5;
                v14.CameraMaxZoomDistance = 12;
            end;
            local l_ipairs_1 = ipairs;
            local v238 = v226.ClientConnections or {};
            for _, v240 in l_ipairs_1(v238) do
                v240:Disconnect();
            end;
            v226.ClientConnections = nil;
            v226.Behavior.EndBloodHuntVFX(v226);
        end;
        return;
    end;
end;
v1.OnExecution = function(_, v242, v243) --[[ Line: 828 ]] --[[ Name: OnExecution ]]
    local v244 = v243.Name == "Noob";
    local _ = v244 and 3.7 or 3;
    local function v247() --[[ Line: 834 ]] --[[ Name: decapitate ]]
        -- upvalues: v243 (copy), v244 (copy)
        local v246 = v243 and v243:FindFirstChild("Torso") and v243:FindFirstChild("Head") and v243.Torso:FindFirstChild("Neck");
        if v246 then
            v246.Enabled = false;
            v243.Head.CollisionGroup = "Ragdolls";
            v243.Head.Velocity = if v244 then Vector3.new(0, -25, 0, 0) else Vector3.new(math.random(-50, 50), 100, math.random(-50, 50));
        end;
    end;
    local v248 = require(game.ReplicatedStorage.Modules.Ragdolls);
    if v244 then
        task.delay(1.53, function() --[[ Line: 847 ]]
            -- upvalues: v242 (copy), v248 (copy), v243 (copy)
            local v249 = (-v242.Rig.PrimaryPart.CFrame.LookVector + Vector3.new(0, 0.5, 0, 0)) * 450;
            v248.AddProfile(v243, {
                AnchorDelay = true, 
                Velocity = v249, 
                Applied = os.clock() + 10
            });
            local l_Humanoid_1 = v243:FindFirstChild("Humanoid");
            if l_Humanoid_1 then
                l_Humanoid_1.BreakJointsOnDeath = false;
                l_Humanoid_1.Health = 0;
            end;
        end);
        task.delay(2.4, v247);
        task.delay(3.22, function() --[[ Line: 857 ]]
            -- upvalues: v243 (copy)
            v243.PrimaryPart.Anchored = false;
        end);
        return;
    else
        v242.Rig:SetAttribute("TailPhysicsEnabled", false);
        delay(3, function() --[[ Line: 862 ]]
            -- upvalues: v242 (copy)
            v242.Rig:SetAttribute("TailPhysicsEnabled", true);
        end);
        local v251 = v242.Rig.PrimaryPart.CFrame.LookVector * -300 + v242.Rig.PrimaryPart.CFrame.RightVector * -60;
        v248.AddProfile(v243, {
            AnchorDelay = true, 
            Velocity = v251, 
            Applied = os.clock() + 10
        });
        task.delay(1.8, function() --[[ Line: 870 ]]
            -- upvalues: v243 (copy), v247 (copy)
            local l_Humanoid_2 = v243:FindFirstChild("Humanoid");
            local l_PrimaryPart_1 = v243.PrimaryPart;
            if l_Humanoid_2 then
                l_Humanoid_2.BreakJointsOnDeath = false;
                l_Humanoid_2.Health = 0;
                v247();
                task.wait(0.65);
                l_PrimaryPart_1.Anchored = false;
                return;
            else
                return;
            end;
        end);
        return;
    end;
end;
v1.OnIntroduction = function(_, _, v256, v257) --[[ Line: 889 ]] --[[ Name: OnIntroduction ]]
    -- upvalues: v8 (copy)
    local _ = v8:CreateFOVMultiplier(game.Players.LocalPlayer, 0.5714285714285714, "JohnDoeIntroScene", v257);
    v256:ScaleTo(1);
end;
v1.OnVictory = function(_, v260, v261, v262, v263) --[[ Line: 895 ]] --[[ Name: OnVictory ]]
    -- upvalues: l_RunService_0 (copy), v8 (copy), l_TweenService_0 (copy)
    local l_Players_0 = game:GetService("Players");
    if v260 == "Start" then
        v262:ScaleTo(1);
        local _ = v261.Config.OutroFrameData;
        local _ = v261.Cache.VictoryKillerTrack;
        local _ = v261.Cache.VictoryCameraTrack;
        local _ = {};
        l_Players_0.LocalPlayer:SetAttribute("FOVMultipliersDisabled", true);
        local v269 = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 914 ]]
            workspace.CurrentCamera.FieldOfView = 25;
        end);
        task.delay(v263, function() --[[ Line: 918 ]]
            -- upvalues: v269 (copy)
            v269:Disconnect();
        end);
        v8:PlayDummyCutsceneAnimations(v261, v263, "Victory");
        task.spawn(function() --[[ Line: 926 ]]
            -- upvalues: l_Players_0 (copy), l_TweenService_0 (ref)
            local function _() --[[ Line: 927 ]] --[[ Name: check ]]
                -- upvalues: l_Players_0 (ref)
                return l_Players_0.LocalPlayer:GetAttribute("FOVMultipliersDisabled");
            end;
            task.wait(1.9166666666666667);
            if not l_Players_0.LocalPlayer:GetAttribute("FOVMultipliersDisabled") then
                return;
            else
                local v271 = Instance.new("ColorCorrectionEffect", game.Lighting);
                v271.Name = "666Effect";
                l_TweenService_0:Create(v271, TweenInfo.new(0.1), {
                    Brightness = 0.12, 
                    Contrast = 0.2
                }):Play();
                task.wait(0.08333333333333333);
                if not l_Players_0.LocalPlayer:GetAttribute("FOVMultipliersDisabled") then
                    return;
                else
                    l_TweenService_0:Create(v271, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Brightness = 0, 
                        Contrast = 0
                    }):Play();
                    task.wait(1);
                    if not l_Players_0.LocalPlayer:GetAttribute("FOVMultipliersDisabled") then
                        return;
                    else
                        l_TweenService_0:Create(v271, TweenInfo.new(0.48333333333333334, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                            Brightness = 0.35, 
                            Contrast = 0.9, 
                            Saturation = -0.5
                        }):Play();
                        task.wait(0.48333333333333334);
                        if not l_Players_0.LocalPlayer:GetAttribute("FOVMultipliersDisabled") then
                            return;
                        else
                            local v272 = {
                                {
                                    Brightness = 1, 
                                    Contrast = 0.4, 
                                    Saturation = 1, 
                                    TintColor = Color3.new(1, 0, 0)
                                }, 
                                {
                                    Brightness = 0.2, 
                                    Contrast = -0.4, 
                                    Saturation = -1
                                }, 
                                {
                                    Brightness = 0.5, 
                                    Contrast = 0.4, 
                                    Saturation = 0.4
                                }, 
                                {
                                    Brightness = -2, 
                                    Contrast = -2, 
                                    Saturation = -1, 
                                    TintColor = Color3.new(1, 1, 1)
                                }
                            };
                            for _, v274 in ipairs(v272) do
                                l_TweenService_0:Create(v271, TweenInfo.new(0.05), v274):Play();
                                task.wait(0.05);
                                if not l_Players_0.LocalPlayer:GetAttribute("FOVMultipliersDisabled") then
                                    return;
                                end;
                            end;
                            return;
                        end;
                    end;
                end;
            end;
        end);
        return;
    else
        if v260 == "End" then
            l_Players_0.LocalPlayer:SetAttribute("FOVMultipliersDisabled", nil);
        end;
        return;
    end;
end;
v1.OnStunnedAbsolute = function(_, v276) --[[ Line: 983 ]] --[[ Name: OnStunnedAbsolute ]]
    -- upvalues: l_RunService_0 (copy), v10 (copy)
    if l_RunService_0:IsClient() then
        return;
    else
        if v276.Hunting then
            v276.HeartbeatBlock = tick();
            v10:ApplyStatus(v276.Rig, "Slowness", {
                Level = 2, 
                Duration = 3
            });
        end;
        return;
    end;
end;
v1.Abilities = {
    ["Carving Slash"] = {
        Name = "Carving Slash", 
		Icon = "rbxassetid://132302791037619", 
        LayoutOrder = 1, 
        KeybindType = "MainAbility", 
        Recharge = 8, 
        Charges = 1, 
        ChargesDisabled = true, 
        Sensitive = true, 
        Cooldown = 2, 
        Callback = function(v277, v278) --[[ Line: 1006 ]] --[[ Name: Callback ]]
            -- upvalues: l_RunService_0 (copy), v7 (copy), v9 (copy), v8 (copy), v11 (copy), l_TweenService_0 (copy), v10 (copy), v12 (copy), v84 (copy)
            local v279 = ("%*666BiteCancel"):format(v277.Player.Name);
            if l_RunService_0:IsServer() then
                local v280 = v277.Behavior.Abilities["Carving Slash"];
                local v281 = false;
                if v280.CurrentCharges > 0 then
                    v281 = v277.Blood >= v277.Config.EviscerateBlood;
                end;
                local v282 = false;
                v277.AbilitiesDisabled = true;
                v277.Cache.SlashNormal:Play();
                task.delay(0.2, function() --[[ Line: 1017 ]]
                    -- upvalues: v7 (ref), v277 (copy)
                    v7:Play(v277.Config.Sounds.Swing, {
                        Parent = v277.Rig.PrimaryPart, 
                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                        Volume = 0.25
                    });
                end);
                task.delay(v277.Config.SlashWindup, function() --[[ Line: 1022 ]]
                    -- upvalues: v9 (ref), v277 (copy), v8 (ref), v7 (ref), v281 (ref)
                    local _ = v9:CreateHitbox(v277.Player, {
                        Size = Vector3.new(5, 7, 7.25, 0), 
                        CFrameOffset = CFrame.new(0, -1, -4.25), 
                        Damage = v277.Config.SlashDamage, 
                        Time = v277.Config.SlashLinger, 
                        Knockback = 2, 
                        HitMultiple = true, 
                        ExecuteOnKill = true, 
                        Connections = {
                            Hit = function(v283, v284) --[[ Line: 1034 ]] --[[ Name: Hit ]]
                                -- upvalues: v8 (ref), v7 (ref), v277 (ref), v281 (ref)
                                v8:CreateSpeedMultiplier(v283, 1.5, "HitSpeedBonus", 1.25);
                                if v284 then
                                    v7:Play(v277.Config.Sounds.Hit, {
                                        Parent = v277.Rig.PrimaryPart, 
                                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                        Volume = 0.25
                                    });
                                end;
                                local v285 = false;
                                local v286 = v277.Highlights[v283];
                                if v286 then
                                    local v287 = tick() - v286[1];
                                    local v288 = v286[2] - v287;
                                    v285 = v286[3];
                                    if v288 > 0.5 then
                                        v277.Behavior.Highlight(v277, v283, v288 / (v285 and 100 or 2));
                                    end;
                                end;
                                if v283:IsDescendantOf(workspace.Players.Survivors) then
                                    v277.Behavior.GiveBlood(v277, v277.Config.SlashBloodOnHit * (v285 and 2 or 1));
                                end;
                                v281 = v277.Blood >= v277.Config.EviscerateBlood;
                            end
                        }
                    });
                end);
                if v281 then
                    local v290 = tick();
                    local function v291() --[[ Line: 1070 ]] --[[ Name: cancel ]]
                        -- upvalues: v282 (ref), v11 (ref), v279 (copy), v277 (copy), v290 (copy)
                        if v282 then
                            return;
                        else
                            v282 = true;
                            v11:RemoveConnection(v279, "REMOTE_EVENT");
                            task.delay(math.clamp(v277.Config.SlashBiteTime - (tick() - v290), 0.02, v277.Config.SlashBiteTime), function() --[[ Line: 1075 ]]
                                -- upvalues: v277 (ref)
                                warn("reset!");
                                v277.AbilitiesDisabled = false;
                            end);
                            return;
                        end;
                    end;
                    v11:SetConnection(v279, "REMOTE_EVENT", function(v292) --[[ Line: 1081 ]]
                        -- upvalues: v277 (copy), v291 (copy)
                        if v292 ~= v277.Player then
                            v292:Kick("no");
                            return;
                        else
                            if v277.BiteThread then
                                pcall(task.cancel, v277.BiteThread);
                                v277.BiteThread = nil;
                            end;
                            v291();
                            return;
                        end;
                    end);
                    if v277.BiteThread then
                        task.cancel(v277.BiteThread);
                        v277.BiteThread = nil;
                    end;
                    v277.BiteThread = task.delay(v277.Config.SlashBiteTime, function() --[[ Line: 1097 ]]
                        -- upvalues: v282 (ref), v277 (copy), v280 (copy), v291 (copy), v11 (ref), v279 (copy), v7 (ref), v8 (ref), l_TweenService_0 (ref), v9 (ref), v10 (ref), v12 (ref), v84 (ref)
                        if v282 or v277.AbilityDisablers.Execution or v277.Blood < v277.Config.EviscerateBlood or v280.CurrentCharges < 1 or not v277.Rig.PrimaryPart then
                            v291();
                            return;
                        else
                            task.delay(v277.Config.SlashBiteTime, function() --[[ Line: 1104 ]]
                                -- upvalues: v277 (ref)
                                v277.AbilitiesDisabled = false;
                            end);
                            v277.Cache.SlashPower:Play(nil, 0.7, nil);
                            v277.Behavior.GiveBlood(v277, -v277.Config.EviscerateBlood);
                            v11:RemoveConnection(v279, "REMOTE_EVENT");
                            task.delay(0.4, function() --[[ Line: 1114 ]]
                                -- upvalues: v7 (ref), v277 (ref)
                                v7:Play(v277.Config.Sounds.Chomp, {
                                    Parent = v277.Rig.PrimaryPart, 
                                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                    Volume = 0.88
                                });
                            end);
                            v277:IncrementCharges("Carving Slash", -1, 1);
                            local l_v8_SpeedMultiplier_0 = v8:CreateSpeedMultiplier(v277.Rig, v277.Config.EviscerateBiteForce, "666EvisLunge", 0.65);
                            l_TweenService_0:Create(l_v8_SpeedMultiplier_0, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                Value = 1
                            }):Play();
                            task.delay(v277.Config.EviscerateWindup, function() --[[ Line: 1125 ]]
                                -- upvalues: v9 (ref), v277 (ref), v8 (ref), v7 (ref), v10 (ref), v12 (ref), v84 (ref), l_TweenService_0 (ref)
                                local v294 = true;
                                local _ = v9:CreateHitbox(v277.Player, {
                                    Size = Vector3.new(7, 6.75, 7, 0), 
                                    CFrameOffset = CFrame.new(0, -1, -4.25), 
                                    Damage = v277.Config.EviscerateDamage, 
                                    Time = v277.Config.EviscerateLinger, 
                                    Knockback = 2, 
                                    HitMultiple = true, 
                                    ExecuteOnKill = false, 
                                    Connections = {
                                        Hit = function(v295) --[[ Line: 1138 ]] --[[ Name: Hit ]]
                                            -- upvalues: v8 (ref), v294 (ref), v277 (ref), v7 (ref), v10 (ref), v12 (ref), v84 (ref)
                                            v8:CreateSpeedMultiplier(v295, 1.65, "HitSpeedBonus", 1.25);
                                            if v294 then
                                                local _, v297 = v277.Behavior.IsHighlighted(v277, v295);
                                                if v297 then
                                                    v277.Behavior.Highlight(v277, v295, 0.1);
                                                end;
                                                v277.Behavior.GiveBlood(v277, v277.Config.EviscerateBloodOnHit * (v297 and 2 or 1));
                                                v7:Play(v277.Config.Sounds.Hit, {
                                                    Parent = v277.Rig.PrimaryPart, 
                                                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                                    Volume = 0.25
                                                });
                                                if v277.Hunting then
                                                    v277:IncrementCharges("Carving Slash", 1, 1);
                                                end;
                                                v277:AddRecharge("Carving Slash", 4);
                                            end;
                                            v294 = false;
                                            if v295:IsDescendantOf(workspace.Players.Survivors) and not v10:PlayerHasStatus(v295, "Hemmorhage") then
                                                v277:SetCooldownOf("Carving Slash", 0.7);
                                                v12:IncrementActorStats(v277.Player, {
                                                    Action = "Hemmorhaged Survivor with Eviscerate", 
                                                    RewardType = "EasyKillerAction"
                                                });
                                                v84(v277, v295);
                                            end;
                                        end
                                    }
                                });
                                task.wait(0.1);
                                local l_v8_SpeedMultiplier_1 = v8:CreateSpeedMultiplier(v277.Rig, 1, "666EvisSlow", 0.7);
                                l_TweenService_0:Create(l_v8_SpeedMultiplier_1, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                    Value = 0.75
                                }):Play();
                                task.wait(0.2);
                                l_TweenService_0:Create(l_v8_SpeedMultiplier_1, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                    Value = 1
                                }):Play();
                            end);
                            return;
                        end;
                    end);
                else
                    task.delay(v277.Config.SlashBiteTime, function() --[[ Line: 1181 ]]
                        -- upvalues: v277 (copy)
                        v277.AbilitiesDisabled = false;
                    end);
                end;
                return v281;
            else
                if l_RunService_0:IsClient() and v278 then
                    local v300 = false;
                    local _ = tick();
                    do
                        local l_v300_0 = v300;
                        local v303 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 1193 ]]
                            -- upvalues: l_v300_0 (ref), v277 (copy), v11 (ref), v279 (copy)
                            if l_v300_0 then
                                return;
                            else
                                if not v277.HeldAbilities["Carving Slash"] then
                                    l_v300_0 = true;
                                    v11:FireServerConnection(v279, "REMOTE_EVENT");
                                end;
                                return;
                            end;
                        end);
                        task.delay(v277.Config.SlashBiteTime, v303.Disconnect, v303);
                    end;
                end;
                return;
            end;
        end
    }, 
    DemonicPursuit = {
        LayoutOrder = 2, 
		Icon = "rbxassetid://116600295653042", 
        KeybindType = "AltAbility1", 
        FlavorText = "[Hold]", 
        Cooldown = 30, 
        Callback = function(v304, _) --[[ Line: 1214 ]] --[[ Name: Callback ]]
            -- upvalues: l_RunService_0 (copy), v8 (copy), v7 (copy), v11 (copy), v9 (copy), v12 (copy), v1 (copy), v84 (copy), l_ReplicatedStorage_0 (copy), v6 (copy), v57 (copy)
            local l_PursuitHold_0 = v304.Config.PursuitHold;
            local v307 = v304.Player.Name .. "666Dash";
            local v308 = v304.Player.Name .. "666Crashed";
            local v309 = RaycastParams.new();
            v309.FilterDescendantsInstances = {
                workspace.Players
            };
            v309.FilterType = Enum.RaycastFilterType.Exclude;
            v309.CollisionGroup = "Killers";
            v309.RespectCanCollide = true;
            if l_RunService_0:IsServer() then
                v304.AbilitiesDisabled = true;
                v304.Rig:SetAttribute("PursuitState", "Charging");
                v304.Rig:SetAttribute("PursuitSpeed", nil);
                task.spawn(function() --[[ Line: 1232 ]]
                    -- upvalues: v304 (copy), v8 (ref), v7 (ref), v11 (ref), v307 (copy), v308 (copy), l_RunService_0 (ref), l_PursuitHold_0 (copy), v9 (ref), v12 (ref), v1 (ref), v309 (copy), v84 (ref), l_ReplicatedStorage_0 (ref)
                    local l_PrimaryPart_2 = v304.Rig.PrimaryPart;
                    local v311 = tick();
                    local v312 = false;
                    local v313 = false;
                    local _ = v304.Rig.Humanoid;
                    local v315 = nil;
                    local v316 = nil;
                    local l_v8_SpeedMultiplier_2 = v8:CreateSpeedMultiplier(v304.Player, 0.01, "666PursuitStart", 5);
                    local v318 = v7:Play(v304.Config.Sounds.DemonicPursuitPrepare, {
                        Parent = l_PrimaryPart_2, 
                        Volume = 1.25
                    });
                    v7:Play(v304.Config.Sounds.DemonicPursuitPrepareWARN, {
                        Parent = v304.Rig.PrimaryPart, 
                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                        Volume = 1.25, 
                        RollOffMaxDistance = 67
                    });
                    v11:SetConnection(v307, "REMOTE_EVENT", function(v319) --[[ Line: 1245 ]]
                        -- upvalues: v304 (ref), v312 (ref)
                        if v319 ~= v304.Player then
                            v319:Kick("no");
                            return;
                        else
                            v312 = true;
                            return;
                        end;
                    end);
                    local v320 = false;
                    v11:SetConnection(v308, "REMOTE_EVENT", function(v321, v322) --[[ Line: 1251 ]]
                        -- upvalues: v304 (ref), v315 (ref), v320 (ref), v7 (ref), l_PrimaryPart_2 (copy)
                        if v321 ~= v304.Player then
                            v321:Kick("no");
                            return;
                        elseif v315 then
                            return;
                        elseif v320 then
                            return;
                        else
                            v320 = true;
                            v7:Play(v304.Config.Sounds[v322], {
                                Parent = l_PrimaryPart_2, 
                                Volume = 0.8
                            });
                            task.delay(0.16, function() --[[ Line: 1260 ]]
                                -- upvalues: v315 (ref), v322 (copy)
                                if not v315 then
                                    v315 = v322;
                                end;
                            end);
                            return;
                        end;
                    end);
                    repeat
                        l_RunService_0.Heartbeat:Wait();
                        v313 = v304.Rig:GetAttribute("Stunned");
                    until v312 and tick() - v311 >= l_PursuitHold_0.Min or tick() - v311 >= l_PursuitHold_0.Max or v313;
                    v11:RemoveConnection(v307, "REMOTE_EVENT");
                    l_v8_SpeedMultiplier_2:Destroy();
                    if v313 then
                        v304.Rig:SetAttribute("PursuitState", "Cancelled");
                        v304.AbilitiesDisabled = false;
                        return;
                    else
                        v304.Rig:SetAttribute("PursuitState", "Dashing");
                        local v323 = math.min(math.ceil(math.clamp(tick() - v311, l_PursuitHold_0.Min, l_PursuitHold_0.Max) / 0.25) * 0.25, l_PursuitHold_0.Max);
                        local v324 = v304.Config.PursuitBaseDamage + (v304.Config.PursuitMaxDamage - v304.Config.PursuitBaseDamage) * (v323 / l_PursuitHold_0.Max);
                        v7:Play(v304.Config.Sounds.DemonicPursuitLunge, {
                            Parent = l_PrimaryPart_2, 
                            PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                            Volume = 0.88
                        });
                        local l_v8_SpeedMultiplier_3 = v8:CreateSpeedMultiplier(v304.Player, 20, "666Pursuit", 99);
                        local v326 = nil;
                        v316 = v9:CreateHitbox(v304.Player, {
                            Size = Vector3.new(7, 14, 7, 0), 
                            CFrameOffset = CFrame.new(0, -3, -2.25), 
                            Damage = 0, 
                            Time = 99, 
                            Knockback = 0, 
                            HitMultiple = true, 
                            Connections = {
                                Hit = function(v327, _) --[[ Line: 1308 ]] --[[ Name: Hit ]]
                                    -- upvalues: v326 (ref), v8 (ref), v316 (ref), v315 (ref), v7 (ref), v304 (ref), l_PrimaryPart_2 (copy), v12 (ref), v1 (ref), v311 (copy), v324 (ref), v309 (ref), v84 (ref), l_ReplicatedStorage_0 (ref), l_RunService_0 (ref), v9 (ref)
                                    if v326 then
                                        return;
                                    elseif not v8:GetEntityType(v327) then
                                        return;
                                    else
                                        if v316 then
                                            v316:Cancel();
                                        end;
                                        v326 = v327;
                                        v315 = "Hit";
                                        v7:Play(v304.Config.Sounds.Hit, {
                                            Parent = l_PrimaryPart_2, 
                                            Volume = 0.8
                                        });
                                        v12:IncrementActorStats(v304.Player, {
                                            Action = "Landed Demonic Pursuit", 
                                            RewardType = "RegularKillerAction"
                                        });
                                        local l_Cooldown_0 = v1.Abilities.DemonicPursuit.Cooldown;
                                        local v330 = 0;
                                        for _, v332 in pairs(v304.Highlights) do
                                            if tick() - v332[1] <= v332[2] then
                                                v330 = v330 + v304.Config.PursuitCooldownReductionPerHighlight;
                                            end;
                                        end;
                                        v304:SetCooldownOf("DemonicPursuit", (math.clamp(l_Cooldown_0 - (tick() - v311) - v330, 2, l_Cooldown_0)));
                                        if v304.Hunting then
                                            local l_Humanoid_4 = v327:FindFirstChild("Humanoid");
                                            if l_Humanoid_4 then
                                                local v334 = l_Humanoid_4:GetAttribute("HardDamage") or 0;
                                                v324 = v324 + math.floor(v334 * v304.Config.PursuitHardDamageBonus);
                                            else
                                                local v335 = tostring(v327) .. " had no Humanoid??";
                                                warn("[G666]:", v335);
                                            end;
                                        end;
                                        local l_v304_Pivot_0 = v304:GetPivot();
                                        local l_Position_3 = l_v304_Pivot_0.Position;
                                        local v338 = workspace:Spherecast(l_v304_Pivot_0.Position, 1, Vector3.new(0, -25, 0, 0), v309);
                                        warn(v338);
                                        local v339 = v338 and v338.Position + Vector3.new(0, 5.206999778747559, 0, 0) or l_Position_3;
                                        v304:PivotTo(CFrame.new(v339));
                                        v84(v304, v327);
                                        v304.Rig.PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0, 0);
                                        require(l_ReplicatedStorage_0.Modules.Ragdolls).AddProfile(v326, {
                                            AnchorDelay = true, 
                                            Applied = os.clock() + 4
                                        });
                                        v8:GiveInvincible(v304.Rig, "DemonicPursuit");
                                        v8:SetUpCutscene(v304.Rig, v326, CFrame.new(0, 1.8, 0), "DemonicPursuit");
                                        local v340 = v8:LoadAnimationFromID(v326, v304.Config.Animations.DemonicPursuitCutscene.Victim, true);
                                        v340:Play(0.05);
                                        v340.Priority = Enum.AnimationPriority.Action4;
                                        v304.Cache.PursuitCutscene.Priority = Enum.AnimationPriority.Action4;
                                        v304.Cache.PursuitCutscene:Play(0);
                                        v304.Cache.PursuitCutscene.TimePosition = v340.TimePosition;
                                        v7:Play(v304.Config.Sounds.DemonicPursuitCutscene, {
                                            Parent = v304.Rig.PrimaryPart, 
                                            PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                            Volume = 0.88
                                        });
                                        task.delay(2.55, function() --[[ Line: 1373 ]]
                                            v304.Behavior.EmitVFX(v304, "SoftRoarEmit");
                                            v304.Behavior.EmitVFX(v304, "SoftRoarEnable");
                                        end);
                                        local v341 = {
                                            [35] = {
                                                Damage = v324 / 5, 
                                                Orb = true
                                            }, 
                                            [53] = {
                                                Damage = v324 / 5, 
                                                Orb = true
                                            }, 
                                            [73] = {
                                                Damage = v324 / 5, 
                                                Orb = true
                                            }, 
                                            [95] = {
                                                Damage = v324 / 5, 
                                                Orb = true
                                            }, 
                                            [122] = {
                                                Damage = v324 / 5, 
                                                Smack = true
                                            }
                                        };
                                        local _, v343 = v304.Behavior.IsHighlighted(v304, v327);
                                        if v343 then
                                            v304.Behavior.Highlight(v304, v327, 0.1);
                                        end;
                                        local v344 = false;
                                        local v345 = nil;
                                        v345 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 1395 ]]
                                            -- upvalues: v341 (copy), v304 (ref), v9 (ref), v327 (copy), v326 (ref), v340 (copy), v8 (ref), v344 (ref), v343 (copy), v345 (ref)
                                            for v346, v347 in pairs(v341) do
                                                if v304.Cache.PursuitCutscene.TimePosition >= v346 / 60 then
                                                    v9:CreateHitbox(v304.Player, {
                                                        Size = Vector3.new(5, 6, 5, 0), 
                                                        CFrame = (v327 and v327.PrimaryPart and v327.PrimaryPart.CFrame or v304.Rig.PrimaryPart.CFrame) * CFrame.new(0, 0, -2) - Vector3.new(0, 2, 0, 0), 
                                                        Damage = v347.Damage, 
                                                        Time = 0.1, 
                                                        Knockback = 0, 
                                                        HitMultiple = true
                                                    });
                                                    if v347.Smack and v326 then
														v340:Stop(0);
                                                        local l_Unit_2 = (-v304.Rig.PrimaryPart.CFrame.RightVector + v304.Rig.PrimaryPart.CFrame.LookVector / 3).Unit;
														v304.Rig.PrimaryPart.Anchored = false
                                                        v8:RagdollLaunch(v304, v326, (l_Unit_2 + Vector3.new(0, 0.30000001192092896, 0, 0)) * 125);
                                                    elseif v347.Orb then
                                                        local v349 = v344 and "L" or "R";
                                                        v344 = not v344;
                                                        v304.Behavior.EmitVFX(v304, "GroundMark" .. v349);
                                                        v304.Behavior.EmitVFX(v304, "Slash" .. v349);
                                                        v304.Behavior.GiveBlood(v304, 5 * (v343 and 2 or 1));
                                                    end;
                                                    v341[v346] = nil;
                                                end;
                                            end;
                                            if (not v326 or not v326.Parent or not v304.Cache.PursuitCutscene.IsPlaying) and v345 then
                                                v345:Disconnect();
                                                v345 = nil;
                                            end;
                                            task.delay(5, function() --[[ Line: 1435 ]]
                                                -- upvalues: v345 (ref)
                                                if v345 then
                                                    v345:Disconnect();
                                                    v345 = nil;
                                                end;
                                            end);
                                        end);
                                        return;
                                    end;
                                end
                            }
                        });
                        while v8:IsAlive(v304.Rig) and not v315 do
                            l_RunService_0.Heartbeat:Wait();
                        end;
                        if not v8:IsAlive(v304.Rig) then
                            return;
                        else
                            if v316 then
                                v316:Cancel();
                            end;
                            local v350 = v304.Config[("Pursuit%*Endlag"):format(v315)] or v304.Config.PursuitEndlag;
                            if v315 == "Hit" then
                                v350 = v350 + (v304.Cache.PursuitCutscene.Length + 0.2);
                            end;
                            v11:RemoveConnection(v308, "REMOTE_EVENT");
                            v304.Rig:SetAttribute("PursuitState", nil);
                            v8:CreateSpeedMultiplier(v304.Player, 0.5, "666Pursuit", v350 - 0.2, true);
                            l_v8_SpeedMultiplier_3:Destroy();
                            task.wait(v350);
                            v304.AbilitiesDisabled = false;
                            if v315 == "Hit" then
                                v304.Rig.PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0, 0);
                                --v8:ToggleAnchored(v304.Rig, "DemonicPursuit", false);
                                v8:RemoveInvincible(v304.Rig, "DemonicPursuit");
                            end;
                            return;
                        end;
                    end;
                end);
                return;
            else
                if l_RunService_0:IsClient() then
                    v11:FireConnection("DisableSprinting", "666Pursuit", true);
                    v304.Rig:SetAttribute("FootstepsMuted", true);
                    v304.Animations.DemonicPursuitStart:Play(0.1);
                    v304.Animations.DemonicPursuitLoop:Play(0.12);
                    task.spawn(function() --[[ Line: 1492 ]]
                        -- upvalues: v304 (copy), v6 (ref), l_RunService_0 (ref), l_PursuitHold_0 (copy), v57 (ref), v309 (copy), v11 (ref), v307 (copy), v308 (copy), v8 (ref)
                        local v351 = workspace.Gravity * v304.Config.PursuitGravity;
                        local v352 = false;
                        local l_PrimaryPart_3 = v304.Rig.PrimaryPart;
                        local l_Humanoid_5 = v304.Rig.Humanoid;
                        local l_CurrentCamera_1 = workspace.CurrentCamera;
                        local l_PursuitMinAngle_0 = v304.Config.PursuitMinAngle;
                        local l_PursuitHorizontalPenalty_0 = v304.Config.PursuitHorizontalPenalty;
                        local v358 = {};
                        local v359 = {};
                        for _, v361 in ipairs(v304.Rig:GetDescendants()) do
                            if (v361:IsA("BasePart") or v361:IsA("Decal")) and v361.Transparency < 0.9 then
                                table.insert(v358, v361);
                            elseif (v361:IsA("ParticleEmitter") or v361:IsA("Beam")) and v361.Enabled then
                                table.insert(v359, v361);
                                v361.Enabled = false;
                            end;
                        end;
                        local v362 = Instance.new("Beam", workspace);
                        local v363 = Instance.new("Attachment", workspace.Terrain);
                        local v364 = Instance.new("Attachment", workspace.Terrain);
                        v362.Attachment0 = v363;
                        v362.Attachment1 = v364;
                        v362.Segments = 40;
                        v362.Width0 = 1.2;
                        v362.Width1 = 0.35;
                        v362.Transparency = NumberSequence.new({
                            NumberSequenceKeypoint.new(0, 1), 
                            NumberSequenceKeypoint.new(0.5, 0), 
                            NumberSequenceKeypoint.new(1, 0)
                        });
                        v362.LightInfluence = 0;
                        v362.Brightness = 10;
                        v362.Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), 
                            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 0, 0)), 
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
                        });
                        v362.ZOffset = 2;
                        local v365 = v304.Config.PursuitLandVFX:Clone();
                        v365.Parent = v364;
                        v364.Visible = true;
                        local v366 = 0;
                        local l_Unit_3 = (l_CurrentCamera_1.CFrame.LookVector * Vector3.new(1, 0, 1, 0)).Unit;
                        local v368 = 0;
                        local v369 = math.clamp((math.deg((vector.angle(Vector3.new(-0, -1, -0, -0), l_CurrentCamera_1.CFrame.LookVector))) - 90) * 1.1, 0, 80);
                        local v370 = tick();
                        if v369 < l_PursuitMinAngle_0 then
                            v369 = 0;
                        end;
                        local v371 = v368 * (v369 / 90);
                        local v372 = v368 * ((90 - math.min(v369 * l_PursuitHorizontalPenalty_0, 80)) / 90);
                        local v373 = 0;
                        v6.StaminaCap = v6.Stamina;
                        l_RunService_0:BindToRenderStep("666PursuitPrepare", Enum.RenderPriority.Character.Value + 1, function() --[[ Line: 1548 ]]
                            -- upvalues: v370 (copy), v373 (ref), l_CurrentCamera_1 (copy), l_Humanoid_5 (copy), l_Unit_3 (ref), v368 (ref), v304 (ref), l_PursuitHold_0 (ref), v369 (ref), l_PursuitMinAngle_0 (copy), v371 (ref), v372 (ref), l_PursuitHorizontalPenalty_0 (copy), v362 (copy), v363 (copy), v364 (copy), v365 (copy), v57 (ref), v351 (copy), v309 (ref), v366 (ref), v358 (copy)
                            local v374 = tick() - v370;
                            local v375 = v374 - v373;
                            local v376 = vector.normalize(l_CurrentCamera_1.CFrame.LookVector * Vector3.new(1, 0, 1, 0));
                            if v376 ~= v376 or not l_Humanoid_5 then
                                return;
                            else
                                l_Humanoid_5:Move(v376);
                                l_Unit_3 = (l_CurrentCamera_1.CFrame.LookVector * Vector3.new(1, 0, 1, 0)).Unit;
                                v368 = (v304.Config.PursuitBaseSpeed + (v304.Config.PursuitMaxSpeed - v304.Config.PursuitBaseSpeed) * (v374 / l_PursuitHold_0.Max)) * v304.Config.Speed;
                                v369 = math.clamp((math.deg((vector.angle(Vector3.new(-0, -1, -0, -0), l_CurrentCamera_1.CFrame.LookVector))) - 90) * 1.1, 0, 80);
                                if v369 < l_PursuitMinAngle_0 then
                                    v369 = 0;
                                end;
                                v371 = v368 * (v369 / 90);
                                v372 = v368 * ((90 - math.min(v369 * l_PursuitHorizontalPenalty_0, 80)) / 90);
                                local v377 = Vector3.new(0, 1, 0, 0) * (v304.Rig.CollisionHitbox.Size.Y / 1.6);
                                if v369 == 0 then
                                    local l_CFrame_0 = v304.Rig.PrimaryPart.CFrame;
                                    local v379 = CFrame.new(l_CFrame_0.Position, l_CFrame_0.Position + l_Unit_3) * CFrame.new(0, 0, -(v368 * v304.Config.PursuitLength)) - v377;
                                    local v380 = 0;
                                    local v381 = 0;
                                    local v382 = v304.Rig.PrimaryPart.CFrame - v377;
                                    v362.CurveSize0 = v380;
                                    v362.CurveSize1 = v381;
                                    v363.CFrame = v363.Parent.CFrame:inverse() * v382 * CFrame.Angles(0, 0, 1.5707963267948966);
                                    v364.CFrame = v364.Parent.CFrame:inverse() * v379 * CFrame.Angles(0, 0, 1.5707963267948966);
                                    v365.Enabled = false;
                                else
                                    local _, v384, v385, v386, v387 = v57(Vector3.new(0, 1, 0, 0) * -v351, l_Unit_3 * v372 + Vector3.new(0, 1, 0, 0) * v371, v304.Rig.PrimaryPart.Position, v309);
                                    v362.CurveSize0 = v384;
                                    v362.CurveSize1 = v385;
                                    v363.CFrame = v363.Parent.CFrame:inverse() * v386;
                                    v364.CFrame = v364.Parent.CFrame:inverse() * v387;
                                    v365.Enabled = true;
                                end;
                                if v366 < 0.92 then
                                    local v388 = v375 * 4;
                                    v388 = v388 + math.min(0.92 - (v366 + v388), 0);
                                    for _, v390 in ipairs(v358) do
                                        v390.Transparency = v390.Transparency + v388;
                                    end;
                                    v366 = v366 + v388;
                                end;
                                v373 = v374;
                                return;
                            end;
                        end);
                        while l_RunService_0.Heartbeat:Wait() do
                            if not v304.HeldAbilities.DemonicPursuit and not v352 then
                                v352 = true;
                                v11:FireServerConnection(v307, "REMOTE_EVENT");
                            elseif v304.Rig:GetAttribute("PursuitState") ~= "Charging" then
                                break;
                            end;
                        end;
                        for _, v392 in ipairs(v358) do
                            v392.Transparency = v392.Transparency - v366;
                        end;
                        for _, v394 in ipairs(v359) do
                            v394.Enabled = true;
                        end;
                        l_RunService_0:UnbindFromRenderStep("666PursuitPrepare");
                        v362:Destroy();
                        v364:Destroy();
                        v363:Destroy();
                        v304.Animations.DemonicPursuitStart:Stop(0);
                        v304.Animations.DemonicPursuitLoop:Stop(0);
                        if v304.Rig:GetAttribute("PursuitState") == "Cancelled" then
                            v11:FireConnection("DisableSprinting", "666Pursuit", false);
                            v304.Rig:SetAttribute("FootstepsMuted", false);
                            return;
                        else
                            local v395 = false;
                            local function _() --[[ Line: 1645 ]] --[[ Name: stop ]]
                                -- upvalues: v395 (ref), v11 (ref), v304 (ref), l_RunService_0 (ref), v6 (ref)
                                if v395 then
                                    return;
                                else
                                    v395 = true;
                                    v11:FireConnection("DisableSprinting", "666Pursuit", false);
                                    v304.Rig:SetAttribute("FootstepsMuted", nil);
                                    l_RunService_0:UnbindFromRenderStep("666PursuitCharge");
                                    v6.StaminaCap = nil;
                                    return;
                                end;
                            end;
                            local v397 = tick();
                            local v398 = tick();
                            local v399 = l_Unit_3 * v372 + Vector3.new(0, 1, 0, 0) * v371;
                            local l_v399_0 = v399;
                            local v401 = false;
                            l_RunService_0:BindToRenderStep("666PursuitCharge", Enum.RenderPriority.Character.Value + 1, function() --[[ Line: 1662 ]]
                                -- upvalues: l_Humanoid_5 (copy), l_PrimaryPart_3 (copy), v395 (ref), v11 (ref), v304 (ref), l_RunService_0 (ref), v6 (ref), v398 (ref), v399 (ref), l_Unit_3 (ref), v372 (ref), v371 (ref), v351 (copy), v397 (copy), v401 (ref), v308 (ref), v309 (ref), l_v399_0 (ref)
                                if not l_Humanoid_5 or not l_PrimaryPart_3 or l_PrimaryPart_3.Anchored then
                                    if v395 then
                                        return;
                                    else
                                        v395 = true;
                                        v11:FireConnection("DisableSprinting", "666Pursuit", false);
                                        v304.Rig:SetAttribute("FootstepsMuted", nil);
                                        l_RunService_0:UnbindFromRenderStep("666PursuitCharge");
                                        v6.StaminaCap = nil;
                                        return;
                                    end;
                                else
                                    local v402 = tick() - v398;
                                    v304.Rig.PrimaryPart.AssemblyLinearVelocity = v399;
                                    v399 = l_Unit_3 * v372 + Vector3.new(0, 1, 0, 0) * math.max(v371 - v351 * v402, -workspace.Gravity * 2);
                                    if l_Humanoid_5.FloorMaterial ~= Enum.Material.Air then
                                        local v403 = tick() - v397;
                                        v398 = tick();
                                        if v304.Config.PursuitLength < v403 and not v401 then
                                            v401 = true;
                                            v11:FireServerConnection(v308, "REMOTE_EVENT", v399.Y < -4 and "Landed" or "Slide");
                                            v371 = 0;
                                        elseif v403 > 0.15 then
                                            v371 = 0;
                                        end;
                                    end;
                                    local v404 = workspace:Raycast(l_PrimaryPart_3.Position, v399.Unit * 11, v309);
                                    if v404 and v404.Normal:Dot((Vector3.new(0, 1, 0, 0))) < 0.2 and not v401 then
                                        v401 = true;
                                        v11:FireServerConnection(v308, "REMOTE_EVENT", "Crashed");
                                    end;
                                    l_v399_0 = v399;
                                    return;
                                end;
                            end);
                            v304.Animations.DemonicPursuitLunge:Play(0);
                            while v304.Rig:GetAttribute("PursuitState") do
                                l_RunService_0.RenderStepped:Wait();
                            end;
                            local _ = v8:CreateSpeedMultiplier(v304.Player, 0.01, "666PursuitEndlag", v304.Config.PursuitEndlag, true);
                            v8:CreateSpeedMultiplier(v304.Player, v372, "666PursuitDampening", 0.1);
                            if not v395 then
                                v395 = true;
                                v11:FireConnection("DisableSprinting", "666Pursuit", false);
                                v304.Rig:SetAttribute("FootstepsMuted", nil);
                                l_RunService_0:UnbindFromRenderStep("666PursuitCharge");
                                v6.StaminaCap = nil;
                            end;
                            return;
                        end;
                    end);
                end;
                return;
            end;
        end
    }, 
    InfernalCry = {
        LayoutOrder = 3, 
		Icon = "rbxassetid://127517579891302", 
        KeybindType = "AltAbility2", 
        Cooldown = 20, 
        Callback = function(v406, v407) --[[ Line: 1717 ]] --[[ Name: Callback ]]
            -- upvalues: l_RunService_0 (copy), v7 (copy), v11 (copy), v8 (copy)
            local l_Config_1 = v406.Config;
            local l_CryWindup_0 = l_Config_1.CryWindup;
            local l_CryEndlag_0 = l_Config_1.CryEndlag;
            if l_RunService_0:IsServer() then
                local l_Humanoid_6 = v406.Rig.Humanoid;
                local v412 = Instance.new("Attachment", v406.Rig.PrimaryPart);
                local v413 = v406.Config.CryLooker:Clone();
                v413.Attachment0 = v412;
                v413.CFrame = v406.Rig.PrimaryPart.CFrame;
                v413.Parent = v406.Rig.PrimaryPart;
                l_Humanoid_6.AutoRotate = false;
                v406.AbilitiesDisabled = true;
                task.delay(l_CryWindup_0, function() --[[ Line: 1734 ]]
                    -- upvalues: v412 (copy), v413 (copy), l_Humanoid_6 (copy), l_CryEndlag_0 (copy), v406 (copy)
                    v412:Destroy();
                    v413:Destroy();
                    l_Humanoid_6.AutoRotate = true;
                    task.wait(l_CryEndlag_0);
                    v406.AbilitiesDisabled = false;
                end);
                v406.ShockwaveBuffer = v406.ShockwaveBuffer + 1;
                v7:Play(l_Config_1.Sounds.CryWindup, {
                    Parent = v406.Rig.PrimaryPart, 
                    RollOffMaxDistance = 80
                });
                return v413;
            else
                if l_RunService_0:IsClient() then
                    v11:FireConnection("DisableSprinting", "INFERNALCRY", true);
                    local function v415() --[[ Line: 1750 ]] --[[ Name: getMouse ]]
                        -- upvalues: v406 (copy), v8 (ref)
                        local _ = (v406.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -20)).Position;
                        if v406.Player:GetAttribute("Device") == "Mobile" then
                            return v8:GetPlayerMousePosition(v406.Player, true);
                        else
                            return v8:GetPlayerMousePosition(v406.Player, false);
                        end;
                    end;
                    task.spawn(function() --[[ Line: 1760 ]]
                        -- upvalues: v407 (copy), l_CryWindup_0 (copy), v8 (ref), v406 (copy), v415 (copy), l_RunService_0 (ref)
                        local v416 = tick();
                        while v407 and tick() - v416 <= l_CryWindup_0 and v8:IsAlive(v406 and v406.Rig) do
                            local v417 = (v415() - v406.Rig.PrimaryPart.Position) * Vector3.new(1, 0, 1, 0).Unit;
                            if v417 == v417 then
                                v407.CFrame = CFrame.new(v406.Rig.PrimaryPart.Position, v406.Rig.PrimaryPart.Position + v417);
                                l_RunService_0.RenderStepped:Wait();
                            end;
                        end;
                    end);
                    v406.Animations.Cry:Play(nil, 0.8, nil);
                    task.delay(0.7, function() --[[ Line: 1774 ]]
                        -- upvalues: v8 (ref), v11 (ref)
                        v8:ApplyCameraShake(0.8, 0.6);
                        v11:FireConnection("DisableSprinting", "INFERNALCRY", false);
                    end);
                    task.delay(l_CryWindup_0, function() --[[ Line: 1779 ]]
                        -- upvalues: v11 (ref), v406 (copy), v415 (copy)
                        v11:FireServerConnection(("%*666Shockwave"):format(v406.Player.Name), "REMOTE_EVENT", (v415() - v406.Rig.PrimaryPart.Position).Unit);
                    end);
                end;
                return;
            end;
        end
    }, 
    BloodHunt = {
        LayoutOrder = 4, 
        Name = "Blood Hunt", 
		Icon = "rbxassetid://135474270073880", 
        KeybindType = "AltAbility3", 
        Cooldown = 30, 
        Callback = function(v418, v419) --[[ Line: 1792 ]] --[[ Name: Callback ]]
            -- upvalues: l_RunService_0 (copy), v12 (copy), v7 (copy), v11 (copy), v8 (copy)
            if l_RunService_0:IsServer() then
                if v418.Blood == v418.MaxBlood and not v418.Hunting then
                    v12:IncrementActorStats(v418.Player, {
                        Action = "Activated Blood Hunt", 
                        RewardType = "EasyKillerAction"
                    });
                    v418.Rig:SetAttribute("Invincible", true);
                    v7:Play(v418.Config.Sounds.BloodHunt, {
                        Parent = v418.Rig.PrimaryPart, 
                        Volume = 0.56, 
                        RollOffMaxDistance = 300
                    });
                    v418.AbilitiesDisabled = true;
                    v418.DisabledAbilities = {
                        BloodHunt = true
                    };
                    task.delay(v418.Config.BloodHuntWindup, function() --[[ Line: 1803 ]]
                        -- upvalues: v418 (copy), v11 (ref)
                        if not v418 or not v418.BloodOrbs then
                            return;
                        else
                            v418.Behavior.EmitVFX(v418, "RoarEnable");
                            v418.Behavior.EmitVFX(v418, "RoarEmit");
                            for _, v421 in ipairs(game.Players:GetPlayers()) do
                                if v421 ~= v418.Player then
                                    local v422 = v421.Character and v421.Character.PrimaryPart and v421.Character.PrimaryPart.Position;
                                    local v423 = v422 and (v418.Rig.PrimaryPart.Position - v422).Magnitude;
                                    if v423 and v423 < 75 then
                                        v11:FireClientConnection(v421, "ApplyCameraShake", "REMOTE_EVENT", math.clamp(75 - v423, 0, 75) / 75 * 0.8, 1.8);
                                    end;
                                end;
                            end;
                            v418.Behavior.StartBloodHunt(v418);
                            task.wait(v418.Config.BloodHuntEndlag);
                            if not v418 or not v418.BloodOrbs then
                                return;
                            else
                                v418.Rig:SetAttribute("Invincible", false);
                                v418.AbilitiesDisabled = false;
                                return;
                            end;
                        end;
                    end);
                    return true;
                else
                    v418.BloodCooldownData = nil;
                    v418.AbilitiesDisabled = true;
                    task.delay(v418.Config.EcholocationWindup + v418.Config.EcholocationEndlag, function() --[[ Line: 1836 ]]
                        -- upvalues: v418 (copy)
                        v418.AbilitiesDisabled = false;
                    end);
                    task.delay(v418.Config.EcholocationWindup, function() --[[ Line: 1840 ]]
                        -- upvalues: v8 (ref), v418 (copy)
                        for _, v425 in ipairs(workspace.Players.Survivors:GetChildren()) do
                            if v8:IsAlive(v425) then
                                local v426 = vector.magnitude(v425.PrimaryPart.Position - v418.Rig.PrimaryPart.Position);
                                local l_Config_2 = v418.Config;
                                local l_EcholocationDistance_0 = l_Config_2.EcholocationDistance;
                                local l_EcholocationDuration_0 = l_Config_2.EcholocationDuration;
                                local v430 = l_EcholocationDistance_0.Max - l_EcholocationDistance_0.Min;
                                local v431 = math.clamp(v426, l_EcholocationDistance_0.Min, l_EcholocationDistance_0.Max) - l_EcholocationDistance_0.Min;
                                local v432 = l_EcholocationDuration_0.Min + (l_EcholocationDuration_0.Max - l_EcholocationDuration_0.Min) * (v431 / v430);
                                v418.Behavior.Highlight(v418, v425, v432);
                                v418.Highlights[v425][3] = true;
                            end;
                        end;
                    end);
                    v7:Play(v418.Config.Sounds.Echolocation, {
                        Parent = v418.Rig.PrimaryPart, 
                        Volume = 0.56, 
                        RollOffMaxDistance = 100
                    });
                    return false;
                end;
            else
                if l_RunService_0:IsClient() then
                    if v419 then
                        v418.Animations.BloodHuntActivate:Play(0.175);
                        v8:ApplyCameraShake(0.1, 1.61);
                        local _ = v8:CreateSpeedMultiplier(v418.Player, 0, "666BloodHuntStart", v418.Config.BloodHuntWindup + v418.Config.BloodHuntEndlag - 0.3, true);
                        if not v8:GetSettingValue("EpilepsyMode") then
                            local l_ColorCorrectionEffect_0 = Instance.new("ColorCorrectionEffect");
                            l_ColorCorrectionEffect_0.Parent = game.Lighting;
                            l_ColorCorrectionEffect_0.Name = "GuestRoar";
                            l_ColorCorrectionEffect_0.Brightness = 0;
                            l_ColorCorrectionEffect_0.Contrast = 0;
                            l_ColorCorrectionEffect_0.Saturation = 0;
                            l_ColorCorrectionEffect_0.TintColor = Color3.fromRGB(255, 255, 255);
                            l_ColorCorrectionEffect_0.Enabled = true;
                            game:GetService("Debris"):AddItem(l_ColorCorrectionEffect_0, 4);
                            game.TweenService:Create(l_ColorCorrectionEffect_0, TweenInfo.new(1.61, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                TintColor = Color3.new(1, 0.737255, 0.737255)
                            }):Play();
                            game.TweenService:Create(l_ColorCorrectionEffect_0, TweenInfo.new(1.61, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                Contrast = 0.1
                            }):Play();
                            game.TweenService:Create(l_ColorCorrectionEffect_0, TweenInfo.new(1.61, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                Saturation = 0.2
                            }):Play();
                            local l_v8_FOVMultiplier_2 = v8:CreateFOVMultiplier(v418.Player, 1, "Roaring");
                            game.TweenService:Create(l_v8_FOVMultiplier_2, TweenInfo.new(1.61, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                Value = 0.875
                            }):Play();
                            game:GetService("Debris"):AddItem(l_v8_FOVMultiplier_2, 4);
                            task.delay(1.61, function() --[[ Line: 1893 ]]
                                -- upvalues: l_v8_FOVMultiplier_2 (copy), l_ColorCorrectionEffect_0 (copy)
                                game.TweenService:Create(l_v8_FOVMultiplier_2, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 9), {
                                    Value = 1.1
                                }):Play();
                                game.TweenService:Create(l_ColorCorrectionEffect_0, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                                    TintColor = Color3.new(1, 0.184314, 0.184314)
                                }):Play();
                                game.TweenService:Create(l_ColorCorrectionEffect_0, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                    Contrast = 0.5
                                }):Play();
                                game.TweenService:Create(l_ColorCorrectionEffect_0, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                    Saturation = 1
                                }):Play();
                            end);
                            task.delay(2.6, function() --[[ Line: 1901 ]]
                                -- upvalues: l_ColorCorrectionEffect_0 (copy), l_v8_FOVMultiplier_2 (copy)
                                game.TweenService:Create(l_ColorCorrectionEffect_0, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                    Contrast = 0
                                }):Play();
                                game.TweenService:Create(l_ColorCorrectionEffect_0, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                    Saturation = 0
                                }):Play();
                                game.TweenService:Create(l_v8_FOVMultiplier_2, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                    Value = 1
                                }):Play();
                                game.TweenService:Create(l_ColorCorrectionEffect_0, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                    TintColor = Color3.new(1, 1, 1)
                                }):Play();
                            end);
                        end;
                        task.delay(1.61, function() --[[ Line: 1909 ]]
                            -- upvalues: v8 (ref)
                            v8:ApplyCameraShake(1, 1.5);
                        end);
                        return;
                    else
                        local _ = v8:CreateSpeedMultiplier(v418.Player, 0, "666BloodHuntStart", v418.Config.BloodHuntWindup + v418.Config.BloodHuntEndlag - 0.3, true);
                        v418.Animations.EcholocationActivate:Play(0.175);
                    end;
                end;
                return;
            end;
        end
    }
};
v1.DisplayHeartbeat = function(v437, v438, v439) --[[ Line: 1923 ]] --[[ Name: DisplayHeartbeat ]]
    -- upvalues: l_RunService_0 (copy), l_TweenService_0 (copy)
    assert(l_RunService_0:IsClient(), "Attempted to display heartbeat on server");
    while v438:FindFirstChild("HeartbeatHighlight") do
        v438.HeartbeatHighlight:Destroy();
    end;
    local l_PrimaryPart_4 = v438.PrimaryPart;
    local v441 = math.clamp(vector.magnitude(v437.Rig.PrimaryPart.Position - l_PrimaryPart_4.Position) / 45 + 0.5, 0.5, 3);
    local v442 = Instance.new("Highlight", v438);
    v442.Name = "HeartbeatHighlight";
    v442.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
    v442.FillTransparency = 0;
    v442.FillColor = if v439 then Color3.new(1, 0.482353, 0.482353) else Color3.new(0.568627, 0, 0);
    v442.OutlineTransparency = 0;
    v442.OutlineColor = if v439 then Color3.new(1, 0.309804, 0.309804) else Color3.new(0, 0, 0);
    l_TweenService_0:Create(v442, TweenInfo.new(v441, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
        FillTransparency = 1
    }):Play();
    l_TweenService_0:Create(v442, TweenInfo.new(v441 * 1.65, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
        OutlineTransparency = 1
    }):Play();
    game.Debris:AddItem(v442, v441 + 1);
end;
v1.EmitVFX = function(v443, v444) --[[ Line: 1950 ]] --[[ Name: EmitVFX ]]
    -- upvalues: v8 (copy)
    assert(v443, "must pass killerInfo as argument");
    local v445 = v443.VFX and v443.VFX[v444];
    if v445 then
        v8:EmitParticles(v445);
        return;
    else
        warn((("Particle %* not found"):format(v444)));
        return;
    end;
end;
v1.StartBloodHuntVFX = function(v446) --[[ Line: 1963 ]] --[[ Name: StartBloodHuntVFX ]]
    -- upvalues: v14 (copy), l_TweenService_0 (copy), v7 (copy), l_RunService_0 (copy), v8 (copy), v20 (copy)
    assert(v446, "must pass killerInfo as argument");
    assert(v446.Behavior.EndBloodHuntVFX, "StartBloodHuntVFX must have a pairing disable method");
    if v446.BloodHuntVFX then
        return;
    else
        v446.BloodHuntVFX = {};
        local l_PlayerGui_0 = v14.PlayerGui;
        local v448 = Instance.new("ColorCorrectionEffect", game.Lighting);
        local function _() --[[ Line: 1974 ]] --[[ Name: guard ]]
            -- upvalues: v446 (copy), v448 (copy)
            return not (v446 and v446.BloodHuntVFX and v446.BloodHuntVFX.ColorCorrection == v448 and v448.Parent);
        end;
        local v450 = l_TweenService_0:Create(v448, TweenInfo.new(1.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Saturation = -1, 
            Brightness = 0.3, 
            Contrast = 0.5, 
            TintColor = Color3.new(1, 0.5, 0.5)
        });
        local v451 = l_TweenService_0:Create(v448, TweenInfo.new(0.65, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Brightness = -0.1, 
            Saturation = -0.6, 
            Contrast = 0.3, 
            TintColor = Color3.new(0.737255, 0.294118, 0.294118)
        });
        local v452 = l_TweenService_0:Create(v448, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Brightness = 0.06, 
            Saturation = -0.55, 
            Contrast = 0.2, 
            TintColor = Color3.new(1, 0.101961, 0.101961)
        });
        local v453 = l_TweenService_0:Create(v448, TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Brightness = 0, 
            Saturation = 0, 
            Contrast = 0, 
            TintColor = Color3.new(1, 1, 1)
        });
        local v454 = {};
        local l_Atmosphere_0 = game.Lighting:FindFirstChildOfClass("Atmosphere");
        if not l_Atmosphere_0 then
            l_Atmosphere_0 = Instance.new("Atmosphere", game.Lighting);
            l_Atmosphere_0:SetAttribute("Artificial", true);
        end;
        for v456, _ in pairs(v446.Config.BloodHuntAtmosphere) do
            v454[v456] = l_Atmosphere_0[v456];
        end;
        local v458 = l_TweenService_0:Create(l_Atmosphere_0, TweenInfo.new(1.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), v446.Config.BloodHuntAtmosphere);
        local v459 = l_TweenService_0:Create(l_Atmosphere_0, TweenInfo.new(1.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), v454);
        local l_Sounds_0 = v446.Config.Sounds;
        for _, v462 in ipairs({
            l_Sounds_0.AmbBloodHuntStart
        }) do
            v7:Play(v462);
        end;
        v458:Play();
        v450:Play();
        v446.BloodHuntVFX.Connections = {};
        v446.BloodHuntVFX.Instances = {};
        v446.BloodHuntVFX.Tweens = {
            Garbage = {
                v450, 
                v451, 
                v452, 
                v458
            }, 
            Reversal = {
                v459, 
                v453
            }
        };
        v446.BloodHuntVFX.ColorCorrection = v448;
        v446.BloodHuntVFX.Fog = l_Atmosphere_0;
        task.wait(1.8);
        if not (v446 and v446.BloodHuntVFX and v446.BloodHuntVFX.ColorCorrection == v448 and v448.Parent) then
            return;
        else
            local l_AmbBloodHuntTheme_0 = l_Sounds_0.AmbBloodHuntTheme;
            v7:PlayTheme(l_AmbBloodHuntTheme_0.ID, {
                Priority = 3, 
                Name = ("%*BloodHunt"):format(v446.Player.Name), 
                Volume = l_AmbBloodHuntTheme_0.Volume, 
                PlaybackRegionsEnabled = l_AmbBloodHuntTheme_0.LoopRegion, 
                LoopRegion = l_AmbBloodHuntTheme_0.LoopRegion, 
                Looped = true
            });
            local v464 = Instance.new("ColorCorrectionEffect", game.Lighting);
            local v465 = v446.Config.BloodHuntVisuals.Survivor.SurvivorSpotlight:Clone();
            local v466 = v446.Config.BloodHuntVignette.VignetteA:Clone();
            local v467 = v446.Config.BloodHuntVignette.VignetteB:Clone();
            v446.BloodHuntVFX.Instances.Vignettes = {
                v466, 
                v467, 
                v464, 
                v465
            };
            v466.Parent = l_PlayerGui_0.TemporaryUI;
            v467.Parent = l_PlayerGui_0.TemporaryUI;
            local v468 = nil;
            local v469 = nil;
            local v470 = 1;
            v446.BloodHuntVFX.Connections.Heartbeat = l_RunService_0.Heartbeat:Connect(function(v471) --[[ Line: 2058 ]]
                -- upvalues: v8 (ref), v446 (copy), v14 (ref), v468 (ref), v464 (copy), v466 (copy), v467 (copy), v470 (ref), v20 (ref), l_Sounds_0 (copy), v469 (ref), v7 (ref)
                if not v8:IsAlive(v446.Rig) or not v8:IsAlive(v14.Character) then
                    return;
                else
                    if v468 then
                        local l_PlaybackLoudness_0 = v468.PlaybackLoudness;
                        v464.Brightness = -math.clamp(l_PlaybackLoudness_0 / 15000, 0, 1);
                        v464.Contrast = math.clamp(l_PlaybackLoudness_0 / 15000, 0, 1);
                        local v473 = 1.3 - math.clamp(l_PlaybackLoudness_0 / 15000 * 3, 0, 0.15);
                        v466.Size = UDim2.fromScale(v473, v473);
                        v467.Size = UDim2.fromScale(v473, v473);
                    end;
                    v470 = v470 + v471;
                    local v474 = vector.magnitude(v446.Rig.PrimaryPart.Position - v14.Character.PrimaryPart.Position) < 40;
                    local v475 = 60 / (v474 and v20(l_Sounds_0.TerrorRadiusThemes) or l_Sounds_0.AmbBloodHuntTheme).BPM;
                    if v469 ~= v475 then
                        v469 = v475;
                        v470 = 0;
                        return;
                    else
                        v469 = v475;
                        if v470 < v475 then
                            return;
                        else
                            v470 = v470 - v475;
                            v468 = v7:Play(v474 and l_Sounds_0.AmbBloodHuntHeartbeatFast or l_Sounds_0.AmbBloodHuntHeartbeatSlow);
                            return;
                        end;
                    end;
                end;
            end);
            v7:Play(l_Sounds_0.AmbBloodHuntBell);
            v450:Pause();
            v448.Brightness = 1;
            v448.Saturation = 3;
            v448.TintColor = Color3.new(0.7, 0, 0);
            v465.Parent = v14.Character.PrimaryPart;
            v451:Play();
            task.wait(1.2);
            if not (v446 and v446.BloodHuntVFX and v446.BloodHuntVFX.ColorCorrection == v448 and v448.Parent) then
                return;
            else
                v451:Pause();
                v452:Play();
                return;
            end;
        end;
    end;
end;
v1.EndBloodHuntVFX = function(v476) --[[ Line: 2106 ]] --[[ Name: EndBloodHuntVFX ]]
    -- upvalues: v7 (copy), v8 (copy)
    assert(v476, "must pass killerInfo as argument");
    if not v476.BloodHuntVFX then
        return;
    else
        if v476.BloodHuntVFX.ColorCorrection then
            game.Debris:AddItem(v476.BloodHuntVFX.ColorCorrection, 1);
        end;
        if v476.BloodHuntVFX.Fog and v476.BloodHuntVFX.Fog:GetAttribute("Artificial") then
            game.Debris:AddItem(v476.BloodHuntVFX.Fog, 1);
        end;
        v7:StopTheme(v476.Player.Name .. "BloodHunt", 0.4, true);
        for _, v478 in pairs(v476.BloodHuntVFX.Connections) do
            v478:Disconnect();
        end;
        for _, v480 in pairs(v476.BloodHuntVFX.Tweens.Reversal) do
            v480:Play();
        end;
        for _, v482 in pairs(v476.BloodHuntVFX.Tweens.Garbage) do
            v482:Pause();
        end;
        v8:RecursiveDestroy(v476.BloodHuntVFX.Instances);
        table.clear(v476.BloodHuntVFX);
        v476.BloodHuntVFX = nil;
        return;
    end;
end;
v1.DelocalizeBloodOrb = function(_, v484) --[[ Line: 2147 ]] --[[ Name: DelocalizeBloodOrb ]]
    for _, v486 in ipairs(v484:GetDescendants()) do
        if v486:IsA("Trail") or v486:IsA("Beam") or v486:IsA("ParticleEmitter") then
            v486.Enabled = false;
        elseif v486:IsA("Decal") or v486:IsA("Texture") then
            v486.Transparency = 0.8;
        elseif v486:IsA("BasePart") then
            v486.LocalTransparencyModifier = 0.8;
        end;
    end;
end;
v1.ToggleOrbVisibility = function(_, v488, v489) --[[ Line: 2160 ]] --[[ Name: ToggleOrbVisibility ]]
    v488.Transparency = v489 and 0 or 1;
    v488.Innards.Transparency = v489 and 0 or 1;
    v488.Innards.Aura.Enabled = v489;
    v488.Innards.ParticleAttachment.Ring.Enabled = false;
end;
if l_RunService_0:IsClient() then
    return v1;
else
    v1.OnKill = function(v490, _) --[[ Line: 2173 ]] --[[ Name: OnKill ]]
        -- upvalues: v12 (copy)
        v490.Behavior.GiveBlood(v490, v490.Config.BloodOnKill);
        if v490.Hunting then
            v490:SetCooldownOf("Carving Slash", 0);
            v490:IncrementCharges("Carving Slash", 1, 1);
            v490:SetCooldownOf("DemonicPursuit", 0);
            v490:SetCooldownOf("InfernalCry", 0);
            v490:SetCooldownOf("BloodHunt", 0);
            v490.HuntKills = (v490.HuntKills or 0) + 1;
            local v492 = v490.Config.BloodHuntKillIncrease * 0.75 ^ (v490.HuntKills - 1);
            v490.RemainingHuntTime = v490.RemainingHuntTime + v492;
            v12:IncrementActorStats(v490.Player, {
                Action = "Killed Survivor during Blood Hunt", 
                RewardType = "EasyKillerAction"
            });
        end;
    end;
    v1.StartBloodHunt = function(v493) --[[ Line: 2193 ]] --[[ Name: StartBloodHunt ]]
        -- upvalues: v8 (copy), v79 (copy), l_RunService_0 (copy), v11 (copy), v10 (copy), v7 (copy)
        if v493.Hunting then
            return;
        else
            v493.RemainingHuntTime = v493.Config.BloodHuntDuration;
            local l_PrimaryPart_5 = v493.Rig.PrimaryPart;
            v493.Hunting = true;
            v493.HuntDrainMultipliers = {};
            v493.HuntingThread = task.spawn(function() --[[ Line: 2202 ]]
                -- upvalues: v493 (copy), v8 (ref), l_PrimaryPart_5 (copy), v79 (ref), l_RunService_0 (ref), v11 (ref), v10 (ref)
                local function _() --[[ Line: 2203 ]] --[[ Name: guard ]]
                    -- upvalues: v493 (ref), v8 (ref), l_PrimaryPart_5 (ref)
                    if v493 and v493.Hunting and v8:IsAlive(v493.Rig) and l_PrimaryPart_5 and l_PrimaryPart_5.Parent and v493.RemainingHuntTime > 0 then
                        return true;
                    else
                        return false;
                    end;
                end;
                v493.Rig:SetAttribute("TerrorMultiplier", v493.Config.BloodHuntTerror);
                v493.Rig:SetAttribute("BloodHuntDuration", v493.RemainingHuntTime);
                v493.Rig:SetAttribute("BloodHuntTimer", v493.RemainingHuntTime);
                v8:GiveStackableAttribute(workspace, "BloodHuntActive", v493.Player.Name);
                v79(v493, "START");
                local v496 = {};
                while if v493 and v493.Hunting and v8:IsAlive(v493.Rig) and l_PrimaryPart_5 and l_PrimaryPart_5.Parent then v493.RemainingHuntTime > 0 else false do
                    local v497 = l_RunService_0.Heartbeat:Wait();
                    if if v493 and v493.Hunting and v8:IsAlive(v493.Rig) and l_PrimaryPart_5 and l_PrimaryPart_5.Parent then v493.RemainingHuntTime > 0 else false then
                        local v498 = 1;
                        for _, v500 in ipairs(v493.HuntDrainMultipliers) do
                            if v500 and typeof(v500) == "number" then
                                v498 = v498 * v500;
                            end;
                        end;
                        for v501, v502 in pairs(v493.Chases) do
                            if v502 and v501 then
                                v498 = v498 / 2;
                                break;
                            end;
                        end;
                        v493.RemainingHuntTime = math.clamp(v493.RemainingHuntTime - v497 * v498, 0, v493.Config.BloodHuntDuration);
                        v493.Rig:SetAttribute("StunnedDisabled", true);
                        if not v493.HeartbeatBlock or tick() - v493.HeartbeatBlock >= 5 then
                            for _, v504 in ipairs(workspace.Players.Survivors:GetChildren()) do
                                if v8:IsAlive(v504) then
                                    v496[v504] = v496[v504] or 0;
                                    v496[v504] = v496[v504] + v497;
                                    if math.clamp(vector.magnitude(v504.PrimaryPart.Position - v493.Rig.PrimaryPart.Position) / 30, 0.5, 5) <= v496[v504] then
                                        v496[v504] = 0;
                                        v11:FireClientConnection(v493.Player, ("%*666DisplayHeartbeat"):format(v493.Player.Name), "REMOTE_EVENT", v504, v10:PlayerHasStatus(v504, "Hemmorhage") and true or false);
                                    end;
                                end;
                            end;
                        end;
                        v493.Rig:SetAttribute("BloodHuntTimer", v493.RemainingHuntTime);
                    else
                        break;
                    end;
                end;
                if v493 and v493.Behavior then
                    v493.Behavior.EndBloodHunt(v493);
                end;
            end);
            v493:SetCooldownOf("Carving Slash", 0);
            v493:IncrementCharges("Carving Slash", 1, 1);
            v493:SetCooldownOf("DemonicPursuit", 0);
            v493:SetCooldownOf("InfernalCry", 0);
            v493:SetCooldownOf("BloodHunt", 0);
            v8:CreateSpeedMultiplier(v493.Rig, v493.Config.BloodHuntSpeedBoost, "666BloodHunt");
            v7:Play(v493.Config.Sounds.BloodHuntStart, {
                Parent = v493.Rig.PrimaryPart, 
                RollOffMaxDistance = 600, 
                Volume = 0.6
            });
            v493.BloodHuntLoopSound = v7:Play(v493.Config.Sounds.BloodHuntLoop, {
                Parent = v493.Rig.PrimaryPart, 
                RollOffMaxDistance = 35, 
                Looped = true, 
                Volume = 0.3
            });
            return;
        end;
    end;
    v1.EndBloodHunt = function(v505) --[[ Line: 2278 ]] --[[ Name: EndBloodHunt ]]
        -- upvalues: v8 (copy), v7 (copy), v79 (copy)
        if not v505.Hunting then
            return;
        else
            v8:RemoveStackableAttribute(workspace, "BloodHuntActive", v505.Player.Name);
            v505.HuntKills = nil;
            v505.RemainingHuntTime = 0;
            v505.Hunting = false;
            if v505.BloodHuntLoopSound then
                v505.BloodHuntLoopSound:Destroy();
                v505.BloodHuntLoopSound = nil;
            end;
            v505.MaxBlood = v505.MaxBlood + v505.Config.BloodHuntIncrease;
            v505.Behavior.GiveBlood(v505, -v505.MaxBlood);
            v505.HeartbeatBlock = nil;
            v505.Rig:SetAttribute("StunnedDisabled", nil);
            v7:Play(v505.Config.Sounds.BloodHuntEnd, {
                Parent = v505.Rig.PrimaryPart, 
                RollOffMaxDistance = 50
            });
            v79(v505, "END");
            task.delay(3, function() --[[ Line: 2302 ]]
                -- upvalues: v505 (copy)
                v505.DisabledAbilities = nil;
            end);
            v8:CreateSpeedMultiplier(v505.Rig, v505.Config.BloodHuntSpeedBoost, "666BloodHunt", 0.05, true);
            v505.Rig:SetAttribute("TerrorMultiplier", nil);
            return;
        end;
    end;
    v1.FireShockwave = function(v506, v507) --[[ Line: 2312 ]] --[[ Name: FireShockwave ]]
        -- upvalues: v7 (copy), l_TweenService_0 (copy), v9 (copy), v10 (copy), v89 (copy), v11 (copy), v12 (copy)
        local l_Rig_2 = v506.Rig;
        local l_PrimaryPart_6 = l_Rig_2.PrimaryPart;
        local l_Config_3 = v506.Config;
        local l_CryShockwaveSize_0 = l_Config_3.CryShockwaveSize;
        local v512 = v506.Hunting and l_Config_3.CryHuntingSize or 1;
        local l_CryShockwaveDuration_0 = l_Config_3.CryShockwaveDuration;
        local l_CryShockwaveDistance_0 = l_Config_3.CryShockwaveDistance;
        local v515 = l_Config_3.CrySlownessDuration + (v506.Hunting and 2 or 0);
        if not l_Rig_2 or not l_PrimaryPart_6 or not v507 then
            return;
        elseif l_Rig_2:GetAttribute("Stunned") then
            return;
        else
            v506.Behavior.EmitVFX(v506, "RoarEnable");
            v506.Behavior.EmitVFX(v506, "RoarEmit");
            v7:Play(l_Config_3.Sounds.CryShockwave, {
                Parent = l_PrimaryPart_6, 
                RollOffMaxDistance = 80
            });
            if v507 ~= v507 then
                v507 = Vector3.new(0, 1, 0, 0);
            end;
            local v516 = CFrame.lookAt(l_PrimaryPart_6.Position, l_PrimaryPart_6.Position + v507);
            local v517 = l_Config_3.CryShockwaveTemplate:Clone();
            v517.Anchored = true;
            v517.Size = Vector3.new(l_CryShockwaveSize_0.Min, l_CryShockwaveSize_0.Min, 3) * v512;
            v517.CFrame = v516;
            v517.Name = ("%*666Shockwave"):format(v506.Player.Name);
            v517.Parent = workspace.Map.Ingame;
            l_TweenService_0:Create(v517, TweenInfo.new(l_CryShockwaveDuration_0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = Vector3.new(l_CryShockwaveSize_0.Max, l_CryShockwaveSize_0.Max, 1) * v512, 
                CFrame = v516 * CFrame.new(0, 0, -l_CryShockwaveDistance_0)
            }):Play();
            game.Debris:AddItem(v517, l_CryShockwaveDuration_0);
            local _ = v9:CreateHitbox(v506.Player, {
                Size = function() --[[ Line: 2354 ]] --[[ Name: Size ]]
                    -- upvalues: v517 (copy)
                    return v517.Size;
                end, 
                CFrame = function() --[[ Line: 2355 ]] --[[ Name: CFrame ]]
                    -- upvalues: v517 (copy)
                    return v517.CFrame;
                end, 
                Damage = v506.Hunting and v506.Config.CryHuntingDamage or v506.Config.CryDamage, 
                Time = l_CryShockwaveDuration_0, 
                HitMultiple = true, 
                IsProjectile = true, 
                DeathProfile = {
                    Velocity = (v507 + Vector3.new(0, 0.20000000298023224, 0, 0)) * 700
                }, 
                Connections = {
                    Hit = function(v518, _) --[[ Line: 2365 ]] --[[ Name: Hit ]]
                        -- upvalues: v10 (ref), l_Config_3 (copy), v515 (copy), v512 (copy), v89 (ref), l_Rig_2 (copy), v506 (copy), v11 (ref), v12 (ref)
                        local l_PlayerFromCharacter_0 = game.Players:GetPlayerFromCharacter(v518);
                        v10:ApplyStatus(v518, "Blindness", {
                            Level = l_Config_3.CrySlowness, 
                            Duration = v515
                        });
                        if v512 ~= 1 and v518:IsDescendantOf(workspace.Players.Survivors) then
                            v89(l_Rig_2, v506.Config.CryHuntSelfStatuses);
                        end;
                        v506.Behavior.Highlight(v506, v518, l_Config_3.CryHighlightDuration);
                        if l_PlayerFromCharacter_0 then
                            v11:FireClientConnection(l_PlayerFromCharacter_0, ("%*666ShockwaveHit"):format(v506.Player.Name), "REMOTE_EVENT");
                        end;
                        if not v518:IsDescendantOf(workspace.Players.Survivors) then
                            return;
                        elseif v10:PlayerHasStatus(v518, "Hemmorhage") then
                            for _ = 1, v506.Config.CryOrbDrop do
                                v506.Behavior.SpawnBloodOrb(v506, v518.PrimaryPart.Position + Vector3.new(math.random(-1.5, 1.5), math.random(-1.5, 1.5), math.random(-1.5, 1.5)), v518);
                            end;
                            v12:IncrementActorStats(v506.Player, {
                                Action = "Hit Hemmorhaged Survivor with Infernal Cry", 
                                RewardType = "EasyKillerAction"
                            });
                            return;
                        else
                            v12:IncrementActorStats(v506.Player, {
                                Action = "Hit Survivor with Infernal Cry", 
                                RewardType = "EasyKillerAction"
                            });
                            return;
                        end;
                    end
                }
            });
            return;
        end;
    end;
    v1.SpawnBloodOrb = function(v523, v524, v525) --[[ Line: 2399 ]] --[[ Name: SpawnBloodOrb ]]
        if not v523 or not v523.Behavior or not v523.BloodContainer or not v523.BloodContainer.Parent or not v523.BloodOrbs then
            return;
        else
            local v526 = v523.Config.BloodOrbTemplate:Clone();
            v526.Parent = v523.BloodContainer;
            v526.CFrame = CFrame.new(v524);
            v526.Anchored = false;
            v526:SetNetworkOwner(v523.Player);
            for _, v528 in ipairs(v526:GetDescendants()) do
                if v528:IsA("BasePart") then
                    v528.Anchored = false;
                    v528:SetNetworkOwner(v523.Player);
                end;
            end;
            local v529 = Instance.new("Attachment", v526);
            local v530 = Instance.new("AlignPosition", v526);
            v530.Mode = Enum.PositionAlignmentMode.OneAttachment;
            v530.MaxForce = 1e999;
            v530.Responsiveness = 200;
            v530.MaxVelocity = 0;
            v530.Position = v526.Position;
            v530.Attachment0 = v529;
            v523.BloodOrbs[v526] = {
                Character = v525, 
                Spawned = tick()
            };
            v526:AddTag((("%*BloodOrb"):format(v523.Player.Name)));
            return;
        end;
    end;
    v1.GiveBlood = function(v531, v532) --[[ Line: 2434 ]] --[[ Name: GiveBlood ]]
        -- upvalues: v79 (copy)
        if math.clamp(v531.Blood + v532, 0, v531.MaxBlood) == v531.LastBlood then
            return;
        else
            v531.Blood = math.clamp(v531.Blood + v532, 0, v531.MaxBlood);
            local v533 = false;
            if v531.Blood == v531.MaxBlood then
                v533 = not v531.Hunting;
            end;
            if v533 then
                v531.BloodCooldownData = {
                    v531:IsOnCooldown("BloodHunt") or 0, 
                    tick()
                };
                v531:SetCooldownOf("BloodHunt", 0);
            elseif not v533 and v531.BloodCooldownData then
                local v534 = tick() - v531.BloodCooldownData[2];
                v531:SetCooldownOf("BloodHunt", (math.max(v531.BloodCooldownData[1] - v534, 0)));
                v531.BloodCooldownData = nil;
            end;
            v79(v531, "BLOOD", v531.Blood, v531.MaxBlood);
            v531.LastBlood = v531.Blood;
            return;
        end;
    end;
    v1.CollectOrb = function(v535, v536) --[[ Line: 2457 ]] --[[ Name: CollectOrb ]]
        -- upvalues: v7 (copy), v8 (copy)
        local v537 = v535.BloodOrbs or {};
        v535.Behavior.GiveBlood(v535, v535.Config.BloodOrbGive);
        v7:Play(v535.Config.Sounds.BloodOrbCollect, {
            Parent = v535.Rig.PrimaryPart
        });
        local v538 = v537[v536];
        if v538 and v8:IsAlive(v538.Character) then
            local v539 = v535.Behavior.IsHighlighted(v535, v538.Character);
            if not v539 or v539 < v535.Config.BloodOrbHighlightDuration then
                v535.Behavior.Highlight(v535, v538.Character, v535.Config.BloodOrbHighlightDuration);
            end;
        end;
        for v540, _ in pairs(v535.Behavior.Abilities) do
            local v542 = v535:IsOnCooldown(v540);
            if v542 then
                v535:SetCooldownOf(v540, (math.max(v542 - v535.Config.BloodOrbCooldownReduction, 0)));
            end;
        end;
        v537[v536] = nil;
        v536:Destroy();
    end;
    v1.Highlight = function(v543, v544, v545) --[[ Line: 2491 ]] --[[ Name: Highlight ]]
        -- upvalues: v8 (copy)
        v545 = v545 or 10;
        v544 = typeof(v544) == "table" and v544.Rig or v544;
        v8:RevealPlayerAuraTo(v543.Player, v544, v545, v543.Config.HighlightColor or Color3.new(0.9, 0, 0));
        v544:AddTag(v543.Player.Name .. "666Highlight");
        v543.Highlights[v544] = {
            tick(), 
            v545
        };
    end;
    v1.IsHighlighted = function(v546, v547) --[[ Line: 2500 ]] --[[ Name: IsHighlighted ]]
        v547 = typeof(v547) == "table" and v547.Rig or v547;
        local v548 = v546.Highlights and v546.Highlights[v547];
        local v549 = v548 and v548[3];
        return v548 and tick() - v548[1] <= v548[2], v549;
    end;
    return v1;
end;