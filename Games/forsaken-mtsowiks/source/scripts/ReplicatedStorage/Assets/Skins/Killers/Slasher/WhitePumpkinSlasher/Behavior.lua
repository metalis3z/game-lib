-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:08:15 2025 ]]
local _ = require(game.ReplicatedStorage.GlobalTypes);
local _ = game:GetService("InsertService");
local l_TweenService_0 = game:GetService("TweenService");
local _ = game:GetService("ContentProvider");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v5 = {};
local v6 = require(l_ReplicatedStorage_0.Modules.Ragdolls);
local _ = require(game.ReplicatedStorage.Modules.Sounds);
local v8 = require(game.ReplicatedStorage.Modules.Util);
local _ = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
local _ = game:GetService("RunService");
local v12 = require(game.ReplicatedStorage.Modules.Schematics.Lighting);
local l_Players_0 = game:GetService("Players");
local l_Debris_0 = game:GetService("Debris");
v5.GashingWoundStart = function(_, v16) --[[ Line: 22 ]] --[[ Name: GashingWoundStart ]]
    local l_Rig_0 = v16.Rig;
    if not l_Rig_0 then
        return;
    else
        local l_EnderPearl_0 = l_Rig_0:FindFirstChild("EnderPearl");
        task.delay(0.56, function() --[[ Line: 26 ]]
            -- upvalues: l_EnderPearl_0 (copy)
            if l_EnderPearl_0 then
                l_EnderPearl_0.Transparency = 0;
            end;
        end);
        task.delay(1.53, function() --[[ Line: 32 ]]
            -- upvalues: l_EnderPearl_0 (copy), l_Rig_0 (copy)
            if l_EnderPearl_0 then
                l_EnderPearl_0.Transparency = 1;
            end;
            l_Rig_0.Torso.TP:Emit(25);
        end);
        return;
    end;
end;
v5.OnExecution = function(_, v20, v21) --[[ Line: 41 ]] --[[ Name: OnExecution ]]
    -- upvalues: v6 (copy)
    local l_Rig_1 = v20.Rig;
    if not l_Rig_1 then
        return;
    else
        local v23 = v21.Name == "Guest1337";
        local v24 = (v23 and -v20.Rig.PrimaryPart.CFrame.RightVector or v20.Rig.PrimaryPart.CFrame.LookVector) * 100;
        local v25 = v23 and 4.6 or 1.1;
        local l_EnderPearl_1 = l_Rig_1:FindFirstChild("EnderPearl");
        task.delay(1.5, function() --[[ Line: 51 ]]
            -- upvalues: l_EnderPearl_1 (copy)
            if l_EnderPearl_1 then
                l_EnderPearl_1.Transparency = 0;
            end;
        end);
        task.delay(2.18, function() --[[ Line: 57 ]]
            -- upvalues: l_EnderPearl_1 (copy), l_Rig_1 (copy)
            if l_EnderPearl_1 then
                l_EnderPearl_1.Transparency = 1;
            end;
            l_Rig_1.Torso.TP:Emit(25);
        end);
        delay(v25, function() --[[ Line: 65 ]]
            -- upvalues: v6 (ref), v21 (copy), v24 (copy), v23 (copy)
            v6.AddProfile(v21, {
                Velocity = v24, 
                KillEffects = if v23 then {
                    Decapitate = true
                } else nil
            });
            local l_Humanoid_0 = v21:FindFirstChildOfClass("Humanoid");
            if l_Humanoid_0 then
                l_Humanoid_0.BreakJointsOnDeath = false;
                l_Humanoid_0.Health = 0;
            end;
        end);
        return;
    end;
end;
v5.OnIntroduction = function(_, v29, _, v31) --[[ Line: 80 ]] --[[ Name: OnIntroduction ]]
    -- upvalues: v12 (copy), l_Players_0 (copy), v8 (copy)
    local l_CurrentCamera_0 = workspace.CurrentCamera;
    local function v33() --[[ Line: 82 ]] --[[ Name: __initialize ]]
        -- upvalues: v12 (ref), v29 (copy), l_Players_0 (ref), v8 (ref), v31 (copy)
        v12:SetCustomLighting(v29.Config.OutroLighting);
        l_Players_0.LocalPlayer:SetAttribute("FOVMultipliersDisabled", true);
        v8:PlayDummyCutsceneAnimations(v29, v31, "Introduction");
    end;
    local v34 = workspace.Misc:WaitForChild(v29.Player.Name .. "CameraRig", 3);
    v34:PivotTo(v34:GetPrimaryPartCFrame() * CFrame.new(0, -3, 0));
    local function v36() --[[ Line: 94 ]] --[[ Name: __initializeBackground ]]
        -- upvalues: l_CurrentCamera_0 (copy)
        local v35 = workspace.Misc:WaitForChild("KillerCutsceneBackground", 3);
        task.delay(2, function() --[[ Line: 97 ]]
            -- upvalues: v35 (copy)
            v35.Map.PaintingRegular:Destroy();
            v35.Map.PaintingBROKE.Wood:Emit(25);
        end);
        if not v35 then
            warn((("[%*]: No killer background??"):format((script:GetFullName()))));
        end;
        if not l_CurrentCamera_0 then
            return;
        else
            l_CurrentCamera_0.FieldOfView = 28;
            return;
        end;
    end;
    spawn(v33);
    spawn(v36);
    task.delay(v31, function() --[[ Line: 116 ]]
        -- upvalues: l_Players_0 (ref)
        l_Players_0.LocalPlayer:SetAttribute("FOVMultipliersDisabled", nil);
    end);
end;
v5.OnVictory = function(_, v38, v39, v40, v41) --[[ Line: 121 ]] --[[ Name: OnVictory ]]
    -- upvalues: v12 (copy), l_Players_0 (copy), v8 (copy), l_Debris_0 (copy), l_TweenService_0 (copy)
    if v38 == "Start" then
        v39.Config.EndingThread = spawn(function() --[[ Line: 123 ]]
            -- upvalues: v12 (ref), v39 (copy), l_Players_0 (ref), v8 (ref), v41 (copy), v40 (copy), l_Debris_0 (ref), l_TweenService_0 (ref)
            local l_CurrentCamera_1 = workspace.CurrentCamera;
            local function v43() --[[ Line: 125 ]] --[[ Name: __initialize ]]
                -- upvalues: v12 (ref), v39 (ref), l_Players_0 (ref), v8 (ref), v41 (ref)
                v12:SetCustomLighting(v39.Config.OutroLighting);
                l_Players_0.LocalPlayer:SetAttribute("FOVMultipliersDisabled", true);
                v8:PlayDummyCutsceneAnimations(v39, v41, "Victory");
            end;
            local l_ColorCorrectionEffect_0 = Instance.new("ColorCorrectionEffect");
            l_ColorCorrectionEffect_0.Name = "WPOutroCCEffect";
            l_ColorCorrectionEffect_0.Parent = game.Lighting;
            local v45 = workspace.Misc:WaitForChild(v39.Player.Name .. "CameraRig", 3);
            v45:PivotTo(v45:GetPrimaryPartCFrame() * CFrame.new(0, -3, 0) * CFrame.Angles(0, 4.71238898038469, 0));
            local v46 = script.FlintandSteel.Flint:Clone();
            v46.Parent = v40;
            v46.Joint.Part0 = v40["Left Arm"];
            local v47 = script.FlintandSteel.Steel:Clone();
            v47.Parent = v40;
            v47.Joint.Part0 = v40["Right Arm"];
            local v48 = v40.Pumpkin.ExtraStuff["WP.Machete"];
            if v48 then
                v48.Transparency = 1;
            end;
            if v45 then
                task.delay(2, function() --[[ Line: 155 ]]
                    -- upvalues: l_Debris_0 (ref), l_TweenService_0 (ref)
                    local l_ColorCorrectionEffect_1 = Instance.new("ColorCorrectionEffect");
                    l_ColorCorrectionEffect_1.Parent = game.Lighting;
                    l_ColorCorrectionEffect_1.Name = "SlasherEvil";
                    l_ColorCorrectionEffect_1.Brightness = 0;
                    l_ColorCorrectionEffect_1.Contrast = 0;
                    l_ColorCorrectionEffect_1.Saturation = 0;
                    l_ColorCorrectionEffect_1.TintColor = Color3.fromRGB(255, 255, 255);
                    l_ColorCorrectionEffect_1.Enabled = true;
                    l_Debris_0:AddItem(l_ColorCorrectionEffect_1, 4);
                    l_TweenService_0:Create(l_ColorCorrectionEffect_1, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        TintColor = Color3.new(0, 0, 0)
                    }):Play();
                    l_TweenService_0:Create(l_ColorCorrectionEffect_1, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        Brightness = -1
                    }):Play();
                end);
                local l_WAHHH_0 = v45:WaitForChild("CamPart2"):WaitForChild("WAHHH");
                if l_WAHHH_0 then
                    for _, v52 in ipairs(l_WAHHH_0:GetDescendants()) do
                        if v52:IsA("ParticleEmitter") then
                            v52.Enabled = false;
                        end;
                    end;
                end;
            end;
            local function v53() --[[ Line: 181 ]] --[[ Name: __initializeBackground ]]
                -- upvalues: l_CurrentCamera_1 (copy)
                if not workspace.Misc:WaitForChild("KillerCutsceneBackground", 3) then
                    warn((("[%*]: No killer background??"):format((script:GetFullName()))));
                end;
                if not l_CurrentCamera_1 then
                    return;
                else
                    l_CurrentCamera_1.FieldOfView = 28;
                    return;
                end;
            end;
            spawn(v43);
            spawn(v53);
        end);
        return;
    else
        if v38 == "End" then
            if v39 and v39.Config.EndingThread then
                coroutine.close(v39.Config.EndingThread);
                v39.Config.EndingThread = nil;
            end;
            l_Players_0.LocalPlayer:SetAttribute("FOVMultipliersDisabled", nil);
        end;
        return;
    end;
end;
return v5;