-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    OnExecution = function(_, v1, v2) --[[ Line: 4 ]] --[[ Name: OnExecution ]]
        local l_NewModelC00lGUIRig_0 = v1.Rig.NewModelC00lGUIRig;
        local l_A_0 = l_NewModelC00lGUIRig_0.Top.A;
        local l_Button_0 = l_NewModelC00lGUIRig_0.Bottom.Button;
        local v6 = v2.Name == "007n7";
        if v6 then
            local l_RoundManager_0 = game.ServerScriptService.Server.Systems.Core.RoundManager;
            local v8 = require(l_RoundManager_0);
            if v8.CurrentSession and v8.CurrentSession.TimePast then
                local l_CurrentSession_0 = v8.CurrentSession;
                l_CurrentSession_0.TimePast = l_CurrentSession_0.TimePast - 2.5;
            end;
        end;
        local function v14(v10, v11) --[[ Line: 21 ]] --[[ Name: emitVFX ]]
            -- upvalues: v6 (copy)
            for _, v13 in pairs(v10:GetDescendants()) do
                if v13:IsA("ParticleEmitter") or v13:IsA("Beam") then
                    if v11 == "Emit" then
                        if not v6 or not v13:GetAttribute("DisabledWhenLoved") then
                            v13:Emit(v13:GetAttribute("EmitCount") or 1);
                        end;
                    else
                        v13.Enabled = v11;
                    end;
                end;
            end;
        end;
        task.delay(v6 and 1.866 or 2.166, function() --[[ Line: 36 ]]
            -- upvalues: v14 (copy), l_A_0 (copy)
            v14(l_A_0, true);
        end);
        task.delay(v6 and 2.5 or 3.085, function() --[[ Line: 41 ]]
            -- upvalues: v2 (copy), v6 (copy), v14 (copy), l_Button_0 (copy), v1 (copy)
            for _, v16 in pairs(v2:GetDescendants()) do
                local v17 = nil;
                if v16:IsA("BasePart") and v16.Transparency < 0.5 then
                    v17 = {
                        Color = Color3.new()
                    };
                    local l_Fire_0 = Instance.new("Fire");
                    l_Fire_0.Color = Color3.new(1, 0.575, 0.575);
                    l_Fire_0.SecondaryColor = Color3.new(1, 0, 0);
                    l_Fire_0.Heat = 0;
                    l_Fire_0.Size = 0;
                    l_Fire_0.Parent = v16;
                    game.TweenService:Create(l_Fire_0, TweenInfo.new(v6 and 5 or 0.5), {
                        Heat = 3, 
                        Size = 3
                    }):Play();
                elseif v16:IsA("Shirt") or v16:IsA("Pants") then
                    v17 = {
                        Color3 = Color3.new(0.3, 0.2, 0.2)
                    };
                end;
                if v17 then
                    game.TweenService:Create(v16, TweenInfo.new(v6 and 4 or 1.25, v6 and Enum.EasingStyle.Linear or Enum.EasingStyle.Quint), v17):Play();
                end;
            end;
            v14(l_Button_0, "Emit");
            local l_PrimaryPart_0 = v1.Rig.PrimaryPart;
            local l_Torso_0 = v2:FindFirstChild("Torso");
            if l_Torso_0 and l_PrimaryPart_0 then
                local v21 = v1.Config.FireVFX:Clone();
                v21.Parent = workspace.Map.Ingame;
                v21.Position = Vector3.new(l_Torso_0.Position.X, l_PrimaryPart_0.Position.Y - (v6 and 0 or 3.275), l_Torso_0.Position.Z);
                game.Debris:AddItem(v21, 5);
                v14(v21, "Emit");
            end;
            local l_Humanoid_0 = v2:FindFirstChild("Humanoid");
            if l_Humanoid_0 then
                l_Humanoid_0.Health = 0.01;
            end;
        end);
        task.delay(v6 and 6.085 or 3.4, function() --[[ Line: 85 ]]
            -- upvalues: v2 (copy), v6 (copy)
            local l_PrimaryPart_1 = v2.PrimaryPart;
            local l_Humanoid_1 = v2:FindFirstChild("Humanoid");
            require(game.ReplicatedStorage.Modules.Ragdolls).AddProfile(v2, {
                Velocity = Vector3.new(0, v6 and 0 or 12, 0)
            });
            if l_PrimaryPart_1 then
                l_PrimaryPart_1.Anchored = false;
            end;
            if l_Humanoid_1 then
                l_Humanoid_1.BreakJointsOnDeath = false;
                l_Humanoid_1.Health = 0;
            end;
        end);
        task.delay(v6 and 3.433 or 3.5, function() --[[ Line: 103 ]]
            -- upvalues: v14 (copy), l_A_0 (copy)
            v14(l_A_0, false);
        end);
    end
};