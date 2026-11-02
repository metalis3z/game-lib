-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

return {
    ["Activate"] = function(p1)
        task.wait(0.1)
        local v2 = p1[1][2]:FindFirstChildOfClass("Humanoid"):LoadAnimation(p1[2][2])
        local v3 = p1[1][1]:FindFirstChildOfClass("Humanoid"):LoadAnimation(p1[2][1])
        v2.Priority = Enum.AnimationPriority.Action4
        v3.Priority = Enum.AnimationPriority.Action4
        v2:Play()
        v3:Play()
        local v4 = next
        local v5, v6 = p1[1][2]:GetDescendants()
        for _, v7 in v4, v5, v6 do
            if v7:IsA("BasePart") then
                v7.LocalTransparencyModifier = v7.Transparency
            end
        end
        local v8 = next
        local v9, v10 = p1[1][1]:GetDescendants()
        for _, v11 in v8, v9, v10 do
            if v11:IsA("BasePart") then
                v11.LocalTransparencyModifier = v11.Transparency
            end
        end
        if p1[1][2]:FindFirstChild("Axe") then
            local v12 = next
            local v13, v14 = p1[1][2].Axe:GetChildren()
            for _, v15 in v12, v13, v14 do
                if v15:IsA("BasePart") then
                    v15.LocalTransparencyModifier = 1
                end
            end
        end
        if table.find(p1[1], game:GetService("Players").LocalPlayer.Character) then
            for _, v16 in p1[1][2]:GetDescendants() do
                if v16:IsA("Accessory") then
                    for _, v17 in v16:GetDescendants() do
                        if v17:IsA("BasePart") then
                            v17:SetAttribute("OGTRANS", v17.Transparency)
                            v17.LocalTransparencyModifier = 1
                        end
                    end
                end
            end
            local GameUIContainer = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):WaitForChild("UI"):FindFirstChild("GameUIContainer") or game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):FindFirstChild("Transitions"):FindFirstChild("GameUIContainer"):FindFirstChild("GameUIContainer")
            local GameUIContainer_0 = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):FindFirstChild("Transitions"):FindFirstChild("GameUIContainer")
            if GameUIContainer then
                GameUIContainer.Parent = GameUIContainer_0
                GameUIContainer_0.GroupTransparency = 0
                game:GetService("TweenService"):Create(GameUIContainer_0, TweenInfo.new(0.5), {
                    ["GroupTransparency"] = 1
                }):Play()
            end
            v3.Stopped:Wait()
            if game:GetService("Players").LocalPlayer:GetAttribute("TEAM") ~= "Lobby" then
                game:GetService("Players").LocalPlayer.PlayerGui.UI:FindFirstChild("Transitions"):FindFirstChild("Transition").GroupTransparency = 0
            end
            for _, v20 in p1[1][2]:GetDescendants() do
                if v20:IsA("Accessory") then
                    for _, v21 in v20:GetDescendants() do
                        if v21:IsA("BasePart") then
                            v21.LocalTransparencyModifier = v21:GetAttribute("OGTRANS")
                        end
                    end
                end
            end
        end
    end
}
