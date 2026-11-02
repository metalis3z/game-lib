-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--!native
local _ = require(game.ReplicatedStorage.GlobalTypes);
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("UserInputService");
local l_RunService_0 = game:GetService("RunService");
local l_TweenService_0 = game:GetService("TweenService");
local l_Players_0 = game:GetService("Players");
local l_ContentProvider_0 = game:GetService("ContentProvider");
local l_ContextActionService_0 = game:GetService("ContextActionService");
local l_CollectionService_0 = game:GetService("CollectionService");
local v9 = require(script.Battery);
local _ = require(l_ReplicatedStorage_0.Modules.Misc.Zone);
local v11 = require(l_ReplicatedStorage_0.Modules.Misc.Maid);
local v12 = require(l_ReplicatedStorage_0.Modules.Util);
local _ = require(script.Utils);
local v14 = require(l_ReplicatedStorage_0.Modules.Statuses);
local v15 = require(l_ReplicatedStorage_0.Modules.Network);
local v16 = require(l_ReplicatedStorage_0.Modules.Sounds);
local _ = require(l_ReplicatedStorage_0.Modules.AchievementUtil);
local v18 = require(l_ReplicatedStorage_0.Modules.Actors);
local v19 = require(l_ReplicatedStorage_0.Systems.Character.Game.Sprinting);
local v20 = require(l_ReplicatedStorage_0.Modules.Hitboxes);
local v21 = require(script.Spray);
local v22 = require(script.SprayVisual);
local l_Gravity_0 = workspace.Gravity;
local v24 = nil;
local v25 = nil;
local _ = TweenInfo.new(5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
local _ = TweenInfo.new(2.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
local v28 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local l_MouseButton1_0 = Enum.UserInputType.MouseButton1;
local _ = Enum.UserInputType.Touch;
local l_ButtonR2_0 = Enum.KeyCode.ButtonR2;
local l_ButtonX_0 = Enum.KeyCode.ButtonX;
local l_Space_0 = Enum.KeyCode.Space;
local _ = {
    InAir = "You have to be on the ground to spray.", 
    InvalidNormal = "This is not a wall.", 
    Nothing = "There's no surface to spray on here.", 
    Far = "You are too far away from your other sprays!", 
    Dead = "What"
};
local v35 = {
    PC = "Press <b>[Space]</b>", 
    Mobile = "Tap <b>[Sprint]</b>", 
    Console = "Press <b>[X]</b>"
};
local v36 = {
    PC = "Hold <b>[Left Click]</b> to Spray<br/>Hold <b>[Space]</b> to Wipe", 
    Console = "Hold <b>[Right Trigger]</b> to Spray<br/>Hold <b>[X]</b> to Wipe"
};
local v37 = l_RunService_0:IsStudio();
local l_clock_0 = os.clock;
local l_insert_0 = table.insert;
local l_remove_0 = table.remove;
local l_find_0 = table.find;
local _ = task.wait;
local l_delay_0 = task.delay;
local l_clamp_0 = math.clamp;
local l_lerp_0 = math.lerp;
local l_abs_0 = math.abs;
local l_random_0 = math.random;
local _ = math.rad;
local function _(v49, v50, v51, v52, v53) --[[ Line: 79 ]] --[[ Name: __reward ]]
    -- upvalues: v18 (copy)
    v18:IncrementActorStats(v49.Player, {
        Action = v52, 
        Money = v50, 
        EXP = v51, 
        RewardType = v53 and "Survivalist" or nil
    });
end;
local function _(v55) --[[ Line: 88 ]] --[[ Name: __displayWarn ]]
    -- upvalues: v37 (copy)
    if v37 then
        warn((("[Veeronica]: %*"):format(v55)));
    end;
end;
local function _(v57) --[[ Line: 94 ]] --[[ Name: __flattenVector ]]
    return Vector3.new(v57.X, 0, v57.Z).Unit;
end;
local function v63(v59, v60) --[[ Line: 98 ]] --[[ Name: __applyStatusesFromDict ]]
    -- upvalues: v14 (copy)
    for v61, v62 in pairs(v60) do
        v14:ApplyStatus(v59, v61, v62);
    end;
end;
local function _(v64) --[[ Line: 104 ]] --[[ Name: __isVertical ]]
    -- upvalues: l_abs_0 (copy)
    return l_abs_0((v64:Dot((Vector3.new(0, 1, 0, 0))))) < 0.2;
end;
local function _(v66, v67) --[[ Line: 108 ]] --[[ Name: __flRandom ]]
    return v66 + Random.new():NextNumber() * (v67 - v66);
end;
local function v73(v69) --[[ Line: 112 ]] --[[ Name: __getCharacterMass ]]
    local v70 = 0;
    for _, v72 in ipairs(v69:GetChildren()) do
        if v72:IsA("BasePart") and not v72.Massless then
            v70 = v70 + v72.Mass;
        end;
    end;
    return v70;
end;
local function v79(v74, v75, ...) --[[ Line: 129 ]] --[[ Name: __pcallMethod ]]
    -- upvalues: v37 (copy)
    assert(v74, "bad moduleInfo, must be a table");
    local l_status_0, l_result_0 = pcall(function(...) --[[ Line: 133 ]]
        -- upvalues: v74 (copy), v75 (copy)
        if v74[v75] then
            return v74[v75](v74, ...);
        else
            return;
        end;
    end, ...);
    if not l_status_0 then
        local v78 = ("Failed to call :%*() due to: %* \n%*"):format(v75, l_result_0, (debug.traceback("Stack:")));
        if v37 then
            warn((("[Veeronica]: %*"):format(v78)));
        end;
    end;
    return l_status_0, l_result_0;
end;
local function v84(v80, v81, v82) --[[ Line: 143 ]] --[[ Name: __playSound ]]
    -- upvalues: v12 (copy), v16 (copy)
    local v83 = v12:CopyTable(v82 or {
        PlaybackSpeed = 0.975 + Random.new():NextNumber() * 0.04999999999999993
    });
    v83.Parent = v80.Rig.PrimaryPart;
    return v16:Play(v80.Config.Sounds[v81], v83);
end;
local function v91(v85, v86, v87) --[[ Line: 157 ]] --[[ Name: __tweenTVTimeValue ]]
    -- upvalues: l_RunService_0 (copy), l_clamp_0 (copy), l_TweenService_0 (copy), l_lerp_0 (copy)
    assert(v85, "bad survivorInfo, must be T.ActorInfo");
    assert(v86, "bad newValue, must be number");
    if v85.ConnectionDictionary.__tweenValueConnection then
        v85.ConnectionDictionary.__tweenValueConnection:Disconnect();
        v85.ConnectionDictionary.__tweenValueConnection = nil;
    end;
    v85.Config.TVScreenSpeed = v86;
    local v88 = 0;
    v85.ConnectionDictionary.__tweenValueConnection = l_RunService_0.RenderStepped:Connect(function(v89) --[[ Line: 173 ]]
        -- upvalues: v88 (ref), v87 (copy), v85 (copy), l_clamp_0 (ref), l_TweenService_0 (ref), l_lerp_0 (ref)
        v88 = l_clamp_0((v88 + v89) / (v87 or v85.Config.TVScreenInterpolationTime), 0, 1);
        local l_l_TweenService_0_Value_0 = l_TweenService_0:GetValue(v88, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
        v85.Meta.__TVScreenCurrentSpeed = l_lerp_0(v85.Meta.__TVScreenCurrentSpeed, v85.Config.TVScreenSpeed, l_l_TweenService_0_Value_0);
        if v88 >= 1 and v85.ConnectionDictionary.__tweenValueConnection then
            v85.ConnectionDictionary.__tweenValueConnection:Disconnect();
            v85.ConnectionDictionary.__tweenValueConnection = nil;
        end;
    end);
end;
local function v118(v92, v93) --[[ Line: 187 ]] --[[ Name: sv_onSprayTick ]]
    -- upvalues: v21 (copy), v12 (copy), l_abs_0 (copy)
    local l_Rig_0 = v92.Rig;
    local v95 = l_Rig_0 and l_Rig_0:FindFirstChildOfClass("Humanoid");
    if l_Rig_0 then
        local _ = l_Rig_0.PrimaryPart;
    end;
    local l_v92_Pivot_0 = v92:GetPivot();
    local l_VandalismDistanceCheck_0 = v92.Config.VandalismDistanceCheck;
    local v99 = OverlapParams.new();
    v99.FilterType = Enum.RaycastFilterType.Include;
    v99.BruteForceAllSlow = true;
    for _, v101 in ipairs(v92.SprayObjects) do
        if not v101.Dead then
            v99:AddToFilter(v101.Model.PrimaryPart);
        end;
    end;
    local v102 = RaycastParams.new();
    v102.FilterType = Enum.RaycastFilterType.Exclude;
    v102.FilterDescendantsInstances = {
        workspace.Players
    };
    v102.RespectCanCollide = true;
    local l_workspace_PartBoundsInBox_0 = workspace:GetPartBoundsInBox(v92:GetPivot() * CFrame.new(0, 0, -(l_VandalismDistanceCheck_0 / 2) - 1), Vector3.new(4, 4, l_VandalismDistanceCheck_0 + 2), v99);
    if l_workspace_PartBoundsInBox_0 and #l_workspace_PartBoundsInBox_0 > 0 then
        table.sort(l_workspace_PartBoundsInBox_0, function(v104, v105) --[[ Line: 213 ]]
            -- upvalues: l_v92_Pivot_0 (copy)
            return (v104.Position - l_v92_Pivot_0.Position).Magnitude < (v105.Position - l_v92_Pivot_0.Position).Magnitude;
        end);
        for _, v107 in ipairs(l_workspace_PartBoundsInBox_0) do
            local v108 = v21.getObject(v107.Parent);
            if v108 then
                local v109 = workspace:Raycast(l_v92_Pivot_0.Position, v107.Position - l_v92_Pivot_0.Position, v102);
                if not v109 or not v109.Instance then
                    v108:ChangeProgression(v93 * (100 / v92.Config.VandalismSprayTime));
                    return v108;
                end;
            end;
        end;
    end;
    if #v92.SprayObjects >= 3 then
        return "Max";
    elseif os.clock() - (v92.Meta.LastSprayCreation or 0) < 1 then
        return "Soon";
    elseif v95.FloorMaterial == Enum.Material.Air then
        return "InAir";
    else
        for _, v111 in v92.SprayObjects do
            if (l_v92_Pivot_0.Position - v111.Model.PrimaryPart.Position).Magnitude > v92.Config.VandalismSprayDistance then
                return "Far";
            end;
        end;
        local v112 = workspace:Raycast(l_v92_Pivot_0.Position, l_v92_Pivot_0.LookVector * l_VandalismDistanceCheck_0, v102);
        if not v112 then
            return "Nothing";
        else
            local v113 = v12:SnapToAxis(v112.Normal);
            if l_abs_0(v113.Y) > 0.4 then
                return "InvalidNormal";
            else
                local v114 = v112.Position + v112.Normal * v92.Config.VandalismSprayOffset;
                local v115 = Vector3.new(0, 1, 0, 0);
                if l_abs_0((v113:Dot(v115))) > 0.99 then
                    v115 = Vector3.new(0, 0, 1, 0);
                end;
                v92.Meta.LastSprayCreation = os.clock();
                local v116 = CFrame.lookAt(v114, v114 - v112.Normal, v115);
                local v117 = v21.new(v92, v116, v112.Instance);
                v92:IncrementCharges("Vandalism", -1);
                v117:ChangeProgression(12);
                return v117;
            end;
        end;
    end;
end;
local function v129(v119, v120) --[[ Line: 281 ]] --[[ Name: sv_onWipeTick ]]
    -- upvalues: v21 (copy)
    local l_Rig_1 = v119.Rig;
    if l_Rig_1 then
        local _ = l_Rig_1:FindFirstChildOfClass("Humanoid");
    end;
    local l_VandalismDistanceCheck_1 = v119.Config.VandalismDistanceCheck;
    local v124 = OverlapParams.new();
    v124.FilterType = Enum.RaycastFilterType.Include;
    v124.MaxParts = 1;
    v124.BruteForceAllSlow = true;
    for _, v126 in ipairs(v119.SprayObjects) do
        if not v126.Dead then
            v124:AddToFilter(v126.Model.PrimaryPart);
        end;
    end;
    local l_workspace_PartBoundsInBox_1 = workspace:GetPartBoundsInBox(v119:GetPivot() * CFrame.new(0, 0, -(l_VandalismDistanceCheck_1 / 2) - 1), Vector3.new(5, 5, l_VandalismDistanceCheck_1 + 2), v124);
    if l_workspace_PartBoundsInBox_1 and #l_workspace_PartBoundsInBox_1 > 0 then
        local v128 = v21.getObject(l_workspace_PartBoundsInBox_1[1].Parent);
        if v128 then
            v128:ChangeProgression(v120 * -200);
            return v128;
        end;
    end;
end;
local function v140(v130, _) --[[ Line: 309 ]] --[[ Name: sv_getClosestSprayInRange ]]
    local _ = v130:GetPivot();
    local v133 = OverlapParams.new();
    v133.FilterType = Enum.RaycastFilterType.Include;
    v133.FilterDescendantsInstances = {
        (v130.Rig:FindFirstChild("QueryHitbox"))
    };
    for _, v135 in pairs(v130.SprayObjects) do
        if not v135.Dead and v135.Complete then
            local v136 = v135 and v135.Model and v135.Model.PrimaryPart.CFrame;
            if v136 then
                local l_VandalismRange_0 = v130.Config.VandalismRange;
                local l_VandalismWidth_0 = v130.Config.VandalismWidth;
                local l_workspace_PartBoundsInBox_2 = workspace:GetPartBoundsInBox(v136 * CFrame.new(0, 0, l_VandalismRange_0 / 2 + 1), vector.create(l_VandalismWidth_0, l_VandalismWidth_0, l_VandalismRange_0), v133);
                if l_workspace_PartBoundsInBox_2 and #l_workspace_PartBoundsInBox_2 > 0 then
                    return v135;
                end;
            end;
        end;
    end;
    return nil;
end;
local v141 = {};
v141.Abilities = {
    Vandalism = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://99162825735363", 
        KeybindType = "AltAbility1", 
        Callback = function(v142, v143) --[[ Line: 344 ]] --[[ Name: Callback ]]
            -- upvalues: l_RunService_0 (copy), v84 (copy), v79 (copy), v118 (copy), v129 (copy), v15 (copy), l_delay_0 (copy), l_ContextActionService_0 (copy), l_MouseButton1_0 (copy), l_ButtonR2_0 (copy), l_Space_0 (copy), l_ButtonX_0 (copy), l_Players_0 (copy), v12 (copy), v36 (copy)
            if l_RunService_0:IsServer() then
                local v144 = not v142.State.SprayState or false;
                if v144 then
                    v142.State.SprayState = "Idle";
                    v84(v142, "VandalismEquip");
                    v79(v142.Behavior, "ToggleSpraycan", v142, true);
                    v142.ConnectionDictionary.VandalListener = l_RunService_0.PreSimulation:Connect(function(v145) --[[ Line: 354 ]]
                        -- upvalues: v142 (copy), v118 (ref), v129 (ref)
                        if not v142.State.SprayState then
                            return;
                        elseif v142.State.SprayState == "Spraying" then
                            v118(v142, v145);
                            return;
                        else
                            if v142.State.SprayState == "Wiping" then
                                v129(v142, v145);
                            end;
                            return;
                        end;
                    end);
                    v15:SetConnection(("%*UpdateSprayInput"):format(v142.Player.Name), "REMOTE_EVENT", function(v146, v147) --[[ Line: 364 ]]
                        -- upvalues: v142 (copy), v15 (ref)
                        if v146 ~= v142.Player then
                            return;
                        elseif not ({
                            Idle = true, 
                            Spraying = true, 
                            Wiping = true
                        })[v147] or not v142.State.SprayState then
                            return;
                        else
                            v142.State.SprayState = v147;
                            for _, v149 in ipairs(game.Players:GetPlayers()) do
                                if v149 ~= v142.Player then
                                    v15:FireClientConnection(v149, ("%*UpdateSprayState"):format(v142.Player.Name), "REMOTE_EVENT", v147);
                                end;
                            end;
                            return;
                        end;
                    end);
                    return v144;
                else
                    v142.Behavior:UnequipSpray(v142);
                    return v144;
                end;
            elseif v143 == "Cancelled" then
                return;
            else
                local v150 = false;
                l_delay_0(v142.Config.VandalismSprayWait, function() --[[ Line: 396 ]]
                    -- upvalues: v150 (ref)
                    v150 = true;
                end);
                local l_SprayClickListener_0 = v142.ConnectionDictionary.SprayClickListener;
                if l_SprayClickListener_0 then
                    l_SprayClickListener_0:Disconnect();
                end;
                if v143 then
                    v142.Animations.CanIdle:Play();
                    v142.Animations.CanTakeout:Play();
                    local function _(v152) --[[ Line: 411 ]] --[[ Name: setState ]]
                        -- upvalues: v142 (copy), v15 (ref)
                        if v142.State.SprayState == v152 then
                            return;
                        else
                            v142.State.SprayState = v152;
                            v142.Behavior:OnSprayStateChanged(v142, v152);
                            v142.State.LastSprayState = v152;
                            v15:FireServerConnection(("%*UpdateSprayInput"):format(v142.Player.Name), "REMOTE_EVENT", v152);
                            return;
                        end;
                    end;
                    v142.State.SprayState = "Idle";
                    v142.State.ActionThread = nil;
                    local function _() --[[ Line: 427 ]] --[[ Name: stopSpraying ]]
                        -- upvalues: v142 (copy), v15 (ref)
                        if v142.State.SprayState ~= "Spraying" then
                            return;
                        elseif v142.State.SprayState == "Idle" then
                            return;
                        else
                            v142.State.SprayState = "Idle";
                            v142.Behavior:OnSprayStateChanged(v142, "Idle");
                            v142.State.LastSprayState = "Idle";
                            v15:FireServerConnection(("%*UpdateSprayInput"):format(v142.Player.Name), "REMOTE_EVENT", "Idle");
                            return;
                        end;
                    end;
                    local function _() --[[ Line: 432 ]] --[[ Name: stopWiping ]]
                        -- upvalues: v142 (copy), v15 (ref)
                        if v142.State.SprayState ~= "Wiping" then
                            return;
                        elseif v142.State.SprayState == "Idle" then
                            return;
                        else
                            v142.State.SprayState = "Idle";
                            v142.Behavior:OnSprayStateChanged(v142, "Idle");
                            v142.State.LastSprayState = "Idle";
                            v15:FireServerConnection(("%*UpdateSprayInput"):format(v142.Player.Name), "REMOTE_EVENT", "Idle");
                            return;
                        end;
                    end;
                    local function _() --[[ Line: 437 ]] --[[ Name: startSpraying ]]
                        -- upvalues: v142 (copy), v15 (ref)
                        if v142.State.SprayState == "Spraying" then
                            return;
                        else
                            if v142.State.SprayState == "Wiping" and v142.State.SprayState ~= "Idle" then
                                v142.State.SprayState = "Idle";
                                v142.Behavior:OnSprayStateChanged(v142, "Idle");
                                v142.State.LastSprayState = "Idle";
                                v15:FireServerConnection(("%*UpdateSprayInput"):format(v142.Player.Name), "REMOTE_EVENT", "Idle");
                            end;
                            if v142.State.SprayState == "Spraying" then
                                return;
                            else
                                v142.State.SprayState = "Spraying";
                                v142.Behavior:OnSprayStateChanged(v142, "Spraying");
                                v142.State.LastSprayState = "Spraying";
                                v15:FireServerConnection(("%*UpdateSprayInput"):format(v142.Player.Name), "REMOTE_EVENT", "Spraying");
                                return;
                            end;
                        end;
                    end;
                    local function _() --[[ Line: 443 ]] --[[ Name: startWiping ]]
                        -- upvalues: v142 (copy), v15 (ref)
                        if v142.State.SprayState == "Wiping" then
                            return;
                        else
                            if v142.State.SprayState == "Spraying" and v142.State.SprayState ~= "Idle" then
                                v142.State.SprayState = "Idle";
                                v142.Behavior:OnSprayStateChanged(v142, "Idle");
                                v142.State.LastSprayState = "Idle";
                                v15:FireServerConnection(("%*UpdateSprayInput"):format(v142.Player.Name), "REMOTE_EVENT", "Idle");
                            end;
                            if v142.State.SprayState == "Wiping" then
                                return;
                            else
                                v142.State.SprayState = "Wiping";
                                v142.Behavior:OnSprayStateChanged(v142, "Wiping");
                                v142.State.LastSprayState = "Wiping";
                                v15:FireServerConnection(("%*UpdateSprayInput"):format(v142.Player.Name), "REMOTE_EVENT", "Wiping");
                                return;
                            end;
                        end;
                    end;
                    local function v160(v158, v159) --[[ Line: 449 ]] --[[ Name: onInput ]]
                        -- upvalues: v142 (copy), v150 (ref), v15 (ref)
                        if not v142.State.SprayState then
                            return;
                        elseif not v150 then
                            return;
                        else
                            if v159 == Enum.UserInputState.Begin then
                                if v158 == "SprayInput" then
                                    if v142.State.SprayState == "Wiping" and v142.State.SprayState ~= "Idle" then
                                        v142.State.SprayState = "Idle";
                                        v142.Behavior:OnSprayStateChanged(v142, "Idle");
                                        v142.State.LastSprayState = "Idle";
                                        v15:FireServerConnection(("%*UpdateSprayInput"):format(v142.Player.Name), "REMOTE_EVENT", "Idle");
                                    end;
                                    if v142.State.SprayState == "Spraying" then
                                        return;
                                    else
                                        if v142.State.SprayState == "Wiping" and v142.State.SprayState ~= "Idle" then
                                            v142.State.SprayState = "Idle";
                                            v142.Behavior:OnSprayStateChanged(v142, "Idle");
                                            v142.State.LastSprayState = "Idle";
                                            v15:FireServerConnection(("%*UpdateSprayInput"):format(v142.Player.Name), "REMOTE_EVENT", "Idle");
                                        end;
                                        if v142.State.SprayState == "Spraying" then
                                            return;
                                        else
                                            v142.State.SprayState = "Spraying";
                                            v142.Behavior:OnSprayStateChanged(v142, "Spraying");
                                            v142.State.LastSprayState = "Spraying";
                                            v15:FireServerConnection(("%*UpdateSprayInput"):format(v142.Player.Name), "REMOTE_EVENT", "Spraying");
                                            return;
                                        end;
                                    end;
                                elseif v158 == "WipeInput" then
                                    if v142.State.SprayState == "Spraying" and v142.State.SprayState ~= "Idle" then
                                        v142.State.SprayState = "Idle";
                                        v142.Behavior:OnSprayStateChanged(v142, "Idle");
                                        v142.State.LastSprayState = "Idle";
                                        v15:FireServerConnection(("%*UpdateSprayInput"):format(v142.Player.Name), "REMOTE_EVENT", "Idle");
                                    end;
                                    if v142.State.SprayState == "Wiping" then
                                        return;
                                    else
                                        if v142.State.SprayState == "Spraying" and v142.State.SprayState ~= "Idle" then
                                            v142.State.SprayState = "Idle";
                                            v142.Behavior:OnSprayStateChanged(v142, "Idle");
                                            v142.State.LastSprayState = "Idle";
                                            v15:FireServerConnection(("%*UpdateSprayInput"):format(v142.Player.Name), "REMOTE_EVENT", "Idle");
                                        end;
                                        if v142.State.SprayState == "Wiping" then
                                            return;
                                        else
                                            v142.State.SprayState = "Wiping";
                                            v142.Behavior:OnSprayStateChanged(v142, "Wiping");
                                            v142.State.LastSprayState = "Wiping";
                                            v15:FireServerConnection(("%*UpdateSprayInput"):format(v142.Player.Name), "REMOTE_EVENT", "Wiping");
                                            return;
                                        end;
                                    end;
                                end;
                            elseif v159 == Enum.UserInputState.End then
                                if v158 == "SprayInput" then
                                    if v142.State.SprayState ~= "Spraying" then
                                        return;
                                    elseif v142.State.SprayState == "Idle" then
                                        return;
                                    else
                                        v142.State.SprayState = "Idle";
                                        v142.Behavior:OnSprayStateChanged(v142, "Idle");
                                        v142.State.LastSprayState = "Idle";
                                        v15:FireServerConnection(("%*UpdateSprayInput"):format(v142.Player.Name), "REMOTE_EVENT", "Idle");
                                        return;
                                    end;
                                elseif v158 == "WipeInput" then
                                    if v142.State.SprayState ~= "Wiping" then
                                        return;
                                    elseif v142.State.SprayState == "Idle" then
                                        return;
                                    else
                                        v142.State.SprayState = "Idle";
                                        v142.Behavior:OnSprayStateChanged(v142, "Idle");
                                        v142.State.LastSprayState = "Idle";
                                        v15:FireServerConnection(("%*UpdateSprayInput"):format(v142.Player.Name), "REMOTE_EVENT", "Idle");
                                    end;
                                end;
                            end;
                            return;
                        end;
                    end;
                    l_ContextActionService_0:BindActionAtPriority("SprayInput", v160, false, 900, l_MouseButton1_0, l_ButtonR2_0);
                    l_ContextActionService_0:BindActionAtPriority("WipeInput", v160, false, 900, l_Space_0, l_ButtonX_0);
                    local v161 = v142.Player:GetAttribute("Device") or "PC";
                    if v161 == "Mobile" then
                        local _ = v142.Player.PlayerGui.TemporaryUI;
                        local v163 = script.SprayButton:Clone();
                        local v164 = script.WipeButton:Clone();
                        for v165, v166 in ipairs({
                            v163, 
                            v164
                        }) do
                            v166.MouseButton1Down:Connect(function() --[[ Line: 480 ]]
                                -- upvalues: v160 (copy), v165 (copy)
                                v160(v165 == 1 and "SprayInput" or "WipeInput", Enum.UserInputState.Begin);
                            end);
                            v166.MouseButton1Up:Connect(function() --[[ Line: 483 ]]
                                -- upvalues: v160 (copy), v165 (copy)
                                v160(v165 == 1 and "SprayInput" or "WipeInput", Enum.UserInputState.End);
                            end);
                            v166.Parent = l_Players_0.LocalPlayer.PlayerGui.TemporaryUI;
                        end;
                        v142.SprayUI = {
                            v163, 
                            v164
                        };
                    elseif not v142.Meta.SprayTutorialFlag then
                        v142.Meta.SprayTutorialFlag = true;
                        v12:CreateWarning("Sk8SprayTutorial", v36[v161] or "what <b>happened</b> to you", script.Tip);
                    end;
                    for _, v168 in v142.SprayVisuals do
                        v168:ToggleBeam(true);
                    end;
                else
                    v142.Behavior:UnequipSpray(v142);
                end;
                return;
            end;
        end
    }, 
    Sk8 = {
        LayoutOrder = 2, 
        Icon = "rbxassetid://113273966501923", 
        AltIcon = "rbxassetid://113273966501923", 
        AltName = "Trick", 
        KeybindType = "AltAbility2", 
        Callback = function(v169, v170) --[[ Line: 512 ]] --[[ Name: Callback ]]
            -- upvalues: l_RunService_0 (copy), v12 (copy), v84 (copy), v79 (copy), v37 (copy), l_ReplicatedStorage_0 (copy), v73 (copy), l_Gravity_0 (copy), l_TweenService_0 (copy), v19 (copy), l_ContextActionService_0 (copy), v141 (copy), v15 (copy), v35 (copy), l_Space_0 (copy), l_ButtonX_0 (copy), l_abs_0 (copy), v14 (copy), l_random_0 (copy)
            if l_RunService_0:IsServer() then
                if v169.State.isSkating or not v169.State.InZone and not v169.State.ClosestSpray and not workspace:GetAttribute("CooldownsDisabled") then
                    return "BAD";
                else
                    v169.Behavior:UnequipSpray(v169);
                    local v171 = false;
                    if v169.State.ClosestSpray and not v169.State.InZone then
                        v171 = true;
                    end;
                    v169.AbilitiesDisabled = true;
					v169.State.isSkating = true;
					v169.Rig:SetAttribute("Skating", true)
                    v12:GiveStackableAttribute(v169.Rig, "FootstepsMuted", "Sk8");
                    v84(v169, "Sk8Start");
                    v169.Cache.Sk8LoopSound = v84(v169, "Sk8Loop", {
                        Looped = true, 
                        Volume = 0.4
                    });
                    v79(v169.Behavior, "ToggleSkateboard", v169, true);
                    if v171 then
                        return "SPRAY";
                    else
                        return "ZONE";
                    end;
                end;
            else
                if l_RunService_0:IsClient() then
                    if v170 == "BAD" then
                        v12:CreateWarning("Sk8SprayFail", "You must be in a Graffiti zone to skate!");
                        return;
                    elseif v169.State.isSkating then
                        if v37 then
                            warn("[Veeronica]: Attempted to toggle skating while already skating");
                        end;
                        return;
                    elseif not v12:IsAlive(v169.Rig) then
                        if v37 then
                            warn("[Veeronica]: she's dead bruh");
                        end;
                        return;
                    else
                        local v172 = require(game.Players.LocalPlayer.PlayerScripts.PlayerModule.ControlModule);
                        local v173 = require(l_ReplicatedStorage_0.Systems.Player.Game.SmoothShiftLock);
                        local l_Player_0 = v169.Player;
                        local v175 = v73(v169.Rig);
                        local l_Sk8TrickCooldown_0 = v169.Config.Sk8TrickCooldown;
                        local v177 = os.clock();
                        local v178 = 0;
                        local v179 = 0;
                        local v180 = 0;
                        local v181 = 0;
                        local v182 = 0;
                        local v183 = 0;
                        local v184 = false;
                        local v185 = false;
                        local l_CurrentChannel_0 = v169.Meta.CurrentChannel;
                        local v187 = v170 == "SPRAY";
                        local _ = {};
                        local v189 = false;
                        local v190 = l_Player_0:GetAttribute("Device") or "PC";
                        local l_Rig_2 = v169.Rig;
                        local l_Humanoid_1 = l_Rig_2.Humanoid;
                        local l_PrimaryPart_1 = l_Rig_2.PrimaryPart;
                        local l_LookVector_0 = workspace.CurrentCamera.CFrame.LookVector;
                        local l_Unit_0 = Vector3.new(l_LookVector_0.X, 0, l_LookVector_0.Z).Unit;
                        local v196 = Vector3.new(0, 0, 0, 0);
                        local v197 = Instance.new("Attachment", l_PrimaryPart_1);
                        local v198 = Instance.new("Attachment", workspace.Terrain);
                        v198.CFrame = l_PrimaryPart_1.CFrame;
                        local v199 = script.SkatePointer:Clone();
                        v199.Parent = l_PrimaryPart_1;
                        v199.Attachment0 = v197;
                        v199.Attachment1 = v198;
                        local v200 = l_Gravity_0 * v175;
                        local v201 = vector.create(0, (1 - v169.Config.Sk8TrickGravity) * v200, 0);
                        local v202 = Instance.new("BodyForce", l_PrimaryPart_1);
                        v202.Force = Vector3.new(0, 0, 0, 0);
                        local v203 = Instance.new("Highlight", script);
                        v203.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
                        for v204, v205 in pairs(v169.Config.Sk8TrickHighlightData.TrickReady) do
                            v203[v204] = v205;
                        end;
                        v169.Instances.Sk8Highlight = v203;
                        v169.Instances.Sk8Attachment = v198;
                        local v206 = v84(v169, "Sk8LoopMusic", {
                            Looped = true, 
                            Volume = 0.35
                        });
                        local v207 = RaycastParams.new();
                        v207.CollisionGroup = "Survivors";
                        v207.RespectCanCollide = true;
                        v207.FilterDescendantsInstances = {
                            workspace.Players.Survivors
                        };
                        v207.FilterType = Enum.RaycastFilterType.Exclude;
                        local v208 = RaycastParams.new();
                        v208.CollisionGroup = "Survivors";
                        v208.RespectCanCollide = true;
                        v208.FilterDescendantsInstances = {
                            workspace.Players
                        };
                        v208.FilterType = Enum.RaycastFilterType.Exclude;
                        local v209 = RaycastParams.new();
                        v209.CollisionGroup = "Survivors";
                        v209.RespectCanCollide = true;
                        v209.FilterDescendantsInstances = {
                            workspace.Players.Killers
                        };
                        v209.FilterType = Enum.RaycastFilterType.Include;
                        local function _(v210) --[[ Line: 631 ]] --[[ Name: fakeCooldown ]]
                            -- upvalues: v169 (copy)
                            v169.Cooldowns.Sk8 = {
                                Duration = v210, 
                                TimePast = 0
                            };
                        end;
                        local function v216(v212) --[[ Line: 638 ]] --[[ Name: stopSkating ]]
                            -- upvalues: v206 (copy), l_TweenService_0 (ref), v12 (ref), l_Rig_2 (copy), l_RunService_0 (ref), v169 (copy), v19 (ref), v203 (copy), v202 (copy), v199 (copy), v198 (copy), v197 (copy), l_ContextActionService_0 (ref), v141 (ref), l_Humanoid_1 (copy), v79 (ref), v15 (ref)
                            if v206 then
                                l_TweenService_0:Create(v206, TweenInfo.new(0.7), {
                                    PlaybackSpeed = 0
                                }):Play();
                                game.Debris:AddItem(v206, 0.7);
                            end;
                            v12:RemoveStackableAttribute(l_Rig_2, "DisableShiftLockMovement", "SkateboardV");
                            l_RunService_0:UnbindFromRenderStep("Sk8");
                            v169.AnimationType = nil;
                            v19.IsSprinting = false;
                            v19.__sprintedEvent:Fire(false);
                            v19.BindsEnabled = true;
                            v169.State.isSkating = false;
                            v19.StaminaGain = v169.State.OGStaminaGain;
                            v19.StaminaLoss = v169.State.OGStaminaLoss;
                            l_Rig_2:SetAttribute("NoFallSlow", nil);
                            v169.State.SkatingSpeed:Destroy();
                            v169.State.TrickSpeed:Destroy();
                            v203:Destroy();
                            v202:Destroy();
                            v199:Destroy();
                            v198:Destroy();
                            v197:Destroy();
                            l_ContextActionService_0:UnbindAction("TrickInput");
                            for _, v214 in ipairs({
                                "TrickStartInput", 
                                "TrickEndInput"
                            }) do
                                if v169.ConnectionDictionary[v214] then
                                    v169.ConnectionDictionary[v214]:Disconnect();
                                    v169.ConnectionDictionary[v214] = nil;
                                end;
                            end;
                            v169.Animations.Sk8Skating:Stop(0.25);
                            local l_Sk8_0 = v169.Behavior.Abilities.Sk8;
                            l_Sk8_0.Name = v141.Abilities.Sk8.Name;
                            l_Sk8_0.Icon = v141.Abilities.Sk8.Icon;
                            if not l_Rig_2:GetAttribute("Ragdolling") then
                                l_Humanoid_1.AutoRotate = true;
                            end;
                            v12:ToggleLockForAbilityIcon("Sk8", "NoCharges", not (v169.State.InZone or v169.State.ClosestSpray));
                            v79(v169.Behavior, "OnSk8Stop", v169);
                            v15:FireServerConnection(("%*StopSkate"):format(v169.Player.Name), "REMOTE_EVENT", v212);
                        end;
                        do
                            local l_v178_0, l_v179_0, l_v180_0, l_v181_0, l_v182_0, l_v183_0, l_v184_0, l_v185_0, l_v189_0, l_l_Unit_0_0, l_v196_0 = v178, v179, v180, v181, v182, v183, v184, v185, v189, l_Unit_0, v196;
                            local function v230(v228, v229) --[[ Line: 693 ]] --[[ Name: onTrickInput ]]
                                -- upvalues: l_v189_0 (ref)
                                if v228 ~= "TrickInput" then
                                    return;
                                else
                                    l_v189_0 = v229 == Enum.UserInputState.Begin or not (v229 == Enum.UserInputState.End) and l_v189_0;
                                    return;
                                end;
                            end;
                            if not v169.Meta.TutorialFlag then
                                v169.Meta.TutorialFlag = true;
                                v12:CreateWarning("Sk8SprayFail", v35[v190] .. " while glowing to perform a Trick!" or "are you dumb", script.Tip);
                            end;
                            v169.State.isSkating = true;
                            v169.State.TrickSpeed = v12:CreateSpeedMultiplier(l_Rig_2, 1, "Sk8Trick");
                            v169.State.TrickLandTween = l_TweenService_0:Create(v169.State.TrickSpeed, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                                Value = 1
                            });
                            v169.State.SkatingSpeed = v12:CreateSpeedMultiplier(l_Rig_2, v169.Config.Sk8Speed, "Sk8");
                            v169.State.OGStaminaLoss = v19.StaminaLoss;
                            v169.State.OGStaminaGain = v19.StaminaGain;
                            v169.Meta.Sk8AbilityUses = 0;
                            v19.BindsEnabled = false;
                            v19.StaminaGain = 0;
                            v19.IsSprinting = true;
                            v19.__sprintedEvent:Fire(true);
                            v169.AnimationType = false;
                            v169.HeldAbilities.Sk8 = nil;
                            v169.Rig:SetAttribute("NoFallSlow", true);
                            v169.Cooldowns.Sk8 = {
                                Duration = 0.5, 
                                TimePast = 0
                            };
                            l_ContextActionService_0:BindAction("TrickInput", v230, false, l_Space_0, l_ButtonX_0);
                            if v190 == "Mobile" then
                                v169.ConnectionDictionary.TrickStartInput = v19.MobileButton.MouseButton1Down:Connect(function() --[[ Line: 736 ]]
                                    -- upvalues: l_v189_0 (ref)
                                    local l_Begin_0 = Enum.UserInputState.Begin;
                                    l_v189_0 = l_Begin_0 == Enum.UserInputState.Begin or not (l_Begin_0 == Enum.UserInputState.End) and l_v189_0;
                                end);
                                v169.ConnectionDictionary.TrickEndInput = v19.MobileButton.MouseButton1Up:Connect(function() --[[ Line: 739 ]]
                                    -- upvalues: l_v189_0 (ref)
                                    local l_End_0 = Enum.UserInputState.End;
                                    l_v189_0 = l_End_0 == Enum.UserInputState.Begin or not (l_End_0 == Enum.UserInputState.End) and l_v189_0;
                                end);
                            end;
                            l_RunService_0:BindToRenderStep("Sk8", Enum.RenderPriority.Character.Value + 1, function(v233) --[[ Line: 746 ]]
                                -- upvalues: v12 (ref), v169 (copy), l_PrimaryPart_1 (copy), v19 (ref), v216 (copy), l_CurrentChannel_0 (copy), l_v182_0 (ref), l_Humanoid_1 (copy), l_v185_0 (ref), l_v178_0 (ref), v202 (copy), l_v183_0 (ref), v177 (copy), l_Rig_2 (copy), v173 (copy), v172 (copy), l_v180_0 (ref), l_v196_0 (ref), l_l_Unit_0_0 (ref), v198 (copy), v187 (copy), v207 (copy), v209 (copy), v208 (copy), l_abs_0 (ref), l_v181_0 (ref), l_v184_0 (ref), v15 (ref), l_v179_0 (ref), l_Sk8TrickCooldown_0 (copy), v203 (copy), l_v189_0 (ref), v14 (ref), v201 (copy), l_random_0 (ref), v79 (ref)
                                if not v12:IsAlive(v169 and v169.Rig) or l_PrimaryPart_1.Anchored or v169.Rig:GetAttribute("Ragdolling") or v19.Stamina <= (v19.MinStamina or 0) then
                                    v216("Manual");
                                    return;
                                else
                                    local v234 = l_CurrentChannel_0 == 1;
                                    local v235 = os.clock() - l_v182_0;
                                    local v236 = v235 < v169.Config.Sk8PhaseTime;
                                    local v237 = l_Humanoid_1.FloorMaterial ~= Enum.Material.Air;
                                    if l_v185_0 and os.clock() - l_v178_0 > 0.3 and v237 then
                                        l_v185_0 = false;
                                        v202.Force = Vector3.new(0, 0, 0, 0);
                                        l_v183_0 = os.clock();
                                        v169.Animations.Sk8TrickLand:Play(0);
                                        v169.State.TrickLandTween:Play();
                                    end;
                                    if not v236 and os.clock() - v177 > 0.4 and os.clock() - l_v178_0 > 0.5 and l_PrimaryPart_1.AssemblyLinearVelocity.Magnitude < 4 then
                                        v216("Manual");
                                        return;
                                    else
                                        local l_Head_0 = l_Rig_2:FindFirstChild("Head");
                                        local l_CurrentCamera_0 = workspace.CurrentCamera;
                                        local v240 = if ((not not v173:IsEnabled() or l_Head_0.LocalTransparencyModifier > 0.9) and "Camera" or "Keys") == "Camera" then l_CurrentCamera_0.CFrame.LookVector else l_CurrentCamera_0.CFrame:VectorToWorldSpace(v172:GetMoveVector());
                                        if v240 and v240.Magnitude > 0.001 and os.clock() - l_v180_0 > 0.2 then
                                            v240 = (v240 * Vector3.new(1, 0, 1, 0)).Unit;
                                            l_v196_0 = Vector3.new(v240.X, 0, v240.Z).Unit;
                                            local l_CFrame_0 = l_Rig_2.PrimaryPart.CFrame;
                                            local l_lookAt_0 = CFrame.lookAt;
                                            local l_Position_0 = l_CFrame_0.Position;
                                            local l_Position_1 = l_CFrame_0.Position;
                                            local l_l_l_Unit_0_0_0 = l_l_Unit_0_0;
                                            l_lookAt_0 = l_lookAt_0(l_Position_0, l_Position_1 + Vector3.new(l_l_l_Unit_0_0_0.X, 0, l_l_l_Unit_0_0_0.Z).Unit.Unit);
                                            l_Position_0 = l_l_Unit_0_0;
                                            local v246 = l_lookAt_0.RightVector:Dot(l_v196_0);
                                            l_Position_1 = (-l_lookAt_0.RightVector):Dot(l_v196_0);
                                            local v247 = l_lookAt_0.LookVector:Dot(l_v196_0) > 0.999 and 0 or l_Position_1 < v246 and -1 or v246 < l_Position_1 and 1 or 1;
                                            if (l_v196_0 - l_l_Unit_0_0).Magnitude > 0.005 then
                                                l_l_l_Unit_0_0_0 = os.clock() - l_v183_0;
                                                local l_InZone_0 = v169.State.InZone;
                                                local v249 = v169.Config[("Sk8Tony%*TurnDuration"):format(l_InZone_0 and "Charged" or "")];
                                                local v250 = l_v185_0 and 1 or l_CurrentChannel_0 == 3 and (v249 - l_l_l_Unit_0_0_0) / v249 or 0;
                                                local v251 = (v169.Config.Sk8TurnControl + math.lerp(0, v169.Config.Sk8TrickTurnControl, (math.clamp(v250, 0, 1)))) * v233;
                                                local v252 = math.acos((math.clamp(l_lookAt_0.LookVector:Dot(l_v196_0), -1, 1)));
                                                local l_LookVector_1 = (l_lookAt_0 * CFrame.Angles(0, math.min(v252, v247 * v251), 0)).LookVector;
                                                l_l_Unit_0_0 = Vector3.new(l_LookVector_1.X, 0, l_LookVector_1.Z).Unit.Unit;
                                                if l_l_Unit_0_0 ~= l_l_Unit_0_0 then
                                                    l_l_Unit_0_0 = l_Position_0;
                                                end;
                                            end;
                                        end;
                                        v12:GiveStackableAttribute(l_Rig_2, "DisableShiftLockMovement", "SkateboardV");
                                        l_Humanoid_1.AutoRotate = false;
                                        local l_Unit_1 = l_PrimaryPart_1.AssemblyLinearVelocity.Unit;
                                        if l_Unit_1 ~= l_Unit_1 then
                                            l_Unit_1 = l_l_Unit_0_0;
                                        end;
                                        l_Unit_1 = l_Unit_1 * Vector3.new(1, l_v185_0 and 0.2 or 0.95, 1);
                                        local l_l_Rig_2_Pivot_0 = l_Rig_2:GetPivot();
                                        v198.CFrame = CFrame.lookAt(l_l_Rig_2_Pivot_0.Position, l_l_Rig_2_Pivot_0.Position + l_Unit_1);
                                        l_Humanoid_1:Move(l_l_Unit_0_0);
                                        v19.StaminaLoss = v169.State.OGStaminaLoss * (v169.State.InZone and v169.Config.Sk8StaminaLoss or v187 and v169.Config.Sk8StaminaLossOutNerfed or v169.Config.Sk8StaminaLossOut);
                                        if os.clock() - l_v178_0 > 0.75 then
                                            local v256 = if os.clock() - l_v180_0 > 0.1 and os.clock() - l_v182_0 > 0.75 then workspace:Raycast(l_PrimaryPart_1.Position, l_l_Unit_0_0.Unit * 3, v207) else nil;
                                            local v257 = if not (l_CurrentChannel_0 ~= 2) or l_CurrentChannel_0 == 1 and v169.Config.Sk8PhaseTime + 0.5 < v235 and v169.Meta.Sk8AbilityUses < v169.Config.Sk8PhaseUses then workspace:Spherecast(l_PrimaryPart_1.Position, 4, l_l_Unit_0_0.Unit * (l_CurrentChannel_0 == 2 and 2.5 or 6), v209) else nil;
                                            local v258 = v257 or v256;
                                            local v259 = nil;
                                            local v260 = v258 and v258.Instance.Parent;
                                            local v261 = v260 and v260.Parent.Name == "Killers" and v260:FindFirstChild("Humanoid");
                                            if not v258 then
                                                for v262 = -90, 90, 5 do
                                                    local v263 = math.rad(v262);
                                                    local v264 = math.sin(v263) / 5;
                                                    local v265 = math.cos(v263);
                                                    local l_Unit_2 = l_l_Unit_0_0.Unit:Cross((Vector3.new(0, 1, 0, 0))).Unit;
                                                    local v267 = l_l_Unit_0_0.Unit * v265 + l_Unit_2 * v264;
                                                    v259 = workspace:Raycast(l_PrimaryPart_1.Position, v267 * 12, if v236 then v208 else v207);
                                                    v260 = v259 and v259.Instance.Parent;
                                                    v261 = v260 and v260.Parent.Name == "Killers" and v260:FindFirstChild("Humanoid");
                                                    if v259 and (l_abs_0((v259.Normal:Dot((Vector3.new(0, 1, 0, 0))))) < 0.2 or v261) then
                                                        break;
                                                    end;
                                                end;
                                            end;
                                            if v258 and (v261 or l_abs_0((v258.Normal:Dot((Vector3.new(0, 1, 0, 0))))) < 0.2) and not v236 then
                                                if v234 then
                                                    if v257 and v234 and v261 then
                                                        local l_Meta_0 = v169.Meta;
                                                        l_Meta_0.Sk8AbilityUses = l_Meta_0.Sk8AbilityUses + 1;
                                                        l_v182_0 = os.clock();
                                                        l_v181_0 = 0;
                                                        l_v184_0 = false;
                                                        v15:FireServerConnection(("%*SkatePhase"):format(v169.Player.Name), "REMOTE_EVENT", v260);
                                                    elseif os.clock() - l_v180_0 > 0.1 then
                                                        local l_Normal_0 = v258.Normal;
                                                        local l_Unit_3 = Vector3.new(l_Normal_0.X, 0, l_Normal_0.Z).Unit.Unit;
                                                        local l_AssemblyLinearVelocity_0 = l_PrimaryPart_1.AssemblyLinearVelocity;
                                                        local l_Unit_4 = Vector3.new(l_AssemblyLinearVelocity_0.X, 0, l_AssemblyLinearVelocity_0.Z).Unit.Unit;
                                                        l_Normal_0 = l_Unit_4 - 2 * l_Unit_4:Dot(l_Unit_3) * l_Unit_3;
                                                        l_l_Unit_0_0 = l_Normal_0;
                                                        l_PrimaryPart_1.AssemblyLinearVelocity = l_Normal_0 * 25;
                                                        l_v180_0 = os.clock();
                                                        v12:CreateSpeedMultiplier(l_Rig_2, 1.25, "Sk8Rebound", 0.1, true);
                                                        v15:FireServerConnection(("%*SkateRebound"):format(v169.Player.Name), "REMOTE_EVENT");
                                                    end;
                                                else
                                                    v216(v261 or v258.Instance);
                                                    return;
                                                end;
                                            elseif v235 > 0.15 and v259 and os.clock() - l_v179_0 > l_Sk8TrickCooldown_0 then
                                                l_v181_0 = os.clock();
                                                local l_Normal_1 = v259.Normal;
                                                l_v184_0 = Vector3.new(l_Normal_1.X, 0, l_Normal_1.Z).Unit.Unit;
                                            elseif os.clock() - l_v181_0 > 0.125 then
                                                l_v184_0 = false;
                                            end;
                                        else
                                            l_v184_0 = false;
                                        end;
                                        v203.Adornee = if l_v184_0 and os.clock() - l_v178_0 > l_Sk8TrickCooldown_0 then v169.Rig else nil;
                                        if v169.HeldAbilities.Sk8 and os.clock() - v177 > 0.5 then
                                            v169.HeldAbilities.Sk8 = nil;
                                            v216("Manual");
                                            return;
                                        else
                                            if l_v189_0 and os.clock() - l_v179_0 > l_Sk8TrickCooldown_0 and os.clock() - l_v178_0 > 0.25 and not v14:PlayerHasStatus(game.Players.LocalPlayer, "Helpless") then
                                                l_v189_0 = false;
                                                l_v179_0 = os.clock();
                                                if l_v184_0 then
                                                    l_v178_0 = os.clock();
                                                    l_v185_0 = true;
                                                    local l_l_Sk8TrickCooldown_0_0 = l_Sk8TrickCooldown_0;
                                                    v169.Cooldowns.Sk8 = {
                                                        Duration = l_l_Sk8TrickCooldown_0_0, 
                                                        TimePast = 0
                                                    };
                                                    l_l_Sk8TrickCooldown_0_0 = v169.State.InZone;
                                                    local l_Sk8TrickPower_0 = v169.Config.Sk8TrickPower;
                                                    local l_l_v184_0_0 = l_v184_0;
                                                    local v277 = if v187 then v169.Config.Sk8TrickStaminaNerfed else v169.Config.Sk8TrickStamina;
                                                    local l_AssemblyLinearVelocity_1 = l_PrimaryPart_1.AssemblyLinearVelocity;
                                                    local l_Unit_5 = Vector3.new(l_AssemblyLinearVelocity_1.X, 0, l_AssemblyLinearVelocity_1.Z).Unit.Unit;
                                                    local v280 = (l_Unit_5 - 2 * l_Unit_5:Dot(l_l_v184_0_0) * l_l_v184_0_0) * l_Sk8TrickPower_0 + Vector3.new(0, 1, 0, 0) * v169.Config.Sk8TrickJump * l_Sk8TrickPower_0;
                                                    l_PrimaryPart_1.AssemblyLinearVelocity = v280;
                                                    l_l_Unit_0_0 = (v280 * Vector3.new(1, 0, 1, 0)).Unit;
                                                    v19.Stamina = math.min(v19.Stamina + v277, v19.MaxStamina or 100);
                                                    v19.IsSprinting = true;
                                                    v19.__sprintedEvent:Fire(true);
                                                    v202.Force = v201;
                                                    v169.State.TrickLandTween:Cancel();
                                                    v169.State.TrickSpeed.Value = v169.Config.Sk8TrickAirborneSpeed;
                                                    v169.Animations[("Sk8Trick%*"):format((l_random_0(1, 2)))]:Play(0);
                                                    v79(v169.Behavior, "OnSk8Trick", v169);
                                                    v15:FireServerConnection(("%*SkateTrick"):format(v169.Player.Name), "REMOTE_EVENT");
                                                end;
                                                v79(v169.Behavior, "TrickCooldownVisual", v169, l_v184_0);
                                            end;
                                            return;
                                        end;
                                    end;
                                end;
                            end);
							v169.Animations.Sk8Start:Play(0.1);
                            v169.Animations.Sk8Skating:Play(0.1);
                            v79(v169.Behavior, "OnSk8Start", v169);
                        end;
                    end;
                end;
                return;
            end;
        end
    }, 
    Broadcast = {
        LayoutOrder = 3, 
        Icon = "rbxassetid://99218231350350", 
        KeybindType = "AltAbility3", 
        Cooldown = 0.5, 
        Callback = function(v281, v282) --[[ Line: 963 ]] --[[ Name: Callback ]]
            -- upvalues: l_RunService_0 (copy), v24 (ref), v37 (copy), l_delay_0 (copy), v79 (copy), v16 (copy)
            if l_RunService_0:IsServer() then
                v281.AbilitiesDisabled = true;
                local v283 = v281.Meta.CurrentChannel + 1;
                v281.Meta.CurrentChannel = v24 < v283 and 1 or v283;
                if l_RunService_0:IsStudio() then
                    local v284 = ("New channel is: %*"):format(v281.Meta.CurrentChannel);
                    if v37 then
                        warn((("[Veeronica]: %*"):format(v284)));
                    end;
                end;
                l_delay_0(0.33, function() --[[ Line: 979 ]]
                    -- upvalues: v79 (ref), v281 (copy)
                    v79(v281.Behavior, "OnChannelSwitch", v281);
                end);
                l_delay_0(0.5, function() --[[ Line: 984 ]]
                    -- upvalues: v281 (copy)
                    v281.AbilitiesDisabled = false;
                end);
                return v281.Meta.CurrentChannel;
            elseif not v282 then
                return;
            else
                v281.Animations.BroadcastSwitch:Play(0);
                v16:Play(v281.Config.Sounds.ChannelSwitch, {
                    Looped = false, 
                    Volume = 0.5
                });
                l_delay_0(0.33, function() --[[ Line: 999 ]]
                    -- upvalues: v79 (ref), v281 (copy)
                    v79(v281.Behavior, "OnChannelSwitch", v281);
                end);
                v281.Meta.CurrentChannel = v282;
                local v285 = v281.Config.BroadcastTypeData[v281.Meta.CurrentChannel or 1];
                v281.Behavior.Abilities.Broadcast.Icon = v285.Icon;
                v281.Behavior.Abilities.Broadcast.FlavorText = v285.Name or "IDK";
                return;
            end;
        end
    }, 
    ActivateBattery = {
        LayoutOrder = 4, 
        Icon = "rbxassetid://111551796924061", 
        KeybindType = "AltAbility4", 
        Callback = function(v286, v287) --[[ Line: 1017 ]] --[[ Name: Callback ]]
            -- upvalues: l_RunService_0 (copy), v79 (copy), v12 (copy), v16 (copy)
			if l_RunService_0:IsServer() then
				--[[local debugInfo = v286.Meta.CurrentBattery:Debug()
				print("Battery Debug:", debugInfo)--]]
                if v286.Meta.CurrentBattery.Charge <= 0 then
                    v286:SetCooldownOf("ActivateBattery", 0.75);
                    return "You are out of battery! Repair Generators or Bump into the Killer!";
                elseif v286.Rig.Humanoid.Health >= v286.Rig.Humanoid.MaxHealth then
                    v286:SetCooldownOf("ActivateBattery", 0.75);
                    return "You are already at full health.";
                else
                    v79(v286.Behavior, "OnActivateBattery", v286);
                    v286.Meta.CurrentBattery:StartHealing(function(v288, v289) --[[ Line: 1028 ]]
                        print(v288, v289);
                    end);
                    return false;
                end;
            else
                if v287 then
                    v12:CreateWarning("VeeNoBattery", v287);
                    v16:Play(v286.Config.Sounds.ActivateBatteryFailure);
                end;
                return;
            end;
        end
    }
};
v141.Created = function(_, v291) --[[ Line: 1044 ]] --[[ Name: Created ]]
    -- upvalues: v11 (copy), v24 (ref), v25 (ref), l_RunService_0 (copy), v9 (copy), l_clock_0 (copy), l_insert_0 (copy), v15 (copy), v12 (copy), v20 (copy), v63 (copy), v18 (copy), v84 (copy), l_TweenService_0 (copy), v79 (copy), l_delay_0 (copy), l_Players_0 (copy), l_find_0 (copy), l_remove_0 (copy), v140 (copy), v37 (copy), l_clamp_0 (copy), l_ContentProvider_0 (copy), l_CollectionService_0 (copy), v22 (copy)
    v291.Maid = v11.new();
    v291.Tags = {
        Spray = ("%*VeeGraffiti"):format(v291.Player.Name)
    };
    v291.Meta = {};
    v291.Instances = {};
    v291.State = {};
    v291.NetworkConnections = {};
    v291.ConnectionDictionary = {};
    v24 = #v291.Config.BroadcastTypeData;
    v25 = #v291.Config.VandalismSprayImages;
    v291.Meta.Sk8AbilityUses = 0;
    v291.Meta.CurrentChannel = 1;
    v291.Rig.Humanoid:SetAttribute("Robot", true);
    if l_RunService_0:IsServer() then
        v291.SprayObjects = {};
        v291.Meta.CurrentBattery = v9.new(v291.Rig);
        v291.Meta.CurrentKillers = {};
        v291.Meta.CurrentSprayZone = nil;
        v291.Meta.CurrentTrickCombo = 1;
        v291.State.SprayState = nil;
		v291.State.isSkating = false;
		v291.Rig:SetAttribute("Skating", false)
        v291.State.InZone = false;
        v291.State.ClosestSpray = nil;
        v291.State.LastBatteryCharge = l_clock_0();
        v291.Rig.Skateboard.Transparency = 1;
        v291.Rig.Spray.Transparency = 1;
        for _, v293 in ipairs({
            "Charged", 
            "Start", 
            "Ended", 
            "Interrupted", 
            "Finished", 
            "Discharged"
        }) do
            if v291.Behavior[("OnBattery%*"):format(v293)] then
                v291.Meta.CurrentBattery.Callbacks[v293] = function(...) --[[ Line: 1094 ]]
                    -- upvalues: v291 (copy), v293 (copy)
                    v291.Behavior[("OnBattery%*"):format(v293)](v291.Behavior, v291, ...);
                end;
            end;
        end;
        l_insert_0(v291.NetworkConnections, {
            ("%*RequestSprayAsync"):format(v291.Player.Name), 
            "REMOTE_FUNCTION"
        });
        v15:SetConnection(("%*RequestSprayAsync"):format(v291.Player.Name), "REMOTE_FUNCTION", function(v294) --[[ Line: 1103 ]]
            -- upvalues: v291 (copy), v12 (ref)
            if v294.UserId ~= v291.Player.UserId then
                v294:Kick((("\n\nForsakenCheatKiller 012:\nInvalid accessor for: %*RequestSprayAsync\n"):format(v291.Player.Name)));
                return;
            elseif not v12:IsAlive(v294.Character) then
                return "Dead";
            else
                local l_PrimaryPart_2 = v291.Rig.PrimaryPart;
                local l_Humanoid_2 = v291.Rig.Humanoid;
                if not l_PrimaryPart_2 or l_Humanoid_2 then

                end;
                return "Dead";
            end;
        end);
        l_insert_0(v291.NetworkConnections, {
            ("%*StopSkate"):format(v291.Player.Name), 
            "REMOTE_EVENT"
        });
        v15:SetConnection(("%*StopSkate"):format(v291.Player.Name), "REMOTE_EVENT", function(v297, v298) --[[ Line: 1128 ]]
            -- upvalues: v291 (copy), v12 (ref), v20 (ref), v63 (ref), v18 (ref), v84 (ref), l_TweenService_0 (ref), v79 (ref)
            if v297.Name ~= v291.Player.Name then
                return;
            elseif not v291.State.isSkating then
                return;
            else
                local _ = v291.Meta.CurrentChannel == 3;
                v291:SetCooldownOf("Sk8", v291.Config.Sk8CD);
                v12:RemoveStackableAttribute(v291.Rig, "FootstepsMuted", "Sk8");
				v291.State.isSkating = false;
				v291.Rig:SetAttribute("Skating", false)
                v291.Meta.Sk8AbilityUses = 0;
                v291.AbilitiesDisabled = nil;
                local v300 = typeof(v298) == "Instance";
                if v291.Meta.CurrentChannel == 2 and v300 and v298:IsA("Humanoid") then
                    local v301 = v298.Parent and v298.Parent:IsA("Model") and v298.Parent.PrimaryPart;
                    if not v301 then
                        return;
                    elseif (v301.Position - v291.Rig.PrimaryPart.Position).Magnitude > 20 then
                        return;
                    else
                        local v302 = os.clock() - (v298:GetAttribute("LastVeeBump") or 0) < v291.Config.Sk8BumpGlobalCooldown;
                        v298:SetAttribute("LastVeeBump", os.clock());
                        local l_v12_Actor_0 = v12:GetActor(v301.Parent);
                        local v304 = l_v12_Actor_0 and l_v12_Actor_0:GetPivot() or v301.CFrame;
                        local _ = v20:CreateHitbox(v291.Player, {
                            CFrame = CFrame.new(v304.Position) * v291.Rig.PrimaryPart.CFrame.Rotation, 
                            Damage = v291.Config[("Sk8Bump%*Damage"):format(v291.State.InZone and "Charged" or "")], 
                            Time = 0.001, 
                            HitMultiple = true, 
                            PredictVelocity = false, 
                            Knockback = (v302 and 0.1 or 1) * v291.Config[("Sk8Bump%*Power"):format(v291.State.InZone and "Charged" or "")]
                        });
                        local v306 = v291.Config[("Sk8Bump%*Battery"):format(v291.State.InZone and "Charged" or "")];
                        v291.Meta.CurrentBattery:IncrementCharge(v306);
                        v63(v291.Rig, v291.State.InZone and v291.Config.Sk8BumpChargedStatuses or v291.Config.Sk8BumpStatuses);
                        v18:IncrementActorStats(v291.Player, {
                            Action = "Knocked the Killer back with Bumper", 
                            Money = nil, 
                            EXP = nil, 
                            RewardType = "Survivalist"
                        });
                        v84(v291, "Sk8Bump");
                    end;
                elseif v300 then
                    v12:ApplyDamage(v291.Rig, v291.Config.Sk8BonkDamage);
                    v63(v291.Rig, v291.Config.Sk8BonkStatuses);
                    v84(v291, "Sk8Bonk");
                else
                    v84(v291, "Sk8Stop");
                end;
                v291.Meta.CurrentTrickCombo = 1;
                local l_Sk8LoopSound_0 = v291.Cache.Sk8LoopSound;
                if l_Sk8LoopSound_0 then
                    l_TweenService_0:Create(l_Sk8LoopSound_0, TweenInfo.new(0.3), {
                        Volume = 0, 
                        PlaybackSpeed = 0
                    }):Play();
                    game.Debris:AddItem(l_Sk8LoopSound_0, 0.35);
                end;
                v79(v291.Behavior, "ToggleSkateboard", v291, false);
                return;
            end;
        end);
        l_insert_0(v291.NetworkConnections, {
            ("%*SkatePhase"):format(v291.Player.Name), 
            "REMOTE_EVENT"
        });
        v15:SetConnection(("%*SkatePhase"):format(v291.Player.Name), "REMOTE_EVENT", function(v308, v309) --[[ Line: 1197 ]]
            -- upvalues: v291 (copy), v18 (ref), v63 (ref), v84 (ref)
            if v308.UserId ~= v291.Player.UserId then
                v308:Kick((("\n\nForsakenCheatKiller 012:\nInvalid accessor for: %*SkatePhase\n"):format(v291.Player.Name)));
                return;
            elseif not v309 or v309.Parent.Name ~= "Killers" or not v309:FindFirstChild("Humanoid") then
                return;
            elseif not v291.State.isSkating or v291.Meta.CurrentChannel ~= 1 or v291.Meta.Sk8AbilityUses >= v291.Config.Sk8PhaseUses then
                return;
            else
                v18:IncrementActorStats(v291.Player, {
                    Action = "Phased through the Killer", 
                    Money = nil, 
                    EXP = nil, 
                    RewardType = "Survivalist"
                });
                local l_Meta_1 = v291.Meta;
                l_Meta_1.Sk8AbilityUses = l_Meta_1.Sk8AbilityUses + 1;
                for _, v312 in ipairs(v291.Rig:GetChildren()) do
                    if v312:IsA("BasePart") and v312.CanCollide then
                        for _, v314 in ipairs(v309:GetChildren()) do
                            if v314:IsA("BasePart") and v314.CanCollide then
                                local v315 = Instance.new("NoCollisionConstraint", v312);
                                v315.Part0 = v312;
                                v315.Part1 = v314;
                                game.Debris:AddItem(v315, v291.Sk8PhaseTime);
                            end;
                        end;
                    end;
                end;
                l_Meta_1 = v291.Config.Sk8PhaseBattery;
                v291.Meta.CurrentBattery:IncrementCharge(l_Meta_1);
                v63(v291.Rig, v291.Config[("Sk8Phase%*Statuses"):format(v291.State.InZone and "Charged" or "")]);
                v84(v291, "Sk8Phase");
                return;
            end;
        end);
        local v316 = false;
        l_insert_0(v291.NetworkConnections, {
            ("%*SkateRebound"):format(v291.Player.Name), 
            "REMOTE_EVENT"
        });
        v15:SetConnection(("%*SkateRebound"):format(v291.Player.Name), "REMOTE_EVENT", function(v317) --[[ Line: 1247 ]]
            -- upvalues: v291 (copy), v316 (ref), l_delay_0 (ref), v12 (ref), v84 (ref)
            if v317 ~= v291.Player then
                return;
            elseif not v291.State.isSkating then
                return;
            elseif v316 then
                return;
            else
                v316 = true;
                l_delay_0(0.1, function() --[[ Line: 1254 ]]
                    -- upvalues: v316 (ref)
                    v316 = false;
                end);
                v12:ApplyDamage(v291.Rig, v291.Config.Sk8PhaseReboundDamage);
                v84(v291, "Sk8Rebound");
                return;
            end;
        end);
        local v318 = false;
        l_insert_0(v291.NetworkConnections, {
            ("%*SkateTrick"):format(v291.Player.Name), 
            "REMOTE_EVENT"
        });
        v15:SetConnection(("%*SkateTrick"):format(v291.Player.Name), "REMOTE_EVENT", function(v319) --[[ Line: 1267 ]]
            -- upvalues: v291 (copy), v318 (ref), l_delay_0 (ref), v18 (ref), v84 (ref), v79 (ref)
            if v319.Name ~= v291.Player.Name then
                return;
            elseif not v291.State.isSkating then
                return;
            elseif v318 then
                return;
            else
                v318 = true;
                l_delay_0(v291.Config.Sk8TrickCooldown - 0.35, function() --[[ Line: 1273 ]]
                    -- upvalues: v318 (ref)
                    v318 = false;
                end);
                if v291.Meta.CurrentTrickCombo == v291.Config.Sk8TrickCombo then
                    local l_Sk8TrickBattery_0 = v291.Config.Sk8TrickBattery;
                    v291.Meta.CurrentBattery:IncrementCharge(l_Sk8TrickBattery_0);
                    v291.Meta.CurrentTrickCombo = 1;
                    v18:IncrementActorStats(v291.Player, {
                        Action = "Did 3 Tricks in a row", 
                        Money = 1, 
                        EXP = 2, 
                        RewardType = nil
                    });
                else
                    local l_Meta_2 = v291.Meta;
                    l_Meta_2.CurrentTrickCombo = l_Meta_2.CurrentTrickCombo + 1;
                end;
                v84(v291, "Sk8Trick");
                v79(v291.Behavior, "OnSk8Trick", v291);
                return;
            end;
        end);
        v291.Maid:Add(l_Players_0.PlayerRemoving:Connect(function(v322) --[[ Line: 1296 ]]
            -- upvalues: l_find_0 (ref), v291 (copy), l_remove_0 (ref), v79 (ref)
            local v323 = l_find_0(v291.Meta.CurrentKillers, v322);
            local v324 = nil;
            if v323 then
                v324 = l_remove_0(v291.Meta.CurrentKillers, v323);
            end;
            v79(v291.Behavior, "OnSprayAreaExited", v291, v324);
        end));
        v291.Maid:Add(l_RunService_0.Heartbeat:Connect(function(v325) --[[ Line: 1309 ]]
            -- upvalues: v291 (copy), l_clock_0 (ref), v140 (ref), v15 (ref), v37 (ref)
            local v326 = #v291.Meta.CurrentKillers > 0;
            local v327 = l_clock_0();
            local v328 = v140(v291, v325);
            if v328 ~= v291.State.ClosestSpray then
                v15:FireClientConnection(v291.Player, "ReplicateClosestSpray", "REMOTE_EVENT", if v328 then v328.Model else nil);
            end;
            v291.State.ClosestSpray = v328;
            if v326 and v327 - v291.State.LastBatteryCharge > v291.Config.BatteryRechargeRate then
                v291.State.LastBatteryCharge = v327;
                v291.Meta.CurrentBattery:IncrementCharge();
                if v37 then
                    local v329 = ("Current battery charge is now: %*"):format(v291.Meta.CurrentBattery.Charge);
                    if v37 then
                        warn((("[Veeronica]: %*"):format(v329)));
                    end;
                end;
            end;
        end));
        return;
    else
        local v330 = l_Players_0.LocalPlayer == v291.Player;
        v291.Meta.__TVScreenCurrentSpeed = v291.Config.TVScreenSpeed;
        v291.Instances.IndicationBeams = {};
        v291.SprayVisuals = {};
        local v331 = v291.Rig and v291.Rig.TV.Screen:FindFirstChildOfClass("Texture");
        v291.Maid:Add(l_RunService_0.Heartbeat:Connect(function(v332) --[[ Line: 1341 ]]
            -- upvalues: v331 (copy), v291 (copy), l_clamp_0 (ref)
            if v331 and v331.Parent then
                v331.OffsetStudsV = l_clamp_0(v331.OffsetStudsV - 0.5 * (v332 * v291.Meta.__TVScreenCurrentSpeed), 0, 3);
                if v331.OffsetStudsV <= 0 then
                    v331.OffsetStudsV = 3;
                end;
            end;
            for _, v334 in v291.SprayVisuals do
                v334:UpdateBeam((v291.Rig.PrimaryPart.Position - v334.Root:GetPivot().Position).Magnitude <= v291.Config.VandalismSprayDistance);
            end;
        end));
        l_ContentProvider_0:PreloadAsync(v291.Config.VandalismSprayImages, function(v335, v336) --[[ Line: 1361 ]]
            -- upvalues: v37 (ref)
            local v337 = ("Preload Status: %* on ID: %*"):format(v336.Name, v335);
            if v37 then
                warn((("[Veeronica]: %*"):format(v337)));
            end;
        end);
        v291.ConnectionDictionary.SprayVisualAdded = l_CollectionService_0:GetInstanceAddedSignal(v291.Tags.Spray):Connect(function(v338) --[[ Line: 1367 ]]
            -- upvalues: v22 (ref), v291 (copy)
            v22.new(v291, v338);
        end);
        v291.ConnectionDictionary.SprayVisualRemoved = l_CollectionService_0:GetInstanceRemovedSignal(v291.Tags.Spray):Connect(function(v339) --[[ Line: 1370 ]]
            -- upvalues: v291 (copy)
            if v291.SprayVisuals[v339] then
                v291.SprayVisuals[v339]:Destroy();
            end;
        end);
        v291.State.LastSprayState = nil;
        l_insert_0(v291.NetworkConnections, {
            ("%*UpdateSprayState"):format(v291.Player.Name), 
            "REMOTE_EVENT"
        });
        v15:SetConnection(("%*UpdateSprayState"):format(v291.Player.Name), "REMOTE_EVENT", function(v340) --[[ Line: 1382 ]]
            -- upvalues: v330 (copy), v291 (copy), v79 (ref)
            if v330 and not v340 then
                v291.Behavior:UnequipSpray(v291);
            else
                v291.State.SprayState = v340;
            end;
            v79(v291.Behavior, "OnSprayStateChanged", v291, v340);
            v291.State.LastSprayState = v340;
        end);
        l_insert_0(v291.NetworkConnections, {
            ("%*ReplicateSprayAreaAsync"):format(v291.Player.Name), 
            "REMOTE_EVENT"
        });
        v15:SetConnection(("%*ReplicateSprayAreaAsync"):format(v291.Player.Name), "REMOTE_EVENT", function(v341) --[[ Line: 1397 ]]
            -- upvalues: v291 (copy), v37 (ref), v79 (ref)
            if v291.Rig and v341 and #v341 == 3 then
                if v37 then
                    warn("[Veeronica]: [ReplicateSprayAreaAsync]: Successfully got request!");
                end;
                v291.ActiveSprays = v341;
                v79(v291.Behavior, "CreateZoneVisual", v291, v341);
            end;
        end);
        l_insert_0(v291.NetworkConnections, {
            ("%*ReplicateRemovedSprayAreaAsync"):format(v291.Player.Name), 
            "REMOTE_EVENT"
        });
        v15:SetConnection(("%*ReplicateRemovedSprayAreaAsync"):format(v291.Player.Name), "REMOTE_EVENT", function(v342) --[[ Line: 1408 ]]
            -- upvalues: v291 (copy), v79 (ref)
            table.clear(v291.ActiveSprays or {});
            v291.ActiveSprays = nil;
            v79(v291.Behavior, "DestroyZoneVisual", v291, v342);
        end);
        if v330 then
            local l_PlayerGui_0 = l_Players_0.LocalPlayer:WaitForChild("PlayerGui");
            local v344 = v291.Config.BatteryUITemplate:Clone();
            local l_Scale_0 = v344.Back.Fill.Size.X.Scale;
            v344.Parent = l_PlayerGui_0.TemporaryUI;
            local function v347() --[[ Line: 1420 ]] --[[ Name: updateBatteryUI ]]
                -- upvalues: v291 (copy), v344 (copy), l_TweenService_0 (ref), l_Scale_0 (copy)
                local v346 = v291.Rig:GetAttribute("BatteryPercent") or 0;
                v344.Text.Text = tostring(v346) .. "%";
                l_TweenService_0:Create(v344.Back.Fill, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Size = UDim2.fromScale(l_Scale_0 * (v346 / 100), v344.Back.Fill.Size.Y.Scale), 
                    BackgroundColor3 = Color3.new(math.clamp((1 - v346 / 100) * 2, 0, 1), math.clamp(v346 / 100 * 2, 0, 1), 0)
                }):Play();
            end;
            v347();
            v291.ConnectionDictionary.OnBatteryChargeChanged = v291.Rig:GetAttributeChangedSignal("BatteryPercent"):Connect(v347);
            local v348 = v291.Config.BroadcastTypeData[v291.Meta.CurrentChannel or 1];
            v291.Behavior.Abilities.Broadcast.Icon = v348.Icon;
            v291.Behavior.Abilities.Broadcast.FlavorText = v348.Name or "IDK";
            v12:ToggleLockForAbilityIcon("Sk8", "NoCharges", true);
            l_insert_0(v291.NetworkConnections, {
                "ReplicateZoneStatus", 
                "REMOTE_EVENT"
            });
            v15:SetConnection("ReplicateZoneStatus", "REMOTE_EVENT", function(v349) --[[ Line: 1441 ]]
                -- upvalues: v291 (copy), v12 (ref)
                v291.State.InZone = v349;
                if not v291.State.isSkating then
                    v12:ToggleLockForAbilityIcon("Sk8", "NoCharges", not (v349 or v291.State.ClosestSpray));
                end;
            end);
            l_insert_0(v291.NetworkConnections, {
                "ReplicateClosestSpray", 
                "REMOTE_EVENT"
            });
            v15:SetConnection("ReplicateClosestSpray", "REMOTE_EVENT", function(v350) --[[ Line: 1450 ]]
                -- upvalues: v291 (copy), v12 (ref)
                v291.State.ClosestSpray = v350;
                for _, v352 in v291.SprayVisuals do
                    v352:ToggleInRange(v352.Root == v350);
                end;
                if not v291.State.isSkating then
                    v12:ToggleLockForAbilityIcon("Sk8", "NoCharges", not (v350 or v291.State.InZone));
                end;
            end);
            l_insert_0(v291.NetworkConnections, {
                "SprayDestroyed", 
                "REMOTE_EVENT"
            });
            v15:SetConnection("SprayDestroyed", "REMOTE_EVENT", function(v353) --[[ Line: 1464 ]]
                -- upvalues: v79 (ref), v291 (copy)
                v79(v291.Behavior, "OnSprayDestroyed", v291, v353);
            end);
        end;
        return;
    end;
end;
v141.Destroyed = function(_, v355) --[[ Line: 1471 ]] --[[ Name: Destroyed ]]
    -- upvalues: v15 (copy), v37 (copy), l_RunService_0 (copy), l_ContextActionService_0 (copy), v79 (copy)
    v355.Maid:Destroy();
    for _, v357 in v355.ConnectionDictionary do
        v357:Disconnect();
        v357 = nil;
    end;
    for _, v359 in v355.NetworkConnections do
        v15:RemoveConnection(v359[1], v359[2]);
        v359 = nil;
    end;
    for _, v361 in v355.Instances do
        if typeof(v361) == "table" then
            for _, v363 in v361 do
                local v364 = ("Removed instance reference: %*"):format(v363);
                if v37 then
                    warn((("[Veeronica]: %*"):format(v364)));
                end;
                v363:Destroy();
            end;
        else
            v361:Destroy();
        end;
    end;
    if l_RunService_0:IsServer() then
        for _, v366 in ipairs(v355.SprayObjects) do
            v366:Destroy();
        end;
        v15:RemoveConnection(("%*UpdateSprayInput"):format(v355.Player.Name), "REMOTE_EVENT");
        return;
    else
        local v367 = v355.SprayVisuals or {};
        for _, v369 in v367 do
            v369:Destroy();
        end;
        if v355.Player == game.Players.LocalPlayer then
            l_ContextActionService_0:UnbindAction("TrickInput");
            l_ContextActionService_0:UnbindAction("SprayInput");
            l_ContextActionService_0:UnbindAction("WipeInput");
            v15:RemoveConnection(("%*UpdateSprayState"):format(v355.Player.Name), "REMOTE_EVENT");
            l_RunService_0:UnbindFromRenderStep("Sk8");
        end;
        v79(v355.Behavior, "DestroyZoneVisual", v355);
        return;
    end;
end;
v141.OnObjectiveCompleted = function(_, v371, v372) --[[ Line: 1521 ]] --[[ Name: OnObjectiveCompleted ]]
    -- upvalues: l_RunService_0 (copy)
    if l_RunService_0:IsServer() then
        v371.Meta.CurrentBattery:IncrementCharge(v372 * v371.Config.BatteryGeneratorCharge);
    end;
end;
v141.UnequipSpray = function(_, v374) --[[ Line: 1527 ]] --[[ Name: UnequipSpray ]]
    -- upvalues: l_RunService_0 (copy), v15 (copy), v79 (copy), l_ContextActionService_0 (copy)
    if not v374.State.SprayState then
        return;
    else
        v374.State.SprayState = nil;
        if l_RunService_0:IsServer() then
            if v374.ConnectionDictionary.VandalListener then
                v374.ConnectionDictionary.VandalListener:Disconnect();
                v374.ConnectionDictionary.VandalListener = nil;
            end;
            v15:FireAllClientConnection(("%*UpdateSprayState"):format(v374.Player.Name), "REMOTE_EVENT");
            v15:RemoveConnection(("%*UpdateSprayInput"):format(v374.Player.Name), "REMOTE_EVENT");
            v79(v374.Behavior, "ToggleSpraycan", v374, false);
            return;
        else
            if l_RunService_0:IsClient() then
                for _, v376 in v374.SprayVisuals do
                    v376:ToggleBeam(false);
                end;
                if v374.SprayUI then
                    for _, v378 in ipairs(v374.SprayUI) do
                        v378:Destroy();
                    end;
                    v374.SprayUI = nil;
                end;
                l_ContextActionService_0:UnbindAction("SprayInput");
                l_ContextActionService_0:UnbindAction("WipeInput");
                v374.Animations.CanIdle:Stop();
                v374.Animations.CanTakeout:Stop();
            end;
            return;
        end;
    end;
end;
v141.OnSprayDestroyed = function(_, v380, v381) --[[ Line: 1563 ]] --[[ Name: OnSprayDestroyed ]]
    -- upvalues: l_RunService_0 (copy), v16 (copy), l_TweenService_0 (copy)
    if l_RunService_0:IsClient() and v380.Player == game.Players.LocalPlayer then
        local v382 = Instance.new("Attachment", workspace.Terrain);
        v382.WorldPosition = v381;
        game.Debris:AddItem(v382, 3.35);
        v16:Play(v380.Config.Sounds.SprayDestroyedNotif);
        local v383 = v380.Config.VandalismDestroyedUI:Clone();
        local l_Spray_0 = v383.Spray;
        local l_Cross_0 = v383.Cross;
        l_Spray_0.ImageTransparency = 1;
        l_Cross_0.ImageTransparency = 1;
        l_Cross_0.Size = UDim2.fromScale(3.5, 3.5);
        l_Cross_0.Rotation = (math.random(1, 2) == 2 and -1 or 1) * 274;
        v383.Parent = v382;
        local v386 = l_TweenService_0:Create(l_Spray_0, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            ImageTransparency = 0.25
        });
        local v387 = l_TweenService_0:Create(l_Cross_0, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            ImageTransparency = 0.3, 
            Rotation = 0
        });
        local v388 = l_TweenService_0:Create(l_Cross_0, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Size = UDim2.fromScale(1, 1)
        });
        v387:Play();
        v388:Play();
        v386:Play();
        v387.Completed:Wait();
        spawn(function() --[[ Line: 1591 ]]
            -- upvalues: l_Cross_0 (copy), l_Spray_0 (copy), l_TweenService_0 (ref), v383 (copy)
            local v389 = os.clock();
            local l_Position_2 = l_Cross_0.Position;
            local l_Rotation_0 = l_Cross_0.Rotation;
            l_Spray_0.ImageColor3 = Color3.fromRGB(255, 0, 0);
            l_Spray_0.Size = UDim2.fromScale(0.5, 0.5);
            l_Cross_0.ImageTransparency = 0;
            l_TweenService_0:Create(l_Cross_0, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ImageTransparency = 0.15
            }):Play();
            l_TweenService_0:Create(l_Spray_0, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ImageColor3 = Color3.fromRGB(0, 0, 0)
            }):Play();
            local _ = l_TweenService_0:Create(l_Spray_0, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(1, 1)
            }):Play();
            while os.clock() - v389 < 1 do
                local v393 = 1 - (os.clock() - v389);
                local v394 = l_Position_2 + UDim2.fromScale(math.random(-100, 100) * v393 / 900, math.random(-100, 100) * v393 / 900);
                local v395 = l_Rotation_0 + math.random(-100, 100) * v393 / 7;
                for _, v397 in {
                    l_Cross_0, 
                    l_Spray_0
                } do
                    v397.Position = v394;
                    v397.Rotation = v395;
                end;
                game["Run Service"].RenderStepped:Wait();
            end;
            l_TweenService_0:Create(l_Spray_0, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                ImageTransparency = 1, 
                Position = UDim2.fromScale(0.5, 1.5), 
                Rotation = math.random(0, 50), 
                Size = UDim2.fromScale(0, 0)
            }):Play();
            l_TweenService_0:Create(l_Cross_0, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                ImageTransparency = 1, 
                Position = UDim2.fromScale(0.5, 1.5), 
                Rotation = math.random(-50, 0), 
                Size = UDim2.fromScale(0, 0)
            }):Play();
            task.wait(0.5);
            v383:Destroy();
        end);
    end;
end;
v141.ToggleSpraycan = function(_, v399, v400) --[[ Line: 1624 ]] --[[ Name: ToggleSpraycan ]]
    v399.Rig.Spray.Transparency = v400 and 0 or 1;
end;
v141.ToggleSkateboard = function(_, v402, v403) --[[ Line: 1628 ]] --[[ Name: ToggleSkateboard ]]
    v402.Rig.Skateboard.Transparency = v403 and 0 or 1;
end;
v141.CreateZoneVisual = function(_, v405, v406) --[[ Line: 1632 ]] --[[ Name: CreateZoneVisual ]]
    -- upvalues: l_TweenService_0 (copy), v16 (copy)
    local v407 = Instance.new("Model", workspace.Misc);
    v407.Name = v405.Player.Name .. "SprayZoneVisual";
    local v408 = {};
    local v409 = TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
    local v410 = nil;
    for v411, v412 in ipairs(v406) do
        local v413 = v405.Config.VandalismZoneVisual:Clone();
        v413.Parent = v407;
        v413.Position = v412.Position;
        l_TweenService_0:Create(v413, v409, {
            Size = Vector3.new(100, 1, 1, 0), 
            Transparency = 0.95
        }):Play();
        l_TweenService_0:Create(v413.Beam, v409, {
            Width0 = 100, 
            Width1 = 100
        }):Play();
        v16:Play(v405.Config.Sounds.VandalismZoneCreated, {
            Parent = v413
        });
        if v410 then
            v413.Beam.Attachment1 = v410.AttachmentA;
        end;
        v410 = v413;
        v408[v411] = v413;
    end;
    v408[1].Beam.Attachment1 = v410.AttachmentA;
    v405.SprayArea = v407;
end;
v141.DestroyZoneVisual = function(_, v415) --[[ Line: 1663 ]] --[[ Name: DestroyZoneVisual ]]
    -- upvalues: l_TweenService_0 (copy), v16 (copy)
    local l_SprayArea_0 = v415.SprayArea;
    if not l_SprayArea_0 then
        return;
    else
        local v417 = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
        for _, v419 in ipairs(l_SprayArea_0:GetChildren()) do
            l_TweenService_0:Create(v419, v417, {
                Size = Vector3.new(0, 1, 1, 0), 
                Transparency = 1
            }):Play();
            l_TweenService_0:Create(v419.Beam, v417, {
                Width0 = 0, 
                Width1 = 0
            }):Play();
            v16:Play(v415.Config.Sounds.VandalismZoneDestroyed, {
                Parent = v419
            });
        end;
        game.Debris:AddItem(l_SprayArea_0, 3);
        v415.SprayArea = nil;
        return;
    end;
end;
v141.TrickCooldownVisual = function(_, v421, v422) --[[ Line: 1679 ]] --[[ Name: TrickCooldownVisual ]]
    -- upvalues: l_TweenService_0 (copy), v84 (copy)
    if v421.Cache.VFXHighlight then
        v421.Cache.VFXHighlight:Destroy();
        v421.Cache.VFXHighlight = nil;
    end;
    task.spawn(function() --[[ Line: 1685 ]]
        -- upvalues: v422 (copy), v421 (copy), l_TweenService_0 (ref), v84 (ref)
        if v422 then
            local v423 = v421.Config.Sk8TrickCooldown / 3;
            local v424 = Instance.new("Highlight", v421.Rig);
            v424.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
            v424.Adornee = v421.Rig;
            v421.Cache.VFXHighlight = v424;
            for _ = 1, 3 do
                for v426, v427 in pairs(v421.Config.Sk8TrickHighlightData.TrickCooldownFlash) do
                    v424[v426] = v427;
                end;
                l_TweenService_0:Create(v424, TweenInfo.new(v423), v421.Config.Sk8TrickHighlightData.TrickCooldownDecay):Play();
                v84(v421, "Sk8CooldownFlash", {
                    Volume = 0.35
                });
                task.wait(v423);
            end;
            v84(v421, "Sk8CooldownReady", {
                Volume = 0.35
            });
            v424:Destroy();
            return;
        else
            local v428 = Instance.new("Highlight", v421.Rig);
            v428.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
            v428.Adornee = v421.Rig;
            v421.Cache.VFXHighlight = v428;
            for v429, v430 in pairs(v421.Config.Sk8TrickHighlightData.TrickCooldownFail) do
                v428[v429] = v430;
            end;
            l_TweenService_0:Create(v428, TweenInfo.new(v421.Config.Sk8TrickCooldown), {
                FillTransparency = 0.9, 
                OutlineTransparency = 1
            }):Play();
            v84(v421, "Sk8CooldownFail", {
                Volume = 0.35
            });
            task.wait(v421.Config.Sk8TrickCooldown);
            v84(v421, "Sk8CooldownReady", {
                Volume = 0.35
            });
            v428:Destroy();
            return;
        end;
    end);
end;
v141.OnSprayStateChanged = function(_, v432, v433) --[[ Line: 1723 ]] --[[ Name: OnSprayStateChanged ]]
    -- upvalues: l_RunService_0 (copy), v16 (copy)
    if l_RunService_0:IsClient() then
        local v434 = game.Players.LocalPlayer == v432.Player;
        for _, v436 in ipairs({
            "SprayingSound", 
            "WipingSound"
        }) do
            if v432.Cache[v436] then
                v432.Cache[v436]:Destroy();
                v432.Cache[v436] = nil;
            end;
        end;
        if v433 == "Spraying" then
            v432.Cache.SprayingSound = v16:Play(v432.Config.Sounds.VandalismSpray, {
                Parent = v432.Rig.PrimaryPart, 
                Looped = true
            });
        elseif v433 == "Wiping" then
            v432.Cache.WipingSound = v16:Play(v432.Config.Sounds.VandalismWipe, {
                Parent = v432.Rig.PrimaryPart, 
                Looped = true
            });
        end;
        if v434 then
            if not v433 then
                v432.Animations.CanIdle:Stop();
                v432.Animations.CanSpray:Stop();
                v432.Animations.CanWipe:Stop();
                return;
            elseif v433 == "Wiping" then
                v432.Animations.CanWipe:Play();
                return;
            elseif v433 == "Spraying" then
                v432.Animations.CanSpray:Play();
                return;
            elseif v433 == "Idle" then
                v432.Animations.CanSpray:Stop();
                v432.Animations.CanWipe:Stop();
            end;
        end;
    end;
end;
--[[v141.OnBatteryCharged = function(_, _, _)

end;
v141.OnBatteryStart = function(_, v441)
    -- upvalues: v84 (copy)
    v441.Meta.BatteryLoopSound = v84(v441, "BatteryLoop", {
        Looped = true, 
        PlaybackSpeed = 1
    });
    v84(v441, "BatteryStart");
end;
v141.OnBatteryEnded = function(_, v443) 
    -- upvalues: l_TweenService_0 (copy)
    local l_BatteryLoopSound_0 = v443.Meta.BatteryLoopSound;
    if l_BatteryLoopSound_0 then
        l_TweenService_0:Create(l_BatteryLoopSound_0, TweenInfo.new(0.2), {
            PlaybackSpeed = 0
        }):Play();
        game.Debris:AddItem(l_BatteryLoopSound_0, 0.5);
    end;
    v443.Meta.BatteryLoopSound = nil;
end;
v141.OnBatteryInterrupted = function(_, v446)
    -- upvalues: v84 (copy)
    v84(v446, "BatteryInterrupted");
end;
v141.OnBatteryDischarged = function(_, v448)
    -- upvalues: v84 (copy)
    v84(v448, "BatteryDischarged");
end;
v141.OnBatteryFinished = function(_, v450)
    -- upvalues: v84 (copy)
    v84(v450, "BatteryFinished");
end;--]]
v141.OnSprayAreaEntered = function(_, _, _) --[[ Line: 1787 ]] --[[ Name: OnSprayAreaEntered ]]

end;
v141.OnSprayAreaExited = function(_, _, _) --[[ Line: 1791 ]] --[[ Name: OnSprayAreaExited ]]

end;
v141.OnChannelSwitch = function(_, v458) --[[ Line: 1795 ]] --[[ Name: OnChannelSwitch ]]
    -- upvalues: l_RunService_0 (copy), l_TweenService_0 (copy), v28 (copy), v91 (copy), l_delay_0 (copy)
    if l_RunService_0:IsServer() then
        v458:ChangeExpression("Hurt", 0.25);
        return;
    else
        local v459 = v458.Rig and v458.Rig.TV.Screen.SurfaceGui.Static;
        if v459 then
            if v459:GetTags()[1] ~= "Spritesheet" then
                v459:SetAttribute("Spritesheet", "Static");
                v459:AddTag("Spritesheet");
            end;
            v459.ImageTransparency = 0;
            l_TweenService_0:Create(v459, v28, {
                ImageTransparency = 1
            }):Play();
        end;
        v91(v458, 8, 0.015);
        l_delay_0(0.015, function() --[[ Line: 1811 ]]
            -- upvalues: v91 (ref), v458 (copy)
            v91(v458, 1, 3.5);
        end);
        return;
    end;
end;
v141.OnSk8Start = function(_, v461) --[[ Line: 1817 ]] --[[ Name: OnSk8Start ]]
    -- upvalues: l_RunService_0 (copy)
    if l_RunService_0:IsServer() then
        return;
    else
        local l_S8EffectsTemplate_0 = v461.Config.S8EffectsTemplate;
        if l_S8EffectsTemplate_0 and v461.Rig.PrimaryPart then
            local v463 = l_S8EffectsTemplate_0:Clone();
            v463.CFrame = v461.Rig.PrimaryPart.CFrame;
            v463.Name = "S8VFX";
            v463.Parent = v461.Rig.PrimaryPart;
            local l_WeldConstraint_0 = Instance.new("WeldConstraint");
            l_WeldConstraint_0.Part0 = v461.Rig.PrimaryPart;
            l_WeldConstraint_0.Part1 = v463;
            l_WeldConstraint_0.Parent = l_WeldConstraint_0.Part1;
            local v465 = v463:FindFirstChild("Wheel1") and v463.Wheel1:FindFirstChildOfClass("Trail");
            if v465 then
                v465.Enabled = true;
            end;
            v461.Instances.S8EFFECTS = v463;
        end;
        return;
    end;
end;
v141.OnSk8Stop = function(_, v467) --[[ Line: 1842 ]] --[[ Name: OnSk8Stop ]]
    -- upvalues: l_RunService_0 (copy)
    if l_RunService_0:IsServer() then
        return;
    else
        local l_S8VFX_0 = v467.Rig.PrimaryPart:FindFirstChild("S8VFX");
        if l_S8VFX_0 then
            l_S8VFX_0:Destroy();
        end;
        return;
    end;
end;
v141.OnSk8Trick = function(_, v470) --[[ Line: 1852 ]] --[[ Name: OnSk8Trick ]]
    -- upvalues: l_RunService_0 (copy)
    if l_RunService_0:IsServer() then
        return;
    else
        local l_S8VFX_1 = v470.Rig.PrimaryPart:FindFirstChild("S8VFX");
        if l_S8VFX_1 and l_S8VFX_1:FindFirstChild("Trick") then
            local l_Sparkles_0 = l_S8VFX_1.Trick:FindFirstChild("Sparkles");
            if l_Sparkles_0 and l_Sparkles_0:IsA("ParticleEmitter") then
                l_Sparkles_0:Emit(10);
            end;
        end;
        return;
    end;
end;
v141.ZoneCharge = function(_, v474, v475) --[[ Line: 1865 ]] --[[ Name: ZoneCharge ]]
    v474.Rig.Head.TennaA.ParticleEmitter.Enabled = v475;
    v474.Rig.Head.TennaB.ParticleEmitter.Enabled = v475;
end;
return v141;