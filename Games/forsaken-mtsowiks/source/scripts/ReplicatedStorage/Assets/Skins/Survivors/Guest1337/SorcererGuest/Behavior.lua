-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:09:11 2025 ]]
local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Util);
v0.CreatedPost = function(_, v3) --[[ Line: 5 ]] --[[ Name: CreatedPost ]]
    -- upvalues: v1 (copy)
    if game["Run Service"]:IsServer() then

    end;
    if game["Run Service"]:IsClient() and v3.Player == game.Players.LocalPlayer then
        local l_Rig_0 = v3.Rig;
        local v5 = l_Rig_0.PrimaryPart or l_Rig_0:WaitForChild("HumanoidRootPart", 10);
        if not v5 then
            return;
        else
            l_Rig_0:GetAttributeChangedSignal("Parried"):Connect(function() --[[ Line: 15 ]]
                -- upvalues: l_Rig_0 (copy), v1 (ref), v3 (copy), v5 (copy)
                if l_Rig_0:GetAttribute("Parried") and not v1:GetSettingValue("EpilepsyMode") then
                    local l_ColorCorrectionEffect_0 = Instance.new("ColorCorrectionEffect");
                    l_ColorCorrectionEffect_0.Parent = game.Lighting;
                    l_ColorCorrectionEffect_0.Name = "BlackFlash";
                    l_ColorCorrectionEffect_0.Brightness = 1;
                    l_ColorCorrectionEffect_0.Contrast = 30;
                    l_ColorCorrectionEffect_0.Saturation = -1;
                    l_ColorCorrectionEffect_0.TintColor = Color3.fromRGB(255, 0, 0);
                    l_ColorCorrectionEffect_0.Enabled = true;
                    task.delay(0.1, function() --[[ Line: 26 ]]
                        -- upvalues: l_ColorCorrectionEffect_0 (copy)
                        l_ColorCorrectionEffect_0.Contrast = 35;
                        l_ColorCorrectionEffect_0.TintColor = Color3.fromRGB(255, 255, 255);
                    end);
                    local l_v1_FOVMultiplier_0 = v1:CreateFOVMultiplier(v3.Player, 1, "BlackFlash");
                    game.TweenService:Create(l_v1_FOVMultiplier_0, TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true), {
                        Value = 0.625
                    }):Play();
                    task.delay(0.15, function() --[[ Line: 34 ]]
                        -- upvalues: l_v1_FOVMultiplier_0 (copy), l_ColorCorrectionEffect_0 (copy)
                        game.Debris:AddItem(l_v1_FOVMultiplier_0, 1);
                        l_ColorCorrectionEffect_0:Destroy();
                    end);
                    local l_Flash_0 = script:FindFirstChild("Flash");
                    if l_Flash_0 then
                        local v9 = l_Flash_0:Clone();
                        v9.Parent = workspace;
                        v9:SetPrimaryPartCFrame(v5.CFrame * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, 4));
                        local l_WeldConstraint_0 = Instance.new("WeldConstraint");
                        l_WeldConstraint_0.Part0 = v5;
                        l_WeldConstraint_0.Part1 = v9.PrimaryPart;
                        l_WeldConstraint_0.Parent = v9.PrimaryPart;
                        local l_Highlight_0 = Instance.new("Highlight");
                        l_Highlight_0.FillColor = Color3.new(0, 0, 0);
                        l_Highlight_0.OutlineColor = Color3.new(0.625, 0, 0);
                        l_Highlight_0.FillTransparency = 0;
                        l_Highlight_0.OutlineTransparency = -0.5;
                        l_Highlight_0.DepthMode = Enum.HighlightDepthMode.Occluded;
                        l_Highlight_0.Parent = v9;
                        for _ = 1, 10 do
                            v9:SetPrimaryPartCFrame(v9.PrimaryPart.CFrame * CFrame.Angles(0, 0, 1.7453292519943295));
                            task.wait(0.01);
                        end;
                        v9:Destroy();
                    end;
                end;
            end);
        end;
    end;
end;
v0.ParryStart = function(v13) --[[ Line: 70 ]] --[[ Name: ParryStart ]]
    local l_Rig_1 = v13.Rig;
    if not l_Rig_1 then
        return;
    else
        l_Rig_1["Right Arm"].Startup.Flash:Emit(1);
        l_Rig_1["Right Arm"].Startup.Flash1:Emit(1);
        l_Rig_1["Right Arm"].Aura0.Black:Emit(1);
        l_Rig_1["Right Arm"].Aura0.Black1:Emit(2);
        l_Rig_1["Right Arm"].Aura0.Flame:Emit(2);
        l_Rig_1["Right Arm"].Aura0.Middle:Emit(2);
        l_Rig_1["Right Arm"].Aura0.Scatter:Emit(2);
        l_Rig_1["Right Arm"].Aura0.Splash:Emit(2);
        return;
    end;
end;
v0.ParryHit = function(v15) --[[ Line: 86 ]] --[[ Name: ParryHit ]]
    local l_Rig_2 = v15.Rig;
    if not l_Rig_2 then
        return;
    else
        l_Rig_2["Right Arm"]["Black Flash 1"].Enabled = true;
        l_Rig_2["Right Arm"]["Black Flash 2"].Enabled = true;
        l_Rig_2["Right Arm"]["Black Flash 3"].Enabled = true;
        l_Rig_2["Right Arm"].BlackHit.Enabled = true;
        l_Rig_2["Right Arm"].BlackHit2.Enabled = true;
        l_Rig_2["Right Arm"].BlackLightning.Enabled = true;
        task.delay(0.125, function() --[[ Line: 97 ]]
            -- upvalues: l_Rig_2 (copy)
            l_Rig_2["Right Arm"]["Black Flash 1"].Enabled = false;
            l_Rig_2["Right Arm"]["Black Flash 2"].Enabled = false;
            l_Rig_2["Right Arm"]["Black Flash 3"].Enabled = false;
            l_Rig_2["Right Arm"].BlackHit.Enabled = false;
            l_Rig_2["Right Arm"].BlackHit2.Enabled = false;
            l_Rig_2["Right Arm"].BlackLightning.Enabled = false;
        end);
        l_Rig_2.HumanoidRootPart.BlackFlash0.Back:Emit(5);
        l_Rig_2.HumanoidRootPart.BlackFlash0.Extra:Emit(5);
        l_Rig_2.HumanoidRootPart.BlackFlash0.Flash:Emit(1);
        l_Rig_2.HumanoidRootPart.BlackFlash0.Front:Emit(5);
        l_Rig_2.HumanoidRootPart.BlackFlash0.Lightning:Emit(3);
        l_Rig_2.HumanoidRootPart.BlackFlash0.Lightning1:Emit(6);
        l_Rig_2.HumanoidRootPart.BlackFlash0.Lightning2:Emit(2);
        l_Rig_2.HumanoidRootPart.BlackFlash0.Shockwave:Emit(2);
        l_Rig_2.HumanoidRootPart.BlackFlash0.Shockwave1:Emit(2);
        return;
    end;
end;
return v0;