-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local TweenService = game:GetService("TweenService")
local v_u_2 = game.Players.LocalPlayer:GetMouse()
local Effect = script.Parent:WaitForChild("Effect")
v_u_2.Button1Down:Connect(function()
    local v_u_4 = Effect:Clone()
    v_u_4.Parent = script.Parent
    v_u_4.Position = UDim2.fromOffset(v_u_2.X + 2, v_u_2.Y + 62)
    v_u_4.Visible = true
    v_u_4.UIStroke.Transparency = 0.95
    v_u_4.Shadow.ImageTransparency = 0.98
    v_u_4.Size = UDim2.new(0.02, 0, 0.02, 0)
    local v5 = TweenService:Create(v_u_4, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        ["Size"] = UDim2.new(0.055, 0, 0.055, 0)
    })
    local v6 = TweenService:Create(v_u_4.UIStroke, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        ["Transparency"] = 1
    })
    local v7 = TweenService:Create(v_u_4.Shadow, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 1
    })
    v5:Play()
    v6:Play()
    v7:Play()
    v5.Completed:Connect(function()
        v_u_4.Visible = false
        v_u_4:Destroy()
    end)
end)
