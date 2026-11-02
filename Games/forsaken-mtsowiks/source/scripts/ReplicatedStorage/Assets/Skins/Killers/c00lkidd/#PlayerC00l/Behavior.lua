-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:08:32 2025 ]]
return {
    GetRig = function(_, v1) --[[ Line: 4 ]] --[[ Name: GetRig ]]
        local v2 = v1.Rig:Clone();
        v2.Parent = workspace;
        v2:SetPrimaryPartCFrame(CFrame.new(0, 100000, 0));
        pcall(function() --[[ Line: 11 ]]
            -- upvalues: v1 (copy), v2 (copy)
            local l_HumanoidDescriptionFromUserId_0 = game.Players:GetHumanoidDescriptionFromUserId(v1.Player.UserId);
            l_HumanoidDescriptionFromUserId_0.Head = 0;
            l_HumanoidDescriptionFromUserId_0.Face = 0;
            v2.Humanoid:ApplyDescription(l_HumanoidDescriptionFromUserId_0, Enum.AssetTypeVerification.Always);
            for _, v5 in pairs(v2:GetChildren()) do
                if v5:IsA("CharacterMesh") and v5.MeshId ~= 48112070 then
                    v5:Destroy();
                end;
            end;
            for _, v7 in pairs(v2:GetDescendants()) do
                if v7:IsA("ParticleEmitter") and (v7.Name == "Number" or v7.Name == "Aura") then
                    v7.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, l_HumanoidDescriptionFromUserId_0.TorsoColor), 
                        ColorSequenceKeypoint.new(1, l_HumanoidDescriptionFromUserId_0.TorsoColor)
                    });
                end;
            end;
        end);
        return v2;
    end, 
    OnExecution = function(_, v9, v10) --[[ Line: 34 ]] --[[ Name: OnExecution ]]
        local l_NewModelC00lGUIRig_0 = v9.Rig.NewModelC00lGUIRig;
        local l_A_0 = l_NewModelC00lGUIRig_0.Top.A;
        local l_Button_0 = l_NewModelC00lGUIRig_0.Bottom.Button;
        local v14 = v10.Name == "007n7";
        if v14 then
            local l_RoundManager_0 = game.ServerScriptService.Server.Systems.Core.RoundManager;
            local v16 = require(l_RoundManager_0);
            if v16.CurrentSession and v16.CurrentSession.TimePast then
                local l_CurrentSession_0 = v16.CurrentSession;
                l_CurrentSession_0.TimePast = l_CurrentSession_0.TimePast - 2.5;
            end;
        end;
        local function v22(v18, v19) --[[ Line: 51 ]] --[[ Name: emitVFX ]]
            -- upvalues: v14 (copy)
            for _, v21 in pairs(v18:GetDescendants()) do
                if v21:IsA("ParticleEmitter") or v21:IsA("Beam") then
                    if v19 == "Emit" then
                        if not v14 or not v21:GetAttribute("DisabledWhenLoved") then
                            v21:Emit(v21:GetAttribute("EmitCount") or 1);
                        end;
                    else
                        v21.Enabled = v19;
                    end;
                end;
            end;
        end;
        task.delay(v14 and 1.866 or 2.166, function() --[[ Line: 66 ]]
            -- upvalues: v22 (copy), l_A_0 (copy)
            v22(l_A_0, true);
        end);
        task.delay(v14 and 2.5 or 3.085, function() --[[ Line: 71 ]]
            -- upvalues: v10 (copy), v14 (copy), v22 (copy), l_Button_0 (copy), v9 (copy)
            for _, v24 in pairs(v10:GetDescendants()) do
                local v25 = nil;
                if v24:IsA("BasePart") and v24.Transparency < 0.5 then
                    v25 = {
                        Color = Color3.new()
                    };
                    local l_Fire_0 = Instance.new("Fire");
                    l_Fire_0.Color = Color3.new(1, 0.575, 0.575);
                    l_Fire_0.SecondaryColor = Color3.new(1, 0, 0);
                    l_Fire_0.Heat = 0;
                    l_Fire_0.Size = 0;
                    l_Fire_0.Parent = v24;
                    game.TweenService:Create(l_Fire_0, TweenInfo.new(v14 and 5 or 0.5), {
                        Heat = 3, 
                        Size = 3
                    }):Play();
                elseif v24:IsA("Shirt") or v24:IsA("Pants") then
                    v25 = {
                        Color3 = Color3.new(0.3, 0.2, 0.2)
                    };
                end;
                if v25 then
                    game.TweenService:Create(v24, TweenInfo.new(v14 and 4 or 1.25, v14 and Enum.EasingStyle.Linear or Enum.EasingStyle.Quint), v25):Play();
                end;
            end;
            v22(l_Button_0, "Emit");
            local l_PrimaryPart_0 = v9.Rig.PrimaryPart;
            local l_Torso_0 = v10:FindFirstChild("Torso");
            if l_Torso_0 and l_PrimaryPart_0 then
                local v29 = v9.Config.FireVFX:Clone();
                v29.Parent = workspace.Map.Ingame;
                v29.Position = Vector3.new(l_Torso_0.Position.X, l_PrimaryPart_0.Position.Y - (v14 and 0 or 3.275), l_Torso_0.Position.Z);
                game.Debris:AddItem(v29, 5);
                v22(v29, "Emit");
            end;
            local l_Humanoid_0 = v10:FindFirstChild("Humanoid");
            if l_Humanoid_0 then
                l_Humanoid_0.Health = 0.01;
            end;
        end);
        task.delay(v14 and 6.085 or 3.4, function() --[[ Line: 115 ]]
            -- upvalues: v10 (copy), v14 (copy)
            local l_PrimaryPart_1 = v10.PrimaryPart;
            local l_Humanoid_1 = v10:FindFirstChild("Humanoid");
            require(game.ReplicatedStorage.Modules.Ragdolls).AddProfile(v10, {
                Velocity = Vector3.new(0, v14 and 0 or 12, 0)
            });
            if l_PrimaryPart_1 then
                l_PrimaryPart_1.Anchored = false;
            end;
            if l_Humanoid_1 then
                l_Humanoid_1.BreakJointsOnDeath = false;
                l_Humanoid_1.Health = 0;
            end;
        end);
        task.delay(v14 and 3.433 or 3.5, function() --[[ Line: 133 ]]
            -- upvalues: v22 (copy), l_A_0 (copy)
            v22(l_A_0, false);
        end);
    end
};