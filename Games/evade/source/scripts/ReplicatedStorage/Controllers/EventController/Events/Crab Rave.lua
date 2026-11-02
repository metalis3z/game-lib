-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_ContentProvider_0 = game:GetService("ContentProvider");
local l_TweenService_0 = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("Lighting");
local l_Players_0 = game:GetService("Players");
local _ = require(l_ReplicatedStorage_0.Shared.EventTypes);
local v7 = {};
local v8 = require(l_ReplicatedStorage_0.Controllers.CameraController);
local v9 = require(l_ReplicatedStorage_0.Controllers.AnimalController);
local v10 = require(l_ReplicatedStorage_0.Controllers.EffectController);
local v11 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local v12 = require(l_ReplicatedStorage_0.Controllers.CycleController);
local v13 = require(l_ReplicatedStorage_0.Controllers.EventController);
local _ = require(l_ReplicatedStorage_0.Packages.Synchronizer);
local v15 = require(l_ReplicatedStorage_0.Packages.Observers);
local _ = require(l_ReplicatedStorage_0.Shared.TweenPivot);
local v17 = require(l_ReplicatedStorage_0.Packages.Signal);
local _ = require(l_ReplicatedStorage_0.Packages.FFlags);
local v19 = require(l_ReplicatedStorage_0.Packages.Trove);
local v20 = require(l_ReplicatedStorage_0.Packages.Net);
local v21 = require(l_ReplicatedStorage_0.Shared.VFX);
local v22 = v20:RemoteEvent("EventService/Crab Rave/Hit");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_CrabRave_0 = workspace.Sounds.CrabRave;
local l_Name_0 = script.Name;
local v26 = v19.new();
v7.OnStart = function(_) --[[ Line: 40 ]] --[[ Name: OnStart ]]
    -- upvalues: v13 (copy), l_Name_0 (copy), v26 (copy), l_ReplicatedStorage_0 (copy), v12 (copy), v11 (copy), l_CrabRave_0 (copy), l_TweenService_0 (copy), v21 (copy), v10 (copy), v15 (copy), v19 (copy), l_RunService_0 (copy), v8 (copy), v17 (copy), l_Players_0 (copy), l_LocalPlayer_0 (copy)
    local l_v13_ActiveEventData_0 = v13:GetActiveEventData(l_Name_0);
    assert(l_v13_ActiveEventData_0);
    local v29 = true;
    v26:Add(function() --[[ Line: 45 ]]
        -- upvalues: v29 (ref)
        v29 = false;
    end);
    l_ReplicatedStorage_0:SetAttribute("CrabRave", true);
    v26:Add(function() --[[ Line: 50 ]]
        -- upvalues: l_ReplicatedStorage_0 (ref), v12 (ref), v11 (ref)
        l_ReplicatedStorage_0:SetAttribute("CrabRave", nil);
        v12:Update();
        v11:UpdateOST();
    end);
    v26:Add(task.spawn(function() --[[ Line: 57 ]]
        -- upvalues: l_CrabRave_0 (ref), l_v13_ActiveEventData_0 (copy)
        while not l_CrabRave_0.IsLoaded do
            task.wait();
        end;
        l_CrabRave_0.TimePosition = math.max(l_CrabRave_0.TimePosition, workspace:GetServerTimeNow() - l_v13_ActiveEventData_0.startedAt);
    end));
    v12:Update();
    v11:UpdateOST();
    local v30 = v26:Add(Instance.new("ColorCorrectionEffect"));
    v30.Parent = workspace.CurrentCamera;
    local v31 = v26:Clone(script.Ocean);
    v31.Parent = workspace;
    local v32 = v26:Add(Instance.new("Highlight"));
    assert(v32);
    v32.DepthMode = Enum.HighlightDepthMode.Occluded;
    v32.FillColor = Color3.new(1, 1, 1);
    v32.FillTransparency = 1;
    v32.OutlineTransparency = 1;
    local function _(v33, v34) --[[ Line: 81 ]] --[[ Name: getTimeLeftForSync ]]
        -- upvalues: l_v13_ActiveEventData_0 (copy)
        return l_v13_ActiveEventData_0.startedAt + v33 - (v34 or workspace:GetServerTimeNow());
    end;
    for _, v37 in v31:GetChildren() do
        if v37:IsA("Beam") then
            local l_TextureLength_0 = v37.TextureLength;
            v37.TextureLength = 0;
            l_TweenService_0:Create(v31.ocean, TweenInfo.new(l_v13_ActiveEventData_0.startedAt + 45 - workspace:GetServerTimeNow(), Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                TextureLength = l_TextureLength_0
            }):Play();
        end;
    end;
    l_TweenService_0:Create(v31.att1, TweenInfo.new(l_v13_ActiveEventData_0.startedAt + 45 - workspace:GetServerTimeNow(), Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
        Position = Vector3.new(0, 0, 400, 0)
    }):Play();
    l_TweenService_0:Create(v30, TweenInfo.new(l_v13_ActiveEventData_0.startedAt + 1.95 - workspace:GetServerTimeNow()), {
        Brightness = -1.2
    }):Play();
    v26:Add(task.delay(l_v13_ActiveEventData_0.startedAt + 45 - workspace:GetServerTimeNow(), function() --[[ Line: 106 ]]
        -- upvalues: v21 (ref), v31 (copy)
        v21.enable(v31.oceanparticles);
    end));
    v10:Run("CrabRaveEvent", "GrassRecolor");
    v26:Add(function() --[[ Line: 111 ]]
        -- upvalues: v10 (ref)
        v10:Stop("CrabRaveEvent", "GrassRecolor");
    end);
    v26:Add(function() --[[ Line: 115 ]]
        -- upvalues: v10 (ref)
        v10:Activate("Blink");
    end);
    v26:Add(v15.observeTag("CrabRaveCrabFolder", function(v39) --[[ Line: 119 ]]
        -- upvalues: v32 (ref)
        v32.Parent = v39;
        return nil;
    end));
    v26:Add(v15.observeTag("CrabRaveCrabs", function(v40) --[[ Line: 124 ]]
        -- upvalues: v19 (ref), l_v13_ActiveEventData_0 (copy), l_RunService_0 (ref)
        local v41 = v19.new();
        local l_Name_1 = v40.Parent.Name;
        local v43 = v41:Clone(script.Crab);
        local v44 = nil;
        local v45 = nil;
        local function _(v46) --[[ Line: 134 ]] --[[ Name: loadAnimation ]]
            -- upvalues: v43 (copy), v41 (copy)
            local v47 = v43.AnimationController:LoadAnimation(v46);
            v41:Add(function() --[[ Line: 136 ]]
                -- upvalues: v47 (copy)
                v47:Stop(0);
                v47:Destroy();
            end);
            return v47;
        end;
        v43["Cylinder.005"].Transparency = 1;
        v41:Add(task.delay(l_v13_ActiveEventData_0.startedAt + 2 - workspace:GetServerTimeNow(), function() --[[ Line: 145 ]]
            -- upvalues: v43 (copy)
            v43["Cylinder.005"].Transparency = 0;
        end));
        local v49 = v41:Add(Instance.new("Weld"));
        v49.Part0 = v43["Cylinder.005"];
        v49.Part1 = v40.HumanoidRootPart;
        v49.C1 = CFrame.new(0, 3.6, 0);
        v49.Parent = v43;
        local v50 = 0;
        local v51 = 0;
        local v52 = CFrame.new(0, 3.6, 0);
        v41:Add(l_RunService_0.PostSimulation:Connect(function(v53) --[[ Line: 158 ]]
            -- upvalues: v51 (ref), v50 (ref), v49 (copy), v52 (copy)
            debug.profilebegin("Crab Rave:Crab:Rotate");
            if math.abs(v51 - v50) < 0.1 then
                return;
            else
                v50 = v51 + (v50 - v51) * math.exp(v53 * -1);
                v49.C1 = v52 * CFrame.Angles(0, v50, 0);
                debug.profileend();
                return;
            end;
        end));
        v43.Parent = v40;
        local l_Animation1_0 = script.Animation1;
        local v55 = v43.AnimationController:LoadAnimation(l_Animation1_0);
        local l_v55_0 = v55 --[[ copy: 13 -> 26 ]];
        v41:Add(function() --[[ Line: 136 ]]
            -- upvalues: l_v55_0 (copy)
            l_v55_0:Stop(0);
            l_v55_0:Destroy();
        end);
        local l_v55_1 = v55;
        v55 = script.Animation2;
        local v58 = v43.AnimationController:LoadAnimation(v55);
        local l_v58_0 = v58 --[[ copy: 14 -> 27 ]];
        v41:Add(function() --[[ Line: 136 ]]
            -- upvalues: l_v58_0 (copy)
            l_v58_0:Stop(0);
            l_v58_0:Destroy();
        end);
        l_Animation1_0 = v58;
        v58 = script.Animation3_Right;
        local v60 = v43.AnimationController:LoadAnimation(v58);
        local l_v60_0 = v60 --[[ copy: 15 -> 28 ]];
        v41:Add(function() --[[ Line: 136 ]]
            -- upvalues: l_v60_0 (copy)
            l_v60_0:Stop(0);
            l_v60_0:Destroy();
        end);
        v55 = v60;
        v60 = script.Animation3_Left;
        local v62 = v43.AnimationController:LoadAnimation(v60);
        local l_v62_0 = v62 --[[ copy: 16 -> 29 ]];
        v41:Add(function() --[[ Line: 136 ]]
            -- upvalues: l_v62_0 (copy)
            l_v62_0:Stop(0);
            l_v62_0:Destroy();
        end);
        v58 = v62;
        v58.Priority = Enum.AnimationPriority.Action;
        v62 = script.Animation4_Walk;
        local v64 = v43.AnimationController:LoadAnimation(v62);
        local l_v64_0 = v64 --[[ copy: 17 -> 30 ]];
        v41:Add(function() --[[ Line: 136 ]]
            -- upvalues: l_v64_0 (copy)
            l_v64_0:Stop(0);
            l_v64_0:Destroy();
        end);
        v60 = v64;
        v60.Priority = Enum.AnimationPriority.Action;
        v64 = script.Animation4_Attack;
        local v66 = v43.AnimationController:LoadAnimation(v64);
        local l_v66_0 = v66 --[[ copy: 18 -> 31 ]];
        v41:Add(function() --[[ Line: 136 ]]
            -- upvalues: l_v66_0 (copy)
            l_v66_0:Stop(0);
            l_v66_0:Destroy();
        end);
        v62 = v66;
        v62.Priority = Enum.AnimationPriority.Action4;
        v64 = v60;
        v66 = function(v68, v69) --[[ Line: 183 ]] --[[ Name: switchWalkAnimationTrack ]]
            -- upvalues: v64 (ref)
            if v64 == v68 then
                return;
            else
                local l_IsPlaying_0 = v64.IsPlaying;
                if l_IsPlaying_0 then
                    v64:Stop();
                end;
                v64 = v68;
                if l_IsPlaying_0 and not v69 then
                    v64:Play();
                end;
                return;
            end;
        end;
        l_v55_1:Play();
        v41:Add(v40:GetAttributeChangedSignal("IsRunning"):Connect(function() --[[ Line: 202 ]]
            -- upvalues: v40 (copy), v64 (ref), v44 (ref), v45 (ref)
            if v40:GetAttribute("IsRunning") then
                if not v64.IsPlaying then
                    v64:Play();
                end;
                if v44 then
                    v44.ParticleEmitter.Enabled = true;
                end;
                if v45 then
                    v45.ParticleEmitter.Enabled = true;
                    return;
                end;
            else
                if v64.IsPlaying then
                    v64:Stop();
                end;
                if v44 then
                    v44.ParticleEmitter.Enabled = false;
                end;
                if v45 then
                    v45.ParticleEmitter.Enabled = false;
                end;
            end;
        end));
        v41:Add(v40:GetAttributeChangedSignal("Attack"):Connect(function() --[[ Line: 231 ]]
            -- upvalues: v62 (copy)
            v62:Play();
        end));
        local l_Animation5_0 = script.Animation5;
        local v72 = v43.AnimationController:LoadAnimation(l_Animation5_0);
        local l_v72_0 = v72 --[[ copy: 21 -> 32 ]];
        v41:Add(function() --[[ Line: 136 ]]
            -- upvalues: l_v72_0 (copy)
            l_v72_0:Stop(0);
            l_v72_0:Destroy();
        end);
        local l_v72_1 = v72;
        l_v72_1.Priority = Enum.AnimationPriority.Action2;
        v72 = script.Animation6;
        local v75 = v43.AnimationController:LoadAnimation(v72);
        local l_v75_0 = v75 --[[ copy: 22 -> 33 ]];
        v41:Add(function() --[[ Line: 136 ]]
            -- upvalues: l_v75_0 (copy)
            l_v75_0:Stop(0);
            l_v75_0:Destroy();
        end);
        l_Animation5_0 = v75;
        l_Animation5_0.Priority = Enum.AnimationPriority.Action2;
        v75 = script.Animation7;
        local v77 = v43.AnimationController:LoadAnimation(v75);
        local l_v77_0 = v77 --[[ copy: 23 -> 34 ]];
        v41:Add(function() --[[ Line: 136 ]]
            -- upvalues: l_v77_0 (copy)
            l_v77_0:Stop(0);
            l_v77_0:Destroy();
        end);
        v72 = v77;
        v72.Priority = Enum.AnimationPriority.Action2;
        v77 = script.Animation8;
        local v79 = v43.AnimationController:LoadAnimation(v77);
        local l_v79_0 = v79 --[[ copy: 24 -> 35 ]];
        v41:Add(function() --[[ Line: 136 ]]
            -- upvalues: l_v79_0 (copy)
            l_v79_0:Stop(0);
            l_v79_0:Destroy();
        end);
        v75 = v79;
        v75.Priority = Enum.AnimationPriority.Action2;
        v77 = {
            [1] = l_v72_1, 
            [2] = l_Animation5_0, 
            [3] = v72, 
            [4] = v75
        };
        v79 = nil;
        v41:Add(v40:GetAttributeChangedSignal("Dance"):Connect(function() --[[ Line: 252 ]]
            -- upvalues: l_v13_ActiveEventData_0 (ref), v40 (copy), v77 (copy), v79 (ref)
            local v81 = nil;
            local v82 = l_v13_ActiveEventData_0.startedAt + 85 - workspace:GetServerTimeNow();
            local v83 = l_v13_ActiveEventData_0.startedAt + 105 - workspace:GetServerTimeNow();
            v81 = v82 <= 0 and v83 > 0 and 4 or v40:GetAttribute("Dance");
            if v81 and v77[v81] and v79 == v77[v81] then
                return;
            else
                if v79 then
                    v79:Stop();
                    v79 = nil;
                end;
                if v81 ~= nil then
                    v79 = v77[v81];
                    assert(v79);
                    v79:Play();
                end;
                return;
            end;
        end));
        local v84 = nil;
        v41:Add(task.delay(l_v13_ActiveEventData_0.startedAt + 7 - workspace:GetServerTimeNow(), function() --[[ Line: 280 ]]
            -- upvalues: l_v55_1 (copy), l_Animation1_0 (copy)
            l_v55_1:Stop();
            l_Animation1_0:Play();
        end));
        if l_Name_1 == "Ground" then
            v41:Add(v40:GetAttributeChangedSignal("ReachedFirstTarget"):Once(function() --[[ Line: 286 ]]
                -- upvalues: v84 (ref), v41 (copy), v43 (copy)
                v84 = v41:Clone(script.SanddrumRoll);
                local v85 = v41:Add(Instance.new("Weld"));
                v85.Part0 = v84;
                v85.Part1 = v43["Cylinder.005"];
                v85.C0 = CFrame.new(0.2, 3.629, 4.378);
                v85.Parent = v84;
                v84.Parent = v43;
            end));
        end;
        v41:Add(task.delay(l_v13_ActiveEventData_0.startedAt + 27.5 - workspace:GetServerTimeNow(), function() --[[ Line: 300 ]]
            -- upvalues: l_Name_1 (copy), v40 (copy), v84 (ref), v41 (copy), v58 (copy), v64 (ref), v51 (ref)
            if l_Name_1 == "Ground" then
                local _ = v40:GetPivot();
                if v84 then
                    local l_v84_0 = v84;
                    l_v84_0.ParticleEmitter.Enabled = false;
                    local l_l_v84_0_0 = l_v84_0 --[[ copy: 1 -> 2 ]];
                    task.delay(3, function() --[[ Line: 307 ]]
                        -- upvalues: v41 (ref), l_l_v84_0_0 (copy)
                        v41:Remove(l_l_v84_0_0);
                    end);
                    v84 = nil;
                end;
                local l_v58_1 = v58;
                if v64 ~= l_v58_1 then
                    if v64.IsPlaying then
                        v64:Stop();
                    end;
                    v64 = l_v58_1;
                end;
                v58:Play(nil, nil, 0.3333333333333333);
                v51 = 1.5707963267948966;
            end;
        end));
        v41:Add(task.delay(l_v13_ActiveEventData_0.startedAt + 31 - workspace:GetServerTimeNow(), function() --[[ Line: 320 ]]
            -- upvalues: l_Name_1 (copy), v58 (copy), v44 (ref), v41 (copy), v43 (copy), v45 (ref), l_Animation1_0 (copy), l_v55_1 (copy)
            if l_Name_1 == "Ground" then
                v58:AdjustSpeed(1);
                v44 = v41:Clone(script.WalkPart);
                assert(v44);
                local v90 = v41:Add(Instance.new("Weld"));
                v90.Part0 = v44;
                v90.Part1 = v43["Cylinder.005"];
                v90.C0 = CFrame.new(0.614, 3.129, 4.731) * CFrame.fromOrientation(0, -1.5707963267948966, 0);
                v90.Parent = v44;
                v44.Parent = v43;
                v45 = v41:Clone(script.WalkPart);
                assert(v45);
                local v91 = v41:Add(Instance.new("Weld"));
                v91.Part0 = v45;
                v91.Part1 = v43["Cylinder.005"];
                v91.C0 = CFrame.new(0.414, 3.129, -4.78) * CFrame.fromOrientation(0, -1.5707963267948966, 0);
                v91.Parent = v45;
                v45.Parent = v43;
                return;
            else
                if l_Name_1 == "Wall" then
                    l_Animation1_0:Stop();
                    l_v55_1:Play();
                end;
                return;
            end;
        end));
        v41:Add(task.delay(l_v13_ActiveEventData_0.startedAt + 43 - workspace:GetServerTimeNow(), function() --[[ Line: 353 ]]
            -- upvalues: v55 (copy), v51 (ref)
            v55:Play(nil, nil, 0.3333333333333333);
            v51 = 0;
        end));
        v41:Add(task.delay(l_v13_ActiveEventData_0.startedAt + 46 - workspace:GetServerTimeNow(), function() --[[ Line: 358 ]]
            -- upvalues: v55 (copy), v60 (copy), v64 (ref), l_Name_1 (copy), l_Animation1_0 (copy), l_v55_1 (copy)
            v55:Stop();
            local l_v60_1 = v60;
            if v64 ~= l_v60_1 then
                local l_IsPlaying_1 = v64.IsPlaying;
                if l_IsPlaying_1 then
                    v64:Stop();
                end;
                v64 = l_v60_1;
                if l_IsPlaying_1 then
                    v64:Play();
                end;
            end;
            if l_Name_1 == "Wall" then
                l_Animation1_0:Stop();
                l_v55_1:Play();
            end;
        end));
        v41:Add(task.delay(l_v13_ActiveEventData_0.startedAt + 141 - workspace:GetServerTimeNow(), function() --[[ Line: 368 ]]
            -- upvalues: l_v13_ActiveEventData_0 (ref), v41 (copy), l_RunService_0 (ref), l_v72_1 (copy), l_Animation5_0 (copy), v72 (copy), v75 (copy)
            local v94 = l_v13_ActiveEventData_0.startedAt + 161 - workspace:GetServerTimeNow();
            local v95 = 0;
            v41:Add(l_RunService_0.PreSimulation:Connect(function(v96) --[[ Line: 372 ]]
                -- upvalues: v95 (ref), v94 (copy), l_v72_1 (ref), l_Animation5_0 (ref), v72 (ref), v75 (ref)
                debug.profilebegin("Crab Rave:Crab:Adjust Dance Speed");
                v95 = v95 + v96;
                local v97 = v95 / v94;
                l_v72_1:AdjustSpeed((math.lerp(1, 0.1, v97)));
                l_Animation5_0:AdjustSpeed((math.lerp(1, 0.1, v97)));
                v72:AdjustSpeed((math.lerp(1, 0.1, v97)));
                v75:AdjustSpeed((math.lerp(1, 0.1, v97)));
                debug.profileend();
            end));
        end));
        return function() --[[ Line: 385 ]]
            -- upvalues: v41 (copy)
            v41:Destroy();
        end;
    end));
    local _ = workspace.CurrentCamera;
    local v99 = 0;
    local v100 = 0;
    v26:Add(l_RunService_0.PostSimulation:Connect(function(v101) --[[ Line: 396 ]]
        -- upvalues: v100 (ref), v99 (ref), l_CrabRave_0 (ref), v32 (ref), l_TweenService_0 (ref), v8 (ref)
        debug.profilebegin("Crab Rave:Update");
        v100 = v100 - v101;
        v99 = v99 - v101;
        local v102 = math.clamp((l_CrabRave_0.PlaybackLoudness - 100) / 900, 0, 1);
        if v99 <= 0 and v32 then
            v99 = 0.5;
            v32.FillTransparency = 0;
            l_TweenService_0:Create(v32, TweenInfo.new(0.3), {
                FillTransparency = 1
            }):Play();
        end;
        if v102 >= 0.25 and v100 <= 0 then
            v100 = 0.1;
            v8:Fov((v102 - 0.25) * 20 + 70, 0.1);
        end;
        debug.profileend();
    end));
    v26:Add(task.delay(l_v13_ActiveEventData_0.startedAt + 7 - workspace:GetServerTimeNow(), function() --[[ Line: 420 ]]
        -- upvalues: v32 (ref), l_TweenService_0 (ref), v30 (copy)
        if v32 then
            v32:Destroy();
            v32 = nil;
        end;
        local v103 = l_TweenService_0:Create(v30, TweenInfo.new(1), {
            Brightness = 0
        });
        v103:Play();
        v103.Completed:Once(function() --[[ Line: 431 ]]
            -- upvalues: v103 (copy)
            v103:Cancel();
            v103:Destroy();
        end);
    end));
    v26:Add(task.delay(l_v13_ActiveEventData_0.startedAt + 46 - workspace:GetServerTimeNow(), function() --[[ Line: 437 ]]
        -- upvalues: v26 (ref), v17 (ref), v15 (ref), l_Players_0 (ref), v19 (ref), l_RunService_0 (ref), l_v13_ActiveEventData_0 (copy), l_LocalPlayer_0 (ref)
        local _ = v26:Add(v17.new());
        local v116 = v26:Add(v15.observeCharacter(l_Players_0.LocalPlayer, function(_, v106) --[[ Line: 441 ]]
            -- upvalues: v19 (ref), l_RunService_0 (ref), l_v13_ActiveEventData_0 (ref), l_LocalPlayer_0 (ref)
            local v107 = v19.new();
            v107:Add(task.spawn(function() --[[ Line: 444 ]]
                -- upvalues: v106 (copy), v107 (copy), l_RunService_0 (ref), l_v13_ActiveEventData_0 (ref), l_LocalPlayer_0 (ref)
                local l_Humanoid_0 = v106:WaitForChild("Humanoid");
                if not l_Humanoid_0 then
                    return;
                else
                    local l_Animator_0 = l_Humanoid_0:WaitForChild("Animator");
                    if not l_Animator_0 then
                        return;
                    else
                        local v110 = l_Animator_0:LoadAnimation(script.Dance);
                        v110.Priority = Enum.AnimationPriority.Action;
                        v110:Play(2);
                        local v111 = 0;
                        local v112 = 0;
                        v107:Add(l_RunService_0.PostSimulation:Connect(function(v113) --[[ Line: 461 ]]
                            -- upvalues: l_v13_ActiveEventData_0 (ref), v110 (copy), v112 (ref), l_Humanoid_0 (copy), l_LocalPlayer_0 (ref), v111 (ref)
                            debug.profilebegin("Crab Rave:Player:Dance");
                            local l_workspace_ServerTimeNow_0 = workspace:GetServerTimeNow();
                            if l_v13_ActiveEventData_0.startedAt + 66 - (l_workspace_ServerTimeNow_0 or workspace:GetServerTimeNow()) > 0 then
                                if not v110.IsPlaying then
                                    v110:Play();
                                    v110.TimePosition = (l_workspace_ServerTimeNow_0 - l_v13_ActiveEventData_0.startedAt) % v110.Length;
                                end;
                                debug.profileend();
                                return;
                            else
                                local l_Length_0 = v110.Length;
                                if v112 ~= l_Length_0 and l_Length_0 > 0 then
                                    v112 = l_Length_0;
                                    v110.TimePosition = (l_workspace_ServerTimeNow_0 - l_v13_ActiveEventData_0.startedAt) % l_Length_0;
                                end;
                                if not (l_Humanoid_0.MoveDirection ~= Vector3.new(0, 0, 0, 0)) and not l_LocalPlayer_0:GetAttribute("Stealing") then
                                    if v111 < 3 then
                                        v111 = v111 + v113;
                                    elseif not v110.IsPlaying then
                                        v110:Play();
                                        v110.TimePosition = (l_workspace_ServerTimeNow_0 - l_v13_ActiveEventData_0.startedAt) % v110.Length;
                                    end;
                                else
                                    v111 = 0;
                                    if v110.IsPlaying then
                                        v110:Stop();
                                    end;
                                end;
                                debug.profileend();
                                return;
                            end;
                        end));
                        v107:Add(function() --[[ Line: 499 ]]
                            -- upvalues: v110 (copy)
                            v110:Stop();
                            v110:Destroy();
                        end);
                        return;
                    end;
                end;
            end));
            return v107:WrapClean();
        end));
        v26:Add(task.delay(l_v13_ActiveEventData_0.startedAt + 140 - workspace:GetServerTimeNow(), v116));
    end));
end;
v7.OnStop = function(_) --[[ Line: 512 ]] --[[ Name: OnStop ]]
    -- upvalues: v26 (copy)
    v26:Destroy();
end;
v7.OnLoad = function(_) --[[ Line: 516 ]] --[[ Name: OnLoad ]]
    -- upvalues: l_ContentProvider_0 (copy), v22 (copy), v9 (copy), v21 (copy)
    task.spawn(pcall, function() --[[ Line: 517 ]]
        -- upvalues: l_ContentProvider_0 (ref)
        l_ContentProvider_0:PreloadAsync(script:GetChildren());
    end);
    v22.OnClientEvent:Connect(function(v119) --[[ Line: 521 ]]
        -- upvalues: v9 (ref), v21 (ref)
        local v120 = nil;
        local v121 = nil;
        if type(v119) == "string" then
            local v122 = v9:GetAnimals()[v119];
            if not v122 then
                return;
            else
                local l_v122_0 = v122 --[[ copy: 3 -> 7 ]];
                local _ = function() --[[ Line: 530 ]] --[[ Name: getTargetPosition ]]
                    -- upvalues: l_v122_0 (copy)
                    local _ = nil;
                    local l_AnimalModel_0 = l_v122_0.AnimalModel;
                    return (if l_AnimalModel_0.PrimaryPart then l_AnimalModel_0.PrimaryPart.CFrame else l_AnimalModel_0:GetPivot()).Position + Vector3.new(0, l_v122_0.AnimalModel:GetExtentsSize().Y * 0.5, 0);
                end;
                local _ = nil;
                local l_AnimalModel_1 = v122.AnimalModel;
                v120 = (if l_AnimalModel_1.PrimaryPart then l_AnimalModel_1.PrimaryPart.CFrame else l_AnimalModel_1:GetPivot()).Position + Vector3.new(0, v122.AnimalModel:GetExtentsSize().Y * 0.5, 0);
                v121 = v122.AnimalModel.PrimaryPart;
            end;
        else
            v120 = v119:GetPivot().Position;
            v121 = v119;
        end;
        local v129 = script.CrabHit:Clone();
        v129:PivotTo(CFrame.new(v120));
        v129.Anchored = false;
        local l_WeldConstraint_0 = Instance.new("WeldConstraint");
        l_WeldConstraint_0.Part0 = v129;
        l_WeldConstraint_0.Part1 = v121;
        l_WeldConstraint_0.Parent = v129;
        v129.Parent = workspace;
        v21.emit(v129);
        task.delay(3, function() --[[ Line: 564 ]]
            -- upvalues: v129 (copy)
            v129:Destroy();
        end);
    end);
end;
return v7;