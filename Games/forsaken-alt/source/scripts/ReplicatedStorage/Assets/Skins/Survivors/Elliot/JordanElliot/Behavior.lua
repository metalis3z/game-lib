-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    CreatedPost = function(_, v1) --[[ Line: 4 ]] --[[ Name: CreatedPost ]]
        if game["Run Service"]:IsServer() then
            local l_Humanoid_0 = v1.Rig.Humanoid;
            local l_Health_0 = l_Humanoid_0.Health;
            do
                local l_l_Health_0_0 = l_Health_0;
                l_Humanoid_0:GetPropertyChangedSignal("Health"):Connect(function() --[[ Line: 9 ]]
                    -- upvalues: l_Humanoid_0 (copy), l_l_Health_0_0 (ref), v1 (copy)
                    if l_Humanoid_0.Health < l_l_Health_0_0 then
                        v1.Rig.HumanoidRootPart.ouch:Play();
                    end;
                    l_l_Health_0_0 = l_Humanoid_0.Health;
                end);
                task.spawn(function() --[[ Line: 17 ]]
                    -- upvalues: v1 (copy)
                    local v5 = {};
                    local l_Descendants_0 = v1.Rig:GetDescendants();
                    for v7, v8 in pairs(l_Descendants_0) do
                        if v8:IsA("BasePart") and v8.Transparency <= 0.5 then
                            local l_SelectionBox_0 = Instance.new("SelectionBox");
                            l_SelectionBox_0.Color = BrickColor.new("Really blue");
                            l_SelectionBox_0.Name = "ForceFieldAppearance";
                            l_SelectionBox_0.LineThickness = 0.1;
                            l_SelectionBox_0.Parent = l_Descendants_0[v7];
                            l_SelectionBox_0.Adornee = l_Descendants_0[v7];
                            table.insert(v5, l_SelectionBox_0);
                        end;
                    end;
                    for _ = 1, 8 do
                        for v11 = 1, #v5 do
                            game.TweenService:Create(v5[v11], TweenInfo.new(1), {
                                Color3 = Color3.fromRGB(0, 0, 255)
                            }):Play();
                        end;
                        task.wait(0.25);
                        for v12 = 1, #v5 do
                            game.TweenService:Create(v5[v12], TweenInfo.new(1), {
                                Color3 = Color3.fromRGB(107, 50, 124)
                            }):Play();
                        end;
                        task.wait(0.25);
                        for v13 = 1, #v5 do
                            game.TweenService:Create(v5[v13], TweenInfo.new(1), {
                                Color3 = Color3.fromRGB(255, 0, 0)
                            }):Play();
                        end;
                        task.wait(0.25);
                        for v14 = 1, #v5 do
                            game.TweenService:Create(v5[v14], TweenInfo.new(1), {
                                Color3 = Color3.fromRGB(107, 50, 124)
                            }):Play();
                        end;
                        task.wait(0.25);
                    end;
                    for v15 = 1, #v5 do
                        v5[v15]:Destroy();
                    end;
                end);
            end;
        end;
    end
};