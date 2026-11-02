-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:08:30 2025 ]]
local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Schematics.Lighting);
v0.OnExecution = function(_, v3, v4) --[[ Line: 5 ]] --[[ Name: OnExecution ]]
    local l_NewModelC00lGUIRig_0 = v3.Rig.NewModelC00lGUIRig;
    local l_A_0 = l_NewModelC00lGUIRig_0.Top.A;
    local l_Button_0 = l_NewModelC00lGUIRig_0.Bottom.Button;
    local v8 = v4.Name == "007n7";
    if v8 then
        local l_RoundManager_0 = game.ServerScriptService.Server.Systems.Core.RoundManager;
        local v10 = require(l_RoundManager_0);
        if v10.CurrentSession and v10.CurrentSession.TimePast then
            local l_CurrentSession_0 = v10.CurrentSession;
            l_CurrentSession_0.TimePast = l_CurrentSession_0.TimePast - 2.5;
        end;
    end;
    local function v16(v12, v13) --[[ Line: 22 ]] --[[ Name: emitVFX ]]
        -- upvalues: v8 (copy)
        for _, v15 in pairs(v12:GetDescendants()) do
            if v15:IsA("ParticleEmitter") or v15:IsA("Beam") then
                if v13 == "Emit" then
                    if not v8 or not v15:GetAttribute("DisabledWhenLoved") then
                        v15:Emit(v15:GetAttribute("EmitCount") or 1);
                    end;
                else
                    v15.Enabled = v13;
                end;
            end;
        end;
    end;
    task.delay(v8 and 1.866 or 2.166, function() --[[ Line: 37 ]]
        -- upvalues: v16 (copy), l_A_0 (copy)
        v16(l_A_0, true);
    end);
    task.delay(v8 and 2.5 or 3.085, function() --[[ Line: 42 ]]
        -- upvalues: v4 (copy), v8 (copy), v16 (copy), l_Button_0 (copy), v3 (copy)
        for _, v18 in pairs(v4:GetDescendants()) do
            local v19 = nil;
            if v18:IsA("BasePart") and v18.Transparency < 0.5 then
                v19 = {
                    Color = Color3.new()
                };
                local l_Fire_0 = Instance.new("Fire");
                l_Fire_0.Color = Color3.new(1, 0.575, 0.575);
                l_Fire_0.SecondaryColor = Color3.new(1, 0, 0);
                l_Fire_0.Heat = 0;
                l_Fire_0.Size = 0;
                l_Fire_0.Parent = v18;
                game.TweenService:Create(l_Fire_0, TweenInfo.new(v8 and 5 or 0.5), {
                    Heat = 3, 
                    Size = 3
                }):Play();
            elseif v18:IsA("Shirt") or v18:IsA("Pants") then
                v19 = {
                    Color3 = Color3.new(0.3, 0.2, 0.2)
                };
            end;
            if v19 then
                game.TweenService:Create(v18, TweenInfo.new(v8 and 4 or 1.25, v8 and Enum.EasingStyle.Linear or Enum.EasingStyle.Quint), v19):Play();
            end;
        end;
        v16(l_Button_0, "Emit");
        local l_PrimaryPart_0 = v3.Rig.PrimaryPart;
        local l_Torso_0 = v4:FindFirstChild("Torso");
        if l_Torso_0 and l_PrimaryPart_0 then
            local v23 = v3.Config.FireVFX:Clone();
            v23.Parent = workspace.Map.Ingame;
            v23.Position = Vector3.new(l_Torso_0.Position.X, l_PrimaryPart_0.Position.Y - (v8 and 0 or 3.275), l_Torso_0.Position.Z);
            game.Debris:AddItem(v23, 5);
            v16(v23, "Emit");
        end;
        local l_Humanoid_0 = v4:FindFirstChild("Humanoid");
        if l_Humanoid_0 then
            l_Humanoid_0.Health = 0.01;
        end;
    end);
    task.delay(v8 and 6.085 or 3.4, function() --[[ Line: 86 ]]
        -- upvalues: v4 (copy), v8 (copy)
        local l_PrimaryPart_1 = v4.PrimaryPart;
        local l_Humanoid_1 = v4:FindFirstChild("Humanoid");
        require(game.ReplicatedStorage.Modules.Ragdolls).AddProfile(v4, {
            Velocity = Vector3.new(0, v8 and 0 or 12, 0)
        });
        if l_PrimaryPart_1 then
            l_PrimaryPart_1.Anchored = false;
        end;
        if l_Humanoid_1 then
            l_Humanoid_1.BreakJointsOnDeath = false;
            l_Humanoid_1.Health = 0;
        end;
    end);
    task.delay(v8 and 3.433 or 3.5, function() --[[ Line: 104 ]]
        -- upvalues: v16 (copy), l_A_0 (copy)
        v16(l_A_0, false);
    end);
end;
v0.WalkspeedStart = function(v27) --[[ Line: 110 ]] --[[ Name: WalkspeedStart ]]
    local l_Rig_0 = v27.Rig;
    if not l_Rig_0 then
        return;
    else
        local l_A_1 = l_Rig_0.NewModelC00lGUIRig.Top.A;
        for _, v31 in ipairs(l_A_1:GetChildren()) do
            if v31:IsA("Beam") then
                v31.Enabled = true;
            end;
        end;
        task.delay(2, function() --[[ Line: 123 ]]
            -- upvalues: l_A_1 (copy)
            for _, v33 in ipairs(l_A_1:GetChildren()) do
                if v33:IsA("Beam") then
                    v33.Enabled = false;
                end;
            end;
        end);
        return;
    end;
end;
v0.MinionSummon = function(v34) --[[ Line: 131 ]] --[[ Name: MinionSummon ]]
    local l_Rig_1 = v34.Rig;
    if not l_Rig_1 then
        return;
    else
        local l_A_2 = l_Rig_1.NewModelC00lGUIRig.Top.A;
        for _, v38 in ipairs(l_A_2:GetChildren()) do
            if v38:IsA("Beam") then
                v38.Enabled = true;
            end;
        end;
        task.delay(2, function() --[[ Line: 144 ]]
            -- upvalues: l_A_2 (copy)
            for _, v40 in ipairs(l_A_2:GetChildren()) do
                if v40:IsA("Beam") then
                    v40.Enabled = false;
                end;
            end;
        end);
        return;
    end;
end;
v0.CNStart = function(v41) --[[ Line: 152 ]] --[[ Name: CNStart ]]
    local l_Rig_2 = v41.Rig;
    if not l_Rig_2 then
        return;
    else
        local l_A_3 = l_Rig_2.NewModelC00lGUIRig.Top.A;
        for _, v45 in ipairs(l_A_3:GetChildren()) do
            if v45:IsA("Beam") then
                v45.Enabled = true;
            end;
        end;
        task.delay(2, function() --[[ Line: 165 ]]
            -- upvalues: l_A_3 (copy)
            for _, v47 in ipairs(l_A_3:GetChildren()) do
                if v47:IsA("Beam") then
                    v47.Enabled = false;
                end;
            end;
        end);
        return;
    end;
end;
v0.LastManStanding = function(_, v49, _) --[[ Line: 174 ]] --[[ Name: LastManStanding ]]
    -- upvalues: v1 (copy)
    if game["Run Service"]:IsServer() then
        v1:SetCustomLighting(v49.Config.ELMSLighting);
    end;
end;
return v0;