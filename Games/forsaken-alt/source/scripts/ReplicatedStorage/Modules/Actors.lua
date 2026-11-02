-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    CurrentActors = {}, 
    ActorAdded = nil
};
local l_RunService_0 = game:GetService("RunService");
local _ = l_RunService_0:IsClient();
local v3 = l_RunService_0:IsServer();
local v4 = require(game.ReplicatedStorage.Modules.Network);
local v5 = require(game.ReplicatedStorage.Modules.Sounds);
local v6 = require(game.ReplicatedStorage.Modules.Util);
local v7 = {
    Killer = "Jason", 
    Survivor = "Noob"
};
local v8 = {
	Idle = "rbxassetid://126704001240025", 
	Walk = "rbxassetid://93586326172113", 
	Run = "rbxassetid://98809016309771", 
	InjuredIdle = "rbxassetid://127611924318230", 
	InjuredWalk = "rbxassetid://128562345343386", 
	InjuredRun = "rbxassetid://102745835613296"
};
v0.__len = function(v9) --[[ Line: 33 ]]
    -- upvalues: v0 (copy)
    local v10 = 0;
    for _, v12 in pairs(v0.CurrentActors) do
        local v13 = v12.Rig and v12.Rig:FindFirstChild("Humanoid");
        if v9.ActorName == v12.ActorName and v13 and v13.Health > 0 then
            v10 = v10 + 1;
        end;
    end;
    return v10;
end;
v0.CreateActor = function(_, v15, v16, v17, v18) --[[ Line: 44 ]] --[[ Name: CreateActor ]]
    -- upvalues: v0 (copy), v7 (copy), v3 (copy), v4 (copy), v6 (copy), v5 (copy)
    if not v17 then
        local l_v0_EquippedActorInfo_0, v20 = v0:GetEquippedActorInfo(v15, v16);
        v17 = l_v0_EquippedActorInfo_0;
        v18 = v20;
    end;
    local v21 = nil;
    local v22 = nil;
    if typeof(v17) == "Instance" and v17:IsA("Folder") then
        v22 = v17;
    else
        v21 = game.ReplicatedStorage.Assets:FindFirstChild((("%*s"):format((tostring(v16)))));
        v22 = v21 and (v21:FindFirstChild((tostring(v17))) or v21:FindFirstChild((tostring(v7[v16]))));
    end;
    if v22 and v15.Character and v15.Character.PrimaryPart and v15.Character.Humanoid.Health > 0 and not v0.CurrentActors[v15] then
        local v23 = setmetatable({
            Cache = {}, 
            Cooldowns = {}, 
            AbilityDisablers = {}
        }, v0);
        v23.Player = v15;
        v23.Folder = v22;
        v23.ActorType = v16;
        v23.ActorName = v17;
        v23.ActorSkin = v18;
        v0:ApplySkinDataToActorInfo(v23);
        v23.IncrementCharges = function(_, v25, v26, v27) --[[ Line: 73 ]] --[[ Name: IncrementCharges ]]
            -- upvalues: v3 (ref), v23 (copy), v4 (ref), v15 (copy)
            if not v3 then
                warn((("attempt to add charges to %* on client!"):format((tostring(v25)))));
                return;
            else
                local v28 = v23 and v23.Behavior.Abilities and v23.Behavior.Abilities[v25];
                if not v28 then
                    return;
                elseif not v28.CurrentCharges then
                    return;
                else
                    v28.CurrentCharges = math.clamp(v28.CurrentCharges + v26, 0, tonumber(v27) or 1e999);
                    v4:FireClientConnection(v15, "UpdateAbilityCharges", "REMOTE_EVENT", v25, v28.CurrentCharges);
                    return;
                end;
            end;
        end;
        local l_pairs_0 = pairs;
        local v30 = v23.Behavior.Abilities or {};
        for _, v32 in l_pairs_0(v30) do
            if v32.Charges then
                v32.CurrentCharges = v32.Charges;
            end;
        end;
        v23.SetCooldownOf = function(_, v34, v35) --[[ Line: 99 ]] --[[ Name: SetCooldownOf ]]
            -- upvalues: v23 (copy), v4 (ref), v15 (copy)
            local v36 = v23 and v23.Cooldowns;
            if not (v23 and v23.Behavior.Abilities and v23.Behavior.Abilities[v34]) then
                return;
            else
                if tonumber(v35) and v35 ~= 0 and not workspace:GetAttribute("CooldownsDisabled") then
                    local v37 = v35 < 0 and v36[v34] and v36[v34] - workspace:GetServerTimeNow() + v35 or v35;
                    local v38 = workspace:GetServerTimeNow() + v37;
                    v36[v34] = v38;
                    task.delay(v37, function() --[[ Line: 112 ]]
                        -- upvalues: v23 (ref), v36 (copy), v34 (copy), v38 (copy)
                        if v23 and v23.Rig.Parent and v36[v34] == v38 then
                            v36[v34] = nil;
                        end;
                    end);
                else
                    v36[v34] = nil;
				end;
                v4:FireClientConnection(v15, "UpdateAbilityCooldown", "REMOTE_EVENT", v34, v35);
                return;
            end;
        end;
        v23.DisableAbilities = function(_, v40, v41, v42) --[[ Line: 128 ]] --[[ Name: DisableAbilities ]]
            -- upvalues: v23 (copy)
            v23.AbilityDisablers[v40] = v41;
            if v42 then
                task.delay(v42, function() --[[ Line: 131 ]]
                    -- upvalues: v23 (ref), v40 (copy), v41 (copy)
                    v23.AbilityDisablers[v40] = not v41;
                end);
            end;
        end;
		v6:PreloadAssets(v23.Config);
		-- TODO: Remake the rig system (load from server storage so it doesn't get shit leaked.)
		if v23.SkinFolder then 
			v23.Rig = game:GetService('ServerStorage').Assets.Actors.Skins:FindFirstChild(v23.ActorType):FindFirstChild(v23.ActorName):FindFirstChild(tostring(v23.ActorSkin)):FindFirstChild('Rig')
		else 
			warn(v23)
			v23.Rig = game:GetService('ServerStorage').Assets.Actors:FindFirstChild(v23.ActorType):FindFirstChild(v23.ActorName):FindFirstChild('Rig')
		end
		--
		if v23.Behavior.GetRig then
            v23.Rig = v23.Behavior:GetRig(v23);
        else
            v23.Rig = v23.Rig:Clone();
        end;
        if not v23.Rig:FindFirstChild("Humanoid") then
            l_pairs_0 = Instance.new("Humanoid");
            l_pairs_0.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
            l_pairs_0.Parent = v23.Rig;
            Instance.new("Animator").Parent = l_pairs_0;
        end;
        l_pairs_0 = v15.Character and v15.Character.PrimaryPart;
        v30 = v23.Rig.Humanoid;
        v30.JumpHeight = 0;
        v30.JumpPower = 0;
        v30.MaxSlopeAngle = 65;
        v30.BreakJointsOnDeath = false;
        v30.HipHeight = v23.Config.HipHeight or 0;
        v30.WalkSpeed = v23.Config.Speed or 16;
        v30.MaxHealth = v23.Config.Health or 100;
        v30.Health = v30.MaxHealth;
        v30:SetAttribute("BaseSpeed", v30.WalkSpeed);
        v23.Rig.Name = v22.Name;
        v23.Rig:SetAttribute("Username", v15.Name);
        v23.Rig:SetAttribute("SkinName", (tostring(v18)));
        if l_pairs_0 then
            v23.Rig:SetPrimaryPartCFrame(l_pairs_0.CFrame);
        end;
        if v23.Config.DirectionalMovementDisabled then
            v23.Rig:SetAttribute("DirectionalMovementDisabled", true);
        end;
        if v23.Config.Sounds and v23.Config.Sounds.Ambience then
            v5:Play(v23.Config.Sounds.Ambience, {
                Parent = v23.Rig.PrimaryPart, 
                Looped = true
            });
        end;
        v30.Died:Connect(function() --[[ Line: 181 ]]
            -- upvalues: v23 (copy), v5 (ref), v0 (ref), v15 (copy)
            local l_PrimaryPart_0 = v23.Rig.PrimaryPart;
            if l_PrimaryPart_0 then
                v5:Play("dead", {
                    Parent = l_PrimaryPart_0
                });
            end;
            v5:PlayVoiceline(v23, "Died", {
                Priority = 10
            });
            v0:CleanupActorFromPlayer(v15);
		end);
        local l_FirstChild_0 = game.ServerStorage.Assets.Instances.KillerBackgrounds.Intro:FindFirstChild(v17);
        if l_FirstChild_0 then
            local v45 = l_FirstChild_0:FindFirstChild((tostring(v18))) or l_FirstChild_0:FindFirstChild("Default");
            if v45 then
                v45 = v45:Clone();
                v45.Parent = workspace.Misc;
                v45:SetPrimaryPartCFrame(CFrame.new(0, 10000, 0));
                game.Debris:AddItem(v45, 10);
            end;
        end;
        if v23.Config.Expressions and not v23.Rig.Head:FindFirstChild("face") then
            local v46 = v23.Rig:FindFirstChild("ExpressionHolder", true) or game.ReplicatedStorage.Assets.Instances.ExpressionHolder:Clone();
            if not v46.Parent then
                v46.Parent = v23.Rig;
                v46.CFrame = v23.Rig.Head.CFrame * CFrame.new(0, 0, -0.005);
                local l_WeldConstraint_0 = Instance.new("WeldConstraint");
                l_WeldConstraint_0.Part0 = v23.Rig.Head;
                l_WeldConstraint_0.Part1 = v46;
                l_WeldConstraint_0.Parent = v46;
            end;
            local v48 = v46:FindFirstChildOfClass("Decal") or Instance.new("Decal");
            if not v48.Parent then
                v48.Parent = v46;
            end;
            v48.Name = "Expression";
            local v49 = nil;
            local l_v48_0 = v48 --[[ copy: 13 -> 24 ]];
            do
                local l_v49_0 = v49;
                v23.ChangeExpression = function(_, v53, v54) --[[ Line: 221 ]] --[[ Name: ChangeExpression ]]
                    -- upvalues: v23 (copy), l_v49_0 (ref), l_v48_0 (copy), v30 (copy)
                    if not v23.Rig.Parent then
                        return;
                    elseif not v23.Config.Expressions[v53] then
                        return;
                    else
                        if l_v49_0 then
                            task.cancel(l_v49_0);
                        end;
                        if v53 == "Default" then
                            l_v48_0.Texture = v30.Health <= v30.MaxHealth / 2 and v23.Config.Expressions.Injured or v23.Config.Expressions.Default;
                        else
                            l_v48_0.Texture = v23.Config.Expressions[v53];
                        end;
                        if v54 then
                            l_v49_0 = task.delay(v54, function() --[[ Line: 235 ]]
                                -- upvalues: l_v48_0 (ref), v30 (ref), v23 (ref)
                                l_v48_0.Texture = v30.Health <= v30.MaxHealth / 2 and v23.Config.Expressions.Injured or v23.Config.Expressions.Default;
                            end);
                        end;
                        return;
                    end;
                end;
                v48.Texture = v23.Config.Expressions.Default or "";
                local l_Health_0 = v30.Health;
                v30.HealthChanged:Connect(function(v56) --[[ Line: 246 ]]
                    -- upvalues: v23 (copy), l_Health_0 (ref), v5 (ref)
                    if v56 <= 0 then
                        v23:ChangeExpression("Dead");
                    elseif v56 < l_Health_0 and v23.Config.Expressions.Hurt then
                        v23:ChangeExpression("Hurt", 0.75);
                    elseif l_Health_0 + 20 < v56 and v23.Config.Expressions.Happy then
                        v23:ChangeExpression("Happy", 0.75);
                    else
                        v23:ChangeExpression("Default");
                    end;
                    if l_Health_0 - v56 >= 15 then
                        v5:PlayVoiceline(v23, "Injured", {
                            Priority = 5
                        });
                    end;
                    l_Health_0 = v56;
                end);
            end;
        else
            v23.ChangeExpression = function(_, _, _) --[[ Line: 268 ]] --[[ Name: ChangeExpression ]]

            end;
        end;
        for _, v61 in pairs(workspace.Players:GetChildren()) do
            if v61.Name:find(v16) then
                v23.Rig.Parent = v61;
                break;
            end;
        end;
        local v62 = {
            Head = true, 
            Torso = true, 
            ["Left Arm"] = true, 
            ["Left Leg"] = true, 
            ["Right Arm"] = true, 
            ["Right Leg"] = true
        };
        for _, v64 in pairs(v23.Rig:GetDescendants()) do
            if v64:IsA("BasePart") then
                v64.Anchored = false;
                v64.Massless = not v62[v64.Name] and v64 ~= v23.Rig.PrimaryPart;
                if v64 ~= v23.Rig.PrimaryPart then
                    v64.CanCollide = false;
                    v64.CanQuery = false;
                    v64.CollisionGroup = "None";
                else
                    v64.CanCollide = true;
                    v64.CanQuery = true;
                    v64.CollisionGroup = ("%*s"):format(v16);
                end;
            end;
        end;
        local v65 = (v23.Config.CollisionHitbox or game.ReplicatedStorage.Assets.Instances.CollisionHitbox):Clone();
        local v66 = v65:GetAttribute("CFrameOffset") or CFrame.new(0, 0.5, 0);
        v65.CFrame = v23.Rig.PrimaryPart.CFrame * v66;
        local v67 = (v23.Config.QueryHitbox or game.ReplicatedStorage.Assets.Instances.QueryHitbox):Clone();
        local v68 = v65:GetAttribute("CFrameOffset") or CFrame.new(0, -0.25, 0);
        v67.CFrame = v23.Rig.PrimaryPart.CFrame * v68;
        for _, v70 in pairs({
            v65, 
            v67
        }) do
            local l_WeldConstraint_1 = Instance.new("WeldConstraint");
            l_WeldConstraint_1.Name = "CollisionConnector";
            l_WeldConstraint_1.Parent = v70;
            l_WeldConstraint_1.Part1 = v70;
            l_WeldConstraint_1.Part0 = v23.Rig.PrimaryPart;
            v70.CollisionGroup = ("%*s"):format(v16);
            v70.Parent = v23.Rig;
        end;
        task.spawn(function() --[[ Line: 330 ]]
            -- upvalues: v23 (copy), v15 (copy)
            v23.Rig.PrimaryPart:SetNetworkOwner(v15);
        end);
        task.spawn(function() --[[ Line: 335 ]]
            -- upvalues: v23 (copy), v6 (ref)
            for v72, v73 in pairs(v23.Config.Animations) do
                if tostring(v72):find("Execution") and typeof(v73) == "table" then
                    v23.Cache[("%*Anim"):format(v72)] = v6:LoadAnimationFromID(v23.Rig, v73.KillerRig, true);
                end;
            end;
        end);
        task.spawn(function() --[[ Line: 344 ]]
            -- upvalues: v23 (copy), v5 (ref)
            if v23.Config.Voicelines and v23.Config.Voicelines.Idle then
                while task.wait(math.random(10, 25)) and v23 and v23.Rig and v23.Rig.PrimaryPart do
                    if not v23.Rig.PrimaryPart:FindFirstChild("VoicelineSFX") then
                        v5:PlayVoiceline(v23, "Idle", {
                            Priority = 0
                        });
                    end;
                end;
            end;
        end);
        if v15.Character then
            v15.Character:Destroy();
        end;
        v15.Character = v23.Rig;
        local v74 = v6:CopyTable(v23);
        v74.Information = nil;
        v74.Behavior = nil;
        v74.Config = nil;
        v4:FireAllClientConnection("ActorCreated", "REMOTE_EVENT", v74);
        for _, v76 in pairs({
            "Created", 
            "CreatedPost"
        }) do
            if v23.Behavior[v76] then
                v23.Behavior[v76](v23.Behavior, v23);
            end;
        end;
        local v77 = v23.Config.SprintSpeed or 24;
        local l_v30_Attribute_0 = v30:GetAttribute("BaseSpeed");
        v6:SetSpeedCap(v15, "Sprinting", v77 / l_v30_Attribute_0);
        v0.CurrentActors[v15] = v23;
        v0.__actorCreated:Fire(v23);
        return v23;
    else
        return;
    end;
end;
v0.CleanupActorFromPlayer = function(_, v80) --[[ Line: 389 ]] --[[ Name: CleanupActorFromPlayer ]]
    -- upvalues: v0 (copy), v4 (copy)
	local v81 = v0.CurrentActors[v80];
    if v81 then
        if v81.Behavior and v81.Behavior.Destroyed then
            v81.Behavior:Destroyed(v81);
        end;
        v4:FireAllClientConnection("ActorDestroyed", "REMOTE_EVENT", v80);
        v0.__actorDestroyed:Fire(v81);
		v0.CurrentActors[v80] = nil;
    end;
end;
v0.GetEquippedActorInfo = function(_, v83, v84) --[[ Line: 408 ]] --[[ Name: GetEquippedActorInfo ]]
    local l_PlayerData_0 = v83:FindFirstChild("PlayerData");
    local v86 = l_PlayerData_0 and l_PlayerData_0:FindFirstChild("Equipped");
    local v87 = v86 and v86:FindFirstChild(v84) and v86[v84].Value or "";
    local v88 = v86 and v86:FindFirstChild("Skins");
    return v87, v88 and v88:FindFirstChild(v87) and v88[v87].Value or "";
end;
v0.GetAmountOfLivingActorsOfClass = function(_, v90) --[[ Line: 420 ]] --[[ Name: GetAmountOfLivingActorsOfClass ]]
    -- upvalues: v0 (copy)
    local v91 = 0;
    for _, v93 in pairs(v0.CurrentActors) do
        if v93.Config and v93.Config.Class == v90 then
            v91 = v91 + 1;
        end;
    end;
    return v91;
end;
v0.ApplySkinDataToActorInfo = function(_, v95) --[[ Line: 430 ]] --[[ Name: ApplySkinDataToActorInfo ]]
    -- upvalues: v6 (copy), v8 (copy)
    local v96 = game["Run Service"]:IsServer();
    local l_Folder_0 = v95.Folder;
    local l_ActorType_0 = v95.ActorType;
    local l_ActorName_0 = v95.ActorName;
    local l_ActorSkin_0 = v95.ActorSkin;
    v95.Config = v6:CopyTable(require(l_Folder_0.Config));
    v95.Behavior = v6:CopyTable(require(l_Folder_0.Behavior));
    if v96 then
		v95.Rig = v95.Config.Rig;
    end;
    for v101, v102 in pairs(v8) do
        if not v95.Config.Animations[v101] then
            v95.Config.Animations[v101] = v102;
        end;
    end;
    local l_FirstChild_1 = game.ReplicatedStorage.Assets.Skins:FindFirstChild(tostring(l_ActorType_0) .. "s");
    local v104 = l_FirstChild_1 and l_FirstChild_1:FindFirstChild(l_ActorName_0);
    local v105 = l_ActorSkin_0 and v104 and v104:FindFirstChild(l_ActorSkin_0);
    if v105 then
        local v106 = v105:FindFirstChild("Config") and require(v105.Config);
        local v107 = v105:FindFirstChild("Behavior") and require(v105.Behavior);
        local v108 = v96 and v106 and v106.Rig;
        local v109 = v6:MergeTables(v95.Config, v106, {
            "DisplayName"
        });
        local v110 = v6:MergeTables(v95.Behavior, v107);
        v95.Config = v109;
        v95.Behavior = v110;
        v95.SkinFolder = v105;
        if v108 then
            v95.Rig = v108;
        end;
        return v105;
    else
        return;
    end;
end;
v0.CreateChatInteraction = function(_, v112, v113, v114) --[[ Line: 477 ]] --[[ Name: CreateChatInteraction ]]
    -- upvalues: v0 (copy), v6 (copy)
    if typeof(v112) == "Instance" then
        v112 = v0.CurrentActors[v112] or v0.CurrentActors[game.Players:GetPlayerFromCharacter(v112)];
    end;
    if typeof(v114) == "Instance" then
        v114 = v0.CurrentActors[v114] or v0.CurrentActors[game.Players:GetPlayerFromCharacter(v114)];
    end;
    if not v112 then
        return;
    else
        local l_TextInteractions_0 = v112.Config.TextInteractions;
        if not l_TextInteractions_0 then
            return;
        else
            local l_l_TextInteractions_0_0 = l_TextInteractions_0;
            local v117 = string.split(v113, "/");
            for _, v119 in pairs(v117) do
                l_l_TextInteractions_0_0 = l_l_TextInteractions_0_0[("%*%*"):format(v114 and tostring(v114.ActorSkin):gsub(v114.ActorName, "") or "", v119)] or l_l_TextInteractions_0_0[v119] or l_l_TextInteractions_0_0.Regular;
                if not l_l_TextInteractions_0_0 then
                    return;
                end;
            end;
            local v120 = l_l_TextInteractions_0_0[math.random(1, #l_l_TextInteractions_0_0)];
            if v120 then
                if typeof(v120) == "table" then
                    task.spawn(function() --[[ Line: 499 ]]
                        -- upvalues: v120 (copy), v112 (ref), v114 (ref), v6 (ref)
                        for _, v122 in pairs(v120) do
                            local v123 = nil;
                            local v124 = string.split(v122, " ");
                            if v124[1]:find(":") then
                                if v124[1]:find(v112.ActorName) then
                                    v123 = v112.Rig;
                                elseif v114 and v124[1]:find(v114.ActorName) then
                                    v123 = v114.Rig;
                                end;
                                table.remove(v124, 1);
                            end;
                            v6:DisplayBubble(v123, table.concat(v124, " "));
                            task.wait((math.clamp(#v124 / 2 + v122:len(), 1, 4)));
                        end;
                    end);
                else
                    v6:DisplayBubble(v112.Rig, v120);
                end;
            end;
            return;
        end;
    end;
end;
v0.IncrementActorStats = function(_, v126, v127) --[[ Line: 523 ]] --[[ Name: IncrementActorStats ]]
    -- upvalues: v0 (copy), v6 (copy), v4 (copy)
    if workspace:GetAttribute("ServerType") == "VIP" then
        return;
    elseif typeof(v126) ~= "Instance" and not v126:IsA("Player") then
        return;
    else
        local v128 = ({
            Support = {
                Money = 10, 
                EXP = 30, 
                KillerChance = 0.5
            }, 
            Offensive = {
                Money = 5, 
                EXP = 15, 
                KillerChance = 0.75
            }, 
            Survivalist = {
                Money = 3, 
                EXP = 12, 
                KillerChance = 0.25
            }, 
            VeryDifficultKillerAction = {
                Money = 20, 
                EXP = 60
            }, 
            DifficultKillerAction = {
                Money = 12, 
                EXP = 36
            }, 
            RegularKillerAction = {
                Money = 8, 
                EXP = 24
            }, 
            EasyKillerAction = {
                Money = 4, 
                EXP = 12
            }
        })[v127.RewardType];
        if v128 then
            v127.Money = tonumber(v128.Money) or v127.Money;
            v127.EXP = tonumber(v128.EXP) or v127.EXP;
        end;
        task.spawn(function() --[[ Line: 571 ]]
            -- upvalues: v127 (copy), v0 (ref), v126 (copy), v6 (ref), v4 (ref)
            local v129 = false;
            if v127.EXP then
                local v130 = v0.CurrentActors[v126];
                local v131 = v130 and v130.Folder;
                if v131 then
                    local l_PlayerData_1 = v126:FindFirstChild("PlayerData");
                    local v133 = l_PlayerData_1 and l_PlayerData_1:FindFirstChild("Purchased");
                    local v134 = v133 and v133:FindFirstChild((("%*s"):format((tostring(v130 and v130.ActorType)))));
                    if v134 then
                        local v135 = v126:GetAttribute("EXPMultiplier") or 1;
                        local l_l_PlayerData_1_FirstChild_0 = l_PlayerData_1:FindFirstChild("EXPBoostTime", true);
                        if l_l_PlayerData_1_FirstChild_0 and l_l_PlayerData_1_FirstChild_0.Value > 0 then
                            v135 = v135 + 0.25;
                        end;
                        if tonumber(v127.EXP) then
                            local l_v127_0 = v127;
                            l_v127_0.EXP = l_v127_0.EXP * v135;
                        end;
                        local l_v134_FirstChild_0 = v134:FindFirstChild(v131.Name);
                        if l_v134_FirstChild_0 then
                            l_v134_FirstChild_0.Value = l_v134_FirstChild_0.Value + tonumber(v127.EXP);
                            v129 = true;
                        end;
                    end;
                end;
            end;
            v6:AddToPlayerStat(v126, "Money", v127.Money);
            v6:AddToPlayerStat(v126, "KillerChance", v127.KillerChance);
            if typeof(v127.Action) == "string" then
                local v139 = tostring(v127.Action);
                local v140 = {
                    v127.Money and ("%*$"):format((tostring(v127.Money))), 
                    v129 and v127.EXP and ("%* EXP"):format((tostring(v127.EXP))) or nil
                };
                local v141 = table.concat(v140, " & ");
                v4:FireClientConnection(v126, "SendNotif", "REMOTE_EVENT", ("+ %*: %*"):format(v141, v139), "Objective");
            end;
        end);
        return;
    end;
end;
v0.CreateCutsceneActor = function(_, v143, v144) --[[ Line: 614 ]] --[[ Name: CreateCutsceneActor ]]
    -- upvalues: v6 (copy)
    local v145 = v143.Config.Animations[v144];
    if not v145 then
        return;
    else
        local v146 = {
            "KillerRig", 
            "CameraRig"
        };
        local v147 = v143.Rig:Clone();
        local v148 = (v143.SkinFolder and (v143.SkinFolder:FindFirstChild((("%*CameraRig"):format(v144))) or v143.SkinFolder:FindFirstChild("CameraRig")) or v143.Folder:FindFirstChild((("%*CameraRig"):format(v144))) or v143.Folder:FindFirstChild("CameraRig") or game.ReplicatedStorage.Assets.Instances.CameraRig):Clone();
        game.Debris:AddItem(v147, 30);
        game.Debris:AddItem(v148, 30);
        v147:WaitForChild("HumanoidRootPart").Anchored = true;
        v148:WaitForChild(v148:GetAttribute("RootName") or "HumanoidRootPart").Anchored = true;
        v147:SetPrimaryPartCFrame(CFrame.new(0, 10000, 0));
        v148:SetPrimaryPartCFrame(CFrame.new(0, 10000, 0));
        v147.Parent = workspace.Misc;
        v148.Parent = workspace.Misc;
        local v149 = {};
        for _, v151 in pairs(v146) do
            local v152 = v145[v151];
            local v153 = v145[("%*Loop"):format(v151)];
            if v152 then
                v149[v151] = v6:LoadAnimationFromID(v151:find("Killer") and v147 or v148, v152, true);
            end;
            if v153 then
                v149[("%*Loop"):format(v151)] = v6:LoadAnimationFromID(v151:find("Killer") and v147 or v148, v153, true);
            end;
        end;
        local _ = task.spawn(function() --[[ Line: 659 ]]
            -- upvalues: v148 (copy)
            local l_CurrentCamera_0 = workspace.CurrentCamera;
            local v155 = v148:GetAttribute("CameraName") or "CameraPart";
            local l_v148_FirstChild_0 = v148:FindFirstChild(v155);
            while v148.Parent do
                if l_v148_FirstChild_0 then
                    l_CurrentCamera_0.CameraType = Enum.CameraType.Scriptable;
                    l_CurrentCamera_0.CFrame = l_v148_FirstChild_0.CFrame;
                end;
                task.wait();
            end;
            local l_LocalPlayer_0 = game.Players.LocalPlayer;
            local v158 = l_LocalPlayer_0.Character and l_LocalPlayer_0.Character:FindFirstChild("Humanoid");
            if v158 then
                l_CurrentCamera_0.CameraSubject = v158;
            end;
            l_CurrentCamera_0.CameraType = Enum.CameraType.Custom;
        end);
        task.delay(v149.CameraRig.Length - 0.1, function() --[[ Line: 682 ]]
            -- upvalues: v149 (copy)
            for v160, v161 in pairs(v149) do
                if not v160:find("Loop") then
                    if v149[("%*Loop"):format(v160)] then
                        v149[("%*Loop"):format(v160)]:Play(0);
                        v161:Stop();
                    else
                        v161:AdjustSpeed(0);
                    end;
                end;
            end;
        end);
        for _, v163 in pairs(v149) do
            v163:Play(0);
        end;
        return v147, v148, v149.CameraRig.Length;
    end;
end;
v0.Start = function(_) --[[ Line: 702 ]] --[[ Name: Start ]]
    -- upvalues: v3 (copy), v0 (copy)
    if v3 then
        game.Players.PlayerRemoving:Connect(function(v165) --[[ Line: 705 ]]
            -- upvalues: v0 (ref)
            v0:CleanupActorFromPlayer(v165);
        end);
    end;
    local v166 = {
        __actorCreated = "ActorAdded", 
        __actorDestroyed = "ActorRemoved"
    };
    for v167, v168 in pairs(v166) do
        v0[v167] = Instance.new("BindableEvent");
        v0[v167].Name = v167;
        v0[v167].Parent = script;
        v0[v168] = v0[v167].Event;
    end;
end;
return v0;