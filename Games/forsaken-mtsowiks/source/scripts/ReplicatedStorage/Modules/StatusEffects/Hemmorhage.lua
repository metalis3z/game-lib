-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Hemmorhage, time of decompilation: Fri Nov 28 21:06:19 2025 ]]
local l_RunService_0 = game:GetService("RunService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("CollectionService");
local l_TweenService_0 = game:GetService("TweenService");
local v4 = require(l_ReplicatedStorage_0.Modules.Util);
local v5 = require(l_ReplicatedStorage_0.Modules.Sounds);
local v6 = require(l_ReplicatedStorage_0.Modules.Network);
local v7 = require(l_ReplicatedStorage_0.Modules.Actors);
local v8 = l_RunService_0:IsServer();
local v9 = l_RunService_0:IsClient();
local v10 = {
    Order = 5, 
    AbilityName = nil, 
    RequestTitle = "Request Healing", 
    NotificationTitle = "PLAYERNAME is bleeding and wants help!"
};
local v11 = {
    SoundId = "rbxassetid://7740696902"
};
local v12 = {
    SoundId = "rbxassetid://1489909826", 
    Looped = true
};
local v13 = {
    Healer = "rbxassetid://97832238877763", 
    Victim = "rbxassetid://101393913463399"
};
local function v19(v14, v15, v16) --[[ Line: 31 ]] --[[ Name: updateBar ]]
    -- upvalues: l_TweenService_0 (copy)
    local v17 = math.clamp(v15, 0, v16) / v16;
    local v18 = v17 == 0 and 0 or 1 / v17;
    l_TweenService_0:Create(v14.Clipping, TweenInfo.new(0.15), {
        Size = UDim2.fromScale(v17, 1)
    }):Play();
    l_TweenService_0:Create(v14.Clipping.Top, TweenInfo.new(0.15), {
        Size = UDim2.fromScale(v18, 1)
    }):Play();
end;
local _ = function(v20) --[[ Line: 42 ]] --[[ Name: hasTruthy ]]
    if not v20 then
        return false;
    else
        for _, v22 in pairs(v20) do
            if v22 then
                return true;
            end;
        end;
        return false;
    end;
end;
return {
    Data = {
        Duration = 1e999, 
        MaxLevel = 3, 
        Description = "Slowly makes health unhealable.\nEffect can only be reversed by teammates.\nStacks will increase rate of effect."
    }, 
    Applied = function(v24) --[[ Line: 62 ]] --[[ Name: Applied ]]
        -- upvalues: v7 (copy), v8 (copy), l_ReplicatedStorage_0 (copy), v4 (copy), v6 (copy), v5 (copy), v12 (copy), l_RunService_0 (copy), v10 (copy), v9 (copy)
        local l_Player_0 = v24.Player;
        local v26 = if v24.Player:IsA("Model") then v24.Player else l_Player_0 and l_Player_0.Character;
        local v27 = if v24.Player:IsA("Player") then v7.CurrentActors[l_Player_0] else nil;
        v24.ConnectionName = ("%*HemmorhageRequest"):format(if l_Player_0 then l_Player_0.Name else "Unknown");
        if v8 then
            if v24.Activated2 then
                v26:SetAttribute("HemmorhageProgress", 0);
                return;
            else
                local v28 = require(l_ReplicatedStorage_0.Modules.Statuses);
                local _ = v24.Data.Killer;
                v26:SetAttribute("HemmorhageDecay", nil);
                v26:SetAttribute("HemmorhageProgress", 0);
                if v26.PrimaryPart and v26.PrimaryPart:FindFirstChild("HemmorhagePrompt") then
                    return;
                else
                    v24.Particles = {};
                    local v30 = v26:FindFirstChild("Torso") or v26.PrimaryPart;
                    for _, v32 in pairs(script.Particles:GetChildren()) do
                        local v33 = v32:Clone();
                        v33.Enabled = true;
                        v33.Parent = v30;
                        table.insert(v24.Particles, v33);
                    end;
                    local v34 = {};
                    v24.Healed = false;
                    v24.Healing = false;
                    do
                        local l_v34_0 = v34;
                        local function v78(v36) --[[ Line: 97 ]] --[[ Name: attemptHeal ]]
                            -- upvalues: l_Player_0 (copy), v24 (copy), v28 (copy), v26 (copy), v4 (ref), l_v34_0 (ref), v6 (ref), v5 (ref), v12 (ref), l_RunService_0 (ref), v7 (ref)
                            local v37 = false;
                            local v38 = false;
                            local v39 = false;
                            local v40 = false;
                            if not l_Player_0 or not l_Player_0:IsA("Player") then
                                v24.Healed = true;
                                v28:RemoveStatus(v26, "Hemmorhage");
                                return "this person wasn't a player so we've just gone ahead and removed it automatically ok yeah";
                            elseif not v24 or v24.Healed or v24.Healing then
                                return "Error";
                            elseif v36 == l_Player_0 then
                                return "You can't heal yourself.";
                            elseif not v4:IsAlive(v36.Character) or not v36.Character:IsDescendantOf(workspace.Players.Survivors) then
                                return "You're dead bruh";
                            elseif os.clock() - (l_v34_0[v36] or 0) > 15 then
                                return "They haven't asked you yet.";
                            elseif v24.Healed then
                                return "They are fully healed already.";
                            elseif v24.Healing then
                                return "They are already being healed.";
                            else
                                local l_v26_0 = v26;
                                local l_Humanoid_0 = l_v26_0:FindFirstChild("Humanoid");
                                local l_v4_Actor_0 = v4:GetActor(l_v26_0);
                                local l_l_Player_0_0 = l_Player_0;
                                local l_Character_0 = v36.Character;
                                local l_Humanoid_1 = l_Character_0:FindFirstChild("Humanoid");
                                local l_v4_Actor_1 = v4:GetActor(l_Character_0);
                                local l_PlayerFromCharacter_0 = game.Players:GetPlayerFromCharacter(l_Character_0);
                                local function _() --[[ Line: 138 ]] --[[ Name: getDistance ]]
                                    -- upvalues: l_v4_Actor_0 (copy), l_v4_Actor_1 (copy)
                                    if not l_v4_Actor_0 or not l_v4_Actor_1 or not l_v4_Actor_0.GetPivot or not l_v4_Actor_1.GetPivot then
                                        return 999;
                                    else
                                        return (l_v4_Actor_1:GetPivot().Position - l_v4_Actor_0:GetPivot().Position).Magnitude;
                                    end;
                                end;
                                if not l_Humanoid_0 or not l_Humanoid_1 then
                                    return "This guy is dead.";
                                elseif not l_v4_Actor_0 or not l_v4_Actor_1 then
                                    return "This person doesn't know what he's doing.";
                                elseif (if l_v4_Actor_0 and l_v4_Actor_1 and l_v4_Actor_0.GetPivot and l_v4_Actor_1.GetPivot then (l_v4_Actor_1:GetPivot().Position - l_v4_Actor_0:GetPivot().Position).Magnitude else 999) > 9 then
                                    return "Get closer.";
                                else
                                    if not l_v4_Actor_0.AbilitiesDisabled then
                                        local l_DisabledAbilities_0 = l_v4_Actor_0.DisabledAbilities;
                                        local v51;
                                        if not l_DisabledAbilities_0 then
                                            v51 = false;
                                        else
                                            for _, v53 in pairs(l_DisabledAbilities_0) do
                                                if v53 then
                                                    v51 = true;
                                                    v37 = true;
                                                end;
                                                if v37 then
                                                    break;
                                                end;
                                            end;
                                            if not v37 then
                                                v51 = false;
                                            end;
                                        end;
                                        v37 = false;
                                        if not v51 then
                                            l_DisabledAbilities_0 = l_v4_Actor_0.AbilityDisablers;
                                            if not l_DisabledAbilities_0 then
                                                v51 = false;
                                            else
                                                for _, v55 in pairs(l_DisabledAbilities_0) do
                                                    if v55 then
                                                        v51 = true;
                                                        v38 = true;
                                                    end;
                                                    if v38 then
                                                        break;
                                                    end;
                                                end;
                                                if not v38 then
                                                    v51 = false;
                                                end;
                                            end;
                                            v38 = false;
                                            if not v51 and not l_v26_0.PrimaryPart.Anchored then
                                                if not l_v4_Actor_1.AbilitiesDisabled then
                                                    l_DisabledAbilities_0 = l_v4_Actor_1.DisabledAbilities;
                                                    if not l_DisabledAbilities_0 then
                                                        v51 = false;
                                                    else
                                                        for _, v57 in pairs(l_DisabledAbilities_0) do
                                                            if v57 then
                                                                v51 = true;
                                                                v39 = true;
                                                            end;
                                                            if v39 then
                                                                break;
                                                            end;
                                                        end;
                                                        if not v39 then
                                                            v51 = false;
                                                        end;
                                                    end;
                                                    v39 = false;
                                                    if not v51 then
                                                        l_DisabledAbilities_0 = l_v4_Actor_1.AbilityDisablers;
                                                        if not l_DisabledAbilities_0 then
                                                            v51 = false;
                                                        else
                                                            for _, v59 in pairs(l_DisabledAbilities_0) do
                                                                if v59 then
                                                                    v51 = true;
                                                                    v40 = true;
                                                                end;
                                                                if v40 then
                                                                    break;
                                                                end;
                                                            end;
                                                            if not v40 then
                                                                v51 = false;
                                                            end;
                                                        end;
                                                        v40 = false;
                                                        if not v51 and not l_Character_0.PrimaryPart.Anchored then
                                                            v51 = CFrame.new(0, 0, -3) * CFrame.Angles(0, 3.141592653589793, 0);
                                                            l_DisabledAbilities_0 = l_v4_Actor_1:GetPivot();
                                                            local l_l_v4_Actor_0_Pivot_0 = l_v4_Actor_0:GetPivot();
                                                            local v61 = CFrame.new(l_DisabledAbilities_0.Position, (Vector3.new(l_l_v4_Actor_0_Pivot_0.Position.X, l_DisabledAbilities_0.Y, l_l_v4_Actor_0_Pivot_0.Position.Z)));
                                                            if v61 ~= v61 then
                                                                return "Something went wrong.";
                                                            else
                                                                local v62 = RaycastParams.new();
                                                                v62.CollisionGroup = "Survivors";
                                                                v62.RespectCanCollide = true;
                                                                v62.FilterType = Enum.RaycastFilterType.Exclude;
                                                                v62.FilterDescendantsInstances = {
                                                                    workspace.Players
                                                                };
                                                                if workspace:Spherecast(l_DisabledAbilities_0.Position, 2, (v61 * v51).Position - l_DisabledAbilities_0.Position, v62) then
                                                                    return "There is something in the way.";
                                                                elseif not workspace:Raycast((v61 * v51).Position, Vector3.new(0, -5, 0, 0), v62) then
                                                                    return "They will fall. Move to flat ground.";
                                                                else
                                                                    v6:FireAllClientConnection("ShowHemmorhagePrompt", "REMOTE_EVENT", false, v26, v24.ConnectionName);
                                                                    task.spawn(function() --[[ Line: 194 ]]
                                                                        -- upvalues: v4 (ref), l_v26_0 (copy), l_Character_0 (copy), l_v4_Actor_0 (copy), v61 (copy), v51 (copy), l_v4_Actor_1 (copy), l_v34_0 (ref), v24 (ref), v26 (ref), l_l_Player_0_0 (copy), v5 (ref), v12 (ref), l_Humanoid_0 (copy), l_Humanoid_1 (copy), v6 (ref), l_PlayerFromCharacter_0 (copy), l_RunService_0 (ref), v7 (ref), v28 (ref), l_Player_0 (ref)
                                                                        v4:ToggleAnchored(l_v26_0, "Hemmorhage", true);
                                                                        v4:ToggleAnchored(l_Character_0, "Hemmorhage", true);
                                                                        l_v4_Actor_0:PivotTo(v61 * v51);
                                                                        l_v4_Actor_1:PivotTo(v61);
                                                                        l_v4_Actor_0:DisableAbilities("HealedHemmorhage", true);
                                                                        l_v4_Actor_1:DisableAbilities("HealingHemmorhage", true);
                                                                        l_v34_0 = {};
                                                                        v24.HealingConnections = {};
                                                                        v24.Healing = true;
                                                                        local v63 = true;
                                                                        local _ = os.clock;
                                                                        local l_v26_Attribute_0 = v26:GetAttribute("HemmorhageProgress");
                                                                        local v66 = 0;
                                                                        local v67 = ("%*HemmorhageCancel"):format(l_l_Player_0_0.Name);
                                                                        local v68 = v5:Play(v12, {
                                                                            Parent = l_v26_0.PrimaryPart
                                                                        });
                                                                        local l_Health_0 = l_Humanoid_0.Health;
                                                                        v24.HealingConnections.HealthChangedVictim = l_Humanoid_0.HealthChanged:Connect(function(v70) --[[ Line: 217 ]]
                                                                            -- upvalues: l_Health_0 (ref), v63 (ref)
                                                                            if v70 < l_Health_0 then
                                                                                v63 = false;
                                                                            end;
                                                                            l_Health_0 = v70;
                                                                        end);
                                                                        local l_Health_1 = l_Humanoid_1.Health;
                                                                        v24.HealingConnections.HealthChangedVictim = l_Humanoid_1.HealthChanged:Connect(function(v72) --[[ Line: 225 ]]
                                                                            -- upvalues: l_Health_1 (ref), v63 (ref)
                                                                            if v72 < l_Health_1 then
                                                                                v63 = false;
                                                                            end;
                                                                            l_Health_1 = v72;
                                                                        end);
                                                                        v6:SetConnection(v67, "REMOTE_EVENT", function(v73) --[[ Line: 232 ]]
                                                                            -- upvalues: l_l_Player_0_0 (ref), l_PlayerFromCharacter_0 (ref), v63 (ref)
                                                                            if v73 == l_l_Player_0_0 or v73 == l_PlayerFromCharacter_0 then
                                                                                v63 = false;
                                                                            end;
                                                                        end);
                                                                        v6:FireClientConnection(l_l_Player_0_0, "HemmorhageHealStart", "REMOTE_EVENT", l_l_Player_0_0, l_PlayerFromCharacter_0);
                                                                        v6:FireClientConnection(l_PlayerFromCharacter_0, "HemmorhageHealStart", "REMOTE_EVENT", l_l_Player_0_0, l_PlayerFromCharacter_0);
                                                                        while v63 and v4:IsAlive(l_v26_0) and v4:IsAlive(l_Character_0) and (if l_v4_Actor_0 and l_v4_Actor_1 and l_v4_Actor_0.GetPivot and l_v4_Actor_1.GetPivot then (l_v4_Actor_1:GetPivot().Position - l_v4_Actor_0:GetPivot().Position).Magnitude else 999) < 6 and not v24.Healed do
                                                                            local v74 = v66 * 100 / 8;
                                                                            local l_v26_Attribute_1 = v26:GetAttribute("HemmorhageProgress");
                                                                            v26:SetAttribute("HemmorhageProgress", l_v26_Attribute_1 + v74);
                                                                            v66 = l_RunService_0.PostSimulation:Wait();
                                                                            l_v26_Attribute_0 = if v24 and v26 then v26:GetAttribute("HemmorhageProgress") else 1e999;
                                                                            if not v24.Healed then
                                                                                if l_v26_Attribute_0 >= 100 then
                                                                                    v7:IncrementActorStats(l_Character_0, {
                                                                                        Action = "Healed a Hemmorhaged Survivor", 
                                                                                        Money = 10, 
                                                                                        EXP = 30
                                                                                    });
                                                                                    break;
                                                                                end;
                                                                            else
                                                                                break;
                                                                            end;
                                                                        end;
                                                                        if l_v4_Actor_0 then
                                                                            l_v4_Actor_0:DisableAbilities("HealedHemmorhage", false);
                                                                        end;
                                                                        if l_v4_Actor_1 then
                                                                            l_v4_Actor_1:DisableAbilities("HealingHemmorhage", false);
                                                                        end;
                                                                        v6:RemoveConnection(v67, "REMOTE_EVENT");
                                                                        if l_l_Player_0_0 then
                                                                            v6:FireClientConnection(l_l_Player_0_0, "HemmorhageHealStop", "REMOTE_EVENT", l_l_Player_0_0, l_PlayerFromCharacter_0);
                                                                        end;
                                                                        if l_PlayerFromCharacter_0 then
                                                                            v6:FireClientConnection(l_PlayerFromCharacter_0, "HemmorhageHealStop", "REMOTE_EVENT", l_l_Player_0_0, l_PlayerFromCharacter_0);
                                                                        end;
                                                                        if v68 then
                                                                            v68:Destroy();
                                                                        end;
                                                                        v4:RemoveStackableAttribute(l_v26_0, "Airborne", "HemmorHeal");
                                                                        v4:RemoveStackableAttribute(l_Character_0, "Airborne", "HemmorHeal");
                                                                        v4:ToggleAnchored(l_v26_0, "Hemmorhage", false);
                                                                        v4:ToggleAnchored(l_Character_0, "Hemmorhage", false);
                                                                        for _, v77 in pairs(v24.HealingConnections) do
                                                                            v77:Disconnect();
                                                                        end;
                                                                        v24.HealingConnections = nil;
                                                                        v24.Healing = false;
                                                                        if not v24.Healed and l_v26_Attribute_0 >= 100 then
                                                                            v24.Healed = true;
                                                                            v28:RemoveStatus(l_Player_0, "Hemmorhage");
                                                                            v7:CreateChatInteraction(l_l_Player_0_0, "Thanks/HemmorhageAsk", l_v4_Actor_1);
                                                                        end;
                                                                    end);
                                                                    return nil;
                                                                end;
                                                            end;
                                                        end;
                                                    end;
                                                end;
                                                return "You seem occupied with something.";
                                            end;
                                        end;
                                    end;
                                    return "They seem occupied with something.";
                                end;
                            end;
                        end;
                        v6:SetConnection(v24.ConnectionName, "REMOTE_EVENT", function(v79) --[[ Line: 307 ]]
                            -- upvalues: v78 (copy), v6 (ref)
                            local v80 = v78(v79);
                            if v80 then
                                v6:FireClientConnection(v79, "HemmorhageDisplayWarning", "REMOTE_EVENT", v80);
                            end;
                        end);
                        if v27 then
                            v27.Config.Requesting = v27.Config.Requesting or {};
                            v27.Config.Requesting.HemmorhageAsk = v4:CopyTable(v10);
                            v27.Config.Requesting.HemmorhageAsk.Callback = function(v81, v82) --[[ Line: 319 ]]
                                -- upvalues: v24 (copy), l_v34_0 (ref), v6 (ref), v26 (copy)
                                local _ = game.Players:GetPlayerFromCharacter(v81);
                                local l_PlayerFromCharacter_2 = game.Players:GetPlayerFromCharacter(v82);
                                if v24.Healing then
                                    return;
                                else
                                    l_v34_0[l_PlayerFromCharacter_2] = os.clock();
                                    v6:FireClientConnection(l_PlayerFromCharacter_2, "ShowHemmorhagePrompt", "REMOTE_EVENT", true, v26, v24.ConnectionName);
                                    return;
                                end;
                            end;
                        end;
                        for _, v86 in ipairs(game.Players:GetPlayers()) do
                            if v86 ~= l_Player_0 then
                                v6:FireClientConnection(v86, "ReplicateHemmorhageRequest", "REMOTE_EVENT", l_Player_0, true);
                            end;
                        end;
                    end;
                end;
            end;
        elseif v9 and v27 and not v24.Activated2 then
            local v87 = require(l_ReplicatedStorage_0.Systems.Character.Game.SurvivorRequests);
            if v27 then
                v27.Cache = v27.Cache or {};
                if not v27.Cache.HemmorhageTutorialNode then
                    local v88 = l_Player_0:GetAttribute("Device") == "Mobile" and "tapping" or "clicking";
                    v4:CreateWarning("HemmorhageWarn", (("You are Hemmorhaged! Use a Medkit or request another Survivor to remove it by %* on them!"):format(v88)));
                end;
                v27.Cache.HemmorhageTutorialNode = true;
            end;
            v27.Config.Requesting = v27.Config.Requesting or {};
            v27.Config.Requesting.HemmorhageAsk = v4:CopyTable(v10);
            v87:UpdateAll();
        end;
        v24.Activated2 = true;
    end, 
    Removed = function(v89) --[[ Line: 365 ]] --[[ Name: Removed ]]
        -- upvalues: v7 (copy), v8 (copy), v4 (copy), v5 (copy), v11 (copy), v6 (copy), v9 (copy), l_ReplicatedStorage_0 (copy)
        local l_Player_1 = v89.Player;
        local v91 = if v89.Player:IsA("Model") then v89.Player else l_Player_1 and l_Player_1.Character;
        local v92 = if v89.Player:IsA("Player") then v7.CurrentActors[l_Player_1] else nil;
        if v8 then
            local _ = require(game.ReplicatedStorage.Modules.Statuses);
            local v94 = v91 and v91:FindFirstChild("Humanoid");
            v89.Healed = true;
            if v89.Particles then
                for _, v96 in ipairs(v89.Particles) do
                    v96:Destroy();
                end;
            end;
            if v4:IsAlive(v91) then
                v5:Play(v11, {
                    Parent = v91.PrimaryPart
                });
            end;
            if v91 and v94 then
                local v97 = 0;
                do
                    local l_v97_0 = v97;
                    task.spawn(function() --[[ Line: 391 ]]
                        -- upvalues: v91 (copy), v4 (ref), l_v97_0 (ref), v94 (copy)
                        v91:SetAttribute("HemmorhageDecay", true);
                        while v4:IsAlive(v91) and v91:GetAttribute("HemmorhageDecay") do
                            while l_v97_0 >= 0.4 do
                                local v99 = v94:GetAttribute("HardDamage") or 0;
                                v94:SetAttribute("HardDamage", (math.max(0, v99 - 1)));
                                l_v97_0 = l_v97_0 - 0.4;
                            end;
                            if v94:GetAttribute("HardDamage") <= 0 then
                                v94:SetAttribute("HardDamage", 0);
                                break;
                            else
                                l_v97_0 = l_v97_0 + task.wait();
                            end;
                        end;
                        if v91 then
                            v91:SetAttribute("HemmorhageDecay", nil);
                        end;
                    end);
                    v91:SetAttribute("HemmorhageProgress", nil);
                end;
            end;
            v6:RemoveConnection(v89.ConnectionName, "REMOTE_EVENT");
            if v92 and v92.Config then
                v92.Config.Requesting = v92.Config.Requesting or {};
                v92.Config.Requesting.HemmorhageAsk = nil;
            end;
            for _, v101 in ipairs(game.Players:GetPlayers()) do
                if v101 ~= l_Player_1 then
                    v6:FireClientConnection(v101, "ReplicateHemmorhageRequest", "REMOTE_EVENT", l_Player_1, false);
                end;
            end;
            return;
        else
            if v9 then
                local v102 = require(l_ReplicatedStorage_0.Systems.Character.Game.SurvivorRequests);
                if v92 then
                    v92.Config.Requesting = v92.Config.Requesting or {};
                    v92.Config.Requesting.HemmorhageAsk = nil;
                    v102:UpdateAll();
                end;
            end;
            return;
        end;
    end, 
    Heartbeat = function(v103, v104) --[[ Line: 441 ]] --[[ Name: Heartbeat ]]
        -- upvalues: v8 (copy), v4 (copy)
        local l_Player_2 = v103.Player;
        local v106 = if v103.Player:IsA("Model") then v103.Player else l_Player_2 and l_Player_2.Character;
        if v8 then
            if not v103.BloodCounter then
                v103.BloodCounter = 0;
            end;
            if not v103.OrbCounter then
                v103.OrbCounter = 0;
            end;
            v103.BloodCounter = v103.BloodCounter + v104;
            local l_Humanoid_2 = v106:FindFirstChild("Humanoid");
            if not v4:IsAlive(v106) then
                v103.Healed = true;
                require(game.ReplicatedStorage.Modules.Statuses):RemoveStatus(v106, "Hemmorhage");
                return;
            else
                local l_Killer_1 = v103.Data.Killer;
                if not l_Killer_1 then
                    return;
                else
                    local l_PrimaryPart_0 = v106.PrimaryPart;
                    local v110 = l_Killer_1 and l_Killer_1.Rig and l_Killer_1.PrimaryPart;
                    local l_Magnitude_0 = vector.create(l_PrimaryPart_0.AssemblyLinearVelocity.X, 0, l_PrimaryPart_0.AssemblyLinearVelocity.Z).Magnitude;
                    if not v110 or not (l_PrimaryPart_0.Position - v110.Position).Magnitude then
                        local _ = 1e999;
                    end;
                    local v113 = l_Killer_1 and l_Killer_1.Chases and l_Killer_1.Chases[v106];
                    local v114 = (v106:GetAttribute("BaseSpeed") or 16) + 2 < l_Magnitude_0;
                    local v115 = v113 and 0.5 or v114 and 1.25 or 1;
                    v103.OrbCounter = v103.OrbCounter + v104 * v115;
                    if v103.BloodCounter >= 0.8 / (0.5 + v103.Data.Level / 2) then
                        local v116 = l_Humanoid_2:GetAttribute("HardDamage") or 0;
                        if v116 + 1 >= l_Humanoid_2.MaxHealth - 1 then
                            l_Humanoid_2:SetAttribute("HardDamage", l_Humanoid_2.MaxHealth - 1);
                        else
                            l_Humanoid_2:SetAttribute("HardDamage", v116 + 1);
                        end;
                        v103.BloodCounter = 0;
                    end;
                    if v103.OrbCounter >= 8 / (0.33 + v103.Data.Level / 3) and l_Killer_1 and l_Killer_1.Rig and l_Killer_1.Rig.PrimaryPart then
                        if l_Killer_1 and l_Killer_1.Behavior and l_Killer_1.Behavior.SpawnBloodOrb then
                            l_Killer_1.Behavior.SpawnBloodOrb(l_Killer_1, l_PrimaryPart_0.Position, v106);
                        end;
                        v103.OrbCounter = 0;
                    end;
                end;
            end;
        end;
    end, 
    Init = function(_) --[[ Line: 505 ]] --[[ Name: Init ]]
        -- upvalues: v8 (copy), v9 (copy), v6 (copy), v13 (copy), v4 (copy), l_RunService_0 (copy), v19 (copy), v7 (copy), v10 (copy)
        if v8 then
            return;
        else
            if v9 then
                local l_LocalPlayer_0 = game.Players.LocalPlayer;
                local _ = {};
                local v120 = {};
                v6:SetConnection("HemmorhageHealStart", "REMOTE_EVENT", function(v121, _) --[[ Line: 512 ]]
                    -- upvalues: l_LocalPlayer_0 (copy), v13 (ref), v4 (ref), l_RunService_0 (ref), v19 (ref), v6 (ref), v120 (copy)
                    local v123 = require(game.Players.LocalPlayer.PlayerScripts.PlayerModule.ControlModule);
                    local v124 = if v121 == l_LocalPlayer_0 then v13.Victim else v13.Healer;
                    local v125 = v4:LoadAnimationFromID(l_LocalPlayer_0.Character, v124, false);
                    local v126 = {};
                    local v127 = os.clock();
                    local v128 = false;
                    local v129 = game.ReplicatedStorage.Assets.UI.ProgressBar:Clone();
                    v129.Title.Text = "Healing";
                    v129.Parent = l_LocalPlayer_0.PlayerGui:FindFirstChild("TemporaryUI");
                    local function _() --[[ Line: 524 ]] --[[ Name: getAttribute ]]
                        -- upvalues: v121 (copy)
                        return v121 and v121.Character and v121.Character:GetAttribute("HemmorhageProgress") or 0;
                    end;
                    v125:Play();
                    table.insert(v126, l_RunService_0.PreRender:Connect(function(_) --[[ Line: 530 ]]
                        -- upvalues: v129 (copy), v19 (ref), v121 (copy), v127 (copy), v128 (ref), v123 (copy), v6 (ref)
                        if not v129 or not v129:FindFirstChild("Bar") then
                            return;
                        else
                            v19(v129.Bar, v121 and v121.Character and v121.Character:GetAttribute("HemmorhageProgress") or 0, 100);
                            if os.clock() - v127 > 0.4 and not v128 and workspace.CurrentCamera.CFrame:VectorToWorldSpace(v123:GetMoveVector()) ~= Vector3.new(0, 0, 0, 0) then
                                v128 = true;
                                v6:FireServerConnection(("%*HemmorhageCancel"):format(v121.Name), "REMOTE_EVENT");
                            end;
                            return;
                        end;
                    end));
                    v120[v121.Character] = {
                        Animation = v125, 
                        Connections = v126, 
                        UI = v129
                    };
                end);
                v6:SetConnection("HemmorhageHealStop", "REMOTE_EVENT", function(v132, _) --[[ Line: 551 ]]
                    -- upvalues: v120 (copy)
                    local v134 = v120[v132.Character];
                    if v134 then
                        v134.Animation:Stop();
                        if v134.UI then
                            v134.UI:Destroy();
                        end;
                        for _, v136 in pairs(v134.Connections) do
                            v136:Disconnect();
                        end;
                    end;
                end);
                v6:SetConnection("ReplicateHemmorhageRequest", "REMOTE_EVENT", function(v137, v138) --[[ Line: 566 ]]
                    -- upvalues: v7 (ref), v4 (ref), v10 (ref)
                    local v139 = v7.CurrentActors[v137];
                    if not v139 then
                        return;
                    elseif v138 then
                        v139.Config.Requesting = v139.Config.Requesting or {};
                        v139.Config.Requesting.HemmorhageAsk = v4:CopyTable(v10);
                        return;
                    else
                        if v139.Config.Requesting then
                            v139.Config.Requesting.HemmorhageAsk = nil;
                        end;
                        return;
                    end;
                end);
                v6:SetConnection("ShowHemmorhagePrompt", "REMOTE_EVENT", function(v140, v141, v142) --[[ Line: 577 ]]
                    -- upvalues: v4 (ref), v6 (ref)
                    if not v4:IsAlive(v141) then
                        return;
                    else
                        local l_HemmorhagePrompt_0 = v141.PrimaryPart:FindFirstChild("HemmorhagePrompt");
                        if l_HemmorhagePrompt_0 then
                            l_HemmorhagePrompt_0:Destroy();
                        end;
                        if v140 then
                            local v144 = script.Prompt:Clone();
                            v144.Parent = v141.PrimaryPart;
                            v144.Name = "HemmorhagePrompt";
                            game.Debris:AddItem(v144, 13);
                            v144.Triggered:Connect(function() --[[ Line: 592 ]]
                                -- upvalues: v6 (ref), v142 (copy)
                                v6:FireServerConnection(v142, "REMOTE_EVENT");
                            end);
                        end;
                        return;
                    end;
                end);
                v6:SetConnection("HemmorhageDisplayWarning", "REMOTE_EVENT", function(v145) --[[ Line: 597 ]]
                    -- upvalues: v4 (ref)
                    v4:CreateWarning("HemmorhageWarning", v145);
                end);
            end;
            return;
        end;
    end
};