-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

return {
    ["Activate"] = function(_)
        game:GetService("Workspace").CurrentCamera.FieldOfView = 60
        local GameUIContainer = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):WaitForChild("UI"):FindFirstChild("GameUIContainer") or game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):FindFirstChild("Transitions"):FindFirstChild("GameUIContainer"):FindFirstChild("GameUIContainer")
        if GameUIContainer then
            print("Loaded")
            GameUIContainer.Visible = true
            local GameUIContainer_0 = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):FindFirstChild("Transitions"):FindFirstChild("GameUIContainer")
            GameUIContainer.Parent = GameUIContainer_0
            GameUIContainer_0.GroupTransparency = 1
            task.wait(0.5)
            game:GetService("TweenService"):Create(GameUIContainer_0, TweenInfo.new(0.5), {
                ["GroupTransparency"] = 0
            }):Play()
            task.delay(0.5, function()
                GameUIContainer.Parent = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):WaitForChild("UI")
                GameUIContainer.Visible = true
            end)
        else
            error("NO UI FOUND", 1)
        end
    end
}
