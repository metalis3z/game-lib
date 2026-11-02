-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Parent_0 = script.Parent;
local l_Humanoid_0 = l_Parent_0:WaitForChild("Humanoid");
local v2 = "Standing";
local l_ProfileData_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"));
local l_status_0, l_result_0 = pcall(function() --[[ Line: 7 ]]
    return UserSettings():IsUserFeatureEnabled("UserNoUpdateOnLoop");
end);
local v6 = l_status_0 and l_result_0;
local l_status_1, l_result_1 = pcall(function() --[[ Line: 10 ]]
    return UserSettings():IsUserFeatureEnabled("UserAnimateScriptEmoteHook");
end);
local v9 = l_status_1 and l_result_1;
local l_ScaleDampeningPercent_0 = script:FindFirstChild("ScaleDampeningPercent");
local v11 = "";
local v12 = nil;
local v13 = nil;
local v14 = nil;
local v15 = 1;
local v16 = nil;
local v17 = nil;
local v18 = {};
local v19 = {};
local v20 = {
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
local v21 = {
    wave = false, 
    point = false, 
    dance = true, 
    dance2 = true, 
    dance3 = true, 
    laugh = false, 
    cheer = false
};
local l_Sync_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"));
for _, v24 in l_Sync_0.Emotes do
    if v24.AnimationID then
        local l_Command_0 = v24.Command;
        v20[l_Command_0] = {
            {
                id = "http://www.roblox.com/asset/?id=" .. v24.AnimationID, 
                weight = v24.Weight or 10
            }
        };
        v21[l_Command_0] = v24.Loop or false;
    end;
end;
math.randomseed(tick());
findExistingAnimationInSet = function(v26, v27) --[[ Line: 125 ]] --[[ Name: findExistingAnimationInSet ]]
    if v26 == nil or v27 == nil then
        return 0;
    else
        for v28 = 1, v26.count do
            if v26[v28].anim.AnimationId == v27.AnimationId then
                return v28;
            end;
        end;
        return 0;
    end;
end;
configureAnimationSet = function(v29, v30) --[[ Line: 139 ]] --[[ Name: configureAnimationSet ]]
    if v19[v29] ~= nil then
        for _, v32 in pairs(v19[v29].connections) do
            v32:disconnect();
        end;
    end;
    v19[v29] = {};
    v19[v29].count = 0;
    v19[v29].totalWeight = 0;
    v19[v29].connections = {};
    local v33 = true;
    local l_status_2, _ = pcall(function() --[[ Line: 152 ]]
        v33 = game:GetService("StarterPlayer").AllowCustomAnimations;
    end);
    if not l_status_2 then
        v33 = true;
    end;
    local l_script_FirstChild_0 = script:FindFirstChild(v29);
    if v33 and l_script_FirstChild_0 ~= nil then
        table.insert(v19[v29].connections, l_script_FirstChild_0.ChildAdded:connect(function(_) --[[ Line: 160 ]]
            configureAnimationSet(v29, v30);
        end));
        table.insert(v19[v29].connections, l_script_FirstChild_0.ChildRemoved:connect(function(_) --[[ Line: 161 ]]
            configureAnimationSet(v29, v30);
        end));
        local v39 = 0;
        for _, v41 in pairs(l_script_FirstChild_0:GetChildren()) do
            if v41:IsA("Animation") then
                local v42 = 1;
                local l_Weight_0 = v41:FindFirstChild("Weight");
                if l_Weight_0 ~= nil then
                    v42 = l_Weight_0.Value;
                end;
                v19[v29].count = v19[v29].count + 1;
                v39 = v19[v29].count;
                v19[v29][v39] = {};
                v19[v29][v39].anim = v41;
                v19[v29][v39].weight = v42;
                v19[v29].totalWeight = v19[v29].totalWeight + v19[v29][v39].weight;
                table.insert(v19[v29].connections, v41.Changed:connect(function(_) --[[ Line: 177 ]]
                    configureAnimationSet(v29, v30);
                end));
                table.insert(v19[v29].connections, v41.ChildAdded:connect(function(_) --[[ Line: 178 ]]
                    configureAnimationSet(v29, v30);
                end));
                table.insert(v19[v29].connections, v41.ChildRemoved:connect(function(_) --[[ Line: 179 ]]
                    configureAnimationSet(v29, v30);
                end));
            end;
        end;
    end;
    if v19[v29].count <= 0 then
        for v47, v48 in pairs(v30) do
            v19[v29][v47] = {};
            v19[v29][v47].anim = Instance.new("Animation");
            v19[v29][v47].anim.Name = v29;
            v19[v29][v47].anim.AnimationId = v48.id;
            v19[v29][v47].weight = v48.weight;
            v19[v29].count = v19[v29].count + 1;
            v19[v29].totalWeight = v19[v29].totalWeight + v48.weight;
        end;
    end;
    for _, v50 in pairs(v19) do
        for v51 = 1, v50.count do
            if v18[v50[v51].anim.AnimationId] == nil then
                l_Humanoid_0:LoadAnimation(v50[v51].anim);
                v18[v50[v51].anim.AnimationId] = true;
            end;
        end;
    end;
end;
configureAnimationSetOld = function(v52, v53) --[[ Line: 210 ]] --[[ Name: configureAnimationSetOld ]]
    if v19[v52] ~= nil then
        for _, v55 in pairs(v19[v52].connections) do
            v55:disconnect();
        end;
    end;
    v19[v52] = {};
    v19[v52].count = 0;
    v19[v52].totalWeight = 0;
    v19[v52].connections = {};
    local v56 = true;
    local l_status_3, _ = pcall(function() --[[ Line: 223 ]]
        v56 = game:GetService("StarterPlayer").AllowCustomAnimations;
    end);
    if not l_status_3 then
        v56 = true;
    end;
    local l_script_FirstChild_1 = script:FindFirstChild(v52);
    if v56 and l_script_FirstChild_1 ~= nil then
        table.insert(v19[v52].connections, l_script_FirstChild_1.ChildAdded:connect(function(_) --[[ Line: 231 ]]
            configureAnimationSet(v52, v53);
        end));
        table.insert(v19[v52].connections, l_script_FirstChild_1.ChildRemoved:connect(function(_) --[[ Line: 232 ]]
            configureAnimationSet(v52, v53);
        end));
        local v62 = 1;
        for _, v64 in pairs(l_script_FirstChild_1:GetChildren()) do
            if v64:IsA("Animation") then
                table.insert(v19[v52].connections, v64.Changed:connect(function(_) --[[ Line: 236 ]]
                    configureAnimationSet(v52, v53);
                end));
                v19[v52][v62] = {};
                v19[v52][v62].anim = v64;
                local l_Weight_1 = v64:FindFirstChild("Weight");
                if l_Weight_1 == nil then
                    v19[v52][v62].weight = 1;
                else
                    v19[v52][v62].weight = l_Weight_1.Value;
                end;
                v19[v52].count = v19[v52].count + 1;
                v19[v52].totalWeight = v19[v52].totalWeight + v19[v52][v62].weight;
                v62 = v62 + 1;
            end;
        end;
    end;
    if v19[v52].count <= 0 then
        for v67, v68 in pairs(v53) do
            v19[v52][v67] = {};
            v19[v52][v67].anim = Instance.new("Animation");
            v19[v52][v67].anim.Name = v52;
            v19[v52][v67].anim.AnimationId = v68.id;
            v19[v52][v67].weight = v68.weight;
            v19[v52].count = v19[v52].count + 1;
            v19[v52].totalWeight = v19[v52].totalWeight + v68.weight;
        end;
    end;
    for _, v70 in pairs(v19) do
        for v71 = 1, v70.count do
            l_Humanoid_0:LoadAnimation(v70[v71].anim);
        end;
    end;
end;
scriptChildModified = function(v72) --[[ Line: 275 ]] --[[ Name: scriptChildModified ]]
    local v73 = v20[v72.Name];
    if v73 ~= nil then
        configureAnimationSet(v72.Name, v73);
    end;
end;
script.ChildAdded:connect(scriptChildModified);
script.ChildRemoved:connect(scriptChildModified);
for v74, v75 in pairs(v20) do
    configureAnimationSet(v74, v75);
end;
local v76 = "None";
local v77 = 0;
local v78 = 0;
local v79 = false;
stopAllAnimations = function() --[[ Line: 306 ]] --[[ Name: stopAllAnimations ]]
    local l_v11_0 = v11;
    if v21[l_v11_0] ~= nil and v21[l_v11_0] == false then
        l_v11_0 = "idle";
    end;
    if v9 and v79 then
        l_v11_0 = "idle";
        v79 = false;
    end;
    v11 = "";
    v12 = nil;
    if v14 ~= nil then
        v14:disconnect();
    end;
    if v13 ~= nil then
        v13:Stop();
        v13:Destroy();
        v13 = nil;
    end;
    if v17 ~= nil then
        v17:disconnect();
    end;
    if v16 ~= nil then
        v16:Stop();
        v16:Destroy();
        v16 = nil;
    end;
    return l_v11_0;
end;
getHeightScale = function() --[[ Line: 345 ]] --[[ Name: getHeightScale ]]
    if l_Humanoid_0 then
        if not l_Humanoid_0.AutomaticScalingEnabled then
            return 1;
        else
            local v81 = l_Humanoid_0.HipHeight / 2;
            if l_ScaleDampeningPercent_0 == nil then
                l_ScaleDampeningPercent_0 = script:FindFirstChild("ScaleDampeningPercent");
            end;
            if l_ScaleDampeningPercent_0 ~= nil then
                v81 = 1 + (l_Humanoid_0.HipHeight - 2) * l_ScaleDampeningPercent_0.Value / 2;
            end;
            return v81;
        end;
    else
        return 1;
    end;
end;
setRunSpeed = function(v82) --[[ Line: 364 ]] --[[ Name: setRunSpeed ]]
    local v83 = v82 * 1.25 / getHeightScale();
    if v83 ~= v15 then
        if v83 < 0.33 then
            v13:AdjustWeight(1);
            v16:AdjustWeight(1.0E-4);
        elseif v83 < 0.66 then
            local v84 = (v83 - 0.33) / 0.33;
            v13:AdjustWeight(1 - v84 + 1.0E-4);
            v16:AdjustWeight(v84 + 1.0E-4);
        else
            v13:AdjustWeight(1.0E-4);
            v16:AdjustWeight(1);
        end;
        v15 = v83;
        v16:AdjustSpeed(v83);
        v13:AdjustSpeed(v83);
    end;
end;
setAnimationSpeed = function(v85) --[[ Line: 387 ]] --[[ Name: setAnimationSpeed ]]
    if v11 == "walk" then
        setRunSpeed(v85);
        return;
    else
        if v85 ~= v15 then
            v15 = v85;
            v13:AdjustSpeed(v15);
        end;
        return;
    end;
end;
keyFrameReachedFunc = function(v86) --[[ Line: 398 ]] --[[ Name: keyFrameReachedFunc ]]
    if v86 == "End" then
        if v11 == "walk" then
            if v6 == true then
                if v16.Looped ~= true then
                    v16.TimePosition = 0;
                end;
                if v13.Looped ~= true then
                    v13.TimePosition = 0;
                    return;
                end;
            else
                v16.TimePosition = 0;
                v13.TimePosition = 0;
                return;
            end;
        else
            local l_v11_1 = v11;
            if v21[l_v11_1] ~= nil and v21[l_v11_1] == false then
                l_v11_1 = "idle";
            end;
            if v9 and v79 then
                if v13.Looped then
                    return;
                else
                    l_v11_1 = "idle";
                    v79 = false;
                end;
            end;
            local l_v15_0 = v15;
            playAnimation(l_v11_1, 0.15, l_Humanoid_0);
            setAnimationSpeed(l_v15_0);
        end;
    end;
end;
rollAnimation = function(v89) --[[ Line: 436 ]] --[[ Name: rollAnimation ]]
    local v90 = math.random(1, v19[v89].totalWeight);
    local _ = v90;
    local v92 = 1;
    while v19[v89][v92].weight < v90 do
        v90 = v90 - v19[v89][v92].weight;
        v92 = v92 + 1;
    end;
    return v92;
end;
local function v98(v93, v94, v95, v96) --[[ Line: 447 ]] --[[ Name: switchToAnim ]]
    if v93 ~= v12 then
        if v13 ~= nil then
            v13:Stop(v95);
            v13:Destroy();
        end;
        if v16 ~= nil then
            v16:Stop(v95);
            v16:Destroy();
            if v6 == true then
                v16 = nil;
            end;
        end;
        v15 = 1;
        v13 = v96:LoadAnimation(v93);
        v13.Priority = Enum.AnimationPriority.Core;
        v13:Play(v95);
        v11 = v94;
        v12 = v93;
        if v14 ~= nil then
            v14:disconnect();
        end;
        v14 = v13.KeyframeReached:connect(keyFrameReachedFunc);
        if v94 == "walk" then
            local v97 = rollAnimation("run");
            v16 = v96:LoadAnimation(v19.run[v97].anim);
            v16.Priority = Enum.AnimationPriority.Core;
            v16:Play(v95);
            if v17 ~= nil then
                v17:disconnect();
            end;
            v17 = v16.KeyframeReached:connect(keyFrameReachedFunc);
        end;
    end;
end;
playAnimation = function(v99, v100, v101) --[[ Line: 498 ]] --[[ Name: playAnimation ]]
    local v102 = rollAnimation(v99);
    local l_anim_0 = v19[v99][v102].anim;
    v98(l_anim_0, v99, v100, v101);
    v79 = false;
end;
playEmote = function(v104, v105, v106) --[[ Line: 506 ]] --[[ Name: playEmote ]]
    v98(v104, v104.Name, v105, v106);
    v79 = true;
end;
local v107 = "";
local v108 = nil;
local v109 = nil;
local v110 = nil;
toolKeyFrameReachedFunc = function(v111) --[[ Line: 519 ]] --[[ Name: toolKeyFrameReachedFunc ]]
    if v111 == "End" then
        playToolAnimation(v107, 0, l_Humanoid_0);
    end;
end;
local v112 = nil;
playToolAnimation = function(v113, v114, v115, v116) --[[ Line: 526 ]] --[[ Name: playToolAnimation ]]
    local v117 = rollAnimation(v113);
    local l_anim_1 = v19[v113][v117].anim;
    if v109 ~= l_anim_1 then
        if v108 ~= nil then
            v108:Stop();
            v108:Destroy();
            v114 = 0;
        end;
        v108 = v115:LoadAnimation(l_anim_1);
        if v116 then
            v108.Priority = v116;
        end;
        v108:Play(v114);
        v107 = v113;
        v109 = l_anim_1;
        v110 = v108.KeyframeReached:connect(toolKeyFrameReachedFunc);
    end;
end;
stopToolAnimations = function() --[[ Line: 553 ]] --[[ Name: stopToolAnimations ]]
    local l_v107_0 = v107;
    if v110 ~= nil then
        v110:disconnect();
    end;
    v107 = "";
    v109 = nil;
    if v108 ~= nil then
        v108:Stop();
        v108:Destroy();
        v108 = nil;
    end;
    return l_v107_0;
end;
onRunning = function(v120) --[[ Line: 575 ]] --[[ Name: onRunning ]]
    if v120 > 0.75 then
        playAnimation("walk", 0.2, l_Humanoid_0);
        setAnimationSpeed(v120 / 16);
        v2 = "Running";
        return;
    else
        if v21[v11] == nil and not v79 then
            playAnimation("idle", 0.2, l_Humanoid_0);
            v2 = "Standing";
        end;
        return;
    end;
end;
onDied = function() --[[ Line: 589 ]] --[[ Name: onDied ]]
    v2 = "Dead";
end;
onJumping = function() --[[ Line: 593 ]] --[[ Name: onJumping ]]
    playAnimation("jump", 0.1, l_Humanoid_0);
    v78 = 0.31;
    v2 = "Jumping";
end;
onClimbing = function(v121) --[[ Line: 599 ]] --[[ Name: onClimbing ]]
    playAnimation("climb", 0.1, l_Humanoid_0);
    setAnimationSpeed(v121 / 5);
    v2 = "Climbing";
end;
onGettingUp = function() --[[ Line: 606 ]] --[[ Name: onGettingUp ]]
    v2 = "GettingUp";
end;
onFreeFall = function() --[[ Line: 610 ]] --[[ Name: onFreeFall ]]
    if v78 <= 0 then
        playAnimation("fall", 0.2, l_Humanoid_0);
    end;
    v2 = "FreeFall";
end;
onFallingDown = function() --[[ Line: 617 ]] --[[ Name: onFallingDown ]]
    v2 = "FallingDown";
end;
onSeated = function() --[[ Line: 621 ]] --[[ Name: onSeated ]]
    v2 = "Seated";
end;
onPlatformStanding = function() --[[ Line: 625 ]] --[[ Name: onPlatformStanding ]]
    v2 = "PlatformStanding";
end;
onSwimming = function(v122) --[[ Line: 632 ]] --[[ Name: onSwimming ]]
    if v122 > 1 then
        playAnimation("swim", 0.4, l_Humanoid_0);
        setAnimationSpeed(v122 / 10);
        v2 = "Swimming";
        return;
    else
        playAnimation("swimidle", 0.4, l_Humanoid_0);
        v2 = "Standing";
        return;
    end;
end;
animateTool = function() --[[ Line: 644 ]] --[[ Name: animateTool ]]
    if v76 == "None" then
        playToolAnimation("toolnone", 0.1, l_Humanoid_0, Enum.AnimationPriority.Idle);
        return;
    elseif v76 == "Slash" then
        playToolAnimation("toolslash", 0, l_Humanoid_0, Enum.AnimationPriority.Action);
        return;
    elseif v76 == "Lunge" then
        playToolAnimation("toollunge", 0, l_Humanoid_0, Enum.AnimationPriority.Action);
        return;
    else
        return;
    end;
end;
getToolAnim = function(v123) --[[ Line: 661 ]] --[[ Name: getToolAnim ]]
    for _, v125 in ipairs(v123:GetChildren()) do
        if v125.Name == "toolanim" and v125.className == "StringValue" then
            return v125;
        end;
    end;
    return nil;
end;
local v126 = 0;
local v127 = nil;
stepAnimate = function(v128) --[[ Line: 674 ]] --[[ Name: stepAnimate ]]
    local v129 = 1;
    local v130 = 1;
    local v131 = v128 - v126;
    v126 = v128;
    local v132 = false;
    if v78 > 0 then
        v78 = v78 - v131;
    end;
    if v2 == "FreeFall" and v78 <= 0 then
        playAnimation("fall", 0.2, l_Humanoid_0);
    elseif v2 == "Seated" then
        playAnimation("sit", 0.5, l_Humanoid_0);
        return;
    elseif v2 == "Running" then
        playAnimation("walk", 0.2, l_Humanoid_0);
    elseif v2 == "Dead" or v2 == "GettingUp" or v2 == "FallingDown" or v2 == "Seated" or v2 == "PlatformStanding" then
        stopAllAnimations();
        v129 = 0.1;
        v130 = 1;
        v132 = true;
    end;
    local l_Tool_0 = l_Parent_0:FindFirstChildOfClass("Tool");
    v112 = l_Parent_0:FindFirstChild("ToolAnimOverride");
    local l_AnimationId_0 = script.toolnone.ToolNoneAnim.AnimationId;
    if l_AnimationId_0 ~= v127 and l_Tool_0 or v112 then
        v76 = "None";
        v109 = nil;
        v77 = 0;
    end;
    if l_Tool_0 and l_Tool_0:FindFirstChild("Handle") then
        local v135 = getToolAnim(l_Tool_0);
        if v135 then
            v76 = v135.Value;
            v135.Parent = nil;
            v77 = v128 + 0.3;
        end;
        if v77 < v128 then
            v77 = 0;
            v76 = "None";
        end;
        animateTool();
    else
        stopToolAnimations();
        v76 = "None";
        v109 = nil;
        v77 = 0;
    end;
    v127 = l_AnimationId_0;
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
local _ = function(v136) --[[ Line: 754 ]]
    for _, v138 in pairs(l_ProfileData_0.Emotes.Owned) do
        if v138 == v136 then
            return true;
        end;
    end;
    return false;
end;
game:GetService("Players").LocalPlayer.Chatted:connect(function(v140) --[[ Line: 761 ]]
    local v141 = false;
    local v142 = false;
    local v143 = false;
    local v144 = "";
    if string.sub(v140, 1, 3) == "/e " then
        v144 = string.sub(v140, 4);
    elseif string.sub(v140, 1, 7) == "/emote " then
        v144 = string.sub(v140, 8);
    end;
    if l_Sync_0.Emotes[v144] then
        local l_v144_0 = v144;
        local v146;
        for _, v148 in pairs(l_ProfileData_0.Emotes.Owned) do
            if v148 == l_v144_0 then
                v146 = true;
                v143 = true;
            end;
            if v143 then
                break;
            end;
        end;
        if not v143 then
            v146 = false;
        end;
        v143 = false;
        v142 = v146;
    end;
    if not v142 then
        v141 = l_Sync_0.Emotes[v144];
    end;
    if v142 or not v141 then
        v142 = false;
        if v2 == "Standing" and v21[v144] ~= nil then
            playAnimation(v144, 0.1, l_Humanoid_0);
        end;
    end;
    v141 = false;
end);
game.ReplicatedStorage.Remotes.Misc.PlayEmote.Event:Connect(function(v149) --[[ Line: 779 ]]
	local v150 = nil;
	local v151 = nil;
	if l_Sync_0.Emotes[v149] then
		v151 = l_Sync_0.Emotes[v149];
	elseif l_Sync_0.Toys[v149] then
		v151 = l_Sync_0.Toys[v149];
		v150 = true;
	end;
	if v150 then
		game.ReplicatedStorage.Remotes.Extras.ReplicateToy:InvokeServer(v149);
		task.defer(function()
			local BackpackNew = game.Players.LocalPlayer:WaitForChild("Backpack")
			local CharacterNew = game.Players.LocalPlayer.Character
			local HumanoidNew = CharacterNew and CharacterNew:FindFirstChildOfClass("Humanoid")

			if HumanoidNew then
				local ToyNew = BackpackNew:FindFirstChild(v149)
				if ToyNew then
					local OldToyNew = CharacterNew:FindFirstChildOfClass("Tool")
					if OldToyNew then
						OldToyNew.Parent = BackpackNew
						task.wait()
					end
					HumanoidNew:EquipTool(ToyNew)
				end
			end
		end)

	else
		local l_Command_1 = v151.Command;
		if v2 == "Standing" and v21[l_Command_1] ~= nil then
			playAnimation(l_Command_1, 0.1, l_Humanoid_0);
		end;
	end
end);
if v9 then
    script:WaitForChild("PlayEmote").OnInvoke = function(v157) --[[ Line: 831 ]]
        if v2 ~= "Standing" then
            return;
        elseif v21[v157] ~= nil then
            playAnimation(v157, 0.1, l_Humanoid_0);
            return true;
        elseif typeof(v157) == "Instance" and v157:IsA("Animation") then
            playEmote(v157, 0.1, l_Humanoid_0);
            return true;
        else
            return false;
        end;
    end;
end;
playAnimation("idle", 0.1, l_Humanoid_0);
v2 = "Standing";
while l_Parent_0.Parent ~= nil do
    local _, v159 = wait(0.1);
    stepAnimate(v159);
end;