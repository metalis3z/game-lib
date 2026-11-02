-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_UserInputService_0 = game:GetService("UserInputService");
local l_ProximityPromptService_0 = game:GetService("ProximityPromptService");
local l_TweenService_0 = game:GetService("TweenService");
local l_TextService_0 = game:GetService("TextService");
local l_PlayerGui_0 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");
local l_PromptThemes_0 = game.ReplicatedStorage.Assets.UI.PromptThemes;
local v7 = {
    [Enum.KeyCode.ButtonX] = "rbxasset://textures/ui/Controls/xboxX.png", 
    [Enum.KeyCode.ButtonY] = "rbxasset://textures/ui/Controls/xboxY.png", 
    [Enum.KeyCode.ButtonA] = "rbxasset://textures/ui/Controls/xboxA.png", 
    [Enum.KeyCode.ButtonB] = "rbxasset://textures/ui/Controls/xboxB.png", 
    [Enum.KeyCode.DPadLeft] = "rbxasset://textures/ui/Controls/dpadLeft.png", 
    [Enum.KeyCode.DPadRight] = "rbxasset://textures/ui/Controls/dpadRight.png", 
    [Enum.KeyCode.DPadUp] = "rbxasset://textures/ui/Controls/dpadUp.png", 
    [Enum.KeyCode.DPadDown] = "rbxasset://textures/ui/Controls/dpadDown.png", 
    [Enum.KeyCode.ButtonSelect] = "rbxasset://textures/ui/Controls/xboxmenu.png", 
    [Enum.KeyCode.ButtonL1] = "rbxasset://textures/ui/Controls/xboxLS.png", 
    [Enum.KeyCode.ButtonR1] = "rbxasset://textures/ui/Controls/xboxRS.png"
};
local v8 = {
    [Enum.KeyCode.Backspace] = "rbxasset://textures/ui/Controls/backspace.png", 
    [Enum.KeyCode.Return] = "rbxasset://textures/ui/Controls/return.png", 
    [Enum.KeyCode.LeftShift] = "rbxasset://textures/ui/Controls/shift.png", 
    [Enum.KeyCode.RightShift] = "rbxasset://textures/ui/Controls/shift.png", 
    [Enum.KeyCode.Tab] = "rbxasset://textures/ui/Controls/tab.png"
};
local v9 = {
    ["'"] = "rbxasset://textures/ui/Controls/apostrophe.png", 
    [","] = "rbxasset://textures/ui/Controls/comma.png", 
    ["`"] = "rbxasset://textures/ui/Controls/graveaccent.png", 
    ["."] = "rbxasset://textures/ui/Controls/period.png", 
    [" "] = "rbxasset://textures/ui/Controls/spacebar.png"
};
local v10 = {
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
};
local function _() --[[ Line: 64 ]] --[[ Name: getScreenGui ]]
    -- upvalues: l_PlayerGui_0 (copy)
    local l_ProximityPrompts_0 = l_PlayerGui_0:FindFirstChild("ProximityPrompts");
    if l_ProximityPrompts_0 == nil then
        l_ProximityPrompts_0 = Instance.new("ScreenGui");
        l_ProximityPrompts_0.Name = "ProximityPrompts";
        l_ProximityPrompts_0.ResetOnSpawn = false;
        l_ProximityPrompts_0.Parent = l_PlayerGui_0;
    end;
    return l_ProximityPrompts_0;
end;
local function _(v13) --[[ Line: 75 ]] --[[ Name: setUpCircularProgressBar ]]
    v13.Progress.Changed:Connect(function(v14) --[[ Line: 77 ]]
        -- upvalues: v13 (copy)
        if v13:FindFirstChild("Bar") then
            v13.Bar.Size = UDim2.fromScale(1, v14);
            v13.Bar.BackgroundTransparency = 0.8 - 0.2 * v14;
            return;
        else
            local l_UIGradient_0 = v13.LeftGradient.ProgressBarImage.UIGradient;
            local l_UIGradient_1 = v13.RightGradient.ProgressBarImage.UIGradient;
            local v17 = math.clamp(v14 * 360, 0, 360);
            l_UIGradient_0.Rotation = math.clamp(v17, 180, 360);
            l_UIGradient_1.Rotation = math.clamp(v17, 0, 180);
            return;
        end;
    end);
end;
local function v128(v19, v20, v21) --[[ Line: 91 ]] --[[ Name: createPrompt ]]
    -- upvalues: l_PromptThemes_0 (copy), l_TweenService_0 (copy), v7 (copy), l_UserInputService_0 (copy), v8 (copy), v9 (copy), v10 (copy), l_TextService_0 (copy)
    local v22 = {};
    local v23 = {};
    local v24 = {};
    local v25 = {};
    local v26 = TweenInfo.new(v19.HoldDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
    local _ = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local v28 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local v29 = TweenInfo.new(0.06, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
    local v30 = TweenInfo.new(0, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
    local v31 = nil;
    local l_v19_Attribute_0 = v19:GetAttribute("Theme");
    if l_v19_Attribute_0 then
        local l_l_PromptThemes_0_FirstChild_0 = l_PromptThemes_0:FindFirstChild(l_v19_Attribute_0);
        if l_l_PromptThemes_0_FirstChild_0 then
            v31 = l_l_PromptThemes_0_FirstChild_0:Clone();
        end;
    end;
    if v31 == nil then
        v31 = l_PromptThemes_0.Default:Clone();
    end;
    v31.Enabled = true;
    local l_PromptFrame_0 = v31.PromptFrame;
    local l_InputFrame_0 = l_PromptFrame_0.InputFrame;
    local l_ActionText_0 = l_PromptFrame_0.ActionText;
    local l_ObjectText_0 = l_PromptFrame_0.ObjectText;
    local l_BackgroundTransparency_0 = l_PromptFrame_0.BackgroundTransparency;
    local l_ImageTransparency_0 = l_PromptFrame_0.ImageTransparency;
    l_PromptFrame_0.BackgroundTransparency = 1;
    l_PromptFrame_0.ImageTransparency = 1;
    table.insert(v22, l_TweenService_0:Create(l_PromptFrame_0, v28, {
        Size = UDim2.fromScale(0.5, 1), 
        BackgroundTransparency = 1, 
        ImageTransparency = 1
    }));
    table.insert(v23, l_TweenService_0:Create(l_PromptFrame_0, v28, {
        Size = UDim2.fromScale(1, 1), 
        BackgroundTransparency = l_BackgroundTransparency_0, 
        ImageTransparency = l_ImageTransparency_0
    }));
    table.insert(v24, l_TweenService_0:Create(l_PromptFrame_0, v28, {
        Size = UDim2.fromScale(0.5, 1), 
        BackgroundTransparency = 1, 
        ImageTransparency = 1
    }));
    table.insert(v25, l_TweenService_0:Create(l_PromptFrame_0, v28, {
        Size = UDim2.fromScale(1, 1), 
        BackgroundTransparency = l_BackgroundTransparency_0, 
        ImageTransparency = l_ImageTransparency_0
    }));
    local function v42(v40) --[[ Line: 132 ]] --[[ Name: setupUIStrokeTweens ]]
        -- upvalues: v22 (copy), l_TweenService_0 (ref), v28 (copy), v23 (copy), v24 (copy), v25 (copy)
        local l_Transparency_0 = v40.Transparency;
        v40.Transparency = 1;
        table.insert(v22, l_TweenService_0:Create(v40, v28, {
            Transparency = 1
        }));
        table.insert(v23, l_TweenService_0:Create(v40, v28, {
            Transparency = l_Transparency_0
        }));
        table.insert(v24, l_TweenService_0:Create(v40, v28, {
            Transparency = 1
        }));
        table.insert(v25, l_TweenService_0:Create(v40, v28, {
            Transparency = l_Transparency_0
        }));
    end;
    local function v45(v43) --[[ Line: 141 ]] --[[ Name: setupGUIObjectTweens ]]
        -- upvalues: v22 (copy), l_TweenService_0 (ref), v28 (copy), v23 (copy), v24 (copy), v25 (copy)
        local l_BackgroundTransparency_1 = v43.BackgroundTransparency;
        v43.BackgroundTransparency = 1;
        table.insert(v22, l_TweenService_0:Create(v43, v28, {
            BackgroundTransparency = 1
        }));
        table.insert(v23, l_TweenService_0:Create(v43, v28, {
            BackgroundTransparency = l_BackgroundTransparency_1
        }));
        table.insert(v24, l_TweenService_0:Create(v43, v28, {
            BackgroundTransparency = 1
        }));
        table.insert(v25, l_TweenService_0:Create(v43, v28, {
            BackgroundTransparency = l_BackgroundTransparency_1
        }));
    end;
    local function v49(v46) --[[ Line: 150 ]] --[[ Name: setupTextLabelTweens ]]
        -- upvalues: v22 (copy), l_TweenService_0 (ref), v28 (copy), v23 (copy), v24 (copy), v25 (copy)
        local l_TextTransparency_0 = v46.TextTransparency;
        local l_TextStrokeTransparency_0 = v46.TextStrokeTransparency;
        v46.TextTransparency = 1;
        v46.TextStrokeTransparency = 1;
        table.insert(v22, l_TweenService_0:Create(v46, v28, {
            TextTransparency = 1, 
            TextStrokeTransparency = 1
        }));
        table.insert(v23, l_TweenService_0:Create(v46, v28, {
            TextTransparency = l_TextTransparency_0, 
            TextStrokeTransparency = l_TextStrokeTransparency_0
        }));
        table.insert(v24, l_TweenService_0:Create(v46, v28, {
            TextTransparency = 1, 
            TextStrokeTransparency = 1
        }));
        table.insert(v25, l_TweenService_0:Create(v46, v28, {
            TextTransparency = l_TextTransparency_0, 
            TextStrokeTransparency = l_TextStrokeTransparency_0
        }));
    end;
    local function v52(v50) --[[ Line: 161 ]] --[[ Name: setupImageLabelTweens ]]
        -- upvalues: v22 (copy), l_TweenService_0 (ref), v28 (copy), v23 (copy), v24 (copy), v25 (copy)
        local l_ImageTransparency_1 = v50.ImageTransparency;
        v50.ImageTransparency = 1;
        table.insert(v22, l_TweenService_0:Create(v50, v28, {
            ImageTransparency = 1
        }));
        table.insert(v23, l_TweenService_0:Create(v50, v28, {
            ImageTransparency = l_ImageTransparency_1
        }));
        table.insert(v24, l_TweenService_0:Create(v50, v28, {
            ImageTransparency = 1
        }));
        table.insert(v25, l_TweenService_0:Create(v50, v28, {
            ImageTransparency = l_ImageTransparency_1
        }));
    end;
    local function v53(v54) --[[ Line: 170 ]] --[[ Name: setupUnexpectedChildTweens ]]
        -- upvalues: v42 (copy), v45 (copy), v49 (copy), v52 (copy), v53 (copy)
        if v54:IsA("UIStroke") then
            v42(v54);
        elseif not v54:IsA("UIGradient") and v54:IsA("GuiObject") then
            v45(v54);
            if v54:IsA("TextLabel") then
                v49(v54);
            elseif v54:IsA("ImageLabel") then
                v52(v54);
            end;
        end;
        for _, v56 in pairs(v54:GetChildren()) do
            v53(v56);
        end;
    end;
    local v57 = {
        [l_InputFrame_0] = false, 
        [l_ActionText_0] = true, 
        [l_ObjectText_0] = true
    };
    for _, v59 in pairs(l_PromptFrame_0:GetChildren()) do
        if v57[v59] == nil then
            v53(v59);
        elseif v57[v59] == true then
            for _, v61 in pairs(v59:GetChildren()) do
                v53(v61);
            end;
        end;
    end;
    local l_Frame_0 = l_InputFrame_0.Frame;
    local l_UIScale_0 = l_Frame_0.UIScale;
    local v64 = v20 == Enum.ProximityPromptInputType.Touch and 1.6 or 1.33;
    table.insert(v22, l_TweenService_0:Create(l_UIScale_0, v28, {
        Scale = v64
    }));
    table.insert(v23, l_TweenService_0:Create(l_UIScale_0, v28, {
        Scale = 1
    }));
    v49(l_ActionText_0);
    v49(l_ObjectText_0);
    local l_ButtonFrame_0 = l_Frame_0.ButtonFrame;
    (function() --[[ Line: 217 ]] --[[ Name: setupButtonFrameTweens ]]
        -- upvalues: l_ButtonFrame_0 (copy), v24 (copy), l_TweenService_0 (ref), v29 (copy), v25 (copy)
        local l_BackgroundTransparency_2 = l_ButtonFrame_0.BackgroundTransparency;
        local l_ImageTransparency_2 = l_ButtonFrame_0.ImageTransparency;
        table.insert(v24, l_TweenService_0:Create(l_ButtonFrame_0, v29, {
            BackgroundTransparency = 1, 
            ImageTransparency = 1
        }));
        table.insert(v25, l_TweenService_0:Create(l_ButtonFrame_0, v29, {
            BackgroundTransparency = l_BackgroundTransparency_2, 
            ImageTransparency = l_ImageTransparency_2
        }));
        for _, v69 in pairs(l_ButtonFrame_0:getChildren()) do
            if v69:IsA("UIStroke") then
                local l_Transparency_1 = v69.Transparency;
                table.insert(v24, l_TweenService_0:Create(v69, v29, {
                    Transparency = 1
                }));
                table.insert(v25, l_TweenService_0:Create(v69, v29, {
                    Transparency = l_Transparency_1
                }));
            end;
        end;
    end)();
    local l_ButtonImage_0 = l_Frame_0.ButtonImage;
    local l_ButtonText_0 = l_Frame_0.ButtonText;
    local l_ButtonTextImage_0 = l_Frame_0.ButtonTextImage;
    local l_UIStroke_0 = l_ButtonImage_0:FindFirstChild("UIStroke");
    if l_UIStroke_0 then
        v42(l_UIStroke_0);
    end;
    local function v81() --[[ Line: 244 ]] --[[ Name: setupButtonTextTweens ]]
        -- upvalues: l_ButtonText_0 (copy), v24 (copy), l_TweenService_0 (ref), v29 (copy), v25 (copy)
        local l_TextTransparency_1 = l_ButtonText_0.TextTransparency;
        local l_TextStrokeTransparency_1 = l_ButtonText_0.TextStrokeTransparency;
        local l_BackgroundTransparency_3 = l_ButtonText_0.BackgroundTransparency;
        l_ButtonText_0.BackgroundTransparency = 1;
        l_ButtonText_0.TextStrokeTransparency = 1;
        l_ButtonText_0.TextTransparency = 1;
        table.insert(v24, l_TweenService_0:Create(l_ButtonText_0, v29, {
            TextTransparency = 1, 
            TextStrokeTransparency = 1, 
            BackgroundTransparency = 1
        }));
        table.insert(v25, l_TweenService_0:Create(l_ButtonText_0, v29, {
            TextTransparency = l_TextTransparency_1, 
            TextStrokeTransparency = l_TextStrokeTransparency_1, 
            BackgroundTransparency = l_BackgroundTransparency_3
        }));
        for _, v79 in pairs(l_ButtonText_0:getChildren()) do
            if v79:IsA("UIStroke") then
                local l_Transparency_2 = v79.Transparency;
                table.insert(v24, l_TweenService_0:Create(v79, v29, {
                    Transparency = 1
                }));
                table.insert(v25, l_TweenService_0:Create(v79, v29, {
                    Transparency = l_Transparency_2
                }));
            end;
        end;
    end;
    local function v84() --[[ Line: 264 ]] --[[ Name: setupButtonImageTweens ]]
        -- upvalues: l_ButtonImage_0 (copy), v24 (copy), l_TweenService_0 (ref), v29 (copy), v25 (copy)
        local l_ImageTransparency_3 = l_ButtonImage_0.ImageTransparency;
        local l_BackgroundTransparency_4 = l_ButtonImage_0.BackgroundTransparency;
        l_ButtonImage_0.BackgroundTransparency = 1;
        l_ButtonImage_0.ImageTransparency = 1;
        table.insert(v24, l_TweenService_0:Create(l_ButtonImage_0, v29, {
            ImageTransparency = 1, 
            BackgroundTransparency = 1
        }));
        table.insert(v25, l_TweenService_0:Create(l_ButtonImage_0, v29, {
            ImageTransparency = l_ImageTransparency_3, 
            BackgroundTransparency = l_BackgroundTransparency_4
        }));
    end;
    local function v87() --[[ Line: 273 ]] --[[ Name: setupIconTweens ]]
        -- upvalues: l_ButtonTextImage_0 (copy), v24 (copy), l_TweenService_0 (ref), v29 (copy), v25 (copy)
        local l_BackgroundTransparency_5 = l_ButtonTextImage_0.BackgroundTransparency;
        local l_ImageTransparency_4 = l_ButtonTextImage_0.ImageTransparency;
        l_ButtonTextImage_0.BackgroundTransparency = 1;
        l_ButtonTextImage_0.ImageTransparency = 1;
        table.insert(v24, l_TweenService_0:Create(l_ButtonTextImage_0, v29, {
            ImageTransparency = 1, 
            BackgroundTransparency = 1
        }));
        table.insert(v25, l_TweenService_0:Create(l_ButtonTextImage_0, v29, {
            ImageTransparency = l_ImageTransparency_4, 
            BackgroundTransparency = l_BackgroundTransparency_5
        }));
    end;
    if v20 == Enum.ProximityPromptInputType.Gamepad then
        if v7[v19.GamepadKeyCode] then
            v87();
            l_ButtonTextImage_0.Image = v7[v19.GamepadKeyCode];
            l_ButtonText_0.Visible = false;
            l_ButtonImage_0.Visible = false;
            l_ButtonTextImage_0.Visible = true;
        end;
    elseif v20 == Enum.ProximityPromptInputType.Touch then
        v84();
        l_ButtonImage_0.Image = "rbxasset://textures/ui/Controls/TouchTapIcon.png";
        l_ButtonText_0.Visible = false;
        l_ButtonTextImage_0.Visible = false;
        l_ButtonImage_0.Visible = true;
    else
        v84();
        l_ButtonImage_0.Visible = true;
        local l_l_UserInputService_0_StringForKeyCode_0 = l_UserInputService_0:GetStringForKeyCode(v19.KeyboardKeyCode);
        local v89 = v8[v19.KeyboardKeyCode];
        if v89 == nil then
            v89 = v9[l_l_UserInputService_0_StringForKeyCode_0];
        end;
        if v89 == nil then
            local v90 = v10[v19.KeyboardKeyCode];
            if v90 then
                l_l_UserInputService_0_StringForKeyCode_0 = v90;
            end;
        end;
        if v89 then
            v87();
            l_ButtonTextImage_0.Image = v89;
            l_ButtonText_0.Visible = false;
            l_ButtonTextImage_0.Visible = true;
        elseif l_l_UserInputService_0_StringForKeyCode_0 ~= nil and l_l_UserInputService_0_StringForKeyCode_0 ~= "" then
            if string.len(l_l_UserInputService_0_StringForKeyCode_0) > 2 then
                l_ButtonText_0.TextSize = math.round(l_ButtonText_0.TextSize * 6 / 7);
            end;
            v81();
            l_ButtonText_0.Text = l_l_UserInputService_0_StringForKeyCode_0;
            l_ButtonTextImage_0.Visible = false;
            l_ButtonText_0.Visible = true;
        else
            error("ProximityPrompt '" .. v19.Name .. "' has an unsupported keycode for rendering UI: " .. tostring(v19.KeyboardKeyCode));
        end;
    end;
    if v20 == Enum.ProximityPromptInputType.Touch or v19.ClickablePrompt then
        local l_TextButton_0 = v31.TextButton;
        local v92 = false;
        do
            local l_v92_0 = v92;
            l_TextButton_0.InputBegan:Connect(function(v94) --[[ Line: 347 ]]
                -- upvalues: v19 (copy), l_v92_0 (ref)
                if (v94.UserInputType == Enum.UserInputType.Touch or v94.UserInputType == Enum.UserInputType.MouseButton1) and v94.UserInputState ~= Enum.UserInputState.Change then
                    v19:InputHoldBegin();
                    l_v92_0 = true;
                end;
            end);
            l_TextButton_0.InputEnded:Connect(function(v95) --[[ Line: 354 ]]
                -- upvalues: l_v92_0 (ref), v19 (copy)
                if (v95.UserInputType == Enum.UserInputType.Touch or v95.UserInputType == Enum.UserInputType.MouseButton1) and l_v92_0 then
                    l_v92_0 = false;
                    v19:InputHoldEnd();
                end;
            end);
            v31.Active = true;
        end;
    end;
    if v19.HoldDuration > 0 then
        local l_ProgressBar_0 = l_Frame_0.ProgressBar;
        local l_l_ProgressBar_0_0 = l_ProgressBar_0 --[[ copy: 38 -> 49 ]];
        l_ProgressBar_0.Progress.Changed:Connect(function(v98) --[[ Line: 77 ]]
            -- upvalues: l_l_ProgressBar_0_0 (copy)
            if l_l_ProgressBar_0_0:FindFirstChild("Bar") then
                l_l_ProgressBar_0_0.Bar.Size = UDim2.fromScale(1, v98);
                l_l_ProgressBar_0_0.Bar.BackgroundTransparency = 0.8 - 0.2 * v98;
                return;
            else
                local l_UIGradient_2 = l_l_ProgressBar_0_0.LeftGradient.ProgressBarImage.UIGradient;
                local l_UIGradient_3 = l_l_ProgressBar_0_0.RightGradient.ProgressBarImage.UIGradient;
                local v101 = math.clamp(v98 * 360, 0, 360);
                l_UIGradient_2.Rotation = math.clamp(v101, 180, 360);
                l_UIGradient_3.Rotation = math.clamp(v101, 0, 180);
                return;
            end;
        end);
        table.insert(v22, l_TweenService_0:Create(l_ProgressBar_0.Progress, v26, {
            Value = 1
        }));
        table.insert(v23, l_TweenService_0:Create(l_ProgressBar_0.Progress, v30, {
            Value = 0
        }));
    end;
    local v102 = nil;
    local v103 = nil;
    local v104 = nil;
    local v105 = nil;
    if v19.HoldDuration > 0 then
        v102 = v19.PromptButtonHoldBegan:Connect(function() --[[ Line: 379 ]]
            -- upvalues: v22 (copy)
            for _, v107 in pairs(v22) do
                v107:Play();
            end;
        end);
        v103 = v19.PromptButtonHoldEnded:Connect(function() --[[ Line: 385 ]]
            -- upvalues: v23 (copy)
            for _, v109 in pairs(v23) do
                v109:Play();
            end;
        end);
    end;
    v104 = v19.Triggered:Connect(function() --[[ Line: 392 ]]
        -- upvalues: v24 (copy)
        for _, v111 in pairs(v24) do
            v111:Play();
        end;
    end);
    v105 = v19.TriggerEnded:Connect(function() --[[ Line: 398 ]]
        -- upvalues: v25 (copy)
        for _, v113 in pairs(v25) do
            v113:Play();
        end;
    end);
    local function v121() --[[ Line: 404 ]] --[[ Name: updateUIFromPrompt ]]
        -- upvalues: v19 (copy), l_ActionText_0 (copy), l_TextService_0 (ref), l_ObjectText_0 (copy), v31 (ref)
        local l_GetTextBoundsParams_0 = Instance.new("GetTextBoundsParams");
        l_GetTextBoundsParams_0.Text = v19.ActionText;
        l_GetTextBoundsParams_0.Font = l_ActionText_0.FontFace;
        l_GetTextBoundsParams_0.Size = l_ActionText_0.TextSize;
        l_GetTextBoundsParams_0.Width = 1000;
        local l_l_TextService_0_TextBoundsAsync_0 = l_TextService_0:GetTextBoundsAsync(l_GetTextBoundsParams_0);
        local l_GetTextBoundsParams_1 = Instance.new("GetTextBoundsParams");
        l_GetTextBoundsParams_1.Text = v19.ObjectText;
        l_GetTextBoundsParams_1.Font = l_ObjectText_0.FontFace;
        l_GetTextBoundsParams_1.Size = l_ObjectText_0.TextSize;
        l_GetTextBoundsParams_1.Width = 1000;
        local l_l_TextService_0_TextBoundsAsync_1 = l_TextService_0:GetTextBoundsAsync(l_GetTextBoundsParams_1);
        local v118 = math.max(l_l_TextService_0_TextBoundsAsync_0.X, l_l_TextService_0_TextBoundsAsync_1.X);
        local v119 = 72;
        if v19.ActionText ~= nil and v19.ActionText ~= "" or v19.ObjectText ~= nil and v19.ObjectText ~= "" then
            v119 = v118 + 72 + 24;
        end;
        local v120 = 0;
        if v19.ObjectText ~= nil and v19.ObjectText ~= "" then
            v120 = 9;
        end;
        if not v19:GetAttribute("OverridePositions") then
            l_ActionText_0.Position = UDim2.new(0.5, 72 - v119 / 2, 0, v120);
            l_ObjectText_0.Position = UDim2.new(0.5, 72 - v119 / 2, 0, -10);
        end;
        l_ActionText_0.Text = v19.ActionText;
        l_ObjectText_0.Text = v19.ObjectText;
        l_ActionText_0.AutoLocalize = v19.AutoLocalize;
        l_ActionText_0.RootLocalizationTable = v19.RootLocalizationTable;
        l_ObjectText_0.AutoLocalize = v19.AutoLocalize;
        l_ObjectText_0.RootLocalizationTable = v19.RootLocalizationTable;
        if not v19:GetAttribute("OverridePositions") then
            v31.Size = UDim2.fromOffset(v119, 72);
            v31.SizeOffset = Vector2.new(v19.UIOffset.X / v31.Size.Width.Offset, v19.UIOffset.Y / v31.Size.Height.Offset);
        end;
    end;
    local v122 = v19.Changed:Connect(v121);
    v121();
    local l_Parent_0 = v19.Parent;
    v31.Adornee = l_Parent_0;
    v31.Parent = v21;
    for _, v125 in pairs(v25) do
        v125:Play();
    end;
    return function() --[[ Line: 462 ]] --[[ Name: cleanup ]]
        -- upvalues: v102 (ref), v103 (ref), v104 (ref), v105 (ref), v122 (copy), v24 (copy), v31 (ref)
        if v102 then
            v102:Disconnect();
        end;
        if v103 then
            v103:Disconnect();
        end;
        v104:Disconnect();
        v105:Disconnect();
        v122:Disconnect();
        for _, v127 in pairs(v24) do
            v127:Play();
        end;
        wait(0.2);
        v31.Parent = nil;
    end;
end;
v0.Start = function(_) --[[ Line: 487 ]] --[[ Name: Start ]]
    -- upvalues: l_ProximityPromptService_0 (copy), l_PlayerGui_0 (copy), v128 (copy)
    l_ProximityPromptService_0.PromptShown:Connect(function(v130, v131) --[[ Line: 488 ]]
        -- upvalues: l_PlayerGui_0 (ref), v128 (ref)
        if v130.Style == Enum.ProximityPromptStyle.Default then
            return;
        else
            local l_ProximityPrompts_1 = l_PlayerGui_0:FindFirstChild("ProximityPrompts");
            if l_ProximityPrompts_1 == nil then
                l_ProximityPrompts_1 = Instance.new("ScreenGui");
                l_ProximityPrompts_1.Name = "ProximityPrompts";
                l_ProximityPrompts_1.ResetOnSpawn = false;
                l_ProximityPrompts_1.Parent = l_PlayerGui_0;
            end;
            l_ProximityPrompts_1 = v128(v130, v131, l_ProximityPrompts_1);
            v130.PromptHidden:Wait();
            l_ProximityPrompts_1();
            return;
        end;
    end);
end;
return v0;