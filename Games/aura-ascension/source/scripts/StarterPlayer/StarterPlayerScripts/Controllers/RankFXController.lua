-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local l_Knit_0 = require(l_ReplicatedStorage_0:WaitForChild("Packages"):WaitForChild("Knit"));
local v4 = require(l_ReplicatedStorage_0.Frameworks.SmartAudio);
local l_Signals_0 = require(l_ReplicatedStorage_0:WaitForChild("Signals"));
local v6 = l_Knit_0.CreateController({
    Name = "RankFXController"
});
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v8 = Random.new();
v6.KnitInit = function(v9) --[[ Line: 17 ]] --[[ Name: KnitInit ]]
    v9.Character = nil;
    v9.Humanoid = nil;
    v9.Head = nil;
    v9.RootPart = nil;
    v9.RebirthAttachment = nil;
    v9.Haptics = nil;
    v9.HapticLevelUp = nil;
    v9.LevelUpSound = nil;
    v9.Music = nil;
    v9.PitchDownTween = nil;
    v9.PitchUpTween = nil;
end;
v6.KnitStart = function(v10) --[[ Line: 33 ]] --[[ Name: KnitStart ]]
    v10:_grabRefs();
    v10:_bindCharacter();
    v10:_bindSignals();
end;
v6._grabRefs = function(v11) --[[ Line: 39 ]] --[[ Name: _grabRefs ]]
    -- upvalues: l_ReplicatedStorage_0 (copy), l_LocalPlayer_0 (copy), l_TweenService_0 (copy)
    v11.LevelUpSound = l_ReplicatedStorage_0:WaitForChild("Assets"):WaitForChild("Sounds"):FindFirstChild("Level Up");
    v11.Haptics = workspace:FindFirstChild("Haptics");
    if v11.Haptics then
        v11.HapticLevelUp = v11.Haptics:FindFirstChild("LevelUp");
    end;
    local l_PlayerScripts_0 = l_LocalPlayer_0:FindFirstChild("PlayerScripts");
    if l_PlayerScripts_0 then
        local l_l_PlayerScripts_0_FirstChild_0 = l_PlayerScripts_0:FindFirstChild("Anti AFK");
        if l_l_PlayerScripts_0_FirstChild_0 then
            v11.Music = l_l_PlayerScripts_0_FirstChild_0:FindFirstChild("Instrumental");
        end;
    end;
    if v11.Music and v11.Music:IsA("Sound") then
        v11.PitchDownTween = l_TweenService_0:Create(v11.Music, TweenInfo.new(1.2), {
            PlaybackSpeed = 0
        });
        v11.PitchUpTween = l_TweenService_0:Create(v11.Music, TweenInfo.new(1.2), {
            PlaybackSpeed = 0.8
        });
    end;
end;
v6._bindCharacter = function(v14) --[[ Line: 69 ]] --[[ Name: _bindCharacter ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    l_LocalPlayer_0.CharacterAdded:Connect(function(v15) --[[ Line: 70 ]] --[[ Name: setupCharacter ]]
        -- upvalues: v14 (copy)
        v14:_setupCharacter(v15);
    end);
    if l_LocalPlayer_0.Character then
        v14:_setupCharacter(l_LocalPlayer_0.Character);
    end;
end;
v6._setupCharacter = function(v16, v17) --[[ Line: 81 ]] --[[ Name: _setupCharacter ]]
    -- upvalues: l_Signals_0 (copy)
    v16.Character = v17;
    v16.Humanoid = v17:WaitForChild("Humanoid", 10);
    v16.Head = v17:FindFirstChild("Head");
    v16.RootPart = v17:FindFirstChild("HumanoidRootPart");
    v16.RebirthAttachment = nil;
    if v16.Head then
        v16.RebirthAttachment = v16.Head:FindFirstChild("RebirthAttachment");
    end;
    if v16.PitchUpTween then
        v16.PitchUpTween:Play();
    end;
    if v16.Humanoid then
        v16.Humanoid.Died:Connect(function() --[[ Line: 97 ]]
            -- upvalues: l_Signals_0 (ref), v16 (copy)
            if l_Signals_0.CameraShake then
                l_Signals_0.CameraShake:Fire(1.5, 0.6);
            end;
            if v16.PitchDownTween then
                v16.PitchDownTween:Play();
            end;
        end);
    end;
end;
v6._bindSignals = function(v18) --[[ Line: 109 ]] --[[ Name: _bindSignals ]]
    -- upvalues: l_Signals_0 (copy)
    if l_Signals_0.RankUpFX then
        l_Signals_0.RankUpFX:Connect(function(v19, v20) --[[ Line: 111 ]]
            -- upvalues: v18 (copy)
            v18:PlayRankUpFX(v19, v20);
        end);
    end;
end;
v6._refreshAttachment = function(v21) --[[ Line: 117 ]] --[[ Name: _refreshAttachment ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    local l_Character_0 = l_LocalPlayer_0.Character;
    if not l_Character_0 then
        return;
    else
        v21.Character = l_Character_0;
        v21.Head = l_Character_0:FindFirstChild("Head");
        if v21.Head then
            v21.RebirthAttachment = v21.Head:FindFirstChild("RebirthAttachment");
        end;
        return;
    end;
end;
v6._emitRebirthParticles = function(v23) --[[ Line: 131 ]] --[[ Name: _emitRebirthParticles ]]
    if not v23.RebirthAttachment then
        v23:_refreshAttachment();
    end;
    if not v23.RebirthAttachment then
        return;
    else
        for _, v25 in ipairs(v23.RebirthAttachment:GetChildren()) do
            if v25:IsA("ParticleEmitter") then
                v25:Emit(5);
            end;
        end;
        return;
    end;
end;
v6.PlayRankUpFX = function(v26, _, _) --[[ Line: 147 ]] --[[ Name: PlayRankUpFX ]]
    -- upvalues: v4 (copy), v8 (copy)
    if v26.LevelUpSound then
        v4.Play(v26.LevelUpSound, v8);
    end;
    if v26.HapticLevelUp then
        v26.HapticLevelUp:Play();
    end;
    v26:_emitRebirthParticles();
end;
return v6;