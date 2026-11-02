-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Velocity Script Decompiler
game:GetService("RunService").RenderStepped:Connect(function()
    if game:GetService("Players").LocalPlayer:GetAttribute("Team") ~= "Lobby" then
        if script.Parent.Highlight.Enabled == true and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            script.Parent.Attachment.BillboardGui.Enabled = true
            local v1 = (game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position - script.Parent.Position).Magnitude
            local v2 = (v1 - 50) / (0 - v1)
            local v3 = math.clamp(v2, 0, 1)
            script.Parent.Highlight.OutlineTransparency = v3 * 2
            script.Parent.Highlight.FillTransparency = v3 + 0.5
        end
    end
end)