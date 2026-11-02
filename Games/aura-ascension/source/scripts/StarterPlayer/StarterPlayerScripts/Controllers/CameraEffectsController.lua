-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_RunService_0 = game:GetService("RunService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local l_Knit_0 = require(l_ReplicatedStorage_0:WaitForChild("Packages"):WaitForChild("Knit"));
local l_Signals_0 = require(l_ReplicatedStorage_0:WaitForChild("Signals"));
local v6 = l_Knit_0.CreateController({
    Name = "CameraEffectsController"
});
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v8 = Random.new();
local l_clock_0 = os.clock;
v6.KnitInit = function(v10) --[[ Line: 19 ]] --[[ Name: KnitInit ]]
    v10.Char = nil;
    v10.Humanoid = nil;
    v10.Head = nil;
    v10.RootPart = nil;
    v10.ShakeIntensity = 0;
    v10.ShakeDuration = 0;
    v10.ShakeStartAt = 0;
    v10.ShakeActive = false;
    v10.SmoothedSway = Vector3.new(0, 0, 0, 0);
    v10.FOVTween = nil;
    v10.DefaultFOV = 70;
end;
v6.KnitStart = function(v11) --[[ Line: 36 ]] --[[ Name: KnitStart ]]
    v11:_bindCharacter();
    v11:_bindSignals();
    v11:_startRenderStep();
end;
v6._bindSignals = function(v12) --[[ Line: 42 ]] --[[ Name: _bindSignals ]]
    -- upvalues: l_Signals_0 (copy)
    if l_Signals_0.CameraShake then
        l_Signals_0.CameraShake:Connect(function(v13, v14) --[[ Line: 44 ]]
            -- upvalues: v12 (copy)
            v12:ScreenShake(v13, v14);
        end);
    end;
    if l_Signals_0.RankUpFX then
        l_Signals_0.RankUpFX:Connect(function() --[[ Line: 50 ]]
            -- upvalues: v12 (copy)
            v12:PlayRankUpFOV();
        end);
    end;
end;
v6._setupCharacter = function(v15, v16) --[[ Line: 56 ]] --[[ Name: _setupCharacter ]]
    v15.Char = v16;
    v15.Humanoid = v16:WaitForChild("Humanoid", 10);
    if not v15.Humanoid then
        return;
    else
        v15.Head = v16:FindFirstChild("Head");
        v15.RootPart = v16:FindFirstChild("HumanoidRootPart");
        v15.Humanoid.Died:Connect(function() --[[ Line: 67 ]]
            -- upvalues: v15 (copy)
            v15:ScreenShake(1.5, 0.6);
        end);
        return;
    end;
end;
v6._bindCharacter = function(v17) --[[ Line: 72 ]] --[[ Name: _bindCharacter ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    l_LocalPlayer_0.CharacterAdded:Connect(function(v18) --[[ Line: 73 ]]
        -- upvalues: v17 (copy)
        v17:_setupCharacter(v18);
    end);
    if l_LocalPlayer_0.Character then
        v17:_setupCharacter(l_LocalPlayer_0.Character);
    end;
end;
v6.ScreenShake = function(v19, v20, v21) --[[ Line: 82 ]] --[[ Name: ScreenShake ]]
    -- upvalues: l_clock_0 (copy)
    v19.ShakeIntensity = v20;
    v19.ShakeDuration = v21;
    v19.ShakeStartAt = l_clock_0();
    v19.ShakeActive = true;
end;
v6.PlayRankUpFOV = function(v22) --[[ Line: 89 ]] --[[ Name: PlayRankUpFOV ]]
    -- upvalues: l_TweenService_0 (copy)
    local l_CurrentCamera_0 = workspace.CurrentCamera;
    if not l_CurrentCamera_0 then
        return;
    else
        local l_FieldOfView_0 = l_CurrentCamera_0.FieldOfView;
        v22.DefaultFOV = l_FieldOfView_0;
        if v22.FOVTween then
            v22.FOVTween:Cancel();
            v22.FOVTween = nil;
        end;
        local v25 = l_TweenService_0:Create(l_CurrentCamera_0, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FieldOfView = l_FieldOfView_0 + 8
        });
        local v26 = l_TweenService_0:Create(l_CurrentCamera_0, TweenInfo.new(0.8, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
            FieldOfView = l_FieldOfView_0
        });
        v25:Play();
        v25.Completed:Once(function() --[[ Line: 116 ]]
            -- upvalues: v26 (copy), v22 (copy)
            v26:Play();
            v22.FOVTween = v26;
        end);
        v22.FOVTween = v25;
        return;
    end;
end;
v6._startRenderStep = function(v27) --[[ Line: 124 ]] --[[ Name: _startRenderStep ]]
    -- upvalues: l_RunService_0 (copy)
    l_RunService_0:BindToRenderStep("CameraEffects", Enum.RenderPriority.Camera.Value + 1, function() --[[ Line: 128 ]]
        -- upvalues: v27 (copy)
        v27:_updateCamera();
    end);
end;
v6._updateCamera = function(v28) --[[ Line: 134 ]] --[[ Name: _updateCamera ]]
    -- upvalues: l_clock_0 (copy), v8 (copy)
    if not v28.Humanoid or not v28.Head or not v28.RootPart then
        return;
    else
        local l_CurrentCamera_1 = workspace.CurrentCamera;
        if not l_CurrentCamera_1 then
            return;
        else
            local v30 = v28.RootPart.CFrame:PointToObjectSpace(v28.Head.Position);
            local v31 = Vector3.new(v30.X, v30.Y - 1.6 + 0.35, v30.Z);
            v28.SmoothedSway = v28.SmoothedSway:Lerp(v31, 0.2);
            l_CurrentCamera_1.CFrame = l_CurrentCamera_1.CFrame * CFrame.new(v28.SmoothedSway);
            if v28.ShakeActive then
                local v32 = l_clock_0() - v28.ShakeStartAt;
                if v32 < v28.ShakeDuration then
                    local v33 = 1 - v32 / v28.ShakeDuration;
                    local v34 = Vector3.new(v8:NextNumber() - 0.5, v8:NextNumber() - 0.5, 0) * v28.ShakeIntensity * v33;
                    l_CurrentCamera_1.CFrame = l_CurrentCamera_1.CFrame * CFrame.new(v34);
                    return;
                else
                    v28.ShakeActive = false;
                end;
            end;
            return;
        end;
    end;
end;
return v6;