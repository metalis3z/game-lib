-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Start = function(_) --[[ Line: 4 ]] --[[ Name: Start ]]
        task.spawn(function() --[[ Line: 5 ]]
            local l_LocalPlayer_0 = game.Players.LocalPlayer;
            local l_Character_0 = l_LocalPlayer_0.Character;
            if not l_Character_0 then
                return;
            else
                local v3 = l_Character_0:WaitForChild("Humanoid", 15);
                if not v3 then
                    return;
                else
                    local l_InjuredVignette_0 = l_LocalPlayer_0.PlayerData.Settings.Customization.InjuredVignette;
                    local v5 = script.injuredVignette:Clone();
                    v5.Parent = l_LocalPlayer_0.PlayerGui.TemporaryUI;
                    local v6 = nil;
                    local v7 = false;
                    local l_MaxHealth_0 = v3.MaxHealth;
                    local function v12(v9) --[[ Line: 21 ]] --[[ Name: updateVignette ]]
                        -- upvalues: v3 (copy), v6 (ref), l_InjuredVignette_0 (copy), v5 (copy), l_MaxHealth_0 (ref), v7 (ref)
                        if not v9 then
                            v9 = v3.Health;
                        end;
                        if v6 then
                            v6:Cancel();
                        end;
                        if not l_InjuredVignette_0.Value then
                            v5.ImageTransparency = 1;
                            return;
                        else
                            if v9 < l_MaxHealth_0 then
                                v5.ImageTransparency = 1 - (l_MaxHealth_0 - v9) / v3.MaxHealth;
                                v5.ImageColor3 = Color3.fromRGB(100, 0, 0);
                            end;
                            if v9 <= v3.MaxHealth / 3 and not v7 then
                                v7 = true;
                                task.spawn(function() --[[ Line: 38 ]]
                                    -- upvalues: v7 (ref), v5 (ref), v3 (ref)
                                    while true do
                                        if task.wait(1) and v7 and v5.Parent and v3.Health > 0 then
                                            if v3.Health > v3.MaxHealth / 3 then
                                                v7 = false;
                                                return;
                                            else
                                                local v10 = math.clamp(v3.Health / v3.MaxHealth * 2, 0, 1);
                                                v5.ImageColor3 = Color3.fromRGB(80, 0, 0);
                                                v5.ImageTransparency = v10 - 0.425;
                                                game.TweenService:Create(v5, TweenInfo.new(0.3), {
                                                    ImageTransparency = v10, 
                                                    ImageColor3 = Color3.fromRGB(66, 0, 0)
                                                }):Play();
                                            end;
                                        else
                                            return;
                                        end;
                                    end;
                                end);
                            end;
                            local v11 = math.clamp(v9 / v3.MaxHealth * 2, 0, 1);
                            v6 = game.TweenService:Create(v5, TweenInfo.new(0.3), {
                                ImageTransparency = v11, 
                                ImageColor3 = Color3.fromRGB(66, 0, 0)
                            });
                            v6:Play();
                            l_MaxHealth_0 = v9;
                            if v9 <= 0 then
                                task.delay(1, function() --[[ Line: 57 ]]
                                    -- upvalues: v5 (ref)
                                    game.TweenService:Create(v5, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                        ImageTransparency = 1
                                    }):Play();
                                end);
                            end;
                            return;
                        end;
                    end;
                    v12(v3.Health);
                    v3.HealthChanged:Connect(v12);
                    v3:GetPropertyChangedSignal("MaxHealth"):Connect(v12);
                    return;
                end;
            end;
        end);
    end, 
    Destroy = function(_) --[[ Line: 70 ]] --[[ Name: Destroy ]]

    end
};