--credit to prince games studio
local t = {
	StartOrder = 2
}
local UserInputService = game:GetService("UserInputService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local TweenService = game:GetService("TweenService")
local TextService = game:GetService("TextService")
local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local t2 = {
	[Enum.KeyCode.Backspace] = "rbxasset://textures/ui/Controls/backspace.png",
	[Enum.KeyCode.Return] = "rbxasset://textures/ui/Controls/return.png",
	[Enum.KeyCode.LeftShift] = "rbxasset://textures/ui/Controls/shift.png",
	[Enum.KeyCode.RightShift] = "rbxasset://textures/ui/Controls/shift.png",
	[Enum.KeyCode.Tab] = "rbxasset://textures/ui/Controls/tab.png"
}
local t3 = {
	["\'"] = "rbxasset://textures/ui/Controls/apostrophe.png",
	[","] = "rbxasset://textures/ui/Controls/comma.png",
	["`"] = "rbxasset://textures/ui/Controls/graveaccent.png",
	["."] = "rbxasset://textures/ui/Controls/period.png",
	[" "] = "rbxasset://textures/ui/Controls/spacebar.png"
}
local t4 = {
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
local v1 = nil

function t.Init(p1) --[[ Init | Line: 50 | Upvalues: v1 (ref) ]]
	v1 = game:GetService("ReplicatedStorage"):FindFirstChild("ProximityPromptTemplates")
end
function t.Start(p1) --[[ Start | Line: 56 | Upvalues: ProximityPromptService (copy) ]]
	ProximityPromptService.PromptShown:Connect(function(p12, p2) --[[ Line: 58 | Upvalues: p1 (copy) ]]
		if p12:GetAttribute("DontShow") ~= nil then
			return
		end

		if p12.Style == Enum.ProximityPromptStyle.Default then
			return
		end

		local v1 = p1:CreatePrompt(p12, p2, (p1:GetScreenGui()))

		p12.PromptHidden:Wait()
		v1()
	end)
end
function t.GetScreenGui(p1) --[[ GetScreenGui | Line: 73 | Upvalues: PlayerGui (copy) ]]
	local ProximityPrompts = PlayerGui:FindFirstChild("ProximityPrompts")

	if ProximityPrompts == nil then
		local ProximityPrompts2 = Instance.new("ScreenGui")

		ProximityPrompts2.Name = "ProximityPrompts"
		ProximityPrompts2.ResetOnSpawn = false
		ProximityPrompts2.Parent = PlayerGui
		ProximityPrompts = ProximityPrompts2
	end

	return ProximityPrompts
end
function t.SetUpCircularProgressBar(p1, p2) --[[ SetUpCircularProgressBar | Line: 86 ]]
	local UIGradient = p2.LeftGradient.ProgressBarImage.UIGradient
	local UIGradient2 = p2.RightGradient.ProgressBarImage.UIGradient

	p2.Progress.Changed:Connect(function(p1) --[[ Line: 91 | Upvalues: UIGradient (copy), UIGradient2 (copy) ]]
		local v1 = math.clamp(p1 * 360, 0, 360)

		UIGradient.Rotation = math.clamp(v1, 180, 360)
		UIGradient2.Rotation = math.clamp(v1, 0, 180)
	end)
end
function t.CreatePrompt(p1, p2, p3, p4) --[[ CreatePrompt | Line: 98 | Upvalues: v1 (ref), TweenService (copy), UserInputService (copy), t2 (copy), t3 (copy), t4 (copy), TextService (copy) ]]
	local t = {}
	local t5 = {}
	local t6 = {}
	local t7 = {}
	local v12 = TweenInfo.new(p2.HoldDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
	local v2 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local v3 = TweenInfo.new(0.06, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
	local v4 = TweenInfo.new(0, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
	local v5 = nil
	local v6 = p2:GetAttribute("Theme")

	if v6 and v1 then
		local v7 = v1:FindFirstChild(v6)

		if v7 then
			v5 = v7:Clone()
		end
	end

	if v5 == nil and v1 then
		local Default = v1:FindFirstChild("Default")

		if Default then
			v5 = Default:Clone()
		end
	end

	if v5 == nil then
		return function() --[[ Line: 127 ]] end
	end

	v5.Enabled = true

	local PromptFrame = v5.PromptFrame
	local InputFrame = PromptFrame.InputFrame
	local ActionText = PromptFrame.ActionText
	local ObjectText = PromptFrame.ObjectText
	local BackgroundTransparency = PromptFrame.BackgroundTransparency
	local ImageTransparency = PromptFrame.ImageTransparency

	PromptFrame.BackgroundTransparency = 1
	PromptFrame.ImageTransparency = 1

	local v8 = TweenService

	table.insert(t, v8:Create(PromptFrame, v2, {
		BackgroundTransparency = 1,
		ImageTransparency = 1,
		Size = UDim2.fromScale(0.5, 1)
	}))

	local v9 = TweenService

	table.insert(t5, v9:Create(PromptFrame, v2, {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = BackgroundTransparency,
		ImageTransparency = ImageTransparency
	}))

	local v10 = TweenService

	table.insert(t6, v10:Create(PromptFrame, v2, {
		BackgroundTransparency = 1,
		ImageTransparency = 1,
		Size = UDim2.fromScale(0.5, 1)
	}))

	local v11 = TweenService

	table.insert(t7, v11:Create(PromptFrame, v2, {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = BackgroundTransparency,
		ImageTransparency = ImageTransparency
	}))

	local function setupUIStrokeTweens(p1) --[[ setupUIStrokeTweens | Line: 148 | Upvalues: t (copy), TweenService (ref), v2 (copy), t5 (copy), t6 (copy), t7 (copy) ]]
		local Transparency = p1.Transparency

		p1.Transparency = 1
		table.insert(t, TweenService:Create(p1, v2, {
			Transparency = 1
		}))
		table.insert(t5, TweenService:Create(p1, v2, {
			Transparency = Transparency
		}))
		table.insert(t6, TweenService:Create(p1, v2, {
			Transparency = 1
		}))
		table.insert(t7, TweenService:Create(p1, v2, {
			Transparency = Transparency
		}))
	end

	local function setupGUIObjectTweens(p1) --[[ setupGUIObjectTweens | Line: 157 | Upvalues: t (copy), TweenService (ref), v2 (copy), t5 (copy), t6 (copy), t7 (copy) ]]
		local BackgroundTransparency = p1.BackgroundTransparency

		p1.BackgroundTransparency = 1
		table.insert(t, TweenService:Create(p1, v2, {
			BackgroundTransparency = 1
		}))
		table.insert(t5, TweenService:Create(p1, v2, {
			BackgroundTransparency = BackgroundTransparency
		}))
		table.insert(t6, TweenService:Create(p1, v2, {
			BackgroundTransparency = 1
		}))
		table.insert(t7, TweenService:Create(p1, v2, {
			BackgroundTransparency = BackgroundTransparency
		}))
	end

	local function setupTextLabelTweens(p1) --[[ setupTextLabelTweens | Line: 166 | Upvalues: t (copy), TweenService (ref), v2 (copy), t5 (copy), t6 (copy), t7 (copy) ]]
		local TextTransparency = p1.TextTransparency
		local TextStrokeTransparency = p1.TextStrokeTransparency

		p1.TextTransparency = 1
		p1.TextStrokeTransparency = 1
		table.insert(t, TweenService:Create(p1, v2, {
			TextTransparency = 1,
			TextStrokeTransparency = 1
		}))
		table.insert(t5, TweenService:Create(p1, v2, {
			TextTransparency = TextTransparency,
			TextStrokeTransparency = TextStrokeTransparency
		}))
		table.insert(t6, TweenService:Create(p1, v2, {
			TextTransparency = 1,
			TextStrokeTransparency = 1
		}))
		table.insert(t7, TweenService:Create(p1, v2, {
			TextTransparency = TextTransparency,
			TextStrokeTransparency = TextStrokeTransparency
		}))
	end

	local function setupImageLabelTweens(p1) --[[ setupImageLabelTweens | Line: 177 | Upvalues: t (copy), TweenService (ref), v2 (copy), t5 (copy), t6 (copy), t7 (copy) ]]
		local ImageTransparency = p1.ImageTransparency

		p1.ImageTransparency = 1
		table.insert(t, TweenService:Create(p1, v2, {
			ImageTransparency = 1
		}))
		table.insert(t5, TweenService:Create(p1, v2, {
			ImageTransparency = ImageTransparency
		}))
		table.insert(t6, TweenService:Create(p1, v2, {
			ImageTransparency = 1
		}))
		table.insert(t7, TweenService:Create(p1, v2, {
			ImageTransparency = ImageTransparency
		}))
	end

	local function v122(p1) --[[ setupUnexpectedChildTweens | Line: 186 | Upvalues: setupUIStrokeTweens (copy), setupGUIObjectTweens (copy), setupTextLabelTweens (copy), setupImageLabelTweens (copy), v122 (copy) ]]
		if p1:IsA("UIStroke") then
			setupUIStrokeTweens(p1)
		elseif not p1:IsA("UIGradient") and p1:IsA("GuiObject") then
			setupGUIObjectTweens(p1)

			if p1:IsA("TextLabel") then
				setupTextLabelTweens(p1)
			elseif p1:IsA("ImageLabel") then
				setupImageLabelTweens(p1)
			end
		end

		for v1, v2 in p1:GetChildren() do
			v122(v2)
		end
	end

	local t12 = {
		[InputFrame] = false,
		[ActionText] = true,
		[ObjectText] = true
	}

	for v13, v14 in PromptFrame:GetChildren() do
		if t12[v14] == nil then
			v122(v14)

			continue
		end

		if t12[v14] == true then
			for v15, v16 in v14:GetChildren() do
				v122(v16)
			end
		end
	end

	local Frame = InputFrame.Frame
	local UIScale = Frame.UIScale
	local v18 = TweenService

	table.insert(t, v18:Create(UIScale, v2, {
		Scale = if p3 == Enum.ProximityPromptInputType.Touch then 1.6 else 1.33
	}))

	local v19 = TweenService

	table.insert(t5, v19:Create(UIScale, v2, {
		Scale = 1
	}))
	setupTextLabelTweens(ActionText)
	setupTextLabelTweens(ObjectText)

	local ButtonFrame = Frame.ButtonFrame
	local ButtonImage = Frame.ButtonImage
	local ButtonText = Frame.ButtonText
	local ButtonTextImage = Frame.ButtonTextImage;

	(function() --[[ setupButtonFrameTweens | Line: 234 | Upvalues: ButtonFrame (copy), t6 (copy), TweenService (ref), v3 (copy), t7 (copy) ]]
		table.insert(t6, TweenService:Create(ButtonFrame, v3, {
			BackgroundTransparency = 1,
			ImageTransparency = 1
		}))
		table.insert(t7, TweenService:Create(ButtonFrame, v3, {
			BackgroundTransparency = ButtonFrame.BackgroundTransparency,
			ImageTransparency = ButtonFrame.ImageTransparency
		}))

		for v9, v10 in ButtonFrame:GetChildren() do
			if v10:IsA("UIStroke") then
				table.insert(t6, TweenService:Create(v10, v3, {
					Transparency = 1
				}))
				table.insert(t7, TweenService:Create(v10, v3, {
					Transparency = v10.Transparency
				}))
			end
		end
	end)()

	local function setupButtonTextTweens() --[[ setupButtonTextTweens | Line: 251 | Upvalues: ButtonText (copy), t6 (copy), TweenService (ref), v3 (copy), t7 (copy) ]]
		local TextTransparency = ButtonText.TextTransparency
		local TextStrokeTransparency = ButtonText.TextStrokeTransparency
		local BackgroundTransparency = ButtonText.BackgroundTransparency

		ButtonText.BackgroundTransparency = 1
		ButtonText.TextStrokeTransparency = 1
		ButtonText.TextTransparency = 1
		table.insert(t6, TweenService:Create(ButtonText, v3, {
			TextTransparency = 1,
			TextStrokeTransparency = 1,
			BackgroundTransparency = 1
		}))
		table.insert(t7, TweenService:Create(ButtonText, v3, {
			TextTransparency = TextTransparency,
			TextStrokeTransparency = TextStrokeTransparency,
			BackgroundTransparency = BackgroundTransparency
		}))

		for v9, v10 in ButtonText:GetChildren() do
			if v10:IsA("UIStroke") then
				table.insert(t6, TweenService:Create(v10, v3, {
					Transparency = 1
				}))
				table.insert(t7, TweenService:Create(v10, v3, {
					Transparency = v10.Transparency
				}))
			end
		end
	end

	local function setupButtonImageTweens() --[[ setupButtonImageTweens | Line: 271 | Upvalues: ButtonImage (copy), t6 (copy), TweenService (ref), v3 (copy), t7 (copy) ]]
		local ImageTransparency = ButtonImage.ImageTransparency
		local BackgroundTransparency = ButtonImage.BackgroundTransparency

		ButtonImage.BackgroundTransparency = 1
		ButtonImage.ImageTransparency = 1
		table.insert(t6, TweenService:Create(ButtonImage, v3, {
			ImageTransparency = 1,
			BackgroundTransparency = 1
		}))
		table.insert(t7, TweenService:Create(ButtonImage, v3, {
			ImageTransparency = ImageTransparency,
			BackgroundTransparency = BackgroundTransparency
		}))
	end

	local function setupIconTweens() --[[ setupIconTweens | Line: 281 | Upvalues: ButtonTextImage (copy), t6 (copy), TweenService (ref), v3 (copy), t7 (copy) ]]
		local BackgroundTransparency = ButtonTextImage.BackgroundTransparency
		local ImageTransparency = ButtonTextImage.ImageTransparency

		ButtonTextImage.BackgroundTransparency = 1
		ButtonTextImage.ImageTransparency = 1
		table.insert(t6, TweenService:Create(ButtonTextImage, v3, {
			ImageTransparency = 1,
			BackgroundTransparency = 1
		}))
		table.insert(t7, TweenService:Create(ButtonTextImage, v3, {
			ImageTransparency = ImageTransparency,
			BackgroundTransparency = BackgroundTransparency
		}))
	end

	if p3 == Enum.ProximityPromptInputType.Gamepad then
		local v20 = UserInputService:GetImageForKeyCode(p2.GamepadKeyCode)

		if v20 ~= "" then
			setupIconTweens()
			ButtonTextImage.Image = v20
			ButtonText.Visible = false
			ButtonImage.Visible = false
			ButtonTextImage.Visible = true
		end
	elseif p3 == Enum.ProximityPromptInputType.Touch then
		setupButtonImageTweens()
		ButtonImage.Image = "rbxasset://textures/ui/Controls/TouchTapIcon.png"
		ButtonText.Visible = false
		ButtonTextImage.Visible = false
		ButtonImage.Visible = true
	else
		setupButtonImageTweens()
		ButtonImage.Visible = true

		local v21 = UserInputService:GetStringForKeyCode(p2.KeyboardKeyCode)
		local v22 = t2[p2.KeyboardKeyCode]

		if v22 == nil then
			v22 = t3[v21]
		end

		if v22 == nil then
			local v23 = t4[p2.KeyboardKeyCode]

			if v23 then
				v21 = v23
			end
		end

		if v22 then
			setupIconTweens()
			ButtonTextImage.Image = v22
			ButtonText.Visible = false
			ButtonTextImage.Visible = true
		else
			if v21 == nil or v21 == "" then
				error("ProximityPrompt \'" .. p2.Name .. "\' has an unsupported keycode for rendering UI: " .. tostring(p2.KeyboardKeyCode))
			end

			if string.len(v21) > 2 then
				ButtonText.TextSize = math.round(ButtonText.TextSize * 6 / 7)
			end

			setupButtonTextTweens()
			ButtonText.Text = v21
			ButtonTextImage.Visible = false
			ButtonText.Visible = true
		end
	end

	if p3 == Enum.ProximityPromptInputType.Touch or p2.ClickablePrompt then
		local TextButton = v5.TextButton
		local v27 = false

		TextButton.InputBegan:Connect(function(p1) --[[ Line: 347 | Upvalues: p2 (copy), v27 (ref) ]]
			if p1.UserInputType ~= Enum.UserInputType.Touch and p1.UserInputType ~= Enum.UserInputType.MouseButton1 then
				return
			end

			if p1.UserInputState == Enum.UserInputState.Change then
				return
			end

			p2:InputHoldBegin()
			v27 = true
		end)
		TextButton.InputEnded:Connect(function(p1) --[[ Line: 355 | Upvalues: v27 (ref), p2 (copy) ]]
			if p1.UserInputType ~= Enum.UserInputType.Touch and p1.UserInputType ~= Enum.UserInputType.MouseButton1 or not v27 then
				return
			end

			v27 = false
			p2:InputHoldEnd()
		end)
		v5.Active = true
	end

	if p2.HoldDuration > 0 then
		local ProgressBar = Frame.ProgressBar

		p1:SetUpCircularProgressBar(ProgressBar)
		table.insert(t, TweenService:Create(ProgressBar.Progress, v12, {
			Value = 1
		}))
		table.insert(t5, TweenService:Create(ProgressBar.Progress, v4, {
			Value = 0
		}))
	end

	local v30, v31

	if p2.HoldDuration > 0 then
		v30 = p2.PromptButtonHoldBegan:Connect(function() --[[ Line: 380 | Upvalues: t (copy) ]]
			for v1, v2 in t do
				v2:Play()
			end
		end)
		v31 = p2.PromptButtonHoldEnded:Connect(function() --[[ Line: 386 | Upvalues: t5 (copy) ]]
			for v1, v2 in t5 do
				v2:Play()
			end
		end)
	else
		v30 = nil
		v31 = nil
	end

	local v32 = p2.Triggered:Connect(function() --[[ Line: 393 | Upvalues: t6 (copy) ]]
		for v1, v2 in t6 do
			v2:Play()
		end
	end)
	local v33 = p2.TriggerEnded:Connect(function() --[[ Line: 399 | Upvalues: t7 (copy) ]]
		for v1, v2 in t7 do
			v2:Play()
		end
	end)

	local function updateUIFromPrompt() --[[ updateUIFromPrompt | Line: 405 | Upvalues: p2 (copy), ActionText (copy), TextService (ref), ObjectText (copy), v5 (ref) ]]
		local GetTextBoundsParams = Instance.new("GetTextBoundsParams")

		GetTextBoundsParams.Text = p2.ActionText
		GetTextBoundsParams.Font = ActionText.FontFace
		GetTextBoundsParams.Size = ActionText.TextSize
		GetTextBoundsParams.Width = 1000

		local v1 = TextService:GetTextBoundsAsync(GetTextBoundsParams)
		local GetTextBoundsParams2 = Instance.new("GetTextBoundsParams")

		GetTextBoundsParams2.Text = p2.ObjectText
		GetTextBoundsParams2.Font = ObjectText.FontFace
		GetTextBoundsParams2.Size = ObjectText.TextSize
		GetTextBoundsParams2.Width = 1000

		local v4 = if (p2.ActionText == nil or p2.ActionText == "") and (p2.ObjectText == nil or p2.ObjectText == "") then 72 else math.max(v1.X, TextService:GetTextBoundsAsync(GetTextBoundsParams2).X) + 72 + 24

		ActionText.Position = UDim2.new(0.5, 72 - v4 / 2, 0, if p2.ObjectText == nil or p2.ObjectText == "" then 0 else 9)
		ObjectText.Position = UDim2.new(0.5, 72 - v4 / 2, 0, -10)
		ActionText.Text = p2.ActionText
		ObjectText.Text = p2.ObjectText
		ActionText.AutoLocalize = p2.AutoLocalize
		ActionText.RootLocalizationTable = p2.RootLocalizationTable
		ObjectText.AutoLocalize = p2.AutoLocalize
		ObjectText.RootLocalizationTable = p2.RootLocalizationTable
		v5.Size = UDim2.fromOffset(v4, 72)
		v5.SizeOffset = Vector2.new(p2.UIOffset.X / v5.Size.Width.Offset, p2.UIOffset.Y / v5.Size.Height.Offset)
	end

	local v34 = p2.Changed:Connect(updateUIFromPrompt)

	updateUIFromPrompt()
	v5.Adornee = p2.Parent
	v5.Parent = p4

	for v35, v36 in t7 do
		v36:Play()
	end

	return function() --[[ cleanup | Line: 460 | Upvalues: v30 (ref), v31 (ref), v32 (ref), v33 (ref), v34 (copy), t6 (copy), v5 (ref) ]]
		if v30 then
			v30:Disconnect()
		end

		if v31 then
			v31:Disconnect()
		end

		v32:Disconnect()
		v33:Disconnect()
		v34:Disconnect()

		for v1, v2 in t6 do
			v2:Play()
		end

		task.wait(0.2)
		v5.Parent = nil
	end
end

return t