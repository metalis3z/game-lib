-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.Start = function(_) --[[ Line: 4 ]] --[[ Name: Start ]]
    -- upvalues: v0 (copy)
    task.delay(1, function() --[[ Line: 6 ]]
        -- upvalues: v0 (ref)
        local l_LocalPlayer_0 = game.Players.LocalPlayer;
        local l_Character_0 = l_LocalPlayer_0.Character;
        if l_Character_0 and tostring(l_Character_0.Parent) == "Killers" then
            local function v12(v4) --[[ Line: 11 ]] --[[ Name: onSurvivorAdded ]]
                -- upvalues: l_Character_0 (copy), l_LocalPlayer_0 (copy)
                local v5 = v4:WaitForChild("Humanoid", 10);
                if v5 then
                    v5.Died:Connect(function() --[[ Line: 14 ]]
                        -- upvalues: v4 (copy), l_Character_0 (ref), l_LocalPlayer_0 (ref), v5 (copy)
                        local l_PrimaryPart_0 = v4.PrimaryPart;
                        if not l_Character_0.PrimaryPart or not l_Character_0.Parent then
                            return;
                        elseif l_PrimaryPart_0 and (l_PrimaryPart_0.Position - l_Character_0.PrimaryPart.Position).Magnitude >= 40 then
                            return;
                        elseif not l_LocalPlayer_0.PlayerData.Settings.Customization.HitboxEffectsEnabled.Value then
                            return;
                        elseif v5:GetAttribute("Killed") then
                            return;
                        else
                            v5:SetAttribute("Killed", true);
                            local l_Value_0 = l_LocalPlayer_0.PlayerData.Settings.Accessibility.EpilepsyMode.Value;
                            local v8 = l_Value_0 and Color3.fromRGB(255, 100, 100) or Color3.fromRGB(255, 20, 20);
                            local v9 = l_Value_0 and 0.5 or 2;
                            local l_ColorCorrectionEffect_0 = Instance.new("ColorCorrectionEffect");
                            l_ColorCorrectionEffect_0.Contrast = v9;
                            l_ColorCorrectionEffect_0.TintColor = v8;
                            l_ColorCorrectionEffect_0.Parent = game.Lighting;
                            game.TweenService:Create(l_ColorCorrectionEffect_0, TweenInfo.new(1), {
                                Contrast = 0, 
                                TintColor = Color3.new(1, 1, 1)
                            }):Play();
                            game.Debris:AddItem(l_ColorCorrectionEffect_0, 1);
                            local l_FOVMultiplier_0 = require(game.ReplicatedStorage.Modules.Util):CreateFOVMultiplier(l_Character_0, 0.85, "SurvivorKilled");
                            game.TweenService:Create(l_FOVMultiplier_0, TweenInfo.new(1), {
                                Value = 1
                            }):Play();
                            game.Debris:AddItem(l_FOVMultiplier_0, 1);
                            return;
                        end;
                    end);
                end;
            end;
            if v0.Connection then
                v0.Connection:Disconnect();
                v0.Connection = nil;
            end;
            v0.Connection = workspace.Players.Survivors.ChildAdded:Connect(v12);
            for _, v14 in pairs(workspace.Players.Survivors:GetChildren()) do
                local v15 = v14:WaitForChild("Humanoid", 10);
                if v15 then
                    v15.Died:Connect(function() --[[ Line: 14 ]]
                        -- upvalues: v14 (copy), l_Character_0 (copy), l_LocalPlayer_0 (copy), v15 (copy)
                        local l_PrimaryPart_1 = v14.PrimaryPart;
                        if not l_Character_0.PrimaryPart or not l_Character_0.Parent then
                            return;
                        elseif l_PrimaryPart_1 and (l_PrimaryPart_1.Position - l_Character_0.PrimaryPart.Position).Magnitude >= 40 then
                            return;
                        elseif not l_LocalPlayer_0.PlayerData.Settings.Customization.HitboxEffectsEnabled.Value then
                            return;
                        elseif v15:GetAttribute("Killed") then
                            return;
                        else
                            v15:SetAttribute("Killed", true);
                            local l_Value_1 = l_LocalPlayer_0.PlayerData.Settings.Accessibility.EpilepsyMode.Value;
                            local v18 = l_Value_1 and Color3.fromRGB(255, 100, 100) or Color3.fromRGB(255, 20, 20);
                            local v19 = l_Value_1 and 0.5 or 2;
                            local l_ColorCorrectionEffect_1 = Instance.new("ColorCorrectionEffect");
                            l_ColorCorrectionEffect_1.Contrast = v19;
                            l_ColorCorrectionEffect_1.TintColor = v18;
                            l_ColorCorrectionEffect_1.Parent = game.Lighting;
                            game.TweenService:Create(l_ColorCorrectionEffect_1, TweenInfo.new(1), {
                                Contrast = 0, 
                                TintColor = Color3.new(1, 1, 1)
                            }):Play();
                            game.Debris:AddItem(l_ColorCorrectionEffect_1, 1);
                            local l_FOVMultiplier_1 = require(game.ReplicatedStorage.Modules.Util):CreateFOVMultiplier(l_Character_0, 0.85, "SurvivorKilled");
                            game.TweenService:Create(l_FOVMultiplier_1, TweenInfo.new(1), {
                                Value = 1
                            }):Play();
                            game.Debris:AddItem(l_FOVMultiplier_1, 1);
                            return;
                        end;
                    end);
                end;
            end;
        end;
    end);
end;
return v0;