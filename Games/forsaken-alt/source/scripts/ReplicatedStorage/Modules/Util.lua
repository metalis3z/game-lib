-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_UserInputService_0 = game:GetService("UserInputService");
local l_TweenService_0 = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local l_Debris_0 = game:GetService("Debris");
local v5 = l_RunService_0:IsClient();
local v6 = l_RunService_0:IsServer();
local v7 = require(game.ReplicatedStorage.Initializer);
local v8 = require(game.ReplicatedStorage.Modules.Network);
local v9 = require(game.ReplicatedStorage.Modules.Sounds);
v0.EmitParticlesFromAttachment = function(_, v11) --[[ Line: 18 ]] --[[ Name: EmitParticlesFromAttachment ]]
    for _, v13 in pairs(v11:GetChildren()) do
        if v13:IsA("ParticleEmitter") then
            v13:Emit(v13:GetAttribute("EmitCount") or 1);
        end;
    end;
end;
v0.LoadAnimationFromID = function(_, v15, v16, v17) --[[ Line: 27 ]] --[[ Name: LoadAnimationFromID ]]
    if not v15 then
        warn(debug.traceback("no rig found while loading animation from ID!"));
        return;
    elseif not v16 then
        warn(debug.traceback("no ID found while loading animation onto rig!"));
        return;
    elseif typeof(v16) ~= "string" then
        return;
    else
        local l_v15_FirstChild_0 = v15:FindFirstChild("Animator", true);
        while not l_v15_FirstChild_0 do
            task.wait();
            l_v15_FirstChild_0 = v15:FindFirstChild("Animator", true);
        end;
        local l_v15_FirstChild_1 = v15:FindFirstChild(v16);
        if l_v15_FirstChild_1 then
            return l_v15_FirstChild_0:LoadAnimation(l_v15_FirstChild_1);
        else
            local l_Animation_0 = Instance.new("Animation");
            l_Animation_0.Name = v16;
            l_Animation_0.AnimationId = v16;
            l_Animation_0.Parent = v15;
            local v21 = l_v15_FirstChild_0:LoadAnimation(l_Animation_0);
            local v22 = 0;
            if v17 and v21.Length <= 0 then
                repeat
                    v22 = v22 + task.wait();
                until v21.Length > 0 or v22 >= 25;
            end;
            return v21;
        end;
    end;
end;
v0.ApplyDamage = function(_, v24, v25) --[[ Line: 61 ]] --[[ Name: ApplyDamage ]]
    local l_Humanoid_0 = v24:FindFirstChild("Humanoid");
    local v27 = tonumber(v25);
    if not v27 or not l_Humanoid_0 or l_Humanoid_0.Health <= 0 then
        return;
    elseif v24:GetAttribute("Invincible") then
        return;
    else
        local l_ResistanceMultipliers_0 = v24:FindFirstChild("ResistanceMultipliers");
        local v29 = 0;
        local l_pairs_0 = pairs;
        local v31 = l_ResistanceMultipliers_0 and l_ResistanceMultipliers_0:GetChildren() or {};
        for _, v33 in l_pairs_0(v31) do
            v29 = v29 + v33.Value;
        end;
        l_pairs_0 = v27 * (1 - v29 / 100);
        v31 = require(game.ReplicatedStorage.Modules.Actors);
        local v34 = v31.CurrentActors[game.Players:GetPlayerFromCharacter(v24)];
        if v34 and v34.Behavior and v34.Behavior.OnHit then
            local v35 = {
                TimePast = 0
            };
            v34.Behavior:OnHit(v34, v35, l_pairs_0);
            if v35.TimePast ~= 0 then
                return;
            end;
        end;
        local l_l_Humanoid_0_Attribute_0 = l_Humanoid_0:GetAttribute("Overheal");
        if l_l_Humanoid_0_Attribute_0 then
            l_l_Humanoid_0_Attribute_0 = l_l_Humanoid_0_Attribute_0 - l_pairs_0;
            l_Humanoid_0:SetAttribute("Overheal", l_l_Humanoid_0_Attribute_0 > 0 and l_l_Humanoid_0_Attribute_0 or nil);
            if l_l_Humanoid_0_Attribute_0 < 0 then
                l_Humanoid_0.Health = l_Humanoid_0.Health - math.abs(l_l_Humanoid_0_Attribute_0);
            end;
        else
            l_Humanoid_0.Health = l_Humanoid_0.Health - l_pairs_0;
        end;
        if l_Humanoid_0.Health <= 0 and tostring(v24.Parent) == "Survivors" then
            local l_RoundManager_0 = game.ServerStorage.ServerSystems.RoundManager;
            local v38 = require(l_RoundManager_0);
            local v39 = require(l_RoundManager_0.Configuration);
            if v38.CurrentSession and v38.CurrentSession.TimePast then
                local l_CurrentSession_0 = v38.CurrentSession;
                l_CurrentSession_0.TimePast = l_CurrentSession_0.TimePast - (tonumber(v38.CurrentSession.Gamemode and v38.CurrentSession.Gamemode.TimeAddedOnKill) or 20);
            end;
            local v41 = tostring(v24:GetAttribute("RecentAttacker"));
            local v42 = tonumber(v24:GetAttribute("RecentAttackerTime")) or 0;
            local l_FirstChild_0 = game.Players:FindFirstChild(v41);
            if l_FirstChild_0 and v42 + 12.5 >= tick() then
                require(game.ReplicatedStorage.Modules.Stats):UpdatePlayerStat(l_FirstChild_0, "Kills", "Add", 1);
                v31:IncrementActorStats(l_FirstChild_0, {
                    Action = "Killed a Survivor through damage over time", 
                    Money = v39.KillerKillCurrency, 
                    EXP = v39.KillerKillEXP
                });
            end;
        end;
        return;
    end;
end;
v0.SpeedCaps = {};
v0.SetSpeedCap = function(_, v45, v46, v47, v48) --[[ Line: 128 ]] --[[ Name: SetSpeedCap ]]
    -- upvalues: v0 (copy)
    if game["Run Service"]:IsClient() then
        return;
    elseif not v46 then
        return;
    else
        local v49 = v45 and (v45:IsA("Model") and v45 or v45.Character);
        if not v49 then
            return;
        elseif v47 then
            if not v0.SpeedCaps[v49] then
                v0.SpeedCaps[v49] = {};
            end;
            v0.SpeedCaps[v49][v46] = {
                Value = v47, 
                ID = math.random(0, 1000000)
            };
            return;
        else
            if v0.SpeedCaps[v49] then
                if tonumber(v48) then
                    local l_ID_0 = v0.SpeedCaps[v49].ID;
                    task.delay(v48, function() --[[ Line: 147 ]]
                        -- upvalues: v0 (ref), v49 (copy), l_ID_0 (copy), v46 (copy)
                        if v0.SpeedCaps[v49] and v0.SpeedCaps[v49].ID == l_ID_0 then
                            v0.SpeedCaps[v49][v46] = nil;
                        end;
                    end);
                    return;
                else
                    v0.SpeedCaps[v49][v46] = nil;
                end;
            end;
            return;
        end;
    end;
end;
v0.CreateValueMultiplier = function(_, v52, v53, v54, v55, v56, v57) --[[ Line: 162 ]] --[[ Name: CreateValueMultiplier ]]
    -- upvalues: l_TweenService_0 (copy), l_Debris_0 (copy)
    local v58 = v52 and (v52:IsA("Model") and v52 or v52.Character);
    local v59 = v58 and v58:FindFirstChild((("%*Multipliers"):format(v53)));
    local v60 = v59 and v59:FindFirstChild((tostring(v55)));
    local l_NumberValue_0 = Instance.new("NumberValue");
    l_NumberValue_0.Value = v54 or 1;
    l_NumberValue_0.Name = v55 or ("%*Multiplier"):format(v53);
    l_NumberValue_0.Parent = v59;
    if v56 then
        if v57 then
            task.delay(v56 - 0.3, function() --[[ Line: 170 ]]
                -- upvalues: l_TweenService_0 (ref), l_NumberValue_0 (copy)
                l_TweenService_0:Create(l_NumberValue_0, TweenInfo.new(0.3), {
                    Value = 1
                }):Play();
            end);
        end;
        l_Debris_0:AddItem(l_NumberValue_0, v56);
    end;
    if v60 then
        v60:Destroy();
    end;
    return l_NumberValue_0;
end;
v0.CreateSpeedMultiplier = function(_, v63, v64, v65, v66, v67) --[[ Line: 176 ]] --[[ Name: CreateSpeedMultiplier ]]
    -- upvalues: v0 (copy)
    return v0:CreateValueMultiplier(v63, "Speed", v64, v65, v66, v67);
end;
v0.CreateFOVMultiplier = function(_, v69, v70, v71, v72, v73) --[[ Line: 181 ]] --[[ Name: CreateFOVMultiplier ]]
    -- upvalues: v0 (copy)
    return v0:CreateValueMultiplier(v69, "FOV", v70, v71, v72, v73);
end;
v0.CreateResistanceMultiplier = function(_, v75, v76, v77, v78, v79) --[[ Line: 186 ]] --[[ Name: CreateResistanceMultiplier ]]
    -- upvalues: v0 (copy)
    return v0:CreateValueMultiplier(v75, "Resistance", v76, v77, v78, v79);
end;
v0.GetSettingValue = function(_, v81, v82) --[[ Line: 191 ]] --[[ Name: GetSettingValue ]]
    -- upvalues: v5 (copy)
    if not v82 then
        v82 = v5 and game.Players.LocalPlayer;
    end;
    if v82 then
        local l_FirstChild_1 = v82.PlayerData.Settings:FindFirstChild(v81, true);
        if l_FirstChild_1 then
            return l_FirstChild_1.Value;
        end;
    end;
end;
v0.ApplyOverheal = function(_, v85, v86, v87) --[[ Line: 200 ]] --[[ Name: ApplyOverheal ]]
    local v88 = v85 and (v85:IsA("Model") and v85 or v85.Character);
    local v89 = v88 and v88:FindFirstChild("Humanoid");
    if not v89 then
        return;
    elseif not tonumber(v86) then
        return;
    else
        if v86 <= 0 then
            v89:SetAttribute("Overheal", nil);
            v89:SetAttribute("DrainingOverheal", nil);
        else
            v89:SetAttribute("Overheal", v86);
        end;
        if v87 and not v89:GetAttribute("DrainingOverheal") then
            task.spawn(function() --[[ Line: 218 ]]
                -- upvalues: v89 (copy)
                v89:SetAttribute("DrainingOverheal", true);
                while v89.Parent and v89.Health > 0 do
                    local v90 = task.wait();
                    local l_v89_Attribute_0 = v89:GetAttribute("Overheal");
                    if l_v89_Attribute_0 then
                        local v92 = l_v89_Attribute_0 - 2 * v90;
                        if v92 > 0 then
                            v89:SetAttribute("Overheal", v92);
                        else
                            break;
                        end;
                    else
                        break;
                    end;
                end;
                v89:SetAttribute("Overheal", nil);
            end);
        end;
        return;
    end;
end;
v0.GetPlayerMousePosition = function(_, v94, v95) --[[ Line: 237 ]] --[[ Name: GetPlayerMousePosition ]]
    -- upvalues: v7 (copy)
    if game["Run Service"]:IsServer() then
        return (v7.Modules.Network:FireClientConnection(v94, "GetMousePosition", "REMOTE_FUNCTION", v95));
    elseif game["Run Service"]:IsClient() then
        return require(game.ReplicatedStorage.Systems.Player.Miscellaneous.GetPlayerMousePosition):GetMousePos(v94);
    else
        return;
    end;
end;
v0.SelectRandomKillers = function(_, v97, v98) --[[ Line: 248 ]] --[[ Name: SelectRandomKillers ]]
    -- upvalues: v0 (copy)
    local v99 = {};
	local v100 = {};
	
    for _, v102 in pairs(v97) do
        local v103 = v102.Instance and v102.Instance:FindFirstChild("PlayerData");
        local v104 = v103 and v103:FindFirstChild("Stats");
        local v105 = v104 and v104:FindFirstChild("KillerChance", true);
        if v105 then
            v102.KillerChance = v105;
            table.insert(v100, v102);
        end;
    end;
    local v106 = workspace:GetAttribute("ServerType") == "VIP";
    if v106 then
        v0:ShuffleTable(v100);
    else
        table.sort(v100, function(v107, v108) --[[ Line: 272 ]]
            return v107.KillerChance.Value > v108.KillerChance.Value;
        end);
	end;
	
	local v109 = math.clamp(#v97 - 1, workspace:GetAttribute("ForcedKiller") and 1 or 0, 1e999);
	
    if v109 >= 1 then
        for _ = 1, math.clamp(v98, 1, v109) do
            local v111 = nil;
            local v112 = nil;
            local l_workspace_Attribute_0 = workspace:GetAttribute("ForcedKiller");
            workspace:SetAttribute("ForcedKiller", nil);
            if l_workspace_Attribute_0 then
                for v114, v115 in pairs(v100) do
                    if tostring(v115.Instance) == l_workspace_Attribute_0 then
                        v111 = v115;
                        v112 = v114;
                    end;
                end;
            end;
            if not v111 then
                v111 = v100[1];
                v112 = 1;
            end;
            if v111 and v112 then
                if not v106 then
                    v111.KillerChance.Value = 1;
                end;
                table.insert(v99, v111);
                table.remove(v100, v112);
            end;
        end;
	end;
	
    if not v106 then
        for _, v117 in pairs(v100) do
            v0:AddToPlayerStat(v117.Instance, "KillerChance", 1);
        end;
	end;
	
	warn(v99, v100)
	
    return v99, v100;
end;
v0.PreloadAssets = function(_, v119) --[[ Line: 344 ]] --[[ Name: PreloadAssets ]]
    -- upvalues: v5 (copy)
    task.spawn(function() --[[ Line: 345 ]]
        -- upvalues: v5 (ref), v119 (copy)
        local v120 = {};
        local function v121(v122) --[[ Line: 347 ]] --[[ Name: fetchAssets ]]
            -- upvalues: v121 (copy), v5 (ref), v120 (copy)
            for v123, v124 in pairs(v122) do
                if typeof(v124) == "table" then
                    v121(v124);
                elseif typeof(v124) == "string" and v124:find("rbxassetid://") then
                    if v123 == "Sounds" and v5 then
                        local l_Sound_0 = Instance.new("Sound");
                        l_Sound_0.Parent = workspace:FindFirstChild("Sounds");
                        l_Sound_0.SoundId = v124;
                        l_Sound_0.Volume = 0;
                        l_Sound_0:Play();
                        game.Debris:AddItem(l_Sound_0, 1);
                    end;
                    table.insert(v120, v124);
                end;
            end;
        end;
        v121(v119);
        game.ContentProvider:PreloadAsync(v120);
    end);
end;
v0.ToggleLockForAbilityIcon = function(_, v127, v128, v129) --[[ Line: 370 ]] --[[ Name: ToggleLockForAbilityIcon ]]
    local l_AbilityContainer_0 = game.Players.LocalPlayer.PlayerGui.MainUI:FindFirstChild("AbilityContainer");
    local v131 = l_AbilityContainer_0 and l_AbilityContainer_0:FindFirstChild((tostring(v127)));
    if not v131 then
        return;
    else
        local function _(v132) --[[ Line: 378 ]] --[[ Name: setAbilityIconTitleTransparencies ]]
            -- upvalues: v131 (copy)
            local l_Clipping_0 = v131:FindFirstChild("Clipping");
            local l_CooldownTime_0 = v131:FindFirstChild("CooldownTime");
            if l_Clipping_0 then
                l_Clipping_0.Visible = v132;
            end;
            if l_CooldownTime_0 then
                l_CooldownTime_0.Visible = v132;
            end;
        end;
        if v129 and not v131:FindFirstChild(v128) then
            local v136 = script.AbilityLock:Clone();
            v136.Name = v128;
            v136.Parent = v131;
            local l_Clipping_1 = v131:FindFirstChild("Clipping");
            local l_CooldownTime_1 = v131:FindFirstChild("CooldownTime");
            if l_Clipping_1 then
                l_Clipping_1.Visible = false;
            end;
            if l_CooldownTime_1 then
                l_CooldownTime_1.Visible = false;
                return;
            end;
        elseif not v129 then
            local l_Clipping_2 = v131:FindFirstChild("Clipping");
            local l_CooldownTime_2 = v131:FindFirstChild("CooldownTime");
            if l_Clipping_2 then
                l_Clipping_2.Visible = true;
            end;
            if l_CooldownTime_2 then
                l_CooldownTime_2.Visible = true;
            end;
            l_Clipping_2 = v131:FindFirstChild(v128);
            if l_Clipping_2 then
                l_Clipping_2:Destroy();
            end;
        end;
        return;
    end;
end;
v0.ToggleLocksForAbilityIcons = function(_, v142, v143) --[[ Line: 405 ]] --[[ Name: ToggleLocksForAbilityIcons ]]
    -- upvalues: v0 (copy)
    local l_AbilityContainer_1 = game.Players.LocalPlayer.PlayerGui.MainUI:FindFirstChild("AbilityContainer");
    local v145 = l_AbilityContainer_1 and l_AbilityContainer_1:GetChildren() or {};
    for _, v147 in pairs(v145) do
        if v147:IsA("GuiObject") then
            v0:ToggleLockForAbilityIcon(v147.Name, v142, v143);
        end;
    end;
end;
v0.CreateDisplayUI = function(_, v149) --[[ Line: 418 ]] --[[ Name: CreateDisplayUI ]]
    -- upvalues: v0 (copy), l_TweenService_0 (copy), l_Debris_0 (copy)
    if not v0.KillerIntroUI then
        v0.KillerIntroUI = Instance.new("ScreenGui");
        v0.KillerIntroUI.Name = "KillerIntroUI";
        v0.KillerIntroUI.DisplayOrder = 10;
        v0.KillerIntroUI.ResetOnSpawn = false;
        v0.KillerIntroUI.Parent = game.Players.LocalPlayer.PlayerGui;
    end;
    local v150 = {};
    local l_KillerDisplays_0 = game.ReplicatedStorage.Assets.UI.KillerDisplays;
    local v152 = l_KillerDisplays_0.KillerDisplayBackground:Clone();
    v152.Parent = v0.KillerIntroUI;
    v152.ImageTransparency = 1;
    v152.Title.TextTransparency = 1;
    v152.Title.Text = #v149 > 1 and "This round's killers are..." or "This round's killer is...";
    l_TweenService_0:Create(v152, TweenInfo.new(0.2), {
        ImageTransparency = 0
    }):Play();
    l_TweenService_0:Create(v152.Title, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
        TextTransparency = 0
    }):Play();
    table.insert(v150, v152);
    table.insert(v150, v152.Title);
    task.delay(0.65, function() --[[ Line: 441 ]]
        -- upvalues: v149 (copy), l_KillerDisplays_0 (copy), v152 (copy), l_TweenService_0 (ref), v150 (copy)
        for v153, v154 in pairs(v149) do
            local v155 = l_KillerDisplays_0.Display:Clone();
            v155.Parent = v152.Displays;
            v155.LayoutOrder = v153;
            v155.KillerName.Text = v154.KillerName;
            v155.PlayerName.Text = ("(%*)"):format(v154.PlayerName);
            v155.KillerName.TextTransparency = 1;
            v155.PlayerName.TextTransparency = 1;
            l_TweenService_0:Create(v155.KillerName, TweenInfo.new(0.2), {
                TextTransparency = 0
            }):Play();
            l_TweenService_0:Create(v155.PlayerName, TweenInfo.new(0.2), {
                TextTransparency = 0.6
            }):Play();
            table.insert(v150, v155.KillerName);
            table.insert(v150, v155.PlayerName);
            if v153 ~= #v149 then
                local v156 = l_KillerDisplays_0.Separator:Clone();
                v156.Parent = v152.Displays;
                v156.LayoutOrder = v153;
                v156.TextTransparency = 1;
                l_TweenService_0:Create(v156, TweenInfo.new(0.2), {
                    TextTransparency = 0
                }):Play();
                table.insert(v150, v156);
            end;
        end;
    end);
    task.delay(5, function() --[[ Line: 467 ]]
        -- upvalues: v150 (copy), l_Debris_0 (ref), l_TweenService_0 (ref)
        for _, v158 in pairs(v150) do
            l_Debris_0:AddItem(v158, 0.5);
            if v158:IsA("TextLabel") then
                l_TweenService_0:Create(v158, TweenInfo.new(0.5), {
                    TextTransparency = 1
                }):Play();
            elseif v158:IsA("ImageLabel") then
                l_TweenService_0:Create(v158, TweenInfo.new(0.5), {
                    ImageTransparency = 1
                }):Play();
            end;
        end;
    end);
end;
local v159 = nil;
v0.CreateTooltip = function(_, v161) --[[ Line: 482 ]] --[[ Name: CreateTooltip ]]
    -- upvalues: v159 (ref), v9 (copy), l_UserInputService_0 (copy)
    local l_LocalPlayer_0 = game.Players.LocalPlayer;
    if v159 and (v159.Title.Text ~= tostring(v161) or not v159.Parent) then
        if v159.Parent then
            game.TweenService:Create(v159.Title, TweenInfo.new(0.15), {
                TextSize = 0, 
                TextTransparency = 1
            }):Play();
            game.TweenService:Create(v159.Background, TweenInfo.new(0.15), {
                Size = UDim2.fromScale(), 
                ImageTransparency = 1
            }):Play();
            game.Debris:AddItem(v159, 0.15);
            v9:Play("hoverEnd");
        end;
        v159 = nil;
    elseif not v159 and v161 then
        local v163 = l_UserInputService_0:GetMouseLocation() - game.GuiService:GetGuiInset();
        v159 = script.Tooltip:Clone();
        v159.Title.Text = v161;
        v159.Title.Position = UDim2.fromOffset(v163.X, v163.Y + -28);
        v159.Background.Position = UDim2.fromOffset(v163.X, v163.Y + -28 - v159.Title.AbsoluteSize.Y / 2);
        v159.Background.Size = UDim2.fromOffset(v159.Title.AbsoluteSize.X + 64, v159.Title.AbsoluteSize.Y + 50);
        v159.Parent = l_LocalPlayer_0.PlayerGui:FindFirstChild("MainUI");
        v9:Play("hover");
        task.spawn(function() --[[ Line: 505 ]]
            -- upvalues: v159 (ref), l_UserInputService_0 (ref)
            while v159 and v159.Parent do
                local v164 = l_UserInputService_0:GetMouseLocation() - game.GuiService:GetGuiInset();
                v159.Title.Position = UDim2.fromOffset(v164.X, v164.Y + -28);
                v159.Background.Position = UDim2.fromOffset(v164.X, v164.Y + -28 - v159.Title.AbsoluteSize.Y / 2);
                v159.Background.Size = UDim2.fromOffset(v159.Title.AbsoluteSize.X + 64, v159.Title.AbsoluteSize.Y + 50);
                task.wait();
            end;
        end);
    end;
    return v159;
end;
v0.AddToPlayerStat = function(_, v166, v167, v168, v169) --[[ Line: 519 ]] --[[ Name: AddToPlayerStat ]]
    -- upvalues: v0 (copy)
    if workspace:GetAttribute("ServerType") == "VIP" and v169 ~= true then
        return;
    else
        local v170 = false;
        if typeof(v166) == "Instance" then
            v170 = v166:FindFirstChild("PlayerData");
        end;
        local v171 = v170 and v170.Stats:FindFirstChild(tostring(v167), true);
        if v171 and v171:IsA("NumberValue") then
            if v167 == "KillerChance" and not v169 and v170.Settings.Game.MaliceDisabled.Value then
                return;
            else
                v171.Value = v171.Value + (tonumber(v168) or 0);
                if v167 == "Money" then
                    v0:AddToPlayerStat(v166, "NetWorth", v168);
                end;
            end;
        end;
        return;
    end;
end;
v0.CopyTable = function(_, v173) --[[ Line: 541 ]] --[[ Name: CopyTable ]]
    -- upvalues: v0 (copy)
    local v174 = {};
    for v175, v176 in pairs(v173) do
        if typeof(v176) == "table" then
            v174[v175] = v0:CopyTable(v176);
        else
            v174[v175] = v176;
        end;
    end;
    return v174;
end;
v0.MergeTables = function(_, v178, v179, v180) --[[ Line: 554 ]] --[[ Name: MergeTables ]]
    -- upvalues: v0 (copy)
    if not v179 then
        return v178;
    else
        local v181 = {
            Voicelines = true, 
            Emotes = true, 
            TerrorRadiusThemes = true
        };
        local v182 = {};
        local l_pairs_1 = pairs;
        local v184 = v178 or {};
        for v185, v186 in l_pairs_1(v184) do
            if typeof(v186) == "table" and typeof(v179[v185]) == "table" then
                v182[v185] = v0:MergeTables(v186, v179[v185], v180);
            else
                v182[v185] = v186;
            end;
        end;
        l_pairs_1 = pairs;
        v184 = v179 or {};
        for v187, v188 in l_pairs_1(v184) do
            if typeof(v188) == "table" and typeof(v178[v187]) == "table" and not v181[v187] then
                v182[v187] = v0:MergeTables(v178[v187], v188, v180);
            elseif not table.find(v180 or {}, v187) then
                v182[v187] = v188;
            end;
        end;
        return v182;
    end;
end;
v0.ShuffleTable = function(_, v190) --[[ Line: 587 ]] --[[ Name: ShuffleTable ]]
    local v191 = nil;
    local v192 = nil;
    for v193 = #v190, 1, -1 do
        v191 = math.random(v193);
        v192 = v190[v193];
        v190[v193] = v190[v191];
        v190[v191] = v192;
    end;
    return v190;
end;
v0.ToCommas = function(_, v195) --[[ Line: 599 ]] --[[ Name: ToCommas ]]
    return tostring(v195):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "");
end;
v0.ConvertToAbbreviation = function(_, v197) --[[ Line: 609 ]] --[[ Name: ConvertToAbbreviation ]]
    local function v199(v198) --[[ Line: 610 ]] --[[ Name: formatNumber ]]
        if v198 % 1 == 0 then
            return string.format("%.0f", v198);
        elseif v198 * 10 % 1 == 0 then
            return string.format("%.1f", v198);
        else
            return string.format("%.2f", v198);
        end;
    end;
    if v197 >= 1000000000000000 then
        return v199(v197 / 1000000000000000) .. "Q+";
    elseif v197 >= 1000000000000 then
        return v199(v197 / 1000000000000) .. "T+";
    elseif v197 >= 1000000000 then
        return v199(v197 / 1000000000) .. "B+";
    elseif v197 >= 1000000 then
        return v199(v197 / 1000000) .. "M+";
    elseif v197 >= 1000 then
        return v199(v197 / 1000) .. "K+";
    else
        return (tostring(v197));
    end;
end;
v0.CalculateLevelFromEXP = function(_, v201) --[[ Line: 636 ]] --[[ Name: CalculateLevelFromEXP ]]
    local v202 = 1;
    local v203 = 100;
    local l_v201_0 = v201;
    while v203 <= l_v201_0 do
        l_v201_0 = l_v201_0 - v203;
        v202 = v202 + 1;
        v203 = math.round(v202 * 10 + 100);
    end;
    if v202 >= 100 then
        return 100, 0, 999999;
    else
        return v202, l_v201_0, v203;
    end;
end;
v0.FormatTime = function(_, v206, v207) --[[ Line: 665 ]] --[[ Name: FormatTime ]]
    -- upvalues: v7 (copy)
    if not v206 then
        v7.Debug("can't format time due to seconds being nil!");
        return "";
    elseif not v207 then
        v7.Debug("can't format time due to formatType being nil!");
        return "";
    else
        local v208 = math.floor(v206 / 86400);
        local v209 = math.floor(v206 % 86400 / 3600);
        local v210 = math.floor(v206 % 3600 / 60);
        local v211 = v206 % 60;
        local v212 = "";
        if v207 == "Clock" then
            if v208 > 0 then
                return (string.format("%d:%02d:%02d:%02d", v208, v209, v210, v211));
            elseif v209 > 0 then
                return (string.format("%02d:%02d:%02d", v209, v210, v211));
            else
                return (string.format("%02d:%02d", v210, v211));
            end;
        else
            if v207 == "String" then
                if v208 > 0 then
                    v212 = ("%*%*%*"):format(v212, v208, v208 == 1 and " day" or " days");
                end;
                if v209 > 0 then
                    if v212 ~= "" then
                        v212 = ("%*%*"):format(v212, (not (not (v208 > 0) or v210 <= 0) or v211 > 0) and ", " or " and ");
                    end;
                    v212 = ("%*%*%*"):format(v212, v209, v209 == 1 and " hour" or " hours");
                end;
                if v210 > 0 then
                    if v212 ~= "" then
                        v212 = ("%*%*"):format(v212, (not (v208 <= 0) or v209 > 0) and v211 > 0 and ", " or " and ");
                    end;
                    v212 = ("%*%*%*"):format(v212, v210, v210 == 1 and " minute" or " minutes");
                end;
                if v211 > 0 then
                    if v212 ~= "" then
                        v212 = ("%*%*"):format(v212, (not (v208 <= 0 and v209 <= 0) or v210 > 0) and " and " or "");
                    end;
                    v212 = ("%*%*%*"):format(v212, v211, v211 == 1 and " second" or " seconds");
                end;
            end;
            return v212;
        end;
    end;
end;
v0.IntToRoman = function(_, v214) --[[ Line: 716 ]] --[[ Name: IntToRoman ]]
    if not tonumber(v214) then
        return "IDK";
    else
        v214 = math.round((tonumber(v214)));
        local v215 = {
            {
                1000, 
                "M"
            }, 
            {
                900, 
                "CM"
            }, 
            {
                500, 
                "D"
            }, 
            {
                400, 
                "CD"
            }, 
            {
                100, 
                "C"
            }, 
            {
                90, 
                "XC"
            }, 
            {
                50, 
                "L"
            }, 
            {
                40, 
                "XL"
            }, 
            {
                10, 
                "X"
            }, 
            {
                9, 
                "IX"
            }, 
            {
                5, 
                "V"
            }, 
            {
                4, 
                "IV"
            }, 
            {
                1, 
                "I"
            }
        };
        local v216 = "";
        for _, v218 in pairs(v215) do
            while v218[1] <= v214 do
                v216 = v216 .. v218[2];
                v214 = v214 - v218[1];
            end;
        end;
        return v216;
    end;
end;
v0.ApplyCameraShake = function(_, v220, v221) --[[ Line: 749 ]] --[[ Name: ApplyCameraShake ]]
    if not game.Players.LocalPlayer.PlayerData.Settings.Customization.ScreenShakeEnabled.Value then
        return;
    else
        local v222 = tick();
        local v223 = nil;
        v223 = game:GetService("RunService").RenderStepped:Connect(function() --[[ Line: 759 ]]
            -- upvalues: v222 (copy), v221 (copy), v220 (copy), v223 (ref)
            local v224 = math.clamp((tick() - v222) / v221, 0, 1);
            local v225 = v220 * (1 - v224);
            local v226 = Vector3.new((math.random() - 0.5) * 2 * v225, (math.random() - 0.5) * 2 * v225, (math.random() - 0.5) * 2 * v225);
            local l_CurrentCamera_0 = workspace.CurrentCamera;
            l_CurrentCamera_0.CFrame = l_CurrentCamera_0.CFrame * CFrame.new(v226);
            if v224 >= 1 then
                v223:Disconnect();
                v223 = nil;
                return;
            else
                return;
            end;
        end);
        return;
    end;
end;
v0.ApplyCameraShakeTo = function(_, v229, v230, v231) --[[ Line: 787 ]] --[[ Name: ApplyCameraShakeTo ]]
    -- upvalues: v6 (copy), v8 (copy)
    if not v6 then
        return;
    else
        v8:FireClientConnection(v229, "ShakeCamera", "REMOTE_EVENT", v230, v231);
        return;
    end;
end;
v0.IsOnScreen = function(_, v233) --[[ Line: 793 ]] --[[ Name: IsOnScreen ]]
    local v234 = false;
    if typeof(v233) ~= "Instance" then
        return;
    else
        local _ = tick();
        local l_Character_0 = game.Players.LocalPlayer.Character;
        local v237 = false;
        local v238 = require(game.ReplicatedStorage.Systems.Player.Miscellaneous.GetPlayerMousePosition);
        local v239 = {};
        table.insert(v239, v233);
        table.insert(v239, l_Character_0);
        table.insert(v239, workspace.CurrentCamera);
        for v240, _ in pairs(v238.TransparentParts) do
            table.insert(v239, v240);
        end;
        local function v245(v242) --[[ Line: 814 ]] --[[ Name: checkForVisibility ]]
            -- upvalues: v239 (copy)
            local _, v244 = workspace.CurrentCamera:WorldToViewportPoint(v242.Position);
            if v244 and #workspace.CurrentCamera:GetPartsObscuringTarget({
                workspace.CurrentCamera.CFrame.Position, 
                v242.Position
            }, v239) == 0 then
                return true;
            else
                return;
            end;
        end;
        if v233:IsA("Model") then
            for _, v247 in pairs(v233:GetChildren()) do
                if v247:IsA("BasePart") and v247.Transparency ~= 1 then
                    v237 = v245(v247);
                    v234 = v237;
                end;
                if v234 then
                    break;
                end;
            end;
            if not v234 then
                return v237;
            end;
        elseif v233:IsA("BasePart") and v233.Transparency ~= 1 then
            v237 = v245(v233);
        end;
        v234 = false;
        return v237;
    end;
end;
v0.CreateProgressBar = function(_, v249, v250) --[[ Line: 839 ]] --[[ Name: CreateProgressBar ]]
    v249 = v249 or "Performing Action";
    v250 = tonumber(v250) or 5;
    local l_LocalPlayer_1 = game.Players.LocalPlayer;
    local v252 = game.ReplicatedStorage.Assets.UI.ProgressBar:Clone();
    v252.Title.Text = ("%*."):format(v249);
    v252.Parent = l_LocalPlayer_1.PlayerGui:FindFirstChild("TemporaryUI");
    game.Debris:AddItem(v252, v250);
    task.spawn(function() --[[ Line: 849 ]]
        -- upvalues: v252 (copy), v250 (ref), v249 (ref)
        local v253 = 0;
        local v254 = 0;
        local v255 = 0;
        while v252.Parent do
            local v256 = v253 / v250;
            local v257 = v256 == 0 and 0 or 1 / v256;
            v252.Bar.Clipping.Size = UDim2.fromScale(v256, 1);
            v252.Bar.Clipping.Top.Size = UDim2.fromScale(v257, 1);
            if v254 >= 0.3 then
                v254 = 0;
                v255 = v255 + 1;
                v252.Title.Text = ("%*%*"):format(v249, (string.rep(".", v255 % 3 + 1)));
            end;
            local v258 = game["Run Service"].Heartbeat:Wait();
            v253 = math.clamp(v253 + v258, 0, v250);
            v254 = v254 + v258;
        end;
    end);
    return v252;
end;
v0.FadeIn = function(v259, v260) --[[ Line: 880 ]] --[[ Name: FadeIn ]]
    -- upvalues: v7 (copy), l_TweenService_0 (copy)
    if not v260 then
        v260 = {};
    end;
    if v259.Fade and v259.Fade.Parent then
        v7.Debug("FadeIn cancelled b/c there's already a fade that exists!");
        return;
    else
        if not v259.FadeUI then
            v259.FadeUI = Instance.new("ScreenGui");
            v259.FadeUI.Name = "FadeUI";
            v259.FadeUI.IgnoreGuiInset = true;
            v259.FadeUI.ResetOnSpawn = false;
            v259.FadeUI.DisplayOrder = 10;
            v259.FadeUI.Parent = v7.Player.PlayerGui;
        end;
        v259.Fade = Instance.new("Frame");
        v259.Fade.Name = "Fade";
        v259.Fade.BackgroundTransparency = v260.StartTransparency or 1;
        v259.Fade.BackgroundColor3 = v260.Color or Color3.new();
        v259.Fade.Size = UDim2.fromScale(1, 1);
        v259.Fade.Parent = v259.FadeUI;
        if v260.InstantTween then
            v259.Fade.BackgroundTransparency = v260.EndTransparency or 0;
            return;
        else
            local v261 = l_TweenService_0:Create(v259.Fade, v260.TweenInfo or TweenInfo.new(v260.Time or 0.325, Enum.EasingStyle.Linear), {
                BackgroundTransparency = v260.EndTransparency or 0
            });
            v261:Play();
            if v260.Yield then
                v261.Completed:Wait();
            end;
            return;
        end;
    end;
end;
v0.FadeOut = function(v262, v263) --[[ Line: 918 ]] --[[ Name: FadeOut ]]
    -- upvalues: v7 (copy), l_TweenService_0 (copy), l_Debris_0 (copy)
    if not v263 then
        v263 = {};
    end;
    if not v262.Fade then
        v7.Debug("FadeOut cancelled b/c there's no fade that exists!");
        return;
    elseif not v262.FadeUI then
        v7.Debug("FadeOut called before ever calling FadeIn!");
        return;
    else
        local v264 = l_TweenService_0:Create(v262.Fade, v263.TweenInfo or TweenInfo.new(v263.Time or 0.325, Enum.EasingStyle.Linear), {
            BackgroundTransparency = v263.Transparency or 1
        });
        v264:Play();
        l_Debris_0:AddItem(v262.Fade, v264.TweenInfo.Time);
        if v263.Yield then
            v264.Completed:Wait();
        end;
        v262.Fade = nil;
        return;
    end;
end;
v0.CreateWarning = function(_, v266, v267, v268) --[[ Line: 940 ]] --[[ Name: CreateWarning ]]
    local l_LocalPlayer_2 = game.Players.LocalPlayer;
    local l_FirstChild_2 = l_LocalPlayer_2.PlayerGui.TemporaryUI:FindFirstChild(v266);
    if l_FirstChild_2 then
        l_FirstChild_2:Destroy();
    end;
    local v271 = (v268 or game.ReplicatedStorage.Assets.UI.Warning):Clone();
    v271.Name = v266;
    v271.Title.Text = tostring(v267);
    v271.Parent = l_LocalPlayer_2.PlayerGui.TemporaryUI;
    task.delay(3, function() --[[ Line: 953 ]]
        -- upvalues: v271 (copy)
        if v271.Parent then
            if v271:GetAttribute("InstantDeletion") then
                v271:Destroy();
                return;
            else
                game.Debris:AddItem(v271, 1);
                game.TweenService:Create(v271, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    BackgroundTransparency = 1
                }):Play();
                game.TweenService:Create(v271.Title, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    TextTransparency = 1, 
                    TextStrokeTransparency = 1, 
                    BackgroundTransparency = 1
                }):Play();
            end;
        end;
    end);
end;
v0.DisplayBubble = function(_, v273, v274) --[[ Line: 967 ]] --[[ Name: DisplayBubble ]]
    -- upvalues: v8 (copy)
    if not v273 then
        return;
    elseif game["Run Service"]:IsServer() then
        v8:FireAllClientConnection("DisplayBubble", "REMOTE_EVENT", v273, v274);
        return;
    else
        game.TextChatService:DisplayBubble(v273, v274);
        return;
    end;
end;
v0.ToggleControls = function(_, v276) --[[ Line: 977 ]] --[[ Name: ToggleControls ]]
    -- upvalues: v7 (copy)
    local l_Controls_0 = require(v7.Player.PlayerScripts:WaitForChild("PlayerModule")):GetControls();
    if not v276 then
        l_Controls_0:Disable();
        return;
    else
        l_Controls_0:Enable();
        return;
    end;
end;
v0.ToggleResetButton = function(_, v279) --[[ Line: 989 ]] --[[ Name: ToggleResetButton ]]
    task.spawn(function() --[[ Line: 990 ]]
        -- upvalues: v279 (copy)
        game:GetService("StarterGui"):SetCore("ResetButtonCallback", v279);
    end);
end;
v0.ToggleSprinting = function(_, v281, v282, v283) --[[ Line: 997 ]] --[[ Name: ToggleSprinting ]]
    -- upvalues: v8 (copy)
    v8:FireConnection("DisableSprinting", v281, not v282);
    if v283 then
        task.delay(v283, function() --[[ Line: 1000 ]]
            -- upvalues: v8 (ref), v281 (copy), v282 (copy)
            v8:FireConnection("DisableSprinting", v281, v282);
        end);
    end;
end;
v0.CreateMoneyDisplay = function(_, v285) --[[ Line: 1007 ]] --[[ Name: CreateMoneyDisplay ]]
    -- upvalues: v7 (copy), v9 (copy)
    local l_NumberValue_1 = Instance.new("NumberValue");
    l_NumberValue_1:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 1010 ]]
        -- upvalues: l_NumberValue_1 (copy), v7 (ref), v285 (copy)
        local v287 = math.round(l_NumberValue_1.Value);
        local v288 = v7.Modules.Util:ToCommas(v287);
        v285.CurrentBalance.Text = ("%*$ "):format(v288);
    end);
    local l_FirstChild_3 = game.Players.LocalPlayer:WaitForChild("PlayerData"):WaitForChild("Stats"):FindFirstChild("Money", true);
    l_FirstChild_3:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 1020 ]]
        -- upvalues: l_NumberValue_1 (copy), l_FirstChild_3 (copy), v285 (copy)
        game.TweenService:Create(l_NumberValue_1, TweenInfo.new(1), {
            Value = l_FirstChild_3.Value
        }):Play();
        v285.CurrentBalance.TextSize = v285.CurrentBalance.AbsoluteSize.Y;
    end);
    l_NumberValue_1.Value = l_FirstChild_3.Value;
    v285.CurrentBalance.Text = ("%*$ "):format((v7.Modules.Util:ToCommas((math.round(l_NumberValue_1.Value)))));
    v285.CurrentBalance.TextSize = v285.CurrentBalance.AbsoluteSize.Y;
    v285.BuyMore.MouseEnter:Connect(function() --[[ Line: 1031 ]]
        -- upvalues: v9 (ref)
        v9:Play("hover");
    end);
    v285.BuyMore.MouseLeave:Connect(function() --[[ Line: 1032 ]]
        -- upvalues: v9 (ref)
        v9:Play("hoverEnd");
    end);
    v285.BuyMore.MouseButton1Click:Connect(function() --[[ Line: 1033 ]]
        -- upvalues: v7 (ref)
        local l_Shop_0 = v7.PlayerSystems.Shop;
        v7.PlayerSystems.SidebarHandler.SidebarMenus.Shop:ToggleMenu(true);
        l_Shop_0:SwitchTab("Robux");
    end);
end;
v0.ApplyVelocity = function(_, v292, v293) --[[ Line: 1042 ]] --[[ Name: ApplyVelocity ]]
    if v292 and v292:IsA("Model") then
        v292 = v292.PrimaryPart;
    end;
    if not v292 then
        return {};
    else
        local l_AssemblyMass_0 = v292.AssemblyMass;
        for _, v296 in pairs(v292.Parent:GetDescendants()) do
            if v296:IsA("BasePart") and not v296.Massless and v296 ~= v292 then
                l_AssemblyMass_0 = l_AssemblyMass_0 + v296.AssemblyMass;
            end;
        end;
        local l_LinearVelocity_0 = Instance.new("LinearVelocity");
        l_LinearVelocity_0.MaxForce = l_AssemblyMass_0 * 350;
        l_LinearVelocity_0.RelativeTo = Enum.ActuatorRelativeTo.World;
        l_LinearVelocity_0.VelocityConstraintMode = Enum.VelocityConstraintMode.Line;
        l_LinearVelocity_0.LineDirection = v292.CFrame.LookVector;
        l_LinearVelocity_0.LineDirection = Vector3.new(l_LinearVelocity_0.LineDirection.X, 0, l_LinearVelocity_0.LineDirection.Z);
        l_LinearVelocity_0.LineVelocity = v293 or 0;
        l_LinearVelocity_0.Attachment0 = v292:FindFirstChild("RootAttachment") or v292:FindFirstChildOfClass("Attachment");
        l_LinearVelocity_0.Parent = v292;
        return l_LinearVelocity_0;
    end;
end;
v0.RevealPlayerAura = function(_, v299, v300, v301) --[[ Line: 1069 ]] --[[ Name: RevealPlayerAura ]]
    -- upvalues: l_Debris_0 (copy), l_TweenService_0 (copy)
    local v302 = v299 and v299:IsA("Player") and v299.Character or v299;
    local l_LocalPlayer_3 = game.Players.LocalPlayer;
    local l_Character_1 = l_LocalPlayer_3.Character;
    if v302 and l_Character_1 and (not v302:GetAttribute("Undetectable") or tostring(v302.Parent) == tostring(l_Character_1.Parent)) then
        local v305 = {
            Killers = Color3.new(1, 0, 0), 
            Survivors = Color3.new(1, 0.75, 0), 
            Spectating = Color3.new(1, 1, 1)
        };
        local l_PlayerAura_0 = v302:FindFirstChild("PlayerAura");
        if l_PlayerAura_0 then
            l_PlayerAura_0:Destroy();
        end;
        local v307 = v301 or v305[tostring(v302.Parent)] or v305[tostring(v302)] or v305.Spectating;
        if l_LocalPlayer_3.PlayerData.Settings.Game.AltHighlights.Value then
            if v302:IsA("Model") and not v302.PrimaryPart then
                return;
            else
                local v308 = game.ReplicatedStorage.Assets.UI.Highlight:Clone();
                v308.Name = "PlayerAura";
                v308.Adornee = v302:FindFirstChild("Head") or v302:IsA("Model") and v302.PrimaryPart or v302;
                v308.Container.ImageColor3 = v307;
                v308.Parent = l_LocalPlayer_3.PlayerGui.TemporaryUI;
                local l_ViewportFrame_0 = v308.Container.ViewportFrame;
                local v310 = nil;
                v310 = if v302:IsA("Model") then l_ViewportFrame_0.ModelCenter.CFrame else l_ViewportFrame_0.PartCenter.CFrame;
                local v311 = v302:Clone();
                if v302:IsA("Model") then
                    v311:SetPrimaryPartCFrame(v310);
                else
                    v311.CFrame = v310;
                end;
                v311.Parent = l_ViewportFrame_0;
                local v312 = {
                    l_ViewportFrame_0, 
                    l_ViewportFrame_0.Parent
                };
                l_Debris_0:AddItem(v308, tonumber(v300) or 10);
                if not l_PlayerAura_0 then
                    for _, v314 in pairs(v312) do
                        l_TweenService_0:Create(v314, TweenInfo.new(1), {
                            ImageTransparency = 0
                        }):Play();
                    end;
                end;
                task.delay((tonumber(v300) or 10) - 1, function() --[[ Line: 1142 ]]
                    -- upvalues: v308 (copy), v312 (copy), l_TweenService_0 (ref)
                    v308.Name = "goodbai";
                    for _, v316 in pairs(v312) do
                        l_TweenService_0:Create(v316, TweenInfo.new(1), {
                            ImageTransparency = 1
                        }):Play();
                    end;
                end);
                return;
            end;
        else
            local l_Highlight_0 = Instance.new("Highlight");
            l_Highlight_0.Name = "PlayerAura";
            l_Highlight_0.FillColor = v307;
            l_Highlight_0.OutlineColor = v307;
            l_Highlight_0.Parent = v302;
            l_Debris_0:AddItem(l_Highlight_0, tonumber(v300) or 10);
            if not l_PlayerAura_0 then
                l_Highlight_0.FillTransparency = 1;
                l_Highlight_0.OutlineTransparency = 1;
                l_TweenService_0:Create(l_Highlight_0, TweenInfo.new(1), {
                    FillTransparency = 0.5, 
                    OutlineTransparency = 0
                }):Play();
            end;
            task.delay((tonumber(v300) or 10) - 1, function() --[[ Line: 1167 ]]
                -- upvalues: l_Highlight_0 (copy), l_TweenService_0 (ref)
                l_Highlight_0.Name = "goodbai";
                l_TweenService_0:Create(l_Highlight_0, TweenInfo.new(1), {
                    FillTransparency = 1, 
                    OutlineTransparency = 1
                }):Play();
            end);
        end;
    end;
end;
v0.RevealPlayerAuraTo = function(_, v319, v320, v321, v322) --[[ Line: 1176 ]] --[[ Name: RevealPlayerAuraTo ]]
    -- upvalues: v8 (copy)
    if v319 and v319:IsA("Model") then
        v319 = game.Players:GetPlayerFromCharacter(v319);
    end;
    v8:FireClientConnection(v319, "RevealPlayerAura", "REMOTE_EVENT", v320, v321, v322);
end;
v0.RemovePlayerAuraFrom = function(_, v324, v325) --[[ Line: 1187 ]] --[[ Name: RemovePlayerAuraFrom ]]
    -- upvalues: v6 (copy), v8 (copy), v5 (copy), l_Debris_0 (copy), l_TweenService_0 (copy)
    if not v324 then
        return;
    elseif v6 then
        if v325 then
            v8:FireClientConnection(v325, "RemovePlayerAura", "REMOTE_EVENT", v324);
            return;
        else
            v8:FireAllClientConnection("RemovePlayerAura", "REMOTE_EVENT", v324);
            return;
        end;
    else
        if v5 then
            local v326 = v324 and v324.Character;
            local l_Character_2 = game.Players.LocalPlayer.Character;
            if v326 then
                local l_PlayerAura_1 = v326:FindFirstChild("PlayerAura");
                if l_PlayerAura_1 and tostring(l_Character_2.Parent) ~= tostring(v326.Parent) then
                    l_PlayerAura_1.Name = "goodbai";
                    l_Debris_0:AddItem(l_PlayerAura_1, 1);
                    l_TweenService_0:Create(l_PlayerAura_1, TweenInfo.new(1), {
                        FillTransparency = 1, 
                        OutlineTransparency = 1
                    }):Play();
                end;
            end;
        end;
        return;
    end;
end;
v0.GetClosestPlayerFromPosition = function(_, v330, v331) --[[ Line: 1212 ]] --[[ Name: GetClosestPlayerFromPosition ]]
    v331 = v331 or {};
    v331.MaxDistance = v331.MaxDistance or 9999;
    v331.PlayerSelection = v331.PlayerSelection or "Survivors";
    local v332 = v331.IncludedSelection or {};
    for _, v334 in pairs(workspace.Players:GetChildren()) do
        if (v331.PlayerSelection == "All" or v334.Name == v331.PlayerSelection) and v334.Name ~= "Spectating" then
            for _, v336 in pairs(v334:GetChildren()) do
                if not v336:GetAttribute("Undetectable") or v331.OverrideUndetectable then
                    table.insert(v332, v336);
                end;
            end;
        end;
    end;
    local v337 = {};
    for _, v339 in pairs(v332) do
        local v340 = v339.PrimaryPart and (v339.PrimaryPart.Position - v330).Magnitude;
        if v340 and v339.Humanoid.Health > 0 and (tonumber(v331.MaxDistance) or 999) >= v340 then
            table.insert(v337, {
                Player = v339, 
                Distance = v340
            });
        end;
    end;
    table.sort(v337, function(v341, v342) --[[ Line: 1239 ]]
        return v341.Distance < v342.Distance;
    end);
    if v331.ReturnTable then
        return v337;
    else
        local v343 = v337[1];
        if v343 then
            return v343.Player, v343.Distance;
        else
            return;
        end;
    end;
end;
v0.OnPlayingStateChanged = function(v344) --[[ Line: 1254 ]] --[[ Name: OnPlayingStateChanged ]]
    local l_LocalPlayer_4 = game.Players.LocalPlayer;
    local v346 = l_LocalPlayer_4.Character or l_LocalPlayer_4.CharacterAdded:Wait();
    task.spawn(v344, (tostring(v346.Parent)));
    v346:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 1258 ]]
        -- upvalues: v344 (copy), v346 (copy)
        v344((tostring(v346.Parent)));
    end);
end;
v0.OnPlayerAdded = function(v347) --[[ Line: 1264 ]] --[[ Name: OnPlayerAdded ]]
    for _, v349 in pairs(game.Players:GetPlayers()) do
        task.spawn(v347, v349);
    end;
    game.Players.PlayerAdded:Connect(v347);
end;
v0.OnCharacterAdded = function(v350) --[[ Line: 1271 ]] --[[ Name: OnCharacterAdded ]]
    -- upvalues: v0 (copy)
    v0.OnPlayerAdded(function(v351) --[[ Line: 1272 ]]
        -- upvalues: v350 (copy)
        if v351.Character then
            v350(v351.Character, v351);
        end;
        v351.CharacterAdded:Connect(function() --[[ Line: 1276 ]]
            -- upvalues: v350 (ref), v351 (copy)
            v350(v351.Character, v351);
        end);
    end);
end;
v0.ValueBaseToTable = function(_, v353) --[[ Line: 1282 ]] --[[ Name: ValueBaseToTable ]]
    local v354 = {};
    local function v355(v356, v357) --[[ Line: 1285 ]] --[[ Name: recurse ]]
        -- upvalues: v355 (copy)
        for _, v359 in pairs(v356:GetChildren()) do
            local l_Name_0 = v359.Name;
            if v359:IsA("Folder") then
                v357[l_Name_0] = {};
                v355(v359, v357[l_Name_0]);
            else
                v357[l_Name_0] = v359.Value;
            end;
        end;
    end;
    v355(v353, v354);
    return v354;
end;
v0.ValueTableToBase = function(_, v362, v363, v364) --[[ Line: 1301 ]] --[[ Name: ValueTableToBase ]]
    local v365 = {
        number = "IntValue", 
        boolean = "BoolValue", 
        string = "StringValue"
    };
    local function v366(v367, v368) --[[ Line: 1308 ]] --[[ Name: recurse ]]
        -- upvalues: v364 (copy), v366 (copy), v365 (copy)
        for v369, v370 in pairs(v367) do
            if typeof(v370) == "table" and (not v364 or not v364[v369]) then
                local l_v368_FirstChild_0 = v368:FindFirstChild(v369);
                if not l_v368_FirstChild_0 then
                    l_v368_FirstChild_0 = Instance.new("Folder");
                    l_v368_FirstChild_0.Name = v369;
                    l_v368_FirstChild_0.Parent = v368;
                end;
                v366(v370, l_v368_FirstChild_0);
            else
                local l_v368_FirstChild_1 = v368:FindFirstChild(v369);
                if not l_v368_FirstChild_1 then
                    local v373 = v365[typeof(v370)];
                    l_v368_FirstChild_1 = Instance.new(v373);
                    l_v368_FirstChild_1.Name = v369;
                end;
                l_v368_FirstChild_1.Value = v370;
                l_v368_FirstChild_1.Parent = v368;
            end;
        end;
    end;
    v366(v362, v363);
end;
return v0;