-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local _ = game:GetService("ServerStorage");
local _ = game:GetService("ReplicatedStorage");
local _ = game:GetService("UserInputService");
local l_TweenService_0 = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local _ = game:GetService("Debris");
local v8 = require(game.ReplicatedStorage.Modules.Sounds);
local v9 = require(game.ReplicatedStorage.Modules.Util);
local v10 = {
    {
        Color3.new(1, 0, 0), 
        Color3.new(0.984314, 1, 0)
    }, 
    {
        Color3.new(1, 1, 1), 
        Color3.new(0, 0, 0)
    }, 
    {
        Color3.new(1, 0, 0), 
        Color3.new(0.984314, 1, 0)
    }, 
    {
        Color3.new(1, 1, 1), 
        Color3.new(0, 0, 0)
    }, 
    {
        Color3.new(1, 0.580392, 0.164706), 
        Color3.new(1, 0.533333, 0)
    }, 
    {
        Color3.new(0.317647, 0.317647, 0.317647)
    }
};
local function v15(v11, v12) --[[ Line: 23 ]] --[[ Name: toggleDescendants ]]
    for _, v14 in ipairs(v11:GetDescendants()) do
        if v14.Name == "MainVFX" then
            v14.Enabled = v12;
        elseif v14.Name == "MainImage" then
            v14.Transparency = v12 and 0 or 1;
        end;
    end;
end;
v0.OnVictory = function(_, v17, v18, _, v20) --[[ Line: 31 ]] --[[ Name: OnVictory ]]
    -- upvalues: l_RunService_0 (copy), v9 (copy), l_TweenService_0 (copy), v10 (copy), l_Players_0 (copy)
    if v17 == "Start" then
        game.Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", true);
        local v21 = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 36 ]]
            workspace.CurrentCamera.FieldOfView = 25;
        end);
        task.delay(v20, function() --[[ Line: 39 ]]
            -- upvalues: v21 (copy)
            v21:Disconnect();
        end);
        task.spawn(function() --[[ Line: 44 ]]
            -- upvalues: v9 (ref), v18 (copy), v20 (copy), l_TweenService_0 (ref), v10 (ref)
            local l_KillerCutsceneBackground_0 = workspace.Misc:FindFirstChild("KillerCutsceneBackground");
            local l_House_0 = l_KillerCutsceneBackground_0.House;
            local l_HouseLikeCarpet_0 = l_KillerCutsceneBackground_0.Dummies.HouseLikeCarpet;
            v9:PlayDummyCutsceneAnimations(v18, v20, "Victory");
            task.wait(1.3833333333333333);
            if not l_KillerCutsceneBackground_0 and l_HouseLikeCarpet_0 and l_House_0 and l_HouseLikeCarpet_0.Parent then
                return;
            else
                local l_Highlight_0 = l_House_0.Highlight;
                local l_Lens_0 = l_HouseLikeCarpet_0.Grass.Attachment.Lens;
                local l_particles_0 = l_House_0.particles;
                local v28 = Instance.new("ColorCorrectionEffect", game.Lighting);
                v28.Name = "DevestoOutroFX";
                v28.Brightness = 0.06;
                v28.TintColor = Color3.new(1, 1, 0.435294);
                l_TweenService_0:Create(v28, TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
                    Brightness = -0.1, 
                    TintColor = Color3.new(1, 0.941176, 0.823529)
                }):Play();
                game.Debris:AddItem(v28, 2.633333333333333);
                l_Lens_0.Enabled = true;
                l_Highlight_0.Enabled = true;
                for v29, v30 in ipairs(v10) do
                    l_Highlight_0.FillColor = v30[Random.new():NextInteger(1, #v30)];
                    l_Highlight_0.FillTransparency = (v29 - 1) / 5;
                    task.wait(0.035);
                end;
                l_Highlight_0.FillTransparency = 0.45;
                l_Highlight_0.FillColor = Color3.fromRGB(255, 110, 6);
                l_Highlight_0.OutlineColor = Color3.fromRGB(162, 71, 6);
                for _, v32 in ipairs(l_particles_0:GetChildren()) do
                    if v32:IsA("ParticleEmitter") then
                        v32.Enabled = true;
                        v32:Emit(50);
                    end;
                end;
                task.wait(0.4);
                v28.Brightness = 0.08;
                v28.Contrast = 0.07;
                l_TweenService_0:Create(v28, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Brightness = 0
                }):Play();
                task.wait(0.77);
                l_TweenService_0:Create(v28, TweenInfo.new(1.15, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                    Brightness = -0.2, 
                    Contrast = 0.2, 
                    Saturation = 0.8, 
                    TintColor = Color3.new(1, 0.3, 0.3)
                }):Play();
                task.wait(1.2);
                v28.Brightness = 0.8;
                v28.Contrast = -0.8;
                v28.TintColor = Color3.new(1, 0, 0);
                return;
            end;
        end);
        return;
    else
        if v17 == "End" then
            l_Players_0.LocalPlayer:SetAttribute("FOVMultipliersDisabled", nil);
        end;
        return;
    end;
end;
v0.OnIntroduction = function(_, _, _, v36) --[[ Line: 105 ]] --[[ Name: OnIntroduction ]]
    -- upvalues: v9 (copy), l_Players_0 (copy), v10 (copy), l_TweenService_0 (copy)
    local l_KillerCutsceneBackground_1 = workspace.Misc:FindFirstChild("KillerCutsceneBackground");
    local _ = v9:CreateFOVMultiplier(l_Players_0.LocalPlayer, 0.5, "DevestoIntro", v36);
    task.spawn(function() --[[ Line: 109 ]]
        -- upvalues: l_KillerCutsceneBackground_1 (copy), v9 (ref), v10 (ref), l_TweenService_0 (ref)
        local l_Wall_0 = l_KillerCutsceneBackground_1.Wall;
        local l_Highlight_1 = l_Wall_0:FindFirstChildOfClass("Highlight");
        local l_SelectionVFX_0 = l_KillerCutsceneBackground_1.SelectionVFX;
        task.wait(0.7);
        l_SelectionVFX_0:PivotTo(l_Wall_0:GetPivot());
        task.spawn(function() --[[ Line: 119 ]]
            -- upvalues: v9 (ref), v10 (ref), l_Highlight_1 (copy), l_TweenService_0 (ref)
            if v9:GetSettingValue("EpilepsyMode") then
                return;
            else
                for v42, v43 in ipairs(v10) do
                    l_Highlight_1.FillColor = v43[Random.new():NextInteger(1, #v43)];
                    l_Highlight_1.FillTransparency = (v42 - 1) / 5;
                    task.wait(0.02);
                end;
                l_TweenService_0:Create(l_Highlight_1, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    FillColor = Color3.new(0.9, 0.9, 0.9)
                }):Play();
                return;
            end;
        end);
        task.wait(0.4);
        l_Wall_0:Destroy();
        for _, v45 in ipairs(l_SelectionVFX_0:GetDescendants()) do
            if v45:IsA("SelectionBox") then
                v45:Destroy();
            elseif v45:IsA("ParticleEmitter") then
                v45.Enabled = false;
            end;
        end;
    end);
end;
v0.EnableVoidstar = function(v46) --[[ Line: 140 ]] --[[ Name: EnableVoidstar ]]
    -- upvalues: v15 (copy), v9 (copy), v8 (copy)
    assert(v46, "must pass killerInfo as argument");
    if v46.Behavior.VoidstarEnabled then
        return;
    else
        v46.Behavior.VoidstarEnabled = true;
        local l_Rig_0 = v46.Rig;
        local v48 = l_Rig_0 and l_Rig_0:FindFirstChild("Voidstar");
        if v48 then
            v48.Transparency = 0;
            v15(v48, true);
            v9:EmitParticles(v9:MergeTables({
                v48.Appear1, 
                v48.Appear2
            }, v48.AppearT:GetChildren()));
            v8:Play(v46.Config.Sounds.VoidstarEnable, {
                Parent = v48
            });
        end;
        return;
    end;
end;
v0.DisableVoidstar = function(v49) --[[ Line: 160 ]] --[[ Name: DisableVoidstar ]]
    -- upvalues: v15 (copy)
    assert(v49, "must pass killerInfo as argument");
    if not v49.Behavior.VoidstarEnabled then
        return;
    else
        v49.Behavior.VoidstarEnabled = false;
        local l_Rig_1 = v49.Rig;
        local v51 = l_Rig_1 and l_Rig_1:FindFirstChild("Voidstar");
        if v51 then
            v51.Transparency = 1;
            v15(v51, false);
        end;
        return;
    end;
end;
return v0;