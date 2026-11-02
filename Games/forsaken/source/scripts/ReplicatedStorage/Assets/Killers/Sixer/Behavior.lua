-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

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
local v2 = game:GetService("RunService");
local v3 = game:GetService("CollectionService");
local v4 = game:GetService("ReplicatedStorage");
local v5 = game:GetService("TweenService");
local v6 = game:GetService("ServerScriptService");
local v7 = require(v4.Systems.Character.Game.Sprinting);
local v8 = require(v4.Modules.Sounds);
local v9 = require(v4.Modules.Util);
local v10 = require(v4.Modules.Hitboxes);
local v11 = require(v4.Modules.Statuses);
local v12 = require(v4.Modules.Network);
local v13 = require(v4.Modules.Actors);
local v14 = require(v4.Modules.Schematics.Lighting);
local v15 = v2:IsClient() and game.Players.LocalPlayer;
if v2:IsClient() then
    local v16 = v15.PlayerData;
end;
local function v22(v17) --[[ Line: 28 ]] --[[ Name: getLowestIndexValue ]]
    local v18 = 1e999;
    local v19 = nil;
    for v20, v21 in pairs(v17) do
        assert(typeof(v20) == "number", "Passed dictionary must contain numeric keys only");
        if v20 < v18 then
            v18 = v20;
            v19 = v21;
        end;
    end;
    return v19;
end;
local function v41(v23, v24, v25, v26) --[[ Line: 43 ]] --[[ Name: beamProjectile ]]
    local v27 = v26 ^ 2;
    local v28 = v24 * v26;
    local v29 = 0.5 * v23 * v27 + v28 + v25;
    local v30 = v29 - (v23 * v27 + v28) / 3;
    local v31 = (0.125 * v23 * v27 + 0.5 * v28 + v25 - 0.125 * (v25 + v29)) / 0.375 - v30;
    local v32 = (v31 - v25).magnitude;
    local v33 = (v30 - v29).magnitude;
    local v34 = (v25 - v29).unit;
    local v35 = (v31 - v25).unit;
    local v36 = v35:Cross(v34).unit;
    local v37 = (v30 - v29).unit;
    local v38 = v37:Cross(v34).unit;
    v34 = v36:Cross(v35).unit;
    local v39 = CFrame.new(v25.x, v25.y, v25.z, v35.x, v36.x, v34.x, v35.y, v36.y, v34.y, v35.z, v36.z, v34.z);
    local v40 = CFrame.new(v29.x, v29.y, v29.z, v37.x, v38.x, v34.x, v37.y, v38.y, v34.y, v37.z, v38.z, v34.z);
    return v32, -v33, v39, v40;
end;
local function v56(v42, v43, v44, v45) --[[ Line: 83 ]] --[[ Name: getTrajectoryPoints ]]
    -- upvalues: v41 (copy)
    local v46 = {};
    local v47 = v44;
    local v48 = nil;
    local v49 = 5;
    for v50 = 0.05, 5, 0.05 do
        local v51 = v50 ^ 2;
        local v52 = v43 * v50;
        local v53 = 0.5 * v42 * v51 + v52 + v44;
        local v54 = vector.create(v53.x, v53.y, v53.z);
        local v55 = v54 - v47;
        v48 = workspace:Raycast(v47, v55, v45);
        if v48 then
            v49 = v50 - 0.05 + (v48.Position - v47).Magnitude / v55.Magnitude * 0.05;
            table.insert(v46, v48.Position);
            break;
        else
            table.insert(v46, v54);
            v47 = v54;
        end;
    end;
    return v46, v41(v42, v43, v44, v49);
end;
local function v58(v57) --[[ Line: 117 ]] --[[ Name: __warn ]]
    warn("[G666]:", v57);
end;
local function v63(v59) --[[ Line: 121 ]] --[[ Name: getMass ]]
    assert(v59 and v59:IsA("Model"), "Model argument of getMass must be a model");
    local v60 = 0;
    for v61, v62 in pairs(v59:GetDescendants()) do
        if v62:IsA("BasePart") then
            v60 = v60 + v62:GetMass();
        end;
    end;
    return v60;
end;
local function v67(v64, v65, v66) --[[ Line: 135 ]] --[[ Name: reward ]]
    -- upvalues: v13 (copy)
    v13:IncrementActorStats(v64.Player, {
        Action = v66, 
        RewardType = v65 .. "KillerAction"
    });
end;
local function v71(v68, v69, v70) --[[ Line: 142 ]] --[[ Name: changeProp ]]
    if v68[v69] ~= v70 then
        v68[v69] = v70;
    end;
end;
local function v75(v72, v73, v74) --[[ Line: 148 ]] --[[ Name: alphaSequence ]]
    v72 = math.clamp(v72, 0, 1);
    if v72 <= 0.001 then
        return ColorSequence.new(v74);
    elseif v72 >= 0.999 then
        return ColorSequence.new(v73);
    else
        return (ColorSequence.new({
            ColorSequenceKeypoint.new(0, v73), 
            ColorSequenceKeypoint.new(v72, v73), 
            ColorSequenceKeypoint.new(v72 + 0.001, v74), 
            ColorSequenceKeypoint.new(1, v74)
        }));
    end;
end;
local function v78(v76, v77, ...) --[[ Line: 167 ]] --[[ Name: updateUI ]]
    -- upvalues: v12 (copy)
    v12:FireClientConnection(v76.Player, "666UI", "REMOTE_EVENT", v77, ...);
end;
local function v83(v79, v80) --[[ Line: 171 ]] --[[ Name: applyHemmorhage ]]
    -- upvalues: v11 (copy)
    if v11:PlayerHasStatus(v80, "Slateskin") then
        return;
    else
        local v81 = v11:PlayerHasStatus(v80, "Hemmorhage");
        local v82 = math.clamp((v81 and v81.Level or 0) + 1, 1, 3);
        v11:ApplyStatus(v80, "Hemmorhage", {
            Killer = v79, 
            Level = v82, 
            Duration = 120
        });
        return;
    end;
end;
local function v88(v84, v85) --[[ Line: 179 ]] --[[ Name: __applyStatusesFromDict ]]
    -- upvalues: v11 (copy)
    for v86, v87 in pairs(v85) do
        v11:ApplyStatus(v84, v86, v87);
    end;
end;
local function v90() --[[ Line: 185 ]] --[[ Name: isLMS ]]
    -- upvalues: v2 (copy), v6 (copy)
    if v2:IsClient() then
        return false;
    else
        local v89 = require(v6.Server.Systems.Core.RoundManager);
        if v89 and v89.CurrentSession and v89.CurrentSession.LastSurvivorAlive then
            return true;
        else
            return false;
        end;
    end;
end;
v1.CreateVFX = function(v91, v92) --[[ Line: 192 ]] --[[ Name: CreateVFX ]]
    local v93 = {};
    local v94 = v92.Config;
    local v95 = v92.Rig;
    local v96 = script.BaseVFX;
    local v97 = v94.VFXFolder;
    for v98, v99 in ipairs(v96:GetChildren()) do
        local v100 = if v97 and v97:FindFirstChild(v99.Name) then v97[v99.Name] else v99;
        local v101 = v100:GetAttribute("Adornee") or "HumanoidRootPart";
        if v95:FindFirstChild(v101) then
            local v102 = v100:Clone();
            v102.Parent = v95[v101];
            v93[v99.Name] = v102;
        else
            warn((("[G666/CreateVFX]: Could not create VFX attachment for %* as Adornee %* does not exist"):format(v99.Name, v101)));
        end;
    end;
    return v93;
end;
v1.LastManStanding = function(v103, v104, v105) --[[ Line: 232 ]] --[[ Name: LastManStanding ]]
    -- upvalues: v78 (copy)
    if not game["Run Service"]:IsServer() then
        return;
    else
        v104.Rig:SetAttribute("NoBloodHunt", true);
        v78(v104, "BLOOD", v104.Blood, v104.MaxBlood);
        if v104.RemainingHuntTime and v104.Hunting then
            v104.Config.BloodHuntKillIncrease = 0;
            v104.RemainingHuntTime = v104.Config.BloodHuntLMSTime;
        end;
        return;
    end;
end;
v1.Created = function(v106, v107) --[[ Line: 249 ]] --[[ Name: Created ]]
    -- upvalues: v2 (copy), v4 (copy), v9 (copy), v12 (copy), v15 (copy), v3 (copy), v5 (copy), v1 (copy), v75 (copy), v0 (copy), v8 (copy)
    v107.Blood = v107.Config.BloodStartCount;
    v107.MaxBlood = v107.Config.BloodStartMax;
    if v2:IsServer() then
        assert(v107.Config.BloodOrbTemplate:IsA("BasePart"), "Blood orb must be a BasePart.");
        v107:SetCooldownOf("DemonicPursuit", v107.Config.PursuitInitialCooldown);
        v107:SetCooldownOf("BloodHunt", v107.Config.BloodHuntInitialCooldown);
        local v108 = {};
        local v109 = {};
        local v110 = {};
        local v111 = v107.Rig;
        local v112 = Instance.new("Model", workspace.Map);
        v112.Name = v107.Player.Name .. "BloodOrbContainer";
        local v113 = v4.Assets.Instances.Nothingburger:Clone();
        v113.Parent = v112;
        v113.Name = "IExist";
        v107.VFX = v107.Behavior:CreateVFX(v107);
        v107.ServerConnections = {};
        v107.Hunting = false;
        v107.RemainingHuntTime = 0;
        v107.BloodOrbs = {};
        v107.BloodContainer = v112;
        v107.Highlights = v108;
        v107.Chases = v109;
        v107.Cache = v107.Cache or {};
        v107.Cache.PursuitCutscene = v9:LoadAnimationFromID(v107.Rig, v107.Config.Animations.DemonicPursuitCutscene.Killer);
        v107.Cache.SlashNormal = v9:LoadAnimationFromID(v107.Rig, v107.Config.Animations.Slash.Slash);
        v107.Cache.SlashPower = v9:LoadAnimationFromID(v107.Rig, v107.Config.Animations.Slash.Bite);
        v107.Rig:SetAttribute("TailPhysicsEnabled", true);
        v107.ShockwaveBuffer = 0;
        v12:SetConnection(("%*666Shockwave"):format(v107.Player.Name), "REMOTE_EVENT", function(v114, v115) --[[ Line: 296 ]]
            -- upvalues: v107 (copy)
            if not v107 or not v115 then
                return;
            elseif v114 ~= v107.Player then
                v114:Kick("do the roar");
                return;
            else
                if v107.Behavior and v107.Behavior.FireShockwave and v107.ShockwaveBuffer then
                    if v107.ShockwaveBuffer > 0 then
                        local v116 = v107;
                        v116.ShockwaveBuffer = v116.ShockwaveBuffer - 1;
                        v107.Behavior.FireShockwave(v107, v115);
                        return;
                    else
                        v114:Kick("do the roar");
                    end;
                end;
                return;
            end;
        end);
        local v117 = 0;
        local v118 = v107.Config.ManicSpeed;
        local v119 = v107.Config.ManicChaseSpeed;
        v107.ManicSpeed = v9:CreateSpeedMultiplier(v107.Player, 1, "666ManicFixation");
        v107.ManicSpeed.Value = 1;
        local v138 = v2.Heartbeat:Connect(function(v120) --[[ Line: 319 ]]
            -- upvalues: v107 (copy), v111 (copy), v9 (ref), v109 (copy), v118 (copy), v119 (copy), v117 (ref)
            if not v107 or not v107.Rig or not v107.Rig.Parent or not v107.Rig.PrimaryPart then
                return;
            else
                local v121 = v107.Rig:GetAttribute("TerrorMultiplier") or 1;
                for v122, v123 in ipairs(workspace.Players.Survivors:GetChildren()) do
                    if not v107.Chases[v123] then
                        local v124 = v123.PrimaryPart;
                        local v125 = v123:FindFirstChild("Humanoid");
                        if v124 and v125 and v125.Health > 0 and ((v124.Position - v111.PrimaryPart.Position) * v9.KillerDistanceVector).Magnitude <= v107.Config.ChaseEnterThreshold then
                            v107.Chases[v123] = true;
                        end;
                    end;
                end;
                for v126, v127 in pairs(v107.Chases) do
                    if not v9:IsAlive(v126) then
                        v109[v126] = nil;
                    elseif ((v126.PrimaryPart.Position - v111.PrimaryPart.Position) * v9.KillerDistanceVector).Magnitude > v107.Config.ChaseLeaveThreshold * v121 then
                        v109[v126] = nil;
                    end;
                end;
                local v128 = 1;
                for v129, v130 in pairs(v107.Highlights) do
                    if not v9:IsAlive(v129) or not v107.Behavior.IsHighlighted(v107, v129) then
                        v129:RemoveTag(v107.Player.Name .. "666Highlight");
                        v107.Highlights[v129] = nil;
                    else
                        local v131 = (v129.PrimaryPart.Position - v111.PrimaryPart.Position) * v9.KillerDistanceVector;
                        local v132 = v131.Unit;
                        local v133 = v111.PrimaryPart.AssemblyLinearVelocity.Unit;
                        local v134 = (v129.PrimaryPart.Position - v111.PrimaryPart.Position).Magnitude;
                        if v133 == v133 and v132 == v132 and (v131.Magnitude <= v107.Config.ManicForceProximity or v132:Dot(v133) > math.cos((math.rad(v107.Config.ManicConeSize)))) then
                            if not v109[v129] then
                                v128 = v118;
                                break;
                            else
                                v128 = v119;
                            end;
                        end;
                    end;
                end;
                if not v107.ManicSpeed or not v107.ManicSpeed.Parent or not v107.ManicSpeed:IsDescendantOf(v111) then
                    if v107.ManicSpeed then
                        v107.ManicSpeed:Destroy();
                        v107.ManicSpeed = nil;
                    end;
                    v107.ManicSpeed = v9:CreateSpeedMultiplier(v107.Player, 1, "666ManicFixation");
                    v107.ManicSpeed.Value = 1;
                end;
                v117 = v128 ~= 1 and tick() or v117;
                if tick() - v117 >= 1 or v128 ~= 1 then
                    local v135 = math.clamp(v107.ManicSpeed.Value < v128 and v107.ManicSpeed.Value + v120 * v107.Config.ManicBuildRate or v107.ManicSpeed.Value - v120 * v107.Config.ManicDecayRate, 1, v118);
                    v107.ManicSpeed.Value = v135;
                end;
                for v136, v137 in pairs(v107.BloodOrbs) do
                    if not v136 or not v136.Parent then
                        if v136 then
                            v136:Destroy();
                        end;
                        v107.BloodOrbs[v136] = nil;
                    elseif (v136.Position - v107.Rig.PrimaryPart.Position).Magnitude < v107.Config.BloodOrbCollectRange and v107.Blood < v107.MaxBlood then
                        v107.BloodOrbs[v136] = nil;
                        v107.Behavior.CollectOrb(v107, v136);
                    end;
                end;
                return;
            end;
        end);
        table.insert(v107.ServerConnections, v138);
        return;
    else
        if v2:IsClient() then
            local v139 = v15 == v107.Player;
            local v140 = v107.Config.Tail and require(v107.Config.Tail);
            if v140 then
                v107.Tail = v140.new(v107.Rig);
            end;
            v107.ClientConnections = {};
            v107.BloodOrbs = {};
            v107.OrbTransparencyConnection = v3:GetInstanceAddedSignal((("%*BloodOrb"):format(v107.Player.Name))):Connect(function(v141) --[[ Line: 435 ]]
                -- upvalues: v139 (copy), v107 (copy)
                if v139 then
                    local v142 = v141:WaitForChild("AlignPosition", 2);
                    if v141 and v141.Parent and v142 then
                        local v143 = {
                            Mover = v142
                        };
                        v107.BloodOrbs[v141] = v143;
                        return;
                    else
                        warn("failed to find mover for", (tostring(v141)));
                        return;
                    end;
                else
                    task.defer(function() --[[ Line: 448 ]]
                        -- upvalues: v141 (copy), v107 (ref)
                        v141.LocalTransparencyModifier = 0.8;
                        v107.Behavior.DelocalizeBloodOrb(v107, v141);
                        table.insert(v107.BloodOrbs, v141);
                    end);
                    return;
                end;
            end);
            if v139 then
                local v144 = v107.Rig:WaitForChild("Humanoid", 30);
                if v144 then
                    v144.CameraOffset = Vector3.new(0, 1.5, 0, 0);
                    v15.CameraMinZoomDistance = 0;
                    v15.CameraMaxZoomDistance = 20;
                end;
                local v145 = v107.Config.BloodUI:Clone();
                v145.Parent = v15.PlayerGui.TemporaryUI;
                v145.Position = v145.Position + UDim2.fromScale(0, 0.5);
                local v146 = {
                    In = v5:Create(v145, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Position = v145.Position - UDim2.fromScale(0, 0.5)
                    }), 
                    Out = v5:Create(v145, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                        Position = v145.Position
                    })
                };
                local v147 = nil;
                local v148 = false;
                local v149 = v145.Timer;
                local v150 = v149.Fill.Gradient;
                local v151 = v149.Time;
                local v152 = v149.Position;
                local v153 = {
                    In = v5:Create(v149, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Size = v149.Size
                    }), 
                    Out = v5:Create(v149, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                        Size = UDim2.fromScale(0, v149.Size.Y.Scale)
                    })
                };
                local v154 = nil;
                local v155 = nil;
                local v156 = v145.Blood;
                local v157 = v156.Fill.Gradient;
                local v158 = v156.Count;
                local v159 = v156.Max;
                v107.BloodHuntEffects = {};
                local v160 = {};
                local function v163() --[[ Line: 499 ]] --[[ Name: updateAbilityName ]]
                    -- upvalues: v107 (copy), v1 (ref)
                    local v161 = false;
                    if v107.Blood >= v107.MaxBlood then
                        v161 = not v107.Hunting and not v107.Rig:GetAttribute("NoBloodHunt");
                    end;
                    local v162 = v107.Behavior.Abilities.BloodHunt;
                    v162.Name = v161 and v1.Abilities.BloodHunt.Name or "Blood Rush";
                    v162.Icon = v161 and v1.Abilities.BloodHunt.Icon or "rbxassetid://86146830667112";
                end;
                do
                    local v164, v165, v166, v167 = v147, v148, v154, v155;
                    local function v172() --[[ Line: 507 ]] --[[ Name: setTimerUI ]]
                        -- upvalues: v165 (ref), v149 (copy), v107 (copy), v150 (copy), v75 (ref), v151 (copy)
                        if not v165 then
                            return;
                        else
                            v149.Visible = true;
                            local v168 = v107.Rig:GetAttribute("BloodHuntDuration") or v107.Config.BloodHuntDuration;
                            local v169 = v107.Rig:GetAttribute("BloodHuntTimer") or v168;
                            v150.Color = v75(v169 / v107.Rig:GetAttribute("BloodHuntDuration"), Color3.new(1, 1, 1), Color3.new(0.1, 0.1, 0.1));
                            local v170 = tostring((math.floor(v169)));
                            v170 = string.rep("0", 2 - string.len(v170)) .. v170;
                            local v171 = tostring(v169 - math.floor(v169));
                            v171 = string.format("%.2f", v171);
                            v151.Text = ("%*:%*"):format(v170, (v171:sub(v171:len() - 1, v171:len())));
                            return;
                        end;
                    end;
                    local function v173() --[[ Line: 525 ]] --[[ Name: uiAppear ]]
                        -- upvalues: v164 (ref), v146 (copy), v165 (ref)
                        if v164 then
                            pcall(task.cancel, v164);
                        end;
                        v164 = nil;
                        v146.In:Play();
                        if v165 then
                            return;
                        else
                            v164 = task.delay(3, function() --[[ Line: 533 ]]
                                -- upvalues: v146 (ref)
                                v146.Out:Play();
                            end);
                            return;
                        end;
                    end;
                    local v174 = v107.Config.BloodStartMax;
                    local v175 = v107.Config.BloodStartCount;
                    v159.Text = tostring(v174);
                    v158.Text = tostring(v175);
                    v157.Color = v75(v175 / v174, Color3.new(1, 1, 1), Color3.new(0.1, 0.1, 0.1));
                    v150.Color = v75(0, Color3.new(1, 1, 1), Color3.new(0.1, 0.1, 0.1));
                    v149.Visible = false;
                    v149.Size = UDim2.fromScale(0, v149.Size.Y.Scale);
                    v163();
                    v12:SetConnection("666UI", "REMOTE_EVENT", function(v176, ...) --[[ Line: 551 ]]
                        -- upvalues: v165 (ref), v166 (ref), v149 (copy), v153 (copy), v9 (ref), v107 (copy), v0 (ref), v5 (ref), v160 (copy), v172 (copy), v167 (ref), v2 (ref), v173 (copy), v151 (copy), v159 (copy), v158 (copy), v157 (copy), v75 (ref), v163 (copy)
                        local v177 = table.pack(...);
                        if v176 == "START" then
                            if v165 then
                                return;
                            else
                                if v166 then
                                    pcall(task.cancel, v166);
                                    v166 = nil;
                                end;
                                v165 = true;
                                v149.Visible = true;
                                v153.In:Play();
                                v9:ToggleLockForAbilityIcon("BloodHunt", "Hunting", true);
                                for v178, v179 in ipairs({
                                    "Character", 
                                    "Lighting"
                                }) do
                                    for v180, v181 in ipairs(v107.Config.BloodHuntVisuals[v179]:GetChildren()) do
                                        local v182 = v181:Clone();
                                        local v183 = v0[v181.ClassName];
                                        if v183 then
                                            local v184 = {};
                                            for v185, v186 in pairs(v183) do
                                                v184[v185] = v181[v185];
                                                v182[v185] = v186;
                                            end;
                                            local v187 = v5:Create(v182, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v184);
                                            local v188 = v5:Create(v182, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v183);
                                            v187:Play();
                                            table.insert(v160, v188);
                                        end;
                                        table.insert(v107.BloodHuntEffects, v182);
                                        v182.Parent = v179 == "Character" and v107.Rig.PrimaryPart or game:GetService("Lighting");
                                    end;
                                end;
                                v172();
                                if v167 then
                                    v167:Disconnect();
                                end;
                                v167 = nil;
                                v167 = v2.Heartbeat:Connect(v172);
                                v107.Hunting = true;
                                v173();
                            end;
                        elseif v176 == "END" then
                            if not v165 then
                                return;
                            else
                                v165 = false;
                                if v167 then
                                    v167:Disconnect();
                                end;
                                v167 = nil;
                                v151.Text = "TIME'S UP";
                                v9:ToggleLockForAbilityIcon("BloodHunt", "Hunting", false);
                                local v189 = v107.BloodHuntEffects or {};
                                for v190, v191 in ipairs(v160) do
                                    v191:Play();
                                end;
                                for v192, v193 in ipairs(v189) do
                                    game.Debris:AddItem(v193, 1.5);
                                end;
                                table.clear(v189);
                                table.clear(v160);
                                v166 = task.delay(1.5, function() --[[ Line: 626 ]]
                                    -- upvalues: v153 (ref), v149 (ref)
                                    v153.Out:Play();
                                    task.wait(0.6);
                                    v149.Visible = false;
                                end);
                                v107.Hunting = nil;
                                v173();
                            end;
                        elseif v176 == "BLOOD" then
                            local v194 = v177[1];
                            local v195 = v177[2];
                            v159.Text = tostring(v195);
                            v158.Text = tostring(v194);
                            v157.Color = v75(v194 / v195, Color3.new(1, 1, 1), Color3.new(0.1, 0.1, 0.1));
                            v107.Blood = v194;
                            v107.MaxBlood = v195;
                            v173();
                        end;
                        v163();
                    end);
                    local v196 = {};
                    local v197 = {};
                    local v198 = 1;
                    table.insert(v107.ClientConnections, v3:GetInstanceAddedSignal(v107.Player.Name .. "666Highlight"):Connect(function(v199) --[[ Line: 659 ]]
                        -- upvalues: v197 (copy)
                        v197[v199] = true;
                    end));
                    table.insert(v107.ClientConnections, v3:GetInstanceRemovedSignal(v107.Player.Name .. "666Highlight"):Connect(function(v200) --[[ Line: 662 ]]
                        -- upvalues: v197 (copy)
                        v197[v200] = nil;
                    end));
                    v12:SetConnection(("%*666DisplayHeartbeat"):format(v107.Player.Name), "REMOTE_EVENT", function(...) --[[ Line: 667 ]]
                        -- upvalues: v107 (copy)
                        v107.Behavior.DisplayHeartbeat(v107, ...);
                    end);
                    v107.BloodOrbs = {};
                    v2:BindToRenderStep("UpdateOrbs", 1, function() --[[ Line: 672 ]]
                        -- upvalues: v9 (ref), v107 (copy), v198 (ref)
                        local v201 = game.Players.LocalPlayer.Character;
                        local v202 = v201 and v201.PrimaryPart;
                        if not v9:IsAlive(v201) then
                            return;
                        else
                            for v203, v204 in pairs(v107.BloodOrbs) do
                                if not v203 or not v203.Parent or not v204.Mover then
                                    v107.BloodOrbs[v203] = nil;
                                else
                                    local v205 = (v202.Position - v203.Position).Magnitude;
                                    local v206 = v107.Config.BloodOrbAttractRange;
                                    if v206 < v205 or v107.Blood >= v107.MaxBlood or v107.Hunting then
                                        if v203.Anchored ~= true then
                                            v203.Anchored = true;
                                        end;
                                        local v207 = v204.Mover;
                                        if v207.Enabled ~= false then
                                            v207.Enabled = false;
                                        end;
                                    else
                                        if v203.Anchored ~= false then
                                            v203.Anchored = false;
                                        end;
                                        local v208 = v204.Mover;
                                        local v209 = v201.PrimaryPart.Position;
                                        if v208.Position ~= v209 then
                                            v208.Position = v209;
                                        end;
                                        v208 = v204.Mover;
                                        if v208.Enabled ~= true then
                                            v208.Enabled = true;
                                        end;
                                        v208 = v204.Mover;
                                        v209 = math.clamp((v206 - v205) / v206 * 35, 0, 35);
                                        if v208.MaxVelocity ~= v209 then
                                            v208.MaxVelocity = v209;
                                        end;
                                    end;
                                end;
                            end;
                            local v210 = v201 and v201:FindFirstChild("SpeedMultipliers") and v201.SpeedMultipliers:FindFirstChild("666ManicFixation");
                            if v210 then
                                if not v107.ManicLighting or not v107.ManicLighting.Parent then
                                    if v107.ManicLighting then
                                        v107.ManicLighting:Destroy();
                                    end;
                                    v107.ManicLighting = Instance.new("ColorCorrectionEffect", game.Lighting);
                                end;
                                local v211 = math.clamp((v210.Value - 1) / (v107.Config.ManicSpeed - 1), 0, 1);
                                for v212, v213 in pairs(v107.Config.ManicColorCorrectionProperties) do
                                    if typeof(v213) == "Color3" then
                                        local v214 = {};
                                        for v215, v216 in ipairs({
                                            "R", 
                                            "G", 
                                            "B"
                                        }) do
                                            table.insert(v214, v9:Lerp(1, v213[v216], v211));
                                        end;
                                        v107.ManicLighting[v212] = Color3.new(v214[1], v214[2], v214[3]);
                                    else
                                        v107.ManicLighting[v212] = v9:Lerp(0, v213, v211);
                                    end;
                                end;
                                v198 = v210.Value;
                            end;
                            return;
                        end;
                    end);
                end;
            end;
            v12:SetConnection(("%*666ShockwaveHit"):format(v107.Player.Name), "REMOTE_EVENT", function() --[[ Line: 732 ]]
                -- upvalues: v107 (copy), v9 (ref), v15 (ref), v5 (ref), v2 (ref), v8 (ref)
                local v217 = v107.Rig.PrimaryPart.Position;
                local v218 = workspace.CurrentCamera;
                local v219 = 0;
                local function v220() --[[ Line: 738 ]] --[[ Name: killTween ]]
                    -- upvalues: v107 (ref)
                    if v107.FocusTween then
                        v107.FocusTween:Pause();
                        v107.FocusTween:Destroy();
                        v107.FocusTween = nil;
                    end;
                end;
                if v107.FocusConnection then
                    v107.FocusConnection:Disconnect();
                    v107.FocusConnection = nil;
                end;
                if v107.FocusTween then
                    v107.FocusTween:Pause();
                    v107.FocusTween:Destroy();
                    v107.FocusTween = nil;
                end;
                v9:ApplyCameraShake(0.35, 0.75);
                local v221 = v9:CreateFOVMultiplier(v15, 1, "666Shockwave");
                local v222 = v5:Create(v221, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Value = 0.5
                });
                v222:Play();
                game.Debris:AddItem(v221, 3);
                task.delay(0.12, function() --[[ Line: 752 ]]
                    -- upvalues: v222 (copy), v5 (ref), v221 (copy)
                    v222:Pause();
                    v5:Create(v221, TweenInfo.new(1.2000000000000002, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        Value = 1
                    }):Play();
                end);
                v107.FocusConnection = v2.RenderStepped:Connect(function(v223) --[[ Line: 758 ]]
                    -- upvalues: v219 (ref), v107 (ref), v5 (ref), v218 (copy), v217 (copy)
                    v219 = v219 + v223;
                    if v219 > 0.8 then
                        if v107.FocusTween then
                            v107.FocusTween:Pause();
                            v107.FocusTween:Destroy();
                            v107.FocusTween = nil;
                        end;
                        v107.FocusConnection:Disconnect();
                        return;
                    else
                        if v107.FocusTween then
                            v107.FocusTween:Pause();
                            v107.FocusTween:Destroy();
                            v107.FocusTween = nil;
                        end;
                        v107.FocusTween = v5:Create(v218, TweenInfo.new(math.clamp(v219 / 0.8, 0.1, 1) + 0.2), {
                            CFrame = CFrame.lookAt(v218.CFrame.Position, v217)
                        });
                        v107.FocusTween:Play();
                        return;
                    end;
                end);
                v8:Play(v107.Config.Sounds.CryHit, {
                    Volume = 0.47, 
                    PlaybackSpeed = Random.new():NextNumber(0.9, 1.1), 
                    Parent = workspace
                });
            end);
            table.insert(v107.ClientConnections, workspace:GetAttributeChangedSignal("BloodHuntActive"):Connect(function() --[[ Line: 775 ]]
                -- upvalues: v9 (ref), v15 (ref), v107 (copy)
                local function v224() --[[ Line: 776 ]] --[[ Name: isActive ]]
                    -- upvalues: v9 (ref), v15 (ref), v107 (ref)
                    return v9:IsAlive(v15.Character) and v15.Character.Parent == workspace.Players.Survivors and workspace:GetAttribute("BloodHuntActive") and v107 and v9:IsAlive(v107.Rig);
                end;
                if v9:IsAlive(v15.Character) and v15.Character.Parent == workspace.Players.Survivors and workspace:GetAttribute("BloodHuntActive") and v107 and v9:IsAlive(v107.Rig) then
                    if v15:GetAttribute("HuntVFXActive") then
                        return;
                    else
                        v15:SetAttribute("HuntVFXActive", true);
                        task.spawn(v107.Behavior.StartBloodHuntVFX, v107);
                        while task.wait() and v9:IsAlive(v15.Character) and v15.Character.Parent == workspace.Players.Survivors and workspace:GetAttribute("BloodHuntActive") and v107 and v9:IsAlive(v107.Rig) do

                        end;
                        v15:SetAttribute("HuntVFXActive", nil);
                        if v107 and v107.Behavior and v107.Behavior.EndBloodHuntVFX then
                            task.spawn(v107.Behavior.EndBloodHuntVFX, v107);
                        end;
                    end;
                end;
            end));
        end;
        return;
    end;
end;
v1.Destroyed = function(v225, v226) --[[ Line: 799 ]] --[[ Name: Destroyed ]]
    -- upvalues: v2 (copy), v12 (copy), v15 (copy)
    if v2:IsServer() then
        local v227 = v226.BloodOrbs or {};
        for v228, v229 in pairs(v227) do
            v228:Destroy();
        end;
        table.clear(v227);
        v226.BloodOrbs = nil;
        while workspace.Map:FindFirstChild(v226.Player.Name .. "BloodOrbContainer") do
            workspace.Map[v226.Player.Name .. "BloodOrbContainer"]:Destroy();
        end;
        v12:RemoveConnection((("%*666Shockwave"):format(v226.Player.Name)));
        local v230 = ipairs;
        local v231 = v226.ServerConnections or {};
        for v232, v233 in v230(v231) do
            v233:Disconnect();
        end;
        return;
    else
        if v2:IsClient() then
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
                for v235, v236 in ipairs(v226.BloodHuntEffects) do
                    game.Debris:AddItem(v236, 2);
                end;
            end;
            v226.BloodOrbs = nil;
            v12:RemoveConnection(("%*666ShockwaveHit"):format(v226.Player.Name), "REMOTE_EVENT");
            if v234 then
                v12:RemoveConnection("666UI", "REMOTE_EVENT");
                v12:RemoveConnection(("%*666DisplayHeartbeat"):format(v226.Player.Name), "REMOTE_EVENT");
                v2:UnbindFromRenderStep("UpdateOrbs");
                v15.CameraMinZoomDistance = 0.5;
                v15.CameraMaxZoomDistance = 12;
            end;
            local v237 = ipairs;
            local v238 = v226.ClientConnections or {};
            for v239, v240 in v237(v238) do
                v240:Disconnect();
            end;
            v226.ClientConnections = nil;
            v226.Behavior.EndBloodHuntVFX(v226);
        end;
        return;
    end;
end;
v1.OnExecution = function(v241, v242, v243) --[[ Line: 859 ]] --[[ Name: OnExecution ]]
    local v244 = v243.Name == "Noob";
    local v245 = v244 and 3.7 or 3;
    local function v247() --[[ Line: 865 ]] --[[ Name: decapitate ]]
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
        task.delay(1.53, function() --[[ Line: 878 ]]
            -- upvalues: v242 (copy), v248 (copy), v243 (copy)
            local v249 = (-v242.Rig.PrimaryPart.CFrame.LookVector + Vector3.new(0, 0.5, 0, 0)) * 450;
            v248.AddProfile(v243, {
                AnchorDelay = true, 
                Velocity = v249, 
                Applied = os.clock() + 10
            });
            local v250 = v243:FindFirstChild("Humanoid");
            if v250 then
                v250.BreakJointsOnDeath = false;
                v250.Health = 0;
            end;
        end);
        task.delay(2.4, v247);
        task.delay(3.22, function() --[[ Line: 888 ]]
            -- upvalues: v243 (copy)
            v243.PrimaryPart.Anchored = false;
        end);
        return;
    else
        v242.Rig:SetAttribute("TailPhysicsEnabled", false);
        delay(3, function() --[[ Line: 893 ]]
            -- upvalues: v242 (copy)
            v242.Rig:SetAttribute("TailPhysicsEnabled", true);
        end);
        local v251 = v242.Rig.PrimaryPart.CFrame.LookVector * -300 + v242.Rig.PrimaryPart.CFrame.RightVector * -60;
        v248.AddProfile(v243, {
            AnchorDelay = true, 
            Velocity = v251, 
            Applied = os.clock() + 10
        });
        task.delay(1.8, function() --[[ Line: 901 ]]
            -- upvalues: v243 (copy), v247 (copy)
            local v252 = v243:FindFirstChild("Humanoid");
            local v253 = v243.PrimaryPart;
            if v252 then
                v252.BreakJointsOnDeath = false;
                v252.Health = 0;
                v247();
                task.wait(0.65);
                v253.Anchored = false;
                return;
            else
                return;
            end;
        end);
        return;
    end;
end;
v1.OnIntroduction = function(v254, v255, v256, v257) --[[ Line: 920 ]] --[[ Name: OnIntroduction ]]
    -- upvalues: v9 (copy)
    local v258 = v9:CreateFOVMultiplier(game.Players.LocalPlayer, 0.5714285714285714, "JohnDoeIntroScene", v257);
    v256:ScaleTo(1);
end;
v1.OnVictory = function(v259, v260, v261, v262, v263) --[[ Line: 926 ]] --[[ Name: OnVictory ]]
    -- upvalues: v2 (copy), v9 (copy), v5 (copy)
    local v264 = game:GetService("Players");
    if v260 == "Start" then
        v262:ScaleTo(1);
        local v265 = v261.Config.OutroFrameData;
        local v266 = v261.Cache.VictoryKillerTrack;
        local v267 = v261.Cache.VictoryCameraTrack;
        local v268 = {};
        v264.LocalPlayer:SetAttribute("FOVMultipliersDisabled", true);
        local v269 = v2.RenderStepped:Connect(function() --[[ Line: 945 ]]
            workspace.CurrentCamera.FieldOfView = 25;
        end);
        task.delay(v263, function() --[[ Line: 949 ]]
            -- upvalues: v269 (copy)
            v269:Disconnect();
        end);
        v9:PlayDummyCutsceneAnimations(v261, v263, "Victory");
        task.spawn(function() --[[ Line: 957 ]]
            -- upvalues: v264 (copy), v5 (ref)
            local function v270() --[[ Line: 958 ]] --[[ Name: check ]]
                -- upvalues: v264 (ref)
                return v264.LocalPlayer:GetAttribute("FOVMultipliersDisabled");
            end;
            task.wait(1.9166666666666667);
            if not v264.LocalPlayer:GetAttribute("FOVMultipliersDisabled") then
                return;
            else
                local v271 = Instance.new("ColorCorrectionEffect", game.Lighting);
                v271.Name = "666Effect";
                v5:Create(v271, TweenInfo.new(0.1), {
                    Brightness = 0.12, 
                    Contrast = 0.2
                }):Play();
                task.wait(0.08333333333333333);
                if not v264.LocalPlayer:GetAttribute("FOVMultipliersDisabled") then
                    return;
                else
                    v5:Create(v271, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Brightness = 0, 
                        Contrast = 0
                    }):Play();
                    task.wait(1);
                    if not v264.LocalPlayer:GetAttribute("FOVMultipliersDisabled") then
                        return;
                    else
                        v5:Create(v271, TweenInfo.new(0.48333333333333334, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                            Brightness = 0.35, 
                            Contrast = 0.9, 
                            Saturation = -0.5
                        }):Play();
                        task.wait(0.48333333333333334);
                        if not v264.LocalPlayer:GetAttribute("FOVMultipliersDisabled") then
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
                            for v273, v274 in ipairs(v272) do
                                v5:Create(v271, TweenInfo.new(0.05), v274):Play();
                                task.wait(0.05);
                                if not v264.LocalPlayer:GetAttribute("FOVMultipliersDisabled") then
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
            v264.LocalPlayer:SetAttribute("FOVMultipliersDisabled", nil);
        end;
        return;
    end;
end;
v1.OnStunnedAbsolute = function(v275, v276) --[[ Line: 1014 ]] --[[ Name: OnStunnedAbsolute ]]
    -- upvalues: v2 (copy), v11 (copy)
    if v2:IsClient() then
        return;
    else
        if v276.Hunting then
            v276.HeartbeatBlock = tick();
            v11:ApplyStatus(v276.Rig, "Slowness", {
                Level = 2, 
                Duration = 3
            });
            v11:ApplyStatus(v276.Rig, "Helpless", {
                Level = 1, 
                Duration = 1.5
            });
        end;
        return;
    end;
end;
v1.Abilities = {
    ["Carving Slash"] = {
        Name = "Carving Slash", 
        Icon = "rbxassetid://133652393566679", 
        LayoutOrder = 1, 
        KeybindType = "MainAbility", 
        Recharge = 8, 
        Charges = 1, 
        ChargesDisabled = true, 
        Sensitive = true, 
        Cooldown = 2, 
        Callback = function(v277, v278) --[[ Line: 1038 ]] --[[ Name: Callback ]]
            -- upvalues: v2 (copy), v8 (copy), v10 (copy), v9 (copy), v11 (copy), v12 (copy), v5 (copy), v13 (copy), v83 (copy)
            local v279 = ("%*666BiteCancel"):format(v277.Player.Name);
            if v2:IsServer() then
                local v280 = v277.Behavior.Abilities["Carving Slash"];
                local v281 = false;
                if v280.CurrentCharges > 0 then
                    v281 = v277.Blood >= v277.Config.EviscerateBlood;
                end;
                local v282 = false;
                v277.AbilitiesDisabled = true;
                v277.Cache.SlashNormal:Play();
                task.delay(0.2, function() --[[ Line: 1049 ]]
                    -- upvalues: v8 (ref), v277 (copy)
                    v8:Play(v277.Config.Sounds.Swing, {
                        Parent = v277.Rig.PrimaryPart, 
                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                        Volume = 0.25
                    });
                end);
                task.delay(v277.Config.SlashWindup, function() --[[ Line: 1054 ]]
                    -- upvalues: v10 (ref), v277 (copy), v9 (ref), v8 (ref), v11 (ref), v281 (ref)
                    local v289 = v10:CreateHitbox(v277.Player, {
                        Size = Vector3.new(5, 7, 7.25, 0), 
                        CFrameOffset = CFrame.new(0, -1, -4.25), 
                        Damage = v277.Config.SlashDamage, 
                        Time = v277.Config.SlashLinger, 
                        Knockback = 2, 
                        HitMultiple = true, 
                        ExecuteOnKill = true, 
                        Connections = {
                            Hit = function(v283, v284) --[[ Line: 1066 ]] --[[ Name: Hit ]]
                                -- upvalues: v9 (ref), v8 (ref), v277 (ref), v11 (ref), v281 (ref)
                                v9:CreateSpeedMultiplier(v283, 1.5, "HitSpeedBonus", 1.25);
                                if v284 then
                                    v8:Play(v277.Config.Sounds.Hit, {
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
                                if v283:IsDescendantOf(workspace.Players.Survivors) and not v11:PlayerHasStatus(v283, "Slateskin") then
                                    v277.Behavior.GiveBlood(v277, v277.Config.SlashBloodOnHit * (v285 and 2 or 1));
                                end;
                                v281 = v277.Blood >= v277.Config.EviscerateBlood;
                            end
                        }
                    });
                end);
                if v281 then
                    local v290 = tick();
                    local function v291() --[[ Line: 1102 ]] --[[ Name: cancel ]]
                        -- upvalues: v282 (ref), v12 (ref), v279 (copy), v277 (copy), v290 (copy)
                        if v282 then
                            return;
                        else
                            v282 = true;
                            v12:RemoveConnection(v279, "REMOTE_EVENT");
                            task.delay(math.clamp(v277.Config.SlashBiteTime - (tick() - v290), 0.02, v277.Config.SlashBiteTime), function() --[[ Line: 1107 ]]
                                -- upvalues: v277 (ref)
                                v277.AbilitiesDisabled = false;
                            end);
                            return;
                        end;
                    end;
                    v12:SetConnection(v279, "REMOTE_EVENT", function(v292) --[[ Line: 1112 ]]
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
                    v277.BiteThread = task.delay(v277.Config.SlashBiteTime, function() --[[ Line: 1128 ]]
                        -- upvalues: v282 (ref), v277 (copy), v280 (copy), v291 (copy), v12 (ref), v279 (copy), v8 (ref), v9 (ref), v5 (ref), v10 (ref), v11 (ref), v13 (ref), v83 (ref)
                        if v282 or v277.AbilityDisablers.Execution or v277.Blood < v277.Config.EviscerateBlood or v280.CurrentCharges < 1 or not v277.Rig.PrimaryPart then
                            v291();
                            return;
                        else
                            task.delay(v277.Config.SlashBiteTime, function() --[[ Line: 1135 ]]
                                -- upvalues: v277 (ref)
                                v277.AbilitiesDisabled = false;
                            end);
                            v277.Cache.SlashPower:Play(nil, 0.7, nil);
                            v277.Behavior.GiveBlood(v277, -v277.Config.EviscerateBlood);
                            v12:RemoveConnection(v279, "REMOTE_EVENT");
                            task.delay(0.4, function() --[[ Line: 1145 ]]
                                -- upvalues: v8 (ref), v277 (ref)
                                v8:Play(v277.Config.Sounds.Chomp, {
                                    Parent = v277.Rig.PrimaryPart, 
                                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                    Volume = 0.88
                                });
                            end);
                            v277:IncrementCharges("Carving Slash", -1, 1);
                            v277:SetCooldownOf("Carving Slash", 1.75);
                            local v293 = v9:CreateSpeedMultiplier(v277.Rig, v277.Config.EviscerateBiteForce, "666EvisLunge", 0.65);
                            v5:Create(v293, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                Value = 1
                            }):Play();
                            task.delay(v277.Config.EviscerateWindup, function() --[[ Line: 1157 ]]
                                -- upvalues: v10 (ref), v277 (ref), v9 (ref), v8 (ref), v11 (ref), v13 (ref), v83 (ref), v5 (ref)
                                local v294 = true;
                                local v295 = 0;
                                local v299 = v10:CreateHitbox(v277.Player, {
                                    Size = Vector3.new(7, 6.75, 7, 0), 
                                    CFrameOffset = CFrame.new(0, -1, -4.25), 
                                    Damage = v277.Config.EviscerateDamage, 
                                    Time = v277.Config.EviscerateLinger, 
                                    Knockback = 2, 
                                    HitMultiple = true, 
                                    ExecuteOnKill = true, 
                                    Connections = {
                                        Hit = function(v296) --[[ Line: 1171 ]] --[[ Name: Hit ]]
                                            -- upvalues: v9 (ref), v295 (ref), v294 (ref), v277 (ref), v8 (ref), v11 (ref), v13 (ref), v83 (ref)
                                            v9:CreateSpeedMultiplier(v296, 1.65, "HitSpeedBonus", 1.25);
                                            v295 = v295 + 1;
                                            if v294 then
                                                local v297, v298 = v277.Behavior.IsHighlighted(v277, v296);
                                                if v298 then
                                                    v277.Behavior.Highlight(v277, v296, 0.1);
                                                end;
                                                v277.Behavior.GiveBlood(v277, v277.Config.EviscerateBloodOnHit * (v298 and 2 or 1));
                                                v8:Play(v277.Config.Sounds.Hit, {
                                                    Parent = v277.Rig.PrimaryPart, 
                                                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                                    Volume = 0.25
                                                });
                                                v277:AddRecharge("Carving Slash", 4);
                                            end;
                                            v294 = false;
                                            if v296:IsDescendantOf(workspace.Players.Survivors) and not v11:PlayerHasStatus(v296, "Hemmorhage") and not v11:PlayerHasStatus(v296, "Slateskin") then
                                                v13:IncrementActorStats(v277.Player, {
                                                    Action = "Hemmorhaged Survivor with Eviscerate", 
                                                    RewardType = "EasyKillerAction"
                                                });
                                                v83(v277, v296);
                                            end;
                                        end, 
                                        Ended = function() --[[ Line: 1197 ]] --[[ Name: Ended ]]
                                            -- upvalues: v295 (ref), v11 (ref), v277 (ref)
                                            if v295 == 0 then
                                                v11:ApplyStatus(v277.Rig, "Slowness", v277.Config.EviscerateSlowness);
                                            end;
                                        end
                                    }
                                });
                                task.wait(0.1);
                                local v300 = v9:CreateSpeedMultiplier(v277.Rig, 1, "666EvisSlow", 0.7);
                                v5:Create(v300, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                    Value = 0.75
                                }):Play();
                                task.wait(0.2);
                                v5:Create(v300, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                    Value = 1
                                }):Play();
                            end);
                            return;
                        end;
                    end);
                else
                    task.delay(v277.Config.SlashBiteTime, function() --[[ Line: 1217 ]]
                        -- upvalues: v277 (copy)
                        v277.AbilitiesDisabled = false;
                    end);
                end;
                return v281;
            else
                if v2:IsClient() and v278 then
                    local v301 = false;
                    local v302 = tick();
                    do
                        local v303 = v301;
                        local v304 = v2.Heartbeat:Connect(function() --[[ Line: 1229 ]]
                            -- upvalues: v303 (ref), v277 (copy), v12 (ref), v279 (copy)
                            if v303 then
                                return;
                            else
                                if not v277.HeldAbilities["Carving Slash"] then
                                    v303 = true;
                                    v12:FireServerConnection(v279, "REMOTE_EVENT");
                                end;
                                return;
                            end;
                        end);
                        task.delay(v277.Config.SlashBiteTime, v304.Disconnect, v304);
                    end;
                end;
                return;
            end;
        end
    }, 
    DemonicPursuit = {
        LayoutOrder = 2, 
        Icon = "rbxassetid://112820220795591", 
        KeybindType = "AltAbility1", 
        FlavorText = "[Hold]", 
        Cooldown = 30, 
        Callback = function(v305, v306) --[[ Line: 1250 ]] --[[ Name: Callback ]]
            -- upvalues: v2 (copy), v9 (copy), v8 (copy), v12 (copy), v10 (copy), v13 (copy), v1 (copy), v11 (copy), v83 (copy), v4 (copy), v7 (copy), v56 (copy)
            local v307 = v305.Config.PursuitHold;
            local v308 = v305.Player.Name .. "666Dash";
            local v309 = v305.Player.Name .. "666Crashed";
            local v310 = RaycastParams.new();
            v310.FilterDescendantsInstances = {
                workspace.Players
            };
            v310.FilterType = Enum.RaycastFilterType.Exclude;
            v310.CollisionGroup = "Killers";
            v310.RespectCanCollide = true;
            if v2:IsServer() then
                v305.AbilitiesDisabled = true;
                v305.Rig:SetAttribute("PursuitState", "Charging");
                v305.Rig:SetAttribute("PursuitSpeed", nil);
                task.spawn(function() --[[ Line: 1268 ]]
                    -- upvalues: v305 (copy), v9 (ref), v8 (ref), v12 (ref), v308 (copy), v309 (copy), v2 (ref), v307 (copy), v10 (ref), v13 (ref), v1 (ref), v310 (copy), v11 (ref), v83 (ref), v4 (ref)
                    local v311 = v305.Rig.PrimaryPart;
                    local v312 = tick();
                    local v313 = false;
                    local v314 = false;
                    local v315 = v305.Rig.Humanoid;
                    local v316 = nil;
                    local v317 = nil;
                    local v318 = v9:CreateSpeedMultiplier(v305.Player, 0.01, "666PursuitStart", 5);
                    local v319 = v8:Play(v305.Config.Sounds.DemonicPursuitPrepare, {
                        Parent = v311, 
                        Volume = 1.25
                    });
                    v8:Play(v305.Config.Sounds.DemonicPursuitPrepareWARN, {
                        Parent = v305.Rig.PrimaryPart, 
                        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                        Volume = 1.25, 
                        RollOffMaxDistance = 67
                    });
                    v12:SetConnection(v308, "REMOTE_EVENT", function(v320) --[[ Line: 1281 ]]
                        -- upvalues: v305 (ref), v313 (ref)
                        if v320 ~= v305.Player then
                            v320:Kick("no");
                            return;
                        else
                            v313 = true;
                            return;
                        end;
                    end);
                    local v321 = false;
                    v12:SetConnection(v309, "REMOTE_EVENT", function(v322, v323) --[[ Line: 1287 ]]
                        -- upvalues: v305 (ref), v316 (ref), v321 (ref), v8 (ref), v311 (copy)
                        if v322 ~= v305.Player then
                            v322:Kick("no");
                            return;
                        elseif v316 then
                            return;
                        elseif v321 then
                            return;
                        else
                            v321 = true;
                            v8:Play(v305.Config.Sounds[v323], {
                                Parent = v311, 
                                Volume = 0.8
                            });
                            task.delay(0.16, function() --[[ Line: 1296 ]]
                                -- upvalues: v316 (ref), v323 (copy)
                                if not v316 then
                                    v316 = v323;
                                end;
                            end);
                            return;
                        end;
                    end);
                    repeat
                        v2.Heartbeat:Wait();
                        v314 = v305.Rig:GetAttribute("Stunned");
                    until v313 and tick() - v312 >= v307.Min or tick() - v312 >= v307.Max or v314;
                    v12:RemoveConnection(v308, "REMOTE_EVENT");
                    v318:Destroy();
                    v319:Destroy();
                    if v314 then
                        v305.Rig:SetAttribute("PursuitState", "Cancelled");
                        v305.AbilitiesDisabled = false;
                        return;
                    else
                        v305.Rig:SetAttribute("PursuitState", "Dashing");
                        local v324 = math.min(math.ceil(math.clamp(tick() - v312, v307.Min, v307.Max) / 0.25) * 0.25, v307.Max);
                        local v325 = v305.Config.PursuitBaseDamage + (v305.Config.PursuitMaxDamage - v305.Config.PursuitBaseDamage) * (v324 / v307.Max);
                        v8:Play(v305.Config.Sounds.DemonicPursuitLunge, {
                            Parent = v311, 
                            PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                            Volume = 0.88
                        });
                        local v326 = v9:CreateSpeedMultiplier(v305.Player, 20, "666Pursuit", 99);
                        local v327 = nil;
                        v317 = v10:CreateHitbox(v305.Player, {
                            Size = Vector3.new(7, 14, 7, 0), 
                            CFrameOffset = CFrame.new(0, -3, -2.25), 
                            Damage = 0, 
                            Time = 99, 
                            Knockback = 0, 
                            HitMultiple = true, 
                            Connections = {
                                Hit = function(v328, v329) --[[ Line: 1344 ]] --[[ Name: Hit ]]
                                    -- upvalues: v327 (ref), v9 (ref), v317 (ref), v316 (ref), v8 (ref), v305 (ref), v311 (copy), v13 (ref), v1 (ref), v312 (copy), v325 (ref), v310 (ref), v11 (ref), v83 (ref), v4 (ref), v2 (ref), v10 (ref)
                                    if v327 then
                                        return;
                                    elseif not v9:GetEntityType(v328) then
                                        return;
                                    else
                                        if v317 then
                                            v317:Cancel();
                                        end;
                                        v327 = v328;
                                        v316 = "Hit";
                                        v8:Play(v305.Config.Sounds.Hit, {
                                            Parent = v311, 
                                            Volume = 0.8
                                        });
                                        v13:IncrementActorStats(v305.Player, {
                                            Action = "Landed Demonic Pursuit", 
                                            RewardType = "RegularKillerAction"
                                        });
                                        local v330 = v1.Abilities.DemonicPursuit.Cooldown;
                                        local v331 = 0;
                                        for v332, v333 in pairs(v305.Highlights) do
                                            if tick() - v333[1] <= v333[2] then
                                                v331 = v331 + v305.Config.PursuitCooldownReductionPerHighlight;
                                            end;
                                        end;
                                        v305:SetCooldownOf("DemonicPursuit", (math.clamp(v330 - (tick() - v312) - v331, 2, v330)));
                                        if v305.Hunting then
                                            local v334 = v328:FindFirstChild("Humanoid");
                                            if v334 then
                                                local v335 = v334:GetAttribute("HardDamage") or 0;
                                                v325 = v325 + math.floor(v335 * v305.Config.PursuitHardDamageBonus);
                                            else
                                                local v336 = tostring(v328) .. " had no Humanoid??";
                                                warn("[G666]:", v336);
                                            end;
                                        end;
                                        local v337 = v305:GetPivot();
                                        local v338 = v337.Position;
                                        local v339 = workspace:Spherecast(v337.Position, 1, Vector3.new(0, -25, 0, 0), v310);
                                        warn(v339);
                                        local v340 = v339 and v339.Position + Vector3.new(0, 5.206999778747559, 0, 0) or v338;
                                        v305:PivotTo(CFrame.new(v340));
                                        if not v11:PlayerHasStatus(v328, "Slateskin") then
                                            v83(v305, v328);
                                        end;
                                        v305.Rig.PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0, 0);
                                        require(v4.Modules.Ragdolls).AddProfile(v327, {
                                            AnchorDelay = true, 
                                            Applied = os.clock() + 4
                                        });
                                        v9:GiveInvincible(v305.Rig, "DemonicPursuit");
                                        v9:SetUpCutscene(v305.Rig, v327, CFrame.new(0, 1.8, 0), "DemonicPursuit");
                                        local v341 = v9:LoadAnimationFromID(v327, v305.Config.Animations.DemonicPursuitCutscene.Victim, true);
                                        v341:Play(0.05);
                                        v341.Priority = Enum.AnimationPriority.Action4;
                                        v305.Cache.PursuitCutscene.Priority = Enum.AnimationPriority.Action4;
                                        v305.Cache.PursuitCutscene:Play(0);
                                        v305.Cache.PursuitCutscene.TimePosition = v341.TimePosition;
                                        v8:Play(v305.Config.Sounds.DemonicPursuitCutscene, {
                                            Parent = v305.Rig.PrimaryPart, 
                                            PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                            Volume = 0.88
                                        });
                                        task.delay(2.55, function() --[[ Line: 1411 ]]
                                            -- upvalues: v305 (ref)
                                            v305.Behavior.EmitVFX(v305, "SoftRoarEmit");
                                            v305.Behavior.EmitVFX(v305, "SoftRoarEnable");
                                        end);
                                        local v342 = {
                                            [35] = {
                                                Damage = v325 / 5, 
                                                Orb = true
                                            }, 
                                            [53] = {
                                                Damage = v325 / 5, 
                                                Orb = true
                                            }, 
                                            [73] = {
                                                Damage = v325 / 5, 
                                                Orb = true
                                            }, 
                                            [95] = {
                                                Damage = v325 / 5, 
                                                Orb = true
                                            }, 
                                            [122] = {
                                                Damage = v325 / 5, 
                                                Smack = true
                                            }
                                        };
                                        local v343, v344 = v305.Behavior.IsHighlighted(v305, v328);
                                        if v344 then
                                            v305.Behavior.Highlight(v305, v328, 0.1);
                                        end;
                                        local v345 = false;
                                        local v346 = nil;
                                        v346 = v2.Heartbeat:Connect(function() --[[ Line: 1433 ]]
                                            -- upvalues: v342 (copy), v305 (ref), v10 (ref), v328 (copy), v327 (ref), v341 (copy), v9 (ref), v345 (ref), v344 (copy), v346 (ref)
                                            for v347, v348 in pairs(v342) do
                                                if v305.Cache.PursuitCutscene.TimePosition >= v347 / 60 then
                                                    v10:CreateHitbox(v305.Player, {
                                                        Size = Vector3.new(5, 6, 5, 0), 
                                                        CFrame = (v328 and v328.PrimaryPart and v328.PrimaryPart.CFrame or v305.Rig.PrimaryPart.CFrame) * CFrame.new(0, 0, -2) - Vector3.new(0, 2, 0, 0), 
                                                        Damage = v348.Damage, 
                                                        Time = 0.1, 
                                                        Knockback = 0, 
                                                        HitMultiple = true
                                                    });
                                                    if v348.Smack and v327 then
                                                        v341:Stop(0);
                                                        local v349 = (-v305.Rig.PrimaryPart.CFrame.RightVector + v305.Rig.PrimaryPart.CFrame.LookVector / 3).Unit;
                                                        v9:ToggleAnchored(v327, "DemonicPursuit", false);
                                                        v9:RagdollLaunch(v305, v327, (v349 + Vector3.new(0, 0.30000001192092896, 0, 0)) * 125);
                                                    elseif v348.Orb then
                                                        local v350 = v345 and "L" or "R";
                                                        v345 = not v345;
                                                        v305.Behavior.EmitVFX(v305, "GroundMark" .. v350);
                                                        v305.Behavior.EmitVFX(v305, "Slash" .. v350);
                                                        v305.Behavior.GiveBlood(v305, 5 * (v344 and 2 or 1));
                                                    end;
                                                    v342[v347] = nil;
                                                end;
                                            end;
                                            if (not v327 or not v327.Parent or not v305.Cache.PursuitCutscene.IsPlaying) and v346 then
                                                v346:Disconnect();
                                                v346 = nil;
                                            end;
                                            task.delay(5, function() --[[ Line: 1473 ]]
                                                -- upvalues: v346 (ref)
                                                if v346 then
                                                    v346:Disconnect();
                                                    v346 = nil;
                                                end;
                                            end);
                                        end);
                                        return;
                                    end;
                                end
                            }
                        });
                        while v9:IsAlive(v305.Rig) and not v316 do
                            v2.Heartbeat:Wait();
                        end;
                        if not v9:IsAlive(v305.Rig) then
                            return;
                        else
                            if v317 then
                                v317:Cancel();
                            end;
                            local v351 = v305.Config[("Pursuit%*Endlag"):format(v316)] or v305.Config.PursuitEndlag;
                            if v316 == "Hit" then
                                v351 = v351 + (v305.Cache.PursuitCutscene.Length + 0.2);
                            end;
                            v12:RemoveConnection(v309, "REMOTE_EVENT");
                            v305.Rig:SetAttribute("PursuitState", nil);
                            v9:CreateSpeedMultiplier(v305.Player, 0.5, "666Pursuit", v351 - 0.2, true);
                            v326:Destroy();
                            task.wait(v351);
                            v305.AbilitiesDisabled = false;
                            if v316 == "Hit" then
                                v305.Rig.PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0, 0);
                                v9:ToggleAnchored(v305.Rig, "DemonicPursuit", false);
                                task.wait(0.35);
                                v9:RemoveInvincible(v305.Rig, "DemonicPursuit");
                            end;
                            return;
                        end;
                    end;
                end);
                return;
            else
                if v2:IsClient() then
                    v12:FireConnection("DisableSprinting", "666Pursuit", true);
                    v305.Rig:SetAttribute("FootstepsMuted", true);
                    v305.Animations.DemonicPursuitStart:Play(0.1);
                    v305.Animations.DemonicPursuitLoop:Play(0.12);
                    task.spawn(function() --[[ Line: 1539 ]]
                        -- upvalues: v305 (copy), v7 (ref), v2 (ref), v307 (copy), v56 (ref), v310 (copy), v12 (ref), v308 (copy), v309 (copy), v9 (ref)
                        local v352 = workspace.Gravity * v305.Config.PursuitGravity;
                        local v353 = false;
                        local v354 = v305.Rig.PrimaryPart;
                        local v355 = v305.Rig.Humanoid;
                        local v356 = workspace.CurrentCamera;
                        local v357 = v305.Config.PursuitMinAngle;
                        local v358 = v305.Config.PursuitHorizontalPenalty;
                        local v359 = {};
                        local v360 = {};
                        for v361, v362 in ipairs(v305.Rig:GetDescendants()) do
                            if (v362:IsA("BasePart") or v362:IsA("Decal")) and v362.Transparency < 0.9 then
                                table.insert(v359, v362);
                            elseif (v362:IsA("ParticleEmitter") or v362:IsA("Beam")) and v362.Enabled then
                                table.insert(v360, v362);
                                v362.Enabled = false;
                            end;
                        end;
                        local v363 = Instance.new("Beam", workspace);
                        local v364 = Instance.new("Attachment", workspace.Terrain);
                        local v365 = Instance.new("Attachment", workspace.Terrain);
                        v363.Attachment0 = v364;
                        v363.Attachment1 = v365;
                        v363.Segments = 40;
                        v363.Width0 = 1.2;
                        v363.Width1 = 0.35;
                        v363.Transparency = NumberSequence.new({
                            NumberSequenceKeypoint.new(0, 1), 
                            NumberSequenceKeypoint.new(0.5, 0), 
                            NumberSequenceKeypoint.new(1, 0)
                        });
                        v363.LightInfluence = 0;
                        v363.Brightness = 10;
                        v363.Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), 
                            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 0, 0)), 
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
                        });
                        v363.ZOffset = 2;
                        local v366 = v305.Config.PursuitLandVFX:Clone();
                        v366.Parent = v365;
                        v365.Visible = true;
                        local v367 = 0;
                        local v368 = (v356.CFrame.LookVector * Vector3.new(1, 0, 1, 0)).Unit;
                        local v369 = 0;
                        local v370 = math.clamp((math.deg((vector.angle(Vector3.new(-0, -1, -0, -0), v356.CFrame.LookVector))) - 90) * 1.1, 0, 80);
                        local v371 = tick();
                        if v370 < v357 then
                            v370 = 0;
                        end;
                        local v372 = v369 * (v370 / 90);
                        local v373 = v369 * ((90 - math.min(v370 * v358, 80)) / 90);
                        local v374 = 0;
                        v7.StaminaCap = v7.Stamina;
                        v2:BindToRenderStep("666PursuitPrepare", Enum.RenderPriority.Character.Value + 1, function() --[[ Line: 1595 ]]
                            -- upvalues: v371 (copy), v374 (ref), v356 (copy), v355 (copy), v368 (ref), v369 (ref), v305 (ref), v307 (ref), v370 (ref), v357 (copy), v372 (ref), v373 (ref), v358 (copy), v363 (copy), v364 (copy), v365 (copy), v366 (copy), v56 (ref), v352 (copy), v310 (ref), v367 (ref), v359 (copy)
                            local v375 = tick() - v371;
                            local v376 = v375 - v374;
                            local v377 = vector.normalize(v356.CFrame.LookVector * Vector3.new(1, 0, 1, 0));
                            if v377 ~= v377 or not v355 then
                                return;
                            else
                                v355:Move(v377);
                                v368 = (v356.CFrame.LookVector * Vector3.new(1, 0, 1, 0)).Unit;
                                v369 = (v305.Config.PursuitBaseSpeed + (v305.Config.PursuitMaxSpeed - v305.Config.PursuitBaseSpeed) * (v375 / v307.Max)) * v305.Config.Speed;
                                v370 = math.clamp((math.deg((vector.angle(Vector3.new(-0, -1, -0, -0), v356.CFrame.LookVector))) - 90) * 1.1, 0, 80);
                                if v370 < v357 then
                                    v370 = 0;
                                end;
                                v372 = v369 * (v370 / 90);
                                v373 = v369 * ((90 - math.min(v370 * v358, 80)) / 90);
                                local v378 = Vector3.new(0, 1, 0, 0) * (v305.Rig.CollisionHitbox.Size.Y / 1.6);
                                if v370 == 0 then
                                    local v379 = v305.Rig.PrimaryPart.CFrame;
                                    local v380 = CFrame.new(v379.Position, v379.Position + v368) * CFrame.new(0, 0, -(v369 * v305.Config.PursuitLength)) - v378;
                                    local v381 = 0;
                                    local v382 = 0;
                                    local v383 = v305.Rig.PrimaryPart.CFrame - v378;
                                    v363.CurveSize0 = v381;
                                    v363.CurveSize1 = v382;
                                    v364.CFrame = v364.Parent.CFrame:inverse() * v383 * CFrame.Angles(0, 0, 1.5707963267948966);
                                    v365.CFrame = v365.Parent.CFrame:inverse() * v380 * CFrame.Angles(0, 0, 1.5707963267948966);
                                    v366.Enabled = false;
                                else
                                    local v384, v385, v386, v387, v388 = v56(Vector3.new(0, 1, 0, 0) * -v352, v368 * v373 + Vector3.new(0, 1, 0, 0) * v372, v305.Rig.PrimaryPart.Position, v310);
                                    v363.CurveSize0 = v385;
                                    v363.CurveSize1 = v386;
                                    v364.CFrame = v364.Parent.CFrame:inverse() * v387;
                                    v365.CFrame = v365.Parent.CFrame:inverse() * v388;
                                    v366.Enabled = true;
                                end;
                                if v367 < 0.92 then
                                    local v389 = v376 * 4;
                                    v389 = v389 + math.min(0.92 - (v367 + v389), 0);
                                    for v390, v391 in ipairs(v359) do
                                        v391.Transparency = v391.Transparency + v389;
                                    end;
                                    v367 = v367 + v389;
                                end;
                                v374 = v375;
                                return;
                            end;
                        end);
                        while v2.Heartbeat:Wait() do
                            if not v305.HeldAbilities.DemonicPursuit and not v353 then
                                v353 = true;
                                v12:FireServerConnection(v308, "REMOTE_EVENT");
                            elseif v305.Rig:GetAttribute("PursuitState") ~= "Charging" then
                                break;
                            end;
                        end;
                        for v392, v393 in ipairs(v359) do
                            v393.Transparency = v393.Transparency - v367;
                        end;
                        for v394, v395 in ipairs(v360) do
                            v395.Enabled = true;
                        end;
                        v2:UnbindFromRenderStep("666PursuitPrepare");
                        v363:Destroy();
                        v365:Destroy();
                        v364:Destroy();
                        v305.Animations.DemonicPursuitStart:Stop(0);
                        v305.Animations.DemonicPursuitLoop:Stop(0);
                        if v305.Rig:GetAttribute("PursuitState") == "Cancelled" then
                            v12:FireConnection("DisableSprinting", "666Pursuit", false);
                            v305.Rig:SetAttribute("FootstepsMuted", false);
                            v7.StaminaCap = nil;
                            return;
                        else
                            local v396 = false;
                            local function v397() --[[ Line: 1711 ]] --[[ Name: stop ]]
                                -- upvalues: v396 (ref), v12 (ref), v305 (ref), v2 (ref), v7 (ref)
                                if v396 then
                                    return;
                                else
                                    v396 = true;
                                    v12:FireConnection("DisableSprinting", "666Pursuit", false);
                                    v305.Rig:SetAttribute("FootstepsMuted", nil);
                                    v2:UnbindFromRenderStep("666PursuitCharge");
                                    v7.StaminaCap = nil;
                                    return;
                                end;
                            end;
                            local v398 = tick();
                            local v399 = tick();
                            local v400 = v368 * v373 + Vector3.new(0, 1, 0, 0) * v372;
                            local v401 = v400;
                            local v402 = false;
                            v2:BindToRenderStep("666PursuitCharge", Enum.RenderPriority.Character.Value + 1, function() --[[ Line: 1728 ]]
                                -- upvalues: v355 (copy), v354 (copy), v396 (ref), v12 (ref), v305 (ref), v2 (ref), v7 (ref), v399 (ref), v400 (ref), v368 (ref), v373 (ref), v372 (ref), v352 (copy), v398 (copy), v402 (ref), v309 (ref), v310 (ref), v401 (ref)
                                if not v355 or not v354 or v354.Anchored then
                                    if v396 then
                                        return;
                                    else
                                        v396 = true;
                                        v12:FireConnection("DisableSprinting", "666Pursuit", false);
                                        v305.Rig:SetAttribute("FootstepsMuted", nil);
                                        v2:UnbindFromRenderStep("666PursuitCharge");
                                        v7.StaminaCap = nil;
                                        return;
                                    end;
                                else
                                    local v403 = tick() - v399;
                                    v305.Rig.PrimaryPart.AssemblyLinearVelocity = v400;
                                    v400 = v368 * v373 + Vector3.new(0, 1, 0, 0) * math.max(v372 - v352 * v403, -workspace.Gravity * 2);
                                    if v355.FloorMaterial ~= Enum.Material.Air then
                                        local v404 = tick() - v398;
                                        v399 = tick();
                                        if v305.Config.PursuitLength < v404 and not v402 then
                                            v402 = true;
                                            v12:FireServerConnection(v309, "REMOTE_EVENT", v400.Y < -4 and "Landed" or "Slide");
                                            v372 = 0;
                                        elseif v404 > 0.15 then
                                            v372 = 0;
                                        end;
                                    end;
                                    local v405 = workspace:Raycast(v354.Position, v400.Unit * 11, v310);
                                    if v405 and v405.Normal:Dot((Vector3.new(0, 1, 0, 0))) < 0.2 and not v402 then
                                        v402 = true;
                                        v12:FireServerConnection(v309, "REMOTE_EVENT", "Crashed");
                                    end;
                                    v401 = v400;
                                    return;
                                end;
                            end);
                            v305.Animations.DemonicPursuitLunge:Play(0);
                            while v305.Rig:GetAttribute("PursuitState") do
                                v2.RenderStepped:Wait();
                            end;
                            local v406 = v9:CreateSpeedMultiplier(v305.Player, 0.01, "666PursuitEndlag", v305.Config.PursuitEndlag, true);
                            v9:CreateSpeedMultiplier(v305.Player, v373, "666PursuitDampening", 0.1);
                            if not v396 then
                                v396 = true;
                                v12:FireConnection("DisableSprinting", "666Pursuit", false);
                                v305.Rig:SetAttribute("FootstepsMuted", nil);
                                v2:UnbindFromRenderStep("666PursuitCharge");
                                v7.StaminaCap = nil;
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
        Icon = "rbxassetid://85312426208381", 
        KeybindType = "AltAbility2", 
        Cooldown = 20, 
        Callback = function(v407, v408) --[[ Line: 1783 ]] --[[ Name: Callback ]]
            -- upvalues: v2 (copy), v8 (copy), v12 (copy), v9 (copy)
            local v409 = v407.Config;
            local v410 = v409.CryWindup;
            local v411 = v409.CryEndlag;
            if v2:IsServer() then
                local v412 = v407.Rig.Humanoid;
                local v413 = Instance.new("Attachment", v407.Rig.PrimaryPart);
                local v414 = v407.Config.CryLooker:Clone();
                v414.Attachment0 = v413;
                v414.CFrame = v407.Rig.PrimaryPart.CFrame;
                v414.Parent = v407.Rig.PrimaryPart;
                v412.AutoRotate = false;
                v407.AbilitiesDisabled = true;
                task.delay(v410, function() --[[ Line: 1800 ]]
                    -- upvalues: v413 (copy), v414 (copy), v412 (copy), v411 (copy), v407 (copy)
                    v413:Destroy();
                    v414:Destroy();
                    v412.AutoRotate = true;
                    task.wait(v411);
                    v407.AbilitiesDisabled = false;
                end);
                v407.ShockwaveBuffer = v407.ShockwaveBuffer + 1;
                v8:Play(v409.Sounds.CryWindup, {
                    Parent = v407.Rig.PrimaryPart, 
                    RollOffMaxDistance = 500
                });
                return v414;
            else
                if v2:IsClient() then
                    v12:FireConnection("DisableSprinting", "INFERNALCRY", true);
                    local function v416() --[[ Line: 1816 ]] --[[ Name: getMouse ]]
                        -- upvalues: v407 (copy), v9 (ref)
                        local v415 = (v407.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -20)).Position;
                        if v407.Player:GetAttribute("Device") == "Mobile" then
                            return v9:GetPlayerMousePosition(v407.Player, true);
                        else
                            return v9:GetPlayerMousePosition(v407.Player, false);
                        end;
                    end;
                    task.spawn(function() --[[ Line: 1826 ]]
                        -- upvalues: v408 (copy), v410 (copy), v9 (ref), v407 (copy), v416 (copy), v2 (ref)
                        local v417 = tick();
                        while v408 and tick() - v417 <= v410 and v9:IsAlive(v407 and v407.Rig) do
                            local v418 = (v416() - v407.Rig.PrimaryPart.Position) * Vector3.new(1, 0, 1, 0).Unit;
                            if v418 == v418 then
                                v408.CFrame = CFrame.new(v407.Rig.PrimaryPart.Position, v407.Rig.PrimaryPart.Position + v418);
                                v2.RenderStepped:Wait();
                            end;
                        end;
                    end);
                    local v419 = 0;
                    local v420 = {};
                    local v421 = {};
                    for v422, v423 in ipairs(v407.Rig:GetDescendants()) do
                        if (v423:IsA("BasePart") or v423:IsA("Decal")) and v423.Transparency < 0.9 then
                            table.insert(v420, v423);
                        elseif (v423:IsA("ParticleEmitter") or v423:IsA("Beam")) and v423.Enabled then
                            table.insert(v421, v423);
                            v423.Enabled = false;
                        end;
                    end;
                    local v424 = tick();
                    do
                        local v425, v426 = v419, v424;
                        v2:BindToRenderStep("InfernalCryTransparency", Enum.RenderPriority.Character.Value + 1, function() --[[ Line: 1854 ]]
                            -- upvalues: v426 (ref), v425 (ref), v420 (copy)
                            local v427 = tick() - v426;
                            if v425 < 0.92 then
                                local v428 = v427 * 4;
                                v428 = v428 + math.min(0.92 - (v425 + v428), 0);
                                for v429, v430 in ipairs(v420) do
                                    v430.Transparency = v430.Transparency + v428;
                                end;
                                v425 = v425 + v428;
                            end;
                            v426 = tick();
                        end);
                        v407.Animations.Cry:Play(nil, 0.8, nil);
                        task.delay(0.7, function() --[[ Line: 1873 ]]
                            -- upvalues: v9 (ref), v12 (ref)
                            v9:ApplyCameraShake(0.8, 0.6);
                            v12:FireConnection("DisableSprinting", "INFERNALCRY", false);
                        end);
                        task.delay(v410, function() --[[ Line: 1878 ]]
                            -- upvalues: v12 (ref), v407 (copy), v416 (copy), v2 (ref), v420 (copy), v425 (ref), v421 (copy)
                            v12:FireServerConnection(("%*666Shockwave"):format(v407.Player.Name), "REMOTE_EVENT", (v416() - v407.Rig.PrimaryPart.Position).Unit);
                            v2:UnbindFromRenderStep("InfernalCryTransparency");
                            for v431, v432 in ipairs(v420) do
                                v432.Transparency = v432.Transparency - v425;
                            end;
                            for v433, v434 in ipairs(v421) do
                                v434.Enabled = true;
                            end;
                        end);
                    end;
                end;
                return;
            end;
        end
    }, 
    BloodHunt = {
        LayoutOrder = 4, 
        Name = "Blood Hunt", 
        Icon = "rbxassetid://90131718849060", 
        KeybindType = "AltAbility3", 
        Cooldown = 30, 
        Callback = function(v435, v436) --[[ Line: 1902 ]] --[[ Name: Callback ]]
            -- upvalues: v2 (copy), v6 (copy), v13 (copy), v8 (copy), v12 (copy), v9 (copy)
            if v2:IsServer() then
                if v435.Blood == v435.MaxBlood and not v435.Hunting then
                    local v437;
                    if v2:IsClient() then
                        v437 = false;
                    else
                        local v438 = require(v6.Server.Systems.Core.RoundManager);
                        v437 = v438 and v438.CurrentSession and v438.CurrentSession.LastSurvivorAlive and true or false;
                    end;
                    if not v437 then
                        v13:IncrementActorStats(v435.Player, {
                            Action = "Activated Blood Hunt", 
                            RewardType = "EasyKillerAction"
                        });
                        v435.Rig:SetAttribute("Invincible", true);
                        v8:Play(v435.Config.Sounds.BloodHunt, {
                            Parent = v435.Rig.PrimaryPart, 
                            Volume = 0.56, 
                            RollOffMaxDistance = 300
                        });
                        v435.AbilitiesDisabled = true;
                        v435.DisabledAbilities = {
                            BloodHunt = true
                        };
                        task.delay(v435.Config.BloodHuntWindup, function() --[[ Line: 1913 ]]
                            -- upvalues: v435 (copy), v12 (ref)
                            if not v435 or not v435.BloodOrbs then
                                return;
                            else
                                v435.Behavior.EmitVFX(v435, "RoarEnable");
                                v435.Behavior.EmitVFX(v435, "RoarEmit");
                                for v439, v440 in ipairs(game.Players:GetPlayers()) do
                                    if v440 ~= v435.Player then
                                        local v441 = v440.Character and v440.Character.PrimaryPart and v440.Character.PrimaryPart.Position;
                                        local v442 = v441 and (v435.Rig.PrimaryPart.Position - v441).Magnitude;
                                        if v442 and v442 < 75 then
                                            v12:FireClientConnection(v440, "ApplyCameraShake", "REMOTE_EVENT", math.clamp(75 - v442, 0, 75) / 75 * 0.8, 1.8);
                                        end;
                                    end;
                                end;
                                v435.Behavior.StartBloodHunt(v435);
                                task.wait(v435.Config.BloodHuntEndlag);
                                if not v435 or not v435.BloodOrbs then
                                    return;
                                else
                                    v435.Rig:SetAttribute("Invincible", false);
                                    v435.AbilitiesDisabled = false;
                                    return;
                                end;
                            end;
                        end);
                        return true;
                    end;
                end;
                v435.BloodCooldownData = nil;
                v435.AbilitiesDisabled = true;
                task.delay(v435.Config.EcholocationWindup + v435.Config.EcholocationEndlag, function() --[[ Line: 1946 ]]
                    -- upvalues: v435 (copy)
                    v435.AbilitiesDisabled = false;
                end);
                task.delay(v435.Config.EcholocationWindup, function() --[[ Line: 1950 ]]
                    -- upvalues: v9 (ref), v435 (copy)
                    for v443, v444 in ipairs(workspace.Players.Survivors:GetChildren()) do
                        if v9:IsAlive(v444) then
                            local v445 = vector.magnitude(v444.PrimaryPart.Position - v435.Rig.PrimaryPart.Position);
                            local v446 = v435.Config;
                            local v447 = v446.EcholocationDistance;
                            local v448 = v446.EcholocationDuration;
                            local v449 = v447.Max - v447.Min;
                            local v450 = math.clamp(v445, v447.Min, v447.Max) - v447.Min;
                            local v451 = v448.Min + (v448.Max - v448.Min) * (v450 / v449);
                            v435.Behavior.Highlight(v435, v444, v451);
                            v435.Highlights[v444][3] = true;
                        end;
                    end;
                end);
                v8:Play(v435.Config.Sounds.Echolocation, {
                    Parent = v435.Rig.PrimaryPart, 
                    Volume = 0.56, 
                    RollOffMaxDistance = 100
                });
                return false;
            else
                if v2:IsClient() then
                    if v436 then
                        v435.Animations.BloodHuntActivate:Play(0.175);
                        v9:ApplyCameraShake(0.1, 1.61);
                        local v452 = v9:CreateSpeedMultiplier(v435.Player, 0, "666BloodHuntStart", v435.Config.BloodHuntWindup + v435.Config.BloodHuntEndlag - 0.3, true);
                        if not v9:GetSettingValue("EpilepsyMode") then
                            local v453 = Instance.new("ColorCorrectionEffect");
                            v453.Parent = game.Lighting;
                            v453.Name = "GuestRoar";
                            v453.Brightness = 0;
                            v453.Contrast = 0;
                            v453.Saturation = 0;
                            v453.TintColor = Color3.fromRGB(255, 255, 255);
                            v453.Enabled = true;
                            game:GetService("Debris"):AddItem(v453, 4);
                            game.TweenService:Create(v453, TweenInfo.new(1.61, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                TintColor = Color3.new(1, 0.737255, 0.737255)
                            }):Play();
                            game.TweenService:Create(v453, TweenInfo.new(1.61, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                Contrast = 0.1
                            }):Play();
                            game.TweenService:Create(v453, TweenInfo.new(1.61, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                Saturation = 0.2
                            }):Play();
                            local v454 = v9:CreateFOVMultiplier(v435.Player, 1, "Roaring");
                            game.TweenService:Create(v454, TweenInfo.new(1.61, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                Value = 0.875
                            }):Play();
                            game:GetService("Debris"):AddItem(v454, 4);
                            task.delay(1.61, function() --[[ Line: 2003 ]]
                                -- upvalues: v454 (copy), v453 (copy)
                                game.TweenService:Create(v454, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 9), {
                                    Value = 1.1
                                }):Play();
                                game.TweenService:Create(v453, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                                    TintColor = Color3.new(1, 0.184314, 0.184314)
                                }):Play();
                                game.TweenService:Create(v453, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                    Contrast = 0.5
                                }):Play();
                                game.TweenService:Create(v453, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                    Saturation = 1
                                }):Play();
                            end);
                            task.delay(2.6, function() --[[ Line: 2011 ]]
                                -- upvalues: v453 (copy), v454 (copy)
                                game.TweenService:Create(v453, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                    Contrast = 0
                                }):Play();
                                game.TweenService:Create(v453, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                    Saturation = 0
                                }):Play();
                                game.TweenService:Create(v454, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                    Value = 1
                                }):Play();
                                game.TweenService:Create(v453, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                    TintColor = Color3.new(1, 1, 1)
                                }):Play();
                            end);
                        end;
                        task.delay(1.61, function() --[[ Line: 2019 ]]
                            -- upvalues: v9 (ref)
                            v9:ApplyCameraShake(1, 1.5);
                        end);
                        return;
                    else
                        local v455 = v9:CreateSpeedMultiplier(v435.Player, 0, "666BloodHuntStart", v435.Config.BloodHuntWindup + v435.Config.BloodHuntEndlag - 0.3, true);
                        v435.Animations.EcholocationActivate:Play(0.175);
                    end;
                end;
                return;
            end;
        end
    }
};
v1.DisplayHeartbeat = function(v456, v457, v458) --[[ Line: 2033 ]] --[[ Name: DisplayHeartbeat ]]
    -- upvalues: v2 (copy), v5 (copy)
    assert(v2:IsClient(), "Attempted to display heartbeat on server");
    while v457:FindFirstChild("HeartbeatHighlight") do
        v457.HeartbeatHighlight:Destroy();
    end;
    local v459 = v457.PrimaryPart;
    local v460 = math.clamp(vector.magnitude(v456.Rig.PrimaryPart.Position - v459.Position) / 45 + 0.5, 0.5, 3);
    local v461 = Instance.new("Highlight", v457);
    v461.Name = "HeartbeatHighlight";
    v461.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
    v461.FillTransparency = 0;
    v461.FillColor = if v458 then Color3.new(1, 0.482353, 0.482353) else Color3.new(0.568627, 0, 0);
    v461.OutlineTransparency = 0;
    v461.OutlineColor = if v458 then Color3.new(1, 0.309804, 0.309804) else Color3.new(0, 0, 0);
    v5:Create(v461, TweenInfo.new(v460, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
        FillTransparency = 1
    }):Play();
    v5:Create(v461, TweenInfo.new(v460 * 1.65, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
        OutlineTransparency = 1
    }):Play();
    game.Debris:AddItem(v461, v460 + 1);
end;
v1.EmitVFX = function(v462, v463) --[[ Line: 2060 ]] --[[ Name: EmitVFX ]]
    -- upvalues: v9 (copy)
    assert(v462, "must pass killerInfo as argument");
    local v464 = v462.VFX and v462.VFX[v463];
    if v464 then
        v9:EmitParticles(v464);
        return;
    else
        warn((("Particle %* not found"):format(v463)));
        return;
    end;
end;
v1.StartBloodHuntVFX = function(v465) --[[ Line: 2073 ]] --[[ Name: StartBloodHuntVFX ]]
    -- upvalues: v15 (copy), v5 (copy), v8 (copy), v2 (copy), v9 (copy), v22 (copy)
    assert(v465, "must pass killerInfo as argument");
    assert(v465.Behavior.EndBloodHuntVFX, "StartBloodHuntVFX must have a pairing disable method");
    if v465.BloodHuntVFX then
        return;
    else
        v465.BloodHuntVFX = {};
        local v466 = v15.PlayerGui;
        local v467 = Instance.new("ColorCorrectionEffect", game.Lighting);
        local function v468() --[[ Line: 2084 ]] --[[ Name: guard ]]
            -- upvalues: v465 (copy), v467 (copy)
            return not (v465 and v465.BloodHuntVFX and v465.BloodHuntVFX.ColorCorrection == v467 and v467.Parent);
        end;
        local v469 = v5:Create(v467, TweenInfo.new(1.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Saturation = -1, 
            Brightness = 0.3, 
            Contrast = 0.5, 
            TintColor = Color3.new(1, 0.5, 0.5)
        });
        local v470 = v5:Create(v467, TweenInfo.new(0.65, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Brightness = -0.1, 
            Saturation = -0.6, 
            Contrast = 0.3, 
            TintColor = Color3.new(0.737255, 0.294118, 0.294118)
        });
        local v471 = v5:Create(v467, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Brightness = 0.06, 
            Saturation = -0.55, 
            Contrast = 0.2, 
            TintColor = Color3.new(1, 0.101961, 0.101961)
        });
        local v472 = v5:Create(v467, TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Brightness = 0, 
            Saturation = 0, 
            Contrast = 0, 
            TintColor = Color3.new(1, 1, 1)
        });
        local v473 = {};
        local v474 = game.Lighting:FindFirstChildOfClass("Atmosphere");
        if not v474 then
            v474 = Instance.new("Atmosphere", game.Lighting);
            v474:SetAttribute("Artificial", true);
        end;
        for v475, v476 in pairs(v465.Config.BloodHuntAtmosphere) do
            v473[v475] = v474[v475];
        end;
        local v477 = v5:Create(v474, TweenInfo.new(1.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), v465.Config.BloodHuntAtmosphere);
        local v478 = v5:Create(v474, TweenInfo.new(1.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), v473);
        local v479 = v465.Config.Sounds;
        for v480, v481 in ipairs({
            v479.AmbBloodHuntStart
        }) do
            v8:Play(v481);
        end;
        v477:Play();
        v469:Play();
        v465.BloodHuntVFX.Connections = {};
        v465.BloodHuntVFX.Instances = {};
        v465.BloodHuntVFX.Tweens = {
            Garbage = {
                v469, 
                v470, 
                v471, 
                v477
            }, 
            Reversal = {
                v478, 
                v472
            }
        };
        v465.BloodHuntVFX.ColorCorrection = v467;
        v465.BloodHuntVFX.Fog = v474;
        task.wait(1.8);
        if not (v465 and v465.BloodHuntVFX and v465.BloodHuntVFX.ColorCorrection == v467 and v467.Parent) then
            return;
        else
            local v482 = v479.AmbBloodHuntTheme;
            v8:PlayTheme(v482.ID, {
                Priority = 3, 
                Name = ("%*BloodHunt"):format(v465.Player.Name), 
                Volume = v482.Volume, 
                PlaybackRegionsEnabled = v482.LoopRegion, 
                LoopRegion = v482.LoopRegion, 
                Looped = true
            });
            local v483 = Instance.new("ColorCorrectionEffect", game.Lighting);
            local v484 = v465.Config.BloodHuntVisuals.Survivor.SurvivorSpotlight:Clone();
            local v485 = v465.Config.BloodHuntVignette.VignetteA:Clone();
            local v486 = v465.Config.BloodHuntVignette.VignetteB:Clone();
            v465.BloodHuntVFX.Instances.Vignettes = {
                v485, 
                v486, 
                v483, 
                v484
            };
            v485.Parent = v466.TemporaryUI;
            v486.Parent = v466.TemporaryUI;
            local v487 = nil;
            local v488 = nil;
            local v489 = 1;
            v465.BloodHuntVFX.Connections.Heartbeat = v2.Heartbeat:Connect(function(v490) --[[ Line: 2168 ]]
                -- upvalues: v9 (ref), v465 (copy), v15 (ref), v487 (ref), v483 (copy), v485 (copy), v486 (copy), v489 (ref), v22 (ref), v479 (copy), v488 (ref), v8 (ref)
                if not v9:IsAlive(v465.Rig) or not v9:IsAlive(v15.Character) then
                    return;
                else
                    if v487 then
                        local v491 = v487.PlaybackLoudness;
                        v483.Brightness = -math.clamp(v491 / 15000, 0, 1);
                        v483.Contrast = math.clamp(v491 / 15000, 0, 1);
                        local v492 = 1.3 - math.clamp(v491 / 15000 * 3, 0, 0.15);
                        v485.Size = UDim2.fromScale(v492, v492);
                        v486.Size = UDim2.fromScale(v492, v492);
                    end;
                    v489 = v489 + v490;
                    local v493 = vector.magnitude(v465.Rig.PrimaryPart.Position - v15.Character.PrimaryPart.Position) < 40;
                    local v494 = 60 / (v493 and v22(v479.TerrorRadiusThemes) or v479.AmbBloodHuntTheme).BPM;
                    if v488 ~= v494 then
                        v488 = v494;
                        v489 = 0;
                        return;
                    else
                        v488 = v494;
                        if v489 < v494 then
                            return;
                        else
                            v489 = v489 - v494;
                            v487 = v8:Play(v493 and v479.AmbBloodHuntHeartbeatFast or v479.AmbBloodHuntHeartbeatSlow);
                            return;
                        end;
                    end;
                end;
            end);
            v8:Play(v479.AmbBloodHuntBell);
            v469:Pause();
            v467.Brightness = 1;
            v467.Saturation = 3;
            v467.TintColor = Color3.new(0.7, 0, 0);
            v484.Parent = v15.Character.PrimaryPart;
            v470:Play();
            task.wait(1.2);
            if not (v465 and v465.BloodHuntVFX and v465.BloodHuntVFX.ColorCorrection == v467 and v467.Parent) then
                return;
            else
                v470:Pause();
                v471:Play();
                return;
            end;
        end;
    end;
end;
v1.EndBloodHuntVFX = function(v495) --[[ Line: 2216 ]] --[[ Name: EndBloodHuntVFX ]]
    -- upvalues: v8 (copy), v9 (copy)
    assert(v495, "must pass killerInfo as argument");
    if not v495.BloodHuntVFX then
        return;
    else
        if v495.BloodHuntVFX.ColorCorrection then
            game.Debris:AddItem(v495.BloodHuntVFX.ColorCorrection, 1);
        end;
        if v495.BloodHuntVFX.Fog and v495.BloodHuntVFX.Fog:GetAttribute("Artificial") then
            game.Debris:AddItem(v495.BloodHuntVFX.Fog, 1);
        end;
        v8:StopTheme(v495.Player.Name .. "BloodHunt", 0.4, true);
        for v496, v497 in pairs(v495.BloodHuntVFX.Connections) do
            v497:Disconnect();
        end;
        for v498, v499 in pairs(v495.BloodHuntVFX.Tweens.Reversal) do
            v499:Play();
        end;
        for v500, v501 in pairs(v495.BloodHuntVFX.Tweens.Garbage) do
            v501:Pause();
        end;
        v9:RecursiveDestroy(v495.BloodHuntVFX.Instances);
        table.clear(v495.BloodHuntVFX);
        v495.BloodHuntVFX = nil;
        return;
    end;
end;
v1.DelocalizeBloodOrb = function(v502, v503) --[[ Line: 2256 ]] --[[ Name: DelocalizeBloodOrb ]]
    for v504, v505 in ipairs(v503:GetDescendants()) do
        if v505:IsA("Trail") or v505:IsA("Beam") or v505:IsA("ParticleEmitter") then
            v505.Enabled = false;
        elseif v505:IsA("Decal") or v505:IsA("Texture") then
            v505.Transparency = 0.8;
        elseif v505:IsA("BasePart") then
            v505.LocalTransparencyModifier = 0.8;
        end;
    end;
end;
v1.ToggleOrbVisibility = function(v506, v507, v508) --[[ Line: 2269 ]] --[[ Name: ToggleOrbVisibility ]]
    if not v507 or not v507.Parent or not v507:FindFirstChild("Innards") then
        return;
    else
        v507.Transparency = v508 and 0 or 1;
        v507.Innards.Transparency = v508 and 0 or 1;
        v507.Innards.Aura.Enabled = v508;
        v507.Innards.ParticleAttachment.Ring.Enabled = false;
        return;
    end;
end;
if v2:IsClient() then
    return v1;
else
    v1.OnKill = function(v509, v510) --[[ Line: 2286 ]] --[[ Name: OnKill ]]
        v509.Behavior.GiveBlood(v509, v509.Config.BloodOnKill);
        if v509.Hunting then
            v509:SetCooldownOf("Carving Slash", 0);
            v509:IncrementCharges("Carving Slash", 1, 1);
            v509:SetCooldownOf("DemonicPursuit", 0);
            v509:SetCooldownOf("InfernalCry", 0);
            v509:SetCooldownOf("BloodHunt", 0);
            v509.HuntKills = (v509.HuntKills or 0) + 1;
            local v511 = v509.Config.BloodHuntKillIncrease * 0.75 ^ (v509.HuntKills - 1);
            v509.RemainingHuntTime = v509.RemainingHuntTime + v511;
        end;
    end;
    v1.StartBloodHunt = function(v512) --[[ Line: 2304 ]] --[[ Name: StartBloodHunt ]]
        -- upvalues: v9 (copy), v78 (copy), v2 (copy), v12 (copy), v11 (copy), v8 (copy)
        if v512.Hunting then
            return;
        else
            v512.RemainingHuntTime = v512.Config.BloodHuntDuration;
            local v513 = v512.Rig.PrimaryPart;
            v512.Hunting = true;
            v512.HuntDrainMultipliers = {};
            v512.HuntingThread = task.spawn(function() --[[ Line: 2319 ]]
                -- upvalues: v512 (copy), v9 (ref), v513 (copy), v78 (ref), v2 (ref), v12 (ref), v11 (ref)
                local function v514() --[[ Line: 2320 ]] --[[ Name: guard ]]
                    -- upvalues: v512 (ref), v9 (ref), v513 (ref)
                    if v512 and v512.Hunting and v9:IsAlive(v512.Rig) and v513 and v513.Parent and v512.RemainingHuntTime > 0 then
                        return true;
                    else
                        return false;
                    end;
                end;
                v512.Rig:SetAttribute("TerrorMultiplier", v512.Config.BloodHuntTerror);
                v512.Rig:SetAttribute("BloodHuntDuration", v512.RemainingHuntTime);
                v512.Rig:SetAttribute("BloodHuntTimer", v512.RemainingHuntTime);
                v9:GiveStackableAttribute(workspace, "BloodHuntActive", v512.Player.Name);
                v78(v512, "START");
                local v515 = {};
                while if v512 and v512.Hunting and v9:IsAlive(v512.Rig) and v513 and v513.Parent then v512.RemainingHuntTime > 0 else false do
                    local v516 = v2.Heartbeat:Wait();
                    if if v512 and v512.Hunting and v9:IsAlive(v512.Rig) and v513 and v513.Parent then v512.RemainingHuntTime > 0 else false then
                        local v517 = 1;
                        for v518, v519 in ipairs(v512.HuntDrainMultipliers) do
                            if v519 and typeof(v519) == "number" then
                                v517 = v517 * v519;
                            end;
                        end;
                        for v520, v521 in pairs(v512.Chases) do
                            if v521 and v520 then
                                v517 = v517 / 2;
                                break;
                            end;
                        end;
                        v512.RemainingHuntTime = math.clamp(v512.RemainingHuntTime - v516 * v517, 0, v512.Config.BloodHuntDuration);
                        v512.Rig:SetAttribute("StunnedDisabled", true);
                        if not v512.HeartbeatBlock or tick() - v512.HeartbeatBlock >= 5 then
                            for v522, v523 in ipairs(workspace.Players.Survivors:GetChildren()) do
                                if v9:IsAlive(v523) then
                                    v515[v523] = v515[v523] or 0;
                                    v515[v523] = v515[v523] + v516;
                                    if math.clamp(vector.magnitude(v523.PrimaryPart.Position - v512.Rig.PrimaryPart.Position) / 30, 0.5, 5) <= v515[v523] then
                                        v515[v523] = 0;
                                        v12:FireClientConnection(v512.Player, ("%*666DisplayHeartbeat"):format(v512.Player.Name), "REMOTE_EVENT", v523, v11:PlayerHasStatus(v523, "Hemmorhage") and true or false);
                                    end;
                                end;
                            end;
                        end;
                        v512.Rig:SetAttribute("BloodHuntTimer", v512.RemainingHuntTime);
                    else
                        break;
                    end;
                end;
                if v512 and v512.Behavior then
                    v512.Behavior.EndBloodHunt(v512);
                end;
            end);
            v512:SetCooldownOf("Carving Slash", 0);
            v512:IncrementCharges("Carving Slash", 1, 1);
            v512:SetCooldownOf("DemonicPursuit", 0);
            v512:SetCooldownOf("InfernalCry", 0);
            v512:SetCooldownOf("BloodHunt", 0);
            v9:CreateSpeedMultiplier(v512.Rig, v512.Config.BloodHuntSpeedBoost, "666BloodHunt");
            v8:Play(v512.Config.Sounds.BloodHuntStart, {
                Parent = v512.Rig.PrimaryPart, 
                RollOffMaxDistance = 600, 
                Volume = 0.6
            });
            v512.BloodHuntLoopSound = v8:Play(v512.Config.Sounds.BloodHuntLoop, {
                Parent = v512.Rig.PrimaryPart, 
                RollOffMaxDistance = 35, 
                Looped = true, 
                Volume = 0.3
            });
            return;
        end;
    end;
    v1.EndBloodHunt = function(v524) --[[ Line: 2395 ]] --[[ Name: EndBloodHunt ]]
        -- upvalues: v9 (copy), v8 (copy), v78 (copy)
        if not v524.Hunting then
            return;
        else
            v9:RemoveStackableAttribute(workspace, "BloodHuntActive", v524.Player.Name);
            v524.HuntKills = nil;
            v524.RemainingHuntTime = 0;
            v524.Hunting = false;
            if v524.BloodHuntLoopSound then
                v524.BloodHuntLoopSound:Destroy();
                v524.BloodHuntLoopSound = nil;
            end;
            v524.MaxBlood = v524.MaxBlood + v524.Config.BloodHuntIncrease;
            v524.Behavior.GiveBlood(v524, -v524.MaxBlood);
            v524.HeartbeatBlock = nil;
            v524.Rig:SetAttribute("StunnedDisabled", nil);
            v8:Play(v524.Config.Sounds.BloodHuntEnd, {
                Parent = v524.Rig.PrimaryPart, 
                RollOffMaxDistance = 50
            });
            v78(v524, "END");
            task.delay(3, function() --[[ Line: 2419 ]]
                -- upvalues: v524 (copy)
                v524.DisabledAbilities = nil;
            end);
            v9:CreateSpeedMultiplier(v524.Rig, v524.Config.BloodHuntSpeedBoost, "666BloodHunt", 0.05, true);
            v524.Rig:SetAttribute("TerrorMultiplier", nil);
            return;
        end;
    end;
    v1.FireShockwave = function(v525, v526) --[[ Line: 2431 ]] --[[ Name: FireShockwave ]]
        -- upvalues: v8 (copy), v5 (copy), v10 (copy), v11 (copy), v88 (copy), v12 (copy), v13 (copy)
        local v527 = v525.Rig;
        local v528 = v527.PrimaryPart;
        local v529 = v525.Config;
        local v530 = v529.CryShockwaveSize;
        local v531 = v525.Hunting and v529.CryHuntingSize or 1;
        local v532 = v529.CryShockwaveDuration;
        local v533 = v529.CryShockwaveDistance;
        local v534 = v529.CrySlownessDuration + (v525.Hunting and 2 or 0);
        if not v527 or not v528 or not v526 then
            return;
        elseif v527:GetAttribute("Stunned") then
            return;
        else
            v525.Behavior.EmitVFX(v525, "RoarEnable");
            v525.Behavior.EmitVFX(v525, "RoarEmit");
            v8:Play(v529.Sounds.CryShockwave, {
                Parent = v528, 
                RollOffMaxDistance = 800
            });
            if v526 ~= v526 then
                v526 = Vector3.new(0, 1, 0, 0);
            end;
            local v535 = CFrame.lookAt(v528.Position, v528.Position + v526);
            local v536 = v529.CryShockwaveTemplate:Clone();
            v536.Anchored = true;
            v536.Size = Vector3.new(v530.Min, v530.Min, 3) * v531;
            v536.CFrame = v535;
            v536.Name = ("%*666Shockwave"):format(v525.Player.Name);
            v536.Parent = workspace.Map.Ingame;
            v5:Create(v536, TweenInfo.new(v532, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = Vector3.new(v530.Max, v530.Max, 1) * v531, 
                CFrame = v535 * CFrame.new(0, 0, -v533), 
                Transparency = 1
            }):Play();
            v5:Create(v536.VFX, TweenInfo.new(v532 + 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
            game.Debris:AddItem(v536, v532 + 0.3);
            local v537 = false;
            local v542 = v10:CreateHitbox(v525.Player, {
                Size = function() --[[ Line: 2479 ]] --[[ Name: Size ]]
                    -- upvalues: v536 (copy)
                    return v536.Size;
                end, 
                CFrame = function() --[[ Line: 2480 ]] --[[ Name: CFrame ]]
                    -- upvalues: v536 (copy)
                    return v536.CFrame;
                end, 
                Damage = v525.Hunting and v525.Config.CryHuntingDamage or v525.Config.CryDamage, 
                Time = v532, 
                HitMultiple = true, 
                IsProjectile = true, 
                DeathProfile = {
                    Velocity = (v526 + Vector3.new(0, 0.20000000298023224, 0, 0)) * 700
                }, 
                Connections = {
                    Hit = function(v538, v539) --[[ Line: 2490 ]] --[[ Name: Hit ]]
                        -- upvalues: v11 (ref), v529 (copy), v534 (copy), v531 (copy), v88 (ref), v527 (copy), v525 (copy), v12 (ref), v537 (ref), v13 (ref)
                        local v540 = game.Players:GetPlayerFromCharacter(v538);
                        v11:ApplyStatus(v538, "Blindness", {
                            Level = v529.CrySlowness, 
                            Duration = v534
                        });
                        if v531 ~= 1 and v538:IsDescendantOf(workspace.Players.Survivors) then
                            v88(v527, v525.Config.CryHuntSelfStatuses);
                        end;
                        v525.Behavior.Highlight(v525, v538, v529.CryHighlightDuration);
                        if v540 then
                            v12:FireClientConnection(v540, ("%*666ShockwaveHit"):format(v525.Player.Name), "REMOTE_EVENT");
                        end;
                        if not v538:IsDescendantOf(workspace.Players.Survivors) then
                            return;
                        else
                            if v11:PlayerHasStatus(v538, "Hemmorhage") then
                                for v541 = 1, v525.Config.CryOrbDrop do
                                    v525.Behavior.SpawnBloodOrb(v525, v538.PrimaryPart.Position + Vector3.new(math.random(-1.5, 1.5), math.random(-1.5, 1.5), math.random(-1.5, 1.5)), v538);
                                end;
                                if not v537 then
                                    v13:IncrementActorStats(v525.Player, {
                                        Action = "Hit Hemmorhaged Survivor with Infernal Cry", 
                                        RewardType = "EasyKillerAction"
                                    });
                                end;
                            elseif not v537 then
                                v13:IncrementActorStats(v525.Player, {
                                    Action = "Hit Survivor with Infernal Cry", 
                                    RewardType = "EasyKillerAction"
                                });
                            end;
                            v537 = true;
                            return;
                        end;
                    end
                }
            });
            return;
        end;
    end;
    v1.SpawnBloodOrb = function(v543, v544, v545) --[[ Line: 2530 ]] --[[ Name: SpawnBloodOrb ]]
        if not v543 or not v543.Behavior or not v543.BloodContainer or not v543.BloodContainer.Parent or not v543.BloodOrbs then
            return;
        else
            local v546 = v543.Config.BloodOrbTemplate:Clone();
            v546.Parent = v543.BloodContainer;
            v546.CFrame = CFrame.new(v544);
            v546.Anchored = false;
            v546:SetNetworkOwner(v543.Player);
            for v547, v548 in ipairs(v546:GetDescendants()) do
                if v548:IsA("BasePart") then
                    v548.Anchored = false;
                    v548:SetNetworkOwner(v543.Player);
                end;
            end;
            game.Debris:AddItem(v546, 60);
            local v549 = Instance.new("Attachment", v546);
            local v550 = Instance.new("AlignPosition", v546);
            v550.Mode = Enum.PositionAlignmentMode.OneAttachment;
            v550.MaxForce = 1e999;
            v550.Responsiveness = 200;
            v550.MaxVelocity = 0;
            v550.Position = v546.Position;
            v550.Attachment0 = v549;
            v543.BloodOrbs[v546] = {
                Character = v545, 
                Spawned = tick()
            };
            v546:AddTag((("%*BloodOrb"):format(v543.Player.Name)));
            return;
        end;
    end;
    v1.GiveBlood = function(v551, v552) --[[ Line: 2571 ]] --[[ Name: GiveBlood ]]
        -- upvalues: v2 (copy), v6 (copy), v78 (copy)
        if math.clamp(v551.Blood + v552, 0, v551.MaxBlood) == v551.LastBlood then
            return;
        else
            v551.Blood = math.clamp(v551.Blood + v552, 0, v551.MaxBlood);
            local v553 = false;
            if v551.Blood == v551.MaxBlood then
                v553 = not v551.Hunting;
                if v553 then
                    local v554;
                    if v2:IsClient() then
                        v554 = false;
                    else
                        local v555 = require(v6.Server.Systems.Core.RoundManager);
                        v554 = v555 and v555.CurrentSession and v555.CurrentSession.LastSurvivorAlive and true or false;
                    end;
                    v553 = not v554;
                end;
            end;
            if v553 then
                v551.BloodCooldownData = {
                    v551:IsOnCooldown("BloodHunt") or 0, 
                    tick()
                };
                v551:SetCooldownOf("BloodHunt", 0);
            elseif not v553 and v551.BloodCooldownData then
                local v556 = tick() - v551.BloodCooldownData[2];
                v551:SetCooldownOf("BloodHunt", (math.max(v551.BloodCooldownData[1] - v556, 0)));
                v551.BloodCooldownData = nil;
            end;
            v78(v551, "BLOOD", v551.Blood, v551.MaxBlood);
            v551.LastBlood = v551.Blood;
            return;
        end;
    end;
    v1.CollectOrb = function(v557, v558) --[[ Line: 2594 ]] --[[ Name: CollectOrb ]]
        -- upvalues: v8 (copy), v9 (copy)
        local v559 = v557.BloodOrbs or {};
        v557.Behavior.GiveBlood(v557, v557.Config.BloodOrbGive);
        v8:Play(v557.Config.Sounds.BloodOrbCollect, {
            Parent = v557.Rig.PrimaryPart
        });
        local v560 = v559[v558];
        if v560 and v9:IsAlive(v560.Character) then
            local v561 = v557.Behavior.IsHighlighted(v557, v560.Character);
            if not v561 or v561 < v557.Config.BloodOrbHighlightDuration then
                v557.Behavior.Highlight(v557, v560.Character, v557.Config.BloodOrbHighlightDuration);
            end;
        end;
        for v562, v563 in pairs(v557.Behavior.Abilities) do
            local v564 = v557:IsOnCooldown(v562);
            if v564 then
                v557:SetCooldownOf(v562, (math.max(v564 - v557.Config.BloodOrbCooldownReduction, 0)));
            end;
        end;
        v559[v558] = nil;
        v558:Destroy();
    end;
    v1.Highlight = function(v565, v566, v567) --[[ Line: 2628 ]] --[[ Name: Highlight ]]
        -- upvalues: v9 (copy)
        v567 = v567 or 10;
        v566 = typeof(v566) == "table" and v566.Rig or v566;
        v9:RevealPlayerAuraTo(v565.Player, v566, v567, v565.Config.HighlightColor or Color3.new(0.9, 0, 0));
        v566:AddTag(v565.Player.Name .. "666Highlight");
        v565.Highlights[v566] = {
            tick(), 
            v567
        };
    end;
    v1.IsHighlighted = function(v568, v569) --[[ Line: 2637 ]] --[[ Name: IsHighlighted ]]
        v569 = typeof(v569) == "table" and v569.Rig or v569;
        local v570 = v568.Highlights and v568.Highlights[v569];
        local v571 = v570 and v570[3];
        return v570 and tick() - v570[1] <= v570[2], v571;
    end;
    return v1;
end;