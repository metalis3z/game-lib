-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:10:34 2025 ]]
return {
    PreSlash = function(_, v1) --[[ Line: 4 ]] --[[ Name: PreSlash ]]
        for _, v3 in pairs(v1.Rig:GetChildren()) do
            if v3.Name:find("Sword") and not v3:GetAttribute("Ignored") then
                v3.Transparency = 0;
            end;
        end;
        for _, v5 in pairs(v1.Rig.Sword:GetChildren()) do
            if v5:IsA("ParticleEmitter") or v5:IsA("Light") or v5:IsA("Highlight") then
                v5.Enabled = true;
            end;
        end;
        task.delay(v1.Config.SlashWindupTime + 0.3, function() --[[ Line: 16 ]]
            -- upvalues: v1 (copy)
            for _, v7 in pairs(v1.Rig:GetChildren()) do
                if v7.Name:find("Sword") then
                    game.TweenService:Create(v7, TweenInfo.new(0.5), {
                        Transparency = 0
                    }):Play();
                end;
            end;
            task.wait(0.3);
            for _, v9 in pairs(v1.Rig.Sword:GetChildren()) do
                if v9:IsA("ParticleEmitter") or v9:IsA("Light") or v9:IsA("Highlight") then
                    v9.Enabled = false;
                end;
            end;
        end);
    end, 
    CreatedPost = function(_, v11) --[[ Line: 29 ]] --[[ Name: CreatedPost ]]
        if game["Run Service"]:IsServer() then
            local l_Humanoid_0 = v11.Rig.Humanoid;
            local l_Health_0 = l_Humanoid_0.Health;
            local v14 = true;
            do
                local l_l_Health_0_0, l_v14_0 = l_Health_0, v14;
                l_Humanoid_0:GetPropertyChangedSignal("Health"):Connect(function() --[[ Line: 35 ]]
                    -- upvalues: l_Humanoid_0 (copy), l_l_Health_0_0 (ref), l_v14_0 (ref), v11 (copy)
                    if l_Humanoid_0.Health < l_l_Health_0_0 and l_v14_0 then
                        l_v14_0 = false;
                        v11.Rig.HumanoidRootPart.ouch:Play();
                        task.delay(0.4, function() --[[ Line: 39 ]]
                            -- upvalues: l_v14_0 (ref)
                            l_v14_0 = true;
                        end);
                    end;
                    l_l_Health_0_0 = l_Humanoid_0.Health;
                end);
                task.spawn(function() --[[ Line: 47 ]]
                    -- upvalues: v11 (copy)
                    local v17 = {};
                    local l_Descendants_0 = v11.Rig:GetDescendants();
                    for v19, v20 in pairs(l_Descendants_0) do
                        if v20:IsA("BasePart") and v20.Transparency <= 0.5 then
                            local l_SelectionBox_0 = Instance.new("SelectionBox");
                            l_SelectionBox_0.Color = BrickColor.new("Really blue");
                            l_SelectionBox_0.Name = "ForceFieldAppearance";
                            l_SelectionBox_0.LineThickness = 0.1;
                            l_SelectionBox_0.Parent = l_Descendants_0[v19];
                            l_SelectionBox_0.Adornee = l_Descendants_0[v19];
                            table.insert(v17, l_SelectionBox_0);
                        end;
                    end;
                    for _ = 1, 8 do
                        for v23 = 1, #v17 do
                            game.TweenService:Create(v17[v23], TweenInfo.new(1), {
                                Color3 = Color3.fromRGB(0, 0, 255)
                            }):Play();
                        end;
                        task.wait(0.25);
                        for v24 = 1, #v17 do
                            game.TweenService:Create(v17[v24], TweenInfo.new(1), {
                                Color3 = Color3.fromRGB(107, 50, 124)
                            }):Play();
                        end;
                        task.wait(0.25);
                        for v25 = 1, #v17 do
                            game.TweenService:Create(v17[v25], TweenInfo.new(1), {
                                Color3 = Color3.fromRGB(255, 0, 0)
                            }):Play();
                        end;
                        task.wait(0.25);
                        for v26 = 1, #v17 do
                            game.TweenService:Create(v17[v26], TweenInfo.new(1), {
                                Color3 = Color3.fromRGB(107, 50, 124)
                            }):Play();
                        end;
                        task.wait(0.25);
                    end;
                    for v27 = 1, #v17 do
                        v17[v27]:Destroy();
                    end;
                end);
            end;
        end;
    end
};