-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.Start = function(_) --[[ Line: 4 ]] --[[ Name: Start ]]
    -- upvalues: v0 (copy)
    task.spawn(function() --[[ Line: 5 ]]
        -- upvalues: v0 (ref)
        local l_LocalPlayer_0 = game.Players.LocalPlayer;
        local l_Character_0 = l_LocalPlayer_0.Character;
        if not l_Character_0 then
            return;
        else
            local v4 = l_Character_0:WaitForChild("Humanoid", 5);
            if not v4 then
                return;
            else
                local l_Lighting_0 = game:GetService("Lighting");
                local l_ScreenDesaturation_0 = l_LocalPlayer_0.PlayerData.Settings.Customization.ScreenDesaturation;
                local function v10() --[[ Line: 27 ]] --[[ Name: calculateBaselineSaturation ]]
                    -- upvalues: l_Lighting_0 (copy)
                    local v7 = 0;
                    for _, v9 in pairs(l_Lighting_0:GetChildren()) do
                        if v9:IsA("ColorCorrectionEffect") and v9.Name ~= "HealthDesaturation" and not v9:GetAttribute("IgnoredByInjuredSaturation") then
                            v7 = v7 + v9.Saturation;
                        end;
                    end;
                    return v7;
                end;
                local function v15() --[[ Line: 38 ]] --[[ Name: updateDesaturation ]]
                    -- upvalues: v4 (copy), v10 (copy), v0 (ref), l_Lighting_0 (copy), l_ScreenDesaturation_0 (copy)
                    local l_MaxHealth_0 = v4.MaxHealth;
                    local v12 = math.clamp(v4.Health - (v4:GetAttribute("FakeDamage") or 0), 0, l_MaxHealth_0) / l_MaxHealth_0;
                    local v13 = v10();
                    if not v0.DesaturationFX or not v0.DesaturationFX.Parent then
                        v0.DesaturationFX = Instance.new("ColorCorrectionEffect");
                        v0.DesaturationFX.Parent = l_Lighting_0;
                        v0.DesaturationFX.Name = "HealthDesaturation";
                        v0.DesaturationFX.Saturation = 0;
                    end;
                    local v14 = math.min(0, -1 - v13);
                    if v12 <= 0.5 and l_ScreenDesaturation_0.Value then
                        v0.DesaturationFX.Saturation = v14 * (1 - v12 / 0.5);
                        return;
                    else
                        v0.DesaturationFX.Saturation = 0;
                        return;
                    end;
                end;
                v4:GetPropertyChangedSignal("Health"):Connect(v15);
                v4:GetAttributeChangedSignal("FakeDamage"):Connect(v15);
                v15();
                return;
            end;
        end;
    end);
end;
return v0;