-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.Start = function(_) --[[ Line: 4 ]] --[[ Name: Start ]]
    -- upvalues: v0 (copy)
    local l_LocalPlayer_0 = game.Players.LocalPlayer;
    local _ = l_LocalPlayer_0.PlayerGui:WaitForChild("TemporaryUI");
    local function _(v4) --[[ Line: 9 ]] --[[ Name: getSettingValue ]]
        -- upvalues: l_LocalPlayer_0 (copy)
        return l_LocalPlayer_0.PlayerData.Settings.Customization[v4].Value;
    end;
    require(game.ReplicatedStorage.Modules.Network):SetConnection("Hit", "UREMOTE_EVENT", function(v6, v7, v8) --[[ Line: 15 ]]
        -- upvalues: l_LocalPlayer_0 (copy), v0 (ref)
        v7 = v7 and Vector3.new(v7.X, v7.Y, v7.Z) or Vector3.new();
        local l_Value_0 = l_LocalPlayer_0.PlayerData.Settings.Customization.HitsoundsEnabled.Value;
        local v10 = tonumber(l_LocalPlayer_0.PlayerData.Settings.Customization.HitsoundID.Value);
        if l_Value_0 and v10 then
            require(game.ReplicatedStorage.Modules.Sounds):Play((("rbxassetid://%*"):format((tostring(v10)))));
        end;
        if not l_LocalPlayer_0.PlayerData.Settings.Customization.HitboxEffectsEnabled.Value then
            return;
        else
            if not v8 then
                local l_ColorCorrectionEffect_0 = Instance.new("ColorCorrectionEffect");
                l_ColorCorrectionEffect_0.Contrast = 0.1;
                l_ColorCorrectionEffect_0.TintColor = Color3.fromRGB(255, 230, 230);
                l_ColorCorrectionEffect_0.Parent = game.Lighting;
                game.TweenService:Create(l_ColorCorrectionEffect_0, TweenInfo.new(1), {
                    Contrast = 0, 
                    TintColor = Color3.new(1, 1, 1)
                }):Play();
                game.Debris:AddItem(l_ColorCorrectionEffect_0, 1);
                local l_FOVMultiplier_0 = require(game.ReplicatedStorage.Modules.Util):CreateFOVMultiplier(l_LocalPlayer_0, 0.975, "HitRegistered");
                game.TweenService:Create(l_FOVMultiplier_0, TweenInfo.new(1), {
                    Value = 1
                }):Play();
                game.Debris:AddItem(l_FOVMultiplier_0, 1);
            end;
            if l_LocalPlayer_0.PlayerData.Settings.Customization.HitmarkersEnabled.Value and v6 and v6 > 0 then
                if l_LocalPlayer_0.PlayerData.Settings.Customization.AccumulatedHitmarkers.Value then
                    if v0.CurrentHitmarker then
                        v0.CurrentHitmarker:Destroy();
                    end;
                    if v0.CurrentDamageDealt then
                        v6 = v6 + v0.CurrentDamageDealt;
                    end;
                end;
                v0.CurrentDamageDealt = v6;
                local v13 = Random.new();
                local l_Part_0 = Instance.new("Part");
                l_Part_0.Position = Vector3.new(v7.X + v13:NextNumber(-1, 1), v7.Y + 2 + v13:NextNumber(-0.25, 0.25), v7.Z + v13:NextNumber(-1, 1));
                l_Part_0.Transparency = 1;
                l_Part_0.Anchored = true;
                l_Part_0.CanCollide = false;
                l_Part_0.Parent = workspace.Misc;
                v0.CurrentHitmarker = l_Part_0;
                local v15 = script.Hitmarker:Clone();
                local l_Size_0 = v15.Size;
                v15.Title.Text = tostring(math.round(v6 * 100) / 100);
                v15.Size = v15.Size + UDim2.fromScale(2, 2);
                v15.Parent = l_Part_0;
                game.TweenService:Create(v15, TweenInfo.new(0.25), {
                    Size = l_Size_0
                }):Play();
                task.delay(1, function() --[[ Line: 78 ]]
                    -- upvalues: v15 (copy), l_Part_0 (copy)
                    if not v15.Parent or not l_Part_0.Parent then
                        return;
                    else
                        game.Debris:AddItem(l_Part_0, 1.5);
                        game.TweenService:Create(v15.Title, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                            TextTransparency = 1
                        }):Play();
                        game.TweenService:Create(v15.Title.Outline, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                            Transparency = 1
                        }):Play();
                        return;
                    end;
                end);
                task.delay(2, function() --[[ Line: 86 ]]
                    -- upvalues: v6 (ref), v0 (ref)
                    if v6 == v0.CurrentDamageDealt then
                        v0.CurrentHitmarker = nil;
                        v0.CurrentDamageDealt = nil;
                    end;
                end);
            end;
            return;
        end;
    end);
end;
return v0;