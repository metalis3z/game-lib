-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ProximityPromptService = game:GetService("ProximityPromptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextService = game:GetService("TextService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local InputIconsConfig = require(ReplicatedStorage.Client.InputIconsConfig)
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local v1 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v2 = {}

local function cleanupWildEggTween() -- line 18 | captures: v2
    if v2.tween then
        v2.tween:Cancel()
        v2.tween = nil
    end
end

local function isWildEggPrompt(v3) -- line 24
    local function v4(...)
        return (typeof(...))
    end

    if v4(v3:GetAttribute("Progress")) == "number" then
        local Parent = v3.Parent
        if Parent then
            return Parent.Name == "WildAssetEgg"
        end
    end
    return false
end

local function applyWildEggZoom(v5, v6) -- line 35 | captures: TweenService, Workspace, v1, v2
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera then
        local v7 = math.clamp(v6, 0, 1)
        if v7 <= 0 then
            if v2.prompt == v5 and v2.baseFov then
                if v2.tween then
                    v2.tween:Cancel()
                    v2.tween = nil
                end
                v2.tween = TweenService:Create(CurrentCamera, v1, { FieldOfView = v2.baseFov })
                local tween = v2.tween
                assert(tween, "luau")
                v2.tween:Play()
                v2.prompt = nil
                v2.baseFov = nil
            end
        else
            if v2.prompt ~= v5 then
                v2.prompt = v5
                v2.baseFov = CurrentCamera.FieldOfView
            end
            local baseFov = v2.baseFov
            if baseFov then
                local v8 = baseFov - 30
                local v9 = baseFov + (math.max(40, v8) - baseFov) * v7
                local v10 = CurrentCamera.FieldOfView - v9
                if not (math.abs(v10) < 0.001) then
                    if v2.tween then
                        v2.tween:Cancel()
                        v2.tween = nil
                    end
                    v2.tween = TweenService:Create(CurrentCamera, v1, { FieldOfView = v9 })
                    local tween = v2.tween
                    assert(tween, "luau")
                    v2.tween:Play()
                end
            end
        end
    end
end

local function gamepadButtonImage(v11) -- line 77 | captures: InputIconsConfig
    return InputIconsConfig.Image(v11)
end

local v12 = {}

v12[Enum.KeyCode.Backspace] = "rbxasset://textures/ui/Controls/backspace.png"
v12[Enum.KeyCode.Return] = "rbxasset://textures/ui/Controls/return.png"
v12[Enum.KeyCode.LeftShift] = "rbxasset://textures/ui/Controls/shift.png"
v12[Enum.KeyCode.RightShift] = "rbxasset://textures/ui/Controls/shift.png"
v12[Enum.KeyCode.Tab] = "rbxasset://textures/ui/Controls/tab.png"

local v13 = {}

v13["'"] = "rbxasset://textures/ui/Controls/apostrophe.png"
v13[","] = "rbxasset://textures/ui/Controls/comma.png"
v13["`"] = "rbxasset://textures/ui/Controls/graveaccent.png"
v13["."] = "rbxasset://textures/ui/Controls/period.png"
v13[" "] = "rbxasset://textures/ui/Controls/spacebar.png"

local v14 = {}

v14[Enum.KeyCode.LeftControl] = "Ctrl"
v14[Enum.KeyCode.RightControl] = "Ctrl"
v14[Enum.KeyCode.LeftAlt] = "Alt"
v14[Enum.KeyCode.RightAlt] = "Alt"
v14[Enum.KeyCode.F1] = "F1"
v14[Enum.KeyCode.F2] = "F2"
v14[Enum.KeyCode.F3] = "F3"
v14[Enum.KeyCode.F4] = "F4"
v14[Enum.KeyCode.F5] = "F5"
v14[Enum.KeyCode.F6] = "F6"
v14[Enum.KeyCode.F7] = "F7"
v14[Enum.KeyCode.F8] = "F8"
v14[Enum.KeyCode.F9] = "F9"
v14[Enum.KeyCode.F10] = "F10"
v14[Enum.KeyCode.F11] = "F11"
v14[Enum.KeyCode.F12] = "F12"

local function getScreenGui() -- line 109 | captures: PlayerGui
    local ProximityPrompts = PlayerGui:FindFirstChild("ProximityPrompts")
    if ProximityPrompts == nil then
        ProximityPrompts = Instance.new("ScreenGui")
        ProximityPrompts.Name = "ProximityPrompts"
        ProximityPrompts.ResetOnSpawn = false
        ProximityPrompts.Parent = PlayerGui
    end
    return ProximityPrompts
end

local function setUpCircularProgressBar(v15) -- line 119
    local UIGradient = v15.LeftGradient.ProgressBarImage.UIGradient
    local UIGradient_2 = v15.RightGradient.ProgressBarImage.UIGradient
    v15.Progress.Changed:Connect(function(v16) -- line 122 | captures: UIGradient, UIGradient_2
        local v17 = v16 * 360
        local v18 = math.clamp(v17, 0, 360)
        UIGradient.Rotation = math.clamp(v18, 180, 360)
        UIGradient_2.Rotation = math.clamp(v18, 0, 180)
    end)
end

local function createPrompt(v19, v20, v21) -- line 128 | captures: TextService, TweenService, UserInputService, Workspace, InputIconsConfig, LocalPlayer, v1, v2, applyWildEggZoom, v12, v13, v14
    local function v22(v23, ...)
        table.insert(v23, ...)
    end

    local function v24(v25, ...)
        table.insert(v25, ...)
    end

    local function v26(v27, ...)
        table.insert(v27, ...)
    end

    local function v28(v29, ...)
        table.insert(v29, ...)
    end

    local function v30(v31, ...)
        table.insert(v31, ...)
    end

    local function v32(v33, ...)
        table.insert(v33, ...)
    end

    local function v34(v35, ...)
        table.insert(v35, ...)
    end

    local function v36(v37, ...)
        table.insert(v37, ...)
    end

    local function v38(v39, ...)
        table.insert(v39, ...)
    end

    local function v40(v41, ...)
        table.insert(v41, ...)
    end

    local function v42(v43, ...)
        table.insert(v43, ...)
    end

    local function v44(v45, ...)
        table.insert(v45, ...)
    end

    local function v46(v47, ...)
        table.insert(v47, ...)
    end

    local function v48(v49, ...)
        table.insert(v49, ...)
    end

    local function v50(...)
        return (typeof(...))
    end

    local function v51(...)
        return (typeof(...))
    end

    local function v52(v53, ...)
        table.insert(v53, ...)
    end

    local function v54(v55, ...)
        table.insert(v55, ...)
    end

    local UIGradient
    local v56 = {}
    local v57 = {}
    local v58 = {}
    local v59 = {}
    local v60 = TweenInfo.new(v19.HoldDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local v61 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local v62 = TweenInfo.new(0.06, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local v63 = TweenInfo.new(0, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local v64
    local Theme = v19:GetAttribute("Theme")
    local v65
    if Theme then
        local v66 = script:FindFirstChild(Theme)
        if v66 then
            v65 = v66:Clone()
            v64 = v65
        end
    end
    if v65 == nil then
        v65 = script.Default:Clone()
        v64 = v65
    end
    v65.Enabled = true
    local PromptFrame = v65.PromptFrame
    local InputFrame = PromptFrame.InputFrame
    local ActionText = PromptFrame.ActionText
    local ObjectText = PromptFrame.ObjectText
    local BackgroundTransparency = PromptFrame.BackgroundTransparency
    local ImageTransparency = PromptFrame.ImageTransparency
    PromptFrame.BackgroundTransparency = 1
    PromptFrame.ImageTransparency = 1
    v22(v56, TweenService:Create(PromptFrame, v61, {
        BackgroundTransparency = 1,
        ImageTransparency = 1,
        Size = UDim2.fromScale(0.5, 1)
    }))
    v24(v57, TweenService:Create(PromptFrame, v61, {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = BackgroundTransparency,
        ImageTransparency = ImageTransparency
    }))
    v26(v58, TweenService:Create(PromptFrame, v61, {
        BackgroundTransparency = 1,
        ImageTransparency = 1,
        Size = UDim2.fromScale(0.5, 1)
    }))
    v28(v59, TweenService:Create(PromptFrame, v61, {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = BackgroundTransparency,
        ImageTransparency = ImageTransparency
    }))

    local function setupUIStrokeTweens(v67) -- line 163 | captures: v56, v57, v58, v59, v61, TweenService
        local function v68(v69, ...)
            table.insert(v69, ...)
        end

        local function v70(v71, ...)
            table.insert(v71, ...)
        end

        local function v72(v73, ...)
            table.insert(v73, ...)
        end

        local function v74(v75, ...)
            table.insert(v75, ...)
        end

        local Transparency = v67.Transparency
        v67.Transparency = 1
        v68(v56, TweenService:Create(v67, v61, { Transparency = 1 }))
        v70(v57, TweenService:Create(v67, v61, { Transparency = Transparency }))
        v72(v58, TweenService:Create(v67, v61, { Transparency = 1 }))
        v74(v59, TweenService:Create(v67, v61, { Transparency = Transparency }))
    end

    local function setupGUIObjectTweens(v76) -- line 171 | captures: v56, v57, v58, v59, v61, TweenService
        local function v77(v78, ...)
            table.insert(v78, ...)
        end

        local function v79(v80, ...)
            table.insert(v80, ...)
        end

        local function v81(v82, ...)
            table.insert(v82, ...)
        end

        local function v83(v84, ...)
            table.insert(v84, ...)
        end

        local BackgroundTransparency = v76.BackgroundTransparency
        v76.BackgroundTransparency = 1
        v77(v56, TweenService:Create(v76, v61, { BackgroundTransparency = 1 }))
        v79(v57, TweenService:Create(v76, v61, { BackgroundTransparency = BackgroundTransparency }))
        v81(v58, TweenService:Create(v76, v61, { BackgroundTransparency = 1 }))
        v83(v59, TweenService:Create(v76, v61, { BackgroundTransparency = BackgroundTransparency }))
    end

    local function setupTextLabelTweens(v85) -- line 179 | captures: v56, v57, v58, v59, v61, TweenService
        local function v86(v87, ...)
            table.insert(v87, ...)
        end

        local function v88(v89, ...)
            table.insert(v89, ...)
        end

        local function v90(v91, ...)
            table.insert(v91, ...)
        end

        local function v92(v93, ...)
            table.insert(v93, ...)
        end

        local TextTransparency = v85.TextTransparency
        local TextStrokeTransparency = v85.TextStrokeTransparency
        v85.TextTransparency = 1
        v85.TextStrokeTransparency = 1
        v86(v56, TweenService:Create(v85, v61, {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }))
        v88(v57, TweenService:Create(v85, v61, {
            TextTransparency = TextTransparency,
            TextStrokeTransparency = TextStrokeTransparency
        }))
        v90(v58, TweenService:Create(v85, v61, {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }))
        v92(v59, TweenService:Create(v85, v61, {
            TextTransparency = TextTransparency,
            TextStrokeTransparency = TextStrokeTransparency
        }))
    end

    local function setupImageLabelTweens(v94) -- line 189 | captures: v56, v57, v58, v59, v61, TweenService
        local function v95(v96, ...)
            table.insert(v96, ...)
        end

        local function v97(v98, ...)
            table.insert(v98, ...)
        end

        local function v99(v100, ...)
            table.insert(v100, ...)
        end

        local function v101(v102, ...)
            table.insert(v102, ...)
        end

        local ImageTransparency = v94.ImageTransparency
        v94.ImageTransparency = 1
        v95(v56, TweenService:Create(v94, v61, { ImageTransparency = 1 }))
        v97(v57, TweenService:Create(v94, v61, { ImageTransparency = ImageTransparency }))
        v99(v58, TweenService:Create(v94, v61, { ImageTransparency = 1 }))
        v101(v59, TweenService:Create(v94, v61, { ImageTransparency = ImageTransparency }))
    end

    local v103

    function v103(v104) -- line 197 | captures: v103, setupUIStrokeTweens, setupGUIObjectTweens, setupTextLabelTweens, setupImageLabelTweens
        if v104:IsA("UIStroke") then
            setupUIStrokeTweens(v104)
        elseif not v104:IsA("UIGradient") and v104:IsA("GuiObject") then
            setupGUIObjectTweens(v104)
            if v104:IsA("TextLabel") then
                setupTextLabelTweens(v104)
            elseif v104:IsA("ImageLabel") then
                setupImageLabelTweens(v104)
            end
        end
        for v105, v106 in pairs(v104:GetChildren()) do
            v103(v106)
        end
    end

    local v107 = {}
    v107[InputFrame] = false
    v107[ActionText] = true
    v107[ObjectText] = true
    for v108, v109 in pairs(PromptFrame:GetChildren()) do
        if v107[v109] == nil then
            v103(v109)
        elseif v107[v109] == true then
            for v110, v111 in pairs(v109:GetChildren()) do
                v103(v111)
            end
        end
    end
    local Frame = InputFrame.Frame
    local UIScale = Frame.UIScale
    local v112 = if v20 == Enum.ProximityPromptInputType.Touch then 1.6 else 1.33
    v30(v56, TweenService:Create(UIScale, v61, { Scale = v112 }))
    v32(v57, TweenService:Create(UIScale, v61, { Scale = 1 }))
    setupTextLabelTweens(ActionText)
    setupTextLabelTweens(ObjectText)
    local ButtonFrame = Frame.ButtonFrame
    v34(v58, TweenService:Create(ButtonFrame, v62, {
        BackgroundTransparency = 1,
        ImageTransparency = 1
    }))
    v36(v59, TweenService:Create(ButtonFrame, v62, {
        BackgroundTransparency = ButtonFrame.BackgroundTransparency,
        ImageTransparency = ButtonFrame.ImageTransparency
    }))
    for v113, v114 in pairs(ButtonFrame:getChildren()) do
        if v114:IsA("UIStroke") then
            v38(v58, TweenService:Create(v114, v62, { Transparency = 1 }))
            v40(v59, TweenService:Create(v114, v62, { Transparency = v114.Transparency }))
        end
    end
    local ButtonImage = Frame.ButtonImage
    local ButtonText = Frame.ButtonText
    local ButtonTextImage = Frame.ButtonTextImage

    local function setupButtonImageTweens() -- line 251 | captures: v58, v59, v62, ButtonImage, TweenService
        local function v115(v116, ...)
            table.insert(v116, ...)
        end

        local function v117(v118, ...)
            table.insert(v118, ...)
        end

        local BackgroundTransparency = ButtonImage.BackgroundTransparency
        local ImageTransparency = ButtonImage.ImageTransparency
        ButtonImage.BackgroundTransparency = 1
        ButtonImage.ImageTransparency = 1
        v115(v58, TweenService:Create(ButtonImage, v62, {
            ImageTransparency = 1,
            BackgroundTransparency = 1
        }))
        v117(v59, TweenService:Create(ButtonImage, v62, {
            ImageTransparency = ImageTransparency,
            BackgroundTransparency = BackgroundTransparency
        }))
    end

    local function setupIconTweens() -- line 259 | captures: v58, v59, v62, ButtonTextImage, TweenService
        local function v119(v120, ...)
            table.insert(v120, ...)
        end

        local function v121(v122, ...)
            table.insert(v122, ...)
        end

        local BackgroundTransparency = ButtonTextImage.BackgroundTransparency
        local ImageTransparency = ButtonTextImage.ImageTransparency
        ButtonTextImage.BackgroundTransparency = 1
        ButtonTextImage.ImageTransparency = 1
        v119(v58, TweenService:Create(ButtonTextImage, v62, {
            ImageTransparency = 1,
            BackgroundTransparency = 1
        }))
        v121(v59, TweenService:Create(ButtonTextImage, v62, {
            ImageTransparency = ImageTransparency,
            BackgroundTransparency = BackgroundTransparency
        }))
    end

    if v20 == Enum.ProximityPromptInputType.Gamepad then
        local v123 = InputIconsConfig.Image(v19.GamepadKeyCode)
        if v123 then
            setupIconTweens()
            ButtonTextImage.Image = v123
            ButtonText.Visible = false
            ButtonImage.Visible = false
            ButtonTextImage.Visible = true
        end
    elseif v20 == Enum.ProximityPromptInputType.Touch then
        setupButtonImageTweens()
        ButtonImage.Image = "rbxasset://textures/ui/Controls/TouchTapIcon.png"
        ButtonText.Visible = false
        ButtonTextImage.Visible = false
        ButtonImage.Visible = true
    else
        setupButtonImageTweens()
        ButtonImage.Visible = true
        local v124 = UserInputService:GetStringForKeyCode(v19.KeyboardKeyCode)
        local v125 = v12[v19.KeyboardKeyCode]
        if v125 == nil then
            v125 = v13[v124]
        end
        if v125 == nil then
            v124 = v14[v19.KeyboardKeyCode] or v124
        end
        if v125 then
            setupIconTweens()
            ButtonTextImage.Image = v125
            ButtonText.Visible = false
            ButtonTextImage.Visible = true
        elseif v124 == nil then
            local error_2 = error
            local Name = v19.Name
            local KeyboardKeyCode = v19.KeyboardKeyCode
            error_2("ProximityPrompt '" .. Name .. "' has an unsupported keycode for rendering UI: " .. tostring(KeyboardKeyCode))
        elseif v124 ~= "" then
            if string.len(v124) > 2 then
                local v126 = ButtonText.TextSize * 6 / 7
                ButtonText.TextSize = math.round(v126)
            end
            local BackgroundTransparency = ButtonText.BackgroundTransparency
            local TextStrokeTransparency = ButtonText.TextStrokeTransparency
            local TextTransparency = ButtonText.TextTransparency
            ButtonText.BackgroundTransparency = 1
            ButtonText.TextStrokeTransparency = 1
            ButtonText.TextTransparency = 1
            v42(v58, TweenService:Create(ButtonText, v62, {
                TextTransparency = 1,
                TextStrokeTransparency = 1,
                BackgroundTransparency = 1
            }))
            v44(v59, TweenService:Create(ButtonText, v62, {
                TextTransparency = TextTransparency,
                TextStrokeTransparency = TextStrokeTransparency,
                BackgroundTransparency = BackgroundTransparency
            }))
            for v127, v128 in pairs(ButtonText:getChildren()) do
                if v128:IsA("UIStroke") then
                    v46(v58, TweenService:Create(v128, v62, { Transparency = 1 }))
                    v48(v59, TweenService:Create(v128, v62, { Transparency = v128.Transparency }))
                end
            end
            ButtonText.Text = v124
            ButtonTextImage.Visible = false
            ButtonText.Visible = true
        end
    end
    local v129
    if v20 == Enum.ProximityPromptInputType.Touch then
        local TextButton = v65.TextButton
        v129 = false
        TextButton.InputBegan:Connect(function(v130) -- line 333 | captures: v129, v19
            if v130.UserInputType == Enum.UserInputType.Touch then
                if v130.UserInputState ~= Enum.UserInputState.Change then
                    v19:InputHoldBegin()
                    v129 = true
                end
            elseif v130.UserInputType == Enum.UserInputType.MouseButton1 and v130.UserInputState ~= Enum.UserInputState.Change then
                v19:InputHoldBegin()
                v129 = true
            end
        end)
        TextButton.InputEnded:Connect(function(v131) -- line 344 | captures: v129, v19
            if v131.UserInputType == Enum.UserInputType.Touch then
                if v129 then
                    v129 = false
                    v19:InputHoldEnd()
                end
            elseif v131.UserInputType == Enum.UserInputType.MouseButton1 and v129 then
                v129 = false
                v19:InputHoldEnd()
            end
        end)
        v65.Active = true
    elseif v19.ClickablePrompt then
    end
    v129 = v50(v19:GetAttribute("Progress"))
    local v132, v133
    if v129 == "number" then
        v129 = v19.Parent
        if v129 and v129.Name == "WildAssetEgg" then
            v132 = true
            v133 = true
        else
            v132 = false
            v133 = false
        end
    else
        v132 = false
        v133 = false
    end
    v129 = nil
    local v134
    if v19.HoldDuration > 0 then
        local ProgressBar = Frame.ProgressBar
        UIGradient = ProgressBar.LeftGradient.ProgressBarImage.UIGradient
        local UIGradient_2 = ProgressBar.RightGradient.ProgressBarImage.UIGradient
        ProgressBar.Progress.Changed:Connect(function(v135) -- line 377 | captures: UIGradient, UIGradient_2
            local v136 = v135 * 360
            local v137 = math.clamp(v136, 0, 360)
            UIGradient.Rotation = math.clamp(v137, 180, 360)
            UIGradient_2.Rotation = math.clamp(v137, 0, 180)
        end)
        local v138 = "Progress_" .. LocalPlayer.UserId
        if v51(v19:GetAttribute("Progress")) == "number" then
            local v139 = v19:GetAttribute(v138)
            if typeof(v139) ~= "number" then
                v139 = 0
            end
            ProgressBar.Progress.Value = v139
            if v133 then
                applyWildEggZoom(v19, v139)
            end
            v129 = v19:GetAttributeChangedSignal(v138):Connect(function() -- line 396 | captures: v132, v19, ProgressBar, v138, applyWildEggZoom
                local v140 = v19:GetAttribute(v138)
                if typeof(v140) ~= "number" then
                    v140 = 0
                end
                ProgressBar.Progress.Value = v140
                if v132 then
                    applyWildEggZoom(v19, v140)
                end
            end)
            if v132 then
                v134 = v19.AncestryChanged:Connect(function(v141, v142) -- line 407 | captures: v19, TweenService, Workspace, v1, v2
                    if v142 == nil then
                        local CurrentCamera = Workspace.CurrentCamera
                        if CurrentCamera and v2.prompt == v19 and v2.baseFov then
                            if v2.tween then
                                v2.tween:Cancel()
                                v2.tween = nil
                            end
                            v2.tween = TweenService:Create(CurrentCamera, v1, { FieldOfView = v2.baseFov })
                            local tween = v2.tween
                            assert(tween, "luau")
                            v2.tween:Play()
                            v2.prompt = nil
                            v2.baseFov = nil
                        end
                    end
                end)
            end
        else
            v52(v56, TweenService:Create(ProgressBar.Progress, v60, { Value = 1 }))
            v54(v57, TweenService:Create(ProgressBar.Progress, v63, { Value = 0 }))
        end
    end
    local v143, v144
    if v19.HoldDuration > 0 then
        v143 = v19.PromptButtonHoldBegan:Connect(function() -- line 433 | captures: v56
            for v145, v146 in ipairs(v56) do
                v146:Play()
            end
        end)
        v144 = v19.PromptButtonHoldEnded:Connect(function() -- line 438 | captures: v57
            for v147, v148 in ipairs(v57) do
                v148:Play()
            end
        end)
    end
    local v149 = v19.Triggered:Connect(function() -- line 444 | captures: v58
        for v150, v151 in ipairs(v58) do
            v151:Play()
        end
    end)
    local v152 = v19.TriggerEnded:Connect(function() -- line 449 | captures: v59
        for v153, v154 in ipairs(v59) do
            v154:Play()
        end
    end)

    local function getTextBoundsForLabel(v155, v156) -- line 454 | captures: TextService
        local GetTextBoundsParams = Instance.new("GetTextBoundsParams")
        GetTextBoundsParams.Font = v155.FontFace
        GetTextBoundsParams.Size = v155.TextSize
        GetTextBoundsParams.Width = 1000
        local v157 = v156 or ""
        if v155.RichText then
            v157 = v157:gsub("<[^>]->", "")
        end
        GetTextBoundsParams.Text = v157
        local v158 = TextService:GetTextBoundsAsync(GetTextBoundsParams)
        GetTextBoundsParams:Destroy()
        return v158
    end

    local function updateUIFromPrompt() -- line 468 | captures: v64, v19, ActionText, ObjectText, getTextBoundsForLabel
        local v159 = getTextBoundsForLabel(ActionText, v19.ActionText)
        local v160 = getTextBoundsForLabel(ObjectText, v19.ObjectText)
        local X = v159.X
        local X_2 = v160.X
        local v161 = math.max(X, X_2)
        local v162
        if v19.ActionText == nil then
            if v19.ObjectText == nil or v19.ObjectText == "" then
                v162 = 72
            else
                v162 = v161 + 72 + 24
            end
        elseif v19.ActionText == "" then
            v162 = 72
        else
            v162 = v161 + 72 + 24
        end
        local v163 = if v19.ObjectText == nil or v19.ObjectText == "" then 0 else 9
        ActionText.Position = UDim2.new(0.5, 72 - v162 / 2, 0, v163)
        ObjectText.Position = UDim2.new(0.5, 72 - v162 / 2, 0, -10)
        ActionText.Text = v19.ActionText
        ObjectText.Text = v19.ObjectText
        ActionText.AutoLocalize = v19.AutoLocalize
        ActionText.RootLocalizationTable = v19.RootLocalizationTable
        ObjectText.AutoLocalize = v19.AutoLocalize
        ObjectText.RootLocalizationTable = v19.RootLocalizationTable
        v64.Size = UDim2.fromOffset(v162, 72)
        v64.SizeOffset = Vector2.new(v19.UIOffset.X / v64.Size.Width.Offset, v19.UIOffset.Y / v64.Size.Height.Offset)
    end

    local v164 = v19.Changed:Connect(updateUIFromPrompt)
    updateUIFromPrompt()
    local Parent = v19.Parent
    v64.Adornee = Parent
    v64.Parent = v21
    for v165, v166 in ipairs(v59) do
        v166:Play()
    end
    return function() -- line 499 | captures: v129, v132, v64, v134, v143, v144, v19, v58, v149, v152, v164, TweenService, Workspace, v1, v2
        if v143 then
            v143:Disconnect()
        end
        if v144 then
            v144:Disconnect()
        end
        if v129 then
            v129:Disconnect()
        end
        if v134 then
            v134:Disconnect()
        end
        v149:Disconnect()
        v152:Disconnect()
        v164:Disconnect()
        for v167, v168 in ipairs(v58) do
            v168:Play()
        end
        local CurrentCamera, v169
        if v132 then
            CurrentCamera = Workspace.CurrentCamera
            if CurrentCamera and v2.prompt == v19 and v2.baseFov then
                if v2.tween then
                    v2.tween:Cancel()
                    v2.tween = nil
                end
                v169 = false
            else
                v169 = true
            end
        else
            v169 = true
        end
        if not v169 then
            v2.tween = TweenService:Create(CurrentCamera, v1, { FieldOfView = v2.baseFov })
            local tween = v2.tween
            assert(tween, "luau")
            v2.tween:Play()
            v2.prompt = nil
            v2.baseFov = nil
        end
        wait(0.2)
        v64.Parent = nil
    end
end

local function onLoad() -- line 536 | captures: ProximityPromptService, PlayerGui, createPrompt
    ProximityPromptService.PromptShown:Connect(function(v170, v171) -- line 537 | captures: PlayerGui, createPrompt
        if v170.Style == Enum.ProximityPromptStyle.Default then
            return
        end
        local ProximityPrompts = PlayerGui:FindFirstChild("ProximityPrompts")
        if ProximityPrompts == nil then
            ProximityPrompts = Instance.new("ScreenGui")
            ProximityPrompts.Name = "ProximityPrompts"
            ProximityPrompts.ResetOnSpawn = false
            ProximityPrompts.Parent = PlayerGui
        end
        local v172 = createPrompt(v170, v171, ProximityPrompts)
        v170.PromptHidden:Wait()
        v172()
    end)
end

ProximityPromptService.PromptShown:Connect(function(v173, v174) -- line 553 | captures: PlayerGui, createPrompt
    if v173.Style == Enum.ProximityPromptStyle.Default then
        return
    end
    local ProximityPrompts = PlayerGui:FindFirstChild("ProximityPrompts")
    if ProximityPrompts == nil then
        ProximityPrompts = Instance.new("ScreenGui")
        ProximityPrompts.Name = "ProximityPrompts"
        ProximityPrompts.ResetOnSpawn = false
        ProximityPrompts.Parent = PlayerGui
    end
    local v175 = createPrompt(v173, v174, ProximityPrompts)
    v173.PromptHidden:Wait()
    v175()
end)
