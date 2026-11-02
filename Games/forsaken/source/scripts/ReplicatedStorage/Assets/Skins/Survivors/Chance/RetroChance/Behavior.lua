-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    CreatedPost = function(_, v1) --[[ Line: 4 ]] --[[ Name: CreatedPost ]]
        if game["Run Service"]:IsServer() then
            local l_Humanoid_0 = v1.Rig.Humanoid;
            local l_Health_0 = l_Humanoid_0.Health;
            local v4 = true;
            do
                local l_l_Health_0_0, l_v4_0 = l_Health_0, v4;
                l_Humanoid_0:GetPropertyChangedSignal("Health"):Connect(function() --[[ Line: 10 ]]
                    -- upvalues: l_Humanoid_0 (copy), l_l_Health_0_0 (ref), l_v4_0 (ref), v1 (copy)
                    if l_Humanoid_0.Health < l_l_Health_0_0 and l_v4_0 then
                        l_v4_0 = false;
                        v1.Rig.HumanoidRootPart.ouch:Play();
                        task.delay(0.4, function() --[[ Line: 14 ]]
                            -- upvalues: l_v4_0 (ref)
                            l_v4_0 = true;
                        end);
                    end;
                    l_l_Health_0_0 = l_Humanoid_0.Health;
                end);
                task.spawn(function() --[[ Line: 22 ]]
                    -- upvalues: v1 (copy)
                    local v7 = {};
                    local l_Descendants_0 = v1.Rig:GetDescendants();
                    for v9, v10 in pairs(l_Descendants_0) do
                        if v10.Name ~= "Coin" and v10.Name ~= "Flintlock" and v10:IsA("BasePart") and v10.Transparency <= 0.5 then
                            local l_SelectionBox_0 = Instance.new("SelectionBox");
                            l_SelectionBox_0.Color = BrickColor.new("Really blue");
                            l_SelectionBox_0.Name = "ForceFieldAppearance";
                            l_SelectionBox_0.LineThickness = 0.1;
                            l_SelectionBox_0.Parent = l_Descendants_0[v9];
                            l_SelectionBox_0.Adornee = l_Descendants_0[v9];
                            table.insert(v7, l_SelectionBox_0);
                        end;
                    end;
                    for _ = 1, 8 do
                        for v13 = 1, #v7 do
                            game.TweenService:Create(v7[v13], TweenInfo.new(1), {
                                Color3 = Color3.fromRGB(0, 0, 255)
                            }):Play();
                        end;
                        task.wait(0.25);
                        for v14 = 1, #v7 do
                            game.TweenService:Create(v7[v14], TweenInfo.new(1), {
                                Color3 = Color3.fromRGB(107, 50, 124)
                            }):Play();
                        end;
                        task.wait(0.25);
                        for v15 = 1, #v7 do
                            game.TweenService:Create(v7[v15], TweenInfo.new(1), {
                                Color3 = Color3.fromRGB(255, 0, 0)
                            }):Play();
                        end;
                        task.wait(0.25);
                        for v16 = 1, #v7 do
                            game.TweenService:Create(v7[v16], TweenInfo.new(1), {
                                Color3 = Color3.fromRGB(107, 50, 124)
                            }):Play();
                        end;
                        task.wait(0.25);
                    end;
                    for v17 = 1, #v7 do
                        v7[v17]:Destroy();
                    end;
                end);
            end;
        end;
    end
};