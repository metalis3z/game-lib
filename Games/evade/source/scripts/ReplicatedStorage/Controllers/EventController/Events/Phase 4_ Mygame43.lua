-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = game:GetService("ServerScriptService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_ContentProvider_0 = game:GetService("ContentProvider");
local l_TweenService_0 = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("Players");
local _ = game:GetService("Debris");
local _ = require(l_ReplicatedStorage_0.Shared.EventTypes);
local v8 = {};
local v9 = require(l_ReplicatedStorage_0.Controllers.SkullEmojiEffectController);
local v10 = require(l_ReplicatedStorage_0.Controllers.EffectController);
local _ = require(l_ReplicatedStorage_0.Controllers.AnimalController);
local v12 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local _ = require(l_ReplicatedStorage_0.Controllers.CycleController);
local v14 = require(l_ReplicatedStorage_0.Controllers.EventController);
local _ = require(l_ReplicatedStorage_0.Controllers.EventController.ClientEventUtils);
local v16 = require(l_ReplicatedStorage_0.Shared.SharedEventUtils);
local _ = require(l_ReplicatedStorage_0.Packages.CreateTween);
local v18 = require(l_ReplicatedStorage_0.Shared.ShakePresets);
local v19 = require(l_ReplicatedStorage_0.Packages.Observers);
local v20 = require(l_ReplicatedStorage_0.Utils.MathUtils);
local v21 = require(l_ReplicatedStorage_0.Packages.Shake);
local v22 = require(l_ReplicatedStorage_0.Packages.Trove);
local v23 = require(l_ReplicatedStorage_0.Packages.Net);
local v24 = require(l_ReplicatedStorage_0.Packages.Spr);
local v25 = require(l_ReplicatedStorage_0.Shared.VFX);
local l_Name_0 = script.Name;
local v27 = v23:RemoteEvent((("EventService/%*/CreateLightningOrb"):format(l_Name_0)));
local v28 = RaycastParams.new();
v28.FilterDescendantsInstances = {
    workspace.Events["Los Matteos"].Areas
};
v28.FilterType = Enum.RaycastFilterType.Include;
local l_CurrentCamera_0 = workspace.CurrentCamera;
local v30 = v22.new();
local v31 = v21.new();
v31.Amplitude = 5.5;
v31.Frequency = 0.05;
v31.FadeInTime = 0;
v31.FadeOutTime = 0.6;
v31.PositionInfluence = Vector3.new(0.5, 0.5, 0.5, 0);
v31.RotationInfluence = Vector3.new(2.5, 0.5, 0.5, 0);
local function v36(v32) --[[ Line: 58 ]] --[[ Name: shakeCameraBasedOnProximity ]]
    -- upvalues: l_CurrentCamera_0 (copy), v31 (copy), v30 (copy), v18 (copy)
    local l_Magnitude_0 = (l_CurrentCamera_0.CFrame.Position - v32).Magnitude;
    if l_Magnitude_0 <= 300 then
        local v34 = v31:Clone();
        local v35 = (1 - l_Magnitude_0 / 300 * 0.5) ^ 2;
        v34.Amplitude = v34.Amplitude * v35;
        v34.RotationInfluence = v34.RotationInfluence * v35;
        v30:Add(v18.BindShakeToCamera(v34));
        v34:Start();
    end;
end;
v8.OnStart = function(_) --[[ Line: 76 ]] --[[ Name: OnStart ]]
    -- upvalues: v14 (copy), l_Name_0 (copy), v30 (copy), v10 (copy), l_ReplicatedStorage_0 (copy), v19 (copy), v24 (copy), l_RunService_0 (copy), v25 (copy), l_CurrentCamera_0 (copy), v9 (copy), v27 (copy), l_TweenService_0 (copy), v16 (copy), v20 (copy), v36 (copy), v12 (copy)
    local l_v14_ActiveEventData_0 = v14:GetActiveEventData(l_Name_0);
    assert(l_v14_ActiveEventData_0);
    local function _(v39) --[[ Line: 80 ]] --[[ Name: calculateTimeLeftFor ]]
        -- upvalues: l_v14_ActiveEventData_0 (copy)
        return l_v14_ActiveEventData_0.startedAt + v39 - workspace:GetServerTimeNow();
    end;
    v30:Add(function() --[[ Line: 84 ]]
        -- upvalues: v10 (ref)
        v10:Activate("Blink");
    end);
    local v41 = nil;
    local function _(v42) --[[ Line: 91 ]] --[[ Name: getOrbPosition ]]
        -- upvalues: v41 (ref)
        local v43 = true;
        if v42 ~= 2 then
            v43 = v42 == 3;
        end;
        local v44 = v43 and 70 or 50;
        local v45 = CFrame.new((v42 - 1) * 30 + -45, v44, 15);
        if v41 then
            return v41.HumanoidRootPart.CFrame * v45;
        else
            return v45;
        end;
    end;
    l_ReplicatedStorage_0.Sounds.Events["Phase 4: Mygame43"].Appear:Play();
    v30:Add(v19.observeTag("Mygame43", function(v47) --[[ Line: 106 ]]
        -- upvalues: v41 (ref), l_v14_ActiveEventData_0 (copy), v30 (ref), v24 (ref), l_RunService_0 (ref), v25 (ref), l_CurrentCamera_0 (ref), v9 (ref)
        v41 = v47;
        assert(v41);
        local v48 = v41.Humanoid.Animator:LoadAnimation(script.Idle);
        local v49 = v41.Humanoid.Animator:LoadAnimation(script.Spawn);
        v48:Play();
        v49:Play();
        v49.TimePosition = 7 - (l_v14_ActiveEventData_0.startedAt + 7 - workspace:GetServerTimeNow());
        v30:Add(task.delay(l_v14_ActiveEventData_0.startedAt + 7.7 - workspace:GetServerTimeNow(), function() --[[ Line: 118 ]]
            -- upvalues: v41 (ref), v30 (ref), v24 (ref), l_RunService_0 (ref)
            for v50 = 1, 4 do
                local v51 = true;
                if v50 ~= 2 then
                    v51 = v50 == 3;
                end;
                local v52 = v51 and 70 or 50;
                local v53 = CFrame.new((v50 - 1) * 30 + -45, v52, 15);
                local v54 = if v41 then v41.HumanoidRootPart.CFrame * v53 else v53;
                v51 = v30:Clone(script.Orb);
                v51.CFrame = v54 - Vector3.new(0, 100, 0, 0);
                v51.Parent = workspace;
                v30:Add(function() --[[ Line: 151 ]]
                    -- upvalues: v24 (ref), v51 (copy)
                    v24.stop(v51);
                end);
                v52 = Random.new():NextNumber(2, 3);
                v30:Add(l_RunService_0.PostSimulation:Connect(function(_) --[[ Line: 156 ]]
                    -- upvalues: v24 (ref), v51 (copy), v54 (copy), v50 (copy), v52 (copy)
                    debug.profilebegin("Mygame43:FloatOrb");
                    v24.target(v51, 0.8, 1, {
                        Pivot = v54 + Vector3.new(0, math.sin((os.clock() + v50 * 90) * v52) * 4, 0)
                    });
                    debug.profileend();
                end));
            end;
        end));
        v30:Add(task.delay(l_v14_ActiveEventData_0.startedAt + 3.6999999999999997 - workspace:GetServerTimeNow(), function() --[[ Line: 166 ]]
            -- upvalues: v25 (ref), v41 (ref), l_RunService_0 (ref), l_CurrentCamera_0 (ref), v9 (ref)
            v25.enable(v41);
            local _ = ("FocusMyGame43_%*"):format(os.clock() // 1);
            local v59 = l_RunService_0.PreRender:Connect(function(v57) --[[ Line: 170 ]]
                -- upvalues: l_CurrentCamera_0 (ref), v41 (ref)
                debug.profilebegin("Mygame43:Focus");
                local l_CFrame_0 = l_CurrentCamera_0.CFrame;
                l_CurrentCamera_0.CFrame = l_CFrame_0:Lerp(CFrame.lookAt(l_CFrame_0.Position, v41:GetPivot().Position), v57 ^ 0.45);
                debug.profileend();
            end);
            task.delay(0.6, function() --[[ Line: 177 ]]
                -- upvalues: v59 (copy), v9 (ref)
                v59:Disconnect();
                v9:Play(3, "Lower");
            end);
        end));
        return nil;
    end));
    v30:Add(v27.OnClientEvent:Connect(function(v60, v61, v62, v63, v64) --[[ Line: 186 ]]
        -- upvalues: v41 (ref), v30 (ref), l_ReplicatedStorage_0 (ref), v25 (ref), l_RunService_0 (ref), l_TweenService_0 (ref), v16 (ref), v20 (ref), v36 (ref), v12 (ref)
        local v65 = true;
        if v61 ~= 2 then
            v65 = v61 == 3;
        end;
        local v66 = v65 and 70 or 50;
        local v67 = CFrame.new((v61 - 1) * 30 + -45, v66, 15);
        local l_Position_0 = (if v41 then v41.HumanoidRootPart.CFrame * v67 else v67).Position;
        local v69 = v30:Clone(script.OrbSmaller);
        v69.CFrame = CFrame.new(l_Position_0);
        v65 = l_ReplicatedStorage_0.Sounds.Events["Phase 4: Mygame43"].OrbFlying:Clone();
        v65.Parent = v69;
        v69.Parent = workspace;
        v65:Play();
        v25.enable(v69);
        v66 = Random.new(v60);
        v67 = l_Position_0 + (v62 - l_Position_0) * 0.25 + Vector3.new(v66:NextNumber(50, 100) * (v66:NextInteger(0, 1) * 2 - 1), v66:NextInteger(300, 400), 0);
        local v70 = l_Position_0 + (v62 - l_Position_0) * 0.6 + Vector3.new(v66:NextNumber(50, 150) * (v66:NextInteger(0, 1) * 2 - 1), v66:NextInteger(100, 200), 0);
        local v71 = 0;
        local v72 = nil;
        v72 = v30:Add(l_RunService_0.PostSimulation:Connect(function(v73) --[[ Line: 209 ]]
            -- upvalues: v71 (ref), l_TweenService_0 (ref), v63 (copy), v16 (ref), v69 (copy), v20 (ref), l_Position_0 (copy), v67 (copy), v70 (copy), v62 (copy), v72 (ref), v30 (ref), v25 (ref), v36 (ref), v62 (copy), v64 (copy), v12 (ref), l_ReplicatedStorage_0 (ref)
            debug.profilebegin("Mygame43:UpdateOrb");
            v71 = v71 + v73;
            local l_l_TweenService_0_Value_0 = l_TweenService_0:GetValue(v71 / v63, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
            v16.pushPartCFrame(v69, CFrame.new(v20.cubicBezier(l_l_TweenService_0_Value_0, l_Position_0, v67, v70, v62)));
            if l_l_TweenService_0_Value_0 >= 1 and v72 then
                v30:Remove(v72);
                v72 = nil;
                v25.disable(v69);
                task.delay(3, function() --[[ Line: 221 ]]
                    -- upvalues: v30 (ref), v69 (ref)
                    v30:Remove(v69);
                end);
                v36(v62);
                local v75 = if v64 then script.StrikeBrainrot:Clone() else script.Strike:Clone();
                v75.Position = v62;
                v75.Parent = workspace;
                v25.emit(v75);
                task.delay(4, function() --[[ Line: 233 ]]
                    -- upvalues: v75 (copy)
                    v75:Destroy();
                end);
                if v64 then
                    v12:PlaySound(l_ReplicatedStorage_0.Sounds.Events["Los Matteos"].Hit, v62, false);
                else
                    v12:PlaySound(l_ReplicatedStorage_0.Sounds.Events["Phase 4: Mygame43"].OrbHitNothing, v62, false);
                end;
            end;
            debug.profileend();
        end));
    end));
end;
v8.OnStop = function(_) --[[ Line: 248 ]] --[[ Name: OnStop ]]
    -- upvalues: v30 (copy)
    v30:Destroy();
end;
v8.OnLoad = function(_) --[[ Line: 252 ]] --[[ Name: OnLoad ]]
    -- upvalues: l_ContentProvider_0 (copy), l_ReplicatedStorage_0 (copy)
    task.spawn(pcall, function() --[[ Line: 253 ]]
        -- upvalues: l_ContentProvider_0 (ref)
        l_ContentProvider_0:PreloadAsync(script:GetChildren());
    end);
    task.spawn(pcall, function() --[[ Line: 257 ]]
        -- upvalues: l_ContentProvider_0 (ref), l_ReplicatedStorage_0 (ref)
        l_ContentProvider_0:PreloadAsync(l_ReplicatedStorage_0.Models.Events["Phase 4: Mygame43"]);
    end);
end;
return v8;