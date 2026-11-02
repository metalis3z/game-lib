-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Knit_0 = require(l_ReplicatedStorage_0:WaitForChild("Packages"):WaitForChild("Knit"));
local l_Idles_0 = require(l_ReplicatedStorage_0.Assets.Animations).Idles;
local l_Ranked_0 = require(l_ReplicatedStorage_0:WaitForChild("Ranked"));
local l_PoseConfig_0 = require(l_ReplicatedStorage_0:WaitForChild("Modules"):WaitForChild("PoseConfig"));
local v6 = l_Knit_0.CreateController({
    Name = "IdleAnimationController"
});
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
v6.KnitInit = function(v8) --[[ Line: 16 ]] --[[ Name: KnitInit ]]
    v8.Char = nil;
    v8.Humanoid = nil;
    v8.Animator = nil;
    v8.Head = nil;
    v8.RootPart = nil;
    v8.CurrentIdleTrack = nil;
    v8.CurrentIdleKey = nil;
    v8.LastAuraForIdle = -1;
    v8.LastEquippedPose = nil;
    v8.IdleAnimCache = {};
    v8.PoseAnimCache = {};
    v8.OtherIdleTracks = {};
    v8.OtherIdleKey = {};
    v8.OtherAuraConn = {};
    v8.OtherCharConn = {};
    v8.OtherPoseConn = {};
end;
v6.KnitStart = function(v9) --[[ Line: 38 ]] --[[ Name: KnitStart ]]
    v9:_bindLocalPlayer();
    v9:_bindOtherPlayers();
end;
v6._getAnimator = function(_, v11) --[[ Line: 43 ]] --[[ Name: _getAnimator ]]
    local l_Animator_0 = v11:FindFirstChildOfClass("Animator");
    if not l_Animator_0 then
        l_Animator_0 = Instance.new("Animator");
        l_Animator_0.Parent = v11;
    end;
    return l_Animator_0;
end;
v6._getIdleAnimation = function(v13, v14) --[[ Line: 52 ]] --[[ Name: _getIdleAnimation ]]
    -- upvalues: l_Idles_0 (copy)
    local v15 = l_Idles_0[v14];
    if not v15 then
        return nil;
    else
        local v16 = v13.IdleAnimCache[v14];
        if v16 then
            return v16;
        else
            local l_Animation_0 = Instance.new("Animation");
            l_Animation_0.AnimationId = v15.Id;
            v13.IdleAnimCache[v14] = l_Animation_0;
            return l_Animation_0;
        end;
    end;
end;
v6._getPoseAnimation = function(v18, v19) --[[ Line: 70 ]] --[[ Name: _getPoseAnimation ]]
    if not v19 or v19 == "" then
        return nil;
    else
        local v20 = v18.PoseAnimCache[v19];
        if v20 then
            return v20;
        else
            local l_Animation_1 = Instance.new("Animation");
            l_Animation_1.AnimationId = v19;
            v18.PoseAnimCache[v19] = l_Animation_1;
            return l_Animation_1;
        end;
    end;
end;
v6._getIdleIndexByRank = function(_, v23) --[[ Line: 87 ]] --[[ Name: _getIdleIndexByRank ]]
    -- upvalues: l_Ranked_0 (copy)
    local v24 = v23 / l_Ranked_0.GetCount();
    if v24 < 0.04 then
        return 1;
    elseif v24 < 0.08 then
        return 2;
    elseif v24 < 0.14 then
        return 3;
    elseif v24 < 0.22 then
        return 4;
    elseif v24 < 0.35 then
        return 5;
    elseif v24 < 0.5 then
        return 6;
    elseif v24 < 0.68 then
        return 7;
    elseif v24 < 0.85 then
        return 8;
    else
        return 9;
    end;
end;
v6._getEquippedPoseData = function(_, v26) --[[ Line: 111 ]] --[[ Name: _getEquippedPoseData ]]
    -- upvalues: l_PoseConfig_0 (copy)
    local l_v26_Attribute_0 = v26:GetAttribute("EquippedPose");
    if not l_v26_Attribute_0 or l_v26_Attribute_0 == "" then
        return nil;
    else
        local v28 = l_PoseConfig_0.GetPose(l_v26_Attribute_0);
        if not v28 or not v28.Animation then
            return nil;
        else
            return l_v26_Attribute_0, v28;
        end;
    end;
end;
v6._getDesiredIdleState = function(v29, v30) --[[ Line: 125 ]] --[[ Name: _getDesiredIdleState ]]
    -- upvalues: l_Ranked_0 (copy), l_Idles_0 (copy)
    local v31, v32 = v29:_getEquippedPoseData(v30);
    if v32 and v32.Animation then
        return {
            Key = "Pose:" .. v31, 
            Animation = v29:_getPoseAnimation(v32.Animation.Id), 
            Priority = v32.Animation.Priority or Enum.AnimationPriority.Action3, 
            Speed = v32.Animation.Speed or 1, 
            HipHeight = v32.Animation.HipHeight or 0
        };
    else
        local v33 = v30:GetAttribute("Aura") or 0;
        local v34 = v29:_getIdleIndexByRank((select(1, l_Ranked_0.GetRankByAura(v33))));
        local v35 = l_Idles_0[v34];
        if not v35 then
            return nil;
        else
            return {
                Key = "Rank:" .. tostring(v34), 
                Animation = v29:_getIdleAnimation(v34), 
                Priority = v35.Priority or Enum.AnimationPriority.Idle, 
                Speed = v35.Speed or 1, 
                HipHeight = v35.HipHeight or 0
            };
        end;
    end;
end;
v6._stopLocalIdle = function(v36) --[[ Line: 154 ]] --[[ Name: _stopLocalIdle ]]
    if v36.CurrentIdleTrack then
        v36.CurrentIdleTrack:Stop(0.2);
        v36.CurrentIdleTrack:Destroy();
        v36.CurrentIdleTrack = nil;
    end;
    v36.CurrentIdleKey = nil;
end;
v6._playLocalState = function(v37, v38) --[[ Line: 164 ]] --[[ Name: _playLocalState ]]
    if not v38 or not v37.Animator or not v38.Animation then
        return;
    elseif v37.CurrentIdleKey == v38.Key then
        return;
    else
        v37:_stopLocalIdle();
        local v39 = v37.Animator:LoadAnimation(v38.Animation);
        v39.Looped = true;
        v39.Priority = v38.Priority or Enum.AnimationPriority.Idle;
        v39:Play(0.2, 1, v38.Speed or 1);
        if v37.Humanoid then
            v37.Humanoid.HipHeight = v38.HipHeight or 0;
        end;
        v37.CurrentIdleTrack = v39;
        v37.CurrentIdleKey = v38.Key;
        return;
    end;
end;
v6._updateIdleAnimation = function(v40, v41) --[[ Line: 188 ]] --[[ Name: _updateIdleAnimation ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    local v42 = l_LocalPlayer_0:GetAttribute("Aura") or 0;
    local l_l_LocalPlayer_0_Attribute_0 = l_LocalPlayer_0:GetAttribute("EquippedPose");
    if not v41 and v42 == v40.LastAuraForIdle and l_l_LocalPlayer_0_Attribute_0 == v40.LastEquippedPose then
        return;
    else
        v40.LastAuraForIdle = v42;
        v40.LastEquippedPose = l_l_LocalPlayer_0_Attribute_0;
        v40:_playLocalState((v40:_getDesiredIdleState(l_LocalPlayer_0)));
        return;
    end;
end;
v6._setupCharacter = function(v44, v45) --[[ Line: 203 ]] --[[ Name: _setupCharacter ]]
    v44.Char = v45;
    v44.Humanoid = v45:WaitForChild("Humanoid", 10);
    if not v44.Humanoid then
        return;
    else
        v44.Animator = v44:_getAnimator(v44.Humanoid);
        v44.Head = v45:FindFirstChild("Head");
        v44.RootPart = v45:FindFirstChild("HumanoidRootPart");
        v44:_stopLocalIdle();
        v44.LastAuraForIdle = -1;
        v44.LastEquippedPose = nil;
        task.defer(function() --[[ Line: 219 ]]
            -- upvalues: v44 (copy)
            v44:_updateIdleAnimation(true);
        end);
        return;
    end;
end;
v6._bindLocalPlayer = function(v46) --[[ Line: 224 ]] --[[ Name: _bindLocalPlayer ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    l_LocalPlayer_0.CharacterAdded:Connect(function(v47) --[[ Line: 225 ]]
        -- upvalues: v46 (copy)
        v46:_setupCharacter(v47);
    end);
    if l_LocalPlayer_0.Character then
        v46:_setupCharacter(l_LocalPlayer_0.Character);
    end;
    l_LocalPlayer_0:GetAttributeChangedSignal("Aura"):Connect(function() --[[ Line: 233 ]]
        -- upvalues: v46 (copy)
        v46:_updateIdleAnimation(false);
    end);
    l_LocalPlayer_0:GetAttributeChangedSignal("EquippedPose"):Connect(function() --[[ Line: 237 ]]
        -- upvalues: v46 (copy)
        v46:_updateIdleAnimation(true);
    end);
end;
v6._stopOtherIdle = function(v48, v49) --[[ Line: 242 ]] --[[ Name: _stopOtherIdle ]]
    local v50 = v48.OtherIdleTracks[v49];
    if v50 then
        v50:Stop(0.2);
        v50:Destroy();
        v48.OtherIdleTracks[v49] = nil;
    end;
    v48.OtherIdleKey[v49] = nil;
end;
v6._playOtherIdle = function(v51, v52, v53) --[[ Line: 253 ]] --[[ Name: _playOtherIdle ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    if v52 == l_LocalPlayer_0 then
        return;
    elseif not v53 or not v53.Parent then
        return;
    else
        local l_Humanoid_0 = v53:FindFirstChildOfClass("Humanoid");
        if not l_Humanoid_0 then
            return;
        else
            local l_Animator_1 = l_Humanoid_0:FindFirstChildOfClass("Animator");
            if not l_Animator_1 then
                return;
            else
                local v56 = v51:_getDesiredIdleState(v52);
                if not v56 or not v56.Animation then
                    return;
                elseif v51.OtherIdleKey[v53] == v56.Key then
                    return;
                else
                    v51:_stopOtherIdle(v53);
                    local v57 = l_Animator_1:LoadAnimation(v56.Animation);
                    v57.Looped = true;
                    v57.Priority = v56.Priority or Enum.AnimationPriority.Idle;
                    v57:Play(0.2, 1, v56.Speed or 1);
                    l_Humanoid_0.HipHeight = v56.HipHeight or 0;
                    v51.OtherIdleTracks[v53] = v57;
                    v51.OtherIdleKey[v53] = v56.Key;
                    return;
                end;
            end;
        end;
    end;
end;
v6._hookOtherPlayer = function(v58, v59) --[[ Line: 293 ]] --[[ Name: _hookOtherPlayer ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    if v59 == l_LocalPlayer_0 then
        return;
    else
        local function v64(v60) --[[ Line: 298 ]] --[[ Name: onCharacter ]]
            -- upvalues: v58 (copy), v59 (copy)
            local v61 = v60:WaitForChild("Humanoid", 5);
            if not v61 then
                return;
            else
                v61:WaitForChild("Animator", 5);
                v58:_playOtherIdle(v59, v60);
                v60.AncestryChanged:Once(function(_, v63) --[[ Line: 308 ]]
                    -- upvalues: v58 (ref), v60 (copy)
                    if not v63 then
                        v58:_stopOtherIdle(v60);
                    end;
                end);
                return;
            end;
        end;
        if v59.Character then
            task.defer(v64, v59.Character);
        end;
        if v58.OtherCharConn[v59] then
            v58.OtherCharConn[v59]:Disconnect();
        end;
        v58.OtherCharConn[v59] = v59.CharacterAdded:Connect(v64);
        if v58.OtherAuraConn[v59] then
            v58.OtherAuraConn[v59]:Disconnect();
        end;
        v58.OtherAuraConn[v59] = v59:GetAttributeChangedSignal("Aura"):Connect(function() --[[ Line: 327 ]]
            -- upvalues: v59 (copy), v58 (copy)
            local l_Character_0 = v59.Character;
            if l_Character_0 then
                v58:_playOtherIdle(v59, l_Character_0);
            end;
        end);
        if v58.OtherPoseConn[v59] then
            v58.OtherPoseConn[v59]:Disconnect();
        end;
        v58.OtherPoseConn[v59] = v59:GetAttributeChangedSignal("EquippedPose"):Connect(function() --[[ Line: 337 ]]
            -- upvalues: v59 (copy), v58 (copy)
            local l_Character_1 = v59.Character;
            if l_Character_1 then
                v58:_playOtherIdle(v59, l_Character_1);
            end;
        end);
        return;
    end;
end;
v6._cleanupOtherPlayer = function(v67, v68) --[[ Line: 345 ]] --[[ Name: _cleanupOtherPlayer ]]
    if v67.OtherAuraConn[v68] then
        v67.OtherAuraConn[v68]:Disconnect();
        v67.OtherAuraConn[v68] = nil;
    end;
    if v67.OtherPoseConn[v68] then
        v67.OtherPoseConn[v68]:Disconnect();
        v67.OtherPoseConn[v68] = nil;
    end;
    if v67.OtherCharConn[v68] then
        v67.OtherCharConn[v68]:Disconnect();
        v67.OtherCharConn[v68] = nil;
    end;
    if v68.Character then
        v67:_stopOtherIdle(v68.Character);
    end;
end;
v6._bindOtherPlayers = function(v69) --[[ Line: 366 ]] --[[ Name: _bindOtherPlayers ]]
    -- upvalues: l_Players_0 (copy)
    for _, v71 in ipairs(l_Players_0:GetPlayers()) do
        v69:_hookOtherPlayer(v71);
    end;
    l_Players_0.PlayerAdded:Connect(function(v72) --[[ Line: 371 ]]
        -- upvalues: v69 (copy)
        v69:_hookOtherPlayer(v72);
    end);
    l_Players_0.PlayerRemoving:Connect(function(v73) --[[ Line: 375 ]]
        -- upvalues: v69 (copy)
        v69:_cleanupOtherPlayer(v73);
    end);
end;
return v6;