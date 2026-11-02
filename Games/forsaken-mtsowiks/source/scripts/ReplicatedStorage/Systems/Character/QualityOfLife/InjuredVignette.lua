-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_TweenService_0 = game:GetService("TweenService");
return {
    Start = function(_) --[[ Line: 5 ]] --[[ Name: Start ]]
        -- upvalues: l_TweenService_0 (copy)
        task.spawn(function() --[[ Line: 6 ]]
            -- upvalues: l_TweenService_0 (ref)
            local l_LocalPlayer_0 = game.Players.LocalPlayer;
            local l_Character_0 = l_LocalPlayer_0.Character;
            if not l_Character_0 then
                return;
            else
                local v4 = l_Character_0:WaitForChild("Humanoid", 15);
                if not v4 then
                    return;
                else
                    local l_InjuredVignette_0 = l_LocalPlayer_0.PlayerData.Settings.Customization.InjuredVignette;
                    local v6 = script.injuredVignette:Clone();
                    v6.Parent = l_LocalPlayer_0.PlayerGui.TemporaryUI;
                    local v7 = script.redFlash:Clone();
                    v7.Parent = l_LocalPlayer_0.PlayerGui.TemporaryUI;
                    v7.ImageTransparency = 1;
                    local v8 = nil;
                    local v9 = false;
                    local l_MaxHealth_0 = v4.MaxHealth;
                    local v11 = 1;
                    local function v18(v12) --[[ Line: 28 ]] --[[ Name: updateVignette ]]
                        -- upvalues: v4 (copy), v8 (ref), l_InjuredVignette_0 (copy), v6 (copy), l_MaxHealth_0 (ref), v11 (ref), v7 (copy), l_TweenService_0 (ref), v9 (ref)
                        if not v12 then
                            v12 = math.clamp(v4.Health - (v4:GetAttribute("FakeDamage") or 0), 0, v4.MaxHealth);
                        end;
                        if v8 then
                            v8:Cancel();
                        end;
                        if not l_InjuredVignette_0.Value then
                            v6.ImageTransparency = 1;
                            return;
                        else
                            if v12 < l_MaxHealth_0 then
                                v6.ImageTransparency = 1 - (l_MaxHealth_0 - v12) / v4.MaxHealth;
                                v6.ImageColor3 = Color3.fromRGB(100, 0, 0);
                            end;
                            local v13 = v12 / v4.MaxHealth;
                            if v13 < v11 then
                                local v14 = v11 - v13;
                                v7.ImageTransparency = math.clamp(0.5 - v14 * 2, 0, 1);
                                v7.Size = UDim2.fromScale(math.max(0, 0.5 - v14) / 3 + 1.2, math.max(0, 0.5 - v14) / 3 + 1.2);
                                v7.ImageColor3 = Color3.new(v13 / 2 + 0.5, v13 / 2 + 0.5, v13 / 2 + 0.5);
                                l_TweenService_0:Create(v7, TweenInfo.new((v14 + 0.35) / 1.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                    ImageTransparency = 1, 
                                    Size = UDim2.fromScale(1.1, 1.1)
                                }):Play();
                            end;
                            v11 = v13;
                            if v12 <= v4.MaxHealth / 3 and not v9 then
                                v9 = true;
                                task.spawn(function() --[[ Line: 62 ]]
                                    -- upvalues: v9 (ref), v6 (ref), v4 (ref), l_TweenService_0 (ref)
                                    while true do
                                        if task.wait(1) and v9 and v6.Parent and v4.Health > 0 then
                                            local v15 = math.clamp(v4.Health - (v4:GetAttribute("FakeDamage") or 0), 0, v4.MaxHealth);
                                            if v4.MaxHealth / 3 < v15 then
                                                v9 = false;
                                                return;
                                            else
                                                local v16 = math.clamp(v15 / v4.MaxHealth * 2, 0, 1);
                                                v6.ImageColor3 = Color3.fromRGB(80, 0, 0);
                                                v6.ImageTransparency = v16 - 0.425;
                                                l_TweenService_0:Create(v6, TweenInfo.new(0.3), {
                                                    ImageTransparency = v16, 
                                                    ImageColor3 = Color3.fromRGB(66, 0, 0)
                                                }):Play();
                                            end;
                                        else
                                            return;
                                        end;
                                    end;
                                end);
                            end;
                            local v17 = math.clamp(v12 / v4.MaxHealth * 2, 0, 1);
                            v8 = l_TweenService_0:Create(v6, TweenInfo.new(0.3), {
                                ImageTransparency = v17, 
                                ImageColor3 = Color3.fromRGB(66, 0, 0)
                            });
                            v8:Play();
                            l_MaxHealth_0 = v12;
                            if v12 <= 0 then
                                task.delay(1, function() --[[ Line: 82 ]]
                                    -- upvalues: l_TweenService_0 (ref), v6 (ref)
                                    l_TweenService_0:Create(v6, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                        ImageTransparency = 1
                                    }):Play();
                                end);
                            end;
                            return;
                        end;
                    end;
                    v18(v4.Health);
                    v4.HealthChanged:Connect(v18);
                    v4:GetPropertyChangedSignal("MaxHealth"):Connect(v18);
                    v4:GetAttributeChangedSignal("FakeDamage"):Connect(v18);
                    return;
                end;
            end;
        end);
    end, 
    Destroy = function(_) --[[ Line: 96 ]] --[[ Name: Destroy ]]

    end
};