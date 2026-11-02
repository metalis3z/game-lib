local ProximityPromptService = game:GetService("ProximityPromptService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local TextService = game:GetService("TextService")
local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local flag_2 = {

    [Enum.KeyCode.ButtonX] = "rbxasset://textures/ui/Controls/xboxX.png",
    [Enum.KeyCode.ButtonY] = "rbxasset://textures/ui/Controls/xboxY.png",
    [Enum.KeyCode.ButtonA] = "rbxasset://textures/ui/Controls/xboxA.png",
    [Enum.KeyCode.ButtonB] = "rbxasset://textures/ui/Controls/xboxB.png",
    [Enum.KeyCode.DPadLeft] = "rbxasset://textures/ui/Controls/dpadLeft.png",
    [Enum.KeyCode.DPadRight] = "rbxasset://textures/ui/Controls/dpadRight.png",
    [Enum.KeyCode.DPadUp] = "rbxasset://textures/ui/Controls/dpadUp.png",
    [Enum.KeyCode.DPadDown] = "rbxasset://textures/ui/Controls/dpadDown.png",
    [Enum.KeyCode.ButtonSelect] = "rbxasset://textures/ui/Controls/xboxView.png",
    [Enum.KeyCode.ButtonStart] = "rbxasset://textures/ui/Controls/xboxmenu.png",
    [Enum.KeyCode.ButtonL1] = "rbxasset://textures/ui/Controls/xboxLB.png",
    [Enum.KeyCode.ButtonR1] = "rbxasset://textures/ui/Controls/xboxRB.png",
    [Enum.KeyCode.ButtonL2] = "rbxasset://textures/ui/Controls/xboxLT.png",
    [Enum.KeyCode.ButtonR2] = "rbxasset://textures/ui/Controls/xboxRT.png",
    [Enum.KeyCode.ButtonL3] = "rbxasset://textures/ui/Controls/xboxLS.png",
    [Enum.KeyCode.ButtonR3] = "rbxasset://textures/ui/Controls/xboxRS.png",
    [Enum.KeyCode.Thumbstick1] = "rbxasset://textures/ui/Controls/xboxLSDirectional.png",
    [Enum.KeyCode.Thumbstick2] = "rbxasset://textures/ui/Controls/xboxRSDirectional.png"
}
local val5 = {
    [Enum.KeyCode.Backspace] = "rbxasset://textures/ui/Controls/backspace.png",
    [Enum.KeyCode.Return] = "rbxasset://textures/ui/Controls/return.png",
    [Enum.KeyCode.LeftShift] = "rbxasset://textures/ui/Controls/shift.png",
    [Enum.KeyCode.RightShift] = "rbxasset://textures/ui/Controls/shift.png",
    [Enum.KeyCode.Tab] = "rbxasset://textures/ui/Controls/tab.png"
}
local val6 = {
    ["'"] = "rbxasset://textures/ui/Controls/apostrophe.png",
    [","] = "rbxasset://textures/ui/Controls/comma.png",
    ["`"] = "rbxasset://textures/ui/Controls/graveaccent.png",
    ["."] = "rbxasset://textures/ui/Controls/period.png",
    [" "] = "rbxasset://textures/ui/Controls/spacebar.png"
}
local val12 = {
    [Enum.KeyCode.LeftControl] = "Ctrl",
    [Enum.KeyCode.RightControl] = "Ctrl",
    [Enum.KeyCode.LeftAlt] = "Alt",
    [Enum.KeyCode.RightAlt] = "Alt",
    [Enum.KeyCode.F1] = "F1",
    [Enum.KeyCode.F2] = "F2",
    [Enum.KeyCode.F3] = "F3",
    [Enum.KeyCode.F4] = "F4",
    [Enum.KeyCode.F5] = "F5",
    [Enum.KeyCode.F6] = "F6",
    [Enum.KeyCode.F7] = "F7",
    [Enum.KeyCode.F8] = "F8",
    [Enum.KeyCode.F9] = "F9",
    [Enum.KeyCode.F10] = "F10",
    [Enum.KeyCode.F11] = "F11",
    [Enum.KeyCode.F12] = "F12"
}

local function _()

    local ProximityPrompts = PlayerGui:FindFirstChild("ProximityPrompts")
    if ProximityPrompts == nil then
        ProximityPrompts = Instance.new("ScreenGui")
        ProximityPrompts.Name = "ProximityPrompts"
        ProximityPrompts.ResetOnSpawn = false
        ProximityPrompts.Parent = PlayerGui
    end

    return ProximityPrompts
end

local function createProgressBarGradient(parent, rotation)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.fromScale(0.5, 1)
    frame.Position = UDim2.fromScale(rotation and 0 or 0.5, 0)
    frame.BackgroundTransparency = 1
    frame.ClipsDescendants = true
    frame.Parent = parent
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.BackgroundTransparency = 1
    imageLabel.Size = UDim2.fromScale(2, 1)
    imageLabel.Position = UDim2.fromScale(rotation and 0 or -1, 0)
    imageLabel.Image = "rbxasset://textures/ui/Controls/RadialFill.png"
    imageLabel.Parent = frame
    local uIGradient = Instance.new("UIGradient")
    uIGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.4999, 0),
        NumberSequenceKeypoint.new(0.5, 1),
        NumberSequenceKeypoint.new(1, 1)
    })
    uIGradient.Rotation = rotation and 180 or 0
    uIGradient.Parent = imageLabel

    return uIGradient
end

local function createCircularProgressBar()

    local frame_2 = Instance.new("Frame")
    frame_2.Name = "CircularProgressBar"
    frame_2.Size = UDim2.fromOffset(58, 58)
    frame_2.AnchorPoint = Vector2.new(0.5, 0.5)
    frame_2.Position = UDim2.fromScale(0.5, 0.5)
    frame_2.BackgroundTransparency = 1
    local ref1 = createProgressBarGradient(frame_2, true)
    local ref2 = createProgressBarGradient(frame_2, false)
    local numberValue = Instance.new("NumberValue")
    numberValue.Name = "Progress"
    numberValue.Parent = frame_2
    numberValue.Changed:Connect(function(val1)

        local val2 = math.clamp(val1 * 360, 0, 360)
        ref1.Rotation = math.clamp(val2, 180, 360)
        ref2.Rotation = math.clamp(val2, 0, 180)
    end)

    return frame_2
end

local function createPrompt(text, flag, parent_2)

    local data = {}
    local data_2 = {}
    local data_3 = {}
    local data_4 = {}
    local tweenInfo = TweenInfo.new(text.HoldDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local tweenInfo_2 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tweenInfo_3 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tweenInfo_4 = TweenInfo.new(0.06, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = "Prompt"
    billboardGui.AlwaysOnTop = true
    local frame_3 = Instance.new("Frame")
    frame_3.Size = UDim2.fromScale(0.5, 1)
    frame_3.BackgroundTransparency = 1
    frame_3.BackgroundColor3 = Color3.new(0.07, 0.07, 0.07)
    frame_3.Parent = billboardGui
    local attribute = text:GetAttribute("State") == "Sell"
    if attribute then
        frame_3.BackgroundColor3 = Color3.fromRGB(67, 0, 0)
    end
    Instance.new("UICorner").Parent = frame_3
    local frame_4 = Instance.new("Frame")
    frame_4.Name = "InputFrame"
    frame_4.Size = UDim2.fromScale(1, 1)
    frame_4.BackgroundTransparency = 1
    frame_4.SizeConstraint = Enum.SizeConstraint.RelativeYY
    frame_4.Parent = frame_3
    local frame_5 = Instance.new("Frame")
    frame_5.Size = UDim2.fromScale(1, 1)
    frame_5.Position = UDim2.fromScale(0.5, 0.5)
    frame_5.AnchorPoint = Vector2.new(0.5, 0.5)
    frame_5.BackgroundTransparency = 1
    frame_5.Parent = frame_4
    local uIScale = Instance.new("UIScale")
    uIScale.Parent = frame_5
    local val3 = flag == Enum.ProximityPromptInputType.Touch and 1.6 or 1.33
    table.insert(data, TweenService:Create(uIScale, tweenInfo_3, {
        Scale = val3
    }))
    table.insert(data_2, TweenService:Create(uIScale, tweenInfo_3, {
        Scale = 1
    }))
    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "ActionText"
    textLabel.Size = UDim2.fromScale(1, 1)
    textLabel.Font = Enum.Font.GothamMedium
    textLabel.TextSize = 19
    textLabel.BackgroundTransparency = 1
    textLabel.TextTransparency = 1
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.Parent = frame_3
    table.insert(data, TweenService:Create(textLabel, tweenInfo_3, {
        TextTransparency = 1
    }))
    table.insert(data_2, TweenService:Create(textLabel, tweenInfo_3, {
        TextTransparency = 0
    }))
    table.insert(data_3, TweenService:Create(textLabel, tweenInfo_3, {
        TextTransparency = 1
    }))
    table.insert(data_4, TweenService:Create(textLabel, tweenInfo_3, {
        TextTransparency = 0
    }))
    local textLabel_2 = Instance.new("TextLabel")
    textLabel_2.Name = "ObjectText"
    textLabel_2.Size = UDim2.fromScale(1, 1)
    textLabel_2.Font = Enum.Font.GothamMedium
    textLabel_2.TextSize = 14
    textLabel_2.BackgroundTransparency = 1
    textLabel_2.TextTransparency = 1
    textLabel_2.TextColor3 = Color3.new(0.7, 0.7, 0.7)
    textLabel_2.TextXAlignment = Enum.TextXAlignment.Left
    textLabel_2.Parent = frame_3
    table.insert(data, TweenService:Create(textLabel_2, tweenInfo_3, {
        TextTransparency = 1
    }))
    table.insert(data_2, TweenService:Create(textLabel_2, tweenInfo_3, {
        TextTransparency = 0
    }))
    table.insert(data_3, TweenService:Create(textLabel_2, tweenInfo_3, {
        TextTransparency = 1
    }))
    table.insert(data_4, TweenService:Create(textLabel_2, tweenInfo_3, {
        TextTransparency = 0
    }))
    table.insert(data, TweenService:Create(frame_3, tweenInfo_3, {
        Size = UDim2.fromScale(0.5, 1),
        BackgroundTransparency = 1
    }))
    table.insert(data_2, TweenService:Create(frame_3, tweenInfo_3, {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 0.2
    }))
    table.insert(data_3, TweenService:Create(frame_3, tweenInfo_3, {
        Size = UDim2.fromScale(0.5, 1),
        BackgroundTransparency = 1
    }))
    table.insert(data_4, TweenService:Create(frame_3, tweenInfo_3, {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 0.2
    }))
    local frame_6 = Instance.new("Frame")
    frame_6.Name = "RoundFrame"
    frame_6.Size = UDim2.fromOffset(48, 48)
    frame_6.AnchorPoint = Vector2.new(0.5, 0.5)
    frame_6.Position = UDim2.fromScale(0.5, 0.5)
    frame_6.BackgroundTransparency = 1
    frame_6.Parent = frame_5
    local uICorner = Instance.new("UICorner")
    uICorner.CornerRadius = UDim.new(0.5, 0)
    uICorner.Parent = frame_6
    table.insert(data_3, TweenService:Create(frame_6, tweenInfo_4, {
        BackgroundTransparency = 1
    }))
    table.insert(data_4, TweenService:Create(frame_6, tweenInfo_4, {
        BackgroundTransparency = 0.5
    }))
    if flag == Enum.ProximityPromptInputType.Gamepad then
        if flag_2[text.GamepadKeyCode] ~= nil then
            local imageLabel_2 = Instance.new("ImageLabel")
            imageLabel_2.Name = "ButtonImage"
            imageLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
            imageLabel_2.Size = UDim2.fromOffset(24, 24)
            imageLabel_2.Position = UDim2.fromScale(0.5, 0.5)
            imageLabel_2.BackgroundTransparency = 1
            imageLabel_2.ImageTransparency = 1
            imageLabel_2.Image = UserInputService:GetImageForKeyCode(text.GamepadKeyCode)
            imageLabel_2.Parent = frame_5
            table.insert(data_3, TweenService:Create(imageLabel_2, tweenInfo_4, {
                ImageTransparency = 1
            }))
            table.insert(data_4, TweenService:Create(imageLabel_2, tweenInfo_4, {
                ImageTransparency = 0
            }))
        end
    elseif flag == Enum.ProximityPromptInputType.Touch then
        local imageLabel_3 = Instance.new("ImageLabel")
        imageLabel_3.Name = "ButtonImage"
        imageLabel_3.BackgroundTransparency = 1
        imageLabel_3.ImageTransparency = 1
        imageLabel_3.Size = UDim2.fromOffset(25, 31)
        imageLabel_3.AnchorPoint = Vector2.new(0.5, 0.5)
        imageLabel_3.Position = UDim2.fromScale(0.5, 0.5)
        imageLabel_3.Image = "rbxasset://textures/ui/Controls/TouchTapIcon.png"
        imageLabel_3.Parent = frame_5
        table.insert(data_3, TweenService:Create(imageLabel_3, tweenInfo_4, {
            ImageTransparency = 1
        }))
        table.insert(data_4, TweenService:Create(imageLabel_3, tweenInfo_4, {
            ImageTransparency = 0
        }))
    else
        local imageLabel_4 = Instance.new("ImageLabel")
        imageLabel_4.Name = "ButtonImage"
        imageLabel_4.BackgroundTransparency = 1
        imageLabel_4.ImageTransparency = 1
        imageLabel_4.Size = UDim2.fromOffset(28, 30)
        imageLabel_4.AnchorPoint = Vector2.new(0.5, 0.5)
        imageLabel_4.Position = UDim2.fromScale(0.5, 0.5)
        imageLabel_4.Image = "rbxasset://textures/ui/Controls/key_single.png"
        imageLabel_4.Parent = frame_5
        table.insert(data_3, TweenService:Create(imageLabel_4, tweenInfo_4, {
            ImageTransparency = 1
        }))
        table.insert(data_4, TweenService:Create(imageLabel_4, tweenInfo_4, {
            ImageTransparency = 0
        }))
        local stringForKeyCode = UserInputService:GetStringForKeyCode(text.KeyboardKeyCode)
        local v6Data = val5[text.KeyboardKeyCode]
        if v6Data == nil then
            v6Data = val6[stringForKeyCode]
        end

        if v6Data == nil then
            local v8Data = val12[text.KeyboardKeyCode]
            if v8Data then
                stringForKeyCode = v8Data
            end
        end

        if v6Data then
            local imageLabel_5 = Instance.new("ImageLabel")
            imageLabel_5.Name = "ButtonImage"
            imageLabel_5.AnchorPoint = Vector2.new(0.5, 0.5)
            imageLabel_5.Size = UDim2.fromOffset(36, 36)
            imageLabel_5.Position = UDim2.fromScale(0.5, 0.5)
            imageLabel_5.BackgroundTransparency = 1
            imageLabel_5.ImageTransparency = 1
            imageLabel_5.Image = v6Data
            imageLabel_5.Parent = frame_5
            table.insert(data_3, TweenService:Create(imageLabel_5, tweenInfo_4, {
                ImageTransparency = 1
            }))
            table.insert(data_4, TweenService:Create(imageLabel_5, tweenInfo_4, {
                ImageTransparency = 0
            }))
        elseif stringForKeyCode ~= nil and stringForKeyCode ~= "" then
            local textLabel_3 = Instance.new("TextLabel")
            textLabel_3.Name = "ButtonText"
            textLabel_3.Position = UDim2.fromOffset(0, -1)
            textLabel_3.Size = UDim2.fromScale(1, 1)
            textLabel_3.Font = Enum.Font.GothamMedium
            textLabel_3.TextSize = 14
            if string.len(stringForKeyCode) > 2 then
                textLabel_3.TextSize = 12
            end
            textLabel_3.BackgroundTransparency = 1
            textLabel_3.TextTransparency = 1
            textLabel_3.TextColor3 = Color3.new(1, 1, 1)
            textLabel_3.TextXAlignment = Enum.TextXAlignment.Center
            textLabel_3.Text = stringForKeyCode
            textLabel_3.Parent = frame_5
            table.insert(data_3, TweenService:Create(textLabel_3, tweenInfo_4, {
                TextTransparency = 1
            }))
            table.insert(data_4, TweenService:Create(textLabel_3, tweenInfo_4, {
                TextTransparency = 0
            }))
        else
            error("ProximityPrompt '" .. text.Name .. "' has an unsupported keycode for rendering UI: " .. tostring(text.KeyboardKeyCode))
        end
    end

    if flag == Enum.ProximityPromptInputType.Touch or text.ClickablePrompt then
        local textButton = Instance.new("TextButton")
        textButton.BackgroundTransparency = 1
        textButton.TextTransparency = 1
        textButton.Size = UDim2.fromScale(1, 1)
        textButton.Parent = billboardGui
        local val4 = false
        do
            local v55 = val4
            textButton.InputBegan:Connect(function(ref3)

                if (ref3.UserInputType == Enum.UserInputType.Touch or ref3.UserInputType == Enum.UserInputType.MouseButton1) and ref3.UserInputState ~= Enum.UserInputState.Change then
                    text:InputHoldBegin()
                    v55 = true
                end
            end)
            textButton.InputEnded:Connect(function(ref4)

                if (ref4.UserInputType == Enum.UserInputType.Touch or ref4.UserInputType == Enum.UserInputType.MouseButton1) and v55 then
                    v55 = false
                    text:InputHoldEnd()
                end
            end)
            billboardGui.Active = true
        end
    end

    if text.HoldDuration > 0 then
        local ref5 = createCircularProgressBar()
        ref5.Parent = frame_5
        table.insert(data, TweenService:Create(ref5.Progress, tweenInfo, {
            Value = 1
        }))
        table.insert(data_2, TweenService:Create(ref5.Progress, tweenInfo_2, {
            Value = 0
        }))
    end
    local connectResult = nil
    local connectResult_2 = nil
    local connectResult_3 = nil
    local connectResult_4 = nil
    if text.HoldDuration > 0 then
        connectResult = text.PromptButtonHoldBegan:Connect(function()

            for _, v27Entry in ipairs(data) do
                v27Entry:Play()
            end
        end)
        connectResult_2 = text.PromptButtonHoldEnded:Connect(function()

            for _, v28Entry in ipairs(data_2) do
                v28Entry:Play()
            end
        end)
    end
    connectResult_3 = text.Triggered:Connect(function()

        for _, v29Entry in ipairs(data_3) do
            v29Entry:Play()
        end
    end)
    connectResult_4 = text.TriggerEnded:Connect(function()

        for _, v30Entry in ipairs(data_4) do
            v30Entry:Play()
        end
    end)

    local function updateUIFromPrompt()

        local textSize = TextService:GetTextSize(text.ActionText, 19, Enum.Font.GothamMedium, Vector2.new(1000, 1000))
        local textSize_2 = TextService:GetTextSize(text.ObjectText, 14, Enum.Font.GothamMedium, Vector2.new(1000, 1000))
        local val7 = math.max(textSize.X, textSize_2.X)
        local val8 = 72
        local val9 = 72
        local val10 = 72
        if attribute then
            val10 = 62
            val9 = 62
            val8 = 62
        end

        if text.ActionText ~= nil and text.ActionText ~= "" or text.ObjectText ~= nil and text.ObjectText ~= "" then
            val9 = val7 + val10 + 24
        end
        local val11 = 0
        if text.ObjectText ~= nil and text.ObjectText ~= "" then
            val11 = 9
        end
        textLabel.Position = UDim2.new(0.5, val10 - val9 / 2, 0, val11)
        textLabel_2.Position = UDim2.new(0.5, val10 - val9 / 2, 0, -10)
        textLabel.Text = text.ActionText
        textLabel_2.Text = text.ObjectText
        textLabel.AutoLocalize = text.AutoLocalize
        textLabel.RootLocalizationTable = text.RootLocalizationTable
        textLabel_2.AutoLocalize = text.AutoLocalize
        textLabel_2.RootLocalizationTable = text.RootLocalizationTable
        billboardGui.Size = UDim2.fromOffset(val9, val8)
        billboardGui.SizeOffset = Vector2.new(text.UIOffset.X / billboardGui.Size.Width.Offset, text.UIOffset.Y / billboardGui.Size.Height.Offset)
    end
    local eventObj = text.Changed:Connect(updateUIFromPrompt)
    task.spawn(updateUIFromPrompt)
    billboardGui.Adornee = text.Parent
    billboardGui.Parent = parent_2
    for _, v30Entry_2 in ipairs(data_4) do
        v30Entry_2:Play()
    end
    local flag_3 = false

    return function()

        if flag_3 then
            return
        else
            flag_3 = true
            if connectResult then
                connectResult:Disconnect()
            end

            if connectResult_2 then
                connectResult_2:Disconnect()
            end
            connectResult_3:Disconnect()
            connectResult_4:Disconnect()
            eventObj:Disconnect()
            for _, v29Entry_2 in ipairs(data_3) do
                v29Entry_2:Play()
            end
            task.wait(0.2)
            billboardGui.Parent = nil
            return
        end
    end
end

task.spawn(function()

    local val13 = false
    local data_5 = {}
    ProximityPromptService.PromptShown:Connect(function(getAttributeObj, val14)

        if getAttributeObj.Style == Enum.ProximityPromptStyle.Default or getAttributeObj:GetAttribute("CustomStyleDisabled") then
            return
        elseif (getAttributeObj:GetAttribute("State") == "Sell" or getAttributeObj:GetAttribute("State") == "Grab") and val13 then
            return
        else
            local ProximityPrompts_2 = PlayerGui:FindFirstChild("ProximityPrompts")
            if ProximityPrompts_2 == nil then
                ProximityPrompts_2 = Instance.new("ScreenGui")
                ProximityPrompts_2.Name = "ProximityPrompts"
                ProximityPrompts_2.ResetOnSpawn = false
                ProximityPrompts_2.Parent = PlayerGui
            end
            ProximityPrompts_2 = createPrompt(getAttributeObj, val14, ProximityPrompts_2)
            local propertyChangedSignal = nil
            local connectResult_5 = nil

            local function cleanupFunction()

                data_5[getAttributeObj] = nil
                if propertyChangedSignal then
                    propertyChangedSignal:Disconnect()
                end

                if connectResult_5 then
                    connectResult_5:Disconnect()
                end
                ProximityPrompts_2()
            end
            propertyChangedSignal = getAttributeObj:GetPropertyChangedSignal("Enabled"):Connect(function()

                if not getAttributeObj.Enabled then
                    data_5[getAttributeObj] = nil
                    if propertyChangedSignal then
                        propertyChangedSignal:Disconnect()
                    end

                    if connectResult_5 then
                        connectResult_5:Disconnect()
                    end
                    ProximityPrompts_2()
                end
            end)
            connectResult_5 = getAttributeObj.PromptHidden:Connect(function()

                data_5[getAttributeObj] = nil
                if propertyChangedSignal then
                    propertyChangedSignal:Disconnect()
                end

                if connectResult_5 then
                    connectResult_5:Disconnect()
                end
                ProximityPrompts_2()
            end)

            if not getAttributeObj.Enabled then
                data_5[getAttributeObj] = nil
                if propertyChangedSignal then
                    propertyChangedSignal:Disconnect()
                end

                if connectResult_5 then
                    connectResult_5:Disconnect()
                end
                ProximityPrompts_2()
            else
                data_5[getAttributeObj] = cleanupFunction
            end
            return
        end
    end)
    ProximityPromptService.PromptHidden:Connect(function(val15)

        if data_5[val15] then
            data_5[val15]()
            data_5[val15] = nil
        end
    end)
    ProximityPromptService.PromptButtonHoldBegan:Connect(function()

        val13 = true
    end)
    ProximityPromptService.PromptButtonHoldEnded:Connect(function()

        val13 = false
    end)
end)

return {}
