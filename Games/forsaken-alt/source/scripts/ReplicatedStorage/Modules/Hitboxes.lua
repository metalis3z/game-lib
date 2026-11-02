-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local _ = function(v1) --[[ Line: 4 ]] --[[ Name: GetDictionaryLength ]]
    local v2 = 0;
    for _, _ in pairs(v1) do
        v2 = v2 + 1;
    end;
    return v2;
end;
v0.CreateHitbox = function(_, v7, v8) --[[ Line: 12 ]] --[[ Name: CreateHitbox ]]
    local v9 = v7 and v7.Character;
    local v10 = v9 and v9.PrimaryPart;
    if not v10 then
        return;
    else
        local v11 = require(game.ReplicatedStorage.Modules.Actors);
        local v12 = require(game.ReplicatedStorage.Modules.Util);
        local v13 = require(game.ReplicatedStorage.Modules.Network);
        local v14 = require(game.ReplicatedStorage.Modules.Ragdolls);
        local v15 = require(game.ReplicatedStorage.Modules.Sounds);
        v8 = v8 or {};
        v8 = {
            Size = v8.Size or Vector3.new(4, 7, 4, 0), 
            CFrameOffset = v8.CFrameOffset or CFrame.new(0, 0, 0), 
            CFrame = v8.CFrame or nil, 
            Damage = v8.Damage or 15, 
            Time = v8.Time or 0.125, 
            Knockback = v8.Knockback or 0, 
            HitMultiple = v8.HitMultiple or false, 
            PredictVelocity = v8.PredictVelocity == nil or v8.PredictVelocity, 
            ExecuteOnKill = v8.ExecuteOnKill or false, 
            FriendlyFire = v8.FriendlyFire or false, 
            RagdollOnHit = v8.RagdollOnHit or false, 
            Connections = v8.Connections or {}
        };
        local v16 = OverlapParams.new();
        v16.FilterType = Enum.RaycastFilterType.Exclude;
        v16.FilterDescendantsInstances = {
            v9
        };
        local v17 = RaycastParams.new();
        v17.FilterType = Enum.RaycastFilterType.Exclude;
        v17.FilterDescendantsInstances = {
            v9
        };
        local v18 = {
            HumanoidsDamaged = {}, 
            Creator = v7, 
            Damage = v8.Damage, 
            IsProjectile = v8.CFrame ~= nil, 
            TimePast = 0
        };
        local function v20(v19, ...) --[[ Line: 61 ]] --[[ Name: runCallback ]]
            -- upvalues: v8 (ref)
            if v8.Connections[v19] then
                v8.Connections[v19](...);
            end;
        end;
        v18.Cancel = function(_) --[[ Line: 68 ]] --[[ Name: Cancel ]]
            -- upvalues: v18 (copy)
            v18.Cancelled = true;
        end;
        task.spawn(function() --[[ Line: 73 ]]
            -- upvalues: v9 (copy), v18 (copy), v8 (ref), v7 (copy), v16 (copy), v10 (copy), v17 (copy), v11 (copy), v15 (copy), v12 (copy), v14 (copy), v20 (copy), v13 (copy)
            while v9.Parent and v9.PrimaryPart and v18.TimePast < v8.Time and not v18.Cancelled do
                local l_HumanoidsDamaged_0 = v18.HumanoidsDamaged;
                local v23 = 0;
                for _, _ in pairs(l_HumanoidsDamaged_0) do
                    v23 = v23 + 1;
                end;
                if (v23 <= 0 or v8.HitMultiple) and not v9:GetAttribute("Stunned") then
                    local l_Part_0 = Instance.new("Part");
                    l_Part_0.Name = tostring(v7) .. "Hitbox";
                    l_Part_0.Transparency = 1;
                    l_Part_0.CanCollide = false;
                    l_Part_0.CanTouch = false;
                    l_Part_0.CanQuery = false;
                    l_Part_0.Anchored = true;
                    l_Part_0.Size = v8.Size;
                    l_Part_0.CFrame = v8.CFrame and (typeof(v8.CFrame) == "function" and v8.CFrame() or v8.CFrame) or v9.PrimaryPart.CFrame * v8.CFrameOffset;
                    l_Part_0.Parent = workspace:FindFirstChild("Hitboxes");
                    task.delay(2, function() --[[ Line: 91 ]]
                        -- upvalues: l_Part_0 (copy)
                        l_Part_0:Destroy();
                    end);
                    if v8.PredictVelocity and v7:IsA("Player") then
                        v23 = 6.5 - (v7:IsA("Player") and math.clamp(10 * v7:GetNetworkPing(), 0, 3) or 0);
                        local v27 = l_Part_0.CFrame:VectorToObjectSpace(v9.PrimaryPart.AssemblyLinearVelocity) / v23;
                        l_Part_0.CFrame = l_Part_0.CFrame * CFrame.new(v27);
                    end;
                    l_HumanoidsDamaged_0 = workspace:GetPartsInPart(l_Part_0, v16);
                    table.sort(l_HumanoidsDamaged_0, function(v28, v29) --[[ Line: 107 ]]
                        local l_Parent_0 = v28.Parent;
                        local l_Parent_1 = v29.Parent;
                        return (l_Parent_0:GetAttribute("HitboxPriority") or 1) > (l_Parent_1:GetAttribute("HitboxPriority") or 1);
                    end);
                    v23 = {};
                    for _, v33 in pairs(l_HumanoidsDamaged_0) do
                        local l_Humanoid_0 = v33.Parent:FindFirstChild("Humanoid");
                        if l_Humanoid_0 and l_Humanoid_0.Health > 0 and not l_Humanoid_0.Parent:GetAttribute("Invincible") and not v18.HumanoidsDamaged[l_Humanoid_0] and (workspace:GetAttribute("FriendlyFire") or v8.FriendlyFire or tostring(v33.Parent:GetAttribute("Team")) ~= tostring(v9.Parent) and tostring(v33.Parent.Parent) ~= tostring(v9.Parent)) then
                            if not v8.CFrame then
                                local v35 = 0;
                                for _, v37 in pairs({
                                    v10.CFrame.LookVector, 
                                    CFrame.lookAt(v10.Position, v33.Position).LookVector
                                }) do
                                    local v38 = workspace:Raycast(v10.Position, v37 * l_Part_0.Size.Z, v17);
                                    local v39 = v38 and v38.Instance;
                                    if v39 and not v39.Parent:FindFirstChild("Humanoid") and v39.Transparency ~= 1 and not v39:GetAttribute("Hitbox") then
                                        v35 = v35 + 1;
                                    end;
                                end;
                                if v35 >= 2 then
                                    continue;
                                end;
                            end;
                            v18.HumanoidsDamaged[l_Humanoid_0] = true;
                            table.insert(v23, l_Humanoid_0);
                            if not v8.HitMultiple then
                                break;
                            end;
                        end;
                    end;
                    l_Part_0.Color = #v23 > 0 and Color3.new(0.5, 1, 0.5) or Color3.new(1, 0.25, 0.25);
                    for v40, v41 in pairs(v23) do
                        local l_Parent_2 = v41.Parent;
                        local v43 = l_Parent_2 and l_Parent_2:IsA("Model") and l_Parent_2.PrimaryPart;
                        local v44 = 0;
                        local v45 = l_Parent_2 and l_Parent_2:FindFirstChild("ResistanceMultipliers");
                        local l_pairs_0 = pairs;
                        local v47 = v45 and v45:GetChildren() or {};
                        for _, v49 in l_pairs_0(v47) do
                            v44 = v44 + v49.Value;
                        end;
                        v44 = v44 - (v9:GetAttribute("StrengthBuff") or 0);
                        v47 = v8.Damage * (1 - v44 / 100);
                        if v43 then
                            l_Parent_2:SetAttribute("TimesHit", (l_Parent_2:GetAttribute("TimesHit") or 0) + 1);
                            local v50 = v11.CurrentActors[game.Players:GetPlayerFromCharacter(l_Parent_2)];
                            if v50 and v50.Behavior and v50.Behavior.OnHit then
                                if v50.Behavior:OnHit(v50, v18, v47) ~= "Ignored" then
                                    if v18.TimePast >= v8.Time then
                                        break;
                                    end;
                                else
                                    continue;
                                end;
                            end;
                            local l_v41_Attribute_0 = v41:GetAttribute("Overheal");
                            if v41.Health > 0 and v41.Health + (l_v41_Attribute_0 or 0) - v47 <= 0 then
                                if tostring(l_Parent_2.Parent) == "Survivors" then
                                    require(game.ReplicatedStorage.Modules.Stats):UpdatePlayerStat(v7, "Kills", "Add", 1);
                                end;
                                local v52 = v11.CurrentActors[v7];
                                local v53 = v52 and v52.Config.Voicelines;
                                if v53 and not l_Parent_2:GetAttribute("ExecutionsDisabled") then
                                    if v53[("Kill%*"):format((tostring(l_Parent_2:GetAttribute("SkinName"))))] then
                                        v15:PlayVoiceline(v52, (("Kill%*"):format((tostring(l_Parent_2:GetAttribute("SkinName"))))));
                                    elseif v53[("Kill%*"):format(l_Parent_2.Name)] then
                                        v15:PlayVoiceline(v52, (("Kill%*"):format(l_Parent_2.Name)));
                                    elseif v53.Kill then
                                        v15:PlayVoiceline(v52, "Kill");
                                    end;
                                end;
                                local l_RoundManager_0 = game.ServerStorage.ServerSystems.RoundManager;
                                local v55 = require(l_RoundManager_0);
                                if tostring(l_Parent_2.Parent) == "Survivors" and v55.CurrentSession and v55.CurrentSession.TimePast then
                                    local l_CurrentSession_0 = v55.CurrentSession;
                                    l_CurrentSession_0.TimePast = l_CurrentSession_0.TimePast - (tonumber(v55.CurrentSession.Gamemode and v55.CurrentSession.Gamemode.TimeAddedOnKill) or 35);
                                    v11:IncrementActorStats(v7, {
                                        Action = "Killed a Survivor", 
                                        Money = 15, 
                                        EXP = 45
                                    });
                                end;
                                if v8.ExecuteOnKill and not l_Parent_2:GetAttribute("ExecutionsDisabled") then
                                    local v57 = v52 and (v52.Config.Animations[("Execution%*"):format(l_Parent_2.Name)] or v52.Config.Animations.Execution);
                                    if v57 and v57.KillerRig and v57.PlayerRig then
                                        task.spawn(function() --[[ Line: 232 ]]
                                            -- upvalues: l_Parent_2 (copy), v52 (copy), v12 (ref), v57 (copy), v43 (copy), v41 (copy), v15 (ref)
                                            require(game.ReplicatedStorage.Modules.Statuses):RemoveStatuses(l_Parent_2, true);
                                            local v58 = v52.Cache[("Execution%*Anim"):format(l_Parent_2.Name)] or v52.Cache.ExecutionAnim;
                                            local v59 = v12:LoadAnimationFromID(l_Parent_2, v57.PlayerRig, false);
                                            if not v58 then
                                                v52.Cache.ExecutionAnim = v12:LoadAnimationFromID(v52.Rig, v57.KillerRig, false);
                                            end;
                                            local l_PrimaryPart_0 = v52.Rig.PrimaryPart;
                                            local v61 = CFrame.new(l_PrimaryPart_0.Position, (Vector3.new(v43.Position.X, l_PrimaryPart_0.Position.Y, v43.Position.Z)));
                                            if v61 ~= v61 then
                                                v61 = l_PrimaryPart_0.CFrame;
                                            end;
                                            v52.Rig:SetAttribute("Invincible", true);
                                            v52.Rig:SetPrimaryPartCFrame(v61);
                                            l_Parent_2:SetPrimaryPartCFrame(l_PrimaryPart_0.CFrame * (v57.PlayerCFrameOffset or CFrame.new()));
                                            l_PrimaryPart_0.Anchored = true;
                                            v43.Anchored = true;
                                            task.delay(v58.Length, function() --[[ Line: 266 ]]
                                                -- upvalues: v52 (ref), l_PrimaryPart_0 (copy), v43 (ref), v41 (ref)
                                                v52.Rig:SetAttribute("Invincible", nil);
                                                v52:DisableAbilities("Execution", false);
                                                l_PrimaryPart_0.Anchored = false;
                                                v43.Anchored = false;
                                                v41.Health = 0;
                                            end);
                                            v52:DisableAbilities("Execution", true);
                                            v58:Play(0);
                                            v59:Play(0);
                                            v15:Play(v52.Config.Sounds[("Execution%*"):format(l_Parent_2.Name)] or v52.Config.Sounds.Execution, {
                                                Parent = l_PrimaryPart_0
                                            });
                                            if v52.Behavior.OnExecution then
                                                v52.Behavior:OnExecution(v52, l_Parent_2);
                                            end;
                                        end);
                                        return;
                                    end;
                                end;
                            end;
                            if v8.RagdollOnHit then
                                v14:Enable(l_Parent_2);
                                task.delay(2, function() --[[ Line: 295 ]]
                                    -- upvalues: v14 (ref), l_Parent_2 (copy)
                                    v14:Disable(l_Parent_2);
                                end);
                            end;
                            if v8.Knockback >= 15 then
                                v43.Velocity = l_Part_0.CFrame.LookVector * v8.Knockback * 10;
                            elseif v8.Knockback > 0 then
                                local l_BodyVelocity_0 = Instance.new("BodyVelocity");
                                l_BodyVelocity_0.MaxForce = Vector3.new(1e999, 1e999, 1e999, 0);
                                l_BodyVelocity_0.Velocity = l_Part_0.CFrame.LookVector * v8.Knockback * 10;
                                l_BodyVelocity_0.Parent = v43;
                                game.Debris:AddItem(l_BodyVelocity_0, 0.05);
                            end;
                            if l_v41_Attribute_0 then
                                l_v41_Attribute_0 = l_v41_Attribute_0 - v47;
                                v41:SetAttribute("Overheal", l_v41_Attribute_0 > 0 and l_v41_Attribute_0 or nil);
                            else
                                v41.Health = v41.Health - v47;
                            end;
                            l_Parent_2:SetAttribute("RecentAttacker", (tostring(v7)));
                            l_Parent_2:SetAttribute("RecentAttackerTime", tick());
                            v20("Hit", l_Parent_2, v40 == 1);
                            local v63 = Vector3int16.new(v43.Position.X, v43.Position.Y, v43.Position.Z);
                            v13:FireClientConnection(v7, "Hit", "UREMOTE_EVENT", v47, v63);
                        end;
                    end;
                    local l_v18_0 = v18;
                    l_v18_0.TimePast = l_v18_0.TimePast + game["Run Service"].Heartbeat:Wait();
                else
                    break;
                end;
            end;
            v20("Ended");
        end);
        return v18;
    end;
end;
v0.Start = function(_) --[[ Line: 342 ]] --[[ Name: Start ]]
    if game["Run Service"]:IsServer() then
        local l_Folder_0 = Instance.new("Folder");
        l_Folder_0.Name = "Hitboxes";
        l_Folder_0.Parent = workspace;
    end;
end;
return v0;