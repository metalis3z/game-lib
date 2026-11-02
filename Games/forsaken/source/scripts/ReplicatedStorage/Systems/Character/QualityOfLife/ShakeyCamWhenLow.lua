-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.Start = function(_) --[[ Line: 4 ]] --[[ Name: Start ]]
    -- upvalues: v0 (copy)
    task.spawn(function() --[[ Line: 5 ]]
        -- upvalues: v0 (ref)
        local l_CurrentCamera_0 = workspace.CurrentCamera;
        local l_LocalPlayer_0 = game.Players.LocalPlayer;
        local l_Character_0 = l_LocalPlayer_0.Character;
        if not l_Character_0 then
            return;
        else
            local v5 = l_Character_0:WaitForChild("Humanoid", 15);
            if not v5 then
                return;
            else
                local v6 = l_Character_0:WaitForChild("Head", 10);
                v6 = v6:IsA("Model") and v6.PrimaryPart or v6;
                local l_ScreenShakeEnabled_0 = l_LocalPlayer_0.PlayerData.Settings.Customization.ScreenShakeEnabled;
                local l_ScreenShakeOnLow_0 = l_LocalPlayer_0.PlayerData.Settings.Customization.ScreenShakeOnLow;
                local function _(v9) --[[ Line: 21 ]] --[[ Name: calculateShakeIntensity ]]
                    -- upvalues: v5 (copy)
                    if v5.MaxHealth / 2 <= v9 then
                        return 0;
                    else
                        return 1.5 * (1 - v9 / (v5.MaxHealth / 2));
                    end;
                end;
                local v11 = 0;
                v0.Connection = game["Run Service"]:BindToRenderStep("ShakeyCamera", Enum.RenderPriority.Camera.Value + 10, function(v12) --[[ Line: 30 ]]
                    -- upvalues: v5 (copy), v6 (ref), l_ScreenShakeEnabled_0 (copy), l_ScreenShakeOnLow_0 (copy), v11 (ref), l_CurrentCamera_0 (copy)
                    local v13 = v5.Health - (v5:GetAttribute("FakeDamage") or 0);
                    local l_MaxHealth_0 = v5.MaxHealth;
                    if (not v6 or v6.LocalTransparencyModifier < 0.5) and v13 < l_MaxHealth_0 * (l_MaxHealth_0 / 2 / 100) and v13 > 0 and l_ScreenShakeEnabled_0.Value and l_ScreenShakeOnLow_0.Value then
                        v11 = v11 + v12;
                        local v15 = v5.MaxHealth / 2 <= v13 and 0 or 1.5 * (1 - v13 / (v5.MaxHealth / 2));
                        local v16 = math.sin(v11 * 2.5) * v15;
                        local v17 = math.cos(v11 * 2.5) * v15;
                        local v18 = math.sin(v11 * 2.5 * 0.5) * v15;
                        local v19 = Random.new();
                        v16 = (v16 + (v19:NextNumber() - 0.5) * 0.3) * v15;
                        v17 = (v17 + (v19:NextNumber() - 0.5) * 0.3) * v15;
                        v18 = (v18 + (v19:NextNumber() - 0.5) * 0.3) * v15;
                        local v20 = CFrame.new(v16 * 0.1, v17 * 0.1, v18 * 0.1);
                        local l_l_CurrentCamera_0_0 = l_CurrentCamera_0;
                        l_l_CurrentCamera_0_0.CFrame = l_l_CurrentCamera_0_0.CFrame * v20;
                    end;
                end);
                return;
            end;
        end;
    end);
end;
v0.Destroy = function(_) --[[ Line: 58 ]] --[[ Name: Destroy ]]
    game["Run Service"]:UnbindFromRenderStep("ShakeyCamera");
end;
return v0;