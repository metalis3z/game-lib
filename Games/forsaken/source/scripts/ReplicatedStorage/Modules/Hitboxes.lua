-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = require(game.ReplicatedStorage.Modules.Util);
local v1 = require(game.ReplicatedStorage.Modules.Ragdolls);
local v2 = {};
local _ = function(v3) --[[ Line: 6 ]] --[[ Name: GetDictionaryLength ]]
    local v4 = 0;
    for _, _ in pairs(v3) do
        v4 = v4 + 1;
    end;
    return v4;
end;
v2.LineOfSight = function(_, v9, v10) --[[ Line: 36 ]] --[[ Name: LineOfSight ]]
    local v11 = require(game.ReplicatedStorage.Modules.Actors);
    local l_PlayerFromCharacter_0 = game.Players:GetPlayerFromCharacter(v9);
    local v13 = l_PlayerFromCharacter_0 and v11.CurrentActors[l_PlayerFromCharacter_0];
    local l_PlayerFromCharacter_1 = game.Players:GetPlayerFromCharacter(v10);
    if l_PlayerFromCharacter_1 then
        local _ = v11.CurrentActors[l_PlayerFromCharacter_1];
    end;
    local _ = v10:FindFirstChild("Humanoid");
    local v17 = v10:FindFirstChild("QueryHitbox") and l_PlayerFromCharacter_1 and v10:HasTag("Replicating");
    local v18 = RaycastParams.new();
    v18.FilterType = Enum.RaycastFilterType.Exclude;
    v18.FilterDescendantsInstances = {
        workspace.Players, 
        v10, 
        v9
    };
    v18.CollisionGroup = tostring(v9.PrimaryPart and v9.PrimaryPart.CollisionGroup or "Killers");
    local function v22(v19) --[[ Line: 54 ]] --[[ Name: partCanBlock ]]
        -- upvalues: v18 (copy)
        local v20 = v19:GetAttribute("Hitbox") or v19.CanCollide or v19.Transparency < 1;
        local l_Humanoid_1 = v19.Parent:FindFirstChild("Humanoid");
        if v20 and not l_Humanoid_1 then
            return true;
        else
            v18:AddToFilter(v19);
            if l_Humanoid_1 then
                v18:AddToFilter(l_Humanoid_1.Parent);
            end;
            return false;
        end;
    end;
    local v23 = nil;
    local v24 = v13 and v13:GetPivot(false).Position or v9.PrimaryPart.Position;
    for _, v26 in ipairs(v10:GetChildren()) do
        if v26:IsA("BasePart") and v26.CanQuery and not v26:GetAttribute("Hitbox") then
            local v27 = v10.PrimaryPart.CFrame:ToObjectSpace(v26.CFrame);
            local v28 = v17 and v10.QueryHitbox.CFrame:ToWorldSpace(v27).Position or v26.Position;
            local v29 = 0;
            repeat
                v23 = workspace:Raycast(v24, v28 - v24, v18);
                v29 = v29 + 1;
            until not v23 or v22(v23.Instance) or v29 > 15;
            if not v23 and v29 <= 15 then
                return true;
            end;
        end;
    end;
    return false;
end;
v2.CreateHitbox = function(_, v31, v32) --[[ Line: 94 ]] --[[ Name: CreateHitbox ]]
    -- upvalues: v2 (copy), v0 (copy), v1 (copy)
    local v33 = v31 and v31.Character;
    if not (v33 and v33.PrimaryPart) then
        return;
    else
        local v34 = require(game.ReplicatedStorage.Modules.Actors);
        local v35 = require(game.ReplicatedStorage.Modules.Network);
        local v36 = require(game.ReplicatedStorage.Modules.Sounds);
        v32 = v32 or {};
        v32 = {
            Size = v32.Size or Vector3.new(4, 7, 4, 0), 
            CFrameOffset = v32.CFrameOffset or CFrame.new(0, 0, 0), 
            CFrame = v32.CFrame or nil, 
            Damage = v32.Damage or 15, 
            Time = v32.Time or 0.125, 
            Knockback = v32.Knockback or 0, 
            HitMultiple = v32.HitMultiple or false, 
            PredictVelocity = v32.PredictVelocity == nil or v32.PredictVelocity, 
            ExecuteOnKill = v32.ExecuteOnKill or false, 
            FriendlyFire = v32.FriendlyFire or false, 
            RagdollOnHit = v32.RagdollOnHit or false, 
            Hide = v32.Hide or false, 
            DeathProfile = v32.DeathProfile or {}, 
            Shape = v32.Shape or Enum.PartType.Block, 
            Connections = v32.Connections or {}
        };
        local v37 = OverlapParams.new();
        v37.FilterType = Enum.RaycastFilterType.Exclude;
        v37.FilterDescendantsInstances = {
            v33
        };
        local v38 = {
            HumanoidsDamaged = {}, 
            Creator = v31, 
            Damage = v32.Damage, 
            IsProjectile = v32.CFrame ~= nil, 
            TimePast = 0
        };
        local function v40(v39, ...) --[[ Line: 140 ]] --[[ Name: runCallback ]]
            -- upvalues: v32 (ref)
            if v32.Connections[v39] then
                v32.Connections[v39](...);
            end;
        end;
        v38.Cancel = function(_) --[[ Line: 147 ]] --[[ Name: Cancel ]]
            -- upvalues: v38 (copy)
            v38.Cancelled = true;
        end;
        task.spawn(function() --[[ Line: 152 ]]
            -- upvalues: v31 (copy), v34 (copy), v33 (copy), v38 (copy), v32 (ref), v37 (copy), v2 (ref), v40 (copy), v35 (copy), v0 (ref), v1 (ref), v36 (copy)
            local v42 = v31 and v31:IsA("Player") and v34.CurrentActors[v31];
            while v33.Parent and v33.PrimaryPart and v38.TimePast < v32.Time and not v38.Cancelled do
                local l_HumanoidsDamaged_0 = v38.HumanoidsDamaged;
                local v44 = 0;
                for _, _ in pairs(l_HumanoidsDamaged_0) do
                    v44 = v44 + 1;
                end;
                if (v44 <= 0 or v32.HitMultiple) and not v33:GetAttribute("Stunned") then
                    local v47 = v42 and v42:GetPivot(v32.PredictVelocity and true or false) or v33.PrimaryPart.CFrame;
                    l_HumanoidsDamaged_0 = Instance.new("Part");
                    l_HumanoidsDamaged_0.Name = tostring(v31) .. "Hitbox";
                    l_HumanoidsDamaged_0.Transparency = 1;
                    l_HumanoidsDamaged_0.CanCollide = false;
                    l_HumanoidsDamaged_0.CanTouch = false;
                    l_HumanoidsDamaged_0.CanQuery = false;
                    l_HumanoidsDamaged_0.CastShadow = false;
                    l_HumanoidsDamaged_0.Anchored = true;
                    l_HumanoidsDamaged_0.Shape = v32.Shape;
                    l_HumanoidsDamaged_0.Size = typeof(v32.Size) == "function" and v32.Size() or v32.Size;
                    l_HumanoidsDamaged_0.CFrame = v32.CFrame and (typeof(v32.CFrame) == "function" and v32.CFrame() or v32.CFrame) or v47 * v32.CFrameOffset;
                    l_HumanoidsDamaged_0.Parent = workspace:FindFirstChild("Hitboxes");
                    game.Debris:AddItem(l_HumanoidsDamaged_0, 0.35);
                    if v32.Hide then
                        l_HumanoidsDamaged_0:SetAttribute("Hidden", true);
                    end;
                    if not v32.PredictVelocity or v31:IsA("Player") then

                    end;
                    v44 = workspace:GetPartsInPart(l_HumanoidsDamaged_0, v37);
                    table.sort(v44, function(v48, v49) --[[ Line: 207 ]]
                        -- upvalues: v33 (ref)
                        local l_Parent_0 = v48.Parent;
                        local l_Parent_1 = v49.Parent;
                        local v52 = l_Parent_0:GetAttribute("HitboxPriority") or 1;
                        local v53 = l_Parent_1:GetAttribute("HitboxPriority") or 1;
                        if v52 == v53 then
                            v52 = (v33.PrimaryPart.Position - v49.Position).Magnitude;
                            v53 = (v33.PrimaryPart.Position - v48.Position).Magnitude;
                        end;
                        return v53 < v52;
                    end);
                    local v54 = {};
                    for _, v56 in ipairs(v44) do
                        local l_Humanoid_2 = v56.Parent:FindFirstChildOfClass("Humanoid");
                        if l_Humanoid_2 and l_Humanoid_2.Health > 0 and not l_Humanoid_2.Parent:GetAttribute("Invincible") and (not l_Humanoid_2.Parent:HasTag("Replicating") or not game.Players:GetPlayerFromCharacter(l_Humanoid_2.Parent) or v56.Name == "QueryHitbox") and not v38.HumanoidsDamaged[l_Humanoid_2] and (workspace:GetAttribute("FriendlyFire") or v32.FriendlyFire or tostring(v56.Parent:GetAttribute("Team")) ~= tostring(v33.Parent) and tostring(v56.Parent.Parent) ~= tostring(v33.Parent)) and (not v32.Target or v32.Target == l_Humanoid_2.Parent) and (v32.CFrame or v2:LineOfSight(v33, l_Humanoid_2.Parent)) then
                            v38.HumanoidsDamaged[l_Humanoid_2] = true;
                            table.insert(v54, l_Humanoid_2);
                            if not v32.HitMultiple then
                                break;
                            end;
                        end;
                    end;
                    l_HumanoidsDamaged_0.Color = #v54 > 0 and Color3.new(0.5, 1, 0.5) or Color3.new(1, 0.25, 0.25);
                    local v58 = require(game.ReplicatedStorage.Modules.AchievementUtil);
                    for v59, v60 in pairs(v54) do
                        local l_Parent_2 = v60.Parent;
                        local v62 = l_Parent_2 and l_Parent_2:IsA("Model") and l_Parent_2.PrimaryPart;
                        local v63 = typeof(v32.Damage) == "number" and v32.Damage or v32.Damage(l_Parent_2);
                        local v64 = 0;
                        local v65 = l_Parent_2 and l_Parent_2:FindFirstChild("ResistanceMultipliers");
                        local l_pairs_0 = pairs;
                        local v67 = v65 and v65:GetChildren() or {};
                        for _, v69 in l_pairs_0(v67) do
                            v64 = v64 + v69.Value;
                        end;
                        v67 = v63 * (1 - math.min(v64 - (v33:GetAttribute("StrengthBuff") or 0), 100) / 100);
                        v58:QueryAchievement("DusekkarUbercharge", nil, {
                            RawDamage = v63, 
                            RealDamage = v67, 
                            VictimCharacter = l_Parent_2
                        });
                        if v62 then
                            l_Parent_2:SetAttribute("TimesHit", (l_Parent_2:GetAttribute("TimesHit") or 0) + 1);
                            v40("HitAbsolute", l_Parent_2, v59 == 1);
                            local v70 = v34.CurrentActors[game.Players:GetPlayerFromCharacter(l_Parent_2)];
                            if v70 and v70.Behavior and v70.Behavior.OnHit then
                                if v70.Behavior:OnHit(v70, v38, v67) ~= "Ignored" then
                                    if v38.TimePast > v32.Time then
                                        break;
                                    end;
                                else
                                    continue;
                                end;
                            end;
                            local v71 = typeof(v32.Knockback) == "number" and v32.Knockback or v32.Knockback(l_Parent_2);
                            local v72 = typeof(v71) == "Vector3" and v71 or l_HumanoidsDamaged_0.CFrame.LookVector;
                            if v71 > 0 then
                                local l_PlayerFromCharacter_2 = game.Players:GetPlayerFromCharacter(l_Parent_2);
                                local v74 = v72 * v71 * 10;
                                if l_PlayerFromCharacter_2 then
                                    v35:FireClientConnection(l_PlayerFromCharacter_2, "KB", "REMOTE_EVENT", v0:SerializeVector(v74));
                                else
                                    v62.AssemblyLinearVelocity = v74 + v62.AssemblyLinearVelocity / 2;
                                end;
                            end;
                            local v75 = v0:CopyTable(v32.DeathProfile);
                            if v71 > 0 and not v75.Velocity then
                                v75 = {
                                    Velocity = v72 * v71 * 10
                                };
                            end;
                            v1.AddProfile(l_Parent_2, v75);
                            local l_v60_Attribute_0 = v60:GetAttribute("Overheal");
                            if v60.Health > 0 and v60.Health + (l_v60_Attribute_0 or 0) - v67 <= 0 then
                                if tostring(l_Parent_2.Parent) == "Survivors" then
                                    require(game.ReplicatedStorage.Modules.Stats):UpdatePlayerStat(v31, "Kills", "Add", 1);
                                end;
                                local v77 = v34.CurrentActors[v31];
                                local v78 = v77 and v77.Config.Voicelines;
                                if v78 and not l_Parent_2:GetAttribute("ExecutionsDisabled") then
                                    local v79 = "Kill";
                                    if game["Run Service"]:IsServer() then
                                        local v80 = require(game.ServerScriptService.Server.Systems.Core.RoundManager);
                                        if v80 and v80.CurrentSession and v80.CurrentSession.LastSurvivorAlive then
                                            v79 = "LastKill";
                                        end;
                                    end;
                                    for _, v82 in ipairs({
                                        v79, 
                                        "Kill"
                                    }) do
                                        if v78[("%*%*"):format(v82, (tostring(l_Parent_2:GetAttribute("SkinName"))))] then
                                            v36:PlayVoiceline(v77, (("Kill%*"):format((tostring(l_Parent_2:GetAttribute("SkinName"))))));
                                            break;
                                        elseif v78[("%*%*"):format(v82, l_Parent_2.Name)] then
                                            v36:PlayVoiceline(v77, (("Kill%*"):format(l_Parent_2.Name)));
                                            break;
                                        elseif v78[("%*"):format(v82)] then
                                            v36:PlayVoiceline(v77, "Kill");
                                            break;
                                        end;
                                    end;
                                end;
                                local l_RoundManager_0 = game.ServerScriptService.Server.Systems.Core.RoundManager;
                                local v84 = require(l_RoundManager_0);
                                if tostring(l_Parent_2.Parent) == "Survivors" and (v84.CurrentSession and v84.CurrentSession.TimePast or game["Run Service"]:IsStudio()) then
                                    v84:AddTime(nil, v70 and v70.TimeAddMultiplier or 1, true);
                                    if v77 and v77.Behavior and v77.Behavior.OnKill then
                                        local l_v77_0 = v77 --[[ copy: 24 -> 32 ]];
                                        local l_status_0, l_result_0 = pcall(function() --[[ Line: 373 ]]
                                            -- upvalues: l_v77_0 (copy), l_Parent_2 (copy)
                                            return l_v77_0.Behavior.OnKill(l_v77_0, l_Parent_2);
                                        end);
                                        if not l_status_0 then
                                            warn((("[%*/CreateHitbox]: Failed to call .OnKill() due to: %*"):format(script, l_result_0)));
                                        end;
                                    end;
                                    v34:IncrementActorStats(v31, {
                                        Action = "Killed a Survivor", 
                                        Money = 15, 
                                        EXP = 45
                                    });
                                end;
                                if v32.ExecuteOnKill and not l_Parent_2:GetAttribute("ExecutionsDisabled") and not v77.AbilityDisablers.Execution then
                                    local v88 = v77 and (v77.Config.Animations[("Execution%*"):format(l_Parent_2.Name)] or v77.Config.Animations.Execution);
                                    if v88 and v88.KillerRig and v88.PlayerRig then
                                        task.spawn(function() --[[ Line: 395 ]]
                                            -- upvalues: l_Parent_2 (copy), v77 (copy), v0 (ref), v88 (copy), v33 (ref), v62 (copy), v60 (copy), v36 (ref)
                                            require(game.ReplicatedStorage.Modules.Statuses):RemoveStatuses(l_Parent_2, true);
                                            local v89 = v77.Cache[("Execution%*Anim"):format(l_Parent_2.Name)] or v77.Cache.ExecutionAnim;
                                            local v90 = v0:LoadAnimationFromID(l_Parent_2, v88.PlayerRig, false);
                                            if not v89 then
                                                v77.Cache.ExecutionAnim = v0:LoadAnimationFromID(v77.Rig, v88.KillerRig, false);
                                            end;
                                            local l_PrimaryPart_0 = v77.Rig.PrimaryPart;
                                            v0:GiveInvincible(v33, "Executing");
                                            v0:SetUpCutscene(v77.Rig, l_Parent_2, v88.PlayerCFrameOffset);
                                            task.delay(v89.Length + 1.5, function() --[[ Line: 418 ]]
                                                -- upvalues: v0 (ref), v33 (ref)
                                                v0:RemoveInvincible(v33, "Executing");
                                            end);
                                            v77:DisableAbilities("Execution", true);
                                            task.delay(v89.Length, function() --[[ Line: 424 ]]
                                                -- upvalues: v77 (ref), l_PrimaryPart_0 (copy), v62 (ref), v60 (ref)
                                                v77:DisableAbilities("Execution", false);
                                                l_PrimaryPart_0.Anchored = false;
                                                v62.Anchored = false;
                                                v60.Health = 0;
                                                v60:ChangeState(Enum.HumanoidStateType.Dead);
                                            end);
                                            v89:Play(0);
                                            v90:Play(0);
                                            v36:Play(v77.Config.Sounds[("Execution%*"):format(l_Parent_2.Name)] or v77.Config.Sounds.Execution, {
                                                Parent = l_PrimaryPart_0
                                            });
                                            if v77.Behavior.OnExecution then
                                                v77.Behavior:OnExecution(v77, l_Parent_2);
                                            end;
                                        end);
                                        return;
                                    end;
                                end;
                            end;
                            if v32.RagdollOnHit then
                                local v92 = typeof(v32.RagdollOnHit) == "number" and v32.RagdollOnHit or 2;
                                v1.EnableRagdoll(l_Parent_2, v92);
                            end;
                            l_Parent_2:SetAttribute("RecentAttacker", (tostring(v31)));
                            l_Parent_2:SetAttribute("RecentAttackerTime", tick());
                            if l_v60_Attribute_0 then
                                l_v60_Attribute_0 = l_v60_Attribute_0 - v67;
                                v60:SetAttribute("Overheal", l_v60_Attribute_0 > 0 and l_v60_Attribute_0 or nil);
                            else
                                v60.Health = v60.Health - v67;
                                if v60.Health <= 0 then
                                    v60:ChangeState(Enum.HumanoidStateType.Dead);
                                end;
                            end;
                            v40("Hit", l_Parent_2, v59 == 1);
                            local v93 = Vector3int16.new(v62.Position.X, v62.Position.Y, v62.Position.Z);
                            v35:FireClientConnection(v31, "Hit", "UREMOTE_EVENT", v67, v93);
                        end;
                    end;
                    local l_v38_0 = v38;
                    l_v38_0.TimePast = l_v38_0.TimePast + game["Run Service"].Heartbeat:Wait();
                else
                    break;
                end;
            end;
            v40("Ended");
        end);
        return v38;
    end;
end;
v2.Start = function(_) --[[ Line: 494 ]] --[[ Name: Start ]]
    if game["Run Service"]:IsServer() then
        local l_Folder_0 = Instance.new("Folder");
        l_Folder_0.Name = "Hitboxes";
        l_Folder_0.Parent = workspace;
    end;
end;
return v2;