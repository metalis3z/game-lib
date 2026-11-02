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
        for _, v4 in p1[1][2]:GetDescendants() do
            if v4:IsA("Accessory") then
                for _, v5 in v4:GetDescendants() do
                    if v5:IsA("BasePart") then
                        v5:SetAttribute("OGTRANS", v5.Transparency)
                        v5.Transparency = 1
                    end
                end
            end
        end
        if p1[1][2]:FindFirstChild("Axe") then
            local v6 = next
            local v7, v8 = p1[1][2]:GetChildren()
            for _, v9 in v6, v7, v8 do
                if v9:IsA("BasePart") then
                    v9.LocalTransparencyModifier = 1
                end
            end
        end
        p1[1][2]:FindFirstChild("Head"):SetAttribute("OGTRANS", p1[1][2]:FindFirstChild("Head").Transparency)
        p1[1][2]:FindFirstChild("Head").Transparency = 1
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
        for _, v12 in p1[1][2]:GetDescendants() do
            if v12:IsA("Accessory") then
                for _, v13 in v12:GetDescendants() do
                    if v13:IsA("BasePart") then
                        v13.Transparency = v13:GetAttribute("OGTRANS")
                    end
                end
            end
        end
        p1[1][2]:FindFirstChild("Head").Transparency = p1[1][2]:FindFirstChild("Head"):GetAttribute("OGTRANS")
    end
}
