local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("ContentProvider");
local l_TweenService_0 = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local l_Lighting_0 = game:GetService("Lighting");
local l_Players_0 = game:GetService("Players");
local _ = game:GetService("Debris");
local _ = require(l_ReplicatedStorage_0.Shared.EventTypes);
local v8 = {};
local _ = require(l_ReplicatedStorage_0.Controllers.EncryptedAssetsController);
local v10 = require(l_ReplicatedStorage_0.Controllers.EventController.ClientEventUtils);
local _ = require(l_ReplicatedStorage_0.Controllers.AnimalController);
local v12 = require(l_ReplicatedStorage_0.Controllers.EffectController);
local _ = require(l_ReplicatedStorage_0.Controllers.CameraController);
local v14 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local v15 = require(l_ReplicatedStorage_0.Controllers.EventController);
local v16 = require(l_ReplicatedStorage_0.Controllers.CycleController);
local _ = require(l_ReplicatedStorage_0.Shared.SharedEventUtils);
local v18 = require(l_ReplicatedStorage_0.Packages.CreateTween);
local _ = require(l_ReplicatedStorage_0.Shared.TweenPivot);
local v20 = require(l_ReplicatedStorage_0.Datas.ServerData);
local v21 = require(l_ReplicatedStorage_0.Packages.Observers);
local v22 = require(l_ReplicatedStorage_0.Utils.MathUtils);
local v23 = require(l_ReplicatedStorage_0.Shared.Animals);
local _ = require(l_ReplicatedStorage_0.Packages.Signal);
local v25 = require(l_ReplicatedStorage_0.Packages.Trove);
local _ = require(l_ReplicatedStorage_0.Packages.Shake);
local v27 = require(l_ReplicatedStorage_0.Packages.Spr);
local v28 = require(l_ReplicatedStorage_0.Packages.Net);
local v29 = require(l_ReplicatedStorage_0.Shared.VFX);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local _ = workspace.CurrentCamera;
local l_Name_0 = script.Name;
local v33 = v28:RemoteEvent((("EventService/%*/BrainrotCandyAnimation"):format(l_Name_0)));
local v34 = v28:RemoteEvent((("EventService/%*/BrainrotHitAnimation"):format(l_Name_0)));
local v35 = v28:RemoteEvent((("EventService/%*/PlayerCandyAnimation"):format(l_Name_0)));
local v36 = v28:RemoteEvent((("EventService/%*/ScreenCandyAnimation"):format(l_Name_0)));
local v37 = v28:RemoteEvent((("EventService/%*/Burst"):format(l_Name_0)));
local v38 = v25.new();
local function _(v39, v40, v41)
    local v42 = v39:LoadAnimation(v40);
    (v41 or v38):Add(function()
        v42:Stop(0);
        v42:Destroy();
    end);
    return v42;
end;
v8.OnStart = function(_)
    local l_v15_ActiveEventData_0 = v15:GetActiveEventData(l_Name_0);
    assert(l_v15_ActiveEventData_0);
    local function _(v46)
        return (math.max(l_v15_ActiveEventData_0.startedAt + v46 - workspace:GetServerTimeNow(), 0));
    end;
    v38:Add(function()
        v12:Activate("Blink");
        v16:Update();
        v14:UpdateOST();
    end);
    local v48 = v38:Clone(script.Map);
    v48.Parent = workspace;
    if v20.IsBiggerServer() then
        v10.resizeEffects(v48.MapVFX, 2);
    end;
    v38:Add(v21.observeTag("HideInTrickOrTreat", function(v49)
        local l_Parent_0 = v49.Parent;
        v49.Parent = script;
        return function()
            pcall(function()
                v49.Parent = l_Parent_0;
            end);
        end;
    end, {
        workspace, 
        script
    }));
    v12:Activate("Blink");
    v16:Update();
    v14:UpdateOST();
    v12:Run("TrickOrTreatEvent", "GrassRecolor");
    v12:Run("TrickOrTreatEvent", "WallRecolor");
    v12:Run("TrickOrTreatEvent", "WallBottomRecolor");
    v38:Add(function()
        v12:Stop("TrickOrTreatEvent", "GrassRecolor");
        v12:Stop("TrickOrTreatEvent", "WallRecolor");
        v12:Stop("TrickOrTreatEvent", "WallBottomRecolor");
    end);
    v38:Add(v21.observeTag("TrickOrTreatDoor", function(v51)
        local l_v51_Pivot_0 = v51:GetPivot();
        return v21.observeAttribute(v51, "Open", function(v53)
            if not v53 then
                v27.target(v51, 0.75, 3.5, {
                    Pivot = l_v51_Pivot_0
                });
            else
                v27.target(v51, 0.75, 3.5, {
                    Pivot = l_v51_Pivot_0 * CFrame.Angles(0, 1.5707963267948966, 0)
                });
            end;
            return nil;
        end);
    end));
    local l_Cartoon_0 = l_Lighting_0:FindFirstChild("Cartoon");
    if l_Cartoon_0 then
        l_Cartoon_0.Parent = script;
        v38:Add(function()
            l_Cartoon_0.Parent = l_Lighting_0;
        end);
    end;
    v38:Clone(script.SkyTrickOrTreat).Parent = l_Lighting_0;
    local l_Atmosphere_0 = l_Lighting_0:FindFirstChild("Atmosphere");
    if l_Atmosphere_0 then
        l_Atmosphere_0.Parent = script;
        v38:Add(function()
            l_Atmosphere_0.Parent = l_Lighting_0;
        end);
    end;
    v38:Clone(script.AtmosphereTrickOrTreat).Parent = l_Lighting_0;
    local function v66(v56, v57, v58, v59)
        local v60 = v25.new();
        local l_v23_AnimatedModel_0 = v23:GetAnimatedModel(v57, "Idle");
        if not l_v23_AnimatedModel_0 then
            return;
        else
            v60:Add(l_v23_AnimatedModel_0);
            task.delay(v59 - workspace:GetServerTimeNow(), function()
                v60:Destroy();
            end);
            l_v23_AnimatedModel_0.PrimaryPart.Anchored = true;
            l_v23_AnimatedModel_0:PivotTo(v58);
            local l_Animator_0 = l_v23_AnimatedModel_0:FindFirstChild("AnimationController"):FindFirstChild("Animator");
            local l_v56_FirstChild_0 = v56:FindFirstChild(v57);
            if not l_v56_FirstChild_0 or not l_v56_FirstChild_0:IsA("Animation") then
                return;
            else
                local v64 = l_Animator_0:LoadAnimation(l_v56_FirstChild_0);
                (v60 or v38):Add(function()
                    v64:Stop(0);
                    v64:Destroy();
                end);
                local l_v64_0 = v64;
                l_v64_0.Priority = Enum.AnimationPriority.Action4;
                l_v64_0.Looped = false;
                task.delay(1, function()
                    l_v64_0:Play();
                end);
                return;
            end;
        end;
    end;
    v38:Add(v34.OnClientEvent:Connect(function(v67, v68, v69)
        v66(script.HitAnimations, v67, v68, v69);
    end));
    v38:Add(v33.OnClientEvent:Connect(function(v70, v71, v72)
        v66(script.Animations, v70, v71, v72);
        local v73 = v71 * CFrame.new(0, 0, -3) * CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966) + Vector3.new(0, 6, 0, 0);
        local v74 = script.CandyCornThrow:Clone();
        v74.CFrame = v73;
        v74.Parent = workspace;
        task.delay(1, v29.emit, v74);
        task.delay(6, function()
            v74:Destroy();
        end);
    end));
    v38:Add(v36.OnClientEvent:Connect(function(_)
        local v76 = Random.new();
        for _ = 1, 20 do
            local v78 = script.Image:Clone();
            v78.Position = UDim2.fromScale(v76:NextNumber(-0.25, 1.25), -0.25);
            v78.Rotation = v76:NextNumber(-120, 120);
            local v79 = v76:NextNumber(0.15, 0.2);
            v78.Size = UDim2.fromScale(v79, v79);
            v78.Parent = l_LocalPlayer_0.PlayerGui:FindFirstChild("Effects");
            v18(v78, TweenInfo.new(v76:NextNumber(0.75, 1.3), Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                Position = v78.Position + UDim2.fromScale(0, 1.5), 
                Rotation = v78.Rotation + v76:NextInteger(-3, 3) * 10
            }, true).Completed:Once(function()
                task.wait(1);
                v78:Destroy();
            end);
        end;
    end));
    v38:Add(v35.OnClientEvent:Connect(function(v80, v81)
        local v82 = 0;
        local v83 = script.CandyCorn:Clone();
        v83.Parent = workspace;
        local v84 = nil;
        v84 = v38:Add(l_RunService_0.PostSimulation:Connect(function(v85)
            debug.profilebegin("Trick or Treat:UpdateCandyCorn");
            v82 = v82 + v85;
            local v86 = v81.Character and v81.Character:GetPivot().Position or Vector3.new(0, 0, 0, 0);
            local v87 = v80 + (v86 - v80) * 0.5 + Vector3.new(0, 15, 0, 0);
            local l_l_TweenService_0_Value_0 = l_TweenService_0:GetValue(v82 / 0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
            v83:PivotTo(CFrame.new(v22.quadBezier(l_l_TweenService_0_Value_0, v80, v87, v86)));
            if l_l_TweenService_0_Value_0 >= 1 and v84 then
                v38:Remove(v84);
                v84 = nil;
                for _, v90 in v83:GetDescendants() do
                    if v90:IsA("BasePart") then
                        v90.Transparency = 1;
                    end;
                end;
                task.delay(3, function()
                    v83:Destroy();
                end);
            end;
            debug.profileend();
        end));
    end));
    v38:Add(v21.observeTag("TrickOrTreatEventPumpkin", function(v91)
        local v92 = v25.new();
        local v93 = v92:Clone(script.Pumpkin);
        v93:ScaleTo(v91:GetAttribute("Scale") or 1);
        v93.Parent = workspace;
        local l_Weld_0 = Instance.new("Weld");
        l_Weld_0.Part0 = v93.PrimaryPart;
        l_Weld_0.Part1 = v91;
        l_Weld_0.C0 = v93.PrimaryPart.PivotOffset;
        l_Weld_0.Parent = v93.PrimaryPart;
        local v95 = v93.AnimationController.Animator:LoadAnimation(script.Idle);
        v38:Add(function()
            v95:Stop(0);
            v95:Destroy();
        end);
        local l_v95_0 = v95;
        l_v95_0.Priority = Enum.AnimationPriority.Idle;
        l_v95_0.Looped = true;
        l_v95_0:Play();
        local v97 = v93.AnimationController.Animator:LoadAnimation(script.Move);
        v38:Add(function()
            v97:Stop(0);
            v97:Destroy();
        end);
        local l_v97_0 = v97;
        l_v97_0.Priority = Enum.AnimationPriority.Action;
        l_v97_0.Looped = true;
        v92:Add(v21.observeAttribute(v91, "Moving", function(v99)
            if v99 then
                l_v97_0:Play();
            else
                l_v97_0:Stop();
            end;
            return nil;
        end));
        return v92:WrapClean();
    end, {
        workspace
    }));
end;
v8.OnStop = function(_)
    v38:Destroy();
end;
v8.OnLoad = function(_)
    v37.OnClientEvent:Connect(function(v102)
        v10.playBurst(script.Burst, v102, {
            l_ReplicatedStorage_0.Sounds.Events["Trick or Treat"].BrainrotHit
        });
    end);
end;
return v8;
