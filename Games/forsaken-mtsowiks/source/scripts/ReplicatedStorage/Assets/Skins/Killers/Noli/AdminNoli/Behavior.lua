-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:09:07 2025 ]]
local v0 = {};
local _ = require(game.ReplicatedStorage.GlobalTypes);
local _ = game:GetService("InsertService");
local l_TweenService_0 = game:GetService("TweenService");
local _ = game:GetService("ContentProvider");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Debris_0 = game:GetService("Debris");
local _ = game:GetService("Lighting");
local _ = require(game.ReplicatedStorage.Modules.Sounds);
local v9 = require(game.ReplicatedStorage.Modules.Util);
local _ = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
local _ = require(game.ReplicatedStorage.Modules.Network);
local v13 = require(game.ReplicatedStorage.Modules.Ragdolls);
local _ = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local v16 = require(l_ReplicatedStorage_0.Modules.Schematics.Lighting);
v0.LastManStanding = function(_, v18, _) --[[ Line: 24 ]] --[[ Name: LastManStanding ]]
    if not game["Run Service"]:IsServer() then
        return;
    else
        local l_Rig_0 = v18.Rig;
        if l_Rig_0 and l_Rig_0.Parent then
            local l_Romeo_0 = l_Rig_0:FindFirstChild("Romeo");
            local l_Admin_0 = l_Rig_0:FindFirstChild("Admin");
            local l_Torso_0 = l_Rig_0:FindFirstChild("Torso");
            local l_Voidstar_0 = l_Rig_0:FindFirstChild("Voidstar");
            local v25 = l_Torso_0 and l_Torso_0:FindFirstChild("Attachment");
            l_Voidstar_0.TextureID = "rbxassetid://134523633901575";
            for _, v27 in ipairs(l_Voidstar_0.Crush:GetChildren()) do
                if v27:IsA("ParticleEmitter") then
                    v27:Emit(40);
                end;
            end;
            if v25 then
                for _, v29 in ipairs(v25:GetDescendants()) do
                    if v29:IsA("ParticleEmitter") then
                        v29:Emit(20);
                    end;
                end;
            end;
            if l_Romeo_0 then
                for _, v31 in ipairs(l_Romeo_0:GetDescendants()) do
                    if v31:IsA("MeshPart") then
                        v31.Transparency = 1;
                    end;
                end;
            end;
            if l_Admin_0 then
                for _, v33 in ipairs(l_Admin_0:GetDescendants()) do
                    if v33:IsA("MeshPart") then
                        v33.Transparency = 0;
                    end;
                end;
            end;
        end;
        return;
    end;
end;
v0.OnExecution = function(_, v35, v36) --[[ Line: 67 ]] --[[ Name: OnExecution ]]
    -- upvalues: v13 (copy)
    local _ = v35.Rig;
    v35.Behavior.DisableVoidstar(v35);
    v35.Behavior.ToggleTendril(v35, true);
    task.delay(4.2, function() --[[ Line: 73 ]]
        -- upvalues: v35 (copy)
        v35.Behavior.EnableVoidstar(v35);
        v35.Behavior.ToggleTendril(v35, false);
    end);
    if v35.VoidstarVisibleThread then
        task.cancel(v35.VoidstarVisibleThread);
        v35.VoidstarVisibleThread = nil;
    end;
    task.delay(2.32, function() --[[ Line: 85 ]]
        -- upvalues: v13 (ref), v36 (copy)
        v13.AddProfile(v36, {
            Velocity = Vector3.new(0, 50, 0, 0), 
            KillEffects = {
                HeadSquash = true, 
                Explode = true
            }, 
            Applied = 1e999
        });
        local l_Humanoid_0 = v36:FindFirstChild("Humanoid");
        if l_Humanoid_0 then
            l_Humanoid_0.BreakJointsOnDeath = true;
            l_Humanoid_0.Health = 0;
        end;
    end);
end;
v0.Stab = function(v39, _, _) --[[ Line: 96 ]] --[[ Name: Stab ]]
    local l_Rig_2 = v39.Rig;
    local v43 = l_Rig_2 and l_Rig_2:FindFirstChild("Right Arm");
    if v43 then
        for _, v45 in ipairs(v43.BeamAttach:GetDescendants()) do
            if v45:IsA("Beam") then
                v45.Enabled = true;
                task.delay(0.4, function() --[[ Line: 105 ]]
                    -- upvalues: v45 (copy)
                    v45.Enabled = false;
                end);
            end;
        end;
    end;
end;
v0.OnVictory = function(_, v47, v48, v49, v50) --[[ Line: 113 ]] --[[ Name: OnVictory ]]
    -- upvalues: v16 (copy), l_Players_0 (copy), v9 (copy), l_Debris_0 (copy), l_TweenService_0 (copy)
    local l_ColorCorrectionEffect_0 = Instance.new("ColorCorrectionEffect");
    l_ColorCorrectionEffect_0.Name = "AdminOutroCCEffect";
    l_ColorCorrectionEffect_0.Parent = game.Lighting;
    if v47 == "Start" then
        v48.Config.EndingThread = spawn(function() --[[ Line: 120 ]]
            -- upvalues: v16 (ref), v48 (copy), l_Players_0 (ref), v9 (ref), v50 (copy), v49 (copy), l_Debris_0 (ref), l_TweenService_0 (ref)
            local l_CurrentCamera_0 = workspace.CurrentCamera;
            local function v53() --[[ Line: 122 ]] --[[ Name: __initialize ]]
                -- upvalues: v16 (ref), v48 (ref), l_Players_0 (ref), v9 (ref), v50 (ref)
                v16:SetCustomLighting(v48.Config.OutroLighting);
                l_Players_0.LocalPlayer:SetAttribute("FOVMultipliersDisabled", true);
                v9:PlayDummyCutsceneAnimations(v48, v50, "Victory");
            end;
            local v54 = workspace.Misc:WaitForChild(v48.Player.Name .. "CameraRig", 3);
            v54:PivotTo(v54:GetPrimaryPartCFrame() * CFrame.new(0, -3, 0) * CFrame.Angles(0, 4.71238898038469, 0));
            local v55 = workspace.Misc:WaitForChild("KillerCutsceneBackground", 3);
            local v56 = v55.Map.AdminSpawn:GetPrimaryPartCFrame() * CFrame.new(0, -3, 0) * CFrame.Angles(0, 4.71238898038469, 0);
            v55.Map.AdminSpawn:PivotTo(v56);
            local l_Mouths_0 = v49.Head.Mouths;
            for _, v59 in ipairs(l_Mouths_0:GetDescendants()) do
                if v59:IsA("MeshPart") then
                    if v59.Name == "Default" then
                        v59.Transparency = 0;
                    else
                        v59.Transparency = 0;
                    end;
                end;
            end;
            local l_ColorCorrectionEffect_1 = Instance.new("ColorCorrectionEffect");
            l_ColorCorrectionEffect_1.Parent = game.Lighting;
            l_ColorCorrectionEffect_1.Name = "AdminClap";
            task.delay(0.21, function() --[[ Line: 155 ]]
                -- upvalues: v55 (copy)
                v55.Map.AdminSpawn.tub.TP:Emit(50);
            end);
            if v9:GetSettingValue("EpilepsyMode") and v54 then
                task.delay(3.43, function() --[[ Line: 161 ]]
                    -- upvalues: l_ColorCorrectionEffect_1 (copy), l_Debris_0 (ref), l_TweenService_0 (ref)
                    l_ColorCorrectionEffect_1.Brightness = 0;
                    l_ColorCorrectionEffect_1.Contrast = 0;
                    l_ColorCorrectionEffect_1.Saturation = 0;
                    l_ColorCorrectionEffect_1.TintColor = Color3.fromRGB(255, 255, 255);
                    l_ColorCorrectionEffect_1.Enabled = true;
                    l_Debris_0:AddItem(l_ColorCorrectionEffect_1, 4);
                    l_TweenService_0:Create(l_ColorCorrectionEffect_1, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        TintColor = Color3.new(0, 0, 0)
                    }):Play();
                    l_TweenService_0:Create(l_ColorCorrectionEffect_1, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        Brightness = -1
                    }):Play();
                end);
                local l_WAHHH_0 = v54:WaitForChild("CamPart2"):WaitForChild("WAHHH");
                if l_WAHHH_0 then
                    for _, v63 in ipairs(l_WAHHH_0:GetDescendants()) do
                        if v63:IsA("ParticleEmitter") then
                            v63.Enabled = false;
                        end;
                    end;
                end;
            end;
            task.delay(3.55, function() --[[ Line: 185 ]]
                -- upvalues: l_ColorCorrectionEffect_1 (copy), l_Debris_0 (ref), l_TweenService_0 (ref)
                l_ColorCorrectionEffect_1.Brightness = 0;
                l_ColorCorrectionEffect_1.Contrast = 0;
                l_ColorCorrectionEffect_1.Saturation = 0;
                l_ColorCorrectionEffect_1.TintColor = Color3.fromRGB(255, 255, 255);
                l_ColorCorrectionEffect_1.Enabled = true;
                l_Debris_0:AddItem(l_ColorCorrectionEffect_1, 4);
                l_TweenService_0:Create(l_ColorCorrectionEffect_1, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    TintColor = Color3.new(0, 0, 0)
                }):Play();
                l_TweenService_0:Create(l_ColorCorrectionEffect_1, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    Brightness = -1
                }):Play();
            end);
            local function v73() --[[ Line: 198 ]] --[[ Name: __initializeBackground ]]
                -- upvalues: l_CurrentCamera_0 (copy), v49 (ref)
                if not workspace.Misc:WaitForChild("KillerCutsceneBackground", 3) then
                    warn((("[%*]: No killer background??"):format((script:GetFullName()))));
                end;
                if not l_CurrentCamera_0 then
                    return;
                else
                    l_CurrentCamera_0.FieldOfView = 28;
                    if v49 and v49.Parent then
                        local l_Romeo_1 = v49:FindFirstChild("Romeo");
                        local l_Admin_1 = v49:FindFirstChild("Admin");
                        local l_Torso_1 = v49:FindFirstChild("Torso");
                        local l_Voidstar_1 = v49:FindFirstChild("Voidstar");
                        if l_Torso_1 then
                            local _ = l_Torso_1:FindFirstChild("Attachment");
                        end;
                        l_Voidstar_1.TextureID = "rbxassetid://134523633901575";
                        if l_Romeo_1 then
                            for _, v70 in ipairs(l_Romeo_1:GetDescendants()) do
                                if v70:IsA("MeshPart") then
                                    v70.Transparency = 1;
                                end;
                            end;
                        end;
                        if l_Admin_1 then
                            for _, v72 in ipairs(l_Admin_1:GetDescendants()) do
                                if v72:IsA("MeshPart") then
                                    v72.Transparency = 0;
                                end;
                            end;
                        end;
                    end;
                    return;
                end;
            end;
            spawn(v53);
            spawn(v73);
        end);
        return;
    else
        if v47 == "End" then
            if v48 and v48.Config.EndingThread then
                coroutine.close(v48.Config.EndingThread);
                v48.Config.EndingThread = nil;
                l_ColorCorrectionEffect_0:Destroy();
            end;
            l_Players_0.LocalPlayer:SetAttribute("FOVMultipliersDisabled", nil);
        end;
        return;
    end;
end;
v0.OnIntroduction = function(_, v75, v76, v77) --[[ Line: 251 ]] --[[ Name: OnIntroduction ]]
    -- upvalues: v16 (copy), l_Players_0 (copy), v9 (copy)
    v16:SetCustomLighting(v75.Config.IntroLighting);
    local v78 = workspace.Misc:WaitForChild(v75.Player.Name .. "CameraRig", 3);
    v78:PivotTo(v78:GetPrimaryPartCFrame() * CFrame.new(0, -3, -2) * CFrame.Angles(0, 4.71238898038469, 0));
    local v79 = workspace.Misc:WaitForChild("KillerCutsceneBackground", 3);
    task.delay(0.17, function() --[[ Line: 259 ]]
        -- upvalues: v79 (copy)
        v79.Map.AdminSpawn.TP:Emit(50);
    end);
    local l_Mouths_1 = v76.Head.Mouths;
    for _, v82 in ipairs(l_Mouths_1:GetDescendants()) do
        if v82:IsA("MeshPart") then
            if v82.Name == "Default" then
                v82.Transparency = 1;
            else
                v82.Transparency = 0;
            end;
        end;
    end;
    task.delay(v77, function() --[[ Line: 274 ]]
        -- upvalues: v76 (copy)
        local l_Mouths_2 = v76.Head.Mouths;
        for _, v85 in ipairs(l_Mouths_2:GetDescendants()) do
            if v85:IsA("MeshPart") then
                if v85.Name == "Default" then
                    v85.Transparency = 0;
                else
                    v85.Transparency = 1;
                end;
            end;
        end;
    end);
    l_Players_0.LocalPlayer:SetAttribute("FOVMultipliersDisabled", nil);
    v9:CreateFOVMultiplier(l_Players_0.LocalPlayer, 0.28, "ADMIN", v77);
end;
return v0;