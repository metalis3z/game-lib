-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Velocity Script Decompiler
game:GetService("Players")
game:GetService("GuiService")
local v_u_1 = game:GetService("UserInputService")
local v_u_2 = Vector2.new(0, 0)
return {
    ["Create"] = function(p_u_3, p4, p5, p_u_6, p_u_7, p_u_8)
        -- upvalues: (copy) v_u_1, (copy) v_u_2
        if p_u_3.thumbstickFrame then
            p_u_3.thumbstickFrame:Destroy()
            p_u_3.thumbstickFrame = nil
            if p_u_3.onTouchMovedConn then
                p_u_3.onTouchMovedConn:Disconnect()
                p_u_3.onTouchMovedConn = nil
            end
            if p_u_3.onTouchEndedConn then
                p_u_3.onTouchEndedConn:Disconnect()
                p_u_3.onTouchEndedConn = nil
            end
        end
        local v9 = p4.AbsoluteSize.X
        local v10 = p4.AbsoluteSize.Y
        local v11 = math.min(v9, v10) <= 500
        p_u_3.thumbstickSize = v11 and 70 or 120
        p_u_3.screenPos = v11 and UDim2.new(0, p_u_3.thumbstickSize / 2 - 10, 1, -p_u_3.thumbstickSize - 20) or UDim2.new(0, p_u_3.thumbstickSize / 2, 1, -p_u_3.thumbstickSize * 1.75)
        p_u_3.thumbstickFrame = Instance.new("Frame")
        p_u_3.thumbstickFrame.Name = "ThumbstickFrame"
        p_u_3.thumbstickFrame.Active = true
        p_u_3.thumbstickFrame.Visible = false
        p_u_3.thumbstickFrame.Size = UDim2.new(0, p_u_3.thumbstickSize, 0, p_u_3.thumbstickSize)
        p_u_3.thumbstickFrame.Position = p_u_3.screenPos
        p_u_3.thumbstickFrame.BackgroundTransparency = 1
        local v12 = Instance.new("ImageLabel")
        v12.Name = "OuterImage"
        v12.Image = "rbxasset://textures/ui/TouchControlsSheet.png"
        v12.ImageRectOffset = Vector2.new()
        v12.ImageRectSize = Vector2.new(220, 220)
        v12.BackgroundTransparency = 1
        v12.Size = UDim2.new(0, p_u_3.thumbstickSize, 0, p_u_3.thumbstickSize)
        v12.Position = UDim2.new(0, 0, 0, 0)
        v12.Parent = p_u_3.thumbstickFrame
        p_u_3.stickImage = Instance.new("ImageLabel")
        p_u_3.stickImage.Name = "StickImage"
        p_u_3.stickImage.Image = "rbxasset://textures/ui/TouchControlsSheet.png"
        p_u_3.stickImage.ImageRectOffset = Vector2.new(220, 0)
        p_u_3.stickImage.ImageRectSize = Vector2.new(111, 111)
        p_u_3.stickImage.BackgroundTransparency = 1
        p_u_3.stickImage.Size = UDim2.new(0, p_u_3.thumbstickSize / 2, 0, p_u_3.thumbstickSize / 2)
        p_u_3.stickImage.Position = UDim2.new(0, p_u_3.thumbstickSize / 2 - p_u_3.thumbstickSize / 4, 0, p_u_3.thumbstickSize / 2 - p_u_3.thumbstickSize / 4)
        p_u_3.stickImage.ZIndex = 2
        p_u_3.stickImage.Parent = p_u_3.thumbstickFrame
        if not p5 then
            p_u_3.stickImage.ImageTransparency = 1
            v12.ImageTransparency = 1
        end
        local v_u_13 = nil
        local v_u_14 = {}
        local function v_u_21(p15)
            -- upvalues: (copy) p_u_7, (copy) p_u_3, (ref) v_u_14, (copy) p_u_6
            if p15 then
                p_u_7()
            else
                local v16 = Vector2.new(p_u_3.moveVector.X, p_u_3.moveVector.Z)
                local v17 = { v16.Y < 0 and Enum.KeyCode.W or Enum.KeyCode.S, v16.X < 0 and Enum.KeyCode.A or Enum.KeyCode.D }
                if v_u_14 and #v_u_14 >= 1 then
                    for v18, v19 in pairs(v_u_14) do
                        if v17[v18] ~= v19 then
                            p_u_6(v19, false)
                        end
                    end
                end
                for _, v20 in pairs(v17) do
                    p_u_6(v20, true)
                end
                v_u_14 = v17
            end
        end
        local function v_u_27(p22)
            -- upvalues: (ref) v_u_13, (copy) p_u_3
            local v23 = Vector2.new(p22.X - v_u_13.X, p22.Y - v_u_13.Y)
            local v24 = v23.magnitude
            local v25 = p_u_3.thumbstickFrame.AbsoluteSize.X / 2
            if p_u_3.isFollowStick and v25 < v24 then
                local _ = v23.unit * v25
            else
                local v26 = math.min(v24, v25)
                v23 = v23.unit * v26
            end
            p_u_3.stickImage.Position = UDim2.new(0, v23.X + p_u_3.stickImage.AbsoluteSize.X / 2, 0, v23.Y + p_u_3.stickImage.AbsoluteSize.Y / 2)
        end
        p_u_3.thumbstickFrame.InputBegan:Connect(function(p28)
            -- upvalues: (copy) p_u_8, (copy) p_u_3, (ref) v_u_13
            p_u_8(true)
            if not p_u_3.moveTouchObject and (p28.UserInputType == Enum.UserInputType.Touch and p28.UserInputState == Enum.UserInputState.Begin) then
                p_u_3.moveTouchObject = p28
                v_u_13 = Vector2.new(p_u_3.thumbstickFrame.AbsolutePosition.X + p_u_3.thumbstickFrame.AbsoluteSize.X / 2, p_u_3.thumbstickFrame.AbsolutePosition.Y + p_u_3.thumbstickFrame.AbsoluteSize.Y / 2)
                Vector2.new(p28.Position.X - v_u_13.X, p28.Position.Y - v_u_13.Y)
            end
        end)
        p_u_3.onTouchMovedConn = v_u_1.TouchMoved:Connect(function(p29, _)
            -- upvalues: (copy) p_u_3, (ref) v_u_13, (copy) v_u_21, (copy) v_u_27
            if p29 == p_u_3.moveTouchObject then
                v_u_13 = Vector2.new(p_u_3.thumbstickFrame.AbsolutePosition.X + p_u_3.thumbstickFrame.AbsoluteSize.X / 2, p_u_3.thumbstickFrame.AbsolutePosition.Y + p_u_3.thumbstickFrame.AbsoluteSize.Y / 2)
                local v30 = Vector2.new(p29.Position.X - v_u_13.X, p29.Position.Y - v_u_13.Y)
                local v31 = v30 / (p_u_3.thumbstickSize / 2)
                local v32 = v31.magnitude
                local v33
                if v32 < 0.05 then
                    v33 = Vector3.new()
                else
                    local v34 = v31.unit * ((v32 - 0.05) / 0.95)
                    local v35 = v34.X
                    local v36 = v34.Y
                    v33 = Vector3.new(v35, 0, v36)
                end
                p_u_3.direction = v30
                p_u_3.moveVector = v33
                v_u_21()
                v_u_27(p29.Position)
            end
        end)
        p_u_3.onTouchEndedConn = v_u_1.TouchEnded:Connect(function(p37, _)
            -- upvalues: (copy) p_u_3, (copy) p_u_8, (ref) v_u_2, (ref) v_u_14, (copy) v_u_21
            if p37 == p_u_3.moveTouchObject then
                p_u_3.stickImage.Position = UDim2.new(0, p_u_3.thumbstickFrame.Size.X.Offset / 2 - p_u_3.thumbstickSize / 4, 0, p_u_3.thumbstickFrame.Size.Y.Offset / 2 - p_u_3.thumbstickSize / 4)
                p_u_8(false)
                p_u_3.moveVector = Vector3.new(0, 0, 0)
                p_u_3.isJumping = false
                p_u_3.moveTouchObject = nil
                p_u_3.direction = v_u_2
                v_u_14 = {}
                v_u_21(true)
            end
        end)
        p_u_3.thumbstickFrame.Parent = p4
        return p_u_3.thumbstickFrame
    end
}