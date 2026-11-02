-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = require(game.ReplicatedStorage.GlobalTypes);
local v1 = {};
local v2 = game:GetService("ReplicatedStorage");
local v3 = game:GetService("RunService");
local v4 = game:GetService("TweenService");
local v5 = game:GetService("Players");
local v6 = game:GetService("Debris");
local v7 = game:GetService("Lighting");
local v8 = game:GetService("CollectionService");
local v9 = game:GetService("UserInputService");
local v10 = require(v2.Modules.Sounds);
local v11 = require(v2.Modules.Actors);
local v12 = require(v2.Modules.Ragdolls);
local v13 = require(v2.Modules.Schematics.Lighting);
local v14 = require(v2.Modules.Util);
local v15 = require(v2.Systems.Character.Game.Sprinting);
local v16 = require(v2.Modules.Hitboxes);
local v17 = require(v2.Modules.Misc.Maid);
local v18 = require(v2.Modules.Statuses);
local v19 = require(v2.Modules.Network);
local v20 = require(v2.Modules.AchievementUtil);
local v21 = require(v2.Modules.Projectiles);
local v22 = math.random;
local v23 = table.insert;
local v24 = table.sort;
local v25 = task.wait;
local v26 = task.spawn;
local v27 = task.delay;
local v28 = coroutine.close;
local v29 = v3:IsClient();
local v30 = v3:IsServer();
local v31 = v3:IsStudio();
local v32 = TweenInfo.new(1);
local v33 = Random.new();
local v34 = TweenInfo.new(0.2);
local v35 = v29 and v5.LocalPlayer;
local v36 = v29 and workspace.CurrentCamera;
local v37 = {
    {
        Text = "W", 
        KeyCode = Enum.KeyCode.W
    }, 
    {
        Text = "A", 
        KeyCode = Enum.KeyCode.A
    }, 
    {
        Text = "S", 
        KeyCode = Enum.KeyCode.S
    }, 
    {
        Text = "D", 
        KeyCode = Enum.KeyCode.D
    }
};
local v38 = {
    {
        Text = "", 
        KeyCode = Enum.KeyCode.DPadDown
    }, 
    {
        Text = "", 
        KeyCode = Enum.KeyCode.DPadRight
    }, 
    {
        Text = "", 
        KeyCode = Enum.KeyCode.DPadUp
    }, 
    {
        Text = "", 
        KeyCode = Enum.KeyCode.DPadLeft
    }
};
local v39 = {
    [Enum.KeyCode.DPadLeft] = "rbxasset://textures/ui/Controls/DefaultController/DPadLeft@3x.png", 
    [Enum.KeyCode.DPadUp] = "rbxasset://textures/ui/Controls/DefaultController/DPadUp@3x.png", 
    [Enum.KeyCode.DPadDown] = "rbxasset://textures/ui/Controls/DefaultController/DPadDown@3x.png", 
    [Enum.KeyCode.DPadRight] = "rbxasset://textures/ui/Controls/DefaultController/DPadRight@3x.png"
};
local function v41(v40) --[[ Line: 66 ]] --[[ Name: __displayWarn ]]
    -- upvalues: v31 (copy)
    if v31 then
        warn((("[Nosferatu]: %*"):format(v40)));
    end;
end;
local function v44(v42, v43) --[[ Line: 72 ]] --[[ Name: __flRandom ]]
    return v42 + Random.new():NextNumber() * (v43 - v42);
end;
local function v46(v45) --[[ Line: 76 ]] --[[ Name: flattenVector ]]
    if v45.Magnitude <= 0.001 then
        return (Vector3.new(0, 0, 0, 0));
    else
        return Vector3.new(v45.X, 0, v45.Z).Unit;
    end;
end;
local function v51(v47) --[[ Line: 84 ]] --[[ Name: __getCharacterMass ]]
    local v48 = 0;
    for v49, v50 in ipairs(v47:GetChildren()) do
        if v50:IsA("BasePart") and not v50.Massless then
            v48 = v48 + v50.Mass;
        end;
    end;
    return v48;
end;
local function v55(v52, v53, v54) --[[ Line: 95 ]] --[[ Name: changeProp ]]
    if v52[v53] ~= v54 then
        v52[v53] = v54;
    end;
end;
local function v59(v56, v57, v58) --[[ Line: 101 ]] --[[ Name: alphaSequence ]]
    v56 = math.clamp(v56, 0, 1);
    if v56 <= 0.001 then
        return ColorSequence.new(v58);
    elseif v56 >= 0.999 then
        return ColorSequence.new(v57);
    else
        return (ColorSequence.new({
            ColorSequenceKeypoint.new(0, v57), 
            ColorSequenceKeypoint.new(v56, v57), 
            ColorSequenceKeypoint.new(v56 + 0.001, v58), 
            ColorSequenceKeypoint.new(1, v58)
        }));
    end;
end;
local function v66(v60, v61, v62, ...) --[[ Line: 128 ]] --[[ Name: __pcallMethod ]]
    local v63 = if ... then {
        ...
    } else nil;
    local v64, v65 = pcall(function() --[[ Line: 130 ]]
        -- upvalues: v62 (copy), v60 (copy), v63 (copy)
        if v62.Behavior[v60] then
            return v62.Behavior[v60](v62.Behavior, v62, if v63 then unpack(v63) else nil);
        else
            return;
        end;
    end);
    if not v64 then
        warn((("[%*]: Failed to call .%*() due to: %*"):format(v61, v60, v65)));
        return;
    else
        return v65;
    end;
end;
local function v70(v67, v68, ...) --[[ Line: 148 ]] --[[ Name: cWait ]]
    -- upvalues: v3 (copy)
    local v69 = os.clock();
    while true do
        if os.clock() - v69 < v67 then
            if v68(...) then
                return true;
            else
                v3.PostSimulation:Wait();
            end;
        elseif v68(...) then
            return true;
        else
            return false;
        end;
    end;
end;
local function v75(v71, v72) --[[ Line: 162 ]] --[[ Name: __applyStatusesFromDict ]]
    -- upvalues: v18 (copy)
    for v73, v74 in pairs(v72) do
        v18:ApplyStatus(v71, v73, v74);
    end;
end;
local function v80(v76, v77, v78) --[[ Line: 171 ]] --[[ Name: __playSound ]]
    -- upvalues: v14 (copy), v10 (copy)
    local v79 = v14:CopyTable(v78 or {
        PlaybackSpeed = 0.975 + Random.new():NextNumber() * 0.04999999999999993, 
        Volume = 0.35
    });
    v79.Parent = v76.Rig.PrimaryPart;
    return v10:Play(v76.Config.Sounds[v77], v79);
end;
local function v83(v81) --[[ Line: 183 ]] --[[ Name: __getStunValidator ]]
    -- upvalues: v14 (copy)
    return function(v82) --[[ Line: 184 ]]
        -- upvalues: v14 (ref)
        if v14:IsAlive(v82.Rig) and not v82.Rig:GetAttribute("Stunned") then
            return false;
        else
            return true;
        end;
    end;
end;
local function v87(v84) --[[ Line: 189 ]] --[[ Name: clearMovers ]]
    for v85, v86 in ipairs(v84.Rig.PrimaryPart:GetChildren()) do
        if v86:IsA("BodyMover") and not v86:GetAttribute("Perm") then
            v86:Destroy();
        end;
    end;
end;
local function v94(v88, v89, v90) --[[ Line: 197 ]] --[[ Name: createAntiGravity ]]
    -- upvalues: v51 (copy), v26 (copy), v14 (copy), v3 (copy)
    local v91 = v88:FindFirstChild("Humanoid");
    if not v91 then
        return;
    else
        local v92 = os.clock();
        local v93 = Instance.new("BodyForce", v88.PrimaryPart);
        v93.Force = Vector3.new(0, v51(v88) * workspace.Gravity * v89, 0);
        v26(function() --[[ Line: 204 ]]
            -- upvalues: v93 (copy), v14 (ref), v91 (copy), v92 (copy), v90 (copy), v3 (ref)
            while v93.Parent and v14:IsAlive(v91.Parent) and (os.clock() - v92 < 0.5 or v91.FloorMaterial == Enum.Material.Air) and os.clock() - v92 < (v90 or 1e999) do
                v3.Heartbeat:Wait();
            end;
            if v93 then
                v93:Destroy();
            end;
        end);
        return v93;
    end;
end;
local function v96(v95) --[[ Line: 217 ]] --[[ Name: cl_onBloodhookCaught ]]

end;
local function v137(v97) --[[ Line: 221 ]] --[[ Name: cl_bloodhookQTEBegin ]]
    -- upvalues: v35 (copy), v14 (copy), v38 (copy), v37 (copy), v4 (copy), v26 (copy), v9 (copy), v27 (copy), v3 (copy), v10 (copy), v19 (copy), v39 (copy)
    if v97.Meta.ActiveQTE then
        v97.Meta.ActiveQTE:Destroy();
    end;
    local v98 = v35:GetAttribute("Device") or "PC";
    local v99 = v98 == "Mobile";
    local v100 = if not v99 then v14:CopyTable(if v98 == "Console" then v38 else v37) else nil;
    local v101 = if not v99 then {} else nil;
    if v98 == "Console" then
        workspace:SetAttribute("GamepadDisabled", true);
    end;
    if not v99 then
        for v102, v103 in ipairs(v100) do
            v101[v103.KeyCode] = true;
        end;
    end;
    local v104 = v97.Config.Uppercut.QTEFrame:Clone();
    v104.Title.TextTransparency = 1;
    v4:Create(v104.Title, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        TextTransparency = 0
    }):Play();
    v104.Parent = v35.PlayerGui.TemporaryUI;
    v97.Meta.ActiveQTE = v104;
    v26(function() --[[ Line: 248 ]]
        -- upvalues: v99 (copy), v9 (ref), v101 (copy), v104 (copy), v35 (ref), v97 (copy), v4 (ref), v27 (ref), v3 (ref), v10 (ref), v19 (ref), v100 (copy), v39 (ref), v98 (copy)
        local v105 = nil;
        local v108 = if v99 then nil else v9.InputBegan:Connect(function(v106, v107) --[[ Line: 250 ]]
            -- upvalues: v101 (ref), v105 (ref)
            if v107 then
                return;
            elseif not v106.KeyCode or not v101[v106.KeyCode] then
                return;
            else
                v105 = v106;
                return;
            end;
        end);
        local function v109() --[[ Line: 256 ]] --[[ Name: guard ]]
            -- upvalues: v104 (ref), v35 (ref), v97 (ref)
            if v104 and v104.Parent == v35.PlayerGui.TemporaryUI and v97 and v97.Meta and v97.Meta.ActiveQTE == v104 then
                return true;
            else
                return false;
            end;
        end;
        v104.Title.Position = if v99 then UDim2.fromScale(0.5, 0.5) else UDim2.fromScale(0.5, 0.25);
        if v35 == v97.Player then
            v104.Title.Text = "Reel it in";
        end;
        local v110 = v104.Position;
        local v111 = 1;
        local v112 = nil;
        local v113 = nil;
        local v114 = nil;
        local v115 = TweenInfo.new(0.22, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
        local v116 = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
        v104.PC.Image = "rbxasset://textures/ui/Controls/key_single@3x.png";
        v104.PC.Visible = false;
        task.wait(0.5);
        while if v104 then v104.Parent == v35.PlayerGui.TemporaryUI and if v97 and v97.Meta then v97.Meta.ActiveQTE == v104 else false else false do
            if v99 then
                local v117 = os.clock();
                local v118 = false;
                local v119 = v104.Mobile:Clone();
                local v120 = v4:Create(v119, v115, {
                    Size = UDim2.fromScale(0.5, 0.5)
                });
                local v121 = v4:Create(v119, v116, {
                    Size = UDim2.fromScale(0, 0)
                });
                v119.Visible = true;
                v119.Name = "ActiveButton";
                v119.Position = UDim2.fromScale(-0.8 + Random.new():NextNumber() * 1.6, -0.8 + Random.new():NextNumber() * 1.6);
                v119.Size = UDim2.fromScale(0.15, 0.15);
                v119.Parent = v104;
                v119.MouseButton1Down:Connect(function() --[[ Line: 291 ]]
                    -- upvalues: v118 (ref)
                    v118 = true;
                end);
                v120:Play();
                v27(0.22, function() --[[ Line: 296 ]]
                    -- upvalues: v119 (copy), v104 (ref), v121 (copy)
                    if v119.Parent ~= v104 then
                        return;
                    else
                        v121:Play();
                        return;
                    end;
                end);
                while (if v104 then v104.Parent == v35.PlayerGui.TemporaryUI and if v97 and v97.Meta then v97.Meta.ActiveQTE == v104 else false else false) and not v118 and os.clock() - v117 < 1.02 do
                    local v122 = v104;
                    local v123 = UDim2.fromScale;
                    local v124 = -v111;
                    local v125 = (v124 + Random.new():NextNumber() * (v111 - v124)) / 1200;
                    local v126 = -v111;
                    v122.Position = v110 + v123(v125, (v126 + Random.new():NextNumber() * (v111 - v126)) / 1200);
                    v111 = math.max(v111 - v3.Heartbeat:Wait() * 7, 1);
                end;
                if v119 then
                    v119:Destroy();
                end;
                if not if v104 then v104.Parent == v35.PlayerGui.TemporaryUI and if v97 and v97.Meta then v97.Meta.ActiveQTE == v104 else false else false then
                    return;
                else
                    v10:Play(v97.Config.Sounds[("QTE%*"):format(v118 and "Succeed" or "Fail")]);
                    v19:FireServerConnection(("%*NosHookQTE"):format(v97.Player.Name), "REMOTE_EVENT", v118);
                    --[[ close >= 11 ]]
                end;
            else
                v105 = nil;
                local v127 = {};
                for v128, v129 in ipairs(v100) do
                    if v129 ~= v113 then
                        table.insert(v127, v129);
                    end;
                end;
                local v130 = v113 or v127[math.random(1, #v127)];
                v113 = v127[math.random(1, #v127)];
                v112 = v114 or v104.PC:Clone();
                if v114 ~= v112 then
                    v112.Size = UDim2.fromScale(0, 0);
                    v112.ImageTransparency = 1;
                    v112.TextLabel.TextTransparency = 1;
                end;
                v112.Parent = v104;
                v112.TextLabel.Text = v130.Text;
                v112.Image = if v39[v130.KeyCode] then v39[v130.KeyCode] else v112.Image;
                v112.Visible = true;
                v4:Create(v112, v115, {
                    Size = UDim2.fromScale(0.31, 0.5), 
                    Position = UDim2.fromScale(0.5, 0.748), 
                    ImageTransparency = 0
                }):Play();
                v4:Create(v112.TextLabel, v115, {
                    TextTransparency = 0
                }):Play();
                v114 = v104.PC:Clone();
                v114.Size = UDim2.fromScale(0.1, 0.15);
                v114.Position = UDim2.fromScale(0.9, 0.848);
                v114.ImageTransparency = 1;
                v114.Image = if v39[v113.KeyCode] then v39[v113.KeyCode] else v114.Image;
                v114.TextLabel.TextTransparency = 1;
                v114.TextLabel.Text = v113.Text;
                v114.Parent = v104;
                v114.Visible = true;
                v4:Create(v114, v115, {
                    Size = UDim2.fromScale(0.2, 0.3), 
                    Position = UDim2.fromScale(0.8, 0.848), 
                    ImageTransparency = 0.5
                }):Play();
                v4:Create(v114.TextLabel, v115, {
                    TextTransparency = 0.5
                }):Play();
                while (if v104 then v104.Parent == v35.PlayerGui.TemporaryUI and if v97 and v97.Meta then v97.Meta.ActiveQTE == v104 else false else false) and not v105 do
                    local v131 = v104;
                    local v132 = UDim2.fromScale;
                    local v133 = -v111;
                    local v134 = (v133 + Random.new():NextNumber() * (v111 - v133)) / 1200;
                    local v135 = -v111;
                    v131.Position = v110 + v132(v134, (v135 + Random.new():NextNumber() * (v111 - v135)) / 1200);
                    v111 = math.max(v111 - v3.Heartbeat:Wait() * 7, 1);
                end;
                if if v104 then v104.Parent == v35.PlayerGui.TemporaryUI and if v97 and v97.Meta then v97.Meta.ActiveQTE == v104 else false else false then
                    local v136 = v105.KeyCode == v130.KeyCode;
                    if not v136 then
                        v111 = 7;
                    end;
                    v4:Create(v112, v115, {
                        Size = UDim2.fromScale(0, 0), 
                        Position = UDim2.fromScale(0.2, 0.848), 
                        ImageTransparency = 1, 
                        ImageColor3 = if v136 then Color3.new(0, 1, 0) else Color3.new(1, 0, 0)
                    }):Play();
                    v4:Create(v112.TextLabel, v115, {
                        TextTransparency = 1
                    }):Play();
                    game.Debris:AddItem(v112, 0.4);
                    v10:Play(v97.Config.Sounds[("QTE%*"):format(v136 and "Succeed" or "Fail")]);
                    v19:FireServerConnection(("%*NosHookQTE"):format(v97.Player.Name), "REMOTE_EVENT", v136);
                else
                    break;
                end;
            end;
        end;
        if v98 == "Console" then
            workspace:SetAttribute("GamepadDisabled", false);
        end;
        v108:Disconnect();
    end);
end;
local function v139(v138) --[[ Line: 390 ]] --[[ Name: cl_bloodhookQTEEnd ]]
    if v138.Meta.ActiveQTE then
        v138.Meta.ActiveQTE:Destroy();
    end;
end;
local function v141(v140) --[[ Line: 396 ]] --[[ Name: cl_airSlashStop ]]
    -- upvalues: v19 (copy), v3 (copy)
    if not v140.State.Slashing then
        return;
    else
        v140.State.DescentStoppers.Slash = nil;
        v140.State.Slashing = false;
        v140.Animations.BatBiteLoop:Stop(0);
        v140.Animations.BatBiteWindup:Stop(0);
        v19:FireServerConnection(("%*NosAirDiveLand"):format(v140.Player.Name), "REMOTE_EVENT");
        v3:UnbindFromRenderStep("AirSlash");
        return;
    end;
end;
local function v156(v142) --[[ Line: 411 ]] --[[ Name: cl_airSlashBegin ]]
    -- upvalues: v87 (copy), v3 (copy), v141 (copy)
    v87(v142);
    v142.State.DescentStoppers.Slash = true;
    local v143 = os.clock();
    local v144 = v142.Config.AscentBite.Speed;
    local v145 = v142.Rig.Humanoid;
    local v146 = Instance.new("BodyVelocity", v142.Rig.PrimaryPart);
    v146.MaxForce = Vector3.new(10000000, 10000000, 10000000, 0);
    v146.P = 1e999;
    v146.Velocity = Vector3.new(0, 0, 0, 0);
    v142.Animations.BatBiteLoop:Play(0);
    v142.Animations.BatBiteWindup:Play(0, nil, 0.75);
    v142.State.Slashing = true;
    local v147 = workspace.CurrentCamera.CFrame.LookVector;
    local v148 = (if v147.Magnitude <= 0.001 then Vector3.new(0, 0, 0, 0) else Vector3.new(v147.X, 0, v147.Z).Unit).Unit;
    local v149 = v148;
    v3:BindToRenderStep("AirSlash", 1, function(v150) --[[ Line: 433 ]]
        -- upvalues: v143 (copy), v142 (copy), v145 (copy), v146 (copy), v141 (ref), v149 (ref), v148 (ref), v144 (copy)
        local v151 = os.clock() - v143;
        if v142.Config.AscentBite.Windup + 0.1 < v151 and (v145.FloorMaterial ~= Enum.Material.Air or not v146 or v142.Rig.PrimaryPart.Anchored) then
            if v146 then
                v146:Destroy();
            end;
            v141(v142);
            return;
        elseif v151 < v142.Config.AscentBite.Windup then
            v146.Velocity = Vector3.new(0, 0, 0, 0);
            return;
        else
            local v152 = workspace.CurrentCamera.CFrame.LookVector;
            v149 = Vector3.new(v152.X, 0, v152.Z).Unit;
            local v153 = v149 - v148;
            local v154 = v153.Magnitude;
            if v154 > 0 then
                local v155 = v142.Config.AscentBite.TurnSpeed * v150;
                if v154 <= v155 then
                    v148 = v149;
                else
                    v148 = v148 + v153.Unit * v155;
                end;
                v148 = v148.Unit;
            end;
            v146.Velocity = (Vector3.new(0, -1, 0, 0) + v148).Unit * v144;
            return;
        end;
    end);
end;
local function v163(v157, v158) --[[ Line: 472 ]] --[[ Name: cl_endFlight ]]
    -- upvalues: v14 (copy), v1 (copy), v87 (copy), v3 (copy), v15 (copy), v19 (copy), v156 (copy)
    v157.State.InFlight = false;
    v157.State.RemainingDescent = 5;
    v14:ToggleSprinting("NosFly", true);
    local v159 = v1.Abilities.Ascent;
    local v160 = v157.Behavior.Abilities.Ascent;
    local v161 = not v160.CurrentCharges or v160.CurrentCharges > 0;
    v160.Name = v159.Name;
    v160.Icon = v159.Icon;
    v160.ChargesDisabled = false;
    v14:ToggleLockForAbilityIcon("Ascent", "NoCharges", not v161);
    v87(v157);
    local v162 = v157.Rig:FindFirstChild("Humanoid");
    v3:UnbindFromRenderStep("NosFlight");
    v15.StaminaGain = v157.Config.StaminaGain;
    v15.Stamina = math.clamp(v15.Stamina - 25, v15.MinStamina, v15.MaxStamina);
    v19:FireServerConnection(("%*NosEndFlight"):format(v157.Player.Name), "REMOTE_EVENT", v158);
    v157.Animations.BatAirLoop:Stop(0);
    v157.Animations.BatFloorLoop:Stop(0);
    v157.Animations.BatStart:Stop(0);
    if v158 then
        v156(v157);
    end;
end;
local function v185(v164) --[[ Line: 507 ]] --[[ Name: cl_beginFlight ]]
    -- upvalues: v87 (copy), v51 (copy), v14 (copy), v1 (copy), v15 (copy), v35 (copy), v2 (copy), v4 (copy), v3 (copy), v163 (copy)
    v164.State.InFlight = true;
    v87(v164);
    local v165 = Instance.new("BodyForce", v164.Rig.PrimaryPart);
    v165.Force = Vector3.new(0, v51(v164.Rig) * workspace.Gravity * 0.5, 0);
    v14:ToggleSprinting("NosFly", false);
    local v166 = v1.Abilities.Ascent;
    local v167 = v164.Behavior.Abilities.Ascent;
    if v167.CurrentCharges then
        local v168 = v167.CurrentCharges > 0;
    end;
    v167.Name = v166.SpecialName;
    v167.Icon = v166.SpecialIcon;
    v167.ChargesDisabled = true;
    v14:ToggleLockForAbilityIcon("Ascent", "NoCharges", false);
    v15.StaminaGain = 0;
    if not v164.Meta.FlyTutorialFlag then
        v164.Meta.FlyTutorialFlag = true;
        local v169 = v35:GetAttribute("Device") or "PC";
        local v170 = v169 == "PC" and "Space" or v169 == "Console" and "A" or "Sprint";
        v14:CreateWarning("Sk8SprayFail", (("Hold [%*] to float. Release to ascend. Use Slash to perform a diving attack."):format(v170)));
    end;
    local v171 = require(game.Players.LocalPlayer.PlayerScripts.PlayerModule.ControlModule);
    local v172 = require(v2.Systems.Player.Game.SmoothShiftLock);
    local v173 = v164.Rig.PrimaryPart;
    local v174 = os.clock();
    local v175 = os.clock();
    local v176 = v164.Config.AscentFlight;
    v164.HeldAbilities.Ascent = false;
    for v177, v178 in pairs(workspace.Players.Survivors:GetChildren()) do
        v14:RevealPlayerAura(v178, v176.AuraDuration);
    end;
    v164.Animations.BatStart:Play();
    local v179 = nil;
    local v180 = v14:CreateSpeedMultiplier(v164.Rig, 1, "NosFlySlow");
    local v181 = v4:Create(v180, TweenInfo.new(0.4), {
        Value = 1
    });
    local v182 = v4:Create(v180, TweenInfo.new(0.1), {
        Value = v176.GroundSlowness
    });
    v3:BindToRenderStep("NosFlight", 2, function() --[[ Line: 557 ]]
        -- upvalues: v174 (copy), v176 (copy), v164 (copy), v165 (copy), v163 (ref), v179 (ref)
        local v183 = os.clock() - v174;
        if v176.Duration < v183 or v183 > 1 and (v164.HeldAbilities.Ascent or v164.HeldAbilities.Slash) then
            v165:Destroy();
            v163(v164, v164.HeldAbilities.Slash and true or false);
            return;
        else
            local v184 = v164.Rig.Humanoid.FloorMaterial == Enum.Material.Air;
            if v184 ~= v179 then
                if v184 then
                    v164.Animations.BatAirLoop:Play(0.1);
                    v164.Animations.BatFloorLoop:Stop(0.1);
                else
                    v164.Animations.BatFloorLoop:Play(0.1);
                    v164.Animations.BatAirLoop:Stop(0.1);
                end;
            end;
            v179 = v184;
            return;
        end;
    end);
end;
local function v208(v186) --[[ Line: 579 ]] --[[ Name: cl_cataclysmStart ]]
    -- upvalues: v14 (copy), v2 (copy), v3 (copy)
    v14:ToggleSprinting("Cataclysm", false);
    local v187 = require(game.Players.LocalPlayer.PlayerScripts.PlayerModule.ControlModule);
    local v188 = require(v2.Systems.Player.Game.SmoothShiftLock);
    local v189 = workspace.CurrentCamera;
    local v190 = v189.CFrame.LookVector;
    local v191 = if v190.Magnitude <= 0.001 then Vector3.new(0, 0, 0, 0) else Vector3.new(v190.X, 0, v190.Z).Unit;
    local v192 = Vector3.new(0, 0, 0, 0);
    local v193 = os.clock();
    local v194 = v186.Rig.PrimaryPart;
    v194.AssemblyLinearVelocity = v194.AssemblyLinearVelocity + v191 * v186.Rig.Humanoid.WalkSpeed;
    v3:BindToRenderStep("NosCataclysm", Enum.RenderPriority.Character.Value + 1, function(v195) --[[ Line: 594 ]]
        -- upvalues: v193 (copy), v14 (ref), v186 (copy), v3 (ref), v188 (copy), v189 (copy), v187 (copy), v192 (ref), v191 (ref)
        local v196 = os.clock() - v193;
        if not v14:IsAlive(v186 and v186.Rig) or v186.Config.Spire.Duration < v196 then
            v3:UnbindFromRenderStep("NosCataclysm");
            if v186 and v186.Animations then
                v186.Animations.SpireLoop:Stop();
                v186.Animations.SpireEnd:Play();
            end;
            v14:ToggleSprinting("Cataclysm", true);
            return;
        else
            local v197 = if ((not not v188:IsEnabled() or v186.Rig.Head.LocalTransparencyModifier > 0.9) and "Camera" or "Keys") == "Camera" then v189.CFrame.LookVector else v189.CFrame:VectorToWorldSpace(v187:GetMoveVector());
            if v197 and v197.Magnitude > 0.001 then
                v197 = (v197 * Vector3.new(1, 0, 1, 0)).Unit;
                v192 = Vector3.new(v197.X, 0, v197.Z).Unit;
                local v198 = v186.Rig.PrimaryPart.CFrame;
                local v199 = CFrame.lookAt;
                local v200 = v198.Position;
                local v201 = v198.Position;
                local v202 = v191;
                v199 = v199(v200, v201 + (if v202.Magnitude <= 0.001 then Vector3.new(0, 0, 0, 0) else Vector3.new(v202.X, 0, v202.Z).Unit).Unit);
                v200 = v191;
                local v203 = v199.RightVector:Dot(v192);
                v201 = (-v199.RightVector):Dot(v192);
                local v204 = v199.LookVector:Dot(v192) > 0.999 and 0 or v201 < v203 and -1 or v203 < v201 and 1 or 1;
                if (v192 - v191).Magnitude > 0.005 then
                    local v205 = v186.Config.Spire.TurnControl * v195;
                    local v206 = math.acos((math.clamp(v199.LookVector:Dot(v192), -1, 1)));
                    local v207 = (v199 * CFrame.Angles(0, math.min(v206, v204 * v205), 0)).LookVector;
                    v191 = (if v207.Magnitude <= 0.001 then Vector3.new(0, 0, 0, 0) else Vector3.new(v207.X, 0, v207.Z).Unit).Unit;
                    if v191 ~= v191 then
                        v191 = v200;
                    end;
                end;
            end;
            v186.Rig.Humanoid:Move(v191);
            return;
        end;
    end);
end;
local function v217(v209) --[[ Line: 652 ]] --[[ Name: cl_ascentDash ]]
    -- upvalues: v87 (copy), v3 (copy), v36 (copy), v14 (copy)
    v87(v209);
    v209.State.DescentStoppers.Ascent = true;
    local v210 = os.clock();
    local v211 = v209.Rig.Humanoid;
    local v212 = v209.Config.Ascent;
    local v213 = Instance.new("BodyVelocity", v209.Rig.PrimaryPart);
    v213.MaxForce = Vector3.new(1, 1, 1, 0) * v212.Force;
    v213.P = 1e999;
    local v214 = Vector3.new(0, 1, 0, 0);
    v3:BindToRenderStep("AscentDash", 1, function() --[[ Line: 668 ]]
        -- upvalues: v210 (copy), v212 (copy), v214 (ref), v36 (ref), v14 (ref), v211 (copy), v209 (copy), v213 (ref), v3 (ref)
        local v215 = os.clock() - v210 - v212.Length;
        if v212.CanTurn then
            v214 = v36.CFrame.LookVector;
        end;
        if v214 ~= v214 then
            return;
        else
            local v216 = os.clock() - v210;
            if v14:IsAlive(v211.Parent) and v216 < v212.Length and not v209.State.InFlight and (v216 < 0.5 or v211.FloorMaterial == Enum.Material.Air) then
                v213.Velocity = v214 * v212.Speed;
                return;
            else
                if v213 then
                    v213:Destroy();
                    v213 = nil;
                end;
                v209.State.DescentStoppers.Ascent = nil;
                v3:UnbindFromRenderStep("AscentDash");
                return;
            end;
        end;
    end);
end;
local function v221(v218) --[[ Line: 694 ]] --[[ Name: sv_onHit ]]
    -- upvalues: v18 (copy)
    for v219, v220 in v218.Config.Bats.SelfStatuses do
        v18:RemoveStatus(v218.Rig, v219);
    end;
end;
local function v233(v222, v223) --[[ Line: 700 ]] --[[ Name: sv_toggleSurvivorCollisions ]]
    -- upvalues: v31 (copy), v14 (copy)
    if (v222.Cache.CollisionConstraints and true or false) == v223 then
        if v31 then
            warn("[Nosferatu]: sv_survivorCollisions, debounce clause triggered");
        end;
        return;
    elseif v223 then
        v222.Cache.CollisionConstraints = {};
        for v224, v225 in workspace.Players.Survivors:GetChildren() do
            if v14:IsAlive(v225) then
                for v226, v227 in {
                    v225:FindFirstChild("CollisionHitbox"), 
                    v225.PrimaryPart
                } do
                    if v227 ~= nil then
                        for v228, v229 in {
                            v222.Rig.PrimaryPart, 
                            v222.Rig:FindFirstChild("CollisionHitbox")
                        } do
                            if v229 then
                                local v230 = Instance.new("NoCollisionConstraint", v229);
                                v230.Part0 = v229;
                                v230.Part1 = v227;
                                table.insert(v222.Cache.CollisionConstraints, v230);
                            end;
                        end;
                    end;
                end;
            end;
        end;
        return;
    else
        for v231, v232 in v222.Cache.CollisionConstraints do
            v232:Destroy();
        end;
        table.clear(v222.Cache.CollisionConstraints);
        v222.Cache.CollisionConstraints = nil;
        return;
    end;
end;
local function v248(v234) --[[ Line: 741 ]] --[[ Name: sv_airSlash ]]
    -- upvalues: v80 (copy), v66 (copy), v10 (copy), v19 (copy), v27 (copy), v16 (copy), v14 (copy), v12 (copy), v75 (copy)
    v80(v234, "AscentBiteStart", {
        Parent = v234.Rig.PrimaryPart
    });
    v66("ToggleBatBiteWarning", "Nosferatu", v234, true);
    local v235 = ("%*NosAirDiveLand"):format(v234.Player.Name);
    local v236 = false;
    local v237 = nil;
    local v238 = v234.Config.AscentBite;
    v10:Play(v234.Config.Sounds.AscentBiteWarning, {
        Volume = 0.8, 
        RollOffMaxDistance = 600, 
        RollOffMinDistance = 50, 
        RollOffMode = Enum.RollOffMode.Linear
    });
    v19:SetConnection(v235, "REMOTE_EVENT", function(v239) --[[ Line: 752 ]]
        -- upvalues: v234 (copy), v237 (ref), v236 (ref)
        if v239 ~= v234.Player then
            v239:Kick("take a shower");
            return;
        elseif v237 then
            return;
        elseif v236 then
            return;
        else
            v236 = true;
            return;
        end;
    end);
    v27(v238.Windup - v234.Player:GetNetworkPing(), function() --[[ Line: 769 ]]
        -- upvalues: v80 (ref), v234 (copy), v16 (ref), v236 (ref), v237 (ref), v14 (ref), v66 (ref), v19 (ref), v235 (copy), v12 (ref), v238 (copy), v27 (ref), v75 (ref)
        local v240 = v80(v234, "AscentBiteLoop", {
            Parent = v234.Rig.PrimaryPart, 
            Looped = true
        });
        local v243 = v16:CreateHitbox(v234.Player, {
            Size = Vector3.new(7, 3, 7, 0), 
            CFrameOffset = CFrame.new(0, -1.5, -2.5), 
            Damage = 0, 
            Time = 9999, 
            Knockback = 2, 
            ExecuteOnKill = false, 
            HitMultiple = true, 
            Connections = {
                Hit = function(v241, v242) --[[ Line: 782 ]] --[[ Name: Hit ]]
                    -- upvalues: v236 (ref), v237 (ref), v14 (ref)
                    if v236 then
                        return;
                    elseif v237 then
                        return;
                    elseif not v14:GetEntityType(v241) then
                        return;
                    else
                        v237 = v241;
                        return;
                    end;
                end
            }
        });
        while v14:IsAlive(v234 and v234.Rig) and not v236 and not v237 do
            task.wait();
        end;
        v66("ToggleBatBiteWarning", "Nosferatu", v234, false);
        v19:RemoveConnection(v235, "REMOTE_EVENT");
        if v240 then
            v240:Destroy();
        end;
        if v243 then
            v243:Cancel();
        end;
        if not v14:IsAlive(v234 and v234.Rig) then
            return;
        else
            v66("BatDisappear", "Nosferatu", v234);
            if v237 then
                v80(v234, "AscentBiteHit", {
                    Parent = v234.Rig.PrimaryPart
                });
                local v244 = v14:GetActor(v237);
                v234:PivotTo(if v244 then v244:GetPivot() else v237:GetPivot());
                v14:SetUpCutscene(v234.Rig, v237, CFrame.new(0, 0, 0), "NosBite");
                v14:GiveInvincible(v234.Rig, "Bloodsucker", 2);
                local v245 = v14:LoadAnimationFromID(v237, v234.Config.Animations.BatBiteCutscene.Victim, true);
                v245:Play(0.05);
                v245.Priority = Enum.AnimationPriority.Action4;
                v234.Cache.BatBiteAnim.Priority = Enum.AnimationPriority.Action4;
                v234.Cache.BatBiteAnim:Play(0);
                v234.Cache.BatBiteAnim.TimePosition = v245.TimePosition;
                v12.AddProfile(v237, {
                    AnchorDelay = true, 
                    Applied = os.clock() + 100
                });
                task.delay(0.8, function() --[[ Line: 836 ]]
                    -- upvalues: v16 (ref), v234 (ref), v237 (ref), v238 (ref)
                    v16:CreateHitbox(v234.Player, {
                        Size = Vector3.new(4, 4, 4, 0), 
                        CFrame = v237 and v237.PrimaryPart and v237.PrimaryPart.CFrame or v234.Rig.PrimaryPart.CFrame, 
                        Damage = v238.Damage[1], 
                        Time = 0.1, 
                        Knockback = 0, 
                        HitMultiple = true
                    });
                end);
                task.delay(2.25, function() --[[ Line: 848 ]]
                    -- upvalues: v238 (ref), v12 (ref), v237 (ref), v234 (ref), v16 (ref), v14 (ref), v245 (copy)
                    local v246 = v238.Knockback;
                    v12.AddProfile(v237, {
                        Velocity = 7 * v234.Rig.PrimaryPart.CFrame.LookVector * v246 + Vector3.new(0, v246, 0)
                    });
                    v16:CreateHitbox(v234.Player, {
                        Size = Vector3.new(4, 4, 4, 0), 
                        CFrame = v237 and v237.PrimaryPart and v237.PrimaryPart.CFrame or v234.Rig.PrimaryPart.CFrame, 
                        Damage = v238.Damage[2], 
                        Time = 0.1, 
                        Knockback = 0, 
                        HitMultiple = true
                    });
                    if v237 and v237:IsDescendantOf(workspace) then
                        local v247 = v234.Rig.PrimaryPart.CFrame.LookVector * v246 + Vector3.new(0, v246, 0);
                        v14:ToggleAnchored(v237, "NosBite", false);
                        v14:RagdollLaunch(v234, v237, v247);
                    end;
                    v14:CreateSpeedMultiplier(v234.Rig, 0.01, "NosBiteCutsceneEndlag", v238.EndlagHit, true);
                    v245:Stop();
                    task.delay(v238.EndlagHit, function() --[[ Line: 874 ]]
                        -- upvalues: v234 (ref), v14 (ref)
                        v234.AbilitiesDisabled = false;
                        v14:ToggleAnchored(v234.Rig, "NosBite", false);
                    end);
                end);
                return;
            elseif v236 then
                v80(v234, "AscentBiteMiss", {
                    Parent = v234.Rig.PrimaryPart
                });
                v27(v238.EndlagMiss, function() --[[ Line: 883 ]]
                    -- upvalues: v234 (ref)
                    v234.AbilitiesDisabled = false;
                end);
                v75(v234.Rig, v238.MissedStatuses);
                v14:ApplyDamage(v234.Rig, 20);
                return;
            else
                warn("Something has gone terribly wrong here");
                return;
            end;
        end;
    end);
end;
local function v250(v249) --[[ Line: 894 ]] --[[ Name: sv_beginFlight ]]
    -- upvalues: v66 (copy), v80 (copy), v14 (copy)
    v66("BatAppear", "Nosferatu", v249);
    v80(v249, "AscentTransform");
    v249.Meta.FlightSound = v80(v249, "AscentFlyLoop", {
        Looped = true
    });
    v249.State.InFlight = true;
    v14:CreateSpeedMultiplier(v249.Rig, v249.Config.AscentFlight.Speed, "NosFlying");
    v14:GiveInvincible(v249.Rig, "NosFlight");
    v249.Rig:SetAttribute("ForcedMinChaseDistance", 60);
    v249.Rig:SetAttribute("ForcedMaxChaseDistance", 50);
end;
local function v253(v251, v252) --[[ Line: 906 ]] --[[ Name: sv_endFlight ]]
    -- upvalues: v14 (copy), v4 (copy), v18 (copy), v80 (copy), v248 (copy), v66 (copy), v75 (copy)
    v14:CreateSpeedMultiplier(v251.Rig, 10, "NosFlying", 0);
    if v251.Meta.FlightSound then
        v4:Create(v251.Meta.FlightSound, TweenInfo.new(0.3), {
            Volume = 0
        }):Play();
        game.Debris:AddItem(v251.Meta.FlightSound, 1);
        v251.Meta.FlightSound = nil;
    end;
    v18:RemoveStatus(v251.Rig, "Undetectable");
    v80(v251, "AscentDetransform");
    v251.State.InFlight = false;
    v14:RemoveInvincible(v251.Rig, "NosFlight");
    if v252 then
        v248(v251);
    else
        v66("BatDisappear", "Nosferatu", v251);
        v75(v251.Rig, v251.Config.AscentBite.MissedStatuses);
        task.delay(v251.Config.AscentFlight.Endlag, function() --[[ Line: 927 ]]
            -- upvalues: v251 (copy)
            v251.AbilitiesDisabled = false;
        end);
    end;
    v251.Rig:SetAttribute("ForcedMinChaseDistance", nil);
    v251.Rig:SetAttribute("ForcedMaxChaseDistance", nil);
end;
v1.OnIntroduction = function(v254, v255, v256, v257) --[[ Line: 936 ]] --[[ Name: OnIntroduction ]]
    -- upvalues: v5 (copy), v4 (copy)
    v5.LocalPlayer:SetAttribute("FOVMultipliersDisabled", true);
    local v258 = workspace.Misc:WaitForChild("KillerCutsceneBackground", 3);
    if not v258 then
        warn((("[%*]: No killer background??"):format((script:GetFullName()))));
    end;
    task.delay(1.66, function() --[[ Line: 943 ]]
        -- upvalues: v258 (copy), v4 (ref)
        local v259 = v258 and v258:FindFirstChild("thechairthatmoves");
        if not v259 and not v259.PrimaryPart then
            warn((("[%*]: No chair here??"):format((script:GetFullName()))));
            return;
        else
            v4:Create(v259.PrimaryPart, TweenInfo.new(0.39, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                CFrame = CFrame.new(v259.PrimaryPart.Position + Vector3.new(4.570000171661377, 0, 1.7100000381469727, 0)) * CFrame.Angles(0, 2.792526803190927, 0)
            }):Play();
            return;
        end;
    end);
    workspace.CurrentCamera.FieldOfView = 20;
    task.delay(v257, function() --[[ Line: 958 ]]
        -- upvalues: v5 (ref)
        v5.LocalPlayer:SetAttribute("FOVMultipliersDisabled", nil);
    end);
end;
v1.OnVictory = function(v260, v261, v262, v263, v264) --[[ Line: 963 ]] --[[ Name: OnVictory ]]
    -- upvalues: v5 (copy), v14 (copy)
    if v261 == "Start" then
        v5.LocalPlayer:SetAttribute("FOVMultipliersDisabled", true);
        workspace.CurrentCamera.FieldOfView = 30;
        task.spawn(function() --[[ Line: 968 ]]
            -- upvalues: v262 (copy), v14 (ref)
            local v265 = tick();
            local v266 = workspace.Misc:WaitForChild("KillerCutsceneBackground", 5);
            if v266 and v266.PrimaryPart then
                local v267 = v262.Config.OutroDummy:Clone();
                v267.Name = "OutroVictim";
                v267.PrimaryPart.Anchored = true;
                v267:SetPrimaryPartCFrame(v266.PrimaryPart.CFrame);
                v267.Parent = v266;
                local v268 = v14:LoadAnimationFromID(v267, "rbxassetid://106642460324718", true);
                v268:Play(0);
                v268.TimePosition = tick() - v265;
                v268.Stopped:Once(function() --[[ Line: 983 ]]
                    -- upvalues: v267 (copy)
                    for v269, v270 in ipairs(v267:GetDescendants()) do
                        if v270:IsA("BasePart") then
                            v270.Anchored = true;
                        end;
                    end;
                end);
                local v271 = false;
                for v272, v273 in ipairs({
                    "Shirt", 
                    "Pants", 
                    "Accessory", 
                    "Hat"
                }) do
                    if v267:FindFirstChildOfClass(v273) then
                        v271 = true;
                        break;
                    end;
                end;
                if not v271 then
                    pcall(function() --[[ Line: 996 ]]
                        -- upvalues: v262 (ref), v267 (copy)
                        local v274 = game.Players:GetHumanoidDescriptionFromUserId(v262.Player.UserId);
                        v267.Humanoid:ApplyDescription(v274, Enum.AssetTypeVerification.Always);
                    end);
                end;
            end;
        end);
        return;
    else
        if v261 == "End" then
            v5.LocalPlayer:SetAttribute("FOVMultipliersDisabled", nil);
        end;
        return;
    end;
end;
v1.Created = function(v275, v276) --[[ Line: 1008 ]] --[[ Name: Created ]]
    -- upvalues: v17 (copy), v30 (copy), v14 (copy), v23 (copy), v19 (copy), v253 (copy), v3 (copy), v51 (copy), v35 (copy), v9 (copy), v15 (copy), v80 (copy), v217 (copy), v185 (copy), v156 (copy), v137 (copy), v208 (copy)
    v276.Maid = v17.new();
    v276.Meta = {};
    v276.Instances = {};
    v276.State = {};
    v276.NetworkConnections = {};
    v276.ConnectionDictionary = {};
    v276.State.InFlight = false;
    v276.State.RemainingDescent = 5;
    v276.State.DescentActive = false;
    v276.State.DescentStoppers = {};
    v276.State.Slashing = false;
    v276.State.Blood = 1;
    v276.Meta.Tags = {};
    v276.Meta.Tags.Puddle = ("%*_NOS_PUDDLE"):format(v276.Player.Name);
    v276.Rig:SetAttribute("Blood", 1);
    if v30 then
        v276.Meta.ServerObjects = {};
        v276.Meta.ServerObjects.Puddles = {};
        v276.Cache = v276.Cache or {};
        v276.Cache.BatBiteAnim = v14:LoadAnimationFromID(v276.Rig, v276.Config.Animations.BatBiteCutscene.Killer);
        v276:SetCooldownOf("Ascent", v276.Config.Ascent.InitialCooldown);
        v276.Rig:SetAttribute("Airborne", true);
        local v277 = v276.Rig:WaitForChild("Humanoid", 2);
        v23(v276.NetworkConnections, {
            ("%*NosEndFlight"):format(v276.Player.Name), 
            "REMOTE_EVENT"
        });
        v19:SetConnection(("%*NosEndFlight"):format(v276.Player.Name), "REMOTE_EVENT", function(v278, v279) --[[ Line: 1045 ]]
            -- upvalues: v276 (copy), v253 (ref)
            if v278 ~= v276.Player then
                v278:Kick("b");
            end;
            v253(v276, v279);
        end);
        return;
    else
        v276.Meta.ClientObjects = {};
        local v280 = game.Players.LocalPlayer == v276.Player;
        v23(v276.NetworkConnections, {
            ("%*NosEndQTE"):format(v276.Player.Name), 
            "REMOTE_EVENT"
        });
        v19:SetConnection(("%*NosEndQTE"):format(v276.Player.Name), "REMOTE_EVENT", function(v281) --[[ Line: 1059 ]]
            -- upvalues: v280 (copy), v276 (copy)
            if v280 then
                v276.Animations.UppercutWinner:Play();
                v276.Animations.UppercutPullingLoop:Stop();
            end;
            local v282 = v276;
            if v282.Meta.ActiveQTE then
                v282.Meta.ActiveQTE:Destroy();
            end;
        end);
        v23(v276.NetworkConnections, {
            ("%*NosHookThrow"):format(v276.Player.Name), 
            "REMOTE_EVENT"
        });
        v19:SetConnection(("%*NosHookThrow"):format(v276.Player.Name), "REMOTE_EVENT", function(v283) --[[ Line: 1069 ]]
            -- upvalues: v280 (copy), v276 (copy), v14 (ref), v3 (ref)
            if v280 then
                local v284 = os.clock();
                local v285 = CFrame.lookAt(v276.Rig.PrimaryPart.Position, v276.Rig.PrimaryPart.Position + v283);
                v14:GiveStackableAttribute(v276.Rig, "DisableShiftLockMovement", "NosHook");
                v3:BindToRenderStep("NosHookLook", 1, function() --[[ Line: 1074 ]]
                    -- upvalues: v284 (copy), v276 (ref), v3 (ref), v14 (ref), v285 (copy)
                    if os.clock() - v284 > v276.Config.Uppercut.ProjectileLifetime * 2 + 0.1 then
                        v3:UnbindFromRenderStep("NosHookLook");
                        v14:RemoveStackableAttribute(v276.Rig, "DisableShiftLockMovement", "NosHook");
                        return;
                    else
                        v276.Rig.PrimaryPart.CFrame = v285;
                        return;
                    end;
                end);
            end;
        end);
        if v280 then
            local v286 = 0;
            local v287 = v51(v276.Rig);
            local v288 = Instance.new("BodyVelocity");
            v288.MaxForce = Vector3.new(0, 10000000000, 0, 0);
            v288:SetAttribute("Perm", true);
            v288.Name = "DarkDescent";
            table.insert(v276.Instances, v288);
            local v289 = v35:GetAttribute("Device") or "PC";
            local v290 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
            local v291 = false;
            local v292 = false;
            local function v293() --[[ Line: 1101 ]] --[[ Name: getFloatBindIsDown ]]
                -- upvalues: v9 (ref), v292 (ref)
                return v9:IsKeyDown(Enum.KeyCode.Space) or v9:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonA) or v292;
            end;
            if v289 == "Mobile" then
                v276.ConnectionDictionary.TrickStartInput = v15.MobileButton.MouseButton1Down:Connect(function() --[[ Line: 1106 ]]
                    -- upvalues: v292 (ref)
                    v292 = true;
                end);
                v276.ConnectionDictionary.TrickEndInput = v15.MobileButton.MouseButton1Up:Connect(function() --[[ Line: 1109 ]]
                    -- upvalues: v292 (ref)
                    v292 = false;
                end);
            end;
            v276.ConnectionDictionary.UpdateUI = v3.RenderStepped:Connect(function(v294) --[[ Line: 1114 ]]
                -- upvalues: v276 (copy), v291 (ref), v9 (ref), v292 (ref), v288 (copy), v286 (ref), v80 (ref)
                v276.State.Blood = v276.Rig:GetAttribute("Blood") or 0;
                v291 = v9:IsKeyDown(Enum.KeyCode.Space) or v9:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonA) or v292;
                if not next(v276.State.DescentStoppers) and v291 and v276.State.InFlight then
                    if not v276.State.DescentActive then
                        v288.Velocity = v276.Rig.PrimaryPart.AssemblyLinearVelocity;
                        v286 = os.clock();
                    end;
                    v276.State.DescentActive = true;
                    v288.Parent = v276.Rig.Torso;
                    local v295 = 5 - v276.State.RemainingDescent;
                    local v296 = math.clamp(v295 - 1, 0, 1) * -15;
                    local v297 = v288.Velocity;
                    local v298 = v276.State.InFlight and 0.002 or 0.005 + v295 / 3000;
                    v288.Velocity = Vector3.new(v297.X, math.lerp(v297.Y, v296, 1 - v298 ^ v294), v297.Z);
                    local v299 = v276.State;
                    v299.RemainingDescent = v299.RemainingDescent - v294;
                else
                    if v276.State.DescentActive and v276.State.InFlight then
                        local v300 = v276.Rig.PrimaryPart.AssemblyLinearVelocity;
                        v276.Rig.PrimaryPart.AssemblyLinearVelocity = Vector3.new(v300.X, v276.Config.AscentFlight.FlapForce, v300.Z);
                        v276.State.RemainingDescent = 5;
                        v80(v276, "AscentWingFlap");
                    end;
                    v276.State.DescentActive = false;
                    v288.Parent = nil;
                end;
                if v276.Rig.Humanoid.FloorMaterial ~= Enum.Material.Air then
                    v276.State.RemainingDescent = 5;
                end;
            end);
            v23(v276.NetworkConnections, {
                "UpdateAirborneStatus", 
                "REMOTE_EVENT"
            });
            v19:SetConnection("UpdateAirborneStatus", "REMOTE_EVENT", function(v301) --[[ Line: 1154 ]]
                -- upvalues: v276 (copy)
                if v276.State.IsAirborne == v301 then
                    return;
                else
                    v276.State.IsAirborne = v301;
                    return;
                end;
            end);
            v23(v276.NetworkConnections, {
                "NosAscentReceived", 
                "REMOTE_EVENT"
            });
            v19:SetConnection("NosAscentReceived", "REMOTE_EVENT", function() --[[ Line: 1163 ]]
                -- upvalues: v217 (ref), v276 (copy)
                v217(v276);
            end);
            v23(v276.NetworkConnections, {
                "NosAscentFlight", 
                "REMOTE_EVENT"
            });
            v19:SetConnection("NosAscentFlight", "REMOTE_EVENT", function() --[[ Line: 1168 ]]
                -- upvalues: v185 (ref), v276 (copy)
                v185(v276);
            end);
            v23(v276.NetworkConnections, {
                "NosAirSlash", 
                "REMOTE_EVENT"
            });
            v19:SetConnection("NosAirSlash", "REMOTE_EVENT", function() --[[ Line: 1173 ]]
                -- upvalues: v156 (ref), v276 (copy)
                v156(v276);
            end);
            v23(v276.NetworkConnections, {
                "NosHookCaught", 
                "REMOTE_EVENT"
            });
            v19:SetConnection("NosHookCaught", "REMOTE_EVENT", function(v302) --[[ Line: 1178 ]]
                -- upvalues: v276 (copy), v137 (ref)
                v276.Animations.Uppercut:Stop();
                v276.Animations.UppercutPullingLoop:Play();
                if v302 then
                    v137(v276);
                end;
                local v303 = v276;
            end);
            v23(v276.NetworkConnections, {
                "NosCataclysmStart", 
                "REMOTE_EVENT"
            });
            v19:SetConnection("NosCataclysmStart", "REMOTE_EVENT", function() --[[ Line: 1190 ]]
                -- upvalues: v208 (ref), v276 (copy)
                v208(v276);
            end);
            v23(v276.NetworkConnections, {
                "SetAbilityName", 
                "REMOTE_EVENT"
            });
            v19:SetConnection("SetAbilityName", "REMOTE_EVENT", function(v304, v305) --[[ Line: 1195 ]]
                -- upvalues: v276 (copy)
                local v306 = v276.Behavior.Abilities[v304];
                if v306 then
                    v306.Name = v305;
                end;
            end);
            return;
        else
            v23(v276.NetworkConnections, {
                ("%*NosHookCaught"):format(v276.Player.Name), 
                "REMOTE_EVENT"
            });
            v19:SetConnection(("%*NosHookCaught"):format(v276.Player.Name), "REMOTE_EVENT", function() --[[ Line: 1203 ]]
                -- upvalues: v137 (ref), v276 (copy)
                v137(v276);
            end);
            return;
        end;
    end;
end;
v1.Destroyed = function(v307, v308) --[[ Line: 1211 ]] --[[ Name: Destroyed ]]
    -- upvalues: v30 (copy), v31 (copy), v19 (copy)
    v308.Maid:Destroy();
    local v309 = ("%* | Destroyed Maid!"):format(v30 and "SERVER" or "CLIENT");
    if v31 then
        warn((("[Nosferatu]: %*"):format(v309)));
    end;
    for v310, v311 in v308.ConnectionDictionary do
        local v312 = ("%* | Disconnected connection: %*"):format(v30 and "SERVER" or "CLIENT", v311);
        if v31 then
            warn((("[Nosferatu]: %*"):format(v312)));
        end;
        v311:Disconnect();
        v308.ConnectionDictionary[v310] = nil;
    end;
    for v313, v314 in v308.NetworkConnections do
        local v315 = ("%* | Disconnected network connection: %*/%*"):format(v30 and "SERVER" or "CLIENT", v314[2], v314[1]);
        if v31 then
            warn((("[Nosferatu]: %*"):format(v315)));
        end;
        v19:RemoveConnection(v314[1], v314[2]);
        v308.NetworkConnections[v313] = nil;
    end;
    if v30 then
        for v316, v317 in ipairs(v308.Meta.ServerObjects.Puddles) do
            v317:Destroy();
        end;
        return;
    else
        return;
    end;
end;
v1.OnExecution = function(v318, v319, v320) --[[ Line: 1235 ]] --[[ Name: OnExecution ]]
    -- upvalues: v27 (copy), v12 (copy)
    if not v319.Rig then
        return;
    else
        local v321 = v319.Rig.PrimaryPart.CFrame.LookVector * 100 + Vector3.new(0, 80, 0, 0);
        v27(1.725, function() --[[ Line: 1243 ]]
            -- upvalues: v12 (ref), v320 (copy), v321 (copy)
            v12.AddProfile(v320, {
                Velocity = v321, 
                KillEffects = {
                    Decapitate = true
                }
            });
            local v322 = v320:FindFirstChildOfClass("Humanoid");
            if v322 then
                v322.BreakJointsOnDeath = false;
                v322.Health = 0;
            end;
        end);
        return;
    end;
end;
v1.BatAppear = function(v323, v324) --[[ Line: 1259 ]] --[[ Name: BatAppear ]]
    -- upvalues: v29 (copy), v18 (copy)
    if v29 then
        return;
    else
        local v325 = v324.Rig.PrimaryPart:FindFirstChild("BatTransform");
        if v325 == nil then
            v325 = v324.Config.BatTransform:Clone();
            v325.Parent = v324.Rig.PrimaryPart;
        end;
        for v326, v327 in (v325:GetChildren()) do
            v327:Emit(v327:GetAttribute("EmitCount") or 1);
        end;
        v18:RemoveStatus(v324.Rig, "Invisibility");
        v324.Rig:SetAttribute("InvisibilityDisabled", true);
        local function v330(v328) --[[ Line: 1277 ]] --[[ Name: isTheBat ]]
            local v329 = false;
            if v328.Name == "Bat" then
                v329 = v328:IsA("BasePart");
            end;
            return v329;
        end;
        if not v324.Cache.BatTransparencyData then
            v324.Cache.BatTransparencyData = {};
            for v331, v332 in ipairs(v324.Rig:GetDescendants()) do
                if v332:IsA("BasePart") or v332:IsA("Decal") then
                    local v333 = false;
                    if v332.Name == "Bat" then
                        v333 = v332:IsA("BasePart");
                    end;
                    if v333 then
                        v324.Cache.BatTransparencyData[v332] = 1;
                        v332.Transparency = 0;
                    else
                        v324.Cache.BatTransparencyData[v332] = v332.Transparency;
                        v332.Transparency = 1;
                    end;
                end;
            end;
            return;
        else
            for v334, v335 in pairs(v324.Cache.BatTransparencyData) do
                local v336 = false;
                if v334.Name == "Bat" then
                    v336 = v334:IsA("BasePart");
                end;
                if v336 then
                    v334.Transparency = 0;
                else
                    v334.Transparency = 1;
                end;
            end;
            return;
        end;
    end;
end;
v1.BatDisappear = function(v337, v338) --[[ Line: 1308 ]] --[[ Name: BatDisappear ]]
    -- upvalues: v29 (copy), v31 (copy)
    if v29 then
        return;
    else
        for v339, v340 in (v338.Rig.PrimaryPart:FindFirstChild("BatTransform"):GetChildren()) do
            v340:Emit(v340:GetAttribute("EmitCount") or 1);
        end;
        v338.Rig:SetAttribute("InvisibilityDisabled", nil);
        if not v338.Cache.BatTransparencyData then
            if v31 then
                warn("[Nosferatu]: Attempted to re-appear Nosferatu, wasn't already transformed.");
            end;
            return;
        else
            for v341, v342 in pairs(v338.Cache.BatTransparencyData) do
                v341.Transparency = v342;
            end;
            return;
        end;
    end;
end;
v1.ToggleBatBiteWarning = function(v343, v344, v345) --[[ Line: 1330 ]] --[[ Name: ToggleBatBiteWarning ]]
    -- upvalues: v4 (copy)
    local v346 = v344.Rig.Bat.LightAttachment.SpotLight;
    if v345 then
        v346.Angle = 90;
        v4:Create(v346, TweenInfo.new(0.25), {
            Brightness = 40, 
            Angle = 27
        }):Play();
        return;
    else
        v4:Create(v346, TweenInfo.new(1), {
            Brightness = 0
        }):Play();
        return;
    end;
end;
v1.ToggleHookVisible = function(v347, v348, v349) --[[ Line: 1340 ]] --[[ Name: ToggleHookVisible ]]
    v348.Rig.HookModel.Transparency = v349 and 0.5 or 1;
    v348.Rig.HookModel.Beam.Enabled = v349;
end;
v1.HookCharacter = function(v350, v351, v352) --[[ Line: 1345 ]] --[[ Name: HookCharacter ]]
    local v353 = v351.Rig.HookModel.Beam:Clone();
    local v354 = v351.Rig["Right Arm"].ChainAtt0;
    local v355 = Instance.new("Attachment", v352.PrimaryPart);
    v353.Attachment0 = v354;
    v353.Attachment1 = v355;
    v353.Parent = v352.PrimaryPart;
    v353.Enabled = true;
    return {
        v353, 
        v355
    };
end;
v1.HookThrowVisual = function(v356, v357) --[[ Line: 1357 ]] --[[ Name: HookThrowVisual ]]

end;
v1.OnCataclysmStart = function(v358, v359) --[[ Line: 1361 ]] --[[ Name: OnCataclysmStart ]]
    -- upvalues: v31 (copy)
    local v360 = v359.Rig;
    local v361 = v359.Config.CataclysmTrailFolder;
    if not v361 then
        if v31 then
            warn("[Nosferatu]: There is no CataclysmTrail.");
        end;
        return;
    else
        local v362 = v361:Clone();
        v362.Parent = v360.PrimaryPart;
        for v363, v364 in (v362:GetDescendants()) do
            if v364:IsA("Trail") or v364:IsA("ParticleEmitter") then
                v364.Enabled = true;
            end;
        end;
        return;
    end;
end;
v1.OnCataclysmEnd = function(v365, v366) --[[ Line: 1379 ]] --[[ Name: OnCataclysmEnd ]]
    -- upvalues: v31 (copy)
    local v367 = v366.Rig;
    local v368 = v367 and v367.PrimaryPart:FindFirstChild("CataclysmTrail");
    if not v368 then
        if v31 then
            warn("[Nosferatu]: There is no CataclysmTrail.");
        end;
        return;
    else
        v368:Destroy();
        return;
    end;
end;
v1.Abilities = {
    Slash = {
        Name = "Lacerate", 
        Icon = "rbxassetid://119979438428834", 
        LayoutOrder = 1, 
        KeybindType = "MainAbility", 
        Cooldown = 2, 
        Callback = function(v369) --[[ Line: 1400 ]] --[[ Name: Callback ]]
            -- upvalues: v30 (copy), v27 (copy), v16 (copy), v80 (copy), v18 (copy), v14 (copy), v29 (copy)
            local v370 = v369.Config;
            local v371 = v369.Rig;
            if v30 then
                local v372 = v369.State.InPowerState;
                v369.AbilitiesDisabled = true;
                local v373 = v370.Slash;
                v27(v373.Windup, function() --[[ Line: 1411 ]]
                    -- upvalues: v16 (ref), v369 (copy), v373 (copy), v80 (ref), v18 (ref), v14 (ref)
                    local v379 = v16:CreateHitbox(v369.Player, {
                        Size = Vector3.new(4.5, 6, 7.5, 0), 
                        CFrameOffset = CFrame.new(0, 0, -(v369.State.Blood > 0 and 1.75 or 1.25)), 
                        Damage = v373.Damage, 
                        Time = v373.Linger, 
                        Knockback = 2, 
                        ExecuteOnKill = true, 
                        Connections = {
                            Hit = function(v374, v375) --[[ Line: 1422 ]] --[[ Name: Hit ]]
                                -- upvalues: v80 (ref), v369 (ref), v18 (ref), v14 (ref)
                                v80(v369, "Hit");
                                local v376 = v369;
                                for v377, v378 in v376.Config.Bats.SelfStatuses do
                                    v18:RemoveStatus(v376.Rig, v377);
                                end;
                                v14:CreateSpeedMultiplier(v374, 1.5, "HitSpeedBonus", 1.25);
                            end
                        }
                    });
                end);
                v27(v373.Windup + v373.Endlag, function() --[[ Line: 1431 ]]
                    -- upvalues: v369 (copy)
                    v369.AbilitiesDisabled = false;
                end);
                v80(v369, "SlashGround");
                return v372;
            else
                if v29 then
                    v369.Animations.Slash:Play(0.025);
                end;
                return;
            end;
        end
    }, 
    Uppercut = {
        Name = "Bloodhook", 
        Icon = "rbxassetid://93747578668234", 
        LayoutOrder = 2, 
        KeybindType = "AltAbility1", 
        Cooldown = 20, 
        Callback = function(v380) --[[ Line: 1452 ]] --[[ Name: Callback ]]
            -- upvalues: v30 (copy), v80 (copy), v66 (copy), v14 (copy), v26 (copy), v70 (copy), v5 (copy), v10 (copy), v18 (copy), v11 (copy), v19 (copy), v3 (copy), v4 (copy), v16 (copy), v75 (copy), v2 (copy), v27 (copy), v21 (copy)
            local v381 = v380.Config.Uppercut;
            if v30 then
                v380.AbilitiesDisabled = true;
                v80(v380, "UppercutWindup");
                v66("ToggleHookVisible", "Nosferatu", v380, true);
                local v382 = v14:CreateSpeedMultiplier(v380.Rig, 0.5, "NosBloodhookThrow", v381.Windup + 0.1);
                v26(function() --[[ Line: 1461 ]]
                    -- upvalues: v70 (ref), v381 (copy), v380 (copy), v14 (ref), v66 (ref), v5 (ref), v10 (ref), v18 (ref), v11 (ref), v26 (ref), v19 (ref), v80 (ref), v3 (ref), v4 (ref), v16 (ref), v75 (ref), v2 (ref), v27 (ref), v21 (ref)
                    local v383 = v70;
                    local v384 = v381.Windup;
                    local v385 = v380;
                    if v383(v384, function(v386) --[[ Line: 184 ]]
                        -- upvalues: v14 (ref)
                        if v14:IsAlive(v386.Rig) and not v386.Rig:GetAttribute("Stunned") then
                            return false;
                        else
                            return true;
                        end;
                    end, v380) then
                        v66("ToggleHookVisible", "Nosferatu", v380, false);
                        v380.AbilitiesDisabled = false;
                        return;
                    else
                        v384 = v14:CreateSpeedMultiplier(v380.Rig, 0.01, "NosBloodhookThrow");
                        local v387 = nil;
                        v385 = nil;
                        local v419 = {
                            Size = Vector3.new(5, 5, 5, 0), 
                            Damage = v381.InitialDamage, 
                            Time = 1, 
                            Knockback = 0.5, 
                            HitMultiple = true, 
                            PredictVelocity = false, 
                            Connections = {
                                Hit = function(v388) --[[ Line: 1484 ]] --[[ Name: Hit ]]
                                    -- upvalues: v387 (ref), v5 (ref), v385 (ref), v380 (ref), v10 (ref), v18 (ref), v14 (ref), v66 (ref), v11 (ref), v26 (ref), v381 (ref), v19 (ref), v80 (ref), v3 (ref), v4 (ref), v16 (ref), v75 (ref), v384 (copy)
                                    if v387 then
                                        return;
                                    elseif not v5:GetPlayerFromCharacter(v388) and not v388:HasTag("SimulateSurvivor") then
                                        return;
                                    else
                                        if v388:HasTag("SimulateSurvivor") then
                                            v385:Destroy();
                                            v387 = true;
                                        end;
                                        for v389, v390 in {
                                            v388.PrimaryPart, 
                                            v380.Rig.PrimaryPart
                                        } do
                                            v10:Play(v380.Config.Sounds.UppercutCaught, {
                                                Parent = v390
                                            });
                                        end;
                                        local v391 = v380;
                                        for v392, v393 in v391.Config.Bats.SelfStatuses do
                                            v18:RemoveStatus(v391.Rig, v392);
                                        end;
                                        if v14:IsAlive(v388) and not v388:GetAttribute("NosHookCaught") and not v388:HasTag("SimulateSurvivor") then
                                            v66("ToggleHookVisible", "Nosferatu", v380, false);
                                            v14:GiveStackableAttribute(v388, "Airborne", (("%*NosHook"):format(v380.Player.Name)));
                                            v388:SetAttribute("NosHookCaught", true);
                                            v380.Rig:SetAttribute("NosFishing", true);
                                            v387 = v388;
                                            v385:Destroy();
                                            v391 = v66("HookCharacter", "Nosferatu", v380, v388);
                                            local v394 = game.Players:GetPlayerFromCharacter(v388);
                                            local v395 = if v394 then v11.CurrentActors[v394] else nil;
                                            if v395 then
                                                v395:DisableAbilities("NosCutsceneCaught", true);
                                            end;
                                            v26(function() --[[ Line: 1521 ]]
                                                -- upvalues: v380 (ref), v388 (copy), v387 (ref), v381 (ref), v19 (ref), v394 (copy), v80 (ref), v14 (ref), v3 (ref), v4 (ref), v391 (copy), v16 (ref), v395 (copy), v75 (ref), v384 (ref), v18 (ref)
                                                local v396 = ("%*NosHookQTE"):format(v380.Player.Name);
                                                local v397 = Instance.new("BodyVelocity", v388.PrimaryPart);
                                                v397.P = 1e999;
                                                v397.MaxForce = Vector3.new(100000000, 100000000, 100000000, 0);
                                                v397.Name = "CatchVelocity";
                                                local v398 = 0;
                                                local v399 = (v387:GetPivot().Position - v380.Rig:GetPivot().Position).Magnitude;
                                                local v400 = v399 < v381.WeakDistance;
                                                local v401 = math.clamp(math.floor(v399 / 10), 0, 12);
                                                v19:FireClientConnection(v394, ("%*NosHookCaught"):format(v380.Player.Name), "REMOTE_EVENT", not v400);
                                                v19:FireClientConnection(v380.Player, "NosHookCaught", "REMOTE_EVENT", not v400);
                                                if not v400 then
                                                    v19:SetConnection(v396, "REMOTE_EVENT", function(v402, v403) --[[ Line: 1537 ]]
                                                        -- upvalues: v380 (ref), v401 (ref), v394 (ref), v398 (ref)
                                                        if v402 == v380.Player then
                                                            v401 = v401 + (v403 and 0.35 or 0);
                                                            return;
                                                        elseif v402 == v394 then
                                                            if v403 then
                                                                v401 = v401 - 0.85;
                                                                return;
                                                            else
                                                                v398 = os.clock();
                                                                return;
                                                            end;
                                                        else
                                                            return;
                                                        end;
                                                    end);
                                                end;
                                                local v404 = v80(v380, "UppercutReelLoop", {
                                                    Parent = v380.Rig.PrimaryPart, 
                                                    Looped = true
                                                });
                                                local v405 = os.clock();
                                                local v406 = false;
                                                local v407 = v400 and 0 or os.clock();
                                                v14:GiveInvincible(v380.Rig, "NosBloodhookPull");
                                                v380.Rig.PrimaryPart.Anchored = true;
                                                v380.Behavior.OnStunnedAbsolute = function(v408, v409) --[[ Line: 1560 ]]
                                                    -- upvalues: v3 (ref), v407 (ref)
                                                    if v3:IsClient() then
                                                        return;
                                                    else
                                                        v407 = os.clock();
                                                        return;
                                                    end;
                                                end;
                                                while v380 and v397 and v397.Parent and v14:IsAlive(v387) and v14:IsAlive(v380.Rig) and not v380.Rig:GetAttribute("Stunned") and os.clock() - v405 < 9 do
                                                    local v410 = (v387:GetPivot().Position - v380.Rig:GetPivot().Position).Magnitude;
                                                    local v411 = v4:GetValue(math.clamp((os.clock() - v407) * 0.75, 0, 1), Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
                                                    if v410 < 4 then
                                                        v406 = true;
                                                        break;
                                                    elseif v401 >= 0 then
                                                        local v412 = 1 - v4:GetValue(math.clamp(os.clock() - v398, 0, 1), Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
                                                        v397.Velocity = (v387:GetPivot().Position - v380.Rig:GetPivot().Position).Unit * v411 * -(v400 and 25 or v381.BasePullSpeed + v412 * v381.FailPullSpeed);
                                                        task.wait();
                                                    else
                                                        break;
                                                    end;
                                                end;
                                                v380.Behavior.OnStunnedAbsolute = nil;
                                                v19:RemoveConnection(v396, "REMOTE_EVENT");
                                                if v397 then
                                                    v397:Destroy();
                                                end;
                                                if v404 then
                                                    v404:Destroy();
                                                end;
                                                local v413 = pairs;
                                                local v414 = v391 or {};
                                                for v415, v416 in v413(v414) do
                                                    v416:Destroy();
                                                end;
                                                if v388 and v388:IsDescendantOf(workspace) then
                                                    v14:RemoveStackableAttribute(v388, "Airborne", (("%*NosHook"):format(v380.Player.Name)));
                                                end;
                                                v19:FireClientConnection(v380.Player, ("%*NosEndQTE"):format(v380.Player.Name), "REMOTE_EVENT", v406);
                                                v19:FireClientConnection(game.Players:GetPlayerFromCharacter(v388), ("%*NosEndQTE"):format(v380.Player.Name), "REMOTE_EVENT", v406);
                                                v388:SetAttribute("NosHookCaught", nil);
                                                v380.Rig:SetAttribute("NosFishing", nil);
                                                if v406 then
                                                    v80(v380, "UppercutCutscene", {
                                                        Parent = v380.Rig.PrimaryPart
                                                    });
                                                    if v387 then
                                                        v14:SetUpCutscene(v380.Rig, v387, CFrame.new(0, 0, -3), "NosHookKick");
                                                        v14:GiveInvincible(v380.Rig, "Hooked", 1);
                                                        task.delay(0.2, function() --[[ Line: 1614 ]]
                                                            -- upvalues: v16 (ref), v380 (ref), v388 (ref), v400 (copy), v381 (ref), v387 (ref), v14 (ref), v395 (ref), v75 (ref), v384 (ref)
                                                            v16:CreateHitbox(v380.Player, {
                                                                Size = Vector3.new(4, 4, 4, 0), 
                                                                CFrame = v388 and v388.PrimaryPart and v388.PrimaryPart.CFrame or v380.Rig.PrimaryPart.CFrame, 
                                                                Damage = if v400 then v381.WeakDamage else v381.KickDamage, 
                                                                Time = 0.1, 
                                                                Knockback = 0, 
                                                                HitMultiple = true
                                                            });
                                                            if v387 and v387:IsDescendantOf(workspace) then
                                                                local v417 = v381.KickKnockback;
                                                                local v418 = v380.Rig.PrimaryPart.CFrame.LookVector * v417 + Vector3.new(0, v417 / 3, 0);
                                                                v14:ToggleAnchored(v387, "NosHookKick", false);
                                                                v14:RagdollLaunch(v380, v387, v418);
                                                                if v395 then
                                                                    v395:DisableAbilities("NosCutsceneCaught", false);
                                                                end;
                                                            end;
                                                            task.delay(v381.Endlag, function() --[[ Line: 1636 ]]
                                                                -- upvalues: v75 (ref), v380 (ref), v381 (ref), v384 (ref), v14 (ref)
                                                                v75(v380.Rig, v381.CutsceneSelfStatuses);
                                                                v380.AbilitiesDisabled = false;
                                                                if v384 then
                                                                    v384:Destroy();
                                                                end;
                                                                v14:ToggleAnchored(v380.Rig, "NosHookKick", false);
                                                            end);
                                                        end);
                                                    end;
                                                else
                                                    if v380 then
                                                        task.delay(v381.Endlag, function() --[[ Line: 1650 ]]
                                                            -- upvalues: v380 (ref), v384 (ref)
                                                            v380.AbilitiesDisabled = false;
                                                            if v384 then
                                                                v384:Destroy();
                                                            end;
                                                        end);
                                                        v18:ApplyStatus(v380.Rig, "Helpless", {
                                                            Level = 1, 
                                                            Duration = 1
                                                        });
                                                    end;
                                                    if v395 then
                                                        v395:DisableAbilities("NosCutsceneCaught", false);
                                                    end;
                                                    pcall(function() --[[ Line: 1664 ]]
                                                        -- upvalues: v80 (ref), v380 (ref), v387 (ref)
                                                        v80(v380, "UppercutBreak", {
                                                            Parent = v380.Rig.PrimaryPart
                                                        });
                                                        v80(v380, "UppercutEscape", {
                                                            Parent = v387.PrimaryPart
                                                        });
                                                    end);
                                                end;
                                                task.delay(v380.Config.Uppercut.LingeringInvincibility, function() --[[ Line: 1671 ]]
                                                    -- upvalues: v14 (ref), v380 (ref)
                                                    v14:RemoveInvincible(v380.Rig, "NosBloodhookPull");
                                                end);
                                                v380.Rig.PrimaryPart.Anchored = false;
                                            end);
                                        end;
                                        return;
                                    end;
                                end
                            }
                        };
                        local v420 = v380:GetPivot().LookVector * v381.ProjectileSpeed;
                        local v421 = v2.Assets.Instances.Nothingburger:Clone();
                        local v422 = RaycastParams.new();
                        v422.RespectCanCollide = true;
                        v422.CollisionGroup = "Killers";
                        v422.FilterDescendantsInstances = {
                            workspace.Players
                        };
                        v19:FireAllClientConnection(("%*NosHookThrow"):format(v380.Player.Name), "REMOTE_EVENT", v420);
                        local v427 = {
                            Owner = v380.Player, 
                            HitboxConfig = v419, 
                            Lifetime = v381.ProjectileLifetime, 
                            InitialCFrame = v380:GetPivot() * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(-0.25, -0.25, 6), 
                            InitialVelocity = v420, 
                            Model = v421, 
                            CastParams = v422, 
                            Callbacks = {
                                HitOther = function(v423) --[[ Line: 1701 ]] --[[ Name: HitOther ]]
                                    v423:Destroy();
                                end, 
                                HitHuman = function(v424, v425) --[[ Line: 1704 ]] --[[ Name: HitHuman ]]
                                    -- upvalues: v5 (ref)
                                    if v5:GetPlayerFromCharacter(v425) then
                                        v424:Destroy();
                                        return;
                                    else
                                        return;
                                    end;
                                end, 
                                Ended = function(v426) --[[ Line: 1710 ]] --[[ Name: Ended ]]
                                    -- upvalues: v387 (ref), v80 (ref), v380 (ref), v381 (ref), v384 (copy)
                                    if v387 then
                                        return;
                                    else
                                        v80(v380, "UppercutMiss");
                                        task.delay(v381.Endlag, function() --[[ Line: 1715 ]]
                                            -- upvalues: v380 (ref), v384 (ref)
                                            v380.AbilitiesDisabled = false;
                                            if v384 then
                                                v384:Destroy();
                                            end;
                                        end);
                                        return;
                                    end;
                                end
                            }
                        };
                        v27(v381.ProjectileLifetime * 2, function() --[[ Line: 1725 ]]
                            -- upvalues: v387 (ref), v66 (ref), v380 (ref)
                            if v387 then
                                return;
                            else
                                v66("ToggleHookVisible", "Nosferatu", v380, true);
                                task.wait(0.55);
                                v66("ToggleHookVisible", "Nosferatu", v380, false);
                                return;
                            end;
                        end);
                        v385 = v21.new(v427);
                        v385:Launch();
                        return;
                    end;
                end);
                return;
            else
                v14:ToggleSprinting("NosBloodWindups", false, 1);
                v380.Animations.Uppercut:Play();
                return;
            end;
        end
    }, 
    Spire = {
        Name = "Cataclysm", 
        Icon = "rbxassetid://119327945150704", 
        LayoutOrder = 3, 
        KeybindType = "AltAbility2", 
        Cooldown = 20, 
        Callback = function(v428) --[[ Line: 1752 ]] --[[ Name: Callback ]]
            -- upvalues: v30 (copy), v80 (copy), v26 (copy), v70 (copy), v14 (copy), v233 (copy), v19 (copy), v18 (copy), v66 (copy), v31 (copy), v27 (copy), v16 (copy), v4 (copy), v25 (copy)
            local v429 = v428.Config.Spire;
            if v30 then
                v80(v428, "SpireStart", {
                    Parent = v428.Rig.PrimaryPart
                });
                v428.AbilitiesDisabled = true;
                v26(function() --[[ Line: 1760 ]]
                    -- upvalues: v70 (ref), v429 (copy), v428 (copy), v14 (ref), v233 (ref), v19 (ref), v18 (ref), v66 (ref), v80 (ref), v31 (ref), v27 (ref), v16 (ref), v4 (ref), v25 (ref)
                    local v430 = v70;
                    local v431 = v429.Windup;
                    local v432 = v428;
                    if v430(v431, function(v433) --[[ Line: 184 ]]
                        -- upvalues: v14 (ref)
                        if v14:IsAlive(v433.Rig) and not v433.Rig:GetAttribute("Stunned") then
                            return false;
                        else
                            return true;
                        end;
                    end, v428) then
                        v428.AbilitiesDisabled = false;
                        return;
                    else
                        v233(v428, true);
                        v14:GiveInvincible(v428.Rig, "NosCataclysm", v429.Duration + 2.5);
                        v19:FireClientConnection(v428.Player, "NosCataclysmStart", "REMOTE_EVENT");
                        v18:ApplyStatus(v428.Rig, "Invisibility", {
                            Level = 4, 
                            Duration = v429.Duration
                        });
                        v66("OnCataclysmStart", "Nosferatu", v428);
                        v431 = v14:CreateSpeedMultiplier(v428.Rig, v429.Speed, "NosCataclysm");
                        local v434 = {};
                        v432 = v80(v428, "SpireLoop", {
                            Parent = v428.Rig.PrimaryPart, 
                            Looped = true
                        });
                        local v435 = v428:GetPivot();
                        local v436 = os.clock();
                        local v437 = RaycastParams.new();
                        v437.CollisionGroup = "Killers";
                        v437.RespectCanCollide = true;
                        v437.FilterDescendantsInstances = {
                            workspace.Players
                        };
                        v437.FilterType = Enum.RaycastFilterType.Exclude;
                        local function v441(v438) --[[ Line: 1786 ]] --[[ Name: downcast ]]
                            -- upvalues: v437 (copy)
                            local v439 = workspace:Raycast(v438, Vector3.new(0, -30, 0, 0), v437);
                            local v440 = v438 + Vector3.new(0, -30, 0, 0);
                            if v439 then
                                return (CFrame.new(v439.Position, v439.Position + v439.Normal));
                            else
                                return (CFrame.new(v440, v440 + Vector3.new(0, 1, 0, 0)));
                            end;
                        end;
                        local function v446(v442) --[[ Line: 1792 ]] --[[ Name: createNode ]]
                            -- upvalues: v434 (copy), v429 (ref)
                            local v443 = v434[#v434];
                            local v444 = Instance.new("Attachment", workspace.Terrain);
                            v444.CFrame = v442 + Vector3.new(0, 0.15000000596046448, 0, 0);
                            if v443 then
                                local v445 = v429.BeamTemplate:Clone();
                                v445.Attachment0 = v443;
                                v445.Attachment1 = v444;
                                v445.Parent = v444;
                            end;
                            table.insert(v434, v444);
                            return v444;
                        end;
                        local v447 = v435.Position;
                        local v448 = workspace:Raycast(v447, Vector3.new(0, -30, 0, 0), v437);
                        local v449 = v447 + Vector3.new(0, -30, 0, 0);
                        local v450 = if v448 then CFrame.new(v448.Position, v448.Position + v448.Normal) else CFrame.new(v449, v449 + Vector3.new(0, 1, 0, 0));
                        v447 = v434[#v434];
                        v448 = Instance.new("Attachment", workspace.Terrain);
                        v448.CFrame = v450 + Vector3.new(0, 0.15000000596046448, 0, 0);
                        if v447 then
                            v449 = v429.BeamTemplate:Clone();
                            v449.Attachment0 = v447;
                            v449.Attachment1 = v448;
                            v449.Parent = v448;
                        end;
                        table.insert(v434, v448);
                        v450 = v435.Position;
                        while os.clock() - v436 < v429.Duration and v428 and v428.GetPivot do
                            v447 = v428:GetPivot().Position;
                            v448 = v447 - v450;
                            v449 = v448.Magnitude;
                            local v451 = 0;
                            while v429.ExplosionGap < v449 do
                                v451 = v451 + 1;
                                local v452 = v450 + v448.Unit * v429.ExplosionGap;
                                local v453 = workspace:Raycast(v452, Vector3.new(0, -30, 0, 0), v437);
                                local v454 = v452 + Vector3.new(0, -30, 0, 0);
                                local v455 = if v453 then CFrame.new(v453.Position, v453.Position + v453.Normal) else CFrame.new(v454, v454 + Vector3.new(0, 1, 0, 0));
                                v453 = v434[#v434];
                                v454 = Instance.new("Attachment", workspace.Terrain);
                                v454.CFrame = v455 + Vector3.new(0, 0.15000000596046448, 0, 0);
                                if v453 then
                                    local v456 = v429.BeamTemplate:Clone();
                                    v456.Attachment0 = v453;
                                    v456.Attachment1 = v454;
                                    v456.Parent = v454;
                                end;
                                table.insert(v434, v454);
                                v450 = v452;
                                v448 = v447 - v450;
                                v449 = v448.Magnitude;
                                if v451 > 9 then
                                    if v31 then
                                        warn("[Nosferatu]: Failsafe activated");
                                        break;
                                    else
                                        break;
                                    end;
                                end;
                            end;
                            task.wait();
                        end;
                        if v432 then
                            v432:Destroy();
                        end;
                        v66("OnCataclysmEnd", "Nosferatu", v428);
                        v80(v428, "SpireEnd", {
                            Parent = v428.Rig.PrimaryPart
                        });
                        v431.Value = 0.01;
                        v27(v429.Delay, function() --[[ Line: 1846 ]]
                            -- upvalues: v233 (ref), v428 (ref), v434 (copy), v16 (ref), v429 (ref), v27 (ref), v80 (ref), v435 (copy), v4 (ref), v431 (copy), v25 (ref)
                            v233(v428, false);
                            local v457 = require(script.sv_Puddle);
                            local v458 = {};
                            local v459 = #v434;
                            for v460, v461 in ipairs(v434) do
                                local v462 = v461.CFrame;
                                v16:CreateHitbox(v428.Player, {
                                    Size = Vector3.new(1, 1, 1, 0) * v429.ExplosionRadius, 
                                    CFrame = v462, 
                                    Damage = function(v463) --[[ Line: 1858 ]] --[[ Name: Damage ]]
                                        -- upvalues: v458 (copy), v429 (ref)
                                        if v458[v463] then
                                            return 0;
                                        else
                                            return v429.ExplosionDamage;
                                        end;
                                    end, 
                                    PredictVelocity = false, 
                                    IsProjectile = true, 
                                    HitMultiple = true, 
                                    Shape = Enum.PartType.Ball, 
                                    Time = 0.01, 
                                    ExecuteOnKill = false, 
                                    Connections = {
                                        Hit = function(v464, v465) --[[ Line: 1869 ]] --[[ Name: Hit ]]
                                            -- upvalues: v458 (copy)
                                            v458[v464] = true;
                                        end
                                    }
                                });
                                if v460 == 1 then
                                    local v466 = v428.Config.CataclysmExplode;
                                    if v466 then
                                        local v467 = v466:Clone();
                                        v467.Parent = workspace.Map.Ingame;
                                        v467.CFrame = v462;
                                        for v468, v469 in (v467:GetDescendants()) do
                                            if v469:IsA("ParticleEmitter") then
                                                v469:Emit(v469:GetAttribute("EmitCount") or 1);
                                            end;
                                        end;
                                        v27(v429.PuddleLifetime, function() --[[ Line: 1888 ]]
                                            -- upvalues: v467 (copy)
                                            if not v467 then
                                                return;
                                            else
                                                v467:Destroy();
                                                return;
                                            end;
                                        end);
                                    end;
                                end;
                                if v460 % 3 == 1 then
                                    local v470 = v457.new(v428, v462);
                                    v27(v429.PuddleLifetime, function() --[[ Line: 1901 ]]
                                        -- upvalues: v470 (copy)
                                        if v470 and v470.Destroy then
                                            v470:Destroy();
                                        end;
                                    end);
                                end;
                                if v460 % 6 == 1 or v460 == v459 then
                                    v80(v428, "SpireExplode", {
                                        Parent = workspace, 
                                        Position = v462.Position, 
                                        PlaybackSpeed = 0.9 + Random.new():NextNumber() * 0.29999999999999993, 
                                        Volume = 0.35
                                    });
                                end;
                                v461:Destroy();
                            end;
                            table.clear(v434);
                            v428:PivotTo(v435);
                            v27(v429.Endlag - 0.3, function() --[[ Line: 1918 ]]
                                -- upvalues: v4 (ref), v431 (ref), v25 (ref), v428 (ref)
                                v4:Create(v431, TweenInfo.new(0.5), {
                                    Value = 1
                                }):Play();
                                game.Debris:AddItem(v431, 0.6);
                                v25(0.3);
                                v428.AbilitiesDisabled = false;
                            end);
                        end);
                        return;
                    end;
                end);
                return;
            else
                v428.Animations.SpireStart:Play();
                v27(v429.Windup, function() --[[ Line: 1928 ]]
                    -- upvalues: v428 (copy)
                    v428.Animations.SpireStart:Stop();
                    v428.Animations.SpireLoop:Play();
                end);
                v14:ToggleSprinting("NosCataclysmWindup", false, v429.Windup + 0.2);
                return;
            end;
        end
    }, 
    Bats = {
        Name = "Hunter's Feast", 
        Icon = "rbxassetid://122139471274199", 
        LayoutOrder = 4, 
        KeybindType = "AltAbility3", 
        Cooldown = 20, 
        Callback = function(v471, v472) --[[ Line: 1946 ]] --[[ Name: Callback ]]
            -- upvalues: v30 (copy), v27 (copy), v14 (copy), v80 (copy), v19 (copy), v26 (copy), v70 (copy), v10 (copy), v75 (copy), v21 (copy), v29 (copy)
            local v473 = v471.Config.Bats;
            if v30 then
                local v474 = v471.Rig;
                v471.AbilitiesDisabled = true;
                local v475 = v471.State.ActiveBats;
                v471.State.ActiveBats = nil;
                if v475 and v475.State == "Running" then
                    v471:SetCooldownOf("Bats", v471.Behavior.Abilities.Bats.Cooldown);
                    v27(0.25, function() --[[ Line: 1961 ]]
                        -- upvalues: v471 (copy)
                        v471.AbilitiesDisabled = false;
                    end);
                    if not v475 or v475.State == "Dead" then
                        return;
                    else
                        local v476 = v471.Player:GetAttribute("Device") == "Mobile";
                        local v477 = v14:GetPlayerMousePosition(v471.Player, v476, true);
                        local v478 = v475.PreviousCFrame or v475.InitialCFrame;
                        local v479 = (v477 - v478.Position).Unit * v473.ProjectileSpeed * 1.5;
                        v475.InitialTick = tick();
                        v475.InitialCFrame = v478;
                        v475.PreviousCFrame = v478;
                        v475.InitialVelocity = v479;
                        v475:ClientCallback("RedirectEvent", {
                            newCFrame = v478, 
                            newVelocity = v479
                        });
                        return "GroundedAlt";
                    end;
                else
                    v80(v471, "BatsGround");
                    v471:SetCooldownOf("Bats", v473.Windup);
                    v19:FireClientConnection(v471.Player, "SetAbilityName", "REMOTE_EVENT", "Bats", "Redirect");
                    v26(function() --[[ Line: 1988 ]]
                        -- upvalues: v70 (ref), v473 (copy), v471 (copy), v14 (ref), v10 (ref), v75 (ref), v474 (copy), v19 (ref), v21 (ref), v27 (ref)
                        local v480 = v70;
                        local v481 = v473.Windup;
                        local v482 = v471;
                        if v480(v481, function(v483) --[[ Line: 184 ]]
                            -- upvalues: v14 (ref)
                            if v14:IsAlive(v483.Rig) and not v483.Rig:GetAttribute("Stunned") then
                                return false;
                            else
                                return true;
                            end;
                        end, v471) then
                            v471.AbilitiesDisabled = false;
                            return;
                        else
                            v481 = nil;
                            v481 = if v471.Player:GetAttribute("Device") == "Mobile" then v14:GetPlayerMousePosition(v471.Player, true) else v14:GetPlayerMousePosition(v471.Player);
                            local v484 = CFrame.lookAt(v471.Rig.PrimaryPart.Position, v481) * CFrame.new(0, 0, -500);
                            v482 = v473.ProjectileTemplate:Clone();
                            local v485 = v471:GetPivot();
                            local v486 = RaycastParams.new();
                            v486.RespectCanCollide = true;
                            v486.CollisionGroup = "Killers";
                            v486.FilterType = Enum.RaycastFilterType.Exclude;
                            v486.FilterDescendantsInstances = {
                                workspace.Players, 
                                v482
                            };
                            v10:Play(v471.Config.Sounds.BatsBatsIdle, {
                                Parent = v482, 
                                Looped = true
                            });
                            for v487, v488 in (v482:GetDescendants()) do
                                if v488:IsA("ParticleEmitter") then
                                    v488.Enabled = true;
                                end;
                            end;
                            local v490 = {
                                Size = Vector3.new(1, 1, 1, 0) * v473.HitboxScalar, 
                                Damage = v473.Damage, 
                                Time = 10, 
                                Knockback = 0.5, 
                                HitMultiple = false, 
                                PredictVelocity = false, 
                                Connections = {
                                    Hit = function(v489) --[[ Line: 2032 ]] --[[ Name: Hit ]]
                                        -- upvalues: v14 (ref), v471 (ref), v473 (ref), v75 (ref), v474 (ref)
                                        if tostring(v489.Parent) == "Survivors" then
                                            v14:RevealPlayerAuraTo(v471.Player, v489, v473.AuraDuration);
                                            v75(v489, v473.Statuses);
                                            v75(v474, v473.SelfStatuses);
                                        end;
                                    end
                                }
                            };
                            local v496 = {
                                Owner = v471.Player, 
                                HitboxConfig = v490, 
                                Lifetime = 10, 
                                InitialCFrame = v485, 
                                InitialVelocity = (v484.Position - v485.Position).Unit * v473.ProjectileSpeed, 
                                Model = v482, 
                                CastParams = v486, 
                                Callbacks = {
                                    HitHuman = function(v491, v492) --[[ Line: 2054 ]] --[[ Name: HitHuman ]]
                                        -- upvalues: v10 (ref), v471 (ref)
                                        v10:Play(v471.Config.Sounds.BatsBatHit, {
                                            Position = v491.PreviousCFrame.Position
                                        });
                                        v491:Destroy();
                                    end, 
                                    HitOther = function(v493, v494) --[[ Line: 2058 ]] --[[ Name: HitOther ]]
                                        -- upvalues: v10 (ref), v471 (ref)
                                        v10:Play(v471.Config.Sounds.BatsBatMiss, {
                                            Position = v493.PreviousCFrame.Position
                                        });
                                        v493:Destroy();
                                    end, 
                                    Ended = function(v495) --[[ Line: 2062 ]] --[[ Name: Ended ]]
                                        -- upvalues: v471 (ref), v19 (ref)
                                        v471:SetCooldownOf("Bats", v471.Behavior.Abilities.Bats.Cooldown);
                                        v471.State.ActiveBats = nil;
                                        v19:FireClientConnection(v471.Player, "SetAbilityName", "REMOTE_EVENT", "Bats", "Hunter's Feast");
                                    end
                                }, 
                                ClientCallbackData = {
                                    RedirectEvent = {
                                        Redirect = {}
                                    }
                                }
                            };
                            local v497 = v21.new(v496);
                            v497:Launch();
                            v471.State.ActiveBats = v497;
                            v27(v473.Endlag, function() --[[ Line: 2083 ]]
                                -- upvalues: v471 (ref)
                                v471.AbilitiesDisabled = false;
                            end);
                            return;
                        end;
                    end);
                    return "Grounded";
                end;
            else
                if v29 and v472 == "Grounded" then
                    v471.Animations.BatsThrow:Play(0.025);
                    local v498 = v473.Endlag + v473.Windup;
                    v14:ToggleSprinting("BatsDuration", false, v498);
                    v14:CreateSpeedMultiplier(v471.Rig, v473.Walkspeed, "Bats", v498, true);
                end;
                return;
            end;
        end
    }, 
    Ascent = {
        Name = "Ascension", 
        Icon = "rbxassetid://87426383077507", 
        SpecialName = "Dismount", 
        SpecialIcon = "rbxassetid://97183429269286", 
        LayoutOrder = 5, 
        KeybindType = "AltAbility4", 
        Cooldown = 30, 
        Callback = function(v499) --[[ Line: 2114 ]] --[[ Name: Callback ]]
            -- upvalues: v30 (copy), v80 (copy), v26 (copy), v70 (copy), v14 (copy), v19 (copy), v27 (copy), v250 (copy), v29 (copy)
            local v500 = ("%*NosFlightCancel"):format(v499.Player.Name);
            local v501 = v499.Config.Ascent;
            if v30 then
                local v502 = v499.Rig;
                v80(v499, "AscentStart");
                v499.AbilitiesDisabled = true;
                v26(function() --[[ Line: 2134 ]]
                    -- upvalues: v70 (ref), v501 (copy), v499 (copy), v14 (ref), v19 (ref), v500 (copy), v27 (ref), v250 (ref)
                    local v503 = v70;
                    local v504 = v501.Windup;
                    local v505 = v499;
                    if v503(v504, function(v506) --[[ Line: 184 ]]
                        -- upvalues: v14 (ref)
                        if v14:IsAlive(v506.Rig) and not v506.Rig:GetAttribute("Stunned") then
                            return false;
                        else
                            return true;
                        end;
                    end, v499) then
                        v19:RemoveConnection(v500, "REMOTE_EVENT");
                        v499.AbilitiesDisabled = false;
                        return;
                    else
                        v19:FireClientConnection(v499.Player, "NosAscentReceived", "REMOTE_EVENT");
                        v27(v501.Length, function() --[[ Line: 2143 ]]
                            -- upvalues: v19 (ref), v500 (ref), v250 (ref), v499 (ref)
                            v19:RemoveConnection(v500, "REMOTE_EVENT");
                            v250(v499);
                            v19:FireClientConnection(v499.Player, "NosAscentFlight", "REMOTE_EVENT");
                        end);
                        return;
                    end;
                end);
                return;
            else
                if v29 then
                    v499.Animations.Ascent:Play();
                    v14:ToggleSprinting("AscentDash", false, v501.Windup + v501.Length - 0.1);
                end;
                return;
            end;
        end
    }
};
return v1;