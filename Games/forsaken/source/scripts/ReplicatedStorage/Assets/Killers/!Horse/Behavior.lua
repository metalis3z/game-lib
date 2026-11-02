-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = require(game.ReplicatedStorage.GlobalTypes);
local v1 = game:GetService("ReplicatedStorage");
local v2 = game:GetService("RunService");
local v3 = game:GetService("TweenService");
local v4 = game:GetService("Players");
local v5 = game:GetService("Debris");
local v6 = game:GetService("Lighting");
local v7 = require(v1.Modules.Sounds);
local v8 = require(v1.Modules.Actors);
local v9 = require(v1.Modules.Ragdolls);
local v10 = require(v1.Modules.Schematics.Lighting);
local v11 = require(v1.Modules.Util);
local v12 = require(v1.Systems.Character.Game.Sprinting);
local v13 = require(v1.Modules.Hitboxes);
local v14 = require(v1.Modules.Misc.Maid);
local v15 = require(v1.Modules.Statuses);
local v16 = require(v1.Modules.Network);
local v17 = require(v1.Modules.AchievementUtil);
local v18 = math.random;
local v19 = table.insert;
local v20 = table.sort;
local v21 = task.wait;
local v22 = task.spawn;
local v23 = task.delay;
local v24 = coroutine.close;
local v25 = v2:IsClient();
local v26 = v2:IsServer();
local v27 = v2:IsStudio();
local v28 = TweenInfo.new(1);
local v29 = Random.new();
local v30 = TweenInfo.new(0.2);
if v25 then
    local v31 = v4.LocalPlayer;
end;
if v25 then
    local v32 = workspace.CurrentCamera;
end;
local function v34(v33) --[[ Line: 44 ]] --[[ Name: __displayWarn ]]
    -- upvalues: v27 (copy)
    if v27 then
        warn((("[Slasher]: %*"):format(v33)));
    end;
end;
local function v40(v35, v36, ...) --[[ Line: 58 ]] --[[ Name: __pcallMethod ]]
    -- upvalues: v27 (copy)
    assert(v35, "bad moduleInfo, must be a table");
    local v37, v38 = pcall(function(...) --[[ Line: 61 ]]
        -- upvalues: v35 (copy), v36 (copy)
        if v35[v36] then
            return v35[v36](...);
        else
            return;
        end;
    end, ...);
    if not v37 then
        local v39 = ("Failed to call :%*() due to: %*"):format(v36, v38);
        if v27 then
            warn((("[Slasher]: %*"):format(v39)));
        end;
    end;
    return v37, v38;
end;
local function v44(v41, v42, v43) --[[ Line: 74 ]] --[[ Name: __getEnragedStat ]]
    return v41.State.isEnraged and v41.Config[("Enraged%*%*"):format(v42, v43)] or v41.Config[("%*%*"):format(v42, v43)];
end;
local function v49(v45) --[[ Line: 81 ]] --[[ Name: __getDictionaryIndexes ]]
    -- upvalues: v19 (copy)
    local v46 = {};
    for v47, v48 in pairs(v45) do
        v19(v46, v47);
    end;
    return v46;
end;
local function v53(v50, v51, v52) --[[ Line: 92 ]] --[[ Name: __playSound ]]
    -- upvalues: v7 (copy), v29 (copy)
    assert(v50.Config.Sounds[v51], "bad soundName, does not exist");
    return v7:Play(v50.Config.Sounds[v51], {
        Parent = v50.Rig.PrimaryPart, 
        PlaybackSpeed = v29:NextNumber(0.975, 1.025), 
        Looped = v52 or false, 
        Volume = 0.25
    });
end;
return {
    Abilities = {
        Charge = {
            LayoutOrder = 1, 
            Name = "Charge", 
            Icon = "rbxassetid://101955457812737", 
            KeybindType = "MainAbility", 
            Cooldown = 20, 
            Callback = function(v54) --[[ Line: 121 ]] --[[ Name: Callback ]]
                -- upvalues: v11 (copy), v7 (copy), v13 (copy)
                local v55 = v54.Config.WalkspeedOverrideDuration;
                local v56 = v54.Config.WalkspeedOverrideEndlag;
                if game["Run Service"]:IsServer() then
                    v54.AbilitiesDisabled = true;
                    v11:SetSpeedCap(v54.Rig, "C00lkiddWalkspeedOverride", v54.Config.WalkspeedOverrideSpeed);
                    local v57 = game:GetService("TweenService");
                    task.delay(v54.Config.WalkspeedOverrideWindup, function() --[[ Line: 134 ]]
                        -- upvalues: v54 (copy), v7 (ref), v13 (ref), v55 (copy), v11 (ref), v56 (copy)
                        local v58 = v54:GetPivot().LookVector;
                        local v59 = v7:Play(v54.Config.Sounds.WalkspeedOverrideLoop, {
                            Parent = v54.Rig.PrimaryPart, 
                            Looped = true, 
                            RollOffMaxDistance = 300, 
                            RollOffMode = Enum.RollOffMode.Linear
                        });
                        local v60 = nil;
                        local v61 = nil;
                        local v63 = v13:CreateHitbox(v54.Player, {
                            Size = Vector3.new(9, 9, 9, 0), 
                            Damage = v54.Config.WalkspeedOverrideDamage, 
                            CFrameOffset = CFrame.new(0, 0, -1.5), 
                            Time = v55, 
                            Knockback = 0, 
                            HitMultiple = true, 
                            DeathProfile = {
                                Velocity = v58 * 750 + Vector3.new(0, 400, 0, 0)
                            }, 
                            Connections = {
                                Hit = function(v62) --[[ Line: 149 ]] --[[ Name: Hit ]]
                                    -- upvalues: v60 (ref), v11 (ref), v54 (ref), v58 (copy)
                                    v60 = v62;
                                    v11:RagdollLaunch(v54, v62, v58 * 700 + Vector3.new(0, 450, 0, 0));
                                end, 
                                Ended = function() --[[ Line: 154 ]] --[[ Name: Ended ]]
                                    -- upvalues: v59 (copy), v61 (ref)
                                    game.TweenService:Create(v59, TweenInfo.new(0.5), {
                                        PlaybackSpeed = 0
                                    });
                                    game.Debris:AddItem(v59, 1);
                                    v61 = true;
                                end
                            }
                        });
                        local v64 = require(game.ReplicatedStorage.Modules.Network);
                        local v65 = Instance.new("BodyVelocity", v54.Rig.PrimaryPart);
                        v65.Velocity = v58 * 155;
                        v65.MaxForce = Vector3.new(500000, 500000, 500000, 0);
                        v65.P = 1e999;
                        v7:Play(v54.Config.Sounds.WalkspeedOverrideLunge, {
                            Parent = v54.Rig.PrimaryPart, 
                            RollOffMaxDistance = 300, 
                            RollOffMode = Enum.RollOffMode.Linear
                        });
                        local v66 = false;
                        local v67 = ("%*C00lkiddCollision"):format(v54.Player.Name);
                        v64:SetConnection(v67, "REMOTE_EVENT", function(v68) --[[ Line: 179 ]]
                            -- upvalues: v54 (ref), v66 (ref)
                            if v68 ~= v54.Player then
                                v68:Kick("not slick at all");
                                return;
                            else
                                v66 = true;
                                return;
                            end;
                        end);
                        repeat
                            task.wait();
                        until v60 or v61 or v66;
                        v65:Destroy();
                        local v69 = "IDK";
                        if v60 then
                            v69 = "Hit";
                            v11:GiveInvincible(v54.Rig, "Walkspeed");
                        elseif v66 then
                            v69 = "Collide";
                        elseif v61 then
                            v69 = "Timeout";
                        end;
                        local v70 = (v69 == "Hit" and 1 or v54.Config.WalkspeedOverrideEndlagMultiplier) * v56;
                        local v71 = Instance.new("StringValue");
                        v71.Name = "Result";
                        v71.Value = v69;
                        v71.Parent = v54.Rig;
                        game.Debris:AddItem(v71, v70);
                        task.delay(v70, function() --[[ Line: 212 ]]
                            -- upvalues: v54 (ref), v69 (ref), v11 (ref)
                            v54.AbilitiesDisabled = false;
                            if v69 == "Hit" then
                                task.delay(1.5, function() --[[ Line: 215 ]]
                                    -- upvalues: v11 (ref), v54 (ref)
                                    v11:RemoveInvincible(v54.Rig, "Walkspeed");
                                end);
                            end;
                        end);
                        v7:PlayVoiceline(v54, ("WalkspeedOverride%*"):format(v69), {
                            Priority = 1.5
                        });
                        v7:Play(v54.Config.Sounds[("WalkspeedOverride%*"):format(v69)], {
                            Parent = v54.Rig.PrimaryPart, 
                            RollOffMaxDistance = 300, 
                            RollOffMode = Enum.RollOffMode.Linear
                        });
                        v11:SetSpeedCap(v54.Rig, "C00lkiddWalkspeedOverride", nil);
                        v64:RemoveConnection(v67, "REMOTE_EVENT");
                        v63:Cancel();
                    end);
                    return;
                else
                    if game["Run Service"]:IsClient() then
                        v54.Animations.WalkspeedOverrideStart:Play();
                        task.delay(v54.Config.WalkspeedOverrideWindup, function() --[[ Line: 233 ]]
                            -- upvalues: v54 (copy)
                            v54.Animations.WalkspeedOverrideLoop.Looped = true;
                            v54.Animations.WalkspeedOverrideLoop:Play();
                        end);
                        local v72 = v11:CreateSpeedMultiplier(v54.Player, 0, "HinderedMovement");
                        local v73 = nil;
                        do
                            local v74 = v73;
                            task.spawn(function() --[[ Line: 243 ]]
                                -- upvalues: v54 (copy), v74 (ref)
                                v54.Rig.PrimaryPart:WaitForChild("LinearVelocity", 2);
                                local v75 = 0;
                                local v76 = false;
                                while true do
                                    if not v74 and v54.Rig.PrimaryPart then
                                        if v75 >= 0.2 and v54.Rig.PrimaryPart.AssemblyLinearVelocity.Magnitude <= 50 then
                                            if not v76 then
                                                require(game.ReplicatedStorage.Modules.Network):FireServerConnection(("%*C00lkiddCollision"):format(v54.Player.Name), "REMOTE_EVENT");
                                                v76 = true;
                                            end;
                                            return;
                                        else
                                            v75 = v75 + game["Run Service"].Heartbeat:Wait();
                                        end;
                                    else
                                        return;
                                    end;
                                end;
                            end);
                            local v77 = v54.Rig:WaitForChild("Result", 6);
                            v74 = v77 and v77.Value or "IDK BRUH";
                            v54.Animations.WalkspeedOverrideStart:Stop();
                            v54.Animations.WalkspeedOverrideLoop:Stop();
                            if v74 == "Hit" then
                                v54.Animations.WalkspeedOverrideHit:Play(0);
                            elseif not v54.Animations.WalkspeedOverrideDuration and not v54.Animations.WalkspeedOverrideCollide then
                                v54.Animations.WalkspeedOverrideMiss:Play(0.05);
                            elseif v74 == "Timeout" and v54.Animations.WalkspeedOverrideDuration then
                                v54.Animations.WalkspeedOverrideDuration:Play(0.05);
                            elseif v74 == "Collide" and v54.Animations.WalkspeedOverrideCollide then
                                v54.Animations.WalkspeedOverrideCollide:Play(0.05);
                            end;
                            if v77 then
                                repeat
                                    task.wait();
                                until not v77.Parent;
                            end;
                            game.TweenService:Create(v72, TweenInfo.new(0.5), {
                                Value = 1
                            }):Play();
                            game.Debris:AddItem(v72, 0.5);
                        end;
                    end;
                    return;
                end;
            end
        }
    }, 
    Created = function(v78, v79) --[[ Line: 297 ]] --[[ Name: Created ]]
        -- upvalues: v14 (copy), v19 (copy), v26 (copy)
        v79.Maid = v14.new();
        v79.Meta = {};
        v79.Instances = {};
        v79.State = {};
        v79.NetworkConnections = {};
        v79.ConnectionDictionary = {};
        v79.State.isEnraged = false;
        v79.Rig:SetAttribute("FootstepsMuted", true);
        local v80 = {};
        for v81, v82 in (v79.Rig:GetDescendants()) do
            if v82.Name == "RagingPace" then
                v19(v80, v82);
            end;
        end;
        v79.Instances.EnragedVisuals = v80;
        if v26 then
            return;
        else
            return;
        end;
    end, 
    Destroyed = function(v83, v84) --[[ Line: 324 ]] --[[ Name: Destroyed ]]

    end
};