-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:09:06 2025 ]]
local v0 = {};
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local l_Lighting_0 = game:GetService("Lighting");
local _ = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local v6 = require(game.ReplicatedStorage.Modules.Sounds);
local v7 = require(game.ReplicatedStorage.Modules.Util);
local _ = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
local _ = require(game.ReplicatedStorage.Modules.Network);
local v11 = require(game.ReplicatedStorage.Modules.Ragdolls);
local v12 = require(l_ReplicatedStorage_0.Modules.Schematics.Lighting);
local l_delay_0 = task.delay;
local l_spawn_0 = task.spawn;
local l_wait_0 = task.wait;
local _ = coroutine.close;
local function v21(v17) --[[ Line: 22 ]] --[[ Name: __createVoidstar ]]
    local l_NovaProjectile_0 = v17.Config.NovaProjectile;
    local v19 = (l_NovaProjectile_0:IsA("Folder") and l_NovaProjectile_0:GetChildren()[math.random(#l_NovaProjectile_0:GetChildren())] or l_NovaProjectile_0):Clone();
    v19.Name = "Voidstar";
    v19.Parent = v17.Rig;
    local l_Motor6D_0 = Instance.new("Motor6D");
    l_Motor6D_0.C0 = CFrame.new((Vector3.new(0, -0.10000000149011612, 0, 0)));
    l_Motor6D_0.C1 = CFrame.new((Vector3.new(0, -0.10000000149011612, 0, 0)));
    l_Motor6D_0.Part0 = v17.Rig.PrimaryPart;
    l_Motor6D_0.Part1 = v19;
    l_Motor6D_0.Parent = v17.Rig.PrimaryPart;
    return v19;
end;
v0.OnExecution = function(_, v23, v24) --[[ Line: 45 ]] --[[ Name: OnExecution ]]
    -- upvalues: l_delay_0 (copy), v11 (copy)
    local l_Rig_0 = v23.Rig;
    v23.Behavior.DisableVoidstar(v23);
    v23.Behavior.ToggleTendril(v23, true);
    l_delay_0(4.2, function() --[[ Line: 51 ]]
        -- upvalues: v23 (copy)
        v23.Behavior.EnableVoidstar(v23);
        v23.Behavior.ToggleTendril(v23, false);
    end);
    if v23.VoidstarVisibleThread then
        task.cancel(v23.VoidstarVisibleThread);
        v23.VoidstarVisibleThread = nil;
    end;
    l_delay_0(2.4, function() --[[ Line: 63 ]]
        -- upvalues: v11 (ref), v24 (copy), l_Rig_0 (copy), l_delay_0 (ref)
        v11.AddProfile(v24, {
            Velocity = Vector3.new(0, 50, 0, 0), 
            KillEffects = {
                HeadSquash = true
            }
        });
        local l_Head_0 = v24:FindFirstChild("Head");
        local l_Humanoid_0 = v24:FindFirstChild("Humanoid");
        if l_Humanoid_0 then
            l_Humanoid_0.BreakJointsOnDeath = false;
            l_Humanoid_0.Health = 0;
            if l_Head_0 then
                l_Head_0:Destroy();
            end;
            for _, v29 in ipairs(l_Rig_0.Voidstar.Crush:GetChildren()) do
                if v29:IsA("ParticleEmitter") then
                    v29.Enabled = true;
                end;
            end;
            l_delay_0(0.125, function() --[[ Line: 82 ]]
                -- upvalues: l_Rig_0 (ref)
                for _, v31 in ipairs(l_Rig_0.Voidstar.Crush:GetChildren()) do
                    if v31:IsA("ParticleEmitter") then
                        v31.Enabled = false;
                    end;
                end;
            end);
        end;
    end);
    if v24:GetAttribute("SkinName") == "IHasAFaceLulzNoob" then
        local l_Humanoid_1 = v24:FindFirstChild("Humanoid");
        local v33 = v23.Rig.PrimaryPart.CFrame.LookVector.Unit * 200;
        local l_TentacleBase_0 = v23.Rig["Right Arm"].TentacleBase;
        for _, v36 in ipairs(l_TentacleBase_0:GetDescendants()) do
            if v36:IsA("Beam") then
                v36.Enabled = true;
                l_delay_0(1.37, function() --[[ Line: 101 ]]
                    -- upvalues: v36 (copy)
                    v36.Enabled = false;
                end);
            end;
        end;
        l_delay_0(3.35, function() --[[ Line: 107 ]]
            -- upvalues: l_Humanoid_1 (copy), v11 (ref), v24 (copy), v33 (copy)
            if l_Humanoid_1 then
                v11.AddProfile(v24, {
                    Velocity = v33
                });
                l_Humanoid_1.Health = 0;
                l_Humanoid_1.BreakJointsOnDeath = true;
            end;
        end);
    end;
end;
v0.OnVictory = function(_, v38, v39, _, v41) --[[ Line: 117 ]] --[[ Name: OnVictory ]]
    -- upvalues: l_spawn_0 (copy), l_Players_0 (copy), v12 (copy), v7 (copy), l_Lighting_0 (copy), l_TweenService_0 (copy), l_delay_0 (copy), l_wait_0 (copy)
    if v38 == "Start" then
        v39.Config.EndingThread = l_spawn_0(function() --[[ Line: 119 ]]
            -- upvalues: l_Players_0 (ref), v12 (ref), v39 (copy), v7 (ref), v41 (copy), l_Lighting_0 (ref), l_TweenService_0 (ref), l_delay_0 (ref), l_wait_0 (ref), l_spawn_0 (ref)
            local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
            local l_l_Players_0_UserThumbnailAsync_0 = l_Players_0:GetUserThumbnailAsync(l_LocalPlayer_0.UserId, Enum.ThumbnailType.AvatarThumbnail, Enum.ThumbnailSize.Size352x352);
            local l_CurrentCamera_0 = workspace.CurrentCamera;
            local function v45() --[[ Line: 124 ]] --[[ Name: __initialize ]]
                -- upvalues: v12 (ref), v39 (ref), l_Players_0 (ref), v7 (ref), v41 (ref)
                v12:SetCustomLighting(v39.Config.OutroLighting);
                l_Players_0.LocalPlayer:SetAttribute("FOVMultipliersDisabled", true);
                v7:PlayDummyCutsceneAnimations(v39, v41, "Victory");
            end;
            local function v51() --[[ Line: 130 ]] --[[ Name: __initializeBackground ]]
                -- upvalues: l_CurrentCamera_0 (copy), l_l_Players_0_UserThumbnailAsync_0 (copy), l_LocalPlayer_0 (copy), l_Lighting_0 (ref), l_TweenService_0 (ref), l_delay_0 (ref), l_wait_0 (ref)
                local v46 = workspace.Misc:WaitForChild("KillerCutsceneBackground", 3);
                if not v46 then
                    warn((("[%*]: No killer background??"):format((script:GetFullName()))));
                end;
                if not l_CurrentCamera_0 then
                    return;
                else
                    l_CurrentCamera_0.FieldOfView = 30;
                    local l_NIKO_Image_0 = v46:FindFirstChild("map").NIKO_Image;
                    if not l_NIKO_Image_0 then
                        return;
                    else
                        local l_Decal_0 = l_NIKO_Image_0:FindFirstChildOfClass("Decal");
                        if l_Decal_0 then
                            l_Decal_0.Texture = l_l_Players_0_UserThumbnailAsync_0;
                        end;
                        local v49 = l_NIKO_Image_0:FindFirstChild("TextDisplay") and l_NIKO_Image_0.TextDisplay.Display;
                        if v49 then
                            v49.Text = l_LocalPlayer_0.Name;
                        end;
                        local l_ColorCorrectionEffect_0 = l_Lighting_0:FindFirstChildOfClass("ColorCorrectionEffect");
                        if not l_ColorCorrectionEffect_0 then
                            return;
                        else
                            l_TweenService_0:Create(l_CurrentCamera_0, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                                FieldOfView = 55
                            }):Play();
                            l_delay_0(0.26, function() --[[ Line: 170 ]]
                                -- upvalues: l_TweenService_0 (ref), l_NIKO_Image_0 (copy)
                                l_TweenService_0:Create(l_NIKO_Image_0, TweenInfo.new(1.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                                    Orientation = Vector3.new(-90, -90, -90, 0)
                                }):Play();
                            end);
                            l_delay_0(1, function() --[[ Line: 180 ]]
                                -- upvalues: l_CurrentCamera_0 (ref), l_TweenService_0 (ref)
                                l_CurrentCamera_0.FieldOfView = 110;
                                l_TweenService_0:Create(l_CurrentCamera_0, TweenInfo.new(1.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                                    FieldOfView = 50
                                }):Play();
                            end);
                            l_delay_0(3, function() --[[ Line: 192 ]]
                                -- upvalues: l_CurrentCamera_0 (ref), l_wait_0 (ref), l_TweenService_0 (ref)
                                l_CurrentCamera_0.FieldOfView = 50;
                                l_wait_0(0.3);
                                l_TweenService_0:Create(l_CurrentCamera_0, TweenInfo.new(0.67, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                                    FieldOfView = 55
                                }):Play();
                            end);
                            l_delay_0(5, function() --[[ Line: 206 ]]
                                -- upvalues: l_TweenService_0 (ref), l_CurrentCamera_0 (ref), l_ColorCorrectionEffect_0 (copy)
                                l_TweenService_0:Create(l_CurrentCamera_0, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                                    FieldOfView = 25
                                }):Play();
                                l_TweenService_0:Create(l_ColorCorrectionEffect_0, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                                    TintColor = Color3.fromRGB(255, 0, 0), 
                                    Contrast = 10, 
                                    Saturation = -0.2
                                }):Play();
                            end);
                            l_delay_0(6, function() --[[ Line: 226 ]]
                                -- upvalues: l_CurrentCamera_0 (ref)
                                l_CurrentCamera_0.FieldOfView = 25;
                            end);
                            return;
                        end;
                    end;
                end;
            end;
            l_spawn_0(v45);
            l_spawn_0(v51);
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
v0.OnIntroduction = function(_, v53, _, _) --[[ Line: 244 ]] --[[ Name: OnIntroduction ]]
    -- upvalues: v12 (copy)
    v12:SetCustomLighting(v53.Config.IntroLighting);
end;
v0.EnableVoidstar = function(v56) --[[ Line: 249 ]] --[[ Name: EnableVoidstar ]]
    -- upvalues: v21 (copy), v6 (copy)
    assert(v56, "must pass killerInfo as argument");
    if v56.Behavior.VoidstarEnabled then
        return;
    else
        v56.Behavior.VoidstarEnabled = true;
        local _ = v56.Rig;
        local v58 = v21(v56);
        v58.Name = "Voidstar";
        v6:Play(v56.Config.Sounds.VoidstarEnable, {
            Parent = v58, 
            Volume = 0.2, 
            RollOffMaxDistance = 13
        });
        return;
    end;
end;
v0.DisableVoidstar = function(v59) --[[ Line: 263 ]] --[[ Name: DisableVoidstar ]]
    assert(v59, "must pass killerInfo as argument");
    if not v59.Behavior.VoidstarEnabled then
        return;
    else
        v59.Behavior.VoidstarEnabled = false;
        local l_Rig_2 = v59.Rig;
        local v61 = l_Rig_2 and l_Rig_2:FindFirstChild("Voidstar");
        if v61 then
            v61:Destroy();
        end;
        return;
    end;
end;
return v0;