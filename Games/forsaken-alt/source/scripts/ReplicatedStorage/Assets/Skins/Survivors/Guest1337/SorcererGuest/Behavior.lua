-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Util);
v0.CreatedPost = function(_, v3) --[[ Line: 5 ]] --[[ Name: CreatedPost ]]
    -- upvalues: v1 (copy)
    if game["Run Service"]:IsServer() then
        local l_Rig_0 = v3.Rig;
        if not (l_Rig_0.PrimaryPart or l_Rig_0:WaitForChild("HumanoidRootPart", 10)) then
            return;
        else
            l_Rig_0:GetAttributeChangedSignal("Parried"):Connect(function() --[[ Line: 11 ]]
                -- upvalues: v3 (copy)
                for _, v6 in pairs(v3.Rig["Right Arm"].Startup:GetChildren()) do
                    if v6:IsA("ParticleEmitter") then
                        v6:Emit(1);
                    end;
                end;
                for _, v8 in pairs(v3.Rig["Right Arm"].Aura0:GetChildren()) do
                    if v8:IsA("ParticleEmitter") then
                        v8:Emit(10);
                    end;
                end;
                for _, v10 in pairs(v3.Rig["Right Arm"]:GetChildren()) do
                    if v10:IsA("ParticleEmitter") then
                        v10:Emit(25);
                    end;
                end;
            end);
        end;
    end;
    if game["Run Service"]:IsClient() and v3.Player == game.Players.LocalPlayer then
        local l_Rig_1 = v3.Rig;
        local v12 = l_Rig_1.PrimaryPart or l_Rig_1:WaitForChild("HumanoidRootPart", 10);
        if not v12 then
            return;
        else
            l_Rig_1:GetAttributeChangedSignal("Parried"):Connect(function() --[[ Line: 38 ]]
                -- upvalues: l_Rig_1 (copy), v1 (ref), v3 (copy), v12 (copy)
                if l_Rig_1:GetAttribute("Parried") and not v1:GetSettingValue("EpilepsyMode") then
                    local l_ColorCorrectionEffect_0 = Instance.new("ColorCorrectionEffect");
                    l_ColorCorrectionEffect_0.Parent = game.Lighting;
                    l_ColorCorrectionEffect_0.Name = "BlackFlash";
                    l_ColorCorrectionEffect_0.Brightness = 1;
                    l_ColorCorrectionEffect_0.Contrast = 30;
                    l_ColorCorrectionEffect_0.Saturation = -1;
                    l_ColorCorrectionEffect_0.TintColor = Color3.fromRGB(255, 0, 0);
                    l_ColorCorrectionEffect_0.Enabled = true;
                    task.delay(0.1, function() --[[ Line: 49 ]]
                        -- upvalues: l_ColorCorrectionEffect_0 (copy)
                        l_ColorCorrectionEffect_0.Contrast = 35;
                        l_ColorCorrectionEffect_0.TintColor = Color3.fromRGB(255, 255, 255);
                    end);
                    local l_v1_FOVMultiplier_0 = v1:CreateFOVMultiplier(v3.Player, 1, "BlackFlash");
                    game.TweenService:Create(l_v1_FOVMultiplier_0, TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true), {
                        Value = 0.625
                    }):Play();
                    task.delay(0.15, function() --[[ Line: 57 ]]
                        -- upvalues: l_v1_FOVMultiplier_0 (copy), l_ColorCorrectionEffect_0 (copy)
                        game.Debris:AddItem(l_v1_FOVMultiplier_0, 1);
                        l_ColorCorrectionEffect_0:Destroy();
                    end);
                    local l_Flash_0 = script:FindFirstChild("Flash");
                    if l_Flash_0 then
                        local v16 = l_Flash_0:Clone();
                        v16.Parent = workspace;
                        v16:SetPrimaryPartCFrame(v12.CFrame * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, 4));
                        local l_WeldConstraint_0 = Instance.new("WeldConstraint");
                        l_WeldConstraint_0.Part0 = v12;
                        l_WeldConstraint_0.Part1 = v16.PrimaryPart;
                        l_WeldConstraint_0.Parent = v16.PrimaryPart;
                        local l_Highlight_0 = Instance.new("Highlight");
                        l_Highlight_0.FillColor = Color3.new(0, 0, 0);
                        l_Highlight_0.OutlineColor = Color3.new(0.625, 0, 0);
                        l_Highlight_0.FillTransparency = 0;
                        l_Highlight_0.OutlineTransparency = -0.5;
                        l_Highlight_0.DepthMode = Enum.HighlightDepthMode.Occluded;
                        l_Highlight_0.Parent = v16;
                        for _ = 1, 10 do
                            v16:SetPrimaryPartCFrame(v16.PrimaryPart.CFrame * CFrame.Angles(0, 0, 1.7453292519943295));
                            task.wait(0.01);
                        end;
                        v16:Destroy();
                        print("Deleted");
                    end;
                end;
            end);
        end;
    end;
end;
return v0;