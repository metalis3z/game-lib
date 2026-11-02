



local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = game:GetService("TweenService")
local function v_u_19(p3)
    local v_u_4 = Instance.new("Frame")
    v_u_4.Name = "UIShimmer"
    v_u_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    v_u_4.BackgroundTransparency = 0
    v_u_4.ClipsDescendants = true
    v_u_4.Size = UDim2.new(1, 0, 1, 0)
    v_u_4.AnchorPoint = Vector2.new(0.5, 0.5)
    v_u_4.Position = UDim2.new(0.5, 0, 0.5, 0)
    v_u_4.BorderSizePixel = 0
    v_u_4.Visible = false
    v_u_4.Parent = p3
    local function v_u_7()
        if v_u_4.Parent:FindFirstChildOfClass("UICorner") then
            local v5 = v_u_4.Parent:FindFirstChildOfClass("UICorner")
            local v6 = Instance.new("UICorner")
            v6.CornerRadius = v5.CornerRadius
            v6.Parent = v_u_4
            v6:GetPropertyChangedSignal("CornerRadius"):Connect(v_u_7)
        end
    end
    v_u_4:GetPropertyChangedSignal("Parent"):Connect(v_u_7)
    v_u_7()
    local function v_u_17()
        if v_u_4.Parent:FindFirstChildOfClass("UIPadding") then
            local v8 = v_u_4.Parent:FindFirstChildOfClass("UIPadding")
            local v9 = v8.PaddingLeft.Scale + v8.PaddingRight.Scale
            local v10 = v8.PaddingTop.Scale + v8.PaddingBottom.Scale
            local v11 = v8.PaddingLeft.Offset + v8.PaddingRight.Offset
            local v12 = v8.PaddingTop.Offset + v8.PaddingBottom.Offset
            local v13 = v8.PaddingTop.Offset - v8.PaddingBottom.Offset
            local v14 = v8.PaddingLeft.Offset - v8.PaddingRight.Offset
            local v15 = 1 / (1 - v9)
            local v16 = 1 / (1 - v10)
            v_u_4.Size = UDim2.new(v15, v11, v16, v12)
            v_u_4.Position = UDim2.new(0.5, -v14 / 2, 0.5, -v13 / 2)
            print(v_u_4.Position)
            v8:GetPropertyChangedSignal("PaddingLeft"):Connect(v_u_17)
            v8:GetPropertyChangedSignal("PaddingRight"):Connect(v_u_17)
            v8:GetPropertyChangedSignal("PaddingTop"):Connect(v_u_17)
            v8:GetPropertyChangedSignal("PaddingBottom"):Connect(v_u_17)
        end
    end
    v_u_4:GetPropertyChangedSignal("Parent"):Connect(v_u_17)
    v_u_17()
    local v18 = Instance.new("UIGradient")
    v18.Rotation = 15
    v18.Color = ColorSequence.new(Color3.new(1, 1, 1))
    v18.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.15, 1),
        NumberSequenceKeypoint.new(0.5, 0.55),
        NumberSequenceKeypoint.new(0.85, 1),
        NumberSequenceKeypoint.new(1, 1)
    })
    v18.Offset = Vector2.new(-1, 0)
    v18.Parent = v_u_4
    return v_u_4
end
v_u_1.PlaybackState = nil
function v_u_1.new(p20, p21, p22, p23, p24, p25, p26)
    local v27
    if typeof(p20) == "Instance" then
        v27 = p20:IsA("GuiObject")
    else
        v27 = false
    end
    assert(v27, "Invalid parent argument. Expected GuiObject.")
    local v28 = p21 or 1
    local v29 = typeof(v28) == "number"
    assert(v29, "Invalid time argument. Expected number.")
    local v30 = p22 or Enum.EasingStyle.Linear
    local v31
    if typeof(v30) == "EnumItem" then
        v31 = v30.EnumType == Enum.EasingStyle
    else
        v31 = false
    end
    assert(v31, "Invalid style argument. Expected EasingStyle enum.")
    local v32 = p23 or Enum.EasingDirection.InOut
    local v33
    if typeof(v32) == "EnumItem" then
        v33 = v32.EnumType == Enum.EasingDirection
    else
        v33 = false
    end
    assert(v33, "Invalid direction argument. Expected EasingDirection enum.")
    local v34 = p24 or -1
    local v35 = typeof(v34) == "number"
    assert(v35, "Invalid repeatCount argument. Expected number.")
    local v36 = p25 or false
    local v37 = typeof(v36) == "boolean"
    assert(v37, "Invalid reverses argument. Expected boolean.")
    local v38 = p26 or 0
    local v39 = typeof(v38) == "number"
    assert(v39, "Invalid delayTime argument. Expected number.")
    local v40 = v_u_1
    local v_u_41 = setmetatable({}, v40)
    local v42 = v30 or Enum.EasingStyle.Linear
    local v43 = v32 or Enum.EasingDirection.InOut
    local v44 = v_u_19(p20)
    v_u_41._frame = v44
    v_u_41._gradient = v44:FindFirstChildOfClass("UIGradient")
    v_u_41._corner = v44:FindFirstChildOfClass("UICorner")
    v_u_41._tween = v_u_2:Create(v_u_41._gradient, TweenInfo.new(v28 or 1, v42, v43, v34 or -1, v36 or false, v38 or 0), {
        ["Offset"] = Vector2.new(1, 0)
    })
    v_u_41._tween.Completed:Connect(function()
        v_u_41:_TweenCompleted()
    end)
    return v_u_41
end
function v_u_1._TweenCompleted(p45)
    p45._frame.Visible = false
    p45.PlaybackState = Enum.PlaybackState.Completed
end
function v_u_1.GetFrame(p46)
    return p46._frame
end
function v_u_1.GetGradient(p47)
    return p47._gradient
end
function v_u_1.GetCorner(p48)
    return p48._corner
end
function v_u_1.Play(p49)
    p49.PlaybackState = Enum.PlaybackState.Begin
    p49._frame.Visible = true
    p49._tween:Play()
    p49.PlaybackState = Enum.PlaybackState.Playing
end
function v_u_1.Pause(p50)
    if p50.PlaybackState == Enum.PlaybackState.Playing then
        p50._tween:Pause()
        p50.PlaybackState = Enum.PlaybackState.Paused
    end
end
function v_u_1.Cancel(p51)
    p51._tween:Cancel()
    p51._frame.Visible = false
    p51.PlaybackState = Enum.PlaybackState.Cancelled
end
return v_u_1