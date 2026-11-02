-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Parent_0 = script.Parent;
local l_Humanoid_0 = l_Parent_0:WaitForChild("Humanoid");
local v2 = "Standing";
local function v3() --[[ Line: 7 ]] --[[ Name: getRigScale ]]
    -- upvalues: l_Parent_0 (copy)
    return l_Parent_0:GetScale();
end;
local l_ScaleDampeningPercent_0 = script:FindFirstChild("ScaleDampeningPercent");
local v5 = "";
local v6 = nil;
local v7 = nil;
local v8 = nil;
local v9 = 1;
local v10 = nil;
local v11 = nil;
local v12 = {};
local v13 = {};
local v14 = {
    idle = {
        {
            id = "http://www.roblox.com/asset/?id=507766666", 
            weight = 1
        }, 
        {
            id = "http://www.roblox.com/asset/?id=507766951", 
            weight = 1
        }, 
        {
            id = "http://www.roblox.com/asset/?id=507766388", 
            weight = 9
        }
    }, 
    walk = {
        {
            id = "http://www.roblox.com/asset/?id=507777826", 
            weight = 10
        }
    }, 
    run = {
        {
            id = "http://www.roblox.com/asset/?id=507767714", 
            weight = 10
        }
    }, 
    swim = {
        {
            id = "http://www.roblox.com/asset/?id=507784897", 
            weight = 10
        }
    }, 
    swimidle = {
        {
            id = "http://www.roblox.com/asset/?id=507785072", 
            weight = 10
        }
    }, 
    jump = {
        {
            id = "http://www.roblox.com/asset/?id=507765000", 
            weight = 10
        }
    }, 
    fall = {
        {
            id = "http://www.roblox.com/asset/?id=507767968", 
            weight = 10
        }
    }, 
    climb = {
        {
            id = "http://www.roblox.com/asset/?id=507765644", 
            weight = 10
        }
    }, 
    sit = {
        {
            id = "http://www.roblox.com/asset/?id=2506281703", 
            weight = 10
        }
    }, 
    toolnone = {
        {
            id = "http://www.roblox.com/asset/?id=507768375", 
            weight = 10
        }
    }, 
    toolslash = {
        {
            id = "http://www.roblox.com/asset/?id=522635514", 
            weight = 10
        }
    }, 
    toollunge = {
        {
            id = "http://www.roblox.com/asset/?id=522638767", 
            weight = 10
        }
    }, 
    wave = {
        {
            id = "http://www.roblox.com/asset/?id=507770239", 
            weight = 10
        }
    }, 
    point = {
        {
            id = "http://www.roblox.com/asset/?id=507770453", 
            weight = 10
        }
    }, 
    dance = {
        {
            id = "http://www.roblox.com/asset/?id=507771019", 
            weight = 10
        }, 
        {
            id = "http://www.roblox.com/asset/?id=507771955", 
            weight = 10
        }, 
        {
            id = "http://www.roblox.com/asset/?id=507772104", 
            weight = 10
        }
    }, 
    dance2 = {
        {
            id = "http://www.roblox.com/asset/?id=507776043", 
            weight = 10
        }, 
        {
            id = "http://www.roblox.com/asset/?id=507776720", 
            weight = 10
        }, 
        {
            id = "http://www.roblox.com/asset/?id=507776879", 
            weight = 10
        }
    }, 
    dance3 = {
        {
            id = "http://www.roblox.com/asset/?id=507777268", 
            weight = 10
        }, 
        {
            id = "http://www.roblox.com/asset/?id=507777451", 
            weight = 10
        }, 
        {
            id = "http://www.roblox.com/asset/?id=507777623", 
            weight = 10
        }
    }, 
    laugh = {
        {
            id = "http://www.roblox.com/asset/?id=507770818", 
            weight = 10
        }
    }, 
    cheer = {
        {
            id = "http://www.roblox.com/asset/?id=507770677", 
            weight = 10
        }
    }
};
local v15 = {
    wave = false, 
    point = false, 
    dance = true, 
    dance2 = true, 
    dance3 = true, 
    laugh = false, 
    cheer = false
};
local v16 = nil;
local v17 = nil;
local v18 = nil;
local v19 = nil;
local v20 = nil;
resetManagerListeners = function() --[[ Line: 115 ]] --[[ Name: resetManagerListeners ]]
    -- upvalues: v16 (ref), v17 (ref), v18 (ref)
    if v16 then
        v16:Disconnect();
        v16 = nil;
    end;
    if v17 then
        v17:Disconnect();
        v17 = nil;
    end;
    if v18 then
        v18:Disconnect();
        v18 = nil;
    end;
end;
processIfManagerBelongsToCharacter = function(v21) --[[ Line: 132 ]] --[[ Name: processIfManagerBelongsToCharacter ]]
    -- upvalues: l_Parent_0 (copy), v20 (ref), v19 (ref), v16 (ref), v17 (ref), v18 (ref)
    if v21.RootPart == l_Parent_0.PrimaryPart then
        if v20 ~= v21 then
            resetManagerListeners();
            v19 = v21.GroundSensor;
            v16 = v21:GetPropertyChangedSignal("GroundSensor"):Connect(function() --[[ Line: 137 ]]
                -- upvalues: v21 (copy), v16 (ref)
                if processIfManagerBelongsToCharacter(v21) then
                    v16:Disconnect();
                    v16 = nil;
                end;
            end);
            v17 = v21:GetPropertyChangedSignal("RootPart"):Connect(function() --[[ Line: 143 ]]
                -- upvalues: v21 (copy), v17 (ref)
                if processIfManagerBelongsToCharacter(v21) then
                    v17:Disconnect();
                    v17 = nil;
                end;
            end);
            v18 = v21.AncestryChanged:Connect(function(_, v23) --[[ Line: 149 ]]
                if v23 == nil then
                    resetManagerListeners();
                    lookForControllerManager();
                end;
            end);
            v20 = v21;
        end;
        return true;
    else
        return false;
    end;
end;
lookForControllerManager = function() --[[ Line: 165 ]] --[[ Name: lookForControllerManager ]]
    -- upvalues: v19 (ref), v20 (ref), l_Parent_0 (copy)
    v19 = nil;
    v20 = nil;
    local l_ControllerManager_0 = l_Parent_0:FindFirstChildOfClass("ControllerManager");
    if l_ControllerManager_0 then
        processIfManagerBelongsToCharacter(l_ControllerManager_0);
    end;
    if v20 == nil then
        local v25 = nil;
        do
            local l_v25_0 = v25;
            l_v25_0 = l_Parent_0.ChildAdded:Connect(function(v27) --[[ Line: 177 ]]
                -- upvalues: l_v25_0 (ref)
                if v27:IsA("ControllerManager") and processIfManagerBelongsToCharacter(v27) then
                    l_v25_0:Disconnect();
                    l_v25_0 = nil;
                end;
            end);
        end;
    end;
end;
lookForControllerManager();
math.randomseed(tick());
findExistingAnimationInSet = function(v28, v29) --[[ Line: 191 ]] --[[ Name: findExistingAnimationInSet ]]
    if v28 == nil or v29 == nil then
        return 0;
    else
        for v30 = 1, v28.count do
            if v28[v30].anim.AnimationId == v29.AnimationId then
                return v30;
            end;
        end;
        return 0;
    end;
end;
configureAnimationSet = function(v31, v32) --[[ Line: 205 ]] --[[ Name: configureAnimationSet ]]
    -- upvalues: v13 (copy), v12 (copy), l_Humanoid_0 (copy)
    if v13[v31] ~= nil then
        for _, v34 in pairs(v13[v31].connections) do
            v34:disconnect();
        end;
    end;
    v13[v31] = {};
    v13[v31].count = 0;
    v13[v31].totalWeight = 0;
    v13[v31].connections = {};
    local v35 = true;
    local l_status_0, _ = pcall(function() --[[ Line: 218 ]]
        -- upvalues: v35 (ref)
        v35 = game:GetService("StarterPlayer").AllowCustomAnimations;
    end);
    if not l_status_0 then
        v35 = true;
    end;
    local l_script_FirstChild_0 = script:FindFirstChild(v31);
    if v35 and l_script_FirstChild_0 ~= nil then
        table.insert(v13[v31].connections, l_script_FirstChild_0.ChildAdded:connect(function(_) --[[ Line: 226 ]]
            -- upvalues: v31 (copy), v32 (copy)
            configureAnimationSet(v31, v32);
        end));
        table.insert(v13[v31].connections, l_script_FirstChild_0.ChildRemoved:connect(function(_) --[[ Line: 227 ]]
            -- upvalues: v31 (copy), v32 (copy)
            configureAnimationSet(v31, v32);
        end));
        local v41 = 0;
        for _, v43 in pairs(l_script_FirstChild_0:GetChildren()) do
            if v43:IsA("Animation") then
                local v44 = 1;
                local l_Weight_0 = v43:FindFirstChild("Weight");
                if l_Weight_0 ~= nil then
                    v44 = l_Weight_0.Value;
                end;
                v13[v31].count = v13[v31].count + 1;
                v41 = v13[v31].count;
                v13[v31][v41] = {};
                v13[v31][v41].anim = v43;
                v13[v31][v41].weight = v44;
                v13[v31].totalWeight = v13[v31].totalWeight + v13[v31][v41].weight;
                table.insert(v13[v31].connections, v43.Changed:connect(function(_) --[[ Line: 243 ]]
                    -- upvalues: v31 (copy), v32 (copy)
                    configureAnimationSet(v31, v32);
                end));
                table.insert(v13[v31].connections, v43.ChildAdded:connect(function(_) --[[ Line: 244 ]]
                    -- upvalues: v31 (copy), v32 (copy)
                    configureAnimationSet(v31, v32);
                end));
                table.insert(v13[v31].connections, v43.ChildRemoved:connect(function(_) --[[ Line: 245 ]]
                    -- upvalues: v31 (copy), v32 (copy)
                    configureAnimationSet(v31, v32);
                end));
            end;
        end;
    end;
    if v13[v31].count <= 0 then
        for v49, v50 in pairs(v32) do
            v13[v31][v49] = {};
            v13[v31][v49].anim = Instance.new("Animation");
            v13[v31][v49].anim.Name = v31;
            v13[v31][v49].anim.AnimationId = v50.id;
            v13[v31][v49].weight = v50.weight;
            v13[v31].count = v13[v31].count + 1;
            v13[v31].totalWeight = v13[v31].totalWeight + v50.weight;
        end;
    end;
    for _, v52 in pairs(v13) do
        for v53 = 1, v52.count do
            if v12[v52[v53].anim.AnimationId] == nil then
                l_Humanoid_0:LoadAnimation(v52[v53].anim);
                v12[v52[v53].anim.AnimationId] = true;
            end;
        end;
    end;
end;
configureAnimationSetOld = function(v54, v55) --[[ Line: 276 ]] --[[ Name: configureAnimationSetOld ]]
    -- upvalues: v13 (copy), l_Humanoid_0 (copy)
    if v13[v54] ~= nil then
        for _, v57 in pairs(v13[v54].connections) do
            v57:disconnect();
        end;
    end;
    v13[v54] = {};
    v13[v54].count = 0;
    v13[v54].totalWeight = 0;
    v13[v54].connections = {};
    local v58 = true;
    local l_status_1, _ = pcall(function() --[[ Line: 289 ]]
        -- upvalues: v58 (ref)
        v58 = game:GetService("StarterPlayer").AllowCustomAnimations;
    end);
    if not l_status_1 then
        v58 = true;
    end;
    local l_script_FirstChild_1 = script:FindFirstChild(v54);
    if v58 and l_script_FirstChild_1 ~= nil then
        table.insert(v13[v54].connections, l_script_FirstChild_1.ChildAdded:connect(function(_) --[[ Line: 297 ]]
            -- upvalues: v54 (copy), v55 (copy)
            configureAnimationSet(v54, v55);
        end));
        table.insert(v13[v54].connections, l_script_FirstChild_1.ChildRemoved:connect(function(_) --[[ Line: 298 ]]
            -- upvalues: v54 (copy), v55 (copy)
            configureAnimationSet(v54, v55);
        end));
        local v64 = 1;
        for _, v66 in pairs(l_script_FirstChild_1:GetChildren()) do
            if v66:IsA("Animation") then
                table.insert(v13[v54].connections, v66.Changed:connect(function(_) --[[ Line: 302 ]]
                    -- upvalues: v54 (copy), v55 (copy)
                    configureAnimationSet(v54, v55);
                end));
                v13[v54][v64] = {};
                v13[v54][v64].anim = v66;
                local l_Weight_1 = v66:FindFirstChild("Weight");
                if l_Weight_1 == nil then
                    v13[v54][v64].weight = 1;
                else
                    v13[v54][v64].weight = l_Weight_1.Value;
                end;
                v13[v54].count = v13[v54].count + 1;
                v13[v54].totalWeight = v13[v54].totalWeight + v13[v54][v64].weight;
                v64 = v64 + 1;
            end;
        end;
    end;
    if v13[v54].count <= 0 then
        for v69, v70 in pairs(v55) do
            v13[v54][v69] = {};
            v13[v54][v69].anim = Instance.new("Animation");
            v13[v54][v69].anim.Name = v54;
            v13[v54][v69].anim.AnimationId = v70.id;
            v13[v54][v69].weight = v70.weight;
            v13[v54].count = v13[v54].count + 1;
            v13[v54].totalWeight = v13[v54].totalWeight + v70.weight;
        end;
    end;
    for _, v72 in pairs(v13) do
        for v73 = 1, v72.count do
            l_Humanoid_0:LoadAnimation(v72[v73].anim);
        end;
    end;
end;
scriptChildModified = function(v74) --[[ Line: 341 ]] --[[ Name: scriptChildModified ]]
    -- upvalues: v14 (copy)
    local v75 = v14[v74.Name];
    if v75 ~= nil then
        configureAnimationSet(v74.Name, v75);
    end;
end;
script.ChildAdded:connect(scriptChildModified);
script.ChildRemoved:connect(scriptChildModified);
local v76 = if l_Humanoid_0 then l_Humanoid_0:FindFirstChildOfClass("Animator") else nil;
if v76 then
    local l_v76_PlayingAnimationTracks_0 = v76:GetPlayingAnimationTracks();
    for _, v79 in ipairs(l_v76_PlayingAnimationTracks_0) do
        v79:Stop(0);
        v79:Destroy();
    end;
end;
for v80, v81 in pairs(v14) do
    configureAnimationSet(v80, v81);
end;
local v82 = "None";
local v83 = 0;
local v84 = 0;
local v85 = false;
stopAllAnimations = function() --[[ Line: 382 ]] --[[ Name: stopAllAnimations ]]
    -- upvalues: v5 (ref), v15 (copy), v85 (ref), v6 (ref), v8 (ref), v7 (ref), v11 (ref), v10 (ref)
    local l_v5_0 = v5;
    if v15[l_v5_0] ~= nil and v15[l_v5_0] == false then
        l_v5_0 = "idle";
    end;
    if v85 then
        l_v5_0 = "idle";
        v85 = false;
    end;
    v5 = "";
    v6 = nil;
    if v8 ~= nil then
        v8:disconnect();
    end;
    if v7 ~= nil then
        v7:Stop();
        v7:Destroy();
        v7 = nil;
    end;
    if v11 ~= nil then
        v11:disconnect();
    end;
    if v10 ~= nil then
        v10:Stop();
        v10:Destroy();
        v10 = nil;
    end;
    return l_v5_0;
end;
getHeightScale = function() --[[ Line: 421 ]] --[[ Name: getHeightScale ]]
    -- upvalues: l_Humanoid_0 (copy), v3 (copy), l_ScaleDampeningPercent_0 (ref)
    if l_Humanoid_0 then
        if not l_Humanoid_0.AutomaticScalingEnabled then
            return v3();
        else
            local v87 = l_Humanoid_0.HipHeight / 2;
            if l_ScaleDampeningPercent_0 == nil then
                l_ScaleDampeningPercent_0 = script:FindFirstChild("ScaleDampeningPercent");
            end;
            if l_ScaleDampeningPercent_0 ~= nil then
                v87 = 1 + (l_Humanoid_0.HipHeight - 2) * l_ScaleDampeningPercent_0.Value / 2;
            end;
            return v87;
        end;
    else
        return v3();
    end;
end;
local function _(v88) --[[ Line: 441 ]] --[[ Name: rootMotionCompensation ]]
    return v88 * 1.25 / getHeightScale();
end;
local function v96(v90) --[[ Line: 449 ]] --[[ Name: setRunSpeed ]]
    -- upvalues: v7 (ref), v10 (ref)
    local v91 = v90 * 1.25 / getHeightScale();
    local v92 = 1.0E-4;
    local v93 = 1.0E-4;
    local v94 = 1;
    if v91 <= 0.5 then
        v92 = 1;
        v94 = v91 / 0.5;
    elseif v91 < 1 then
        local v95 = (v91 - 0.5) / 0.5;
        v92 = 1 - v95;
        v93 = v95;
    else
        v94 = v91 / 1;
        v93 = 1;
    end;
    v7:AdjustWeight(v92);
    v10:AdjustWeight(v93);
    v7:AdjustSpeed(v94);
    v10:AdjustSpeed(v94);
end;
setAnimationSpeed = function(v97) --[[ Line: 475 ]] --[[ Name: setAnimationSpeed ]]
    -- upvalues: v5 (ref), v96 (copy), v9 (ref), v7 (ref)
    if v5 == "walk" then
        v96(v97);
        return;
    else
        if v97 ~= v9 then
            v9 = v97;
            v7:AdjustSpeed(v9);
        end;
        return;
    end;
end;
keyFrameReachedFunc = function(v98) --[[ Line: 486 ]] --[[ Name: keyFrameReachedFunc ]]
    -- upvalues: v5 (ref), v10 (ref), v7 (ref), v15 (copy), v85 (ref), v9 (ref), l_Humanoid_0 (copy)
    if v98 == "End" then
        if v5 == "walk" then
            if v10.Looped ~= true then
                v10.TimePosition = 0;
            end;
            if v7.Looped ~= true then
                v7.TimePosition = 0;
                return;
            end;
        else
            local l_v5_1 = v5;
            if v15[l_v5_1] ~= nil and v15[l_v5_1] == false then
                l_v5_1 = "idle";
            end;
            if v85 then
                if v7.Looped then
                    return;
                else
                    l_v5_1 = "idle";
                    v85 = false;
                end;
            end;
            local l_v9_0 = v9;
            playAnimation(l_v5_1, 0.15, l_Humanoid_0);
            setAnimationSpeed(l_v9_0);
        end;
    end;
end;
rollAnimation = function(v101) --[[ Line: 519 ]] --[[ Name: rollAnimation ]]
    -- upvalues: v13 (copy)
    local v102 = math.random(1, v13[v101].totalWeight);
    local _ = v102;
    local v104 = 1;
    while v13[v101][v104].weight < v102 do
        v102 = v102 - v13[v101][v104].weight;
        v104 = v104 + 1;
    end;
    return v104;
end;
local function v110(v105, v106, v107, v108) --[[ Line: 530 ]] --[[ Name: switchToAnim ]]
    -- upvalues: v6 (ref), v7 (ref), v10 (ref), v9 (ref), v5 (ref), v8 (ref), v13 (copy), v11 (ref)
    if v105 ~= v6 then
        if v7 ~= nil then
            v7:Stop(v107);
            v7:Destroy();
        end;
        if v10 ~= nil then
            v10:Stop(v107);
            v10:Destroy();
            v10 = nil;
        end;
        v9 = 1;
        v7 = v108:LoadAnimation(v105);
        v7.Priority = Enum.AnimationPriority.Core;
        v7:Play(v107);
        v5 = v106;
        v6 = v105;
        if v8 ~= nil then
            v8:disconnect();
        end;
        v8 = v7.KeyframeReached:connect(keyFrameReachedFunc);
        if v106 == "walk" then
            local v109 = rollAnimation("run");
            v10 = v108:LoadAnimation(v13.run[v109].anim);
            v10.Priority = Enum.AnimationPriority.Core;
            v10:Play(v107);
            if v11 ~= nil then
                v11:disconnect();
            end;
            v11 = v10.KeyframeReached:connect(keyFrameReachedFunc);
        end;
    end;
end;
playAnimation = function(v111, v112, v113) --[[ Line: 579 ]] --[[ Name: playAnimation ]]
    -- upvalues: v13 (copy), v110 (copy), v85 (ref)
    local v114 = rollAnimation(v111);
    local l_anim_0 = v13[v111][v114].anim;
    v110(l_anim_0, v111, v112, v113);
    v85 = false;
end;
playEmote = function(v116, v117, v118) --[[ Line: 587 ]] --[[ Name: playEmote ]]
    -- upvalues: v110 (copy), v85 (ref)
    v110(v116, v116.Name, v117, v118);
    v85 = true;
end;
local v119 = "";
local v120 = nil;
local v121 = nil;
local v122 = nil;
toolKeyFrameReachedFunc = function(v123) --[[ Line: 600 ]] --[[ Name: toolKeyFrameReachedFunc ]]
    -- upvalues: v119 (ref), l_Humanoid_0 (copy)
    if v123 == "End" then
        playToolAnimation(v119, 0, l_Humanoid_0);
    end;
end;
playToolAnimation = function(v124, v125, v126, v127) --[[ Line: 607 ]] --[[ Name: playToolAnimation ]]
    -- upvalues: v13 (copy), v121 (ref), v120 (ref), v119 (ref), v122 (ref)
    local v128 = rollAnimation(v124);
    local l_anim_1 = v13[v124][v128].anim;
    if v121 ~= l_anim_1 then
        if v120 ~= nil then
            v120:Stop();
            v120:Destroy();
            v125 = 0;
        end;
        v120 = v126:LoadAnimation(l_anim_1);
        if v127 then
            v120.Priority = v127;
        end;
        v120:Play(v125);
        v119 = v124;
        v121 = l_anim_1;
        v122 = v120.KeyframeReached:connect(toolKeyFrameReachedFunc);
    end;
end;
stopToolAnimations = function() --[[ Line: 634 ]] --[[ Name: stopToolAnimations ]]
    -- upvalues: v119 (ref), v122 (ref), v121 (ref), v120 (ref)
    local l_v119_0 = v119;
    if v122 ~= nil then
        v122:disconnect();
    end;
    v119 = "";
    v121 = nil;
    if v120 ~= nil then
        v120:Stop();
        v120:Destroy();
        v120 = nil;
    end;
    return l_v119_0;
end;
onRunning = function(v131) --[[ Line: 656 ]] --[[ Name: onRunning ]]
    -- upvalues: v19 (ref), l_Humanoid_0 (copy), v20 (ref), v85 (ref), v2 (ref), v15 (copy), v5 (ref)
    local v132 = getHeightScale();
    if v19 ~= nil and l_Humanoid_0.EvaluateStateMachine == false then
        local l_RootPart_0 = l_Humanoid_0.RootPart;
        local l_SensedPart_0 = v19.SensedPart;
        if l_SensedPart_0 then
            local l_l_SensedPart_0_VelocityAtPosition_0 = l_SensedPart_0:GetVelocityAtPosition(v19.HitFrame.Position);
            local l_AssemblyLinearVelocity_0 = l_RootPart_0.AssemblyLinearVelocity;
            local l_Magnitude_0 = Vector3.new(l_AssemblyLinearVelocity_0.X - l_l_SensedPart_0_VelocityAtPosition_0.X, 0, l_AssemblyLinearVelocity_0.Z - l_l_SensedPart_0_VelocityAtPosition_0.Z).Magnitude;
            local l_Magnitude_1 = v20.MovingDirection.Magnitude;
            if l_Magnitude_1 < 0.1 then
                l_Magnitude_0 = 0;
                l_Magnitude_1 = 0;
            elseif l_Magnitude_1 > 1 then
                l_Magnitude_1 = 1;
            end;
            v131 = l_Magnitude_0 * l_Magnitude_1;
        end;
    end;
    if (v85 and l_Humanoid_0.MoveDirection == Vector3.new(0, 0, 0, 0) and l_Humanoid_0.WalkSpeed / v132 or 0.75) * v132 < v131 then
        playAnimation("walk", 0.2, l_Humanoid_0);
        setAnimationSpeed(v131 / 16);
        v2 = "Running";
        return;
    else
        if v15[v5] == nil and not v85 then
            playAnimation("idle", 0.2, l_Humanoid_0);
            v2 = "Standing";
        end;
        return;
    end;
end;
onDied = function() --[[ Line: 699 ]] --[[ Name: onDied ]]
    -- upvalues: v2 (ref)
    v2 = "Dead";
end;
onJumping = function() --[[ Line: 703 ]] --[[ Name: onJumping ]]
    -- upvalues: l_Humanoid_0 (copy), v84 (ref), v2 (ref)
    playAnimation("jump", 0.1, l_Humanoid_0);
    v84 = 0.31;
    v2 = "Jumping";
end;
onClimbing = function(v139) --[[ Line: 709 ]] --[[ Name: onClimbing ]]
    -- upvalues: l_Humanoid_0 (copy), v2 (ref)
    v139 = v139 / getHeightScale();
    playAnimation("climb", 0.1, l_Humanoid_0);
    setAnimationSpeed(v139 / 5);
    v2 = "Climbing";
end;
onGettingUp = function() --[[ Line: 717 ]] --[[ Name: onGettingUp ]]
    -- upvalues: v2 (ref)
    v2 = "GettingUp";
end;
onFreeFall = function() --[[ Line: 721 ]] --[[ Name: onFreeFall ]]
    -- upvalues: v84 (ref), l_Humanoid_0 (copy), v2 (ref)
    if v84 <= 0 then
        playAnimation("fall", 0.2, l_Humanoid_0);
    end;
    v2 = "FreeFall";
end;
onFallingDown = function() --[[ Line: 728 ]] --[[ Name: onFallingDown ]]
    -- upvalues: v2 (ref)
    v2 = "FallingDown";
end;
onSeated = function() --[[ Line: 732 ]] --[[ Name: onSeated ]]
    -- upvalues: v2 (ref)
    v2 = "Seated";
end;
onPlatformStanding = function() --[[ Line: 736 ]] --[[ Name: onPlatformStanding ]]
    -- upvalues: v2 (ref)
    v2 = "PlatformStanding";
end;
onSwimming = function(v140) --[[ Line: 743 ]] --[[ Name: onSwimming ]]
    -- upvalues: l_Humanoid_0 (copy), v2 (ref)
    v140 = v140 / getHeightScale();
    if v140 > 1 then
        playAnimation("swim", 0.4, l_Humanoid_0);
        setAnimationSpeed(v140 / 10);
        v2 = "Swimming";
        return;
    else
        playAnimation("swimidle", 0.4, l_Humanoid_0);
        v2 = "Standing";
        return;
    end;
end;
animateTool = function() --[[ Line: 756 ]] --[[ Name: animateTool ]]
    -- upvalues: v82 (ref), l_Humanoid_0 (copy)
    if v82 == "None" then
        playToolAnimation("toolnone", 0.1, l_Humanoid_0, Enum.AnimationPriority.Idle);
        return;
    elseif v82 == "Slash" then
        playToolAnimation("toolslash", 0, l_Humanoid_0, Enum.AnimationPriority.Action);
        return;
    elseif v82 == "Lunge" then
        playToolAnimation("toollunge", 0, l_Humanoid_0, Enum.AnimationPriority.Action);
        return;
    else
        return;
    end;
end;
getToolAnim = function(v141) --[[ Line: 773 ]] --[[ Name: getToolAnim ]]
    for _, v143 in ipairs(v141:GetChildren()) do
        if v143.Name == "toolanim" and v143.className == "StringValue" then
            return v143;
        end;
    end;
    return nil;
end;
local v144 = 0;
stepAnimate = function(v145) --[[ Line: 784 ]] --[[ Name: stepAnimate ]]
    -- upvalues: v144 (ref), v84 (ref), v2 (ref), l_Humanoid_0 (copy), l_Parent_0 (copy), v82 (ref), v83 (ref), v121 (ref)
    local v146 = 1;
    local v147 = 1;
    local v148 = v145 - v144;
    v144 = v145;
    local v149 = false;
    if v84 > 0 then
        v84 = v84 - v148;
    end;
    if v2 == "FreeFall" and v84 <= 0 then
        playAnimation("fall", 0.2, l_Humanoid_0);
    elseif v2 == "Seated" then
        playAnimation("sit", 0.5, l_Humanoid_0);
        return;
    elseif v2 == "Running" then
        playAnimation("walk", 0.2, l_Humanoid_0);
    elseif v2 == "Dead" or v2 == "GettingUp" or v2 == "FallingDown" or v2 == "Seated" or v2 == "PlatformStanding" then
        stopAllAnimations();
        v146 = 0.1;
        v147 = 1;
        v149 = true;
    end;
    local l_Tool_0 = l_Parent_0:FindFirstChildOfClass("Tool");
    if l_Tool_0 and l_Tool_0:FindFirstChild("Handle") then
        local v151 = getToolAnim(l_Tool_0);
        if v151 then
            v82 = v151.Value;
            v151.Parent = nil;
            v83 = v145 + 0.3;
        end;
        if v83 < v145 then
            v83 = 0;
            v82 = "None";
        end;
        animateTool();
        return;
    else
        stopToolAnimations();
        v82 = "None";
        v121 = nil;
        v83 = 0;
        return;
    end;
end;
l_Humanoid_0.Died:connect(onDied);
l_Humanoid_0.Running:connect(onRunning);
l_Humanoid_0.Jumping:connect(onJumping);
l_Humanoid_0.Climbing:connect(onClimbing);
l_Humanoid_0.GettingUp:connect(onGettingUp);
l_Humanoid_0.FreeFalling:connect(onFreeFall);
l_Humanoid_0.FallingDown:connect(onFallingDown);
l_Humanoid_0.Seated:connect(onSeated);
l_Humanoid_0.PlatformStanding:connect(onPlatformStanding);
l_Humanoid_0.Swimming:connect(onSwimming);
game:GetService("Players").LocalPlayer.Chatted:connect(function(v152) --[[ Line: 850 ]]
    -- upvalues: v2 (ref), v15 (copy), l_Humanoid_0 (copy)
    local v153 = "";
    if string.sub(v152, 1, 3) == "/e " then
        v153 = string.sub(v152, 4);
    elseif string.sub(v152, 1, 7) == "/emote " then
        v153 = string.sub(v152, 8);
    end;
    if v2 == "Standing" and v15[v153] ~= nil then
        playAnimation(v153, 0.1, l_Humanoid_0);
    end;
end);
script:WaitForChild("PlayEmote").OnInvoke = function(v154) --[[ Line: 864 ]]
    -- upvalues: v2 (ref), v15 (copy), l_Humanoid_0 (copy), v7 (ref)
    if v2 ~= "Standing" then
        return;
    elseif v15[v154] ~= nil then
        playAnimation(v154, 0.1, l_Humanoid_0);
        return true, v7;
    elseif typeof(v154) == "Instance" and v154:IsA("Animation") then
        playEmote(v154, 0.1, l_Humanoid_0);
        return true, v7;
    else
        return false;
    end;
end;
if l_Parent_0.Parent ~= nil then
    playAnimation("idle", 0.1, l_Humanoid_0);
    v2 = "Standing";
end;
while l_Parent_0.Parent ~= nil do
    local _, v156 = wait(0.1);
    stepAnimate(v156);
end;