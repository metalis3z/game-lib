-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Velocity Script Decompiler
local v_u_1 = game:GetService("UserInputService")
local v2 = game:GetService("RunService")
local v_u_3 = script.Parent.Container.Frame
local v_u_4 = script.Parent.Container.AbsoluteSize
local v_u_5 = script.Parent:GetAttribute("HP")
local v_u_6 = nil
game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Follow
local v_u_7 = Vector2.new(0, 0)
v_u_1.InputChanged:Connect(function(p8)
    -- upvalues: (ref) v_u_7
    if p8.KeyCode == Enum.KeyCode.Thumbstick2 then
        v_u_7 = Vector2.new(p8.Position.X, p8.Position.Y)
    end
end)
local v_u_9 = tick()
v_u_6 = v2.RenderStepped:Connect(function(p10)
    -- upvalues: (copy) v_u_1, (ref) v_u_6, (ref) v_u_9, (ref) v_u_5, (ref) v_u_4, (copy) v_u_3, (ref) v_u_7
    if script.Parent:GetAttribute("Active") == false then
        game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
        v_u_1.MouseBehavior = Enum.MouseBehavior.Default
        v_u_1.MouseIconEnabled = true
        v_u_6:Disconnect()
    else
        if tick() - v_u_9 > 0.1 then
            v_u_9 = tick()
            script.Event:FireServer(v_u_5)
        end
        if (script.Parent.Container.Frame.AbsolutePosition - (script.Parent.Container.Box.AbsolutePosition + script.Parent.Container.Box.AbsoluteSize / 2)).Magnitude < script.Parent.Container.Box.AbsoluteSize.Magnitude / 3 then
            local v11 = v_u_5 + 100 * p10
            v_u_5 = math.clamp(v11, 0, 100)
        else
            local v12 = v_u_5 - 175 * p10
            v_u_5 = math.clamp(v12, 0, 100)
        end
        v_u_4 = script.Parent.Container.AbsoluteSize
        script.Parent.Container.Size = UDim2.new(0, workspace.CurrentCamera.ViewportSize.X, 0, workspace.CurrentCamera.ViewportSize.Y)
        script.Parent.Container.Position = UDim2.new(0.5, 0, 0.5, 0)
        v_u_1.MouseBehavior = Enum.MouseBehavior.LockCenter
        v_u_1.MouseIconEnabled = false
        game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
        local v13 = v_u_3.Position.X.Offset + v_u_1:GetMouseDelta().X * 3
        local v14 = v_u_3.Position.Y.Offset + v_u_1:GetMouseDelta().Y * 3
        local v15 = UDim2.new(0, math.random(-3, 3), 0, math.random(-3, 3))
        local v16 = v_u_1.TouchEnabled
        local v17 = v_u_1.GamepadEnabled
        local _ = v_u_1.KeyboardEnabled
        if v17 and v_u_7 then
            v13 = v13 + v_u_7.X * 28
            v14 = v14 - v_u_7.Y * 28
        end
        script.Parent.Container.hpBar.UIGradient.Offset = Vector2.new(v_u_5 / 100 - 0.5, 0)
        local v18 = v_u_3
        local v19 = UDim2.new
        local v20 = v_u_4.X
        local v21 = math.clamp(v13, 0, v20)
        local v22 = v_u_4.Y
        v18.Position = v19(0, v21, 0, (math.clamp(v14, 0, v22))) + v15
        if v16 then
            v_u_3.Position = v_u_3.Position:Lerp(UDim2.new(0, v_u_4.X / 2, 0, v_u_4.Y / 2), 0.005)
        elseif v17 then
            v_u_3.Position = v_u_3.Position:Lerp(UDim2.new(0, v_u_4.X / 2, 0, v_u_4.Y / 2), 0.005)
        else
            v_u_3.Position = v_u_3.Position:Lerp(UDim2.new(0, v_u_4.X / 2, 0, v_u_4.Y / 2), 0.005)
        end
        workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0, 2, 5) * CFrame.fromEulerAnglesXYZ(-0.20943951023931956, 0, 0), 0.5)
        if game:GetService("Players").LocalPlayer.Character then
            local v23 = next
            local v24, v25 = game:GetService("Players").LocalPlayer.Character:GetDescendants()
            for _, v26 in v23, v24, v25 do
                if v26:IsA("BasePart") then
                    v26.LocalTransparencyModifier = v26.Transparency
                end
            end
        end
    end
end)
v_u_3.Position = UDim2.new(0, v_u_4.X / 2, 0, v_u_4.Y / 2)
script.Event.OnClientEvent:Connect(function(p27, _)
    -- upvalues: (ref) v_u_5, (copy) v_u_3, (ref) v_u_4
    if p27 == "Bump" then
        script.Event:FireServer(v_u_5)
        v_u_3.Position = UDim2.new(0, Random.new():NextNumber(0, v_u_4.X), 0, Random.new():NextNumber(0, v_u_4.Y))
    elseif p27 == "Update" then
        script.Event:FireServer(v_u_5)
    end
end)
script.Parent:GetAttributeChangedSignal("Active"):Connect(function()
    -- upvalues: (ref) v_u_6, (copy) v_u_1
    if script.Parent:GetAttribute("Active") == false then
        v_u_6:Disconnect()
        game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
        v_u_1.MouseBehavior = Enum.MouseBehavior.Default
        v_u_1.MouseIconEnabled = true
    end
end)